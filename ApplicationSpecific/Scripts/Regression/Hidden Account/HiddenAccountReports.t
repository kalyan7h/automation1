[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<HiddenAccount.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   <This script contains all Hidden/Closed Accounts test cases>
	[ ] //
	[ ] // DEPENDENCIES:	<include.inc>
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 25-Sep-12	Udita Dube	Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[+] // Global variables
	[ ] public LIST OF ANYTYPE  lsExcelData,lsSavingGoalData,lsTestData
	[ ] public STRING sActual,sHandle,sCaption
	[ ] public LIST OF STRING lsAddSavingGoal,lsEditSavingGoal,lsReportName1,lsReportName2,lsReport
	[ ] public BOOLEAN bCaption,bExists,bMatch,bSeparateAccount
	[ ] public INTEGER iSelect,i,iRow
	[ ] public STRING sFileNameHiddenAccounts="HiddenAccountReports"
	[ ] public STRING sBankingReportWorksheet="Banking Reports"
	[ ] public STRING sComparisonReportWorksheet="Comparison Reports"
	[ ] public STRING sNetWorthReportWorksheet="Net Worth & Balances"
	[ ] public STRING sSpendingReportWorksheet="Spending Reports"
	[ ] public STRING sInvestingReportWorksheet="Investing Reports"
	[ ] // public STRING sFileNameHiddenAccounts="HiddenAccountReports1"
	[ ] public STRING sTestDataHiddenAccounts="DataForHiddenAccount"
	[ ] public STRING sTab="Display Options"
	[ ] public STRING sOverallTotal="OVERALL TOTAL"
	[ ] public INTEGER iSetUpFile ,iResult ,iCount ,iListCount,iSeparate,iNavigate
	[ ] public STRING sToConvert 
	[ ] public STRING sOldDateYear="/2012"
	[ ] public STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
[ ] 
[+] //Global Functions
	[+] //#############  SetUp ######################################################
		[ ] // ********************************************************
		[+] // Function Name:	 SetUp()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] // This testcase will open data file to test hidden account 
			[ ] //
			[ ] // PARAMETERS:		None
			[ ] //
			[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file							
			[ ] //						Fail			If any error occurs
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] // 	  , 2012		Dean Paes	created
		[ ] // ********************************************************
		[ ] 
	[+] public INTEGER SetUpReports(STRING sFileNameHiddenAccounts)
		[ ] 
		[ ] INTEGER iSetupAutoAPI,iRegistration,iOpenDataFile
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileNameHiddenAccounts + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileNameHiddenAccounts + ".QDF"
		[ ] iFunctionResult=FAIL
		[ ] 
		[ ] 
		[+] do
			[+] if(FileExists(sDataFile))
				[+] if (QuickenWindow.Exists())
					[ ] QuickenWindow.Kill()
					[ ] sleep(2)
					[ ] 
				[ ] DeleteFile(sDataFile)
			[ ] CopyFile(sSourceFile,sDataFile)
			[+] if (!QuickenWindow.Exists())
				[ ] LaunchQuicken()
			[ ] 
			[+] if (QuickenWindow.Exists(5))
				[ ] sleep(3)
				[ ] QuickenWindow.SetActive()
				[ ] iResult=OpenDataFile(sFileNameHiddenAccounts)
				[+] if (iResult==PASS)
					[ ] 
					[ ] // Set Classic View
					[ ] SetViewMode(VIEW_CLASSIC_MENU)
					[ ] // Off Popup Register
					[ ] UsePopUpRegister("OFF")
					[ ] 
					[ ] 
					[ ] //Deselect Save Report Notification option in Preferences to prevent pop ups during reports
					[ ] QuickenWindow.SetActive()
					[ ] iResult=SelectPreferenceType("Reports only")
					[+] if (iResult==PASS)
						[ ] sleep(3)
						[ ] Preferences.SetActive()
						[ ] Preferences.RemindMeToSaveReports.Uncheck()
						[ ] Preferences.OK.Click()
						[ ] iFunctionResult=PASS
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Preferences", FAIL, "Verify Dialog Preferences : Preferences Dialog didn't appear.")
						[ ] iFunctionResult=FAIL
					[ ] 
				[+] else
					[ ] ReportStatus("Verify data file: {sFileNameHiddenAccounts} opened.", FAIL, "Data file - {sFileNameHiddenAccounts} is not opened.")
					[ ] iFunctionResult=FAIL
			[+] else
				[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
				[ ] iFunctionResult=FAIL
		[+] except
			[ ] exceptlog()
			[ ] iFunctionResult=FAIL
		[ ] return iFunctionResult
		[ ] 
		[ ] 
	[ ] //#######################################################################################
[ ] 
[ ] 
[ ] //==========================================REPORTS==================================================================
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] // //######################################Separate Accounts##################################################
[ ] 
[ ] 
[ ] 
[+] //#############  SeparateAccountReports_SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 SeparateAccountReports_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open data file to test hidden account for business accounts
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file							
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[-] testcase SeparateAccountReports_SetUp () appstate QuickenBaseState
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] INTEGER iSetUpFile,iSelect,iSeparate
		[ ] STRING sSavingsAccount= "Savings 02"
		[ ] STRING sTab= "Display Options"
		[ ] 
	[ ] 
	[ ] 
	[ ] //SkipRegistration
	[ ] SkipRegistration()
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] iSetUpFile=SetUpReports(sFileNameHiddenAccounts)
		[+] if(iSetUpFile)
			[ ] ReportStatus("Hidden Account Reports",PASS,"File Opened successfully")
		[+] else
			[ ] ReportStatus("Hidden Account Reports",PASS,"File did not open")
		[ ] 
		[ ] // Separate savings account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sSavingsAccount,sTab)			
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Check "Keep This Account Separate" checkbox
			[+] if(AccountDetails.KeepThisAccountSeparate.Exists())
				[ ] AccountDetails.KeepThisAccountSeparate.Check()
				[ ] AccountDetails.OK.Click()
				[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", PASS, "{sSavingsAccount} is made separated")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify separate this account option exists for account: {sSavingsAccount}" , FAIL,"Separate this account option doen't exist for account: {sSavingsAccount}.")
		[+] else
			[ ] ReportStatus("Verify account details tab displayed for account: {sSavingsAccount}", FAIL,"Account details tab didn't display for account: {sSavingsAccount}.")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Hidden Account  Reports", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Banking reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test01_SeparateAccountsBankingReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Banking reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Banking Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 29, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_SeparateAccountInBankingReports() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,j,k=2
		[ ] STRING sAccount, sSavingsAccount,sToConvert
		[ ] LIST OF STRING lsReport
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sBankingReportWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] 
		[ ] //Verify that Separate Account Details are not shown in Banking Reports
		[+] for(i=1;i<=5;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] QuickenWindow.SetActive ()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Banking.Click()
			[ ] 
			[ ] //Open required report from Banking Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Banking.BankingSummary.Select()
					[ ] BankingSummary.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)            //27
					[ ] 
					[ ] 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Banking.CashFlow.Select()
					[ ] CashFlow.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)             //27
					[ ] 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Banking.CashFlowByTag.Select()
					[ ] CashFlowByTag.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)             //29
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Banking.MissingChecks.Select()
					[ ] MissingChecks.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)          //34
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Banking.Transaction.Select()
					[ ] TransactionReports.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)            //49
					[ ] 
					[ ] 
				[ ] 
				[+] default 
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] 
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] 
				[ ] iListCount= wReport.QWListViewer1.ListBox1.GetItemCount()
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[+] // for (iCount=iListCount; iCount>= 0; iCount--)
					[ ] // sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(iCount))
					[ ] // bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] // if(bMatch == TRUE)
						[ ] // break
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] 
				[ ] //Close Report Window
				[ ] wReport.Close()
				[ ] sleep(2)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Comparison reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test02_SeparateAccountsComparisonReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Comparison reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Comparison Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 29, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_SeparateAccountsComparisonReports() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,iSetUpFile
		[ ] STRING sTab,sAccount, sSavingsAccount,sToConvert
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] 
		[ ] BOOLEAN bSeparateAccount
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sComparisonReportWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] //Verify that Separate Account Details are not shown in Comparison Reports
		[+] for(i=1;i<=6;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Comparison.Click()
			[ ] 
			[ ] 
			[ ] //Open required report from Comparison Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Comparison.CurrentVsAverageSpendingByCategory.Select()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Comparison.CurrentVsAverageSpendingByPayee.Select()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Comparison.CashFlowComparison.Select()
					[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Comparison.IncomeAndExpenseComparison1.Select()
					[ ] IncomeExpenseComparisonByC.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Comparison.IncomeAndExpenseComparison2.Select()
					[ ] IncomeExpenseComparisonByP.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 6
					[ ] 
					[ ] QuickenWindow.Reports.Comparison.ProfitAndLoss.Select()
					[ ] ProfitAndLossComparison.QWCustomizeBar1.PopupList1.Select(21)
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] iRow= Val (sToConvert) 
					[ ] 
				[ ] 
				[+] default
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Net Worth & Balances reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test03_SeparateAccountsNetWorthAndBalancesReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Net Worth & Balances reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Net Worth & Balances Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 30, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_SeparateAccountsNetWorthAndBalancesReports() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,j,k=2
		[ ] STRING sTab,sAccount, sSavingsAccount,sToConvert
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] INTEGER iSetUpFile
		[ ] BOOLEAN bSeparateAccount
		[ ] //sAccount="Vendor Invoices 1"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] //Verify that Separate Account Details are not shown in Net Worth & Balances Reports
		[+] for(i=1;i<=2;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sNetWorthReportWorksheet)
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.NetWorthBalances.Click()
			[ ] 
			[ ] 
			[ ] //Open required report from NetWorthAndBalances Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.NetWorthBalances.AccountBalances.Select()
					[ ] AccountBalances.QWCustomizeBar.PopupList1.Select(23)
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.NetWorthBalances.NetWorth.Select()
					[ ] NetWorthReports.QWCustomizeBar.PopupList1.Select(23) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] default
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] 
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Spending reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test04_SeparateAccountsSpendingReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Spending reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Spending Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_SeparateAccountsSpendingReports() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow
		[ ] STRING sTab,sAccount, sSavingsAccount,sSavingsAccount2
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] sAccount="Vendor Invoices 1"
		[ ] 
		[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sSpendingReportWorksheet)
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] //Verify that Separate Account Details are not shown in Spending Reports
		[+] for(i=1;i<=11;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] // Read data from excel sheet
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Spending.Click()
			[ ] 
			[ ] //Open required report from Spending Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Spending.ItemizedCategories.Select()
					[ ] ItemizedCategories.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Spending.ItemizedPayees.Select()
					[ ] ItemizedPayees.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Spending.ItemizedTags.Select()
					[ ] sleep(1)
					[ ] ItemizedTags.QWCustomizeBar.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Spending.SpendingByCategory.Select()
					[ ] SpendingByCategory.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Spending.SpendingByPayee.Select()
					[ ] SpendingByPayee.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 6
					[ ] QuickenWindow.Reports.Spending.CurrentVsAverageSpendingByCategory.Select()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 7
					[ ] QuickenWindow.Reports.Spending.CurrentVsAverageSpendingByPayee.Select()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 8
					[ ] QuickenWindow.Reports.Spending.IncomeAndExpenseByCategory.Select()
					[ ] IncomeExpenseByCategory.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 9
					[ ] QuickenWindow.Reports.Spending.IncomeAndExpenseByPayee.Select()
					[ ] IncomeExpenseByPayee.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 10
					[ ] QuickenWindow.Reports.Spending.CurrentBudget.Select()
					[ ] CurrentBudget.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 11
					[ ] QuickenWindow.Reports.Spending.HistoricalBudget.Select()
					[ ] HistoricalBudget.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] default
					[ ] ReportStatus("Spending Reports",FAIL,"Incorrect Value entered")
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened sucessfully")
				[ ] 
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] 
				[ ] //Values should match for all except last two cases since additonal values are shown in Current and Historical budget
				[+] if(i<10)
					[ ] 
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[ ] 
					[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Investing reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test05_SeparateAccountsInvestingReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Investing reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Investing Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_SeparateAccountsInvestingReports() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow
		[ ] STRING sFileNameHiddenAccounts="HiddenAccountReports3"
		[ ] STRING sTab,sAccount, sSavingsAccount,sSavingsAccount2,sInvestingAccount
		[ ] LIST OF STRING lsReport
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileNameHiddenAccounts + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileNameHiddenAccounts + ".QDF"
		[ ] sSavingsAccount= "Savings 02"
		[ ] sInvestingAccount="Brokerage 02"
		[ ] sTab= "Display Options"
		[ ] sAccount="Vendor Invoices 1"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sInvestingReportWorksheet)
		[ ] sAccount = "Brokerage 02"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] // Separate Investing Account
		[ ] iSelect = SeparateAccount(ACCOUNT_INVESTING,sAccount)
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox for Investing account", PASS, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is checked")
			[ ] 
			[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
			[ ] CloseRegisterReminderInfoPopup()
			[ ] 
			[ ] iSeparate=NavigateToAccountDetailsTab( ACCOUNT_SEPARATE,sAccount)
			[+] if (iSeparate == PASS)
				[ ] AccountDetails.Cancel.Click()
				[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and investing account is displayed under this seaction")
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
			[ ] 
		[ ] 
		[ ] 
		[ ] //Verify that Separate Account Details are not shown in Investing Reports
		[+] for(i=1;i<=9;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Investing.Click()
			[ ] 
			[ ] //Open required report from Banking Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Investing.CapitalGains.Select()
					[ ] CapitalGains.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Investing.InvestingActivity.Select()
					[ ] InvestingActivity.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
				[ ] 
				[+] case 3
					[ ] QuickenWindow.Reports.Investing.InvestmentAssetAllocation.Select()
					[ ] AssetAllocation.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Investing.InvestmentIncome.Select()
					[ ] InvestmentIncome.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Investing.InvestmentPerformance.Select()
					[ ] InvestmentPerformance.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[+] case 6
					[ ] QuickenWindow.Reports.Investing.InvestmentTransactions.Select()
					[ ] InvestmentTransactions.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 7
					[ ] QuickenWindow.Reports.Investing.MaturityDatesForBondsAndC.Select()
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 8
					[ ] QuickenWindow.Reports.Investing.PortfolioValue.Select()
					[ ] PortfolioValue.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 9
					[ ] QuickenWindow.Reports.Investing.PortfolioValueCostBasis.Select()
					[ ] PortfolioValueAndCostBasis.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] default
					[ ] ReportStatus("Spending Reports",FAIL,"Incorrect Value entered")
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[+] if(i!=7)
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[ ] 
				[+] else
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Banking Summary Report is not available")
		[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in Tax reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test06_SeparateAccountsTaxReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in Tax reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Tax reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test06_SeparateAccountsTaxReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,iSetupAutoAPI
		[ ] STRING sFileNameHiddenAccounts="HiddenAccountReports2"
		[ ] STRING sTab,sAccount, sSavingsAccount,sSavingsAccount2,sInvestingAccount,sTaxReportWorksheet
		[ ] LIST OF STRING lsReport
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileNameHiddenAccounts + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileNameHiddenAccounts + ".QDF"
		[ ] sSavingsAccount= "Savings 02"
		[ ] sInvestingAccount="Brokerage 02"
		[ ] sTab= "Display Options"
		[ ] sTaxReportWorksheet="Tax Reports"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sTaxReportWorksheet)
		[ ] 
		[ ] 
		[ ] 
	[-] 
			[ ] //Verify that Separate Account Details are not shown in Business Reports
			[+] for(i=1;i<=5;i++)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[ ] // Fetch ith row from the given sheet
				[ ] lsReport=lsExcelData[i]
				[ ] 
				[ ] 
				[ ] //Read value of Row to read total from
				[ ] sToConvert=lsReport[3]
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Tax.Click()
				[ ] 
				[ ] 
				[ ] //Open required report from Business Reports
				[-] switch(i)
					[-] case 1
						[ ] QuickenWindow.Reports.Tax.ScheduleAItemizedDeductions.Select()
						[ ] ScheduleA.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[-] case 2
						[ ] QuickenWindow.Reports.Tax.ScheduleBInterestAndDivide.Select()
						[ ] ScheduleB.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[-] case 3
						[ ] QuickenWindow.Reports.Tax.ScheduleDCapitalGainsAndL.Select()
						[ ] ScheduleD.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 4
						[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
						[ ] TaxSchedule.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 5
						[ ] QuickenWindow.Reports.Tax.TaxSummary.Select()
						[ ] TaxSummary.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] default
						[ ] ReportStatus("Tax Reports",FAIL,"Wrong value")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] if(wReport.Exists(5))
					[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened sucessfully")
					[ ] 
					[ ] 
					[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
					[ ] 
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
					[ ] 
					[+] if(i!=4)
						[+] if(MatchStr("*{lsReport[2]}*", sActual))
							[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
						[+] else
							[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report actual is: {sActual} and expected is: {lsReport[2]}.")
							[ ] 
					[+] else
						[+] if(MatchStr("*{lsReport[2]}*", sActual))
							[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
						[+] else
							[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] wReport.Close()
					[ ] sleep(2)
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
					[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive ()
		[ ] CloseRegisterReminderInfoPopup()
		[ ] sleep(1)
		[ ] //Update the date of the transactions for current year
		[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
		[-] if (DlgFindAndReplace.Exists(5))
			[ ] DlgFindAndReplace.SetActive()
			[ ] DlgFindAndReplace.SearchTextField.SetText(sOldDateYear)
			[ ] DlgFindAndReplace.FindButton.Click()
			[ ] DlgFindAndReplace.SelectAllButton.Click()
			[ ] DlgFindAndReplace.ReplacePopupList.SetFocus()
			[ ] DlgFindAndReplace.ReplacePopupList.Select("Date")
			[ ] sleep(1)
			[ ] DlgFindAndReplace.ReplacementTextField.SetText(sDateStamp)
			[ ] DlgFindAndReplace.ReplaceAllButton.Click()
			[ ] sleep(15)
			[ ] DlgFindAndReplace.DoneButton.Click()
			[ ] WaitForState(DlgFindAndReplace,False,5)
			[ ] sleep(2)
			[ ] 
			[ ] //Verify that Separate Account Details are not shown in Business Reports
			[+] for(i=1;i<=5;i++)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[ ] // Fetch ith row from the given sheet
				[ ] lsReport=lsExcelData[i]
				[ ] 
				[ ] 
				[ ] //Read value of Row to read total from
				[ ] sToConvert=lsReport[3]
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Tax.Click()
				[ ] 
				[ ] 
				[ ] //Open required report from Business Reports
				[-] switch(i)
					[-] case 1
						[ ] QuickenWindow.Reports.Tax.ScheduleAItemizedDeductions.Select()
						[ ] ScheduleA.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 2
						[ ] QuickenWindow.Reports.Tax.ScheduleBInterestAndDivide.Select()
						[ ] ScheduleB.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 3
						[ ] QuickenWindow.Reports.Tax.ScheduleDCapitalGainsAndL.Select()
						[ ] ScheduleD.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 4
						[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
						[ ] TaxSchedule.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 5
						[ ] QuickenWindow.Reports.Tax.TaxSummary.Select()
						[ ] TaxSummary.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] default
						[ ] ReportStatus("Tax Reports",FAIL,"Wrong value")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] if(wReport.Exists(5))
					[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened sucessfully")
					[ ] 
					[ ] 
					[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
					[ ] 
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
					[ ] 
					[+] if(i!=4)
						[+] if(MatchStr("*{lsReport[2]}*", sActual))
							[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
						[+] else
							[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report actual is: {sActual} and expected is: {lsReport[2]}.")
							[ ] 
					[+] else
						[+] if(MatchStr("*{lsReport[2]}*", sActual))
							[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
						[+] else
							[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] wReport.Close()
					[ ] sleep(2)
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
					[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Find and Replace dialog", FAIL, " Find and Replace dialog didn't appear.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Banking Summary Report", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
[ ] // //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in Business reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test07_SeparateAccountsBusinessReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in Business reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Business reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_SeparateAccountsBusinessReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iOpenDataFile,iRow
		[ ] STRING sBusinessFileNameHiddenAccounts="HiddenAccountBusinessReports"
		[ ] STRING sBusinessReportWorksheet
		[ ] STRING sAccountType="Business"
		[ ] LIST OF STRING lsReport,lsTransactionData
		[ ] STRING sTab= "Display Options"
		[ ] sBusinessReportWorksheet="Business Reports"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sBusinessReportWorksheet)
		[ ] // Fetch ith row from the given sheet
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] iSetUpFile=SetUpReports(sBusinessFileNameHiddenAccounts)
		[+] if(iSetUpFile)
			[ ] ReportStatus("Hidden Account Reports",PASS,"File Opened successfully")
		[+] else
			[ ] ReportStatus("Hidden Account Reports",PASS,"File did not open")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Verify that Separate Account Details are not shown in Business Reports
		[+] for(i=1;i<=12;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.BusinessReports.Click()
			[ ] 
			[ ] 
			[ ] //Open required report from Business Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Business.BusinessReports.AccountsPayable.Select()
					[ ] APByVendor.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Business.BusinessReports.AccountsReceivable.Select()
					[ ] ARByCustomer.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 3
					[ ] QuickenWindow.Business.BusinessReports.BalanceSheet.Select()
					[ ] BalanceSheet.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Business.BusinessReports.CashFlow.Select()
					[ ] CashFlow.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Business.BusinessReports.CashFlowComparison.Select()
					[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 6
					[ ] QuickenWindow.Business.BusinessReports.MissingChecks.Select()
					[ ] MissingChecks.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[ ] 
				[+] case 7
					[ ] QuickenWindow.Business.BusinessReports.ProfitAndLossComparison.Select()
					[ ] ProfitAndLossComparison.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[ ] 
				[+] case 8
					[ ] QuickenWindow.Business.BusinessReports.ProfitAndLossStatement.Select()
					[ ] ProfitAndLossStatement.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[ ] 
				[+] case 9
					[ ] QuickenWindow.Business.BusinessReports.ProjectJobByBusinessTag.Select()
					[ ] ProjectJobByBusinessTag.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 10
					[ ] QuickenWindow.Business.BusinessReports.ProjectJobByProject.Select()
					[ ] ProjectJobByProject.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 11
					[ ] QuickenWindow.Business.BusinessReports.ScheduleCProfitOrLossFrom.Select()
					[ ] ScheduleCReport.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 12
					[ ] QuickenWindow.Business.BusinessReports.TaxSchedule.Select()
					[ ] TaxSchedule.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[ ] 
				[+] default
					[ ] ReportStatus("Business Reports",FAIL,"Wrong value")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] 
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] 
				[+] if(MatchStr("*{lsReport[2]}*", sActual))
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[ ] 
[ ] //######################################Separate and Closed Accounts##################################################
[ ] 
[ ] 
[+] //#############  SeparateAndClosedAccountReports_SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Reports_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will modify data file to test separate and closed accounts hidden account for business accounts
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file							
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 17, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase SeparateAndClosedAccountReports_SetUp () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iVerify
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] STRING sAccountTypeSeparate="Separate"
		[ ] STRING sSavingsAccount="Savings 02"
		[ ] STRING sTab="Display Options"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] iSetUpFile=SetUpReports(sFileNameHiddenAccounts)
		[+] if(iSetUpFile==PASS)
			[ ] ReportStatus("Hidden Account Reports",PASS,"File Opened successfully")
			[ ] // Separate savings account
			[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sSavingsAccount,sTab)			
			[+] if (iSelect == PASS)
				[ ] // Check "Keep This Account Separate" checkbox
				[+] if(AccountDetails.KeepThisAccountSeparate.Exists())
					[ ] AccountDetails.KeepThisAccountSeparate.Check()
					[ ] AccountDetails.OK.Click()
					[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", PASS, "{sSavingsAccount} is made separated")
					[ ] //Close Separate Savings Account
					[ ] AccountBarSelect(ACCOUNT_SEPARATE,2)
					[ ] iNavigate=NavigateToAccountDetails(sSavingsAccount)
					[+] if(iNavigate==PASS)
						[ ] AccountDetails.TextClick("Display Options")
						[ ] AccountDetails.CloseAccount.Click()
						[+] if (PermanentlyCloseAccount.Exists(5))
							[ ] ReportStatus("Verify Close Accounts confirmation dialog", PASS, " Close Accounts confirmation dialog appeared.")
							[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
							[ ] PermanentlyCloseAccount.OK.Click()
							[ ] sleep(3)
						[+] else
							[ ] ReportStatus("Verify Close Accounts confirmation dialog", FAIL, " Close Accounts confirmation dialog didn't appear.")
						[ ] AccountDetails.SetActive()
						[ ] AccountDetails.OK.Click()
					[+] else
						[ ] ReportStatus("Separate Accounts", FAIL, " Account Details not opened")
					[ ] 
				[+] else
					[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "{sSavingsAccount} is made separated")
			[+] else
				[ ] ReportStatus("Separate Accounts", FAIL, " Account Details not opened")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Hidden Account Reports",FAIL,"File did not open")
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Banking reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test08_SeparateAndClosedAccountsBankingReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Banking reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Banking Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 29, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08_SeparateAndClosedAccountsBankingReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,j,k=2
		[ ] STRING sTab,sAccount, sSavingsAccount,sToConvert
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] INTEGER iSetUpFile
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sBankingReportWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Banking Reports
		[+] for(i=1;i<=5;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Banking.Click()
			[ ] 
			[ ] //Open required report from Banking Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Banking.BankingSummary.Select()
					[ ] BankingSummary.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)            //27
					[ ] 
					[ ] 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Banking.CashFlow.Select()
					[ ] CashFlow.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)             //27
					[ ] 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Banking.CashFlowByTag.Select()
					[ ] CashFlowByTag.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)             //29
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Banking.MissingChecks.Select()
					[ ] MissingChecks.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)          //34
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Banking.Transaction.Select()
					[ ] TransactionReports.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)            //49
					[ ] 
					[ ] 
				[ ] 
				[+] default 
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] 
				[ ] 
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] //Close Report Window
				[ ] wReport.Close()
				[ ] sleep(2)
				[ ] 
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
		[ ] 
	[+] else
		[ ] // // ReportStatus("Validate Banking Summary Report", FAIL, "Banking Summary Report is not available")
		[ ] // // 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Comparison reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test09_SeparateAndClosedAccountsComparisonReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Comparison reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Comparison Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 29, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test09_SeparateAndClosedAccountsComparisonReports() appstate none
	[ ] 
	[ ] // 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,iSetUpFile
		[ ] STRING sTab,sAccount, sSavingsAccount,sToConvert
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] BOOLEAN bSeparateAccount
		[ ] //sAccount="Vendor Invoices 1"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sComparisonReportWorksheet)
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Comparison Reports
		[+] for(i=1;i<=6;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Comparison.Click()
			[ ] 
			[ ] //Open required report from Comparison Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Comparison.CurrentVsAverageSpendingByCategory.Select()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Comparison.CurrentVsAverageSpendingByPayee.Select()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Comparison.CashFlowComparison.Select()
					[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Comparison.IncomeAndExpenseComparison1.Select()
					[ ] IncomeExpenseComparisonByC.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Comparison.IncomeAndExpenseComparison2.Select()
					[ ] IncomeExpenseComparisonByP.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 6
					[ ] 
					[ ] QuickenWindow.Reports.Comparison.ProfitAndLoss.Select()
					[ ] ProfitAndLossComparison.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
				[ ] 
				[+] default
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Net Worth & Balances reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test10_SeparateAndClosedAccountsNetWorthAndBalancesReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Net Worth & Balances reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Net Worth & Balances Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 30, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test10_SeparateAndClosedAccountsNetWorthAndBalancesReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,j,k=2
		[ ] STRING sTab,sAccount, sSavingsAccount,sToConvert
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] INTEGER iSetUpFile
		[ ] BOOLEAN bSeparateAccount
		[ ] //sAccount="Vendor Invoices 1"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sNetWorthReportWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Net Worth & Balances Reports
		[+] for(i=1;i<=2;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.NetWorthBalances.Click()
			[ ] //Open required report from NetWorthAndBalances Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.NetWorthBalances.AccountBalances.Select()
					[ ] AccountBalances.QWCustomizeBar.PopupList1.Select(23)
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.NetWorthBalances.NetWorth.Select()
					[ ] NetWorthReports.QWCustomizeBar.PopupList1.Select(23) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] default
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] 
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] // 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Spending reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test11_SeparateAndClosedAccountsSpendingReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Spending reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Spending Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 30, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test11_SeparateAndClosedAccountsSpendingReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow
		[ ] STRING sTab,sAccount, sSavingsAccount,sSavingsAccount2
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] sAccount="Vendor Invoices 1"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sSpendingReportWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Spending Reports
		[+] for(i=1;i<=11;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Spending.Click()
			[ ] 
			[ ] //Open required report from Spending Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Spending.ItemizedCategories.Select()
					[ ] ItemizedCategories.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Spending.ItemizedPayees.Select()
					[ ] ItemizedPayees.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Spending.ItemizedTags.Select()
					[ ] ItemizedTags.QWCustomizeBar.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Spending.SpendingByCategory.Select()
					[ ] SpendingByCategory.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Spending.SpendingByPayee.Select()
					[ ] SpendingByPayee.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 6
					[ ] QuickenWindow.Reports.Spending.CurrentVsAverageSpendingByCategory.Select()
					[ ] SCurrentVsAverageSpendingByCategory.QWCustomizeBar1.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 7
					[ ] QuickenWindow.Reports.Spending.CurrentVsAverageSpendingByPayee.Select()
					[ ] SCurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 8
					[ ] QuickenWindow.Reports.Spending.IncomeAndExpenseByCategory.Select()
					[ ] IncomeExpenseByCategory.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 9
					[ ] QuickenWindow.Reports.Spending.IncomeAndExpenseByPayee.Select()
					[ ] IncomeExpenseByPayee.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 10
					[ ] QuickenWindow.Reports.Spending.CurrentBudget.Select()
					[ ] CurrentBudget.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 11
					[ ] QuickenWindow.Reports.Spending.HistoricalBudget.Select()
					[ ] HistoricalBudget.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] default
					[ ] ReportStatus("Spending Reports",FAIL,"Incorrect Value entered")
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] 
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] 
				[ ] //Values should match for all except last two cases since additonal values are shown in Current and Historical budget
				[+] if(i<10)
					[ ] 
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] // // ReportStatus("Validate Banking Summary Report", FAIL, "Banking Summary Report is not available")
		[ ] // // 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Investing reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test12_SeparateAndClosedAccountsInvestingReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in the Investing reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Investing Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 30, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test12_SeparateAndClosedAccountsInvestingReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow
		[ ] STRING sFileNameHiddenAccounts="HiddenAccountReports3"
		[ ] STRING sTab,sAccount, sSavingsAccount,sInvestingAccount,sAccountTypeSeparate
		[ ] LIST OF STRING lsReport , lsPayees
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileNameHiddenAccounts + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileNameHiddenAccounts + ".QDF"
		[ ] sSavingsAccount= "Savings 02"
		[ ] sInvestingAccount="Brokerage 02"
		[ ] sTab= "Display Options"
		[ ] sAccount="Vendor Invoices 1"
		[ ] sAccountTypeSeparate="Separate"
		[ ] lsPayees= {"NDA","NDA","Intu","Intu"}
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sInvestingReportWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SeparateAccount(ACCOUNT_INVESTING,sInvestingAccount)
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox for Investing account", PASS, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is checked")
			[ ] 
			[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
			[ ] // Separate Investing account Brokerage 02
			[ ] iSelect = AccountBarSelect(sAccountTypeSeparate,4 )		
			[+] if (iSelect == PASS)
				[ ] 
				[ ] //Delete transactions
				[+] for each sPayee in lsPayees
					[ ] DeleteTransaction("MDI",sPayee,ACCOUNT_INVESTING)
					[ ] sleep(3)
				[ ] 
				[ ] //Close Brokerage Account
				[ ] 
				[ ] iNavigate=NavigateToAccountDetails(sInvestingAccount)
				[+] if(iNavigate==PASS)
					[ ] AccountDetails.TextClick("Display Options")
					[ ] AccountDetails.CloseAccount.Click()
					[+] if (PermanentlyCloseAccount.Exists(5))
						[ ] ReportStatus("Verify Close Accounts confirmation dialog", PASS, " Close Accounts confirmation dialog appeared.")
						[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
						[ ] PermanentlyCloseAccount.OK.Click()
						[ ] 
						[ ] sleep(3)
						[ ] AccountDetails.SetActive()
						[ ] AccountDetails.OK.Click()
						[ ] sleep(3)
						[ ] 
						[ ] //Verify that Hidden Account Details are not shown in Investing Reports
						[+] for(i=1;i<=9;i++)
							[ ] QuickenWindow.SetActive ()
							[ ] 
							[ ] // Fetch ith row from the given sheet
							[ ] lsReport=lsExcelData[i]
							[ ] 
							[ ] //Read value of Row to read total from
							[ ] sToConvert=lsReport[3]
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.Reports.Click()
							[ ] QuickenWindow.Reports.Investing.Click()
							[ ] //Open required report from Banking Reports
							[+] switch(i)
								[+] case 1
									[ ] QuickenWindow.Reports.Investing.CapitalGains.Select()
									[ ] CapitalGains.QWCustomizeBar1.PopupList1.Select(1) 
									[ ] iRow= Val (sToConvert) 
									[ ] 
								[ ] 
								[+] case 2
									[ ] QuickenWindow.Reports.Investing.InvestingActivity.Select()
									[ ] InvestingActivity.QWCustomizeBar1.PopupList1.Select(1) 
									[ ] iRow= Val (sToConvert) 
									[ ] 
								[ ] 
								[+] case 3
									[ ] QuickenWindow.Reports.Investing.InvestmentAssetAllocation.Select()
									[ ] AssetAllocation.QWCustomizeBar1.PopupList1.Select(1) 
									[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
								[ ] 
								[+] case 4
									[ ] QuickenWindow.Reports.Investing.InvestmentIncome.Select()
									[ ] InvestmentIncome.QWCustomizeBar1.PopupList1.Select(1) 
									[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
									[ ] 
								[ ] 
								[+] case 5
									[ ] QuickenWindow.Reports.Investing.InvestmentPerformance.Select()
									[ ] InvestmentPerformance.QWCustomizeBar1.PopupList1.Select(1) 
									[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
									[ ] 
								[ ] 
								[+] case 6
									[ ] QuickenWindow.Reports.Investing.InvestmentTransactions.Select()
									[ ] InvestmentTransactions.QWCustomizeBar1.PopupList1.Select(1) 
									[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
								[ ] 
								[+] case 7
									[ ] QuickenWindow.Reports.Investing.MaturityDatesForBondsAndC.Select()
									[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
								[ ] 
								[+] case 8
									[ ] QuickenWindow.Reports.Investing.PortfolioValue.Select()
									[ ] PortfolioValue.QWCustomizeBar1.PopupList1.Select(1) 
									[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
								[ ] 
								[+] case 9
									[ ] QuickenWindow.Reports.Investing.PortfolioValueCostBasis.Select()
									[ ] PortfolioValueAndCostBasis.QWCustomizeBar1.PopupList1.Select(1) 
									[ ] iRow= Val (sToConvert) 
								[ ] 
								[+] default
									[ ] ReportStatus("Spending Reports",FAIL,"Incorrect Value entered")
							[ ] 
							[ ] 
							[+] if(wReport.Exists(5))
								[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
								[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
								[ ] 
								[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
								[ ] 
								[+] if(i!=7)
									[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
									[+] if(bMatch == TRUE)
										[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
									[+] else
										[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
									[ ] 
								[+] else
									[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
									[+] if(bMatch == TRUE)
										[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
									[+] else
										[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
									[ ] 
									[ ] 
									[ ] 
								[ ] 
								[ ] wReport.Close()
								[ ] sleep(2)
							[+] else
								[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Close Accounts confirmation dialog", FAIL, " Close Accounts confirmation dialog didn't appear.")
				[+] else
					[ ] ReportStatus("Verify Close Accounts ", FAIL, " Account Details not opened- QW-4132")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Close Account selected", FAIL, " Closed account couldn't be selected")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Banking Summary Report is not available")
		[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in Tax reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test13_SeparateAndClosedAccountsTaxReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in Tax reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Tax reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[-] testcase Test13_SeparateAndClosedAccountsTaxReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,iSetupAutoAPI
		[ ] STRING sFileNameHiddenAccounts="HiddenAccountReports2"
		[ ] STRING sTab,sAccount, sSavingsAccount,sSavingsAccount2,sInvestingAccount,sTaxReportWorksheet
		[ ] LIST OF STRING lsReport
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileNameHiddenAccounts + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileNameHiddenAccounts + ".QDF"
		[ ] sSavingsAccount= "Savings 02"
		[ ] sInvestingAccount="Brokerage 02"
		[ ] sTab= "Display Options"
		[ ] sTaxReportWorksheet="Tax Reports"
		[ ] 
	[+] //Relaunch quicken to hande crash due to QW-4132
		[ ] Sys_Execute("taskkill /f /im qw.exe",NULL,EM_CONTINUE_RUNNING )
		[ ] sleep(5)
		[ ] LaunchQuicken()
	[ ] 
	[-] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
		[-] if (DlgFindAndReplace.Exists(5))
			[ ] DlgFindAndReplace.SetActive()
			[ ] DlgFindAndReplace.SearchTextField.SetText(sOldDateYear)
			[ ] DlgFindAndReplace.FindButton.Click()
			[ ] DlgFindAndReplace.SelectAllButton.Click()
			[ ] DlgFindAndReplace.ReplacePopupList.SetFocus()
			[ ] DlgFindAndReplace.ReplacePopupList.Select("Date")
			[ ] sleep(1)
			[ ] DlgFindAndReplace.ReplacementTextField.SetText(sDateStamp)
			[ ] DlgFindAndReplace.ReplaceAllButton.Click()
			[ ] sleep(15)
			[ ] DlgFindAndReplace.DoneButton.Click()
			[ ] WaitForState(DlgFindAndReplace,False,5)
			[ ] sleep(2)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Verify that Hidden Account Details are not shown in Business Reports
			[-] for(i=1;i<=5;i++)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sTaxReportWorksheet)
				[ ] // Fetch ith row from the given sheet
				[ ] lsReport=lsExcelData[i]
				[ ] 
				[ ] 
				[ ] //Read value of Row to read total from
				[ ] sToConvert=lsReport[3]
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Tax.Click()
				[ ] 
				[ ] //Open required report from Business Reports
				[-] switch(i)
					[+] case 1
						[ ] QuickenWindow.Reports.Tax.ScheduleAItemizedDeductions.Select()
						[ ] ScheduleA.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 2
						[ ] QuickenWindow.Reports.Tax.ScheduleBInterestAndDivide.Select()
						[ ] ScheduleB.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 3
						[ ] QuickenWindow.Reports.Tax.ScheduleDCapitalGainsAndL.Select()
						[ ] ScheduleD.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 4
						[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
						[ ] TaxSchedule.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 5
						[ ] QuickenWindow.Reports.Tax.TaxSummary.Select()
						[ ] TaxSummary.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] default
						[ ] ReportStatus("Tax Reports",FAIL,"Wrong value")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[-] if(wReport.Exists(5))
					[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened sucessfully")
					[ ] 
					[ ] 
					[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sTaxReportWorksheet)
					[ ] // Fetch ith row from the given sheet
					[ ] lsReport=lsExcelData[i]
					[ ] 
					[ ] 
					[ ] 
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
					[ ] 
					[-] if(i!=4)
						[+] if(MatchStr("*{lsReport[2]}*", sActual))
							[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
						[+] else
							[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
							[ ] 
					[+] else
						[+] if(MatchStr("*{lsReport[2]}*", sActual))
							[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
						[+] else
							[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] wReport.Close()
					[ ] sleep(2)
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open: QW-4132")
					[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Find and Replace dialog", FAIL, " Find and Replace dialog didn't appear.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Banking Summary Report", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in Business reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test07_SeparateAccountsBusinessReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Checking account should not get displayed in Business reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Business reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 03, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test14_SeparateAndClosedAccountsBusinessReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iOpenDataFile,iRow
		[ ] STRING sBusinessFileNameHiddenAccounts="HiddenAccountBusinessReports"
		[ ] STRING sBusinessReportWorksheet
		[ ] STRING sAccountType="Business"
		[ ] LIST OF STRING lsReport,lsTransactionData
		[ ] STRING sTab= "Display Options"
		[ ] sBusinessReportWorksheet="Business Reports"
		[ ] STRING sBusinessAccountVendor="Vendor Invoices 2"
		[ ] STRING sBusinessAccountCustomer="Customer Invoices 2"
		[ ] STRING sAccountTypeSeparate="Separate"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sBusinessReportWorksheet)
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSetUpFile=SetUpReports(sBusinessFileNameHiddenAccounts)
		[+] if(iSetUpFile==PASS)
			[ ] ReportStatus("Hidden Account Reports",PASS,"File Opened successfully")
			[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
			[ ] 
			[ ] AccountBarSelect(sAccountTypeSeparate,3 )
			[ ] iNavigate=NavigateToAccountDetails(sBusinessAccountVendor)
			[+] if(iNavigate==PASS)
				[ ] AccountDetails.TextClick("Display Options")
				[ ] AccountDetails.CloseAccount.Click()
				[+] if (PermanentlyCloseAccount.Exists(5))
					[ ] ReportStatus("Verify Close Accounts confirmation dialog", PASS, " Close Accounts confirmation dialog appeared.")
					[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
					[ ] PermanentlyCloseAccount.OK.Click()
					[ ] 
					[ ] sleep(3)
					[ ] AccountDetails.SetActive()
					[ ] AccountDetails.OK.Click()
					[ ] sleep(3)
					[ ] 
					[ ] AccountBarSelect(sAccountTypeSeparate,2 )
					[ ] iNavigate=NavigateToAccountDetails(sBusinessAccountCustomer)
					[+] if(iNavigate==PASS)
						[ ] AccountDetails.TextClick("Display Options")
						[ ] AccountDetails.CloseAccount.Click()
						[+] if (PermanentlyCloseAccount.Exists(5))
							[ ] ReportStatus("Verify Close Accounts confirmation dialog", PASS, " Close Accounts confirmation dialog appeared.")
							[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
							[ ] PermanentlyCloseAccount.OK.Click()
							[ ] 
							[ ] sleep(3)
							[ ] AccountDetails.SetActive()
							[ ] AccountDetails.OK.Click()
							[ ] 
							[ ] sleep(3)
							[ ] //Verify that Hidden Account Details are not shown in Business Reports
							[ ] 
							[ ] QuickenWindow.SetActive()
							[+] for(i=1;i<=12;i++)
								[ ] QuickenWindow.SetActive ()
								[ ] 
								[ ] // Fetch ith row from the given sheet
								[ ] lsReport=lsExcelData[i]
								[ ] 
								[ ] 
								[ ] //Read value of Row to read total from
								[ ] sToConvert=lsReport[3]
								[ ] QuickenWindow.SetActive()
								[ ] QuickenWindow.Business.Click()
								[ ] QuickenWindow.Business.BusinessReports.Click()
								[ ] 
								[ ] 
								[ ] //Open required report from Business Reports
								[+] switch(i)
									[+] case 1
										[ ] QuickenWindow.Business.BusinessReports.AccountsPayable.Select()
										[ ] APByVendor.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
										[ ] 
									[ ] 
									[+] case 2
										[ ] QuickenWindow.Business.BusinessReports.AccountsReceivable.Select()
										[ ] ARByCustomer.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[+] case 3
										[ ] QuickenWindow.Business.BusinessReports.BalanceSheet.Select()
										[ ] BalanceSheet.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[+] case 4
										[ ] QuickenWindow.Business.BusinessReports.CashFlow.Select()
										[ ] CashFlow.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[+] case 5
										[ ] QuickenWindow.Business.BusinessReports.CashFlowComparison.Select()
										[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[+] case 6
										[ ] QuickenWindow.Business.BusinessReports.MissingChecks.Select()
										[ ] MissingChecks.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
									[+] case 7
										[ ] QuickenWindow.Business.BusinessReports.ProfitAndLossComparison.Select()
										[ ] ProfitAndLossComparison.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
									[+] case 8
										[ ] QuickenWindow.Business.BusinessReports.ProfitAndLossStatement.Select()
										[ ] ProfitAndLossStatement.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
									[+] case 9
										[ ] QuickenWindow.Business.BusinessReports.ProjectJobByBusinessTag.Select()
										[ ] ProjectJobByBusinessTag.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[+] case 10
										[ ] QuickenWindow.Business.BusinessReports.ProjectJobByProject.Select()
										[ ] ProjectJobByProject.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[+] case 11
										[ ] QuickenWindow.Business.BusinessReports.ScheduleCProfitOrLossFrom.Select()
										[ ] ScheduleCReport.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[+] case 12
										[ ] QuickenWindow.Business.BusinessReports.TaxSchedule.Select()
										[ ] TaxSchedule.QWCustomizeBar1.PopupList1.Select(1) 
										[ ] iRow= Val (sToConvert) 
									[ ] 
									[ ] 
									[+] default
										[ ] ReportStatus("Business Reports",FAIL,"Wrong value")
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[+] if(wReport.Exists(5))
									[ ] 
									[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
									[ ] 
									[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
									[ ] 
									[ ] 
									[+] if(MatchStr("*{lsReport[2]}*", sActual))
										[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
										[ ] 
									[+] else
										[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
										[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] wReport.Close()
									[ ] sleep(2)
								[+] else
									[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Close Accounts confirmation dialog. ", FAIL, " Close Accounts confirmation dialog didn't appear.")
					[+] else
						[ ] ReportStatus("Verify Close Accounts ", FAIL, " Account Details not opened")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Close Accounts confirmation dialog. ", FAIL, " Close Accounts confirmation dialog didn't appear.")
			[+] else
				[ ] ReportStatus("Verify Close Accounts ", FAIL, " Account Details not opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Hidden Account Reports",FAIL,"File did not open")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
[ ] //###################################################################
[ ] // 
[ ] 
[ ] 
[ ] //#############  Hidden In AccountBar And TransactionEntry Reports_SetUp ######################################################
[ ] 
[+] //#############  HiddenInAccountBarAndTransactionEntryReports_SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 HiddenInAccountBarAndTransactionEntryReports_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will modify data file to test hidden accounts in account bar and transaction entry list
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 						
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 17, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase HiddenInAccountBarAndAccountListReports_SetUp() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] INTEGER iSetUpFile,iAddTransaction
		[ ] STRING sTab= "Display Options"
		[ ] STRING sSavingsAccount2 = "Savings 02"
		[ ] STRING sSavingsAccount1 = "Savings 01"
		[ ] STRING sTransactionWorksheet="Transaction"
		[ ] LIST OF STRING lsTransactionData
		[ ] STRING sAccountTypeSeparate="Separate"
		[ ] STRING sAccountTypeBanking="Banking"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] iSetUpFile=SetUpReports(sFileNameHiddenAccounts)
		[+] if(iSetUpFile==PASS)
			[ ] ReportStatus("Hidden Account Reports",PASS,"File Opened successfully")
			[ ] // Separate savings account
			[ ] 
			[ ] iNavigate=NavigateToAccountDetailsTab(ACCOUNT_BANKING ,sSavingsAccount2,sTab)	
			[+] if(iNavigate==PASS)
				[ ] AccountDetails.TextClick("Display Options")
				[ ] 
				[ ] AccountDetails.KeepThisAccountSeparate.Check()
				[ ] AccountDetails.OK.Click()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Verify Close Accounts ", FAIL, " Account Details not opened")
				[ ] 
			[ ] // Hide savings account in account bar
			[ ] AccountBarSelect(sAccountTypeBanking,4 )
			[ ] iNavigate=NavigateToAccountDetails(sSavingsAccount1)
			[+] if(iNavigate==PASS)
				[ ] AccountDetails.TextClick("Display Options")
				[ ] 
				[ ] AccountDetails.HideAccountNameInAccountB.Check()
				[ ] AccountDetails.OK.Click()
				[ ] sleep(2)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Close Accounts ", FAIL, " Account Details not opened")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Hidden Account Reports",PASS,"File did not open")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Hidden Account  Reports", FAIL, "Quicken is not available")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Banking reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test15_HiddenAccountsBankingReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden Checking account should not get displayed in the Banking reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If HIdden accounts are not displayed in Banking Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test15_HiddenAccountsBankingReports() appstate none
	[ ] 
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,j,k=2
		[ ] STRING sAccount, sSavingsAccount
		[ ] LIST OF STRING lsReport
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Banking Reports
		[+] for(i=1;i<=5;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] 
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sBankingReportWorksheet)
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Banking.Click()
			[ ] 
			[ ] //Open required report from Banking Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Banking.BankingSummary.Select()
					[ ] BankingSummary.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)            //27
					[ ] 
					[ ] 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Banking.CashFlow.Select()
					[ ] CashFlow.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)             //27
					[ ] 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Banking.CashFlowByTag.Select()
					[ ] CashFlowByTag.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)             //29
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Banking.MissingChecks.Select()
					[ ] MissingChecks.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)          //34
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Banking.Transaction.Select()
					[ ] TransactionReports.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)            //49
					[ ] 
					[ ] 
				[ ] 
				[+] default 
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] 
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] //Close Report Window
				[ ] wReport.Close()
				[ ] sleep(2)
				[ ] 
				[ ] 
				[+] // //waitforstate(SaveReportAs,TRUE,1)
					[+] // if(SaveReportAs.DontShowMeThisAgain.Exists())
						[ ] // //SaveReportAs.SetActive()
						[ ] // SaveReportAs.DontShowMeThisAgain.Check()
						[ ] // SaveReportAs.DontSave.Click()
						[ ] // waitforstate(SaveReportAs,FALSE,1)
					[ ] // 
					[ ] // 
					[ ] // 
					[ ] // // 
					[+] // // if(SaveReportAs.Exists())
						[ ] // // SaveReportAs.SetActive()
						[ ] // // SaveReportAs.DontShowMeThisAgain.Check()
						[ ] // // SaveReportAs.DontSave.Click()
						[ ] // // 
						[ ] // // 
						[ ] // // 
					[ ] // // 
					[ ] // // 
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Comparison reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test16_HiddenAccountsComparisonReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden Checking account should not get displayed in the Comparison reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Hidden accounts are not displayed in Comparison Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 29, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test16_HiddenAccountsComparisonReports() appstate none
	[ ] 
	[ ] // 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,iSetUpFile
		[ ] STRING sTab,sAccount, sSavingsAccount,sToConvert
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] BOOLEAN bSeparateAccount
		[ ] //sAccount="Vendor Invoices 1"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sComparisonReportWorksheet)
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Comparison Reports
		[+] for(i=1;i<=6;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Comparison.Click()
			[ ] 
			[ ] //Open required report from Comparison Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Comparison.CurrentVsAverageSpendingByCategory.Select()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Comparison.CurrentVsAverageSpendingByPayee.Select()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Comparison.CashFlowComparison.Select()
					[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Comparison.IncomeAndExpenseComparison1.Select()
					[ ] IncomeExpenseComparisonByC.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Comparison.IncomeAndExpenseComparison2.Select()
					[ ] IncomeExpenseComparisonByP.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 6
					[ ] 
					[ ] QuickenWindow.Reports.Comparison.ProfitAndLoss.Select()
					[ ] ProfitAndLossComparison.QWCustomizeBar1.PopupList1.Select(1)
					[ ] // ProfitAndLossComparison.QWCustomizeBar1.PopupList3.Select(23)
					[ ] // DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] // DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] // DlgCustomDate.OKButton.Click()
					[ ] iRow= Val (sToConvert) 
					[ ] 
				[ ] 
				[+] default
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Net Worth & Balances reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test17_HiddenAccountsNetWorthAndBalancesReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden Checking account should not get displayed in the Net Worth & Balances reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If hidden accounts are not displayed in Net Worth & Balances Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 30, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test17_HiddenAccountsNetWorthAndBalancesReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,j,k=2
		[ ] STRING sTab,sAccount, sSavingsAccount,sToConvert
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] INTEGER iSetUpFile
		[ ] BOOLEAN bSeparateAccount
		[ ] //sAccount="Vendor Invoices 1"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Net Worth & Balances Reports
		[+] for(i=1;i<=2;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sNetWorthReportWorksheet)
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.NetWorthBalances.Click()
			[ ] 
			[ ] 
			[ ] //Open required report from NetWorthAndBalances Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.NetWorthBalances.AccountBalances.Select()
					[ ] AccountBalances.QWCustomizeBar.PopupList1.Select(23)
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.NetWorthBalances.NetWorth.Select()
					[ ] NetWorthReports.QWCustomizeBar.PopupList1.Select(23) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] default
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] 
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Spending reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test18_HiddenAccountsSpendingReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden Checking account should not get displayed in the Spending reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If hidden accounts are not displayed in Spending Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 30, 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test18_HiddenAccountsSpendingReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow
		[ ] STRING sTab,sAccount, sSavingsAccount,sSavingsAccount2
		[ ] LIST OF STRING lsReport
		[ ] sSavingsAccount= "Savings 02"
		[ ] sTab= "Display Options"
		[ ] sAccount="Vendor Invoices 1"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Spending Reports
		[+] for(i=1;i<=11;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sSpendingReportWorksheet)
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Spending.Click()
			[ ] 
			[ ] //Open required report from Spending Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Spending.ItemizedCategories.Select()
					[ ] ItemizedCategories.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Spending.ItemizedPayees.Select()
					[ ] ItemizedPayees.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Spending.ItemizedTags.Select()
					[ ] 
					[ ] ItemizedTags.QWCustomizeBar.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Spending.SpendingByCategory.Select()
					[ ] SpendingByCategory.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Spending.SpendingByPayee.Select()
					[ ] SpendingByPayee.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 6
					[ ] QuickenWindow.Reports.Spending.CurrentVsAverageSpendingByCategory.Select()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 7
					[ ] QuickenWindow.Reports.Spending.CurrentVsAverageSpendingByPayee.Select()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList1.Select(12) 
					[ ] DlgCustomDate.FromTextField.SetText("01/01/2012")
					[ ] DlgCustomDate.ToTextField.SetText("12/31/2014")
					[ ] DlgCustomDate.OKButton.Click()
					[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList2.Select(9)
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 8
					[ ] QuickenWindow.Reports.Spending.IncomeAndExpenseByCategory.Select()
					[ ] IncomeExpenseByCategory.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 9
					[ ] QuickenWindow.Reports.Spending.IncomeAndExpenseByPayee.Select()
					[ ] IncomeExpenseByPayee.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 10
					[ ] QuickenWindow.Reports.Spending.CurrentBudget.Select()
					[ ] CurrentBudget.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] case 11
					[ ] QuickenWindow.Reports.Spending.HistoricalBudget.Select()
					[ ] HistoricalBudget.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] default
					[ ] ReportStatus("Spending Reports",FAIL,"Incorrect Value entered")
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened sucessfully")
				[ ] 
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] 
				[ ] //Values should match for all except last two cases since additonal values are shown in Current and Historical budget
				[+] if(i<10)
					[ ] 
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[ ] 
					[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in the Investing reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test19_HiddenAccountsInvestingReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden Checking account should not get displayed in the Investing reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If hidden accounts are not displayed in Investing Reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test19_HiddenAccountsInvestingReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow
		[ ] 
		[ ] STRING sTab
		[ ] LIST OF STRING lsReport
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileNameHiddenAccounts + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileNameHiddenAccounts + ".QDF"
		[ ] STRING sInvestingAccount1="Brokerage 01"
		[ ] STRING sInvestingAccount2="Brokerage 02"
		[ ] 
		[ ] sTab= "Display Options"
		[ ] //sAccount="Vendor Invoices 1"
		[ ] STRING sAccountTypeInvesting="Investing"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sInvestingReportWorksheet)
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] iNavigate=NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sInvestingAccount2,sTab)		
		[+] if(iNavigate==PASS)
			[ ] AccountDetails.TextClick("Display Options")
			[ ] 
			[ ] AccountDetails.KeepThisAccountSeparate.Check()
			[ ] AccountDetails.OK.Click()
			[ ] sleep(2)
		[+] else
			[ ] ReportStatus("Verify Close Accounts ", FAIL, " Account Details not opened")
			[ ] 
		[ ] // Hide savings account in account bar
		[ ] AccountBarSelect(sAccountTypeInvesting,2 )
		[ ] iNavigate=NavigateToAccountDetails(sInvestingAccount1)
		[+] if(iNavigate==PASS)
			[ ] AccountDetails.TextClick("Display Options")
			[ ] AccountDetails.HideAccountNameInAccountB.Check()
			[ ] AccountDetails.OK.Click()
			[ ] sleep(2)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Close Accounts ", FAIL, " Account Details not opened")
			[ ] 
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Investing Reports
		[+] for(i=1;i<=9;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Investing.Click()
			[ ] 
			[ ] 
			[ ] //Open required report from Banking Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Investing.CapitalGains.Select()
					[ ] CapitalGains.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Investing.InvestingActivity.Select()
					[ ] InvestingActivity.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
				[ ] 
				[+] case 3
					[ ] QuickenWindow.Reports.Investing.InvestmentAssetAllocation.Select()
					[ ] AssetAllocation.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Investing.InvestmentIncome.Select()
					[ ] InvestmentIncome.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Investing.InvestmentPerformance.Select()
					[ ] InvestmentPerformance.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[+] case 6
					[ ] QuickenWindow.Reports.Investing.InvestmentTransactions.Select()
					[ ] InvestmentTransactions.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 7
					[ ] QuickenWindow.Reports.Investing.MaturityDatesForBondsAndC.Select()
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 8
					[ ] QuickenWindow.Reports.Investing.PortfolioValue.Select()
					[ ] PortfolioValue.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
				[ ] 
				[+] case 9
					[ ] QuickenWindow.Reports.Investing.PortfolioValueCostBasis.Select()
					[ ] PortfolioValueAndCostBasis.QWCustomizeBar1.PopupList1.Select(1) 
					[ ] iRow= Val (sToConvert) 
				[ ] 
				[+] default
					[ ] ReportStatus("Spending Reports",FAIL,"Incorrect Value entered")
			[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[+] if(i!=7)
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[ ] 
				[+] else
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Banking Summary Report is not available")
		[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in Tax reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test20_HiddenAccountsTaxReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden Checking account should not get displayed in Tax reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If hidden accounts are not displayed in Tax reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[-] testcase Test20_HiddenAccountsTaxReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iNavigateTo,iRow,iSetupAutoAPI
		[ ] STRING sFileNameHiddenAccounts="HiddenAccountReports2"
		[ ] STRING sTab,sAccount, sSavingsAccount,sSavingsAccount2,sInvestingAccount,sTaxReportWorksheet
		[ ] LIST OF STRING lsReport
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileNameHiddenAccounts + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileNameHiddenAccounts + ".QDF"
		[ ] sSavingsAccount= "Savings 02"
		[ ] sInvestingAccount="Brokerage 02"
		[ ] sTab= "Display Options"
		[ ] sTaxReportWorksheet="Tax Reports"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sTaxReportWorksheet)
		[ ] 
	[ ] 
	[ ] 
	[-] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
		[-] if (DlgFindAndReplace.Exists(5))
			[ ] DlgFindAndReplace.SetActive()
			[ ] DlgFindAndReplace.SearchTextField.SetText(sOldDateYear)
			[ ] DlgFindAndReplace.FindButton.Click()
			[ ] DlgFindAndReplace.SelectAllButton.Click()
			[ ] DlgFindAndReplace.ReplacePopupList.SetFocus()
			[ ] DlgFindAndReplace.ReplacePopupList.Select("Date")
			[ ] sleep(1)
			[ ] DlgFindAndReplace.ReplacementTextField.SetText(sDateStamp)
			[ ] DlgFindAndReplace.ReplaceAllButton.Click()
			[ ] sleep(15)
			[ ] DlgFindAndReplace.DoneButton.Click()
			[ ] WaitForState(DlgFindAndReplace,False,5)
			[ ] sleep(2)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Verify that Hidden Account Details are not shown in Business Reports
			[-] for(i=1;i<=5;i++)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[ ] 
				[ ] // Fetch ith row from the given sheet
				[ ] lsReport=lsExcelData[i]
				[ ] 
				[ ] 
				[ ] //Read value of Row to read total from
				[ ] sToConvert=lsReport[3]
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Tax.Click()
				[ ] 
				[ ] 
				[ ] //Open required report from Business Reports
				[-] switch(i)
					[-] case 1
						[ ] QuickenWindow.Reports.Tax.ScheduleAItemizedDeductions.Select()
						[ ] ScheduleA.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[-] case 2
						[ ] QuickenWindow.Reports.Tax.ScheduleBInterestAndDivide.Select()
						[ ] ScheduleB.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[-] case 3
						[ ] QuickenWindow.Reports.Tax.ScheduleDCapitalGainsAndL.Select()
						[ ] ScheduleD.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 4
						[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
						[ ] TaxSchedule.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] case 5
						[ ] QuickenWindow.Reports.Tax.TaxSummary.Select()
						[ ] TaxSummary.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow=Val (sToConvert) 
					[ ] 
					[+] default
						[ ] ReportStatus("Tax Reports",FAIL,"Wrong value")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] if(wReport.Exists(5))
					[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened sucessfully")
					[ ] 
					[ ] 
					[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
					[ ] 
					[ ] 
					[ ] 
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
					[ ] 
					[+] if(i!=4)
						[+] if(MatchStr("*{lsReport[2]}*", sActual))
							[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
						[+] else
							[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
							[ ] 
					[+] else
						[+] if(MatchStr("*{lsReport[2]}*", sActual))
							[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
						[+] else
							[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] wReport.Close()
					[ ] sleep(2)
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
					[ ] 
		[+] else
			[ ] ReportStatus("Verify Find and Replace dialog", FAIL, " Find and Replace dialog didn't appear.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Banking Summary Report", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
[ ] // //###################################################################
[ ] 
[ ] 
[+] //#############Verify that Separate accounts and its transactions should not get displayed in Business reports###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test21_HiddenAccountsBusinessReports()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden Checking account should not get displayed in Business reports. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If hidden accounts are not displayed in Business reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test21_HiddenAccountsBusinessReports() appstate none
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iOpenDataFile,iRow
		[ ] STRING sBusinessFileNameHiddenAccounts="HiddenAccountBusinessReports"
		[ ] STRING sBusinessReportWorksheet
		[ ] STRING sAccountType="Business"
		[ ] LIST OF STRING lsReport,lsTransactionData
		[ ] STRING sTab= "Display Options"
		[ ] sBusinessReportWorksheet="Business Reports"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] iSetUpFile=SetUpReports(sBusinessFileNameHiddenAccounts)
		[+] if(iSetUpFile==PASS)
			[ ] ReportStatus("Hidden Account Reports",PASS,"File Opened successfully")
			[ ] //Verify that Hidden Account Details are not shown in Business Reports
			[+] for(i=1;i<=12;i++)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sBusinessReportWorksheet)
				[ ] // Fetch ith row from the given sheet
				[ ] lsReport=lsExcelData[i]
				[ ] 
				[ ] 
				[ ] //Read value of Row to read total from
				[ ] sToConvert=lsReport[3]
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.BusinessReports.Click()
				[ ] 
				[ ] 
				[ ] //Open required report from Business Reports
				[+] switch(i)
					[+] case 1
						[ ] QuickenWindow.Business.BusinessReports.AccountsPayable.Select()
						[ ] APByVendor.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
						[ ] 
					[ ] 
					[+] case 2
						[ ] QuickenWindow.Business.BusinessReports.AccountsReceivable.Select()
						[ ] ARByCustomer.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[+] case 3
						[ ] QuickenWindow.Business.BusinessReports.BalanceSheet.Select()
						[ ] BalanceSheet.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[+] case 4
						[ ] QuickenWindow.Business.BusinessReports.CashFlow.Select()
						[ ] CashFlow.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[+] case 5
						[ ] QuickenWindow.Business.BusinessReports.CashFlowComparison.Select()
						[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[+] case 6
						[ ] QuickenWindow.Business.BusinessReports.MissingChecks.Select()
						[ ] MissingChecks.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
					[+] case 7
						[ ] QuickenWindow.Business.BusinessReports.ProfitAndLossComparison.Select()
						[ ] ProfitAndLossComparison.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
					[+] case 8
						[ ] QuickenWindow.Business.BusinessReports.ProfitAndLossStatement.Select()
						[ ] ProfitAndLossStatement.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
					[+] case 9
						[ ] QuickenWindow.Business.BusinessReports.ProjectJobByBusinessTag.Select()
						[ ] ProjectJobByBusinessTag.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[+] case 10
						[ ] QuickenWindow.Business.BusinessReports.ProjectJobByProject.Select()
						[ ] ProjectJobByProject.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[+] case 11
						[ ] QuickenWindow.Business.BusinessReports.ScheduleCProfitOrLossFrom.Select()
						[ ] ScheduleCReport.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[+] case 12
						[ ] QuickenWindow.Business.BusinessReports.TaxSchedule.Select()
						[ ] TaxSchedule.QWCustomizeBar1.PopupList1.Select(1) 
						[ ] iRow= Val (sToConvert) 
					[ ] 
					[ ] 
					[+] default
						[ ] ReportStatus("Business Reports",FAIL,"Wrong value")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] if(wReport.Exists(5))
					[ ] 
					[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
					[ ] 
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
					[ ] 
					[ ] 
					[+] if(MatchStr("*{lsReport[2]}*", sActual))
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
						[ ] 
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] wReport.Close()
					[ ] sleep(2)
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
			[ ] 
		[+] else
			[ ] ReportStatus("Hidden Account Reports",FAIL,"File did not open")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[ ] 
[+] //#############Verify the displaying of Account in Reports after enabling show hide in Transaction Entry list checkbox ###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test22_SeparateAccountsCustomizeButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the displaying of Separate account in Reports after enabling show hidden account checkbox on Customize account dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Business reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test22_AccountsHiddenInTransactionEntryList() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] INTEGER iSetUpFile,iSelect
		[ ] STRING sSavingsAccount1= "Savings 01"
		[ ] STRING sSavingsAccount2= "Savings 02"
		[ ] STRING sTab= "Display Options"
		[ ] STRING sAccountTypeBanking="Banking"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] iSetUpFile=SetUpReports(sFileNameHiddenAccounts)
		[+] if(iSetUpFile)
			[ ] ReportStatus("Hidden Account Reports",PASS,"File Opened successfully")
		[+] else
			[ ] ReportStatus("Hidden Account Reports",PASS,"File did not open")
		[ ] 
		[ ] // Separate savings account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sSavingsAccount2,sTab)			
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Check "Keep This Account Separate" checkbox
			[+] if(AccountDetails.KeepThisAccountSeparate.Exists())
				[ ] AccountDetails.KeepThisAccountSeparate.Check()
				[ ] AccountDetails.OK.Click()
				[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", PASS, "{sSavingsAccount2} is made separated")
				[ ] 
		[ ] 
		[ ] 
		[ ] //Hide Account in Account Bar and Account List
		[ ] AccountBarSelect(sAccountTypeBanking,4 )
		[ ] NavigateToAccountDetails(sSavingsAccount1)
		[ ] AccountDetails.TextClick("Display Options")
		[ ] AccountDetails.HideInTransactionEntryList.Check()
		[ ] AccountDetails.OK.Click()
		[ ] 
		[ ] 
		[ ] //Verify that Hidden Account Details are not shown in Banking Reports
		[+] for(i=1;i<=5;i++)
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] 
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sBankingReportWorksheet)
			[ ] // Fetch ith row from the given sheet
			[ ] lsReport=lsExcelData[i]
			[ ] 
			[ ] //Read value of Row to read total from
			[ ] sToConvert=lsReport[3]
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Reports.Click()
			[ ] QuickenWindow.Reports.Banking.Click()
			[ ] 
			[ ] //Open required report from Banking Reports
			[+] switch(i)
				[+] case 1
					[ ] QuickenWindow.Reports.Banking.BankingSummary.Select()
					[ ] BankingSummary.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)           
					[ ] 
					[ ] 
				[ ] 
				[+] case 2
					[ ] QuickenWindow.Reports.Banking.CashFlow.Select()
					[ ] CashFlow.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)           
					[ ] 
				[ ] 
				[+] case 3	
					[ ] QuickenWindow.Reports.Banking.CashFlowByTag.Select()
					[ ] CashFlowByTag.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)       
				[ ] 
				[+] case 4
					[ ] QuickenWindow.Reports.Banking.MissingChecks.Select()
					[ ] MissingChecks.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)         
				[ ] 
				[+] case 5
					[ ] QuickenWindow.Reports.Banking.Transaction.Select()
					[ ] TransactionReports.QWCustomizeBar1.PopupList1.Select(1)
					[ ] iRow= Val (sToConvert)            
					[ ] 
					[ ] 
				[ ] 
				[+] default 
					[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[+] if(wReport.Exists(5))
				[ ] 
				[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
				[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
				[ ] 
				[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
				[ ] 
				[ ] 
				[ ] //Close Report Window
				[ ] wReport.Close()
				[ ] sleep(2)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[ ] 
[+] //#############Verify the displaying of Separate account in Reports after enabling show hidden account checkbox on Customize account dialog###########
	[ ] // ********************************************************
	[+] // TestCase Name: Test22_SeparateAccountsCustomizeButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the displaying of Separate account in Reports after enabling show hidden account checkbox on Customize account dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate accounts are not displayed in Business reports.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  , 2012		Dean Paes	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test23_SeparateAccountsCustomizeButton() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sFileNameHiddenAccounts= "HiddenAccountReports"
		[ ] INTEGER iSetUpFile,iSelect
		[ ] STRING sSavingsAccount= "Savings 02"
		[ ] STRING sTab= "Display Options"
		[ ] STRING sCustomizeReportWorksheet="Customize Button"
		[ ] STRING sActual1,sActual2
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable( sTestDataHiddenAccounts, sCustomizeReportWorksheet)
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] OpenDataFile("TempFile")
		[ ] iSetUpFile=SetUpReports(sFileNameHiddenAccounts)
		[ ] iSetUpFile=PASS
		[+] if(iSetUpFile==PASS)
			[ ] ReportStatus("Hidden Account Reports",PASS,"File Opened successfully")
			[ ] 
			[ ] //Verify that Hidden Account Details are not shown in Banking Reports
			[+] for(i=1;i<=5;i++)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[ ] 
				[ ] // Fetch ith row from the given sheet
				[ ] lsReport=lsExcelData[i]
				[ ] 
				[ ] //Read value of Row to read total from
				[ ] sToConvert=lsReport[3]
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Banking.Click()
				[ ] 
				[ ] //Open required report from Banking Reports
				[+] switch(i)
					[+] case 1
						[ ] QuickenWindow.Reports.Banking.BankingSummary.Select()
						[ ] BankingSummary.QWCustomizeBar1.PopupList1.Select(1)
						[ ] BankingSummary.QW_BAG_TOOLBAR1.QW_MAIN_TOOLBAR1.TextClick("Customize")
						[+] if (CustomizeReport.Exists(5))
							[ ] CustomizeReport.SetActive()
							[ ] CustomizeReport.TextClick("Accounts")
							[ ] CustomizeReport.QWListViewer1.ListBox1.Select(7)
							[ ] CustomizeReport.OKButton.Click()
						[+] else
							[ ] ReportStatus("Verify Customize report dialog", FAIL,"Customize report dialog didn't appear.")
						[ ] iRow= Val (sToConvert)           
						[ ] 
						[ ] 
					[ ] 
					[+] case 2
						[ ] QuickenWindow.Reports.Banking.CashFlow.Select()
						[ ] CashFlow.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow= Val (sToConvert)           
						[ ] 
					[ ] 
					[+] case 3	
						[ ] QuickenWindow.Reports.Banking.CashFlowByTag.Select()
						[ ] CashFlowByTag.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow= Val (sToConvert)       
					[ ] 
					[+] case 4
						[ ] QuickenWindow.Reports.Banking.MissingChecks.Select()
						[ ] MissingChecks.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow= Val (sToConvert)         
					[ ] 
					[+] case 5
						[ ] QuickenWindow.Reports.Banking.Transaction.Select()
						[ ] TransactionReports.QWCustomizeBar1.PopupList1.Select(1)
						[ ] iRow= Val (sToConvert)            
						[ ] 
						[ ] 
					[ ] 
					[+] default 
						[ ] ReportStatus("Banking Reports",FAIL,"Incorrect Value entered")
						[ ] 
					[ ] 
					[ ] 
				[ ] 
				[+] if(wReport.Exists(5))
					[ ] 
					[ ] 
					[ ] 
					[ ] ReportStatus("Match Banking Summary Reports", PASS, " {lsReport[1]}' report opened successfully")
					[ ] sHandle = Str(wReport.QWListViewer1.ListBox1.GetHandle())
					[ ] 
					[ ] // QwAutoExecuteCommand("QW_BAG_TOOLBAR1.QW_MAIN_TOOLBAR1_CLICK","Customize")
					[ ] 
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iRow}")
					[ ] 
					[ ] 
					[ ] bMatch = MatchStr("*{lsReport[2]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Match Banking Summary Reports", PASS, "Hidden account details are not displayed in the '{lsReport[1]}' report")
					[+] else
						[ ] ReportStatus("Match Banking Summary Reports", FAIL, "Hidden account details are displayed in the '{lsReport[1]}' report")
					[ ] 
					[ ] 
					[ ] //Close Report Window
					[ ] wReport.Close()
					[ ] sleep(2)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Match Banking Summary Reports", FAIL, " {lsReport[1]}' report did not open")
			[ ] 
		[+] else
			[ ] ReportStatus("Hidden Account Reports",FAIL,"File did not open")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Hidden Account Report Verification", FAIL, "Quicken is not available")
		[ ] 
	[ ] 
[ ] //###################################################################
