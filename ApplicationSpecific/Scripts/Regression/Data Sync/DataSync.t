	[ ] 
[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<DataSync.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Data Sync test cases for Quicken Desktop : This will not include QM part and data verification on cloud
	[ ] //
	[ ] // DEPENDENCIES:	includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube/ Mukesh Mishra/ Dean 
	[ ] //
	[ ] // Developed on: 		24/01/2013
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Jan 24, 2013	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[-] // Global variables used for DataSync Test cases
	[ ] public STRING sFileName = "EWCDataFile"
	[ ] public STRING sDCFileName = "DCDataFile"
	[ ] //public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sSyncData = "SyncTestData"
	[ ] public STRING sTxnWorksheet = "Test"
	[ ] 
	[ ] public LIST OF ANYTYPE  lsExcelData , lsExcelDataFromQm, lsQDResultFile, lsQMResultFile, lsRowData
	[ ] public STRING sCaption,sAmountPaidExpected,sAmountPaidActual,sAccount,sDateStamp, sAccountType,sAccountId,sAccountName
	[ ] public BOOLEAN bCaption,bExists
	[ ] LIST OF ANYTYPE  lsCloudUserData,lsReminder,lsUserCredentials,lsTransaction,lsAccountId,lsAccountName ,lsAddAccount
	[ ] LIST OF ANYTYPE lsMlgTrans, lsListBoxItems, lsAccountResponse ,lsAccount, lsStringData, lsExcelAccountData , lsCategoryData ,lsCategoryName
	[ ] 
	[ ] // STRING sFileName="MobileSyncData"
	[ ] LIST OF ANYTYPE lsReqResponse, lsFITID, lsRequestParameters , lsRequestData, lsTemp,lsTemp2, lsDescription, lsCategoryExcelData
	[ ] LIST OF ANYTYPE lsCatTxnExcelData, lsCategoriesTransactions , lsCatResponse , lsResponse ,lsCategoryId
	[ ] public STRING sMobileSyncData = "MobileSyncData"
	[ ] public STRING sCloudIdData = "CloudIdData"
	[ ] public STRING sTransactionSheet = "Checking Transaction"
	[ ] public STRING sCCMintBankCredentials = "CCMintBank Credentials"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sAccountsAddedWorksheet = "AccountsAdded"
	[ ] public STRING sInvestingTransactionWorksheet = "Investing Transaction"
	[ ] public INTEGER iAddAccount,iSelect, iAmount,iCounter,iAddTransaction ,iZipcode,iResult, iActualData, iAmountExpected, iAmountActual
	[ ] public STRING hWnd,sActual,sItem, sCategory,sExpected, sActualText,sReqItem,sRespItem ,sCategoryName , sCategoryId ,sCategoryIdVal
	[ ] public STRING  sMenuItem , sTransactionCount , sActualOnlineBalance ,sActualEndingBalance
	[ ] public boolean bMatch
	[ ] public INTEGER iCount, iLog, iAccCount, iAccountId, iItemCounter, iVerify , iSync , iNum
	[ ] public STRING sOnlineTransactions = "OnlineTransactions"
	[ ] public STRING sDCOnlineTransactions = "DCOnlineTransactions"
	[ ] public STRING sPaycheckAccTrans = "PaycheckAccTrans"
	[ ] public STRING sManualTransactions= "ManualTransactions"
	[ ] public STRING sSyncCategoriesSheet= "SyncCategoriesSheet"
	[ ] public STRING sSyncCategoriesTransactions= "SyncCategoriesTransactions"
	[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\Data Sync\" + sFileName + ".QDF"
	[ ] STRING sOriginalDataFile = AUT_DATAFILE_PATH + "\DataSyncTestData\" + sFileName + ".QDF"
	[ ] STRING sSyncLogFile = AUT_DATAFILE_PATH + "\Data Sync\" + sFileName +"_SyncLog.dat"
	[ ] STRING sDCSyncLogFile = AUT_DATAFILE_PATH + "\Data Sync\" + sDCFileName +"_SyncLog.dat"
	[ ] STRING sDataFileLocation = AUT_DATAFILE_PATH + "\Data Sync" 
	[ ] STRING sQMResultFileLocation = "D:"
	[ ] public STRING sPopUpWindow = "PopUp"
	[ ] public STRING sMDIWindow = "MDI"
	[ ] 
[ ] 
[ ] 
[+] //#############  EWC Sync SetUp #############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_EWC()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync EWC accounts and verify request and responces
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 24, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] // testcase DataSync_EWC () appstate none
	[ ] // 
	[ ] // // Variable declaration
	[ ] // INTEGER iNavigate,iLogin,iLog,iCounter,iAmount,i,j,iDeleteLog
	[ ] // STRING sCloudId,sPwd,sZip,sItem,sResponseItem,sPayee1,sPayee2,sPayee3
	[ ] // LIST OF ANYTYPE lsResponse,lsResultData1,lsData,lsRequestParameters,lsKey,lsValue,lsResponseList,lsResultData2,lsResultData3
	[ ] // BOOLEAN bAssert,bMatch
	[ ] // 
	[ ] // sCloudId="synctest22+4@gmail.com"
	[ ] // sPwd="qwerty"
	[ ] // sZip="12345"
	[ ] // // sPayee1 = "Minor Income_EWC_Checking"
	[ ] // // sPayee2="Ent_EWC_Checking"
	[ ] // // sPayee3="Paycheck_EWC_Checking"
	[ ] // 
	[ ] // // Read data from excel sheet
	[ ] // lsExcelData=ReadExcelTable(sSyncData, sTxnWorksheet)
	[ ] // lsKey=lsExcelData[1]
	[ ] // 
	[+] // if(QuickenWindow.Exists())
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] // 
		[ ] // // iNavigate=NavigateQuickenTab(sTAB_MOBILE_ALERTS,sTAB_QUICKEN_MOBILE)
		[ ] // // ReportStatus("Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}",iNavigate,"Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}")
		[ ] // 
		[ ] // iLogin=MobileSignUp(sCloudId,sPwd,sZip)
		[ ] // ReportStatus("Signup with {sCloudId}", iLogin, "Signup with {sCloudId} successful")
		[ ] // 
		[ ] // Waitforstate(AccountPasswordTextField,TRUE,SHORT_SLEEP)
		[ ] // 
		[+] // // if(AccountPasswordTextField.Exists())
			[ ] // // AccountPasswordTextField.SetText("datasync")
			[ ] // // AccountPasswordTextField.TypeKeys(KEY_TAB)
			[ ] // // AccountPasswordTextField.TypeKeys(KEY_ENTER)
		[ ] // 
		[ ] // WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click ()
		[ ] // WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,14,34)
		[ ] // 
		[ ] // // Click on Done Button
		[ ] // Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton,TRUE,70)
		[ ] // QuickenWindow.SetActive()
		[ ] // WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton.Click()
		[ ] // 
		[ ] // // Verify Server side error
		[+] // if(AlertMessageBox.Exists(SHORT_SLEEP))
			[ ] // ReportStatus("Server Side Verification",FAIL, "Server side error encountered")
			[ ] // AlertMessageBox.OK.Click()
		[+] // else
			[ ] // Waitforstate(DlgCloudSyncComplete,TRUE,60)
			[+] // if(DlgCloudSyncComplete.Exists())
				[ ] // DlgCloudSyncComplete.OK.Click()
				[+] // if(DlgAccountsSynced.Exists(SHORT_SLEEP))
					[ ] // DlgAccountsSynced.OK.Click()
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Account Synced window",FAIL,"Account Synced window does not appear")
			[+] // else if(DlgAccountsSynced.Exists(MEDIUM_SLEEP))
				[ ] // DlgAccountsSynced.OK.Click()
			[+] // else
				[ ] // ReportStatus("Verify Cloud Sync complete window",FAIL,"Cloud Sync complete window does not appear")
				[ ] // 
		[ ] // 
		[+] // if(WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.HTTP500Error.Exists())
			[ ] // ReportStatus("HTTP 500 Error", FAIL, "HTTP 500 error encountered")
		[ ] // 
		[ ] // Waitforstate(QuickenMainWindow,TRUE,60)
		[ ] // 
		[ ] // iLog=OpenAndSaveCloudSyncLog()
		[ ] // ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
		[ ] // 
		[+] // for(j=1;j<ListCount(lsExcelData);++j)
			[ ] // lsValue=lsExcelData[j+1]
			[+] // for (iCounter=1; iCounter< ListCount(lsKey)+1;++iCounter)
				[+] // if(j==1)
					[ ] //  ListAppend(lsResultData1, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] // else if(j==2)
					[ ] //  ListAppend(lsResultData2, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] // else if (j==3)
					[ ] //  ListAppend(lsResultData3, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Sync Expected data",FAIL,"Expected data can not verify")
			[ ] // 
		[ ] // 
		[ ] // // Verify online transaction
		[ ] // lsResponse=GetOnlineTransactionResponseFromSyncLog(lsExcelData[2][2])
		[+] // for each sResponseItem in lsResponse
			[ ] // sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] // ListAppend(lsResponseList,sResponseItem)
		[ ] // print(lsResponseList)
		[+] // for (iCounter=2; iCounter<=ListCount(lsResultData1);iCounter++)
			[+] //   for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] // 
				[ ] // bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData1[iCounter])
				[+] // if(bMatch==TRUE)
					[ ] // ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData1[iCounter]}")
					[ ] // break
					[ ] // 
				[+] // else
					[+] //  if(i==ListCount(lsResponseList))
						[ ] // ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData1[iCounter]}")
					[+] // else
						[ ] // continue
			[+] // if(iCounter==ListCount(lsResultData1))
				[ ] // break
		[ ] // 
		[ ] // // Verify manual transaction
		[ ] // lsResponse=GetManualTransactionResponseFromCloudSyncLog(lsExcelData[3][2])
		[+] // for each sResponseItem in lsResponse
			[ ] // sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] // ListAppend(lsResponseList,sResponseItem)
		[ ] // print(lsResponseList)
		[+] // for (iCounter=2; iCounter<=ListCount(lsResultData2);iCounter++)
			[+] //   for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] // 
				[ ] // bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData2[iCounter])
				[+] // if(bMatch==TRUE)
					[ ] // ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData2[iCounter]}")
					[ ] // break
					[ ] // 
				[+] // else
					[+] // if(i==ListCount(lsResponseList))
						[ ] // ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData2[iCounter]}")
					[+] // else
						[ ] // continue
			[+] // if(iCounter==ListCount(lsResultData2))
				[ ] // break
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[+] // for(i=2;i<=ListCount(lsExcelData);i++)
			[ ] // SearchTransactionsInRegister(lsExcelData[i][2])
		[ ] // 
		[ ] // 
		[ ] // iDeleteLog=DeleteSyncLogFile(sFileName)
		[ ] // ReportStatus("Delete Log",PASS,"Logs are deleted")
		[ ] // 
		[ ] // DeleteCloudID()
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] // 
[ ] //###########################################################################
[ ] // 
[+] // //############# DataSync_EWC_Manual_VerifyOnlineBalances#############################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 DataSync_EWC_Manual_VerifyOnlineBalances()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will sync EWC accounts and verify request and responses
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs 
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Jan 24, 2013		Mukesh	
	[ ] // // ********************************************************
[-] testcase DataSync_EWC_Manual_VerifyOnlineBalances() appstate DataSyncBaseState
	[ ] STRING sCurrentDate , sFutureDate  ,sAmountOnlineBalanceActual ,sAmountOnlineBalanceExpected  ,sConnectionType ,sFILoginId ,sContentProviderType
	[ ] STRING sAmountEndingBalanceExpected ,scpFIID ,sFIName, sOnlineBalance, sEndingBalance
	[ ] NUMBER nAmountOnlineBalanceExpected ,nAmountOnlineBalanceActual  ,nAmountEndingBalanceActual ,nAmountEndingBalanceExpected 
	[ ] NUMBER nOnlineBalance, nEndingBalance
	[ ] STRING sDCAccountPassword="datasync"
	[ ] STRING sSyncResultFile="SyncResult"
	[ ] STRING sAccountBalanceSheet="AccountBalanceSheet"
	[ ] STRING sQMResultFile="Results testEWCAccountBalance"
	[ ] STRING sQMAccountBalanceSheet = "testEWCAccountBalance"
	[ ] INTEGER icpFIID, iCount
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sCCMintBankCredentials
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCCMintBankCredentials)
	[ ] lsUserCredentials=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sTransactionSheet)
	[ ] 
	[ ] ///rFILoginRecord
	[ ] rFILoginReqRespRecord rFILoginReqResp
	[ ] rFILoginReqResp =lsFILoginRecordValue
	[ ] 
	[ ] ///rAccountReqRespRecord
	[ ] rAccountReqRespRecord rAccountReqResp
	[ ] rAccountReqResp = lsAccountReqRespRecordValue
	[ ] sFutureDate =FormatDateTime ( AddDateTime (GetDateTime (), 1), "m/d/yyyy") 
	[ ] sCurrentDate =FormatDateTime ( AddDateTime (GetDateTime (), 0), "m/d/yyyy") 
	[ ] sExpected="Accounts Synced"
	[ ] 
	[ ] 
	[ ] 
	[-] if(FileExists(sSyncLogFile))
		[ ] DeleteFile(sSyncLogFile)
	[ ] 
	[-] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // //Add Future dated transactions to every account
		[+] for (iCounter=1;  iCounter<4;++iCounter)
			[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, iCounter)
			[+] if(iSelect==PASS)
				[+] for (iCount=1;  iCount<ListCount(lsExcelData)+1;++iCount)
					[ ] lsTransaction=lsExcelData[iCount]
					[+] if (lsTransaction[1]==NULL)
						[ ] break
						[ ] 
						[ ] // sWindowType,STRING sTransactionType, STRING sAmount, STRING sDate , STRING sChequeNo optional, STRING sPayee optional, STRING sMemo  optional, STRING sCategory optional, STRING sTag optional)
						[ ] //WindowType	TransactionMode	Amount	TransactionDate	ChequeNo	Payee	Memo	Category	PayBalance	Account	
					[ ] 
					[ ] sDateStamp =sCurrentDate
					[ ] 
					[ ] lsAccount =lsExcelAccountData[iCounter]
					[+] if (lsAccount[3]=="manual") 
						[ ] sDateStamp=sFutureDate
						[ ] 
					[ ] 
					[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
					[ ] lsTransaction=NULL
			[+] else
				[ ] ReportStatus("Account selection",FAIL,"Account couldn't be selected")
		[+] for (iCounter=4;  iCounter<9;++iCounter)
			[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, iCounter)
			[+] if(iSelect==PASS)
				[+] for (iCount=1;  iCount<ListCount(lsExcelData)+1;++iCount)
					[ ] lsTransaction=lsExcelData[iCount]
					[+] if (lsTransaction[1]==NULL)
						[ ] break
						[ ] 
						[ ] // sWindowType,STRING sTransactionType, STRING sAmount, STRING sDate , STRING sChequeNo optional, STRING sPayee optional, STRING sMemo  optional, STRING sCategory optional, STRING sTag optional)
						[ ] //WindowType	TransactionMode	Amount	TransactionDate	ChequeNo	Payee	Memo	Category	PayBalance	Account	
					[ ] 
					[ ] sDateStamp =sCurrentDate
					[ ] 
					[ ] lsAccount =lsExcelAccountData[iCounter]
					[+] if (lsAccount[3]=="manual")
						[ ] sDateStamp=sFutureDate
						[ ] 
					[ ] 
					[ ] AddSavingCreditCashTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,lsTransaction[6],lsTransaction[7],lsTransaction[8])
					[ ] lsTransaction=NULL
			[+] else
				[ ] ReportStatus("Account selection",FAIL,"Account couldn't be selected")
		[ ] 
		[ ] //Added Future dated transactions to every account
		[ ] 
		[ ] //Mobile SignUp
		[ ] iResult=MobileSignUp()
		[-] if (iResult==PASS)
			[ ] ReportStatus("Mobile user SignUp", PASS, "Mobile user Signed-Up on QM.")
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] ////#####Verify all accounts synced####/////////////////
			[ ] 
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.AllButton.Click()
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,330,7)
			[-] if (WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.Exists(20))
				[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.TypeKeys(lsUserCredentials[2])
				[ ] 
				[ ] 
				[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.DoneButton.Click()
				[-] if (DlgAccountsSynced.Exists(180))
					[ ] DlgAccountsSynced.SetActive()
					[ ] sActual=DlgAccountsSynced.GetCaption()
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[-] if (bMatch==TRUE)
						[ ] ReportStatus("Verify all accounts sync", PASS, "Verify all accounts sync: All Accounts synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,1)
						[ ] ////#########Save CloudSyncLog################////
						[ ] iLog=OpenAndSaveCloudSyncLog()
						[-] if (iLog==PASS)
							[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
							[-] for (iCounter=1;iCounter< ListCount(lsExcelAccountData)-1; ++iCounter)
								[ ] lsAccount=lsExcelAccountData[iCounter]
								[+] if (lsAccount[1]==NULL)
									[ ] break
								[ ] sConnectionType=lsAccount[3]
								[ ] sAccountType=lsAccount[4]
								[ ] sAmountOnlineBalanceExpected=NULL
								[ ] sAmountEndingBalanceExpected=NULL
								[ ] 
								[ ] iResult =SelectAccountFromAccountBar(lsAccount[1] ,ACCOUNT_BANKING)
								[-] if(iResult==PASS)
									[ ] sleep(3)
									[-] if (lsAccount[1]=="Credit Card")
										[ ] nAmountOnlineBalanceExpected =-VAL(lsAccount[2])
										[ ] sAmountOnlineBalanceExpected=trim(Str(nAmountOnlineBalanceExpected,6,2))
										[ ] ///nAmountEndingBalanceExpected
										[ ] sAmountEndingBalanceExpected = MDIClient.AccountRegister.Balances.EndingBalance.GetText()
										[ ] sAmountEndingBalanceExpected=StrTran(sAmountEndingBalanceExpected,",","")
										[ ] 
									[-] else if (lsAccount[3]=="manual" || lsAccount[3]=="webconnect")
										[ ] 
										[ ] // The MDIClient.AccountRegister.Balances.OnlineBalance and 
										[ ] //MDIClient.AccountRegister.Balances.EndingBalance controls indexes are reversed
										[ ] sAmountOnlineBalanceExpected=NULL
										[ ] QuickenWindow.SetActive()
										[ ] sAmountOnlineBalanceExpected = MDIClient.AccountRegister.Balances.EndingBalance.GetText()
										[-] if (sAmountOnlineBalanceExpected!=NULL)
											[ ] sAmountOnlineBalanceExpected=StrTran(sAmountOnlineBalanceExpected,",","")
										[ ] 
										[ ] ///nAmountEndingBalanceExpected
										[ ] sAmountEndingBalanceExpected = MDIClient.AccountRegister.Balances.OnlineBalance.GetText()
										[ ] sAmountEndingBalanceExpected=StrTran(sAmountEndingBalanceExpected,",","")
										[ ] 
										[ ] 
									[-] else
										[ ] sAmountOnlineBalanceExpected=NULL
										[ ] sAmountEndingBalanceExpected=NULL
										[ ] QuickenWindow.SetActive()
										[ ] sAmountOnlineBalanceExpected = MDIClient.AccountRegister.Balances.OnlineBalance.GetText()
										[ ] sAmountOnlineBalanceExpected=StrTran(sAmountOnlineBalanceExpected,",","")
										[ ] 
										[ ] ///nAmountEndingBalanceExpected
										[ ] sAmountEndingBalanceExpected = MDIClient.AccountRegister.Balances.EndingBalance.GetText()
										[ ] sAmountEndingBalanceExpected=StrTran(sAmountEndingBalanceExpected,",","")
									[ ] 
									[ ] //Get AccountID
									[ ] sContentProviderType=NULL
									[ ] scpFIID =NULL
									[ ] sFIName= NULL
									[ ] sFIName=lsAccount[7]
									[ ] sContentProviderType= lsAccount[5]
									[ ] icpFIID =VAL(lsAccount[6])
									[ ] scpFIID=Str(icpFIID)
									[ ] sFILoginId=GetFILoginIDResponse (sContentProviderType ,scpFIID)
									[ ] //GetAccount Response
									[ ] lsAccountResponse=GetAccountsResultFromCloudSyncLog(lsAccount[1])
									[-] for each sItem in lsAccountResponse
										[ ] bMatch= MatchStr("*{sFILoginId}*",sItem)
										[-] if (bMatch==TRUE)
											[ ] break
									[-] if (bMatch==TRUE)
										[ ] ReportStatus("Verify Account type and ID ", PASS, "FILogingId matched for {lsAccount[1]} actual: {sItem}")
										[ ] 
										[-] for each sItem in lsAccountResponse
											[ ] bMatch= MatchStr("*{rAccountReqResp.sCurrentBalance}*",sItem)
											[-] if (bMatch==TRUE)
												[ ] break
										[-] if (bMatch==TRUE)
											[ ] lsStringData=split(sItem,":")
											[ ] nAmountOnlineBalanceActual = VAL (lsStringData[2])
											[ ] sAmountOnlineBalanceActual=trim(Str(nAmountOnlineBalanceActual,6,2))
											[-] if (sAmountOnlineBalanceActual==sAmountOnlineBalanceExpected)
												[ ] ReportStatus("Verify Account balance ", PASS, "Account balance of {lsAccount[1]} is {sAmountOnlineBalanceActual} as expected {sAmountOnlineBalanceExpected}.")
												[ ] 
												[ ] //Clearing the list object for next iteration
												[ ] lsData=lsTemp
												[ ] // Append parameters a list to be written to SyncResult.xls 
												[ ] //AccountName
												[ ] 
												[ ] ListAppend (lsData , lsAccount[1] )
												[ ] //sAmountOnlineBalanceExpected
												[ ] ListAppend (lsData ,sAmountOnlineBalanceExpected)
												[ ] //sAmountEndingBalanceExpected
												[ ] ListAppend (lsData ,sAmountEndingBalanceExpected )
												[ ] //AccountName
												[ ] ListAppend (lsData , sConnectionType )
												[ ] //AccountName
												[ ] ListAppend (lsData , sAccountType)
												[ ] //sContentProviderType
												[ ] ListAppend (lsData , sContentProviderType)
												[ ] //scpFIID
												[ ] ListAppend (lsData , scpFIID)
												[ ] //sFIName
												[ ] ListAppend (lsData , sFIName)
												[ ] 
												[ ] 
												[ ] 
												[ ] WriteExcelTable(sSyncResultFile ,sAccountBalanceSheet, lsData)
												[ ] 
												[ ] 
												[ ] // WriteExcelTable(sSyncResultFile ,sAccountBalanceSheet,lsAccount[1], sAmountOnlineBalanceExpected ,sAmountEndingBalanceExpected, sConnectionType ,sAccountType)
												[ ] 
											[-] else
												[ ] ReportStatus("Verify Account balance ", FAIL, "Account balance of {lsAccount[1]} is {sAmountOnlineBalanceActual} is not as expected {sAmountOnlineBalanceExpected}.")
										[-] else
											[ ] ReportStatus("Verify Account balance ", FAIL, "Account balance not found for {lsAccount[1]}.")
									[-] else
										[ ] ReportStatus("Verify Account type and ID ", FAIL, "Account didn't add as expected as filoginID: {sFILoginId} couldn't be found in account response {lsAccountResponse}.")
								[-] else
									[ ] ReportStatus("Account selection",FAIL,"Account {lsAccount[1]} couldn't be selected")
								[ ] 
								[ ] 
						[-] else
							[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log couldn't be saved.")
					[-] else
						[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,1)
				[+] else
					[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
			[+] else
				[ ] ReportStatus("Verify AccountPasswordTextField enabled", FAIL, "Verify AccountPasswordTextField enabled: Verify AccountPasswordTextField disabled.")
		[+] else
			[ ] ReportStatus("Mobile user SignUp", FAIL, "Mobile user couldn't SignUp on QM.")
		[ ] 
		[ ] //Call the Robotium Script
		[ ] APP_START("C:\automation\ApplicationSpecific\Data\TestData\BAT Files\accountBalEWC.bat")
		[ ] 
		[ ] //Sleep
		[ ] Sleep(150)
		[ ] 
		[ ] // Delete created cloudID
		[ ] DeleteCloudID(sPassword)
		[ ] 
		[ ] //Compare the Account Balances and FI Name as displayed on Quicken Desktop & on Quicken Mobile
		[ ] 
		[ ] //Read the Sync Result xls containing the account data read from QD
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSyncResultFile, sAccountBalanceSheet,AUT_DATAFILE_PATH)
		[ ] 
		[-] for(iCount = 1; iCount<=ListCount(lsExcelData);iCount++)
			[ ] 
			[ ] lsRowData=lsExcelData[iCount]
			[ ] 
			[ ] sAccountName=lsRowData[1]
			[ ] sFIName=lsRowData[8]
			[ ] 
			[ ] nOnlineBalance = val(lsRowData[2])
			[ ] nEndingBalance = val(lsRowData[3])
			[ ] 
			[ ] sOnlineBalance = Str(nOnlineBalance,NULL,2)
			[ ] sEndingBalance = Str(nEndingBalance,NULL,2)
			[ ] 
			[ ] ListAppend(lsQDResultFile, sAccountName)
			[ ] ListAppend(lsQDResultFile, sFIName)
			[ ] ListAppend(lsQDResultFile, sOnlineBalance)
			[ ] ListAppend(lsQDResultFile, sEndingBalance)
		[ ] 
		[ ] 
		[ ] //Read the Robotium result xls containing the account data read from QM
		[ ] lsExcelDataFromQm=NULL
		[ ] lsExcelDataFromQm = ReadExcelTable(sQMResultFile,sQMAccountBalanceSheet,sQMResultFileLocation)
		[ ] 
		[-] for(iCount = 1; iCount<=ListCount(lsExcelDataFromQm);iCount++)
			[ ] 
			[ ] lsRowData=lsExcelDataFromQm[iCount]
			[ ] 
			[ ] sAccountName=lsRowData[1]
			[ ] sFIName=lsRowData[2]
			[ ] 
			[ ] nOnlineBalance = val(lsRowData[3])
			[ ] nEndingBalance = val(lsRowData[4])
			[ ] 
			[ ] sOnlineBalance = Str(nOnlineBalance,NULL,2)
			[ ] sEndingBalance = Str(nEndingBalance,NULL,2)
			[ ] 
			[ ] ListAppend(lsQMResultFile, sAccountName)
			[ ] ListAppend(lsQMResultFile, sFIName)
			[ ] ListAppend(lsQMResultFile, sOnlineBalance)
			[ ] ListAppend(lsQMResultFile, sEndingBalance)
		[ ] 
		[ ] //Compare lsExcelData & lsExcelDataFromQm
		[ ] 
		[+] // for each sQDItem in lsQDResultFile
			[+] // for each sQMItem in lsQMResultFile
				[ ] // bMatch = MatchStr("{sQDItem}" ,sQMItem)
				[-] // if (bMatch)
					[ ] // break
					[ ] // 
			[-] // if(bMatch)
				[ ] // ReportStatus("Compare QD & QM Account Info", PASS, "Online Balance: {lsQDResultFile[iCount+2]} matches for account {lsQDResultFile[iCount]} ")
			[-] // else
				[ ] // ReportStatus("Compare QD & QM Account Info", FAIL, "Online Balance is different for account {lsQDResultFile[iCount]} on QD & QM. Online Balance in QD is: {lsQDResultFile[iCount+2]} and Online Balance in QM is: {lsQMResultFile[iCount+2]} ")
			[ ] // 
		[ ] 
		[-] for(iCount=1; iCount <= (ListCount(lsQDResultFile)) ; iCount++)
			[ ] 
			[ ] //Verify that account names match
			[-] if(lsQMResultFile[iCount] == lsQDResultFile[iCount])
				[ ] 
				[ ] //Verify FI Name is same for the account
				[-] if(lsQMResultFile[iCount+1] == lsQDResultFile[iCount+1])
					[ ] ReportStatus("Compare QD & QM Account Info", PASS, "FI Name: {lsQDResultFile[iCount+1]} matches for account {lsQDResultFile[iCount]} ")
				[+] else
					[ ] ReportStatus("Compare QD & QM Account Info", FAIL, "FI Name is different for account {lsQDResultFile[iCount]} on Qd & QM. FI Name in QD is: {lsQDResultFile[iCount+1]} and FI Name in QM is: {lsQMResultFile[iCount+1]} ")
				[ ] 
				[ ] //Verfiy Online Balance for the account
				[-] if(lsQMResultFile[iCount+2] == lsQDResultFile[iCount+2])
					[ ] ReportStatus("Compare QD & QM Account Info", PASS, "Online Balance: {lsQDResultFile[iCount+2]} matches for account {lsQDResultFile[iCount]} ")
				[+] else
					[ ] ReportStatus("Compare QD & QM Account Info", FAIL, "Online Balance is different for account {lsQDResultFile[iCount]} on QD & QM. Online Balance in QD is: {lsQDResultFile[iCount+2]} and Online Balance in QM is: {lsQMResultFile[iCount+2]} ")
				[ ] 
				[ ] //Verify Ending Balance for the account
				[-] if(lsQMResultFile[iCount+3] == lsQDResultFile[iCount+3])
					[ ] ReportStatus("Compare QD & QM Account Info", PASS, "Ending Balance: {lsQDResultFile[iCount+1]} matches for account {lsQDResultFile[iCount]} ")
				[+] else
					[ ] ReportStatus("Compare QD & QM Account Info", FAIL, "Ending Balance is different for account {lsQDResultFile[iCount]} on QD & QM. Ending Balance in QD is: {lsQDResultFile[iCount+3]} and Ending Balance in QM is: {lsQMResultFile[iCount+3]} ")
				[ ] 
			[-] else
				[ ] ReportStatus("Compare QD & QM Account Info", FAIL, "Account Name is different on QD & QM. Account Name in QD is: {lsQDResultFile[iCount]} and Account Name in QM is: {lsQMResultFile[iCount]} ")
			[ ] iCount = iCount+3
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] // //############# DataSync_DC_VerifyOnlineBalances#############################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 DataSync_EWC_Manual_VerifyOnlineBalances()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will sync EWC accounts and verify request and responses
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs 
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Jan 24, 2013		Mukesh	
	[ ] // // ********************************************************
[-] testcase DataSync_DC_VerifyOnlineBalances() appstate  DataSyncDcAccountBaseState 
	[ ] STRING sCurrentDate , sFutureDate  ,sAmountOnlineBalanceActual ,sAmountOnlineBalanceExpected  ,sConnectionType ,sFILoginId ,sContentProviderType
	[ ] STRING sAmountEndingBalanceExpected ,scpFIID ,sFIName
	[ ] STRING sAccountName, sOnlineBalance, sEndingBalance
	[ ] NUMBER nOnlineBalance, nEndingBalance
	[ ] NUMBER nAmountOnlineBalanceExpected ,nAmountOnlineBalanceActual  ,nAmountEndingBalanceActual ,nAmountEndingBalanceExpected
	[ ] INTEGER icpFIID, iCount
	[ ] sExpected="Accounts Synced"
	[ ] STRING sDCAccountPassword="datasync"
	[ ] STRING sSyncResultFile="SyncResult"
	[ ] STRING sAccountBalanceSheet="AccountBalanceSheet"
	[ ] STRING sQMResultFile="Results testDCAccountBalance"
	[ ] STRING sQMAccountBalanceSheet = "testDCAccountBalance"
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sTransactionSheet)
	[ ] 
	[ ] rAccountReqRespRecord rAccountReqResp
	[ ] rAccountReqResp = lsAccountReqRespRecordValue
	[ ] sFutureDate =FormatDateTime ( AddDateTime (GetDateTime (), 1), "m/d/yyyy") 
	[ ] sCurrentDate =FormatDateTime ( AddDateTime (GetDateTime (), 0), "m/d/yyyy") 
	[ ] 
	[ ] 
	[ ] 
	[-] if(FileExists(sDCSyncLogFile))
		[ ] DeleteFile(sDCSyncLogFile)
	[ ] 
	[-] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=OSUWithPasswordVault(sDCAccountPassword)
		[-] if (iResult==PASS)
			[ ] 
			[-] //Add Future dated transactions to every account
				[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 1)
				[-] if(iSelect==PASS)
					[-] for (iCount=3;  iCount<ListCount(lsExcelData)+1;++iCount)
						[ ] lsTransaction=lsExcelData[iCount]
						[+] if (lsTransaction[1]==NULL)
							[ ] break
							[ ] 
							[ ] // sWindowType,STRING sTransactionType, STRING sAmount, STRING sDate , STRING sChequeNo optional, STRING sPayee optional, STRING sMemo  optional, STRING sCategory optional, STRING sTag optional)
							[ ] //WindowType	TransactionMode	Amount	TransactionDate	ChequeNo	Payee	Memo	Category	PayBalance	Account	
						[ ] 
						[ ] sDateStamp =sCurrentDate
						[ ] 
						[ ] // lsAccount =lsExcelAccountData[iCounter]
						[-] // if (lsAccount[3]=="manual")
							[ ] // sDateStamp=sFutureDate
							[ ] // 
						[ ] // 
						[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
						[ ] lsTransaction=NULL
				[+] else
					[ ] ReportStatus("Account selection",FAIL,"Account couldn't be selected")
				[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 2)
				[+] if(iSelect==PASS)
					[-] for (iCount=1;  iCount<ListCount(lsExcelData)+1;++iCount)
						[ ] lsTransaction=lsExcelData[iCount]
						[-] if (lsTransaction[1]==NULL)
							[ ] break
							[ ] 
							[ ] // sWindowType,STRING sTransactionType, STRING sAmount, STRING sDate , STRING sChequeNo optional, STRING sPayee optional, STRING sMemo  optional, STRING sCategory optional, STRING sTag optional)
							[ ] //WindowType	TransactionMode	Amount	TransactionDate	ChequeNo	Payee	Memo	Category	PayBalance	Account	
						[ ] 
						[ ] sDateStamp =sCurrentDate
						[ ] 
						[ ] // lsAccount =lsExcelAccountData[iCounter]
						[-] // if (lsAccount[3]=="manual")
							[ ] // sDateStamp=sFutureDate
							[ ] // 
						[ ] 
						[ ] AddSavingCreditCashTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,lsTransaction[6],lsTransaction[7],lsTransaction[8])
						[ ] lsTransaction=NULL
				[-] else
					[ ] ReportStatus("Account selection",FAIL,"Account couldn't be selected")
			[ ] 
			[ ] //Added Future dated transactions to every account
			[ ] 
			[ ] 
			[ ] //Mobile SignUp
			[ ] iResult=MobileSignUp()
			[-] if (iResult==PASS)
				[ ] ReportStatus("Mobile user SignUp", PASS, "Mobile user Signed-Up on QM.")
				[ ] QuickenWindow.SetActive()
				[ ] ////#####Verify all accounts synced####/////////////////
				[-] if (WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.Exists(20))
					[ ] 
					[ ] 
					[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.DoneButton.Click()
					[-] if (DlgAccountsSynced.Exists(300))
						[ ] DlgAccountsSynced.SetActive()
						[ ] sActual=DlgAccountsSynced.GetCaption()
						[ ] bMatch = MatchStr("*{sExpected}*", sActual)
						[-] if (bMatch==TRUE)
							[ ] ReportStatus("Verify all accounts sync", PASS, "Verify all accounts sync: All Accounts synced.")
							[ ] DlgAccountsSynced.OK.Click()
							[ ] WaitForState(DlgAccountsSynced,FALSE,1)
							[ ] ////#########Save CloudSyncLog################////
							[ ] iLog=OpenAndSaveCloudSyncLog()
							[-] if (iLog==PASS)
								[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
								[ ] iCount=0
								[-] for (iCounter=9;iCounter< ListCount(lsExcelAccountData)+1; ++iCounter)
									[ ] lsAccount=lsExcelAccountData[iCounter]
									[-] if (lsAccount[1]==NULL)
										[ ] break
									[ ] sConnectionType=lsAccount[3]
									[ ] sAccountType=lsAccount[4]
									[ ] iCount=iCount+1
									[ ] QuickenWindow.SetActive()
									[ ] QuickenMainWindow.QWNavigator.Home.Click()
									[ ] QuickenWindow.SetActive()
									[ ] iResult=AccountBarSelect(ACCOUNT_BANKING, iCount)
									[ ] // iResult =SelectAccountFromAccountBar(lsAccount[1] ,ACCOUNT_BANKING)
									[-] if(iResult==PASS)
										[ ] sleep(3)
										[ ] sAmountOnlineBalanceExpected=NULL
										[ ] QuickenWindow.SetActive()
										[ ] sAmountOnlineBalanceExpected = MDIClient.AccountRegister.Balances.OnlineBalance.GetText()
										[ ] sAmountOnlineBalanceExpected=StrTran(sAmountOnlineBalanceExpected,",","")
										[ ] 
										[ ] 
										[ ] ///nAmountEndingBalanceExpected
										[ ] sAmountEndingBalanceExpected = MDIClient.AccountRegister.Balances.EndingBalance.GetText()
										[ ] sAmountEndingBalanceExpected=StrTran(sAmountEndingBalanceExpected,",","")
										[ ] 
										[ ] 
										[ ] //GetAccount Response
										[ ] //Get AccountID
										[ ] sContentProviderType=NULL
										[ ] scpFIID =NULL
										[ ] sFIName= NULL
										[ ] sFIName=lsAccount[7]
										[ ] sContentProviderType= lsAccount[5]
										[ ] icpFIID =VAL(lsAccount[6])
										[ ] scpFIID=Str(icpFIID)
										[ ] sFILoginId=GetFILoginIDResponse (sContentProviderType ,scpFIID)
										[ ] //GetAccount Response
										[ ] lsAccountResponse=GetAccountsResultFromCloudSyncLog(lsAccount[1])
										[+] for each sItem in lsAccountResponse
											[ ] bMatch= MatchStr("*{sFILoginId}*",sItem)
											[-] if (bMatch==TRUE)
												[ ] break
										[-] if (bMatch==TRUE)
											[ ] ReportStatus("Verify Account type and ID ", PASS, "FILogingId matched for {lsAccount[1]} actual: {sItem}")
											[ ] 
											[-] for each sItem in lsAccountResponse
												[ ] bMatch= MatchStr("*{rAccountReqResp.sCurrentBalance}*",sItem)
												[-] if (bMatch==TRUE)
													[ ] break
											[-] if (bMatch==TRUE)
												[ ] lsStringData=split(sItem,":")
												[ ] nAmountOnlineBalanceActual = VAL (lsStringData[2])
												[ ] sAmountOnlineBalanceActual=trim(Str(nAmountOnlineBalanceActual,6,2))
												[-] if (sAmountOnlineBalanceActual==sAmountOnlineBalanceExpected)
													[ ] ReportStatus("Verify Account balance ", PASS, "Account balance of {lsAccount[1]} is {sAmountOnlineBalanceActual} as expected {sAmountOnlineBalanceExpected}.")
													[ ] 
													[ ] //Clearing the list object for next iteration
													[ ] lsData=lsTemp
													[ ] 
													[ ] // Append parameters a list to be written to SyncResult.xls 
													[ ] //AccountName
													[ ] ListAppend (lsData , lsAccount[1] )
													[ ] //sAmountOnlineBalanceExpected
													[ ] ListAppend (lsData ,sAmountOnlineBalanceExpected)
													[ ] //sAmountEndingBalanceExpected
													[ ] ListAppend (lsData ,sAmountEndingBalanceExpected )
													[ ] //AccountName
													[ ] ListAppend (lsData , sConnectionType )
													[ ] //AccountName
													[ ] ListAppend (lsData , sAccountType)
													[ ] 
													[ ] //sContentProviderType
													[ ] ListAppend (lsData , sContentProviderType)
													[ ] //scpFIID
													[ ] ListAppend (lsData , scpFIID)
													[ ] //sFIName
													[ ] ListAppend (lsData , sFIName)
													[ ] 
													[ ] //write to SyncResult.xls 
													[ ] 
													[ ] WriteExcelTable(sSyncResultFile ,sAccountBalanceSheet, lsData)
													[ ] 
													[ ] // WriteExcelTable(sSyncResultFile ,sAccountBalanceSheet,lsAccount[1], sAmountOnlineBalanceExpected ,sAmountEndingBalanceExpected, sConnectionType ,sAccountType)
												[-] else
													[ ] ReportStatus("Verify Account balance ", FAIL, "Account balance of {lsAccount[1]} is {sAmountOnlineBalanceActual} is not as expected {sAmountOnlineBalanceExpected}.")
											[+] else
												[ ] ReportStatus("Verify Account balance ", FAIL, "Account balance not found for {lsAccount[1]}.")
										[+] else
											[ ] ReportStatus("Verify Account type and ID ", FAIL, "Account didn't add as expected as filoginID: {sFILoginId} couldn't be found in account response {lsAccountResponse}.")
											[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Account selection",FAIL,"Account {lsAccount[1]} couldn't be selected")
									[ ] 
							[+] else
								[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log couldn't be saved.")
						[+] else
							[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
							[ ] DlgAccountsSynced.OK.Click()
							[ ] WaitForState(DlgAccountsSynced,FALSE,1)
					[-] else
						[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
				[+] else
					[ ] ReportStatus("Verify AccountPasswordTextField enabled", FAIL, "Verify AccountPasswordTextField enabled: Verify AccountPasswordTextField disabled.")
				[ ] 
				[ ] // Call the Robotium script
				[ ] APP_START("C:\automation\ApplicationSpecific\Data\TestData\BAT Files\accountBalDC.bat")
				[ ] 
				[ ] //Sleep
				[ ] Sleep(150)
				[ ] 
				[ ] // Delete created cloudID
				[ ] DeleteCloudID(sPassword)
				[ ] 
				[ ] //Compare the Account Balances and FI Name as displayed on Quicken Desktop & on Quicken Mobile
				[ ] 
				[ ] //Read the Sync Result xls containing the account data read from QD
				[ ] lsExcelData=NULL
				[ ] lsExcelData=ReadExcelTable(sSyncResultFile, sAccountBalanceSheet,AUT_DATAFILE_PATH)
				[ ] 
				[-] for(iCount = 1; iCount<=ListCount(lsExcelData);iCount++)
					[ ] 
					[ ] lsRowData=lsExcelData[iCount]
					[ ] 
					[ ] sAccountName=lsRowData[1]
					[ ] sFIName=lsRowData[8]
					[ ] 
					[ ] nOnlineBalance = val(lsRowData[2])
					[ ] nEndingBalance = val(lsRowData[3])
					[ ] 
					[ ] sOnlineBalance = Str(nOnlineBalance,NULL,2)
					[ ] sEndingBalance = Str(nEndingBalance,NULL,2)
					[ ] 
					[ ] ListAppend(lsQDResultFile, sAccountName)
					[ ] ListAppend(lsQDResultFile, sFIName)
					[ ] ListAppend(lsQDResultFile, sOnlineBalance)
					[ ] ListAppend(lsQDResultFile, sEndingBalance)
				[ ] 
				[ ] 
				[ ] //Read the Robotium result xls containing the account data read from QM
				[ ] lsExcelDataFromQm=NULL
				[ ] lsExcelDataFromQm = ReadExcelTable(sQMResultFile,sQMAccountBalanceSheet,sQMResultFileLocation)
				[ ] 
				[-] for(iCount = 1; iCount<=ListCount(lsExcelDataFromQm);iCount++)
					[ ] 
					[ ] lsRowData=lsExcelDataFromQm[iCount]
					[ ] 
					[ ] sAccountName=lsRowData[1]
					[ ] sFIName=lsRowData[2]
					[ ] 
					[ ] nOnlineBalance = val(lsRowData[3])
					[ ] nEndingBalance = val(lsRowData[4])
					[ ] 
					[ ] sOnlineBalance = Str(nOnlineBalance,NULL,2)
					[ ] sEndingBalance = Str(nEndingBalance,NULL,2)
					[ ] 
					[ ] ListAppend(lsQMResultFile, sAccountName)
					[ ] ListAppend(lsQMResultFile, sFIName)
					[ ] ListAppend(lsQMResultFile, sOnlineBalance)
					[ ] ListAppend(lsQMResultFile, sEndingBalance)
				[ ] 
				[ ] //Compare lsExcelData & lsExcelDataFromQm
				[ ] 
				[+] // for each sQDItem in lsQDResultFile
					[+] // for each sQMItem in lsQMResultFile
						[ ] // bMatch = MatchStr("{sQDItem}" ,sQMItem)
						[-] // if (bMatch)
							[ ] // break
							[ ] // 
					[-] // if(bMatch)
						[ ] // ReportStatus("Compare QD & QM Account Info", PASS, "Online Balance: {lsQDResultFile[iCount+2]} matches for account {lsQDResultFile[iCount]} ")
					[-] // else
						[ ] // ReportStatus("Compare QD & QM Account Info", FAIL, "Online Balance is different for account {lsQDResultFile[iCount]} on QD & QM. Online Balance in QD is: {lsQDResultFile[iCount+2]} and Online Balance in QM is: {lsQMResultFile[iCount+2]} ")
					[ ] // 
				[ ] 
				[-] for(iCount=1; iCount <= (ListCount(lsQDResultFile)) ; iCount++)
					[ ] 
					[ ] //Verify that account names match
					[-] if(lsQMResultFile[iCount] == lsQDResultFile[iCount])
						[ ] 
						[ ] //Verify FI Name is same for the account
						[-] if(lsQMResultFile[iCount+1] == lsQDResultFile[iCount+1])
							[ ] ReportStatus("Compare QD & QM Account Info", PASS, "FI Name: {lsQDResultFile[iCount+1]} matches for account {lsQDResultFile[iCount]} ")
						[-] else
							[ ] ReportStatus("Compare QD & QM Account Info", FAIL, "FI Name is different for account {lsQDResultFile[iCount]} on Qd & QM. FI Name in QD is: {lsQDResultFile[iCount+1]} and FI Name in QM is: {lsQMResultFile[iCount+1]} ")
						[ ] 
						[ ] //Verfiy Online Balance for the account
						[-] if(lsQMResultFile[iCount+2] == lsQDResultFile[iCount+2])
							[ ] ReportStatus("Compare QD & QM Account Info", PASS, "Online Balance: {lsQDResultFile[iCount+2]} matches for account {lsQDResultFile[iCount]} ")
						[-] else
							[ ] ReportStatus("Compare QD & QM Account Info", FAIL, "Online Balance is different for account {lsQDResultFile[iCount]} on QD & QM. Online Balance in QD is: {lsQDResultFile[iCount+2]} and Online Balance in QM is: {lsQMResultFile[iCount+2]} ")
						[ ] 
						[ ] //Verify Ending Balance for the account
						[-] if(lsQMResultFile[iCount+3] == lsQDResultFile[iCount+3])
							[ ] ReportStatus("Compare QD & QM Account Info", PASS, "Ending Balance: {lsQDResultFile[iCount+1]} matches for account {lsQDResultFile[iCount]} ")
						[-] else
							[ ] ReportStatus("Compare QD & QM Account Info", FAIL, "Ending Balance is different for account {lsQDResultFile[iCount]} on QD & QM. Ending Balance in QD is: {lsQDResultFile[iCount+3]} and Ending Balance in QM is: {lsQMResultFile[iCount+3]} ")
						[ ] 
						[ ] 
					[-] else
						[ ] ReportStatus("Compare QD & QM Account Info", FAIL, "Account Name is different on QD & QM. Account Name in QD is: {lsQDResultFile[iCount]} and Account Name in QM is: {lsQMResultFile[iCount]} ")
					[ ] iCount = iCount+3
				[ ] 
			[-] else
				[ ] ReportStatus("Mobile user SignUp", FAIL, "Mobile user couldn't SignUp on QM.")
		[-] else
			[ ] ReportStatus("Verify OSUWithPasswordVault ",FAIL, "Verify OSU With Password Vault: OSU With Password Vault didn't succeed.")
		[ ] 
	[-] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# DataSync_EWC_VerifyOnlineTransactionsSync#############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_EWC_VerifyOnlineTransactionsSync()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync EWC accounts and verify request and responses
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 09, 2013		Mukesh	
	[ ] // ********************************************************
[+] testcase DataSync_EWC_VerifyOnlineTransactionsSync() appstate DataSyncBaseState
	[ ] // Read data from excel sheet sCCMintBankCredentials
	[ ] sleep(10)
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCCMintBankCredentials)
	[ ] lsUserCredentials=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sMobileSyncData 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCloudIdData)
	[ ] lsCloudUserData=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sOnlineTransactions)
	[ ] 
	[ ] 
	[ ] rTransactionReqRespRecord rTxnReqResp
	[ ] rTxnReqResp = lsTransactionReqRespValue
	[ ] 
	[ ] rAccountReqRespRecord rAccountReqResp
	[ ] rAccountReqResp = lsAccountReqRespRecordValue
	[ ] 
	[ ] sDateStamp =FormatDateTime ( AddDateTime (GetDateTime (), 1), "m/d/yyyy") 
	[ ] 
	[ ] sExpected="Accounts Synced"
	[ ] 
	[+] if(FileExists(sSyncLogFile))
		[ ] DeleteFile(sSyncLogFile)
		[ ] sleep(3)
	[-] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] //Mobile SignUp
		[ ] // iResult=MobileSignUp(lsCloudUserData[1],lsCloudUserData[2],lsCloudUserData[3])
		[ ]  iResult=MobileSignUp()
		[+] if (iResult==PASS)
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "Verification of {lsCloudUserData[1]} SignUp -  {lsCloudUserData[1]}  is Signed Up successfully.")
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] ////#####Verify all accounts synced####/////////////////
			[ ] 
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click()
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,14,34)
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,14,60)
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,14,82)
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,330,7)
			[+] if (WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.Exists(20))
				[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.TypeKeys(trim(lsUserCredentials[2]))
				[ ] 
				[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.DoneButton.Click()
				[+] if (DlgAccountsSynced.Exists(180))
					[ ] DlgAccountsSynced.SetActive()
					[ ] sActual=DlgAccountsSynced.GetCaption()
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[+] if (bMatch==TRUE)
						[ ] ReportStatus("Verify all accounts sync", PASS, "Verify all accounts sync: All Accounts synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,1)
						[ ] QDSyncNow()
						[ ] ////#########Save CloudSyncLog################////
						[ ] iLog=OpenAndSaveCloudSyncLog()
						[+] if (iLog==PASS)
							[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
							[ ] ///#######Transaction requests#################////
							[ ] ////######Get transaction data of all online accounts in a list lsAccount#########
							[ ] lsRequestParameters=GetRequestFromTransactionsList(lsExcelData)
							[ ] ///####### verifyTransaction request responses#################////
							[+] for (iItemCounter=1;iItemCounter<ListCount(lsRequestParameters)+1;++iItemCounter)
								[ ] lsTemp=lsRequestParameters[iItemCounter]
								[+] if (lsTemp[1]==NULL)
									[ ] break
									[ ] 
								[+] for (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
									[ ] bMatch= MatchStr("*{rAccountReqResp.sSourceAccountName}*",lsTemp[iCounter])
									[+] if (bMatch==TRUE)
										[ ] sAccountName=lsTemp[iCounter]
										[ ] break
									[ ] 
								[ ] ////////Get the Account name of the trasaction from the request data///////
								[ ] lsAccountName=Split(sAccountName,":")
								[+] if (lsAccountName[2]!=NULL)
									[ ] 
									[ ] ////////Get the AccountID from the synclog using the account name///////
									[ ] lsAccountResponse=GetAccountsResultFromCloudSyncLog(lsAccountName[2])
									[+] for (iCounter=1;iCounter<ListCount(lsAccountResponse)+1;++iCounter) 
										[ ] bMatch= MatchStr("*{rAccountReqResp.sSourceAccountName}*",lsAccountResponse[iCounter])
										[+] if (bMatch==TRUE)
											[+] for (iCount=iCounter;iCount<ListCount(lsAccountResponse)+1;++iCount) 
												[ ] bMatch=false
												[ ] bMatch= MatchStr("*{rAccountReqResp.sSourceAccountId}*",lsAccountResponse[iCount])
												[+] if (bMatch==TRUE)
													[+] for (iAccCount=iCount+1;iAccCount<ListCount(lsAccountResponse)+1;++iAccCount) 
														[ ] bMatch=false
														[ ] bMatch= MatchStr("*{rAccountReqResp.sAccountId}*",lsAccountResponse[iAccCount])
														[+] if (bMatch==TRUE)
															[ ] sAccountId=lsAccountResponse[iAccCount]
															[ ] break
									[ ] 
									[ ] ///Add accountId to request to be verified///
									[ ] lsAccountId=Split(sAccountId,":")
									[ ] iAccountId=VAL(lsAccountId[2])
									[+] if (lsAccountId[2]!=NULL)
										[+] for  (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
											[ ] bMatch= MatchStr("*{rAccountReqResp.sSourceAccountName}*",lsTemp[iCounter])
											[+] if (bMatch==TRUE)
												[ ] bMatch=FALSE
												[ ] ListDelete(lsTemp,iCounter )
												[+] if (iCounter>ListCount(lsTemp))
													[ ] ListAppend (lsTemp,sAccountId)
												[+] else
													[ ] ListInsert (lsTemp,iCounter ,sAccountId)
										[ ] 
										[+] for each sItem in lsTemp
											[ ] bMatch= MatchStr("*{rTxnReqResp.sfiTId}*",sItem)
											[+] if (bMatch==TRUE)
												[ ] break
										[+] if (bMatch==TRUE)
											[ ] lsFITID=split(sItem,":")
											[+] if (lsFITID[2]!="")
												[ ] lsReqResponse=GetOnlineTransactionResponseFromSyncLog(lsFITID[2],iAccountId)
												[+] if( ListCount(lsReqResponse)>1)
													[+] for each sReqItem in lsTemp
														[+] for each sRespItem in lsReqResponse
																[ ] bMatch=FALSE
															[+] if (sReqItem==sRespItem)
																[ ] bMatch=TRUE
																[ ] break
														[+] if (bMatch==TRUE)
															[ ] ReportStatus("Verify request data", PASS, " Verify request data with response: Response for FITID {lsFITID[2]}: data {sRespItem} is as expected request data {sReqItem}.")
														[+] else
															[ ] ReportStatus("Verify request data", FAIL, " Verify request data with response: Response FITID {lsFITID[2]}: data is NOT as expected request data {sReqItem}.")
												[+] else
													[ ] ReportStatus("Verify FITID", FAIL, " FITID  {lsFITID[2]} is not present or duplicated in the SyncLog.")
											[+] else
												[ ] ReportStatus("Verify FITID", FAIL, " FITID  {lsFITID[2]} is not present in datasheet for this transaction.")
										[+] else
											[ ] ReportStatus("Verify FITID", FAIL, " FITID column is not present in datasheet.")
									[+] else
										[ ] ReportStatus("Get accountId from the synclog", FAIL, " Get accountId from the synclog: accountId not found in the synclog .")
								[+] else
									[ ] ReportStatus("Get account name from the synclog", FAIL, " Get account name from the synclog: account name not found in the excelsheet .")
							[ ] 
							[ ] ////######Transactions Verified#################////
							[ ] 
						[+] else
							[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log couldn't be saved.")
					[+] else
						[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,1)
				[+] else
					[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
			[+] else
				[ ] ReportStatus("Verify AccountPasswordTextField enabled", FAIL, "Verify AccountPasswordTextField enabled: Verify AccountPasswordTextField disabled.")
		[-] else
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "{lsCloudUserData[1]} SignUp -  {lsCloudUserData[2]} couldn't SignUp.")
		[ ] // Delete created cloudID
		[ ] DeleteCloudID(sPassword)
	[-] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] //############# DataSync_EWC_VerifyManuaPaycheckTransactionsSync#############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_EWC_VerifyManuaPaycheckTransactionsSync()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync a manual cash account and will verify Paycheck transactions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 11, 2013		Mukesh	
	[ ] // ********************************************************
[+] testcase DataSync_EWC_VerifyManuaPaycheckTransactionsSync() appstate DataSyncBaseState
	[ ] // Read data from excel sheet sCCMintBankCredentials
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCCMintBankCredentials)
	[ ] lsUserCredentials=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sMobileSyncData 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCloudIdData)
	[ ] lsCloudUserData=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sPaycheckAccTrans)
	[ ] 
	[ ] rTransactionReqRespRecord rTxnReqResp
	[ ] rTxnReqResp = lsTransactionReqRespValue
	[ ] sDateStamp =FormatDateTime ( AddDateTime (GetDateTime (), 1), "m/d/yyyy") 
	[ ] 
	[ ] sExpected="Accounts Synced"
	[+] if(FileExists(sSyncLogFile))
		[ ] DeleteFile(sSyncLogFile)
		[ ] sleep(3)
	[-] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] //Mobile SignUp
		[ ] // iResult=MobileSignUp(lsCloudUserData[1],lsCloudUserData[2],lsCloudUserData[3])
		[ ]  iResult=MobileSignUp()
		[-] if (iResult==PASS)
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "Verification of {lsCloudUserData[1]} SignUp -  {lsCloudUserData[1]}  is Signed Up successfully.")
			[ ] // WaitForState(MessageBox,TRUE,3)
			[ ] QuickenWindow.SetActive()
			[ ] ////#####Verify all accounts synced####/////////////////
			[ ] /////Selecting Cash Account containing paycheck////
			[ ] WinMoblieSync.Click()
			[ ] Agent.SetOption(OPT_VERIFY_ACTIVE,FALSE)
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click()
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,15,139)
			[ ] /////#####AccountPasswordTextField location based click############///
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,330,7)
			[-] if (WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.Exists(20))
				[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.TypeKeys(lsUserCredentials[2])
				[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.DoneButton.Click()
				[ ] Agent.SetOption(OPT_VERIFY_ACTIVE,TRUE)
				[-] if (DlgAccountsSynced.Exists(180))
					[ ] DlgAccountsSynced.SetActive()
					[ ] sActual=DlgAccountsSynced.GetCaption()
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[-] if (bMatch==TRUE)
						[ ] ReportStatus("Verify all accounts sync", PASS, "Verify all accounts sync: All Accounts synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,1)
						[ ] 
						[ ] QDSyncNow()
						[ ] sleep(5)
						[ ] ////#########Save CloudSyncLog################////
						[ ] iLog=OpenAndSaveCloudSyncLog()
						[-] if (iLog==PASS)
							[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
							[ ] ////######Get transaction data of manual accounts in a list lsAccount#########
							[ ] lsRequestParameters=GetRequestFromTransactionsList(lsExcelData)
							[ ] 
							[ ] ///####### VerifyTransaction request responses#################////
							[ ] 
							[+] for (iCounter=1;iCounter<ListCount(lsRequestParameters)+1;++iCounter)
								[ ] lsTemp=lsRequestParameters[iCounter]
								[+] if (lsTemp[1]==NULL)
									[ ] break
								[+] for each sItem in lsTemp
									[ ] bMatch= MatchStr("*{rTxnReqResp.sDescription}*",sItem)
									[+] if (bMatch==TRUE)
										[ ] break
								[-] if (bMatch==TRUE)
									[ ] lsDescription=split(sItem,":")
									[-] if (lsDescription[2]!="")
										[ ] lsReqResponse=GetManualTransactionResponseFromCloudSyncLog(lsDescription[2])
										[-] if( ListCount(lsReqResponse)>1)
											[-] for each sReqItem in lsTemp
												[-] for each sRespItem in lsReqResponse
														[ ] bMatch=FALSE
													[+] if (sReqItem==sRespItem)
														[ ] bMatch=TRUE
														[ ] break
												[-] if (bMatch==TRUE)
													[ ] ReportStatus("Verify request data", PASS, " Verify request data with response: Response for payee {lsDescription[2]} data {sRespItem} is as expected request data {sReqItem}.")
												[+] else
													[ ] ReportStatus("Verify request data", FAIL, " Verify request data with response: Response for payee {lsDescription[2]} data is NOT as expected request data {sReqItem}.")
											[ ] // SearchTransactionsInRegister(lsDescription[2])
										[+] else
											[ ] ReportStatus("Verify Payee", FAIL, " Payee {lsDescription[2]} is not present in the SyncLog.")
									[+] else
										[ ] ReportStatus("Verify Payee", FAIL, " Payee is not present in datasheet for this transaction.")
								[+] else
									[ ] ReportStatus("Verify Payee", FAIL, " Payee column is not present in datasheet.")
								[ ] 
							[ ] 
							[ ] ////######Transactions Verified#################////
							[ ] 
						[+] else
							[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log couldn't be saved.")
					[+] else
						[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,1)
				[+] else
					[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
			[+] else
				[ ] ReportStatus("Verify AccountPasswordTextField enabled", FAIL, "Verify AccountPasswordTextField enabled: Verify AccountPasswordTextField disabled.")
		[+] else
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "{lsCloudUserData[1]} SignUp -  {lsCloudUserData[2]} couldn't SignUp.")
		[ ] // Delete created cloudID
		[ ] DeleteCloudID(sPassword)
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] //############# DataSync_VerifyManualAccountTransactionsSync#############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_VerifyManualAccountTransactionsSync()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync manual checking,credit card and saving accounts and will verify Paycheck transactions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 11, 2013		Mukesh	
	[ ] // ********************************************************
[+] testcase DataSync_VerifyManualAccountTransactionsSync() appstate DataSyncBaseState
	[ ] // Read data from excel sheet sCCMintBankCredentials
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCCMintBankCredentials)
	[ ] lsUserCredentials=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sMobileSyncData 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCloudIdData)
	[ ] lsCloudUserData=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sManualTransactions)
	[ ] 
	[ ] rTransactionReqRespRecord rTxnReqResp
	[ ] rTxnReqResp = lsTransactionReqRespValue
	[ ] sDateStamp =FormatDateTime ( AddDateTime (GetDateTime (), 1), "m/d/yyyy") 
	[ ] 
	[ ] sExpected="Accounts Synced"
	[ ] ////######Get transaction data of manual cash account in a list lsAccount#########
	[+] if(FileExists(sSyncLogFile))
		[ ] DeleteFile(sSyncLogFile)
		[ ] sleep(3)
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] //Mobile SignUp
		[ ] // iResult=MobileSignUp(lsCloudUserData[1],lsCloudUserData[2],lsCloudUserData[3])
		[ ]  iResult=MobileSignUp()
		[+] if (iResult==PASS)
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "Verification of {lsCloudUserData[1]} SignUp -  {lsCloudUserData[1]}  is Signed Up successfully.")
			[ ] // WaitForState(MessageBox,TRUE,3)
			[ ] QuickenWindow.SetActive()
			[ ] ////#####Verify all accounts synced####/////////////////
			[ ] /////Selecting checking,credit card and saving accounts ////
			[ ] WinMoblieSync.Click()
			[ ] 
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click()
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,15,165)
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,15,190)
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,15,215)
			[ ] 
			[ ] /////#####AccountPasswordTextField location based click############///
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,330,7)
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.DoneButton.Click()
			[+] if (DlgAccountsSynced.Exists(300))
				[ ] DlgAccountsSynced.SetActive()
				[ ] sActual=DlgAccountsSynced.GetCaption()
				[ ] bMatch = MatchStr("*{sExpected}*", sActual)
				[+] if (bMatch==TRUE)
					[ ] ReportStatus("Verify all accounts sync", PASS, "Verify all accounts sync: All Accounts synced.")
					[ ] DlgAccountsSynced.OK.Click()
					[ ] WaitForState(DlgAccountsSynced,FALSE,1)
					[ ] 
					[ ] sleep(2)
					[ ] QDSyncNow()
					[ ] sleep(5)
					[ ] ////#########Save CloudSyncLog################////
					[ ] iLog=OpenAndSaveCloudSyncLog()
					[+] if (iLog==PASS)
						[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
						[ ] ////######Get transaction data of manual cash account in a list lsAccount#########
						[ ] lsRequestParameters=GetRequestFromTransactionsList(lsExcelData)
						[ ] ///####### VerifyTransaction request responses#################////
						[ ] 
						[+] for (iCounter=1;iCounter<ListCount(lsRequestParameters)+1;++iCounter)
							[ ] lsTemp=lsRequestParameters[iCounter]
							[+] if (lsTemp[1]==NULL)
								[ ] break
							[+] for each sItem in lsTemp
								[ ] bMatch= MatchStr("*{rTxnReqResp.sDescription}*",sItem)
								[+] if (bMatch==TRUE)
									[ ] break
							[+] if (bMatch==TRUE)
								[ ] lsDescription=split(sItem,":")
								[+] if (lsDescription[2]!="")
									[ ] lsReqResponse=GetManualTransactionResponseFromCloudSyncLog(lsDescription[2])
									[+] if( ListCount(lsReqResponse)>1)
										[+] for each sReqItem in lsTemp
											[+] for each sRespItem in lsReqResponse
													[ ] bMatch=FALSE
												[+] if (sReqItem==sRespItem)
													[ ] bMatch=TRUE
													[ ] break
											[+] if (bMatch==TRUE)
												[ ] ReportStatus("Verify request data", PASS, " Verify request data with response: Response for payee {lsDescription[2]} {sRespItem} is as expected request data {sReqItem}.")
											[+] else
												[ ] ReportStatus("Verify request data", FAIL, " Verify request data with response: Response for payee {lsDescription[2]} is NOT as expected request data {sReqItem}.")
										[ ] SearchTransactionsInRegister(lsDescription[2])
									[+] else
										[ ] ReportStatus("Verify Payee", FAIL, " Request for payee {lsDescription[2]} is not present in the SyncLog.")
								[+] else
									[ ] ReportStatus("Verify Payee", FAIL, " Payee is not present in datasheet for this transaction.")
							[+] else
								[ ] ReportStatus("Verify Payee", FAIL, " Payee column is not present in datasheet.")
								[ ] 
						[ ] ////######Transactions Verified#################////
					[+] else
						[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log couldn't be saved.")
				[+] else
					[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
					[ ] DlgAccountsSynced.OK.Click()
					[ ] WaitForState(DlgAccountsSynced,FALSE,1)
			[+] else
				[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
			[ ] 
			[+] // if (WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.Exists(20))
				[ ] // WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.TypeKeys(lsUserCredentials[2])
				[ ] // WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.DoneButton.Click()
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify AccountPasswordTextField enabled", FAIL, "Verify AccountPasswordTextField enabled: Verify AccountPasswordTextField disabled.")
		[+] else
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "{lsCloudUserData[1]} SignUp -  {lsCloudUserData[2]} couldn't SignUp.")
		[ ] // Delete created cloudID
		[ ] DeleteCloudID(sPassword)
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] //#############  EWC Delete Account #############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_EWC()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync EWC accounts and verify request and responces
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 24, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[ ] 
[+] testcase DataSync_DeleteTransaction_EWC() appstate DataSyncBaseState
	[ ] LIST OF ANYTYPE lsResponseBeforeDelete, lsResponseAfterDelete,lsSyncId
	[ ] STRING sSyncID,sWindowType
	[ ] INTEGER iVerify
	[ ] STRING sDeleteParamOLd="deleted:false"
	[ ] STRING sDeleteParamNEW="deleted:true"
	[ ] STRING sDefaultSaveLocation=AUT_DATAFILE_PATH + "\SyncLog.txt"
	[ ] STRING sDeleteTxnSyncLogLocation=AUT_DATAFILE_PATH + "\SyncLog1.txt"
	[ ] 
	[ ] sWindowType= "MDI"
	[ ] sExpected="Accounts Synced"
	[ ] 
	[ ] // Read data from excel sheet sCCMintBankCredentials
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCCMintBankCredentials)
	[ ] lsUserCredentials=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet sMobileSyncData 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCloudIdData)
	[ ] lsCloudUserData=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sManualTransactions)
	[ ] lsRequestParameters=lsExcelData[1]
	[ ] 
	[ ] lsTransaction=lsExcelData[2]
	[ ] 
	[ ] rTransactionReqRespRecord rTxnReqResp
	[ ] rTxnReqResp = lsTransactionReqRespValue
	[ ] ////#######Delete the synclog.dat from datafile folder####////
	[+] if(FileExists(sSyncLogFile))
		[ ] DeleteFile(sSyncLogFile)
		[ ] sleep(3)
	[ ] 
	[ ] /////##########Creating list of the request parameters and their values to be verified##########////
	[+] for (iCounter=1;iCounter< ListCount(lsRequestParameters)+1; ++iCounter)
		[+] if (lsRequestParameters[iCounter]==NULL)
			[ ] break
		[ ] LIstAppend(lsRequestData, lsRequestParameters[iCounter] + ":" + lsTransaction[iCounter])
	[+] for (iCounter=1;iCounter< ListCount(lsRequestData)+1; ++iCounter)
		[ ] bMatch = MatchStr("*{sDeleteParamOLd}*", lsRequestData[iCounter])
		[+] if ( bMatch == TRUE)
			[ ] ListDelete(lsRequestData,iCounter)
			[ ] ListInsert (lsRequestData,iCounter,sDeleteParamNEW)
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] //Mobile SignUp
		[ ] // iResult=MobileSignUp(lsCloudUserData[1],lsCloudUserData[2],lsCloudUserData[3])
		[ ]  iResult=MobileSignUp()
		[+] if (iResult==PASS)
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "Verification of {lsCloudUserData[1]} SignUp -  {lsCloudUserData[1]}  is Signed Up successfully.")
			[ ] // WaitForState(MessageBox,TRUE,3)
			[ ] QuickenWindow.SetActive()
			[ ] ////#####Verify all accounts synced####/////////////////
			[ ] /////Selecting checking,credit card and saving accounts ////
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click()
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,15,165)
			[ ] 
			[ ] /////#####AccountPasswordTextField location based click############///
			[ ] 
			[ ] WinMoblieSync.Click()
			[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,330,7)
			[+] if (WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.Exists(20))
				[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.AccountPasswordTextField.TypeKeys(lsUserCredentials[2])
				[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.DoneButton.Click()
				[ ] 
				[+] if (DlgAccountsSynced.Exists(180))
					[ ] DlgAccountsSynced.SetActive()
					[ ] sActual=DlgAccountsSynced.GetCaption()
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[+] if (bMatch==TRUE)
						[ ] ReportStatus("Verify account sync", PASS, "Verify account sync: Account synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,1)
						[ ] sleep(3)
						[ ] QDSyncNow()
						[ ] sleep(5)
						[ ] ////#########Save CloudSyncLog################////
						[ ] iLog=OpenAndSaveCloudSyncLog()
						[+] if (iLog==PASS)
							[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
							[ ] ///#######Transaction requests#################////
							[ ] 
							[ ] lsResponseBeforeDelete=GetManualTransactionResponseFromCloudSyncLog(lsTransaction[1])
							[+] if(FileExists(sDefaultSaveLocation))
								[ ] DeleteFile(sDefaultSaveLocation)
							[ ] 
							[+] if (ListCount(lsResponseBeforeDelete)>1)
								[+] for each sItem in lsResponseBeforeDelete
									[ ] bMatch=MatchStr("*{rTxnReqResp.sCategoryId}*",sItem)
									[+] if ( bMatch == TRUE)
										[+] for (iCounter=1 ; iCounter <ListCount( lsRequestData)+1 ; ++iCounter)
											[ ] bMatch=MatchStr("*{rTxnReqResp.sCategoryName}*", lsRequestData [iCounter])
											[+] if ( bMatch == TRUE)
												[ ] ListDelete( lsRequestData ,iCounter)
												[ ] ListAppend(lsRequestData, sItem )
										[ ] 
									[ ] 
								[+] for each sItem in lsResponseBeforeDelete
									[ ] bMatch=MatchStr("*{rTxnReqResp.sSyncID}*",sItem)
									[+] if ( bMatch == TRUE)
										[ ] sSyncID=sItem
										[ ] lsSyncId =Split(sItem,":")
										[ ] sSyncID=lsSyncId[3]
										[ ] break
									[ ] 
								[+] if ( bMatch == TRUE)
									[ ] ////#######Delete the synclog.dat from datafile folder####////
									[+] if(FileExists(sSyncLogFile))
										[ ] DeleteFile(sSyncLogFile)
										[ ] sleep(3)
									[ ] ///////########Delete Transaction from account register#########///
									[ ] QuickenWindow.SetActive()
									[ ] AccountBarSelect(ACCOUNT_BANKING,1)
									[ ] 
									[ ] iVerify=DeleteTransaction(sWindowType, lsTransaction[1])
									[+] if (iVerify==PASS)
										[ ] ReportStatus("Delete Transaction from register", PASS, "Transaction deleted from register")
										[ ] ////#######Now Sync Again##############
										[ ] QuickenWindow.SetActive()
										[ ] QuickenMainWindow.QWNavigator.MobileAlerts.Click()
										[ ] WaitForState(QuickenMainWindow,TRUE,2)
										[ ] QuickenWindow.SetActive()
										[ ] WinMoblieSync.Click()
										[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.SyncNowButton.Click()
										[ ] Agent.SetOption(OPT_REQUIRE_ACTIVE,FALSE)
										[+] if(DlgCloudSyncComplete.Exists(120))
											[ ] DlgCloudSyncComplete.OKButton.Click()
											[ ] Agent.SetOption(OPT_REQUIRE_ACTIVE,TRUE)
											[ ] 
											[ ] ReportStatus("Sync data file to cloud",PASS,"Sync complete")
											[ ] ////########Save CloudSyncLog##################///
											[ ] iLog=FAIL
											[ ] sleep(3)
											[ ] QDSyncNow()
											[ ] sleep(5)
											[ ] iLog=OpenAndSaveCloudSyncLog(sDeleteTxnSyncLogLocation)
											[+] if (iLog==PASS)
												[+] for  (iCounter=1;iCounter<ListCount(lsResponseBeforeDelete)+1;++iCounter)
													[ ] bMatch = MatchStr("*{sDeleteParamOLd}*", lsResponseBeforeDelete[iCounter])
													[+] if ( bMatch == TRUE)
														[ ] ListDelete(lsResponseBeforeDelete,iCounter)
														[ ] ListInsert (lsResponseBeforeDelete,iCounter,sDeleteParamNEW)
												[ ] lsResponseAfterDelete=GetDeletedManualTransactionResponseFromCloudSyncLog(lsTransaction[1],sSyncID,lsResponseBeforeDelete)
												[+] if (ListCount(lsResponseAfterDelete)>1)
													[+] for each sItem in lsRequestData
														[+] for each sRespItem in lsResponseAfterDelete
															[ ] bMatch = MatchStr("*{sItem}*", sRespItem)
															[+] if( bMatch==TRUE)
																[ ] break
																[ ] 
														[+] if (bMatch==TRUE)
															[ ] ReportStatus("Verify Delete request data", PASS, " Verify Delete request data with response:Delete response for payee {lsTransaction[1]} : {sRespItem} is as expected request data {sItem}.")
														[+] else
															[ ] ReportStatus("Verify Delete request data", FAIL, " Verify Delete request data with response: Delete response for payee {lsTransaction[1]} data is NOT as expected request data {sItem}.")
													[ ] /////####Search Transaction in register for duplicacy###////
													[ ] QuickenWindow.SetActive()
													[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
													[ ] WaitForState(DlgFindAndReplace,True,2)
													[+] if (DlgFindAndReplace.Exists(5))
														[ ] DlgFindAndReplace.SetActive()
														[ ] DlgFindAndReplace.SearchTextField.SetText(lsTransaction[1])
														[ ] DlgFindAndReplace.FindButton.Click()
														[+] if (AlertMessage.Exists(2))
															[ ] ReportStatus("Verify Transaction exists,", PASS, "Transaction with Payee {lsTransaction[1]} deleted.")
															[ ] AlertMessage.OK.Click()
														[+] else
															[ ] ReportStatus("Verify Transaction exists,", FAIL, "Transaction with Payee {lsTransaction[1]} didn't delete.")
														[ ] DlgFindAndReplace.DoneButton.Click()
														[ ] WaitForState(DlgFindAndReplace,FALSE,1)
													[+] else
														[ ] ReportStatus("Verify transactions not duplicated after sync", FAIL, "Verify transactions not duplicated after sync: Dialog Find and Replace didn't appear.")
												[+] else
													[ ] ReportStatus(" Verify Delete request in the SyncLog", FAIL, "Verify Delete request in the SyncLog: Request for payee {lsTransaction[1]} not found in the SyncLog.")
											[+] else
												[ ] ReportStatus("Save Cloud Log", FAIL, "Quicken Cloud Log couldn't be after delete saved.")
											[ ] 
										[+] else
											[ ] ReportStatus("Sync data file to cloud",FAIL,"Sync not complete")
										[ ] 
									[+] else
										[ ] ReportStatus("Delete Transaction from register", FAIL, "Transaction didn't delete from register")
								[+] else
									[ ] ReportStatus("Verify the SyncID", FAIL, "SyncID not found.")
									[ ] 
							[+] else
								[ ] ReportStatus(" Verify request in the SyncLog", FAIL, "Verify request in the SyncLog: Request for payee {lsTransaction[1]} not found in the SyncLog.")
						[+] else
							[ ] ReportStatus("Save Cloud Log", FAIL, "Quicken Cloud Log couldn't be saved.")
					[+] else
						[ ] ReportStatus("Verify account sync", FAIL, "Verify account sync: Account NOT synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,1)
				[+] else
					[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
			[+] else
				[ ] ReportStatus("Verify AccountPasswordTextField enabled", FAIL, "Verify AccountPasswordTextField enabled: Verify AccountPasswordTextField disabled.")
		[+] else
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "{lsCloudUserData[1]} SignUp -  {lsCloudUserData[2]} couldn't SignUp.")
		[ ] // Delete created cloudID
		[ ] DeleteCloudID(sPassword)
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[+] //############# DataSync_VerifyThreeLevelCategorySync#############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_VerifyThreeLevelCategorySync()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create three level categories and will use these categories in transactions
		[ ] //   and will verify transactions request and responses
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if trnsaction alongwith category verification is successful
		[ ] //						Fail		if trnsaction alongwith category verification is unsuccessful
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 16, 2013		Mukesh	
	[ ] // ********************************************************
[+] testcase DataSync_VerifyThreeLevelCategorySync() appstate DataSyncBaseState
	[ ] // Read data from excel sheet sCCMintBankCredentials
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCCMintBankCredentials)
	[ ] lsUserCredentials=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sMobileSyncData 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCloudIdData)
	[ ] lsCloudUserData=lsExcelData[1]
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsCategoryExcelData=NULL
	[ ] lsCategoryExcelData=ReadExcelTable(sMobileSyncData, sSyncCategoriesSheet)
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sTransactionSheet)
	[ ] // Read data from excel sheet sSyncCategoriesTransactions
	[ ] lsCatTxnExcelData=NULL
	[ ] lsCatTxnExcelData=ReadExcelTable(sMobileSyncData, sSyncCategoriesTransactions)
	[ ] 
	[ ] 
	[ ] ////read rAccountReqRespRecord
	[ ] rAccountReqRespRecord rAccountReqResp
	[ ] rAccountReqResp = lsAccountReqRespRecordValue
	[ ] ///////Fetching the Transaction request record////
	[ ] rTransactionReqRespRecord rTxnReqResp
	[ ] rTxnReqResp = lsTransactionReqRespValue
	[ ] 
	[ ] ///////Fetching the Categoryrequest record////
	[ ] rCategoryReqRespRecord rCatReqResp
	[ ] rCatReqResp = lsCategoryReqRespValue
	[ ] 
	[ ] 
	[ ] sDateStamp =FormatDateTime (GetDateTime () , "m/d/yyyy") 
	[ ] 
	[ ] sExpected="Accounts Synced"
	[ ] ///Delete the existing synclog///
	[+] if(FileExists(sSyncLogFile))
		[ ] DeleteFile(sSyncLogFile)
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.MobileAlerts.DoubleClick()
		[ ] // iResult=MobileSignUpComplete(lsCloudUserData[1] , lsCloudUserData[2] , lsCloudUserData[3], lsUserCredentials[2] )
		[ ] iResult=MobileSignUpComplete( lsUserCredentials[2] )
		[ ] 
		[+] if (iResult==PASS)
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "Verification of {lsCloudUserData[1]} SignUp -  {lsCloudUserData[1]}  is Signed Up successfully.")
			[ ] ///Delete the existing synclog///
			[+] if(FileExists(sSyncLogFile))
				[ ] DeleteFile(sSyncLogFile)
			[ ] 
			[ ] lsAddAccount=lsExcelAccountData[1]
			[ ] sAccountName=lsAddAccount[1]
			[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ///Add categories///
				[+] for (iCounter=1;iCounter<4 ; ++iCounter)
					[ ] lsCategoryData=lsCategoryExcelData[iCounter]
					[+] if (lsCategoryData[1]==NULL)
						[ ] break
					[+] if (iCounter==3)
						[ ] //// parent categaory has leading spaces on the setupcategory dialog//
						[ ] lsCategoryData[4] = "  " +lsCategoryData[4]
					[ ] AddCategory(lsCategoryData[1], lsCategoryData[2], lsCategoryData[3], lsCategoryData[4] )	
					[ ] 
				[ ] 
				[ ] ///Added categories///
				[ ] ////Add transaction with added categories///
				[+] for (iCounter=1 ; iCounter< 4; ++iCounter)
					[ ] lsTransaction=lsExcelData[iCounter]
					[+] if (lsTransaction[1]==NULL)
						[ ] break
						[ ] 
					[ ] lsCategoryData=lsCategoryExcelData[iCounter]
					[+] if (lsCategoryData[1]==NULL)
						[ ] break
						[ ] 
					[ ] 
					[ ] // sWindowType,STRING sTransactionType, STRING sAmount, STRING sDate , STRING sChequeNo optional, STRING sPayee optional, STRING sMemo  optional, STRING sCategory optional, STRING sTag optional)
					[ ] //WindowType	TransactionMode	Amount	TransactionDate	ChequeNo	Payee	Memo	Category	PayBalance	Account	
					[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,lsTransaction[5],lsTransaction[6],lsTransaction[7], lsCategoryData[1])
					[ ] 
				[ ] ////Sync again to verify the categories along with the transactions//////
				[ ] QDSyncNow()
				[ ] iSync=QDSyncNow()
				[ ] 
				[+] if (iSync==PASS)
					[ ] 
					[ ] ////#########Save CloudSyncLog################////
					[ ] iLog=OpenAndSaveCloudSyncLog()
					[+] if (iLog==PASS)
						[ ] ReportStatus("Save Cloud Log", PASS, "Quicken Cloud Log saved successfully")
						[ ] 
						[ ] ///####### VerifyTransaction request responses#################////
						[ ] ////######Get transaction data of manual accounts in a list lsAccount#########
						[ ] lsRequestParameters=GetRequestFromTransactionsList(lsCatTxnExcelData)
						[ ] 
						[+] for (iItemCounter=1 ; iItemCounter<ListCount(lsRequestParameters)+1 ; ++iItemCounter)
							[ ] lsTemp=lsRequestParameters[iItemCounter]
							[+] if (lsTemp[1]==NULL)
								[ ] break
								[ ] 
							[+] for each sItem in lsTemp
								[ ] bMatch= MatchStr("*{rTxnReqResp.sDescription}*",sItem)
								[+] if (bMatch==TRUE)
									[ ] break
							[+] if (bMatch==TRUE)
								[ ] lsDescription=split(sItem,":")
								[+] if (lsDescription[2]!="")
									[ ] lsReqResponse=GetManualTransactionResponseFromCloudSyncLog(lsDescription[2])
									[+] if( ListCount(lsReqResponse)>1)
										[+] for each sReqItem in lsTemp
											[+] for each sRespItem in lsReqResponse
													[ ] bMatch=FALSE
												[+] if (sReqItem==sRespItem)
													[ ] bMatch=TRUE
													[ ] break
											[+] if (bMatch==TRUE)
												[ ] ReportStatus("Verify request data", PASS, " Verify request data with response: Response for payee {lsDescription[2]} {sRespItem} is as expected request data {sReqItem}.")
											[+] else
												[ ] ReportStatus("Verify request data", FAIL, " Verify request data with response: Response for payee {lsDescription[2]} is NOT as expected request data {sReqItem}.")
										[ ] SearchTransactionsInRegister(lsDescription[2])
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Payee", FAIL, " Request for payee {lsDescription[2]} is not present in the SyncLog.")
								[+] else
									[ ] ReportStatus("Verify Payee", FAIL, " Payee is not present in datasheet for this transaction.")
							[+] else
								[ ] ReportStatus("Verify Payee", FAIL, " Payee column is not present in datasheet.")
								[+] 
									[ ] 
							[ ] 
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Save Cloud Log", FAIL, "Quicken Cloud Log couldn't be after delete saved.")
						[ ] 
				[+] else
					[ ] ReportStatus("Sync data file to cloud",FAIL,"Sync Now couldn't complete.")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account {sAccountName} is selected. ",FAIL,"Account {sAccountName} not selected")
			[ ] 
		[+] else
			[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "{lsCloudUserData[1]} SignUp -  {lsCloudUserData[2]} couldn't SignUp.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] // 
[+] // // ############# DataSync_VerifyRenamedL2CategorySync#############################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 DataSync_VerifyRenamedL2CategorySync()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will rename the 2nd level category and will use these category in transaction
		[ ] // // and will verify transactions request and responses
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 	if transaction alongwith category verification is successful
		[ ] // // Fail		if transaction alongwith category verification is unsuccessful
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // April 18, 2013		Mukesh	
	[ ] // // ********************************************************
[+] testcase DataSync_VerifyRenamedL2CategorySync() appstate QuickenBaseState
	[ ] STRING sRenamedCategory
	[ ] INTEGER iSearch , iEdit
	[ ] LIST OF ANYTYPE lsCatRequestTemp
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet sSyncCategoriesSheet
	[ ] lsCategoryExcelData=NULL
	[ ] lsCategoryExcelData=ReadExcelTable(sMobileSyncData, sSyncCategoriesSheet)
	[ ] 
	[ ] sRenamedCategory =lsCategoryExcelData[2][5]
	[ ] ListAppend(lsCategoryData, sRenamedCategory)
	[ ] /////Fetching the Categoryrequest record////
	[ ] rCategoryReqRespRecord rCatReqResp
	[ ] rCatReqResp = lsCategoryReqRespValue
	[ ] 
	[ ] sExpected="Accounts Synced"
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] CategoryRecord rCatRecord
		[ ] rCatRecord =lsCategoryData
		[ ] sCategory =lsCategoryExcelData[2][1]
		[ ] 
		[ ] // /Rename the category///
		[ ] //////Get the CategoryID from the synclog using the Category name///////
		[ ] sCategory= trim(lsCategoryExcelData[1][1]) + ":" +  trim(lsCategoryExcelData[2][1])
		[ ] sCategory = rCatReqResp.sCategoryName +":" + sCategory
		[ ] lsCatResponse=GetCategoryResponseFromCloudSyncLog(trim(sCategory))
		[ ] 
		[+] for (iCounter=1;iCounter<ListCount(lsCatResponse)+1;++iCounter) 
			[ ] bMatch= MatchStr("*:{rCatReqResp.sId}:*" , lsCatResponse[iCounter])
			[+] if (bMatch==TRUE)
				[ ] sCategoryId=lsCatResponse[iCounter]
				[ ] break
		[ ] 
		[ ] // /Add CategoryID to request to be verified///
		[ ] lsCategoryId=Split(sCategoryId,":")
		[ ] sCategoryIdVal=lsCategoryId[3]
		[ ] 
		[ ] 
		[+] if (sCategoryIdVal != NULL)
			[ ] iEdit = CategoryEdit(rCatRecord, trim(lsCategoryExcelData[2][1]))				// edit category
			[+] if(iEdit == PASS)
				[ ] ReportStatus("Edit Category", PASS, "Category - {sCategory} is editted ") 
				[+] if(CategoryList.Exists())
					[ ] CategoryList.DoneButton.Click()
				[ ] iSync=QDSyncNow()
				[+] if (iSync==PASS)
					[ ] //#########Save CloudSyncLog################////
					[ ] iLog=OpenAndSaveCloudSyncLog()
					[+] if (iLog==PASS)
						[ ] ReportStatus("Save Cloud Log", PASS, "Quicken Cloud Log saved successfully")
						[ ] lsCatRequestTemp=GetUpdateCategoryResponseFromCloudSyncLog(sCategoryIdVal)
						[+] if (ListCount(lsCatRequestTemp)>0)
							[ ] 
							[+] for (iCounter=1;iCounter<ListCount(lsCatRequestTemp)+1;++iCounter) 
								[ ] bMatch=False
								[ ] bMatch = MatchStr("*{rCatReqResp.sCategoryName}:{sRenamedCategory}*", lsCatRequestTemp[iCounter])
								[+] if ( bMatch == TRUE)
									[ ] break
								[ ] 
							[ ] 
							[+] if (bMatch==TRUE)
								[ ] ReportStatus("Verify category ID of renamed category", PASS, " Verify category ID of renamed category: CategoryId {sCategoryIdVal} for category {sCategory} is same after it is renamed to {lsCatRequestTemp[iCounter]}.")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify category ID of renamed category", FAIL, " Verify category ID of renamed category: Category Id {sCategoryIdVal} for category {sCategory} changed when it renamed to {sRenamedCategory} actual data is {lsCatRequestTemp}.")
								[ ] 
						[+] else
							[ ] ReportStatus("Get CategoryId from the synclog", FAIL, " Get CategoryId from the synclog: CategoryId {sCategoryIdVal} for category {sCategory}  not found in the synclog .")
						[ ] 
					[+] else
						[ ] ReportStatus("Save Cloud Log", FAIL, "Quicken Cloud Log couldn't be saved.")
						[ ] 
				[+] else
					[ ] ReportStatus("Sync data file to cloud",FAIL,"Sync Now couldn't complete.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Edit Category", FAIL, "Category - {sCategory} couldn't be editted ") 
				[+] if(CategoryList.Exists())
					[ ] CategoryList.DoneButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Get CategoryId from the synclog", FAIL, " Get CategoryId from the synclog: CategoryId for category {sCategory}  not found in the synclog .")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[ ] // 
[+] // // ############# DataSync_VerifyL4LevelCategorySync#############################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 DataSync_VerifyL4LevelCategorySync()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will create L4 level category and will use these category in transactions
		[ ] // // and will verify transaction's request and responses
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 	if transaction alongwith category verification is successful
		[ ] // // Fail		if transaction alongwith category verification is unsuccessful
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // April 22, 2013		Mukesh	
	[ ] // // ********************************************************
[+] testcase DataSync_VerifyL4LevelCategorySync() appstate QuickenBaseState
	[ ] STRING sRenamedCategory
	[ ] INTEGER iSearch , iEdit
	[ ] LIST OF ANYTYPE lsRenamedCatResp
	[ ] 
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsCategoryExcelData=NULL
	[ ] lsCategoryExcelData=ReadExcelTable(sMobileSyncData, sSyncCategoriesSheet)
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] 
	[ ] sRenamedCategory =lsCategoryExcelData[2][5]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sTransactionSheet)
	[ ] sPayee= lsExcelData[2][6]
	[ ] // Read data from excel sheet sSyncCategoriesTransactions
	[ ] lsCatTxnExcelData=NULL
	[ ] lsCatTxnExcelData=ReadExcelTable(sMobileSyncData, sSyncCategoriesTransactions)
	[ ] //######Get transaction data of manual accounts in a list lsAccount#########
	[ ] lsRequestParameters=GetRequestFromTransactionsList(lsCatTxnExcelData)
	[ ] 
	[ ] //read rAccountReqRespRecord
	[ ] rAccountReqRespRecord rAccountReqResp
	[ ] rAccountReqResp = lsAccountReqRespRecordValue
	[ ] /////Fetching the Transaction request record////
	[ ] rTransactionReqRespRecord rTxnReqResp
	[ ] rTxnReqResp = lsTransactionReqRespValue
	[ ] 
	[ ] /////Fetching the Categoryrequest record////
	[ ] rCategoryReqRespRecord rCatReqResp
	[ ] rCatReqResp = lsCategoryReqRespValue
	[ ] 
	[ ] 
	[ ] sDateStamp =FormatDateTime (GetDateTime () , "m/d/yyyy") 
	[ ] 
	[ ] sExpected="Accounts Synced"
	[ ] // /Delete the existing synclog///
	[+] // if(FileExists(sSyncLogFile))
		[ ] // DeleteFile(sSyncLogFile)
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] lsAddAccount=lsExcelAccountData[1]
		[ ] sAccountName=lsAddAccount[1]
		[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] // /Add categories///
			[ ] lsCategoryData=lsCategoryExcelData[4]
			[ ]  lsCategoryData[4] = "    " + lsCategoryData[4]
			[ ] iResult=AddCategory(lsCategoryData[1], lsCategoryData[2], lsCategoryData[3], lsCategoryData[4])	
			[+] if (iResult==PASS)
				[ ] // Verify if Find and replace window is opened
				[ ] QuickenWindow.SetActive()
				[ ] //Search and update the transaction with L1:EditedL2 category///
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
				[+] if(DlgFindAndReplace.Exists(5))
					[ ] DlgFindAndReplace.SetActive()
					[ ] sExpected=trim(lsCategoryExcelData[1][1])+":" + trim(lsCategoryExcelData[2][5]) + ":"+ trim(lsCategoryExcelData[3][1])+":" +trim(lsCategoryExcelData[4][1])
					[ ] sMenuItem="Category"
					[ ] DlgFindAndReplace.SearchTextField.SetText(sPayee)
					[ ] DlgFindAndReplace.FindButton.Click()
					[ ] DlgFindAndReplace.SelectAllButton.Click()
					[ ] DlgFindAndReplace.ReplacePopupList.Select(sMenuItem)
					[ ] DlgFindAndReplace.ReplacementTextField.ClearText()
					[ ] DlgFindAndReplace.ReplacementTextField.SetText(sExpected)
					[ ] DlgFindAndReplace.TypeKeys(KEY_TAB)
					[ ] DlgFindAndReplace.SetActive()
					[ ] DlgFindAndReplace.ReplaceAllButton.DoubleClick()
					[ ] WaitForState(DlgFindAndReplace,True,1)
					[ ] DlgFindAndReplace.DoneButton.Click()
					[ ] WaitForState(DlgFindAndReplace,False,1)
					[ ] 
					[ ] // Verify transaction's category has been edited////
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] iVerify=FindTransaction(sMDIWindow ,sExpected)
					[+] if (iVerify==PASS)
						[ ] 
						[ ] //Sync again to verify the categories along with the transactions//////
						[ ] QDSyncNow()
						[ ] iSync=QDSyncNow()
						[+] if (iSync==PASS)
							[ ] 
							[ ] //#########Save CloudSyncLog################////
							[ ] iLog=OpenAndSaveCloudSyncLog()
							[+] if (iLog==PASS)
								[ ] ReportStatus("Save Cloud Log", PASS, "Quicken Cloud Log saved successfully")
								[ ] 
								[ ] // /####### VerifyTransaction request responses#################////
								[ ] 
								[+] for (iItemCounter=1 ; iItemCounter<ListCount(lsRequestParameters)+1 ; ++iItemCounter)
									[ ] lsTemp=lsRequestParameters[iItemCounter]
									[+] if (lsTemp[1]==NULL)
										[ ] break
										[ ] 
									[+] for (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
										[ ] bMatch= MatchStr("*{rTxnReqResp.sDescription}:{sPayee}*", lsTemp[iCounter])
										[+] if (bMatch==TRUE)
											[ ] //////Get the CategoryID from the synclog using the Category name///////
											[ ] // /Added the rCatReqResp.sCategoryName parameter ////
											[ ] // Modified the category as createcategory request is available for L2 make it like "L1:L2:L3:L4"///
											[ ] sExpected=trim(lsCategoryExcelData[1][1])+":" + trim(lsCategoryExcelData[2][1]) + ":"+ trim(lsCategoryExcelData[3][1])+":" +trim(lsCategoryExcelData[4][1])
											[ ] sExpected = rCatReqResp.sCategoryName +":" + sExpected
											[ ] lsCatResponse=GetCategoryResponseFromCloudSyncLog(trim(sExpected))
											[+] for (iCounter=1;iCounter<ListCount(lsCatResponse)+1;++iCounter) 
												[ ] bMatch= MatchStr("*:{rCatReqResp.sId}:*" , lsCatResponse[iCounter])
												[+] if (bMatch==TRUE)
													[ ] sCategoryId=lsCatResponse[iCounter]
													[ ] break
											[ ] 
											[ ] // /Add CategoryID to request to be verified///
											[ ] lsCategoryId=Split(sCategoryId,":")
											[ ] sCategoryIdVal=lsCategoryId[3]
											[+] if (sCategoryIdVal != NULL)
												[+] for  (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
													[ ] bMatch= MatchStr("*{rCatReqResp.sCategoryId}*",lsTemp[iCounter])
													[+] if (bMatch==TRUE)
														[ ] bMatch=FALSE
														[ ] ListDelete(lsTemp,iCounter )
														[+] if (iCounter>ListCount(lsTemp))
															[ ] ListAppend (lsTemp , "{rTxnReqResp.sCategoryId}:{sCategoryIdVal}")
														[+] else
															[ ] ListInsert (lsTemp , iCounter , "{rTxnReqResp.sCategoryId}:{sCategoryIdVal}")
												[+] for each sItem in lsTemp
													[ ] bMatch= MatchStr("*{rTxnReqResp.sDescription}*",sItem)
													[+] if (bMatch==TRUE)
														[ ] break
												[+] if (bMatch==TRUE)
													[ ] lsDescription=split(sItem,":")
													[+] if (lsDescription[2]!="")
														[ ] lsReqResponse=GetManualTransactionResponseFromCloudSyncLog(trim(lsDescription[2]) ,sCategoryIdVal )
														[+] if( ListCount(lsReqResponse)>1)
															[+] for each sReqItem in lsTemp
																[+] for each sRespItem in lsReqResponse
																		[ ] bMatch=FALSE
																	[+] if (sReqItem==sRespItem)
																		[ ] bMatch=TRUE
																		[ ] break
																[+] if (bMatch==TRUE)
																	[ ] ReportStatus("Verify request data", PASS, " Verify request data with response: Response for payee {lsDescription[2]} {sRespItem} is as expected request data {sReqItem}.")
																[+] else
																	[ ] ReportStatus("Verify request data", FAIL, " Verify request data with response: Response for payee {lsDescription[2]} is NOT as expected request data {sReqItem}.")
															[ ] SearchTransactionsInRegister(lsDescription[2])
															[ ] 
															[ ] 
														[+] else
															[ ] ReportStatus("Verify Payee", FAIL, " Request for payee {lsDescription[2]} is not present in the SyncLog.")
													[+] else
														[ ] ReportStatus("Verify Payee", FAIL, " Payee is not present in datasheet for this transaction.")
												[+] else
													[ ] ReportStatus("Verify Payee", FAIL, " Payee column is not present in datasheet.")
													[ ] 
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Get CategoryId from the synclog", FAIL, " Get CategoryId from the synclog: CategoryId for category {lsCategoryName[2]}  not found in the synclog .")
											[ ] 
											[ ] break
									[+] if (bMatch==TRUE)
										[ ] break
										[ ] 
							[+] else
								[ ] ReportStatus("Save Cloud Log", FAIL, "Quicken Cloud Log couldn't be after delete saved.")
								[ ] 
						[+] else
							[ ] ReportStatus("Sync data file to cloud",FAIL,"Sync Now couldn't complete.")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify transaction's category has been edited.", FAIL, "Verify transaction's category has been edited: Transaction with payee {sPayee}'s category couldn't be updated to {sExpected} in account {sAccountName} ") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify dialog Find And Replace", FAIL, "Verify dialog Find And Replace: Dialog Find And Replace doesn't exist.") 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus(" Verfiy category added", FAIL, "Category:{lsCategoryData[1]} couldn't be added properly.") 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account {sAccountName} is selected. ",FAIL,"Account {sAccountName} not selected")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] // // ############# DataSync_VerifyL2LevelCategorySync#############################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 DataSync_VerifyL2LevelCategorySync()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will create one L2 level category and will use these category in transactions
		[ ] // // and will verify transaction's request and responses
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 	if transaction alongwith category verification is successful
		[ ] // // Fail		if transaction alongwith category verification is unsuccessful
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // April 24, 2013		Mukesh	
	[ ] // // ********************************************************
[+] testcase DataSync_VerifyL2LevelCategorySync() appstate QuickenBaseState
	[ ] STRING sRenamedCategory
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsCategoryExcelData=NULL
	[ ] lsCategoryExcelData=ReadExcelTable(sMobileSyncData, sSyncCategoriesSheet)
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] 
	[ ] sRenamedCategory =lsCategoryExcelData[2][5]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sTransactionSheet)
	[ ] sPayee= lsExcelData[2][6]
	[ ] // Read data from excel sheet sSyncCategoriesTransactions
	[ ] lsCatTxnExcelData=NULL
	[ ] lsCatTxnExcelData=ReadExcelTable(sMobileSyncData, sSyncCategoriesTransactions)
	[ ] //######Get transaction data of manual accounts in a list lsAccount#########
	[ ] lsRequestParameters=GetRequestFromTransactionsList(lsCatTxnExcelData)
	[ ] 
	[ ] //read rAccountReqRespRecord
	[ ] rAccountReqRespRecord rAccountReqResp
	[ ] rAccountReqResp = lsAccountReqRespRecordValue
	[ ] /////Fetching the Transaction request record////
	[ ] rTransactionReqRespRecord rTxnReqResp
	[ ] rTxnReqResp = lsTransactionReqRespValue
	[ ] 
	[ ] /////Fetching the Categoryrequest record////
	[ ] rCategoryReqRespRecord rCatReqResp
	[ ] rCatReqResp = lsCategoryReqRespValue
	[ ] 
	[ ] 
	[ ] sDateStamp =FormatDateTime (GetDateTime () , "m/d/yyyy") 
	[ ] 
	[ ] sExpected="Accounts Synced"
	[ ] // /Delete the existing synclog///
	[+] // if(FileExists(sSyncLogFile))
		[ ] // DeleteFile(sSyncLogFile)
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] // /Add categories///
		[ ] lsCategoryData=lsCategoryExcelData[5]
		[ ] iResult=AddCategory(lsCategoryData[1], lsCategoryData[2], lsCategoryData[3], lsCategoryData[4])	
		[+] if (iResult==PASS)
			[ ] // Verify if Find and replace window is opened
			[ ] QuickenWindow.SetActive()
			[ ] lsAddAccount=lsExcelAccountData[1]
			[ ] sAccountName=lsAddAccount[1]
			[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] //Search and update the transaction with L1:EditedL2 category///
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
				[+] if(DlgFindAndReplace.Exists(5))
					[ ] DlgFindAndReplace.SetActive()
					[ ] sExpected=trim(lsCategoryExcelData[1][1])+":" + trim(lsCategoryExcelData[5][1])
					[ ] sMenuItem="Category"
					[ ] DlgFindAndReplace.SearchTextField.SetText(sPayee)
					[ ] DlgFindAndReplace.FindButton.Click()
					[ ] DlgFindAndReplace.SelectAllButton.Click()
					[ ] DlgFindAndReplace.ReplacePopupList.Select(sMenuItem)
					[ ] DlgFindAndReplace.ReplacementTextField.ClearText()
					[ ] DlgFindAndReplace.ReplacementTextField.SetText(sExpected)
					[ ] DlgFindAndReplace.TypeKeys(KEY_TAB)
					[ ] DlgFindAndReplace.SetActive()
					[ ] DlgFindAndReplace.ReplaceAllButton.DoubleClick()
					[ ] WaitForState(DlgFindAndReplace,True,1)
					[ ] DlgFindAndReplace.DoneButton.Click()
					[ ] WaitForState(DlgFindAndReplace,False,1)
					[ ] 
					[ ] // Verify transaction's category has been edited////
					[ ] QuickenWindow.SetActive()
					[ ] iVerify=FindTransaction(sMDIWindow ,sExpected)
					[+] if (iVerify==PASS)
						[ ] 
						[ ] //Sync again to verify the categories along with the transactions//////
						[ ] QDSyncNow()
						[ ] iSync=QDSyncNow()
						[+] if (iSync==PASS)
							[ ] 
							[ ] //#########Save CloudSyncLog################////
							[ ] iLog=OpenAndSaveCloudSyncLog()
							[+] if (iLog==PASS)
								[ ] ReportStatus("Save Cloud Log", PASS, "Quicken Cloud Log saved successfully")
								[ ] 
								[ ] // /####### VerifyTransaction request responses#################////
								[ ] 
								[+] for (iItemCounter=1 ; iItemCounter<ListCount(lsRequestParameters)+1 ; ++iItemCounter)
									[ ] lsTemp=lsRequestParameters[iItemCounter]
									[+] if (lsTemp[1]==NULL)
										[ ] break
										[ ] 
									[+] for (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
										[ ] bMatch= MatchStr("*{rTxnReqResp.sDescription}:{sPayee}*", lsTemp[iCounter])
										[+] if (bMatch==TRUE)
											[ ] //////Get the CategoryID from the synclog using the Category name///////
											[ ] // /Added the rCatReqResp.sCategoryName parameter ////
											[ ] // Modified the category as createcategory request is available for L2 make it like "L1:L21"///
											[ ] sExpected = rCatReqResp.sCategoryName +":" + sExpected
											[ ] lsCatResponse=GetCategoryResponseFromCloudSyncLog(trim(sExpected))
											[+] for (iCounter=1;iCounter<ListCount(lsCatResponse)+1;++iCounter) 
												[ ] bMatch= MatchStr("*:{rCatReqResp.sId}:*" , lsCatResponse[iCounter])
												[+] if (bMatch==TRUE)
													[ ] sCategoryId=lsCatResponse[iCounter]
													[ ] break
											[ ] 
											[ ] // /Add CategoryID to request to be verified///
											[ ] lsCategoryId=Split(sCategoryId,":")
											[ ] sCategoryIdVal=lsCategoryId[3]
											[+] if (sCategoryIdVal != NULL)
												[+] for  (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
													[ ] bMatch= MatchStr("*{rCatReqResp.sCategoryId}*",lsTemp[iCounter])
													[+] if (bMatch==TRUE)
														[ ] bMatch=FALSE
														[ ] ListDelete(lsTemp,iCounter )
														[+] if (iCounter>ListCount(lsTemp))
															[ ] ListAppend (lsTemp , "{rTxnReqResp.sCategoryId}:{sCategoryIdVal}")
														[+] else
															[ ] ListInsert (lsTemp , iCounter , "{rTxnReqResp.sCategoryId}:{sCategoryIdVal}")
												[+] for each sItem in lsTemp
													[ ] bMatch= MatchStr("*{rTxnReqResp.sDescription}*",sItem)
													[+] if (bMatch==TRUE)
														[ ] break
												[+] if (bMatch==TRUE)
													[ ] lsDescription=split(sItem,":")
													[+] if (lsDescription[2]!="")
														[ ] lsReqResponse=GetManualTransactionResponseFromCloudSyncLog(trim(lsDescription[2]) , trim(sCategoryIdVal))
														[+] if( ListCount(lsReqResponse)>1)
															[+] for each sReqItem in lsTemp
																[+] for each sRespItem in lsReqResponse
																		[ ] bMatch=FALSE
																	[+] if (sReqItem==sRespItem)
																		[ ] bMatch=TRUE
																		[ ] break
																[+] if (bMatch==TRUE)
																	[ ] ReportStatus("Verify request data", PASS, " Verify request data with response: Response for payee {lsDescription[2]} {sRespItem} is as expected request data {sReqItem}.")
																[+] else
																	[ ] ReportStatus("Verify request data", FAIL, " Verify request data with response: Response for payee {lsDescription[2]} is NOT as expected request data {sReqItem}.")
															[ ] SearchTransactionsInRegister(lsDescription[2])
															[ ] 
															[ ] 
														[+] else
															[ ] ReportStatus("Verify Payee", FAIL, " Request for payee {lsDescription[2]} is not present in the SyncLog.")
													[+] else
														[ ] ReportStatus("Verify Payee", FAIL, " Payee is not present in datasheet for this transaction.")
												[+] else
													[ ] ReportStatus("Verify Payee", FAIL, " Payee column is not present in datasheet.")
													[ ] 
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Get CategoryId from the synclog", FAIL, " Get CategoryId from the synclog: CategoryId for category {lsCategoryName[2]}  not found in the synclog .")
											[ ] 
											[ ] break
									[+] if (bMatch==TRUE)
										[ ] break
										[ ] 
							[+] else
								[ ] ReportStatus("Save Cloud Log", FAIL, "Quicken Cloud Log couldn't be after delete saved.")
								[ ] 
						[+] else
							[ ] ReportStatus("Sync data file to cloud",FAIL,"Sync Now couldn't complete.")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify transaction's category has been edited.", FAIL, "Verify transaction's category has been edited: Transaction with payee {sPayee}'s category couldn't be updated to {sExpected} in account {sAccountName} ") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify dialog Find And Replace", FAIL, "Verify dialog Find And Replace: Dialog Find And Replace doesn't exist.") 
			[+] else
				[ ] ReportStatus("Verify Account {sAccountName} is selected. ",FAIL,"Account {sAccountName} not selected")
			[ ] 
		[+] else
			[ ] ReportStatus(" Verfiy category added", FAIL, "Category:{lsCategoryData[1]} couldn't be added properly.") 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] // ############# DataSync_VerifyUncategorizedTransactionsSync#############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_VerifyUncategorizedTransactionsSync()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will create an uncategorized transaction 
		[ ] // and will verify transaction's request and responses
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	if transaction alongwith category verification is successful
		[ ] // Fail		if transaction alongwith category verification is unsuccessful
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // April 25, 2013		Mukesh	
	[ ] // ********************************************************
[+] testcase DataSync_VerifyUncategorizedTransactionsSync() appstate QuickenBaseState
	[ ] STRING sRenamedCategory
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsCategoryExcelData=NULL
	[ ] lsCategoryExcelData=ReadExcelTable(sMobileSyncData, sSyncCategoriesSheet)
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] 
	[ ] sRenamedCategory =lsCategoryExcelData[2][5]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sTransactionSheet)
	[ ] sPayee= lsExcelData[2][6]
	[ ] // Read data from excel sheet sSyncCategoriesTransactions
	[ ] lsCatTxnExcelData=NULL
	[ ] lsCatTxnExcelData=ReadExcelTable(sMobileSyncData, sSyncCategoriesTransactions)
	[ ] //######Get transaction data of manual accounts in a list lsAccount#########
	[ ] lsRequestParameters=GetRequestFromTransactionsList(lsCatTxnExcelData)
	[ ] 
	[ ] /////Fetching the Transaction request record////
	[ ] rTransactionReqRespRecord rTxnReqResp
	[ ] rTxnReqResp = lsTransactionReqRespValue
	[ ] 
	[ ] /////Fetching the Categoryrequest record////
	[ ] rCategoryReqRespRecord rCatReqResp
	[ ] rCatReqResp = lsCategoryReqRespValue
	[ ] sExpected=trim(lsCategoryExcelData[1][1])+":" + trim(lsCategoryExcelData[5][1])
	[ ] 
	[ ] // /Delete the existing synclog///
	[+] if(FileExists(sSyncLogFile))
		[ ] DeleteFile(sSyncLogFile)
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] // Verify if Find and replace window is opened
		[ ] QuickenWindow.SetActive()
		[ ] lsAddAccount=lsExcelAccountData[1]
		[ ] sAccountName=lsAddAccount[1]
		[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] iVerify=FindTransaction(sMDIWindow , sPayee)
			[+] if (iVerify==PASS)
				[ ] //Search and update the transaction with L1:L2 category as Uncategorized transaction///
				[ ] 
				[ ] // Verify transaction's category has been edited////
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.Click()
				[+] if (SplitTransaction.Exists(5))
					[ ] SplitTransaction.SetActive()
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#1")
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.ClearText()
					[ ] SplitTransaction.OK.Click()
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
					[ ] 
					[ ] //Sync again to verify the categories along with the transactions//////
					[ ] QDSyncNow()
					[ ] iSync=QDSyncNow()
					[+] if (iSync==PASS)
						[ ] 
						[ ] //#########Save CloudSyncLog################////
						[ ] iLog=OpenAndSaveCloudSyncLog()
						[+] if (iLog==PASS)
							[ ] ReportStatus("Save Cloud Log", PASS, "Quicken Cloud Log saved successfully")
							[ ] 
							[ ] // /####### VerifyTransaction request responses#################////
							[ ] 
							[+] for (iItemCounter=1 ; iItemCounter<ListCount(lsRequestParameters)+1 ; ++iItemCounter)
								[ ] lsTemp=lsRequestParameters[iItemCounter]
								[+] if (lsTemp[1]==NULL)
									[ ] break
									[ ] 
								[+] for (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
									[ ] bMatch= MatchStr("*{rTxnReqResp.sDescription}:{sPayee}*", lsTemp[iCounter])
									[+] if (bMatch==TRUE)
										[ ] 
										[ ] // /Add CategoryID to request to be verified///
										[ ] // /CategoryID for Uncategorized category should be "20"////
										[ ] sCategoryIdVal="20"
										[+] if (sCategoryIdVal != NULL)
											[+] for  (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
												[ ] bMatch= MatchStr("*{rCatReqResp.sCategoryId}*",lsTemp[iCounter])
												[+] if (bMatch==TRUE)
													[ ] bMatch=FALSE
													[ ] ListDelete(lsTemp,iCounter )
													[+] if (iCounter>ListCount(lsTemp))
														[ ] ListAppend (lsTemp , "{rTxnReqResp.sCategoryId}:{sCategoryIdVal}")
													[+] else
														[ ] ListInsert (lsTemp , iCounter , "{rTxnReqResp.sCategoryId}:{sCategoryIdVal}")
											[+] for each sItem in lsTemp
												[ ] bMatch= MatchStr("*{rTxnReqResp.sDescription}*",sItem)
												[+] if (bMatch==TRUE)
													[ ] break
											[+] if (bMatch==TRUE)
												[ ] lsDescription=split(sItem,":")
												[+] if (lsDescription[2]!="")
													[ ] lsReqResponse=GetManualTransactionResponseFromCloudSyncLog(trim(lsDescription[2]) , trim(sCategoryIdVal))
													[+] if( ListCount(lsReqResponse)>1)
														[+] for each sReqItem in lsTemp
															[+] for each sRespItem in lsReqResponse
																	[ ] bMatch=FALSE
																[+] if (sReqItem==sRespItem)
																	[ ] bMatch=TRUE
																	[ ] break
															[+] if (bMatch==TRUE)
																[ ] ReportStatus("Verify request data", PASS, " Verify Uncategorized request data with response: Uncategorized transaction Response for payee {lsDescription[2]} {sRespItem} is as expected request data {sReqItem}.")
															[+] else
																[ ] ReportStatus("Verify request data", FAIL, " Verify Uncategorized request data with response: Uncategorized transaction Response for payee {lsDescription[2]} is NOT as expected request data {sReqItem}.")
														[ ] SearchTransactionsInRegister(lsDescription[2])
														[ ] 
														[ ] 
													[+] else
														[ ] ReportStatus("Verify Payee", FAIL, " Request for payee {lsDescription[2]} is not present in the SyncLog.")
												[+] else
													[ ] ReportStatus("Verify Payee", FAIL, " Payee is not present in datasheet for this transaction.")
											[+] else
												[ ] ReportStatus("Verify Payee", FAIL, " Payee column is not present in datasheet.")
												[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Get CategoryId from the synclog", FAIL, " Get CategoryId from the synclog: CategoryId for category {lsCategoryName[2]}  not found in the synclog .")
										[ ] 
										[ ] break
								[+] if (bMatch==TRUE)
									[ ] break
									[ ] 
						[+] else
							[ ] ReportStatus("Save Cloud Log", FAIL, "Quicken Cloud Log couldn't be after delete saved.")
							[ ] 
					[+] else
						[ ] ReportStatus("Sync data file to cloud",FAIL,"Sync Now couldn't complete.")
				[+] else
					[ ] ReportStatus("Verify Uncategorized request data with response", FAIL, " Verify Uncategorized request data with response:Split transaction dialog didn't appear hence transaction with: {sPayee} couldn't be set as uncategorized.")
			[+] else
				[ ] ReportStatus("Verify transaction with payee {sPayee} exists.", FAIL, "Verify transaction with payee {sPayee} exists: Transaction with payee {sPayee} doesn't exists.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account {sAccountName} is selected. ",FAIL,"Account {sAccountName} not selected")
			[ ] 
		[ ] 
		[ ] // Delete created cloudID
		[ ] QuickenWindow.SetActive()
		[ ] DeleteCloudID(sPassword)
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] //###########################################################################
[+] //############# DataSync_VerifyDCOnlineTransactionsSync#############################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 DataSync_VerifyDCOnlineTransactionsSync()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync DC accounts and verify request and responses
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 23, 2013		Mukesh	
	[ ] // ********************************************************
[+] testcase DataSync_VerifyDCOnlineTransactionsSync() appstate  DataSyncDcAccountBaseState
	[ ] // Read data from excel sheet sCCMintBankCredentials
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCCMintBankCredentials)
	[ ] lsUserCredentials=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sMobileSyncData 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCloudIdData)
	[ ] lsCloudUserData=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] lsExcelAccountData=NULL
	[ ] lsExcelAccountData=ReadExcelTable(sMobileSyncData, sAccountsAddedWorksheet)
	[ ] // Read data from excel sheet sAccountsAddedWorksheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sDCOnlineTransactions)
	[ ] 
	[ ] 
	[ ] /////Read the rTransactionReqRespRecord///
	[ ] rTransactionReqRespRecord rTxnReqResp
	[ ] rTxnReqResp = lsTransactionReqRespValue
	[ ] 
	[ ] /////Read the rAccountReqRespRecord///
	[ ] 
	[ ] rAccountReqRespRecord rAccountReqResp
	[ ] rAccountReqResp = lsAccountReqRespRecordValue
	[ ] 
	[ ] 
	[ ] 
	[ ] sDateStamp =FormatDateTime ( AddDateTime (GetDateTime (), 1), "m/d/yyyy") 
	[ ] 
	[ ] sExpected="Accounts Synced"
	[ ] STRING sDCAccountPassword="datasync"
	[ ] ////Delete synclog file for DC Account ///
	[ ] 
	[ ] 
	[+] if(FileExists(sDCSyncLogFile))
		[ ] DeleteFile(sDCSyncLogFile)
		[ ] sleep(3)
		[ ] ////Synclog file deleted for DC Account ///
	[ ] ////######Get transaction data of all online accounts in a list lsAccount#########
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] //Perform OSU with Password Vault
		[ ] iResult=OSUWithPasswordVault(sDCAccountPassword)
		[+] if (iResult==PASS)
			[ ] //Mobile SignUp
			[ ] iResult=FAIL
			[ ] // iResult=MobileSignUp(lsCloudUserData[1],lsCloudUserData[2],lsCloudUserData[3])
			[ ]  iResult=MobileSignUp()
			[+] if (iResult==PASS)
				[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "Verification of {lsCloudUserData[1]} SignUp -  {lsCloudUserData[1]}  is Signed Up successfully.")
				[ ] 
				[ ] 
				[ ] ////#####Verify all accounts synced####/////////////////
				[ ] QuickenWindow.SetActive()
				[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.DoneButton.Click()
				[+] if (DlgAccountsSynced.Exists(360))
					[ ] DlgAccountsSynced.SetActive()
					[ ] sActual=DlgAccountsSynced.GetCaption()
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[+] if (bMatch==TRUE)
						[ ] ReportStatus("Verify all accounts sync", PASS, "Verify all accounts sync: All Accounts synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,2)
						[ ] QuickenWindow.SetActive()
						[ ] QDSyncnow()
						[ ] sleep(5)
						[ ] QuickenWindow.SetActive()
						[ ] ////#########Save CloudSyncLog################////
						[ ] iLog=OpenAndSaveCloudSyncLog()
						[+] if (iLog==PASS)
							[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
							[ ] ///#######Transaction requests#################////
							[ ] ////######Get transaction data of all online accounts in a list lsAccount#########
							[ ] lsRequestParameters=GetRequestFromTransactionsList(lsExcelData)
							[ ] 
							[ ] ///####### verifyTransaction request responses#################////
							[ ] 
							[+] for (iItemCounter=1;iItemCounter<ListCount(lsRequestParameters)+1;++iItemCounter)
								[ ] lsTemp=lsRequestParameters[iItemCounter]
								[+] if (lsTemp[1]==NULL)
									[ ] break
									[ ] 
								[+] for (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
									[ ] bMatch= MatchStr("*{rAccountReqResp.sSourceAccountName}*",lsTemp[iCounter])
									[+] if (bMatch==TRUE)
										[ ] sAccountName=lsTemp[iCounter]
										[ ] break
									[ ] 
								[ ] ////////Get the Account name of the trasaction from the request data///////
								[ ] lsAccountName=Split(sAccountName,":")
								[+] if (lsAccountName[2]!=NULL)
									[ ] 
									[ ] ////////Get the AccountID from the synclog using the account name///////
									[ ] lsAccountResponse=GetAccountsResultFromCloudSyncLog(lsAccountName[2])
									[+] for (iCounter=1;iCounter<ListCount(lsAccountResponse)+1;++iCounter) 
										[ ] bMatch= MatchStr("*{rAccountReqResp.sSourceAccountName}*",lsAccountResponse[iCounter])
										[+] if (bMatch==TRUE)
											[+] for (iCount=iCounter;iCount<ListCount(lsAccountResponse)+1;++iCount) 
												[ ] bMatch=false
												[ ] bMatch= MatchStr("*{rAccountReqResp.sSourceAccountId}*",lsAccountResponse[iCount])
												[+] if (bMatch==TRUE)
													[+] for (iAccCount=iCount+1;iAccCount<ListCount(lsAccountResponse)+1;++iAccCount) 
														[ ] bMatch=false
														[ ] bMatch= MatchStr("*{rAccountReqResp.sAccountId}*",lsAccountResponse[iAccCount])
														[+] if (bMatch==TRUE)
															[ ] sAccountId=lsAccountResponse[iAccCount]
															[ ] break
									[ ] 
									[ ] ///Add accountId to request to be verified///
									[ ] lsAccountId=Split(sAccountId,":")
									[ ] iAccountId=VAL(lsAccountId[2])
									[+] if (lsAccountId[2]!=NULL)
										[+] for  (iCounter=1;iCounter<ListCount(lsTemp)+1;++iCounter) 
											[ ] bMatch= MatchStr("*{rAccountReqResp.sSourceAccountName}*",lsTemp[iCounter])
											[+] if (bMatch==TRUE)
												[ ] bMatch=FALSE
												[ ] ListDelete(lsTemp,iCounter )
												[+] if (iCounter>ListCount(lsTemp))
													[ ] ListAppend (lsTemp,sAccountId)
												[+] else
													[ ] ListInsert (lsTemp,iCounter ,sAccountId)
										[ ] 
										[+] for each sItem in lsTemp
											[ ] bMatch= MatchStr("*{rTxnReqResp.sfiTId}*",sItem)
											[+] if (bMatch==TRUE)
												[ ] break
										[+] if (bMatch==TRUE)
											[ ] lsFITID=split(sItem,":")
											[+] if (lsFITID[2]!="")
												[ ] lsReqResponse=GetOnlineTransactionResponseFromSyncLog(lsFITID[2],iAccountId)
												[+] if( ListCount(lsReqResponse)>1)
													[+] for each sReqItem in lsTemp
														[+] for each sRespItem in lsReqResponse
																[ ] bMatch=FALSE
															[+] if (sReqItem==sRespItem)
																[ ] bMatch=TRUE
																[ ] break
														[+] if (bMatch==TRUE)
															[ ] ReportStatus("Verify request data", PASS, " Verify request data with response: Response for FITID {lsFITID[2]}: data {sRespItem} is as expected request data {sReqItem}.")
														[+] else
															[ ] ReportStatus("Verify request data", FAIL, " Verify request data with response: Response FITID {lsFITID[2]}: data is NOT as expected request data {sReqItem}.")
												[+] else
													[ ] ReportStatus("Verify FITID", FAIL, " FITID  {lsFITID[2]} is not present or duplicated in the SyncLog.")
											[+] else
												[ ] ReportStatus("Verify FITID", FAIL, " FITID  {lsFITID[2]} is not present in datasheet for this transaction.")
										[+] else
											[ ] ReportStatus("Verify FITID", FAIL, " FITID column is not present in datasheet.")
									[+] else
										[ ] ReportStatus("Get accountId from the synclog", FAIL, " Get accountId from the synclog: accountId not found in the synclog .")
								[+] else
									[ ] ReportStatus("Get account name from the synclog", FAIL, " Get account name from the synclog: account name not found in the excelsheet .")
								[ ] 
								[ ] 
							[ ] 
							[ ] ////######Transactions Verified#################////
							[ ] 
						[+] else
							[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log couldn't be saved.")
					[+] else
						[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
						[ ] DlgAccountsSynced.OK.Click()
						[ ] WaitForState(DlgAccountsSynced,FALSE,1)
				[+] else
					[ ] ReportStatus("Verify all accounts sync", FAIL, "Verify all accounts sync: Accounts NOT synced.")
			[+] else
				[ ] ReportStatus("{lsCloudUserData[1]} SignUp", iResult, "{lsCloudUserData[1]} SignUp -  {lsCloudUserData[2]} couldn't SignUp.")
			[ ] // Delete created cloudID
			[ ] DeleteCloudID(sPassword)
		[+] else
			[ ] ReportStatus("Verify OSUWithPasswordVault ",FAIL, "Verify OSU With Password Vault: OSU With Password Vault didn't succeed.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[ ] 
