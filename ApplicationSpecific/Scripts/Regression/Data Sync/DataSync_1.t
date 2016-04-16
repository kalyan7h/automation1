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
[+] // Global variables used for Smoke Test cases
	[ ] public STRING sFileName = "EWC Manual DC"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sSyncData = "SyncTestData"
	[ ] public STRING sSplitWorksheet = "Split"
	[ ] public STRING sEWCCheckingWorksheet = "EWC Checking"
	[ ] public STRING sEWCSavingWorksheet = "EWC Savings"
	[ ] public STRING sEWCCreditCardWorksheet = "EWC Credit Card"
	[ ] public STRING sManualCheckingWorksheet = "Manual Checking"
	[ ] public STRING sManualSavingWorksheet = "Manual Savings"
	[ ] public STRING sManualCreditCardWorksheet = "Manual Credit Card"
	[ ] 
	[ ] 
	[ ] public LIST OF ANYTYPE  lsExcelData
	[ ] public STRING sCaption
	[ ] public BOOLEAN bCaption,bExists
	[ ] public INTEGER i,j,iNavigate,iLogin,iLog,iCounter,iDeleteLog
[ ] 
[ ] 
[+] //#############  SetUp #######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will setup the necessary pre-requisite for tests
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
[+] testcase DataSync_SetUp () appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iSetupAutoAPI,iOpenDataFile,iMobileSetup
	[ ] 
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Data Sync\" + sFileName + ".QDF"
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
	[ ] iMobileSetup=SetUp_StageMiniConfig()
	[ ] ReportStatus("Stagemini Setup",iMobileSetup,"StageMini Setup done" )
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] QuickenMainWindow.SetActive()
	[+] else
		[ ] QuickenMainWindow.Start (sCmdLine)
		[ ] 
	[ ] 
	[ ] // Open data file
	[ ] sCaption = QuickenMainWindow.GetCaption()
	[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists(sDataFile)
		[+] if(bExists == TRUE)
			[ ] DeleteFile(sDataFile)
			[ ] QuickenMainWindow.Start (sCmdLine)
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] iOpenDataFile=OpenDataFile(sFileName)
			[ ] ReportStatus("{sFileName} data file open", iOpenDataFile,"{sFileName} data file open")
			[ ] 
		[+] else
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] iOpenDataFile=OpenDataFile(sFileName)
			[ ] ReportStatus("{sFileName} data file open", iOpenDataFile,"{sFileName} data file open")
	[+] else
		[ ] QuickenMainWindow.Close()
		[ ] sleep(SHORT_SLEEP)
		[+] if(FileExists(sDataFile))
			[ ] DeleteFile(sDataFile)
			[ ] 
		[+] else
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] iOpenDataFile=OpenDataFile(sFileName)
			[ ] ReportStatus("{sFileName} data file open", iOpenDataFile,"{sFileName} data file open")
			[ ] 
	[ ] 
	[ ] // Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] // Bypass Registration
	[ ] // BypassRegistration()
	[ ] // Select Home tab
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] // Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  EWC Sync for Checking accounts ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_EWC()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync EWC checking accounts and verify request and responces
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 28, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase DataSync_EWC_Checking () appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sCloudId,sPwd,sZip,sItem,sResponseItem
	[ ] LIST OF ANYTYPE lsResponse,lsResultData1,lsKey,lsValue,lsResponseList,lsResultData2,lsResultData3
	[ ] BOOLEAN bMatch
	[ ] 
	[ ] sCloudId="TestAutomationUser@gmail.com"
	[ ] sPwd="qwerty"
	[ ] sZip="12345"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSyncData, sEWCCheckingWorksheet)
	[ ] lsKey=lsExcelData[1]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // iNavigate=NavigateQuickenTab(sTAB_MOBILE_ALERTS,sTAB_QUICKEN_MOBILE)
		[ ] // ReportStatus("Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}",iNavigate,"Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}")
		[ ] 
		[ ] iLogin=MobileSignUp(sCloudId,sPwd,sZip)
		[ ] ReportStatus("Signup with {sCloudId}", iLogin, "Signup with {sCloudId} successful")
		[ ] 
		[ ] Waitforstate(AccountPasswordTextField,TRUE,SHORT_SLEEP)
		[ ] 
		[+] // if(AccountPasswordTextField.Exists())
			[ ] // AccountPasswordTextField.SetText("datasync")
			[ ] // AccountPasswordTextField.TypeKeys(KEY_TAB)
			[ ] // AccountPasswordTextField.TypeKeys(KEY_ENTER)
		[ ] 
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click ()
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,14,34)
		[ ] 
		[ ] // Click on Done Button
		[ ] Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton,TRUE,70)
		[ ] QuickenMainWindow.SetActive()
		[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton.Click()
		[ ] 
		[ ] // Verify Server side error
		[+] if(AlertMessageBox.Exists(SHORT_SLEEP))
			[ ] ReportStatus("Server Side Verification",FAIL, "Server side error encountered")
			[ ] AlertMessageBox.OK.Click()
		[+] else
			[ ] Waitforstate(DlgCloudSyncComplete,TRUE,90)
			[+] if(DlgCloudSyncComplete.Exists())
				[ ] DlgCloudSyncComplete.OK.Click()
				[+] if(DlgAccountsSynced.Exists(SHORT_SLEEP))
					[ ] DlgAccountsSynced.OK.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Synced window",FAIL,"Account Synced window does not appear")
			[+] else if(DlgAccountsSynced.Exists(MEDIUM_SLEEP))
				[ ] DlgAccountsSynced.OK.Click()
			[+] else
				[ ] ReportStatus("Verify Cloud Sync complete window",FAIL,"Cloud Sync complete window does not appear")
				[ ] 
		[ ] 
		[+] if(WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.HTTP500Error.Exists())
			[ ] ReportStatus("HTTP 500 Error", FAIL, "HTTP 500 error encountered")
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,80)
		[ ] 
		[ ] iLog=OpenAndSaveCloudSyncLog()
		[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
		[ ] // 
		[+] for(j=1;j<ListCount(lsExcelData);++j)
			[ ] lsValue=lsExcelData[j+1]
			[+] for (iCounter=1; iCounter< ListCount(lsKey)+1;++iCounter)
				[+] if(j==1)
					[ ] ListAppend(lsResultData1, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if(j==2)
					[ ] ListAppend(lsResultData2, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if (j==3)
					[ ] ListAppend(lsResultData3, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Sync Expected data",FAIL,"Expected data can not verify")
			[ ] 
		[ ] 
		[ ] // Verify online transaction
		[ ] lsResponse=GetOnlineTransactionResponseFromSyncLog(lsExcelData[2][2])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData1);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData1[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData1[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData1[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData1))
				[ ] break
		[ ] 
		[ ] // Verify manual transaction
		[ ] lsResponse=GetManualTransactionResponseFromCloudSyncLog(lsExcelData[3][3])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData2);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData2[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData2[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(MatchStr("*fiTId*",lsResultData2[iCounter]))
						[ ] //skip
			[+] if(iCounter==ListCount(lsResultData2))
				[ ] break
		[ ] 
		[ ] // Verify split
		[ ] 
		[ ] 
		[ ] QuickenMainWindow.SetActive()
		[+] for(i=2;i<=ListCount(lsExcelData);i++)
			[ ] SearchTransactionsInRegister(lsExcelData[i][3])
		[ ] 
		[ ] 
		[ ] DeleteCloudID()
		[ ] 
		[ ] iDeleteLog=DeleteSyncLogFile(sFileName)
		[ ] ReportStatus("Delete Log",PASS,"Logs are deleted")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  EWC Sync for Savings accounts #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_EWC_Savings()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync EWC checking accounts and verify request and responces
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 04, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase DataSync_EWC_Savings () appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iNavigate,iLogin,iLog,iCounter,iAmount,i,j,iDeleteLog
	[ ] STRING sCloudId,sPwd,sZip,sItem,sResponseItem,sPayee1,sPayee2,sPayee3
	[ ] LIST OF ANYTYPE lsResponse,lsResultData1,lsData,lsRequestParameters,lsKey,lsValue,lsResponseList,lsResultData2,lsResultData3
	[ ] BOOLEAN bAssert,bMatch
	[ ] 
	[ ] sCloudId="TestAutomationUser@gmail.com"
	[ ] sPwd="qwerty"
	[ ] sZip="12345"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSyncData, sEWCSavingWorksheet)
	[ ] lsKey=lsExcelData[1]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // iNavigate=NavigateQuickenTab(sTAB_MOBILE_ALERTS,sTAB_QUICKEN_MOBILE)
		[ ] // ReportStatus("Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}",iNavigate,"Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}")
		[ ] 
		[ ] iLogin=MobileSignUp(sCloudId,sPwd,sZip)
		[ ] ReportStatus("Signup with {sCloudId}", iLogin, "Signup with {sCloudId} successful")
		[ ] 
		[ ] Waitforstate(AccountPasswordTextField,TRUE,SHORT_SLEEP)
		[ ] 
		[+] // if(AccountPasswordTextField.Exists())
			[ ] // AccountPasswordTextField.SetText("datasync")
			[ ] // AccountPasswordTextField.TypeKeys(KEY_TAB)
			[ ] // AccountPasswordTextField.TypeKeys(KEY_ENTER)
		[ ] 
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click ()
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,16,87)
		[ ] 
		[ ] // Click on Done Button
		[ ] Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton,TRUE,70)
		[ ] QuickenMainWindow.SetActive()
		[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton.Click()
		[ ] 
		[ ] // Verify Server side error
		[+] if(AlertMessageBox.Exists(SHORT_SLEEP))
			[ ] ReportStatus("Server Side Verification",FAIL, "Server side error encountered")
			[ ] AlertMessageBox.OK.Click()
		[+] else
			[ ] Waitforstate(DlgCloudSyncComplete,TRUE,90)
			[+] if(DlgCloudSyncComplete.Exists())
				[ ] DlgCloudSyncComplete.OK.Click()
				[+] if(DlgAccountsSynced.Exists(SHORT_SLEEP))
					[ ] DlgAccountsSynced.OK.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Synced window",FAIL,"Account Synced window does not appear")
			[+] else if(DlgAccountsSynced.Exists(MEDIUM_SLEEP))
				[ ] DlgAccountsSynced.OK.Click()
			[+] else
				[ ] ReportStatus("Verify Cloud Sync complete window",FAIL,"Cloud Sync complete window does not appear")
				[ ] 
		[ ] 
		[+] if(WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.HTTP500Error.Exists())
			[ ] ReportStatus("HTTP 500 Error", FAIL, "HTTP 500 error encountered")
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,80)
		[ ] 
		[ ] iLog=OpenAndSaveCloudSyncLog()
		[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
		[ ] 
		[+] for(j=1;j<ListCount(lsExcelData);++j)
			[ ] lsValue=lsExcelData[j+1]
			[+] for (iCounter=1; iCounter< ListCount(lsKey)+1;++iCounter)
				[+] if(j==1)
					[ ] ListAppend(lsResultData1, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if(j==2)
					[ ] ListAppend(lsResultData2, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if (j==3)
					[ ] ListAppend(lsResultData3, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Sync Expected data",FAIL,"Expected data can not verify")
			[ ] 
		[ ] 
		[ ] // Verify online transaction
		[ ] lsResponse=GetOnlineTransactionResponseFromSyncLog(lsExcelData[2][2])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData1);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData1[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData1[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData1[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData1))
				[ ] break
		[ ] 
		[ ] // Verify manual transaction
		[ ] lsResponse=GetManualTransactionResponseFromCloudSyncLog(lsExcelData[3][3])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData2);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData2[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData2[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(MatchStr("*fiTId*",lsResultData2[iCounter]))
						[ ] //skip
					[+] else if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData2[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData2))
				[ ] break
		[ ] 
		[ ] QuickenMainWindow.SetActive()
		[+] for(i=2;i<=ListCount(lsExcelData);i++)
			[ ] SearchTransactionsInRegister(lsExcelData[i][3])
		[ ] 
		[ ] 
		[ ] DeleteCloudID()
		[ ] 
		[ ] iDeleteLog=DeleteSyncLogFile(sFileName)
		[ ] ReportStatus("Delete Log",PASS,"Logs are deleted")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# EWC Sync for Credit Cards accounts ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_EWC_CreditCard()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync EWC credit card accounts and verify request and responces
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 04, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase DataSync_EWC_CreditCard () appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iNavigate,iLogin,iLog,iCounter,iAmount,i,j,iDeleteLog
	[ ] STRING sCloudId,sPwd,sZip,sItem,sResponseItem,sPayee1,sPayee2,sPayee3
	[ ] LIST OF ANYTYPE lsResponse,lsResultData1,lsData,lsRequestParameters,lsKey,lsValue,lsResponseList,lsResultData2,lsResultData3
	[ ] BOOLEAN bAssert,bMatch
	[ ] 
	[ ] sCloudId="TestAutomationUser@gmail.com"
	[ ] sPwd="qwerty"
	[ ] sZip="12345"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSyncData, sEWCCreditCardWorksheet)
	[ ] lsKey=lsExcelData[1]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // iNavigate=NavigateQuickenTab(sTAB_MOBILE_ALERTS,sTAB_QUICKEN_MOBILE)
		[ ] // ReportStatus("Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}",iNavigate,"Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}")
		[ ] 
		[ ] iLogin=MobileSignUp(sCloudId,sPwd,sZip)
		[ ] ReportStatus("Signup with {sCloudId}", iLogin, "Signup with {sCloudId} successful")
		[ ] 
		[ ] Waitforstate(AccountPasswordTextField,TRUE,SHORT_SLEEP)
		[ ] 
		[+] // if(AccountPasswordTextField.Exists())
			[ ] // AccountPasswordTextField.SetText("datasync")
			[ ] // AccountPasswordTextField.TypeKeys(KEY_TAB)
			[ ] // AccountPasswordTextField.TypeKeys(KEY_ENTER)
		[ ] 
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click ()
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,16,62)
		[ ] 
		[ ] // Click on Done Button
		[ ] Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton,TRUE,70)
		[ ] QuickenMainWindow.SetActive()
		[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton.Click()
		[ ] 
		[ ] // Verify Server side error
		[+] if(AlertMessageBox.Exists(SHORT_SLEEP))
			[ ] ReportStatus("Server Side Verification",FAIL, "Server side error encountered")
			[ ] AlertMessageBox.OK.Click()
		[+] else
			[ ] Waitforstate(DlgCloudSyncComplete,TRUE,90)
			[+] if(DlgCloudSyncComplete.Exists())
				[ ] DlgCloudSyncComplete.OK.Click()
				[+] if(DlgAccountsSynced.Exists(SHORT_SLEEP))
					[ ] DlgAccountsSynced.OK.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Synced window",FAIL,"Account Synced window does not appear")
			[+] else if(DlgAccountsSynced.Exists(MEDIUM_SLEEP))
				[ ] DlgAccountsSynced.OK.Click()
			[+] else
				[ ] ReportStatus("Verify Cloud Sync complete window",FAIL,"Cloud Sync complete window does not appear")
				[ ] 
		[ ] 
		[+] if(WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.HTTP500Error.Exists())
			[ ] ReportStatus("HTTP 500 Error", FAIL, "HTTP 500 error encountered")
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,80)
		[ ] 
		[ ] iLog=OpenAndSaveCloudSyncLog()
		[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
		[ ] 
		[+] for(j=1;j<ListCount(lsExcelData);++j)
			[ ] lsValue=lsExcelData[j+1]
			[+] for (iCounter=1; iCounter< ListCount(lsKey)+1;++iCounter)
				[+] if(j==1)
					[ ] ListAppend(lsResultData1, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if(j==2)
					[ ] ListAppend(lsResultData2, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if (j==3)
					[ ] ListAppend(lsResultData3, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Sync Expected data",FAIL,"Expected data can not verify")
			[ ] 
		[ ] 
		[ ] // Verify online transaction
		[ ] lsResponse=GetOnlineTransactionResponseFromSyncLog(lsExcelData[2][2])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData1);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData1[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData1[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData1[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData1))
				[ ] break
		[ ] 
		[ ] // Verify manual transaction
		[ ] lsResponse=GetManualTransactionResponseFromCloudSyncLog(lsExcelData[3][3])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData2);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData2[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData2[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(MatchStr("*fiTId*",lsResultData2[iCounter]))
						[ ] //skip
					[+] else if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData2[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData2))
				[ ] break
		[ ] 
		[ ] QuickenMainWindow.SetActive()
		[+] for(i=2;i<=ListCount(lsExcelData);i++)
			[ ] SearchTransactionsInRegister(lsExcelData[i][3])
		[ ] 
		[ ] 
		[ ] DeleteCloudID()
		[ ] 
		[ ] iDeleteLog=DeleteSyncLogFile(sFileName)
		[ ] ReportStatus("Delete Log",PASS,"Logs are deleted")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Manual Sync for Checking accounts ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_Manual_Checking()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync Manual checking accounts and verify request and responces
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 06, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase DataSync_Manual_Checking () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sCloudId,sPwd,sZip,sItem,sResponseItem
		[ ] LIST OF ANYTYPE lsResponse,lsResultData1,lsKey,lsValue,lsResponseList,lsResultData2,lsResultData3
		[ ] BOOLEAN bMatch
		[ ] 
		[ ] sCloudId="TestAutomationUser@gmail.com"
		[ ] sPwd="qwerty"
		[ ] sZip="12345"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSyncData, sManualCheckingWorksheet)
	[ ] lsKey=lsExcelData[1]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // iNavigate=NavigateQuickenTab(sTAB_MOBILE_ALERTS,sTAB_QUICKEN_MOBILE)
		[ ] // ReportStatus("Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}",iNavigate,"Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}")
		[ ] 
		[ ] iLogin=MobileSignUp(sCloudId,sPwd,sZip)
		[ ] ReportStatus("Signup with {sCloudId}", iLogin, "Signup with {sCloudId} successful")
		[ ] 
		[ ] Waitforstate(AccountPasswordTextField,TRUE,SHORT_SLEEP)
		[ ] 
		[+] // if(AccountPasswordTextField.Exists())
			[ ] // AccountPasswordTextField.SetText("datasync")
			[ ] // AccountPasswordTextField.TypeKeys(KEY_TAB)
			[ ] // AccountPasswordTextField.TypeKeys(KEY_ENTER)
		[ ] 
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click ()
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.VScrollBar.ScrollToMax()
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,16,169)
		[ ] 
		[ ] // Click on Done Button
		[ ] Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton,TRUE,70)
		[ ] QuickenMainWindow.SetActive()
		[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton.Click()
		[ ] 
		[ ] // Verify Server side error
		[+] if(AlertMessageBox.Exists(SHORT_SLEEP))
			[ ] ReportStatus("Server Side Verification",FAIL, "Server side error encountered")
			[ ] AlertMessageBox.OK.Click()
		[+] else
			[ ] Waitforstate(DlgCloudSyncComplete,TRUE,90)
			[+] if(DlgCloudSyncComplete.Exists())
				[ ] DlgCloudSyncComplete.OK.Click()
				[+] if(DlgAccountsSynced.Exists(SHORT_SLEEP))
					[ ] DlgAccountsSynced.OK.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Synced window",FAIL,"Account Synced window does not appear")
			[+] else if(DlgAccountsSynced.Exists(MEDIUM_SLEEP))
				[ ] DlgAccountsSynced.OK.Click()
			[+] else
				[ ] ReportStatus("Verify Cloud Sync complete window",FAIL,"Cloud Sync complete window does not appear")
				[ ] 
		[ ] 
		[+] if(WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.HTTP500Error.Exists())
			[ ] ReportStatus("HTTP 500 Error", FAIL, "HTTP 500 error encountered")
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,80)
		[ ] 
		[ ] iLog=OpenAndSaveCloudSyncLog()
		[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
		[ ] 
		[+] for(j=1;j<ListCount(lsExcelData);++j)
			[ ] lsValue=lsExcelData[j+1]
			[+] for (iCounter=1; iCounter< ListCount(lsKey)+1;++iCounter)
				[+] if(j==1)
					[ ] ListAppend(lsResultData1, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if(j==2)
					[ ] ListAppend(lsResultData2, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if (j==3)
					[ ] ListAppend(lsResultData3, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Sync Expected data",FAIL,"Expected data can not verify")
			[ ] 
		[ ] 
		[ ] // Verify online transaction
		[ ] lsResponse=GetManualTransactionResponseFromCloudSyncLog(lsExcelData[2][2])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData1);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData1[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData1[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData1[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData1))
				[ ] break
		[ ] 
		[ ] // Verify manual transaction
		[ ] lsResponse=GetManualTransactionResponseFromCloudSyncLog(lsExcelData[3][2])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData2);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData2[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData2[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(MatchStr("*fiTId*",lsResultData2[iCounter]))
						[ ] //skip
			[+] if(iCounter==ListCount(lsResultData2))
				[ ] break
		[ ] 
		[ ] // Verify split
		[ ] 
		[ ] 
		[ ] QuickenMainWindow.SetActive()
		[+] for(i=2;i<=ListCount(lsExcelData);i++)
			[ ] SearchTransactionsInRegister(lsExcelData[i][2])
		[ ] 
		[ ] 
		[ ] DeleteCloudID()
		[ ] 
		[ ] iDeleteLog=DeleteSyncLogFile(sFileName)
		[ ] ReportStatus("Delete Log",PASS,"Logs are deleted")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Manual Sync for Savings accounts #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_Manual_Savings()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync Manual savings accounts and verify request and responces
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 06, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase DataSync_Manual_Savings () appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sCloudId,sPwd,sZip,sItem,sResponseItem
	[ ] LIST OF ANYTYPE lsResponse,lsResultData1,lsKey,lsValue,lsResponseList,lsResultData2,lsResultData3
	[ ] BOOLEAN bMatch
	[ ] 
	[ ] sCloudId="TestAutomationUser@gmail.com"
	[ ] sPwd="qwerty"
	[ ] sZip="12345"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSyncData, sManualSavingWorksheet)
	[ ] lsKey=lsExcelData[1]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // iNavigate=NavigateQuickenTab(sTAB_MOBILE_ALERTS,sTAB_QUICKEN_MOBILE)
		[ ] // ReportStatus("Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}",iNavigate,"Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}")
		[ ] 
		[ ] iLogin=MobileSignUp(sCloudId,sPwd,sZip)
		[ ] ReportStatus("Signup with {sCloudId}", iLogin, "Signup with {sCloudId} successful")
		[ ] 
		[ ] Waitforstate(AccountPasswordTextField,TRUE,SHORT_SLEEP)
		[ ] 
		[+] // if(AccountPasswordTextField.Exists())
			[ ] // AccountPasswordTextField.SetText("datasync")
			[ ] // AccountPasswordTextField.TypeKeys(KEY_TAB)
			[ ] // AccountPasswordTextField.TypeKeys(KEY_ENTER)
		[ ] 
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.NoneButton.Click ()
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.VScrollBar.ScrollToMax()
		[ ] WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,16,219)
		[ ] 
		[ ] // Click on Done Button
		[ ] Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton,TRUE,70)
		[ ] QuickenMainWindow.SetActive()
		[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton.Click()
		[ ] 
		[ ] // Verify Server side error
		[+] if(AlertMessageBox.Exists(SHORT_SLEEP))
			[ ] ReportStatus("Server Side Verification",FAIL, "Server side error encountered")
			[ ] AlertMessageBox.OK.Click()
		[+] else
			[ ] Waitforstate(DlgCloudSyncComplete,TRUE,90)
			[+] if(DlgCloudSyncComplete.Exists())
				[ ] DlgCloudSyncComplete.OK.Click()
				[+] if(DlgAccountsSynced.Exists(SHORT_SLEEP))
					[ ] DlgAccountsSynced.OK.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Synced window",FAIL,"Account Synced window does not appear")
			[+] else if(DlgAccountsSynced.Exists(MEDIUM_SLEEP))
				[ ] DlgAccountsSynced.OK.Click()
			[+] else
				[ ] ReportStatus("Verify Cloud Sync complete window",FAIL,"Cloud Sync complete window does not appear")
				[ ] 
		[ ] 
		[+] if(WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.HTTP500Error.Exists())
			[ ] ReportStatus("HTTP 500 Error", FAIL, "HTTP 500 error encountered")
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,80)
		[ ] 
		[ ] iLog=OpenAndSaveCloudSyncLog()
		[ ] ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
		[ ] 
		[+] for(j=1;j<ListCount(lsExcelData);++j)
			[ ] lsValue=lsExcelData[j+1]
			[+] for (iCounter=1; iCounter< ListCount(lsKey)+1;++iCounter)
				[+] if(j==1)
					[ ] ListAppend(lsResultData1, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if(j==2)
					[ ] ListAppend(lsResultData2, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if (j==3)
					[ ] ListAppend(lsResultData3, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Sync Expected data",FAIL,"Expected data can not verify")
			[ ] 
		[ ] 
		[ ] // Verify online transaction
		[ ] lsResponse=GetManualTransactionResponseFromCloudSyncLog(lsExcelData[2][2])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData1);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData1[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData1[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData1[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData1))
				[ ] break
		[ ] 
		[ ] // Verify manual transaction
		[ ] lsResponse=GetManualTransactionResponseFromCloudSyncLog(lsExcelData[3][2])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData2);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData2[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData2[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(MatchStr("*fiTId*",lsResultData2[iCounter]))
						[ ] //skip
					[+] else if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData2[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData2))
				[ ] break
		[ ] 
		[ ] QuickenMainWindow.SetActive()
		[+] for(i=2;i<=ListCount(lsExcelData);i++)
			[ ] SearchTransactionsInRegister(lsExcelData[i][2])
		[ ] 
		[ ] 
		[ ] DeleteCloudID()
		[ ] 
		[ ] iDeleteLog=DeleteSyncLogFile(sFileName)
		[ ] ReportStatus("Delete Log",PASS,"Logs are deleted")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Manual Sync for Credit Cards accounts ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataSync_Manual_CreditCard()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will sync Manual credit card accounts and verify request and responces
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 06, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase DataSync_Manual_CreditCard () appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sCloudId,sPwd,sZip,sItem,sResponseItem
	[ ] LIST OF ANYTYPE lsResponse,lsResultData1,lsKey,lsValue,lsResponseList,lsResultData2,lsResultData3
	[ ] BOOLEAN bAssert,bMatch
	[ ] 
	[ ] sCloudId="TestAutomationUser@gmail.com"
	[ ] sPwd="qwerty"
	[ ] sZip="12345"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSyncData, sManualCreditCardWorksheet)
	[ ] lsKey=lsExcelData[1]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
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
		[ ] // WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.VScrollBar.ScrollToMax()
		[ ] // WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.QWinChild1.QWListViewer1.ListBox1.Click(1,16,194)
		[ ] // 
		[ ] // // Click on Done Button
		[ ] // Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton,TRUE,70)
		[ ] // QuickenMainWindow.SetActive()
		[ ] // WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton.Click()
		[ ] // 
		[ ] // // Verify Server side error
		[+] // if(AlertMessageBox.Exists(SHORT_SLEEP))
			[ ] // ReportStatus("Server Side Verification",FAIL, "Server side error encountered")
			[ ] // AlertMessageBox.OK.Click()
		[+] // else
			[ ] // Waitforstate(DlgCloudSyncComplete,TRUE,90)
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
		[ ] // Waitforstate(QuickenMainWindow,TRUE,80)
		[ ] // 
		[ ] // iLog=OpenAndSaveCloudSyncLog()
		[ ] // ReportStatus("Save Cloud Log", iLog, "Quicken Cloud Log saved successfully")
		[ ] // 
		[+] for(j=1;j<ListCount(lsExcelData);++j)
			[ ] lsValue=lsExcelData[j+1]
			[+] for (iCounter=1; iCounter< ListCount(lsKey)+1;++iCounter)
				[+] if(j==1)
					[ ] ListAppend(lsResultData1, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if(j==2)
					[ ] ListAppend(lsResultData2, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
				[+] else if (j==3)
					[ ] ListAppend(lsResultData3, "{lsKey[iCounter]}"+":"+"{lsValue[iCounter]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Sync Expected data",FAIL,"Expected data can not verify")
			[ ] 
		[ ] 
		[ ] // Verify online transaction
		[ ] lsResponse=GetOnlineTransactionResponseFromSyncLog(lsExcelData[2][2])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData1);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData1[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData1[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData1[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData1))
				[ ] break
		[ ] 
		[ ] // Verify manual transaction
		[ ] lsResponse=GetManualTransactionResponseFromCloudSyncLog(lsExcelData[3][2])
		[+] for each sResponseItem in lsResponse
			[ ] sResponseItem=StrTran(sResponseItem,chr(34),"")
			[ ] ListAppend(lsResponseList,sResponseItem)
		[+] for (iCounter=2; iCounter<=ListCount(lsResultData2);iCounter++)
			[+] for(i=1;i<=ListCount(lsResponseList);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsResponseList[i]}*",lsResultData2[iCounter])
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Response",PASS,"Response matched- Actual - {lsResponseList[i]} and Expected-{lsResultData2[iCounter]}")
					[ ] break
					[ ] 
				[+] else
					[+] if(MatchStr("*fiTId*",lsResultData2[iCounter]))
						[ ] //skip
					[+] else if(i==ListCount(lsResponseList))
						[ ] ReportStatus("Verify Response",FAIL,"Response not found - Expected-{lsResultData2[iCounter]}")
					[+] else
						[ ] continue
			[+] if(iCounter==ListCount(lsResultData2))
				[ ] break
		[ ] 
		[ ] QuickenMainWindow.SetActive()
		[+] for(i=2;i<=ListCount(lsExcelData);i++)
			[ ] SearchTransactionsInRegister(lsExcelData[i][2])
		[ ] 
		[ ] 
		[ ] DeleteCloudID()
		[ ] 
		[ ] iDeleteLog=DeleteSyncLogFile(sFileName)
		[ ] ReportStatus("Delete Log",PASS,"Logs are deleted")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //###########################################################################
[ ] 
