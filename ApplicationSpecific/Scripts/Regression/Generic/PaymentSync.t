[+] // //Global Variable
	[ ] // public HANDLE hDB
	[ ] // public HANDLE hSQL 
	[ ] // public STRING sMFCUAccountId = "123456"
	[ ] // public STRING sOnlineAccountFileName = "Online"
	[ ] // STRING sOnlineAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
	[ ] // 
	[ ] // STRING sOnlineOFXLogPath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".OFXLOG"
	[ ] // 
	[ ] // public STRING sCheckingAccount = "Checking XX9609"
	[ ] // INTEGER iResponseStatus
	[ ] // public LIST OF ANYTYPE  lsAccountData,lsExcelData
	[ ] // public STRING sXLSName = "PaymentSyncMFCU"
	[ ] // public STRING sPaymentSyncData = LoadControlsDataXLSPath(sXLSName)
	[ ] // STRING sBankingTransactionWorksheet="transactions"
	[ ] // STRING sHandle,sExpected,sActual
	[ ] // BOOLEAN bMatch,bFlag,bGlobalTransactionCount
	[ ] // INTEGER i,iSetupAutoAPI
	[ ] // STRING sFileFolder=AUT_DATAFILE_PATH + "\PaymentSyncData\"
	[ ] // 
	[ ] // // STRING sSmokeData = "SmokeTestData"
	[ ] // // STRING sIAMWorksheet = "IAM Registration"
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
[ ] 
[+] //Global Variable
	[ ] public HANDLE hDB
	[ ]  public HANDLE hSQL 
	[ ] public STRING sMFCUAccountId = "123456"
	[ ] public STRING sOnlineAccountFileName = "Online"
	[ ] STRING sOnlineAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
	[ ] 
	[ ] STRING sOnlineOFXLogPath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".OFXLOG"
	[ ] 
	[ ] public STRING sFIName="ZZZ - Mission Federal Credit Union"
	[ ] 
	[ ] public STRING sCheckingAccount = "Checking XX9609"
	[ ] INTEGER iResponseStatus ,iSelect
	[ ] public LIST OF ANYTYPE  lsAccountData,lsExcelData
	[ ] public STRING sXLSName = "PaymentSyncMFCU"
	[ ] // public STRING sPaymentSyncData = LoadControlsDataXLSPath(sXLSName)
	[ ] public STRING sPaymentSyncData = "PaymentSyncMFCU"
	[ ] STRING sBankingTransactionWorksheet="transactions"
	[ ] STRING sHandle,sExpected,sActual
	[ ] BOOLEAN bMatch,bFlag,bGlobalTransactionCount
	[ ] INTEGER i,iSetupAutoAPI
	[ ] STRING sFileFolder=AUT_DATAFILE_PATH + "\PaymentSyncData\"
	[ ] 
	[ ] // STRING sSmokeData = "SmokeTestData"
	[ ] // STRING sIAMWorksheet = "IAM Registration"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Payment  Sync Setup ############# 
	[ ] // ********************************************************
	[-] // TestCase Name:	 BeaconSetup()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will copy few required files from original to temp location  if it exists
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	 Mar 13, 2012		Sandeep Patil  created	
	[ ] //*********************************************************
	[ ] 
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
[ ] 
[ ] 
[ ] 
[ ] 
[+] ///OLD
	[ ] // 
	[ ] // /////testcase PaymentSyncSetup() appstate none /////
	[+] // testcase PaymentSyncSetup() appstate QuickenBaseState
		[+] // //VARIABLE
			[ ] // INTEGER iCreateDataFile, iLocalFileSetup, iIntuonlConfigure,iSetupAutoAPI
			[ ] // STRING sSourceOlnIniFile="{ROOT_PATH}\ApplicationSpecific\Tools\intuonl\Release\intu_onl.ini"
			[ ] // BOOLEAN bDeleteStatus
			[ ] // STRING sOriginalFolder="{AUT_DATAFILE_PATH}\OriginalPaymentSyncData"
			[ ] // STRING sTempFolder="{AUT_DATAFILE_PATH}\PaymentSyncData"
			[ ] // 
		[-] // if (QuickenWindow.Exists() == TRUE)
			[ ] // QuickenWindow.Close()
			[ ] // 
		[ ] // //Deleting existing folder 
		[+] // if(SYS_DirExists(sTempFolder))
			[ ] // bDeleteStatus=DeleteDir(sTempFolder)
		[+] // else
			[ ] // print("{sTempFolder} folder not exists exists")
		[ ] // MakeDir(sTempFolder)
		[+] // if SYS_DirExists(sOriginalFolder)				
			[ ] // CopyDir(sOriginalFolder,sTempFolder)		// copy Payment Sync folder to Temporary folder
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Payment  Sync Files and Folder",FAIL,"Payment  Sync Files and Folders are not available in mentioned location")
		[ ] // 
		[ ] // 
		[ ] // //QuickennWindow.VerifyEnabled(TRUE, 20)
		[ ] // iCreateDataFile = DataFileCreate(sOnlineAccountFileName)
		[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sOnlineAccountFileName} is created")
		[-] // if(QuickenWindow.Exists())
			[ ] // // QuickenWindow.Tools.Click()
			[ ] // // QuickenWindow.Tools.OneStepUpdate.Select()
			[+] // // // if(FakeResponse.Exists(5))
				[ ] // // // FakeResponse.Cancel.Click()
			[ ] // // RegisterQuickenConnectedServices()
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // //Setup LocalFile Testing mechanism
		[ ] // iLocalFileSetup = SetUpLocalFile()
		[ ] // ReportStatus("LocalFile Setup", iLocalFileSetup, "LocalFile Testing Setup is performed") 
		[ ] // 
		[ ] // //Copying Ini file from source to destination folder
		[-] // if(FileExists(sDestinationonliniFile) == FALSE)
			[ ] // CopyFile(sSourceOlnIniFile, sDestinationonliniFile)
		[-] // // if(FileExists(sOnlieAccountFilePath))
			[ ] // // DeleteFile(sOnlieAccountFilePath)
		[ ] // 
		[ ] // 
		[ ] // //AutoApi Setup
		[ ] // iSetupAutoAPI = SetUp_AutoApi()			// copy qwautoap.dll to Quicken folder in Program files
		[ ] // 
		[ ] // CloseQuicken()
		[ ] // 
	[ ] // // // // //###########################################################################
	[ ] // 
	[ ] // 
	[+] // // //############# Add online account using local files ##################################
		[ ] // // ********************************************************
		[+] // // TestCase Name:	 Test1_AddEWCWelsFargoAccount()
			[ ] // // 
			[ ] // // DESCRIPTION:
			[ ] // // This testcase will create Online account for Mission Federal Credit Union Bank. This will create a new data file and add Checking account .
			[ ] // // Using Localfile Testing mechansim.
			[ ] // // 
			[ ] // // PARAMETERS:	none
			[ ] // // 
			[ ] // // RETURNS:			Pass 		If no error occurs while creating online account 							
			[ ] // // Fail		If any error occurs
			[ ] // // 
			[ ] // // REVISION HISTORY:
			[ ] // // Jun 03, 2011		Puja Verma created	
		[ ] // //*********************************************************
	[-] // testcase Test1_AddMissionFederalCreditUnionAccount () appstate QuickenBaseState
		[+] // //VARIABLES
			[ ] // LIST OF ANYTYPE lsExcelCellData, lsC2RData
			[ ] // STRING hWnd, sActualOutput,sPaymentSync,sPaymentSyncActualOutput
			[ ] // BOOLEAN bMatchStatus
			[ ] // INTEGER iCreateDataFile, iLocalFileSetup, iIntuonlConfigure
			[ ] // STRING sActualPaymentSyncCount = "1"
			[ ] // STRING sActualCount ="4"
			[ ] // STRING sExpEndingbalance="660.52"
			[ ] // //STRING sExpEndingbalance="658.53"
			[ ] // 
			[ ] // STRING sExpOnlineBalance="49.52"
			[ ] // 
			[ ] // 
			[ ] // LIST OF STRING lsPaymentSyncTransactionData={"New","3/7/2010","Bhavani Kaki" ,"1.99"}
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // STRING sOnlineAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
			[ ] // //Respose files for Local File Testing
			[ ] // STRING sBrandingResponse =sFileFolder+"1_brand_resp.dat"
			[ ] // STRING sProfileResponse =sFileFolder+"2_prof_resp.dat"
			[ ] // STRING sAccountInfoResponse =sFileFolder+"3_acct_info.dat"
			[ ] // STRING sPaymentSyncResponse =sFileFolder+"4_payment_sync.dat"
			[ ] // STRING sStmtResponse =sFileFolder+"5_stmt_resp.dat"
			[ ] // //STRING sExpEndingBalanceAfterAccept="49.52"
			[ ] // STRING sExpEndingBalanceAfterAccept="47.53"
			[ ] // 
			[ ] // STRING sTransactionsAfterAccept="6"
			[ ] // BOOLEAN bWorksheet = FALSE
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
		[ ] // 
		[ ] // //CONNECT TO EXCEL AND READ EXCEL WORKSHEET
		[+] // do
			[ ] // // connect to the database and Reading excel file
			[ ] // hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sPaymentSyncData}{DB_CONNECT_SUFFIX}")
			[ ] // //execute a SQL statement
			[ ] // hSQL = DB_ExecuteSQL (hDB, "{SQL_QUERY_START}[{sBankingTransactionWorksheet}$]")//while there are still rows to retrieve
			[ ] // lsExcelData = ReadExcelTable(sPaymentSyncData, sBankingTransactionWorksheet)
			[ ] // bWorksheet=TRUE
			[ ] // print(lsExcelData)
		[+] // except
			[ ] // ReportStatus("Worksheet verification", WARN, "Worksheet {sBankingTransactionWorksheet} not found") 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // // Lauch Quicken
		[+] // if (!QuickenWindow.Exists ())
			[ ] // QuickenWindow.Start ("{QUICKEN_ROOT}" + "\qw.exe")
		[ ] // // Create a new data file for Online account
		[ ] // 
		[+] // if (QuickenWindow.Exists() == True)
			[ ] // // Navigate to Edit > Preferences
			[ ] // QuickenWindow.SetActive()
			[ ] // //QuickenMainWindow.SetActive()
			[ ] // QuickenWindow.Edit.Click()
			[ ] // QuickenWindow.Edit.Preferences.Select()
			[ ] // 
			[-] // if(Preferences.Exists(2))
				[ ] // sHandle = Str(Preferences.SelectPreferenceType1.ListBox1.GetHandle())
				[ ] // sExpected = "Downloaded Transactions"
				[ ] // // find the Register option in Prefernces window
				[-] // for( i = 11; i<=15; i++)
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
					[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
					[-] // if(bMatch == TRUE)
						[ ] // bFlag=TRUE
						[ ] // QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(i))		// Select Download Transactions option
						[ ] // // Check the avalability of the checkbox
						[-] // if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
							[ ] // // UnCheck the checkboxes of Automatically download transaction and apply naming rules to downloaded transactions  if it is unchecked
							[-] // if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
									[ ] // Preferences.AutomaticallyAddDownloadedT.UnCheck ()
									[ ] // //Preferences.ApplyRenamingRulesToDownloadedT.Uncheck()
									[ ] // 
									[ ] // Preferences.OK.Click()
							[-] // else
									[ ] // Preferences.OK.Click()
									[ ] // 
						[+] // else
								[ ] // Preferences.Close()
						[ ] // 
						[ ] // break
					[-] // else 
						[-] // bFlag = FALSE
								[-] // if(i==15)
									[ ] // ReportStatus("Validate Download Transaction option'", FAIL, "Download Transaction option is not available") 
								[-] // else
									[ ] // continue
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] // 
		[ ] // 
		[ ] // // Local Web request window should not come 
		[ ] // QuickenWindow.SetActive()
		[ ] // // Add Online Account
		[ ] // ExpandAccountBar()
		[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] // AddAccount.Checking.Click()//Spending.Select("Checking")
		[+] // // if(QuickenUpdateStatus.Exists(10))
			[ ] // // QuickenUpdateStatus.StopUpdate.Click()
			[ ] // // 
		[ ] // sleep(30)
		[ ] // //WaitForState(AddAnyAccount,FALSE,10)
		[ ] // AddAnyAccount.SetActive()
		[ ] // AddAnyAccount.EnterTheNameOfYourBank.SetText("Mission Federal Credit Union")
		[ ] // AddAnyAccount.Next.Click()
		[ ] // // Provide different DAT files for Local file responses
		[+] // if (FakeResponse.Exists(15) == TRUE)
			[ ] // iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
			[ ] // ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Fake Respose Window", WARN, "Branding Response is not asked") 
			[ ] // 
		[ ] // //AddAnyAccount.Next.Click()
		[+] // if (AddAnyAccount.Exists(15) == TRUE)
			[ ] // AddAnyAccount.SetActive()
			[ ] // 
			[ ] // AddAnyAccount.BankMemberNumber.SetText(sMFCUAccountId)
			[ ] // AddAnyAccount.BankPassword.SetText("12345")			// Any random passord is OK
			[ ] // AddAnyAccount.Connect.Click()
			[ ] // 
			[ ] // 
			[ ] // sleep(2)
			[ ] // 
			[-] // if (FakeResponse.Exists(15) == TRUE)
				[ ] // iResponseStatus = EnterFakeResponseFile(sProfileResponse)
				[ ] // ReportStatus("Profile Response ", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
				[ ] // 
				[ ] // sleep(2)
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sAccountInfoResponse)
				[ ] // ReportStatus("Account Info  Response ", iResponseStatus, "Fake Response - {sAccountInfoResponse} is entered")
				[ ] // 
				[ ] // sleep(2)
				[ ] // 
				[ ] // 
				[-] // if(AddAnyAccount.Exists(SHORT_SLEEP))
					[ ] // AddAnyAccount.SetActive()
					[ ] // AddAnyAccount.Next.Click()
					[ ] // 
				[ ] // //Added by Mukesh Oct 22 2012
				[ ] // // iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
				[ ] // // ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sProfileResponse)
				[ ] // ReportStatus("Profile  Response ", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
				[ ] // 
				[ ] // sleep(2)
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sPaymentSyncResponse)
				[ ] // ReportStatus("Profile  Response ", iResponseStatus, "Fake Response - {sPaymentSyncResponse} is entered")
				[ ] // 
				[ ] // sleep(2)
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sStmtResponse)
				[ ] // ReportStatus("Statement Response ", iResponseStatus, "Fake Response - {sStmtResponse} is entered")
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // //Closing Local web Request popup
				[+] // if(LocalWebRequest.Exists(SHORT_SLEEP))
					[ ] // LocalWebRequest.SetActive()
					[ ] // LocalWebRequest.FailRequest.Click()
					[ ] // //.Click (1,5,5)
				[ ] // 
				[ ] // //Complete the process by clicking on Finish button
				[ ] // AccountAdded.SetActive()
				[ ] // AccountAdded.Finish.Click()
				[ ] // ReportStatus("Account Add  ", PASS, "Account added sucessfully")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Fake Respose Window", FAIL, "Fake Respose window is not available") 
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Checking Account Window", FAIL, "Checking Account window is not available") 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // //Verify Accounts are displayed on Account Bar
		[ ] // QuickenWindow.SetActive()
		[ ] // hWnd = str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
		[ ] // 
		[ ] // //Verify Checking account on AccountBar
		[ ] // sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
		[ ] // bMatchStatus = MatchStr("*{sCheckingAccount}*", sActualOutput)
		[+] // if (bMatchStatus == TRUE)
			[ ] // ReportStatus("Validate Checking Account", PASS, "Checking Account -  {sCheckingAccount} is present in Account Bar") 
		[+] // else
			[ ] // ReportStatus("Validate Checking Account", FAIL, "Actual -  {sActualOutput} is not matching with Expected - {sCheckingAccount}") 
		[ ] // 
		[ ] // UsePopupRegister("OFF")
		[ ] // SelectAccountFromAccountBar(sCheckingAccount,ACCOUNT_BANKING)
		[ ] // 
		[ ] // //MATCH ENDING BALANCE OF THE ACCOUNT ADDED
		[ ] // INTEGER iResult= PASS
		[ ] // STRING actualBalance=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
		[ ] // ///Remove   ------/BankingPopUp.EndingBalance.OnlineBalance.GetText()
		[ ] // bMatch = MatchStr(sExpEndingbalance, actualBalance)
		[-] // if(bMatch == TRUE)
			[ ] // ReportStatus("Validate Download transaction", PASS, "Ending balance  {actualBalance} and {sExpEndingbalance} matching successfully")
		[+] // else
			[ ] // ReportStatus("Validate Download transaction", FAIL, "Ending balance {actualBalance} and {sExpEndingbalance}  not matching successfully")
		[ ] // 
		[ ] // 
		[ ] // //MATCH PAYMENT SYNC TRANSACTION AFTER ADD ACCOUNT
		[ ] // WaitForState(MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions,TRUE,3)
		[ ] // sPaymentSync=MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.GetCaption()
		[ ] // print(sPaymentSync)
		[ ] // 
		[ ] // 
		[ ] // bMatch = MatchStr("*{sActualPaymentSyncCount}*", sPaymentSync)
		[-] // if(bMatch == TRUE)
			[ ] // ReportStatus("Validate Download transactions", PASS, "Downloaded transactions  {sActualCount}  matching successfully")
			[ ] // bGlobalTransactionCount=TRUE
			[ ] // 
			[ ] // //Read Payment Sync Data
			[ ] // 
			[ ] // hWnd = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
			[ ] // sPaymentSyncActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  str(0))
			[ ] // 
			[ ] // 
			[+] // for(i=1;i<=ListCount(lsPaymentSyncTransactionData);i++)
				[ ] // bMatch=MatchStr("*{lsPaymentSyncTransactionData[i]}*",sPaymentSyncActualOutput)
				[-] // if(bMatch==TRUE)
					[ ] // ReportStatus("Validate Payment Sync  transaction", PASS, "Payment Sync transactions  {lsPaymentSyncTransactionData[i]} matched successfully")
					[ ] // 
					[ ] // //MDIClient.AccountRegister.QWSnapHolder1.StaticText2.Continue.Click()
					[ ] // 
					[ ] // 
				[-] // else
					[ ] // ReportStatus("Validate Payment Sync  transaction", PASS, "Payment Sync transactions  {lsPaymentSyncTransactionData[i]} not matched successfully to transaction {sPaymentSyncActualOutput}")
					[ ] // 
					[ ] // 
			[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText2.AcceptAll.Click()
			[ ] // 
			[ ] // 
		[-] // else
			[ ] // ReportStatus("Validate Download transactions", FAIL, "Downloaded transactions {sActualCount} does not match")
			[ ] // bGlobalTransactionCount=FALSE
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // //MATCH DOWNLOADED TRANSACTIONS AFTER ADD ACCOUNT
		[ ] // WaitForState(MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions,TRUE,3)
		[ ] // STRING sDownloadedTransaction=MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.GetCaption()
		[ ] // 
		[ ] // print(sDownloadedTransaction)
		[ ] // STRING TotalTxnCount
		[ ] // TotalTxnCount=StrTran(sDownloadedTransaction,"Downloaded Transactions (","")
		[ ] // TotalTxnCount= GetField(TotalTxnCount,")",1) 
		[ ] // bMatch = MatchStr(sActualCount, TotalTxnCount)
		[+] // if(bMatch == TRUE)
			[ ] // ReportStatus("Validate Download transactions", PASS, "Downloaded transactions  {sActualCount} and {TotalTxnCount} matching successfully")
			[ ] // bGlobalTransactionCount=TRUE
			[ ] // 
			[ ] // 
		[-] // else
			[ ] // ReportStatus("Validate Download transactions", FAIL, "Downloaded transactions {sActualCount} and {TotalTxnCount}  not matching successfully")
			[ ] // bGlobalTransactionCount=FALSE
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // //MATCH THE TRANSACTION IN C2R AND EXCEL DATA SHEET
		[ ] // hWnd = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
		[ ] // 
		[ ] // 
		[-] // if(bWorksheet==TRUE)
			[ ] // INTEGER sExcelRow, sExcelCell, sTransactionRow, sTransactionCell
			[ ] // // Fetch data  from the given sheet
			[ ] // print("Data from Excel")
			[+] // for(sExcelRow=1;sExcelRow<=ListCount(lsExcelData);sExcelRow++)
				[ ] // lsData=lsExcelData[sExcelRow]
				[-] // for(sExcelCell=1; sExcelCell<7; sExcelCell++)
					[-] // if lsData[sExcelCell]==NULL
						[ ] // ListAppend (lsExcelCellData, "NULL")
					[-] // else
						[ ] // ListAppend (lsExcelCellData, lsData[sExcelCell])
			[ ] // print(lsExcelCellData) //REMOVE
			[ ] // print("Data from C2R")
			[+] // for(sTransactionRow=0;sTransactionRow<=(ListCount(lsExcelData)*2-1);sTransactionRow=sTransactionRow+2)
				[ ] // sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  str(sTransactionRow))
				[-] // for(sTransactionCell=1; sTransactionCell<7; sTransactionCell++)
					[-] // if GetField (sActualOutput, "@", sTransactionCell) == ""
						[ ] // //print("NULL")
						[ ] // ListAppend (lsC2RData, "NULL")
					[-] // else
						[ ] // //Print (GetField (sActualOutput, "@", sTransactionCell) )
						[ ] // ListAppend (lsC2RData, (GetField (sActualOutput, "@", sTransactionCell) ))
						[ ] // 
			[ ] // print(lsExcelCellData)
			[ ] // print(lsC2RData)
			[+] // if lsExcelCellData == lsC2RData
				[ ] // ReportStatus("Validate Download transactions ", PASS, "All the transactions from data excel sheet and C2R registry matched")
			[+] // else
				[ ] // ReportStatus("Validate Download transactions ", FAIL, "Transactions from data excel sheet and C2R registry are not matched")
			[ ] // 
			[ ] // //Accept All downloaded transactions and matach the number of transactions
			[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText2.AcceptAll.Click()
			[ ] // 
			[ ] // TotalTxnCount=MDIClient.AccountRegister.Balances.TransactionCount.GetText()
			[ ] // 
			[ ] // TotalTxnCount= GetField(TotalTxnCount," Transactions",1) 
			[ ] // bMatch = MatchStr(sTransactionsAfterAccept,TotalTxnCount)
			[-] // if(bMatch == TRUE)
				[ ] // ReportStatus("Validate Download transactions ", PASS, "After Accepting downloaded transactions Total transactions  {sTransactionsAfterAccept} and {TotalTxnCount} matching successfully")
			[-] // else
				[ ] // ReportStatus("Validate Download transactions", FAIL, "After Accepting downloaded transactions Total transactions {sTransactionsAfterAccept} and {TotalTxnCount}  not matching successfully")
			[ ] // 
			[ ] // print(MDIClient.AccountRegister.Balances.EndingBalance.GetText())
			[ ] // actualBalance=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
			[ ] // 
			[ ] // 
			[ ] // bMatch = MatchStr(sExpEndingBalanceAfterAccept, actualBalance)
			[-] // if(bMatch == TRUE)
				[ ] // ReportStatus("Validate Download transactions", PASS, "After Accepting downloaded transactions Ending balance  {actualBalance} and {sExpEndingBalanceAfterAccept} matching successfully")
			[+] // else
				[ ] // ReportStatus("Validate Download transactions", FAIL, "After Accepting downloaded transactions Ending balance {actualBalance} and {sExpEndingBalanceAfterAccept}  not matching successfully")
			[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Match Worksheet values with C2R Transactions",FAIL,"Worksheet not found")
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // // Match the accepted transaction by using quicken Find functionality
		[+] // for(sExcelRow=1;sExcelRow<=ListCount(lsExcelData);sExcelRow++)
			[ ] // lsData=lsExcelData[sExcelRow]
			[+] // for(sExcelCell=2; sExcelCell<5; sExcelCell++)
					[ ] // 
					[ ] // 
					[ ] // 
					[ ] // QuickenWindow.SetActive()
					[ ] // 
					[ ] // ////#########Commented by Mukesh Aug 29 2012 as Find button is no longer available on QW13#####///
					[ ] // //BankingPopUp.Find.click()
					[ ] // // QuickenFind.SetActive()
					[ ] // ////#########Commented by Mukesh Aug 29 2012 as Find button is no longer available on QW13#####///
					[ ] // 
					[ ] // QuickenWindow.TypeKeys(KEY_CTRL_F)
					[ ] // 
					[ ] // //QuickenWindow.TypeKeys(KEY_CTRL_H)
					[ ] // 
					[ ] // WaitForState(QuickenFind,TRUE,5)
					[ ] // 
					[ ] // QuickenFind.SetActive()
					[ ] // //Handle Null values in the excel sheet
					[-] // if (lsData[sExcelCell]!=NULL)
						[+] // switch(sExcelCell)
							[ ] // 
							[ ] // 
							[-] // case 2
								[ ] // QuickenFind.FindAnyField.Select("Date")
								[ ] // QuickenFind.Contains.Select("Exact")
								[ ] // QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
							[-] // case 3
								[ ] // QuickenFind.FindAnyField.Select("Check number")
								[ ] // QuickenFind.Contains.Select("Exact")
								[ ] // QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
							[-] // case 4
								[ ] // QuickenFind.FindAnyField.Select("Payee")
								[ ] // QuickenFind.Contains.Select("Contains")
								[ ] // string tempPayee= GetField(lsData[sExcelCell]," /",1)
								[ ] // QuickenFind.QuickenFind.SetText(tempPayee)
								[ ] // QuickenFind.TypeKeys(KEY_TAB)
								[ ] // QuickenFind.TypeKeys(KEY_TAB)
								[ ] // sleep(1)
							[-] // default
								[ ] // QuickenFind.FindAnyField.Select("Any Field")
								[ ] // QuickenFind.Contains.Select("Contains")
								[ ] // QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
						[ ] // 
						[ ] // 
						[ ] // //MATCH NUMBER OF TRANSACTIONS IN SEARCH RESULTS POP UP
						[ ] // QuickenFind.SetActive()
						[ ] // QuickenFind.FindAll.click()
						[-] // if(SearchResultsWindow.Exists())
							[ ] // SearchResultsWindow.SetActive()
							[ ] // STRING sText=SearchResultsWindow.TransactionCount.GetText()
							[ ] // bMatch = MatchStr("*Found in 1 transaction*",sText)
							[-] // if(bMatch == TRUE)
								[ ] // ReportStatus("Search Transaction in Registry ", PASS, "Transaction {lsData[sExcelCell]} found in account registry")
							[-] // else
								[ ] // ReportStatus("Search Transaction in Registry ", FAIL, "Transaction {lsData[sExcelCell]} not found in account registry")
							[ ] // SearchResultsWindow.SetActive()
							[ ] // SearchResultsWindow.Close()
							[ ] // sleep(2)
						[-] // else
							[-] // if QuickenFind.Exists()
								[ ] // QuickenFind.Close()
		[ ] // 
		[ ] // 
		[ ] // //Match the Payment sync transactions
		[+] // for(sExcelCell=2;sExcelCell<=ListCount(lsPaymentSyncTransactionData);sExcelCell++)
			[ ] // lsData=lsPaymentSyncTransactionData
			[ ] // 
			[+] // switch(sExcelCell)
				[ ] // 
				[ ] // QuickenWindow.SetActive()
				[ ] // QuickenWindow.TypeKeys(KEY_CTRL_F)
				[ ] // 
				[ ] // 
				[-] // case 2
					[ ] // QuickenFind.FindAnyField.Select("Date")
					[ ] // QuickenFind.Contains.Select("Exact")
					[ ] // QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
				[-] // case 3
					[ ] // QuickenFind.FindAnyField.Select("Payee")
					[ ] // QuickenFind.Contains.Select("Contains")
					[ ] // QuickenFind.QuickenFind.SetText(tempPayee)
					[ ] // QuickenFind.TypeKeys(KEY_TAB)
					[ ] // QuickenFind.TypeKeys(KEY_TAB)
					[ ] // sleep(1)
				[-] // case 4
					[ ] // QuickenFind.FindAnyField.Select("Amount")
					[ ] // QuickenFind.Contains.Select("Exact")
					[ ] // QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
				[-] // default
					[ ] // QuickenFind.FindAnyField.Select("Any Field")
					[ ] // QuickenFind.Contains.Select("Contains")
					[ ] // QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // //MATCH NUMBER OF TRANSACTIONS IN SEARCH RESULTS POP UP
			[ ] // QuickenFind.SetActive()
			[ ] // QuickenFind.FindAll.click()
			[-] // if(SearchResultsWindow.Exists())
				[ ] // SearchResultsWindow.SetActive()
				[ ] // sText=SearchResultsWindow.TransactionCount.GetText()
				[ ] // bMatch = MatchStr("*Found in 1 transaction*",sText)
				[-] // if(bMatch == TRUE)
					[ ] // ReportStatus("Search Transaction in Registry ", PASS, "Transaction {lsData[sExcelCell]} found in account registry")
				[-] // else
					[ ] // ReportStatus("Search Transaction in Registry ", FAIL, "Transaction {lsData[sExcelCell]} not found in account registry")
				[ ] // SearchResultsWindow.SetActive()
				[ ] // SearchResultsWindow.Close()
				[ ] // sleep(2)
			[-] // else
				[-] // if QuickenFind.Exists()
					[ ] // QuickenFind.Close()
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
	[+] // testcase Test2_OneStepUpdateForMissionFederalCreditUnion() appstate QuickenBaseState
		[+] // // Variable
			[ ] // LIST OF ANYTYPE lsExcelCellData, lsC2RData,lsAddAccount
			[ ] // STRING hWnd, sActualOutput
			[ ] // STRING sCaption
			[ ] // BOOLEAN bCaption
			[ ] // STRING sActualCount ="0"
			[ ] // //Respose files for Local File Testing
			[ ] // STRING sBrandingResponse =sFileFolder+"1_brand_resp.dat"
			[ ] // STRING sProfileResponse =sFileFolder+"2_prof_resp.dat"
			[ ] // STRING sStmtResponse =sFileFolder+"5_stmt_resp.dat"
			[ ] // STRING sBankingTransactionWorksheet="transactionsAfterOSU"
			[ ] // BOOLEAN bWorksheet = FALSE
			[ ] // INTEGER iValidate
			[ ] // 
		[ ] // 
		[-] // //Variable declaration
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // // connect to the database and Reading excel file
			[+] // do
				[ ] // hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sPaymentSyncData}{DB_CONNECT_SUFFIX}")
				[ ] // //execute a SQL statement
				[ ] // hSQL = DB_ExecuteSQL (hDB, "{SQL_QUERY_START}[{sBankingTransactionWorksheet}$]")//while there are still rows to retrieve
				[ ] // lsExcelData = ReadExcelTable(sPaymentSyncData, sBankingTransactionWorksheet)
				[ ] // bWorksheet=TRUE
				[ ] // print(lsExcelData)
			[+] // except
				[ ] // ReportStatus("Worksheet verification", WARN, "Worksheet {sBankingTransactionWorksheet} not found") 
				[ ] // 
			[ ] // //Open existing online data files //By Pass the registration
			[ ] // // OpenDataFile(sOnlieAccountFileName)
			[+] // // if(QuickenConnectedServices.Exists(10))
				[ ] // // RegisterQuickenConnectedServices()
			[ ] // 
			[ ] // 
			[ ] // //Matching the actual file is open of not.
			[ ] // sCaption = QuickenWindow.GetCaption()
			[ ] // bCaption = MatchStr("*{sOnlineAccountFileName}*", sCaption)
			[+] // if(bCaption==TRUE)
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // QuickenWindow.SetActive()
				[ ] // //Click on one step update 
				[ ] // INTEGER iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
				[+] // if(UnlockYourPasswordVault.Exists(5))
					[ ] // UnlockYourPasswordVault.SetActive()
					[ ] // UnlockYourPasswordVault.Skip.Click()
					[ ] // 
					[ ] // 
				[ ] // 
				[ ] // sleep(2)
				[+] // if (FakeResponse.Exists(10) == TRUE)
					[ ] // //Added by Mukesh Oct 22 2012
					[ ] // iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
					[ ] // ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
					[ ] // 
					[+] // if(QuickenConnectedServices.Exists(10))
						[ ] // RegisterQuickenConnectedServices()
					[ ] // 
					[ ] // 
				[-] // if(iNavigate == PASS)
					[-] // if(OneStepUpdate.Exists(10))
						[ ] // OneStepUpdate.SetActive ()
						[ ] // //Entering password and click Update button
					[ ] // OneStepUpdate.OneStepUpdateSettings3.ListBox1.AccountPassword.SetText("12345")
					[ ] // OneStepUpdate.UpdateNow.Click ()		
					[ ] // 
					[ ] // //Click on NO button of remeber password option of One Step Update message box
					[+] // if(OneStepUpdateMessagebox.Exists(10))
						[ ] // OneStepUpdateMessagebox.SetActive()
						[ ] // OneStepUpdateMessagebox.No.Click()
						[ ] // 
					[ ] // 
					[ ] // 
					[ ] // //Providing response files
					[-] // if (FakeResponse.Exists(15) == TRUE)
						[ ] // iResponseStatus = EnterFakeResponseFile(sProfileResponse)
						[ ] // ReportStatus("Log On Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
						[ ] // 
						[ ] // sleep(2)
						[ ] // 
						[ ] // iResponseStatus = EnterFakeResponseFile(sStmtResponse)
						[ ] // ReportStatus("Get Institutional Response", iResponseStatus, "Fake Response - {sStmtResponse} is entered")
						[ ] // 
						[ ] // // //Closing Local web Request popup
						[+] // // if(MessageBox.FileDlg("Local Web Request").Exists())
							[ ] // // MessageBox.FileDlg("Local Web Request").SetActive()
							[ ] // // MessageBox.FileDlg("Local Web Request").CustomWin("[WindowsForms10.BUTTON.app.0.378734a]Fail Request|#3|$854190|@(388,541)").click()
						[ ] // 
						[+] // if(LocalWebRequest.Exists(5))
							[ ] // LocalWebRequest.SetActive()
							[ ] // LocalWebRequest.FailRequest.Click()
							[ ] // 
							[ ] // 
						[ ] // 
						[ ] // 
						[ ] // 
						[+] // if(OneStepUpdateSummary.Exists())
							[ ] // OneStepUpdateSummary.Close.Click()
							[ ] // 
						[ ] // 
						[ ] // 
						[ ] // 
						[ ] // ReportStatus("Validate Download transactions", PASS, "Transactions downloaded successfully with OSU")
				[ ] // 
				[ ] // //QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.Click(1,38, 5)
				[ ] // SelectAccountFromAccountBar(sCheckingAccount,ACCOUNT_BANKING)
				[ ] // 
				[ ] // 
				[ ] // //MATCH DOWNLOADED TRANSACTIONS AFTER  OSU
				[ ] // //STRING sDownloadedTransaction=BankingPopUp.EndingBalance.DownloadedTransactions.DownloadedTransactionsTab.GetCaption()
				[ ] // STRING sDownloadedTransaction=MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.GetCaption()
				[ ] // print("Downloaded Transactions {sDownloadedTransaction}" )
				[ ] // STRING TotalTxnCount
				[ ] // TotalTxnCount=StrTran(sDownloadedTransaction,"Downloaded Transactions (","")
				[ ] // TotalTxnCount= GetField(TotalTxnCount,")",1) 
				[ ] // bMatch = MatchStr(sActualCount, TotalTxnCount)
				[-] // if(bMatch == TRUE)
					[ ] // ReportStatus("Validate Download transactions", PASS, "Downloaded transactions  {sActualCount} and {TotalTxnCount} matching successfully")
				[+] // else
					[ ] // ReportStatus("Validate Download transactions", FAIL, "Downloaded transactions {sActualCount} and {TotalTxnCount}  not matching successfully")
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // //MATCH THE TRANSACTION IN C2R AND EXCEL DATA SHEET
				[ ] // // BankingPopUp.EndingBalance.DownloadedTransactions.DownloadedTransactionsTab.Click()
				[ ] // //Quicken2012Popup.SetActive()
				[ ] // 
				[ ] // // 
				[ ] // // //hWnd = str(BankingPopUp.QWSnapHolder.AcceptClearenceTransaction.QWListViewer1.ListBox1.GetHandle())
				[ ] // // 
				[ ] // // hWnd = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] // // 
				[+] // // if(bWorksheet==TRUE)
					[ ] // // INTEGER sExcelRow, sExcelCell, sTransactionRow, sTransactionCell
					[ ] // // // Fetch data  from the given sheet
					[ ] // // print("Data from Excel")
					[+] // // for(sExcelRow=1;sExcelRow<=ListCount(lsExcelData);sExcelRow++)
						[ ] // // lsData=lsExcelData[sExcelRow]
						[-] // // for(sExcelCell=1; sExcelCell<7; sExcelCell++)
							[-] // // if lsData[sExcelCell]==NULL
								[ ] // // ListAppend (lsExcelCellData, "NULL")
							[-] // // else
								[ ] // // ListAppend (lsExcelCellData, lsData[sExcelCell])
					[ ] // // print("Data from C2R")
					[+] // // for(sTransactionRow=0;sTransactionRow<=(ListCount(lsExcelData)*2-1);sTransactionRow=sTransactionRow+2)
						[ ] // // sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  str(sTransactionRow))
						[-] // // for(sTransactionCell=1; sTransactionCell<7; sTransactionCell++)
							[-] // // if GetField (sActualOutput, "@", sTransactionCell) == ""
								[ ] // // //print("NULL")
								[ ] // // ListAppend (lsC2RData, "NULL")
							[-] // // else
								[ ] // // //Print (GetField (sActualOutput, "@", sTransactionCell) )
								[ ] // // ListAppend (lsC2RData, (GetField (sActualOutput, "@", sTransactionCell) ))
								[ ] // // 
					[ ] // // print(lsExcelCellData)
					[ ] // // print(lsC2RData)
					[+] // // if lsExcelCellData == lsC2RData
						[ ] // // ReportStatus("Validate Download transactions ", PASS, "All the transactions from data excel sheet and C2R registry matched")
					[-] // // else
						[ ] // // ReportStatus("Validate Download transactions ", FAIL, "Transactions from data excel sheet and C2R registry are not matched")
					[ ] // // 
				[+] // // else
					[ ] // // ReportStatus("Worksheet verification", FAIL, "Could not read excel Worksheet {sBankingTransactionWorksheet}") 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify data file that is open",FAIL,"Incorrect data file is open")
				[ ] // 
		[+] // // else
			[ ] // // ReportStatus("Verify If all transactions are not downloaded",FAIL,"OSU for Payment not executed as Test Test1_AddMissionFederalCreditUnionAccount failed")
			[ ] // // 
			[ ] // // 
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
	[+] // //############# Beacon Clean ############# #####################################
		[ ] // // ********************************************************
		[+] // // TestCase Name:	 BeaconClean()
			[ ] // //
			[ ] // // DESCRIPTION:
			[ ] // // This testcase will close Quicken, Delete Ini . file and Data File
			[ ] // //
			[ ] // // PARAMETERS:	none
			[ ] // //
			[ ] // // RETURNS:			Pass 		if no error occurs while closing the window							
			[ ] // //						Fail		if any error occurs
			[ ] // //
			[ ] // // REVISION HISTORY:
			[ ] // //	  June 23, 2011		Puja Verma  created	
		[ ] // //*********************************************************
	[+] // testcase PaymentSyncClean() appstate none//QuickenBaseState
		[ ] // //VARAIBLE
		[ ] // //STRING sDestinationonliniFile="C:\Documents and Settings\All Users\Application Data\Intuit\Quicken\Config\intu_onl.ini"
		[ ] // STRING sTempFolder="{AUT_DATAFILE_PATH}\PaymentSyncData"
		[ ] // 
		[-] // if(QuickenWindow.Exists() == TRUE)
			[ ] // QuickenWindow.Close()
		[ ] // // Delete the INI file, quicken data file and the temp directory of local file response
		[ ] // // Delete the C:\Program Files\Quicken\qa_acc32.dll 
		[+] // if(FileExists(sAccDllDestinationPath) == TRUE)
			[ ] // DeleteFile(sAccDllDestinationPath)
		[ ] // // Delete the ....Application Data\Intuit\Quicken\Config\Intu_onl.ini file
		[+] // if(FileExists(sDestinationonliniFile) == TRUE)
			[ ] // DeleteFile( sDestinationonliniFile)
		[ ] // // Delete the Quicken data file
		[+] // if(FileExists(sOnlineAccountFilePath))
			[ ] // DeleteFile(sOnlineAccountFilePath)
		[ ] // //Delete OFX log
		[+] // if(FileExists(sOnlineOFXLogPath))
			[ ] // DeleteFile(sOnlineOFXLogPath)
		[ ] // //Delete the temp response folder
		[+] // if(FileExists(sTempFolder))
			[ ] // DeleteDir(sTempFolder)
		[ ] // // 
	[ ] // // //###########################################################################
[ ] 
[ ] 
[ ] 
[ ] /////testcase PaymentSyncSetup() appstate none /////
[ ] // Updated By Abhijit S, June 2015
[-] testcase PaymentSyncSetup() appstate QuickenBaseState
	[-] //VARIABLE
		[ ] INTEGER iCreateDataFile, iLocalFileSetup, iIntuonlConfigure,iSetupAutoAPI
		[ ] STRING sSourceOlnIniFile="{ROOT_PATH}\ApplicationSpecific\Tools\intuonl\Release\intu_onl.ini"
		[ ] BOOLEAN bDeleteStatus
		[ ] STRING sOriginalFolder="{AUT_DATAFILE_PATH}\OriginalPaymentSyncData"
		[ ] STRING sTempFolder="{AUT_DATAFILE_PATH}\PaymentSyncData"
		[ ] STRING sOriginalFidir="C:\ProgramData\Intuit\Quicken\Inet\Common\Localweb\Banklist\2016\fidir.txt"
		[ ] STRING sNewFidir="{AUT_DATAFILE_PATH}\PaymentSyncData\fidir.txt"
		[ ] STRING sKeepFidir="{AUT_DATAFILE_PATH}\PaymentSyncData\FIDIR\fidr.txt"
	[-] if (QuickenWindow.Exists(5))
		[ ] CloseQuicken()
		[ ] sleep(5)
	[ ] //Deleting existing folder 
	[-] if(SYS_DirExists(sTempFolder))
		[ ] bDeleteStatus=DeleteDir(sTempFolder)
	[+] else
		[ ] print("{sTempFolder} folder not exists exists")
	[ ] MakeDir(sTempFolder)
	[-] if SYS_DirExists(sOriginalFolder)
		[ ] CopyDir(sOriginalFolder,sTempFolder)		// copy Payment Sync folder to Temporary folder
		[ ] 
	[+] else
		[ ] ReportStatus("Payment  Sync Files and Folder",FAIL,"Payment  Sync Files and Folders are not available in mentioned location")
	[-] if(FileExists(sOriginalFidir) == TRUE)
		[ ] CopyFile(sOriginalFidir,sKeepFidir)
		[ ] DeleteFile(sOriginalFidir)
	[ ] CopyFile(sNewFidir, sOriginalFidir)
	[ ] 
	[ ] 
	[ ] //QuickennWindow.VerifyEnabled(TRUE, 20)
	[ ] iCreateDataFile = DataFileCreate(sOnlineAccountFileName)
	[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sOnlineAccountFileName} is created")
	[ ] 
	[+] // if(QuickenWindow.Exists())
		[ ] // // QuickenWindow.Tools.Click()
		[ ] // // QuickenWindow.Tools.OneStepUpdate.Select()
		[+] // // // if(FakeResponse.Exists(5))
			[ ] // // // FakeResponse.Cancel.Click()
		[ ] // // RegisterQuickenConnectedServices()
		[ ] // 
	[ ] 
	[ ] 
	[ ] //Setup LocalFile Testing mechanism
	[ ] iLocalFileSetup = SetUpLocalFile()
	[ ] ReportStatus("LocalFile Setup", iLocalFileSetup, "LocalFile Testing Setup is performed") 
	[ ] 
	[ ] //Copying Ini file from source to destination folder
	[-] if(FileExists(sDestinationonliniFile) == FALSE)
		[ ] CopyFile(sSourceOlnIniFile, sDestinationonliniFile)
	[-] // if(FileExists(sOnlieAccountFilePath))
		[ ] // DeleteFile(sOnlieAccountFilePath)
	[ ] 
	[ ] 
	[ ] //AutoApi Setup
	[ ] iSetupAutoAPI = SetUp_AutoApi()			// copy qwautoap.dll to Quicken folder in Program files
	[ ] 
	[ ] //Relaunch Quicken
	[ ] LaunchQuicken()
	[ ] 
[ ] // // // //###########################################################################
[ ] 
[ ] 
[-] // //############# Add online account using local files ##################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test1_AddEWCWelsFargoAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will create Online account for Mission Federal Credit Union Bank. This will create a new data file and add Checking account .
		[ ] // Using Localfile Testing mechansim.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs while creating online account 							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Jun 03, 2011		Puja Verma created	
		[ ] // Updated By Abhijit S, June 2015
	[ ] //*********************************************************
[+] testcase Test1_AddMissionFederalCreditUnionAccount () appstate none // QuickenBaseState
	[-] //VARIABLES
		[ ] LIST OF ANYTYPE lsExcelCellData, lsC2RData
		[ ] STRING hWnd, sActualOutput,sPaymentSync,sPaymentSyncActualOutput
		[ ] BOOLEAN bMatchStatus
		[ ] INTEGER iCreateDataFile, iLocalFileSetup, iIntuonlConfigure
		[ ] STRING sActualPaymentSyncCount = "1"
		[ ] STRING sActualCount ="4"
		[ ] STRING sExpEndingbalance="660.52"
		[ ] //STRING sExpEndingbalance="658.53"
		[ ] 
		[ ] STRING sExpOnlineBalance="49.52"
		[ ] 
		[ ] 
		[ ] LIST OF STRING lsPaymentSyncTransactionData={"New","3/7/2010","Bhavani Kaki" ,"1.99"}
		[ ] 
		[ ] 
		[ ] 
		[ ] STRING sOnlineAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
		[ ] //Respose files for Local File Testing
		[ ] STRING sBrandingResponse =sFileFolder+"1_brand_resp.dat"
		[ ] STRING sProfileResponse =sFileFolder+"2_prof_resp.dat"
		[ ] STRING sAccountInfoResponse =sFileFolder+"3_acct_info.dat"
		[ ] STRING sPaymentSyncResponse =sFileFolder+"4_payment_sync.dat"
		[ ] STRING sStmtResponse =sFileFolder+"5_stmt_resp.dat"
		[ ] //STRING sExpEndingBalanceAfterAccept="49.52"
		[ ] STRING sExpEndingBalanceAfterAccept="47.53"
		[ ] 
		[ ] STRING sTransactionsAfterAccept="6"
		[ ] BOOLEAN bWorksheet = FALSE
		[ ] 
		[ ] 
		[ ] 
		[ ] lsExcelData = ReadExcelTable(sPaymentSyncData, sBankingTransactionWorksheet)
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //CONNECT TO EXCEL AND READ EXCEL WORKSHEET
	[+] // do
		[ ] // // // // connect to the database and Reading excel file
		[ ] // // hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sPaymentSyncData}{DB_CONNECT_SUFFIX}")
		[ ] // // //execute a SQL statement
		[ ] // // hSQL = DB_ExecuteSQL (hDB, "{SQL_QUERY_START}[{sBankingTransactionWorksheet}$]")//while there are still rows to retrieve
		[ ] // 
		[ ] // lsExcelData = ReadExcelTable(sPaymentSyncData, sBankingTransactionWorksheet)
		[ ] // // bWorksheet=TRUE
		[ ] // print(lsExcelData)
	[+] // except
		[ ] // ReportStatus("Worksheet verification", WARN, "Worksheet {sBankingTransactionWorksheet} not found") 
		[ ] // 
	[ ] 
	[ ] 
	[ ] 
	[ ] // Lauch Quicken
	[-] // if (!QuickenWindow.Exists ())
		[ ] // //QuickenWindow.Start ("{QUICKEN_ROOT}" + "\qw.exe")
		[ ] // App_Start(sCmdLine)
		[ ] 
	[ ] // Create a new data file for Online account
	[ ] 
	[ ] // Replace QwAuto with TextClick()
	[+] // if (QuickenWindow.Exists() == True)
		[ ] // // Navigate to Edit > Preferences
		[ ] // QuickenWindow.SetActive()
		[ ] // //QuickenMainWindow.SetActive()
		[ ] // QuickenWindow.Edit.Click()
		[ ] // QuickenWindow.Edit.Preferences.Select()
		[ ] // 
		[-] // if(Preferences.Exists(2))
			[ ] // sHandle = Str(Preferences.SelectPreferenceType1.ListBox1.GetHandle())
			[ ] // sExpected = "Downloaded Transactions"
			[ ] // // find the Register option in Prefernces window
			[-] // for( i = 11; i<=15; i++)
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
				[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
				[-] // if(bMatch == TRUE)
					[ ] // bFlag=TRUE
					[ ] // QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(i))		// Select Download Transactions option
					[ ] // // Check the avalability of the checkbox
					[-] // if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
						[ ] // // UnCheck the checkboxes of Automatically download transaction and apply naming rules to downloaded transactions  if it is unchecked
						[-] // if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
								[ ] // Preferences.AutomaticallyAddDownloadedT.UnCheck ()
								[ ] // //Preferences.ApplyRenamingRulesToDownloadedT.Uncheck()
								[ ] // 
								[ ] // Preferences.OK.Click()
						[-] // else
								[ ] // Preferences.OK.Click()
								[ ] // 
					[+] // else
							[ ] // Preferences.Close()
					[ ] // 
					[ ] // break
				[-] // else 
					[-] // bFlag = FALSE
							[-] // if(i==15)
								[ ] // ReportStatus("Validate Download Transaction option'", FAIL, "Download Transaction option is not available") 
							[-] // else
								[ ] // continue
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[-] if (QuickenWindow.Exists(15))
		[ ] 
		[ ] // Navigate to Edit > Preferences
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[-] if(Preferences.Exists(2))
			[ ] 
			[ ] sExpected = "Downloaded transactions"
			[ ] 
			[ ] Preferences.SelectPreferenceType1.ListBox1.TextClick(sExpected)
			[+] if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
					[ ] Preferences.AutomaticallyAddDownloadedT.UnCheck ()
					[ ] Preferences.OK.Click()
					[ ] 
			[-] else
					[ ] Preferences.OK.Click()
					[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Local Web request window should not come 
			[ ] QuickenWindow.SetActive()
			[ ] // Add Online Account
			[ ] iSelect=ExpandAccountBar()
			[-] if(iSelect==PASS)
				[+] if(AddAccount.Exists(5))
					[ ] AddAccount.No.Click()
					[ ] 
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
				[ ] AddAccount.Checking.Click()
				[+] if(QuickenUpdateStatus.Exists(10))
					[ ] QuickenUpdateStatus.StopUpdate.Click()
					[ ] 
				[ ] 
				[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.EnterTheNameOfYourBank.TypeKeys(sFIName)
				[ ] AddAnyAccount.Next.Click()
				[ ] // Provide different DAT files for Local file responses
				[-] if (FakeResponse.Exists(15) == TRUE)
					[ ] iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
					[ ] ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
					[ ] 
				[+] else
					[ ] ReportStatus("Fake Respose Window", WARN, "Branding Response is not asked") 
					[ ] 
				[ ] //AddAnyAccount.Next.Click()
				[-] if (AddAnyAccount.Exists(15) == TRUE)
					[ ] AddAnyAccount.SetActive()
					[ ] 
					[ ] AddAnyAccount.BankMemberNumber.SetText(sMFCUAccountId)
					[ ] AddAnyAccount.BankPassword.SetText("12345")			// Any random passord is OK
					[ ] AddAnyAccount.Connect.Click()
					[ ] 
					[ ] 
					[ ] sleep(2)
					[ ] 
					[-] if (FakeResponse.Exists(15) == TRUE)
						[ ] iResponseStatus = EnterFakeResponseFile(sProfileResponse)
						[ ] ReportStatus("Profile Response ", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
						[ ] 
						[ ] sleep(2)
						[ ] 
						[-] if (FakeResponse.Exists(15) == TRUE)
							[ ] iResponseStatus = EnterFakeResponseFile(sAccountInfoResponse)
							[ ] ReportStatus("Account Info  Response ", iResponseStatus, "Fake Response - {sAccountInfoResponse} is entered")
						[ ] 
						[ ] sleep(2)
						[ ] 
						[ ] 
						[-] if(AddAnyAccount.Exists(SHORT_SLEEP))
							[ ] AddAnyAccount.SetActive()
							[ ] sleep(10)
							[ ] AddAnyAccount.Next.Click()
							[ ] 
						[ ] //Added by Mukesh Oct 22 2012
						[ ] // iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
						[ ] // ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
						[ ] // 
						[ ] // iResponseStatus = EnterFakeResponseFile(sProfileResponse)
						[ ] // ReportStatus("Profile  Response ", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
						[ ] 
						[ ] sleep(2)
						[ ] 
						[-] if (FakeResponse.Exists(15) == TRUE)
							[ ] iResponseStatus = EnterFakeResponseFile(sPaymentSyncResponse)
							[ ] ReportStatus("Profile  Response ", iResponseStatus, "Fake Response - {sPaymentSyncResponse} is entered")
						[ ] 
						[ ] sleep(20)
						[ ] 
						[-] if (FakeResponse.Exists(15) == TRUE)
							[ ] iResponseStatus = EnterFakeResponseFile(sStmtResponse)
							[ ] ReportStatus("Statement Response ", iResponseStatus, "Fake Response - {sStmtResponse} is entered")
						[ ] 
						[ ] 
						[ ] sleep(20)
						[ ] //Closing Local web Request popup
						[-] if(LocalWebRequest.Exists(SHORT_SLEEP))
							[ ] LocalWebRequest.SetActive()
							[ ] LocalWebRequest.FailRequest.Click()
							[ ] //.Click (1,5,5)
						[ ] sleep(20)
						[ ] //Complete the process by clicking on Finish button
						[ ] AccountAdded.SetActive()
						[ ] AccountAdded.Finish.Click()
						[ ] ReportStatus("Account Add  ", PASS, "Account added sucessfully")
						[ ] 
					[+] else
						[ ] ReportStatus("Fake Respose Window", FAIL, "Fake Respose window is not available") 
						[ ] 
				[+] else
					[ ] ReportStatus("Checking Account Window", FAIL, "Checking Account window is not available") 
				[ ] 
				[ ] 
				[-] if (DlgReplaceExistingID.Exists(60))
					[ ] DlgReplaceExistingID.SetActive()
					[ ] DlgReplaceExistingID.NoButton.Click()
				[ ] 
				[ ] 
				[ ] //Verify Accounts are displayed on Account Bar
				[ ] QuickenWindow.SetActive()
				[ ] hWnd = str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
				[ ] 
				[ ] //Verify Checking account on AccountBar
				[ ] sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
				[ ] bMatchStatus = MatchStr("*{sCheckingAccount}*", sActualOutput)
				[+] if (bMatchStatus == TRUE)
					[ ] ReportStatus("Validate Checking Account", PASS, "Checking Account -  {sCheckingAccount} is present in Account Bar") 
				[+] else
					[ ] ReportStatus("Validate Checking Account", FAIL, "Actual -  {sActualOutput} is not matching with Expected - {sCheckingAccount}") 
				[ ] 
				[ ] UsePopupRegister("OFF")
				[ ] SelectAccountFromAccountBar(sCheckingAccount,ACCOUNT_BANKING)
				[ ] 
				[ ] //MATCH ENDING BALANCE OF THE ACCOUNT ADDED
				[ ] INTEGER iResult= PASS
				[ ] STRING actualBalance=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
				[ ] ///Remove   ------/BankingPopUp.EndingBalance.OnlineBalance.GetText()
				[ ] bMatch = MatchStr(sExpEndingbalance, actualBalance)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate Download transaction", PASS, "Ending balance  {actualBalance} and {sExpEndingbalance} matching successfully")
				[+] else
					[ ] ReportStatus("Validate Download transaction", FAIL, "Ending balance {actualBalance} and {sExpEndingbalance}  not matching successfully")
				[ ] 
				[ ] 
				[ ] //MATCH PAYMENT SYNC TRANSACTION AFTER ADD ACCOUNT
				[ ] WaitForState(MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions,TRUE,3)
				[ ] sPaymentSync=MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.GetCaption()
				[ ] print(sPaymentSync)
				[ ] 
				[ ] 
				[ ] bMatch = MatchStr("*{sActualPaymentSyncCount}*", sPaymentSync)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate Download transactions", PASS, "Downloaded transactions  {sActualCount}  matching successfully")
					[ ] bGlobalTransactionCount=TRUE
					[ ] 
					[ ] //Read Payment Sync Data
					[ ] 
					[ ] hWnd = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] sPaymentSyncActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  str(0))
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsPaymentSyncTransactionData);i++)
						[ ] bMatch=MatchStr("*{lsPaymentSyncTransactionData[i]}*",sPaymentSyncActualOutput)
						[-] if(bMatch==TRUE)
							[ ] ReportStatus("Validate Payment Sync  transaction", PASS, "Payment Sync transactions  {lsPaymentSyncTransactionData[i]} matched successfully")
							[ ] 
							[ ] //MDIClient.AccountRegister.QWSnapHolder1.StaticText2.Continue.Click()
							[ ] 
							[ ] 
						[-] else
							[ ] ReportStatus("Validate Payment Sync  transaction", PASS, "Payment Sync transactions  {lsPaymentSyncTransactionData[i]} not matched successfully to transaction {sPaymentSyncActualOutput}")
							[ ] 
							[ ] 
					[ ] MDIClient.AccountRegister.QWSnapHolder1.StaticText2.AcceptAll.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Download transactions", FAIL, "Downloaded transactions {sActualCount} does not match")
					[ ] bGlobalTransactionCount=FALSE
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //MATCH DOWNLOADED TRANSACTIONS AFTER ADD ACCOUNT
				[ ] WaitForState(MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions,TRUE,3)
				[ ] STRING sDownloadedTransaction=MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.GetCaption()
				[ ] 
				[ ] print(sDownloadedTransaction)
				[ ] STRING TotalTxnCount
				[ ] TotalTxnCount=StrTran(sDownloadedTransaction,"Downloaded Transactions (","")
				[ ] TotalTxnCount= GetField(TotalTxnCount,")",1) 
				[ ] bMatch = MatchStr(sActualCount, TotalTxnCount)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate Download transactions", PASS, "Downloaded transactions  {sActualCount} and {TotalTxnCount} matching successfully")
					[ ] bGlobalTransactionCount=TRUE
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Download transactions", FAIL, "Downloaded transactions {sActualCount} and {TotalTxnCount}  not matching successfully")
					[ ] bGlobalTransactionCount=FALSE
				[ ] 
				[ ] 
				[ ] 
				[ ] //MATCH THE TRANSACTION IN C2R AND EXCEL DATA SHEET
				[ ] hWnd = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] 
				[+] // if(bWorksheet==TRUE)
					[ ] INTEGER sExcelRow, sExcelCell, sTransactionRow, sTransactionCell
					[ ] // Fetch data  from the given sheet
					[ ] print("Data from Excel")
					[+] for(sExcelRow=1;sExcelRow<=ListCount(lsExcelData);sExcelRow++)
						[ ] lsData=lsExcelData[sExcelRow]
						[-] for(sExcelCell=1; sExcelCell<7; sExcelCell++)
							[-] if lsData[sExcelCell]==NULL
								[ ] ListAppend (lsExcelCellData, "NULL")
							[-] else
								[ ] ListAppend (lsExcelCellData, lsData[sExcelCell])
					[ ] print(lsExcelCellData) //REMOVE
					[ ] print("Data from C2R")
					[+] for(sTransactionRow=0;sTransactionRow<=(ListCount(lsExcelData)*2-1);sTransactionRow=sTransactionRow+2)
						[ ] sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  str(sTransactionRow))
						[-] for(sTransactionCell=1; sTransactionCell<7; sTransactionCell++)
							[-] if GetField (sActualOutput, "@", sTransactionCell) == ""
								[ ] //print("NULL")
								[ ] ListAppend (lsC2RData, "NULL")
							[-] else
								[ ] //Print (GetField (sActualOutput, "@", sTransactionCell) )
								[ ] ListAppend (lsC2RData, (GetField (sActualOutput, "@", sTransactionCell) ))
								[ ] 
					[ ] print(lsExcelCellData)
					[ ] print(lsC2RData)
					[+] if lsExcelCellData == lsC2RData
						[ ] ReportStatus("Validate Download transactions ", PASS, "All the transactions from data excel sheet and C2R registry matched")
					[+] else
						[ ] ReportStatus("Validate Download transactions ", FAIL, "Transactions from data excel sheet and C2R registry are not matched")
					[ ] 
					[ ] //Accept All downloaded transactions and matach the number of transactions
					[ ] MDIClient.AccountRegister.QWSnapHolder1.StaticText2.AcceptAll.Click()
					[ ] 
					[ ] TotalTxnCount=MDIClient.AccountRegister.Balances.TransactionCount.GetText()
					[ ] 
					[ ] TotalTxnCount= GetField(TotalTxnCount," Transactions",1) 
					[ ] bMatch = MatchStr(sTransactionsAfterAccept,TotalTxnCount)
					[-] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Download transactions ", PASS, "After Accepting downloaded transactions Total transactions  {sTransactionsAfterAccept} and {TotalTxnCount} matching successfully")
					[-] else
						[ ] ReportStatus("Validate Download transactions", FAIL, "After Accepting downloaded transactions Total transactions {sTransactionsAfterAccept} and {TotalTxnCount}  not matching successfully")
					[ ] 
					[ ] print(MDIClient.AccountRegister.Balances.EndingBalance.GetText())
					[ ] actualBalance=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
					[ ] 
					[ ] 
					[ ] bMatch = MatchStr(sExpEndingBalanceAfterAccept, actualBalance)
					[-] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Download transactions", PASS, "After Accepting downloaded transactions Ending balance  {actualBalance} and {sExpEndingBalanceAfterAccept} matching successfully")
					[+] else
						[ ] ReportStatus("Validate Download transactions", FAIL, "After Accepting downloaded transactions Ending balance {actualBalance} and {sExpEndingBalanceAfterAccept}  not matching successfully")
					[ ] 
					[ ] 
				[+] // else
					[ ] // ReportStatus("Match Worksheet values with C2R Transactions",FAIL,"Worksheet not found")
					[ ] // 
				[ ] 
				[ ] 
				[ ] // Match the accepted transaction by using quicken Find functionality
				[+] for(sExcelRow=1;sExcelRow<=ListCount(lsExcelData);sExcelRow++)
					[ ] lsData=lsExcelData[sExcelRow]
					[+] for(sExcelCell=2; sExcelCell<5; sExcelCell++)
							[ ] 
							[ ] 
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] 
							[ ] ////#########Commented by Mukesh Aug 29 2012 as Find button is no longer available on QW13#####///
							[ ] //BankingPopUp.Find.click()
							[ ] // QuickenFind.SetActive()
							[ ] ////#########Commented by Mukesh Aug 29 2012 as Find button is no longer available on QW13#####///
							[ ] 
							[ ] QuickenWindow.TypeKeys(KEY_CTRL_F)
							[ ] 
							[ ] //QuickenWindow.TypeKeys(KEY_CTRL_H)
							[ ] 
							[ ] WaitForState(QuickenFind,TRUE,5)
							[ ] 
							[ ] QuickenFind.SetActive()
							[ ] //Handle Null values in the excel sheet
							[-] if (lsData[sExcelCell]!=NULL)
								[+] switch(sExcelCell)
									[ ] 
									[ ] 
									[-] case 2
										[ ] QuickenFind.FindAnyField.Select("Date")
										[ ] QuickenFind.Contains.Select("Exact")
										[ ] QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
									[-] case 3
										[ ] QuickenFind.FindAnyField.Select("Check number")
										[ ] QuickenFind.Contains.Select("Exact")
										[ ] QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
									[-] case 4
										[ ] QuickenFind.FindAnyField.Select("Payee")
										[ ] QuickenFind.Contains.Select("Contains")
										[ ] string tempPayee= GetField(lsData[sExcelCell]," /",1)
										[ ] QuickenFind.QuickenFind.SetText(tempPayee)
										[ ] QuickenFind.TypeKeys(KEY_TAB)
										[ ] QuickenFind.TypeKeys(KEY_TAB)
										[ ] sleep(1)
									[-] default
										[ ] QuickenFind.FindAnyField.Select("Any Field")
										[ ] QuickenFind.Contains.Select("Contains")
										[ ] QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
								[ ] 
								[ ] 
								[ ] //MATCH NUMBER OF TRANSACTIONS IN SEARCH RESULTS POP UP
								[ ] QuickenFind.SetActive()
								[ ] QuickenFind.FindAll.click()
								[-] if(SearchResultsWindow.Exists())
									[ ] SearchResultsWindow.SetActive()
									[ ] STRING sText=SearchResultsWindow.TransactionCount.GetText()
									[ ] bMatch = MatchStr("*Found in 1 transaction*",sText)
									[-] if(bMatch == TRUE)
										[ ] ReportStatus("Search Transaction in Registry ", PASS, "Transaction {lsData[sExcelCell]} found in account registry")
									[-] else
										[ ] ReportStatus("Search Transaction in Registry ", FAIL, "Transaction {lsData[sExcelCell]} not found in account registry")
									[ ] SearchResultsWindow.SetActive()
									[ ] SearchResultsWindow.Close()
									[ ] sleep(2)
								[-] else
									[-] if QuickenFind.Exists()
										[ ] QuickenFind.Close()
				[ ] 
				[ ] 
				[ ] //Match the Payment sync transactions
				[+] for(sExcelCell=2;sExcelCell<=ListCount(lsPaymentSyncTransactionData);sExcelCell++)
					[ ] lsData=lsPaymentSyncTransactionData
					[ ] 
					[+] switch(sExcelCell)
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_F)
						[ ] 
						[ ] 
						[-] case 2
							[ ] QuickenFind.FindAnyField.Select("Date")
							[ ] QuickenFind.Contains.Select("Exact")
							[ ] QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
						[-] case 3
							[ ] QuickenFind.FindAnyField.Select("Payee")
							[ ] QuickenFind.Contains.Select("Contains")
							[ ] QuickenFind.QuickenFind.SetText(tempPayee)
							[ ] QuickenFind.TypeKeys(KEY_TAB)
							[ ] QuickenFind.TypeKeys(KEY_TAB)
							[ ] sleep(1)
						[-] case 4
							[ ] QuickenFind.FindAnyField.Select("Amount")
							[ ] QuickenFind.Contains.Select("Exact")
							[ ] QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
						[-] default
							[ ] QuickenFind.FindAnyField.Select("Any Field")
							[ ] QuickenFind.Contains.Select("Contains")
							[ ] QuickenFind.QuickenFind.SetText(lsData[sExcelCell])
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //MATCH NUMBER OF TRANSACTIONS IN SEARCH RESULTS POP UP
					[ ] QuickenFind.SetActive()
					[ ] QuickenFind.FindAll.click()
					[-] if(SearchResultsWindow.Exists())
						[ ] SearchResultsWindow.SetActive()
						[ ] sText=SearchResultsWindow.TransactionCount.GetText()
						[ ] bMatch = MatchStr("*Found in 1 transaction*",sText)
						[-] if(bMatch == TRUE)
							[ ] ReportStatus("Search Transaction in Registry ", PASS, "Transaction {lsData[sExcelCell]} found in account registry")
						[-] else
							[ ] ReportStatus("Search Transaction in Registry ", FAIL, "Transaction {lsData[sExcelCell]} not found in account registry")
						[ ] SearchResultsWindow.SetActive()
						[ ] SearchResultsWindow.Close()
						[ ] sleep(2)
					[-] else
						[-] if QuickenFind.Exists()
							[ ] QuickenFind.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Expand Account Bar",FAIL,"Account bar couldn't be identified")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Preferences window is launched",FAIL,"Preferences window is NOT launched")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
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
[ ] // Updated By Abhijit S, June 2015
[+] testcase Test2_OneStepUpdateForMissionFederalCreditUnion() appstate none //QuickenBaseState
	[+] // Variable
		[ ] LIST OF ANYTYPE lsExcelCellData, lsC2RData,lsAddAccount
		[ ] STRING hWnd, sActualOutput
		[ ] STRING sCaption
		[ ] BOOLEAN bCaption
		[ ] STRING sActualCount ="0"
		[ ] //Respose files for Local File Testing
		[ ] STRING sBrandingResponse =sFileFolder+"1_brand_resp.dat"
		[ ] STRING sProfileResponse =sFileFolder+"2_prof_resp.dat"
		[ ] STRING sStmtResponse =sFileFolder+"5_stmt_resp.dat"
		[ ] STRING sBankingTransactionWorksheet="transactionsAfterOSU"
		[ ] BOOLEAN bWorksheet = FALSE
		[ ] INTEGER iValidate
		[ ] 
	[ ] 
	[-] //Variable declaration
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // connect to the database and Reading excel file
		[-] do
			[ ] // hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sPaymentSyncData}{DB_CONNECT_SUFFIX}")
			[ ] // //execute a SQL statement
			[ ] // hSQL = DB_ExecuteSQL (hDB, "{SQL_QUERY_START}[{sBankingTransactionWorksheet}$]")//while there are still rows to retrieve
			[ ] lsExcelData = ReadExcelTable(sPaymentSyncData, sBankingTransactionWorksheet)
			[ ] bWorksheet=TRUE
			[ ] print(lsExcelData)
		[-] except
			[ ] ReportStatus("Worksheet verification", WARN, "Worksheet {sBankingTransactionWorksheet} not found") 
			[ ] 
		[ ] //Open existing online data files //By Pass the registration
		[ ] // OpenDataFile(sOnlieAccountFileName)
		[+] // if(QuickenConnectedServices.Exists(10))
			[ ] // RegisterQuickenConnectedServices()
		[ ] 
		[ ] 
		[ ] //Matching the actual file is open of not.
		[ ] sCaption = QuickenWindow.GetCaption()
		[ ] bCaption = MatchStr("*{sOnlineAccountFileName}*", sCaption)
		[-] if(bCaption==TRUE)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] //Click on one step update 
			[ ] INTEGER iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
			[+] if(UnlockYourPasswordVault.Exists(5))
				[ ] UnlockYourPasswordVault.SetActive()
				[ ] UnlockYourPasswordVault.Skip.Click()
				[ ] 
				[ ] 
			[ ] 
			[ ] sleep(2)
			[+] if (FakeResponse.Exists(10) == TRUE)
				[ ] //Added by Mukesh Oct 22 2012
				[ ] iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
				[ ] ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
				[ ] 
				[+] if(QuickenConnectedServices.Exists(10))
					[ ] RegisterQuickenConnectedServices()
				[ ] 
				[ ] 
			[+] if(iNavigate == PASS)
				[-] if(OneStepUpdate.Exists(10))
					[ ] OneStepUpdate.SetActive ()
					[ ] //Entering password and click Update button
				[ ] OneStepUpdate.OneStepUpdateSettings3.ListBox1.AccountPassword.SetText("12345")
				[ ] OneStepUpdate.UpdateNow.Click ()		
				[ ] 
				[ ] //Click on NO button of remeber password option of One Step Update message box
				[+] if(OneStepUpdateMessagebox.Exists(10))
					[ ] OneStepUpdateMessagebox.SetActive()
					[ ] OneStepUpdateMessagebox.No.Click()
					[ ] 
				[ ] 
				[ ] 
				[ ] //Providing response files
				[+] if (FakeResponse.Exists(15) == TRUE)
					[ ] iResponseStatus = EnterFakeResponseFile(sProfileResponse)
					[ ] ReportStatus("Log On Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
					[ ] 
					[ ] sleep(2)
					[ ] 
					[ ] iResponseStatus = EnterFakeResponseFile(sStmtResponse)
					[ ] ReportStatus("Get Institutional Response", iResponseStatus, "Fake Response - {sStmtResponse} is entered")
					[ ] 
					[ ] // //Closing Local web Request popup
					[+] // if(MessageBox.FileDlg("Local Web Request").Exists())
						[ ] // MessageBox.FileDlg("Local Web Request").SetActive()
						[ ] // MessageBox.FileDlg("Local Web Request").CustomWin("[WindowsForms10.BUTTON.app.0.378734a]Fail Request|#3|$854190|@(388,541)").click()
					[ ] 
					[+] if(LocalWebRequest.Exists(5))
						[ ] LocalWebRequest.SetActive()
						[ ] LocalWebRequest.FailRequest.Click()
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[+] if(OneStepUpdateSummary.Exists())
						[ ] OneStepUpdateSummary.Close.Click()
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] ReportStatus("Validate Download transactions", PASS, "Transactions downloaded successfully with OSU")
			[ ] 
			[ ] //QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.Click(1,38, 5)
			[ ] SelectAccountFromAccountBar(sCheckingAccount,ACCOUNT_BANKING)
			[ ] 
			[ ] 
			[ ] //MATCH DOWNLOADED TRANSACTIONS AFTER  OSU
			[ ] //STRING sDownloadedTransaction=BankingPopUp.EndingBalance.DownloadedTransactions.DownloadedTransactionsTab.GetCaption()
			[ ] STRING sDownloadedTransaction=MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.GetCaption()
			[ ] print("Downloaded Transactions {sDownloadedTransaction}" )
			[ ] STRING TotalTxnCount
			[ ] TotalTxnCount=StrTran(sDownloadedTransaction,"Downloaded Transactions (","")
			[ ] TotalTxnCount= GetField(TotalTxnCount,")",1) 
			[ ] bMatch = MatchStr(sActualCount, TotalTxnCount)
			[-] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Download transactions", PASS, "Downloaded transactions  {sActualCount} and {TotalTxnCount} matching successfully")
			[+] else
				[ ] ReportStatus("Validate Download transactions", FAIL, "Downloaded transactions {sActualCount} and {TotalTxnCount}  not matching successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //MATCH THE TRANSACTION IN C2R AND EXCEL DATA SHEET
			[ ] // BankingPopUp.EndingBalance.DownloadedTransactions.DownloadedTransactionsTab.Click()
			[ ] //Quicken2012Popup.SetActive()
			[ ] 
			[ ] // 
			[ ] // //hWnd = str(BankingPopUp.QWSnapHolder.AcceptClearenceTransaction.QWListViewer1.ListBox1.GetHandle())
			[ ] // 
			[ ] // hWnd = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
			[ ] // 
			[+] // if(bWorksheet==TRUE)
				[ ] // INTEGER sExcelRow, sExcelCell, sTransactionRow, sTransactionCell
				[ ] // // Fetch data  from the given sheet
				[ ] // print("Data from Excel")
				[+] // for(sExcelRow=1;sExcelRow<=ListCount(lsExcelData);sExcelRow++)
					[ ] // lsData=lsExcelData[sExcelRow]
					[-] // for(sExcelCell=1; sExcelCell<7; sExcelCell++)
						[-] // if lsData[sExcelCell]==NULL
							[ ] // ListAppend (lsExcelCellData, "NULL")
						[-] // else
							[ ] // ListAppend (lsExcelCellData, lsData[sExcelCell])
				[ ] // print("Data from C2R")
				[+] // for(sTransactionRow=0;sTransactionRow<=(ListCount(lsExcelData)*2-1);sTransactionRow=sTransactionRow+2)
					[ ] // sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  str(sTransactionRow))
					[-] // for(sTransactionCell=1; sTransactionCell<7; sTransactionCell++)
						[-] // if GetField (sActualOutput, "@", sTransactionCell) == ""
							[ ] // //print("NULL")
							[ ] // ListAppend (lsC2RData, "NULL")
						[-] // else
							[ ] // //Print (GetField (sActualOutput, "@", sTransactionCell) )
							[ ] // ListAppend (lsC2RData, (GetField (sActualOutput, "@", sTransactionCell) ))
							[ ] // 
				[ ] // print(lsExcelCellData)
				[ ] // print(lsC2RData)
				[+] // if lsExcelCellData == lsC2RData
					[ ] // ReportStatus("Validate Download transactions ", PASS, "All the transactions from data excel sheet and C2R registry matched")
				[-] // else
					[ ] // ReportStatus("Validate Download transactions ", FAIL, "Transactions from data excel sheet and C2R registry are not matched")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Worksheet verification", FAIL, "Could not read excel Worksheet {sBankingTransactionWorksheet}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify data file that is open",FAIL,"Incorrect data file is open")
			[ ] 
	[+] // else
		[ ] // ReportStatus("Verify If all transactions are not downloaded",FAIL,"OSU for Payment not executed as Test Test1_AddMissionFederalCreditUnionAccount failed")
		[ ] // 
		[ ] // 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[-] //############# Beacon Clean ############# #####################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 BeaconClean()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken, Delete Ini . file and Data File
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while closing the window							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  June 23, 2011		Puja Verma  created	
		[ ] // Updated By Abhijit S, June 2015
	[ ] //*********************************************************
[-] testcase PaymentSyncClean() appstate none//QuickenBaseState
	[ ] //VARAIBLE
	[ ] //STRING sDestinationonliniFile="C:\Documents and Settings\All Users\Application Data\Intuit\Quicken\Config\intu_onl.ini"
	[ ] STRING sTempFolder="{AUT_DATAFILE_PATH}\PaymentSyncData"
	[ ] STRING sOriginalFidir ="C:\ProgramData\Intuit\Quicken\Inet\Common\Localweb\Banklist\2016\fidir.txt"
	[ ] STRING sKeepFidir="{AUT_DATAFILE_PATH}\PaymentSyncData\FIDIR\fidr.txt"
	[+] if(QuickenWindow.Exists() == TRUE)
		[ ] QuickenWindow.Kill()
	[ ] // Delete the INI file, quicken data file and the temp directory of local file response
	[ ] // Delete the C:\Program Files\Quicken\qa_acc32.dll 
	[+] if(FileExists(sAccDllDestinationPath) == TRUE)
		[ ] DeleteFile(sAccDllDestinationPath)
	[ ] // Delete the ....Application Data\Intuit\Quicken\Config\Intu_onl.ini file
	[+] if(FileExists(sDestinationonliniFile) == TRUE)
		[ ] DeleteFile( sDestinationonliniFile)
	[ ] // Delete the Quicken data file
	[+] if(FileExists(sOnlineAccountFilePath))
		[ ] DeleteFile(sOnlineAccountFilePath)
	[ ] //Delete OFX log
	[+] if(FileExists(sOnlineOFXLogPath))
		[ ] DeleteFile(sOnlineOFXLogPath)
	[ ] //Delete the temp response folder
	[+] if(FileExists(sTempFolder))
		[ ] DeleteDir(sTempFolder)
	[ ] DeleteFile(sOriginalFidir)
	[ ] CopyFile(sKeepFidir,sOriginalFidir)
	[ ] DeleteFile(sKeepFidir)
	[ ] // 
[ ] // //###########################################################################
