[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<Reports.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Report test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  KalyanG
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Mar 13, 2015	KalyanG  Created
[ ] // *********************************************************
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
	[ ] //--------------EXCEL DATA----------------
	[ ] // .xls file
	[ ] public STRING sReportsDataExcel="Reports_TestData"
	[ ] public STRING sFileName = "Report"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sReportsData = "ReportsData"
	[ ] public STRING sAccountWorksheet = "AccountTransactions"
[ ] 
[+] //Local Functions
	[ ] 
	[+] public LIST OF STRING getReportContents(STRING sReportName)
		[ ] WINDOW wReport
		[+] switch (sReportName)
			[+] case "CurrentVsAverageSpendingByCategory"
				[ ] wReport = CurrentVsAverageSpendingByCategory.QWListViewer1
			[+] case "CurrentVsAverageSpendingByPayee"
				[ ] wReport = CurrentVsAverageSpendingByPayee.QWListViewer1
			[+] case "CashFlowComparison"
				[ ] wReport = CashFlowComparison.QWListViewer1
			[+] case "IncomeExpenseComparisonByC"
				[ ] wReport = IncomeExpenseComparisonByC.QWListViewer1
			[+] case "IncomeExpenseComparisonByP"
				[ ] wReport = IncomeExpenseComparisonByP.QWListViewer1
			[ ] 
			[+] default
				[ ] raise -1, "Function [getReportContents] invalid argument [{sReportName}]"
		[ ] 
		[ ] wReport.SetActive()
		[ ] Clipboard.SetText({""})
		[ ] wReport.OpenContextMenu(3,3)
		[ ] sleep(1)
		[ ] // Its a defect, change type keys to Ctrl+C after fixing
		[ ] wReport.TypeKeys("C")
		[ ] return Clipboard.GetText()
	[+] public BOOLEAN verifyReport (LIST OF STRING lsActual, LIST OF STRING lsExpected)
		[ ] INTEGER iCount, jCount
		[ ] BOOLEAN bFound, bVerify = TRUE
		[ ] 
		[+] for iCount = 1 to ListCount(lsExpected)
			[ ] bFound = FALSE
			[+] for jCount = 1 to ListCount(lsActual)
				[+] if (MatchStr("*{lsExpected[iCount]}*", lsActual[jCount]))
					[ ] bFound = TRUE
					[ ] ReportStatus("Report Content Verification", PASS, "{lsExpected[iCount]} found on the report")
					[ ] break
				[ ] 
			[+] if (! bFound)
				[ ] ReportStatus("Report Content Verification", FAIL, "{lsExpected[iCount]} not found on the report")
				[ ] bVerify = FALSE
		[ ] 
		[ ] return bVerify
	[+] public VOID deselectManualBackupOption()
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[ ] 
		[+] if(Preferences.Exists(5))
			[ ] Preferences.SelectPreferenceType1.ListBox.Select(5)
			[ ] Preferences.ManualBackupReminder.Uncheck()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Preferences window is present", FAIL, "Preferences window not found")
	[+] public LIST OF STRING getReportDatesFromCurrent()
		[ ] 
		[ ] DATETIME today = GetDateTime()
		[ ] STRING sFormat = "m/d/yyyy"
		[ ] 
		[-] LIST OF ANYTYPE lsDates ={...}
			[ ] "{FormatDateTime(AddDateTime(today,-180),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-150),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-120),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-90),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-60),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-30),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-15),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-1),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-2),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-3),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-4),sFormat)}"
			[ ] "{FormatDateTime(AddDateTime(today,-5),sFormat)}"
		[ ] 
		[ ] return lsDates
		[ ] 
	[+] public VOID invokeReport (STRING sReportName)
		[ ] 
		[ ] BOOLEAN bInvoke
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Reports.Click()
		[ ] QuickenWindow.Reports.Comparison.Click()
		[ ] 
		[+] switch (sReportName)
			[ ] 
			[+] case "CurrentVsAverageSpendingByCategory"
				[ ] QuickenWindow.Reports.Comparison.CurrentVsAverageSpendingByCategory.Select()
				[ ] sleep(2)
				[ ] bInvoke = CurrentVsAverageSpendingByCategory.Exists()
			[+] case "CurrentVsAverageSpendingByPayee"
				[ ] QuickenWindow.Reports.Comparison.CurrentVsAverageSpendingByPayee.Select()
				[ ] sleep(2)
				[ ] bInvoke = CurrentVsAverageSpendingByPayee.Exists()
				[ ] 
			[+] case "CashFlowComparison"
				[ ] QuickenWindow.Reports.Comparison.CashFlowComparison.Select()
				[ ] sleep(2)
				[ ] bInvoke = CashFlowComparison.Exists()
			[+] case "IncomeExpenseComparisonByC"
				[ ] QuickenWindow.Reports.Comparison.IncomeAndExpenseComparison1.Select()
				[ ] sleep(2)
				[ ] bInvoke = IncomeExpenseComparisonByC.Exists()
			[+] case "IncomeExpenseComparisonByP"
				[ ] QuickenWindow.Reports.Comparison.IncomeAndExpenseComparison2.Select()
				[ ] sleep(2)
				[ ] bInvoke = IncomeExpenseComparisonByP.Exists()
			[+] default
				[ ] raise -1, "Function [selectReport] invalid argument [{sReportName}]"
			[ ] 
			[+] if (!bInvoke)
				[ ] raise -1, "Function [selectReport] Failed to invoke [{sReportName}]"
		[ ] 
	[+] public VOID openQuickenFile(STRING fileName)
		[ ] 
		[+] if !(QuickenWindow.Exists())
			[ ] LaunchQuicken()
			[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] STRING sCaption = QuickenWindow.GetCaption()
		[ ] BOOLEAN bCaption = MatchStr("*{fileName}*", sCaption)
		[ ] 
		[+] if (! bCaption)
			[+] if (! FileExists("{AUT_DATAFILE_PATH}\{fileName}.QDF"))
				[ ] raise -1, "File not found [{AUT_DATAFILE_PATH}\{fileName}.QDF]"
			[+] else
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.OpenQuickenFile.Select ()
				[ ] OpenQuickenFile.SetActive ()
				[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\" + fileName + ".QDF")
				[ ] OpenQuickenFile.OK.Click ()
				[ ] sleep(5)
		[ ] 
		[ ] SetViewMode(VIEW_CLASSIC_MENU)
		[ ] UsePopUpRegister("OFF")
		[ ] sleep(SHORT_SLEEP)
		[ ] 
	[+] public VOID closeReport (STRING sReportName)
		[ ] 
		[ ] WINDOW wReport
		[+] switch (sReportName)
			[+] case "CurrentVsAverageSpendingByCategory"
				[ ] wReport = CurrentVsAverageSpendingByCategory
			[+] case "CurrentVsAverageSpendingByPayee"
				[ ] wReport = CurrentVsAverageSpendingByPayee
			[+] case "CashFlowComparison"
				[ ] wReport = CashFlowComparison
			[+] case "IncomeExpenseComparisonByC"
				[ ] wReport = IncomeExpenseComparisonByC
			[+] case "IncomeExpenseComparisonByP"
				[ ] wReport = IncomeExpenseComparisonByP
			[+] default
				[ ] raise -1, "Function [getReportContents] invalid argument [{sReportName}]"
		[ ] wReport.SetActive()
		[ ] wReport.Close()
		[ ] 
		[+] if (SaveReportAs.Exists(5))
			[ ] SaveReportAs.DonTSave.Click()
	[+] // public VOID deleteTransaction (STRING sTransaction)
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // AccountBarSelect(ACCOUNT_BANKING, 1)
		[ ] // QuickenWindow.Edit.Click()
		[ ] // QuickenWindow.Edit.Find.Select()
		[ ] // 
		[+] // if ! (QuickenFind.Exists(SHORT_SLEEP))
			[ ] // raise -1, "QuickenFind Dialog not found"
		[+] // else
			[ ] // ReportStatus("QuickenFind", PASS, "QuickenFind Dialog Exist!")
		[ ] // 
		[ ] // QuickenFind.SetActive()
		[ ] // QuickenFind.QuickenFind.SetText("")
		[ ] // QuickenFind.Find.Click()
		[ ] // 
		[+] // if ! (AlertMessage.Yes.Exists(5))   
			[ ] // raise -1, "AlertMessage not found after clicking 'Find' on QuickenFind Dialog "
		[+] // else
			[ ] // ReportStatus("AlertMessage", PASS, " 'AlertMessage >> Yes' found after clicking 'Find' on QuickenFind Dialog!")
		[ ] // 
		[ ] // AlertMessage.SetActive ()
		[ ] // AlertMessage.Yes.Click ()
		[ ] // 
		[+] // if(AlertMessage.Exists(5))  
			[ ] // AlertMessage.SetActive ()
			[ ] // AlertMessage.OK.Click()
			[ ] // raise -1, " Transaction [{sTransaction}] not found when searched through QuickenFind Dialog"
		[+] // else
			[ ] // ReportStatus("AlertMessage", PASS, "Transaction [{sTransaction}] found when searched through QuickenFind Dialog")
		[ ] // 
		[ ] // QuickenFind.Close.Click()
		[ ] // sleep(2)
		[ ] // 
		[ ] // // QuickenWindow.Edit.Click()
		[ ] // // QuickenWindow.Edit.Transaction.Click()
		[ ] // // QuickenWindow.Edit.Transaction.Delete.Select()
		[ ] // QuickenWindow.MainMenu.Select("/*Edit/_Transaction/_Delete*")
		[ ] // sleep(2)
		[ ] // 
		[ ] // print (AlertMessage.StaticText.GetText() )
		[ ] // print("************")
		[+] // if !(AlertMessage.Exists(5) && AlertMessage.StaticText.GetText() == "Delete the Current Transaction?")
			[ ] // raise -1, "Alert message for delete transaction did not appear"
		[ ] // 
		[ ] // ReportStatus("Edit>Transaction>Delete", PASS, "Alert message for delete transaction [{sTransaction}] found!")
		[ ] // AlertMessage.Yes.Click()
		[ ] // sleep(1)
	[+] public BOOLEAN isCategoryExist (LIST OF STRING lsActual, STRING sCategory)
		[ ] INTEGER  jCount
		[ ] BOOLEAN bFound = FALSE
		[+] for jCount = 1 to ListCount(lsActual)
			[+] if (MatchStr("*{sCategory}*", lsActual[jCount]))
				[ ] bFound = TRUE
				[ ] break
		[ ] return bFound
	[+] // public INTEGER AddAccountForReport(STRING sAccountType, STRING sAccountName, STRING sAccountBalance, STRING sAccountCreateDate optional,STRING sAccountIntent optional)
		[-] // // Variable declaration
			[ ] // STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
			[ ] // 
			[ ] // 
		[-] // do
			[+] // if(sAccountCreateDate == NULL) 
				[ ] // sAccountCreateDate =sDateStamp
			[ ] // dockAccountBar()
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.Tools.Click()
			[ ] // QuickenWindow.Tools.AddAccount.Select()
			[ ] // 
			[-] // if (AddAccount.Exists(30))
				[ ] // AddAccount.SetActive()
				[+] // switch(sAccountType)
					[-] // case "Checking"
						[ ] // //AddAccount.PushButton(sAccountType).Click()
						[ ] // AddAccount.Checking.Click()
						[ ] // 
						[ ] // WaitForState(AddAnyAccount.Panel.QWHtmlView1,TRUE,700)
						[+] // if(AddAnyAccount.Exists(SHORT_SLEEP) && AddAnyAccount.IsEnabled())
							[ ] // ADDACC:
							[ ] // AddAnyAccount.SetActive()
							[ ] // AddAnyAccount.Panel.QWHtmlView1.Click (1, 62, 5)
							[ ] // AddAnyAccount.AddCheckingAccount.Select("I want to enter my transactions manually")
							[ ] // WaitForState(AddAnyAccount.Next,true,2)
							[ ] // AddAnyAccount.Next.Click()
						[+] // else
							[ ] // sleep(10)
							[+] // if(AddAnyAccount.Exists(700) )
								[ ] // goto ADDACC
							[+] // else
								[ ] // ReportStatus("Validate Add {sAccountType} Account Window", FAIL, "Add {sAccountType} Account window is not available") 
					[+] // case "Savings"
						[ ] // AddAccount.Savings.Click()
						[ ] // 
						[+] // // if(MessageBox.Exists(2))
							[ ] // // //QuickenUpdateStatus.SetActive()
							[ ] // // MessageBox.TypeKeys(KEY_ENTER)
							[ ] // // 
						[ ] // WaitForState(AddAnyAccount.Panel.QWHtmlView1,TRUE,700)
						[+] // if(AddAnyAccount.Exists(SHORT_SLEEP))
							[ ] // ADDSAVINGACC:
							[ ] // AddAnyAccount.SetActive()
							[ ] // AddAnyAccount.Panel.QWHtmlView1.Click (1, 65, 5)
							[ ] // AddAnyAccount.AddCheckingAccount.Select("I want to enter my transactions manually")
							[ ] // AddAnyAccount.Next.Click()
							[ ] // 
						[+] // else
							[ ] // sleep(10)
							[+] // if(AddAnyAccount.Exists(700) )
								[ ] // goto ADDSAVINGACC
							[+] // else
								[ ] // ReportStatus("Validate Add {sAccountType} Account Window", FAIL, "Add {sAccountType} Account window is not available") 
						[ ] // 
						[ ] // 
					[+] // case "Credit Card"
						[ ] // AddAccount.CreditCard.Click()
						[ ] // 
						[+] // // if(MessageBox.Exists(2))
							[ ] // // //QuickenUpdateStatus.SetActive()
							[ ] // // MessageBox.TypeKeys(KEY_ENTER)
							[ ] // // 
						[ ] // WaitForState(AddAnyAccount.Panel.QWHtmlView1,TRUE,700)
						[+] // if(AddAnyAccount.Exists(SHORT_SLEEP))
							[ ] // AddAnyAccount.Panel.QWHtmlView1.Click (1, 65, 5)
							[ ] // AddAnyAccount.AddCheckingAccount.Select("I want to enter my transactions manually")
							[ ] // AddAnyAccount.Next.Click()
						[+] // else
							[ ] // ReportStatus("Validate Add {sAccountType} Account Window", FAIL, "Add {sAccountType} Account window is not available") 
						[ ] // 
						[ ] // 
					[+] // case "Cash"
						[ ] //  AddAccount.CashButton.Click()
						[ ] // //AddAccount.Next.Click()
						[ ] // 
					[+] // default
						[ ] // print(sAccountType + "not found")
						[ ] // iFunctionResult = FAIL
				[ ] // AddAnyAccount.VerifyEnabled(TRUE, EXTRA_LONG_SLEEP)
				[+] // if(AddAnyAccount.Exists(SHORT_SLEEP))
					[ ] // // Enter Account Name
					[ ] // AddAnyAccount.AccountName.SetText(sAccountName)
					[+] // switch(sAccountIntent)
						[+] // case "BUSINESS"
							[ ] // AddAnyAccount.TypeKeys(KEY_TAB)
							[ ] // AddAnyAccount.TypeKeys(KEY_DN)
						[+] // case "RENTAL"
							[ ] // AddAnyAccount.TypeKeys(KEY_TAB)
							[ ] // AddAnyAccount.TypeKeys(KEY_DN)
							[ ] // AddAnyAccount.TypeKeys(KEY_DN)
							[ ] // 
					[ ] // AddAnyAccount.Next.Click()
					[ ] // // Enter Statement Ending Date
					[ ] // AddAnyAccount.StatementEndingDate.SetText (sAccountCreateDate)
					[ ] // // Enter Account Balance
					[ ] // AddAnyAccount.StatementEndingBalance.SetText(sAccountBalance)
					[ ] // AddAnyAccount.Next.Click()
					[ ] // // If date format is not correct
					[+] // if(AddAnyAccount.AlertMessage.Exists(5))
						[ ] // AddAnyAccount.AlertMessage.SetActive()
						[ ] // AddAnyAccount.AlertMessage.OK.Click()
						[ ] // LogError("Date format is not valid")
						[ ] // iFunctionResult = FAIL
						[ ] // return iFunctionResult
					[ ] // // Click on Finish
					[ ] // AccountAdded.Finish.Click()
					[ ] // 
					[ ] // CloseMobileSyncInfoPopup()
					[ ] // 
					[ ] // iFunctionResult = PASS
				[+] // else
					[ ] // ReportStatus("Validate Add {sAccountType} Account Window", FAIL, "Add {sAccountType} Account window is not available") 
					[ ] // 
				[ ] // 
				[+] // if(DlgReplaceExistingID.Exists(2))
					[ ] // DlgReplaceExistingID.SetActive()
					[ ] // DlgReplaceExistingID.Close()
				[ ] // 
			[-] // else
				[ ] // ReportStatus("Validate Add Account Window", FAIL, "Add Account window is didn't display in 30 seconds.") 
			[ ] // 
			[ ] // 
		[+] // except
			[-] // if(AddAnyAccount.Exists(SHORT_SLEEP))
				[ ] // AddAnyAccount.Close()
				[-] // if(DeleteTransaction.Exists(SHORT_SLEEP))
					[ ] // DeleteTransaction.Yes.Click()
				[ ] // 
				[ ] // 
			[ ] // // Close Alert message
			[+] // if (AddAnyAccount.AlertMessage.Exists(SHORT_SLEEP))
				[ ] // AddAnyAccount.AlertMessage.SetActive()
				[ ] // AddAnyAccount.AlertMessage.TypeKeys("<Ctrl-y>")
				[ ] // 
			[+] // if(AddAccount.Exists(SHORT_SLEEP))
				[ ] // AddAccount.Close()
			[ ] // // QuickenMainWindow.kill()
			[ ] // ExceptLog()
			[ ] // iFunctionResult = FAIL
		[ ] // return iFunctionResult
	[+] // public VOID dockAccountBar()
		[ ] // QuickenWindow.SetActive () 
		[ ] // QuickenWindow.View.click()
		[ ] // QuickenWindow.View.AccountBar.click()
		[ ] // 
		[+] // if !(QuickenWindow.View.AccountBar.DockAccountBar.GetProperty("IsChecked"))
			[ ] // QuickenWindow.View.AccountBar.DockAccountBar.Select()
		[ ] // 
	[+] // public INTEGER DataFileCreateForReport(STRING sFileName,STRING sLocation optional)
		[ ] // 
		[-] // // Variable declaration
			[ ] // STRING sCaption, sExpected, sFileWithPath
			[ ] // BOOLEAN bAssert, bFound , bResult
			[ ] // bResult=FALSE
			[ ] // BOOLEAN bMatch=FALSE
			[ ] // INTEGER iResult
			[ ] // 
			[-] // if(sLocation==NULL)
				[ ] // sFileWithPath = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
			[-] // else
				[ ] // sFileWithPath = sLocation + "\" + sFileName + ".QDF"
				[ ] // 
			[ ] // 
		[-] // do
			[ ] // 
			[+] // if (!QuickenWindow.Exists())
				[ ] // LaunchQuicken()
			[ ] // 
			[-] // if(QuickenWindow.Exists(20))
				[ ] // QuickenWindow.SetActive()
				[ ] // sCaption = QuickenWindow.GetCaption ()
				[ ] // bFound = MatchStr("*{sFileName}*", sCaption)
				[-] // if(FileExists(sFileWithPath))
					[-] // if(bFound)
						[ ] // OpenDataFile("TempFile")
					[ ] // DeleteFile(sFileWithPath)
					[ ] // 
				[ ] // 
				[-] // if(QuickenWindow.Exists(20))
					[ ] // QuickenWindow.SetActive()
					[ ] // 
					[+] // // if(QuickenWindow.GetState()!=WS_MAXIMIZED)
						[ ] // // QuickenWindow.PressKeys(KEY_ALT_SPACE)
						[ ] // // QuickenWindow.TypeKeys(KEY_X)
						[ ] // // QuickenWindow.ReleaseKeys(KEY_ALT_SPACE)
					[ ] // 
					[ ] // 
					[ ] // QuickenWindow.SetActive()
					[ ] // // bResult =QuickenWindow.File.IsEnabled
					[+] // // if (bResult==FALSE)
						[ ] // // QuickenWindow.Kill()
						[ ] // // WaitForState(QuickenWindow,False,5)
						[ ] // // App_Start (sCmdLine)
						[ ] // // sleep(5)
						[ ] // // WaitForState(QuickenWindow,true,10)
						[ ] // // QuickenWindow.SetActive()
						[ ] // // 
					[+] // // do
						[ ] // // QuickenWindow.TextClick("File")
						[ ] // // // QuickenWindow.File.Click()
						[ ] // // QuickenWindow.File.NewQuickenFile.Select()
					[+] // // except
						[ ] // // QuickenWindow.MainMenu.Select("/_File/_New Quicken File...")
						[ ] // // 
					[ ] // START:
					[-] // do
						[ ] // QuickenWindow.SetActive()
						[ ] // QuickenWindow.TypeKeys(KEY_ALT_F)
						[ ] // sleep(2)
						[ ] // QuickenWindow.MainMenu.Select("/_File/_New Quicken File*")
					[+] // except
						[ ] // // LaunchQuicken()
						[ ] // // goto START
					[ ] // 
					[ ] // ////CreateNewFile Dailog will appear if the file to be created doesn't exist and a file is already open //// 
					[ ] // 
					[-] // if (CreateNewFile.Exists(2))
						[ ] // CreateNewFile.SetActive()
						[ ] // CreateNewFile.OK.Click()
						[ ] // 
						[ ] // // Alert for online payments
						[+] // if(AlertMessage.No.Exists(5))
							[ ] // AlertMessage.SetActive()
							[ ] // AlertMessage.No.Click()
						[ ] // 
						[+] // if(SyncChangesToTheQuickenCloud.Exists(3))
							[ ] // SyncChangesToTheQuickenCloud.Later.Click()
							[ ] // WaitForState(SyncChangesToTheQuickenCloud,FALSE,5)
						[ ] // WaitForState(CreateNewFile,False,1)
					[-] // if (ImportExportQuickenFile.Exists(10))
						[ ] // ImportExportQuickenFile.SetActive()
						[ ] // ImportExportQuickenFile.FileName.SetText(sFileWithPath)
						[ ] // 
						[ ] // ImportExportQuickenFile.OK.Click()
						[ ] // 
						[ ] // //Check for the already existing file
						[+] // if (ImportExportQuickenFile.DuplicateFileMsg.Exists())
							[ ] // ImportExportQuickenFile.DuplicateFileMsg.Close()
							[ ] // ImportExportQuickenFile.Cancel.Click()
							[ ] // ReportStatus("Data file existence", ABORT, "Data File {sFileName} already exists") 
						[ ] // 
						[-] // if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
							[ ] // RegisterQuickenConnectedServices()
							[ ] // bMatch=TRUE
						[ ] // 
						[+] // if (bMatch==FALSE)
							[ ] // RegisterQuickenConnectedServices()
						[ ] // QuickenWindow.SetActive()
						[ ] // sCaption = QuickenWindow.GetCaption ()
						[ ] // 
						[ ] // bFound = MatchStr("*{sFileName}*", sCaption)
						[+] // if(bFound == TRUE)
							[ ] // iFunctionResult = PASS
							[ ] // 
						[+] // else
							[ ] // iFunctionResult = FAIL
							[ ] // ReportStatus("Verify Data file name", FAIL, "Data file name actual is: {sCaption} is NOT as expected: {sFileName}.") 
						[ ] // 
						[ ] // QuickenWindow.SetActive()
					[+] // else
						[ ] // ReportStatus("Verify Create New Quicken File", FAIL, "Create New Quicken File dailog didn't appear.") 
						[ ] // iFunctionResult=FAIL
				[+] // else
					[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
					[ ] // iFunctionResult = FAIL
			[+] // else
				[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] // iFunctionResult = FAIL
				[ ] // 
		[+] // except
			[ ] // ExceptLog()
			[ ] // // QuickenWindow.Kill()
			[ ] // // WaitForState(QuickenWindow , FALSE ,5)
			[ ] // // App_Start(sCmdLine)
			[ ] // // WaitForState(QuickenWindow , TRUE ,10)
			[ ] // 
			[+] // if (ImportExportQuickenFile.Exists())
				[ ] // ImportExportQuickenFile.Close()
				[ ] // 
			[ ] // iFunctionResult = FAIL
		[ ] // 
		[ ] // return iFunctionResult
	[+] // public INTEGER AccountBarSelectForReport(STRING sAccountType,  INTEGER iRowNum)
		[-] // // Variable declaration
			[ ] // INTEGER iCounter
			[ ] // INTEGER iXCords,iYCords
			[ ] // iXCords = 64
			[ ] // iYCords = 9
		[ ] // 
		[-] // do
			[ ] // 
			[ ] // QuickenWindow.SetActive ()      
			[ ] // dockAccountBar()
			[ ] // 
			[-] // for ( iCounter = 1; iCounter<iRowNum; iCounter++)
				[ ] // //iYCords = iYCords + 20
				[ ] // iYCords = iYCords + 19  // updated by Anagha 25/04/2013
				[ ] // 
			[-] // switch(sAccountType)
				[-] // case "Banking"
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.Click(1,iXCords, iYCords)
					[ ] // iFunctionResult = PASS
				[+] // case "Rental Property"
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer2.ListBox.Click(1,iXCords, iYCords)
					[ ] // iFunctionResult = PASS
				[+] // case "Business"
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.Click(1,iXCords, iYCords)
					[ ] // iFunctionResult = PASS
				[+] // case "Investing"
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.Click(1,iXCords, iYCords)
					[ ] // iFunctionResult = PASS
				[+] // case "Property & Debt"
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.Click(1,iXCords, iYCords)
					[ ] // iFunctionResult = PASS
				[+] // case "Savings Goal"
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer6.ListBox.Click(1,iXCords, iYCords)
					[ ] // iFunctionResult = PASS
					[ ] // 
				[+] // case "Separate"
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.Click(1,iXCords, iYCords)
					[ ] // iFunctionResult = PASS
				[ ] // 
			[ ] // 
			[ ] // CloseRegisterReminderInfoPopup()
			[ ] // 
		[+] // except
			[ ] // ExceptLog()
			[ ] // iFunctionResult = FAIL
		[ ] // return iFunctionResult
	[ ] 
[ ] 
[+] // testcase test01_VerifyCurrentSpendingVsAverageSpendingByCategoryReports() appstate none //Reports
	[ ] // 
	[ ] // STRING sReport
	[+] // LIST OF STRING lsCategories = <text>
		[ ] // Auto & Transport:Car Wash
		[ ] // Bills & Utilities:Mobile Phone
		[ ] // Food & Dining:Coffee Shops
	[ ] // LIST OF STRING lsActual
	[ ] // 
	[+] // if (! QuickenWindow.Exists(5))
		[ ] // ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] // 
	[ ] // QuickenWindow.SetActive()
	[ ] // QuickenWindow.Reports.Click()
	[ ] // QuickenWindow.Reports.Comparison.Click()
	[ ] // sleep(1)
	[ ] // QuickenWindow.Reports.Comparison.CurrentVsAverageSpendingByCategory.Select()
	[ ] // 
	[+] // if (! CurrentVsAverageSpendingByCategory.Exists())
		[ ] // raise -1, "Failed to invoke CurrentVsAverageSpendingByCategory"
	[ ] // ReportStatus("CurrentVsAverageSpendingByCategory Window", PASS, "CurrentVsAverageSpendingByCategory Invoked successfully")
	[ ] // 
	[ ] // lsActual = getReportContents()
	[ ] // 
	[+] // if (verifyReport(lsActual, lsCategories))
		[ ] // ReportStatus("CurrentVsAverageSpendingByCategory Window", PASS, "Expected categories present on the report")
	[+] // else
		[ ] // ReportStatus("CurrentVsAverageSpendingByCategory Window", FAIL, "Expected categories not present on the report")
	[ ] // 
[ ] 
[+] testcase test01_VerifyCurrentSpendingVsAverageSpendingByCategoryReports() appstate none
	[ ] 
	[+] LIST OF STRING lsCategories = <text>
		[ ] Auto & Transport:Car Wash
		[ ] Bills & Utilities:Mobile Phone
		[ ] Food & Dining:Coffee Shops
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, sAccountWorksheet)
	[ ] DataFileCreate("Report001")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] 
	[ ] invokeReport("CurrentVsAverageSpendingByCategory")
	[ ] lsActual = getReportContents("CurrentVsAverageSpendingByCategory")
	[-] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("CurrentVsAverageSpendingByCategory Window", PASS, "Expected categories present on the report")
	[+] else
		[ ] ReportStatus("CurrentVsAverageSpendingByCategory Window", FAIL, "Expected categories not present on the report")
	[ ] CurrentVsAverageSpendingByCategory.Close()
[ ] 
[+] testcase test02_VerifyCurrentSpendingVsAverageSpendingByCategoryReportsAfterAddingMoreTransactions() appstate none
	[ ] 
	[+] LIST OF STRING lsCategories = <text>
		[ ] Auto & Transport:Car Wash
		[ ] Bills & Utilities:Mobile Phone
		[ ] Food & Dining:Coffee Shops
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, sAccountWorksheet)
	[ ] DataFileCreate("Report002")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] 
	[ ] invokeReport("CurrentVsAverageSpendingByCategory")
	[ ] lsActual = getReportContents("CurrentVsAverageSpendingByCategory")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("CurrentVsAverageSpendingByCategory Window", PASS, "Expected categories present on the report")
	[+] else
		[ ] ReportStatus("CurrentVsAverageSpendingByCategory Window", FAIL, "Expected categories not present on the report")
	[ ] CurrentVsAverageSpendingByCategory.Close()
	[ ] 
	[ ] // add two more transactions
	[ ] // 
	[ ] // Health & Fitness:Dentist
	[ ] 
	[ ] AddCheckingTransaction(lsTransactionData[9][1],lsTransactionData[9][2], lsTransactionData[9][3], lsDates[7],lsTransactionData[9][5],lsTransactionData[9][6],lsTransactionData[9][7],lsTransactionData[9][8])
	[ ] AddCheckingTransaction(lsTransactionData[10][1],lsTransactionData[10][2], lsTransactionData[10][3], lsDates[8],lsTransactionData[10][5],lsTransactionData[10][6],lsTransactionData[10][7],lsTransactionData[10][8])
	[ ] 
	[ ] invokeReport("CurrentVsAverageSpendingByCategory")
	[ ] lsActual = getReportContents("CurrentVsAverageSpendingByCategory")
	[+] if (verifyReport(lsActual, {lsTransactionData[9][8], lsTransactionData[10][8]}))
		[ ] ReportStatus("CurrentVsAverageSpendingByCategory Window", PASS, "Expected categories present on the report")
	[+] else
		[ ] ReportStatus("CurrentVsAverageSpendingByCategory Window", FAIL, "Expected categories not present on the report")
	[ ] CurrentVsAverageSpendingByCategory.Close()
[ ] 
[+] testcase test03_VerifyCurrentSpendingVsAverageSpendingByCategoryReportsWithDifferentDateRangeProvided() appstate none
	[ ] 
	[+] LIST OF STRING lsCategories = <text>
		[ ] Auto & Transport:Car Wash
		[ ] Bills & Utilities:Mobile Phone
		[ ] Food & Dining:Coffee Shops
		[ ] Health & Fitness:Dentist
		[ ] Entertainment:Music
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] openQuickenFile ("Report003")
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] invokeReport("CurrentVsAverageSpendingByCategory")
	[ ] CurrentVsAverageSpendingByCategory.Exists()
	[ ] CurrentVsAverageSpendingByCategory.QWCustomizeBar.PopupList1.Select("Custom dates...")
	[ ] 
	[+] if ! DlgCustomDate.Exists(5)
		[ ] raise -1, "CustomDate dialog did not exist"
	[ ] 
	[ ] DlgCustomDate.FromTextField.SetText("1/1/2014")
	[ ] DlgCustomDate.ToTextField.SetText("11/10/2014")
	[ ] DlgCustomDate.OKButton.Click()
	[ ] 
	[ ] lsActual = getReportContents("CurrentVsAverageSpendingByCategory")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("CurrentVsAverageSpendingByCategory Window", PASS, "Expected categories present on the report")
	[+] else
		[ ] ReportStatus("CurrentVsAverageSpendingByCategory Window", FAIL, "Expected categories not present on the report")
	[ ] 
	[ ] closeReport("CurrentVsAverageSpendingByCategory")
	[ ] 
[ ] 
[+] testcase test04_VerifyCurrentSpendingVsAverageSpendingByPayeeReports() appstate none
	[ ] 
	[+] LIST OF STRING lsPayees = <text>
		[ ] Payee1
		[ ] Payee2
		[ ] Payee3
		[ ] Payee4
		[ ] Payee5
		[ ] Payee6
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, sAccountWorksheet)
	[ ] DataFileCreate("Report004")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] 
	[ ] invokeReport("CurrentVsAverageSpendingByPayee")
	[ ] lsActual = getReportContents("CurrentVsAverageSpendingByPayee")
	[+] if (verifyReport(lsActual, lsPayees))
		[ ] ReportStatus("CurrentVsAverageSpendingByPayee Window", PASS, "Expected categories present on the report")
	[+] else
		[ ] ReportStatus("CurrentVsAverageSpendingByPayee Window", FAIL, "Expected categories not present on the report")
	[ ] CurrentVsAverageSpendingByPayee.Close()
[ ] 
[+] testcase test05_VerifyCurrentSpendingVsAverageSpendingByPayeeReportsAfterAddingMoreTransactions() appstate none
	[ ] 
	[+] LIST OF STRING lsPayees = <text>
		[ ] Payee1
		[ ] Payee2
		[ ] Payee3
		[ ] Payee4
		[ ] Payee5
		[ ] Payee6
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, sAccountWorksheet)
	[ ] DataFileCreate("Report005")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] 
	[ ] invokeReport("CurrentVsAverageSpendingByPayee")
	[ ] lsActual = getReportContents("CurrentVsAverageSpendingByPayee")
	[+] if (verifyReport(lsActual, lsPayees))
		[ ] ReportStatus("CurrentVsAverageSpendingByPayee Window", PASS, "Expected categories present on the report")
	[+] else
		[ ] ReportStatus("CurrentVsAverageSpendingByPayee Window", FAIL, "Expected categories not present on the report")
	[ ] CurrentVsAverageSpendingByCategory.Close()
	[ ] 
	[ ] // add two more transactions
	[ ] // 
	[ ] // Health & Fitness:Dentist
	[ ] 
	[ ] AddCheckingTransaction(lsTransactionData[9][1],lsTransactionData[9][2], lsTransactionData[9][3], lsDates[7],lsTransactionData[9][5],lsTransactionData[9][6],lsTransactionData[9][7],lsTransactionData[9][8])
	[ ] AddCheckingTransaction(lsTransactionData[10][1],lsTransactionData[10][2], lsTransactionData[10][3], lsDates[8],lsTransactionData[10][5],lsTransactionData[10][6],lsTransactionData[10][7],lsTransactionData[10][8])
	[ ] 
	[ ] invokeReport("CurrentVsAverageSpendingByPayee")
	[ ] lsActual = getReportContents("CurrentVsAverageSpendingByPayee")
	[+] if (verifyReport(lsActual, {lsTransactionData[9][6], lsTransactionData[10][6]}))
		[ ] ReportStatus("CurrentVsAverageSpendingByPayee Window", PASS, "Expected Payees present on the report")
	[+] else
		[ ] ReportStatus("CurrentVsAverageSpendingByPayee Window", FAIL, "Expected Payees not present on the report")
	[ ] CurrentVsAverageSpendingByPayee.Close()
[ ] 
[+] testcase test06_VerifyCurrentSpendingVsAverageSpendingByPayeeReportsWithDifferentDateRangeProvided() appstate none
	[ ] 
	[+] LIST OF STRING lsPayees = <text>
		[ ] Payee1
		[ ] Payee2
		[ ] Payee3
		[ ] Payee4
		[ ] Payee5
		[ ] Payee6
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] openQuickenFile ("Report006")
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] invokeReport("CurrentVsAverageSpendingByPayee")
	[ ] 
	[ ] // select dates
	[ ] CurrentVsAverageSpendingByPayee.QWCustomizeBar1.PopupList1.Select("Custom dates...")
	[ ] 
	[+] if ! DlgCustomDate.Exists(5)
		[ ] raise -1, "CustomDate dialog did not exist on CurrentVsAverageSpendingByPayee "
	[ ] 
	[ ] DlgCustomDate.FromTextField.SetText("1/1/2014")
	[ ] DlgCustomDate.ToTextField.SetText("11/10/2014")
	[ ] DlgCustomDate.OKButton.Click()
	[ ] sleep(2)
	[ ] 
	[ ] lsActual = getReportContents("CurrentVsAverageSpendingByPayee")
	[+] if (verifyReport(lsActual, lsPayees))
		[ ] ReportStatus("CurrentVsAverageSpendingByPayee Window", PASS, "Expected Payees present on the report")
	[+] else
		[ ] ReportStatus("CurrentVsAverageSpendingByPayee Window", FAIL, "Expected Payees not present on the report")
	[ ] 
	[ ] closeReport("CurrentVsAverageSpendingByPayee")
[ ] 
[+] testcase test07_VerifyCashFlowReportFunctionality() appstate none
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, "test07")
	[ ] 
	[ ] // any changes in the excel data file has to be updated in lsCategories
	[+] LIST OF STRING lsCategories = <text>
		[ ] INFLOWS
		[ ] Other Income (Business)*777
		[ ] TOTAL INFLOWS*777
		[ ] OUTFLOWS
		[ ] Auto & Transport:Car Wash
		[ ] Bills & Utilities:Mobile Phone*-100
		[ ] Food & Dining:Coffee Shops
		[ ] Health & Fitness:Dentist*-100
		[ ] Entertainment:Music*-30
		[ ] TOTAL OUTFLOWS
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] DataFileCreate("Report007")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[10][1],lsTransactionData[10][2], lsTransactionData[10][3], lsDates[10],lsTransactionData[10][5],lsTransactionData[10][6],lsTransactionData[10][7],lsTransactionData[10][8])
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] AddCheckingTransaction(lsTransactionData[9][1],lsTransactionData[9][2], lsTransactionData[9][3], lsDates[9],lsTransactionData[9][5],lsTransactionData[9][6],lsTransactionData[9][7],lsTransactionData[9][8])
	[ ] AddCheckingTransaction(lsTransactionData[11][1],lsTransactionData[11][2], lsTransactionData[11][3], lsDates[11],lsTransactionData[11][5],lsTransactionData[11][6],lsTransactionData[11][7],lsTransactionData[11][8])
	[ ] 
	[ ] invokeReport("CashFlowComparison")
	[ ] 
	[ ] lsActual = getReportContents("CashFlowComparison")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("CashFlowComparison Window", PASS, "Expected categories present on the CashFlowComparison report")
	[+] else
		[ ] ReportStatus("CashFlowComparison Window", FAIL, "Expected categories not present on the CashFlowComparison report")
	[ ] closeReport("CashFlowComparison")
[ ] 
[+] testcase test08_VerifyCashFlowReportFunctionalityWithFilter() appstate none
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, "test07")
	[ ] 
	[ ] // any changes in the QDF  file has to be updated in lsCategories
	[+] LIST OF STRING lsCategories = <text>
		[ ] Cash Flow Comparison - All Dates
		[ ] INFLOWS
		[ ] Other Income (Business)*777
		[ ] TOTAL INFLOWS*777
		[ ] OUTFLOWS
		[ ] Auto & Transport:Car Wash
		[ ] Bills & Utilities:Mobile Phone*-100
		[ ] Food & Dining:Coffee Shops
		[ ] Health & Fitness:Dentist*-100
		[ ] Entertainment:Music*-30
		[ ] TOTAL OUTFLOWS
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] openQuickenFile ("Report008")
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] invokeReport("CashFlowComparison")
	[ ] 
	[ ] CashFlowComparison.SetActive()
	[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] 
	[ ] lsActual = getReportContents("CashFlowComparison")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("CashFlowComparison Window", PASS, "Expected categories present on the CashFlowComparison report")
	[+] else
		[ ] ReportStatus("CashFlowComparison Window", FAIL, "Expected categories not present on the CashFlowComparison report")
	[ ] closeReport("CashFlowComparison")
[ ] 
[+] testcase test09_VerifyCashFlowReportAfterAddingOrRemovingAnyTransaction() appstate none
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, "test09")
	[ ] 
	[ ] // any changes in the excel data file has to be updated in lsCategories
	[+] LIST OF STRING lsCategories = <text>
		[ ] INFLOWS
		[ ] Other Income (Business)*777
		[ ] TOTAL INFLOWS*777
		[ ] OUTFLOWS
		[ ] Auto & Transport:Car Wash
		[ ] Bills & Utilities:Mobile Phone*-100
		[ ] Food & Dining:Coffee Shops
		[ ] Health & Fitness:Dentist*-100
		[ ] Entertainment:Music*-30
		[ ] TOTAL OUTFLOWS
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] DataFileCreate("Report009")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] AddCheckingTransaction(lsTransactionData[9][1],lsTransactionData[9][2], lsTransactionData[9][3], lsDates[9],lsTransactionData[9][5],lsTransactionData[9][6],lsTransactionData[9][7],lsTransactionData[9][8])
	[ ] AddCheckingTransaction(lsTransactionData[10][1],lsTransactionData[10][2], lsTransactionData[10][3], lsDates[10],lsTransactionData[10][5],lsTransactionData[10][6],lsTransactionData[10][7],lsTransactionData[10][8])
	[ ] 
	[ ] invokeReport("CashFlowComparison")
	[ ] CashFlowComparison.SetActive()
	[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] 
	[ ] lsActual = getReportContents("CashFlowComparison")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("CashFlowComparison Window", PASS, "Expected categories present on the CashFlowComparison report")
	[+] else
		[ ] ReportStatus("CashFlowComparison Window", FAIL, "Expected categories not present on the CashFlowComparison report")
	[ ] closeReport("CashFlowComparison")
	[ ] 
	[ ] // any changes in the excel data file has to be updated in lsCategories
	[+] lsCategories ={...}
		[ ] "{lsTransactionData[11][8]}"
		[ ] "{lsTransactionData[12][8]}*-"
	[ ] AddCheckingTransaction(lsTransactionData[11][1],lsTransactionData[11][2], lsTransactionData[11][3], lsDates[11],lsTransactionData[11][5],lsTransactionData[11][6],lsTransactionData[11][7],lsTransactionData[11][8])
	[ ] AddCheckingTransaction(lsTransactionData[12][1],lsTransactionData[12][2], lsTransactionData[12][3], lsDates[12],lsTransactionData[12][5],lsTransactionData[12][6],lsTransactionData[12][7],lsTransactionData[12][8])
	[ ] 
	[ ] invokeReport("CashFlowComparison")
	[ ] CashFlowComparison.SetActive()
	[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] 
	[ ] lsActual = getReportContents("CashFlowComparison")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("CashFlowComparison Window", PASS, "Expected categories present on the CashFlowComparison report")
	[+] else
		[ ] ReportStatus("CashFlowComparison Window", FAIL, "Expected categories not present on the CashFlowComparison report")
	[ ] closeReport("CashFlowComparison")
	[ ] 
	[ ] deleteTransaction("MDI",lsTransactionData[7][8])
	[ ] deleteTransaction("MDI",lsTransactionData[11][8])
	[ ] 
	[ ] invokeReport("CashFlowComparison")
	[ ] CashFlowComparison.SetActive()
	[ ] CashFlowComparison.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] lsActual = getReportContents("CashFlowComparison")
	[ ] 
	[+] if ! (isCategoryExist(lsActual, lsTransactionData[7][8]))
		[ ] ReportStatus("CashFlowComparison Window", PASS, "Category [{lsTransactionData[7][8]}] not found on the report")
	[+] else
		[ ] ReportStatus("CashFlowComparison Window", FAIL, "Category [{lsTransactionData[7][8]}] found on the report even after deleting the transaction")
	[ ] 
	[+] if ! (isCategoryExist(lsActual, lsTransactionData[11][8]))
		[ ] ReportStatus("CashFlowComparison Window", PASS, "Category [{lsTransactionData[11][8]}] not found on the report")
	[+] else
		[ ] ReportStatus("CashFlowComparison Window", FAIL, "Category [{lsTransactionData[11][8]}] found on the report even after deleting the transaction")
	[ ] closeReport("CashFlowComparison")
[ ] 
[+] testcase test10_VerifyIncomeAndExpenseComparisionByCategoryReport() appstate none
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, "test10")
	[ ] 
	[ ] // any changes in the excel data file has to be updated in lsCategories
	[+] LIST OF STRING lsCategories = <text>
		[ ] Income/Expense Comparison by Category
		[ ] INCOME
		[ ] TOTAL INCOME*888
		[ ] EXPENSES
		[ ] Health & Fitness:Dentist*100
		[ ] Entertainment:Music*30
		[ ] TOTAL EXPENSES*
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] DataFileCreate("Report010")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[10][1],lsTransactionData[10][2], lsTransactionData[10][3], lsDates[10],lsTransactionData[10][5],lsTransactionData[10][6],lsTransactionData[10][7],lsTransactionData[10][8])
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] AddCheckingTransaction(lsTransactionData[9][1],lsTransactionData[9][2], lsTransactionData[9][3], lsDates[9],lsTransactionData[9][5],lsTransactionData[9][6],lsTransactionData[9][7],lsTransactionData[9][8])
	[ ] AddCheckingTransaction(lsTransactionData[11][1],lsTransactionData[11][2], lsTransactionData[11][3], lsDates[11],lsTransactionData[11][5],lsTransactionData[11][6],lsTransactionData[11][7],lsTransactionData[11][8])
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByC")
	[ ] 
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByC")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("IncomeExpenseComparisonByCategory Window", PASS, "Expected categories present on the IncomeExpenseComparisonByCategory report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByCategory Window", FAIL, "Expected categories not present on the IncomeExpenseComparisonByCategory report")
	[ ] closeReport("IncomeExpenseComparisonByC")
[ ] 
[+] testcase test11_VerifyIncomeAndExpenseComparisionByCategoryReportWithDateFilter() appstate none
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, "test10")
	[ ] 
	[ ] // any changes in the excel data file has to be updated in lsCategories
	[+] LIST OF STRING lsCategories = <text>
		[ ] Income/Expense Comparison by Category
		[ ] *through 3/11/2015 (Cash Basis)
		[ ] INCOME
		[ ] TOTAL INCOME*888
		[ ] EXPENSES
		[ ] Health & Fitness:Dentist*100
		[ ] Entertainment:Music*30
		[ ] TOTAL EXPENSES*
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] openQuickenFile ("Report011")
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByC")
	[ ] IncomeExpenseComparisonByC.QWCustomizeBar1.PopupList1.Select("Custom dates...")
	[ ] sleep(2)
	[+] if ! DlgCustomDate.Exists(5)
		[ ] raise -1, "CustomDate dialog did not exist"
	[ ] 
	[ ] DlgCustomDate.FromTextField.SetText("1/1/2015")
	[ ] DlgCustomDate.ToTextField.SetText("3/11/2015")
	[ ] DlgCustomDate.OKButton.Click()
	[ ] sleep(2)
	[ ] 
	[ ] 
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByC")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("IncomeExpenseComparisonByCategory Window", PASS, "Expected categories present on the IncomeExpenseComparisonByCategory report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByCategory Window", FAIL, "Expected categories not present on the IncomeExpenseComparisonByCategory report")
	[ ] closeReport("IncomeExpenseComparisonByC")
[ ] 
[+] testcase test12_VerifyIncomeAndExpenseComparisionByPayeeReport() appstate none
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, "test12")
	[ ] 
	[ ] // any changes in the excel data file has to be updated in lsCategories
	[+] LIST OF STRING lsPayees = <text>
		[ ] Income/Expense Comparison by Payee
		[ ] INCOME
		[ ] TOTAL INCOME*888
		[ ] EXPENSES
		[ ] Payee2
		[ ] Payee3
		[ ] Payee4
		[ ] Payee5
		[ ] Payee6
		[ ] TOTAL EXPENSES*
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] DataFileCreate("Report012")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[10][1],lsTransactionData[10][2], lsTransactionData[10][3], lsDates[10],lsTransactionData[10][5],lsTransactionData[10][6],lsTransactionData[10][7],lsTransactionData[10][8])
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] AddCheckingTransaction(lsTransactionData[9][1],lsTransactionData[9][2], lsTransactionData[9][3], lsDates[9],lsTransactionData[9][5],lsTransactionData[9][6],lsTransactionData[9][7],lsTransactionData[9][8])
	[ ] AddCheckingTransaction(lsTransactionData[11][1],lsTransactionData[11][2], lsTransactionData[11][3], lsDates[11],lsTransactionData[11][5],lsTransactionData[11][6],lsTransactionData[11][7],lsTransactionData[11][8])
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByP")
	[ ] 
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByP")
	[+] if (verifyReport(lsActual, lsPayees))
		[ ] ReportStatus("IncomeExpenseComparisonByPayees Window", PASS, "Expected categories present on the IncomeExpenseComparisonByPayees report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByPayees Window", FAIL, "Expected categories not present on the IncomeExpenseComparisonByPayees report")
	[ ] closeReport("IncomeExpenseComparisonByP")
[ ] 
[+] testcase test13_VerifyIncomeAndExpenseComparisionByPayeeReportWithDateFilter() appstate none
	[ ] 
	[ ] 
	[ ] // any changes in the QDF file has to be updated in lsPayees
	[+] LIST OF STRING lsPayees = <text>
		[ ] Income/Expense Comparison by Payee
		[ ] Payee*1/1/2015- 3/12/2015
		[ ] INCOME
		[ ] Dep1*333
		[ ] Dep2*444
		[ ] Dep3*111
		[ ] TOTAL INCOME*888
		[ ] EXPENSES
		[ ] Payee1*100
		[ ] Payee2*10
		[ ] Payee3*115
		[ ] Payee4*70
		[ ] Payee5*25
		[ ] Payee6*30
		[ ] TOTAL EXPENSES*.00
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] openQuickenFile ("Report013")
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByP")
	[ ] IncomeExpenseComparisonByP.QWCustomizeBar1.PopupList1.Select("Custom dates...")
	[ ] sleep(2)
	[+] if ! DlgCustomDate.Exists(5)
		[ ] raise -1, "CustomDate dialog did not exist"
	[ ] 
	[ ] DlgCustomDate.FromTextField.SetText("1/1/2015")
	[ ] DlgCustomDate.ToTextField.SetText("3/12/2015")
	[ ] DlgCustomDate.OKButton.Click()
	[ ] sleep(2)
	[ ] 
	[ ] 
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByP")
	[+] if (verifyReport(lsActual, lsPayees))
		[ ] ReportStatus("IncomeExpenseComparisonByPayee Window", PASS, "Expected Payees present on the IncomeExpenseComparisonByPayee report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByPayee Window", FAIL, "Expected Payees not present on the IncomeExpenseComparisonByPayee report")
	[ ] closeReport("IncomeExpenseComparisonByP")
[ ] 
[+] testcase test14_VerifyIncomeAndExpenseComparisionByPayeeReportAfterAddingAndRemovingTransactions() appstate none
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, "test14")
	[ ] 
	[ ] // any changes in the QDF file has to be updated in lsPayees
	[+] LIST OF STRING lsPayees = <text>
		[ ] Income/Expense Comparison by Payee - All Dates
		[ ] INCOME
		[ ] Dep1*333
		[ ] Dep2*444
		[ ] TOTAL INCOME*777
		[ ] EXPENSES
		[ ] Payee2
		[ ] Payee3
		[ ] Payee4
		[ ] Payee5
		[ ] Payee6
		[ ] TOTAL EXPENSES*.00
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] DataFileCreate("Report014")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] AddCheckingTransaction(lsTransactionData[9][1],lsTransactionData[9][2], lsTransactionData[9][3], lsDates[9],lsTransactionData[9][5],lsTransactionData[9][6],lsTransactionData[9][7],lsTransactionData[9][8])
	[ ] AddCheckingTransaction(lsTransactionData[10][1],lsTransactionData[10][2], lsTransactionData[10][3], lsDates[10],lsTransactionData[10][5],lsTransactionData[10][6],lsTransactionData[10][7],lsTransactionData[10][8])
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByP")
	[ ] IncomeExpenseComparisonByP.SetActive()
	[ ] IncomeExpenseComparisonByP.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] 
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByP")
	[+] if (verifyReport(lsActual, lsPayees))
		[ ] ReportStatus("IncomeExpenseComparisonByP Window", PASS, "Expected categories present on the IncomeExpenseComparisonByPayee report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByP Window", FAIL, "Expected categories not present on the IncomeExpenseComparisonByPayee report")
	[ ] closeReport("IncomeExpenseComparisonByP")
	[ ] 
	[ ] // any changes in the excel data file has to be updated in lsCategories
	[+] lsPayees ={...}
		[ ] "{lsTransactionData[11][6]}"
		[ ] "{lsTransactionData[12][6]}*-"
	[ ] AddCheckingTransaction(lsTransactionData[11][1],lsTransactionData[11][2], lsTransactionData[11][3], lsDates[11],lsTransactionData[11][5],lsTransactionData[11][6],lsTransactionData[11][7],lsTransactionData[11][8])
	[ ] AddCheckingTransaction(lsTransactionData[12][1],lsTransactionData[12][2], lsTransactionData[12][3], lsDates[12],lsTransactionData[12][5],lsTransactionData[12][6],lsTransactionData[12][7],lsTransactionData[12][8])
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByP")
	[ ] IncomeExpenseComparisonByP.SetActive()
	[ ] IncomeExpenseComparisonByP.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] 
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByP")
	[+] if (verifyReport(lsActual, lsPayees))
		[ ] ReportStatus("IncomeExpenseComparisonByP Window", PASS, "Expected payees present on the IncomeExpenseComparisonByPayee report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByP Window", FAIL, "Expected Payees not present on the IncomeExpenseComparisonByPayee report")
	[ ] closeReport("IncomeExpenseComparisonByP")
	[ ] 
	[ ] deleteTransaction("MDI",lsTransactionData[7][6])
	[ ] deleteTransaction("MDI",lsTransactionData[11][6])
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByP")
	[ ] IncomeExpenseComparisonByP.SetActive()
	[ ] IncomeExpenseComparisonByP.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByP")
	[ ] 
	[+] if ! (isCategoryExist(lsActual, lsTransactionData[7][8]))
		[ ] ReportStatus("IncomeExpenseComparisonByP Window", PASS, "Deleted Payee [{lsTransactionData[7][6]}] not found on the report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByP Window", FAIL, "Deleted Payee [{lsTransactionData[7][6]}] found on the report even after deleting the transaction")
	[ ] 
	[+] if ! (isCategoryExist(lsActual, lsTransactionData[11][8]))
		[ ] ReportStatus("IncomeExpenseComparisonByP Window", PASS, "Deleted Payee [{lsTransactionData[11][6]}] not found on the report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByP Window", FAIL, "Deleted Payee [{lsTransactionData[11][6]}] found on the report even after deleting the transaction")
	[ ] closeReport("IncomeExpenseComparisonByP")
[ ] 
[+] testcase test15_VerifyIncomeAndExpenseComparisionByCategoryReportAfterAddingAndRemovingTransactions() appstate none
	[ ] 
	[ ] LIST OF ANYTYPE lsTransactionData=ReadExcelTable(sReportsDataExcel, "test15")
	[ ] 
	[ ] // any changes in the QDF file has to be updated in lsCategories
	[+] LIST OF STRING lsCategories = <text>
		[ ] Income/Expense Comparison by Category - All Dates
		[ ] Category
		[ ] INCOME
		[ ] Other Income (Business)*777
		[ ] TOTAL INCOME*777
		[ ] EXPENSES
		[ ] Auto & Transport:Car Wash*45
		[ ] Bills & Utilities:Mobile Phone*100
		[ ] Entertainment:Music*30
		[ ] Food & Dining:Coffee Shops*50
		[ ] Health & Fitness:Dentist*100
		[ ] TOTAL EXPENSES*.00
	[ ] LIST OF STRING lsActual
	[ ] 
	[ ] // DataFileCreate("Report015")
	[ ] LIST OF STRING lsDates = getReportDatesFromCurrent()
	[ ] AddManualSpendingAccount("Checking", "Checking 01 Account","9876.54", FormatDateTime(GetDateTime(),"m/d/yyyy"))
	[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
	[ ] 
	[ ] // add transactions
	[ ] AddCheckingTransaction(lsTransactionData[1][1],lsTransactionData[1][2], lsTransactionData[1][3], lsDates[1],lsTransactionData[1][5],lsTransactionData[1][6],lsTransactionData[1][7],lsTransactionData[1][8])
	[ ] AddCheckingTransaction(lsTransactionData[2][1],lsTransactionData[2][2], lsTransactionData[2][3], lsDates[2],lsTransactionData[2][5],lsTransactionData[2][6],lsTransactionData[2][7],lsTransactionData[2][8])
	[ ] AddCheckingTransaction(lsTransactionData[3][1],lsTransactionData[3][2], lsTransactionData[3][3], lsDates[3],lsTransactionData[3][5],lsTransactionData[3][6],lsTransactionData[3][7],lsTransactionData[3][8])
	[ ] AddCheckingTransaction(lsTransactionData[4][1],lsTransactionData[4][2], lsTransactionData[4][3], lsDates[4],lsTransactionData[4][5],lsTransactionData[4][6],lsTransactionData[4][7],lsTransactionData[4][8])
	[ ] AddCheckingTransaction(lsTransactionData[5][1],lsTransactionData[5][2], lsTransactionData[5][3], lsDates[5],lsTransactionData[5][5],lsTransactionData[5][6],lsTransactionData[5][7],lsTransactionData[5][8])
	[ ] AddCheckingTransaction(lsTransactionData[6][1],lsTransactionData[6][2], lsTransactionData[6][3], lsDates[6],lsTransactionData[6][5],lsTransactionData[6][6],lsTransactionData[6][7],lsTransactionData[6][8])
	[ ] AddCheckingTransaction(lsTransactionData[7][1],lsTransactionData[7][2], lsTransactionData[7][3], lsDates[7],lsTransactionData[7][5],lsTransactionData[7][6],lsTransactionData[7][7],lsTransactionData[7][8])
	[ ] AddCheckingTransaction(lsTransactionData[8][1],lsTransactionData[8][2], lsTransactionData[8][3], lsDates[8],lsTransactionData[8][5],lsTransactionData[8][6],lsTransactionData[8][7],lsTransactionData[8][8])
	[ ] AddCheckingTransaction(lsTransactionData[9][1],lsTransactionData[9][2], lsTransactionData[9][3], lsDates[9],lsTransactionData[9][5],lsTransactionData[9][6],lsTransactionData[9][7],lsTransactionData[9][8])
	[ ] AddCheckingTransaction(lsTransactionData[10][1],lsTransactionData[10][2], lsTransactionData[10][3], lsDates[10],lsTransactionData[10][5],lsTransactionData[10][6],lsTransactionData[10][7],lsTransactionData[10][8])
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByC")
	[ ] IncomeExpenseComparisonByC.SetActive()
	[ ] IncomeExpenseComparisonByC.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] 
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByC")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("IncomeExpenseComparisonByC Window", PASS, "Expected categories present on the IncomeExpenseComparisonByCategory report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByP Window", FAIL, "Expected categories not present on the IncomeExpenseComparisonByCategory report")
	[ ] closeReport("IncomeExpenseComparisonByC")
	[ ] 
	[ ] // any changes in the excel data file has to be updated in lsCategories
	[+] lsCategories ={...}
		[ ] "{lsTransactionData[11][8]}"
		[ ] "{lsTransactionData[12][8]}*-"
	[ ] AddCheckingTransaction(lsTransactionData[11][1],lsTransactionData[11][2], lsTransactionData[11][3], lsDates[11],lsTransactionData[11][5],lsTransactionData[11][6],lsTransactionData[11][7],lsTransactionData[11][8])
	[ ] AddCheckingTransaction(lsTransactionData[12][1],lsTransactionData[12][2], lsTransactionData[12][3], lsDates[12],lsTransactionData[12][5],lsTransactionData[12][6],lsTransactionData[12][7],lsTransactionData[12][8])
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByC")
	[ ] IncomeExpenseComparisonByC.SetActive()
	[ ] IncomeExpenseComparisonByC.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] 
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByC")
	[+] if (verifyReport(lsActual, lsCategories))
		[ ] ReportStatus("IncomeExpenseComparisonByC Window", PASS, "Expected Categories present on the IncomeExpenseComparisonByCategory report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByC Window", FAIL, "Expected Categories not present on the IncomeExpenseComparisonByCategory report")
	[ ] closeReport("IncomeExpenseComparisonByC")
	[ ] 
	[ ] deleteTransaction("MDI",lsTransactionData[7][6])
	[ ] deleteTransaction("MDI",lsTransactionData[11][6])
	[ ] 
	[ ] invokeReport("IncomeExpenseComparisonByC")
	[ ] IncomeExpenseComparisonByC.SetActive()
	[ ] IncomeExpenseComparisonByC.QWCustomizeBar1.PopupList1.Select("Include all dates")
	[ ] sleep(2) // wait for refresh to happen
	[ ] lsActual = getReportContents("IncomeExpenseComparisonByC")
	[ ] 
	[+] if ! (isCategoryExist(lsActual, lsTransactionData[7][8]))
		[ ] ReportStatus("IncomeExpenseComparisonByC Window", PASS, "Deleted Category [{lsTransactionData[7][6]}] not found on the report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByC Window", FAIL, "Deleted Category [{lsTransactionData[7][6]}] found on the report")
	[ ] 
	[+] if ! (isCategoryExist(lsActual, lsTransactionData[11][8]))
		[ ] ReportStatus("IncomeExpenseComparisonByC Window", PASS, "Deleted Category [{lsTransactionData[11][6]}] not found on the report")
	[+] else
		[ ] ReportStatus("IncomeExpenseComparisonByC Window", FAIL, "Deleted Category [{lsTransactionData[11][6]}] found on the report")
	[ ] closeReport("IncomeExpenseComparisonByC")
[ ] 
