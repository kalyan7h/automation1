[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[+] // Variable Declaration
	[ ] 
	[ ] LIST OF ANYTYPE lsAddAccount, lsExcelData, lsTransaction, lsReportNames,lsAccount,lsAmountData,lsListBoxItems,lsTemp ,lsTxnExcelData
	[ ] INTEGER iAmount ,iSwitchState,iSelect,iResult,iNum
	[ ] LIST OF ANYTYPE  lsIncomeCategory,lsExpenseCategory,lsCategory,lsActualListContents
	[ ] NUMBER nAmount,nAmount1,nAmount2,nAmountTotal,nActualAmount,nAmountDifferenceActual ,nAmountDifferenceExpected
	[ ] 
	[ ] public INTEGER iClickAccount,iCreateFile,iPopupRegister,itest
	[ ] STRING sAccountType
	[ ] 
	[ ] public INTEGER iXpos =235
	[ ] public INTEGER iYpos =21
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] public INTEGER iSetupAutoAPI ,iCounter, iItemCount, iCount,iVerify , iListCount
	[ ] BOOLEAN bMatch, bResult
	[ ] STRING sRegFileName="Register"
	[ ] public STRING sRegisterExcelsheet="BankingRegister"
	[ ] 
	[ ] public STRING sRegDataFile = AUT_DATAFILE_PATH + "\" + sRegFileName + ".QDF"
	[ ] public STRING sRegAccountWorksheet = "RegAccount"
	[ ] public STRING sRegTransactionSheet = "RegCheckingTransaction"
	[ ] public STRING sExpenseCategoryDataSheet = "ExpenseCategoryData"
	[ ] public STRING sIncomeCategoryDataSheet = "IncomeCategoryData"
	[ ] public STRING sRegBusinessTransaction = "RegBusinessTransaction"
	[ ] public STRING sRegCustomerVendorTransactions= "CustomerVendorTransactions"
	[ ] public STRING sRegCustomerVendorPayment= "CustomerVendorPayment"
	[ ] public STRING sRegCustomerCreditTransactions= "CustomerCreditTransactions"
	[ ] public STRING sRegCustomerVendorRefund= "CustomerVendorRefund"
	[ ] public STRING sRegCustomerFinanceCharge= "CustomerFinanceCharge"
	[ ] public STRING sRegVendorCreditTransactions= "VendorCreditTransactions"
	[ ] public STRING sRegVendorRefundTransaction= "VendorRefundTransaction"
	[ ] public STRING sBrokerageAccountSheet= "BrokerageAccount"
	[ ] public STRING sTRowPriceTxnsSheet= "TRowPriceTxns"
	[ ] public STRING sAccountAttributesSheet= "AccountAttributes"
	[ ] public STRING sAccountHoldingsDataSheet= "AccountHoldingsData"
	[ ] 
	[ ] public INTEGER  iAddAccount
	[ ] public STRING sActualErrorMsg ,sExpectedErrorMsg,hWnd,sExpected, sActual, sDateRange,sAmountPaid,sCategory,sListitem,sTransactionCount
	[ ] public STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[ ] public string sCaption
	[ ] 
	[ ] public STRING sValidationText,sActualAmount, sAccountAction,sAmount,sItem,sMenuItem,sAccountName,sDueDate,sActualDate,sExpectedDate
	[ ] 
	[ ] 
	[ ] //Integer
	[ ] public INTEGER iCreateDataFile,iAddTransaction,iFileResult,i
	[ ] public INTEGER iLoop
	[ ] public INTEGER iAccountSpecificCounterValue
	[ ] 
	[ ] //String
	[ ] public STRING sFileName = "Register"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] 
	[ ] public STRING sHandle,sExpectedEndingBalance,sDateFormat
	[ ] 
	[ ] public STRING sTransactionFilterWorksheet="TransactionFilter"
	[ ] public STRING sDateFilterWorksheet="DateFilter"
	[ ] public STRING sTypeFilterWorksheet="TypeFilter"
	[ ] public STRING sTransactionWorksheet="OtherTransaction"
	[ ] public STRING sCheckingTransactionWorksheet="CheckingTransaction"
	[ ] public STRING sAccountWorksheet="Account"
	[ ] public STRING sSearchFilterWorksheet="SearchFilter"
	[ ] 
	[ ] //List of String
	[ ] public LIST OF STRING lsTransactionData
	[ ] 
	[ ] public STRING sPopUpWindow = "PopUp"
	[ ] public STRING sMDIWindow = "MDI"
	[ ] STRING sDate=ModifyDate(0,"m/d/yyyy")
	[ ] //Boolean
	[ ] public BOOLEAN bBalanceCheck
	[ ] window CreateExcelCompatibleFile
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] // Functions
	[ ] // 
	[ ] // 
	[ ] // ==========================================================
	[+] // FUNCTION: GetLineFromReport()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This function will restore from the backup of Quicken
		[ ] // 
		[ ] // PARAMETERS:			STRING  	sSearchString      Unique string to search in the report and retirive the transaction
		[ ] // 
		[ ] // 
		[ ] // RETURNS:				STRING 	PASS	 String from report is returned if value is found else NULL
		[ ] // 
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May 3rd, 2013 	Dean Paes created
	[ ] // ==========================================================
	[+] public STRING GetLineFromReport(window wReport, STRING sSearchString)
		[ ] 
		[ ] 
		[+] // Variable Declaration
			[ ] STRING sActual,sHandle,sCaption
			[ ] BOOLEAN bFindTransactionFlag,bMatch
		[ ] 
		[+] do
			[+] if(wReport.Exists(2))
				[ ] wReport.SetActive()
				[ ] 
				[ ] sCaption=wReport.GetCaption()
				[ ] 
				[ ] iCount=wReport.QWListViewer1.ListBox1.GetItemCount()
				[ ] sHandle=Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] // ---------------Get Payee Name from Report------------------
				[+] for(i=0;i<=iCount;i++)
					[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sSearchString}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] bFindTransactionFlag=TRUE
						[ ] goto END
						[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] if(bFindTransactionFlag==FALSE)
					[ ] ReportStatus("Find Transaction In Report",FAIL,"Transaction NOT found in Report {sCaption}")
					[ ] sActual=NULL
				[ ] 
				[ ] END:
				[+] if(bFindTransactionFlag==TRUE)
					[ ] ReportStatus("Find Transaction In Report",PASS,"Transaction {sActual} found in Report {sCaption}")
				[ ] 
				[ ] 
				[ ] 
		[+] except
			[ ] sActual=NULL
		[ ] return sActual
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // ==========================================================
	[+] // FUNCTION: TransactionReportOperations()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This function will restore from the backup of Quicken
		[ ] // 
		[ ] // PARAMETERS:			STRING  	sSearchString      Option to search the register to find transaction for which transaction report is to be opened
		[ ] // STRING  	sReportAction	  Option to be selected from the right click menu on the report (e.g:  Retag transaction(s))
		[ ] // INTEGER    iLineNo                Line of the report where the transaction is found
		[ ] // 
		[ ] // RETURNS:				INTEGER	PASS	If Transaction report is opened and option is selected
		[ ] // FAIL	In case of failure
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May 3rd, 2013 	Dean Paes created
	[ ] // ==========================================================
	[+] // public INTEGER TransactionReportOperations(STRING sSearchString,STRING sReportAction)
		[ ] // 
		[ ] // 
		[+] // Variable Declaration
			[ ] // 
			[ ] // Account Register Coordinates
			[ ] // INTEGER iX1=280
			[ ] // INTEGER iY1=21
			[ ] // Report Coordinates
			[ ] // INTEGER iX2=380
			[ ] // INTEGER iY2=50
			[ ] // 
			[ ] // STRING sAction="Launch Mini-Report For Payee " + sSearchString
		[ ] // 
		[+] // do
			[ ] // 
			[ ] // 
			[ ] // ---------Open Paye Mini Rpeort----------
			[ ] // AccountActionsOnTransaction(sSearchString,sAction,iX1,iY1)
			[+] // if(MDICalloutHolder.CalloutPopup.Exists(5))
				[ ] // ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened")
				[ ] // 
				[ ] // -----------Click on Show Report button on Callout----------
				[ ] // MDICalloutHolder.CalloutPopup.ShowReport.Click()
				[ ] // 
				[+] // if(wReport.Exists(4))
					[ ] // ReportStatus("Open Report from Register Mini Report",PASS,"Report Opened")
					[ ] // 
					[ ] // Select Include All dates from date filter
					[ ] // wReport.QWCustomizeBar1.PopupList1.Select(1)
					[ ] // 
					[ ] // wReport.QWListViewer1.ListBox1.Click(1,iX2,iY2)
					[ ] // 
					[ ] // 
					[ ] // -------------Select Action of report from right click dropdown menu------------
					[ ] // wReport.QWListViewer1.ListBox1.PopUpSelect(iX2,iY2,sReportAction)
					[ ] // iFunctionResult=PASS
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Open Report from Register Mini Report",FAIL,"Report Not Opened")
					[ ] // iFunctionResult=FAIL
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Open Register Mini Report",FAIL,"Mini Report Not Opened")
				[ ] // iFunctionResult=FAIL
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
		[+] // except
			[ ] // iFunctionResult=FAIL
		[ ] // return iFunctionResult
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // ==========================================================
	[+] // FUNCTION: RegisterSetUp()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This function will restore from the backup of Quicken
		[ ] // 
		[ ] // PARAMETERS:			STRING  	sSearchString      Option to search the register to find transaction for which transaction report is to be opened
		[ ] // STRING  	sReportAction	  Option to be selected from the right click menu on the report (e.g:  Retag transaction(s))
		[ ] // INTEGER    iLineNo                Line of the report where the transaction is found
		[ ] // 
		[ ] // RETURNS:				INTEGER	PASS	If Transaction report is opened and option is selected
		[ ] // FAIL	In case of failure
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May 3rd, 2013 	Dean Paes created
	[ ] // ==========================================================
	[+] public void RegisterSetUp()
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[+] do
			[ ] 
			[+] if(FileExists(sTestCaseStatusFile))
				[ ] DeleteFile(sTestCaseStatusFile)
			[ ] // Load O/S specific paths
			[ ] LoadOSDependency()
			[+] //########Launch Quicken and open RPM_Test File######################//
				[ ] 
				[ ] iResult =DataFileCreate(sRegFileName)
				[+] if (iResult==PASS)
					[ ] // Add Checking Account---------------------------
					[ ] QuickenWindow.SetActive() 
					[ ] // Read data from excel sheet
					[+] for (iCount=1 ; iCount < 5; ++iCount)
							[ ] 
							[ ] // Fetch rows from the given sheet
							[ ] lsAddAccount=lsExcelData[iCount]
							[+] if (lsAddAccount[1]==NULL)
								[ ] break
							[ ] //############## Manual Spending Account #####################################
							[ ] // Quicken is launched then Add Account
							[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
							[ ] // Report Status if checking Account is created
							[+] if (iAddAccount==PASS)
								[ ] ReportStatus("{lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
							[+] else
								[ ] ReportStatus("{lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] // Report Status if Quicken is not launched
					[ ] //############## Added New Checking Account #####################################
					[ ] iSetupAutoAPI = SetUp_AutoApi()
					[+] if (iSetupAutoAPI==PASS)
						[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
					[+] else
						[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup couldn't complete.") 
				[+] else
					[ ] ReportStatus("Verify datafile creation. ", FAIL, "Verify datafile creation: Datafile: {sRegFileName} couldn't be created.") 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] // 
[ ] 
[ ] 
[ ] 
[ ] //Part 1
[ ] 
[ ] 
[+] //############# Register SetUp #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_RegisterSetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the Register.QDF if it exists. It will setup the necessary pre-requisite for Register tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Feb18, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test1_RegisterSetUp() appstate QuickenBaseState
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[+] //########Launch Quicken and open RPM_Test File######################//
		[ ] 
		[ ] iResult =DataFileCreate(sRegFileName)
		[+] if (iResult==PASS)
			[ ] // Add Checking Account---------------------------
			[ ] QuickenWindow.SetActive() 
			[ ] // Read data from excel sheet
			[+] for (iCount=1 ; iCount < 5; ++iCount)
					[ ] 
					[ ] // Fetch rows from the given sheet
					[ ] lsAddAccount=lsExcelData[iCount]
					[+] if (lsAddAccount[1]==NULL)
						[ ] break
					[ ] //############## Manual Spending Account #####################################
					[ ] // Quicken is launched then Add Account
					[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
					[ ] // Report Status if checking Account is created
					[+] if (iAddAccount==PASS)
						[ ] ReportStatus("{lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
					[+] else
						[ ] ReportStatus("{lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Report Status if Quicken is not launched
			[ ] //############## Added New Checking Account #####################################
			[ ] iSetupAutoAPI = SetUp_AutoApi()
			[+] if (iSetupAutoAPI==PASS)
				[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
			[+] else
				[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup couldn't complete.") 
		[+] else
			[ ] ReportStatus("Verify datafile creation. ", FAIL, "Verify datafile creation: Datafile: {sRegFileName} couldn't be created.") 
[ ] 
[ ] 
[ ] 
[+] // //############# Test2_VerifyRegisterAccountActions #################################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test2_VerifyRegisterAccountActions()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will verify Register Account Actions
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If register account actions verification is successful						
		[ ] // //						Fail			If register account actions verification is unsuccessful		
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Date                             Feb18, 2013		
		[ ] // //Author                          Mukesh 	
		[ ] // 
		[ ] // // ********************************************************
		[ ] // 
	[ ] // 
[+] testcase Test2_VerifyRegisterAccountActions() appstate QuickenBaseState 
	[ ] //Variable Declaration
	[ ] 
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive ()
			[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
			[+] if (iSwitchState==PASS)
				[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Turn on Pop up register mode")
				[ ] //Select the Banking account
				[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] 
				[ ] 
				[+] if (iSelect==PASS)
					[ ] ReportStatus("Verify {lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} account open successfully")
					[+] if(BankingPopUp.Exists(5))
						[ ] BankingPopUp.Maximize()
						[+] if (AccountActionsPopUpButton.Exists(5))
							[ ] ReportStatus("Verify Account Actions button", PASS, "Verify Account Actions button: Account Actions button displayed.")
							[ ] 
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Set Up Online#####////
								[+] if(iLoop<4)
									[ ] 
									[ ] BankingPopUp.SetActive()
									[ ] sValidationText="Activate One Step Update"
									[ ] NavigateToAccountActionBanking(2,sPopUpWindow)
									[+] if (DlgActivateOneStepUpdate.Exists(4))
										[ ] DlgActivateOneStepUpdate.SetActive()
										[ ] sActual=DlgActivateOneStepUpdate.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions> Set Up Online:Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions> Set Up Online:Dialog  {sValidationText} didn't display.")
										[ ] DlgActivateOneStepUpdate.Cancel.Click()
										[ ] WaitForState(DlgActivateOneStepUpdate,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Dialog Activate One Step Update", FAIL, "Verify Dialog Activate One Step Update:  One Step Update Dialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Edit Account Details#####////  
								[+] if(iLoop<5)
									[ ] 
									[+] if(iLoop==4)
										[ ] iAccountSpecificCounterValue=2
									[+] else
										[ ] iAccountSpecificCounterValue=3
									[ ] 
									[ ] BankingPopUp.SetActive()
									[ ] sValidationText=NULL
									[ ] sActual=NULL
									[ ] sValidationText="Account Details"
									[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
									[+] if (AccountDetails.Exists(4))
										[ ] AccountDetails.SetActive()
										[ ] sActual=AccountDetails.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Edit Account Details", PASS, "Verify Account Actions> Edit Account Details option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Edit Account Details", FAIL, "Verify Account Actions>Edit Account Details option: Dialog {sValidationText} didn't display.")
										[ ] AccountDetails.Cancel.Click()
										[ ] WaitForState(AccountDetails,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify  Edit Account Details", FAIL, "Verify Dialog Edit Account Details:  One Step Update Dialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Write Checks#####////  
								[+] if(iLoop<3)
									[ ] 
									[ ] 
									[ ] BankingPopUp.SetActive()
									[ ] sValidationText=NULL
									[ ] sActual=NULL
									[ ] sValidationText="Write Checks: {lsAddAccount[2]}"
									[ ] NavigateToAccountActionBanking(4,sPopUpWindow)
									[+] if (WriteChecks.Exists(4))
										[ ] WriteChecks.SetActive()
										[ ] sActual=WriteChecks.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Write Checks", PASS, "Verify Account Actions> Write Checks option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Write Checks", FAIL, "Verify Account Actions> Write Checks option: Dialog {sValidationText} didn't display.")
										[ ] WriteChecks.Done.Click()
										[ ] WaitForState(WriteChecks,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Write Checks", FAIL, "Verify Dialog Write Checks:  Write Checks Dialog didn't appear.")
									[ ] 
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Reconcile Details#####////  
								[+] if(iLoop<4)
									[ ] 
									[+] if(iLoop==3)
										[ ] iAccountSpecificCounterValue=4
										[ ] 
									[+] else
										[ ] iAccountSpecificCounterValue=5
										[ ] 
									[ ] 
									[ ] BankingPopUp.SetActive()
									[ ] sValidationText=NULL
									[ ] sActual=NULL
									[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
									[+] if(iLoop==3)
										[ ] 
										[ ] //For Credit Card Account
										[ ] sValidationText="Reconcile: {lsAddAccount[2]}"
										[+] if (ReconcileCreditCardAccount.Exists(4))
											[ ] ReconcileCreditCardAccount.SetActive()
											[ ] sActual=ReconcileCreditCardAccount.GetProperty("Caption")
											[+] if (sActual==sValidationText)
												[ ] ReportStatus("Verify Reconcile Details", PASS, "Verify Account Actions> Reconcile Details option: Dialog {sActual} displayed as expected {sValidationText}.")
											[+] else
												[ ] ReportStatus("VerifyReconcile Details", FAIL, "Verify Account Actions> Reconcile Details option: Dialog {sValidationText} didn't display.")
											[ ] ReconcileCreditCardAccount.Cancel.Click()
											[ ] WaitForState(ReconcileCreditCardAccount,FALSE,1)
										[+] else
											[ ] ReportStatus("Verify Reconcile Details", FAIL, "Verify Dialog Reconcile Details: Reconcile Details Dialog didn't appear.")
										[ ] 
										[ ] 
									[+] else
										[ ] 
										[ ] //For Checking and Savings account
										[ ] sValidationText="Reconcile Details"
										[ ] 
										[+] if (DlgReconcileDetails.Exists(4))
											[ ] DlgReconcileDetails.SetActive()
											[ ] sActual=DlgReconcileDetails.GetProperty("Caption")
											[+] if (sActual==sValidationText)
												[ ] ReportStatus("Verify Reconcile Details", PASS, "Verify Account Actions> Reconcile Details option: Dialog {sActual} displayed as expected {sValidationText}.")
											[+] else
												[ ] ReportStatus("VerifyReconcile Details", FAIL, "Verify Account Actions> Reconcile Details option: Dialog {sValidationText} didn't display.")
											[ ] DlgReconcileDetails.Cancel.Click()
											[ ] WaitForState(DlgReconcileDetails,FALSE,1)
										[+] else
											[ ] ReportStatus("Verify Reconcile Details", FAIL, "Verify Dialog Reconcile Details: Reconcile Details Dialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Update Balance#####////  
								[+] if(iLoop==4)
									[ ] 
									[ ] iAccountSpecificCounterValue=3
									[ ] 
									[ ] BankingPopUp.SetActive()
									[ ] sValidationText=NULL
									[ ] sActual=NULL
									[ ] sValidationText="Update Balance"
									[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
									[+] if (UpdateBalance.Exists(4))
										[ ] UpdateBalance.SetActive()
										[ ] sActual=UpdateBalance.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Update Balance", PASS, "Verify Account Actions> Update Balance option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Update Balance", FAIL, "Verify Account Actions> Update Balance option: Dialog {sValidationText} didn't display.")
										[ ] UpdateBalance.Cancel.Click()
										[ ] WaitForState(UpdateBalance,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Update Balance", FAIL, "Verify Account Actions>  Update Balance Dialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Transfer Money #####////  
								[ ] 
								[ ] 
								[+] if(iLoop==1||iLoop==2)
									[ ] iAccountSpecificCounterValue=6
									[ ] 
								[+] else if(iLoop==3)
									[ ] iAccountSpecificCounterValue=5
								[+] else
									[ ] iAccountSpecificCounterValue=4
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Transfer Money Within Quicken"
								[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
								[+] for (iCounter=1;iCounter<iAccountSpecificCounterValue;++iCounter)
									[ ] BankingPopUp.TypeKeys(KEY_DN)
								[ ] BankingPopUp.TypeKeys(KEY_ENTER)
								[+] if (DlgTransferMoneyWithinQuicken.Exists(4))
									[ ] DlgTransferMoneyWithinQuicken.SetActive()
									[ ] sActual=DlgTransferMoneyWithinQuicken.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Transfer Money", PASS, "Verify Account Actions> Transfer Money option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Transfer Money", FAIL, "Verify Account Actions> Transfer Money option: Dialog {sValidationText} didn't display.")
									[ ] DlgTransferMoneyWithinQuicken.CancelButton.Click()
									[ ] WaitForState(DlgTransferMoneyWithinQuicken,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Transfer Money ", FAIL, "Verify Dialog Transfer Money : Transfer Money Dialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Account Attachments #####////  
								[ ] 
								[+] if(iLoop==1||iLoop==2)
									[ ] iAccountSpecificCounterValue=8
									[ ] 
								[+] else if(iLoop==3)
									[ ] iAccountSpecificCounterValue=7
									[ ] 
								[+] else
									[ ] iAccountSpecificCounterValue=6
								[ ] 
								[ ] 
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Account Attachments: {lsAddAccount[2]}"
								[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
								[+] if (DlgAccountAttachments.Exists(4))
									[ ] DlgAccountAttachments.SetActive()
									[ ] sActual=DlgAccountAttachments.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Account Attachments", PASS, "Verify Account Actions> Account Attachments option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Account Attachments", FAIL, "Verify Account Actions> Account Attachments option: Dialog {sValidationText} didn't display.")
									[ ] DlgAccountAttachments.DoneButton.Click()
									[ ] WaitForState(DlgAccountAttachments,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Attachments : Account Attachments Dialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Account Overview #####////  
								[ ] 
								[+] if(iLoop==1||iLoop==2)
									[ ] iAccountSpecificCounterValue=9
									[ ] 
								[+] else if(iLoop==3)
									[ ] iAccountSpecificCounterValue=8
									[ ] 
								[+] else
									[ ] iAccountSpecificCounterValue=7
								[ ] 
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Account Overview: {lsAddAccount[2]}"
								[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
								[+] if (DlgAccountOverview.Exists(4))
									[ ] DlgAccountOverview.SetActive()
									[ ] sActual=DlgAccountOverview.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Account Overview", PASS, "Verify Account Actions> Account Overview option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Account Overview", FAIL, "Verify Account Actions> Account Overview option: Dialog {sValidationText} didn't display.")
									[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
									[ ] WaitForState(DlgAccountOverview,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Print Transactions#####////  
								[ ] 
								[+] if(iLoop==1||iLoop==2)
									[ ] iAccountSpecificCounterValue=11
									[ ] 
								[+] else if(iLoop==3)
									[ ] iAccountSpecificCounterValue=10
									[ ] 
								[+] else
									[ ] iAccountSpecificCounterValue=9
								[ ] 
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Print Register"
								[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
								[+] if (PrintRegister.Exists(4))
									[ ] PrintRegister.SetActive()
									[ ] sActual=PrintRegister.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Print Transactions", PASS, "Verify Account Actions> Print Transactions option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Print Transactions", FAIL, "Verify Account Actions> Print Transactions option: Dialog {sValidationText} didn't display.")
									[ ] PrintRegister.CancelButton.Click()
									[ ] WaitForState(PrintRegister,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Print Register", FAIL, "Verify Dialog Print Register : Print RegisterDialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Export to excel compatible file #####////  
								[ ] 
								[+] if(iLoop==1||iLoop==2)
									[ ] iAccountSpecificCounterValue=12
									[ ] 
								[+] else if(iLoop==3)
									[ ] iAccountSpecificCounterValue=11
									[ ] 
								[+] else
									[ ] iAccountSpecificCounterValue=10
								[ ] 
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Create Excel compatible file"
								[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
								[ ] 
								[+] if (FileName.Exists(5))
									[ ] CreateExcelCompatibleFile=FileName.GetParent()
									[ ] CreateExcelCompatibleFile.SetActive()
									[ ] sActual=CreateExcelCompatibleFile.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Export to excel compatible file", PASS, "Verify Account Actions> Export to excel compatible file option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Export to excel compatible file", FAIL, "Verify Account Actions>Export to excel compatible file option: Dialog {sValidationText} didn't display.")
									[ ] CreateExcelCompatibleFile.Close()
									[ ] WaitForState(CreateExcelCompatibleFile,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify CreateExcelCompatibleFile", FAIL, "Verify Dialog CreateExcelCompatibleFile : CreateExcelCompatibleFile Dialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Register preferences#####////  
								[ ] 
								[+] if(iLoop==1||iLoop==2)
									[ ] iAccountSpecificCounterValue=18
									[ ] 
								[+] else if(iLoop==3)
									[ ] iAccountSpecificCounterValue=17
									[ ] 
								[+] else
									[ ] iAccountSpecificCounterValue=16
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Preferences"
								[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
								[+] if (Preferences.Exists(4))
									[ ] Preferences.SetActive()
									[ ] sActual=Preferences.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Register preferences", PASS, "Verify Account Actions>Register preferences option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Register preferences", FAIL, "Verify Account Actions>Register preferences option: Dialog {sValidationText} didn't display.")
									[ ] Preferences.Cancel.Click()
									[ ] WaitForState(Preferences,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Preferences", FAIL, "Verify Dialog Preferences : Preferences Dialog didn't appear.")
							[ ] 
							[ ] 
							[+] ///##########Verifying Acount Actions> Customize Action Bar#####////  
								[ ] 
								[+] if(iLoop<3)
									[ ] iAccountSpecificCounterValue=19
									[ ] 
								[+] else if(iLoop==3)
									[ ] iAccountSpecificCounterValue=18
									[ ] 
								[+] else
									[ ] iAccountSpecificCounterValue=17
								[ ] 
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Customize Action Bar"
								[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue,sPopUpWindow)
								[+] if (DlgCustomizeActionBar.Exists(5))
									[ ] DlgCustomizeActionBar.SetActive()
									[ ] sActual=DlgCustomizeActionBar.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customize Action Bar", PASS, "Verify Account Actions>Customize Action Bar option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Account Actions>Customize Action Bar option: Dialog {sValidationText} didn't display.")
									[ ] DlgCustomizeActionBar.DoneButton.Click()
									[ ] WaitForState(DlgCustomizeActionBar,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Dialog Customize Action Bar :  Customize Action Bar Dialog didn't appear.")
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account Actions button", FAIL, "Verify Account Actions button: Account Actions button doesn't exist'.")
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,2)
						[ ] 
					[+] else
							[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} account coudln't open.")
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} account couldn't open.")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Pop Up Register", FAIL, "Pop up register mode didn't get enable.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test3_VerifyAvailabilityofSavingGoalsOnAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_VerifyAvailabilityofSavingGoalsOnAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Register Account Actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Account actions has Saving Goal indicator when saving goal is linked with the account				
		[ ] //						Fail			If Account actions doesn't show Saving Goal indicator when saving goal is linked with the account	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Feb 20, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test3_VerifyAvailabilityofSavingGoalsOnAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] 
	[ ] STRING sSavingGoal="SavingGoal"
	[ ] sAmount ="200"
	[ ] String sContributedAmount ="20.50"
	[ ] String sContributionPayee="Contribution towards goal"
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=16
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=16
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=15
				[ ] 
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=14
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive ()
			[ ] ///####Add saving goal########///
			[ ] iResult= AddSavingGoal(sSavingGoal,sAmount,sDateStamp)
			[+] if (iResult==PASS)  ////Commented as even goal is added but Saving Goal Text is not displayed on main window hence failing////
				[ ] QuickenWindow.SetActive ()
				[ ] QuickenMainWindow.QWNavigator.Planning.Click()
				[ ] QuickenMainWindow.QWNavigator.SavingGoals.Click()
				[ ] Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel1.ContributeButton.click()
				[+] if (DlgContributeToGoal.Exists(5))
					[ ] DlgContributeToGoal.SetActive()
					[ ] DlgContributeToGoal.FromAccountPopupList.Select(lsAddAccount[2])
					[ ] DlgContributeToGoal.AmountTextField.SetText(sContributedAmount)
					[ ] DlgContributeToGoal.OKButton.click()
					[ ] WaitForState(DlgContributeToGoal,FALSE, 1)
					[ ] QuickenWindow.SetActive ()
					[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
					[+] if (iSwitchState==PASS)
						[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Turn on Pop up register mode")
						[ ] 
						[ ] //Select the Banking account
						[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] 
						[ ] 
						[+] if (iSelect==PASS)
							[ ] ReportStatus("Verify {lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} account open successfully")
							[+] if(BankingPopUp.Exists(5))
								[ ] BankingPopUp.Maximize()
								[+] if (AccountActionsPopUpButton.Exists(5))
									[ ] ReportStatus("Verify Account Actions button", PASS, "Verify Account Actions button: Account Actions button displayed.")
									[ ] ///##########Verifying Acount Actions> Set Up Online#####////
									[ ] BankingPopUp.SetActive()
									[ ] ///Diasable the "Show Savings Goal transactions in register and reports" option/////
									[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue, sPopUpWindow)
									[ ] iResult=VerifyTransactionInAccountRegister(sContributionPayee,"0",sPopUpWindow)
									[+] if (iResult==PASS)
										[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions>Show Savings Goal transactions in register and reports option: Option disabled.'")
									[+] else
										[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions>Show Savings Goal transactions in register and reports option: Option couldn't be disabled.")
									[ ] ///Enable the "Show Savings Goal transactions in register and reports" option/////
									[ ] 
									[ ] BankingPopUp.SetActive()
									[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue, sPopUpWindow)
									[ ] iResult=VerifyTransactionInAccountRegister(sContributionPayee,"1",sPopUpWindow)
									[ ] 
									[+] if (iResult==PASS)
										[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions>Show Savings Goal transactions in register and reports option: Option enabled.'")
									[+] else
										[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions>Show Savings Goal transactions in register and reports option: Option couldn't be enabled.")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Account Actions button", FAIL, "Verify Account Actions button: Account Actions button doesn't exist'.")
								[ ] BankingPopUp.Close()
								[ ] WaitForState(BankingPopUp,FALSE,2)
								[ ] ///Delete Created Saving Goal///
								[ ] iResult=FAIL
								[ ] iResult=DeleteSavingGoal(sSavingGoal)
								[+] if (iResult==PASS)
									[ ] ReportStatus("Verify saving goal deleted",PASS,"Verify saving goal deleted: {sSavingGoal} deleted")
									[ ] UsePopupRegister("OFF")	
								[+] else
									[ ] ReportStatus("Verify saving goal deleted",FAIL,"Verify saving goal {sSavingGoal} couldn't be deleted.")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify BankingPopUp ", FAIL, "BankingPopUp couldn't open.")
						[+] else
							[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} account couldn't open.")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
				[+] else
					[ ] ReportStatus("Verify DlgContributeToGoal ", FAIL, "Verify DlgContributeToGoal: Dialog DlgContributeToGoal didn't appear.") 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Saving Goal added. ", FAIL, "Verify Saving Goal added: Saving Goal couldn't be added.") 
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
[ ] 
[ ] 
[ ] 
[+] //############# Test4_VerifyTransferSetup #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4_VerifyTransferSetup()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that a transfer can be setup from one account to another
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  a transfer can be setup from one account to another			
		[ ] //						Fail			If  a transfer can not be setup from one account to another
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Feb 21, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test4_VerifyTransferSetup() appstate QuickenBaseState 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sSavingGoal="SavingGoal"
	[ ] String sAmount ="167.25"
	[ ] String sTransferPayeeMemo ="TransferPayeeMemo"
	[ ] String sTransferPayeeDescription="TransferPayeeDescription"
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAccount=NULL
				[ ] lsAddAccount=NULL
				[ ] lsAccount=lsExcelData[1]
				[ ] lsAddAccount=lsExcelData[5]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=6
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAccount=NULL
				[ ] lsAddAccount=NULL
				[ ] lsAccount=lsExcelData[2]
				[ ] lsAddAccount=lsExcelData[6]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=6
				[ ] 
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAccount=NULL
				[ ] lsAddAccount=NULL
				[ ] lsAccount=lsExcelData[3]
				[ ] lsAddAccount=lsExcelData[7]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=5
				[ ] 
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAccount=NULL
				[ ] lsAddAccount=NULL
				[ ] lsAccount=lsExcelData[4]
				[ ] lsAddAccount=lsExcelData[8]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=4
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //############## Create New Checking Account #####################################
			[ ] // Quicken is launched then Add Checking Account
			[ ] // Add Checking Account
			[ ] QuickenWindow.SetActive()
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] print(lsAccount[2])
				[ ] iSelect =SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BANKING)
				[+] if (iSelect==PASS)
					[ ] ReportStatus("Verify {lsAccount[1]} Account", PASS, "{lsAccount[1]} account open successfully")
					[ ] iResult=UsePopupRegister("ON")	
					[+] if (iResult==PASS)
						[ ] 
						[+] if(BankingPopUp.Exists(5))
							[ ] BankingPopUp.Maximize()
							[ ] ///##########Verifying Acount Actions> Transfer Money #####////  
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText=NULL
							[ ] sActual=NULL
							[ ] sValidationText="Transfer Money Within Quicken"
							[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue, sPopUpWindow)
							[+] if (DlgTransferMoneyWithinQuicken.Exists(5))
								[ ] DlgTransferMoneyWithinQuicken.SetActive()
								[ ] sActual=DlgTransferMoneyWithinQuicken.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] ReportStatus("Verify Transfer Money", PASS, "Verify Account Actions> Transfer Money option: Dialog {sActual} displayed as expected {sValidationText}.")
									[ ] 
									[ ] DlgTransferMoneyWithinQuicken.TransferDateTextField.SetText(sDateStamp)
									[ ] DlgTransferMoneyWithinQuicken.AmountTextField.SetText(sAmount)
									[ ] DlgTransferMoneyWithinQuicken.FromAccountPopupList.Select(lsAccount[2]) 
									[ ] DlgTransferMoneyWithinQuicken.ToAccountPopupList.Select(lsAddAccount[2]) 
									[ ] DlgTransferMoneyWithinQuicken.PayeeDescriptionTextField.SetText(sTransferPayeeDescription)
									[ ] DlgTransferMoneyWithinQuicken.MemoTextField.SetText(sTransferPayeeMemo)
									[ ] DlgTransferMoneyWithinQuicken.OKButton.Click()
									[ ] WaitForState(DlgTransferMoneyWithinQuicken,false,1)
									[ ] iResult=VerifyTransactionInAccountRegister(sTransferPayeeDescription,"1",sPopUpWindow)
									[+] if (iResult==PASS)
										[ ] ReportStatus("Verify Transfer Money Within Quicken", PASS, "Verify Transfer Money Within Quicken: Transfer with payee {sTransferPayeeDescription} from {lsAccount[2]} to {lsAddAccount[2]} has been successful.")
									[+] else
										[ ] ReportStatus("Verify Transfer Money Within Quicken", FAIL, "Verify Transfer Money Within Quicken: Transfer with payee {sTransferPayeeDescription} from {lsAccount[2]} couldn't succeed.")
									[ ] BankingPopUp.Close()
									[ ] WaitForState(BankingPopUp,FALSE,1)
									[ ] ///Open the To Account to verify the transaction///
									[ ] iSelect =SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
									[ ] WaitForState(BankingPopUp,TRUE,1)
									[ ] BankingPopUp.SetActive()
									[ ] iResult=FAIL
									[ ] iResult=VerifyTransactionInAccountRegister(sTransferPayeeDescription,"1",sPopUpWindow)
									[+] if (iResult==PASS)
										[ ] ReportStatus("Verify Transfer Money Within Quicken", PASS, "Verify Transfer Money Within Quicken: Transfer with payee {sTransferPayeeDescription} To {lsAddAccount[2]} From {lsAccount[2]} has been successful.")
									[+] else
										[ ] ReportStatus("Verify Transfer Money Within Quicken", FAIL, "Verify Transfer Money Within Quicken: Transfer with payee {sTransferPayeeDescription} To {lsAddAccount[2]} couldn't succeed.")
									[ ] BankingPopUp.SetActive()
									[ ] BankingPopUp.Close()
									[ ] WaitForState(BankingPopUp,FALSE,1)
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] //Delete the added transaction if ttransaction delete fails it can impcat other testcases
									[ ] iResult=UsePopupRegister("OFF")	
									[+] if (iResult==PASS)
										[ ] iResult =SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BANKING)
										[+] if (iResult==PASS)
											[ ] sleep(1)
											[ ] DeleteTransaction(sMDIWindow,sTransferPayeeDescription)
										[+] else
											[ ] ReportStatus("Verify  {lsAddAccount[2]}  Account", FAIL, " {lsAddAccount[2]} couldn't be selected.")
									[+] else
										[ ] ReportStatus("Verify Popup Register mode is ON", FAIL, "Popup Register mode couldn't be set OFF.") 
								[+] else
									[ ] ReportStatus("Verify Transfer Money", FAIL, "Verify Account Actions> Transfer Money option: Dialog {sValidationText} didn't display.")
									[ ] DlgTransferMoneyWithinQuicken.CancelButton.Click()
									[ ] WaitForState(DlgTransferMoneyWithinQuicken,FALSE,1)
								[+] if (DlgTransferMoneyWithinQuicken.Exists(5))
									[ ] DlgTransferMoneyWithinQuicken.SetActive()
									[ ] DlgTransferMoneyWithinQuicken.CancelButton.Click()
							[+] else
								[ ] ReportStatus("Verify Transfer Money ", FAIL, "Verify Dialog Transfer Money : Transfer Money Dialog didn't appear.")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify BankingPopUp ", FAIL, "BankingPopUp couldn't open.")
					[+] else
						[ ] ReportStatus("Verify Popup Register mode is ON", FAIL, "Popup Register mode couldn't be set ON.") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify  {lsAccount[2]}  Account", FAIL, " {lsAccount[2]} couldn't open.")
				[ ] 
			[+] else
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[+] if (BankingPopUp.Exists(5))
			[ ] BankingPopUp.SetActive()
			[ ] BankingPopUp.Close()
			[ ] WaitForState(BankingPopUp,FALSE,1)
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# Test5_VerifyMoreReportsonAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test5_VerifyMoreReportsonAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify MoreReports on Account Actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MoreReports verifification on Account Actions is successful
		[ ] //						Fail			If MoreReports verifification on Account Actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Feb18, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test5_VerifyMoreReportsonAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sBudget="TestBudget"
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] lsReportNames= {"Register Report","Banking Summary","Cash Flow Comparison","Cash Flow","Income/Expense Comparison by Category","Itemized Categories","Missing Checks","Current Budget","Historical Budget","Net Worth"}
	[ ] 
	[ ] 
	[ ] /////Create a Budget/////
	[ ] QuickenMainWindow.QWNavigator.Planning.Click ()
	[ ] QuickenMainWindow.QWNavigator.Budgets.Click()
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] QuickenMainWindow.QWNavigator.Planning.Click ()
	[ ] QuickenMainWindow.QWNavigator.Budgets.Click()
	[ ] 
	[ ] WaitForState(QuickenWindow,TRUE,5)
	[ ] QuickenWindow.SetActive()
	[+] if(GetStartedBrowserWindow.GetStarted.Exists(5))
		[ ] GetStartedBrowserWindow.GetStarted.DoubleClick()
		[+] if (CreateANewBudget.Exists(5))
			[ ] CreateANewBudget.SetActive()
			[ ] CreateANewBudget.BudgetName.SetText(sBudget)
			[ ] CreateANewBudget.OK.Click()
			[ ] WaitForState(QuickenMainWindow,TRUE,2)
		[+] else
			[ ] ReportStatus("Verify Create A NewBudget dialog", FAIL, "Create A NewBudget dialog didn't appear so budget reports will not be verified.")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Budget", PASS, "Budget already created.")
	[ ] 
	[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
	[+] if (iSwitchState==PASS)
		[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Turn on Pop up register mode")
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[+] if(iLoop==1)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=11
				[ ] 
			[ ] 
			[+] if(iLoop==2)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=11
				[ ] 
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=10
				[ ] 
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
				[ ] iAccountSpecificCounterValue=NULL
				[ ] iAccountSpecificCounterValue=9
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] if(QuickenWindow.Exists(5))
				[+] QuickenWindow.SetActive ()
					[ ] 
					[ ] 
					[ ] //Select the Banking account
					[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] 
					[+] if (iSelect==PASS)
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", PASS, "{lsAddAccount[2]} account open successfully")
						[+] if(BankingPopUp.Exists(5))
							[ ] BankingPopUp.Maximize()
							[+] if (AccountActionsPopUpButton.Exists(5))
								[ ] ReportStatus("Verify Account Actions button", PASS, "Verify Account Actions button: Account Actions button displayed.")
								[ ] ///##########Verifying Acount Actions> More Reports#####////
								[+] for (iCounter=1; iCounter<11;++iCounter)
									[ ] BankingPopUp.SetActive()
									[ ] AccountActionsPopUpButton.Click(1,55,10)
									[+] for (iCount=1; iCount<iAccountSpecificCounterValue;++iCount)
										[ ] BankingPopUp.TypeKeys(KEY_DN)
									[ ] BankingPopUp.TypeKeys(KEY_RT)
									[+] for  (iCount=1; iCount<iCounter+1;++iCount)
										[+] if (iCount>1)
											[ ] BankingPopUp.TypeKeys(KEY_DN)
									[ ] BankingPopUp.TypeKeys(KEY_ENTER)
									[ ] 
									[+] if(Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").Exists(5))
										[ ] Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").SetActive()
										[ ] sActual=Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").GetProperty("caption")
										[ ] Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").Close()
										[+] if (sActual==lsReportNames[iCounter])
											[ ] ReportStatus("Verify Account Actions> More Reports", PASS, "Verify Account Actions> More Reports >{lsReportNames[iCounter]}: Report {sActual} is as expected {lsReportNames[iCounter]} .")
										[+] else
											[ ] ReportStatus("Verify Account Actions> More Reports", FAIL, "Verify Account Actions> More Reports >{lsReportNames[iCounter]}: Report {sActual} is  Not as expected {lsReportNames[iCounter]} .")
											[ ] 
									[+] else
										[ ] ReportStatus("Verify Account Actions> More Reports", FAIL, "Verify Account Actions> More Reports >{lsReportNames[iCounter]}: Report {lsReportNames[iCounter]} didn't appear.")
							[+] else
								[ ] ReportStatus("Verify Account Actions button", FAIL, "Verify Account Actions button: Account Actions button doesn't exist'.")
							[ ] BankingPopUp.Close()
							[ ] WaitForState(BankingPopUp,FALSE,1)
							[ ] 
						[+] else
								[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
					[+] else
						[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
						[ ] 
					[+] if(BankingPopUp.Exists(2))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] 
				[ ] 
				[ ] 
	[+] else
		[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# Test6_VerifySplitTransaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_VerifySplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify add / updatesplit transaction.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding split transaction is successful
		[ ] //						Fail			If adding split transaction is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 06, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test6_VerifySplitTransaction() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sTag , sMemo
	[ ] 
	[ ] // Read data from sRegAccountWorksheet excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
	[ ] lsTransaction=lsExcelData[1]
	[ ] // Fetch 1st row from sExpenseCategoryDataSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
	[ ] lsExpenseCategory=lsExcelData[1]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] UsePopupRegister("OFF")
		[ ] 
		[ ] //Select the Banking account
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if (iSelect==PASS)
			[ ] 
			[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
			[ ] 
			[ ] ////////Fetch 2nd row from sExpenseCategoryDataSheet////
			[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
			[+] if(iVerify==PASS)
				[ ] 
				[ ] 
				[ ] lsExpenseCategory=lsExcelData[2]
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
				[+] if(SplitTransaction.Exists(5))
					[ ] SplitTransaction.SetActive()
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
					[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
					[+] if (NewTag.Exists(5))
						[ ] NewTag.SetActive()
						[ ] NewTag.OKButton.Click()
						[ ] 
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsExpenseCategory[4])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsExpenseCategory[2])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
					[+] if (SplitTransaction.Adjust.IsEnabled())
						[ ] SplitTransaction.Adjust.Click()
					[ ] SplitTransaction.OK.Click()
					[ ] WaitForState(SplitTransaction,False,1)
					[ ] QuickenWindow.SetActive ()
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
					[ ] ////########Verify Split Button in the category field of the transaction#########///////// 
					[ ] iVerify=FAIL
					[ ] iVerify= VerifyTransactionInAccountRegister(lsTransaction[6],"1",sMDIWindow)   //FindTransaction(sMDIWindow,lsTransaction[6])
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N) 
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_HOME)
					[ ] MDIClient.AccountRegister.SearchWindow.TypeKeys(lsTransaction[6])
					[ ] 
					[+] if(iVerify==PASS)
						[+] if (MDIClient.AccountRegister.TxList.AddedSplitButton.Exists(5))
							[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
							[ ] ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
							[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
							[ ] // MDIClient.AccountRegister.TxList.AddedSplitButton.Click(1,6,8)
							[+] if(SplitTransaction.Exists(5))
								[ ] SplitTransaction.SetActive()
								[ ] 
								[ ] hWnd=NULL
								[ ] lsExpenseCategory=NULL
								[ ] lsExpenseCategory=lsExcelData[1]
								[ ] nAmount=VAL(lsExpenseCategory[2])
								[ ] lsAmountData=Split(Str(nAmount,7,2),".")
								[ ] hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
								[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
								[+] if (bMatch==TRUE)
									[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} appeared.")
								[+] else
									[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} didn't appear.")
								[ ] bMatch=FALSE
								[ ] lsExpenseCategory=NULL
								[ ] lsExpenseCategory=lsExcelData[2]
								[ ] nAmount=VAL(lsExpenseCategory[2])
								[ ] lsAmountData=Split(Str(nAmount,7,2),".")
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
								[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{lsExpenseCategory[3]}*{lsExpenseCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
								[+] if (bMatch==TRUE)
									[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount:{Str(nAmount,7,2)}appeared.")
								[+] else
									[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount: {Str(nAmount,7,2)} didn't appear.")
									[ ] 
								[+] if (!SplitTransaction.IsActive())
									[ ] SplitTransaction.SetActive()
								[ ] SplitTransaction.OK.Click()
								[ ] WaitForState(SplitTransaction,False,1)
								[ ] 
							[+] else
								[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
						[+] else
							[ ] ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
					[+] else
							[ ] ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] MDIClient.AccountRegister.SearchWindow.TypeKeys("")
				[+] else
					[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Find Transaction",FAIL,"Transaction {lsTransaction[6]} not found in Account {lsAddAccount[2]}")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[2]}  Account", FAIL, "{lsAddAccount[2]} account couldn't open.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] 
[+] //############# Test7_VerifyModifySplitTransaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_VerifyModifySplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify update split transaction.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If modifying split transaction is successful
		[ ] //						Fail			If modifying split transaction is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 06, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test7_VerifyModifySplitTransaction() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sTag , sMemo
	[ ] 
	[ ] // Read data from sRegAccountWorksheet excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
	[ ] lsTransaction=lsExcelData[1]
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
	[ ] lsExpenseCategory=lsExcelData[1]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if (iSelect==PASS)
			[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
			[+] if(iVerify==PASS)
				[ ] ////########Verify modified split transaction#########///////// 
				[ ] 
				[ ] ///Adding new categories to transaction and clicking Cancel///
				[ ] lsExpenseCategory=NULL
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
				[+] if(SplitTransaction.Exists(5))
					[+] if (!SplitTransaction.IsActive())
						[ ] SplitTransaction.SetActive()
					[+] for (iCounter=3;iCounter<ListCount(lsExcelData)+1;++iCounter)
						[ ] lsExpenseCategory=lsExcelData[iCounter]
						[+] if (lsExpenseCategory[1]==NULL)
							[ ] break
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#{iCounter}")
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
						[+] if (NewTag.Exists(1))
							[ ] NewTag.SetActive()
							[ ] NewTag.OKButton.Click()
							[ ] 
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsExpenseCategory[4])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsExpenseCategory[2])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
					[+] if (SplitTransaction.Adjust.IsEnabled())
						[ ] SplitTransaction.Adjust.Click()
					[ ] SplitTransaction.Cancel.Click()
					[+] if (AlertMessage.Exists(5))
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(AlertMessage,False,1)
						[ ] 
					[ ] WaitForState(SplitTransaction,False,1)
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
					[ ] /////Verifying that no changes has been made as cancel was clicked after modification///
					[ ] lsExpenseCategory=NULL
					[ ] MDIClient.AccountRegister.TxList.AddedSplitButton.DoubleClick()
					[+] if(SplitTransaction.Exists(2))
						[+] if (!SplitTransaction.IsActive())
							[ ] SplitTransaction.SetActive()
						[ ] hWnd=NULL
						[ ] hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
						[ ] lsExpenseCategory=NULL
						[+] for (iCounter=1;iCounter<ListCount(lsExcelData)+1;++iCounter)
							[ ] lsExpenseCategory=lsExcelData[iCounter]
							[+] if (lsExpenseCategory[1]==NULL)
								[ ] break
							[ ] nAmount=VAL(lsExpenseCategory[2])
							[ ] lsAmountData=Split(Str(nAmount,7,2),".")
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter-1}")
							[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
							[+] if (iCounter<3)
								[+] if (bMatch==TRUE)
									[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify changes not saved after modifying data and clicking Cancel: Categories added prior to modification persist  category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} appeared.")
								[+] else
									[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify changes not saved after modifying data and clicking Cancel: Categories added prior to modification NOT saved and category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} didn't appear.")
							[+] else
								[+] if (bMatch==TRUE)
									[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify changes not saved after modifying data and clicking Cancel:Categories added after the modification saved and category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} appeared.")
								[+] else
									[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify changes not saved after modifying data and clicking Cancel:Categories added after the modification NOT saved and category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} didn't appear.")
								[ ] 
						[ ] SplitTransaction.Cancel.Click()
						[ ] WaitForState(SplitTransaction,False,1)
					[+] else
						[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[ ] 
				[ ] ///Adding new categories to transaction and clicking OK///
				[ ] lsExpenseCategory=NULL
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
				[+] if(SplitTransaction.Exists(5))
					[+] if (!SplitTransaction.IsActive())
						[ ] SplitTransaction.SetActive()
					[+] for (iCounter=1;iCounter<ListCount(lsExcelData)+1;++iCounter)
						[ ] lsExpenseCategory=lsExcelData[iCounter]
						[+] if (lsExpenseCategory[1]==NULL)
							[ ] break
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#{iCounter}")
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
						[+] if (NewTag.Exists(1))
							[ ] NewTag.SetActive()
							[ ] NewTag.OKButton.Click()
							[ ] 
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsExpenseCategory[4])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsExpenseCategory[2])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
					[+] if (SplitTransaction.Adjust.IsEnabled())
						[ ] SplitTransaction.Adjust.Click()
					[ ] SplitTransaction.OK.Click()
					[ ] WaitForState(SplitTransaction,False,1)
					[ ] ///Verify split transaction dailog data after modification///
					[ ] 
					[ ] MDIClient.AccountRegister.TxList.AddedSplitButton.DoubleClick()
					[+] if(SplitTransaction.Exists(2))
						[+] if (!SplitTransaction.IsActive())
							[ ] SplitTransaction.SetActive()
						[ ] hWnd=NULL
						[ ] hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
						[ ] lsExpenseCategory=NULL
						[+] for (iCounter=1;iCounter<ListCount(lsExcelData)+1;++iCounter)
							[ ] lsExpenseCategory=lsExcelData[iCounter]
							[+] if (lsExpenseCategory[1]==NULL)
								[ ] break
							[ ] nAmount=VAL(lsExpenseCategory[2])
							[ ] lsAmountData=Split(Str(nAmount,7,2),".")
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter-1}")
							[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{lsExpenseCategory[3]}*{lsExpenseCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
							[+] if (bMatch==TRUE)
								[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data after modification: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount:{Str(nAmount,7,2)}appeared.")
							[+] else
								[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data after modification: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount: {Str(nAmount,7,2)} didn't appear.")
								[ ] 
						[ ] SplitTransaction.Cancel.Click()
						[ ] WaitForState(AlertMessage,False,1)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Find Transaction",FAIL,"Transaction {lsTransaction[6]} not found in Account {lsAddAccount[2]}")
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[2]}  Account", FAIL, "{lsAddAccount[2]} couldn't open.")
		[ ] QuickenWindow.SetActive ()
		[ ] MDIClient.AccountRegister.SearchWindow.SetText("")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test8_VerifyClearSplitTransaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_VerifyClearSplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify clearing all the lines of the split transaction
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of clearing all the lines of the split transaction is successful
		[ ] //						Fail			If verification of clearing all the lines of the split transaction is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 07, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test8_VerifyClearSplitTransaction() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sTag , sMemo
	[ ] 
	[ ] // Read data from sRegAccountWorksheet excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
	[ ] lsTransaction=lsExcelData[1]
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
	[ ] lsExpenseCategory=lsExcelData[1]
	[ ] sExpected="Clear all split lines?"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if (iSelect==PASS)
			[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
			[+] if(iVerify==PASS)
				[ ] 
				[ ] /////Verifying the Clear Splitlines button tied with transaction/// 
				[ ] lsExpenseCategory=NULL
				[ ] MDIClient.AccountRegister.TxList.ClearSplitlinesButton.DoubleClick(1,6,7) 
				[+] if (AlertMessage.Exists(10))
					[ ] sActual=AlertMessage.StaticText.Getproperty("Text")
					[+] if (sActual==sExpected)
						[ ] ReportStatus("Verify Clear all split lines button",PASS,"Verify Clear all split lines button: Clear all split lines dailog {sActual} appeared as expected {sExpected}")
					[+] else
						[ ] ReportStatus("Verify Clear all split lines button",FAIL,"Verify Clear all split lines button: Clear all split lines dailog {sActual} didn't appear as expected {sExpected}")
					[ ] AlertMessage.No.Click()
					[ ] WaitForState(AlertMessage,False,1)
				[+] else
					[ ] ReportStatus("Verify Clear all split lines dailog.",FAIL,"Verify Clear all split lines dailog: Clear all split lines dailog didn't appear.")
				[ ] lsExpenseCategory=NULL
				[ ] MDIClient.AccountRegister.TxList.ClearSplitlinesButton.DoubleClick(1,6,7)
				[+] if (AlertMessage.Exists(10))
					[ ] sActual=AlertMessage.StaticText.Getproperty("Text")
					[+] if (sActual==sExpected)
						[ ] ReportStatus("Verify Clear all split lines button",PASS,"Verify Clear all split lines button: Clear all split lines dailog {sActual} appeared as expected {sExpected}")
						[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(AlertMessage,False,1)
						[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
						[ ] sleep(1)
						[ ] ///Verify split transaction dailog after clearing all the lines///
						[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
						[+] if(iVerify==PASS)
							[+] // if (MDIClient.AccountRegister.TxList.AddedSplitButton.Exists(5))
								[ ] // ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction after clearing the split lines: Split Button in the category field of the transaction appeared.")
							[+] // else
								[ ] // ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction after clearing the split lines: Split Button in the category field of the transaction didn't appear.")
							[ ] MDIClient.AccountRegister.TxList.AddedSplitButton.Click()
							[+] if(!SplitTransaction.Exists(3))
								[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction after clearing the split lines: Split Button in the category field of the transaction didn't appear.")
							[+] else
								[ ] ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction after clearing the split lines: Split Button in the category field of the transaction appeared.")
						[+] else
							[ ] ReportStatus("Find Transaction",FAIL,"Transaction {lsTransaction[6]} not found in Account {lsAddAccount[2]}")
					[+] else
						[ ] ReportStatus("Verify Clear all split lines button",FAIL,"Verify Clear all split lines button: Clear all split lines dailog {sActual} didn't appear as expected {sExpected}")
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Clear all split lines dailog.",FAIL,"Verify Clear all split lines dailog: Clear all split lines dailog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Find Transaction",FAIL,"Transaction {lsTransaction[6]} not found in Account {lsAddAccount[2]}")
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[2]}  Account", FAIL, "{lsAddAccount[2]} account couldn't open.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test9_VerifyIncomeCategorySplitTransaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_VerifyIncomeCategorySplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify add / update Income split transaction.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Income split transaction is successful
		[ ] //						Fail			If adding Income split transaction is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 08, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test9_VerifyIncomeCategorySplitTransaction() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sTag , sMemo
	[ ] 
	[ ] // Read data from sRegAccountWorksheet excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
	[ ] lsTransaction=lsExcelData[2]
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sIncomeCategoryDataSheet)
	[ ] lsIncomeCategory=lsExcelData[1]
	[ ] NUMBER nAmountTotal=0
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Select the Banking account
		[ ] iVerify = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[ ] 
		[+] if (iVerify==PASS)
			[ ] ////////Fetch 2nd row from sExpenseCategoryDataSheet////
			[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
			[+] if(iVerify==PASS) 
				[ ] DeleteTransaction(sMDIWindow,lsTransaction[6])
			[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsIncomeCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsIncomeCategory[4],lsIncomeCategory[1])
			[ ] 
			[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
			[+] if(iVerify==PASS)
				[ ] 
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
				[ ] ///Adding new categories to transaction and clicking OK///
				[ ] lsIncomeCategory=NULL
				[+] if(SplitTransaction.Exists(5))
					[+] if (!SplitTransaction.IsActive())
						[ ] SplitTransaction.SetActive()
					[+] for (iCounter=1;iCounter<ListCount(lsExcelData)+1;++iCounter)
						[ ] lsIncomeCategory=lsExcelData[iCounter]
						[+] if (lsIncomeCategory[1]==NULL)
							[ ] break
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#{iCounter}")
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsIncomeCategory[1])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsIncomeCategory[3])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
						[+] if (NewTag.Exists(5))
							[ ] NewTag.SetActive()
							[ ] NewTag.OKButton.Click()
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsIncomeCategory[4])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsIncomeCategory[2])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
						[ ] nAmount=VAL(lsIncomeCategory[2])
						[ ] nAmountTotal=nAmount+nAmountTotal
					[+] if (SplitTransaction.Adjust.IsEnabled())
						[ ] SplitTransaction.Adjust.Click()
					[ ] SplitTransaction.OK.Click()
					[+] if (DlgPaymentOrDeposit.Exists(5))
						[ ] DlgPaymentOrDeposit.PaymentRadioButton.Select("Payment")
						[ ] DlgPaymentOrDeposit.OKButton.Click()
					[ ] WaitForState(SplitTransaction,False,1)
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
					[ ] ///Verify split transaction dailog data after modification///
					[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
					[+] if(iVerify==PASS)
						[ ] MDIClient.AccountRegister.TxList.AddedSplitButton.DoubleClick()
						[+] if(SplitTransaction.Exists(2))
							[+] if (!SplitTransaction.IsActive())
								[ ] SplitTransaction.SetActive()
							[ ] hWnd=NULL
							[ ] hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
							[ ] lsIncomeCategory=NULL
							[+] for (iCounter=1;iCounter<ListCount(lsExcelData)+1;++iCounter)
								[ ] lsIncomeCategory=lsExcelData[iCounter]
								[+] if (lsIncomeCategory[1]==NULL)
									[ ] break
								[ ] nAmount=VAL(lsIncomeCategory[2])
								[ ] lsAmountData=Split(Str(nAmount,7,2),".")
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter-1}")
								[ ] bMatch =MatchStr("*{lsIncomeCategory[1]}*{lsIncomeCategory[3]}*{lsIncomeCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
								[+] if (bMatch==TRUE)
									[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data after modification: Transaction with category {lsIncomeCategory[1]} , Tag: {lsIncomeCategory[3]}, Memo: {lsIncomeCategory[4]} and with amount:{Str(nAmount,7,2)}appeared.")
								[+] else
									[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data after modification: Transaction with category {lsIncomeCategory[1]} , Tag: {lsIncomeCategory[3]}, Memo: {lsIncomeCategory[4]} and with amount: {Str(nAmount,7,2)} didn't appear.")
									[ ] 
							[ ] 
							[ ] //////Verfy total amount of the categories/////
							[ ] SplitTransaction.SetActive()
							[ ] sActualAmount=SplitTransaction.SplitTransactionsTotalText.GetText()
							[ ] nActualAmount=VAL(sActualAmount)
							[+] if (nAmountTotal==nActualAmount)
								[ ] ReportStatus("Verify split transactions total amount.",PASS,"Verify split transactions total amount: Actual toatal amount - {nActualAmount} is as expected {nAmountTotal}.")
							[+] else
								[ ] ReportStatus("Verify split transactions total amount.",FAIL,"Verify split transactions total amount: Actual toatal amount - {nActualAmount} is NOT as expected {nAmountTotal}.")
								[ ] 
							[ ] SplitTransaction.Cancel.Click()
							[ ] WaitForState(AlertMessage,False,1)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
					[+] else
						[ ] ReportStatus("Search Transaction",FAIL,"Transaction {lsTransaction[6]} not found in Account {lsAddAccount[2]}")
				[+] else
					[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]}  account couldn't open.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] 
[+] //############# Test10_VerifyIncomeExpenseCategorySplitTransaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyIncomeExpenseCategorySplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify add / update Income split transaction.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Income split transaction is successful
		[ ] //						Fail			If adding Income split transaction is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 08, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test10_VerifyIncomeExpenseCategorySplitTransaction() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sTag , sMemo
	[ ] LIST OF ANYTYPE lsExcelData2, lsMixedCategories
	[ ] // Read data from sRegAccountWorksheet excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
	[ ] lsTransaction=lsExcelData[3]
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sIncomeCategoryDataSheet)
	[ ] lsIncomeCategory=lsExcelData[1]
	[ ] 
	[ ] lsExcelData2=NULL
	[ ] lsExcelData2=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
	[ ] lsExpenseCategory=lsExcelData2[1]
	[ ] 
	[ ] lsMixedCategories=lsExcelData+lsExcelData2
	[ ] NUMBER nAmountTotal=0
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Select the Banking account
		[ ] iVerify =SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[ ] 
		[+] if (iVerify==PASS)
			[ ] ////////Fetch 2nd row from sExpenseCategoryDataSheet//// 
			[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsIncomeCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsIncomeCategory[4],lsIncomeCategory[1])
			[ ] 
			[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
			[+] if(iVerify==PASS)
				[ ] 
				[ ] 
				[ ] 
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
				[ ] ///Adding new categories to transaction and clicking OK/// lsCategory
				[ ] lsCategory=NULL
				[+] if(SplitTransaction.Exists(2))
					[+] if (!SplitTransaction.IsActive())
						[ ] SplitTransaction.SetActive()
					[+] for (iCounter=1;iCounter<ListCount(lsMixedCategories)+1 ;++iCounter)
						[ ] lsCategory=lsMixedCategories[iCounter]
						[+] if (lsCategory[1]==NULL)
							[ ] break
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#{iCounter}")
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsCategory[1])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsCategory[3])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
						[+] if (NewTag.Exists(3))
							[ ] NewTag.SetActive()
							[ ] NewTag.OKButton.Click()
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsCategory[4])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsCategory[2])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
						[+] if (iCounter==30)
							[ ] SplitTransaction.AddLines.Click()
						[ ] nAmount=VAL(lsCategory[2])
						[ ] nAmountTotal=nAmount+nAmountTotal
					[+] if (SplitTransaction.Adjust.IsEnabled())
						[ ] SplitTransaction.Adjust.Click()
					[ ] SplitTransaction.OK.Click()
					[ ] WaitForState(SplitTransaction,False,1)
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
					[ ] ///Verify split transaction dailog data after modification///
					[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
					[+] if(iVerify==PASS)
						[ ] MDIClient.AccountRegister.TxList.AddedSplitButton.DoubleClick()
						[+] if(SplitTransaction.Exists(2))
							[+] if (!SplitTransaction.IsActive())
								[ ] SplitTransaction.SetActive()
							[ ] hWnd=NULL
							[ ] hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
							[ ] lsCategory=NULL
							[+] for (iCounter=1;iCounter<ListCount(lsMixedCategories)+1;++iCounter)
								[ ] lsCategory=lsMixedCategories[iCounter]
								[+] if (lsCategory[1]==NULL)
									[ ] break
								[ ] nAmount=VAL(lsCategory[2])
								[ ] lsAmountData=Split(Str(nAmount,7,2),".")
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter-1}")
								[ ] bMatch =MatchStr("*{lsCategory[1]}*{lsCategory[3]}*{lsCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
								[+] if (bMatch==TRUE)
									[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data after modification: Transaction with category {lsCategory[1]} , Tag: {lsCategory[3]}, Memo: {lsCategory[4]} and with amount:{Str(nAmount,7,2)}appeared.")
								[+] else
									[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data after modification: Transaction with category {lsCategory[1]} , Tag: {lsCategory[3]}, Memo: {lsCategory[4]} and with amount: {Str(nAmount,7,2)} didn't appear.")
									[ ] 
							[ ] 
							[ ] //////Verfy total amount of the categories/////
							[ ] sActualAmount=SplitTransaction.SplitTransactionsTotalText.GetText()
							[ ] nActualAmount=VAL(StrTran(sActualAmount , ",", ""))
							[+] if (nAmountTotal==nActualAmount)
								[ ] ReportStatus("Verify split transactions total amount.",PASS,"Verify split transactions total amount: Actual toatal amount - {nActualAmount} is as expected {nAmountTotal}.")
							[+] else
								[ ] ReportStatus("Verify split transactions total amount.",FAIL,"Verify split transactions total amount: Actual toatal amount - {nActualAmount} is NOT as expected {nAmountTotal}.")
								[ ] 
							[ ] SplitTransaction.Cancel.Click()
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
					[+] else
						[ ] ReportStatus("Search Transaction",FAIL,"Transaction {lsTransaction[6]} not found in Account {lsAddAccount[2]}")
				[+] else
					[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[2]}  Account", FAIL, "{lsAddAccount[2]}  account couldn't open.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] 
[+] //############# Test11_VerifyUnknownTypePaymentSplitTransaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyUnknownTypeSplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify unknown type split transaction enetered as payement
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verifying unknown type split transaction enetered as payement is successful
		[ ] //						Fail			If verifying unknown type split transaction enetered as payement is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 10, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test11_VerifyUnknownTypePaymentSplitTransaction() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sTag , sMemo
	[ ] LIST OF ANYTYPE lsExcelData2, lsMixedCategories
	[ ] // Read data from sRegAccountWorksheet excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
	[ ] lsTransaction=lsExcelData[4]
	[ ] // Fetch 1st row from sExpenseCategoryDataSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
	[ ] lsExpenseCategory=lsExcelData[1]
	[ ] 
	[ ] lsMixedCategories=lsExcelData+lsExcelData2
	[ ] NUMBER nAmountTotal=0
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Select the Banking account
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[ ] 
		[+] if (iSelect==PASS)
			[ ] ////////Adding unknown type transaction//////
			[ ] 
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
			[ ] 
			[ ] 
			[+] if(SplitTransaction.Exists(2))
				[+] if (!SplitTransaction.IsActive())
					[ ] SplitTransaction.SetActive()
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#1")
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
				[+] if (NewTag.Exists(5))
					[ ] NewTag.SetActive()
					[ ] NewTag.OKButton.Click()
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsExpenseCategory[4])
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsExpenseCategory[2])
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
				[ ] 
				[+] if (SplitTransaction.Adjust.IsEnabled())
					[ ] SplitTransaction.Adjust.Click()
				[ ] 
				[ ] nAmount=VAL(lsExpenseCategory[2])
				[ ] nAmountTotal=nAmount+nAmountTotal
				[ ] sActualAmount=SplitTransaction.SplitTransactionsTotalText.GetText()
				[ ] SplitTransaction.OK.Click()
				[+] if (DlgPaymentOrDeposit.Exists(5))
					[ ] DlgPaymentOrDeposit.PaymentRadioButton.Select("Payment")
					[ ] DlgPaymentOrDeposit.OKButton.Click()
					[ ] 
				[ ] WaitForState(SplitTransaction,False,1)
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
				[ ] 
				[ ] //////Verfy total amount of the categories/////
				[ ] nActualAmount=VAL(StrTran(sActualAmount ,"," ,""))
				[+] if (nAmountTotal==nActualAmount)
					[ ] ReportStatus("Verify split transactions total amount.",PASS,"Verify split transactions total amount: Actual toatal amount - {nActualAmount} is as expected {nAmountTotal}.")
				[+] else
					[ ] ReportStatus("Verify split transactions total amount.",FAIL,"Verify split transactions total amount: Actual toatal amount - {nActualAmount} is NOT as expected {nAmountTotal}.")
				[ ] //Verify that transactis entered as a payment///
				[ ] lsTemp=GetTransactionsInRegister(lsTransaction[6])
				[ ] 
				[+] if (ListCount(lsTemp)>0)
					[ ] 
					[ ] bMatch= MatchStr("*{lsTransaction[6]}*-{trim(Str(nAmount,7,2))}*",lsTemp[1])
					[+] if (bMatch==TRUE)
						[ ] ReportStatus("Verify transaction entered as payment", PASS, "Verify transaction entered as payment: Transaction with payee {lsTransaction[6]} and amount - {nAmount} entered as payment")
					[+] else
						[ ] ReportStatus("Verify transaction entered as payment", FAIL, "Verify transaction entered as payment: Transaction with payee {lsTransaction[6]} and amount - {nAmount} didn't enter as payment")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify transaction entered as payment", FAIL, "Verify transaction entered as payment: Transaction with payee {lsTransaction[6]} and amount - {nAmount} not found in Find and Replace dailog box.")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account couldn't open.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] 
[+] //############# Test12_VerifyUnknownTypeIncomeSplitTransaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyUnknownTypeIncomeSplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify unknown type split transaction entered as deposit
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verifying unknown type split transaction enetered as deposit is successful
		[ ] //						Fail			If verifying unknown type split transaction enetered as deposit is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 10, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test12_VerifyUnknownTypeIncomeSplitTransaction() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sTag , sMemo
	[ ] LIST OF ANYTYPE lsExcelData2, lsMixedCategories
	[ ] // Read data from sRegAccountWorksheet excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
	[ ] lsTransaction=lsExcelData[5]
	[ ] // Fetch 1st row from sExpenseCategoryDataSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
	[ ] lsExpenseCategory=lsExcelData[1]
	[ ] 
	[ ] lsMixedCategories=lsExcelData+lsExcelData2
	[ ] NUMBER nAmountTotal=0
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Select the Banking account
		[ ] iSelect =SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[ ] 
		[+] if (iSelect==PASS)
			[ ] ////////Adding unknown type transaction//////
			[ ] 
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] 
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
			[+] if(SplitTransaction.Exists(2))
				[+] if (!SplitTransaction.IsActive())
					[ ] SplitTransaction.SetActive()
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#1")
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
				[+] if (NewTag.Exists(5))
					[ ] NewTag.SetActive()
					[ ] NewTag.OKButton.Click()
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsExpenseCategory[4])
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsExpenseCategory[2])
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] nAmount=VAL(lsExpenseCategory[2])
				[ ] nAmountTotal=nAmount+nAmountTotal
				[ ] sActualAmount=SplitTransaction.SplitTransactionsTotalText.GetText()
				[ ] SplitTransaction.OK.Click()
				[+] if (DlgPaymentOrDeposit.Exists(5))
					[ ] DlgPaymentOrDeposit.DepositRadioButton.Select("Deposit")
					[ ] DlgPaymentOrDeposit.OKButton.Click()
				[ ] WaitForState(SplitTransaction,False,1)
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
				[ ] 
				[ ] //////Verfy total amount of the categories/////
				[ ] nActualAmount=VAL(sActualAmount)
				[+] if (nAmountTotal==nActualAmount)
					[ ] ReportStatus("Verify split transactions total amount.",PASS,"Verify split transactions total amount: Actual toatal amount - {nActualAmount} is as expected {nAmountTotal}.")
				[+] else
					[ ] ReportStatus("Verify split transactions total amount.",FAIL,"Verify split transactions total amount: Actual toatal amount - {nActualAmount} is NOT as expected {nAmountTotal}.")
				[ ] //Verify that transactis entered as a payment///
				[ ] lsTemp=GetTransactionsInRegister(lsTransaction[6])
				[ ] bMatch= MatchStr("*{lsTransaction[6]}*{trim(Str(nAmount,7,2))}*",lsTemp[1])
				[+] if (bMatch==TRUE)
					[ ] ReportStatus("Verify transaction entered as deposit", PASS, "Verify transaction entered as deposit: Transaction with payee {lsTransaction[6]} and amount {nAmount} entered as deposit")
				[+] else
					[ ] ReportStatus("Verify transaction entered as deposit", FAIL, "Verify transaction entered as deposit: Transaction with payee {lsTransaction[6]} and amount  {nAmount} didn't enter as deposit")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[2]}  Account", FAIL, "{lsAddAccount[2]}  account couldn't open.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] 
[+] ////############# Verify Search Window in Account Register ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC13_RegisterSearchFeatureExistsForBusinessAccounts()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify existence of Search window in Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If search window exists			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  14/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC13_RegisterSearchFeatureExistsForBusinessAccounts() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountName
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegBusinessTransaction)
		[ ] lsTransactionData=lsExcelData[1]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sRegFileName)
		[ ] 
		[+] if (iVerify == PASS)
			[ ] QuickenWindow.SetActive()
			[ ] // Add Business Account
			[+] for (iCounter=12; iCounter<14;++iCounter)
				[ ] lsAddAccount=lsExcelData[iCounter]
				[+] if (lsAddAccount[1]==NULL)
					[ ] break
				[ ] sAccountName=lsAddAccount[2]
				[ ] iAddAccount = AddBusinessAccount(lsAddAccount[1], sAccountName)
				[ ] // Report Status if checking Account is created
				[+] if (iAddAccount==PASS)
					[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {sAccountName}  is created successfully")
					[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sAccountName} selected successfully")
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N)
						[+] if(MDIClient.AccountRegister.SearchWindow.Exists(5))
							[ ] ReportStatus("Register Search Feature Exists ", PASS, "Search Window Exists in Account Register")
							[ ] iVerify= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDateStamp,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
							[+] if (iVerify==PASS)
								[ ] MDIClient.AccountRegister.SearchWindow.SetText(lsTransactionData[5])
								[ ] 
								[ ] // // Match value obtained from register to value given in 
								[ ] sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
								[ ] MDIClient.AccountRegister.SearchWindow.SetText("")
								[ ] iNum=val(sTransactionCount)
								[ ] 
								[+] if(iNum==1)
									[ ] ReportStatus("Register Search Feature Functionality",PASS,"Transaction displayed correctly when searched by {lsTransactionData[5]}")
									[ ] /////Now delete the created transaction////
									[ ] DeleteTransaction(sMDIWindow,lsTransactionData[5])
									[ ] 
								[+] else
									[ ] ReportStatus("Register Search Feature Functionality",FAIL,"Transaction not displayed correctly when searched by {lsTransactionData[5]}")
							[+] else
								[ ] ReportStatus("Verify transaction added.", FAIL, "Verify transaction added: Transaction with payee {lsTransactionData[5]} couldn't be added.")
						[+] else
							[ ] ReportStatus("Register Search Feature Exists ", FAIL, "Search Window does not Exists in Account Register")
					[+] else
						[ ] ReportStatus("Verify register Search Feature exists for BusinessAccounts",FAIL,"Account {sAccountName} not selected")
					[ ] 
				[+] else
					[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {sAccountName}  is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Register Search Feature Exists ", FAIL, "Data file -  {sFileName} is not Opened")
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
	[ ] 
	[ ] 
	[ ] 
[ ] // 
[+] // ////############# Verify attachment options for banking register ########################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC14_VerifyAttachmentoptionsInBankingRegister()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify attachment options
		[ ] // //.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	       If attachment options verification is successful
		[ ] // //						Fail		      If attachment options verification is unsuccessful
		[ ] // // 
		[ ] // //REVISION HISTORY:  16/03/ 2013	Created by	Mukesh
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase TC14_VerifyAttachmentoptionsInBankingRegister() appstate none
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[+] // //Variable Declaration
		[ ] // 
		[ ] // //Integer
		[ ] // INTEGER iVerify
		[ ] // STRING sAccountName
		[+] // LIST OF STRING lsExpectedAttachNewPopupList={...}
			[ ] // "Check"
			[ ] // "Receipt/bill"
			[ ] // "Invoice"
			[ ] // "Warranty"
			[ ] // "Other"
		[ ] // sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] // sAccountAction="Attachments"
		[ ] // ////Read first row from sRegTransactionSheet
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
		[ ] // lsTransaction=lsExcelData[1]
		[ ] // 
		[ ] // ////Read first row from sRegAccountWorksheet
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] // lsAddAccount=lsExcelData[1]
		[ ] // //// Fetch 1st row from sExpenseCategoryDataSheet the given sheet
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
		[ ] // lsExpenseCategory=lsExcelData[1]
		[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // 
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] // if(iVerify==PASS)
			[ ] // MDIClient.AccountRegister.SearchWindow.SetText(lsTransaction[6])
			[ ] // 
			[ ] // // // Match value obtained from register to value given in 
			[ ] // sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
			[ ] // 
			[ ] // iNum=val(sTransactionCount)
			[ ] // ///Add transaction into the banking register if doesn't exist/// 
			[+] // if(iNum==0)
				[ ] // AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
			[ ] // iVerify=AccountActionsOnTransaction(lsTransaction[6],sAccountAction)
			[+] // if (iVerify==PASS)
				[+] // if (DlgTransactionAttachments.Exists(5))
					[ ] // DlgTransactionAttachments.SetActive()
					[ ] // /// ######Verify AttachNew PopupList contents#######///
					[+] // if (DlgTransactionAttachments.AttachNewPopupList.Exists(5))
						[ ] // lsActualListContents=DlgTransactionAttachments.AttachNewPopupList.GetContents()
						[+] // if (lsActualListContents==lsExpectedAttachNewPopupList)
							[ ] // ReportStatus("Verify AttachNew PopupList contents.", PASS, "Verify AttachNew PopupList contents: AttachNew PopupList has contents {lsActualListContents} as expected {lsExpectedAttachNewPopupList}.") 
						[+] // else
							[ ] // ReportStatus("Verify AttachNew PopupList contents.", FAIL, "Verify AttachNew PopupList contents: AttachNew PopupList's contents {lsActualListContents} are NOT as expected {lsExpectedAttachNewPopupList}.") 
					[+] // else
						[ ] // ReportStatus("Verify AttachNew PopupList exists.", FAIL, "Verify AttachNew PopupList exists: AttachNew PopupList doesn't exist.") 
					[ ] // /// ###### Verify options File,Scanner,Clipboard ,Done ,Help,Print and active#######///
					[+] // if (DlgTransactionAttachments.FileButton.Exists(5))
						[ ] // ReportStatus("Verify File Button exists.", PASS, "Verify File Button exists: File Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify File Button exists.", FAIL, "Verify File Button exists: File Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.ScannerButton.Exists(5))
						[ ] // ReportStatus("Verify Scanner Button exists.", PASS, "Verify Scanner Button exists: Scanner Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify Scanner Button exists.", FAIL, "Verify Scanner Button exists: Scanner Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.ClipboardButton.Exists(5))
						[ ] // ReportStatus("Verify Clipboard Button exists.", PASS, "Verify Clipboard Button exists: Clipboard Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify Clipboard Button exists.", FAIL, "Verify Clipboard Button exists: Clipboard Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.DoneButton.Exists(5))
						[ ] // ReportStatus("Verify Done Button exists.", PASS, "Verify Done Button exists: Done Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify Done Button exists.", FAIL, "Verify Done Button exists: Done Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.HelpButton.Exists(5))
						[ ] // ReportStatus("Verify Help Button exists.", PASS, "Verify Help Button exists: Help Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify Help Button exists.", FAIL, "Verify Help Button exists: Help Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.PrintButton.Exists(5))
						[ ] // ReportStatus("Verify Print Button exists.", PASS, "Verify Print Button exists: Print Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify Print Button exists.", FAIL, "Verify Print Button exists: Print Button doesn't exist.") 
					[ ] // 
					[ ] // /// ###### Verify options Open, Encryption,Export and Delete exists but inactive#######///
					[+] // if ((DlgTransactionAttachments.OpenButton.Exists(5) )&& (DlgTransactionAttachments.OpenButton.IsEnabled()==FALSE))
						[ ] // ReportStatus("Verify Open Button exists and disabled.", PASS, "Verify Open Button exists  and disabled: Open Button exists  and disabled.") 
					[+] // else
						[ ] // ReportStatus("Verify Open Button exists.", FAIL, "Verify Open Button exists: Open Button either doesn't exist or enabled.") 
					[+] // if ((DlgTransactionAttachments.EncryptionButton.Exists(5) )&& (DlgTransactionAttachments.EncryptionButton.IsEnabled()==FALSE))
						[ ] // ReportStatus("Verify Encryption Button exists and disabled.", PASS, "Verify Encryption Button exists and disabled: Encryption Button exists and disabled.") 
					[+] // else
						[ ] // ReportStatus("Verify Encryption Button exists.", FAIL, "Verify Encryption Button exists: Encryption Button either doesn't exist or enabled.") 
					[+] // if ((DlgTransactionAttachments.ExportButton.Exists(5) )&& (DlgTransactionAttachments.ExportButton.IsEnabled()==FALSE))
						[ ] // ReportStatus("Verify Export Button exists and disabled.", PASS, "Verify Export Button exists and disabled: Export Button exists and disabled.") 
					[+] // else
						[ ] // ReportStatus("Verify Export Button exists.", FAIL, "Verify Export Button exists: Export Button either doesn't exist or enabled.") 
					[+] // if ((DlgTransactionAttachments.DeleteButton.Exists(5) )&& (DlgTransactionAttachments.DeleteButton.IsEnabled()==FALSE))
						[ ] // ReportStatus("Verify Delete Button exists and disabled.", PASS, "Verify Delete Button exists and disabled: Delete Button exists and disabled.") 
					[+] // else
						[ ] // ReportStatus("Verify Delete Button exists.", FAIL, "Verify Delete Button exists: Delete Button either doesn't exist or enabled.") 
					[ ] // ///Close the attachments dailog///
					[ ] // DlgTransactionAttachments.DoneButton.Click()
					[ ] // WaitForState(DlgTransactionAttachments,false,1)
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify attachments dialog.", FAIL, "Verify attachments dialog: Attachments dialog couldn't be opened.") 
			[+] // else
				[ ] // ReportStatus("Verify attachments menu selected.", FAIL, "Verify attachments menu selected: Attachments dialog couldn't be opened.") 
		[+] // else
			[ ] // ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
	[+] // else
		[ ] // ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] // 
	[ ] // 
	[ ] // 
[ ] // 
[+] // ////############# Verify attachment feature for banking register ########################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC15_VerifyAttachmentFeatureInBankingRegister()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify attachment functionality
		[ ] // //.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	       If attachment functionality verification is successful
		[ ] // //						Fail		      If attachment functionality verification is unsuccessful
		[ ] // // 
		[ ] // //REVISION HISTORY:  16/03/ 2013	Created by	Mukesh
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase TC15_VerifyAttachmentFeatureInBankingRegister() appstate none
	[ ] // 
	[ ] //  
	[ ] // 
	[ ] // 
	[+] // //Variable Declaration
		[ ] // 
		[ ] // //Integer
		[ ] // INTEGER iVerify
		[ ] // STRING sAccountName, sAttachmentLocation, sAttachmentFolder
		[ ] // sAttachmentFolder="TransactionAttachments"
		[ ] //  sAttachmentLocation= AUT_DATAFILE_PATH + "\" + sAttachmentFolder+"\"
		[+] // LIST OF STRING lsExpectedAttachNewPopupList={...}
			[ ] // "Check"
			[ ] // "Receipt/bill"
			[ ] // "Invoice"
			[ ] // "Warranty"
			[ ] // "Other"
		[ ] //  sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] // sAccountAction="Attachments"
		[ ] // ////Read first row from sRegTransactionSheet
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
		[ ] // lsTransaction=lsExcelData[1]
		[ ] // 
		[ ] // ////Read first row from sRegAccountWorksheet
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] // lsAddAccount=lsExcelData[1]
		[ ] // //// Fetch 1st row from sExpenseCategoryDataSheet the given sheet
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
		[ ] // lsExpenseCategory=lsExcelData[1]
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // 
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] // if(iVerify==PASS)
			[ ] // MDIClient.AccountRegister.SearchWindow.SetText(lsTransaction[6])
			[ ] // 
			[ ] // // // Match value obtained from register to value given in 
			[ ] // sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
			[ ] // 
			[ ] // iNum=val(sTransactionCount)
			[ ] // ///Add transaction into the banking register if doesn't exist/// 
			[+] // if(iNum==0)
				[ ] // AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
			[ ] // iVerify=AccountActionsOnTransaction(lsTransaction[6],sAccountAction)
			[+] // if (iVerify==PASS)
				[+] // if (DlgTransactionAttachments.Exists(5))
					[ ] // DlgTransactionAttachments.SetActive()
					[ ] // /// ######Verify AttachNew Check#######///
					[+] // if (DlgTransactionAttachments.AttachNewPopupList.Exists(5))
						[+] // for (iCounter=1; iCounter<ListCount(lsExpectedAttachNewPopupList)+1 ; ++iCounter)
							[ ] // DlgTransactionAttachments.AttachNewPopupList.Select(trim(lsExpectedAttachNewPopupList[iCounter]))
							[ ] // ////#####This line has been added to handle "/" as we can not have this as the part of file name#####////
							[+] // if (lsExpectedAttachNewPopupList[iCounter]=="Receipt/bill")
								[ ] // lsExpectedAttachNewPopupList[iCounter]="Receiptbill"
							[ ] // 
							[ ] // DlgTransactionAttachments.FileButton.Click()
							[+] // if (SaveAs.Exists(5))
								[ ] // SaveAs.SetActive()
								[ ] // SaveAs.FileName.SetText(sAttachmentLocation+lsExpectedAttachNewPopupList[iCounter])
								[ ] // SaveAs.Open.DoubleClick()
								[ ] // WaitForState(SaveAs,False,1)
								[+] // if (DlgTransactionAttachments.Exists(5))
									[ ] // 
									[ ] // DlgTransactionAttachments.SetActive()
									[+] // if (DlgTransactionAttachments.AttachedPanel.QWinChild1.Panel1.Exists(5))
										[ ] // ReportStatus("Verify attachment attached.", PASS, "Verify attachment attached: Attachment {lsExpectedAttachNewPopupList[iCounter]} successfully attached.") 
										[ ] // ///######Delete the added attachment########////
										[ ] // DlgTransactionAttachments.DeleteButton.Click()
										[+] //  if(Quicken2012Popup.Exists(5))
											[ ] // Quicken2012Popup.Yes.Click()
											[ ] // WaitForState(Quicken2012Popup,False,1)
											[ ] // 
										[+] // else
											[ ] // ReportStatus("Verify delete confirmation dialog.", FAIL, "Verify delete confirmation dialog: Delete confirmation dialog didn't appear.") 
									[+] // else
										[ ] // ReportStatus("Verify attachment attached..", FAIL, "Verify attachment attached: Attachment {lsExpectedAttachNewPopupList[3]} couldn't be attached.") 
								[+] // else
									[ ] // ReportStatus("Verify attachments dialog.", FAIL, "Verify attachments dialog: Attachments dialog couldn't be opened.") 
								[ ] // ////Attachment 
							[+] // else
								[ ] // ReportStatus("Verify Select attachment file dialog.", FAIL, "Verify Select attachment file dialog: Select attachment file dialog didn't appear.") 
					[+] // else
						[ ] // ReportStatus("Verify AttachNewPopupList exists.", FAIL, "Verify AttachNewPopupList exists: AttachNewPopupList doesn't exist.") 
					[+] // if (!DlgTransactionAttachments.IsActive())
						[ ] // DlgTransactionAttachments.SetActive()
					[ ] // DlgTransactionAttachments.DoneButton.Click()
					[ ] // WaitForState(DlgTransactionAttachments,False,1)
				[+] // else
					[ ] // ReportStatus("Verify attachments dialog.", FAIL, "Verify attachments dialog: Attachments dialog couldn't be opened.") 
			[+] // else
				[ ] // ReportStatus("Verify attachments menu selected.", FAIL, "Verify attachments menu selected: Attachments dialog couldn't be opened.") 
		[+] // else
			[ ] // ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
	[+] // else
		[ ] // ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] // 
	[ ] // 
	[ ] // 
[ ] 
[+] ////############# Verify default in Edit - Find ->Find########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC16_VerifyFindFeatureForBankingRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Find feature
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	       If Find feature verification is successful
		[ ] //						Fail		       If Find feature verification is unsuccessful
		[ ] // 
		[ ] //REVISION HISTORY:  16/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC16_VerifyFindFeatureForBankingRegister() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sAccountName, sAttachmentLocation, sAttachmentFolder
		[ ] // sAttachmentFolder="TransactionAttachments"
		[ ] // sAttachmentLocation= AUT_DATAFILE_PATH + "\" + sAttachmentFolder+"\"
		[+] LIST OF STRING lsExpectedFindPopupList={...}
			[ ] "Any Field"
			[ ] "Amount"
			[ ] "Category"
			[ ] "Check number"
			[ ] "Cleared status"
			[ ] "Date"
			[ ] "Memo"
			[ ] "Payee"
			[ ] "Tag"
			[ ] 
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] // sAccountAction="Attachments"
		[ ] ////Read first row from sRegTransactionSheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] ////Read first row from sRegAccountWorksheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] //// Fetch 1st row from sExpenseCategoryDataSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
		[ ] lsExpenseCategory=lsExcelData[1]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] iVerify =FindTransaction(sMDIWindow,lsTransaction[5])
			[+] if(iVerify==PASS)
				[ ] DeleteTransaction(sMDIWindow,lsTransaction[5])
			[ ] lsTransaction[6]="Find Transaction"  //+lsTransaction[6]
			[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
			[ ] QuickenWindow.SetActive()
			[ ] // 
			[ ] // MDIClient.AccountRegister.SearchWindow.SetText(lsTransaction[6])
			[ ] // 
			[ ] // // // Match value obtained from register to value given in 
			[ ] // sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
			[ ] // MDIClient.AccountRegister.SearchWindow.SetText("")
			[ ] // 
			[ ] // iNum=val(sTransactionCount)
			[ ] ///Add transaction into the banking register if doesn't exist/// 
			[ ] 
			[ ] lsTransaction[3]=lsExpenseCategory[2]
			[ ] lsTransaction[4]=sDateStamp
			[ ] lsTransaction[7]=lsExpenseCategory[4]
			[ ] lsTransaction[8]=lsExpenseCategory[1]
			[ ] 
			[ ] ////Creating list of data to be searched////
			[ ] //add Any Field
			[ ] ListAppend(lsTemp,lsExpectedFindPopupList[1])
			[ ] //add amount
			[ ] ListAppend(lsTemp,lsTransaction[3])
			[ ] //add category
			[ ] ListAppend(lsTemp,lsTransaction[8])
			[ ] //add check no.
			[ ] ListAppend(lsTemp,lsTransaction[5])
			[ ] //add cleared status Uncleared
			[ ] ListAppend(lsTemp,"Uncleared")
			[ ] //add date
			[ ] ListAppend(lsTemp,sDateStamp)
			[ ] //add memo
			[ ] ListAppend(lsTemp,lsTransaction[7])
			[ ] //add payee
			[ ] ListAppend(lsTemp,lsTransaction[6])
			[ ] 
			[ ] 
			[ ] 
			[ ] ////Created list of data to be searched////
			[ ] /// ######Verify Find> Find pouplist contents #######///
			[ ] QuickenWindow.SetActive ()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)   
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_F)           // Launch Quicken Find window      
			[ ] 
			[+] if(QuickenFind.Exists(5))
				[ ] QuickenFind.SetActive()
				[ ] lsActualListContents= QuickenFind.FindAnyField.GetContents()
				[ ] QuickenFind.Close()
				[ ] 
				[+] if (lsActualListContents==lsExpectedFindPopupList)
					[ ] ReportStatus("Verify Edit > Find> Find pouplist contents.", PASS, "Verify Edit >Find> Find pouplist contents: Find pouplist has contents {lsActualListContents} as expected {lsExpectedFindPopupList}.") 
					[+] for (iCounter=2; iCounter<ListCount(lsExpectedFindPopupList) ; ++iCounter)
						[ ] QuickenWindow.SetActive ()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)	// highlight the new row
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_F)           // Launch Quicken Find window         [QW2013 compatible] lsActualListContents
						[+] if(QuickenFind.Exists(5))
							[ ] QuickenFind.SetActive()
							[ ] QuickenFind.FindAnyField.Select(iCounter)
							[ ] QuickenFind.QuickenFind.SetText(lsTemp[iCounter])
							[ ] QuickenFind.Find.Click()
							[+] if (AlertMessage.Exists(2))
								[ ] sCaption=AlertMessage.GetCaption()
								[+] if(sCaption=="Quicken 2014")
									[ ] AlertMessage.OK.Click()
									[ ] WaitForState(AlertMessage,false,1)
									[ ] ReportStatus("Verify Edit> Find feature", FAIL, "Verify Edit> Find feature: Transaction Not found for criteria {lsExpectedFindPopupList[iCounter]} and value {lsTemp[iCounter]}.")
							[+] else
								[ ] ReportStatus("Verify Edit> Find feature", PASS, "Verify Edit> Find feature: Transaction found for criteria {lsExpectedFindPopupList[iCounter]} and value {lsTemp[iCounter]}.")
							[ ] QuickenFind.Close()
							[ ] WaitForState(QuickenFind,False,1)
						[+] else
							[ ] ReportStatus("Validate Window", FAIL, "Quicken Find window doesn't exists")
							[ ] 
				[+] else
					[ ] ReportStatus("Verify Edit > Find> Find pouplist contents.", FAIL, "Verify Edit >Find> Find pouplist contents: Find pouplist's contents {lsActualListContents} are NOT as expected {lsExpectedFindPopupList}.") 
					[ ] 
		[+] else
			[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
	[+] else
		[ ] ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] ////############# Enter transactions with different check # options in Checking account #######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC17_VerifyCheckNumOptionsforCheckingAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Check # Options for Checking Account
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	       If Check # Options verification for Checking Account is successful
		[ ] //						Fail		       If Check # Options verification for Checking Account is unsuccessful
		[ ] // 
		[ ] //REVISION HISTORY:  21/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC17_VerifyCheckNumOptionsforCheckingAccount() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] CheckNumReordKeys rCheckNumReord
		[ ] rCheckNumReord=lsCheckNumReordValue
		[ ] ////Read first row from sRegTransactionSheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] 
		[ ] ////Read first row from sRegAccountWorksheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[9]
		[ ] 
		[ ] /////Account Balance in data sheet////
		[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
		[ ] ///Transaction amount///
		[ ] nAmount1=Val(StrTran(lsTransaction[3],",",""))
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //############## Create New Checking Account #####################################
		[ ] // Quicken is launched then Add Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ////####Verify Ending Balance after adding the tranaction with check no.#####//
				[ ] iVerify =FindTransaction(sMDIWindow,lsTransaction[6])
				[+] if(iVerify==PASS)
					[ ] DeleteTransaction(sMDIWindow,lsTransaction[6])
				[ ] 
				[ ] sleep(2)
				[ ] ///Amount difference after adding the transaction///  ,
				[ ] nAmountDifferenceExpected=nAmountTotal - nAmount1
				[ ] ///Get the Account balance///
				[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
				[ ] nAmount=Val(StrTran(sAmount,",",""))
				[ ] ////Add the transaction with check number////
				[ ] 
				[+] if (nAmountTotal==nAmount)
					[ ] sPayee ="{lsTransaction[6]}+CheckNo."
					[ ] iResult=AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,lsTransaction[5],sPayee,lsTransaction[7],lsTransaction[8])
					[+] if (iResult==PASS)
						[ ] ///Get the Account balance after adding the transaction///
						[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
						[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
						[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the tranaction with check no {lsTransaction[5]}: Ending Balance {nAmountDifferenceActual} is the difference of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
						[+] else
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the tranaction with check no. {lsTransaction[5]}: Ending Balance  {nAmountDifferenceActual} is NOT the difference of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
							[ ] 
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
					[ ] 
				[ ] ////####Verify Ending Balance after adding the tranaction with ATM in Check # field #####//
				[ ] iVerify =FindTransaction(sMDIWindow,lsTransaction[6])
				[+] if(iVerify==PASS)
					[ ] DeleteTransaction(sMDIWindow,lsTransaction[6])
				[ ] 
				[ ] ////Add the transaction with check number////
				[ ] 
				[+] if (nAmountTotal==nAmount)
					[ ] sPayee=NULL
					[ ] sPayee ="{lsTransaction[6]}+{rCheckNumReord.sATM}"
					[ ] iResult=AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,rCheckNumReord.sATM,sPayee,lsTransaction[7],lsTransaction[8])
					[+] if (iResult==PASS)
						[ ] ///Get the Account balance after adding the transaction///
						[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
						[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
						[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the tranaction with ATM as check #.: Ending Balance {nAmountDifferenceActual} is the difference of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
						[+] else
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the tranaction with ATM as check #.: Ending Balance  {nAmountDifferenceActual} is NOT the difference of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
							[ ] 
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
					[ ] 
				[ ] iVerify =FindTransaction(sMDIWindow,lsTransaction[6])
				[+] if(iVerify==PASS)
					[ ] DeleteTransaction(sMDIWindow,lsTransaction[6])
				[ ] ///Amount difference after adding the transaction///  ,
				[ ] 
				[ ] nAmountDifferenceExpected=nAmountTotal + nAmount1
				[ ] ///Get the Account balance///
				[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
				[ ] nAmount=Val(StrTran(sAmount,",",""))
				[ ] ////Add the transaction with check number////
				[ ] 
				[ ] ////####Verify Ending Balance after adding the tranaction with DEPOSIT in Check # field #####//
				[ ] ////Add the transaction  with DEPOSIT in Check # field////
				[+] if (nAmountTotal==nAmount)
					[ ] ///Payee needs to be modified as the transaction will be memorized///
					[ ] sPayee="DEPOSIT" + lsTransaction[6]
					[ ] iResult=AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,rCheckNumReord.sDeposit,sPayee,lsTransaction[7],lsTransaction[8])
					[+] if (iResult==PASS)
						[ ] ///Get the Account balance after adding the transaction///
						[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
						[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
						[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the tranaction with DEPOSIT as check #.: Ending Balance {nAmountDifferenceActual} is the sum of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
						[+] else
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the tranaction with DEPOSIT as check #.: Ending Balance  {nAmountDifferenceActual} is NOT the sum of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
					[ ] 
				[ ] 
				[ ] ////####Verify Ending Balance after adding the tranaction with EFT in Check # field #####//
				[ ] iVerify =FindTransaction(sMDIWindow,lsTransaction[6])
				[+] if(iVerify==PASS)
					[ ] DeleteTransaction(sMDIWindow,lsTransaction[6])
				[ ] sleep(2)
				[ ] ////Add the transaction with EFT in Check # field////
				[ ] nAmountDifferenceExpected=nAmountTotal - nAmount1
				[ ] 
				[+] if (nAmountTotal==nAmount)
					[ ] sPayee=NULL
					[ ] sPayee ="{lsTransaction[6]}+{rCheckNumReord.sEFT}"
					[ ] 
					[ ] iResult=AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,rCheckNumReord.sEFT,sPayee,lsTransaction[7],lsTransaction[8])
					[+] if (iResult==PASS)
						[ ] ///Get the Account balance after adding the transaction///
						[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
						[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
						[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the tranaction with EFT as check #.: Ending Balance {nAmountDifferenceActual} is the difference of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
						[+] else
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the tranaction with EFT as check #.: Ending Balance  {nAmountDifferenceActual} is NOT the difference of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
							[ ] 
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
					[ ] 
				[ ] 
				[ ] ////####Verify Ending Balance after adding the tranaction with Print Check in Check # field #####//
				[ ] iVerify =FindTransaction(sMDIWindow,lsTransaction[6])
				[+] if(iVerify==PASS)
					[ ] DeleteTransaction(sMDIWindow,lsTransaction[6])
				[ ] sleep(2)
				[ ] ////Add the transaction with Print Check in Check # field////
				[ ] nAmountDifferenceExpected=nAmountTotal - nAmount1
				[+] if (nAmountTotal==nAmount)
					[ ] sPayee=NULL
					[ ] sPayee ="{lsTransaction[6]}+{rCheckNumReord.sPrintCheck}"
					[ ] 
					[ ] iResult=AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,rCheckNumReord.sPrintCheck,sPayee,lsTransaction[7],lsTransaction[8])
					[+] if (iResult==PASS)
						[ ] ///Get the Account balance after adding the transaction///
						[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
						[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
						[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the tranaction with Print Check as check #.: Ending Balance {nAmountDifferenceActual} is the difference of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
							[ ] DeleteTransaction(sMDIWindow,lsTransaction[6])
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the tranaction with Print Check as check #.: Ending Balance  {nAmountDifferenceActual} is NOT the difference of the openning balance :{nAmountTotal}  and transaction amount: {nAmount1}")
							[ ] 
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
			[ ] 
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# TA2390-Transfer when Register is a document window - Checking#######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC18_VerifyTransferFromCheckingToSavingsDocumentWindowMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Transfer From Checking accont in Document Window Mode
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	       If Transfer From Checking to savings accont in Document Window Mode verification is successful
		[ ] //						Fail		       If Transfer From Checking  to savings accont in Document Window Mode verification is unsuccessful
		[ ] // 
		[ ] //REVISION HISTORY:  21/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC18_VerifyTransferFromCheckingToSavingsDocumentWindowMode() appstate none //QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] CheckNumReordKeys rCheckNumReord
		[ ] rCheckNumReord=lsCheckNumReordValue
		[ ] ////Read first row from sRegTransactionSheet
		[ ] lsExcelData=NULL
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] 
		[ ] ////Read first row from sRegAccountWorksheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] /////Account Balance in data sheet////
		[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
		[ ] ///Transaction amount///
		[ ] nAmount1=Val(StrTran(lsTransaction[3],",",""))
		[ ] sPayee="TXFR" +lsTransaction[6]
		[ ] STRING sTransferAccount
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] ////####Verify Ending Balance after adding the tranaction with check no.#####//
			[ ] 
			[ ] // // search and delete the transaction if exists///
			[ ] iVerify =FindTransaction(sMDIWindow,sPayee)
			[+] if(iVerify==PASS)
				[ ] DeleteTransaction(sMDIWindow,sPayee)
			[ ] ///##########Verify Transfer Transction in From account########////
			[ ] 
			[ ] ///Amount difference after adding the transaction///  
			[ ] nAmountDifferenceExpected=nAmountTotal - nAmount1
			[ ] ///Get the Account balance///
			[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
			[ ] // clear the search field
			[ ] nAmount=Val(StrTran(sAmount,",",""))
			[ ] ////Add the transaction with check number////
			[+] if (nAmountTotal==nAmount)
				[ ] lsAddAccount=lsExcelData[6]
				[ ] sTransferAccount=lsAddAccount[2]
				[ ] iResult=AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,rCheckNumReord.sTransfer,sPayee,lsTransaction[7],sTransferAccount)
				[+] if (iResult==PASS)
					[ ] ///Get the Account balance after adding the transaction///
					[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
					[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
					[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmountDifferenceActual} is the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
					[+] else
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmountDifferenceActual} is NOT the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
				[ ] 
			[ ] 
			[ ] ///##########Verify Transfer Transction in To account########////
			[ ] ///Fetch the account balance for the savings account ///
			[ ] lsAddAccount=lsExcelData[6]
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] 
				[ ] nAmountTotal=0
				[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
				[ ] ///Amount difference after adding the transaction///  
				[ ] 
				[ ] nAmountDifferenceExpected=nAmountTotal + nAmount1
				[ ] ///Get the Account balance///
				[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
				[ ] nAmount=Val(StrTran(sAmount,",",""))
				[ ] ////Add the transaction with check number////
				[+] if (nAmountDifferenceExpected==nAmount)
					[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmount} is the sum of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
					[ ] ///Delete the added transfer////
					[ ] DeleteTransaction(sMDIWindow,sPayee)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmount} is NOT the sum of the openning balance :{nAmountTotal} and transfer amount: {nAmount1}")
			[+] else
				[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] ////############# TA2390-Transfer when Register is a document window - Checking#######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC19_VerifyTransferFromSavingsToCheckingDocumentWindowMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Transfer From Savings to Checking  accont in Document Window Mode
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	       If Transfer From Savings to Checking accont in Document Window Mode verification is successful
		[ ] //						Fail		       If Transfer From Savings to Checking accont in Document Window Mode verification is unsuccessful
		[ ] // 
		[ ] //REVISION HISTORY:  21/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC19_VerifyTransferFromSavingsToCheckingDocumentWindowMode() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] CheckNumReordKeys rCheckNumReord
		[ ] rCheckNumReord=lsCheckNumReordValue
		[ ] ////Read first row from sRegTransactionSheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] 
		[ ] ////Read first row from sRegAccountWorksheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[6]
		[ ] /////Account Balance in data sheet////
		[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
		[ ] ///Transaction amount///
		[ ] nAmount1=Val(StrTran(lsTransaction[3],",",""))
		[ ] sPayee="FromSavings" +lsTransaction[6]
		[ ] STRING sTransferAccount
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[+] QuickenWindow.SetActive()
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ////####Verify Ending Balance after adding the tranaction with check no.#####//
				[ ] 
				[ ] MDIClient.AccountRegister.SearchWindow.SetText(sPayee)
				[ ] // // search and delete the transaction if exists///
				[ ] sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
				[ ] iNum=val(sTransactionCount)
				[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
				[+] if(iNum==1)
					[ ] DeleteTransaction(sMDIWindow,sPayee)
				[ ] ///##########Verify Transfer Transction in From account########////
				[ ] 
				[ ] ///Amount difference after adding the transaction///  
				[ ] nAmountDifferenceExpected=nAmountTotal - nAmount1
				[ ] ///Get the Account balance///
				[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
				[ ] nAmount=Val(StrTran(sAmount,",",""))
				[ ] ////Add the transaction with check number////
				[+] if (nAmountTotal==nAmount)
					[ ] lsAddAccount=lsExcelData[5]
					[ ] sTransferAccount=lsAddAccount[2]
					[ ] iResult=AddSavingCreditCashTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,sPayee,lsTransaction[7],sTransferAccount)
					[+] if (iResult==PASS)
						[ ] ///Get the Account balance after adding the transaction///
						[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
						[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
						[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmountDifferenceActual} is the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
						[+] else
							[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmountDifferenceActual} is NOT the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
					[ ] 
				[ ] 
				[ ] ///##########Verify Transfer Transction in To account########////
				[ ] ///Fetch the account balance for the savings account ///
				[ ] lsAddAccount=lsExcelData[5]
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] MDIClient.AccountRegister.SearchWindow.SetText(sPayee)
					[ ] nAmountTotal=0
					[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
					[ ] ///Amount difference after adding the transaction///  
					[ ] 
					[ ] nAmountDifferenceExpected=nAmountTotal + nAmount1
					[ ] ///Get the Account balance///
					[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
					[ ] nAmount=Val(StrTran(sAmount,",",""))
					[ ] ////Add the transaction with check number////
					[+] if (nAmountDifferenceExpected==nAmount)
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmount} is the sum of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
						[ ] ///Delete the added transfer////
						[ ] DeleteTransaction(sMDIWindow,sPayee)
					[+] else
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmount} is NOT the sum of the openning balance :{nAmountTotal} and transfer amount: {nAmount1}")
					[ ] 
					[ ] MDIClient.AccountRegister.SearchWindow.SetText("")
				[+] else
					[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] ////############# Transfer when Register is a PopUp window - Checking#######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC20_VerifyTransferFromCheckingToSavingsPopUpWindowMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Transfer From Checking accont in PopUp Window Mode
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	       If Transfer From Checking to savings accont in PopUp Window Mode verification is successful
		[ ] //						Fail		       If Transfer From Checking  to savings accont in PopUp Window Mode verification is unsuccessful
		[ ] // 
		[ ] //REVISION HISTORY:  21/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC20_VerifyTransferFromCheckingToSavingsPopUpWindowMode() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] CheckNumReordKeys rCheckNumReord
		[ ] rCheckNumReord=lsCheckNumReordValue
		[ ] ////Read first row from sRegTransactionSheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] 
		[ ] ////Read first row from sRegAccountWorksheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] /////Account Balance in data sheet////
		[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
		[ ] ///Transaction amount///
		[ ] nAmount1=Val(StrTran(lsTransaction[3],",",""))
		[ ] sPayee="TXFR" +lsTransaction[6]
		[ ] STRING sTransferAccount
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////popup register is made off just to make base state by searching and deleting the transaction here rest process////
		[ ] //////will be executed in Poup mode////
		[ ] UsePopupRegister("OFF")
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] ////####Verify Ending Balance after adding the tranaction with check no.#####//
			[ ] 
			[ ] MDIClient.AccountRegister.SearchWindow.SetText(sPayee)
			[ ] // // search and delete the transaction if exists///
			[ ] sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
			[ ] iNum=val(sTransactionCount)
			[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
			[+] if(iNum==1)
				[ ] DeleteTransaction(sMDIWindow,sPayee)
			[ ] ///##########Verify Transfer Transction in From account########////
			[ ] 
			[ ] ///Amount difference after adding the transaction///  
			[ ] nAmountDifferenceExpected=nAmountTotal - nAmount1
			[ ] ///Get the Account balance///
			[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
			[ ] nAmount=Val(StrTran(sAmount,",",""))
			[ ] ////Add the transaction with check number////
			[+] if (nAmountTotal==nAmount)
				[ ] lsAddAccount=lsExcelData[6]
				[ ] sTransferAccount=lsAddAccount[2]
				[ ] iResult=AddCheckingTransaction(sPopUpWindow,lsTransaction[2],lsTransaction[3],sDateStamp,rCheckNumReord.sTransfer,sPayee,lsTransaction[7],sTransferAccount)
				[+] if (iResult==PASS)
					[ ] ///Get the Account balance after adding the transaction///
					[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
					[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
					[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmountDifferenceActual} is the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
					[+] else
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmountDifferenceActual} is NOT the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
					[ ] 
					[+] if (BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.TypeKeys(KEY_EXIT)
						[ ] WaitForState(BankingPopUp,False,1)
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
				[ ] 
			[ ] 
			[ ] ///##########Verify Transfer Transction in To account########////
			[ ] ///Fetch the account balance for the savings account ///
			[ ] lsAddAccount=lsExcelData[6]
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] 
				[ ] nAmountTotal=0
				[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
				[ ] ///Amount difference after adding the transaction///  
				[ ] 
				[ ] nAmountDifferenceExpected=nAmountTotal + nAmount1
				[ ] ///Get the Account balance///
				[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
				[ ] nAmount=Val(StrTran(sAmount,",",""))
				[ ] BankingPopUp.SearchWindow.SetText("")
				[ ] 
				[ ] ////Add the transaction with check number////
				[+] if (nAmountDifferenceExpected==nAmount)
					[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmount} is the sum of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmount} is NOT the sum of the openning balance :{nAmountTotal} and transfer amount: {nAmount1}")
				[ ] 
				[+] if (BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.TypeKeys(KEY_EXIT)
					[ ] WaitForState(BankingPopUp,False,1)
				[ ] //Delete the added transaction if ttransaction delete fails it can impcat other testcases
				[ ] iResult=UsePopupRegister("OFF")	
				[+] if (iResult==PASS)
					[ ] iResult =SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[+] if (iResult==PASS)
						[ ] sleep(1)
						[ ] DeleteTransaction(sMDIWindow,sPayee)
					[+] else
						[ ] ReportStatus("Verify  {lsAddAccount[2]}  Account", FAIL, " {lsAddAccount[2]} couldn't be selected.")
				[+] else
					[ ] ReportStatus("Verify Popup Register mode is ON", FAIL, "Popup Register mode couldn't be set OFF.") 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] ////############# Transfer when Register is a PopUp window - Checking#######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC21_VerifyTransferFromSavingsToCheckingPopUpWindowMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Transfer From Savings to Checking  accont in PopUp Window Mode
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	       If Transfer From Savings to Checking accont in Document PopUp Mode verification is successful
		[ ] //						Fail		       If Transfer From Savings to Checking accont in Document PopUp Mode verification is unsuccessful
		[ ] // 
		[ ] //REVISION HISTORY:  21/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC21_VerifyTransferFromSavingsToCheckingPopUpWindowMode() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] CheckNumReordKeys rCheckNumReord
		[ ] rCheckNumReord=lsCheckNumReordValue
		[ ] ////Read first row from sRegTransactionSheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] 
		[ ] ////Read first row from sRegAccountWorksheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[6]
		[ ] /////Account Balance in data sheet////
		[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
		[ ] ///Transaction amount///
		[ ] nAmount1=Val(StrTran(lsTransaction[3],",",""))
		[ ] sPayee="FromSavings" +lsTransaction[6]
		[ ] STRING sTransferAccount
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////popup register is made off just to make base state by searching and deletin the transaction here rest process////
		[ ] //////will be executed in Poup mode////
		[ ] UsePopupRegister("OFF")
		[ ] 
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] ////####Verify Ending Balance after adding the tranaction with check no.#####//
			[ ] 
			[ ] MDIClient.AccountRegister.SearchWindow.SetText(sPayee)
			[ ] // // search and delete the transaction if exists///
			[ ] sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
			[ ] iNum=val(sTransactionCount)
			[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
			[+] if(iNum==1)
				[ ] DeleteTransaction(sMDIWindow,sPayee)
			[ ] ///##########Verify Transfer Transction in From account########////
			[ ] 
			[ ] ///Amount difference after adding the transaction///  
			[ ] nAmountDifferenceExpected=nAmountTotal - nAmount1
			[ ] ///Get the Account balance///
			[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
			[ ] nAmount=Val(StrTran(sAmount,",",""))
			[ ] ////Add the transaction with check number////
			[+] if (nAmountTotal==nAmount)
				[ ] lsAddAccount=lsExcelData[5]
				[ ] sTransferAccount=lsAddAccount[2]
				[ ] iResult=AddSavingCreditCashTransaction(sPopUpWindow,lsTransaction[2],lsTransaction[3],sDateStamp,sPayee,lsTransaction[7],sTransferAccount)
				[+] if (iResult==PASS)
					[ ] ///Get the Account balance after adding the transaction///
					[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
					[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
					[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmountDifferenceActual} is the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
					[+] else
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmountDifferenceActual} is NOT the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
				[ ] ///Close the Banking PopUp///
				[+] if (BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.TypeKeys(KEY_EXIT)
					[ ] WaitForState(BankingPopUp,False,1)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
				[ ] 
			[ ] 
			[ ] ///##########Verify Transfer Transction in To account########////
			[ ] ///Fetch the account balance for the Checking account ///
			[ ] lsAddAccount=lsExcelData[5]
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] nAmountTotal=0
				[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
				[ ] ///Amount difference after adding the transaction///  
				[ ] 
				[ ] nAmountDifferenceExpected=nAmountTotal + nAmount1
				[ ] ///Get the Account balance///
				[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
				[ ] nAmount=Val(StrTran(sAmount,",",""))
				[ ] ////Add the transaction with check number////
				[+] if (nAmountDifferenceExpected==nAmount)
					[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmount} is the sum of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
				[+] else
					[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmount} is NOT the sum of the openning balance :{nAmountTotal} and transfer amount: {nAmount1}")
				[ ] //Close the BankingPopUp//
				[+] if (BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.TypeKeys(KEY_EXIT)
					[ ] WaitForState(BankingPopUp,False,1)
				[ ] //Delete the added transaction if ttransaction delete fails it can impcat other testcases
				[ ] iResult=UsePopupRegister("OFF")	
				[+] if (iResult==PASS)
					[ ] iResult =SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[+] if (iResult==PASS)
						[ ] sleep(1)
						[ ] DeleteTransaction(sMDIWindow,sPayee)
					[+] else
						[ ] ReportStatus("Verify  {lsAddAccount[2]}  Account", FAIL, " {lsAddAccount[2]} couldn't be selected.")
				[+] else
					[ ] ReportStatus("Verify Popup Register mode is ON", FAIL, "Popup Register mode couldn't be set OFF.") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] ////############# Transfer when Register is a PopUp window - Checking#######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC22_VerifyEditDeleteTransferFromCheckingToSavingsPopUpWindowMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Transfer From Checking to Savings accont in PopUp Window Mode
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	       If Edit Transfer From Checking to savings accont in PopUp Window Mode verification is successful
		[ ] //						Fail		       If Edit Transfer From Checking  to savings accont in PopUp Window Mode verification is unsuccessful
		[ ] // 
		[ ] //REVISION HISTORY:  25/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC22_VerifyEditDeleteTransferFromCheckingToSavingsPopUpWindowMode() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] CheckNumReordKeys rCheckNumReord
		[ ] rCheckNumReord=lsCheckNumReordValue
		[ ] STRING sEditTransactionsAction="Edit transaction(s)"
		[ ] 
		[ ] ////Read first row from sRegTransactionSheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] 
		[ ] ////Read first row from sRegAccountWorksheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] /////Account Balance in data sheet////
		[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
		[ ] ///Transaction amount///
		[ ] nAmount1=Val(StrTran(lsTransaction[3],",",""))
		[ ] sPayee="TXFR" +lsTransaction[6]
		[ ] STRING sTransferAccount
		[ ] sValidationText="Current Balance"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ///Select Classic menu option///
		[ ] SetViewMode(VIEW_CLASSIC_MENU)
		[ ] ////popup register is made off just to make base state by searching and deletin the transaction here rest process////
		[ ] //////will be executed in Poup mode////
		[ ] UsePopupRegister("OFF")
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] ////####Verify Ending Balance after adding the tranaction with check no.#####//
			[ ] 
			[ ] MDIClient.AccountRegister.SearchWindow.SetText(sPayee)
			[ ] // // search and delete the transaction if exists///
			[ ] sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
			[ ] iNum=val(sTransactionCount)
			[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
			[+] if(iNum==1)
				[ ] DeleteTransaction(sMDIWindow,sPayee)
			[ ] ///##########Verify Transfer Transction in From account########////
			[ ] 
			[ ] ///Amount difference after adding the transaction///  
			[ ] nAmountDifferenceExpected=nAmountTotal - nAmount1
			[ ] ///Get the Account balance///
			[ ] sAmount=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
			[ ] nAmount=Val(StrTran(sAmount,",",""))
			[ ] ////Add the transaction with check number////
			[+] if (nAmountTotal==nAmount)
				[ ] lsAddAccount=lsExcelData[6]
				[ ] sTransferAccount=lsAddAccount[2]
				[ ] iResult=AddCheckingTransaction(sPopUpWindow,lsTransaction[2],lsTransaction[3],sDateStamp,rCheckNumReord.sTransfer,sPayee,lsTransaction[7],sTransferAccount)
				[+] if (iResult==PASS)
					[ ] ///Get the Account balance after adding the transaction///
					[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
					[ ] nAmountDifferenceActual=Val(StrTran(sAmount,",",""))
					[+] if (nAmountDifferenceActual==nAmountDifferenceExpected)
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmountDifferenceActual} is the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
					[+] else
						[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmountDifferenceActual} is NOT the difference of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
					[ ] 
					[+] if (BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.TypeKeys(KEY_EXIT)
						[ ] WaitForState(BankingPopUp,False,1)
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify account balance of account added", FAIL, "Verify account balance for account added: Account balance of {lsAddAccount[2]} is {nAmountTotal} not as expected {nAmount1} .") 
				[ ] 
			[ ] 
			[ ] ///##########Verify Transfer Transction in To account########////
			[ ] ///Fetch the account balance for the savings account ///
			[ ] lsAddAccount=lsExcelData[6]
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] 
				[ ] nAmountTotal=0
				[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
				[ ] ///Amount difference after adding the transaction///  
				[ ] 
				[ ] nAmountDifferenceExpected=nAmountTotal + nAmount1
				[ ] ///Get the Account balance///
				[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
				[ ] nAmount=Val(StrTran(sAmount,",",""))
				[ ] ////Add the transaction with check number////
				[+] if (nAmountDifferenceExpected==nAmount)
					[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmount} is the sum of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
				[+] else
					[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance  {nAmount} is NOT the sum of the openning balance :{nAmountTotal} and transfer amount: {nAmount1}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
			[ ] 
			[ ] ///##########Modify the transfer amount########////
			[ ] 
			[+] if (BankingPopUp.Exists(5))
				[ ] BankingPopUp.SetActive()
				[ ] 
				[ ] iVerify=AccountActionsOnTransaction(sPopUpWindow,sPayee,sEditTransactionsAction)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Edit Transaction", PASS, "{sEditTransactionsAction} Action successful") 
					[ ] 
					[ ] //Verify if Find and replace window is opened
					[+] if(DlgFindAndReplace.Exists(5))
						[ ] DlgFindAndReplace.SetActive()
						[ ] ReportStatus("Verify Edit Transaction", PASS, "Find and Replace window opened") 
						[ ] 
						[ ] sMenuItem="Amount"
						[ ] sExpected="10.45"
						[ ] nAmount2=Val(StrTran(sExpected,",",""))
						[ ] // DlgFindAndReplace.SearchTextField.SetText(sPayee)
						[ ] // DlgFindAndReplace.FindButton.Click()
						[ ] DlgFindAndReplace.SelectAllButton.Click()
						[ ] DlgFindAndReplace.ReplacePopupList.Select(sMenuItem)
						[ ] DlgFindAndReplace.ReplacementTextField.ClearText()
						[ ] DlgFindAndReplace.ReplacementTextField.SetText(sExpected)
						[ ] DlgFindAndReplace.SetActive()
						[ ] // DlgFindAndReplace.Click()
						[ ] DlgFindAndReplace.ReplaceAllButton.Click()
						[ ] WaitForState(DlgFindAndReplace,True,1)
						[ ] DlgFindAndReplace.DoneButton.Click()
						[ ] WaitForState(DlgFindAndReplace,False,1)
						[ ] 
						[ ] //Verify Transfer has been modified in To account////
						[ ] lsAddAccount=lsExcelData[5]
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.SearchWindow.SetText(sExpected)
						[ ] // // search and delete the transaction if exists///
						[ ] sTransactionCount  = BankingPopUp.EndingBalance.OnlineBalance.GetText()
						[ ] iNum=val(sTransactionCount)
						[+] if (iNum==1)
							[ ] ReportStatus("Verify Edit transfer transaction.", PASS, "Verify Edit transfer transaction.: Transfer with payee {sPayee}'s amount has been updated to {sExpected} in the To account {lsAddAccount} ") 
							[ ] BankingPopUp.SearchWindow.ClearText()
							[ ] 
							[ ] ////Verify Account overview for Savings Account///
							[ ] nAmountDifferenceExpected=nAmountTotal + nAmount2
							[ ] ///Get the Account balance///
							[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
							[ ] nAmount=Val(StrTran(sAmount,",",""))
							[ ] 
							[ ] ////Add the transaction with check number////
							[+] if (nAmountDifferenceExpected==nAmount)
								[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmount} is the sum of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
								[ ] 
								[ ] ////Verify Account overview for Savings Account///
								[ ] NavigateToAccountActionBanking(9,sPopUpWindow)
								[ ] 
								[+] if (DlgAccountOverview.Exists(4))
									[ ] DlgAccountOverview.SetActive()
									[ ] 
									[ ] hWnd=Str(DlgAccountOverview.ListBox1.GetHandle())
									[+] for (iCounter=0;iCounter<DlgAccountOverview.ListBox1.GetItemCount(); ++iCounter)
										[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, Str(iCounter))
										[ ] bMatch = MatchStr("*{sValidationText}*{sAmount}*",sActual)
										[+] if (bMatch==TRUE)
											[ ] break
									[+] if (bMatch)
										[ ] ReportStatus("Verify modified transfer amount on Savings Account Overview", PASS, "Verify modified transfer amount on Savings Account Overview: Amount {sActual} displayed as expected {sAmount} for {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify modified transfer amount on Savings Account Overview", FAIL, "Verify modified transfer amount on Savings Account Overview: Amount {sActual} didn't display as expected {sAmount} for {sValidationText}.")
									[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
									[ ] WaitForState(DlgAccountOverview,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
								[ ] 
								[ ] ///Close the To account register///
								[+] if (BankingPopUp.Exists(5))
									[ ] BankingPopUp.SetActive()
									[ ] BankingPopUp.TypeKeys(KEY_EXIT)
									[ ] WaitForState(BankingPopUp,False,1)
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance after adding the Transfer tranaction: Ending Balance {nAmount} is NOT the sum of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
								[ ] 
							[ ] 
							[ ] ////Verify Account overview for Checking Account///
							[ ] lsAddAccount=lsExcelData[5]
							[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
							[ ] nAmountDifferenceExpected=nAmountTotal - nAmount2
							[ ] ///Get the Account balance///
							[ ] 
							[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
							[+] if(iVerify==PASS)
								[ ] 
								[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
								[ ] nAmount=Val(StrTran(sAmount,",",""))
								[ ] 
								[ ] ////Add the transaction with check number////
								[+] if (nAmountDifferenceExpected==nAmount)
									[ ] ReportStatus("Verify Ending Balance after adding the tranaction",PASS,"Verify Ending Balance of {lsAddAccount[2]} after adding the Transfer tranaction: Ending Balance {nAmount} is the sum of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
									[ ] 
									[ ] ////Verify Account overview for Checking Account///
									[ ] // BankingPopUp.TypeKeys(KEY_CTRL_SHIFT_O)
									[ ] NavigateToAccountActionBanking(9,sPopUpWindow)
									[ ] 
									[+] if (DlgAccountOverview.Exists(4))
										[ ] DlgAccountOverview.SetActive()
										[ ] 
										[ ] hWnd=Str(DlgAccountOverview.ListBox1.GetHandle())
										[+] for (iCounter=0;iCounter<DlgAccountOverview.ListBox1.GetItemCount(); ++iCounter)
											[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, Str(iCounter))
											[ ] bMatch = MatchStr("*{sValidationText}*{sAmount}*",sActual)
											[+] if (bMatch==TRUE)
												[ ] break
										[+] if (bMatch)
											[ ] ReportStatus("Verify modified transfer amount on Checking Account Overview", PASS, "Verify modified transfer amount on {lsAddAccount[2]} - Account Overview: Amount {sActual} displayed as expected {sAmount} for {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify modified transfer amount on Checking Account Overview", FAIL, "Verify modified transfer amount on {lsAddAccount[2]} - Account Overview: Amount {sActual} didn't display as expected {sAmount} for {sValidationText}.")
										[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
										[ ] WaitForState(DlgAccountOverview,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
									[ ] 
									[ ] 
									[+] if (BankingPopUp.Exists(5))
										[ ] BankingPopUp.SetActive()
										[ ] /////Now delete the created transfer////
										[ ] // DeleteTransaction(sPopUpWindow,sPayee)       // Defect - Ctrl - d is not working for Popup
										[ ] SelectTransactionAction(sPopUpWindow,sPayee,"Delete")
										[ ] 
										[ ] ////Verify Account overview from Checking Account///
										[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
										[+] if(iVerify==PASS)
											[ ] BankingPopUp.SetActive()
											[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
											[ ] nAmount=Val(StrTran(sAmount,",",""))
											[ ] ////Add the transaction with check number////
											[+] if (nAmountTotal==nAmount)
												[ ] NavigateToAccountActionBanking(9,sPopUpWindow)
												[+] if (DlgAccountOverview.Exists(4))
													[ ] DlgAccountOverview.SetActive()
													[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
													[ ] hWnd=Str(DlgAccountOverview.ListBox1.GetHandle())
													[+] for (iCounter=0;iCounter<DlgAccountOverview.ListBox1.GetItemCount(); ++iCounter)
														[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, Str(iCounter))
														[ ] bMatch = MatchStr("*{sValidationText}*{sAmount}*",sActual)
														[+] if (bMatch==TRUE)
															[ ] break
													[+] if (bMatch)
														[ ] ReportStatus("Verify account balance.", PASS, "Verify account balance of account after deleting the transfer with amount {nAmount2} }.: Account balance of {lsAddAccount[2]} is {sAmount}  as expected {nAmountTotal} after deleting the transfer with amount {nAmount2} .") 
													[+] else
														[ ] ReportStatus("Verify account balance.", FAIL, "Verify account balance of account after deleting the transfer with amount {nAmount2} }.: Account balance of {lsAddAccount[2]} is {sAmount} not as expected {nAmountTotal} after deleting the transfer with amount {nAmount2} .") 
													[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
													[ ] WaitForState(DlgAccountOverview,FALSE,1)
												[+] else
													[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
												[ ] 
											[+] else
												[ ] ReportStatus("Verify account balance.", FAIL, "Verify account balance of account after deleting the transfer with amount {nAmount2} }.: Account balance of {lsAddAccount[2]} is {sAmount} not as expected {nAmountTotal} after deleting the transfer with amount {nAmount2} .") 
											[ ] ///Close the From Checking account register///
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.TypeKeys(KEY_EXIT)
											[ ] WaitForState(BankingPopUp,False,1)
										[+] else
											[ ] ReportStatus("Verify account pop-up window is displayed.", FAIL, "Verify account pop-up window of {lsAddAccount[2]} doesn't exist.") 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify account pop-up window is displayed.", FAIL, "Verify account pop-up window of {lsAddAccount[2]} doesn't exist.") 
									[ ] 
									[ ] ////Verify savings account and account overview after deleting the transfer transaction////
									[ ] lsAddAccount=lsExcelData[6]
									[ ] nAmountTotal=Val(StrTran(lsAddAccount[3],",",""))
									[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
									[+] if(iVerify==PASS)
										[+] if (BankingPopUp.Exists(5))
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.SetActive()
											[ ] sAmount=BankingPopUp.EndingBalance.OnlineBalance.GetText()
											[ ] nAmount=Val(StrTran(sAmount,",",""))
											[ ] ////Verify savings account pop window's account balance after deleting the transfer transaction///
											[ ] 
											[+] if (nAmountTotal==nAmount)
												[ ] NavigateToAccountActionBanking(9,sPopUpWindow)
												[ ] ////Verify savings account and account overview after deleting the transfer transaction///
												[ ] 
												[+] if (DlgAccountOverview.Exists(4))
													[ ] DlgAccountOverview.SetActive()
													[ ] hWnd=Str(DlgAccountOverview.ListBox1.GetHandle())
													[+] for (iCounter=0;iCounter<DlgAccountOverview.ListBox1.GetItemCount(); ++iCounter)
														[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, Str(iCounter))
														[ ] bMatch = MatchStr("*{sValidationText}*{sAmount}*",sActual)
														[+] if (bMatch==TRUE)
															[ ] break
													[+] if (bMatch)
														[ ] ReportStatus("Verify account balance.", PASS, "Verify account balance of account after deleting the transfer with amount {nAmount2} }.: Account balance of {lsAddAccount[2]} is {sAmount}  as expected {nAmountTotal} after deleting the transfer with amount {nAmount2} .") 
													[+] else
														[ ] ReportStatus("Verify account balance.", FAIL, "Verify account balance of account after deleting the transfer with amount {nAmount2} }.: Account balance of {lsAddAccount[2]} is {sAmount} not as expected {nAmountTotal} after deleting the transfer with amount {nAmount2} .") 
													[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
													[ ] WaitForState(DlgAccountOverview,FALSE,1)
												[+] else
													[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
												[ ] 
											[+] else
												[ ] ReportStatus("Verify account balance.", FAIL, "Verify account balance of account after deleting the transfer with amount {nAmount2} }.: Account balance of {lsAddAccount[2]} is {sAmount} not as expected {nAmountTotal} after deleting the transfer with amount {nAmount2} .") 
											[ ] ///Close the To savings account register///
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.TypeKeys(KEY_EXIT)
											[ ] WaitForState(BankingPopUp,False,1)
										[+] else
											[ ] ReportStatus("Verify account pop-up window is displayed.", FAIL, "Verify account pop-up window of {lsAddAccount[2]} doesn't exist.") 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
										[ ] 
								[+] else
									[ ] ReportStatus("Verify Ending Balance after adding the tranaction",FAIL,"Verify Ending Balance of {lsAddAccount[2]} after adding the Transfer tranaction: Ending Balance {nAmount} is NOT the sum of the openning balance :{nAmountTotal}  and transfer amount: {nAmount1}")
							[+] else
								[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Edit transfer transaction.", FAIL, "Verify Edit transfer transaction.: Transfer with payee {sPayee}'s amount couldn't be updated to {sExpected} in the To account {lsAddAccount} ") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify dialog Find And Replace", FAIL, "Verify dialog Find And Replace: Dialog Find And Replace doesn't exist.") 
				[+] else
					[ ] ReportStatus("Verify Edit Transaction", FAIL, "{sEditTransactionsAction} Action couldn't be performed.") 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify account pop-up window is displayed.", FAIL, "Verify account pop-up window doesn't exist.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify account selected", FAIL, "Verify account selected: {lsAddAccount[2]} Account couldn't be selected.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] ////############# Verify Account Actions menu contents available in Business Account(Accounts Payable)##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_VerifyRegisterAccountActionsForCustomerInvoiceAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Register Business Account Actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If register account actions verification is successful						
		[ ] //						Fail			If register account actions verification is unsuccessful		
		[ ] // 
		[ ] //REVISION HISTORY:  28/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test23_VerifyRegisterAccountActionsForCustomerInvoiceAccount() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountName
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegBusinessTransaction)
		[ ] lsTransactionData=lsExcelData[1]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] ////Fetch the Customer Invoice Account row from datasheet///
		[ ] lsAddAccount=lsExcelData[13]
		[ ] sAccountName=lsAddAccount[2]
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sRegFileName)
		[+] if (iVerify == PASS)
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sAccountName} selected successfully")
				[ ] QuickenWindow.SetActive ()
				[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
				[+] if (iSwitchState==PASS)
					[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Turn on Pop up register mode")
					[ ] 
					[+] if(BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Maximize()
						[+] if (AccountActionsPopUpButton.Exists(5))
							[ ] ReportStatus("Verify Account Actions button", PASS, "Verify Account Actions button: Account Actions button displayed.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> Edit Account Details#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Account Details" 
								[ ] NavigateToAccountActionBanking(2, sPopUpWindow)
								[+] if (AccountDetails.Exists(4))
									[ ] AccountDetails.SetActive()
									[ ] sActual=AccountDetails.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customer Invoices Account Actions> Edit Account Details", PASS, "Verify Customer Invoices Account Actions> Edit Account Details option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else 
										[ ] ReportStatus("Verify Customer Invoices Account Actions> Edit Account Details", FAIL, "Verify Customer Invoices Account Actions> Edit Account Details option: Dialog {sValidationText} didn't display.")
									[ ] AccountDetails.Cancel.Click()
									[ ] WaitForState(AccountDetails,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Account Details", FAIL, "Verify Dialog Account Details:  Account Details dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> New Customer Invoice#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Invoice - " + sAccountName
								[ ] NavigateToAccountActionBanking(3, sPopUpWindow)
								[+] if (DlgInvoice.Exists(4))
									[ ] DlgInvoice.SetActive()
									[ ] sActual=DlgInvoice.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Invoice", PASS, "Verify Customer Invoices Account Actions> New Customer Invoice option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Invoice", FAIL, "Verify Customer Invoices Account Actions>New Customer Invoice option: Dialog {sValidationText} didn't display.")
									[ ] DlgInvoice.CancelButton.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
									[ ] 
									[ ] WaitForState(DlgInvoice,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> New Customer Payment#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Payment - "  + sAccountName
								[ ] NavigateToAccountActionBanking(4, sPopUpWindow)
								[+] if (DlgPaymentInvoices.Exists(4))
									[ ] DlgPaymentInvoices.SetActive()
									[ ] sActual=DlgPaymentInvoices.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Payment", PASS, "Verify Customer Invoices Account Actions> New Customer Payment option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Payment", FAIL, "Verify Customer Invoices Account Actions>New Customer Payment option: Dialog {sValidationText} didn't display.")
									[ ] DlgPaymentInvoices.CancelButton.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
									[ ] 
									[ ] WaitForState(DlgPaymentInvoices,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify New Customer Payment", FAIL, "Verify Dialog New Customer Payment: New Customer Payment dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> New Credit#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Credit - "  + sAccountName
								[ ] NavigateToAccountActionBanking(5, sPopUpWindow)
								[+] for (iCounter=1;iCounter<6;++iCounter)
									[ ] BankingPopUp.TypeKeys(KEY_DN)
								[ ] BankingPopUp.TypeKeys(KEY_ENTER)
								[+] if (DlgCreditInvoices.Exists(4))
									[ ] DlgCreditInvoices.SetActive()
									[ ] sActual=DlgCreditInvoices.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Credit", PASS, "Verify Customer Invoices Account Actions> New Credit option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Credit", FAIL, "Verify Customer Invoices Account Actions>New Credit option: Dialog {sValidationText} didn't display.")
									[ ] DlgCreditInvoices.CancelButton.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
									[ ] 
									[ ] WaitForState(DlgCreditInvoices,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify New Credit", FAIL, "Verify Dialog New Credit: New Credit dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> New Refund#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Refund - "  + sAccountName
								[ ] NavigateToAccountActionBanking(6, sPopUpWindow)
								[+] for (iCounter=1;iCounter<7;++iCounter)
									[ ] BankingPopUp.TypeKeys(KEY_DN)
								[ ] BankingPopUp.TypeKeys(KEY_ENTER)
								[+] if (DlgRefund.Exists(4))
									[ ] DlgRefund.SetActive()
									[ ] sActual=DlgRefund.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Refund", PASS, "Verify Customer Invoices Account Actions> New Refund option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Refund", FAIL, "Verify Customer Invoices Account Actions>New Refund option: Dialog {sValidationText} didn't display.")
									[ ] DlgRefund.CancelButton.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
									[ ] 
									[ ] WaitForState(DlgRefund,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify New Refund", FAIL, "Verify Dialog New Refund: New Refund dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> New Finance Charge#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Create Finance Charge"
								[ ] NavigateToAccountActionBanking(7, sPopUpWindow)
								[+] if (DlgCreateFinanceCharge.Exists(4))
									[ ] DlgCreateFinanceCharge.SetActive()
									[ ] sActual=DlgCreateFinanceCharge.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Finance Charge", PASS, "Verify Customer Invoices Account Actions> New Finance Charge option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Customer Invoices Account Actions> New Finance Charge", FAIL, "Verify Customer Invoices Account Actions>New Finance Charge option: Dialog {sValidationText} didn't display.")
									[ ] DlgCreateFinanceCharge.CancelButton.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
									[ ] 
									[ ] WaitForState(DlgCreateFinanceCharge,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Create Finance Charge", FAIL, "Verify Dialog Create Finance Charge: Create Finance Charge dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> Account Attachments #####////  
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Account Attachments: {lsAddAccount[2]}"
								[ ] NavigateToAccountActionBanking(9, sPopUpWindow)
								[+] if (DlgAccountAttachments.Exists(4))
									[ ] DlgAccountAttachments.SetActive()
									[ ] sActual=DlgAccountAttachments.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Account Attachments", PASS, "Verify Customer Invoices Account Actions> Account Attachments option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Account Attachments", FAIL, "Verify Customer Invoices Account Actions> Account Attachments option: Dialog {sValidationText} didn't display.")
									[ ] DlgAccountAttachments.DoneButton.Click()
									[ ] WaitForState(DlgAccountAttachments,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Attachments : Account Attachments Dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> Account Overview #####////  
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Account Overview: {sAccountName}"
								[ ] NavigateToAccountActionBanking(10, sPopUpWindow)
								[+] if (DlgAccountOverview.Exists(4))
									[ ] DlgAccountOverview.SetActive()
									[ ] sActual=DlgAccountOverview.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Account Overview", PASS, "Verify Customer Invoices Account Actions> Account Overview option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Account Overview", FAIL, "Verify Customer Invoices Account Actions> Account Overview option: Dialog {sValidationText} didn't display.")
									[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
									[ ] WaitForState(DlgAccountOverview,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
							[ ] 
							[+] // ///##########Verifying Customer Invoices Account Actions> Print Transactions#####////  
								[ ] // 
								[ ] // 
								[ ] // BankingPopUp.SetActive()
								[ ] // sValidationText=NULL
								[ ] // sActual=NULL
								[ ] // sValidationText="Print Register"
								[ ] // NavigateToAccountActionBanking(12, sPopUpWindow)
								[+] // if (PrintRegister.Exists(4))
									[ ] // PrintRegister.SetActive()
									[ ] // sActual=PrintRegister.GetProperty("Caption")
									[+] // if (sActual==sValidationText)
										[ ] // ReportStatus("Verify Print Transactions", PASS, "Verify Customer Invoices Account Actions> Print Transactions option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] // else
										[ ] // ReportStatus("Verify Print Transactions", FAIL, "Verify Customer Invoices Account Actions> Print Transactions option: Dialog {sValidationText} didn't display.")
									[ ] // PrintRegister.CancelButton.Click()
									[ ] // WaitForState(PrintRegister,FALSE,1)
								[+] // else
									[ ] // ReportStatus("Verify Print Register", FAIL, "Verify Dialog Print Register : Print RegisterDialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> Export to excel compatible file #####////  
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Create Excel compatible file"
								[ ] NavigateToAccountActionBanking(13, sPopUpWindow)
								[+] if (FileName.Exists(5))
									[ ] CreateExcelCompatibleFile=FileName.GetParent()
									[ ] CreateExcelCompatibleFile.SetActive()
									[ ] sActual=CreateExcelCompatibleFile.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Export to excel compatible file", PASS, "Verify Customer Invoices Account Actions> Export to excel compatible file option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Export to excel compatible file", FAIL, "Verify Customer Invoices Account Actions>Export to excel compatible file option: Dialog {sValidationText} didn't display.")
									[ ] CreateExcelCompatibleFile.Close()
									[ ] WaitForState(CreateExcelCompatibleFile,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify CreateExcelCompatibleFile", FAIL, "Verify Dialog CreateExcelCompatibleFile : CreateExcelCompatibleFile Dialog didn't appear.")
								[ ] 
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> Invoice defaults#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Set Invoice Defaults"
								[ ] NavigateToAccountActionBanking(18, sPopUpWindow)
								[+] if (DlgSetInvoiceDefaults.Exists(4))
									[ ] DlgSetInvoiceDefaults.SetActive()
									[ ] sActual=DlgSetInvoiceDefaults.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customer Invoices Account Actions> Invoice Defaults", PASS, "Verify Customer Invoices Account Actions> Invoice Defaults option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Customer Invoices Account Actions> Invoice Defaults", FAIL, "Verify Customer Invoices Account Actions>Invoice Defaults option: Dialog {sValidationText} didn't display.")
									[ ] DlgSetInvoiceDefaults.CancelButton.Click()
									[ ] WaitForState(DlgSetInvoiceDefaults,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Set Invoice Defaults", FAIL, "Verify Dialog Set Invoice Defaults: Set Invoice Defaults dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> Register preferences#####////  
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Preferences"
								[ ] NavigateToAccountActionBanking(20, sPopUpWindow)
								[+] if (Preferences.Exists(4))
									[ ] Preferences.SetActive()
									[ ] sActual=Preferences.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Register preferences", PASS, "Verify Customer Invoices Account Actions>Register preferences option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Register preferences", FAIL, "Verify Customer Invoices Account Actions>Register preferences option: Dialog {sValidationText} didn't display.")
									[ ] Preferences.Cancel.Click()
									[ ] WaitForState(Preferences,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Preferences", FAIL, "Verify Dialog Preferences : Preferences Dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Customer Invoices Account Actions> Customize Action Bar#####////  
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Customize Action Bar"
								[ ] NavigateToAccountActionBanking(21, sPopUpWindow)
								[+] if (DlgCustomizeActionBar.Exists(5))
									[ ] DlgCustomizeActionBar.SetActive()
									[ ] sActual=DlgCustomizeActionBar.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customize Action Bar", PASS, "Verify Customer Invoices Account Actions>Customize Action Bar option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Customer Invoices Account Actions>Customize Action Bar option: Dialog {sValidationText} didn't display.")
									[ ] DlgCustomizeActionBar.DoneButton.Click()
									[ ] WaitForState(DlgCustomizeActionBar,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Dialog Customize Action Bar:  Customize Action Bar Dialog didn't appear.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account Actions button", FAIL, "Verify Account Actions button: Account Actions button doesn't exist'.")
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,2)
						[ ] 
					[+] else
							[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} account coudln't open.")
				[+] else
					[ ] ReportStatus("Verify Pop Up Register", FAIL, "Pop up register mode didn't get enable.")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sAccountName} not selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Register Search Feature Exists ", FAIL, "Data file -  {sFileName} is not Opened")
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] ////############# Verify Account Actions menu contents available in Business Account(Vendor Invoices)##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_VerifyRegisterAccountActionsForCustomerInvoiceAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Register Vendor Invoice Business Account Actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If register account actions for Vendor Invoice verification is successful						
		[ ] //						Fail			If register account actions for Vendor Invoice verification is unsuccessful		
		[ ] // 
		[ ] //REVISION HISTORY:  28/03/ 2013	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test24_VerifyRegisterAccountActionsForVendorInvoiceAccount() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountName
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegBusinessTransaction)
		[ ] lsTransactionData=lsExcelData[1]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] ////Fetch the Vendor Invoice Account row from datasheet///
		[ ] lsAddAccount=lsExcelData[12]
		[ ] sAccountName=lsAddAccount[2]
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sRegFileName)
		[+] if (iVerify == PASS)
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sAccountName} selected successfully")
				[ ] QuickenWindow.SetActive ()
				[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
				[+] if (iSwitchState==PASS)
					[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Turn on Pop up register mode")
					[ ] 
					[+] if(BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Maximize()
						[+] if (AccountActionsPopUpButton.Exists(5))
							[ ] ReportStatus("Verify Account Actions button", PASS, "Verify Account Actions button: Account Actions button displayed.")
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> Edit Account Details#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Account Details" 
								[ ] NavigateToAccountActionBanking(2, sPopUpWindow)
								[+] if (AccountDetails.Exists(4))
									[ ] AccountDetails.SetActive()
									[ ] sActual=AccountDetails.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> Edit Account Details", PASS, "Verify Vendor Invoices Account Actions> Edit Account Details option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> Edit Account Details", FAIL, "Verify Vendor Invoices Account Actions> Edit Account Details option: Dialog {sValidationText} didn't display.")
									[ ] AccountDetails.Cancel.Click()
									[ ] WaitForState(AccountDetails,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Account Details", FAIL, "Verify Dialog Account Details:  Account Details dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> New Vendor Invoice#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Bill - " + sAccountName
								[ ] NavigateToAccountActionBanking(3, sPopUpWindow)
								[+] if (DlgInvoice.Exists(4))
									[ ] DlgInvoice.SetActive()
									[ ] sActual=DlgInvoice.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Customer Invoice", PASS, "Verify Vendor Invoices Account Actions> New Vendor Invoice option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Customer Invoice", FAIL, "Verify Vendor Invoices Account Actions>New Vendor Invoice option: Dialog {sValidationText} didn't display.")
									[ ] DlgInvoice.CancelButton.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
									[ ] 
									[ ] WaitForState(DlgInvoice,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify New Vendor Invoice", FAIL, "Verify Dialog New Vendor Invoice: New Vendor Invoice dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> New Vendor Payment#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Payment - "  + sAccountName
								[ ] NavigateToAccountActionBanking(4, sPopUpWindow)
								[+] if (DlgPaymentInvoices.Exists(4))
									[ ] DlgPaymentInvoices.SetActive()
									[ ] sActual=DlgPaymentInvoices.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Vendor Payment", PASS, "Verify Vendor Invoices Account Actions> New Vendor Payment option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Vendor Payment", FAIL, "Verify Vendor Invoices Account Actions>New Vendor Payment option: Dialog {sValidationText} didn't display.")
									[ ] DlgPaymentInvoices.CancelButton.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
									[ ] 
									[ ] WaitForState(DlgPaymentInvoices,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify New Vendor Payment", FAIL, "Verify Dialog New Vendor Payment: New Vendor Payment dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> New Credit#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Credit - "  + sAccountName
								[ ] NavigateToAccountActionBanking(5, sPopUpWindow)
								[+] if (DlgCreditInvoices.Exists(4))
									[ ] DlgCreditInvoices.SetActive()
									[ ] sActual=DlgCreditInvoices.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Credit", PASS, "Verify Vendor Invoices Account Actions> New Credit option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Credit", FAIL, "Verify Vendor Invoices Account Actions>New Credit option: Dialog {sValidationText} didn't display.")
									[ ] DlgCreditInvoices.CancelButton.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
									[ ] 
									[ ] WaitForState(DlgCreditInvoices,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify New Credit", FAIL, "Verify Dialog New Credit: New Credit dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> New Refund#####////
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText="Refund - "  + sAccountName
								[ ] NavigateToAccountActionBanking(6, sPopUpWindow)
								[+] if (DlgRefund.Exists(4))
									[ ] DlgRefund.SetActive()
									[ ] sActual=DlgRefund.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Refund", PASS, "Verify Vendor Invoices Account Actions> New Refund option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Refund", FAIL, "Verify Vendor Invoices Account Actions>New Refund option: Dialog {sValidationText} didn't display.")
									[ ] DlgRefund.CancelButton.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
									[ ] 
									[ ] WaitForState(DlgRefund,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify New Refund", FAIL, "Verify Dialog New Refund: New Refund dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> Account Attachments #####////  
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Account Attachments: {lsAddAccount[2]}"
								[ ] NavigateToAccountActionBanking(8, sPopUpWindow)
								[+] if (DlgAccountAttachments.Exists(4))
									[ ] DlgAccountAttachments.SetActive()
									[ ] sActual=DlgAccountAttachments.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Account Attachments", PASS, "Verify Vendor Invoices Account Actions> Account Attachments option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Account Attachments", FAIL, "Verify Vendor Invoices Account Actions> Account Attachments option: Dialog {sValidationText} didn't display.")
									[ ] DlgAccountAttachments.DoneButton.Click()
									[ ] WaitForState(DlgAccountAttachments,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Attachments : Account Attachments Dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> Account Overview #####////  
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Account Overview: {sAccountName}"
								[ ] NavigateToAccountActionBanking(9, sPopUpWindow)
								[+] if (DlgAccountOverview.Exists(4))
									[ ] DlgAccountOverview.SetActive()
									[ ] sActual=DlgAccountOverview.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Account Overview", PASS, "Verify Vendor Invoices Account Actions> Account Overview option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Account Overview", FAIL, "Verify Vendor Invoices Account Actions> Account Overview option: Dialog {sValidationText} didn't display.")
									[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
									[ ] WaitForState(DlgAccountOverview,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
							[ ] 
							[+] // ///##########Verifying Vendor Invoices Account Actions> Print Transactions#####////  
								[ ] // 
								[ ] // 
								[ ] // BankingPopUp.SetActive()
								[ ] // BankingPopUp.TypeKeys(KEY_CTRL_SHIFT_N)
								[ ] // sValidationText=NULL
								[ ] // sActual=NULL
								[ ] // sValidationText="Print Register"
								[+] // for (iCounter=1;iCounter<iAccountSpecificCounterValue;++iCounter)
									[ ] // BankingPopUp.TypeKeys(KEY_DN)
								[ ] // BankingPopUp.TypeKeys(KEY_ENTER)
								[+] // if (PrintRegister.Exists(4))
									[ ] // PrintRegister.SetActive()
									[ ] // sActual=PrintRegister.GetProperty("Caption")
									[+] // if (sActual==sValidationText)
										[ ] // ReportStatus("Verify Print Transactions", PASS, "Verify Customer Invoices Account Actions> Print Transactions option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] // else
										[ ] // ReportStatus("Verify Print Transactions", FAIL, "Verify Customer Invoices Account Actions> Print Transactions option: Dialog {sValidationText} didn't display.")
									[ ] // PrintRegister.CancelButton.Click()
									[ ] // WaitForState(PrintRegister,FALSE,1)
								[+] // else
									[ ] // ReportStatus("Verify Print Register", FAIL, "Verify Dialog Print Register : Print RegisterDialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> Export to excel compatible file #####////  
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Create Excel compatible file"
								[ ] NavigateToAccountActionBanking(12, sPopUpWindow)
								[+] if (FileName.Exists(5))
									[ ] CreateExcelCompatibleFile=FileName.GetParent()
									[ ] CreateExcelCompatibleFile.SetActive()
									[ ] sActual=CreateExcelCompatibleFile.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Export to excel compatible file", PASS, "Verify Vendor Invoices Account Actions> Export to excel compatible file option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Export to excel compatible file", FAIL, "Verify Vendor Invoices Account Actions>Export to excel compatible file option: Dialog {sValidationText} didn't display.")
									[ ] CreateExcelCompatibleFile.Close()
									[ ] WaitForState(CreateExcelCompatibleFile,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify CreateExcelCompatibleFile", FAIL, "Verify Dialog CreateExcelCompatibleFile : CreateExcelCompatibleFile Dialog didn't appear.")
								[ ] 
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> Register preferences#####////  
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Preferences"
								[ ] NavigateToAccountActionBanking(18, sPopUpWindow)
								[+] if (Preferences.Exists(4))
									[ ] Preferences.SetActive()
									[ ] sActual=Preferences.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Register preferences", PASS, "Verify Vendor Invoices Account Actions>Register preferences option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Register preferences", FAIL, "Verify Vendor Invoices Account Actions>Register preferences option: Dialog {sValidationText} didn't display.")
									[ ] Preferences.Cancel.Click()
									[ ] WaitForState(Preferences,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Preferences", FAIL, "Verify Dialog Preferences : Preferences Dialog didn't appear.")
							[ ] 
							[+] ///##########Verifying Vendor Invoices Account Actions> Customize Action Bar#####////  
								[ ] 
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Customize Action Bar"
								[ ] NavigateToAccountActionBanking(19, sPopUpWindow)
								[+] if (DlgCustomizeActionBar.Exists(5))
									[ ] DlgCustomizeActionBar.SetActive()
									[ ] sActual=DlgCustomizeActionBar.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Customize Action Bar", PASS, "Verify Vendor Invoices Account Actions>Customize Action Bar option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Vendor Invoices Account Actions>Customize Action Bar option: Dialog {sValidationText} didn't display.")
									[ ] DlgCustomizeActionBar.DoneButton.Click()
									[ ] WaitForState(DlgCustomizeActionBar,FALSE,1)
								[+] else
									[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Dialog Customize Action Bar:  Customize Action Bar Dialog didn't appear.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account Actions button", FAIL, "Verify Account Actions button: Account Actions button doesn't exist'.")
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,2)
						[ ] 
					[+] else
							[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} account coudln't open.")
				[+] else
					[ ] ReportStatus("Verify Pop Up Register", FAIL, "Pop up register mode didn't get enable.")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sAccountName} not selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Register Search Feature Exists ", FAIL, "Data file -  {sFileName} is not Opened")
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test25_VerifyMoreReportsonCustomerInvoiceAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_VerifyMoreReportsonCustomerInvoiceAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify MoreReports on Customer Invoice Account Actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MoreReports verifification on Customer Invoice Account Actions is successful
		[ ] //						Fail			If MoreReports verifification on Customer Invoice Account Actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 29, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test25_VerifyMoreReportsonCustomerInvoiceAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] INTEGER iReportCounter=0
	[ ] 
	[ ] STRING sBudget="TestBudget"
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[13]
	[ ] lsReportNames= {"Register Report","Unpaid Invoices","Banking Summary","Cash Flow Comparison","Cash Flow","Income/Expense Comparison by Category","Itemized Categories","Missing Checks","Current Budget","Historical Budget","Net Worth"}
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Turn on Pop up register mode")
			[ ] /////Create a Budget/////
			[ ] QuickenMainWindow.QWNavigator.Planning.Click ()
			[ ] QuickenMainWindow.QWNavigator.Budgets.Click()
			[ ] WaitForState(QuickenMainWindow,TRUE,1)
			[+] if (!Budget.BudgetActions.Exists(5))
				[ ] GetStartedBrowserWindow.GetStarted.DoubleClick()
				[+] if(CreateANewBudget.Exists(5))
					[ ] CreateANewBudget.SetActive()
					[ ] CreateANewBudget.BudgetName.SetText(sBudget)
					[ ] CreateANewBudget.OK.Click()
					[ ] WaitForState(QuickenMainWindow,TRUE,2)
				[+] else
					[ ] ReportStatus("Verify Create A New Budget dialog.", FAIL, "Verify Create A New Budget dialog: Create A New Budget dialog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Budget", PASS, "Budget already created.")
			[ ] 
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account", PASS, "{lsAddAccount[2]} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[ ] ReportStatus("Verify Customer Invoice Account Actions button", PASS, "Verify  Customer Invoice Account Actions button: Account Actions button displayed.")
						[ ] ///##########Verifying Acount Actions> More Reports#####////
						[ ] iReportCounter=0
						[+] for (iCounter=1; iCounter<12;++iCounter)
							[ ] BankingPopUp.SetActive()
							[ ] AccountActionsPopUpButton.Click(1,52,11)
							[+] for (iCount=1; iCount<12;++iCount)
								[ ] BankingPopUp.TypeKeys(KEY_DN)
							[ ] BankingPopUp.TypeKeys(KEY_RT)
							[+] for  (iCount=1; iCount<iCounter+1;++iCount)
								[+] if (iCount>1)
									[ ] BankingPopUp.TypeKeys(KEY_DN)
							[ ] BankingPopUp.TypeKeys(KEY_ENTER)
							[ ] iReportCounter=iReportCounter+1
							[+] if (iReportCounter==2)
								[+] if (DlgUnpaidInvoices.Exists(5))
									[ ] DlgUnpaidInvoices.SetActive()
									[ ] sActual=DlgUnpaidInvoices.GetProperty("Caption")
									[+] if (sActual==lsReportNames[iCounter])
										[ ] ReportStatus("Verify  Customer Invoice Account Actions> More Reports", PASS, "Verify  Customer Invoice Account Actions> More Reports reports: Report {sActual} is as expected {lsReportNames[iCounter]} .")
									[+] else
										[ ] ReportStatus("Verify  Customer Invoice Account Actions> More Reports", FAIL, "Verify  Customer Invoice Account Actions> More Reports reports: Report {sActual} is  Not as expected {lsReportNames[iCounter]} .")
									[ ] DlgUnpaidInvoices.SetActive()
									[ ] DlgUnpaidInvoices.TypeKeys(KEY_EXIT)
									[ ] WaitForState(DlgUnpaidInvoices,False,1)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify  Customer Invoice Account Actions> More Reports", FAIL, "Verify  Customer Invoice Account Actions> More Reports reports: Unpaid Invoices Report didn't appear.")
								[ ] 
							[+] else
								[+] if(Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").Exists(5))
									[ ] Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").SetActive()
									[ ] sActual=Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").GetProperty("caption")
									[ ] Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").Close()
									[+] if (sActual==lsReportNames[iCounter])
										[ ] ReportStatus("Verify Customer Invoice Account Actions> More Reports", PASS, "Verify Customer Invoice Account Actions> More Reports >{lsReportNames[iCounter]}: Report {sActual} is as expected {lsReportNames[iCounter]} .")
									[+] else
										[ ] ReportStatus("Verify Customer Invoice Account Actions> More Reports", FAIL, "Verify Customer Invoice Account Actions> More Reports >{lsReportNames[iCounter]}: Report {sActual} is  Not as expected {lsReportNames[iCounter]} .")
										[ ] 
								[+] else
									[ ] ReportStatus("Verify Customer Invoice Account Actions> More Reports", FAIL, "Verify Customer Invoice Account Actions> More Reports >{lsReportNames[iCounter]}: Report {lsReportNames[iCounter]} didn't appear.")
								[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Invoice Account Actions button", FAIL, "Verify  Customer Invoice Account Actions button: Account Actions button doesn't exist'.")
					[ ] BankingPopUp.Close()
					[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test26_VerifyMoreReportsonVendorInvoiceAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test26_VerifyMoreReportsonVendorInvoiceAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify MoreReports on Vendor Invoice Account Actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MoreReports verifification on Vendor Invoice Account Actions is successful
		[ ] //						Fail			If MoreReports verifification on Vendor Invoice Account Actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 29, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test26_VerifyMoreReportsonVendorInvoiceAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[12]
	[ ] lsReportNames= {"Register Report","Banking Summary","Cash Flow Comparison","Cash Flow","Income/Expense Comparison by Category","Itemized Categories","Missing Checks","Current Budget","Historical Budget","Net Worth"}
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account", PASS, "{lsAddAccount[2]} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[ ] ReportStatus("Verify Vendor Invoice Account Actions button", PASS, "Verify Vendor Invoice Account Actions button: Vendor Invoice Account Actions button displayed.")
						[ ] ///##########Verifying Acount Actions> More Reports#####////
						[+] for (iCounter=1; iCounter<11;++iCounter)
							[ ] BankingPopUp.SetActive()
							[ ] AccountActionsPopUpButton.Click(1,52,11)
							[+] for (iCount=1; iCount<11;++iCount)
								[ ] BankingPopUp.TypeKeys(KEY_DN)
							[ ] BankingPopUp.TypeKeys(KEY_RT)
							[+] for  (iCount=1; iCount<iCounter+1;++iCount)
								[+] if (iCount>1)
									[ ] BankingPopUp.TypeKeys(KEY_DN)
							[ ] BankingPopUp.TypeKeys(KEY_ENTER)
							[ ] 
							[+] if(Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").Exists(5))
								[ ] Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").SetActive()
								[ ] sActual=Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").GetProperty("caption")
								[ ] Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").Close()
								[+] if (sActual==lsReportNames[iCounter])
									[ ] ReportStatus("Verify Vendor Invoice Account Actions> More Reports", PASS, "Verify Vendor Invoice Account Actions> More Reports >{lsReportNames[iCounter]}: Report {sActual} is as expected {lsReportNames[iCounter]} .")
								[+] else
									[ ] ReportStatus("Verify Vendor Invoice Account Actions> More Reports", FAIL, "Verify Vendor Invoice Account Actions> More Reports >{lsReportNames[iCounter]}: Report {sActual} is  Not as expected {lsReportNames[iCounter]} .")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify Vendor Invoice Account Actions> More Reports", FAIL, "Verify Vendor Invoice Account Actions> More Reports >{lsReportNames[iCounter]}: Report {lsReportNames[iCounter]} didn't appear.")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Vendor Invoice Account Actions button", FAIL, "Verify Vendor Invoice Account Actions button: Vendor Invoice Account Actions button doesn't exist'.")
					[ ] BankingPopUp.Close()
					[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] // //------------------------------------
[ ] 
[+] //############# Test27_VerifyAddCustomerInvoiceUsingAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_VerifyAddCustomerInvoiceUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding Customer Invoice using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Customer Invoice using account actions verifification  is successful
		[ ] //						Fail			If adding Customer Invoice using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 30, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test27_VerifyAddCustomerInvoiceUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[13]
	[ ] // Fetch 1st row from the sRegCustomerVendorTransactions sheet
	[ ] sAccountName=lsAddAccount[2]
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegCustomerVendorTransactions)
	[ ] lsTransaction=lsExcelData[1]
	[ ] ///Get the total amount of invoice////
	[ ] nAmount=VAL(lsTransaction[15])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[+] ///##########Verifying Customer Invoices Account Actions> New Customer Invoice#####////
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText="Invoice - " + sAccountName
							[ ] NavigateToAccountActionBanking(3, sPopUpWindow)
							[+] if (DlgInvoice.Exists(4))
								[ ] DlgInvoice.SetActive()
								[ ] sActual=DlgInvoice.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] 
									[ ] iAddTransaction=AddBusinessInvoiceTransaction(lsTransaction[1],lsTransaction[2], lsTransaction[3], lsTransaction[4], lsTransaction[5], lsTransaction[6], lsTransaction[7], lsTransaction[8], lsTransaction[9], lsTransaction[10], lsTransaction[11], lsTransaction[12],  lsTransaction[13], lsTransaction[14] )
									[+] if (iAddTransaction==PASS)
										[ ] //Verify that transaction in register using Find and Replace dailog box///
										[ ] lsTemp=GetTransactionsInRegister(lsTransaction[1])
										[ ] 
										[+] if (ListCount(lsTemp)>0)
											[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[1]}*{trim(Str(nAmount,7,2))}*",lsTemp[1])
											[+] if (bMatch==TRUE)
												[ ] ReportStatus("Verify New Customer Invoice added", PASS, "Verify New Customer Invoice added: Customer Invoice with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} entered in account {sAccountName}.")
												[ ] ////delete the added invoice///
												[ ] DeleteTransaction(sPopUpWindow,lsTransaction[1])
											[+] else
												[ ] ReportStatus("Verify New Customer Invoice added", FAIL, "Verify New Customer Invoice added: Customer Invoice with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} couldn't be entered in account {sAccountName} correctly.")
										[+] else
											[ ] ReportStatus("Verify New Customer Invoice added", FAIL, "Verify New Customer Invoice added: Transaction with payee {lsTransaction[1]} not found in Find and Replace dailog box.")
									[+] else
										[ ] ReportStatus("Verify New Customer Invoice added.", FAIL, "Verify New Customer Invoice added: New Customer Invoice with customer {lsTransaction[1]} couldn't be added.")
								[+] else
									[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Invoice", FAIL, "Verify Customer Invoices Account Actions>New Customer Invoice option: Dialog {sValidationText} didn't display.")
							[+] else
								[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Vendor Invoice Account Actions button", FAIL, "Verify Vendor Invoice Account Actions button: Vendor Invoice Account Actions button doesn't exist'.")
					[+] if (BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test28_VerifyAddCustomerPaymentUsingAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_VerifyAddCustomerInvoiceUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding Customer payment using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Customer payment using account actions verifification is successful
		[ ] //						Fail			If adding Customer payment using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 01, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test28_VerifyAddCustomerPaymentUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[13]
	[ ] // Fetch 1st row from the sRegCustomerVendorTransactions sheet
	[ ] sAccountName=lsAddAccount[2]
	[ ] // Fetch 1st row from the sRegCustomerVendorPayment sheet
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegCustomerVendorPayment)
	[ ] lsTransaction=lsExcelData[1]
	[ ] ///Get the total amount of payment////
	[ ] nAmount=VAL(lsTransaction[3])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[+] ///##########Verifying Customer Invoices Account Actions> New Customer Payment#####////
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText="Payment - " + sAccountName
							[ ] NavigateToAccountActionBanking(4, sPopUpWindow)
							[+] if (DlgPaymentInvoices.Exists(4))
								[ ] DlgPaymentInvoices.SetActive()
								[ ] sActual=DlgPaymentInvoices.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] iAddTransaction=AddCustomerVendorPayment(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5])
									[+] if (iAddTransaction==PASS)
										[ ] //Verify that Payment in Customer Invoice account register using Find and Replace dailog box///
										[ ] lsTemp=GetTransactionsInRegister(lsTransaction[1])
										[ ] 
										[+] if (ListCount(lsTemp)>1)
											[+] for (iCount=1 ; iCount <ListCount(lsTemp)+1 ; ++iCount)
												[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[1]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCount])
												[+] if (bMatch)
													[ ] break
											[ ] 
											[+] if (bMatch)
												[ ] ReportStatus("Verify New Customer Payment added", PASS, "Verify New Customer Payment added: Customer Payment with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} entered in account {sAccountName}.")
											[+] else
												[ ] ReportStatus("Verify New Customer Payment added", FAIL, "Verify New Customer Payment added: Customer Payment with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} couldn't be entered in account {sAccountName} correctly.")
										[+] else
											[ ] ReportStatus("Verify New Customer Invoice added", FAIL, "Verify New Customer Invoice added: Transaction with payee {lsTransaction[1]} not found in Find and Replace dailog box.")
										[ ] ///Close the Customer Invoice account register popup window///
										[+] if (BankingPopUp.Exists(5))
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.Close()
											[ ] WaitForState(BankingPopUp,FALSE,1)
										[ ] ////Verify that Payment in Checking 01 account register using Find and Replace dailog box///
										[ ] //Select the Checking 01 account
										[ ] QuickenWindow.SetActive ()
										[ ] sAccountName=lsTransaction[2]
										[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
										[+] if (iSelect==PASS)
											[+] if (BankingPopUp.Exists(5))
												[ ] BankingPopUp.SetActive()
												[ ] lsTemp=GetTransactionsInRegister(lsTransaction[1])
												[ ] 
												[+] if (ListCount(lsTemp)>0)
													[+] for (iCount=1 ; iCount <ListCount(lsTemp)+1 ; ++iCount)
														[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[1]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCount])
														[+] if (bMatch)
															[ ] break
													[+] if (bMatch)
														[ ] ReportStatus("Verify New Customer Payment added", PASS, "Verify New Customer Payment added: Customer Payment with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} entered in account {sAccountName}.")
														[ ] 
														[ ] //Delete the added transaction if ttransaction delete fails it can impcat other testcases
														[+] if (BankingPopUp.Exists(1))
															[ ] BankingPopUp.SetActive()
															[ ] BankingPopUp.Close()
															[ ] WaitForState(BankingPopUp,FALSE,2)
														[ ] iResult=UsePopupRegister("OFF")	
														[+] if (iResult==PASS)
															[ ] iResult =SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
															[+] if (iResult==PASS)
																[ ] sleep(1)
																[ ] DeleteTransaction(sMDIWindow,lsTransaction[1])
																[ ] //Invoice delete confirmation
																[+] if(DeleteTransaction.Exists(5))
																	[ ] DeleteTransaction.SetActive ()
																	[ ] DeleteTransaction.Yes.Click ()
																[ ] 
																[ ] sleep(2)
															[+] else
																[ ] ReportStatus("Verify  {sAccountName}  Account", FAIL, " {sAccountName} couldn't be selected.")
														[+] else
															[ ] ReportStatus("Verify Popup Register mode is ON", FAIL, "Popup Register mode couldn't be set OFF.") 
														[ ] 
														[ ] 
													[+] else
														[ ] ReportStatus("Verify New Customer Payment added", FAIL, "Verify New Customer Payment added: Customer Payment with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))}couldn't be entered in account {sAccountName} correctly.")
												[+] else
													[ ] ReportStatus("Verify New Customer Payment added", FAIL, "Verify New Customer Payment added: Payment with payee {lsTransaction[1]} not found in Find and Replace dailog box.")
											[+] else
												[ ] ReportStatus("Verify {sAccountName} in popup mode.", FAIL, "Verify {sAccountName} couldn't open in popup mode.")
										[+] else
											[ ] ReportStatus("Verify {sAccountName} opened.", FAIL, "{sAccountName} couldn't open.")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify New Customer Payment added.", FAIL, "Verify New Customer Payment added: New Customer Payment with customer {lsTransaction[1]} couldn't be added.")
								[+] else
									[ ] ReportStatus("Verify Customer Payment Account Actions> New Customer Payment", FAIL, "Verify Customer Payment Account Actions>New Customer Payment option: Dialog {sValidationText} didn't display.")
							[+] else
								[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Vendor Invoice Account Actions button", FAIL, "Verify Vendor Invoice Account Actions button: Vendor Invoice Account Actions button doesn't exist'.")
					[+] if (BankingPopUp.Exists(3))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify {sAccountName} opened.", FAIL, "{sAccountName} couldn't open.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
		[+] if(BankingPopUp.Exists(5))
			[ ] BankingPopUp.SetActive()
			[ ] BankingPopUp.Close()
		[ ] 
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] // //---------------------------------------
[ ] 
[+] //############# Test29_VerifyAddCustomerCreditUsingAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_VerifyAddCustomerCreditUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding Customer Invoice using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Customer Invoice using account actions verifification  is successful
		[ ] //						Fail			If adding Customer Invoice using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             March 30, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test29_VerifyAddCustomerCreditUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[13]
	[ ] // Fetch 1st row from the sRegCustomerCreditTransactions sheet
	[ ] sAccountName=lsAddAccount[2]
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegCustomerCreditTransactions)
	[ ] lsTransaction=lsExcelData[1]
	[ ] ///Get the total amount of invoice////
	[ ] nAmount=VAL(lsTransaction[14])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[+] ///##########Verifying Customer Invoices Account Actions> Credit#####////
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText="Credit - " + sAccountName
							[ ] NavigateToAccountActionBanking(5, sPopUpWindow)
							[+] if (DlgCreditInvoices.Exists(4))
								[ ] DlgCreditInvoices.SetActive()
								[ ] sActual=DlgCreditInvoices.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] iAddTransaction=AddCustomerCreditTransaction(lsTransaction[1],lsTransaction[2], lsTransaction[3], lsTransaction[4], lsTransaction[5], lsTransaction[6], lsTransaction[7], lsTransaction[8], lsTransaction[9], lsTransaction[10], lsTransaction[11], lsTransaction[12],  lsTransaction[13])
									[+] if (iAddTransaction==PASS)
										[ ] 
										[ ] //Verify transaction in register using Find and Replace dailog box///
										[ ] lsTemp=GetTransactionsInRegister(lsTransaction[1])
										[ ] 
										[+] if (ListCount(lsTemp)>0)
											[+] for (iCounter=1; iCounter<ListCount(lsTemp)+1 ; ++iCounter)
												[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[1]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCounter])
												[+] if (bMatch==TRUE)
													[ ] break
											[+] if (bMatch==TRUE)
												[+] ReportStatus("Verify Credit- { sAccountName} is added", PASS, "Verify Credit- { sAccountName} is added: Credit- { sAccountName} with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} entered in {sAccountName} as expected {lsTemp[iCounter]}")
													[ ] //Delete the added transaction if ttransaction delete fails it can impcat other testcases
													[+] if (BankingPopUp.Exists(1))
														[ ] BankingPopUp.SetActive()
														[ ] BankingPopUp.Close()
														[ ] WaitForState(BankingPopUp,FALSE,1)
													[ ] iResult=UsePopupRegister("OFF")	
													[+] if (iResult==PASS)
														[ ] iResult =SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
														[+] if (iResult==PASS)
															[ ] sleep(1)
															[ ] DeleteTransaction(sMDIWindow,lsTransaction[1])
														[+] else
															[ ] ReportStatus("Verify  {sAccountName}  Account", FAIL, " {sAccountName} couldn't be selected.")
													[+] else
														[ ] ReportStatus("Verify Popup Register mode is ON", FAIL, "Popup Register mode couldn't be set OFF.") 
											[+] else
												[ ] ReportStatus("Verify Credit- { sAccountName} is added", FAIL, "Verify Credit- { sAccountName} is added: Credit- { sAccountName} with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} couldn't be entered in {sAccountName} correctly.")
										[+] else
											[ ] ReportStatus("Verify New Customer Invoice added", FAIL, "Verify New Customer Invoice added: Transaction with payee {lsTransaction[1]} not found in Find and Replace dailog box.")
									[+] else
										[ ] ReportStatus("Verify transaction added for Credit- { sAccountName}..", FAIL, "Verify Credit- { sAccountName} is added: Credit- { sAccountName} with customer {lsTransaction[1]} couldn't be added.")
								[+] else
									[ ] ReportStatus("Verify Customer Invoices Account Actions> Credit- { sAccountName}", FAIL, "Verify Customer Invoices Account Actions>Credit- { sAccountName} option: Dialog {sValidationText} didn't display.")
							[+] else
								[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Invoice Account Actions button", FAIL, "Verify Customer Invoice Account Actions button: Customer Invoice Account Actions button doesn't exist'.")
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test30_VerifyAddCustomerRefundUsingAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_VerifyAddCustomerRefundUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding Customer Refund using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Customer Refund using account actions verifification  is successful
		[ ] //						Fail			If adding Customer Refund using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 02, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test30_VerifyAddCustomerRefundUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[13]
	[ ] // Fetch 1st row from the sRegCustomerVendorTransactions sheet
	[ ] sAccountName=lsAddAccount[2]
	[ ] // Fetch 1st row from the sRegCustomerVendorPayment sheet
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegCustomerVendorRefund)
	[ ] lsTransaction=lsExcelData[1]
	[ ] 
	[ ] ///Get the total amount of payment////
	[ ] nAmount=VAL(lsTransaction[3])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[+] ///##########Verifying Customer Invoices Account Actions> New Customer Payment#####////
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText="Refund - " + sAccountName
							[ ] NavigateToAccountActionBanking(6 , sPopUpWindow)
							[+] if (DlgRefund.Exists(4))
								[ ] DlgRefund.SetActive()
								[ ] sActual=DlgRefund.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] iAddTransaction=AddCustomerRefund(lsTransaction[1],lsTransaction[2], lsTransaction[3], lsTransaction[4], sDateStamp , lsTransaction[5], lsTransaction[6], lsTransaction[7])
									[+] if (iAddTransaction==PASS)
										[ ] //Verify that Refund in Customer Invoice account register using Find and Replace dailog box///
										[ ] lsTemp=GetTransactionsInRegister(lsTransaction[2])
										[ ] 
										[+] if (ListCount(lsTemp)>1)
											[+] for (iCounter=1; iCounter<ListCount(lsTemp)+1 ; ++iCounter)
												[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[2]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCounter])
												[+] if (bMatch==TRUE)
													[ ] break
											[+] if (bMatch==TRUE)
												[ ] ReportStatus("Verify Refund - { sAccountName} is added", PASS, "Verify Refund - { sAccountName} is added: Refund - { sAccountName}with payee {lsTransaction[2]} and amount - {trim(Str(nAmount,7,2))} entered in account {sAccountName} as expected {lsTemp[iCounter]}.")
											[+] else
												[ ] ReportStatus("Verify Refund - { sAccountName} is added", FAIL, "Verify Refund - { sAccountName} is added: Refund - { sAccountName} with payee {lsTransaction[2]} and amount - {trim(Str(nAmount,7,2))} couldn't be entered in account {sAccountName} correctly.")
										[+] else 
											[ ] ReportStatus("Verify Refund - { sAccountName} is added", FAIL, "Verify Refund - { sAccountName} is added: Transaction with payee {lsTransaction[2]} not found in Find and Replace dailog box.")
										[ ] ///Close the Customer Invoice account register popup window///
										[+] if (BankingPopUp.Exists(5))
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.Close()
											[ ] WaitForState(BankingPopUp,FALSE,1)
										[ ] ////Verify that Payment in Checking 01 account register using Find and Replace dailog box///
										[ ] //Select the Checking 01 account
										[ ] sAccountName=lsTransaction[1]
										[ ] 
										[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
										[+] if (iSelect==PASS)
											[+] if (BankingPopUp.Exists(5))
												[ ] BankingPopUp.SetActive()
												[ ] lsTemp=GetTransactionsInRegister(lsTransaction[2])
												[ ] 
												[+] if (ListCount(lsTemp)>0)
													[+] for (iCounter=1; iCounter<ListCount(lsTemp) +1; ++iCounter)
														[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[2]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCounter])
														[+] if (bMatch==TRUE)
															[ ] break
													[ ] 
													[+] if (bMatch==TRUE)
														[ ] ReportStatus("Verify Refund - { sAccountName}added", PASS, "Verify Refund - { sAccountName} added: Refund - { sAccountName} with payee {lsTransaction[2]} and amount : {trim(Str(nAmount,7,2))} entered in account {sAccountName} as expected {lsTemp[iCounter]}.")
														[ ] ////delete the added Payment///
														[ ] DeleteTransaction(sPopUpWindow,lsTransaction[2])
													[+] else
														[ ] ReportStatus("Verify Refund - { sAccountName} added", FAIL, "Verify Refund - { sAccountName} added: Refund - { sAccountName}with payee {lsTransaction[2]} and amount  {trim(Str(nAmount,7,2))}couldn't be entered in account {sAccountName} correctly.")
												[+] else
													[ ] ReportStatus("Verify Refund - { sAccountName} added", FAIL, "Verify Refund - { sAccountName} added: Refund - { sAccountName} with payee {lsTransaction[2]} not found in Find and Replace dailog box.")
											[+] else
												[ ] ReportStatus("Verify {sAccountName} in popup mode.", FAIL, "Verify {sAccountName} couldn't open in popup mode.")
										[+] else
											[ ] ReportStatus("Verify {sAccountName} opened.", FAIL, "{sAccountName} couldn't open.")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Refund - { sAccountName} isadded.", FAIL, "Verify Refund - { sAccountName} added: Refund - { sAccountName} with customer {lsTransaction[1]} couldn't be added.")
								[+] else
									[ ] ReportStatus("Verify { sAccountName} Account Actions> Refund", FAIL, "Verify { sAccountName} Actions>Refund option: Dialog {sValidationText} didn't display.")
							[+] else
								[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify { sAccountName} Account Actions button", FAIL, "Verify { sAccountName} Account Actions button:  { sAccountName} Account Actions button doesn't exist'.")
					[+] if (BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify {sAccountName} opened.", FAIL, "{sAccountName} couldn't open.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test31_VerifyAddCustomerFinanceChargeUsingAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test31_VerifyAddCustomerFinanceChargeUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding Customer Finance Charge using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Customer Finance Charge using account actions verifification  is successful
		[ ] //						Fail			If adding Customer Finance Charge using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 02, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test31_VerifyAddCustomerFinanceChargeUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[13]
	[ ] // Fetch 1st row from the sRegCustomerVendorTransactions sheet
	[ ] sAccountName=lsAddAccount[2]
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegCustomerFinanceCharge)
	[ ] lsTransaction=lsExcelData[1]
	[ ] ///Get the total amount of invoice////
	[ ] nAmount=VAL(lsTransaction[5])
	[ ] sDate=FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sDueDate =FormatDateTime ( AddDateTime (GetDateTime (), 2), "m/d/yyyy") 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[+] ///##########Verifying Customer Invoices Account Actions> New Customer Invoice#####////
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText="Create Finance Charge" 
							[ ] NavigateToAccountActionBanking(7 , sPopUpWindow)
							[+] if (DlgCreateFinanceCharge.Exists(4))
								[ ] DlgCreateFinanceCharge.SetActive()
								[ ] sActual=DlgCreateFinanceCharge.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] iAddTransaction=AddCustomerFinanceCharge(lsTransaction[1], sDateStamp,sDueDate,lsTransaction[2], lsTransaction[3], lsTransaction[4], lsTransaction[5], lsTransaction[6])
									[+] if (iAddTransaction==PASS)
										[ ] //Verify that transaction in register using Find and Replace dailog box///
										[ ] lsTemp=GetTransactionsInRegister(lsTransaction[1])
										[ ] 
										[+] if (ListCount(lsTemp)>0)
											[+] for (iCounter=1; iCounter<=ListCount(lsTemp) ; iCounter++)
												[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[1]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCounter])
												[+] if (bMatch==TRUE)
													[ ] break
											[ ] 
											[+] if (bMatch==TRUE)
												[ ] ReportStatus("Verify Create Finance Charge added", PASS, "Verify Create Finance Charge added: Create Finance Charge with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} entered in account {sAccountName} as expected {lsTemp[iCounter]}")
												[ ] ////delete the added transaction///
												[ ] DeleteTransaction(sPopUpWindow,lsTransaction[1])
											[+] else
												[ ] ReportStatus("Verify Create Finance Charge added", FAIL, "Verify Create Finance Charge added: Create Finance Charge with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} couldn't be entered in account {sAccountName} correctly.")
										[+] else
											[ ] ReportStatus("Verify Create Finance Charge added", FAIL, "Verify Create Finance Charge added: Transaction with payee {lsTransaction[1]} not found in Find and Replace dailog box.")
									[+] else
										[ ] ReportStatus("Verify Create Finance Charge added.", FAIL, "Verify Create Finance Charge added: Create Finance Charge with customer {lsTransaction[1]} couldn't be added.")
								[+] else
									[ ] ReportStatus("Verify Customer Invoices Account Actions> Create Finance Charge", FAIL, "Verify Customer Invoices Account Actions>Create Finance Charge option: Dialog {sValidationText} didn't display.")
							[+] else
								[ ] ReportStatus("Verify Create Finance Charge", FAIL, "Verify Dialog Create Finance Charge: Create Finance Charge dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Account Actions button", FAIL, "Verify Customer Invoice Account Actions button: Customer Invoice Account Actions button doesn't exist'.")
					[+] if (BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test32_VerifyInvoiceDefaultsFeatureUsingAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test32_VerifyInvoiceDefaultsFeatureUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Invoice Defaults impact on Invoice dialog using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Invoice Defaults impact on Invoice dialog verifification using account actions is successful
		[ ] //						Fail			If Invoice Defaults impact on Invoice dialog verifification using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 03, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test32_VerifyInvoiceDefaultsFeatureUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[13]
	[ ] // Fetch 1st row from the sRegCustomerVendorTransactions sheet
	[ ] sAccountName=lsAddAccount[2]
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegCustomerFinanceCharge)
	[ ] lsTransaction=lsExcelData[1]
	[ ] ///Get the total amount of invoice////
	[ ] nAmount=VAL(lsTransaction[5])
	[ ] sDate=FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sDueDate =FormatDateTime ( AddDateTime (GetDateTime (), 15), "m/d/yyyy") 
	[ ] STRING sDueDateDays="15"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[+] ///##########Verifying Customer Invoices Account Actions> Invoice defaults#####////
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText="Set Invoice Defaults"
							[ ] NavigateToAccountActionBanking(18 , sPopUpWindow)
							[+] if (DlgSetInvoiceDefaults.Exists(4))
								[ ] DlgSetInvoiceDefaults.SetActive()
								[ ] sActual=DlgSetInvoiceDefaults.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] sExpected=DlgSetInvoiceDefaults.TaxAccountPopupList.GetSelText()
									[ ] DlgSetInvoiceDefaults.DueDateTextField.SetText(sDueDateDays)
									[ ] DlgSetInvoiceDefaults.OKButton.Click()
									[ ] WaitForState(DlgSetInvoiceDefaults,False,1)
									[+] ///##########Verifying Tax account and due date on invoice dialog#####////
										[ ] BankingPopUp.SetActive()
										[ ] sValidationText="Invoice - " + sAccountName
										[ ] NavigateToAccountActionBanking(3 , sPopUpWindow)
										[+] if (DlgInvoice.Exists(4))
											[ ] DlgInvoice.SetActive()
											[ ] sActual=DlgInvoice.GetProperty("Caption")
											[+] if (sActual==sValidationText)
												[ ] sActualDate=DlgInvoice.DUEDATETextField.GetText()
												[+] if (sActualDate==sDueDate)
													[ ] ReportStatus("Verify Invoice defaults> Due Date on Invoice dialog.", PASS, "Verify Invoice defaults> Due Date : Invoice dialog's due date is: {sActualDate} updated to {sDueDateDays} from current date.")
												[+] else
													[ ] ReportStatus("Verify Invoice defaults> Due Date on Invoice dialog.", FAIL, "Verify Invoice defaults> Due Date : Invoice dialog's due date is: {sActualDate} couldn't be updated to {sDueDateDays} from current date.")
													[ ] 
												[ ] sActual=NULL
												[ ] sActual=DlgInvoice.TaxAccountPopupList.GetSelText()
												[+] if (sActual==sExpected)
													[ ] ReportStatus("Verify Invoice defaults>Tax Account on Invoice dialog.", PASS, "Verify Invoice defaults>Tax Account  : Invoice dialog's Tax Account  is: {sActual} same as on Invoice defaults dialog {sExpected}.")
												[+] else
													[ ] ReportStatus("Verify Invoice defaults>Tax Account on Invoice dialog.", FAIL, "Verify Invoice defaults>Tax Account  : Invoice dialog's Tax Account  is: {sActual} is NOT same as on Invoice defaults dialog {sExpected}.")
												[ ] DlgInvoice.SetActive()
												[ ] DlgInvoice.CancelButton.Click()
												[+] if (AlertMessage.Exists(5))
													[ ] AlertMessage.SetActive()
													[ ] AlertMessage.Yes.Click()
												[ ] WaitForState(DlgInvoice,FALSE,1)
											[+] else
												[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Invoice", FAIL, "Verify Customer Invoices Account Actions>New Customer Invoice option: Dialog {sValidationText} didn't display.")
										[+] else
											[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Customer Invoices Account Actions> Invoice Defaults", FAIL, "Verify Customer Invoices Account Actions>Invoice Defaults option: Dialog {sValidationText} didn't display.")
							[+] else
								[ ] ReportStatus("Verify Set Invoice Defaults", FAIL, "Verify Dialog Set Invoice Defaults: Set Invoice Defaults dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Account Actions button", FAIL, "Verify Customer Invoice Account Actions button: Customer Invoice Account Actions button doesn't exist'.")
					[+] if (BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test33_VerifyAddVendorPaymentUsingAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test33_VerifyAddVendorPaymentUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding Vendor payment using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Vendor payment using account actions verifification is successful
		[ ] //						Fail			If adding Vendor payment using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 03, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test33_VerifyAddVendorPaymentUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[12]
	[ ] // Fetch 1st row from the sRegCustomerVendorTransactions sheet
	[ ] sAccountName=lsAddAccount[2]
	[ ] // Fetch 1st row from the sRegCustomerVendorPayment sheet
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegCustomerVendorPayment)
	[ ] lsTransaction=lsExcelData[2]
	[ ] 
	[ ] ///Get the total amount of payment////
	[ ] nAmount=VAL(lsTransaction[3])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[+] ///##########Verifying Customer Invoices Account Actions> New Customer Payment#####////
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText="Payment - " + sAccountName
							[ ] NavigateToAccountActionBanking(4 , sPopUpWindow)
							[+] if (DlgPaymentInvoices.Exists(4))
								[ ] DlgPaymentInvoices.SetActive()
								[ ] sActual=DlgPaymentInvoices.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] iAddTransaction=AddCustomerVendorPayment(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5])
									[+] if (iAddTransaction==PASS)
										[ ] 
										[ ] //Verify Buttons for the added transactions
										[ ] iAddTransaction=FindTransaction(sPopUpWindow,lsTransaction[1])
										[+] if (AlertMessage.Exists(5))
											[ ] AlertMessage.OK.Click()
										[ ] 
										[+] if (iAddTransaction==PASS)
											[ ] BankingPopUp.SetActive()
											[+] if (BankingPopUp.TxList.TxToolbar.SplitButton.Exists(5))
												[ ] ReportStatus("Verify Split Button for {sAccountName}.", PASS, "Verify Split Button for { sAccountName}: Split Button exists for { sAccountName}.")
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Verify Split Button for {sAccountName}.", FAIL, "Verify Split Button for { sAccountName}: Split Button doesn't exist for { sAccountName}.")
												[ ] 
											[+] if (BankingPopUp.TxList.TxToolbar.MoreAccountActions.Exists(5))
												[ ] ReportStatus("Verify MoreActions Button for {sAccountName}.", PASS, "Verify MoreActions Button for { sAccountName}: MoreActions Button exists for { sAccountName}.")
											[+] else
												[ ] ReportStatus("Verify MoreActions Button for {sAccountName}.", FAIL, "Verify MoreActions Button for { sAccountName}: MoreActions Button doesn't exist for { sAccountName}.")
											[+] if (BankingPopUp.TxList.TxToolbar.Save.Exists(5))
												[ ] ReportStatus("Verify Save Button for {sAccountName}.", PASS, "Verify Save Button for { sAccountName}: Save Button exists for { sAccountName}.")
											[+] else
												[ ] ReportStatus("Verify Save Button for {sAccountName}.", FAIL, "Verify Save Button for { sAccountName}: Save Button doesn't exist for { sAccountName}.")
											[ ] 
										[+] else
											[ ] ReportStatus("Verify transaction added for Credit- { sAccountName}..", FAIL, "Verify Credit- { sAccountName} is added: Credit- { sAccountName} with customer {lsTransaction[1]} couldn't be added.")
											[ ] 
										[ ] 
										[ ] //Verify that Payment in Customer Invoice account register using Find and Replace dailog box///
										[ ] lsTemp=GetTransactionsInRegister(lsTransaction[1])
										[ ] 
										[+] if (ListCount(lsTemp)>1)
											[+] for (iCounter=1; iCounter<ListCount(lsTemp)+1 ; ++iCounter)
												[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[1]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCounter])
												[+] if (bMatch==TRUE)
													[ ] break
											[ ] 
											[+] if (bMatch==TRUE)
												[ ] ReportStatus("Verify New Vendor Payment added", PASS, "Verify New Vendor Payment added: Vendor Payment with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} entered in account {sAccountName} as expected {lsTemp[iCounter]}")
											[+] else
												[ ] ReportStatus("Verify New Vendor Payment added", FAIL, "Verify New Vendor Payment added: Vendor Payment with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} couldn't be entered in account {sAccountName} correctly.")
										[+] else
											[ ] ReportStatus("Verify New Vendor Payment added", FAIL, "Verify New Vendor Payment added: Transaction with payee {lsTransaction[1]} not found in Find and Replace dailog box.")
										[ ] ///Close the Customer Invoice account register popup window///
										[+] if (BankingPopUp.Exists(5))
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.Close()
											[ ] WaitForState(BankingPopUp,FALSE,1)
										[ ] ////Verify that Payment in Checking 01 account register using Find and Replace dailog box///
										[ ] //Select the Checking 01 account
										[ ] sAccountName=lsTransaction[2]
										[ ] 
										[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
										[+] if (iSelect==PASS)
											[+] if (BankingPopUp.Exists(5))
												[ ] BankingPopUp.SetActive()
												[ ] lsTemp=GetTransactionsInRegister(lsTransaction[1])
												[ ] 
												[+] if (ListCount(lsTemp)>0)
													[+] for (iCounter=1; iCounter<ListCount(lsTemp)+1 ; ++iCounter)
														[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[1]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCounter])
														[+] if (bMatch==TRUE)
															[ ] break
													[ ] 
													[+] if (bMatch==TRUE)
														[ ] ReportStatus("Verify New Vendor Payment added", PASS, "Verify New Vendor Payment added: Vendor Payment with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} entered in account {sAccountName} as expected {lsTemp[iCounter]}.")
														[ ] ////delete the added Payment///
														[ ] DeleteTransaction(sPopUpWindow,lsTransaction[1])
													[+] else
														[ ] ReportStatus("Verify New Vendor Payment added", FAIL, "Verify New Vendor Payment added: Vendor Payment with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))}couldn't be entered in account {sAccountName} correctly.")
												[+] else
													[ ] ReportStatus("Verify New Vendor Payment added", FAIL, "Verify New Vendor Payment added: Payment with payee {lsTransaction[1]} not found in Find and Replace dailog box.")
											[+] else
												[ ] ReportStatus("Verify {sAccountName} in popup mode.", FAIL, "Verify {sAccountName} couldn't open in popup mode.")
										[+] else
											[ ] ReportStatus("Verify {sAccountName} opened.", FAIL, "{sAccountName} couldn't open.")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify New Vendor Payment added.", FAIL, "Verify New Customer Vendor added: New Customer Vendor with Vendor {lsTransaction[1]} couldn't be added.")
								[+] else
									[ ] ReportStatus("Verify Vendor Payment Account Actions> New Vendor Payment", FAIL, "Verify Vendor Payment Account Actions>New Customer Payment option: Dialog {sValidationText} didn't display.")
							[+] else
								[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Vendor Invoice Account Actions button", FAIL, "Verify Vendor Invoice Account Actions button: Vendor Invoice Account Actions button doesn't exist'.")
					[+] if (BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify {sAccountName} opened.", FAIL, "{sAccountName} couldn't open.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test34_VerifyAddVendorCreditUsingAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test34_VerifyAddVendorCreditUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding Credit Vendor Invoice using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Credit Vendor Invoice using account actions verifification  is successful
		[ ] //						Fail			If adding Credit Vendor Invoice using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 04, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test34_VerifyAddVendorCreditUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[12]
	[ ] // Fetch 1st row from the sRegCustomerCreditTransactions sheet
	[ ] sAccountName=lsAddAccount[2]
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegVendorCreditTransactions)
	[ ] lsTransaction=lsExcelData[1]
	[ ] ///Get the total amount of invoice////
	[ ] nAmount=VAL(lsTransaction[7])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[+] ///##########Verifying Customer Invoices Account Actions> Credit#####////
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText="Credit - " + sAccountName
							[ ] NavigateToAccountActionBanking(5 , sPopUpWindow)
							[+] if (DlgCreditInvoices.Exists(4))
								[ ] DlgCreditInvoices.SetActive()
								[ ] sActual=DlgCreditInvoices.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] 
									[ ] iAddTransaction=AddVendorCreditTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5], lsTransaction[6],lsTransaction[7],lsTransaction[8])
									[ ] 
									[+] if (iAddTransaction==PASS)
										[ ] 
										[ ] //Verify transaction in register using Find and Replace dailog box///
										[ ] lsTemp=GetTransactionsInRegister(lsTransaction[1])
										[ ] 
										[+] if (ListCount(lsTemp)>0)
											[+] for (iCounter=1; iCounter<ListCount(lsTemp)+1 ; ++iCounter)
												[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[1]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCounter])
												[+] if (bMatch==TRUE)
													[ ] break
											[+] if (bMatch==TRUE)
												[ ] ReportStatus("Verify Credit- { sAccountName} is added", PASS, "Verify Credit- {sAccountName} is added: Credit- {sAccountName} with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} entered in {sAccountName} as expected {lsTemp[iCounter]}")
												[ ] 
												[ ] ///////Verify Print options for Vendor account////
												[ ] ///##########Verifying Acount Actions> Print >Transactions#####////
												[ ] sValidationText="Print Register"
												[ ] BankingPopUp.SetActive()
												[ ] AccountActionsPopUpButton.Click(1,52,11)
												[+] for (iCount=1; iCount<12;++iCount)
													[ ] BankingPopUp.TypeKeys(KEY_DN)
												[ ] BankingPopUp.TypeKeys(KEY_RT)
												[ ] BankingPopUp.TypeKeys(KEY_ENTER)
												[+] if (PrintRegister.Exists(4))
													[ ] PrintRegister.SetActive()
													[ ] sActual=PrintRegister.GetProperty("Caption")
													[+] if (trim(sActual)==trim(sValidationText))
														[ ] ReportStatus("Verify Print Transactions", PASS, "Verify Account Actions> Print Transactions option for {sAccountName}: Dialog {sActual} displayed as expected {sValidationText}.")
													[+] else
														[ ] ReportStatus("Verify Print Transactions", FAIL, "Verify Account Actions> Print Transactions option for {sAccountName}: Dialog {sValidationText} didn't display.")
													[ ] PrintRegister.CancelButton.Click()
													[ ] WaitForState(PrintRegister,FALSE,1)
												[+] else
													[ ] ReportStatus("Verify Print Register", FAIL, "Verify Dialog Print Register : Print RegisterDialog didn't appear.")
												[ ] ///##########Verifying Acount Actions> Print > Invoices#####////
												[ ] sValidationText="Print Invoices"
												[ ] BankingPopUp.SetActive()
												[ ] AccountActionsPopUpButton.Click(1,52,11)
												[+] for (iCount=1; iCount<12;++iCount)
													[ ] BankingPopUp.TypeKeys(KEY_DN)
												[ ] BankingPopUp.TypeKeys(KEY_RT)
												[ ] BankingPopUp.TypeKeys(KEY_DN)
												[ ] BankingPopUp.TypeKeys(KEY_ENTER)
												[+] if (DlgPrintInvoices.Exists(4))
													[ ] DlgPrintInvoices.SetActive()
													[ ] sActual=DlgPrintInvoices.GetProperty("Caption")
													[+] if (trim(sActual)==trim(sValidationText))
														[ ] ReportStatus("Verify Print Invoices", PASS, "Verify Account Actions> Print Invoices option for {sAccountName}: Dialog {sActual} displayed as expected {sValidationText}.")
													[+] else
														[ ] ReportStatus("Verify Print Invoices", FAIL, "Verify Account Actions> Print Invoices option for {sAccountName}: Dialog {sValidationText} didn't display.")
													[ ] DlgPrintInvoices.DoneButton.Click()
													[ ] WaitForState(DlgPrintInvoices,FALSE,1)
												[+] else
													[ ] ReportStatus("Verify Print Invoices", FAIL, "Verify Dialog Print Invoices option for {sAccountName}: Print Invoices Dialog didn't appear.")
												[ ] 
												[ ] ///##########Verifying Acount Actions> Print > Customer Statements#####////
												[ ] sValidationText="Customer Statements"
												[ ] 
												[ ] BankingPopUp.SetActive()
												[ ] AccountActionsPopUpButton.Click(1,52,11)
												[+] for (iCount=1; iCount<12;++iCount)
													[ ] BankingPopUp.TypeKeys(KEY_DN)
												[ ] BankingPopUp.TypeKeys(KEY_RT)
												[ ] BankingPopUp.TypeKeys(KEY_DN)
												[ ] BankingPopUp.TypeKeys(KEY_DN)
												[ ] BankingPopUp.TypeKeys(KEY_ENTER)
												[+] if (DlgCustomerStatements.Exists(4))
													[ ] DlgCustomerStatements.SetActive()
													[ ] sActual=DlgCustomerStatements.GetProperty("Caption")
													[+] if (trim(sActual)==trim(sValidationText))
														[ ] ReportStatus("Verify Print Customer Statements", PASS, "Verify Account Actions> Print Customer Statements option for {sAccountName}: Dialog {sActual} displayed as expected {sValidationText}.")
													[+] else
														[ ] ReportStatus("Verify Print Customer Statements", FAIL, "Verify Account Actions> Print Customer Statements option for {sAccountName}: Dialog {sValidationText} didn't display.")
													[ ] DlgCustomerStatements.CancelButton.Click()
													[ ] WaitForState(DlgCustomerStatements,FALSE,1)
												[+] else
													[ ] ReportStatus("Verify Print Customer Statements", FAIL, "Verify Dialog Print Customer Statements option for {sAccountName}: Print Customer Statements Dialog didn't appear.")
												[ ] 
												[ ] 
												[ ] ////delete the added Credit///
												[ ] DeleteTransaction(sPopUpWindow,lsTransaction[1])
											[+] else
												[ ] ReportStatus("Verify Credit- { sAccountName} is added", FAIL, "Verify Credit- { sAccountName} is added: Credit- { sAccountName} with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} couldn't be entered in {sAccountName} correctly.")
										[+] else
											[ ] ReportStatus("Verify New Customer Invoice added", FAIL, "Verify New Customer Invoice added: Transaction with payee {lsTransaction[1]} not found in Find and Replace dailog box.")
									[+] else
										[ ] ReportStatus("Verify transaction added for Credit- { sAccountName}..", FAIL, "Verify Credit- { sAccountName} is added: Credit- { sAccountName} with customer {lsTransaction[1]} couldn't be added.")
								[+] else
									[ ] ReportStatus("Verify Vendor Invoices Account Actions> Credit- { sAccountName}", FAIL, "Verify Vendor Invoices Account Actions>Credit- { sAccountName} option: Dialog {sValidationText} didn't display.")
							[+] else
								[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Vendor Invoice Account Actions button", FAIL, "Verify Vendor Invoice Account Actions button: Vendor Invoice Account Actions button doesn't exist'.")
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account coudln't be selected.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test35_VerifyAddVendorRefundUsingAccountActions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test35_VerifyAddVendorRefundUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding Vendor Refund using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Vendor Refund using account actions verifification  is successful
		[ ] //						Fail			If adding Vendor Refund using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 04, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test35_VerifyAddVendorRefundUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[12]
	[ ] // Fetch 1st row from the sRegCustomerVendorTransactions sheet
	[ ] sAccountName=lsAddAccount[2]
	[ ] // Fetch 1st row from the sRegCustomerVendorPayment sheet
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegVendorRefundTransaction)
	[ ] lsTransaction=lsExcelData[1]
	[ ] 
	[ ] ///Get the total amount of payment////
	[ ] nAmount=VAL(lsTransaction[5])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(5))
						[+] ///##########Verifying Vendor Invoices Account Actions> New Customer Refund#####////
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText="Refund - " + sAccountName
							[ ] NavigateToAccountActionBanking(6 , sPopUpWindow)
							[+] if (DlgRefund.Exists(4))
								[ ] DlgRefund.SetActive()
								[ ] sActual=DlgRefund.GetProperty("Caption")
								[+] if (sActual==sValidationText)
									[ ] iAddTransaction=AddVendorRefund(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5], lsTransaction[6],lsTransaction[7])
									[+] if (iAddTransaction==PASS)
										[ ] //Verify that Refund in Vendor Invoice account register using Find and Replace dailog box///
										[ ] lsTemp=GetTransactionsInRegister(lsTransaction[2])
										[ ] 
										[+] if (ListCount(lsTemp)>1)
											[+] for (iCounter=1; iCounter<ListCount(lsTemp)+1 ; ++iCounter)
												[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[2]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCounter])
												[+] if (bMatch==TRUE)
													[ ] break
											[+] if (bMatch==TRUE)
												[ ] ReportStatus("Verify Refund - { sAccountName} is added", PASS, "Verify Refund - { sAccountName} is added: Refund - { sAccountName}with payee {lsTransaction[2]} and amount - {trim(Str(nAmount,7,2))} entered in account {sAccountName} as expected {lsTemp[iCounter]}.")
											[+] else
												[ ] ReportStatus("Verify Refund - { sAccountName} is added", FAIL, "Verify Refund - { sAccountName} is added: Refund - { sAccountName} with payee {lsTransaction[2]} and amount - {trim(Str(nAmount,7,2))} couldn't be entered in account {sAccountName} correctly.")
										[+] else 
											[ ] ReportStatus("Verify Refund - { sAccountName} is added", FAIL, "Verify Refund - { sAccountName} is added: Transaction with payee {lsTransaction[2]} not found in Find and Replace dailog box.")
										[ ] ///Close the Vendor Invoice account register popup window///
										[+] if (BankingPopUp.Exists(5))
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.Close()
											[ ] WaitForState(BankingPopUp,FALSE,1)
										[ ] ////Verify that Refund in Checking 01 account register using Find and Replace dailog box///
										[ ] //Select the Checking 01 account
										[ ] sAccountName=lsTransaction[1]
										[ ] 
										[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
										[+] if (iSelect==PASS)
											[+] if (BankingPopUp.Exists(5))
												[ ] BankingPopUp.SetActive()
												[ ] lsTemp=GetTransactionsInRegister(lsTransaction[2])
												[ ] 
												[+] if (ListCount(lsTemp)>0)
													[+] for (iCounter=1; iCounter<ListCount(lsTemp) +1; ++iCounter)
														[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[2]}*{trim(Str(nAmount,7,2))}*",lsTemp[iCounter])
														[+] if (bMatch==TRUE)
															[ ] break
													[ ] 
													[+] if (bMatch==TRUE)
														[ ] ReportStatus("Verify Refund - { sAccountName}added", PASS, "Verify Refund - { sAccountName} added: Refund - { sAccountName} with payee {lsTransaction[2]} and amount : {trim(Str(nAmount,7,2))} entered in account {sAccountName} as expected {lsTemp[iCounter]}.")
														[ ] ////delete the added Refund///
														[ ] DeleteTransaction(sPopUpWindow,lsTransaction[2])
													[+] else
														[ ] ReportStatus("Verify Refund - { sAccountName} added", FAIL, "Verify Refund - { sAccountName} added: Refund - { sAccountName}with payee {lsTransaction[2]} and amount  {trim(Str(nAmount,7,2))}couldn't be entered in account {sAccountName} correctly.")
												[+] else
													[ ] ReportStatus("Verify Refund - { sAccountName} added", FAIL, "Verify Refund - { sAccountName} added: Refund - { sAccountName} with payee {lsTransaction[2]} not found in Find and Replace dailog box.")
											[+] else
												[ ] ReportStatus("Verify {sAccountName} in popup mode.", FAIL, "Verify {sAccountName} couldn't open in popup mode.")
										[+] else
											[ ] ReportStatus("Verify {sAccountName} opened.", FAIL, "{sAccountName} couldn't open.")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Refund - { sAccountName} is added.", FAIL, "Verify Refund - { sAccountName} added: Refund - { sAccountName} with customer {lsTransaction[1]} couldn't be added.")
								[+] else
									[ ] ReportStatus("Verify { sAccountName} Account Actions> Refund", FAIL, "Verify { sAccountName} Actions>Refund option: Dialog {sValidationText} didn't display.")
							[+] else
								[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify { sAccountName} Account Actions button", FAIL, "Verify { sAccountName} Account Actions button:  { sAccountName} Account Actions button doesn't exist'.")
					[+] if (BankingPopUp.Exists(5))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Close()
						[ ] WaitForState(BankingPopUp,FALSE,1)
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account coudln't open.")
			[+] else
				[ ] ReportStatus("Verify {sAccountName} opened.", FAIL, "{sAccountName} couldn't be selected.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Pop up register mode didn't get enable.")
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test36_VerifyCustomerVendorAccountsDeletion #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test36_VerifyCustomerVendorAccountsDeletion()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify deletion of Customer and Vendor Accounts
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If deletion of Customer and Vendor Accounts is successful
		[ ] //						Fail			If deletion of Customer and Vendor Accounts is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 08, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test36_VerifyCustomerVendorAccountsDeletion() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] //############## Verify deletion of Customer and Vendor Accounts#####################################
		[+] for (iCounter=12; iCounter< 14; ++iCounter)
			[ ] lsAddAccount =lsExcelData[iCounter]
			[ ] sAccountName=lsAddAccount[2]
			[ ] iResult=DeleteAccount(ACCOUNT_BUSINESS,sAccountName)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify deletion of business accounts.", PASS, "Verify deletion of business accounts {sAccountName}:  {sAccountName} of type {lsAddAccount[1]} has been deleted successfully.")
				[ ] ////Add deleted business account///
				[ ] iAddAccount = AddBusinessAccount(lsAddAccount[1], sAccountName)
				[ ] // Report Status if checking Account is created
				[+] if (iAddAccount==PASS)
					[ ] ReportStatus("Verify creation of business accounts.", PASS, "Verify creation of business account: {sAccountName} of type {lsAddAccount[1]} has been created successfully.")
				[+] else
					[ ] ReportStatus("Verify creation of business accounts.", FAIL, "Verify creation of business account: {sAccountName} of type {lsAddAccount[1]}  couldn't be created.")
			[+] else
				[ ] ReportStatus("Verify deletion of business accounts.", FAIL, "Verify deletion of business accounts {sAccountName}:  {sAccountName} of type {lsAddAccount[1]} couldn't be deleted.")
		[ ] 
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //Part 2
[ ] 
[ ] 
[+] ////############# TC10_DownloadedTransactionsPreferences_NewFile #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC10_DownloadedTransactionsPreferences_NewFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Downloaded Transactions  Preferences in new file
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC10_DownloadedTransactionsPreferences_NewFile() appstate QuickenBaseState
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sHandle
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // Create Data File------------------------------------------------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[ ] iCreateDataFile  = PASS
	[ ] // Report Staus If Data file Created successfully
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", PASS , "Data file -  {sDataFile} is created")
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to option 'Downloaded Transactions'---------------------------------------------------------------------------------
		[ ] 
		[ ] iResult=SelectPreferenceType("Downloaded transactions")
		[+] if(iResult==PASS)
			[ ] ReportStatus("Preferences Window",PASS,"Preferences Window Opened")
			[ ] Preferences.SetActive()
			[ ] 
			[ ] 
			[ ] //After Transaction Download
			[+] if(Preferences.AfterDownloadingTransactions.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AfterDownloadingTransactions Text is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AfterDownloadingTransactions Text is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyAddToBankingRegister.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToBankingRegister Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToBankingRegister Checkbox is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyAddToInvestmentTransactionLists.Exists(5))
				[ ] Preferences.AutomaticallyAddToInvestmentTransactionLists.Check()
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToInvestmentTransactionLists Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToInvestmentTransactionLists Checkbox is missing")
				[ ] 
			[ ] 
			[ ] 
			[ ] //During Transaction Download
			[+] if(Preferences.DownloadedTransactionsPreferences.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"DownloadedTransactionsPreferences Text is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"DownloadedTransactionsPreferences Text is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyCategorizeTransactions.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCategorizeTransactions Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCategorizeTransactions Checkbox is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyApplyQuickenSuggestedNameToPayee.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is missing")
				[ ] 
			[+] if(Preferences.CapitalizeFirstLetterOnlyInDownloadedPayeeNames.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is missing")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Renaming Rules
			[+] if(Preferences.YourRenamingRulesText.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"YourRenamingRulesText is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"YourRenamingRulesText is missing")
				[ ] 
			[+] if(Preferences.UseMyExistingRenamingRules.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"UseMyExistingRenamingRules Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"UseMyExistingRenamingRules Checkbox is missing")
				[ ] 
			[+] if(Preferences.RenamingRules.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"RenamingRules button is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"RenamingRules button is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyCreateRulesWhenIRenamePayees.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is missing")
				[ ] 
			[+] if(Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is missing")
				[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] //Close Preferences
			[ ] Preferences.SetActive()
			[ ] Preferences.Close()
			[ ] WaitForState(Preferences,False,1)
		[+] else
			[ ] ReportStatus("Preferences Window",FAIL,"Preferences Window Not Opened")
		[ ] 
	[ ] // Report Staus If Data file is not Created 
	[+] else
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
	[+] //--------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Setup : Convert Data File From 2012 to 2014 ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataConversionRegister2012_2013()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2012 into latest Quicken version
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase DataConversionRegisterSetup2012_2013() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] //Boolean
		[ ] BOOLEAN bSource,bVerify
		[ ] 
		[ ] //Integer
		[ ] INTEGER iDataFileConversion
		[ ] 
		[ ] //String
		[ ] STRING sFileName= "RegisterDataFile2012"
		[ ] STRING sQuicken2012File = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sVersion="2012"
		[ ] STRING sQuicken2012Source = AUT_DATAFILE_PATH + "\2012\" + sFileName + ".QDF"
		[ ] STRING sQuicken2012FileCopy= AUT_DATAFILE_PATH + "\" + "Q12Files"+ "\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Delete Existing File
		[+] if(SYS_FileExists(sQuicken2012File))
			[ ] // Delete existing file, if exists
			[ ] bVerify=DeleteFile(sQuicken2012File)
			[+] if(bVerify==TRUE)
				[ ] ReportStatus("2012 Data File Conversion",PASS,"Existing File Deleted")
			[+] else
				[ ] ReportStatus("2012 Data File Conversion",PASS,"Existing File Not Deleted")
			[ ] 
			[ ] 
		[ ] //Delete Copy of File
		[+] if(SYS_FileExists(sQuicken2012FileCopy))
			[ ] DeleteFile(sQuicken2012FileCopy)
			[ ] bVerify=DeleteFile(sQuicken2012FileCopy)
			[+] if(bVerify==TRUE)
				[ ] ReportStatus("2012 Data File Conversion",PASS,"Existing Copy of File Deleted")
			[+] else
				[ ] ReportStatus("2012 Data File Conversion",FAIL,"Existing Copy of File Not Deleted")
		[ ] 
		[ ] // Copy 2012 data file to location
		[+] if(SYS_FileExists(sQuicken2012Source))
			[ ] SYS_Execute("attrib -r  {sQuicken2012Source} ")
			[ ] bVerify=CopyFile(sQuicken2012Source, sQuicken2012File)
			[+] if(bVerify==TRUE)
				[ ] ReportStatus("2012 Data File Conversion",PASS,"File Copied successfully")
			[+] else
				[ ] ReportStatus("2012 Data File Conversion",FAIL,"File Not Copied to location")
		[ ] 
		[ ] iDataFileConversion=DataFileConversion(sFileName,sVersion,"",sQuicken2012File)
		[+] if (iDataFileConversion==PASS)
			[ ] ReportStatus("2012 Data File Conversion",PASS,"File Converted from 2012 to 2014")
		[+] else
			[ ] ReportStatus("2012 Data File Conversion",FAIL,"File couldn't be Converted from 2012 to 2014")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("2012 Data File Conversion",FAIL,"Quicken Window Not found")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# DownloadedTransactionsPreferences_Migration #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC11_DownloadedTransactionsPreferences_Migration()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Downloaded Transactions  Preferences in file migrated from previous version
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC11_DownloadedTransactionsPreferences_Migration() appstate QuickenBaseState
	[ ] 
	[+] //Variable Decalration
		[ ] STRING sHandle
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Navigate to option 'Downloaded Transactions'---------------------------------------------------------------------------------
		[ ] iResult=SelectPreferenceType("Downloaded transactions")
		[+] if(iResult==PASS)
			[ ] ReportStatus("Preferences Window",PASS,"Preferences Window Opened")
			[ ] 
			[ ] 
			[ ] Preferences.SetActive()
			[ ] 
			[ ] 
			[ ] //After Transaction Download
			[+] if(Preferences.AfterDownloadingTransactions.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AfterDownloadingTransactions Text is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AfterDownloadingTransactions Text is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyAddToBankingRegister.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToBankingRegister Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToBankingRegister Checkbox is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyAddToInvestmentTransactionLists.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToInvestmentTransactionLists Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToInvestmentTransactionLists Checkbox is missing")
				[ ] 
			[ ] 
			[ ] 
			[ ] //During Transaction Download
			[+] if(Preferences.DownloadedTransactionsPreferences.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"DownloadedTransactionsPreferences Text is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"DownloadedTransactionsPreferences Text is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyCategorizeTransactions.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCategorizeTransactions Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCategorizeTransactions Checkbox is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyApplyQuickenSuggestedNameToPayee.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is missing")
				[ ] 
			[+] if(Preferences.CapitalizeFirstLetterOnlyInDownloadedPayeeNames.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is missing")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Renaming Rules
			[+] if(Preferences.YourRenamingRulesText.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"YourRenamingRulesText is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"YourRenamingRulesText is missing")
				[ ] 
			[+] if(Preferences.UseMyExistingRenamingRules.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"UseMyExistingRenamingRules Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"UseMyExistingRenamingRules Checkbox is missing")
				[ ] 
			[+] if(Preferences.RenamingRules.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"RenamingRules button is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"RenamingRules button is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyCreateRulesWhenIRenamePayees.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is missing")
				[ ] 
			[+] if(Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is missing")
				[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] Preferences.SetActive()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,False,1)
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Preferences Window",FAIL,"Preferences Window Not Opened")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Checking Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC12_VerifyCheckingAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Checking account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC12_VerifyCheckingAccountRegister() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] 
		[ ] 
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] STRING sPayBalance
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] // Fetch 2nd row from the given sheet
		[ ] lsTransactionData=lsExcelData[1]
		[ ] lsTransactionData[2]="Deposit"
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if (QuickenWindow.Exists(3))
		[ ] QuickenWindow.Kill()
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow,TRUE,10)
	[ ] 
	[+] if (iCreateDataFile == PASS)
		[ ] ReportStatus("Validate Data File ", PASS , "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] 
			[ ] //Select Checking Account---------------------------------------------------------------------------------------------------------------
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[+] if (iResult==PASS)
				[ ] // Add Deposit Transaction to Checking account
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],"DEP",lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] 
					[ ] ReportStatus("Add Transaction", PASS, "{lsTransactionData[2]} Transaction has been added successfully to {lsAddAccount[2]}.") 
					[ ] 
					[ ] iVerify=FindTransactionsInRegister(lsTransactionData[6])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Add Transaction", PASS, "{lsTransactionData[2]} Transaction couldn't  be added to {lsAddAccount[2]}.")
					[ ] 
				[+] if(BankingPopUp.Exists(5))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.TypeKeys(KEY_EXIT)
					[ ] WaitForState(BankingPopUp,false,1)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} selected.",FAIL," {lsAddAccount[2]} couldn't be selected")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Savings Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC13_VerifySavingsAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Savings account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	8/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC13_VerifySavingsAccountRegister() appstate none
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] lsTransactionData[2]="Deposit"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] iFileResult=OpenDataFile(sFileName)
		[+] if(iFileResult==PASS)
			[ ] ReportStatus("Open File ",PASS,"{sDataFile} File opened successfully")
			[ ] 
			[ ] 
			[ ] //Add A Savings account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] // Add Savings Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Savings Account", PASS, "Account -  {lsAddAccount[2]}  is created successfully")
				[+] if (QuickenWindow.Exists(60))
					[ ] QuickenWindow.SetActive()
					[ ] // Turn Off "Use Popup Register" option for MDI window type
					[ ] UsePopupRegister("OFF")
					[ ] //This will select Savings account on AccountBar
					[ ] 
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
					[ ] sleep(3)
					[ ] 
					[ ] 
					[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
					[ ] 
					[ ] 
					[ ] //Add Transaction to account
					[ ] iAddTransaction= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
					[ ] // 
					[+] // if(BankingPopUp.Exists(5))
						[ ] // sActual = BankingPopUp.EndingBalance.EndingBalance.GetText()
						[ ] // BankingPopUp.Close()
					[ ] 
					[ ] iVerify=FindTransactionsInRegister(lsTransactionData[6])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Savings Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open File ",FAIL,"File Not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Credit Card Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC14_VerifyCreditCardAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Credit Card account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	8/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC14_VerifyCreditCardAccountRegister() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] lsTransactionData[2]="Deposit"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] iFileResult=OpenDataFile(sFileName)
		[+] if(iFileResult==PASS)
			[ ] ReportStatus("Open File ",PASS,"{sDataFile} File opened successfully")
			[ ] 
			[ ] 
			[ ] //Add A Credit Card Account account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Add Credit Card Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Credit card Account", PASS, "Credit Card Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] //This will select credit card account on AccountBar
				[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
				[ ] 
				[ ] 
				[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] //Add Transaction to account
				[ ] iAddTransaction= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
				[ ] 
				[ ] 
				[ ] iVerify=FindTransactionsInRegister(lsTransactionData[6])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Credit Card Account", FAIL, "Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open File ",FAIL,"File Not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Cash Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC15_VerifyCashAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Cash account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	8/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC15_VerifyCashAccountRegister() appstate none
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[6]
		[ ] 
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] lsTransactionData[2]="Deposit"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] iFileResult=OpenDataFile(sFileName)
		[+] if(iFileResult==PASS)
			[ ] ReportStatus("Open File ",PASS,"{sDataFile} File opened successfully")
			[ ] 
			[ ] 
			[ ] //Add A Savings account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] // Add Cash Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Cash Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
				[ ] 
				[ ] //This will select Cash account on AccountBar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
				[+] if (iResult==PASS)
					[ ] 
					[ ] //Add Transaction to account
					[ ] iResult= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iResult==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "{lsTransactionData[2]} Transaction") 
						[ ] iVerify=FindTransactionsInRegister(lsTransactionData[6])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
						[+] else
							[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with payee {lsTransactionData[2]} couldn't be added successfully.")
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} selected.",FAIL," {lsAddAccount[2]} couldn't be selected")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Cash Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
		[+] else
			[ ] ReportStatus("Open File ",FAIL,"File Not opened")
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Filters in Account Register ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC34_FilterForAllDatesTransactionType()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if all Filters are present in Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account filters are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  19/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC34_FilterForAllDatesTransactionType() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] SetUp_AutoApi()
	[ ] 
	[ ] 
	[+] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Turn Off PopUp Registers
			[ ] UsePopupRegister("OFF")
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
			[ ] 
			[ ] 
			[ ] 
			[+] for(iLoop=1;iLoop<=4;iLoop++)
				[ ] 
				[+] if(iLoop==1)
					[ ] lsAddAccount=lsExcelData[1]
				[ ] 
				[+] if(iLoop==2)
					[ ] lsAddAccount=lsExcelData[2]
				[ ] 
				[+] if(iLoop==3)
					[ ] lsAddAccount=lsExcelData[3]
				[ ] 
				[+] if(iLoop==4)
					[ ] lsAddAccount=lsExcelData[4]
				[ ] 
				[ ] 
				[ ] 
				[ ] //Add An account--------------------------------------------------------------------------------------------------------------
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Add Checking Account
				[ ] iVerify = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
				[ ] //Report Status if checking Account is created
				[+] if (iVerify==PASS)
					[ ] ReportStatus("Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
					[ ] 
					[ ] 
					[ ] 
					[ ] //Select Account From Account Bar
					[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify if Filters are present",PASS,"Account {lsAddAccount[2]} selected successfully")
						[ ] 
						[ ] //Verify existence of all filters
						[ ] 
						[ ] //Transaction Filter exists
						[+] if(MDIClient.AccountRegister.TransactionTypeFilter.Exists(5))
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
							[ ] 
						[ ] 
						[ ] //Date Filter exists
						[+] if(MDIClient.AccountRegister.DateFilter.Exists(5))
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Date Filter is present in Account Register")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Date Filter does not exist in Account Register")
							[ ] 
						[ ] 
						[ ] //Type Filter exists
						[+] if(MDIClient.AccountRegister.TypeFilter.Exists(5))
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Type Filter is present in Account Register")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Type Filter does not exist in Account Register")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not added")
					[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter Contents in Account Register ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC35_FilterForAllTransactionType()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if content under Transaction and Type filters is correct	
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If all content under Transaction and Type filters is correct		
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  19/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC35_FilterForAllTransactionType() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,i
		[ ] 
		[ ] //String
		[ ] STRING sAccountName
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionContents,lsTypeContents,lsTransactionFilterData
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] for(iLoop=3;iLoop<=4;iLoop++)
			[ ] 
			[ ] //read account names
			[ ] lsExcelData=NULL
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAddAccount=lsExcelData[1]
				[ ] sAccountName=lsAddAccount[2]
				[ ] 
				[ ] 
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAddAccount=lsExcelData[2]
				[ ] sAccountName=lsAddAccount[2]
				[ ] 
				[ ] 
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=lsExcelData[3]
				[ ] sAccountName=lsAddAccount[2]
				[ ] 
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=lsExcelData[4]
				[ ] sAccountName=lsAddAccount[2]
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account From Account Bar
			[ ] iVerify=NULL
			[ ] // iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[ ] 
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {lsAddAccount[2]} selected successfully")
				[ ] 
				[ ] 
				[ ] //Transaction Filter exists
				[+] if(MDIClient.AccountRegister.TransactionTypeFilter.Exists(5))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register for {lsAddAccount[1]} type account")
					[ ] 
					[ ] lsTransactionContents=MDIClient.AccountRegister.TransactionTypeFilter.GetContents()
					[ ] 
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsTransactionContents);i++)
						[ ] 
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
						[ ] lsTransactionFilterData=lsExcelData[i]
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionFilterData[2]}*",lsTransactionContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsTransactionFilterData[2]} option present under Transaction Type Filter in Account Register for {sAccountName}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsTransactionFilterData[2]} option not found under Transaction Type Filter in Account Register for {sAccountName}")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] //Type Filter exists
				[+] if(MDIClient.AccountRegister.TypeFilter.Exists(5))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsTypeContents=MDIClient.AccountRegister.TypeFilter.GetContents()
					[ ] print("Actual")
					[ ] print(lsTypeContents)
					[ ] 
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsTypeContents);i++)
						[ ] print(lsTypeContents)
						[ ] 
						[+] if(iLoop==1||iLoop==2)
							[ ] 
							[ ] // Read data from excel sheet
							[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTypeFilterWorksheet)
							[ ] lsTransactionFilterData=lsExcelData[i]
						[ ] 
						[+] if(iLoop==3)
							[ ] // Read data from excel sheet
							[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTypeFilterWorksheet)
							[ ] lsTransactionFilterData=lsExcelData[i+3]
							[ ] 
						[ ] 
						[+] if(iLoop==4)
							[ ] // Read data from excel sheet
							[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTypeFilterWorksheet)
							[ ] lsTransactionFilterData=lsExcelData[i+6]
							[ ] 
						[ ] 
						[ ] print("Expected")
						[ ] print(lsTransactionFilterData)
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionFilterData[4]}*",lsTypeContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsTransactionFilterData[2]} option present under Type Filter in Account Register for {sAccountName}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsTransactionFilterData[2]} option not found under Type Filter in Account Register for {sAccountName}")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {lsAddAccount[2]} not selected")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Filters present in account register",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Date Filter Contents in Account Register ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC36_FilterForAllDates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if content under Date filter is correct
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If all content under Date filter is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  19/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC36_FilterForAllDates() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,i
		[ ] 
		[ ] 
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsDateContents,lsTransactionFilterData
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {lsAddAccount[2]} selected successfully")
				[ ] 
				[ ] 
				[ ] //Verify Date Filter Contents
				[+] if(MDIClient.AccountRegister.DateFilter.Exists(5))
					[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsDateContents=MDIClient.AccountRegister.DateFilter.GetContents()
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsDateContents);i++)
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
						[ ] lsTransactionFilterData=lsExcelData[i]
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionFilterData[2]}*",lsDateContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if correct data is present under filters",PASS,"{lsTransactionFilterData[2]} option present under Date Filter in Account Register for {lsAddAccount[1]} account")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"{lsTransactionFilterData[2]} option not found under Date Filter in Account Register for {lsAddAccount[1]} account")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
	[+] else
		[ ] ReportStatus("Verify Filters present in account register",FAIL,"Quicken Main Window Not found")
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC39_RegisterAllTransactionsFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "All Transactions" Filter from Transaction Dropdown menu in Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC37_RegisterAllTransactionsFilter() appstate QuickenBaseState
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
			[ ] // Fetch 2nd row from the given sheet
			[ ] lsTransactionFilterData=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] 
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iVerify == PASS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
			[+] else
				[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
		[ ] 
		[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC40_RegisterTransactions_UncategorizedFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Uncategorized" Option from Transaction Dropdown menu in Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC38_RegisterTransactions_UncategorizedFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsTransactionFilterData=lsExcelData[2]
				[ ] 
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iVerify == PASS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
			[+] else
				[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC41_RegisterTransactions_UnreconciledFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Unreconciled" Filter from Transaction Dropdown menu in Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC_128RegisterTransactions_UnreconciledFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsTransactionFilterData=lsExcelData[3]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iVerify == PASS)
					[ ] //Verify the All Transactions Filter
					[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[+] else
					[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC42_RegisterTransactions_ClearedFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Cleared" Option from Transaction Dropdown menu in Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC_129RegisterTransactions_ClearedFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[+] // if (QuickenWindow.Exists(3))
		[ ] // QuickenWindow.Kill()
		[ ] // App_Start(sCmdLine)
		[ ] // WaitForState(QuickenWindow,TRUE,10)
	[ ] 
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsTransactionFilterData=lsExcelData[4]
				[ ] 
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iVerify == PASS)
					[ ] 
					[ ] //Verify the All Transactions Filter
					[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[+] else
					[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC43_RegisterAllTransactions_UnclearedFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Uncleared" Option from Transaction Dropdown menu in Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC39_RegisterAllTransactions_UnclearedFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsTransactionFilterData=lsExcelData[5]
				[ ] 
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iVerify == PASS)
					[ ] 
					[ ] //Verify the All Transactions Filter
					[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[+] else
					[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC44_RegisterAllTransactions_FlaggedFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will Verify "Flagged" Option from Transaction Dropdown menu in Account Register
		[ ] // 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC40_RegisterAllTransactions_FlaggedFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsTransactionFilterData=lsExcelData[6]
				[ ] 
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iVerify == PASS)
					[ ] 
					[ ] //Verify the All Transactions Filter
					[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[+] else
					[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC44_RegisterAllTransactions_FlaggedFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will Verify "Flagged" Option from Transaction Dropdown menu in Account Register
		[ ] // 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC41_RegisterAllType_PaymentsFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsTransactionFilterData=lsExcelData[6]
				[ ] 
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iVerify == PASS)
					[ ] 
					[ ] //Verify the All Transactions Filter
					[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[+] else
					[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC44_RegisterAllTransactions_FlaggedFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will Verify "Flagged" Option from Transaction Dropdown menu in Account Register
		[ ] // 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC42_RegisterAllType_DepositsFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsTransactionFilterData=lsExcelData[6]
				[ ] 
				[ ] 
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iVerify == PASS)
					[ ] 
					[ ] //Verify the All Transactions Filter
					[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[+] else
					[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] ////############# Verify Date Filter in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC43_54BankingRegisterDateFilter_AllDates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify all options under "All Dates" Dropdown menu from Business  Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all  details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC43_54BankingRegisterDateFilter_AllDates() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Datetime
		[ ] DATETIME dtDateTime,newDateTime
		[ ] 
		[ ] //Integer
		[ ] INTEGER iCount,i,iCounter=0, j,iVerify,iSelectDate
		[ ] //INTEGER iDateDropdownCount=12
		[ ] 
		[ ] //String
		[ ] STRING sNewDate,sCompareDay,sCompareMonth,sCompareYear
		[ ] 
		[ ] STRING sDay,sMonth,sYear
		[ ] 
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] //STRING sDateFormat="m-d-yyyy"
		[ ] //STRING sDateFormat="dd-mm-yyyy"
		[ ] STRING sDateFormat="m/d/yyyy"
		[ ] STRING sCompareDayFormat="d"
		[ ] STRING sCompareMonthFormat="m"
		[ ] STRING sCompareYearFormat="yyyy"
		[ ] 
		[ ] 
		[ ] STRING sCustomDate1,sCustomDate2
		[ ] 
		[ ] STRING sAccountDate="1/1/2011"
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsDate,lsDateFilterData
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet ) //sAccountWorksheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] //Read Transaction Data
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[4]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[ ] 
	[+] if (iCreateDataFile == PASS)
		[ ] //At times stops recognizing controls so just restarting the quicken//
		[+] if (QuickenWindow.Exists(2))
			[ ] QuickenWindow.kill()
			[ ] WaitForState(QuickenWindow , false ,10)
			[ ] App_Start(sCmdLine)
			[ ] WaitForState(QuickenWindow , true ,20)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], sAccountDate)
		[ ] 
		[ ] 
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
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
			[ ] //Verify Dates for transactions-------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For All Dates Transactions---------------------------------------------------------------------------------------------------------------
				[ ] sNewDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sNewDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] lsDateFilterData=lsExcelData[1]
				[ ] 
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] sleep(SHORT_SLEEP)
				[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For This Month Transactions------------------------------------------------------------------------------------------------------------
				[ ] sNewDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sNewDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] //This Month---------------------------------
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] lsDateFilterData=lsExcelData[2]
				[ ] 
				[ ] 
				[ ] // //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] sleep(SHORT_SLEEP)
				[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For Last Month Transaction--------------------------------------------------------------------------------------------------------------
				[ ] dtDateTime= GetDateTime ()
				[ ] sCompareDay = FormatDateTime ([DATETIME] dtDateTime,  sCompareDayFormat) 
				[ ] 
				[ ] 
				[ ] 
				[+] // if(sCompareDay=="28"||sCompareDay=="29"||sCompareDay=="30"||sCompareDay=="31")
					[ ] // 
					[ ] // sNewDate=ModifyDate(-35)
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // 
					[ ] // sNewDate=ModifyDate(-28)
					[ ] // 
				[ ] 
				[ ] //Get date for Bill
				[ ] sDay=FormatDateTime(GetDateTime(), "d")
				[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
				[+] if(val(sMonth)==1)
					[ ] iSelectDate=12
				[+] else
					[ ] iSelectDate=val(sMonth)-1
				[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
				[ ] sDate="{iSelectDate}" +"/"+sDay+"/"+sYear
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3],sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[3]
				[ ] 
				[ ] 
				[ ] // //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] // 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For Last 30 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-25,sDateFormat)
				[ ] 
				[ ] // // Verify total Transaction count under filter
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[4]
				[ ] 
				[ ] 
				[ ] // //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] // 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last 60 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-55,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[5]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last 90 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sNewDate=ModifyDate(-85,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sNewDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[6]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last 12 Months-------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sNewDate=ModifyDate(-200,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sNewDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[7]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For This Quarter Transactions----------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] //This Month---------------------------------
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] lsDateFilterData=lsExcelData[8]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] //For Last Quarter Transaction Date-----------------------------------------------------------------------------------------------------
				[ ] 
				[ ] dtDateTime= GetDateTime ()
				[ ] sCompareMonth = FormatDateTime ([DATETIME] dtDateTime,  sCompareMonthFormat) 
				[ ] 
				[ ] 
				[ ] 
				[+] if(sCompareMonth=="3"||sCompareMonth=="6"||sCompareMonth=="9"||sCompareMonth=="12")
					[ ] 
					[ ] //For Last Quarter Month
					[ ] sDate=ModifyDate(-100,sDateFormat)
					[ ] 
					[ ] 
				[+] else if(sCompareMonth=="2"||sCompareMonth=="5"||sCompareMonth=="8"||sCompareMonth=="11")
					[ ] 
					[ ] sDate=ModifyDate(-65,sDateFormat)
					[ ] 
					[ ] 
				[+] else if(sCompareMonth=="1"||sCompareMonth=="4"||sCompareMonth=="7"||sCompareMonth=="10")
					[ ] 
					[ ] sDate=ModifyDate(-35,sDateFormat)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] // //Get date for Bill
				[ ] // sDay=FormatDateTime(GetDateTime(), "d")
				[ ] // sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
				[ ] // iSelectDate=val(sMonth)-3 //Get date of last quater
				[ ] // sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
				[ ] // sDate="{iSelectDate}" +"/"+sDay+"/"+sYear
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[9]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For This Year Transaction Date---------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[10]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] //For Last Year Transaction Date---------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] //sNewDate=ModifyDate(-365)
				[ ] //Get date for Bill
				[ ] sDay=FormatDateTime(GetDateTime(), "d")
				[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
				[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
				[ ] iSelectDate=val(sYear)-1
				[ ] 
				[ ] sDate= sMonth+"/"+sDay+"/"+"{iSelectDate}"
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[11]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
				[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] //Custom date----------------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sNewDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sNewDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
				[ ] 
				[ ] 
				[ ] dtDateTime= GetDateTime ()
				[ ] newDateTime = AddDateTime (dtDateTime, -15)
				[ ] sCustomDate1 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
				[ ] 
				[ ] newDateTime = AddDateTime (dtDateTime, +15)
				[ ] sCustomDate2 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
				[ ] 
				[ ] MDIClient.AccountRegister.DateFilter.Select(12)
				[+] if(RegisterCustomDate.Exists(5))
					[ ] RegisterCustomDate.CustomDate1.SetText(sCustomDate1)
					[ ] RegisterCustomDate.CustomDate2.SetText(sCustomDate2)
					[ ] RegisterCustomDate.OK.Click()
					[ ] 
					[ ] //Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
					[ ] //Fetch 2nd row from the given sheet
					[ ] lsDateFilterData=lsExcelData[12]
					[ ] 
					[ ] 
					[ ] //Select Account from Account Bar
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] 
					[ ] //Verify the All Transactions Filter
					[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} matched to filter {lsDateFilterData[2]}") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} with date {sNewDate} not matched to filter {lsDateFilterData[2]}") 
						[ ] 
					[ ] 
					[ ] //Delete Transaction From Register
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[ ] ReportStatus("Add Transaction", iVerify, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[ ] 
					[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  not created")
			[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not created")
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] ////############# Verify Search Window in Account Register ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC55_RegisterSearchFeatureExists(5)
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify existence of Search window in  Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If search window exists			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  19/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC55_RegisterSearchFeatureExists() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountName
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] RegisterSetUp()
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sAccountName} selected successfully")
				[ ] 
				[ ] 
				[ ] UsePopupRegister("OFF")
				[+] if(MDIClient.AccountRegister.SearchWindow.Exists(3))
					[ ] ReportStatus("Register Search Feature Exists ", PASS, "Search Window Exists in Account Register of {lsAddAccount[1]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Register Search Feature Exists ", FAIL, "Search Window does not Exists in Account Register")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sAccountName} not selected")
				[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify functionality of Search window in  Account Register ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC56_RegisterSearchFeatureFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality of Search window in  Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If search window functionality is correct		
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  19/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC56_RegisterSearchFeatureFunctionality() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify,iNum
		[ ] STRING sTransactionCount,sNum
		[ ] LIST OF STRING lsTransactionData 
		[ ] sDateFormat= "m/d/yyyy"
		[ ] sDate=FormatDateTime (GetDateTime (),  sDateFormat) 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] 
			[ ] lsExcelData=NULL
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
			[ ] 
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] 
			[ ] UsePopupRegister("OFF")
			[ ] 
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Register Search feature",PASS,"Account {lsAddAccount[2]} selected successfully ")
				[ ] 
				[ ] 
				[ ] 
				[+] if(MDIClient.AccountRegister.SearchWindow.Exists(3))
					[ ] ReportStatus("Register Search Feature Exists ", PASS, "Search Window Exists in Account Register of {lsAddAccount[1]} type account")
					[ ] 
					[ ] 
					[ ] 
					[ ] // Checking Account
					[+] if(iLoop==1)
						[ ] 
						[ ] 
						[ ] // Add Transactions in Register for Checking Account
						[+] for(i=4;i<=6;i++)
							[ ] 
							[ ] // // Read data from excel sheet 
							[ ] lsExcelData=NULL
							[ ] lsTransactionData=NULL
							[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
							[ ] lsTransactionData=lsExcelData[i]
							[ ] 
							[ ] 
							[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
							[ ] ReportStatus("Add Transaction", iVerify, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] // Verify Search functionality for Checking Account
						[+] for(i=1;i<=5;i++)
							[ ] 
							[ ] 
							[ ] // // Read data from excel sheet
							[ ] lsExcelData=NULL
							[ ] lsTransactionData=NULL
							[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sSearchFilterWorksheet)
							[ ] lsTransactionData=lsExcelData[i]
							[ ] 
							[ ] 
							[ ] MDIClient.AccountRegister.SearchWindow.SetText(lsTransactionData[2])
							[ ] 
							[ ] // // Match value obtained from register to value given in 
							[ ] sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
							[ ] 
							[ ] iNum=val(lsTransactionData[3])
							[ ] sNum=Str(iNum)
							[ ] 
							[ ] bMatch=MatchStr("*{sNum}*",sTransactionCount)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Register Search Feature Functionality",PASS,"Transaction displayed correctly when searched by {lsTransactionData[1]} for account {lsAddAccount[2]} which is of type {lsAddAccount[1]}")
							[+] else
								[ ] ReportStatus("Register Search Feature Functionality",FAIL,"Transaction not displayed correctly when searched by {lsTransactionData[1]} for account {lsAddAccount[2]} which is of type {lsAddAccount[1]}")
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
					[ ] //Savings,Credit Card and Cash Accounts
					[+] if(iLoop>1)
						[ ] 
						[ ] 
						[ ] // Add Transactions in Register for Savings,Credit Card and Cash Accounts
						[+] for(i=3;i<=5;i++)
							[ ] 
							[ ] // // Read data from excel sheet 
							[ ] lsExcelData=NULL
							[ ] lsTransactionData=NULL
							[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
							[ ] lsTransactionData=lsExcelData[i]
							[ ] 
							[ ] 
							[ ] iAddTransaction= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
							[ ] 
							[+] if(iAddTransaction==PASS)
								[ ] ReportStatus("Add Transaction", PASS, "{lsTransactionData[2]} Transaction is added to {lsAddAccount[2]} account") 
							[+] else
								[ ] ReportStatus("Add Transaction", FAIL, "{lsTransactionData[2]} Transaction is not added to {lsAddAccount[2]} account") 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] // Verify Search functionality for Savings , Credit Card and Cash Accounts
						[+] for(i=6;i<=9;i++)
							[ ] 
							[ ] 
							[ ] // // Read data from excel sheet
							[ ] lsExcelData=NULL
							[ ] lsTransactionData=NULL
							[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sSearchFilterWorksheet)
							[ ] lsTransactionData=lsExcelData[i]
							[ ] 
							[ ] 
							[ ] MDIClient.AccountRegister.SearchWindow.SetText(lsTransactionData[2])
							[ ] 
							[ ] // // Match value obtained from register to value given in 
							[ ] sTransactionCount  = MDIClient.AccountRegister.EndingBalance.NumOfTransactions.GetText()
							[ ] 
							[ ] iNum=val(lsTransactionData[3])
							[ ] sNum=Str(iNum)
							[ ] 
							[ ] bMatch=MatchStr("*{sNum}*",sTransactionCount)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Register Search Feature Functionality",PASS,"Transaction displayed correctly when searched by {lsTransactionData[1]} for account {lsAddAccount[2]} which is of type {lsAddAccount[1]}")
							[+] else
								[ ] ReportStatus("Register Search Feature Functionality",FAIL,"Transaction not displayed correctly when searched by {lsTransactionData[1]} for account {lsAddAccount[2]} which is of type {lsAddAccount[1]}")
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
				[+] else
					[ ] ReportStatus("Register Search Feature Functionality ", FAIL, "Search Window does not Exists in Account Register of {lsAddAccount[1]} type account")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Register Search Feature Functionality ", FAIL, "Account {lsAddAccount[2]} not selected")
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
	[+] else 
		[ ] ReportStatus("Register Search Feature Functionality",FAIL,"Quicken Window not available")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Enter Transactions in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC88_VerifyEnterTransactionsInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This will verify that transaction is added when user enters details for a new transaction in the register and Clicks Enter button
		[ ] // 
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If transaction is added in Account Register		
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  20/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC88_VerifyEnterTransactionsInRegister() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAccountBalance={"9,908.69","1,032.15","-523.62","132.50"}
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[2]
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[4]
		[ ] 
		[ ] NUMBER nNum
		[ ] STRING sNum
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iVerify = DataFileCreate(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Enter Transaction", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] 
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Enter Transaction", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not added")
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[ ] 
			[+] if(iVerify==PASS)
				[ ] //ReportStatus("Verify Enter Transaction",PASS,"Account {lsAddAccount[2]} selected successfully")
				[ ] 
				[ ] 
				[ ] STRING sDate=ModifyDate(-5, "m/d/yyyy")
				[ ] print(sDate)
				[ ] 
				[ ] //Add Transaction Values
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDate)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[+] if(iLoop==1)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[5])
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[6])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[7])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[8])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[+] if (iLoop==3)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[3])
				[ ] sleep(SHORT_SLEEP)
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] lsTransactionActual=GetTransactionsInRegister(lsTransactionData[6])
				[ ] 
				[ ] //Verify if transaction is added with all correct values
				[ ] 
				[ ] //Verify Memo in Transaction
				[+] if(MatchStr("*{lsTransactionData[7]}*",lsTransactionActual[1]))
					[ ] ReportStatus("Verify Enter Transaction",PASS,"{lsTransactionData[7]}  matched correctly for transaction of {lsAddAccount[2]} type")
				[+] else
					[ ] ReportStatus("Verify Enter Transaction",FAIL,"{lsTransactionData[7]}  not matched correctly to {lsTransactionActual} for transaction of {lsAddAccount[2]} type")
					[ ] 
				[ ] 
				[ ] //Verify Payee Name in Transaction
				[+] if(MatchStr("*{lsTransactionData[6]}*",lsTransactionActual[1]))
					[ ] ReportStatus("Verify Enter Transaction",PASS,"{lsTransactionData[6]}  matched correctly for transaction of {lsAddAccount[2]} type")
				[+] else
					[ ] ReportStatus("Verify Enter Transaction",FAIL,"{lsTransactionData[6]}  not matched correctly to {lsTransactionActual} for transaction of {lsAddAccount[2]} type")
					[ ] 
				[ ] 
				[ ] //Verify Balances in Transaction
				[ ] sActualBalanceText=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
				[+] // if (iLoop>3)
					[ ] // sActualBalanceText=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
				[+] // else
					[ ] // sActualBalanceText=MDIClient.AccountRegister.Balances.OnlineBalance.GetText()
				[+] if(sActualBalanceText==lsAccountBalance[iLoop])
					[ ] ReportStatus("Verify Enter Transaction",PASS,"Correct Ending Balance {sActualBalanceText} Displayed in Account Register for transaction of {lsAddAccount[2]} type")
				[+] else
					[ ] ReportStatus("Verify Enter Transaction",FAIL,"Wrong Ending Balance {sActualBalanceText} Displayed in Account Register;Expected is {lsAccountBalance[iLoop]} for transaction of {lsAccountBalance[iLoop]} type")
					[ ] 
					[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Error during Data file creation for file -  {sFileName} ")
		[ ] 
		[+] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
[ ] 
[ ] 
[+] ////############## Verify Edit Button Account Register #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC89_VerifyEditButtonInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Button functionality in Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account filters are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC89_VerifyEditButtonInRegister() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] STRING sEditTransactionsAction="Edit transaction(s)"
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[4]
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] 
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify Edit Transaction",PASS,"Account {lsAddAccount[2]} selected successfully")
				[ ] 
				[ ] 
				[ ] iVerify=AccountActionsOnTransaction(sMDIWindow ,lsTransactionData[6],sEditTransactionsAction)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Edit Transaction", PASS, "{sEditTransactionsAction} Action successful") 
					[ ] 
					[ ] //Verify if Find and replace window is opened
					[+] if(FindAndReplace.Exists(3))
						[ ] ReportStatus("Verify Edit Transaction", PASS, "Find and Replace window opened") 
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify if correct transaction is displayed in find and replace with all correct values
						[ ] lsTransactionActual=GetTransactionsUsingEditTransactions(lsTransactionData[6])
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] if(MatchStr("*{lsAddAccount[2]}*{lsTransactionData[6]}*{lsTransactionData[8]}*{lsTransactionData[7]}*",lsTransactionActual[1]))
							[ ] ReportStatus("Verify Enter Transaction",PASS,"{lsTransactionData[6]} for account {lsAddAccount[2]} matched correctly")
						[+] else
							[+] ReportStatus("Verify Enter Transaction",FAIL,"{lsTransactionData[6]} for account {lsAddAccount[2]} not matched correctly to {lsTransactionActual}")
								[ ] 
					[+] else
						[ ] ReportStatus("Verify Edit Transaction", FAIL, "Find and Replace window not opened") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Edit Transaction", FAIL, "{sEditTransactionsAction} Action Error") 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Edit Transaction",FAIL,"Account {lsAddAccount[2]} not selected")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Edit Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify New Transactions in Account Register Actions###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC91_VerifyNewTransactionsInRegisterActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This will verify that transaction is added when user clicks on new in more actions menu and enters details for a new transaction in the register
		[ ] // 
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If transaction is added in Account Register		
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  21/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC91_VerifyNewTransactionsInRegisterActions() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] NUMBER nAccBalActual ,nAccBalExpected 
		[ ] 
		[ ] // Read transaction data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[4]
		[ ] // Read Account data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iVerify = DataFileCreate(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Enter Transaction", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] 
			[ ] 
			[+] if(iLoop==2)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Add Checking Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Enter Transaction", PASS, "Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //Select Account From Account Bar
				[ ] 
				[ ] 
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[ ] 
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Enter Transaction",PASS,"Account {lsAddAccount[2]} selected successfully")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] STRING sDate=ModifyDate(-5, "m/d/yyyy")
					[ ] print(sDate)
					[ ] 
					[ ] //Add Transaction Values
					[ ] 
					[ ] AccountActionsOnTransaction(sMDIWindow, lsTransactionData[6],"New","",iXpos ,iYpos)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDate)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
					[+] if(iLoop==1)
						[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[5])
						[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[6])
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[7])
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[8])
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransactionData[3])
					[ ] sleep(SHORT_SLEEP)
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] lsTransactionActual=GetTransactionsInRegister(lsTransactionData[6])
					[ ] 
					[ ] //Verify if transaction is added with all correct values
					[+] for(i=5;i<=7;i++)
						[ ] 
						[ ] 
						[+] if(MatchStr("*{lsTransactionData[i]}*",lsTransactionActual[1]))
							[ ] ReportStatus("Verify Enter Transaction",PASS,"{lsTransactionData[i]}  matched correctly")
						[+] else
							[ ] ReportStatus("Verify Enter Transaction",FAIL,"{lsTransactionData[i]}  not matched correctly to {lsTransactionActual}")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] //Verify Balances
					[ ] //Expected balance
					[+] if (iLoop==3)
						[ ] nAccBalExpected = -VAL(lsAddAccount[3]) + VAL(lsTransactionData[3])
					[+] else
						[ ] nAccBalExpected = VAL(lsAddAccount[3]) + VAL(lsTransactionData[3])
					[ ] 
					[ ] //Actual balance
					[ ] 
					[ ] sActualBalanceText=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
					[ ] 
					[ ] nAccBalActual =VAL (StrTran (sActualBalanceText,",",""))
					[+] if(nAccBalActual==nAccBalExpected)
						[ ] ReportStatus("Verify Enter Transaction",PASS,"Correct Ending Balance {sActualBalanceText} Displayed in Account Register")
					[+] else
						[ ] ReportStatus("Verify Enter Transaction",FAIL,"Wrong Ending Balance {sActualBalanceText} Displayed in Account Register;Expected is {nAccBalExpected} ")
						[ ] 
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Enter Transaction", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
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
			[+] else
				[ ] ReportStatus("Checking Account", FAIL, "Account -  {lsAddAccount[2]}  is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Error during Data file creation for file -  {sFileName} ")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Delete Transactions in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC92_VerifyDeleterTransactionsInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if transaction is deleted successfully from Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If transaction is deleted successfully		
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  21/2/2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC92_VerifyDeleteTransactionsInRegister() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] 
		[ ] 
	[ ] sDate=ModifyDate(-5, "m/d/yyyy")
	[ ] //
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Delete Transaction", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[ ] nActualAmount =VAL(lsAddAccount[3])
			[ ] //Add Checking Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Delete Transaction", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //Select Account From Account Bar
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Delete Transaction",PASS,"Account {lsAddAccount[2]} selected successfully")
					[ ] 
					[ ] 
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
					[ ] lsTransactionData=lsExcelData[4]
					[ ] 
					[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Delete Transaction", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] iResult=AccountActionsOnTransaction(sMDIWindow, lsTransactionData[6],"Delete","",iXpos ,iYpos)
						[ ] //Delete Transaction
						[+] if (iResult==PASS)
							[+] if (AlertMessage.Exists(2))
								[ ] AlertMessage.Yes.Click()
								[ ] 
								[ ] //Verify delete operation
								[ ] iVerify=FindTransactionsInRegister(lsTransactionData[6])
								[+] if(iVerify==FAIL)
									[ ] 
									[+] if (AlertMessage.Exists(2))
										[ ] AlertMessage.OK.Click()
										[ ] WaitForState(AlertMessage , false , 1)
									[ ] 
									[ ] DlgFindAndReplace.SetActive()
									[ ] DlgFindAndReplace.DoneButton.Click()
									[ ] WaitForState(DlgFindAndReplace , false , 2)
									[ ] ReportStatus("Verify Delete Transaction", PASS, "Transaction with payee: {lsTransactionData[6]} deleted successfully.") 
									[ ] //Verify Balances
									[ ] sActualBalanceText=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
									[ ] nAmount =VAL(StrTran(sActualBalanceText, ",",""))
									[+] if(nActualAmount==nAmount)
										[ ] ReportStatus("Verify Enter Transaction",PASS,"Ending Balance after deleting the transaction: {nActualAmount} is as expected {nAmount}.")
									[+] else
										[ ] ReportStatus("Verify Enter Transaction",FAIL,"Ending Balance after deleting the transaction: {nActualAmount} is NOT as expected {nAmount}.")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Delete Transaction", FAIL, "Transaction with payee: {lsTransactionData[6]} couldn't be deleted.") 
									[ ] 
							[+] else
								[ ] ReportStatus("Verify Delete Transaction", FAIL, "Delete transaction confirmation dialog didn't appear.") 
						[+] else
							[ ] ReportStatus("Verify Delete Transaction", FAIL, "Delete transaction using actions couldn't be performed.") 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Delete Transaction", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
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
				[+] else
					[ ] ReportStatus("Verify Delete Transaction",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Delete Transaction", FAIL, "Checking Account -  {lsAddAccount[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Delete Transaction ", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Delete Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] //
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] ////############# Verify Mark As A Clear Transactions in Account Register ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC94_VerifyMarkAsClearTransactionsInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Mark As A Clear Transactions option in account register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If transaction is cleared
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  22/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC94_VerifyMarkAsClearTransactionsInRegister() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] STRING sClearedAccountAction="Reconcile/#2"
		[ ] STRING sFilterType="Transaction"
		[ ] STRING sFilterName="Cleared"
		[ ] STRING sExpectedCountOfTransactionsCleared="3"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Mark As Clear Transaction", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[ ] 
			[ ] //Add Checking Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify Mark As Clear Transaction", iVerify, "Checking Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Select Account From Account Bar
				[ ] 
				[ ] // Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
				[ ] lsTransactionData=lsExcelData[4]
				[ ] 
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Mark As Clear Transaction", PASS, "{lsAddAccount[2]} Account is selected") 
					[ ] 
					[+] for(i=4;i<=6;i++)
						[ ] 
						[ ] // Read data from excel sheet
						[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
						[ ] lsTransactionData=lsExcelData[i]
						[ ] 
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Mark As Clear Transaction", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] iVerify=AccountActionsOnTransaction(sMDIWindow , lsTransactionData[6],"Reconcile",sFilterName ,iXpos ,iYpos)
							[ ] MDIClient.AccountRegister.SearchWindow.SetText("")
							[+] if(iVerify==PASS)
								[ ] ReportStatus("Verify Mark As Clear Transaction", PASS, "Account Action {sClearedAccountAction} completed") 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Mark As Clear Transaction", FAIL, "Account Action {sClearedAccountAction} not completed") 
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Mark As Clear Transaction", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
							[ ] 
					[ ] VerifyAccountRegisterFilter(sFilterType,sFilterName ,sExpectedCountOfTransactionsCleared)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Mark As Clear Transaction", PASS, "{lsAddAccount[2]} Account not selected") 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Mark As Clear Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Go to Matching Transfer in Account Register #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC95_VerifyGoToMatchingTransferInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Go to Matching Transfer option in account register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If matching transfer is selected	
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC95_VerifyGoToMatchingTransferInRegister() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] STRING sGotToTransferAction="Go To matching transfer"
		[ ] 
		[ ] List of STRING lsTxfrReminder={"Transfer","Payee1","20", "{sDate}","Checking 02 Account","Checking Account"}
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Go to Matching Transfer", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount1=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] //Add Checking 01 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Go to Matching Transfer", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
				[ ] lsAddAccount2=lsExcelData[2]
				[ ] 
				[ ] //Add Checking 02 Account
				[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
				[ ] //Report Status if checking Account is created
				[+] if (iVerify==PASS)
					[ ] ReportStatus("Verify Go to Matching Transfer", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
					[ ] 
					[ ] 
					[ ] //Select Checking 02 Account From Account Bar
					[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Go to Matching Transfer",PASS,"Account {lsAddAccount2[2]} selected successfully")
						[ ] 
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
						[ ] lsTransactionData=lsExcelData[4]
						[ ] 
						[ ] //Add Checking Transaction
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7], lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Go to Matching Transfer", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //Add a Transfer Reminder
							[ ] 
							[ ] NavigateReminderDetailsPage(lsTxfrReminder[1],lsTxfrReminder[2])
							[ ] iVerify=AddReminderInDataFile(lsTxfrReminder[1],lsTxfrReminder[2],lsTxfrReminder[3],lsTxfrReminder[4],"",lsTxfrReminder[5],lsTxfrReminder[6])
							[+] if(iVerify==PASS)
								[ ] ReportStatus("Verify Go to Matching Transfer", PASS, "Transfer reminder is added") 
								[ ] 
								[ ] //Navigate to bills tab
								[ ] NavigateQuickenTab(sTAB_BILL)	
								[ ] 
								[ ] //Enter Bill
								[ ] Bills.Enter.Click()
								[ ] 
								[+] if(EnterExpenseTransaction.Exists(3))
									[ ] EnterExpenseTransaction.SetActive()
									[ ] EnterExpenseTransaction.EnterTransaction.Click()
									[ ] 
									[ ] //Select Account from account bar
									[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount1[2],ACCOUNT_BANKING)
									[+] if(iVerify==PASS)
										[ ] AccountActionsOnTransaction(sMDIWindow ,"[{lsAddAccount2[2]}]",sGotToTransferAction,"",iXpos ,iYpos)
										[+] if(QuickenMainWindow.QWNavigator1.AccountName.GetText()==lsAddAccount2[2])
											[ ] ReportStatus("Verify Go to Matching Transfer", PASS, "Navigated to correct account") 
											[ ] 
											[ ] iVerify=FindTransactionsInRegister("[{lsAddAccount2[2]}]")
											[+] if(iVerify==PASS)
												[ ] ReportStatus("Verify Go to Matching Transfer", PASS, "Go To Transfer functionality is correct") 
											[+] else
												[ ] ReportStatus("Verify Go to Matching Transfer", FAIL, "Go To Transfer option error") 
												[ ] 
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Go to Matching Transfer", FAIL, "Not Navigated to correct account") 
											[ ] 
											[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Go to Matching Transfer",FAIL,"Account {lsAddAccount2[2]} not selected")
								[+] else
									[ ] ReportStatus("Verify Go to Matching Transfer", FAIL, "Enter Expense Transaction dialog didn't appear.") 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Go to Matching Transfer", FAIL, "Transfer reminder is added") 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Go to Matching Transfer", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Go to Matching Transfer",FAIL,"Account {lsAddAccount2[2]} not selected")
				[+] else
					[ ] ReportStatus("Verify Go to Matching Transfer", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Go to Matching Transfer", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Go to Matching Transfer", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Go to Matching Transfer",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Move Transactions in Account Register #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC96_VerifyMoveTransactionsInRegisterCancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Move transaction option in account register and then click on cancel button on Confirmation dialog
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If  transaction is not moved			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  22/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC96_VerifyMoveTransactionsInRegisterCancel() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sMoveAccountAction="Move transaction(s)"
		[ ] STRING sMoveCancelExpectedNumberOfTransactionsC1="0"
		[ ] STRING sMoveCancelExpectedNumberOfTransactionsC2="1"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount1=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] //Add Checking 01 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
				[ ] lsAddAccount2=lsExcelData[2]
				[ ] 
				[ ] //Add Checking 02 Account
				[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
				[ ] //Report Status if checking Account is created
				[+] if (iVerify==PASS)
					[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
					[ ] 
					[ ] 
					[ ] //Select Checking 02 Account From Account Bar
					[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Move Transaction Cancel  button",PASS,"Account {lsAddAccount2[2]} selected successfully")
						[ ] 
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
						[ ] lsTransactionData=lsExcelData[4]
						[ ] 
						[ ] //Add Checking Transaction
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] 
							[ ] 
							[ ] //Move transaction from Checking 02 account
							[ ] iVerify=AccountActionsOnTransaction(sMDIWindow ,lsTransactionData[6],sMoveAccountAction,"",iXpos ,iYpos)
							[ ] //Click on Cancel button of move transaction window
							[+] if(iVerify==PASS)
								[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "{sMoveAccountAction} completed") 
								[+] if(MoveTransactionS.Exists(3))
									[ ] MoveTransactionS.Cancel.Click()
								[ ] 
								[ ] 
								[ ] //Verify if Transacton is present in Checking 02 account register
								[ ] iVerify=VerifyTransactionInAccountRegister(lsTransactionData[6], sMoveCancelExpectedNumberOfTransactionsC2)
								[ ] ReportStatus("Verify Move Transaction Cancel  button", iVerify, "{sMoveAccountAction} in {lsAddAccount2[2]} account register") 
								[ ] 
								[ ] 
								[ ] 
								[ ] //Select Checking 01 Account From Account Bar
								[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount1[2],ACCOUNT_BANKING)
								[+] if(iVerify==PASS)
									[ ] ReportStatus("Verify Move Transaction Cancel  button",PASS,"Account {lsAddAccount1[2]} selected successfully")
									[ ] 
									[ ] 
									[ ] //Verify if Transaction is present in Checking 02 account register
									[ ] iVerify=VerifyTransactionInAccountRegister(lsTransactionData[6], sMoveCancelExpectedNumberOfTransactionsC1)
									[ ] 
									[ ] ReportStatus("Verify Move Transaction Cancel  button", iVerify, "{sMoveAccountAction} in {lsAddAccount1[2]} account register") 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Move Transaction Cancel  button",FAIL,"Account {lsAddAccount1[2]} not selected")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "{sMoveAccountAction} not completed") 
						[+] else
							[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Move Transaction Cancel  button",FAIL,"Account {lsAddAccount2[2]} not selected")
				[+] else
					[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Move Transaction Cancel  button",FAIL,"Quicken Main Window Not found")
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Move Transactions in Account Register #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC97_VerifyMoveTransactionsInRegisterOK()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Move transaction option in account register and then click on OK button on Confirmation dialog
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If transaction is moved to selected account		
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  21/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC97_VerifyMoveTransactionsInRegisterOK() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sMoveAccountAction="Move transaction(s)"
		[ ] STRING sMoveCancelExpectedNumberOfTransactionsC1="1"
		[ ] STRING sMoveCancelExpectedNumberOfTransactionsC2="0"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount1=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] //Add Checking 01 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
				[ ] lsAddAccount2=lsExcelData[2]
				[ ] 
				[ ] //Add Checking 02 Account
				[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
				[ ] //Report Status if checking Account is created
				[+] if (iVerify==PASS)
					[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
					[ ] 
					[ ] 
					[ ] //Select Checking 02 Account From Account Bar
					[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Move Transaction Cancel  button",PASS,"Account {lsAddAccount2[2]} selected successfully")
						[ ] 
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
						[ ] lsTransactionData=lsExcelData[4]
						[ ] 
						[ ] //Add Checking Transaction
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] 
							[ ] 
							[ ] //Move transaction from Checking 02 account
							[ ] iVerify=AccountActionsOnTransaction( sMDIWindow, lsTransactionData[6],sMoveAccountAction,"",iXpos ,iYpos)
							[ ] //Click on Cancel button of move transaction window
							[+] if(iVerify==PASS)
								[ ] ReportStatus("Verify Move Transaction Cancel  button", PASS, "{sMoveAccountAction} completed") 
								[+] if(MoveTransactionS.Exists(3))
									[ ] MoveTransactionS.SetActive()
									[ ] MoveTransactionS.OK.Click()
								[ ] 
								[ ] 
								[ ] //Verify if Transacton is present in Checking 02 account register
								[ ] iVerify=VerifyTransactionInAccountRegister(lsTransactionData[6], sMoveCancelExpectedNumberOfTransactionsC2)
								[ ] ReportStatus("Verify Move Transaction OK button", iVerify, "{sMoveAccountAction} in {lsAddAccount2[2]} account register") 
								[ ] 
								[ ] 
								[ ] 
								[ ] //Select Checking 01 Account From Account Bar
								[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount1[2],ACCOUNT_BANKING)
								[+] if(iVerify==PASS)
									[ ] ReportStatus("Verify Move Transaction OK button",PASS,"Account {lsAddAccount1[2]} selected successfully")
									[ ] 
									[ ] 
									[ ] //Verify if Transaction is present in Checking 02 account register
									[ ] iVerify=VerifyTransactionInAccountRegister(lsTransactionData[6], sMoveCancelExpectedNumberOfTransactionsC1)
									[ ] 
									[ ] ReportStatus("Verify Move Transaction Cancel  button", iVerify, "{sMoveAccountAction} in {lsAddAccount1[2]} account register") 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Move Transaction Cancel  button",FAIL,"Account {lsAddAccount1[2]} not selected")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "{sMoveAccountAction} not completed") 
						[+] else
							[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Move Transaction Cancel  button",FAIL,"Account {lsAddAccount2[2]} not selected")
				[+] else
					[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Move Transaction Cancel  button", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Move Transaction Cancel  button",FAIL,"Quicken Main Window Not found")
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Copy Transactions in Account Register #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC101_VerifyCopyTransactionsInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Copy transaction option in account register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If copy transaction functionality is correct			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  21/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC101_VerifyCopyTransactionsInRegister() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sCopyAccountAction="Copy transaction(s)"
		[ ] STRING sPasteAccountAction="Paste transaction(s)"
		[ ] STRING sExpectedNumberOfTransactions="1"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Copy Transaction", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount1=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] //Add Checking 01 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Copy Transaction", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
				[ ] lsAddAccount2=lsExcelData[2]
				[ ] 
				[ ] //Add Checking 02 Account
				[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
				[ ] //Report Status if checking Account is created
				[+] if (iVerify==PASS)
					[ ] ReportStatus("Verify Copy Transaction", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
					[ ] 
					[ ] 
					[ ] //Select Checking 02 Account From Account Bar
					[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Copy Transaction",PASS,"Account {lsAddAccount2[2]} selected successfully")
						[ ] 
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
						[ ] lsTransactionData=lsExcelData[4]
						[ ] 
						[ ] 
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Copy Transaction", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] 
							[ ] 
							[ ] //Copy transaction from Checking 02 account
							[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sCopyAccountAction,"",iXpos ,iYpos)
							[+] if(iVerify==PASS)
								[ ] ReportStatus("Verify Copy Transaction", PASS, "{sCopyAccountAction} completed") 
								[ ] 
								[ ] //Verify if Account is present in Checking 02 account register
								[ ] iVerify=VerifyTransactionInAccountRegister(lsTransactionData[6], sExpectedNumberOfTransactions)
								[ ] ReportStatus("Verify Copy Transaction", iVerify, "{sCopyAccountAction} in {lsAddAccount2[2]} account register") 
								[ ] 
								[ ] 
								[ ] 
								[ ] //Select Checking 01 Account From Account Bar
								[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount1[2],ACCOUNT_BANKING)
								[+] if(iVerify==PASS)
									[ ] ReportStatus("Verify Copy Transaction",PASS,"Account {lsAddAccount1[2]} selected successfully")
									[ ] 
									[ ] 
									[ ] 
									[ ] //Paste transaction from Checking 02
									[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sPasteAccountAction,"",iXpos ,iYpos)
									[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
									[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_ENTER)
									[+] if(iVerify==PASS)
										[ ] ReportStatus("Verify Copy Transaction", PASS, "{sPasteAccountAction} completed") 
										[ ] 
										[ ] 
										[ ] //Verify if Account is present in Checking 02 account register
										[ ] iVerify=VerifyTransactionInAccountRegister(lsTransactionData[6], sExpectedNumberOfTransactions)
										[ ] ReportStatus("Verify Copy Transaction", iVerify, "{sCopyAccountAction} in {lsAddAccount1[2]} account register") 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Copy Transaction", FAIL, "{sPasteAccountAction} not completed") 
								[+] // else
									[ ] // ReportStatus("Verify Copy Transaction",PASS,"Account {lsAddAccount1[2]} not selected")
									[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify Copy Transaction", FAIL, "{sCopyAccountAction} not completed") 
						[+] // else
							[ ] // ReportStatus("Verify Copy Transaction", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Copy Transaction",FAIL,"Account {lsAddAccount[2]} not selected")
				[+] // else
					[ ] // ReportStatus("Verify Copy Transaction", FAIL, "Checking Account -  {lsAddAccount[2]}  is not added")
					[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Copy Transaction", FAIL, "Checking Account -  {lsAddAccount[2]}  is not added")
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Data File ", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] // 
	[+] else
		[ ] ReportStatus("Verify Filters present in account",FAIL,"Quicken Main Window Not found")
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Cut Transactions in Account Register ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC102_VerifyCutTransactionsInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Cut transaction option in account register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Cut transaction functionality is correct			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  21/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC102_VerifyCutTransactionsInRegister() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sCutAccountAction="Cut transaction(s)"
		[ ] STRING sPasteAccountAction="Paste transaction(s)"
		[ ] STRING sExpectedNumberOfTransactionsCut="0"
		[ ] STRING sExpectedNumberOfTransactionsPaste="1"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Cut Transaction", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount1=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] //Add Checking 01 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Cut Transaction", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
				[ ] lsAddAccount2=lsExcelData[2]
				[ ] 
				[ ] //Add Checking 02 Account
				[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
				[ ] //Report Status if checking Account is created
				[+] if (iVerify==PASS)
					[ ] ReportStatus("Verify Cut Transaction", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
					[ ] 
					[ ] 
					[ ] //Select Checking 02 Account From Account Bar
					[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Cut Transaction",PASS,"Account {lsAddAccount2[2]} selected successfully")
						[ ] 
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
						[ ] lsTransactionData=lsExcelData[4]
						[ ] 
						[ ] 
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Cut Transaction", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] 
							[ ] 
							[ ] //Cut transaction from Checking 02 account
							[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sCutAccountAction ,"",iXpos ,iYpos)
							[+] if(iVerify==PASS)
								[ ] ReportStatus("Verify Cut Transaction", PASS, "{sCutAccountAction} completed") 
								[ ] 
								[ ] //Verify if Transacton is present in Checking 02 account register
								[ ] iVerify=VerifyTransactionInAccountRegister(lsTransactionData[6], sExpectedNumberOfTransactionsCut)
								[ ] ReportStatus("Verify Cut Transaction", iVerify, "{sCutAccountAction} in {lsAddAccount2[2]} account register") 
								[ ] 
								[ ] 
								[ ] 
								[ ] //Select Checking 01 Account From Account Bar
								[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount1[2],ACCOUNT_BANKING)
								[+] if(iVerify==PASS)
									[ ] ReportStatus("Verify Cut Transaction",PASS,"Account {lsAddAccount1[2]} selected successfully")
									[ ] 
									[ ] 
									[ ] 
									[ ] //Paste transaction from Checking 02
									[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sPasteAccountAction,"",iXpos ,iYpos)
									[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_ENTER)
									[+] if(iVerify==PASS)
										[ ] ReportStatus("Verify Cut Transaction", PASS, "{sPasteAccountAction} completed") 
										[ ] 
										[ ] 
										[ ] //Verify if Account is present in Checking 02 account register
										[ ] iVerify=VerifyTransactionInAccountRegister(lsTransactionData[6], sExpectedNumberOfTransactionsPaste)
										[ ] ReportStatus("Verify Cut Transaction", iVerify, "{sCutAccountAction} in {lsAddAccount1[2]} account register") 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Cut Transaction", FAIL, "{sPasteAccountAction} not completed") 
								[+] else
									[ ] ReportStatus("Verify Cut Transaction",FAIL,"Account {lsAddAccount1[2]} not selected")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify Cut Transaction", FAIL, "{sCutAccountAction} not completed") 
						[+] else
							[ ] ReportStatus("Verify Cut Transaction", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Cut Transaction",FAIL,"Account {lsAddAccount[2]} not selected")
				[+] else
					[ ] ReportStatus("Verify Cut Transaction", FAIL, "Checking Account -  {lsAddAccount[2]}  is not added")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Cut Transaction", FAIL, "Checking Account -  {lsAddAccount[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Cut Transaction", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Cut Transaction",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] ////############# Verify Save Transactions in Account Register ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC103_VerifySaveTransactionsInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if transaction is saved in account register when we enter transaction and click save button
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If transaction is added in Account Register			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  20/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC103_VerifySaveTransactionsInRegister() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Enter Transaction", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount=lsExcelData[2]
			[ ] 
			[ ] 
			[ ] //Add Checking Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Enter Transaction", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //Select Account From Account Bar
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Enter Transaction",PASS,"Account {lsAddAccount[2]} selected successfully")
					[ ] 
					[ ] 
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
					[ ] lsTransactionData=lsExcelData[4]
					[ ] 
					[ ] 
					[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Enter Transaction", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
						[ ] 
						[ ] lsTransactionActual=GetTransactionsInRegister(lsTransactionData[6])
						[ ] 
						[ ] //Verify if transaction is added with all correct values
						[+] for(i=5;i<=7;i++)
							[ ] 
							[ ] 
							[+] if(MatchStr("*{lsTransactionData[i]}*",lsTransactionActual[1]))
								[ ] ReportStatus("Verify Enter Transaction",PASS,"{lsTransactionData[i]}  matched correctly")
							[+] else
								[ ] ReportStatus("Verify Enter Transaction",FAIL,"{lsTransactionData[i]}  not matched correctly to {lsTransactionActual}")
								[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] //Verify Balances
						[ ] sActualBalanceText=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
						[+] if(sActualBalanceText==lsTransactionData[10])
							[ ] ReportStatus("Verify Enter Transaction",PASS,"Correct Ending Balance {sActualBalanceText} Displayed in Account Register")
						[+] else
							[ ] ReportStatus("Verify Enter Transaction",FAIL,"Wrong Ending Balance {sActualBalanceText} Displayed in Account Register;Expected is {lsTransactionData[10]} ")
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Enter Transaction", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present",FAIL,"Account {lsAddAccount[2]} not selected")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Filters present in account",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] ////############# Verify Memorized Payee in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC110_VerifyMemorizedPayeeForTransaction_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if memorized payee option is selected from More Actions dropdown and Cancel button is clicked then Payee should not be memorized
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If payee is not memorized
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  26/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC110_VerifyMemorizedPayeeForTransaction_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] INTEGER iNoMemorizedPayeeCount=0
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] //String
		[ ] STRING sActualBalanceText,sActualListValue
		[ ] 
		[ ] //STRING sPreferenceType="Data entry and Quickfill"
		[ ] 
		[ ] STRING sMemorizePayee="Memorize payee..."
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iVerify = DataFileCreate(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Void Transaction in Register", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] 
		[ ] 
		[ ] //Navigate to option 'Data entry and Quickfill' and UnCheck "Automatically Memorize New Payee'' option
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[+] if(Preferences.Exists(3))
			[ ] ReportStatus("Preferences Window",PASS,"Preferences Window Opened")
		[+] else
			[ ] ReportStatus("Preferences Window",FAIL,"Preferences Window Not Opened")
		[ ] 
		[ ] //SelectPreferenceType()
		[ ] Preferences.SetActive()
		[ ] sHandle = Str(Preferences.SelectPreferenceType1.ListBox.GetHandle())
		[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, "9")
		[ ] 
		[ ] 
		[ ] Preferences.AutomaticallyMemorizeNewPay.Uncheck()
		[ ] Preferences.OK.Click()
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] //Add Checking 01 Account
		[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
		[ ] //Report Status if checking Account is created
		[+] if (iVerify==PASS)
			[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount2=lsExcelData[2]
			[ ] 
			[ ] //Add Checking 02 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Select Checking 02 Account From Account Bar
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Memorize Payee in Register",PASS,"Account {lsAddAccount2[2]} selected successfully")
					[ ] 
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
					[ ] lsTransactionData=lsExcelData[4]
					[ ] 
					[ ] //Add Checking Transaction
					[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] //Void Transaction from transaction dropdown menu
						[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sMemorizePayee,"",iXpos ,iYpos)
						[+] if(iVerify==PASS)
							[ ] 
							[ ] 
							[+] if(AlertMessage.Exists(3))
								[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "{sMemorizePayee} alert box displayed") 
								[ ] AlertMessage.Cancel.Click()
								[ ] 
								[ ] 
								[ ] 
								[ ] //Verify if Payee is Memorized from Memorized Payee List
								[ ] QuickenWindow.SetActive()
								[ ] QuickenWindow.Tools.Click()
								[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
								[+] if(MemorizedPayeeList.Exists(3))
									[ ] MemorizedPayeeList.SetActive()
									[ ] 
									[+] if(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()==iNoMemorizedPayeeCount)
										[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "Payee {lsTransactionData[6]} not displayed") 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Payee {lsTransactionData[6]} not displayed") 
									[ ] MemorizedPayeeList.SetActive()
									[ ] MemorizedPayeeList.Done.Click()
									[ ] WaitForState(MemorizedPayeeList, false,1)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Memorized payee List not opened") 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "{sMemorizePayee} alert box not displayed") 
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
						[+] else
							[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "{sMemorizePayee} not completed") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Memorize Payee in Register",FAIL,"Account {lsAddAccount2[2]} not selected")
			[+] else
				[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Error during Data file creation for file -  {sFileName} ")
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] ////############# Verify Memorized Payee in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC110_VerifyMemorizedPayeeForTransaction_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if memorized payee option is selected from
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If transaction is voided correctly
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  26/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC111_VerifyMemorizedPayeeForTransaction_OK() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] INTEGER iNoMemorizedPayeeCount=0
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] //String
		[ ] STRING sActualBalanceText,sActualListValue
		[ ] 
		[ ] //STRING sPreferenceType="Data entry and Quickfill"
		[ ] 
		[ ] STRING sMemorizePayee="Memorize payee..."
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iVerify = DataFileCreate(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] 
		[ ] 
		[ ] //Navigate to option 'Data entry and Quickfill' and UnCheck "Automatically Memorize New Payee'' option
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[+] if(Preferences.Exists(3))
			[ ] ReportStatus("Preferences Window",PASS,"Preferences Window Opened")
		[+] else
			[ ] ReportStatus("Preferences Window",FAIL,"Preferences Window Not Opened")
		[ ] 
		[ ] //SelectPreferenceType()
		[ ] Preferences.SetActive()
		[ ] sHandle = Str(Preferences.SelectPreferenceType1.ListBox.GetHandle())
		[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, "9")
		[ ] 
		[ ] 
		[ ] Preferences.AutomaticallyMemorizeNewPay.Uncheck()
		[ ] Preferences.OK.Click()
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] //Add Checking 01 Account
		[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
		[ ] //Report Status if checking Account is created
		[+] if (iVerify==PASS)
			[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount2=lsExcelData[2]
			[ ] 
			[ ] //Add Checking 02 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Select Checking 02 Account From Account Bar
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Memorize Payee in Register",PASS,"Account {lsAddAccount2[2]} selected successfully")
					[ ] 
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
					[ ] lsTransactionData=lsExcelData[4]
					[ ] 
					[ ] //Add Checking Transaction
					[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] //Void Transaction from transaction dropdown menu
						[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sMemorizePayee,"",iXpos ,iYpos)
						[+] if(iVerify==PASS)
							[ ] 
							[ ] 
							[+] if(AlertMessage.Exists(3))
								[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "{sMemorizePayee} alert box displayed") 
								[ ] AlertMessage.OK.Click()
								[ ] 
								[ ] 
								[ ] 
								[ ] //Verify if Payee is Memorized from Memorized Payee List
								[ ] QuickenWindow.SetActive()
								[ ] QuickenWindow.Tools.Click()
								[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
								[+] if(MemorizedPayeeList.Exists(3))
									[ ] MemorizedPayeeList.SetActive()
									[ ] 
									[ ] 
									[+] if(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()==iNoMemorizedPayeeCount)
										[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Payee {lsTransactionData[6]} not displayed") 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "Payee {lsTransactionData[6]} displayed") 
										[ ] 
										[ ] sHandle=Str(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetHandle())
										[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
										[ ] bMatch=MatchStr("*{lsTransactionData[6]}*",sActual)
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("Verify Memorize Payee in Register", PASS, "Payee {lsTransactionData[6]} memorized successfully") 
										[+] else
											[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Payee {lsTransactionData[6]} not memorized") 
											[ ] 
									[ ] MemorizedPayeeList.SetActive()
									[ ] MemorizedPayeeList.Done.Click()
									[ ] WaitForState(MemorizedPayeeList, false,1)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Memorized payee List not opened") 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "{sMemorizePayee} alert box not displayed") 
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
						[+] else
							[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "{sMemorizePayee} not completed") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Memorize Payee in Register",FAIL,"Account {lsAddAccount2[2]} not selected")
			[+] else
				[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Memorize Payee in Register", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Void Transaction in Register", FAIL, "Error during Data file creation for file -  {sFileName} ")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] ////############# Verify Make the transaction a Schedule Bill in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC112_VerifyMakeTheTransactionAScheduleBill_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Bill is not added from Make a Transaction a Schedule Bill option in account register and clicking on cancel button
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If bill reminder is not added
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC112_VerifyMakeTheTransactionAScheduleBill_Cancel() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText,sActualListValue
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] STRING sScheduleBillAction="Schedule bill or deposit"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount1=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] //Add Checking 01 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
				[ ] lsAddAccount2=lsExcelData[2]
				[ ] 
				[ ] //Add Checking 02 Account
				[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
				[ ] //Report Status if checking Account is created
				[+] if (iVerify==PASS)
					[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
					[ ] 
					[ ] 
					[ ] //Select Checking 02 Account From Account Bar
					[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Make the transaction a Schedule Bill",PASS,"Account {lsAddAccount2[2]} selected successfully")
						[ ] 
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
						[ ] lsTransactionData=lsExcelData[4]
						[ ] 
						[ ] //Add Checking Transaction
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //Schedule transaction from Checking 02 account as bill
							[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sScheduleBillAction,"",iXpos ,iYpos)
							[ ] //Click on Cancel button of Schedule transaction as bill window
							[+] if(iVerify==PASS)
								[ ] 
								[ ] 
								[+] if(DlgAddEditReminder.Exists(3))
									[ ] DlgAddEditReminder.SetActive()
									[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "{sScheduleBillAction} completed") 
									[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
									[ ] DlgAddEditReminder.TypeKeys(KEY_UP)
									[ ] DlgAddEditReminder.CancelButton.Click()
									[ ] WaitForState(DlgAddEditReminder,false,1)
									[ ] 
									[ ] 
									[ ] //Verify that Bill Reminder should not be added
									[ ] NavigateQuickenTab(sTAB_BILL)
									[ ] 
									[+] if(GetStartedBrowserWindow.GetStarted.Exists(2))
										[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Bill is not scheduled for Transaction with Payee name {lsTransactionData[6]}")
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Bill is scheduled for Transaction with Payee name {lsTransactionData[6]}")
										[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "{sScheduleBillAction} completed") 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "{sScheduleBillAction} not completed") 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Make the transaction a Schedule Bill",FAIL,"Account {lsAddAccount2[2]} not selected")
				[+] else
					[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
		[ ] 
		[ ] 
[ ] 
[ ] 
[+] ////############# Verify Make the transaction a Schedule Bill in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC113_VerifyMakeTheTransactionAScheduleBill_OKl()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Bill is added from Make a Transaction a Schedule Bill option in account register and click on OK button
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If bill reminder is added
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[ ] 
[+] testcase TC113_VerifyMakeTheTransactionAScheduleBill_OK() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] //Integer
	[ ] INTEGER iVerify
	[ ] STRING sActualBalanceText,sActualListValue
	[ ] LIST OF STRING lsTransactionActual
	[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
	[ ] 
	[ ] STRING sScheduleBillAction="Schedule bill or deposit "
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iVerify = DataFileCreate(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] //Add Checking 01 Account
		[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
		[ ] //Report Status if checking Account is created
		[+] if (iVerify==PASS)
			[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount2=lsExcelData[2]
			[ ] 
			[ ] //Add Checking 02 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Select Checking 02 Account From Account Bar
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Make the transaction a Schedule Bill",PASS,"Account {lsAddAccount2[2]} selected successfully")
					[ ] 
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
					[ ] lsTransactionData=lsExcelData[4]
					[ ] 
					[ ] //Add Checking Transaction
					[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] //Schedule transaction from Checking 02 account as bill
						[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sScheduleBillAction,"",iXpos ,iYpos)
						[ ] //Click on Cancel button of Schedule transaction as bill window
						[+] if(iVerify==PASS)
							[ ] 
							[ ] 
							[+] if(DlgAddEditReminder.Exists(5))
								[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "{sScheduleBillAction} completed") 
								[ ] DlgAddEditReminder.SetActive()
								[ ] DlgAddEditReminder.DoneButton.Click()
								[ ] WaitForState(DlgAddEditReminder , false ,1)
								[ ] 
								[ ] 
								[ ] //Navigate to Bills tab
								[ ] NavigateQuickenTab(sTAB_BILL)
								[ ] 
								[+] if(GetStartedBrowserWindow.GetStarted.Exists(2))
									[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Bill is not scheduled for Transaction with Payee name {lsTransactionData[6]}")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Bill is added")
									[ ] 
									[ ] //Verify that Bill Reminder should not be added
									[ ] 
									[ ] Bills.ViewAsPopupList.Select(2)
									[ ] Bills.DueWithinNextPopupList.Select(4)
									[+] if(Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.Exists(3))
										[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Bills Tab opened in list view")
										[ ] sHandle=Str(Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
										[ ] iListCount=Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
										[+] if(iListCount!=0)
											[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Bill scheduled Transaction with Payee name {lsTransactionData[6]}")
											[+] for(i=0;i<=iListCount-1;i++)
												[ ] sActualListValue= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
												[ ] 
												[ ] bMatch = MatchStr("*{lsTransactionData[6]}*", sActualListValue)
												[+] if(bMatch == TRUE)
													[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Payee name matched")
												[+] else
													[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Payee name not matched in {sActualListValue}")
												[ ] 
												[ ] 
												[ ] bMatch = MatchStr("*{val(lsTransactionData[4])}*", sActualListValue)
												[+] if(bMatch == TRUE)
													[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "Amount {lsTransactionData[3]} matched")
												[+] else
													[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Amount {lsTransactionData[3]} not matched in {sActualListValue}")
												[ ] 
												[ ] 
												[ ] 
												[ ] 
												[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Bill is not scheduled for Transaction with Payee name {lsTransactionData[6]}")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Make the transaction a Schedule Bill", PASS, "{sScheduleBillAction} completed") 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "{sScheduleBillAction} not completed") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Make the transaction a Schedule Bill",FAIL,"Account {lsAddAccount2[2]} not selected")
			[+] else
				[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Make the transaction a Schedule Bill", FAIL, "Error during Data file creation for file -  {sFileName} ")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Make the transaction a Schedule Deposit in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC114_VerifyMakeTheTransactionAScheduleDeposit_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that deposit is not added from Make a Transaction a Schedule deposit option in account register and clicking on cancel button
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If reminder is not added
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC114_VerifyMakeTheTransactionAScheduleDeposit_Cancel() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,iListCount
		[ ] STRING sActualBalanceText,sActualListValue
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] STRING sScheduleBillAction="Schedule bill or deposit "
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount1=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] //Add Checking 01 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
				[ ] lsAddAccount2=lsExcelData[2]
				[ ] 
				[ ] //Add Checking 02 Account
				[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
				[ ] //Report Status if checking Account is created
				[+] if (iVerify==PASS)
					[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
					[ ] 
					[ ] 
					[ ] //Select Checking 02 Account From Account Bar
					[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Make the transaction a Schedule Deposit",PASS,"Account {lsAddAccount2[2]} selected successfully")
						[ ] 
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
						[ ] lsTransactionData=lsExcelData[4]
						[ ] 
						[ ] //Add Checking Transaction
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //Schedule transaction from Checking 02 account as bill
							[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sScheduleBillAction,"",iXpos ,iYpos)
							[ ] //Click on Cancel button of Schedule transaction as bill window
							[+] if(iVerify==PASS)
								[ ] 
								[ ] 
								[+] if(DlgAddEditReminder.Exists(3))
									[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "{sScheduleBillAction} completed") 
									[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
									[ ] DlgAddEditReminder.CancelButton.Click()
									[ ] WaitForState(DlgAddEditReminder, false,1)
									[ ] sleep(2)
									[ ] //Verify that Bill Reminder should not be added
									[ ] NavigateQuickenTab(sTAB_BILL)
									[ ] 
									[+] if(GetStartedBrowserWindow.GetStarted.Exists(3))
										[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Deposit is not scheduled for Transaction with Payee name {lsTransactionData[6]}")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Deposit is scheduled for Transaction with Payee name {lsTransactionData[6]}")
										[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "{sScheduleBillAction} completed") 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "{sScheduleBillAction} not completed") 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Make the transaction a Schedule Deposit",FAIL,"Account {lsAddAccount2[2]} not selected")
				[+] else
					[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Error during Data file creation for file -  {sFileName} ")
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Make the transaction a Schedule Deposit in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC115_VerifyMakeTheTransactionAScheduleDeposit_OKl()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if deposit is added from Make a Transaction a Schedule deposit option in account register and click on OK button
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If reminder  is added
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC115_VerifyMakeTheTransactionAScheduleDeposit_OK() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] //Integer
	[ ] INTEGER iVerify,iListCount
	[ ] STRING sActualBalanceText,sActualListValue
	[ ] LIST OF STRING lsTransactionActual
	[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
	[ ] 
	[ ] STRING sScheduleBillAction="Schedule bill or deposit "
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iVerify = DataFileCreate(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] //Add Checking 01 Account
		[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
		[ ] //Report Status if checking Account is created
		[+] if (iVerify==PASS)
			[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount2=lsExcelData[2]
			[ ] 
			[ ] //Add Checking 02 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Select Checking 02 Account From Account Bar
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Make the transaction a Schedule Deposit",PASS,"Account {lsAddAccount2[2]} selected successfully")
					[ ] 
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
					[ ] lsTransactionData=lsExcelData[4]
					[ ] 
					[ ] //Add Checking Transaction
					[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] //Schedule transaction from Checking 02 account as bill
						[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sScheduleBillAction,"",iXpos ,iYpos)
						[ ] //Click on Cancel button of Schedule transaction as bill window
						[+] if(iVerify==PASS)
							[ ] 
							[ ] 
							[+] if(DlgAddEditReminder.Exists(3))
								[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "{sScheduleBillAction} completed") 
								[ ] // DlgAddEditReminder.TypeKeys(KEY_TAB)
								[ ] // DlgAddEditReminder.TypeKeys(KEY_TAB)
								[ ] // DlgAddEditReminder.TypeKeys(KEY_ENTER)
								[ ] // DlgAddEditReminder.TypeKeys(KEY_TAB)
								[ ] // DlgAddEditReminder.TypeKeys(KEY_TAB)
								[ ] // DlgAddEditReminder.TypeKeys(KEY_ENTER)
								[+] // if(DlgAddEditReminder.Exists(3))
									[ ] // DlgAddEditReminder.TypeKeys(KEY_ENTER)
								[ ] DlgAddEditReminder.SetActive()
								[ ] DlgAddEditReminder.DoneButton.Click()
								[ ] WaitForState(DlgAddEditReminder , false ,1)
								[ ] 
								[ ] 
								[ ] //Navigate to Bills tab
								[ ] NavigateQuickenTab(sTAB_BILL)
								[ ] 
								[+] if(GetStartedBrowserWindow.GetStarted.Exists(3))
									[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Deposit is not scheduled for Transaction with Payee name {lsTransactionData[6]}")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Deposit is added")
									[ ] 
									[ ] //Verify that Bill Reminder should not be added
									[ ] 
									[ ] Bills.ViewAsPopupList.Select(2)
									[ ] Bills.DueWithinNextPopupList.Select(4)
									[+] if(Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.Exists(3))
										[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Bills Tab opened in list view")
										[ ] sHandle=Str(Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
										[ ] iListCount=Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
										[+] if(iListCount!=0)
											[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Bill scheduled Transaction with Payee name {lsTransactionData[6]}")
											[+] for(i=0;i<iListCount;i++)
												[ ] sActualListValue= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
												[ ] 
												[ ] bMatch = MatchStr("*{lsTransactionData[6]}*", sActualListValue)
												[+] if(bMatch == TRUE)
													[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Payee name matched")
												[+] else
													[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Payee name not matched in {sActualListValue}")
												[ ] 
												[ ] 
												[ ] bMatch = MatchStr("*{val(lsTransactionData[4])}*", sActualListValue)
												[+] if(bMatch == TRUE)
													[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "Amount {lsTransactionData[3]} matched")
												[+] else
													[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Amount {lsTransactionData[3]} not matched in {sActualListValue}")
												[ ] 
												[ ] 
												[ ] 
												[ ] 
												[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Bill is not scheduled for Transaction with Payee name {lsTransactionData[6]}")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", PASS, "{sScheduleBillAction} completed") 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "{sScheduleBillAction} not completed") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Make the transaction a Schedule Deposit",FAIL,"Account {lsAddAccount2[2]} not selected")
			[+] else
				[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Make the transaction a Schedule Deposit", FAIL, "Error during Data file creation for file -  {sFileName} ")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Void a transaction in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC116_VerifyVoidTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Void a transaction in Account Register and determine that VOID is added to Payee name and amount is changed to 0.00
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If transaction is voided correctly
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  26/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC116_VerifyVoidTransaction() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] //String
		[ ] STRING sActualBalanceText,sActualListValue
		[ ] STRING sVoidTransaction="Void transaction(s) "
		[ ] STRING sVoidPayee="**VOID**"
		[ ] STRING sVoidAmount="0.00"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Create a New Data File---------------------------------------------------------------------------------
		[ ] iVerify = DataFileCreate(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Verify Void Transaction in Register", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] lsAddAccount1=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] //Add Checking 01 Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount1[1], lsAddAccount1[2], lsAddAccount1[3], lsAddAccount1[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Void Transaction in Register", PASS, "Checking Account -  {lsAddAccount1[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
				[ ] lsAddAccount2=lsExcelData[2]
				[ ] 
				[ ] //Add Checking 02 Account
				[ ] iVerify = AddManualSpendingAccount(lsAddAccount2[1], lsAddAccount2[2], lsAddAccount2[3], lsAddAccount2[4])
				[ ] //Report Status if checking Account is created
				[+] if (iVerify==PASS)
					[ ] ReportStatus("Verify Void Transaction in Register", PASS, "Checking Account -  {lsAddAccount2[2]}  is created successfully")
					[ ] 
					[ ] 
					[ ] //Select Checking 02 Account From Account Bar
					[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Verify Void Transaction in Register",PASS,"Account {lsAddAccount2[2]} selected successfully")
						[ ] 
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
						[ ] lsTransactionData=lsExcelData[4]
						[ ] 
						[ ] //Add Checking Transaction
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Void Transaction in Register", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //Void Transaction from transaction dropdown menu
							[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sVoidTransaction,"",iXpos ,iYpos)
							[ ] //Click on Save button
							[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
							[+] if(iVerify==PASS)
								[ ] 
								[ ] 
								[ ] //Get All transactions in register
								[ ] lsTransactionActual=GetTransactionsInRegister(lsTransactionData[6])
								[ ] 
								[ ] //Match payee name to verify that **VOID** is prefixed
								[ ] bMatch=MatchStr("*{sVoidPayee+lsTransactionData[6]}*",lsTransactionActual[1])
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify Void Transaction in Register", PASS, " Payee name is {sVoidPayee}") 
								[+] else
									[ ] ReportStatus("Verify Void Transaction in Register", FAIL, " Payee name is not {sVoidPayee}") 
								[ ] 
								[ ] //Match amount to determine that amount is 0.00
								[ ] bMatch=MatchStr("*{sVoidAmount}*",lsTransactionActual[1])
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify Void Transaction in Register", PASS, " Payee name is {sVoidAmount}") 
								[+] else
									[ ] ReportStatus("Verify Void Transaction in Register", FAIL, " Payee name is not {sVoidAmount}") 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Void Transaction in Register", FAIL, "{sVoidTransaction} not completed") 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Void Transaction in Register", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Void Transaction in Register",FAIL,"Account {lsAddAccount2[2]} not selected")
				[+] else
					[ ] ReportStatus("Verify Void Transaction in Register", FAIL, "Checking Account -  {lsAddAccount2[2]}  is not added")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Void Transaction in Register", FAIL, "Checking Account -  {lsAddAccount1[2]}  is not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Void Transaction in Register", FAIL, "Error during Data file creation for file -  {sFileName} ")
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
[+] //############# Setup : Convert Data File From 2012 to 2014 ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataConversionRegister2012_2013()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2012 into latest Quicken version
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase DataConversionRegister2012_2013() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] //Boolean
		[ ] BOOLEAN bSource,bVerify
		[ ] 
		[ ] //Integer
		[ ] INTEGER iDataFileConversion
		[ ] 
		[ ] //String
		[ ] STRING sFileName= "RegisterDataFile2012"
		[ ] STRING sQuicken2012File = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sVersion="2012"
		[ ] STRING sQuicken2012Source = AUT_DATAFILE_PATH + "\2012\" + sFileName + ".QDF"
		[ ] STRING sQuicken2012FileCopy= AUT_DATAFILE_PATH + "\" + "Q12Files"+ "\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Delete Existing File
		[+] if(SYS_FileExists(sQuicken2012File))
			[ ] // Delete existing file, if exists
			[ ] bVerify=DeleteFile(sQuicken2012File)
			[+] if(bVerify==TRUE)
				[ ] ReportStatus("2012 Data File Conversion",PASS,"Existing File Deleted")
			[+] else
				[ ] ReportStatus("2012 Data File Conversion",PASS,"Existing File Not Deleted")
			[ ] 
			[ ] 
		[ ] //Delete Copy of File
		[+] if(SYS_FileExists(sQuicken2012FileCopy))
			[ ] DeleteFile(sQuicken2012FileCopy)
			[ ] bVerify=DeleteFile(sQuicken2012FileCopy)
			[+] if(bVerify==TRUE)
				[ ] ReportStatus("2012 Data File Conversion",PASS,"Existing Copy of File Deleted")
			[+] else
				[ ] ReportStatus("2012 Data File Conversion",FAIL,"Existing Copy of File Not Deleted")
		[ ] 
		[ ] // Copy 2012 data file to location
		[+] if(SYS_FileExists(sQuicken2012Source))
			[ ] SYS_Execute("attrib -r  {sQuicken2012Source} ")
			[ ] bVerify=CopyFile(sQuicken2012Source, sQuicken2012File)
			[+] if(bVerify==TRUE)
				[ ] ReportStatus("2012 Data File Conversion",PASS,"File Copied successfully")
			[+] else
				[ ] ReportStatus("2012 Data File Conversion",FAIL,"File Not Copied to location")
		[ ] 
		[ ] iDataFileConversion=DataFileConversion(sFileName,sVersion,"",sQuicken2012File)
		[ ] ReportStatus("2012 Data File Conversion",iDataFileConversion,"File Converted from 2012 to 2014")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("2012 Data File Conversion",FAIL,"Quicken Window Not found")
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] // ////############# DownloadedTransactionsPreferences_Migration #############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC11_DownloadedTransactionsPreferences_Migration()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify Downloaded Transactions  Preferences in file migrated from previous version
		[ ] // //.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If verification of content is correct					
		[ ] // //						Fail		       If any error occurs
		[ ] // // 
		[ ] // //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase TC11_DownloadedTransactionsPreferences_Migration() appstate none
	[ ] // 
	[+] // //Variable Decalration
		[ ] // STRING sHandle
		[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // 
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // 
		[ ] // //Navigate to option 'Downloaded Transactions'---------------------------------------------------------------------------------
		[ ] // QuickenWindow.Edit.Click()
		[ ] // QuickenWindow.Edit.Preferences.Select()
		[+] // if(Preferences.Exists(5))
			[ ] // ReportStatus("Preferences Window",PASS,"Preferences Window Opened")
			[ ] // 
			[ ] // //SelectPreferenceType()
			[ ] // Preferences.SetActive()
			[ ] // sHandle = Str(Preferences.SelectPreferenceType1.ListBox.GetHandle())
			[ ] // QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, "12")
			[ ] // //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] // 
			[ ] // //Verify that all objects are present----------------------------------------------------------------------------------------------------
			[ ] // WaitForState(Preferences,TRUE,10)
			[ ] // //VerifyContentInEditPreferences
			[ ] // 
			[ ] // Preferences.SetActive()
			[ ] // 
			[ ] // 
			[ ] // //After Transaction Download
			[+] // if(Preferences.AfterDownloadingTransactions.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AfterDownloadingTransactions Text is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AfterDownloadingTransactions Text is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyAddToBankingRegister.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToBankingRegister Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToBankingRegister Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyAddToInvestmentTransactionLists.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToInvestmentTransactionLists Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToInvestmentTransactionLists Checkbox is missing")
				[ ] // 
			[ ] // 
			[ ] // 
			[ ] // //During Transaction Download
			[+] // if(Preferences.DownloadedTransactionsPreferences.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"DownloadedTransactionsPreferences Text is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"DownloadedTransactionsPreferences Text is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyCategorizeTransactions.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCategorizeTransactions Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCategorizeTransactions Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyApplyQuickenSuggestedNameToPayee.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.CapitalizeFirstLetterOnlyInDownloadedPayeeNames.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is missing")
				[ ] // 
			[ ] // 
			[ ] // 
			[ ] // //Renaming Rules
			[+] // if(Preferences.YourRenamingRulesText.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"YourRenamingRulesText is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"YourRenamingRulesText is missing")
				[ ] // 
			[+] // if(Preferences.UseMyExistingRenamingRules.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"UseMyExistingRenamingRules Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"UseMyExistingRenamingRules Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.RenamingRules.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"RenamingRules button is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"RenamingRules button is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyCreateRulesWhenIRenamePayees.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is missing")
				[ ] // 
			[ ] // //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] // 
			[ ] // Preferences.SetActive()
			[ ] // Preferences.OK.Click()
			[ ] // WaitForState(Preferences,False,1)
			[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Preferences Window",FAIL,"Preferences Window Not Opened")
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
[ ] 
[ ] 
[ ] 
[+] // //############## Enable Classic menu mode  ####################################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test02_Enable Classic menu mode()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This testcase will check enable classic menu mode in Prefernces for Converted file.
		[ ] // //
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass 	if Use classic menu is checked		
		[ ] // //							Fail	       if any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:	
		[ ] // // 06/02/2013  	Created By	Indrajit Deshmukh
	[ ] // //*********************************************************
[+] testcase Test02_EnableClassicMenuMode() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
	[ ] 
	[ ] // Quicken is launched
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] SetUp_AutoApi()
		[ ] SelectPreferenceType("Navigation")
		[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
		[+] if (bCheck==TRUE)
			[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu checkbox is checked when file where option is checked is migrated")
		[+] else
			[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu checkbox is unchecked when file where option is checked is migrated")
		[ ] 
		[ ] 
		[ ] //Uncheck Classic Menus
		[ ] Preferences.UseClassicMenus.UnCheck()
		[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
		[+] if (bCheck==FALSE)
			[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu checkbox is unchecked")
		[+] else
			[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu checkbox is checked ")
		[ ] 
		[ ] Preferences.OK.Click()
		[ ] WaitForState(Preferences,FALSE,20)
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] // 
[ ] // //############################################################################
[ ] 
[ ] 
[+] //############## RegisterpreferencesafterMigration  ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test06_Register preferences after Migration()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check enable classic menu mode in Prefernces for Converted file.
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Use classic menu is checked for Converted file.	
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 07/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test06_RegisterPreferencesAfterMigration() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
	[ ] 
	[ ] 
	[ ] // Quicken is launched
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] SelectPreferenceType("Register")
		[ ] //To check Register fields section in Preferences
		[+] if (Preferences.RegisterFieldsText.Exists(5))
			[ ] ReportStatus("Verify Register Fields label is exists in Register Preferences", PASS, "Register Fields label is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify Register Fields label is exists in Register Preferences", FAIL, "Register Fields label is not exists in Register Preferences ")
		[+] if (Preferences.ShowDateBeforeCheckNumber.Exists(5))
			[ ] ReportStatus("Verify ShowDateBeforeCheckNumber checkbox is exists in Register Preferences", PASS, "ShowDateBeforeCheckNumber checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify ShowDateBeforeCheckNumber checkbox is exists in Register Preferences", FAIL, "ShowDateBeforeCheckNumber checkbox is not exists in Register Preferences ")
		[+] if (Preferences.ShowMemoBeforeCategory.Exists(5))
			[ ] ReportStatus("Verify ShowMemoBeforeCategory checkbox is exists in Register Preferences", PASS, "ShowMemoBeforeCategory checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify ShowMemoBeforeCategory checkbox is exists in Register Preferences", FAIL, "ShowMemoBeforeCategory checkbox is not exists in Register Preferences ")
			[ ] 
			[ ] //To check Transactions Entry section in Preferences
		[+] if (Preferences.TransactionEntryText.Exists(5))
			[ ] ReportStatus("Verify Transaction Entry label is exists in Register Preferences", PASS, "Transaction Entry label is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify Transaction Entry label is exists in Register Preferences", FAIL, "Transaction Entry label is not exists in Register Preferences ")
		[+] if (Preferences.AutomaticallyEnterSplitData.Exists(5))
			[ ] ReportStatus("Verify AutomaticallyEnterSplitData checkbox is exists in Register Preferences", PASS, "AutomaticallyEnterSplitData checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify AutomaticallyEnterSplitData checkbox is exists in Register Preferences", FAIL, "AutomaticallyEnterSplitData checkbox is not exists in Register Preferences ")
			[ ] 
		[+] if (Preferences.AutomaticallyPlaceDecimalPoint.Exists(5))
			[ ] ReportStatus("Verify AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences", PASS, "AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences", FAIL, "AutomaticallyPlaceDecimalPoint checkbox is not exists in Register Preferences ")
			[ ] 
			[ ] //To check Register Appearence section in Preferences
		[+] if (Preferences.RegisterAppearanceText.Exists(5))
			[ ] ReportStatus("Verify Register Appearance label is exists in Register Preferences", PASS, "Register Appearance  label is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify Register Appearance  label is exists in Register Preferences", FAIL, "Register Appearance  label is not exists in Register Preferences ")
		[ ] 
		[+] if (Preferences.GrayReconciledTransactions.Exists(5))
			[ ] ReportStatus("Verify GrayReconciledTransactions checkbox is exists in Register Preferences", PASS, "GrayReconciledTransactions checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify GrayReconciledTransactions checkbox is exists in Register Preferences", FAIL, "GrayReconciledTransactions checkbox is not exists in Register Preferences ")
		[ ] 
		[+] if (Preferences.RememberRegisterFiltersAfterQuickenCloses.Exists(5))
			[ ] ReportStatus("Verify RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences", PASS, "RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences", FAIL, "RememberRegisterFiltersAfterQuickenCloses checkbox is not exists in Register Preferences ")
			[ ] 
		[+] if (Preferences.UsePopUpRegisters.Exists(5))
			[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", PASS, "UsePopUpRegisters checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", FAIL, "UsePopUpRegisters checkbox is not exists in Register Preferences ")
		[ ] 
		[ ] Preferences.OK.Click()
		[ ] WaitForState(Preferences,FALSE,20)
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] // //############## Verify Quick Fill Preferences - Migration ####################################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test08_Verify Quick Fill Preferences - Migration ()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This testcase will Verify Quick Fill Preferences for converted file.
		[ ] // //
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // RETURNS:				Pass 	if Quick fill Preferences is available for new file
		[ ] //							Fail	      if Quick fill Preferences is not available for new file
		[ ] // // 
		[ ] // // REVISION HISTORY:	
		[ ] // // 11/02/2013  	Created By	Indrajit Deshmukh
	[ ] // //*********************************************************
[+] testcase Test08_VerifyQuickFillPreferencesMigration() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] STRING sHandle,sActual
	[ ] 
	[ ] 
	[ ] // Quicken is launched
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] SelectPreferenceType("Data entry and Quickfill")
		[+] if (Preferences.RemoveMemorizedPayeesNotUsed.Exists(5))
			[ ] ReportStatus("Verify Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences", PASS, "Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences")
		[+] else
			[ ] ReportStatus("Verify Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences", FAIL, "Remove memorized payees not used in last  months is not exists in Data entry & Quick Fill preferences ")
		[ ] 
		[ ] 
		[ ] Preferences.OK.Click()
		[ ] WaitForState(Preferences,FALSE,20)
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
	[ ] // 
[ ] // //############################################################################
[ ] 
[+] //############## Verify default menu mode for new user  ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test01_Verify default menu mode for new user()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check enable classic menu mode in Prefernces for Converted file.
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Use classic menu is unchecked		
		[ ] //							Fail	      if Use classic menu is checked
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 07/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test01_VerifyDefaultMenuModeForNewUser() appstate none
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] INTEGER iCreateDataFile,iRegistration
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] 
	[ ] // Create Data File
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[ ] 
	[ ] // Report Staus If Data file Created successfully
	[+] if ( iCreateDataFile==PASS )
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] iResult=SelectPreferenceType("Navigation")
		[+] if (iResult==PASS)
			[ ] Preferences.SetActive()
			[ ] //To check Use classic menu checkbox is unchecked
			[ ] bCheck=False
			[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
			[+] if (bCheck==FALSE)
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu checkbox is unchecked ")
			[+] else
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu checkbox is checked")
				[ ] 
			[ ] //To check Use Popup registers is available in Preferences.
			[ ] Preferences.SetActive()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences, false,1)
			[ ] SelectPreferenceType("Register")
			[+] if (Preferences.UsePopUpRegisters.Exists(5))
				[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", PASS, "UsePopUpRegisters checkbox exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", FAIL, "UsePopUpRegisters checkbox does not exist in Register Preferences ")
			[ ] 
			[ ] //Close Preferences Window
			[ ] Preferences.SetActive()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences, false,1)
		[+] else
			[ ] ReportStatus("Verify Preference dialog.", FAIL, "Preference dialog didn't appear or Navigation option not found.")
		[ ] 
		[ ] 
		[ ] 
	[ ] // Report Staus If Data file is not Created 
	[+] else 
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //############## Verify Register display in Classic menu mode  ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test04_Verify Register display in Classic menu mode ()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check enable classic menu mode in Preferences for New  file.
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Register display in the Respective mode	
		[ ] //							Fail	     	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 08/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test04_VerifyRegisterDisplayinClassicMenuMode() appstate none
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] INTEGER iCreateDataFile,iRegistration,iAddAccount, iClickAssetAccount
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData,lsAddAccount
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sRegisterExcelsheet = "BankingRegister"
		[ ] STRING sAccountWorksheet = "Account"
		[ ] STRING sActual, sAccountName = "Checking Account"
		[ ] BOOLEAN bMatch
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] // NavigateQuickenTab(sTAB_HOME)
			[ ] // QuickenMainWindow.QWNavigator.Accounts.Click()
			[ ] 
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] // Fetch 1st row from the given sheet
			[ ] lsAddAccount=lsExcelData[1]
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2], lsAddAccount[3])
			[ ] 
			[ ] SelectPreferenceType("Navigation")
			[ ] Preferences.UseClassicMenus.Check()
			[ ] Preferences.OK.Click()
			[ ] QuickenWindow.View.Click()
			[ ] bCheck=QuickenWindow.View.ClassicMenus.IsChecked
			[+] if (bCheck==TRUE)
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu is enabled ")
			[+] else
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu is not enabled")
			[ ] QuickenWindow.TypeKeys(KEY_ESC)
			[ ] SelectPreferenceType("Register")
			[ ] Preferences.UsePopUpRegisters.Check()
			[ ] Preferences.OK.Click()
			[ ] QuickenWindow.View.Click()
			[ ] bCheck=QuickenWindow.View.UsePopUpRegisters.IsChecked
			[+] if (bCheck==TRUE)
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", PASS, "Use PopUp Registers is enabled")
			[+] else
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", FAIL, "Use PopUp Registers checkbox is not enabled")
				[ ] 
			[ ] QuickenWindow.TypeKeys(KEY_ESC)
			[ ] //For selecting the checking account in the Account Bar
			[ ] iClickAssetAccount = AccountBarSelect(ACCOUNT_BANKING,1)
			[+] if (iClickAssetAccount==PASS)
				[ ] ReportStatus("Validate Checking account is selected", PASS, "Checking account is selected")
			[+] else
				[ ] ReportStatus("Validate Checking account is selected", FAIL, "Checking account is not selected")
			[ ] 
			[+] if(BankingPopUp.Exists(5))
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", PASS, "Use PopUp Registers is enabled")
			[+] else
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", FAIL, "Use PopUp Registers checkbox is not enabled")
				[ ] 
			[ ] 
			[ ] //To disable Popup register
			[ ] // UsePopupRegister("OFF")
			[ ] QuickenWindow.View.Click()
			[ ] QuickenWindow.View.UsePopUpRegisters.Click()
			[ ] 
			[ ] sleep(2)
			[ ] AccountBarSelect(ACCOUNT_BANKING,1)
			[ ] sleep(2)
			[ ] sActual=QuickenMainWindow.GetCaption()
			[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
			[ ] sleep(1)
			[+] if(bMatch)
				[ ] ReportStatus("Validate Checking Account display in Document Register mode", PASS, " Checking Account display in Document Register mode")
			[+] else
				[ ] ReportStatus("Validate Checking Account display in Document Register moder", FAIL, "Checking Account is not display in Document Register mode")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
			[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //############## Verify Popup Mode - Register not available in Start-up ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test05_Verify Popup Mode - Register not available in Start-up ()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check Popup Mode - Register not available in Start-up 
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Register display in the Respective mode	
		[ ] //							Fail	     	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 07/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test05_VerifyPopupModeRegisternotavailableinStartup() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] INTEGER iCreateDataFile,iRegistration,iAddAccount, iClickAssetAccount
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData,lsAddAccount
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sRegisterExcelsheet = "BankingRegister"
		[ ] STRING sAccountWorksheet = "Account"
		[ ] STRING sActual, sAccountName = "Checking Account"
		[ ] BOOLEAN bMatch
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] // Fetch 1st row from the given sheet
			[ ] lsAddAccount=lsExcelData[1]
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2], lsAddAccount[3])
			[ ] 
			[ ] 
			[ ] 
			[ ] //Enable Classic menus
			[ ] SelectPreferenceType("Navigation")
			[ ] Preferences.UseClassicMenus.Check()
			[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
			[+] if (bCheck==TRUE)
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu is enabled ")
			[+] else
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu is not enabled")
			[ ] 
			[ ] //Close preferences
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify if Pop Up registers are enabled
			[+] SelectPreferenceType("Register")
				[ ] bCheck=Preferences.UsePopUpRegisters.IsChecked()
			[+] if (bCheck==FALSE)
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", PASS, "Use PopUp Registers is enabled")
			[+] else
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", FAIL, "Use PopUp Registers checkbox is not enabled")
			[ ] 
			[ ] 
			[ ] //Enable pop Up registers
			[ ] Preferences.UsePopUpRegisters.Check()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
			[ ] 
			[ ] 
			[ ] //For selecting the checking account in the Account Bar
			[ ] iClickAssetAccount = AccountBarSelect(ACCOUNT_BANKING,1)
			[+] if (iClickAssetAccount==PASS)
				[ ] ReportStatus("Validate Checking account is selected", PASS, "Checking account is selected")
			[+] else
				[ ] ReportStatus("Validate Checking account is selected", FAIL, "Checking account is not selected")
			[ ] 
			[+] if(BankingPopUp.Exists(5))
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", PASS, "Use PopUp Registers is enabled")
			[+] else
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", FAIL, "Use PopUp Registers checkbox is not enabled")
				[ ] 
			[ ] 
			[ ] 
			[ ] //To disable Popup register
			[ ] // UsePopupRegister("OFF")
			[ ] QuickenWindow.View.Click()
			[ ] QuickenWindow.View.UsePopUpRegisters.Click()
			[ ] 
			[ ] sleep(2)
			[ ] AccountBarSelect(ACCOUNT_BANKING,1)
			[ ] sleep(2)
			[ ] sActual=QuickenMainWindow.GetCaption()
			[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
			[ ] sleep(1)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Checking Account display in Document Register mode", PASS, " Checking Account display in Document Register mode")
			[+] else
				[ ] ReportStatus("Validate Checking Account display in Document Register moder", FAIL, "Checking Account is not display in Document Register mode")
			[ ] 
			[ ] //Uncheck classic Menus
			[ ] SelectPreferenceType("Navigation")
			[ ] Preferences.UseClassicMenus.Uncheck()
			[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
			[+] if (bCheck==FALSE)
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu is unchecked ")
			[+] else
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu is checked")
			[ ] 
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //############## Verify Register preferences for New file  ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test07_Register preferences for New file()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check Register preferences for New file
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass   if all the Register settings exists in preferences 
		[ ] //							Fail	     if all the Register settings are not exists in preferences 
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 08/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test07_RegisterPreferencesForNewFile() appstate none
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] INTEGER iCreateDataFile,iRegistration,iAddAccount, iClickAssetAccount
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] 
			[ ] SelectPreferenceType("Register")
			[ ] //To check Register fields section in Preferences
			[+] if (Preferences.RegisterFieldsText.Exists(1))
				[ ] ReportStatus("Verify Register Fields label is exists in Register Preferences", PASS, "Register Fields label is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify Register Fields label is exists in Register Preferences", FAIL, "Register Fields label is not exists in Register Preferences ")
			[+] if (Preferences.ShowDateBeforeCheckNumber.Exists(1))
				[ ] ReportStatus("Verify ShowDateBeforeCheckNumber checkbox is exists in Register Preferences", PASS, "ShowDateBeforeCheckNumber checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify ShowDateBeforeCheckNumber checkbox is exists in Register Preferences", FAIL, "ShowDateBeforeCheckNumber checkbox is not exists in Register Preferences ")
			[+] if (Preferences.ShowMemoBeforeCategory.Exists(1))
				[ ] ReportStatus("Verify ShowMemoBeforeCategory checkbox is exists in Register Preferences", PASS, "ShowMemoBeforeCategory checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify ShowMemoBeforeCategory checkbox is exists in Register Preferences", FAIL, "ShowMemoBeforeCategory checkbox is not exists in Register Preferences ")
				[ ] 
				[ ] //To check Transactions Entry section in Preferences
			[+] if (Preferences.TransactionEntryText.Exists(1))
				[ ] ReportStatus("Verify Transaction Entry label is exists in Register Preferences", PASS, "Transaction Entry label is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify Transaction Entry label is exists in Register Preferences", FAIL, "Transaction Entry label is not exists in Register Preferences ")
			[+] if (Preferences.AutomaticallyEnterSplitData.Exists(1))
				[ ] ReportStatus("Verify AutomaticallyEnterSplitData checkbox is exists in Register Preferences", PASS, "AutomaticallyEnterSplitData checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify AutomaticallyEnterSplitData checkbox is exists in Register Preferences", FAIL, "AutomaticallyEnterSplitData checkbox is not exists in Register Preferences ")
				[ ] 
			[+] if (Preferences.AutomaticallyPlaceDecimalPoint.Exists(1))
				[ ] ReportStatus("Verify AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences", PASS, "AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences", FAIL, "AutomaticallyPlaceDecimalPoint checkbox is not exists in Register Preferences ")
				[ ] 
				[ ] //To check Register Appearence section in Preferences
			[+] if (Preferences.RegisterAppearanceText.Exists(1))
				[ ] ReportStatus("Verify Register Appearance label is exists in Register Preferences", PASS, "Register Appearance  label is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify Register Appearance  label is exists in Register Preferences", FAIL, "Register Appearance  label is not exists in Register Preferences ")
			[ ] 
			[+] if (Preferences.GrayReconciledTransactions.Exists(1))
				[ ] ReportStatus("Verify GrayReconciledTransactions checkbox is exists in Register Preferences", PASS, "GrayReconciledTransactions checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify GrayReconciledTransactions checkbox is exists in Register Preferences", FAIL, "GrayReconciledTransactions checkbox is not exists in Register Preferences ")
			[ ] 
			[+] if (Preferences.RememberRegisterFiltersAfterQuickenCloses.Exists(1))
				[ ] ReportStatus("Verify RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences", PASS, "RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences", FAIL, "RememberRegisterFiltersAfterQuickenCloses checkbox is not exists in Register Preferences ")
				[ ] 
			[+] if (Preferences.UsePopUpRegisters.Exists(1))
				[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", PASS, "UsePopUpRegisters checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", FAIL, "UsePopUpRegisters checkbox is not exists in Register Preferences ")
			[ ] 
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
			[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[+] // //############## Verify Quick Fill Preferences - New File  ####################################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test09_Verify Quick Fill Preferences - New File  ()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This testcase will Verify Quick Fill Preferences - New File 
		[ ] // //
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass 	if Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences
		[ ] // //							Fail	      if any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:	
		[ ] // // 11/02/2013  	Created By	Indrajit Deshmukh
	[ ] // //*********************************************************
[+] testcase Test09_VerifyQuickFillPreferencesNewFile() appstate none
	[+] // Variable declaration
		[ ] STRING sHandle,sActual
		[ ] INTEGER iCreateDataFile,iRegistration
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
		[ ] 
		[ ] 
		[ ] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] 
			[ ] //To select Data entry & Quick Fill preferences
			[ ] SelectPreferenceType("Data entry and Quickfill")
			[ ] 
			[+] if (Preferences.RemoveMemorizedPayeesNotUsed.Exists(5))
				[ ] ReportStatus("Verify Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences", PASS, "Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences")
			[+] else
				[ ] ReportStatus("Verify Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences", FAIL, "Remove memorized payees not used in last  months is not exists in Data entry & Quick Fill preferences ")
			[ ] 
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
			[ ] 
			[ ] 
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] // 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken Asset Account Rgister ####################################### 
	[ ] // ********************************************************
	[+] // TestCase Name:Test01_AssetAccountRgister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Asset Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijit Sarma
		[ ] //	  
	[ ] // ********************************************************
	[ ] 
[+] testcase Test17_AssetAccountRegister () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="House"
		[ ] sAccName ="House Account1"
		[ ] sPrice="1000"
		[ ] sEstimatedValue="1050"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
	[ ] 
	[ ] 
	[ ] SetUp_AutoApi()
	[ ] 
	[ ] // Create new data file
	[ ] iCreateFile = DataFileCreate(sFileName)
	[ ] 
	[+] if ( iCreateFile  == PASS)
		[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
		[ ] 
		[ ] // Add Asset Account
		[ ] iAddAccount = AddPropertyAccount(sAccType, sAccName,sDateStamp,sPrice,sEstimatedValue)
		[+] if ( iAddAccount  == PASS)
			[ ] ReportStatus("Add Asset Account ", PASS, "Account -  {sAccName} is created")
			[ ] // On Popup Register
			[ ] iPopupRegister=UsePopupRegister("ON")
			[+] if (iPopupRegister==PASS)
				[ ] // Open the Asset Account register from ccount Bar
				[ ] iClickAccount = AccountBarSelect(ACCOUNT_PROPERTYDEBT,1)
				[ ] //get the caption of the popo up register
				[ ] sCaption = BankingPopUp.Getproperty("Caption")
				[ ] 
				[ ] //Match the caption and account name
				[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
					[ ] iAddTransaction =  AddPropertyTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Asset Transaction",PASS,"Asset Transaction Added")
					[+] else
						[ ] ReportStatus("Add Asset Transaction",FAIL,"Asset Transaction Not Added")
				[+] else
					[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
			[+] else
				[ ] ReportStatus("Verify  PopupRegister mode", FAIL, "PopupRegister mode couldn't be set ON")
			[ ] 
			[ ] 
		[ ] //Report Staus If Data file is not Created 
		[+] else
			[ ] ReportStatus("Add Asset  Account", FAIL, "Account -  {sAccName} is not created ")
		[ ] 
		[ ] 
		[+] if (BankingPopUp.Exists(3))
			[ ] BankingPopUp.SetActive()
			[ ] BankingPopUp.Close()
		[ ] 
		[ ] UsePopupRegister("OFF")
		[ ] 
		[ ] 
	[ ] //Report Staus If Data file is not Created 
	[+] else
		[ ] ReportStatus("Data fle not created ", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
		[ ] 
	[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken Vehicle Account Rgister ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test02_VehicleAccountRgister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Vehicle Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijity Sarma
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test18_VehicleAccountRegister () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sVehicleYear,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
			[ ] sAccType ="Vehicle"
			[ ] sAccName ="My Vehicle Account"
			[ ] sPrice="1000"
			[ ] sEstimatedValue="1050"
			[ ] sVehicleYear = "2012"
			[ ] sWindowType = "PopUp"
			[ ] sTransactionType = "Payment"
			[ ] sAmount = "50"
			[ ] sPayee = "Test Payee"
		[ ] 
	[ ] 
	[ ] // Add Vehicle Account
	[ ] iAddAccount = AddPropertyAccount(sAccType, sAccName,sDateStamp,sPrice,sEstimatedValue,"",sVehicleYear)
	[ ] 
	[+] if ( iAddAccount  == PASS)
		[ ] ReportStatus("Add vehicle Account ", PASS, "Account -  {sAccName} is created")
	[ ] 
	[+] else
		[ ] ReportStatus("Add vehicle Account ", FAIL, "Account -  {sAccName} is not created ")
	[ ] 
	[ ] // On Popup Register
	[ ] iPopupRegister = UsePopupRegister("ON")
	[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
	[ ] 
	[ ] // Open the Vehicle  Account register from Acount Bar
	[ ] iClickAccount = SelectAccountFromAccountBar(sAccName, ACCOUNT_PROPERTYDEBT)
	[ ] //Get the caption of the popo up register
	[ ] sCaption = BankingPopUp.Getproperty("Caption")
	[ ] 
	[ ] //Match the caption and account name
	[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
	[+] if(bMatch == TRUE)
		[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
	[+] else
		[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
	[ ] 
	[ ] iAddTransaction =  AddPropertyTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
	[ ] ReportStatus("Add Vehicle Transaction",iAddTransaction,"Vehicle Transaction Added")
	[+] if (BankingPopUp.Exists(3))
		[ ] BankingPopUp.SetActive()
		[ ] BankingPopUp.Close()
	[ ] 
	[ ] UsePopupRegister("OFF")
	[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken Other Asset Account Rgister ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test01_AssetAccountRgister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Other Asset Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijity Sarma
		[ ] //	  
	[ ] // ********************************************************
	[ ] 
[+] testcase Test19_OtherAssetAccountRegister () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="Other Asset"
		[ ] sAccName ="Other Asset Account"
		[ ] sEstimatedValue="1050"
		[ ] sPrice="1000"
		[ ] sWindowType = "PopUp"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Add Other Type Asset Account
			[ ] iAddAccount = AddPropertyAccount(sAccType, sAccName,sDateStamp,sPrice,sEstimatedValue)
			[+] if ( iAddAccount  == PASS)
				[ ] ReportStatus("Add property Account- Other Type Asset Account ", PASS, "Account -  {sAccName} is created")
			[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Add property Account- Other Type Asset Account ", FAIL, "Account -  {sAccName} is not created ")
			[ ] 
			[ ] // On Popup Register
			[ ] iPopupRegister = UsePopupRegister("ON")
			[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
			[ ] 
			[ ] // Open the Other Asset Account register from ccount Bar
			[ ] iClickAccount = SelectAccountFromAccountBar(sAccName ,ACCOUNT_PROPERTYDEBT)
			[ ] //Get the caption of the popo up register
			[ ] sCaption = BankingPopUp.Getproperty("Caption")
			[ ] 
			[ ] //Match the caption and account name
			[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
			[+] else
				[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
			[ ] 
			[ ] iAddTransaction =  AddPropertyTransaction("PopUp","Payment","50",sDateStamp,"XYZ","ABC")
			[ ] ReportStatus("Add Property Transaction",iAddTransaction,"Property Transaction Added")
			[+] if (BankingPopUp.Exists(3))
				[ ] BankingPopUp.SetActive()
				[ ] BankingPopUp.Close()
			[ ] 
			[ ] UsePopupRegister("OFF")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
	[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] //############# Verify Quicken Account Receivable Account Rgister #############################
[+] testcase Test20_AccReceivableAccountRegister () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="Accounts Receivable"
		[ ] sAccName ="Customer Invoice Account"
		[ ] sPrice="1000"
		[ ] sEstimatedValue="1050"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Create new data file
			[ ] iCreateFile = DataFileCreate(sFileName)
			[ ] 
			[+] if ( iCreateFile  == PASS)
				[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
				[ ] 
				[ ] // Add Account Receivable Account
				[ ] iAddAccount = AddBusinessAccount(sAccType, sAccName)
				[+] if ( iAddAccount  == PASS)
					[ ] ReportStatus("Add Business Account- Account Receivable ", PASS, "Account -  {sAccName} is created")
				[ ] //Report Staus If Data file is not Created 
				[+] else
					[ ] ReportStatus("Add Business Account- Account Receivable", FAIL, "Account -  {sAccName} is not created ")
				[ ] 
				[ ] // On Popup Register
				[ ] iPopupRegister = UsePopupRegister("ON")
				[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
				[ ] 
				[ ] // Open the Account Receivable register from Account Bar
				[ ] iClickAccount = SelectAccountFromAccountBar(sAccName ,ACCOUNT_BUSINESS)
				[ ] //get the caption of the popo up register
				[ ] sCaption = BankingPopUp.Getproperty("Caption")
				[ ] 
				[ ] //Match the caption and account name
				[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
				[+] else
					[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
				[ ] 
				[ ] // Add Business Transaction // Function for adding Business Transaction to be written
				[ ] // iAddTransaction =  AddBusinessTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
				[ ] // ReportStatus("Add Business Transaction",iAddTransaction,"Business Transaction Added")
				[+] if (BankingPopUp.Exists(3))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Close()
				[ ] 
				[ ] UsePopupRegister("OFF")
				[ ] 
				[ ] 
			[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Add Data File", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //############ Verify Quicken Account payable Account Rgister ################################
[+] testcase Test21_AccPayableAccountRegister () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="Accounts Payable"
		[ ] sAccName ="Business Bill Account"
		[ ] sPrice="1000"
		[ ] sEstimatedValue="1050"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Add Accounts Payable Account
			[ ] iAddAccount = AddBusinessAccount(sAccType, sAccName)
			[+] if ( iAddAccount  == PASS)
				[ ] ReportStatus("Add Business Account- Account payable ", PASS, "Account -  {sAccName} is created")
			[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Add Business Account-Account payable  ", FAIL, "Account -  {sAccName} is not created ")
			[ ] 
			[ ] // On Popup Register
			[ ] iPopupRegister = UsePopupRegister("ON")
			[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
			[ ] 
			[ ] // Open the Asset Account register from ccount Bar
			[ ] iClickAccount = SelectAccountFromAccountBar(sAccName, ACCOUNT_BUSINESS)
			[ ] //get the caption of the popo up register
			[ ] sCaption = BankingPopUp.Getproperty("Caption")
			[ ] 
			[ ] //Match the caption and account name
			[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
			[+] else
				[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
			[ ] 
			[ ] // Add Business Transaction // Function for adding Business Transaction to be written
			[ ] // iAddTransaction =  AddBusinessTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
			[ ] // ReportStatus("Add Business Transaction",iAddTransaction,"Business Transaction Added")
			[+] if (BankingPopUp.Exists(3))
				[ ] BankingPopUp.SetActive()
				[ ] BankingPopUp.Close()
			[ ] 
			[ ] UsePopupRegister("OFF")
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken Other Liability  Account Rgister ################################# 
	[ ] // ********************************************************
	[+] // TestCase Name:Test01_AssetAccountRgister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Asset Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijity Sarma
		[ ] //	  
	[ ] // ********************************************************
	[ ] 
[+] testcase Test22_OtherLiabilityAccountRegister () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="Other Liability"
		[ ] sAccName ="New Liability Account"
		[ ] sPrice="1000"
		[ ] sEstimatedValue="1050"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Create new data file
			[ ] iCreateFile = DataFileCreate(sFileName)
			[ ] 
			[+] if ( iCreateFile  == PASS)
				[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
				[ ] 
				[ ] // Add Asset Account
				[ ] iAddAccount = AddOtherLiabilityAccount( sAccType, sAccName, sDateStamp)
				[ ] 
				[+] if ( iAddAccount  == PASS)
					[ ] ReportStatus("Add Other liability Account ", PASS, "Account -  {sAccName} is created")
				[ ] //Report Staus If Data file is not Created 
				[+] else
					[ ] ReportStatus("Add Other liability Account", FAIL, "Account -  {sAccName} is not created ")
				[ ] 
				[ ] // On Popup Register
				[ ] iPopupRegister = UsePopupRegister("ON")
				[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
				[ ] 
				[ ] // Open the Asset Account register from ccount Bar
				[ ] iClickAccount = SelectAccountFromAccountBar(sAccName, ACCOUNT_PROPERTYDEBT)
				[ ] //get the caption of the popo up register
				[ ] sCaption = BankingPopUp.Getproperty("Caption")
				[ ] 
				[ ] //Match the caption and account name
				[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
				[+] else
					[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
				[ ] 
				[ ] iAddTransaction =  AddPropertyTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
				[ ] ReportStatus("Add Liability Transaction",iAddTransaction,"Liability Transaction Added")
				[+] if (BankingPopUp.Exists(3))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Close()
				[ ] 
				[ ] UsePopupRegister("OFF")
				[ ] 
				[ ] 
			[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Data fle not created ", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] //##################Verify Correct Window Title displayed in Account Register ####################
[+] testcase Test35_CheckingAccountRgisterTitle () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sAccBalance,sWindowType,sTransactionType,sAmount,sChkNo,sPayee,sMemo, sCategory
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sWindowType="PopUp"
		[ ] sAccType ="Checking"
		[ ] sAccName ="Checking Account"
		[ ] sAccBalance="1000"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] sChkNo = "101"
		[ ] sMemo = "Memo"
		[ ] sCategory= "Auto"
		[ ] 
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Create new data file
			[ ] iCreateFile = DataFileCreate(sFileName)
			[+] if ( iCreateFile  == PASS)
				[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
				[ ] // Add Asset Account
				[ ] 
				[ ] iAddAccount = AddManualSpendingAccount(sAccType, sAccName,sAccBalance,sDateStamp)
				[+] if ( iAddAccount  == PASS)
					[ ] ReportStatus("Add Checking Account ", PASS, "Account -  {sAccName} is created")
				[ ] //Report Staus If Data file is not Created 
				[+] else
					[ ] ReportStatus("Add Checking Account ", FAIL, "Account -  {sAccName} is not created ")
					[ ] 
				[ ] //On Popup Register
				[ ] iPopupRegister = UsePopupRegister("ON")
				[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
				[ ] 
				[ ] //Open the Asset Account register from ccount Bar
				[ ] iClickAccount = SelectAccountFromAccountBar(sAccName, ACCOUNT_BANKING)
				[ ] 
				[ ] //get the caption of the popo up register
				[ ] sCaption = BankingPopUp.Getproperty("Caption")
				[ ] 
				[ ] //Match the caption and account name
				[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
				[+] else
					[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
				[ ] // Add Transaction to register
				[ ] iAddTransaction =  AddCheckingTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sChkNo,sPayee,sMemo,sCategory)
				[ ] ReportStatus("Add Banking Transaction",iAddTransaction,"Banking Transaction Added")
				[+] if (BankingPopUp.Exists(3))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Close()
				[ ] 
				[ ] 
				[ ] UsePopupRegister("OFF")
				[ ] 
				[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Data fle not created ", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[+] //Global variables
	[ ] public STRING sStartQuicken = "{QUICKEN_ROOT}\qw.exe"
	[ ] public BOOLEAN  bExist
	[ ] 
	[ ] STRING sCCMintBankAccountId = "testuser"
	[ ] STRING sCCMintBankAccountPass = "testuser123"
	[ ] 
[ ] 
[ ] 
[+] // //###############TC93_UndoAcceptAll()###############################
	[ ] // // **************************************************************************************
	[+] // // TestCase Name:	 TC93_UndoAcceptAll()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will create a New Register.QDF
		[ ] // // This test case will verify Undo Accept All Transaction functionality
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	   If Undo Accept All Transaction functionality works.
		[ ] // //				        Fail		   If Undo Accept All Transaction functionality does not work.
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Feb 08, 2013		Anagha Bhandare created
	[ ] // // **************************************************************************************
[+] testcase TC93_UndoAcceptAll() appstate none
	[ ] 
	[ ] integer iCreateDataFile,iAddAccount,iNavigate,iResult,iSelect,iOpenAccountRegister
	[ ] STRING sPayee = "Opening Balance",sAction = "Undo Accept All Transactions"
	[ ] STRING sAccBalanceBefore = "100",sAccBalanceAfter ="100"
	[ ] STRING sCCMintBankAccountId ,sCCMintBankAccountPass
	[ ] integer iSetupAutoAPI 
	[ ] sCCMintBankAccountId="datasync"
	[ ] sCCMintBankAccountPass =sCCMintBankAccountId
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] //Create Data File
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[ ] //Report Staus If Data file Created successfully
	[ ] 
	[+] if(iCreateDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS , "Data file -  {sDataFile} is created")
		[ ] //Set C2R Mode On
		[ ] iResult=SetC2RMode("ON")
		[ ] 
		[+] if(iResult==PASS)
			[ ] ReportStatus("Turn ON C2R",iResult,"C2R mode is turned ON")
			[ ] AddCCMintBankAccount(sCCMintBankAccountId,sCCMintBankAccountPass)
			[ ] 
			[ ] // Opening Checking Account Register
			[ ] iOpenAccountRegister=AccountBarSelect(ACCOUNT_BANKING,1)
			[ ] 
			[+] if(iOpenAccountRegister==PASS)
				[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
				[ ] // Verify that Balances is same to opening balance before accepting the online transactions
				[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
				[ ] iListCount= QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()
				[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch = MatchStr("*{sAccBalanceBefore}*", sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[ ] 
				[+] if(bMatch)
					[ ] ReportStatus("Validate Balance in Account Bar", PASS, "Account Balance- {sAccBalanceBefore} before accepting all transaction")
					[ ] // Click on Accept All 
					[ ] AcceptAll.Click ()
					[ ] 
					[ ] sleep(5)
					[ ] // Verify that Balances is same to opening balance after accepting the online transactions
					[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
					[ ] iListCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()
					[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
						[ ] bMatch = MatchStr("*{sAccBalanceAfter}*", sActual)
						[+] if(bMatch)
							[ ] break
					[ ] 
					[ ] 
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Balance in Account Bar after accepting transactions", PASS, "Account Balance- {sAccBalanceAfter} after accepting all transaction")
						[ ] //Right - click for Undo - Accept All 
						[ ] AccountActionsOnTransaction( sMDIWindow,"",sAction)
						[ ] 
						[ ] 
						[ ] // Verify that Balances is same to opening balance after Undo accept all the online transactions
						[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
						[ ] iListCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()
						[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
							[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
							[ ] bMatch = MatchStr("*{sAccBalanceBefore}*", sActual)
							[+] if(bMatch)
								[ ] break
						[ ] 
						[+] if(bMatch )
							[ ] ReportStatus("Validate Balance in Account Bar after ", PASS, "Account Balance- {sAccBalanceBefore} after undo accepting all transaction")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Balance in Account Bar", FAIL, "Account Balance- {sAccBalanceBefore} after undo accepting all transaction")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Balance in Account Bar", FAIL, "Account Balance- {sAccBalanceAfter} after accepting all transaction")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Balance in Account Bar", FAIL, "Account Balance: expected- {sAccBalanceBefore} and actual- {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Account is selected from AccountBar", FAIL , "account is not selected from AccountBar")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Turn ON C2R",iResult,"C2R mode is not turned ON")
		[ ] 
		[ ] //Report Staus If Data file is not Created 
	[+] else
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] //Report Staus If Data file already exists
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Tax Line Item Assignment in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC98_VerifyTaxLineItemAssignmentInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Tax Line Item Assignment option in account register and click on cancel button
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If matching transfer is selected	
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC98_VerifyTaxLineItemAssignmentInRegister_Cancel() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sTaxLineItemAssignAction="Tax Line Item Assignments"
		[ ] //BOOLEAN bMatch
		[ ] LIST OF STRING lsTaxScheduleReportContents,lsSubStringsTaxItem
		[ ] STRING sTaxItem
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsTxnExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] 
		[ ] //BOOLEAN bMatch1,bMatch2
		[ ] 
		[ ] 
		[ ] //STRING sMoveCancelExpectedNumberOfTransactionsC1="0"
		[ ] //STRING sMoveCancelExpectedNumberOfTransactionsC2="1"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iVerify = DataFileCreate(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] //Read data from excel sheet
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] 
			[+] if(iLoop==2)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
				[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
				[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Add Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Select Account From Account Bar
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Tax Line Item Assignment",PASS,"Account {lsAddAccount[2]} selected successfully")
					[ ] 
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsTransactionData=lsTxnExcelData[4]
					[ ] 
					[ ] //Add Checking Transaction
					[+] if(iLoop==1)
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDateStamp,lsTransactionData[4],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added to {lsAddAccount[2]} account") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
						[ ] 
						[ ] 
						[ ] 
					[ ] //Add Savings,Credit Card and Cash Account Transactions
					[+] if(iLoop>1)
						[ ] 
						[ ] 
						[ ] iVerify= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDateStamp,NULL,lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added to {lsAddAccount[2]} account") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
						[ ] 
						[ ] 
					[ ] 
					[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sTaxLineItemAssignAction)
					[+] if(TaxLineItemAssignments.Exists(3))
						[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{sTaxLineItemAssignAction} option is selected") 
						[ ] 
						[ ] 
						[ ] TaxLineItemAssignments.SetActive()
						[ ] //Verify Tax Item
						[ ] TaxLineItemAssignments.TaxItem.Select(12)                 
						[ ] 
						[ ] 
						[ ] TaxLineItemAssignments.Cancel.Click()
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify in Tax Schedule Report---------------------------------------------------------------------------
						[ ] 
						[ ] //Open Tax schedule report
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Reports.Click()
						[ ] QuickenWindow.Reports.Tax.Click()
						[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
						[ ] 
						[ ] i=TaxScheduleReport.QWListViewer1.ListBox1.GetItemCount()
						[+] if(i==1)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Tax Line Item has not been assigned")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Tax Line Item has not been assigned")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] TaxScheduleReport.Close()
						[ ] WaitForState(TaxScheduleReport,false,1)
						[ ] //clear search field
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
						[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{sTaxLineItemAssignAction} option is not selected") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Tax Line Item Assignment",FAIL,"Account {lsAddAccount[2]} not selected")
			[+] else
				[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Account -  {lsAddAccount[2]}  is not added")
				[ ] 
		[ ] 
	[+] // else
		[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "Error during Data file creation for file -  {sFileName} ")
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] // // //############# Verify Tax Line Item Assignment in Account Register ###############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC99_VerifyTaxLineItemAssignmentInRegister_OK()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify Tax Line Item Assignment option in account register and click on OK button
		[ ] // // .
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 		 If matching transfer is selected	
		[ ] // // Fail		       If any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] // // 
	[ ] // // ********************************************************
[+] testcase TC99_VerifyTaxLineItemAssignmentInRegister_OK() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,iSelectTaxItem=0,iMatchIncrement
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sTaxLineItemAssignAction="Tax Line Item Assignments"
		[ ] //BOOLEAN bMatch
		[ ] LIST OF STRING lsTaxScheduleReportContents,lsSubStringsTaxItem
		[ ] STRING sTaxItem
		[ ] 
		[ ] 
		[ ] 
		[ ] //STRING sMoveCancelExpectedNumberOfTransactionsC1="0"
		[ ] //STRING sMoveCancelExpectedNumberOfTransactionsC2="1"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[4]
	[ ] 
	[ ] //Open New Data File---------------------------------------------------------------------------------
	[ ] 
	[ ] iVerify = OpenDataFile(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Data file -  {sFileName} is opened")
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=1
				[ ] 
			[+] if(iLoop==2)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=5
				[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=5
				[ ] 
				[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=9
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify Tax Line Item Assignment",PASS,"Account {lsAddAccount[2]} selected successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sTaxLineItemAssignAction)
				[ ] //sleep(2)
				[+] if(TaxLineItemAssignments.Exists(3))
					[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{sTaxLineItemAssignAction} option is selected") 
					[ ] 
					[ ] TaxLineItemAssignments.SetActive()
					[ ] //Verify Tax Item
					[ ] iSelectTaxItem=iSelectTaxItem+10
					[ ] TaxLineItemAssignments.TaxItem.Select(iSelectTaxItem)                 
					[ ] sTaxItem=TaxLineItemAssignments.TaxItem.GetSelText()
					[ ] 
					[ ] 
					[ ] lsSubStringsTaxItem=Split(sTaxItem,":")
					[ ] 
					[ ] TaxLineItemAssignments.OK.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify in Tax Schedule Report---------------------------------------------------------------------------
					[ ] 
					[ ] //Open Tax schedule report
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Reports.Click()
					[ ] QuickenWindow.Reports.Tax.Click()
					[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
					[ ] 
					[ ] 
					[ ] sHandle=Str(TaxScheduleReport.QWListViewer1.ListBox1.GetHandle())
					[ ] iListCount=TaxScheduleReport.QWListViewer1.ListBox1.GetItemCount()
					[ ] 
					[ ] 
					[ ] //Match first part of tax item to report entry
					[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
						[ ] bMatch = MatchStr("*{lsSubStringsTaxItem[1]}*", sActual)
						[+] if (bMatch)
							[ ] break
					[+] if(bMatch)
						[ ] 
						[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[1]} matched")
						[ ] 
						[ ] 
						[ ] //Match Second part of tax item to report entry
						[ ] sActual=NULL
						[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
							[ ] bMatch = MatchStr("*{lsSubStringsTaxItem[2]}*", sActual)
							[+] if (bMatch)
								[ ] break
							[ ] 
						[+] if(bMatch)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[2]} matched")
							[ ] 
							[ ] 
							[ ] //Match Account Name to report entry
							[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
								[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
								[+] if (bMatch)
									[ ] break
								[ ] 
							[+] if(bMatch)
								[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsAddAccount[2]} matched")
								[ ] 
								[ ] 
								[ ] //Match Payee Name to report entry
								[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
									[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
									[ ] bMatch = MatchStr("*{lsTransactionData[6]}*", sActual)
									[+] if (bMatch)
										[ ] break
									[ ] 
								[+] if(bMatch)
									[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[6]} matched")
								[+] else
									[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsTransactionData[6]} not matched")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsAddAccount[2]} matched")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[1]} not matched")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[2]} not matched")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] TaxScheduleReport.Close()
					[ ] WaitForState(TaxScheduleReport,false,1)
					[+] if(TaxScheduleReport.Exists(2))
						[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Report Not Closed")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Report Closed")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{sTaxLineItemAssignAction} option is not selected") 
				[ ] 
				[ ] //clear search field
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Tax Line Item Assignment",FAIL,"Account {lsAddAccount[2]} not selected")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Data file -  {sFileName} not opened")
		[ ] 
[ ] 
[ ] 
[+] // //############# Verify Tax Line Item Assignment in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC100_VerifyTaxLineItemAssignmentInRegister_New()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Tax Line Item Assignment option in account register and create new Tax line item
		[ ] // .
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		 If matching transfer is selected	
		[ ] // Fail		       If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] // 
	[ ] // ********************************************************
[+] testcase TC100_VerifyTaxLineItemAssignmentInRegister_New() appstate RegisterBaseState
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,iMatchIncrement
		[ ] INTEGER iSelectTaxItem=2
		[ ] 
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sTaxLineItemAssignAction="Tax Line Item Assignments"
		[ ] 
		[ ] LIST OF STRING lsTaxScheduleReportContents,lsSubStringsTaxItem
		[ ] STRING sTaxItem
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[4]
	[ ] 
	[ ] 
	[ ] 
	[ ] //Open New Data File---------------------------------------------------------------------------------
	[ ] iVerify = OpenDataFile(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Data file -  {sFileName} is opened")
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=1
				[ ] 
			[+] if(iLoop==2)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=13
				[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=5
				[ ] 
				[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=9
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify Tax Line Item Assignment",PASS,"Account {lsAddAccount[2]} selected successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sTaxLineItemAssignAction)
				[ ] //sleep(2)
				[+] if(TaxLineItemAssignments.Exists(3))
					[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{sTaxLineItemAssignAction} option is selected") 
					[ ] 
					[ ] TaxLineItemAssignments.SetActive()
					[ ] //Verify Tax Item
					[ ] iSelectTaxItem=iSelectTaxItem+10
					[ ] TaxLineItemAssignments.TaxItem.Select(iSelectTaxItem)                 
					[ ] sTaxItem=TaxLineItemAssignments.TaxItem.GetSelText()
					[ ] 
					[ ] 
					[ ] lsSubStringsTaxItem=Split(sTaxItem,":")
					[ ] 
					[ ] TaxLineItemAssignments.OK.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify in Tax Schedule Report---------------------------------------------------------------------------
					[ ] 
					[ ] //Open Tax schedule report
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Reports.Click()
					[ ] QuickenWindow.Reports.Tax.Click()
					[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
					[ ] 
					[ ] 
					[ ] sHandle=Str(TaxScheduleReport.QWListViewer1.ListBox1.GetHandle())
					[ ] iListCount=TaxScheduleReport.QWListViewer1.ListBox1.GetItemCount()
					[+] // for(i=TaxScheduleReport.QWListViewer1.ListBox1.GetItemCount();i>=1;i--)
						[ ] // ListAppend(lsTaxScheduleReportContents, QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{i}"))
						[ ] // 
						[ ] // 
					[ ] 
					[ ] 
					[ ] //Match first part of tax item to report entry
					[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
						[ ] bMatch = MatchStr("*{lsSubStringsTaxItem[1]}*", sActual)
						[+] if (bMatch)
							[ ] break
					[+] if(bMatch)
						[ ] 
						[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[1]} matched")
						[ ] 
						[ ] 
						[ ] //Match Second part of tax item to report entry
						[ ] sActual=NULL
						[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
							[ ] bMatch = MatchStr("*{lsSubStringsTaxItem[2]}*", sActual)
							[+] if (bMatch)
								[ ] break
							[ ] 
						[+] if(bMatch)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[2]} matched")
							[ ] 
							[ ] 
							[ ] //Match Account Name to report entry
							[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
								[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
								[+] if (bMatch)
									[ ] break
								[ ] 
							[+] if(bMatch)
								[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsAddAccount[2]} matched")
								[ ] 
								[ ] 
								[ ] //Match Payee Name to report entry
								[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
									[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
									[ ] bMatch = MatchStr("*{lsTransactionData[6]}*", sActual)
									[+] if (bMatch)
										[ ] break
									[ ] 
								[+] if(bMatch)
									[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[6]} matched")
								[+] else
									[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsTransactionData[6]} not matched")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsAddAccount[2]} matched")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[1]} not matched")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[2]} not matched")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] // if(bMatch==TRUE)
						[ ] // 
						[ ] // ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[1]} matched")
						[ ] // 
						[ ] // 
						[ ] // //Match Second part of tax item to report entry
						[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iMatchIncrement+1}")
						[ ] // bMatch = MatchStr("*{lsSubStringsTaxItem[2]}*", sActual)
						[ ] // sActual=NULL
						[+] // if(bMatch==TRUE)
							[ ] // ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[2]} matched")
							[ ] // 
							[ ] // 
							[ ] // //Match Account Name to report entry
							[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iMatchIncrement+2}")
							[ ] // bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
							[ ] // sActual=NULL
							[+] // if(bMatch==TRUE)
								[ ] // ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsAddAccount[2]} matched")
								[ ] // 
								[ ] // 
								[ ] // //Match Payee Name to report entry
								[ ] // 
								[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iMatchIncrement+2}")
								[ ] // bMatch = MatchStr("*{lsTransactionData[6]}*", sActual)
								[+] // if(bMatch==TRUE)
									[ ] // ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[6]} matched")
									[ ] // 
								[+] // else
									[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsTransactionData[6]} not matched")
								[ ] // 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsAddAccount[2]} matched")
								[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[1]} not matched")
							[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[2]} not matched")
						[ ] // 
						[ ] // 
						[ ] // 
					[ ] // 
					[ ] 
					[ ] TaxSchedule.Close()
					[ ] WaitForState(TaxSchedule,false,1)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{sTaxLineItemAssignAction} option is not selected") 
				[ ] 
				[ ] //clear search field
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Tax Line Item Assignment",FAIL,"Account {lsAddAccount[2]} not selected")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Data file -  {sFileName} not opened")
		[ ] 
[ ] 
[ ] 
[ ] 
[+] //////################Open Register Preferences From Account Actions###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC83_OpenRegisterPreferencesFromAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Preferences window is opened and Register Preferences are displayed from Account Actions window
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  06/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC83_OpenRegisterPreferencesFromAccountActions() appstate RegisterBaseState
	[ ] 
	[ ] 
	[+] //Variable
		[ ] INTEGER iCount,iAccountActionsOption
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] 
		[ ] //Read data from excel sheet
		[ ] 
		[ ] 
		[ ] 
		[+] if(iLoop==1)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[1]
			[ ] iAccountActionsOption=NULL
			[ ] iAccountActionsOption=18
			[ ] 
			[ ] 
		[+] if(iLoop==2)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[2]
			[ ] iAccountActionsOption=NULL
			[ ] iAccountActionsOption=18
			[ ] 
		[+] if(iLoop==3)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[3]
			[ ] iAccountActionsOption=NULL
			[ ] iAccountActionsOption=17
			[ ] 
			[ ] 
		[+] if(iLoop==4)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[4]
			[ ] iAccountActionsOption=NULL
			[ ] iAccountActionsOption=16
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Select Account Bar
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[ ] sleep(5)
		[+] if(iVerify==PASS)
			[ ] QuickenWindow.SetActive()
			[+] if (MDIClient.AccountRegister.Exists(5))
				[ ] ReportStatus("Register preferences",PASS,"Register displayed")
				[ ] 
				[ ] //Open Account Actions menu
				[ ] //Navigate to Account Actions> Register preferences
				[ ] NavigateToAccountActionBanking(iAccountActionsOption,sMDIWindow)
				[+] if(Preferences.Exists(3))
					[ ] ReportStatus("Register preferences",PASS,"Preferences Window displayed")
					[ ] 
					[+] if(Preferences.ShowDateBeforeCheckNumber.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"ShowDateBeforeCheckNumber checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"ShowDateBeforeCheckNumber checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.ShowMemoBeforeCategory.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"ShowMemoBeforeCategory checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"ShowMemoBeforeCategory checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.AutomaticallyEnterSplitData.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"AutomaticallyEnterSplitData checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"AutomaticallyEnterSplitData checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.AutomaticallyPlaceDecimalPoint.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"AutomaticallyPlaceDecimalPoint checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"AutomaticallyPlaceDecimalPoint checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.GrayReconciledTransactions.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"GrayReconciledTransactions checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"GrayReconciledTransactions checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.RememberRegisterFiltersAfterQuickenCloses.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"RememberRegisterFiltersAfte checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"RememberRegisterFiltersAfte checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.UsePopUpRegisters.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"UsePopUpRegisters checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"UsePopUpRegisters checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.Fonts.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"Fonts button displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"Fonts button not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.Colors.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"Colors button displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"Colors button not displayed")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] Preferences.Close()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Register preferences",FAIL,"Preferences Window not displayed")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //////################Buttons Available In Register###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC83_OpenRegisterPreferencesFromAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Preferences window is opened and Register Preferences are displayed from Account Actions window
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  06/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC87_ButtonsAvailableInRegister() appstate RegisterBaseState
	[ ] 
	[ ] 
	[+] //Variable
		[ ] INTEGER iCount
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
		[+] if(iLoop==1)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[ ] 
		[+] if(iLoop==2)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[2]
			[ ] 
		[+] if(iLoop==3)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[ ] 
		[+] if(iLoop==4)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[+] if (MDIClient.AccountRegister.Exists(3))
				[ ] ReportStatus("Register Buttons",PASS,"Register displayed")
				[ ] 
				[ ] //Select New line
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N)
				[ ] 
				[+] if(MDIClient.AccountRegister.TxList.TxToolBar.Save.Exists(2))
					[ ] ReportStatus("Register Buttons",PASS,"Transaction List Save button displayed")
				[+] else
					[ ] ReportStatus("Register Buttons",FAIL,"Transaction List Save button is not found")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] if(MDIClient.AccountRegister.TxList.TxToolBar.MoreActions.Exists(2))
					[ ] ReportStatus("Register Buttons",PASS,"Transaction List More Actions button displayed")
				[+] else
					[ ] ReportStatus("Register Buttons",FAIL,"Transaction List More Actions button is not found")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] if(MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.Exists(2))
					[ ] ReportStatus("Register Buttons",PASS,"Transaction List Split button displayed")
				[+] else
					[ ] ReportStatus("Register Buttons",FAIL,"Transaction List Save Split is not found")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Register Preferences",FAIL,"Account Register Window is not found")
				[ ] 
			[ ] 
			[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //////################Add A Flag To Transaction###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC104_AddAFlagToTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that transactions that are flagged are displayed correctly in register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC104_AddAFlagToTransaction() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iCount
		[ ] STRING sFlagTransactionAction="Notes and flags..."
		[ ] STRING sFlagActual  ="Blue"
		[ ] STRING sFlagExpected="Blue"
		[ ] STRING sFlaggedFilter="Flagged"
		[ ] 
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[4]
	[ ] 
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
		[+] if(iLoop==1)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[ ] 
		[+] if(iLoop==2)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[2]
			[ ] 
		[+] if(iLoop==3)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[ ] 
		[+] if(iLoop==4)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[4]
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
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sFlagTransactionAction)
			[+] if(TransactionNotesAndFlags.Exists(5))
				[ ] ReportStatus("Verify Add Notes and Flags to Transactions", PASS, "{sFlagTransactionAction} option is selected") 
				[ ] TransactionNotesAndFlags.SetActive()
				[ ] 
				[ ] //Set Transaction with Flag
				[ ] TransactionNotesAndFlags.FlagThisTransaction.Click()
				[ ] TransactionNotesAndFlags.FlagColor.Select(sFlagExpected)
				[ ] sleep(1)
				[ ] TransactionNotesAndFlags.OK.DoubleClick()
				[ ] WaitForState(TransactionNotesAndFlags , false ,2)
				[ ] 
				[ ] 
				[ ] //Verify if Flagged Transaction is added
				[ ] //has to select 5 times as it was not selecting in the first attempt
				[+] for (iCount=1 ; iCount <6 ; ++iCount)
					[ ] MDIClient.AccountRegister.TransactionTypeFilter.Select(sFlaggedFilter)
					[ ] 
				[ ] sleep(1)
				[ ] VerifyTransactionInAccountRegister(lsTransactionData[6],Str(1))
				[ ] 
				[ ] 
				[ ] //Verify if correct flag is selected
				[ ] AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sFlagTransactionAction)
				[ ] TransactionNotesAndFlags.FlagColor.Click()
				[ ] sFlagActual=TransactionNotesAndFlags.FlagColor.GetSelText()
				[ ] 
				[+] if(sFlagActual==sFlagExpected)
					[ ] ReportStatus("Verify Add Notes and Flags to Transactions", PASS, "{sFlagActual} flag option selected is correct") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "Wrong flag option {sFlagActual} is displayed instead of {sFlagExpected}") 
					[ ] 
				[ ] TransactionNotesAndFlags.Cancel.DoubleClick()
				[ ] WaitForState(TransactionNotesAndFlags , false ,2)
				[ ] //clear search field
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "{sFlagTransactionAction} option selection error") 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //////################Add A Note To Transaction###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC105_AddANoteToTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that notes can be added to transactions in register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC105_AddANoteToTransaction() appstate RegisterBaseState
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iCount
		[ ] STRING sFlagTransactionAction="Notes and flags..."
		[ ] STRING sNoteActual 
		[ ] STRING sNoteExpected
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // Read transactio data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[4]
	[ ] 
	[ ] sNoteExpected="This is a note for a transaction with Payee"+ lsTransactionData[6]
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
		[+] if(iLoop==1)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[ ] 
		[+] if(iLoop==2)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[2]
			[ ] 
		[+] if(iLoop==3)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[ ] 
		[+] if(iLoop==4)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[4]
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
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sFlagTransactionAction)
			[+] if(TransactionNotesAndFlags.Exists(2))
				[ ] ReportStatus("Verify Add Notes and Flags to Transactions", PASS, "{sFlagTransactionAction} option is selected") 
				[ ] 
				[ ] 
				[ ] //Set Transaction with Flag
				[ ] TransactionNotesAndFlags.SetActive()
				[+] if(TransactionNotesAndFlags.Notes.Exists(3))
					[ ] TransactionNotesAndFlags.Notes.SetText(sNoteExpected)
					[ ] TransactionNotesAndFlags.OK.DoubleClick()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL,"Notes Textfield not found in Transaction notes and flags window") 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Verify if correct note is added
				[ ] AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sFlagTransactionAction)
				[+] if(TransactionNotesAndFlags.Exists(2))
					[ ] 
					[ ] sNoteActual=TransactionNotesAndFlags.Notes.GetText()
					[ ] print(sNoteActual)
					[+] if(sNoteActual==sNoteExpected)
						[ ] ReportStatus("Verify Add Notes and Flags to Transactions", PASS, "{sNoteActual} flag option selected is correct") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "Wrong flag option {sNoteActual} is displayed instead of {sNoteExpected}") 
						[ ] 
					[ ] TransactionNotesAndFlags.OK.DoubleClick()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "{sFlagTransactionAction} option selection error") 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "{sFlagTransactionAction} option selection error") 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] //clear search field
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
		[ ] 
		[+] else
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
[ ] 
[ ] 
[+] //////################Edit - Payee Report###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC107_EditPayeeReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Edit - Payee Report is displayed from transactions in register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC107_EditPayeeReport() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iCount,iNum
		[ ] INTEGER iXpos=235
		[ ] INTEGER iYpos=31
		[ ] STRING sPayeeReportAction,sAmount
		[ ] NUMBER nNum
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //setup accounts
	[ ] RegisterSetUp()
	[ ] 
	[ ] // Read transactio data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
	[ ] lsTransactionData=lsExcelData[1]
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] 
	[ ] 
	[ ] sPayeeReportAction="Payments made to"
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] lsAddAccount=lsExcelData[iLoop]
		[ ] 
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[+] if (iLoop==1)
				[ ] 
				[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] 
			[+] else
				[ ] iVerify=AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDateStamp,NULL,lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify Add Transaction", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
				[ ] 
				[+] if (iLoop==4)
					[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sPayeeReportAction,"",153,33)
				[+] else
					[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sPayeeReportAction,"",iXpos,iYpos)
					[ ] 
				[+] if(PayeeReport.Exists(2))
					[ ] PayeeReport.SetActive()
					[ ] ReportStatus("Verify Edit Payee Report", PASS, "{sPayeeReportAction} option is selected") 
					[ ] 
					[ ] 
					[ ] 
					[ ] sHandle=Str(PayeeReport.QWListViewer1.ListBox1.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"1")
					[ ] 
					[ ] 
					[ ] //Match Payee name to report entry
					[ ] bMatch=MatchStr("*{lsTransactionData[6]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Edit Payee Report", PASS,"Payee name is matched to report entry")
						[ ] bMatch=FALSE
					[+] else
						[ ] ReportStatus("Verify Edit Payee Report", FAIL,"Payee name is not matched to report entry")
						[ ] 
					[ ] 
					[ ] 
					[ ] //Match Amount to report entry
					[ ] nNum =val(lsTransactionData[3])
					[ ] sAmount=Str(nNum ,4,2)
					[ ] 
					[ ] bMatch=MatchStr("*{sAmount}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Edit Payee Report", PASS,"Amount is matched to report entry")
						[ ] bMatch=FALSE
					[+] else
						[ ] ReportStatus("Verify Edit Payee Report", FAIL,"Amount is not matched to report entry")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //Match Category to report entry
					[ ] bMatch=MatchStr("*{lsTransactionData[8]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Edit Payee Report", PASS,"Category is matched to report entry")
						[ ] bMatch=FALSE
					[+] else
						[ ] ReportStatus("Verify Edit Payee Report", FAIL,"Category is not matched to report entry")
						[ ] 
					[ ] 
					[ ] PayeeReport.SetActive()
					[ ] PayeeReport.Close()
					[ ] WaitForState(PayeeReport, false,1)
				[+] else
					[ ] ReportStatus("Verify Edit Payee Report", FAIL, "{sPayeeReportAction} option selection error") 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] //clear search field
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Transaction", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
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
		[+] else
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Checking Account Register Document Window###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test139_CheckingAccountRegisterDocumentWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Checking account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC139_CheckingAccountRegisterDocumentWindow() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] 
		[ ] 
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] STRING sPayBalance
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if (iCreateDataFile == PASS)
		[ ] ReportStatus("Validate Data File ", PASS , "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] 
			[ ] //Select Checking Account---------------------------------------------------------------------------------------------------------------
			[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[+] if(MDIClient.AccountRegister.Exists(2))
				[ ] ReportStatus("Checking Account", PASS, "Checking Account opened in Document Window")
				[ ] 
				[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsTransactionData=lsExcelData[4]
				[ ] 
				[ ] // Add Deposit Transaction to Checking account
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
				[ ] 
				[ ] 
				[ ] 
				[ ] iVerify=FindTransactionsInRegister(lsTransactionData[6])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
			[+] else
				[ ] ReportStatus("Checking Account", FAIL, "Checking Account not opened in Document Window")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Savings Account RegisterDocument Window ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC13_VerifySavingsAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Savings account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	8/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC140_SavingsAccountRegisterDocumentWindow() appstate RegisterBaseState
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[2]
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] iFileResult=OpenDataFile(sFileName)
		[+] if(iFileResult==PASS)
			[ ] ReportStatus("Open File ",PASS,"{sDataFile} File opened successfully")
			[ ] 
			[ ] 
			[ ] //Add A Savings account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] // Add Savings Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Savings Account", PASS, "Account -  {lsAddAccount[2]}  is created successfully")
				[+] if (QuickenWindow.Exists(60))
					[ ] QuickenWindow.SetActive()
					[ ] // Turn Off "Use Popup Register" option for MDI window type
					[ ] UsePopupRegister("OFF")
					[ ] //This will select Savings account on AccountBar
					[ ] 
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
					[ ] sleep(3)
					[+] if(MDIClient.AccountRegister.Exists(3))
						[ ] ReportStatus("Savings Account", PASS, "Savings Account opened in Document Window")
						[ ] 
						[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
						[ ] 
						[ ] iAddTransaction= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
						[ ] 
						[ ] 
						[ ] iVerify=FindTransactionsInRegister(lsAddAccount[2])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
						[+] else
							[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
					[+] else
						[ ] ReportStatus("Savings Account", FAIL, "Savings Account not opened in Document Window")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Savings Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open File ",FAIL,"File Not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Credit Card Account Register Document Window###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC14_VerifyCreditCardAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Credit Card account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	8/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC141_CreditCardAccountRegisterDocumentWindow() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] iFileResult=OpenDataFile(sFileName)
		[+] if(iFileResult==PASS)
			[ ] ReportStatus("Open File ",PASS,"{sDataFile} File opened successfully")
			[ ] 
			[ ] 
			[ ] //Add A Credit Card Account -------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] // Add Credit Card Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Credit card Account", PASS, "Credit Card Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] //This will select credit card account on AccountBar
				[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
				[+] if(MDIClient.AccountRegister.Exists(3))
					[ ] ReportStatus("Credit Card Account", PASS, "Credit Card Account opened in Document Window")
					[ ] 
					[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
					[ ] iAddTransaction= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
					[ ] 
					[ ] 
					[ ] iVerify=FindTransactionsInRegister(lsAddAccount[2])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Credit Card Account", FAIL, "Credit Card Account not opened in Document Window")
				[ ] 
			[+] else
				[ ] ReportStatus("Credit Card Account", FAIL, "Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open File ",FAIL,"File Not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Cash Account Register Document Window ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC15_VerifyCashAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Cash account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	8/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC142_CashAccountRegisterDocumentWindow() appstate none
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] iFileResult=OpenDataFile(sFileName)
		[+] if(iFileResult==PASS)
			[ ] ReportStatus("Open File ",PASS,"{sDataFile} File opened successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] // Add Cash Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Cash Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
				[ ] 
				[ ] //This will select Cash account on AccountBar
				[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
				[ ] 
				[+] if(MDIClient.AccountRegister.Exists(3))
					[ ] ReportStatus("Cash Account", PASS, "Cash Account opened in Document Window")
					[ ] 
					[ ] //Add Transaction to account
					[ ] iAddTransaction= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
					[ ] 
					[ ] iVerify=FindTransactionsInRegister(lsAddAccount[2])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Cash Account", FAIL, "Cash Account not opened in Document Window")
				[ ] 
			[+] else
				[ ] ReportStatus("Cash Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
		[+] else
			[ ] ReportStatus("Open File ",FAIL,"File Not opened")
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Money Market Account Register Document Window####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC12_VerifyCheckingAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Checking account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC143_MoneyMarketAccountRegisterDocumentWindow()  appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING sHandle
		[ ] INTEGER iCreateDataFile,iVerify
		[ ] 
		[ ] STRING sCCBankAccountId="UserAccount"
		[ ] STRING sCCBankAccountPass="Password"
		[ ] STRING sAccountName="MONEY MARKET XX3333"
		[ ] 
		[ ] LIST OF STRING lsMatchTransactions
		[ ] sDate =FormatDateTime ( GetDateTime (), "m/d/yyyy") 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] // Fetch row from the given sheet
		[ ] lsMatchTransactions=lsExcelData[5]
		[ ] 
	[ ] 
	[ ] 
	[ ] // Create Data File------------------------------------------------------------------------------------------------------------------------
	[ ] // iCreateDataFile = DataFileCreate(sFileName)
	[ ] // Report Staus If Data file Created successfully
	[ ] iCreateDataFile  = PASS
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] // Add CCBank Account
		[ ] 
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.DoubleClick()
		[ ] AddAccount.Checking.Click()
		[ ] 
		[ ] AddAnyAccount.VerifyEnabled(TRUE, 500)
		[ ] AddAnyAccount.SetActive()
		[ ] AddAnyAccount.EnterTheNameOfYourBank.SetText("CCBank")
		[ ] AddAnyAccount.Next.Click()
		[ ] sleep(20)
		[+] if (AddAnyAccount.Exists(200))
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.BankUserID.SetText(sCCBankAccountId) 
			[ ] AddAnyAccount.BankPassword.SetText(sCCBankAccountPass)			
			[ ] AddAnyAccount.Next.Click()
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.CCBank2.ListBox1.Exists(300))
			[ ] AddAnyAccount.Next.Click()
			[+] if(AccountAdded.Exists(300))
				[ ] AccountAdded.SetActive()
				[ ] AccountAdded.Finish.Click()
				[ ] WaitForState(AddAnyAccount,False,4)
				[+] if(QuickenWindow.Exists(60))
					[ ] 
					[ ] //For Money Market Account--------------------------------------------------------------------------------------------------------------------
					[ ] 
					[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
					[+] if (iResult==PASS)
						[ ] 
						[ ] sleep(2)
						[+] if(MDIClient.AccountRegister.Exists(3))
							[ ] ReportStatus("Money Market Account", PASS, "Money Market Account opened in Document Window")
							[ ] // Add Deposit Transaction to Money Market Account
							[ ] iVerify= AddCheckingTransaction(lsMatchTransactions[1],lsMatchTransactions[2], lsMatchTransactions[3], sDate,lsMatchTransactions[5],lsMatchTransactions[6],lsMatchTransactions[7],lsMatchTransactions[8])
							[ ] 
							[ ] 
							[ ] //Transaction is added
							[+] if(iVerify==PASS)
								[ ] iVerify=FindTransactionsInRegister(lsMatchTransactions[6])
								[ ] //Transaction added to register
								[+] if(iVerify==PASS)
									[ ] ReportStatus("Add Transaction", PASS, "{lsMatchTransactions[6]} Transaction added successfully") 
								[+] else
									[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction not added") 
						[+] else
							[ ] ReportStatus("Money Market Account", FAIL, "Money Market Account not opened in Document Window")
					[+] else
						[ ] ReportStatus("Verify Money Market Account selected.",FAIL,"Money Market Account couldn't be selected.")
				[+] else
					[ ] ReportStatus("Verify Money Market Account",FAIL,"Quicken Not Available")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Money Market Account",FAIL,"Account Not Added")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Money Market Account",FAIL,"Account Not Added")
			[+] 
				[ ] 
				[ ] 
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Error during creating Data file - {sFileName}")
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Line Of Credit Account Register Document Window#####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC17_VerifyLineOfCreditAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Transaction is successfully added to Document Window register for Line of Credit account
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	18/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[ ] 
[+] testcase TC144_LineOfCreditAccountRegisterDocumentWindow() appstate  QuickenBaseState 
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] STRING sHandle
		[ ] INTEGER iCreateDataFile,iVerify
		[ ] 
		[ ] STRING sCCBankAccountId="UserAccount"
		[ ] STRING sCCBankAccountPass="Password"
		[ ] STRING sAccountName="My Line of Credit XX6666"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] // Fetch row from the given sheet
		[ ] lsMatchTransactions=lsExcelData[5]
		[ ] 
		[ ] LIST OF STRING lsMatchTransactions
		[ ] sDate =FormatDateTime ( GetDateTime (), "m/d/yyyy") 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Open Data File---------------------------------------------------------------------------------
	[ ] iVerify = OpenDataFile(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[+] if(QuickenWindow.Exists(3))
			[ ] 
			[ ] 
			[ ] 
			[ ] //For Money Market Account--------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[ ] 
			[ ] sleep(2)
			[+] if(MDIClient.AccountRegister.Exists(3))
				[ ] ReportStatus("Line Of Credit Account", PASS, "Line Of Credit Account opened in Document Window")
				[ ] 
				[ ] // Add Deposit Transaction to Money Market Account
				[ ] iVerify= AddBankingTransaction(lsMatchTransactions[1],lsMatchTransactions[2], lsMatchTransactions[3],sDate,"",lsMatchTransactions[5],lsMatchTransactions[6],lsMatchTransactions[7])
				[ ] 
				[ ] 
				[ ] //Transaction is added
				[+] if(iVerify==PASS)
					[ ] iVerify=FindTransactionsInRegister(lsMatchTransactions[5])
					[ ] //Transaction added to register
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "{lsMatchTransactions[6]} Transaction added successfully") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction not added") 
			[+] else
				[ ] ReportStatus("Line Of Credit Account", FAIL, "Line Of Credit Account not opened in Document Window")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Money Market Account",FAIL,"Quicken Not Available")
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken Security Based Investing Account Rgister ########################
	[ ] // ********************************************************
	[+] // TestCase Name:Test25_SecurityBasedInvestingAccountRegister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Asset Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijit Sarma
		[ ] //	  
	[ ] // ********************************************************
	[ ] 
[+] testcase Test25_SecurityBasedInvestingAccountRegister () appstate none
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sWindowType,sTransactionType,sAmount,sPayee, sAccountUsedPrimarily,sAccount,sSecurity,sNumberOfShares,sPricePaid,sCommission,sMemo,sExpectedCashBalance,sUseCash,sDateAcquired,sAccruedInt
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
		[ ] list of anytype  lsTransactionData
	[ ] 
	[+] // Variable Definition
		[ ] sWindowType="PopUp"
		[ ] sAccType ="Brokerage"
		[ ] sAccName ="Brokerage Account"
		[ ] sAmount="1000"
		[ ] sTransactionType = "Buy"
		[ ] sAmount = "50"
		[ ] sAccountUsedPrimarily=""
		[ ] sSecurity= "INTU"
		[ ] sNumberOfShares = "10"
		[ ] sPricePaid= "20"
		[ ] sCommission= "1"
		[ ] sMemo = "memo"
		[ ] sExpectedCashBalance = "1500"
		[ ] sUseCash = " Brokerage"
		[ ] sDateAcquired =""
		[ ] sAccruedInt = "10"
		[ ] STRING sValue="49"
		[ ] //Buy		Brokerage	01/01/2012	Intu	10	50.05	25		6,449.90
		[ ] 
		[ ] lsTransactionData={sWindowType,sTransactionType,sAccountUsedPrimarily,sAccName,sDateStamp,sSecurity,sNumberOfShares,sPricePaid,sCommission,sMemo,sExpectedCashBalance,sUseCash,sDateAcquired,sAccruedInt}
		[ ] //
		[ ] SetUp_AutoApi()
		[ ] //Create new data file
		[ ] 
	[ ] iCreateFile = DataFileCreate(sFileName)
	[+] if ( iCreateFile  == PASS)
		[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
		[ ] // Add manual Brokerage Account
		[ ] iAddAccount = AddManualBrokerageAccount(sAccType,sAccName,sAmount,sDateStamp)
		[+] if ( iAddAccount  == PASS)
			[ ] ReportStatus("Add Brokerage Account ", PASS, "Account -  {sAccName} is created")
			[ ] //Report Staus If account is not Created 
			[ ] 
			[ ] 
			[ ] // Open the Brokerage Account register from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(sAccName,ACCOUNT_INVESTING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] //Add transaction to Brokerage account
				[ ] 
				[ ] iResult= AddBrokerageTransaction(lsTransactionData)
				[+] if (iResult==PASS) 
					[+] if(InvestingAccountPopup.Exists(5))
						[ ] InvestingAccountPopup.SetActive ()
						[ ] InvestingAccountPopup.Close()
						[ ] WaitForState(InvestingAccountPopup, false,1)
					[ ] iResult=UsePopupRegister("OFF")
					[+] if (iResult==PASS) 
						[ ] iResult=SelectAccountFromAccountBar(sAccName,ACCOUNT_INVESTING)
						[+] if (iResult==PASS) 
							[ ] sHandle=Str(BrokerageAccount.InvestingAccountRegister.AccountRegisterChild.StaticText1.QWListViewer.ListBox.GetHandle())
							[+] for (iCount=0 ;iCount<5;++iCount)
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  str(iCount))
								[ ] bMatch = MatchStr("*{sSecurity}*", sActual)
								[+] if (bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Add Investing  Transaction",PASS,"Investing Transaction for Security: {sSecurity} added")
							[+] else
								[ ] ReportStatus("Add Investing  Transaction",FAIL,"Investing Transaction or Security: {sSecurity} couldn't be added")
						[+] else
							[ ] ReportStatus("Verify brokerage account selected.",FAIL,"Brokerage account couldn't be selected")
					[+] else
						[ ] ReportStatus("Verify PopupRegister set off.",FAIL,"PopupRegister couldn't be set off.")
				[+] else
					[ ] ReportStatus("Add Investing Transaction",FAIL,"Investing Transaction is not Added")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify brokerage account selected.",FAIL,"Brokerage account couldn't be selected")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Add Brokerage Account", FAIL, "Account -  {sAccName} is not created ")
		[ ] 
		[ ] 
		[ ] 
	[ ] //Report Staus If Data file is not Created 
	[+] else
		[+] ReportStatus("Data fle not created ", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
			[ ] 
	[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] //#############  Verify Quicken 401(K) Account Rgister ########################
[+] testcase Test26_401kAccountRegister () appstate QuickenBaseState
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sWindowType,sTransactionType,sAmount,sPayee, sAccountUsedPrimarily,sAccount,sSecurity,sNumberOfShares,sPricePaid,sCommission,sMemo,sExpectedCashBalance,sUseCash,sDateAcquired,sAccruedInt, sEmployerName, sStatementEndingDate 
		[ ] INTEGER  iTotalShares
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
		[ ] list of anytype  lsTransactionData
	[ ] 
	[+] // Variable Definition
		[ ] sWindowType="MDI"
		[ ] sAccType ="401(k) or 403(b)"
		[ ] sAccName ="401K Account"
		[ ] sAmount="1000"
		[ ] sTransactionType = "Buy"
		[ ] sAmount = "50"
		[ ] sAccountUsedPrimarily=""
		[ ] sSecurity= "INTU"
		[ ] sNumberOfShares = "10"
		[ ] sPricePaid= "20"
		[ ] sCommission= "1"
		[ ] sMemo = "memo"
		[ ] sExpectedCashBalance = "1500"
		[ ] sUseCash = " Brokerage"
		[ ] sDateAcquired =""
		[ ] sAccruedInt = "10"
		[ ] sEmployerName = "Intuit Inc"
		[ ] sStatementEndingDate = ModifyDate(-90,"m/d/yyyy")
		[ ] STRING  sTotalShares = "20"
		[ ] iTotalShares=VAL(sTotalShares)
		[ ] 
		[ ] sDateStamp =ModifyDate(-1,"m/d/yyyy")
		[ ] lsTransactionData={sWindowType,sTransactionType,sAccountUsedPrimarily,sAccName,sDateStamp,sSecurity,sNumberOfShares,sPricePaid,sCommission,sMemo,sExpectedCashBalance,sUseCash,sDateAcquired,sAccruedInt}
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // SetUp_AutoApi()
			[ ] // 
			[ ] //Create new data file
			[ ] iResult = OpenDataFile(sFileName)
			[+] if ( iResult  == PASS)
				[ ] QuickenWindow.SetActive()
				[ ] // Add manual Brokerage Account
				[ ] iAddAccount = AddManual401KAccount(sAccType,sAccName,sEmployerName,sStatementEndingDate,sSecurity,iTotalShares)
				[ ] 
				[ ] iAddAccount=PASS
				[+] if ( iAddAccount  == PASS)
					[ ] ReportStatus("Add 401K Account ", PASS, "Account -  {sAccName} is created")
					[ ] //Report Staus If account is not Created 
					[ ] 
					[ ] 
					[ ] // Open the Brokerage Account register from Account Bar
					[ ] iResult=SelectAccountFromAccountBar(sAccName,ACCOUNT_INVESTING)
					[+] if (iResult==PASS)
						[ ] 
						[ ] //Add transaction to Brokerage account
						[ ] 
						[ ] iResult= AddBrokerageTransaction(lsTransactionData)
						[+] if (iResult==PASS) 
							[ ] sHandle=Str(BrokerageAccount.InvestingAccountRegister.AccountRegisterChild.StaticText1.QWListViewer.ListBox.GetHandle())
							[+] for (iCount=0 ;iCount<5;++iCount)
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  str(iCount))
								[ ] bMatch = MatchStr("*{sSecurity}*", sActual)
								[+] if (bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Add Investing  Transaction",PASS,"Investing Transaction for Security: {sSecurity} added")
							[+] else
								[ ] ReportStatus("Add Investing  Transaction",FAIL,"Investing Transaction or Security: {sSecurity} couldn't be added")
						[+] else
							[ ] ReportStatus("Add Investing Transaction",FAIL,"Investing Transaction is not Added")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify 401K account selected.",FAIL,"401K account: {sAccName} couldn't be selected")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add 401K Account", FAIL, "Account -  {sAccName} is not created ")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Data fle not opened ", FAIL, "Data file -  {sFileName} is not Opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[+] ////############# Verify Money Market Account Register ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC12_VerifyCheckingAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Checking account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC16_VerifyMoneyMarketAccountRegister()  appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING sHandle
		[ ] INTEGER iCreateDataFile,iVerify
		[ ] 
		[ ] STRING sCCBankAccountId="UserAccount"
		[ ] STRING sCCBankAccountPass="Password"
		[ ] STRING sAccountName="MONEY MARKET"  //MONEY MARKET XX3333
		[ ] 
		[ ] LIST OF STRING lsMatchTransactions
		[ ] sDateStamp =FormatDateTime ( GetDateTime (), "m/d/yyyy") 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] // Fetch row from the given sheet
		[ ] lsMatchTransactions=lsExcelData[5]
		[ ] 
		[ ] 
		[ ] 
		[ ] // Create Data File------------------------------------------------------------------------------------------------------------------------
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sFileName} is created")
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
			[ ] AddAccount.Checking.Click()
			[ ] 
			[ ] AddAnyAccount.VerifyEnabled(TRUE, 500)
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.EnterTheNameOfYourBank.SetText("CCBank")
			[ ] AddAnyAccount.Next.Click()
			[ ] 
			[+] if (AddAnyAccount.Exists(200))
				[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.BankUserID.SetText(sCCBankAccountId)
				[ ] AddAnyAccount.BankPassword.SetText(sCCBankAccountPass)			
				[ ] AddAnyAccount.Next.Click()
			[ ] 
			[ ] 
			[+] if(AddAnyAccount.CCBank2.ListBox1.Exists(300))
				[ ] AddAnyAccount.Next.Click()
				[+] if(AccountAdded.Exists(300))
					[ ] AccountAdded.SetActive()
					[ ] AccountAdded.Finish.Click()
					[ ] WaitForState(AddAnyAccount,False,4)
					[+] if(QuickenWindow.Exists(60))
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] //For Money Market Account--------------------------------------------------------------------------------------------------------------------
						[ ] 
						[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
						[ ] 
						[ ] sleep(2)
						[ ] 
						[ ] // Add Deposit Transaction to Money Market Account
						[ ] iVerify= AddCheckingTransaction(lsMatchTransactions[1],lsMatchTransactions[2], lsMatchTransactions[3], sDateStamp,lsMatchTransactions[5],lsMatchTransactions[6],lsMatchTransactions[7],lsMatchTransactions[8])
						[ ] 
						[ ] 
						[ ] //Transaction is added
						[+] if(iVerify==PASS)
							[ ] iVerify=FindTransactionsInRegister(lsMatchTransactions[6])
							[ ] //Transaction added to register
							[+] if(iVerify==PASS)
								[ ] ReportStatus("Add Transaction", PASS, "{lsMatchTransactions[6]} Transaction added successfully") 
							[+] else
								[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction not added") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction failed") 
					[+] else
						[ ] ReportStatus("Verify Money Market Account",FAIL,"Quicken Not Available")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Money Market Account",FAIL,"Account Not Added")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Money Market Account",FAIL,"Account Not Added")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] // 
		[ ] // Report Staus If Data file is not Created 
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Error during creating Data file - {sFileName}")
		[ ] 
		[ ] 
		[ ] 
[ ] 
[ ] 
[+] ////############# Verify Line Of Credit Account Register #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC17_VerifyLineOfCreditAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Transaction is successfully added to Account register for Line of Credit account
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	18/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC17_VerifyLineOfCreditAccountRegister() appstate none
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] STRING sHandle
		[ ] INTEGER iCreateDataFile,iVerify
		[ ] 
		[ ] STRING sCCBankAccountId="UserAccount"
		[ ] STRING sCCBankAccountPass="Password"
		[ ] STRING sAccountName="My Line of Credit XX6666"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] // Fetch row from the given sheet
		[ ] lsMatchTransactions=lsExcelData[5]
		[ ] 
		[ ] LIST OF STRING lsMatchTransactions
		[ ] sDateStamp =FormatDateTime ( GetDateTime (), "m/d/yyyy") 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Open Data File---------------------------------------------------------------------------------
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[+] if(QuickenWindow.Exists(5))
				[ ] 
				[ ] 
				[ ] 
				[ ] //For Money Market Account--------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] 
				[ ] sleep(2)
				[ ] 
				[ ] 
				[ ] 
				[ ] // Add Deposit Transaction to Money Market Account
				[ ] iVerify= AddBankingTransaction(lsMatchTransactions[1],lsMatchTransactions[2], lsMatchTransactions[3],sDateStamp,"",lsMatchTransactions[5],lsMatchTransactions[6],lsMatchTransactions[7])
				[ ] 
				[ ] 
				[ ] //Transaction is added
				[+] if(iVerify==PASS)
					[ ] iVerify=FindTransactionsInRegister(lsMatchTransactions[5])
					[ ] //Transaction added to register
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "{lsMatchTransactions[6]} Transaction added successfully") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction not added") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction failed") 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Money Market Account",FAIL,"Quicken Not Available")
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
	[+] else
		[ ] ReportStatus("Verify Filters present in account",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# TC_Setup_Webconnect_File #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC_Setup_Webconnect_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create a new data file import a webconnect file into Quicken for testcase nos 165-175
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If file is created and webconnect file is imported
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
	[ ] // ********************************************************
[+] testcase TC_Setup_Webconnect_File() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iValidate
		[ ] STRING sWebConnectFileName="WebConnect_Files\WellsFargo_Checking_Register_Automation"
		[ ] STRING sFileName="Register"
		[ ] 
	[ ] iValidate=DataFileCreate(sFileName)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=ImportWebConnectFile(sWebConnectFileName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Import Web connect file",PASS,"Web connect file imported succesfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Import Web connect file",FAIL,"Error during importing Web connect file")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Data File Create",FAIL,"Data file not created")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# TC165_Recategorize_Transaction_From_Transaction_Report_Cancel #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC165_Recategorize_Transaction_From_Transaction_Report_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Category from Payee Transaction Report and click on cancel button.
		[ ] //  Then verifies that changes should not be reflected in Report and register
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes are  not be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 5th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC165_Recategorize_Transaction_From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt Fed Jpmorgan"          //Payee Name
		[ ] 
		[ ] STRING sOldCategory="Other Inc"
		[ ] STRING sNewCategory="Net Salary"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Recategorize transaction(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //----------------Verify Category mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction,"",iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports ,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldCategory}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Category to report",PASS,"Category {sOldCategory} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Category to report",FAIL,"Category {sOldCategory} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Re transaction from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Recategorize Transaction Dialog is open----------------------------
			[+] if(RecategorizeTransactions.Exists(4))
				[ ] ReportStatus("Recategorize transactions dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RecategorizeTransactions.SetActive()
				[ ] RecategorizeTransactions.CategoryTextField.TypeKeys(sNewCategory)
				[ ] RecategorizeTransactions.CategoryTextField.TypeKeys(KEY_ENTER)
				[ ] RecategorizeTransactions.Cancel.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Category NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction ,"", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports, sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sOldCategory}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Category to report",PASS,"Old Category {sOldCategory} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Category to report",FAIL,"New Category {sNewCategory} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Retag transactions dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC166_Recategorize_Transaction_From_Transaction_Report_OK #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC166_Recategorize_Transaction_From_Transaction_Report_OK()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Category from Payee Transaction Report and click on OK button.
		[ ] //  Then verifies that changes should be reflected in Report and register
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 5th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC166_Recategorize_Transaction_From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt Fed Jpmorgan"          //Payee Name
		[ ] 
		[ ] STRING sOldCategory="Other Inc"
		[ ] STRING sNewCategory="Net Salary"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Recategorize transaction(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] //----------------Verify Category mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldCategory}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Category to report",PASS,"Category {sOldCategory} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Category to report",FAIL,"Category {sOldCategory} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Re transaction from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Recategorize Transaction Dialog is open----------------------------
			[+] if(RecategorizeTransactions.Exists(4))
				[ ] ReportStatus("Recategorize transactions dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RecategorizeTransactions.SetActive()
				[ ] RecategorizeTransactions.CategoryTextField.TypeKeys(sNewCategory)
				[ ] RecategorizeTransactions.CategoryTextField.TypeKeys(KEY_ENTER)
				[ ] RecategorizeTransactions.OK.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Category mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] TransactionReports.SetActive()
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sNewCategory}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Category to report",PASS,"New Category {sNewCategory} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Category to report",FAIL,"New Category {sNewCategory} not matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] //-----------------Old Category is NOT matched to report---------------------------
							[ ] bMatch=NULL
							[ ] bMatch=MatchStr("*{sOldCategory}*",sReportEntry)
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Match Category to report",PASS,"Old Category {sOldCategory} not matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Category to report",FAIL,"Old Category {sOldCategory} matched to report")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Retag transactions dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] // //############# TC167_Retag_Transaction_From_Transaction_Report_Cancel #################################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC167_Retag_Transaction_From_Transaction_Report_Cancel()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Update tag from Payee Transaction Report and click on cancel button.
		[ ] // //  Then verifies that changes should not be reflected in Report and register
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If changes are  not reflected in Report and register
		[ ] // //						Fail			If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Date                             May 5th 2013		
		[ ] // //Author                          Dean Paes
		[ ] // 
	[ ] // // ********************************************************
[+] testcase TC167_Retag_Transaction_From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt Fed Jpmorgan"          //Payee Name
		[ ] 
		[ ] STRING sOldTag="Old Tag"
		[ ] STRING sNewTag="New Tag"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Retag transaction(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] 
		[ ] //---------------------Add Tag to Transaction-----------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] FindTransaction(sMDIWindow,sSearchPayeeName)
		[ ] MDIClient.AccountRegister.TypeKeys(Replicate(KEY_TAB,5))
		[ ] MDIClient.AccountRegister.TypeKeys(sOldTag)
		[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[+] if(NewTag.Exists(2))
			[ ] NewTag.SetActive()
			[ ] NewTag.OKButton.Click()
			[ ] 
		[ ] 
		[ ] //REMOVE AFTER DEFECT IS RESOLVED IN R12
		[ ] FindTransaction(sMDIWindow,sSearchPayeeName)
		[ ] MDIClient.AccountRegister.TypeKeys(Replicate(KEY_TAB,5))
		[ ] MDIClient.AccountRegister.TypeKeys(sOldTag)
		[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[ ] //MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Verify Tag mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldTag}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Tag to report",PASS,"Tag {sOldTag} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Tag to report",FAIL,"Tag {sOldTag} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Retag transaction from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Retag Transaction Dialog is open----------------------------
			[+] if(RetagTransactions.Exists(4))
				[ ] ReportStatus("Recategorize transactions dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RetagTransactions.SetActive()
				[ ] RetagTransactions.TagS.TypeKeys(sNewTag)
				[ ] RetagTransactions.TagS.TypeKeys(KEY_ENTER)
				[+] if(NewTag.Exists(2))
					[ ] NewTag.SetActive()
					[ ] NewTag.CancelButton.Click()
				[+] if(RetagTransactions.Exists(2))
					[ ] RetagTransactions.Cancel.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Tag NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sOldTag}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Tag to report",PASS,"Old Tag {sOldTag} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Tag to report",FAIL,"New Tag {sNewTag} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Retag transactions dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] // //############# TC168_Retag_Transaction_From_Transaction_Report_OK #################################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC168_Retag_Transaction_From_Transaction_Report_OK()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Update Tag from Payee Transaction Report and click on OK button.
		[ ] // //  Then verifies that changes should be reflected in Report and register
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] // //						Fail			If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Date                             May 5th 2013		
		[ ] // //Author                          Dean Paes
		[ ] // 
	[ ] // // ********************************************************
[+] testcase TC168_Retag_Transaction_From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt Fed Jpmorgan"          //Payee Name
		[ ] 
		[ ] STRING sOldTag="Old Tag"
		[ ] STRING sNewTag="New Tag"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Retag transaction(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] 
		[ ] //---------------------Add Tag to Transaction-----------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] FindTransaction(sMDIWindow,sSearchPayeeName)
		[ ] MDIClient.AccountRegister.TypeKeys(Replicate(KEY_TAB,5))
		[ ] MDIClient.AccountRegister.TypeKeys(sOldTag)
		[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[+] if(NewTag.Exists(2))
			[ ] NewTag.SetActive()
			[ ] NewTag.OKButton.Click()
			[ ] 
		[ ] 
		[ ] //REMOVE AFTER DEFECT IS RESOLVED IN R12
		[ ] FindTransaction(sMDIWindow,sSearchPayeeName)
		[ ] MDIClient.AccountRegister.TypeKeys(Replicate(KEY_TAB,5))
		[ ] MDIClient.AccountRegister.TypeKeys(sOldTag)
		[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[ ] //MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Verify Tag mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldTag}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Tag to report",PASS,"Tag {sOldTag} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Tag to report",FAIL,"Tag {sOldTag} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Retag transaction from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Retag Transaction Dialog is open----------------------------
			[+] if(RetagTransactions.Exists(4))
				[ ] ReportStatus("Recategorize transactions dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RetagTransactions.SetActive()
				[ ] RetagTransactions.TagS.TypeKeys(sNewTag)
				[ ] RetagTransactions.TagS.TypeKeys(KEY_ENTER)
				[+] if(NewTag.Exists(2))
					[ ] NewTag.SetActive()
					[ ] NewTag.OKButton.Click()
					[ ] 
				[+] if(RetagTransactions.Exists(2))
					[ ] RetagTransactions.OK.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Tag NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] TransactionReports.SetActive()
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sNewTag}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Tag to report",PASS,"Old Category {sOldTag} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Tag to report",FAIL,"New Category {sNewTag} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //-----------------Old Tag is NOT matched to report---------------------------
							[ ] bMatch=NULL
							[ ] bMatch=MatchStr("*{sOldTag}*",sReportEntry)
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Match Tag to report",PASS,"Old Tag {sOldTag} not matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Tag to report",FAIL,"Old Tag {sOldTag} matched to report")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.SetActive()
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Retag transactions dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC169_Rename_Payee__From_Transaction_Report_Cancel #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC169_Rename_Payee__From_Transaction_Report_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Payee Name from Payee Transaction Report and click on Cancel button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes are not reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC169_Rename_Payee__From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] STRING sOldPayeeName="Wire Trans Svc"          //Payee Name
		[ ] STRING sNewPayeeName="New Payee Wire Trans Svc"
		[ ] 
		[ ] STRING sReportAction="Rename payee(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //----------------Verify Payee mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sOldPayeeName,sAction,"",iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sOldPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sOldPayeeName)
				[ ] bMatch=MatchStr("*{sOldPayeeName}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Payee name to report",PASS,"Payee name {sOldPayeeName} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Payee name to report",FAIL,"Payee name {sOldPayeeName} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sOldPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Rename Payee from report-------------------
		[ ] iVerify=TransactionReportOperations(sOldPayeeName,sReportAction ,sAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Rename Payee Dialog is open----------------------------
			[+] if(RenamePayee.Exists(4))
				[ ] ReportStatus("Rename Payee dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RenamePayee.SetActive()
				[ ] RenamePayee.PayeeName.TypeKeys(sNewPayeeName)
				[ ] RenamePayee.Cancel.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Tag NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sOldPayeeName,sAction,"",iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sOldPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sOldPayeeName)
							[ ] bMatch=MatchStr("*{sOldPayeeName}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Payee Name to report",PASS,"Old Payee Name {sOldPayeeName} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Payee Name to report",FAIL,"Old Payee Name {sOldPayeeName} Not matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sOldPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Rename Payee dialog box is not open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC170_Rename_Payee__From_Transaction_Report_OK #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC170_Rename_Payee__From_Transaction_Report_OK()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Payee Name from Payee Transaction Report and click on OK button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC170_Rename_Payee__From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] STRING sOldPayeeName="Wire Trans Svc"          //Payee Name
		[ ] STRING sNewPayeeName="New Payee"
		[ ] 
		[ ] STRING sReportAction="Rename payee(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] STRING sNewAction="Launch Mini-Report for Payee Online"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //----------------Verify Payee mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sOldPayeeName,sAction,"",iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(5))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sOldPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sOldPayeeName)
				[ ] bMatch=MatchStr("*{sOldPayeeName}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Payee name to report",PASS,"Payee name {sOldPayeeName} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Payee name to report",FAIL,"Payee name {sOldPayeeName} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sOldPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Rename Payee from report-------------------
		[ ] iVerify=TransactionReportOperations(sOldPayeeName,sReportAction,sAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Rename Payee Dialog is open----------------------------
			[+] if(RenamePayee.Exists(4))
				[ ] ReportStatus("Rename Payee dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RenamePayee.SetActive()
				[ ] RenamePayee.PayeeName.TypeKeys(sNewPayeeName)
				[ ] RenamePayee.OK.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Payee name mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sNewPayeeName,sNewAction)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sNewPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sNewPayeeName)
							[ ] bMatch=MatchStr("*{sNewPayeeName}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Payee Name to report",PASS,"New Payee Name {sNewPayeeName} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Payee Name to report",FAIL,"New Payee Name {sNewPayeeName} Not matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] //-----------------Old Payee Name  is NOT matched to report---------------------------
							[ ] bMatch=NULL
							[ ] bMatch=MatchStr("*{sOldPayeeName}*",sReportEntry)
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Match Payee name to report",PASS,"Old Payee name {sOldPayeeName} not matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Payee name to report",FAIL,"Old Payee name {sOldPayeeName} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sNewPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Rename Payee dialog box is not open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC171_Edit_Memo__From_Transaction_Report_Cancel #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC171_Edit_Memo__From_Transaction_Report_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Memo from Payee Transaction Report and click on Cancel button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes are not reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC171_Edit_Memo__From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt Fed Jpmorgan"          //Payee Name
		[ ] 
		[ ] STRING sOldMemo="Old"
		[ ] STRING sNewMemo="New"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Edit memo(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual" 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //----------------Verify Memo mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldMemo}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Memo to report",PASS,"Memo {sOldMemo} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Memo to report",FAIL,"Memo {sOldMemo} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Edit memo from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Edit memo Dialog is open----------------------------
			[+] if(EditMemo.Exists(4))
				[ ] ReportStatus("Edit Memo dialog box",PASS,"Edit Memo dialog box is open")
				[ ] EditMemo.SetActive()
				[ ] EditMemo.EditMemoTextField.TypeKeys(sNewMemo)
				[ ] EditMemo.Cancel.Click()
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify Edited memo NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports , sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sOldMemo}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Memo to report",PASS,"Old Memo {sOldMemo} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Memo to report",FAIL,"New Memo {sNewMemo} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Edit Memo dialog box",FAIL,"Edit Memo dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC172_Edit_Memo__From_Transaction_Report_OK #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC172_Edit_Memo__From_Transaction_Report_OK()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Memo from Payee Transaction Report and click on OK button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC172_Edit_Memo__From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt Fed Jpmorgan"          //Payee Name
		[ ] 
		[ ] STRING sOldMemo="Old"
		[ ] STRING sNewMemo="New"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Edit memo(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual" 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //----------------Verify Memo mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports , sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldMemo}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Memo to report",PASS,"Memo {sOldMemo} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Memo to report",FAIL,"Memo {sOldMemo} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Edit memo from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Edit memo Dialog is open----------------------------
			[+] if(EditMemo.Exists(4))
				[ ] ReportStatus("Edit Memo dialog box",PASS,"Edit Memo dialog box is open")
				[ ] EditMemo.SetActive()
				[ ] EditMemo.EditMemoTextField.TypeKeys(sNewMemo)
				[ ] EditMemo.OK.Click()
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify Edited memo mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports , sSearchPayeeName)
							[ ] //-----------------New memo is matched to report---------------------------
							[ ] bMatch=MatchStr("*{sNewMemo}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Memo to report",PASS,"New Memo {sNewMemo} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Memo to report",FAIL,"New Memo {sNewMemo} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //-----------------Old memo is NOT matched to report---------------------------
							[ ] bMatch=NULL
							[ ] bMatch=MatchStr("*{sOldMemo}*",sReportEntry)
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Match Memo to report",PASS,"Old Memo {sOldMemo} not matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Memo to report",FAIL,"Old Memo {sOldMemo} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Edit Memo dialog box",FAIL,"Edit Memo dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC173_Delete_Transaction__From_Transaction_Report_Cancel #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC173_Delete_Transaction__From_Transaction_Report_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete transaction from Payee Transaction Report and click on Cancel button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes are not reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 7th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC173_Delete_Transaction__From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //List Of String
		[ ] LIST OF STRING lsTransactionDetails={"1/4/2010","Account Maintenance Fee","Fees & Charges:Bank Fee","-13.95"}
		[ ] STRING sSearchPayeeName=lsTransactionDetails[2]
		[ ] 
		[ ] 
		[ ] //String
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] STRING sReportAction="Delete transaction(s)"
		[ ] STRING sReportEntry
		[ ] STRING sAction="Launch Mini-Report for Payee Manual" 
		[ ] STRING sDeleteDialogCaption="Delete Transaction"
		[ ] STRING sExpectedNumberOfTransactions="3"
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Delete Transaction from Report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Delete Transaction Dialog is open----------------------------
			[+] if(AlertMessage.Exists(4))
				[ ] ReportStatus("Delete Transaction dialog box",PASS,"Delete Transaction dialog box is open")
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.Cancel.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify Transaction present in register---------------------------------
				[ ] iVerify=VerifyTransactionInAccountRegister(sSearchPayeeName,sExpectedNumberOfTransactions)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Transaction present in register",PASS,"Transaction is found in register")
					[ ] 
					[ ] //------------Clear Search window------------
					[ ] MDIClient.AccountRegister.SearchWindow.SetText("")
					[ ] 
					[ ] 
					[ ] //----------------Verify Content in Payee report---------------------------------
					[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
					[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
					[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
						[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
						[ ] //-----------Click on Show Report button on Callout----------
						[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
						[ ] 
						[ ] //----------------------Select Include all dates-----------------------
						[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
						[ ] 
						[ ] //------------Verify that transaction is present in report by retrieving it using amount-----------
						[ ] sReportEntry=GetLineFromReport(TransactionReports, lsTransactionDetails[4])
						[+] if(sReportEntry==NULL)
							[ ] ReportStatus("Transaction present in register",FAIL,"Transaction deleted from register")
							[ ] 
							[ ] 
							[ ] 
						[+] else 
							[ ] ReportStatus("Transaction present in register",PASS,"Transaction present in register")
						[ ] 
						[ ] 
						[ ] //---------Close Report----------
						[ ] TransactionReports.Close()
						[ ] WaitForState(TransactionReports,FALSE,5)
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
				[+] else
					[ ] ReportStatus("Transaction present in register",FAIL,"Transaction deleted from in register")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Delete Transaction dialog box",FAIL,"Delete Transaction dialog box did not open")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC174_Delete_Transaction__From_Transaction_Report_OK #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC174_Delete_Transaction__From_Transaction_Report_OK()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete transaction from Payee Transaction Report and click on OK button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 7th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC174_Delete_Transaction__From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //List Of String
		[ ] LIST OF STRING lsTransactionDetails={"1/4/2010","Account Maintenance Fee","Fees & Charges:Bank Fee","-13.95"}
		[ ] STRING sSearchPayeeName=lsTransactionDetails[2]
		[ ] 
		[ ] 
		[ ] //String
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] STRING sReportAction="Delete transaction(s)"
		[ ] STRING sReportEntry
		[ ] STRING sAction="Launch Mini-Report for Payee Manual" 
		[ ] STRING sDeleteDialogCaption="Delete Transaction"
		[ ] STRING sExpectedNumberOfTransactions="2"
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Delete Transaction from Report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Delete Transaction Dialog is open----------------------------
			[+] if(AlertMessage.Exists(4))
				[ ] ReportStatus("Delete Transaction dialog box",PASS,"Delete Transaction dialog box is open")
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.OK.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify Transaction present in register---------------------------------
				[ ] iVerify=VerifyTransactionInAccountRegister(sSearchPayeeName,sExpectedNumberOfTransactions)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Transaction present in register",PASS,"Transaction is found in register")
					[ ] 
					[ ] //------------Clear Search window------------
					[ ] MDIClient.AccountRegister.SearchWindow.SetText("")
					[ ] 
					[ ] 
					[ ] //----------------Verify Content in Payee report---------------------------------
					[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
					[ ] AccountActionsOnTransaction( sMDIWindow, sSearchPayeeName,sAction, "", iX,iY)
					[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
						[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
						[ ] //-----------Click on Show Report button on Callout----------
						[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
						[ ] 
						[ ] //----------------------Select Include all dates-----------------------
						[ ] WaitForState(TransactionReports, true ,2)
						[ ] TransactionReports.SetActive()
						[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
						[ ] 
						[ ] //------------Verify that transaction is present in report by retrieving it using amount-----------
						[ ] sReportEntry=GetLineFromReport(TransactionReports ,lsTransactionDetails[4])
						[+] if(sReportEntry==NULL)
							[ ] ReportStatus("Transaction present in register",PASS,"Transaction deleted from report")
							[ ] 
							[ ] 
						[+] else 
							[ ] ReportStatus("Transaction present in register",FAIL,"Transaction not deleted from report")
							[ ] 
						[ ] 
						[ ] 
						[ ] //---------Close Report----------
						[ ] TransactionReports.Close()
						[ ] WaitForState(TransactionReports,FALSE,5)
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
				[+] else
					[ ] ReportStatus("Transaction present in register",FAIL,"Transaction deleted from in register")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Delete Transaction dialog box",FAIL,"Delete Transaction dialog box did not open")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] // ############# TC11_Delete_Transfer__Transaction_From_Register #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC11_Delete_Transfer__Transaction_From_Register()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Delete Transfer Transaction from Register
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If changes are reflected in both accounts
		[ ] // Fail			If any error occurs
		[ ] // 
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Date                             May 8th 2013		
		[ ] // Author                          Dean Paes
	[ ] // ********************************************************
[+] testcase TC11_Delete_Transfer__Transaction_From_Register() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] LIST OF STRING lsFindTransaction
		[ ] INTEGER iValidate
		[ ] 
		[ ] STRING sCheckingAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] BOOLEAN bMatch1,bMatch2
		[ ] 
		[ ] //-------Savings Account Details----------------------------
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] STRING sSavingsAccountName=lsAddAccount[2]
		[ ] STRING sTransferCategorySavings="[{sCheckingAccountName}]"
		[ ] 
		[ ] 
		[ ] //------Checking Account Details Account Details----------------------------
		[ ] STRING sTransferCategoryChecking="[{lsAddAccount[2]}]"
		[ ] 
		[ ] STRING sSearchPayeeName="Transfer Transaction Payee"
		[ ] 
		[ ] //------Transfer Transaction Data--------------------------
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] lsTransactionData[6]=sSearchPayeeName
		[ ] STRING sTransferTransaction="Transfer"
		[ ] 
		[ ] 
		[ ] //----------Match Transaction count-----------
		[ ] STRING sExpectedNumberOfTransactions="0"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //-----------------Add a Savings Account----------------
		[ ] iValidate=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add a savings Account",PASS,"Savings account added successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Add Transaction to account
			[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[ ] iValidate= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDateStamp,sTransferTransaction,lsTransactionData[6],lsTransactionData[7],sTransferCategorySavings)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add Transaction", iValidate, "{lsTransactionData[2]} Transaction") 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //------------------------------------Verify that transaction is added--------------------------------
				[ ] lsFindTransaction=GetTransactionsInRegister(sSearchPayeeName)
				[ ] 
				[+] if(lsFindTransaction!=NULL)
					[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
					[ ] 
					[ ] //---------Verify if transfer transaction is added for Checking Account-------------
					[ ] bMatch1=MatchStr("*{sTransferCategoryChecking}*",lsFindTransaction[1])
					[ ] bMatch2=MatchStr("*{sCheckingAccountName}*",lsFindTransaction[1])
					[+] if(bMatch1==TRUE && bMatch2==TRUE)
						[ ] ReportStatus("Verify if transfer transaction is added for Checking Account",PASS,"Transfer Transaction is added for Checking Account")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if transfer transaction is added for Checking Account",FAIL,"Transfer Transaction is not added for Checking Account")
						[ ] 
					[ ] 
					[ ] 
					[ ] //---------Verify if account is added for Savings Account-------------
					[ ] bMatch1=MatchStr("*{sTransferCategorySavings}*",lsFindTransaction[2])
					[ ] bMatch2=MatchStr("*{sSavingsAccountName}*",lsFindTransaction[2])
					[+] if(bMatch1==TRUE && bMatch2==TRUE)
						[ ] ReportStatus("Verify if transfer transaction is added for Savings Account",PASS,"Transfer Transaction is added for Savings Account")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if transfer transaction is added for Savings Account",FAIL,"Transfer Transaction is not added for Savings Account")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //----------------------------------Delete Transfer Transaction-----------------------------------------
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] iValidate=DeleteTransaction(sMDIWindow,sSearchPayeeName)
					[+] if(iValidate==PASS)
						[ ] 
						[ ] //---------Verify if transfer transaction is deleted from Checking Account-------------
						[ ] SelectAccountFromAccountBar(sCheckingAccountName,ACCOUNT_BANKING)
						[ ] iValidate=VerifyTransactionInAccountRegister(sSearchPayeeName,sExpectedNumberOfTransactions)
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify if transfer transaction is deleted from Checking Account",PASS,"Transfer Transaction is deleted for Checking Account")
						[+] else
							[ ] ReportStatus("Verify if transfer transaction is deleted from Checking Account",FAIL,"Transfer Transaction is not deleted for Checking Account")
							[ ] 
						[ ] 
						[ ] 
						[ ] //---------Verify if account is added for Savings Account-------------
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] iValidate=VerifyTransactionInAccountRegister(sSearchPayeeName,sExpectedNumberOfTransactions)
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify if transfer transaction is deleted from Savings Account",PASS,"Transfer Transaction is deleted for Savings Account")
						[+] else
							[ ] ReportStatus("Verify if transfer transaction is deleted from Savings Account",FAIL,"Transfer Transaction is not deleted for Savings Account")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Delete Transaction",FAIL,"Error during deletion of Transaction {lsTransactionData[6]} from Account {lsAddAccount[2]}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
				[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Add a savings Account",FAIL,"Savings account not added")
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
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# Test179_VerifySplitTransactionBankingAccount #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test179_VerifySplitTransactionBankingAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify add split transaction and verifies if:
		[ ] //    1.the green tick mark button opens split dialog
		[ ] //    2.the red cross button clears all split lines
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding split transaction is successful
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                              26 April 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC179_VerifySplitTransactionBankingAccount() appstate none 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sTag , sMemo
		[ ] INTEGER iSplitListCount
		[ ] 
		[ ] 
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if (iCreateDataFile == PASS)
		[ ] ReportStatus("Validate Data File ", PASS , "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] 
			[ ] // Read data from sRegAccountWorksheet excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
			[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
			[ ] lsExcelData=NULL
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
			[ ] lsTransaction=lsExcelData[1]
			[ ] // Fetch 1st row from sExpenseCategoryDataSheet the given sheet
			[ ] lsExcelData=NULL
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
			[ ] lsExpenseCategory=lsExcelData[1]
			[ ] 
			[ ] //Select Checking Account---------------------------------------------------------------------------------------------------------------
			[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING,1)
			[+] if (iSelect==PASS)
				[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
				[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransaction[6]} added succesfully to Account {lsAddAccount[2]}")
					[ ] ////////Fetch 2nd row from sExpenseCategoryDataSheet////
					[ ] lsExpenseCategory=lsExcelData[2]
					[ ] sleep(2)
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
					[+] if(SplitTransaction.Exists(2))
						[ ] SplitTransaction.SetActive()
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#2")
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
						[+] if (NewTag.Exists(3))
							[ ] NewTag.SetActive()
							[ ] NewTag.OKButton.Click()
							[ ] 
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsExpenseCategory[4])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsExpenseCategory[2])
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
						[ ] 
						[+] if (SplitTransaction.Adjust.IsEnabled())
							[ ] SplitTransaction.Adjust.Click()
						[ ] SplitTransaction.OK.Click()
						[ ] WaitForState(SplitTransaction,False,1)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
						[ ] ////########Verify Split Button in the category field of the transaction#########///////// 
						[ ] iVerify=FAIL
						[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
						[ ] 
						[+] if(iVerify==PASS)
							[+] if (MDIClient.AccountRegister.TxList.AddedSplitButton.Exists(3))
								[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
								[ ] ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
								[ ] MDIClient.AccountRegister.TxList.AddedSplitButton.DoubleClick()
								[+] if(SplitTransaction.Exists(2))
									[ ] SplitTransaction.SetActive()
									[ ] 
									[ ] hWnd=NULL
									[ ] lsExpenseCategory=NULL
									[ ] lsExpenseCategory=lsExcelData[1]
									[ ] nAmount=VAL(lsExpenseCategory[2])
									[ ] lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
									[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] if (bMatch==TRUE)
										[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} appeared.")
									[+] else
										[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} didn't appear.")
									[ ] bMatch=FALSE
									[ ] lsExpenseCategory=NULL
									[ ] lsExpenseCategory=lsExcelData[2]
									[ ] nAmount=VAL(lsExpenseCategory[2])
									[ ] lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
									[ ] //bMatch =MatchStr("*{lsExpenseCategory[1]}",sActual)
									[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{lsExpenseCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] if (bMatch==TRUE)
										[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount:{Str(nAmount,7,2)}appeared.")
									[+] else
										[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount: {Str(nAmount,7,2)} didn't appear.")
										[ ] 
									[+] if (!SplitTransaction.IsActive())
										[ ] SplitTransaction.SetActive()
									[ ] SplitTransaction.OK.Click()
									[ ] WaitForState(SplitTransaction,False,1)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
							[+] else
								[ ] ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
							[ ] 
						[+] else
								[ ] ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
						[ ] 
						[ ] ////########Verify Clear Split Button in the category field of the transaction#########///////// 
						[ ] iVerify=FAIL
						[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
						[+] if(iVerify==PASS)
							[+] if (MDIClient.AccountRegister.TxList.ClearSplitlinesButton.Exists(3))
								[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
								[ ] ////########Verify clicking Clear Split Lines Button in the category field of the transaction deletes all split lines#########///////// 
								[ ] MDIClient.AccountRegister.TxList.ClearSplitlinesButton.DoubleClick(1,8,8)
								[+] if(AlertMessage.Exists(3))
									[ ] AlertMessage.Yes.Click()
								[+] else if(AlertMessage.Exists(3))
									[ ] AlertMessage.Yes.Click()
								[ ] 
								[ ] 
								[ ] //Verify if split dialog is empty
								[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
								[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
								[+] if(SplitTransaction.Exists(2))
									[ ] SplitTransaction.SetActive()
									[ ] 
									[ ] hWnd=NULL
									[ ] lsExpenseCategory=NULL
									[ ] lsExpenseCategory=lsExcelData[1]
									[ ] nAmount=VAL(lsExpenseCategory[2])
									[ ] lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
									[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] if (bMatch==FALSE)
										[ ] ReportStatus("Verify split transaction dailog ",PASS,"Split Lines are cleared for split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)}.")
									[+] else
										[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Split Lines are not cleared for split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)}.")
									[ ] bMatch=FALSE
									[ ] lsExpenseCategory=NULL
									[ ] lsExpenseCategory=lsExcelData[2]
									[ ] nAmount=VAL(lsExpenseCategory[2])
									[ ] lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
									[ ] //bMatch =MatchStr("*{lsExpenseCategory[1]}",sActual)
									[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{lsExpenseCategory[3]}*{lsExpenseCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] if (bMatch==FALSE)
										[ ] ReportStatus("Verify split transaction dailog ",PASS,"Split Lines are cleared for split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)}.")
									[+] else
										[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Split Lines are not cleared for split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)}.")
										[ ] 
									[+] if (!SplitTransaction.IsActive())
										[ ] SplitTransaction.SetActive()
									[ ] SplitTransaction.OK.Click()
									[ ] WaitForState(SplitTransaction,False,1)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
							[ ] 
						[+] else
								[ ] ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
					[ ] 
					[ ] 
					[+] else
						[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
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
		[+] // if(QuickenWindow.Exists(3))
			[ ] // QuickenWindow.SetActive ()
			[ ] // 
			[ ] // //Select the Banking account
			[ ] // iSelect = AccountBarSelect(ACCOUNT_BANKING,1)
			[+] // if (iSelect==PASS)
				[ ] // AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
				[ ] // iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
				[+] // if(iVerify==PASS)
					[ ] // ReportStatus("Add Transaction",PASS,"Transaction {lsTransaction[6]} added succesfully to Account {lsAddAccount[2]}")
					[ ] // ////////Fetch 2nd row from sExpenseCategoryDataSheet////
					[ ] // lsExpenseCategory=lsExcelData[2]
					[ ] // MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
					[+] // if(SplitTransaction.Exists(2))
						[ ] // SplitTransaction.SetActive()
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#2")
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // //SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[3])
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[+] // // if (NewTag.Exists(3))
							[ ] // // NewTag.SetActive()
							[ ] // // NewTag.OKButton.Click()
							[ ] // 
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[4])
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[2])
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
						[+] // if (SplitTransaction.Adjust.IsEnabled())
							[ ] // SplitTransaction.Adjust.Click()
						[ ] // SplitTransaction.OK.Click()
						[ ] // WaitForState(SplitTransaction,False,1)
						[ ] // MDIClient.AccountRegister.SetActive()
						[ ] // MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
						[ ] // ////########Verify Split Button in the category field of the transaction#########///////// 
						[ ] // iVerify=FAIL
						[ ] // iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
						[ ] // 
						[+] // if(iVerify==PASS)
							[+] // if (MDIClient.AccountRegister.TxList.AddedSplitButton.Exists(3))
								[ ] // ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
								[ ] // ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
								[ ] // MDIClient.AccountRegister.TxList.AddedSplitButton.Click()
								[+] // if(SplitTransaction.Exists(2))
									[ ] // SplitTransaction.SetActive()
									[ ] // 
									[ ] // hWnd=NULL
									[ ] // lsExpenseCategory=NULL
									[ ] // lsExpenseCategory=lsExcelData[1]
									[ ] // nAmount=VAL(lsExpenseCategory[2])
									[ ] // lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] // hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
									[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
									[ ] // bMatch =MatchStr("*{lsExpenseCategory[1]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] // if (bMatch==TRUE)
										[ ] // ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} appeared.")
									[+] // else
										[ ] // ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} didn't appear.")
									[ ] // bMatch=FALSE
									[ ] // lsExpenseCategory=NULL
									[ ] // lsExpenseCategory=lsExcelData[2]
									[ ] // nAmount=VAL(lsExpenseCategory[2])
									[ ] // lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
									[ ] // bMatch =MatchStr("*{lsExpenseCategory[1]}*{lsExpenseCategory[3]}*{lsExpenseCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] // if (bMatch==TRUE)
										[ ] // ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount:{Str(nAmount,7,2)}appeared.")
									[+] // else
										[ ] // ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount: {Str(nAmount,7,2)} didn't appear.")
										[ ] // 
									[+] // if (!SplitTransaction.IsActive())
										[ ] // SplitTransaction.SetActive()
									[ ] // SplitTransaction.OK.Click()
									[ ] // WaitForState(SplitTransaction,False,1)
									[ ] // 
								[+] // else
									[ ] // ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
							[+] // else
								[ ] // ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
							[ ] // 
						[+] // else
								[ ] // ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] // 
						[ ] // 
						[ ] // ////########Verify Clear Split Button in the category field of the transaction#########///////// 
						[ ] // iVerify=FAIL
						[ ] // iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
						[+] // if(iVerify==PASS)
							[+] // if (MDIClient.AccountRegister.TxList.ClearSplitlinesButton.Exists(3))
								[ ] // ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
								[ ] // ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
								[ ] // MDIClient.AccountRegister.TxList.ClearSplitlinesButton.Click(1,9,8)
								[+] // if(AlertMessage.Exists(3))
									[ ] // AlertMessage.Yes.Click()
								[+] // else if(MessageBox.Exists(3))
									[ ] // MessageBox.Yes.Click()
								[ ] // 
								[ ] // 
								[ ] // //Verify if split dialog is empty
								[ ] // iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
								[ ] // MDIClient.AccountRegister.TxList.TxToolBar.Split.Click()
								[+] // if(SplitTransaction.Exists(2))
									[ ] // SplitTransaction.SetActive()
									[ ] // 
									[ ] // hWnd=NULL
									[+] // if(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetItemCount()==0)
										[ ] // ReportStatus("Verify Clear Split lines Button in the transaction",PASS,"All Split data cleared")
										[ ] // 
									[+] // else
										[ ] // ReportStatus("Verify Clear Split lines Button in the transaction",FAIL,"Split data not cleared")
										[ ] // 
									[ ] // 
									[ ] // 
									[ ] // 
									[ ] // 
								[+] // else
									[ ] // ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
								[ ] // 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
							[ ] // 
						[+] // else
								[ ] // ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] // 
					[ ] // 
					[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[+] // else
					[ ] // ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
			[+] // else
				[ ] // ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
		[+] // else
			[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# Verify Correct Window Title displayed for Business Accounts##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC182_AttachDialogForTwoAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Correct Window Title displayed for Business Accounts
		[ ] //   
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If correct window name is displayed
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                              22 April 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC183_CorrectWindowTitleBusinessAccount() appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] //String
	[ ] 
	[+] if (QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] // Add Business Account
		[+] for (iCounter=12; iCounter<14;++iCounter)
			[ ] lsAddAccount=lsExcelData[iCounter]
			[+] if (lsAddAccount[1]==NULL)
				[ ] break
			[ ] sAccountName=lsAddAccount[2]
			[ ] iAddAccount = AddBusinessAccount(lsAddAccount[1], sAccountName)
			[ ] 
			[ ] //----------Turn On Popup Register---------------
			[ ] iPopupRegister = UsePopupRegister("ON")
			[+] if (iPopupRegister==PASS)
				[ ] 
				[ ] //-------Select Accounts Payable Receivable From Account Bar------------
				[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sAccountName} selected successfully")
					[ ] 
					[ ] //----------Get Caption--------------
					[ ] sCaption = BankingPopUp.Getproperty("Caption")
					[ ] 
					[ ] //-----------Match Caption with window name------------
					[ ] bMatch=MatchStr(sCaption,sAccountName)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Account Window Title",PASS, "Correct Account Title is displayed for {sAccountName} account")
					[+] else
						[ ] ReportStatus("Verify Account Window Title",FAIL, "Correct Account Title is not displayed for {sCaption} account:{sAccountName} ")
					[ ] 
					[ ] //----------Close Account Register--------------
					[ ] BankingPopUp.Close()
					[ ] WaitForState(BankingPopUp, false,1)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sAccountName} not selected")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] if (BankingPopUp.Exists(3))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Close()
				[ ] 
				[ ] 
				[ ] //----------Turn Off Popup Register---------------
				[ ] iPopupRegister = UsePopupRegister("OFF")
				[+] if (iPopupRegister==FAIL)
					[ ] ReportStatus("Popup Register OFF",FAIL,"Popup Register couldn't be set OFF")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Popup Register ON",FAIL,"Popup Register couldn't be set ON.")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
[ ] 
[+] ////############# Verify Transaction Filter Contents in Account Register ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC184_185_FilterForAllTransactionTypeBusinessAccounts()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if content under Transaction and Type filters is correct for business account registers	
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If all content under Transaction and Type filters is correct		
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  18th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC184_185_FilterForAllTransactionTypeBusinessAccounts() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,i
		[ ] 
		[ ] //String
		[ ] //STRING sAccountName
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionContents,lsTypeContents,lsActualCustomerTypeFilterContents,lsActualVendorTypeFilterContents,lsActualTransactionFilterContents
		[ ] 
		[ ] 
		[ ] lsActualCustomerTypeFilterContents={"Any Type","Paid","Charged"}
		[ ] lsActualVendorTypeFilterContents={"Any Type","Billed","Paid"}
		[ ] 
		[ ] lsActualTransactionFilterContents={"All Transactions","Uncategorized","Unreconciled","Cleared","Uncleared","Flagged"}
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Accounts Receivable From Account Bar
			[ ] iVerify=NULL
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sCustomerAccount} selected successfully")
				[ ] 
				[ ] 
				[ ] //Transaction Filter exists
				[+] if(MDIClient.AccountRegister.TransactionTypeFilter.Exists(3))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register for {sCustomerAccount} type account")
					[ ] 
					[ ] lsTransactionContents=MDIClient.AccountRegister.TransactionTypeFilter.GetContents()
					[ ] 
					[+] for(i=1;i<=ListCount(lsTransactionContents);i++)
						[ ] 
						[ ] // // Read data from excel sheet
						[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
						[ ] // lsTransactionFilterData=lsExcelData[i]
						[ ] // 
						[ ] 
						[ ] bMatch=MatchStr("*{lsActualTransactionFilterContents[i]}*",lsTransactionContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsActualTransactionFilterContents[i]} option present under Transaction Type Filter in Account Register for {sCustomerAccount}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsActualTransactionFilterContents[i]} option not found under Transaction Type Filter in Account Register for {sCustomerAccount}")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] //Type Filter exists
				[+] if(MDIClient.AccountRegister.TypeFilter.Exists(3))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsTypeContents=MDIClient.AccountRegister.TypeFilter.GetContents()
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsTypeContents);i++)
						[ ] 
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsActualCustomerTypeFilterContents[i]}*",lsTypeContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsActualCustomerTypeFilterContents[i]} option present under Type Filter in Account Register")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsActualCustomerTypeFilterContents[i]} option not found under Type Filter in Account Register")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sCustomerAccount} not selected")
			[ ] 
			[ ] 
			[ ] //Select Accounts Payable From Account Bar
			[ ] iVerify=NULL
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sVendorAccount} selected successfully")
				[ ] 
				[ ] 
				[ ] //Transaction Filter exists
				[+] if(MDIClient.AccountRegister.TransactionTypeFilter.Exists(3))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register for {sVendorAccount} type account")
					[ ] 
					[ ] lsTransactionContents=MDIClient.AccountRegister.TransactionTypeFilter.GetContents()
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsTransactionContents);i++)
						[ ] 
						[ ] bMatch=MatchStr("*{lsActualTransactionFilterContents[i]}*",lsTransactionContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsActualTransactionFilterContents[i]} option present under Transaction Type Filter in Account Register")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsActualTransactionFilterContents[i]} option not found under Transaction Type Filter in Account Register")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] //Type Filter exists
				[+] if(MDIClient.AccountRegister.TypeFilter.Exists(3))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsTypeContents=MDIClient.AccountRegister.TypeFilter.GetContents()
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsTypeContents);i++)
						[ ] 
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsActualVendorTypeFilterContents[i]}*",lsTypeContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsActualVendorTypeFilterContents[i]} option present under Type Filter in Account Register")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsActualVendorTypeFilterContents[i]} option not found under Type Filter in Account Register")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open data file",FAIL,"Data File {sFileName} opened successfully")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Filters present in account register",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Date Filter Contents in Account Register ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC36_FilterForAllDates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if content under Date filter is correct
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If all content under Date filter is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  19/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC186_FilterForAllDates() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,i
		[ ] 
		[ ] //String
		[ ] STRING sAccountName
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] 
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsDateContents,lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] //Select Accounts Payable From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sVendorAccount} selected successfully")
				[ ] 
				[ ] 
				[ ] //Verify Date Filter Contents
				[+] if(MDIClient.AccountRegister.DateFilter.Exists(3))
					[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsDateContents=MDIClient.AccountRegister.DateFilter.GetContents()
					[+] for(i=1;i<=ListCount(lsDateContents);i++)
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
						[ ] lsTransactionFilterData=lsExcelData[i]
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionFilterData[2]}*",lsDateContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if correct data is present under filters",PASS,"{lsTransactionFilterData[2]} option present under Date Filter in Account Register for {sVendorAccount}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"{lsTransactionFilterData[2]} option not found under Date Filter in Account Register for {sVendorAccount}")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sAccountName} not selected")
					[ ] 
			[+] else
				[ ] ReportStatus("Select account from account bar",PASS,"Account {sVendorAccount} selected successfully")
			[ ] 
			[ ] 
			[ ] //Select Accounts Receivable From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sCustomerAccount} selected successfully")
				[ ] 
				[ ] 
				[ ] //Verify Date Filter Contents
				[+] if(MDIClient.AccountRegister.DateFilter.Exists(3))
					[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsDateContents=MDIClient.AccountRegister.DateFilter.GetContents()
					[+] for(i=1;i<=ListCount(lsDateContents);i++)
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
						[ ] lsTransactionFilterData=lsExcelData[i]
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionFilterData[2]}*",lsDateContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if correct data is present under filters",PASS,"{lsTransactionFilterData[2]} option present under Date Filter in Account Register for {sCustomerAccount}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"{lsTransactionFilterData[2]} option not found under Date Filter in Account Register for {sCustomerAccount}")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sAccountName} not selected")
					[ ] 
			[+] else
				[ ] ReportStatus("Select account from account bar",PASS,"Account {sCustomerAccount} selected successfully")
		[+] else
			[ ] ReportStatus("Open data file",FAIL,"Data File {sFileName} opened successfully")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Filters present in account register",FAIL,"Quicken Main Window Not found")
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC187_VerifyAllTransactionsFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "All Transactions" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC187_VerifyAllTransactionsFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sBusinessAccount="Vendor Invoices"
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[1]
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
			[ ] 
			[ ] //Verify the All Transactions Filter
			[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
		[+] else
			[ ] ReportStatus("Open data file",FAIL,"Data File {sFileName} opened successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC188_VerifyUncategorizedFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Uncategorized" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC188_VerifyUncategorizedFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sCheckingAccount="Checking"
		[ ] STRING sBusinessAccount="Vendor Invoices"
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC189_VerifyUnreconciledFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Unreconciled" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC189_VerifyUnreconciledFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sCheckingAccount="Checking 01 A"
		[ ] STRING sBusinessAccount="Vendor Invoices Account"
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC191_VerifyUnclearedFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Uncleared" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC191_VerifyUnclearedFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String  
		[ ] STRING sFileName ,sCheckingAccount ,sBusinessAccount
		[ ] sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] sCheckingAccount="Checking 01 Account"
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[4]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC192_VerifyClearedFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Cleared" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC192_VerifyClearedFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sCheckingAccount="Checking"
		[ ] STRING sBusinessAccount="Vendor Invoices Account"
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[11][2]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[5]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC193_VerifyFlaggedFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Flagged" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC193_VerifyFlaggedFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sCheckingAccount="Checking"
		[ ] STRING sBusinessAccount="Vendor Invoices Account"
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[11][2]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[6]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC194_RegisterAllTypeFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will Verify "Flagged" Option from Transaction Dropdown menu in Account Register
		[ ] // 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC194_RegisterAllTypeFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTypeFilterWorksheet)
		[ ] 
	[ ] 
	[+] // if (QuickenWindow.Exists(3))
		[ ] // QuickenWindow.Kill()
		[ ] // App_Start(sCmdLine)
		[ ] // WaitForState(QuickenWindow,TRUE,10)
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] // Read data from excel sheet
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the All Type Filter
				[ ] lsTransactionFilterData=lsExcelData[4]
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the All Type Filter
				[ ] lsTransactionFilterData=NULL
				[ ] lsTransactionFilterData=lsExcelData[7]
				[ ] 
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC195_RegisterAllType_PaidFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will Verify "Flagged" Option from Transaction Dropdown menu in Account Register
		[ ] // 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC195_RegisterAllType_Paid_BilledFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTypeFilterWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] // Read data from excel sheet
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the Paid Filter
				[ ] lsTransactionFilterData=lsExcelData[6]
				[ ] 
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the All Type Filter
				[ ] lsTransactionFilterData=NULL
				[ ] lsTransactionFilterData=lsExcelData[10]
				[ ] print(lsTransactionFilterData)
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC196_RegisterAllType_ChargedFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will Verify "Flagged" Option from Transaction Dropdown menu in Account Register
		[ ] // 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC196_RegisterAllType_Charged_PaidFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] lsExcelData=NULL
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sTypeFilterWorksheet)
		[ ] 
		[ ] 
		[ ] lsTransactionFilterData=lsExcelData[11]
		[ ] print(lsTransactionFilterData)
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] // Read data from excel sheet
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the Charged Filter
				[ ] lsTransactionFilterData=lsExcelData[11]
				[ ] print(lsTransactionFilterData)
				[ ] 
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sCustomerAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the All Type Filter
				[ ] lsTransactionFilterData=NULL
				[ ] lsTransactionFilterData=lsExcelData[12]
				[ ] print(lsTransactionFilterData)
				[ ] 
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] ////############# Verify Date Filter in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC43_54RegisterDateFilter_AllDates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify all options under "All Dates" Dropdown menu from  Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all  details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC197_208_BusinessRegisterDateFilter_AllDates() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Datetime
		[ ] DATETIME dtDateTime,newDateTime
		[ ] 
		[ ] //Integer
		[ ] INTEGER iSelectDate
		[ ] 
		[ ] //String
		[ ] STRING sCompareDay,sCompareMonth,sCompareYear
		[ ] 
		[ ] STRING sDay,sMonth,sYear
		[ ] 
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] STRING sDateFormat="m/d/yyyy"
		[ ] STRING sCompareDayFormat="d"
		[ ] STRING sCompareMonthFormat="m"
		[ ] STRING sCompareYearFormat="yyyy"
		[ ] STRING sBusinessAccount="Vendor Invoices Account"
		[ ] 
		[ ] STRING sCustomDate1,sCustomDate2
		[ ] 
		[ ] STRING sAccountDate="1/1/2011"
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsDate,lsDateFilterData
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegBusinessTransaction)
		[ ] lsTransactionData=lsExcelData[2]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] lsExcelData=NULL
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if (iCreateDataFile == PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Add Business Account
		[ ] iAddAccount = AddBusinessAccount("Accounts Payable",sBusinessAccount)
		[ ] 
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Add Business Account", PASS, "Accounts Payable Account -  {sBusinessAccount}  is created successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Dates for transactions-------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For All Dates Transactions---------------------------------------------------------------------------------------------------------------
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]} ") 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] lsDateFilterData=lsExcelData[1]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[4])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Transaction From Register sMDIWindow
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For This Month Transactions------------------------------------------------------------------------------------------------------------
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]} ") 
				[ ] 
				[ ] //This Month---------------------------------
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] lsDateFilterData=lsExcelData[2]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[4])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] 
				[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For Last Month Transaction--------------------------------------------------------------------------------------------------------------
				[ ] dtDateTime= GetDateTime ()
				[ ] sCompareDay = FormatDateTime ([DATETIME] dtDateTime,  sCompareDayFormat) 
				[ ] 
				[ ] 
				[ ] 
				[+] // if(sCompareDay=="28"||sCompareDay=="29"||sCompareDay=="30"||sCompareDay=="31")
					[ ] // 
					[ ] // sNewDate=ModifyDate(-35)
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // 
					[ ] // sNewDate=ModifyDate(-28)
					[ ] // 
				[ ] 
				[ ] //Get date for Bill
				[ ] sDay=FormatDateTime(GetDateTime(), "d")
				[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
				[+] if(val(sMonth)==1)
					[ ] iSelectDate=12
				[+] else
					[ ] iSelectDate=val(sMonth)-1
				[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
				[ ] sDate="{iSelectDate}" +"/"+sDay+"/"+sYear
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]} ") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[3]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[4])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] 
				[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[+] //For Last 30 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-25,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[4]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last 60 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-55,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[5]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last 90 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-85,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[6]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last 12 Months-------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-200,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[7]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For This Quarter Transactions----------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //This Month---------------------------------
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] lsDateFilterData=lsExcelData[8]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] sleep(SHORT_SLEEP)
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] //For Last Quarter Transaction Date-----------------------------------------------------------------------------------------------------
				[ ] 
				[ ] dtDateTime= GetDateTime ()
				[ ] sCompareMonth = FormatDateTime ([DATETIME] dtDateTime,  sCompareMonthFormat) 
				[ ] 
				[+] if(sCompareMonth=="3"||sCompareMonth=="6"||sCompareMonth=="9"||sCompareMonth=="12")
					[ ] 
					[ ] //For Last Quarter Month
					[ ] sDate=ModifyDate(-100,sDateFormat)
					[ ] 
					[ ] 
				[+] else if(sCompareMonth=="2"||sCompareMonth=="5"||sCompareMonth=="8"||sCompareMonth=="11")
					[ ] 
					[ ] sDate=ModifyDate(-65,sDateFormat)
					[ ] 
					[ ] 
				[+] else if(sCompareMonth=="1"||sCompareMonth=="4"||sCompareMonth=="7"||sCompareMonth=="10")
					[ ] 
					[ ] sDate=ModifyDate(-35,sDateFormat)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[9]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For This Year Transaction Date---------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[10]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last Year Transaction Date---------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] 
				[ ] //Get date for Bill
				[ ] sDay=FormatDateTime(GetDateTime(), "d")
				[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
				[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
				[ ] iSelectDate=val(sYear)-1
				[ ] 
				[ ] sDate= sMonth+"/"+sDay+"/"+"{iSelectDate}"
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[11]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] //Custom date----------------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] 
				[ ] dtDateTime= GetDateTime ()
				[ ] newDateTime = AddDateTime (dtDateTime, -15)
				[ ] sCustomDate1 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
				[ ] 
				[ ] newDateTime = AddDateTime (dtDateTime, +15)
				[ ] sCustomDate2 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
				[ ] 
				[ ] MDIClient.AccountRegister.DateFilter.Select(12)
				[+] if(DlgCustomDate.Exists(3))
					[ ] DlgCustomDate.FromTextField.SetText(sCustomDate1)
					[ ] DlgCustomDate.ToTextField.SetText(sCustomDate2)
					[ ] DlgCustomDate.OKButton.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] //Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
					[ ] lsDateFilterData=lsExcelData[12]
					[ ] 
					[ ] 
					[ ] //Select Account from Account Bar
					[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
					[ ] 
					[ ] //Verify the All Transactions Filter
					[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
						[ ] 
					[ ] 
					[ ] //Delete Transaction From Register
					[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
					[ ] 
					[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  not created")
			[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not created")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# Test_CategoriesSplitTransaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test_CategoriesSplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add a split transaction with 30 split lines
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding split transaction is successful
		[ ] //						Fail			If adding split transaction is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 30th 2013		
		[ ] //Author                          Dean
		[ ] 
	[ ] // ********************************************************
	[ ] 
	[ ] 
[+] testcase Test_CategoriesSplitTransaction() appstate none 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sTag , sMemo ,sAccountTotal ,sActualBalanceText
		[ ] INTEGER iCount,iAccountCount,iAccountLoop
		[ ] LIST OF STRING lsAccountNameList ,lsAccountBalList
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] // Fetch 1st row from sExpenseCategoryDataSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
		[ ] lsExpenseCategory=lsExcelData[1]
		[ ] iCount = ListCount (lsExcelData) 
		[ ] 
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[ ] 
	[ ] iResult= DataFileCreate(sRegFileName)
	[+] if (iResult==PASS)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add Checking Account---------------------------
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] ListAppend(lsAccountNameList,lsAddAccount[2])
		[ ] ListAppend(lsAccountBalList,lsAddAccount[3])
		[ ] 
		[ ] 
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] // Add Savings Account---------------------------
		[ ] 
		[ ] // // Read data from excel sheet
		[ ] lsAddAccount=lsExcelData[2]
		[ ] ListAppend(lsAccountNameList,lsAddAccount[2])
		[ ] ListAppend(lsAccountBalList,lsAddAccount[3])
		[ ] 
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] 
		[ ] // Add Credit Card Account---------------------------
		[ ] // // Read data from excel sheet
		[ ] lsAddAccount=lsExcelData[3]
		[ ] ListAppend(lsAccountNameList,lsAddAccount[2])
		[ ] ListAppend(lsAccountBalList,lsAddAccount[3])
		[ ] 
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] 
		[ ] // Add Cash Account---------------------------
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsAddAccount=lsExcelData[4]
		[ ] ListAppend(lsAccountNameList,lsAddAccount[2])
		[ ] ListAppend(lsAccountBalList,lsAddAccount[3])
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] 
		[ ] iAccountCount=ListCount(lsAccountNameList)
		[+] for(iAccountLoop=1;iAccountLoop<=iAccountCount;iAccountLoop++)
			[ ] //Select the Banking account
			[ ] iSelect=SelectAccountFromAccountBar(lsAccountNameList[iAccountLoop],ACCOUNT_BANKING)
			[+] if (iSelect==PASS)
				[ ] 
				[ ] //Change Payee name to account related name
				[ ] lsTransaction[6]=lsAccountNameList[iAccountLoop]+"Payee"
				[ ] 
				[ ] 
				[+] if(iAccountLoop==1)
					[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
					[ ] 
				[ ] 
				[+] if(iAccountLoop>1)
					[ ] AddBankingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,NULL,lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
					[ ] 
					[ ] 
				[ ] 
				[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransaction[6]} added succesfully to Account {lsAccountNameList[iAccountLoop]}")
					[ ] 
					[ ] 
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
					[+] if(SplitTransaction.Exists(2))
						[ ] 
						[ ] 
						[ ] lsExcelData=NULL
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
						[ ] 
						[ ] nAmount1=0
						[+] for(i=1;i<=iCount;i++)
							[ ] lsExpenseCategory=lsExcelData[i]
							[ ] SplitTransaction.SetActive()
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select (i)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
							[+] if (NewTag.Exists(3))
								[ ] NewTag.SetActive()
								[ ] NewTag.OKButton.Click()
								[ ] 
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsExpenseCategory[4])
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsExpenseCategory[2])
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
							[ ] 
							[ ] 
							[ ] nAmount1 =VAL(lsExpenseCategory[2]) + nAmount1
						[ ] 
						[+] if (SplitTransaction.Adjust.IsEnabled())
							[ ] SplitTransaction.Adjust.Click()
						[ ] SplitTransaction.OK.Click()
						[ ] WaitForState(SplitTransaction,False,1)
						[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
						[ ] 
						[ ] 
						[ ] nAmount = VAL(lsAccountBalList[iAccountLoop]) - nAmount1
						[ ] //----------------Verify if Transaction is added to account-------------------------
						[+] if (iAccountLoop==3)
							[ ] nAmount = -VAL(lsAccountBalList[iAccountLoop]) - nAmount1
						[ ] sActualBalanceText=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
						[ ] 
						[ ] nActualAmount =VAL(StrTran(sActualBalanceText,",",""))
						[+] if(nActualAmount==nAmount)
							[ ] ReportStatus("Verify Split Transaction added to account",PASS,"Split Transaction:Transaction with payee {lsTransaction[6]} added to Account {lsAccountNameList[iAccountLoop]} with actual balance {nActualAmount}")
						[+] else
							[ ] ReportStatus("Verify Split Transaction added to account",FAIL,"Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAccountNameList[iAccountLoop]} with actual balance {nActualAmount} but expected balance is {nAmount}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAccountNameList[iAccountLoop]}")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] else
		[ ] ReportStatus("Verify Create New Quicken File", FAIL, "New Quicken File couldn't be created successfully..") 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# TC271_278_279_283__Verify_401K_Register_Account_Actions_Content #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC271_278_279_283__Verify_401K_Register_Account_Actions_Content()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the following testcases
		[ ] // 1. Register Account Actions for 401 K account
		[ ] // 2. Investing activity report
		[ ] // 3.Register Preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If register account actions verification is successful						
		[ ] //						Fail			If register account actions verification is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes                10th May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC271_278_279_283__Verify_401K_Register_Account_Actions_Content() appstate none //QuickenBaseState 
	[+] //Variable Declaration
		[ ] STRING sStatementEndingDate =ModifyDate(-5,"m/d/yyyy")
		[ ] LIST OF ANYTYPE lsAddAccount={"401(k) or 403(b)","401K Account","NewEmployer",sStatementEndingDate,"YHOO",10}
	[ ] 
	[ ] 
	[ ] iCreateDataFile=DataFileCreate(sFileName)
	[+] if(iCreateDataFile==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=AddManual401KAccount( lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
		[+] if(iResult==PASS)
			[ ] ReportStatus("Add 401K account in Quicken",PASS,"401K account successfully added to Quicken")
			[ ] 
			[ ] iSwitchState = UsePopupRegister("OFF")			// Turning Off pop up register mode
			[+] if (iSwitchState==PASS)
				[ ] ReportStatus("Verify Pop Up Register", PASS, "Turn on Pop up register mode")
				[ ] 
				[ ] //Select the 401k account
				[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
				[+] if (iSelect==PASS)
					[ ] ReportStatus("Verify {lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} account open successfully")
					[ ] 
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Set Up Online#####////
						[ ] 
						[ ] sValidationText="Activate One Step Update"
						[ ] NavigateToAccountActionInvesting(2,sMDIWindow)
						[ ] 
						[+] if (DlgActivateOneStepUpdate.Exists(4))
							[ ] DlgActivateOneStepUpdate.SetActive()
							[ ] sActual=DlgActivateOneStepUpdate.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions> Set Up Online:Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions> Set Up Online:Dialog  {sValidationText} didn't display.")
							[ ] DlgActivateOneStepUpdate.Cancel.Click()
							[ ] WaitForState(DlgActivateOneStepUpdate,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Dialog Activate One Step Update", FAIL, "Verify Dialog Activate One Step Update:  One Step Update Dialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Update 401K Holdings#####////
						[ ] 
						[ ] 
						[ ] sValidationText="Update 401(k)/403(b) Account: {lsAddAccount[2]}"
						[ ] NavigateToAccountActionInvesting(3,sMDIWindow)
						[+] if (DlgUpdate401KAccountHoldings.Exists(4))
							[ ] DlgUpdate401KAccountHoldings.SetActive()
							[ ] sActual=DlgUpdate401KAccountHoldings.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions> Update 401K Holdings:Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions> Update 401K Holdings:Dialog  {sValidationText} didn't display.")
							[ ] DlgUpdate401KAccountHoldings.Cancel.Click()
							[ ] WaitForState(DlgUpdate401KAccountHoldings,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Dialog  Update 401K Holdings", FAIL, "Verify Dialog:  Update 401K Holdings Dialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Update 401K Quotes#####////
						[ ] 
						[ ] sValidationText="Quicken Update Status"
						[ ] NavigateToAccountActionInvesting(4,sMDIWindow)
						[ ] 
						[+] if (QuickenUpdateStatus.Exists(4))
							[ ] QuickenUpdateStatus.SetActive()
							[ ] sActual=QuickenUpdateStatus.GetProperty("Caption")
							[ ] 
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions> Update 401K Quotes:Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions> Update 401K Quotes:Dialog  {sValidationText} didn't display.")
								[ ] 
							[ ] QuickenUpdateStatus.SetActive()
							[ ] // QuickenUpdateStatus.StopUpdate.Click()
							[ ] WaitForState(QuickenUpdateStatus,FALSE,20)
						[+] else
							[ ] ReportStatus("Verify Dialog  Update 401K Quotes", FAIL, "Verify Dialog:  Update 401K Quotes Dialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Edit Account Details#####////  
						[ ] 
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Account Details"
						[ ] NavigateToAccountActionInvesting(5,sMDIWindow)
						[+] if (AccountDetails.Exists(4))
							[ ] AccountDetails.SetActive()
							[ ] sActual=AccountDetails.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Edit Account Details", PASS, "Verify Account Actions> Edit Account Details option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Edit Account Details", FAIL, "Verify Account Actions>Edit Account Details option: Dialog {sValidationText} didn't display.")
							[ ] AccountDetails.Cancel.Click()
							[ ] WaitForState(AccountDetails,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify  Edit Account Details", FAIL, "Verify Dialog Edit Account Details:  One Step Update Dialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> EnterTransaction #####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Buy - Shares Bought"
						[ ] NavigateToAccountActionInvesting(6,sMDIWindow)
						[+] if (wEnterTransaction.Exists(4))
							[ ] wEnterTransaction.SetActive()
							[ ] sActual=wEnterTransaction.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Enter Transaction", PASS, "Verify Account Actions> Enter Transaction option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Enter Transaction", FAIL, "Verify Account Actions>Enter Transaction option: Dialog {sValidationText} didn't display.")
							[ ] wEnterTransaction.Cancel.Click()
							[ ] WaitForState(wEnterTransaction,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify  Enter Transaction ", FAIL, "Verify Dialog Enter Transaction :  Enter Transaction Dialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Reconcile Details#####////  
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Reconcile: {lsAddAccount[2]}"
						[ ] NavigateToAccountActionInvesting(7,sMDIWindow)
						[+] if (DlgReconcileDetails.Exists(4))
							[ ] DlgReconcileDetails.SetActive()
							[ ] sActual=DlgReconcileDetails.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Reconcile Details", PASS, "Verify Account Actions> Reconcile Details option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("VerifyReconcile Details", FAIL, "Verify Account Actions> Reconcile Details option: Dialog {sValidationText} didn't display.")
							[ ] DlgReconcileDetails.Cancel.Click()
							[ ] WaitForState(DlgReconcileDetails,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Reconcile Details", FAIL, "Verify Dialog Reconcile Details: Reconcile Details Dialog didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Update Cash Balance #####////  
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] 
						[ ] sValidationText="Update Cash Balance"
						[ ] NavigateToAccountActionInvesting(8,sMDIWindow)
						[+] if (UpdateCashBalance.Exists(4))
							[ ] UpdateCashBalance.SetActive()
							[ ] sActual=UpdateCashBalance.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Update Cash Balance", PASS, "Verify Account Actions> Update Cash Balance option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Update Cash Balance", FAIL, "Verify Account Actions> Update Cash Balance option: Dialog {sValidationText} didn't display.")
							[ ] UpdateCashBalance.Cancel.Click()
							[ ] WaitForState(UpdateCashBalance,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Update Cash Balance", FAIL, "Verify Dialog Update Cash Balance :Update Cash Balance Dialog didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[+] // /##########Verifying Acount Actions> Update Share Balance #####////  
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] 
						[ ] sValidationText="Adjust Share Balance"
						[ ] NavigateToAccountActionInvesting(9,sMDIWindow)
						[ ] 
						[+] if (AdjustShareBalance.Exists(4))
							[ ] AdjustShareBalance.SetActive()
							[ ] sActual=AdjustShareBalance.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Adjust Share Balance", PASS, "Verify Account Actions> Adjust Share Balance option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Adjust Share Balance", FAIL, "Verify Account Actions> Adjust Share Balance option: Dialog {sValidationText} didn't display.")
							[ ] AdjustShareBalance.Cancel.Click()
							[ ] WaitForState(AdjustShareBalance,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Adjust Share Balance", FAIL, "Verify Dialog Adjust Share Balance: Adjust Share Balance Dialog didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[+] // /##########Verifying Acount Actions> Security List #####////  
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] 
						[ ] sValidationText="Security List"
						[ ] NavigateToAccountActionInvesting(10,sMDIWindow)
						[+] if (SecurityList.Exists(4))
							[ ] SecurityList.SetActive()
							[ ] sActual=SecurityList.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Adjust Share Balance", PASS, "Verify Account Actions> Adjust Share Balance option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Adjust Share Balance", FAIL, "Verify Account Actions> Adjust Share Balance option: Dialog {sValidationText} didn't display.")
							[ ] SecurityList.Close()
							[ ] WaitForState(SecurityList,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Security List", FAIL, "Verify Dialog Security List : Security List Dialog didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Account Attachments #####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Account Attachments: {lsAddAccount[2]}"
						[ ] NavigateToAccountActionInvesting(12,sMDIWindow)
						[+] if (DlgAccountAttachments.Exists(4))
							[ ] DlgAccountAttachments.SetActive()
							[ ] sActual=DlgAccountAttachments.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Attachments", PASS, "Verify Account Actions> Account Attachments option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Attachments", FAIL, "Verify Account Actions> Account Attachments option: Dialog {sValidationText} didn't display.")
							[ ] DlgAccountAttachments.DoneButton.Click()
							[ ] WaitForState(DlgAccountAttachments,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Attachments : Account Attachments Dialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Account Overview #####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Account Overview: {lsAddAccount[2]}"
						[ ] NavigateToAccountActionInvesting(13,sMDIWindow)
						[+] if (DlgAccountOverview.Exists(4))
							[ ] DlgAccountOverview.SetActive()
							[ ] sActual=DlgAccountOverview.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Overview", PASS, "Verify Account Actions> Account Overview option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Overview", FAIL, "Verify Account Actions> Account Overview option: Dialog {sValidationText} didn't display.")
							[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
							[ ] WaitForState(DlgAccountOverview,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Investing Activity #####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Investing Activity"
						[ ] NavigateToAccountActionInvesting(14 , sMDIWindow)
						[+] if (InvestingActivity.Exists(4))
							[ ] InvestingActivity.SetActive()
							[ ] sActual=InvestingActivity.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Investing Activity", PASS, "Verify Account Actions> Investing Activity option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Investing Activity", FAIL, "Verify Account Actions> Investing Activity option: Dialog {sValidationText} didn't display.")
							[ ] InvestingActivity.Close()
							[ ] WaitForState(InvestingActivity,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Investing Activity ", FAIL, "Verify Investing Activity: Investing Activity didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Print Transactions#####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Print Register"
						[ ] NavigateToAccountActionInvesting(15 , sMDIWindow)
						[+] if (PrintRegister.Exists(4))
							[ ] PrintRegister.SetActive()
							[ ] sActual=PrintRegister.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Print Transactions", PASS, "Verify Account Actions> Print Transactions option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Print Transactions", FAIL, "Verify Account Actions> Print Transactions option: Dialog {sValidationText} didn't display.")
							[ ] PrintRegister.CancelButton.Click()
							[ ] WaitForState(PrintRegister,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Print Register", FAIL, "Verify Dialog Print Register : Print RegisterDialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Register preferences#####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Preferences"
						[ ] NavigateToAccountActionInvesting(17 , sMDIWindow)
						[+] if (Preferences.Exists(4))
							[ ] Preferences.SetActive()
							[ ] sActual=Preferences.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Register preferences", PASS, "Verify Account Actions>Register preferences option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Register preferences", FAIL, "Verify Account Actions>Register preferences option: Dialog {sValidationText} didn't display.")
							[ ] Preferences.Cancel.Click()
							[ ] WaitForState(Preferences,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Preferences", FAIL, "Verify Dialog Preferences : Preferences Dialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Customize Action Bar#####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Customize Action Bar"
						[ ] NavigateToAccountActionInvesting(18 , sMDIWindow)
						[+] if (DlgCustomizeActionBar.Exists(3))
							[ ] DlgCustomizeActionBar.SetActive()
							[ ] sActual=DlgCustomizeActionBar.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customize Action Bar", PASS, "Verify Account Actions>Customize Action Bar option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Account Actions>Customize Action Bar option: Dialog {sValidationText} didn't display.")
							[ ] DlgCustomizeActionBar.DoneButton.Click()
							[ ] WaitForState(DlgCustomizeActionBar,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Dialog Customize Action Bar :  Customize Action Bar Dialog didn't appear.")
					[ ] 
					[ ] 
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} account coudln't open.")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Pop Up Register", FAIL, "Pop up register mode didn't get enable.")
		[+] else
			[ ] ReportStatus("Add 401K account in Quicken",FAIL,"401K account successfully added to Quicken")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File ", FAIL, "Error during data file creation.") 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# TC272_Verify_401K_Register_Enter_Transactions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC272_Verify_401K_Register_Enter_Transactions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Account Actions menu - Enter Transactions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If transaction entry is successful						
		[ ] //						Fail			If any error occurs	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes               9th May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC272_Verify_401K_Register_Enter_Transactions() appstate QuickenBaseState 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iValidate
		[ ] STRING sNumberOfShares="5"
		[ ] STRING sPricePaid="12.00"
		[ ] 
		[ ] 
		[ ] STRING sStatementEndingDate =ModifyDate(-5,"m/d/yyyy")
		[ ] LIST OF ANYTYPE lsAddAccount={"401(k) or 403(b)","401K Account","NewEmployer",sStatementEndingDate,"Yahoo! Inc",10}
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("OFF")			// Turning Off pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] ReportStatus("Verify Pop Up Register", PASS, "Turn on Pop up register mode")
			[ ] 
			[ ] //Select the 401k account
			[ ] iSelect =AccountBarSelect(ACCOUNT_INVESTING,1)
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account", PASS, "{lsAddAccount[2]} account open successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] sValidationText=NULL
				[ ] sActual=NULL
				[ ] sValidationText="Buy - Shares Bought"
				[ ] NavigateToAccountActionInvesting(6,sMDIWindow)
				[+] if (wEnterTransaction.Exists(5))
					[ ] wEnterTransaction.SetActive()
					[ ] sActual=wEnterTransaction.GetProperty("Caption")
					[+] if (sActual==sValidationText)
						[ ] ReportStatus("Verify Enter Transaction", PASS, "Verify Account Actions> Enter Transaction option: Dialog {sActual} displayed as expected {sValidationText}.")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] //----------------Enter Transaction Details------------------
						[ ] wEnterTransaction.SecurityName.SetText(lsAddAccount[5])
						[ ] wEnterTransaction.NumberOfShares.SetText(sNumberOfShares)
						[ ] wEnterTransaction.PricePaid.SetText(sPricePaid)
						[ ] wEnterTransaction.EnterDone.Click()
						[ ] WaitForState(wEnterTransaction,FALSE,5)
						[ ] 
						[ ] 
						[ ] //-----------Find Transaction in Register----------------------------
						[ ] QuickenWindow.TypeKeys("<Ctrl-f>") 
						[ ] QuickenFind.QuickenFind.SetText(lsAddAccount[5])
						[ ] QuickenFind.Find.Click()
						[ ] 
						[+] if(!AlertMessage.Exists(4))
							[ ] ReportStatus("Verify Transaction Added to Register",PASS,"Transaction Added to Register")
						[+] else
							[ ] ReportStatus("Verify Transaction Added to Register",FAIL,"Transaction not  Added to Register")
							[ ] 
							[ ] 
						[ ] 
						[ ] QuickenFind.SetActive()
						[ ] QuickenFind.Close()
						[ ] 
					[ ] 
					[ ] 
					[+] else
						[ ] ReportStatus("Verify Enter Transaction", FAIL, "Verify Account Actions>Enter Transaction option: Dialog {sValidationText} didn't display.")
				[+] else
					[ ] ReportStatus("Verify  Enter Transaction ", FAIL, "Verify Dialog Enter Transaction :  Enter Transaction Dialog didn't appear.")
					[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} account did not open")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", FAIL, "Pop up register mode didn't get enable.")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# Test282_Buttons_Present_In_401K_Register_ #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test282_Buttons_Present_In_401K_Register_()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify buttons present in register
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If buttons are present
		[ ] //						Fail			If buttons are missing
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Dean Paes                             May 10th, 2013		
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test282_Buttons_Present_In_401K_Register_() appstate none 
	[ ] 
	[ ] //Variable Declaration
	[ ] LIST OF STRING lsInvestingRegisterButton={"Enter","Edit","Delete","Attach"}
	[ ] LIST OF ANYTYPE lsAddAccount
	[ ] STRING sHandle,sActual
	[ ] STRING sStatementEndingDate =ModifyDate(-5,"m/d/yyyy")
	[ ] lsAddAccount={"401(k) or 403(b)","401K Account","NewEmployer",sStatementEndingDate,"YHOO",10}
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] //Get Handle of 401K register
			[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
			[ ] 
			[ ] //Search the register rows for text of buttons using Qwauto
			[+] for(i=0;i<=20;i++)
				[ ] 
				[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
				[ ] bMatch=MatchStr("*{lsInvestingRegisterButton[1]}*{lsInvestingRegisterButton[2]}*{lsInvestingRegisterButton[3]}*{lsInvestingRegisterButton[4]}*",sActual)    //          lsInvestingRegisterButton[2]*lsInvestingRegisterButton[3]*lsInvestingRegisterButton[4]}*",)
				[+] if(bMatch)
					[ ] break
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify Investing reigster buttons",PASS,"{sActual} buttons are present in reigster as expected :{lsInvestingRegisterButton}")
				[ ] // bMatch=MatchStr("*{lsInvestingRegisterButton[2]}*",sActual)  
				[+] // if(bMatch==TRUE)
					[ ] // ReportStatus("Verify Investing reigster buttons",PASS,"{lsInvestingRegisterButton[2]} button is present in reigster")
					[ ] // bMatch=MatchStr("*{lsInvestingRegisterButton[3]}*",sActual)  
					[+] // if(bMatch==TRUE)
						[ ] // ReportStatus("Verify Investing reigster buttons",PASS,"{lsInvestingRegisterButton[3]} button is present in reigster")
						[ ] // bMatch=MatchStr("*{lsInvestingRegisterButton[4]}*",sActual)  
						[+] // if(bMatch==TRUE)
							[ ] // ReportStatus("Verify Investing reigster buttons",PASS,"{lsInvestingRegisterButton[4]} button is present in reigster")
							[ ] // break
						[+] // else
							[ ] // bMatch=FALSE
							[ ] // goto END 
						[ ] // 
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // bMatch=FALSE
						[ ] // goto END
					[ ] // 
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // bMatch=FALSE
					[ ] // goto END
					[ ] // 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Investing reigster buttons",FAIL,"{sActual} buttons are NOT present in reigster as expected :{lsInvestingRegisterButton}")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Select Account from account bar",FAIL,"Account not selected")
			[ ] 
	[+] else
		[ ] ReportStatus("Quicken Exists",FAIL,"Quicken Main Window not found")
		[ ] 
		[ ] 
[ ] 
[ ] 
[ ] // ///Mukesh//
[ ] 
[+] //#############TC 276-Account Actions menu - Update 401 K Holdings#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC276_AccountActionsMenuUpdate401KHoldings()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify cofiguring a manual 401k account for Setup download
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of cofiguring a manual 401k account for Setup download is successful				
		[ ] //						Fail			If verification of cofiguring a manual 401k account for Setup downloadis unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              20th May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC276_AccountActionsMenuUpdate401KHoldings() appstate none 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING sStatementEndingDate ,sHoldingsEndDate
		[ ] STRING sEmployeeContribution ,sEmployerContribution , sStateTax ,sFederalTax ,sExpReportTitle 
		[ ] INTEGER iSharesCount , iReportSelect
		[ ] LIST OF ANYTYPE lsReportData
		[ ] sStatementEndingDate =ModifyDate(-120,"m/d/yyyy")
		[ ] sHoldingsEndDate =ModifyDate(-1,"m/d/yyyy")
		[ ] ///Fetch sBrokerageAccountSheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] iSharesCount= Val(lsAddAccount[6])
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] ///Fetch sAccountHoldingsDataSheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountHoldingsDataSheet)
		[ ] 
		[ ] 
		[ ] sEmployeeContribution=lsExcelData[1][2]
		[ ] sEmployerContribution=lsExcelData[2][2]
		[ ] sFederalTax=lsExcelData[3][2]
		[ ] sStateTax=lsExcelData[4][2]
		[ ] 
	[ ] 
	[ ] iCreateDataFile=DataFileCreate(sRegFileName)
	[+] if(iCreateDataFile==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] ///Add a 401K account///
		[ ] iAddAccount=AddManual401KAccount( sAccountType , sAccountName ,lsAddAccount[3],sStatementEndingDate, lsAddAccount[5], iSharesCount)
		[+] if(iAddAccount==PASS)
			[ ] ReportStatus("Add {sAccountType} account in Quicken",PASS,"{sAccountName} account of {sAccountType} added to Quicken")
			[ ] 
			[ ] iSwitchState = UsePopupRegister("OFF")			// Turning Off pop up register mode
			[+] if (iSwitchState==PASS)
				[ ] 
				[ ] //Select the 401k account
				[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
				[+] if (iSelect==PASS)
					[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Update401KHoldings#####////
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateToAccountActionInvesting(3 , sMDIWindow)
						[+] if (DlgUpdate401KAccountHoldings.Exists(3))
							[ ] ReportStatus("Verify Account Actions for {sAccountName}", PASS, "Verify Account Actions> Update 401K Holdings for {sAccountName}:Update 401K Holdings for {sAccountName} displayed.")
							[ ] DlgUpdate401KAccountHoldings.SetActive()
							[ ] DlgUpdate401KAccountHoldings.ThisStatementEndsTextField.SetText(sHoldingsEndDate)
							[ ] DlgUpdate401KAccountHoldings.Next.Click()
							[ ] DlgUpdate401KAccountHoldings.EmployeeContributionsTextField.SetText(sEmployeeContribution)
							[ ] DlgUpdate401KAccountHoldings.EmployerMatchingContributionTextField.SetText(sEmployerContribution)
							[ ] DlgUpdate401KAccountHoldings.Next.Click()
							[ ] DlgUpdate401KAccountHoldings.StateTaxWithheldTextField.SetText(sStateTax)
							[ ] DlgUpdate401KAccountHoldings.FederalTaxWithheldTextField.SetText(sFederalTax)
							[ ] DlgUpdate401KAccountHoldings.Next.Click()
							[+] for ( iCount=0;iCount< 3;++iCount)
								[ ] DlgUpdate401KAccountHoldings.SetActive()
								[ ] DlgUpdate401KAccountHoldings.Next.Click()
							[+] if (AlertMessage.Exists(2))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.Yes.Click()
								[ ] WaitForState(AlertMessage,False,1)
								[ ] 
							[ ] DlgUpdate401KAccountHoldings.Done.Click()
							[ ] WaitForState(DlgUpdate401KAccountHoldings,False,1)
							[+] ///Verify Update 401K holdings data in register ///
								[ ] //Listcount is commented as the listcount is calculated by incorrectly by silktest it just takes count as 12//
								[ ] //hence count is hardcoded to retrieve the reult till desired rows///
								[ ] 
								[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
								[ ] // iListCount=MDIClient.AccountRegister.InvestingAccountRegister.AccountRegisterChild.QWListViewer.ListBox.GetItemCount()+1
								[+] for( iCounter=0;iCounter< 20 ;++iCounter)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
									[ ] ListAppend(lsListBoxItems,sActual)
								[ ] 
								[+] for ( iCount=1;iCount< ListCount(lsExcelData) + 1 ; ++iCount)
									[ ] lsTransaction=lsExcelData[iCount]
									[+] if (lsTransaction[1]==NULL)
										[ ] break
									[+] for( iCounter=1;iCounter< ListCount(lsListBoxItems) + 1 ;++iCounter)
										[+] if (lsTransaction[1]==sAccountName)
											[ ] bMatch = MatchStr("*{sHoldingsEndDate}*{lsTransaction[3]}*{lsTransaction[2]}*", lsListBoxItems[iCounter])
										[+] else
											[ ] bMatch = MatchStr("*{sHoldingsEndDate}*{lsTransaction[3]}*{lsTransaction[1]}*{lsTransaction[2]}*", lsListBoxItems[iCounter])
										[+] if ( bMatch == TRUE)
											[ ] break
									[+] if (bMatch)
										[ ] ReportStatus("Verify updated holdings data",PASS,"Verify updated holdings data in {sAccountName}: Updated holdings data is: {lsListBoxItems[iCounter]} as expected {lsTransaction} in {sAccountName}.")
									[+] else
										[ ] ReportStatus("Verify updated holdings data",FAIL,"Verify updated holdings data in {sAccountName}: Updated holdings data is not as expected {lsTransaction} in {sAccountName}.")
									[ ] 
							[+] ///Verify Update 401K holdings data in Investment Income report ///
								[ ] //Listcount is commented as the listcount is calculated by incorrectly by silktest it just takes count as 12//
								[ ] //hence count is hardcoded to retrieve the reult till desired rows///
								[ ] // Open Tax Schedule Report
								[ ] 
								[ ] sExpReportTitle="Investment Transactions"
								[ ] iReportSelect = OpenReport(lsReportCategory[3], sREPORT_INVESTMENT_TRANSACTION)	
								[+] if (iReportSelect==PASS)
									[ ] ReportStatus("Run {sREPORT_INVESTMENT_TRANSACTION} Report", iReportSelect, "Run Report successful") 
									[ ] // Verify sREPORT_INVESTMENT_TRANSACTION is Opened
									[+] if (InvestmentTransactions.Exists(3))
										[ ] 
										[ ] // Set Actives sREPORT_INVESTMENT_TRANSACTION  
										[ ] InvestmentTransactions.SetActive()
										[ ] 
										[ ] // Maximize sREPORT_INVESTMENT_TRANSACTION 
										[ ] InvestmentTransactions.Maximize()
										[ ] 
										[ ] // Get window caption
										[ ] sActual = InvestmentTransactions.GetCaption()
										[ ] 
										[ ] // Verify window title
										[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
										[ ] 
										[ ] // Report Status if window title is as expected
										[+] if (bMatch == TRUE)
											[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
											[ ] //  Validate Report Data
											[ ] sHandle=NULL
											[ ] sHandle = Str(InvestmentTransactions.QWListViewer1.ListBox1.GetHandle ())
											[ ] // //############## Verifying transactions on Reports> Investing> Investment Transaction############
											[ ] sActual=NULL
											[ ] iListCount=InvestmentTransactions.QWListViewer1.ListBox1.GetItemCount() +1
											[+] for( iCounter=0;iCounter< iListCount ;++iCounter)
												[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
												[ ] ListAppend (lsReportData , sActual)
											[ ] 
											[+] for ( iCount=1;iCount< ListCount(lsExcelData) + 1 ; ++iCount)
												[ ] lsTransaction=lsExcelData[iCount]
												[+] if (lsTransaction[1]==NULL)
													[ ] break
												[+] for( iCounter=1;iCounter< ListCount(lsReportData) + 1 ;++iCounter)
													[ ] bMatch = MatchStr("*{sHoldingsEndDate}*{sAccountName}*{lsTransaction[1]}*{lsTransaction[2]}*", lsReportData[iCounter])
													[+] if ( bMatch == TRUE)
														[ ] break
												[+] if (bMatch)
													[ ] ReportStatus("Verify updated holdings data",PASS,"Verify updated holdings data in {sAccountName}: Updated holdings data is: {lsReportData[iCounter]} as expected {lsTransaction} for  {sAccountName}.")
												[+] else
													[ ] ReportStatus("Verify updated holdings data",FAIL,"Verify updated holdings data in {sAccountName}: Updated holdings data is not as expected {lsTransaction} for {sAccountName}.")
												[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
										[ ] InvestmentTransactions.TypeKeys(KEY_EXIT)
										[ ] WaitForState(InvestmentTransactions,FALSE,1)
										[ ] /////#######Report validation done#######///
									[+] else
										[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
								[+] else
									[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account Actions for {sAccountName}", FAIL, "Verify Account Actions> Update 401K Holdings for {sAccountName}:Update 401K Holdings for {sAccountName} didn't display.")
							[ ] 
						[ ] 
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Pop Up Register is OFF.", FAIL, "Pop up register mode couldn't be disabled.")
		[+] else
			[ ] ReportStatus("Add {sAccountType} account in Quicken",FAIL,"{sAccountName} account of {sAccountType} couldn't be added to Quicken")
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File ", FAIL, "Error during data file creation.") 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //#############TC 275-Account Actions menu - Setup Download#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC275_AccountActionsMenuSetupDownload()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify cofiguring a manual 401k account for Setup download
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of cofiguring a manual 401k account for Setup download is successful				
		[ ] //						Fail			If verification of cofiguring a manual 401k account for Setup downloadis unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              20th May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC275_AccountActionsMenuSetupDownload() appstate QuickenBaseState 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING  sBankName ,sAccountID ,sPassword , sAccountNumber
		[ ] INTEGER iSharesCount
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sTRowPriceTxnsSheet)
		[ ] 
		[ ] iSharesCount= Val(lsAddAccount[6])
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] sBankName="T. Rowe Price"
		[ ] sAccountID="quickenqa"
		[ ] sPassword="Zags2010"
		[ ] sAccountNumber="0540120459"
		[ ] 
	[+] if (QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] iSwitchState = UsePopupRegister("OFF")			// Turning Off pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] 
			[ ] //Select the 401k account
			[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[ ] 
				[ ] NavigateToAccountDetails(sAccountName)
				[+] if (iSelect==PASS)
					[ ] AccountDetails.SetActive()
					[ ] AccountDetails.InvestingAccountNumber.SetText(sAccountNumber)
					[ ] AccountDetails.OK.Click()
					[ ] 
					[+] ///##########Verifying Acount Actions> Set Up Download#####////
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateToAccountActionInvesting(2 , sMDIWindow)
						[ ] SetUpDownload(sBankName, sAccountID ,sPassword)
						[ ] 
						[ ] ///After converting to online account transactions do get downloaded into C2R//
						[ ] QuickenWindow.SetActive()
						[ ] AcceptAll.Click()
						[+] if (AlertMessage.Exists(3))
							[ ] AlertMessage.OK.Click()
							[ ] WaitForState(AlertMessage,False,2)
							[ ] 
						[+] if (DlgAdjustHoldingsAmount.Exists(20))
							[ ] DlgAdjustHoldingsAmount.SetActive()
							[ ] DlgAdjustHoldingsAmount.AcceptButton.Click()
							[ ] WaitForState(DlgAdjustHoldingsAmount,False,2)
						[ ] 
						[+] if (DlgSecuritiesComparisonMismatch.DoneButton.Exists(20))
							[ ] DlgSecuritiesComparisonMismatch.SetActive()
							[ ] DlgSecuritiesComparisonMismatch.DoneButton.Click()
							[ ] WaitForState(DlgSecuritiesComparisonMismatch,False,2)
						[+] if (DlgSecuritiesComparisonMismatch.Exists(20))
							[ ] DlgSecuritiesComparisonMismatch.SetActive()
							[ ] DlgSecuritiesComparisonMismatch.AcceptButton.Click()
							[ ] WaitForState(DlgSecuritiesComparisonMismatch,False,2)
						[ ] 
						[ ] 
						[ ] 
						[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
						[ ] iListCount=BrokerageAccount.ListBox1.GetItemCount()+1
						[+] for ( iCount=1;iCount< ListCount(lsExcelData) +1;++iCount)
							[ ] lsTransaction=lsExcelData[iCount]
							[+] if (lsTransaction[1]==NULL)
								[ ] break
							[+] for( iCounter=0;iCounter< iListCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
								[ ] bMatch = MatchStr("*{lsTransaction[1]}*{lsTransaction[4]}*{lsTransaction[2]}*{lsTransaction[5]}*", sActual)
								[+] if ( bMatch == TRUE)
									[ ] break
							[+] if (bMatch)
								[ ] ReportStatus("Verify downloaded transactions",PASS,"Verify downloaded transactions in {lsAddAccount[2]}: Transactions downloaded {sActual} as expected {lsTransaction}.")
							[+] else
								[ ] ReportStatus("Verify downloaded transactions",FAIL,"Verify downloaded transactions in {lsAddAccount[2]}: Transactions couldn't download as expected {lsTransaction}.")
							[ ] 
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Account Details window", FAIL, "Account Details window is not opened")
			[+] else
					[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register is OFF.", FAIL, "Pop up register mode couldn't be disabled.")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //#############TC 277-Account Actions menu - Account Overview#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC277_AccountActionsMenuAccountOverview()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Account Status and Account Attributes on Account Overview 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of Account Status and Account Attributes on Account Overview is successful				
		[ ] //						Fail			If verification of cAccount Status and Account Attributes on Account Overview is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              21st May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC277_AccountActionsMenuAccountOverview() appstate QuickenBaseState 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING  sBankName ,sAccountID ,sPassword , sAccountNumber , sAttribute
		[ ] INTEGER iSharesCount
		[ ] LIST OF ANYTYPE lsAccAttributeParams , lsAccAttributeVal ,lsAccAttribute
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountAttributesSheet)
		[ ] lsAccAttributeParams=lsExcelData[1]
		[ ] lsAccAttributeVal =lsExcelData[2]
		[ ] sAccountName=lsAccAttributeVal[1]
		[ ] ///Create Account attribute  and attribute values key-value list//
		[+] for ( iCounter=1;iCounter<ListCount(lsAccAttributeParams) +1 ;++iCounter)
			[+] if (lsAccAttributeParams[iCounter]==NULL)
				[ ] break
			[+] if (lsAccAttributeVal[iCounter]==NULL)
				[ ] lsAccAttributeVal[iCounter]=""
			[ ] 
			[ ] ListAppend(lsAccAttribute , "{lsAccAttributeParams[iCounter]}@@{lsAccAttributeVal[iCounter]}")
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] //Select the 401k account
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] 
			[+] ///##########Verifying Acount Actions> Account Overview#####////
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] NavigateToAccountActionInvesting(12 , sMDIWindow)
				[ ] 
				[ ] ///After converting to online account transactions do get downloaded into C2R//
				[+] if (DlgAccountOverview.Exists(3))
					[ ] DlgAccountOverview.SetActive()
					[ ] 
					[ ] 
					[ ] 
					[ ] sHandle=Str(DlgAccountOverview.ListBox3.GetHandle())
					[ ] iListCount=DlgAccountOverview.ListBox3.GetItemCount()+1
					[+] for( iCounter=0;iCounter< iListCount ;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
						[ ] ListAppend(lsListBoxItems,sActual)
					[ ] 
					[ ] 
					[+] for each sAttribute in lsAccAttribute
						[+] for( iCounter=1;iCounter<ListCount( lsListBoxItems)+1 ;++iCounter)
							[ ] bMatch = MatchStr("*{sAttribute}*", lsListBoxItems[iCounter])
							[+] if ( bMatch == TRUE)
								[ ] break
						[+] if (bMatch)
							[ ] ReportStatus("Verify Account Overview data",PASS,"Verify Account Overview for {sAccountName}: Attribute {sActual} is as expected {sAttribute} on Account Overview for {sAccountName}.")
						[+] else
							[ ] ReportStatus("Verify Account Overview data",FAIL,"Verify Account Overview for {sAccountName}: Attribute {sActual} is not as expected {sAttribute} on Account Overview for {sAccountName}.")
							[ ] 
					[ ] DlgAccountOverview.SetActive()
					[ ] DlgAccountOverview.Close()
					[ ] WaitForState(DlgAccountOverview , false ,1)
				[+] else
					[ ] ReportStatus("Verify Account Overview dialog", FAIL, "Verify Account Overview dialog for {sAccountName} account couldn't open: Account Overview dialog for {sAccountName} couldn't open")
				[ ] 
			[ ] 
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //######################TC 287-Account Actions menu - Update Cash Balance########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC287_AccountActionsMenuUpdateCashBalance()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Update Cash Balance feature for investing account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of Update Cash Balance feature for investing account is successful				
		[ ] //						Fail			If verification of Update Cash Balance feature for investing account is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              21st May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC287_AccountActionsMenuUpdateCashBalance() appstate QuickenBaseState 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING sUpdateBalance ,sActualBalance
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] sUpdateBalance="200.22"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Select the 401k account
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] 
			[+] ///##########Verifying Acount Actions> UpdateCashBalance#####////
				[ ] //Update Cash balance
				[ ] QuickenWindow.SetActive()
				[ ] NavigateToAccountActionInvesting(7 , sMDIWindow)
				[+] if (UpdateCashBalance.Exists(3))
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", PASS, "Verify Account Actions> Update Cash Balance for {sAccountName}:Update Cash Balance for {sAccountName} displayed.")
					[ ] UpdateCashBalance.SetActive()
					[ ] UpdateCashBalance.CashBalanceTextField.SetText(sUpdateBalance)
					[ ] UpdateCashBalance.Done.Click()
					[ ] WaitForState(UpdateCashBalance,False,1)
					[ ] MDIClient.BrokerageAccount.QWHtmlView.Click(1,1180,10)
					[ ] 
					[ ] ///Verify updated cash balance on updated cash balance dialog by launching the dialog //
					[ ] //by clicking on CashBalance link lower rirght corner of the investing register //
					[+] if (UpdateCashBalance.Exists(2))
						[ ] UpdateCashBalance.SetActive()
						[ ] sActualBalance=UpdateCashBalance.CashBalanceTextField.GetText()
						[ ] UpdateCashBalance.Done.Click()
						[ ] WaitForState(UpdateCashBalance,False,1)
						[ ] 
						[+] if (sActualBalance==sUpdateBalance)
							[ ] ReportStatus("Verify UpdateCashBalance ", PASS, "Verify CashBalance updated: Cash balance {sActualBalance} updated as expected {sUpdateBalance} for {sAccountName}.")
						[+] else
							[ ] ReportStatus("Verify UpdateCashBalance ", FAIL, "Verify CashBalance updated: Cash balance {sActualBalance} updated is not as expected {sUpdateBalance} for {sAccountName}.")
					[+] else
						[ ] ReportStatus("Verify CashBalance link", FAIL, "Verify CashBalance link: CashBalance link couldn't launch the dialog Update Cash Balance for {sAccountName}.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", FAIL, "Verify Account Actions> Cash BalanceHoldings for {sAccountName}:Update Cash Balance for {sAccountName} didn't display.")
					[ ] 
				[ ] 
			[ ] 
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] // // ######################TC 288-Account Actions menu - Update Share Balance########################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC288_AccountActionsMenuUpdateShareBalance()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will verify Update Share Balance feature for investing account
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 		If verification of Update Share Balance feature for investing account is successful				
		[ ] // // Fail			If verification of Update Share Balance feature for investing account is unsuccessful		
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh              21st May 2013
		[ ] // // 
		[ ] // // ********************************************************
		[ ] // // 
	[ ] // // 
[+] testcase TC288_AccountActionsMenuUpdateShareBalance() appstate QuickenBaseState 
	[+] // Variable Declaration
		[ ] 
		[ ] STRING sSecurityName , sNumberOfShares
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] sSecurityName="Intu"
		[ ] sNumberOfShares="50"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Select the 401k account
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] 
			[+] // // /##########Verifying Acount Actions> Update Share Balance#####////
				[ ] // Update share balance
				[ ] QuickenWindow.SetActive()
				[ ] NavigateToAccountActionInvesting(8 , sMDIWindow)
				[+] if (AdjustShareBalance.Exists(3))
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", PASS, "Verify Account Actions> Update Share Balance for {sAccountName}:Update Share Balance for {sAccountName} displayed.")
					[ ] AdjustShareBalance.SetActive()
					[ ] AdjustShareBalance.SecurityName.SetText(sSecurityName)
					[ ] AdjustShareBalance.NumberOfShares.SetText(sNumberOfShares)
					[ ] AdjustShareBalance.EnterDone.Click()
					[+] if (AddSecurityToQuicken.Exists(3))
						[ ] AddSecurityToQuicken.TickerSymbol.SetText(sSecurityName)
						[ ] AddSecurityToQuicken.Next.Click()
						[+] if (AddSecurityToQuicken.ListBox.Exists(10))
							[ ] AddSecurityToQuicken.Done.Click()
					[ ] WaitForState(AdjustShareBalance,False,1)
					[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
					[ ] iListCount=BrokerageAccount.ListBox1.GetItemCount()+1
					[+] for( iCounter=0;iCounter< 25 ;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
						[ ] bMatch = MatchStr("*{sDate}*{sSecurityName}*{sNumberOfShares}*", sActual)
						[+] if ( bMatch == TRUE)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify Update Share Balance",PASS,"Verify Update Share Balance in {lsAddAccount[2]}: Verify Update Share Balance updated: {sActual} as expected: {sDate}, {sSecurityName}, {sNumberOfShares}.")
					[+] else
						[ ] ReportStatus("Verify Update Share Balance",FAIL,"Verify Update Share Balance in {lsAddAccount[2]}: Verify Update Share Balance didn't update: {sActual} as expected: {sDate}, {sSecurityName}, {sNumberOfShares}.")
						[ ] 
						[ ] // /Verify updated share balance on updated share balance dialog by searching the transaction in the investing register // sDate
				[+] else
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", FAIL, "Verify Account Actions> Share Balance for {sAccountName}:Update Share Balance dialog for {sAccountName} didn't display.")
					[ ] 
				[ ] 
			[ ] 
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //######################TC 286-Account Actions menu - Reconcile########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC286_AccountActionsMenuReconcile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Reconcile feature for investing account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of Reconcile feature for investing account is successful				
		[ ] //						Fail			If verification of Reconcile feature for investing account is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              21st May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC286_AccountActionsMenuReconcile() appstate none 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING sStartingCashBalance , sEndingCashBalance , sExpAdjustmentAmount ,sActualAdjustmentAmount
		[ ] STRING sOpeningBalanceDesc ,sAdjustmentBalanceDesc
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] sStartingCashBalance="1,000.00"
		[ ] sEndingCashBalance="1001"
		[ ] sExpAdjustmentAmount="$199.22"
		[ ] sOpeningBalanceDesc="Opening Balance Adjustment"
		[ ] sAdjustmentBalanceDesc="Balance Adjustment"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Select the 401k account
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] 
			[+] ///##########Verifying Acount Actions> Update Share Balance#####////
				[ ] //Update share balance
				[ ] QuickenWindow.SetActive()
				[ ] NavigateToAccountActionInvesting(6 , sMDIWindow)
				[+] if (DlgReconcileDetails.Exists(5))
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", PASS, "Verify Account Actions>Reconcile for {sAccountName}: Reconcile for {sAccountName} displayed.")
					[ ] DlgReconcileDetails.SetActive()
					[ ] DlgReconcileDetails.StartingCashBalanceTextField.SetText(sStartingCashBalance)
					[ ] DlgReconcileDetails.EndingCashBalanceTextField.SetText(sEndingCashBalance)
					[ ] DlgReconcileDetails.OK.Click()
					[+] if (DlgReconcileTransactions.Exists(2))
						[ ] DlgReconcileTransactions.SetActive()
						[ ] DlgReconcileTransactions.MarkAllButton.Click()
						[ ] DlgReconcileTransactions.DoneButton.Click()
						[+] if (DlgAdjustOpeningBalance.Exists(2))
							[ ] DlgAdjustOpeningBalance.SetActive()
							[ ] DlgAdjustOpeningBalance.AdjustButton.Click()
							[+] if (DlgAdjustBalance.Exists(2))
								[ ] DlgAdjustBalance.SetActive()
								[ ] sActualAdjustmentAmount = DlgAdjustBalance.AdjustmentAmountText.GetText()
								[ ] DlgAdjustBalance.AdjustButton.Click()
								[+] if (sActualAdjustmentAmount==sExpAdjustmentAmount)
									[ ] ReportStatus("Verify Adjustment Amount for {sAccountName}", PASS, "Verify Adjustment Amount for {sAccountName}: Adjustment Amount for {sAccountName} : {sActualAdjustmentAmount} is as expected: {sExpAdjustmentAmount} .")
									[+] if (DlgReconciliationComplete.Exists(5))
										[ ] DlgReconciliationComplete.SetActive()
										[ ] DlgReconciliationComplete.NoButton.Click()
										[ ] WaitForState(DlgReconciliationComplete, false,1)
										[ ] 
										[ ] 
										[ ] WaitForState(AdjustShareBalance,False,1)
										[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
										[ ] 
										[ ] //Listcount is commented as the listcount is calculated by incorrectly by silktest it just takes count as 12//
										[ ] //hence count is hardcoded to retrieve the reult till desired rows///
										[ ] //iListCount=MDIClient.AccountRegister.InvestingAccountRegister.AccountRegisterChild.QWListViewer.ListBox.GetItemCount()+1
										[ ] ///Get all the rows of investing register in a list//
										[+] for( iCounter=0;iCounter< 30 ;++iCounter)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
											[ ] ListAppend(lsListBoxItems,sActual)
										[ ] 
										[ ] ///Verify Reconcile transaction for Opening Balance in 401K Account///
										[+] for( iCounter=1;iCounter< ListCount(lsListBoxItems)+1  ;++iCounter)
											[ ] bMatch = MatchStr("*{sDate}*{sOpeningBalanceDesc}*{sStartingCashBalance}*", lsListBoxItems[iCounter])
											[+] if ( bMatch == TRUE)
												[ ] break
										[+] if (bMatch)
											[ ] ReportStatus("Verify Reconcile for {sOpeningBalanceDesc}",PASS,"Verify Reconcile txn for {sOpeningBalanceDesc} in {sAccountName}: Reconcile txn for {sOpeningBalanceDesc} is : {lsListBoxItems[iCounter]} as expected: {sDate}, {sOpeningBalanceDesc}, {sStartingCashBalance}.")
										[+] else
											[ ] ReportStatus("Verify Reconcile for {sOpeningBalanceDesc}",FAIL,"Verify Reconcile txn for {sOpeningBalanceDesc} in {sAccountName}: Reconcile txn for {sOpeningBalanceDesc} is not as expected: {sDate}, {sOpeningBalanceDesc}, {sStartingCashBalance}.")
											[ ] 
										[ ] 
										[ ] ///Verify Reconcile transaction for Adjustment Balance in 401K Account///
										[ ] 
										[ ] sExpAdjustmentAmount=StrTran(sExpAdjustmentAmount,"$","")
										[+] for ( iCounter=1;iCounter< ListCount(lsListBoxItems)+1  ;++iCounter)
											[ ] bMatch = MatchStr("*{sDate}*{sAdjustmentBalanceDesc}*{sExpAdjustmentAmount}*", lsListBoxItems[iCounter])
											[+] if ( bMatch == TRUE)
												[ ] break
										[+] if (bMatch)
											[ ] ReportStatus("Verify Reconcile for {sAdjustmentBalanceDesc}",PASS,"Verify Reconcile txn for {sAdjustmentBalanceDesc} in {sAccountName}: Reconcile txn for {sAdjustmentBalanceDesc} is : {lsListBoxItems[iCounter]} as expected: {sDate}, {sAdjustmentBalanceDesc}, {sExpAdjustmentAmount}.")
										[+] else
											[ ] ReportStatus("Verify Reconcile for {sAdjustmentBalanceDesc}",FAIL,"Verify Reconcile txn for {sAdjustmentBalanceDesc} in {sAccountName}: Reconcile txn for {sAdjustmentBalanceDesc} is not as expected: {sDate}, {sAdjustmentBalanceDesc}, {sExpAdjustmentAmount}.")
											[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Reconciliation Complete for {sAccountName}", FAIL, "Verify Reconciliation Complete for {sAccountName}: Reconciliation Complete dialog for {sAccountName} didn't display.")
								[+] else
									[ ] ReportStatus("Verify Adjustment Amount for {sAccountName}", FAIL, "Verify Adjustment Amount for {sAccountName}: Adjustment Amount for {sAccountName} : {sActualAdjustmentAmount} is not as expected: {sExpAdjustmentAmount} .")
								[+] if (DlgReconciliationComplete.Exists(5))
									[ ] DlgReconciliationComplete.SetActive()
									[ ] DlgReconciliationComplete.NoButton.Click()
									[ ] WaitForState(DlgReconciliationComplete, false,1)
								[ ] 
							[+] else
								[ ] ReportStatus("Verify dialog Adjust Balance for {sAccountName}", FAIL, "Verify dialog Adjust Balance for {sAccountName}: Adjust Balance dialog for {sAccountName} didn't display.")
						[+] else
							[ ] ReportStatus("Verify dialog AdjustOpeningBalance for {sAccountName}", FAIL, "Verify dialog Adjust Opening Balance for {sAccountName}: Adjust Opening Balance dialog for {sAccountName} didn't display.")
					[+] else
						[ ] ReportStatus("Verify Reconcile for {sAccountName}", FAIL, "Verify Reconcile for {sAccountName}: Reconcile dialog for {sAccountName} didn't display.")
				[+] else
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", FAIL, "Verify Account Actions> Reconcile for {sAccountName}: Account Actions> Reconcile dialog for {sAccountName} didn't display.")
					[ ] 
				[ ] 
			[ ] 
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //######################TC 285-Account Actions menu - Account Attachment########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC285_AccountActionsMenuAccountAttachment()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Account Attachment feature for investing account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of Account Attachment feature for investing account is successful				
		[ ] //						Fail			If verification of Account Attachment feature for investing account is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              21st May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC285_AccountActionsMenuAccountAttachment() appstate none //QuickenBaseState 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] STRING sAccountName, sAttachmentLocation, sAttachmentFolder
		[+] LIST OF STRING lsExpectedAttachNewPopupList={...}
			[ ] "Statement"
			[ ] "Other"
			[ ] "Check"
			[ ] "Invoice"
			[ ] "Receiptbill"
			[ ] "Warranty"
		[ ] 
		[ ] sAttachmentFolder="TransactionAttachments"
		[ ] sAttachmentLocation= AUT_DATAFILE_PATH + "\" + sAttachmentFolder+"\"
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Select the 401k account
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] 
			[+] ///##########Verifying Acount Actions> AccountAttachments#####////
				[ ] //Update Cash balance
				[ ] QuickenWindow.SetActive()
				[ ] NavigateToAccountActionInvesting(12 , sMDIWindow)
				[+] if (DlgAccountAttachments.Exists(2))
					[ ] DlgAccountAttachments.SetActive()
					[ ] DlgAccountAttachments.AddButton.Click()
					[+] if (DlgAddAttachment.Exists(3))
						[ ] DlgAddAttachment.SetActive()
						[ ] DlgAddAttachment.OKButton.Click()
						[+] if (DlgTransactionAttachments.Exists(3))
							[ ] DlgTransactionAttachments.SetActive()
							[ ] /// ######Verify AttachNew Check#######///
							[+] if (DlgTransactionAttachments.AddButton.Exists(3))
								[+] for (iCounter=1; iCounter<ListCount(lsExpectedAttachNewPopupList)+1 ; ++iCounter)
									[ ] DlgTransactionAttachments.AddButton.Click()
									[ ] // DlgTransactionAttachments.AttachNewPopupList.Select(trim(lsExpectedAttachNewPopupList[iCounter]))
									[ ] ////#####This line has been added to handle "/" as we can not have this as the part of file name#####////
									[ ] DlgTransactionAttachments.TypeKeys(KEY_DN)
									[ ] DlgTransactionAttachments.TypeKeys(KEY_ENTER)
									[+] if (DlgSelectAttachment.Exists(3))
										[ ] DlgSelectAttachment.SetActive()
										[ ] DlgSelectAttachment.FileName.SetText(sAttachmentLocation+lsExpectedAttachNewPopupList[iCounter])
										[ ] DlgSelectAttachment.Open.DoubleClick()
										[ ] WaitForState(DlgSelectAttachment,False,1)
										[+] if (DlgTransactionAttachments.Exists(3))
											[ ] 
											[ ] DlgTransactionAttachments.SetActive()
											[+] if (DlgTransactionAttachments.Exists(3))
												[ ] ReportStatus("Verify attachment attached.", PASS, "Verify attachment attached: Attachment {lsExpectedAttachNewPopupList[iCounter]} successfully attached.") 
												[ ] ///######Delete the added attachment########////
												[ ] DlgTransactionAttachments.DeleteButton.Click()
												[ ] DlgTransactionAttachments.TypeKeys(replicate(KEY_DN,3))
												[ ] DlgTransactionAttachments.TypeKeys(KEY_ENTER)
												[+] if(AlertMessage.Exists(3))
													[ ] AlertMessage.Yes.Click()
													[ ] WaitForState(AlertMessage,False,2)
													[ ] sleep(2)
													[ ] 
												[+] else
													[ ] ReportStatus("Verify delete confirmation dialog.", FAIL, "Verify delete confirmation dialog: Delete confirmation dialog didn't appear.") 
											[+] else
												[ ] ReportStatus("Verify attachment attached..", FAIL, "Verify attachment attached: Attachment {lsExpectedAttachNewPopupList[3]} couldn't be attached.") 
										[+] else
											[ ] ReportStatus("Verify attachments dialog.", FAIL, "Verify attachments dialog: Attachments dialog couldn't be opened.") 
										[ ] ////Attachment 
									[+] else
										[ ] ReportStatus("Verify Select attachment file dialog.", FAIL, "Verify Select attachment file dialog: Select attachment file dialog didn't appear.") 
							[+] else
								[ ] ReportStatus("Verify AttachNewPopupList exists.", FAIL, "Verify AttachNewPopupList exists: AttachNewPopupList doesn't exist.") 
							[+] if (!DlgTransactionAttachments.IsActive())
								[ ] DlgTransactionAttachments.SetActive()
							[ ] DlgTransactionAttachments.DoneButton.Click()
							[ ] WaitForState(DlgTransactionAttachments,False,1)
						[+] else
							[ ] ReportStatus("Verify attachments dialog.", FAIL, "Verify attachments dialog: Attachments dialog couldn't be opened.") 
					[+] else
						[ ] ReportStatus("Verify Add Attachment ", FAIL, "Verify Add Attachment dialog: Add Attachment dialog didn't appear.")
					[ ] DlgAccountAttachments.SetActive()
					[ ] DlgAccountAttachments.DoneButton.Click()
				[+] else
					[ ] ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Attachments : Account Attachments Dialog didn't appear.")
				[ ] 
			[ ] 
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# Test274_Enter_Transactions_401K_Register_ #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test274_Enter_Transactions_401K_Register_()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Enter Transactions for Cash Transferred In the account, out of account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Entering Transactions for Cash Transferred In the account, out of account is successful
		[ ] //						Fail			If Entering Transactions for Cash Transferred In the account, out of account is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Dean Paes                             May 10th, 2013		
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test274_Enter_Transactions_401K_Register_() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[+] //Variable Definition
		[ ] 
		[ ] STRING sStatementEndingDate,sTransferInMatch,sTransferOutMatch,sMatchText
		[ ] 
		[ ] INTEGER j
		[ ] 
		[ ] LIST OF STRING lsCashIntoAccount,lsCashOutOfAccount,lsSharesTransferredBetweenAccounts,lsResult
		[ ] 
		[ ] LIST OF ANYTYPE lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] sStatementEndingDate =ModifyDate(-5,"m/d/yyyy")
		[ ] sTransferInMatch="XIn"
		[ ] sTransferOutMatch="XOut"
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //List of Anytype
		[ ] lsAddAccount1={"401(k) or 403(b)","401K Account","NewEmployer",sStatementEndingDate,"YHOO",10}
		[ ] lsAddAccount2={"401(k) or 403(b)","401K 02 Account","NewEmployer",sStatementEndingDate,"YHOO",10}
		[ ] //List Of String
		[ ] lsCashIntoAccount={"Cash Transferred into Account","["+lsAddAccount2[2]+"]","12.5"}
		[ ] lsCashOutOfAccount={"Cash Transferred out of Account","["+lsAddAccount2[2]+"]","7.25"}
		[ ] lsSharesTransferredBetweenAccounts={"Shares Transferred Between Accounts","["+lsAddAccount2[2]+"]","4"}
		[ ] 
	[ ] 
	[ ] 
	[ ] iCreateDataFile=DataFileCreate(sFileName)
	[+] if(iCreateDataFile==PASS)
		[+] if(QuickenWindow.Exists(5))
			[ ] 
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] 
			[ ] iResult=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
			[+] if(iResult==PASS)
				[ ] 
				[ ] iResult=AddManual401KAccount( lsAddAccount2[1],lsAddAccount2[2],lsAddAccount2[3],lsAddAccount2[4],lsAddAccount2[5],lsAddAccount2[6])
				[+] if(iResult==PASS)
					[+] for(j=1;j<=2;j++)
						[ ] 
						[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_INVESTING)
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of {lsAddAccount1[2]} is opened")
							[ ] 
							[ ] 
							[+] switch j 
								[ ] 
								[ ] // Cash Transferred In the account 
								[+] case 1
									[ ] 
									[ ] //---------------Enter Transaction------------------
									[ ] 
									[ ] NavigateToAccountActionInvesting(6,sMDIWindow)
									[+] if (wEnterTransaction.Exists(5))
										[ ] wEnterTransaction.SetActive()
										[ ] 
										[ ] 
										[ ] wEnterTransaction.EnterTransaction.Select(lsCashIntoAccount[1])
										[ ] wEnterTransaction.TransferAccount.SetText(lsAddAccount[2])
										[ ] wEnterTransaction.AmountToTransfer.SetText(lsCashIntoAccount[3])
										[ ] wEnterTransaction.Memo.SetText(lsCashIntoAccount[1])
										[ ] wEnterTransaction.EnterDone.Click()
										[+] if(AlertMessage.Exists(2))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.No.Click()
											[ ] ReportStatus("Add Transaction",PASS,"Transaction is added successfully")
										[ ] WaitForState(wEnterTransaction,FALSE,5)
										[ ] 
										[ ] 
										[ ] 
										[ ] //-----------Open Incoming Register----------------------------
										[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
										[+] if(iVerify==PASS)
											[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of {lsAddAccount[2]} is opened")
											[ ] 
											[ ] 
											[ ] //-----------Find Transaction in Incoming Register----------------------------
											[ ] lsResult=GetTransactionsInRegister(lsCashIntoAccount[1])
											[ ] bMatch=MatchStr("*{lsCashIntoAccount[2]}*{lsCashIntoAccount[3]}*",lsResult[1])
											[+] if(bMatch==TRUE)
												[ ] ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferInMatch} matched")
											[+] else
												[ ] ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
												[ ] 
											[ ] 
											[ ] 
											[ ] //FROM_ACCOUNT:
											[ ] //-----------Open Outgoing Register----------------------------
											[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_INVESTING)
											[+] if(iVerify==PASS)
												[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of account {lsAddAccount2[2]} is opened")
												[ ] 
												[ ] 
												[ ] //-----------Find Transaction in Outgoing Register----------------------------
												[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
												[+] for(i=0;i<=10;i++)
													[ ] 
													[ ] //Match Transfer 
													[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
													[ ] bMatch=MatchStr("*{sTransferInMatch}*",sActual)
													[ ] 
													[+] if(bMatch==TRUE)
														[ ] ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferInMatch} matched")
														[ ] 
														[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i+1))
														[ ] //Match Transfer from account information
														[ ] bMatch=MatchStr("*{lsAddAccount[2]}*",sActual)
														[+] if(bMatch==TRUE)
															[ ] ReportStatus("Match Transfer Account",PASS,"Transfer from account {lsAddAccount[2]} matched")
															[ ] break
															[ ] 
														[+] else
															[ ] ReportStatus("Match Transfer Account",FAIL,"Transfer from account {lsAddAccount[2]} not matched")
														[ ] 
														[ ] 
														[ ] 
													[+] else
														[ ] bMatch=FALSE
														[ ] 
													[ ] 
													[ ] 
													[ ] 
												[+] if(bMatch==FALSE)
													[ ] 
													[ ] ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
													[ ] break
													[ ] 
													[ ] 
													[ ] 
													[ ] 
													[ ] 
													[ ] 
												[ ] 
												[ ] 
												[ ] 
												[+] // for(i=0;i<=iRegisterCount;i++)
													[ ] // 
													[ ] // sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
													[ ] // //Match Transfer 
													[ ] // bMatch=MatchStr("*{sTransferOutMatch}*",sActual)
													[+] // if(bMatch==TRUE)
														[ ] // ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferInMatch} matched")
														[ ] // 
														[ ] // sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i+1))
														[ ] // 
														[ ] // //Match Transfer from account information
														[ ] // bMatch=MatchStr("*{lsAddAccount1[2]}*",sActual)
														[+] // if(bMatch==TRUE)
															[ ] // ReportStatus("Match Transfer Account",PASS,"Transfer from account {lsAddAccount1[2]} matched")
															[ ] // goto FROM_ACCOUNT
															[ ] // 
														[+] // else
															[ ] // ReportStatus("Match Transfer Account",FAIL,"Transfer from account {lsAddAccount1[2]} not matched")
															[ ] // 
															[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
													[+] // else
														[ ] // 
														[ ] // ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
														[ ] // 
														[ ] // 
														[ ] // 
													[+] // if(bMatch==FALSE)
														[ ] // 
														[ ] // ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
														[ ] // break
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
													[ ] // 
													[ ] // 
													[ ] // 
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register {lsAddAccount2[2]} is not opened")
											[ ] 
											[ ] 
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register is opened")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Investing window displayed",FAIL,"Investing window not displayed")
										[ ] 
								[ ] 
								[ ] 
								[ ] // Cash Transferred Out the account 
								[+] case 2
									[ ] 
									[ ] //---------------Enter Transaction------------------
									[ ] 
									[ ] NavigateToAccountActionInvesting(6,sMDIWindow)
									[+] if (wEnterTransaction.Exists(5))
										[ ] wEnterTransaction.SetActive()
										[ ] 
										[ ] 
										[ ] wEnterTransaction.EnterTransaction.Select(lsCashOutOfAccount[1])
										[ ] wEnterTransaction.TransferAccount.SetText(lsAddAccount[2])
										[ ] wEnterTransaction.AmountToTransfer.SetText(lsCashOutOfAccount[3])
										[ ] wEnterTransaction.Memo.SetText(lsCashOutOfAccount[1])
										[ ] wEnterTransaction.EnterDone.Click()
										[+] if(AlertMessage.Exists(2))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.No.Click()
											[ ] ReportStatus("Add Transaction",PASS,"Transaction is added successfully")
										[ ] WaitForState(wEnterTransaction,FALSE,5)
										[ ] 
										[ ] 
										[ ] 
										[ ] //-----------Open Incoming Register----------------------------
										[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
										[+] if(iVerify==PASS)
											[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of {lsAddAccount[2]} is opened")
											[ ] 
											[ ] 
											[ ] //-----------Find Transaction in Incoming Register----------------------------
											[ ] lsResult=GetTransactionsInRegister(lsCashOutOfAccount[1])
											[ ] bMatch=MatchStr("*{lsCashOutOfAccount[2]}*{lsCashOutOfAccount[3]}*",lsResult[1])
											[+] if(bMatch==TRUE)
												[ ] ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferInMatch} matched")
											[+] else
												[ ] ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
												[ ] 
											[ ] 
											[ ] 
											[ ] //FROM_ACCOUNT:
											[ ] //-----------Open Outgoing Register----------------------------
											[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_INVESTING)
											[+] if(iVerify==PASS)
												[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of account {lsAddAccount2[2]} is opened")
												[ ] 
												[ ] 
												[ ] //-----------Find Transaction in Outgoing Register----------------------------
												[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
												[+] for(i=0;i<=10;i++)
													[ ] 
													[ ] //Match Transfer 
													[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
													[ ] 
													[ ] bMatch=MatchStr("*{sTransferOutMatch}*",sActual)
													[ ] 
													[+] if(bMatch==TRUE)
														[ ] ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferOutMatch} matched")
														[ ] 
														[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i+1))
														[ ] 
														[ ] //Match Transfer from account information
														[ ] bMatch=MatchStr("*{lsAddAccount[2]}*",sActual)
														[+] if(bMatch==TRUE)
															[ ] ReportStatus("Match Transfer Account",PASS,"Transfer from account {lsAddAccount[2]} matched")
															[ ] break
															[ ] 
														[+] else
															[ ] ReportStatus("Match Transfer Account",FAIL,"Transfer from account {lsAddAccount[2]} not matched")
														[ ] 
														[ ] 
														[ ] 
													[+] else
														[ ] bMatch=FALSE
														[ ] 
													[ ] 
													[ ] 
													[ ] 
												[+] if(bMatch==FALSE)
													[ ] 
													[ ] ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
													[ ] break
													[ ] 
													[ ] 
													[ ] 
													[ ] 
													[ ] 
													[ ] 
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register {lsAddAccount2[2]} is not opened")
											[ ] 
											[ ] 
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register is opened")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Investing window displayed",FAIL,"Investing window not displayed")
										[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register couldn't be opened")
							[ ] 
							[ ] 
				[+] else
					[+] ReportStatus("Add 401K account in Quicken",FAIL,"401K account successfully added to Quicken")
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
			[+] else
				[ ] ReportStatus("Add Checking account in Quicken",FAIL,"Error while adding Checking account to Quicken")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Create Data File ", FAIL, "Error during data file creation.") 
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
