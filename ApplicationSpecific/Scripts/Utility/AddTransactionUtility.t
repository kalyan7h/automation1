[-] // Global variables used for AddAccountsUtility
	[ ] public STRING sFileName = "AddAccountsandTransaction"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sValidateLogFolder = "{APP_PATH}\Data\TestData\ValidateLog"
[ ] 
[ ] 
[-] testcase AddTransactions () appstate none				// testcase for adding accounts and transactions
	[-] // Variable Declaration
		[ ] STRING sTransactionData = "AddTransactions.xls"
		[ ] STRING sTransactionWorkSheet = "Transaction_Data"
		[ ] STRING sAccountsData = "AddManualSpendingAccounts.xls"
		[ ] STRING sAccountsWorkSheet = "Accounts"
		[ ] 
		[ ] INTEGER iCreateDataFile, iSetupAutoAPI, iAddSpendingAccounts, iAddTransactions
		[ ] STRING sDataLogPath, sDate, sCmdLine, sPopUpWindow, sMDIWindow, sWindowType
		[ ] 
		[ ] sDataLogPath = USERPROFILE + "\Application Data\Intuit\Quicken\Log\DATA_LOG.TXT"
		[ ] Datetime dTime = GetDateTime()
		[ ] sDate = FormatDateTime(dTime, "mm_dd_yy")
		[ ] sCmdLine = "{QUICKEN_ROOT}\qw.exe"
		[ ] sPopUpWindow = "PopUp"
		[ ] sMDIWindow = "MDI"
		[ ] 
	[ ] 
	[+] // Perform Setup activities
		[+] if(QuickenMainWindow.Exists())
			[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
			[ ] QuickenMainWindow.SetActive()
			[ ] QuickenMainWindow.Exit()
		[ ] 
		[ ] sleep(SHORT_SLEEP)
		[ ] 
		[+] if(FileExists(sDataFile))
			[ ] DeleteFile(sDataFile)
		[ ] 
		[+] if(FileExists(sTestCaseStatusFile))
			[ ] DeleteFile(sTestCaseStatusFile)
		[ ] 
		[ ] //Load O/S specific paths
		[ ] LoadOSDependency()
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[ ] // Launch Quicken
	[+] if (!QuickenMainWindow.Exists ())
		[ ] QuickenMainWindow.Start (sCmdLine)
	[ ] 
	[+] if (QuickenMainWindow.Exists(MEDIUM_SLEEP) == TRUE)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Status If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
		[ ] 
		[ ] // Report Status If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] 
		[ ] // Report Status If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
		[ ] 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] // Add Accounts based on input XLS
	[-] if(QuickenMainWindow.Exists(SHORT_SLEEP) == TRUE)
		[ ] QuickenMainWindow.SetActive()
		[-] if(QuickenMainWindow.View.UsePopUpRegisters.IsChecked() == TRUE)
			[ ] sWindowType = sPopUpWindow
		[-] else
			[ ] sWindowType = sMDIWindow
		[ ] 
		[ ] iAddSpendingAccounts = AddSpendingAccount(sAccountsData, sAccountsWorkSheet)
		[-] if(iAddSpendingAccounts == PASS)
			[ ] ReportStatus("Add Accounts Utility", iAddSpendingAccounts, "Utility is executed successfully") 
			[ ] iAddTransactions = AddTransactionGeneric(sWindowType, sTransactionData, sTransactionWorkSheet)
			[+] if(iAddTransactions == PASS)
				[ ] ReportStatus("Add Transactions Utility", iAddTransactions, "Utility is executed successfully") 
			[ ] 
			[+] else
				[ ] ReportStatus("Add Transactions Utility", iAddTransactions, "Utility is not executed successfully") 
		[ ] 
		[-] else
			[ ] ReportStatus("Add Accounts Utility", iAddSpendingAccounts, "Utility is not executed successfully") 
		[ ] 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
[ ] 
[ ] // 
[ ] // ==========================================================
[+] // FUNCTION: AddTransactionGeneric()
	[ ] //
	[ ] // DESCRIPTION:		This function will add Transaction to different accounts.
	[ ] // 
	[ ] //
	[ ] // PARAMETERS:		STRING 	sWindowType			MDI or Popup
	[ ] //						STRING 	sDataFile				Data file name
	[ ] //						STRING 	sWorkSheet			Worksheet name
	[ ] //
	[ ] // RETURNS:			None
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //  March 22, 2011		Mamta Jain created
[ ] // ==========================================================
[-] // public INTEGER AddTransactionGeneric(STRING sWindowType, STRING sDataFile, STRING sWorkSheet)
	[ ] // 
	[-] // // Variable declaration
		[ ] // BOOLEAN bFlag, bMatch, bAccountFound
		[ ] // INTEGER iFunctionResult, iSelect, iCount, i, j, iRowCount
		[ ] // STRING sActual, sErrorMsg, sHandle, sAccountName, sSplitWorkSheet
		[ ] // LIST of STRING lsTransactionData
		[ ] // LIST of ANYTYPE lsExcelData, lList
		[ ] // 
		[ ] // sSplitWorkSheet = "Split_Data"
		[ ] // bAccountFound = FALSE
		[ ] // 
	[-] // do
		[ ] // // Read data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sDataFile, sWorkSheet)
		[ ] // 
		[ ] // QuickenMainWindow.SetActive ()
		[ ] // 
		[-] // if(sWindowType == "MDI")
			[ ] // // For Premier and Deluxe SKU's, tag column is not selected. Include the tag column from Account Settings options.
			[+] // // if(SKU_TOBE_TESTED == "PREMIER" || SKU_TOBE_TESTED == "DELUXE")		// In R8 build, Tag column is by default selected
				[ ] // // BankingMDI.AccountActions.Click ()
				[ ] // // BankingMDI.AccountActions.TypeKeys(  Replicate (KEY_DN, 16)) 
				[ ] // // BankingMDI.AccountActions.TypeKeys(KEY_ENTER)
				[ ] // // MDICalloutHolder.SetActive ()
				[ ] // // MDICalloutHolder.CalloutPopup.Tag.Click (1, 12, 12)
				[ ] // // MDICalloutHolder.CalloutPopup.Done.Click (1, 29, 11)
		[ ] // 
		[+] // else if(sWindowType == "PopUp")
			[ ] // // For Premier and Deluxe SKU's, tag column is not selected. Include the tag column from Account Settings options.
			[+] // // if(SKU_TOBE_TESTED == "PREMIER" || SKU_TOBE_TESTED == "DELUXE")
				[ ] // // BankingPopUp.AccountActions.Click ()
				[ ] // // BankingPopUp.AccountActions.TypeKeys(  Replicate (KEY_DN, 16)) 
				[ ] // // BankingPopUp.AccountActions.TypeKeys(KEY_ENTER)
				[ ] // // PopUpCalloutHolder.SetActive ()
				[ ] // // PopUpCalloutHolder.CalloutPopup.Tag.Click (1, 12, 12)
				[ ] // // PopUpCalloutHolder.CalloutPopup.Done.Click (1, 29, 11)
			[ ] // 
		[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Window type", WARN, "{sWindowType} not found")
		[ ] // 
		[ ] // iCount = ListCount(lsExcelData)			// Get the row count
		[-] // for (i = 1; i<=iCount; i++)
			[ ] // print(i)
			[ ] // bFlag = FALSE
			[ ] // bAccountFound = FALSE
			[ ] // 
			[ ] // // Fetch rows from the given sheet
			[ ] // lsTransactionData=lsExcelData[i]
			[+] // if(IsNULL(lsTransactionData[1]))
				[ ] // lsTransactionData[1] = ""
			[+] // if(IsNULL(lsTransactionData[2]))
				[ ] // lsTransactionData[2] = ""
			[+] // if(IsNULL(lsTransactionData[3]))
				[ ] // lsTransactionData[3] = ""
				[ ] // 
			[+] // if(IsNULL(lsTransactionData[4]))
				[ ] // lsTransactionData[4] = ""
			[+] // if( IsNULL(lsTransactionData[5]))
				[ ] // lsTransactionData[5] = ""
			[+] // if(IsNULL(lsTransactionData[6]))
				[ ] // lsTransactionData[6] = ""
			[+] // if(IsNULL(lsTransactionData[7]))
				[ ] // lsTransactionData[7] = ""
			[+] // if(IsNULL(lsTransactionData[8]))
				[ ] // lsTransactionData[8] = ""
			[+] // if(IsNULL(lsTransactionData[9]))
				[ ] // lsTransactionData[9] = ""
			[+] // if(IsNULL(lsTransactionData[10]))
				[ ] // lsTransactionData[10] = ""
			[+] // if(IsNULL(lsTransactionData[11]))
				[ ] // lsTransactionData[11] = ""
			[+] // if(IsNULL(lsTransactionData[12]))
				[ ] // lsTransactionData[12] = ""
			[ ] // 
			[+] // if(lsTransactionData[1] == ACCOUNT_BANKING)		// if Account type is Banking
				[-] // if( QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.Exists() == TRUE)
					[ ] // iRowCount = QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()		// Get no. of accounts
					[ ] // sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())	// get handle
					[-] // for(j = 0; j<iRowCount; j++)
						[ ] // sAccountName = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(j))
						[ ] // bMatch = MatchStr("*{lsTransactionData[2]}*", sAccountName)
						[-] // if(bMatch == TRUE)
							[ ] // AccountBarSelect(ACCOUNT_BANKING, j)			// Select Account from account bar
							[ ] // bAccountFound = TRUE
							[ ] // break
						[-] // else
							[ ] // continue
				[ ] // 
				[-] // else
					[ ] // ReportStatus("Validate Account Type", FAIL, "Account Type- {lsTransactionData[1]} not found")
				[ ] // 
			[ ] // 
			[-] // if(lsTransactionData[1] == ACCOUNT_RENTALPROPERTY)		// if account type is Rental property
				[-] // if( QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer2.ListBox1.Exists() == TRUE)
					[ ] // iRowCount = QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer2.ListBox1.GetItemCount()		// get no. of accounts
					[ ] // sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer2.ListBox1.GetHandle())		// get handle
					[-] // for(j = 0; j<iRowCount; j++)
						[ ] // sAccountName = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(j))
						[ ] // bMatch = MatchStr("*{lsTransactionData[2]}*", sAccountName)
						[-] // if(bMatch == TRUE)
							[ ] // AccountBarSelect(ACCOUNT_RENTALPROPERTY, j)			// Select Account from account bar
							[ ] // bAccountFound = TRUE
							[ ] // break
						[-] // else
							[ ] // continue
				[ ] // 
				[+] // else
					[ ] // ReportStatus("Validate Account Type", FAIL, "Account Type- {lsTransactionData[1]} not found")
			[ ] // 
			[+] // // if(lsTransactionData[1] == ACCOUNT_BUSINESS)			// if account type is Business
				[-] // // if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox1.Exists() == TRUE)
					[ ] // // iRowCount = QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox1.GetItemCount()		// get the no. of accounts
					[ ] // // sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox1.GetHandle())		// get handle
					[-] // // for(j = 0; j<iRowCount; j++)
						[ ] // // sAccountName = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(j))
						[ ] // // bMatch = MatchStr("*{lsTransactionData[2]}*", sAccountName)
						[-] // // if(bMatch == TRUE)
							[ ] // // AccountBarSelect(ACCOUNT_BUSINESS, j)			// Select Account from account bar
							[ ] // // bAccountFound = TRUE
							[ ] // // break
						[-] // // else
							[ ] // // continue
				[ ] // // 
				[+] // // else
					[ ] // // ReportStatus("Validate Account Type", FAIL, "Account Type- {lsTransactionData[1]} not found")
				[ ] // // 
			[ ] // // 
			[+] // if(lsTransactionData[1] == ACCOUNT_PROPERTYDEBT)		// if account type is Property and debt
				[+] // if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox1.Exists() == TRUE)
					[ ] // iRowCount = QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox1.GetItemCount()		// get no. of accounts
					[ ] // sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox1.GetHandle())		// get handle
					[+] // for(j = 0; j<iRowCount; j++)
						[ ] // sAccountName = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(j))
						[ ] // bMatch = MatchStr("*{lsTransactionData[2]}*", sAccountName)
						[-] // if(bMatch == TRUE)
							[ ] // AccountBarSelect(ACCOUNT_PROPERTYDEBT, j)			// Select Account from account bar
							[ ] // bAccountFound = TRUE
							[ ] // break
						[-] // else
							[ ] // continue
				[ ] // 
				[-] // else
					[ ] // ReportStatus("Validate Account Type", FAIL, "Account Type- {lsTransactionData[1]} not found")
			[ ] // 
			[-] // if(bAccountFound == TRUE)		// if account found then add transaction
				[ ] // 
				[-] // switch(sWindowType)
					[+] // case("MDI")
						[ ] // BankingMDI.VerifyEnabled(TRUE, 20)
						[ ] // BankingMDI.SetActive ()
						[ ] // BankingMDI.TypeKeys("<Ctrl-n>")			// Go to the new line
						[ ] // 
						[+] // if(MessageBox.Exists(SHORT_SLEEP))			// if any trnsaction is already present, then on adding new transaction it saks for save the old transaction.
							[ ] // MessageBox.SetActive()
							[ ] // sErrorMsg = MessageBox.ErrorMsg.GetText()
							[ ] // ReportStatus("Validate Error Meassage", WARN, "Error Message - '{sErrorMsg}' is observed")
							[ ] // MessageBox.No.Click()
							[ ] // 
						[ ] // 
						[+] // //switch(lsTransactionData[11])
							[ ] // //case("Payment")
						[-] // if (lsTransactionData[4] != "")
							[ ] // BankingMDI.TxList.TypeKeys (lsTransactionData[4])    // enter date
						[ ] // BankingMDI.TxList.TypeKeys(KEY_TAB)
						[+] // if(MessageBox.Exists(SHORT_SLEEP))				// for invalid date, error message is displayed.
							[ ] // bFlag = TRUE
							[ ] // break
						[ ] // 
						[+] // if(lsTransactionData[3] == "Yes")
							[-] // if(lsTransactionData[5] != "")				// enter cheque no.
								[ ] // BankingMDI.TxList.TypeKeys (lsTransactionData[5])
							[ ] // BankingMDI.TxList.TypeKeys(KEY_TAB)
						[ ] // 
						[-] // if(lsTransactionData[6] != "")				// enter payee name
							[ ] // BankingMDI.TxList.TypeKeys (lsTransactionData[6])
						[ ] // BankingMDI.TxList.TypeKeys(KEY_TAB)		
						[-] // if(lsTransactionData[7] != "")							// enter memo
							[ ] // BankingMDI.TxList.TypeKeys (lsTransactionData[7])
						[ ] // BankingMDI.TxList.TypeKeys(KEY_TAB)			 
						[-] // if(lsTransactionData[8] != "")							// enter category
							[ ] // BankingMDI.TxList.TypeKeys (lsTransactionData[8])
						[ ] // BankingMDI.TxList.TypeKeys(KEY_TAB)
						[ ] // 
						[+] // if(MessageBox.Exists())				// for invalid category error message is disaplyed
							[ ] // bFlag = TRUE
							[ ] // break
						[+] // if(NewCategory.Exists())				// for new category, prompt for adding new category
							[ ] // NewCategory.SetActive()
							[ ] // NewCategory.Yes.Click()
							[ ] // 
							[ ] // 
							[-] // if(SetUpCategoryMDI.Exists())
								[ ] // SetUpCategoryMDI.SetActive()
								[ ] // SetUpCategoryMDI.OK.Click()
								[-] // if(MessageBox.Exists(SHORT_SLEEP))				// for invalid category, error message is displayed in Creating new category
									[ ] // MessageBox.SetActive()
									[ ] // sErrorMsg = MessageBox.ErrorMsg.GetText()
									[ ] // ReportStatus("Validate Error Meassage", WARN, "Error Message - '{sErrorMsg}' is observed")
									[ ] // MessageBox.OK.Click()
									[ ] // SetUpCategoryMDI.Close()
									[ ] // break
						[ ] // 
						[-] // if(lsTransactionData[9] != "")					// enter tag
							[ ] // BankingMDI.TxList.TypeKeys (lsTransactionData[9])
						[ ] // BankingMDI.TxList.TypeKeys(KEY_TAB)
						[ ] // 
						[+] // if(MessageBox.Exists())					// for invalid tag, error message is displayed
							[ ] // bFlag = TRUE
							[ ] // break
						[-] // if(NewTagMDI.Exists())					// for new tag, prompts for adding new tag
							[ ] // NewTagMDI.SetActive()
							[ ] // NewTagMDI.OK.Click()
						[ ] // 
						[-] // if(lsTransactionData[11] == "Type 2")
							[ ] // BankingMDI.TxList.TypeKeys(KEY_TAB)
						[ ] // 
						[-] // if (lsTransactionData[10] != "")				// enter amount
							[ ] // BankingMDI.TxList.TypeKeys (lsTransactionData[10])
						[ ] // 
						[ ] // sleep(SHORT_SLEEP)
						[ ] // 
						[+] // if(lsTransactionData[12] == "Yes")
							[ ] // SplitTransaction(sWindowType, sDataFile, sSplitWorkSheet, Str(i))
						[ ] // 
						[ ] // BankingMDI.TxList.TxToolbar.Save.Click()
						[ ] // 
						[+] // if(Quicken2012ForWindowsMDI.Exists(SHORT_SLEEP))			// if date is very old or for later date, message is displayed
							[ ] // Quicken2012ForWindowsMDI.SetActive ()
							[ ] // sErrorMsg = Quicken2012ForWindowsMDI.Message.GetText()
							[ ] // ReportStatus("Validate Error Meassage", WARN, "Error Message - '{sErrorMsg}' is observed")
							[ ] // Quicken2012ForWindowsMDI.Yes.Click ()
							[ ] // break
						[+] // if(MessageBox.Exists())			// for invalid data, error message is displayed on saving
							[ ] // bFlag = TRUE
							[ ] // break
						[ ] // 
						[ ] // ReportStatus("Validate Transaction", PASS, "Transaction is added in Account - {lsTransactionData[2]}.")
						[ ] // iFunctionResult = PASS
						[ ] // 
					[ ] // 
					[-] // case("PopUp")
						[ ] // 
						[ ] // BankingPopUp.VerifyEnabled(TRUE, 20)
						[ ] // BankingPopUp.Maximize()			// Maximize the Checking account window as Popup Register is on
						[ ] // BankingPopUp.TypeKeys("<Ctrl-n>")			// go to new line
						[ ] // 
						[+] // if(MessageBox.Exists(SHORT_SLEEP))			// if any trnsaction is already present, then on adding new transaction it saks for save the old transaction.
							[ ] // MessageBox.SetActive()
							[ ] // sErrorMsg = MessageBox.ErrorMsg.GetText()
							[ ] // ReportStatus("Validate Error Meassage", WARN, "Error Message - '{sErrorMsg}' is observed")
							[ ] // MessageBox.No.Click()
						[ ] // 
						[-] // if (lsTransactionData[4] != "")
							[ ] // BankingPopUp.TxList.TypeKeys (lsTransactionData[4])		// enter date
						[ ] // BankingPopUp.TxList.TypeKeys(KEY_TAB)
						[+] // if(MessageBox.Exists(SHORT_SLEEP))				// for invalid date, error message is displayed.
							[ ] // bFlag = TRUE
							[ ] // break
						[ ] // 
						[+] // if(lsTransactionData[3] == "Yes")
							[-] // if(lsTransactionData[5] != "")			
								[ ] // BankingPopUp.TxList.TypeKeys (lsTransactionData[5])		// enter cheque no.
								[ ] // BankingPopUp.TxList.TypeKeys(KEY_TAB)
						[ ] // 
						[-] // if(lsTransactionData[6] != "")
							[ ] // BankingPopUp.TxList.TypeKeys (lsTransactionData[6])		// ente payee name
						[ ] // BankingPopUp.TxList.TypeKeys(KEY_TAB)
						[-] // if(lsTransactionData[7] != "")
							[ ] // BankingPopUp.TxList.TypeKeys (lsTransactionData[7])		// enter memo
						[ ] // BankingPopUp.TxList.TypeKeys(KEY_TAB)
						[-] // if(lsTransactionData[8] != "")
							[ ] // BankingPopUp.TxList.TypeKeys (lsTransactionData[8])		// enter category
						[ ] // BankingPopUp.TxList.TypeKeys(KEY_TAB)
						[ ] // 
						[+] // if(MessageBox.Exists())		// for invalid category error message is disaplyed
							[ ] // bFlag = TRUE
							[ ] // break
						[+] // if(NewCategoryPopup.Exists())		// for new category, prompt for adding new category
							[ ] // NewCategoryPopup.SetActive()
							[ ] // NewCategoryPopup.Yes.Click()
							[-] // if(SetUpCategoryPopup.Exists())
								[ ] // SetUpCategoryPopup.SetActive()
								[ ] // SetUpCategoryPopup.OK.Click()
								[+] // if(MessageBox.Exists(SHORT_SLEEP))		// for invalid category, error message is displayed in Creating new category
									[ ] // MessageBox.SetActive()
									[ ] // sErrorMsg = MessageBox.ErrorMsg.GetText()
									[ ] // ReportStatus("Validate Error Meassage", WARN, "Error Message - '{sErrorMsg}' is observed")
									[ ] // MessageBox.OK.Click()
									[ ] // SetUpCategoryPopup.Close()
									[ ] // break
								[ ] // 
						[ ] // 
						[-] // if(lsTransactionData[9] != "")
							[ ] // BankingPopUp.TxList.TypeKeys (lsTransactionData[9])			// enter tag
						[ ] // BankingPopUp.TxList.TypeKeys(KEY_TAB)
						[ ] // 
						[+] // if(MessageBox.Exists())		// for invalid tag, error message is displayed
							[ ] // bFlag = TRUE
							[ ] // break
						[+] // if(NewTag.Exists())			// for new tag, prompts for adding new tag
							[ ] // NewTag.SetActive()
							[ ] // NewTag.OK1.Click()
						[ ] // 
						[+] // if(lsTransactionData[11] == "Type 2")
							[ ] // BankingPopUp.TxList.TypeKeys(KEY_TAB)
						[ ] // 
						[-] // if (lsTransactionData[10] != "")
							[ ] // BankingPopUp.TxList.TypeKeys (lsTransactionData[10])		// enter amount
						[ ] // 
						[ ] // sleep(SHORT_SLEEP)
						[ ] // 
						[-] // if(lsTransactionData[12] == "Yes")
							[ ] // SplitTransaction(sWindowType, sDataFile, sSplitWorkSheet, Str(i))
						[ ] // 
						[ ] // BankingPopUp.TxList.TxToolbar.Save.Click()
						[+] // if(Quicken2012ForWindows.Exists(SHORT_SLEEP))		// if date is very old or for later date, message is displayed
							[ ] // Quicken2012ForWindows.SetActive ()
							[ ] // sErrorMsg = Quicken2012ForWindows.Message.GetText()
							[ ] // ReportStatus("Validate Error Meassage", WARN, "Error Message - '{sErrorMsg}' is observed")
							[ ] // Quicken2012ForWindows.Yes.Click ()
							[ ] // break
						[+] // if(MessageBox.Exists())					// for invalid data, error message is displayed on saving
							[ ] // bFlag = TRUE
							[ ] // break
						[ ] // 
						[ ] // BankingPopUp.Close()
						[ ] // ReportStatus("Validate Transaction", PASS, "Transaction is added in Account - {lsTransactionData[2]}.")
						[ ] // iFunctionResult = PASS
				[ ] // 
				[+] // if(bFlag == TRUE)					// if any error message is displayed, then flag will be set to TRUE & below code will be executed
					[-] // if(MessageBox.Exists(SHORT_SLEEP))
						[ ] // MessageBox.SetActive ()
						[ ] // sErrorMsg = MessageBox.ErrorMsg.GetText()
						[ ] // ReportStatus("Validate Error Meassage", WARN, "Error Message - '{sErrorMsg}' is observed")
						[ ] // MessageBox.OK1.Click ()
				[+] // else								// if no error occurs, continue with iteration
					[ ] // 
			[ ] // 
			[+] // else
				[ ] // ReportStatus("Validate Account", FAIL, "Account - {lsTransactionData[2]} not found")
				[ ] // iFunctionResult = FAIL
				[ ] // 
		[ ] // 
		[+] // if(BankingPopUp.Exists())			// if in between any error occurs, pop up window needs to be closed
			[ ] // BankingPopUp.Close()
			[-] // if(MessageBox.Exists(SHORT_SLEEP))
				[ ] // MessageBox.SetActive()
				[ ] // MessageBox.No.Click()
			[ ] // 
		[-] // if(iFunctionResult != PASS && iFunctionResult != FAIL)
			[ ] // iFunctionResult = FAIL
	[-] // except 
		[+] // if(BankingPopUp.Exists())
			[ ] // BankingPopUp.Close()
			[ ] // 
		[ ] // iFunctionResult = FAIL
	[ ] // return iFunctionResult
[ ] 
[ ] 
[+] // public INTEGER SplitTransaction(STRING sWindowType, STRING sDataFile, STRING sWorkSheet, STRING sRow)
	[ ] // INTEGER i, iFunctionResult
	[ ] // LIST OF STRING lsSplitData
	[ ] // LIST OF ANYTYPE lsExcelData
	[-] // do
		[ ] // lsExcelData = ReadExcelTable(sDataFile, sWorkSheet)
		[+] // if(sWindowType == "MDI")
			[ ] // BankingMDI.SetActive ()
			[ ] // BankingMDI.TxList.TxToolbar.SplitButton.Click (1, 6, 10)		// click on "More Actions button"
			[ ] // BankingMDI.TxList.TxToolbar.SplitButton.TypeKeys(Replicate(KEY_DN, 3))		// Select split option
			[ ] // BankingMDI.TxList.TxToolbar.SplitButton.TypeKeys(KEY_ENTER)
			[+] // if(SplitTransaction.Exists(SHORT_SLEEP))
				[ ] // SplitTransaction.SetActive()
				[-] // for(i = 1; i<= ListCount(lsExcelData); i++)
					[ ] // lsSplitData = lsExcelData[i]
					[-] // if(lsSplitData[1] == sRow)
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText (lsSplitData[2])		// Enter Category
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys (KEY_TAB)
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField11.SetText (lsSplitData[3])			// Enter Tag
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField11.TypeKeys (KEY_TAB)
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField12.SetText (lsSplitData[4])			// Enter Memo
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField12.TypeKeys (KEY_TAB)
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField13.TypeKeys (KEY_TAB)
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField14.TypeKeys (lsSplitData[5])			// Enter amount
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TypeKeys(KEY_TAB)
					[ ] // 
					[+] // else
						[ ] // continue
				[ ] // iFunctionResult = PASS
				[ ] // SplitTransaction.OK.Click()
			[+] // else
				[ ] // ReportStatus("Validate Split Window", FAIL, "Split window is not available")
		[ ] // 
		[+] // if(sWindowType == "PopUp")
			[ ] // BankingPopUp.SetActive()
			[ ] // BankingPopUp.Maximize()
			[ ] // BankingPopUp.TxList.TxToolbar.SplitButton.Click()
			[ ] // BankingPopUp.TxList.TxToolbar.SplitButton.TypeKeys(Replicate(KEY_DN, 3))
			[ ] // BankingPopUp.TxList.TxToolbar.SplitButton.TypeKeys(KEY_ENTER)
			[-] // if(SplitTransactionPopUp.Exists(SHORT_SLEEP))
				[ ] // SplitTransactionPopUp.SetActive()
				[-] // for(i = 1; i<= ListCount(lsExcelData); i++)
					[ ] // lsSplitData = lsExcelData[i]
					[+] // if(lsSplitData[1] == sRow)
						[ ] // SplitTransactionPopUp.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText (lsSplitData[2])		// Enter Category
						[ ] // SplitTransactionPopUp.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys (KEY_TAB)
						[ ] // SplitTransactionPopUp.EnterMultipleCategoriesToI2.ListBox1.TextField11.SetText (lsSplitData[3])			// Enter Tag
						[ ] // SplitTransactionPopUp.EnterMultipleCategoriesToI2.ListBox1.TextField11.TypeKeys (KEY_TAB)
						[ ] // SplitTransactionPopUp.EnterMultipleCategoriesToI2.ListBox1.TextField12.SetText (lsSplitData[4])			// Enter Memo
						[ ] // SplitTransactionPopUp.EnterMultipleCategoriesToI2.ListBox1.TextField12.TypeKeys (KEY_TAB)
						[ ] // SplitTransactionPopUp.EnterMultipleCategoriesToI2.ListBox1.TextField13.TypeKeys (KEY_TAB)
						[ ] // SplitTransactionPopUp.EnterMultipleCategoriesToI2.ListBox1.TextField14.TypeKeys (lsSplitData[5])			// Enter amount
						[ ] // SplitTransactionPopUp.EnterMultipleCategoriesToI2.ListBox1.TypeKeys(KEY_TAB)
					[ ] // 
					[+] // else
						[ ] // continue
				[ ] // iFunctionResult = PASS
				[ ] // SplitTransactionPopUp.OK.Click()
			[+] // else
				[ ] // ReportStatus("Validate Split Window", FAIL, "Split window is not available")
			[ ] // 
	[ ] // 
	[-] // except
		[ ] // iFunctionResult = FAIL
	[ ] // 
	[ ] // return iFunctionResult
[ ] 
[ ] 
[ ] // 
[+] // testcase AddSpendingAccounts() appstate none
	[+] // // Variable Declaration
		[ ] // STRING sExcelData = "AddManualSpendingAccounts.xls"
		[ ] // STRING sWorkSheet = "Accounts"
		[ ] // 
		[ ] // INTEGER iCreateDataFile, iSetupAutoAPI, iAddSpendingAccounts
		[ ] // STRING sDataLogPath, sDate, sCmdLine, sValidatePath
		[ ] // 
		[ ] // sDataLogPath = USERPROFILE + "\Application Data\Intuit\Quicken\Log\DATA_LOG.TXT"
		[ ] // Datetime dTime = GetDateTime()
		[ ] // sDate = FormatDateTime(dTime, "mm_dd_yy")
		[ ] // sValidatePath = sValidateLogFolder + DELIMITER +  "VALIDATE_LOG" + "_"+ sDate + ".log"
		[ ] // sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] // 
	[+] // // // Perform Setup activities
		[+] // // if(QuickenMainWindow.Exists())
			[ ] // // QuickenMainWindow.VerifyEnabled(TRUE, 20)
			[ ] // // QuickenMainWindow.SetActive()
			[ ] // // QuickenMainWindow.Exit()
		[ ] // // 
		[ ] // // sleep(SHORT_SLEEP)
		[ ] // // 
		[+] // // if(FileExists(sDataFile))
			[ ] // // DeleteFile(sDataFile)
		[ ] // // 
		[+] // // if(FileExists(sTestCaseStatusFile))
			[ ] // // DeleteFile(sTestCaseStatusFile)
		[ ] // // 
		[ ] // // //Load O/S specific paths
		[ ] // // LoadOSDependency()
		[ ] // // 
		[ ] // // iSetupAutoAPI = SetUp_AutoApi()
		[ ] // // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] // // 
	[ ] // // // Launch Quicken
	[+] // // if (!QuickenMainWindow.Exists ())
		[ ] // // QuickenMainWindow.Start (sCmdLine)
	[ ] // 
	[+] // // if (QuickenMainWindow.Exists(MEDIUM_SLEEP) == TRUE)
		[ ] // // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // // 
		[ ] // // // Create Data File
		[ ] // // iCreateDataFile = DataFileCreate(sFileName)
		[ ] // // 
		[ ] // // // Report Status If Data file Created successfully
		[+] // // if ( iCreateDataFile  == PASS)
			[ ] // // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] // // 
		[ ] // // 
		[ ] // // // Report Status If Data file is not Created 
		[+] // // else if ( iCreateDataFile ==FAIL)
			[ ] // // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // // 
		[ ] // // // Report Status If Data file already exists
		[+] // // else
			[ ] // // ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
		[ ] // // 
	[ ] // // 
	[ ] // // // Report Status if Quicken is not launched
	[+] // // else
		[ ] // // ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] // 
	[ ] // // Add Accounts based on input XLS
	[+] // if(QuickenMainWindow.Exists(SHORT_SLEEP) == TRUE)
		[ ] // QuickenMainWindow.SetActive()
		[ ] // iAddSpendingAccounts = AddSpendingAccount(sExcelData, sWorkSheet)
		[+] // if(iAddSpendingAccounts == PASS)
			[ ] // ReportStatus("Add Category Utility", iAddSpendingAccounts, "Utility is executed successfully") 
		[ ] // 
		[+] // else
			[ ] // ReportStatus("Add Category Utility", iAddSpendingAccounts, "Utility is not executed successfully") 
		[ ] // 
	[ ] // 
	[ ] // // Report Status if Quicken is not launched
	[+] // else
		[ ] // ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] // 
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: AddManualSpendingAccount()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will add accounts using manual option..
	[ ] // If account is added successfully TRUE is returned else FALSE with error message is returned.
	[ ] 
	[ ] //
	[ ] // PARAMETERS:		STRING 	sAccountType		Type of the account to be created
	[ ] //						STRING     sAccounName	Name of the account
	[ ] //						STRING 	sAccountBalance	Account balance of the new account to be created
	[ ] //
	[ ] // RETURNS:			INTEGER	0 = If account is created successfully
	[ ] //									1 = if any error occurs while adding account
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 03, 2010	Mamta Jain created
	[ ] //	 Dec 23, 2010 Udita Dube  Changed window declarations
	[ ] // 	Jan 04, 2011 Udita Dube	  Added Code for Saving Account / Credit Card Account / Cash Account
	[ ] //	Jan 18, 2011 Udita Dube	 Added do except block and updated except block
[ ] // ==========================================================
[+] // public INTEGER AddSpendingAccount(STRING sDataFile, STRING sWorkSheet)
	[-] // // Variable declaration
		[ ] // INTEGER iFunctionResult, i
		[ ] // LIST oF ANYTYPE lsExcelData
		[ ] // LIST OF STRING lsAccountsData
		[ ] // STRING sErrorMsg
		[ ] // BOOLEAN bErrorStatus = FALSE
	[-] // do
		[ ] // lsExcelData = ReadExcelTable(sDataFile, sWorkSheet)
		[ ] // 
		[-] // for(i = 1; i<= ListCount(lsExcelData); i++)
			[ ] // lsAccountsData = lsExcelData[i]
			[+] // if(IsNULL(lsAccountsData[1]))
				[ ] // lsAccountsData[1] = ""
			[+] // if(IsNULL(lsAccountsData[2]))
				[ ] // lsAccountsData[2] = ""
			[-] // if(IsNULL(lsAccountsData[3]))
				[ ] // lsAccountsData[3] = ""
			[-] // if(IsNULL(lsAccountsData[4]))
				[ ] // lsAccountsData[4] = ""
			[-] // if(IsNULL(lsAccountsData[5]))
				[ ] // lsAccountsData[5] = ""
			[ ] // 
			[-] // switch(lsAccountsData[1])
				[-] // case "Checking"
					[ ] // ExpandAccountBar()
					[ ] // QuickenMainWindow.SetActive()
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
					[ ] // AddAccount.Spending.Select(lsAccountsData[1])
					[ ] // AddAccount.Next.Click()
					[-] // if(AddAnyAccount.Exists(MEDIUM_SLEEP))
						[ ] // AddAnyAccount.VerifyEnabled(TRUE, 600)
						[ ] // AddAnyAccount.SetActive()
						[ ] // AddAnyAccount.Panel.QWHtmlView1.Click (1, 65, 5)
						[ ] // AddAnyAccount.AddCheckingAccount.Select("I want to enter my transactions manually")
						[ ] // AddAnyAccount.Next.Click()
					[-] // else
						[ ] // ReportStatus("Validate Add {lsAccountsData[1]} Account Window", FAIL, "Add {lsAccountsData[1]} Account window is not available") 
				[+] // case "Savings"
					[ ] // ExpandAccountBar()
					[ ] // QuickenMainWindow.SetActive()
					[ ] // // Click on Add Account button
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
					[ ] // // Select Account Type
					[ ] // AddAccount.Spending.Select(lsAccountsData[1])
					[ ] // AddAccount.Next.Click()
					[ ] // //AddAnyAccount.VerifyEnabled(TRUE, 300)
					[+] // if(AddAnyAccount.Exists(500))
						[ ] // AddAnyAccount.Panel.QWHtmlView1.Click (1, 65, 5)
						[ ] // AddAnyAccount.AddCheckingAccount.Select("I want to enter my transactions manually")
						[ ] // AddAnyAccount.Next.Click()
						[ ] // 
					[-] // else
						[ ] // ReportStatus("Validate Add {lsAccountsData[1]} Account Window", FAIL, "Add {lsAccountsData[1]} Account window is not available") 
					[ ] // 
					[ ] // 
				[+] // case "Credit Card"
					[ ] // ExpandAccountBar()
					[ ] // QuickenMainWindow.SetActive()
					[ ] // // Click on Add Account button
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
					[ ] // // Select Account Type
					[ ] // AddAccount.Spending.Select(lsAccountsData[1])
					[ ] // AddAccount.Next.Click()
					[ ] // //AddAnyAccount.VerifyEnabled(TRUE, 300)
					[+] // if(AddAnyAccount.Exists(500))
						[ ] // AddAnyAccount.Panel.QWHtmlView1.Click (1, 65, 5)
						[ ] // AddAnyAccount.AddCheckingAccount.Select("I want to enter my transactions manually")
						[ ] // AddAnyAccount.Next.Click()
					[-] // else
						[ ] // ReportStatus("Validate Add {lsAccountsData[1]} Account Window", FAIL, "Add {lsAccountsData[1]} Account window is not available") 
					[ ] // 
					[ ] // 
				[+] // case "Cash"
					[ ] // ExpandAccountBar()
					[ ] // QuickenMainWindow.SetActive()
					[ ] // // Click on Add Account button
					[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
					[ ] // // Select Account Type
					[ ] // AddAccount.Spending.Select(lsAccountsData[1])
					[ ] // AddAccount.Next.Click()
					[ ] // 
				[+] // default
					[ ] // print(lsAccountsData[1] + "not found")
					[ ] // iFunctionResult = FAIL
			[ ] // 
			[ ] // AddAnyAccount.VerifyEnabled(TRUE, EXTRA_LONG_SLEEP)
			[-] // if(AddAnyAccount.Exists())
				[ ] // AddAnyAccount.AccountName.SetText(lsAccountsData[2])		// Enter Account Name
				[-] // if(lsAccountsData[5] != "")
					[ ] // AddAnyAccount.AccountUsedPrimarily.Select(lsAccountsData[5])		// Select radio button which states "Account is used primarily for..."
				[ ] // 
				[ ] // AddAnyAccount.Next.Click()
				[-] // if(AddAnyAccount.AlertMessage.Exists(SHORT_SLEEP))
					[ ] // bErrorStatus = TRUE
					[ ] // 
				[-] // else				// Business Transactions,,,Rental Property Transactions
					[ ] // AddAnyAccount.StatementEndingDate.SetText (lsAccountsData[4])	// Enter Statement Ending Date
					[ ] // AddAnyAccount.StatementEndingBalance.SetText(lsAccountsData[3])	// Enter Account Balance
					[ ] // AddAnyAccount.Next.Click()
					[ ] // 
					[+] // if(AddAnyAccount.AlertMessage.Exists(SHORT_SLEEP))		// If date format is not correct, error message is displayed
						[ ] // bErrorStatus = TRUE
					[ ] // 
					[-] // else
						[ ] // AccountAdded.Finish.Click()		// Click on Finish
						[ ] // ReportStatus("Validate Account", PASS, "{lsAccountsData[1]} Account - {lsAccountsData[2]} is added successfully") 
						[ ] // iFunctionResult = PASS
						[ ] // bErrorStatus = FALSE
				[+] // if(bErrorStatus == TRUE)
					[ ] // AddAnyAccount.AlertMessage.SetActive()
					[ ] // sErrorMsg = AddAnyAccount.AlertMessage.TextMessage.GetText()
					[ ] // ReportStatus("Validate Account", FAIL, "{lsAccountsData[1]} Account - '{lsAccountsData[2]}' is not added and Error Message '{sErrorMsg}' is displayed.") 
					[ ] // AddAnyAccount.AlertMessage.OK.Click()
					[ ] // AddAnyAccount.Cancel.CLick()
					[-] // if(AddAnyAccount.AlertMessage.Exists(SHORT_SLEEP))
						[ ] // AddAnyAccount.AlertMessage.SetActive()
						[ ] // AddAnyAccount.AlertMessage.OK.Click()
						[ ] // 
					[ ] // iFunctionResult = FAIL
					[ ] // 
				[-] // else
					[ ] // //continue
			[+] // else
				[ ] // ReportStatus("Validate Add {lsAccountsData[1]} Account Window", FAIL, "Add {lsAccountsData[1]} Account window is not available") 
				[ ] // 
		[ ] // 
	[-] // except
		[+] // if(AddAnyAccount.AlertMessage.Exists(SHORT_SLEEP))
			[ ] // AddAnyAccount.AlertMessage.OK.Click()
		[ ] // AddAnyAccount.Cancel.CLick()
		[+] // if(AddAnyAccount.AlertMessage.Exists(SHORT_SLEEP))
			[ ] // AddAnyAccount.AlertMessage.SetActive()
			[ ] // AddAnyAccount.AlertMessage.OK.Click()
			[ ] // 
		[ ] // iFunctionResult = FAIL
	[ ] // 
	[ ] // return iFunctionResult
[ ] 
