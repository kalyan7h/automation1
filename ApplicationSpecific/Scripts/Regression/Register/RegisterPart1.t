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
[+] testcase Test2_VerifyRegisterAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
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
					[+] if(BankingPopUp.Exists(20))
						[ ] BankingPopUp.Maximize()
						[+] if (AccountActionsPopUpButton.Exists(20))
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
								[+] if (DlgCreateExcelCompatibleFile.Exists(20))
									[ ] 
									[ ] DlgCreateExcelCompatibleFile.SetActive()
									[ ] sActual=DlgCreateExcelCompatibleFile.GetProperty("Caption")
									[+] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Export to excel compatible file", PASS, "Verify Account Actions> Export to excel compatible file option: Dialog {sActual} displayed as expected {sValidationText}.")
									[+] else
										[ ] ReportStatus("Verify Export to excel compatible file", FAIL, "Verify Account Actions>Export to excel compatible file option: Dialog {sValidationText} didn't display.")
									[ ] DlgCreateExcelCompatibleFile.Close()
									[ ] WaitForState(DlgCreateExcelCompatibleFile,FALSE,1)
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
								[+] if (DlgCustomizeActionBar.Exists(20))
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
[+] testcase Test3_VerifyAvailabilityofSavingGoalsOnAccountActions() appstate NavigateToHomeTab 
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
	[+] if (QuickenWindow.Exists(20))
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
				[+] if (DlgContributeToGoal.Exists(20))
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
							[+] if(BankingPopUp.Exists(20))
								[ ] BankingPopUp.Maximize()
								[+] if (AccountActionsPopUpButton.Exists(20))
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
[+] testcase Test4_VerifyTransferSetup() appstate NavigateToHomeTab 
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
	[+] if (QuickenWindow.Exists(20))
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
				[+] if (iLoop==3)
					[ ] iSelect=AccountBarSelect(ACCOUNT_BANKING ,7)
				[+] else
					[ ] iSelect =SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BANKING)
				[ ] 
				[+] if (iSelect==PASS)
					[ ] ReportStatus("Verify {lsAccount[1]} Account", PASS, "{lsAccount[1]} account open successfully")
					[ ] iResult=UsePopupRegister("ON")	
					[+] if (iResult==PASS)
						[ ] 
						[+] if(BankingPopUp.Exists(20))
							[ ] BankingPopUp.Maximize()
							[ ] ///##########Verifying Acount Actions> Transfer Money #####////  
							[ ] BankingPopUp.SetActive()
							[ ] sValidationText=NULL
							[ ] sActual=NULL
							[ ] sValidationText="Transfer Money Within Quicken"
							[ ] NavigateToAccountActionBanking(iAccountSpecificCounterValue, sPopUpWindow)
							[+] if (DlgTransferMoneyWithinQuicken.Exists(20))
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
									[+] if (iLoop==3)
										[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TextClick(lsAddAccount[2])
									[+] else
										[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
									[ ] 
									[ ] 
									[ ] 
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
								[+] if (DlgTransferMoneyWithinQuicken.Exists(20))
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
		[+] if (BankingPopUp.Exists(20))
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
[+] testcase Test5_VerifyMoreReportsonAccountActions() appstate NavigateToHomeTab 
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
	[+] if(GetStartedBrowserWindow.GetStarted.Exists(20))
		[ ] GetStartedBrowserWindow.GetStarted.DoubleClick()
		[+] if (CreateANewBudget.Exists(20))
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
			[+] if(QuickenWindow.Exists(20))
				[+] QuickenWindow.SetActive ()
					[ ] 
					[ ] 
					[ ] //Select the Banking account
					[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] 
					[+] if (iSelect==PASS)
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", PASS, "{lsAddAccount[2]} account open successfully")
						[+] if(BankingPopUp.Exists(20))
							[ ] BankingPopUp.Maximize()
							[+] if (AccountActionsPopUpButton.Exists(20))
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
									[+] if(Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").Exists(20))
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
[+] testcase Test6_VerifySplitTransaction() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
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
				[+] if(SplitTransaction.Exists(20))
					[ ] SplitTransaction.SetActive()
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
					[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
					[+] if (NewTag.Exists(20))
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
						[+] if (MDIClient.AccountRegister.TxList.AddedSplitButton.Exists(20))
							[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
							[ ] ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
							[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
							[ ] // MDIClient.AccountRegister.TxList.AddedSplitButton.Click(1,6,8)
							[+] if(SplitTransaction.Exists(20))
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
[+] testcase Test7_VerifyModifySplitTransaction() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
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
				[+] if(SplitTransaction.Exists(20))
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
					[+] if (AlertMessage.Exists(20))
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
				[+] if(SplitTransaction.Exists(20))
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
[+] testcase Test8_VerifyClearSplitTransaction() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
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
							[+] // if (MDIClient.AccountRegister.TxList.AddedSplitButton.Exists(20))
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
[+] testcase Test9_VerifyIncomeCategorySplitTransaction() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
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
				[+] if(SplitTransaction.Exists(20))
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
						[+] if (NewTag.Exists(20))
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
					[+] if (DlgPaymentOrDeposit.Exists(20))
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
[+] testcase Test10_VerifyIncomeExpenseCategorySplitTransaction() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
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
[+] testcase Test11_VerifyUnknownTypePaymentSplitTransaction() appstate NavigateToHomeTab
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
	[+] if(QuickenWindow.Exists(20))
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
				[+] if (NewTag.Exists(20))
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
				[+] if (DlgPaymentOrDeposit.Exists(20))
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
[+] testcase Test12_VerifyUnknownTypeIncomeSplitTransaction() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
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
				[+] if (NewTag.Exists(20))
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
				[+] if (DlgPaymentOrDeposit.Exists(20))
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
[+] testcase TC13_RegisterSearchFeatureExistsForBusinessAccounts() appstate NavigateToHomeTab
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
	[+] if(QuickenWindow.Exists(20))
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
						[+] if(MDIClient.AccountRegister.SearchWindow.Exists(20))
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
	[+] // if(QuickenWindow.Exists(20))
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
				[+] // if (DlgTransactionAttachments.Exists(20))
					[ ] // DlgTransactionAttachments.SetActive()
					[ ] // /// ######Verify AttachNew PopupList contents#######///
					[+] // if (DlgTransactionAttachments.AttachNewPopupList.Exists(20))
						[ ] // lsActualListContents=DlgTransactionAttachments.AttachNewPopupList.GetContents()
						[+] // if (lsActualListContents==lsExpectedAttachNewPopupList)
							[ ] // ReportStatus("Verify AttachNew PopupList contents.", PASS, "Verify AttachNew PopupList contents: AttachNew PopupList has contents {lsActualListContents} as expected {lsExpectedAttachNewPopupList}.") 
						[+] // else
							[ ] // ReportStatus("Verify AttachNew PopupList contents.", FAIL, "Verify AttachNew PopupList contents: AttachNew PopupList's contents {lsActualListContents} are NOT as expected {lsExpectedAttachNewPopupList}.") 
					[+] // else
						[ ] // ReportStatus("Verify AttachNew PopupList exists.", FAIL, "Verify AttachNew PopupList exists: AttachNew PopupList doesn't exist.") 
					[ ] // /// ###### Verify options File,Scanner,Clipboard ,Done ,Help,Print and active#######///
					[+] // if (DlgTransactionAttachments.FileButton.Exists(20))
						[ ] // ReportStatus("Verify File Button exists.", PASS, "Verify File Button exists: File Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify File Button exists.", FAIL, "Verify File Button exists: File Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.ScannerButton.Exists(20))
						[ ] // ReportStatus("Verify Scanner Button exists.", PASS, "Verify Scanner Button exists: Scanner Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify Scanner Button exists.", FAIL, "Verify Scanner Button exists: Scanner Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.ClipboardButton.Exists(20))
						[ ] // ReportStatus("Verify Clipboard Button exists.", PASS, "Verify Clipboard Button exists: Clipboard Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify Clipboard Button exists.", FAIL, "Verify Clipboard Button exists: Clipboard Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.DoneButton.Exists(20))
						[ ] // ReportStatus("Verify Done Button exists.", PASS, "Verify Done Button exists: Done Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify Done Button exists.", FAIL, "Verify Done Button exists: Done Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.HelpButton.Exists(20))
						[ ] // ReportStatus("Verify Help Button exists.", PASS, "Verify Help Button exists: Help Button exists.") 
					[+] // else
						[ ] // ReportStatus("Verify Help Button exists.", FAIL, "Verify Help Button exists: Help Button doesn't exist.") 
					[+] // if (DlgTransactionAttachments.PrintButton.Exists(20))
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
	[+] // if(QuickenWindow.Exists(20))
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
				[+] // if (DlgTransactionAttachments.Exists(20))
					[ ] // DlgTransactionAttachments.SetActive()
					[ ] // /// ######Verify AttachNew Check#######///
					[+] // if (DlgTransactionAttachments.AttachNewPopupList.Exists(20))
						[+] // for (iCounter=1; iCounter<ListCount(lsExpectedAttachNewPopupList)+1 ; ++iCounter)
							[ ] // DlgTransactionAttachments.AttachNewPopupList.Select(trim(lsExpectedAttachNewPopupList[iCounter]))
							[ ] // ////#####This line has been added to handle "/" as we can not have this as the part of file name#####////
							[+] // if (lsExpectedAttachNewPopupList[iCounter]=="Receipt/bill")
								[ ] // lsExpectedAttachNewPopupList[iCounter]="Receiptbill"
							[ ] // 
							[ ] // DlgTransactionAttachments.FileButton.Click()
							[+] // if (SaveAs.Exists(20))
								[ ] // SaveAs.SetActive()
								[ ] // SaveAs.FileName.SetText(sAttachmentLocation+lsExpectedAttachNewPopupList[iCounter])
								[ ] // SaveAs.Open.DoubleClick()
								[ ] // WaitForState(SaveAs,False,1)
								[+] // if (DlgTransactionAttachments.Exists(20))
									[ ] // 
									[ ] // DlgTransactionAttachments.SetActive()
									[+] // if (DlgTransactionAttachments.AttachedPanel.QWinChild1.Panel1.Exists(20))
										[ ] // ReportStatus("Verify attachment attached.", PASS, "Verify attachment attached: Attachment {lsExpectedAttachNewPopupList[iCounter]} successfully attached.") 
										[ ] // ///######Delete the added attachment########////
										[ ] // DlgTransactionAttachments.DeleteButton.Click()
										[+] //  if(Quicken2012Popup.Exists(20))
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
		[ ] 
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
		[ ] //Check No.
		[ ] lsTransaction[5]="120"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(20))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] // 
			[ ] 
			[ ] ////Creating list of data to be searched////
			[ ] 
			[ ] iVerify =FindTransaction(sMDIWindow,lsTransaction[5])
			[+] if(iVerify==PASS)
				[ ] DeleteTransaction(sMDIWindow,lsTransaction[5])
			[ ] ////Creating list of data to be searched////
			[ ] lsTransaction[6]="Find Transaction"  
			[ ] lsTransaction[3]=lsExpenseCategory[2]
			[ ] lsTransaction[4]=sDateStamp
			[ ] lsTransaction[7]=lsExpenseCategory[4]
			[ ] lsTransaction[8]=lsExpenseCategory[1]
			[ ] 
			[ ] lsTemp ={lsTransaction[6] , lsTransaction[3] ,lsTransaction[8] ,lsTransaction[5] ,"Uncleared" ,sDateStamp ,lsTransaction[7],lsTransaction[6] ,lsTransaction[9]}
			[ ] 
			[ ] iResult=AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1],lsTransaction[9])
			[+] if (iResult== PASS)
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] ////Created list of data to be searched////
				[ ] /// ######Verify Find> Find pouplist contents #######///
				[ ] QuickenWindow.SetActive ()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)   
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_F)           // Launch Quicken Find window      
				[ ] 
				[+] if(QuickenFind.Exists(20))
					[ ] QuickenFind.SetActive()
					[ ] lsActualListContents= QuickenFind.FindAnyField.GetContents()
					[ ] QuickenFind.Close()
					[ ] 
					[+] if (lsActualListContents==lsExpectedFindPopupList)
						[ ] ReportStatus("Verify Edit > Find> Find pouplist contents.", PASS, "Verify Edit >Find> Find pouplist contents: Find pouplist has contents {lsActualListContents} as expected {lsExpectedFindPopupList}.") 
						[+] for (iCounter=1; iCounter<=ListCount(lsExpectedFindPopupList) ; ++iCounter)
							[ ] QuickenWindow.SetActive ()
							[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)	// highlight the new row
							[ ] QuickenWindow.TypeKeys(KEY_CTRL_F)           // Launch Quicken Find window         [QW2013 compatible] lsActualListContents
							[+] if(QuickenFind.Exists(20))
								[ ] QuickenFind.SetActive()
								[ ] QuickenFind.FindAnyField.Select(iCounter)
								[ ] QuickenFind.QuickenFind.SetText(lsTemp[iCounter])
								[ ] QuickenFind.Find.Click()
								[+] if (AlertMessage.Exists(2))
									[ ] AlertMessage.SetActive()
									[ ] sCaption=AlertMessage.MessageText.GetText()
									[ ] AlertMessage.OK.Click()
									[ ] WaitForState(AlertMessage,false,1)
									[ ] ReportStatus("Verify Edit> Find feature", FAIL, "{sCaption} alert message appeared.")
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
					[ ] ReportStatus("Verify Find window" , FAIL , "Find window didn't appear")
			[+] else
				[ ] ReportStatus("Verify transaction is added to the: {lsAddAccount[2]}." , FAIL , "Transaction with payee: {lsTransaction[6]} is added to the: {lsAddAccount[2]}.")
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
[+] testcase TC17_VerifyCheckNumOptionsforCheckingAccount() appstate NavigateToHomeTab
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
	[+] if(QuickenWindow.Exists(20))
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
[+] testcase TC18_VerifyTransferFromCheckingToSavingsDocumentWindowMode() appstate none //NavigateToHomeTab
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
	[+] if(QuickenWindow.Exists(20))
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
[+] testcase TC19_VerifyTransferFromSavingsToCheckingDocumentWindowMode() appstate NavigateToHomeTab
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
	[+] if(QuickenWindow.Exists(20))
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
[+] testcase TC20_VerifyTransferFromCheckingToSavingsPopUpWindowMode() appstate NavigateToHomeTab
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
	[+] if(QuickenWindow.Exists(20))
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
					[+] if (BankingPopUp.Exists(20))
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
				[+] if (BankingPopUp.Exists(20))
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
[+] testcase TC21_VerifyTransferFromSavingsToCheckingPopUpWindowMode() appstate NavigateToHomeTab
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
	[+] if(QuickenWindow.Exists(20))
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
				[+] if (BankingPopUp.Exists(20))
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
				[+] if (BankingPopUp.Exists(20))
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
[+] testcase TC22_VerifyEditDeleteTransferFromCheckingToSavingsPopUpWindowMode() appstate NavigateToHomeTab
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
	[+] if(QuickenWindow.Exists(20))
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
					[+] if (BankingPopUp.Exists(20))
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
			[+] if (BankingPopUp.Exists(20))
				[ ] BankingPopUp.SetActive()
				[ ] 
				[ ] iVerify=AccountActionsOnTransaction(sPopUpWindow,sPayee,sEditTransactionsAction)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Edit Transaction", PASS, "{sEditTransactionsAction} Action successful") 
					[ ] 
					[ ] //Verify if Find and replace window is opened
					[+] if(DlgFindAndReplace.Exists(20))
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
								[+] if (BankingPopUp.Exists(20))
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
									[+] if (BankingPopUp.Exists(20))
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
										[+] if (BankingPopUp.Exists(20))
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
[-] testcase Test23_VerifyRegisterAccountActionsForCustomerInvoiceAccount() appstate NavigateToHomeTab
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
	[-] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sRegFileName)
		[-] if (iVerify == PASS)
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[-] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sAccountName} selected successfully")
				[ ] QuickenWindow.SetActive ()
				[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
				[-] if (iSwitchState==PASS)
					[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Turn on Pop up register mode")
					[ ] 
					[-] if(BankingPopUp.Exists(20))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Maximize()
						[-] if (AccountActionsPopUpButton.Exists(20))
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
									[+] if (AlertMessage.Exists(20))
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
									[+] if (AlertMessage.Exists(20))
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
									[+] if (AlertMessage.Exists(20))
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
									[+] if (AlertMessage.Exists(20))
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
									[+] if (AlertMessage.Exists(20))
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
							[-] ///##########Verifying Customer Invoices Account Actions> Export to excel compatible file #####////  
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Create Excel compatible file"
								[ ] NavigateToAccountActionBanking(13, sPopUpWindow)
								[-] if (DlgCreateExcelCompatibleFile.Exists(20))
									[ ] //CreateExcelCompatibleFile=FileName.GetParent()
									[ ] DlgCreateExcelCompatibleFile.SetActive()
									[ ] sActual=DlgCreateExcelCompatibleFile.GetProperty("Caption")
									[-] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Export to excel compatible file", PASS, "Verify Customer Invoices Account Actions> Export to excel compatible file option: Dialog {sActual} displayed as expected {sValidationText}.")
									[-] else
										[ ] ReportStatus("Verify Export to excel compatible file", FAIL, "Verify Customer Invoices Account Actions>Export to excel compatible file option: Dialog {sValidationText} didn't display.")
									[ ] DlgCreateExcelCompatibleFile.Close()
									[ ] WaitForState(DlgCreateExcelCompatibleFile,FALSE,1)
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
								[+] if (DlgCustomizeActionBar.Exists(20))
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
[-] testcase Test24_VerifyRegisterAccountActionsForVendorInvoiceAccount() appstate NavigateToHomeTab
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
	[-] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sRegFileName)
		[-] if (iVerify == PASS)
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[-] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sAccountName} selected successfully")
				[ ] QuickenWindow.SetActive ()
				[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
				[-] if (iSwitchState==PASS)
					[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Turn on Pop up register mode")
					[ ] 
					[-] if(BankingPopUp.Exists(20))
						[ ] BankingPopUp.SetActive()
						[ ] BankingPopUp.Maximize()
						[-] if (AccountActionsPopUpButton.Exists(20))
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
									[+] if (AlertMessage.Exists(20))
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
									[+] if (AlertMessage.Exists(20))
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
									[+] if (AlertMessage.Exists(20))
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
									[+] if (AlertMessage.Exists(20))
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
							[-] ///##########Verifying Vendor Invoices Account Actions> Export to excel compatible file #####////  
								[ ] BankingPopUp.SetActive()
								[ ] sValidationText=NULL
								[ ] sActual=NULL
								[ ] sValidationText="Create Excel compatible file"
								[ ] NavigateToAccountActionBanking(12, sPopUpWindow)
								[-] if (DlgCreateExcelCompatibleFile.Exists(20))
									[ ] //CreateExcelCompatibleFile=FileName.GetParent()
									[ ] DlgCreateExcelCompatibleFile.SetActive()
									[ ] sActual=DlgCreateExcelCompatibleFile.GetProperty("Caption")
									[-] if (sActual==sValidationText)
										[ ] ReportStatus("Verify Export to excel compatible file", PASS, "Verify Vendor Invoices Account Actions> Export to excel compatible file option: Dialog {sActual} displayed as expected {sValidationText}.")
									[-] else
										[ ] ReportStatus("Verify Export to excel compatible file", FAIL, "Verify Vendor Invoices Account Actions>Export to excel compatible file option: Dialog {sValidationText} didn't display.")
									[ ] DlgCreateExcelCompatibleFile.Close()
									[ ] WaitForState(DlgCreateExcelCompatibleFile,FALSE,1)
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
								[+] if (DlgCustomizeActionBar.Exists(20))
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
[+] testcase Test25_VerifyMoreReportsonCustomerInvoiceAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] /////Create a Budget/////
		[ ] 
		[ ] QuickenMainWindow.QWNavigator.Planning.Click ()
		[ ] sleep(3)
		[ ] QuickenMainWindow.QWNavigator.Budgets.Click()
		[ ] sleep(3)
		[ ] WaitForState(QuickenMainWindow,TRUE,1)
		[ ] QuickenWindow.SetActive ()
		[+] if (!MDIClient.Budget.BudgetActions.Exists(3))
			[ ] GetStartedBrowserWindow.GetStarted.DoubleClick()
			[+] if(CreateANewBudget.Exists(20))
				[ ] CreateANewBudget.SetActive()
				[ ] CreateANewBudget.BudgetName.SetText(sBudget)
				[ ] CreateANewBudget.OK.Click()
				[ ] WaitForState(QuickenMainWindow,TRUE,2)
			[+] else
				[ ] ReportStatus("Verify Create A New Budget dialog.", FAIL, "Verify Create A New Budget dialog: Create A New Budget dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Budget", PASS, "Budget already created.")
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] ReportStatus("Verify Pop Up Register", iSwitchState, "Turn on Pop up register mode")
			[ ] 
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account", PASS, "{lsAddAccount[2]} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
								[+] if (DlgUnpaidInvoices.Exists(20))
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
								[+] if(Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").Exists(20))
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
		[ ] 
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
[+] testcase Test26_VerifyMoreReportsonVendorInvoiceAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account", PASS, "{lsAddAccount[2]} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
							[+] if(Desktop.Find("//MainWin[@caption='{lsReportNames[iCounter]}']").Exists(20))
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
[+] testcase Test27_VerifyAddCustomerInvoiceUsingAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
					[+] if (BankingPopUp.Exists(20))
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
[+] testcase Test28_VerifyAddCustomerPaymentUsingAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
										[+] if (BankingPopUp.Exists(20))
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.Close()
											[ ] WaitForState(BankingPopUp,FALSE,1)
										[ ] ////Verify that Payment in Checking 01 account register using Find and Replace dailog box///
										[ ] //Select the Checking 01 account
										[ ] QuickenWindow.SetActive ()
										[ ] sAccountName=lsTransaction[2]
										[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
										[+] if (iSelect==PASS)
											[+] if (BankingPopUp.Exists(20))
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
																[+] if(DeleteTransaction.Exists(20))
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
		[+] if(BankingPopUp.Exists(20))
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
[+] testcase Test29_VerifyAddCustomerCreditUsingAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
[+] testcase Test30_VerifyAddCustomerRefundUsingAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
										[+] if (BankingPopUp.Exists(20))
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.Close()
											[ ] WaitForState(BankingPopUp,FALSE,1)
										[ ] ////Verify that Payment in Checking 01 account register using Find and Replace dailog box///
										[ ] //Select the Checking 01 account
										[ ] sAccountName=lsTransaction[1]
										[ ] 
										[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
										[+] if (iSelect==PASS)
											[+] if (BankingPopUp.Exists(20))
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
					[+] if (BankingPopUp.Exists(20))
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
[+] testcase Test31_VerifyAddCustomerFinanceChargeUsingAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
					[+] if (BankingPopUp.Exists(20))
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
[+] testcase Test32_VerifyInvoiceDefaultsFeatureUsingAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
												[+] if (AlertMessage.Exists(20))
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
					[+] if (BankingPopUp.Exists(20))
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
[+] testcase Test33_VerifyAddVendorPaymentUsingAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
										[+] if (AlertMessage.Exists(20))
											[ ] AlertMessage.OK.Click()
										[ ] 
										[+] if (iAddTransaction==PASS)
											[ ] BankingPopUp.SetActive()
											[+] if (BankingPopUp.TxList.TxToolbar.SplitButton.Exists(20))
												[ ] ReportStatus("Verify Split Button for {sAccountName}.", PASS, "Verify Split Button for { sAccountName}: Split Button exists for { sAccountName}.")
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Verify Split Button for {sAccountName}.", FAIL, "Verify Split Button for { sAccountName}: Split Button doesn't exist for { sAccountName}.")
												[ ] 
											[+] if (BankingPopUp.TxList.TxToolbar.MoreAccountActions.Exists(20))
												[ ] ReportStatus("Verify MoreActions Button for {sAccountName}.", PASS, "Verify MoreActions Button for { sAccountName}: MoreActions Button exists for { sAccountName}.")
											[+] else
												[ ] ReportStatus("Verify MoreActions Button for {sAccountName}.", FAIL, "Verify MoreActions Button for { sAccountName}: MoreActions Button doesn't exist for { sAccountName}.")
											[+] if (BankingPopUp.TxList.TxToolbar.Save.Exists(20))
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
										[+] if (BankingPopUp.Exists(20))
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.Close()
											[ ] WaitForState(BankingPopUp,FALSE,1)
										[ ] ////Verify that Payment in Checking 01 account register using Find and Replace dailog box///
										[ ] //Select the Checking 01 account
										[ ] sAccountName=lsTransaction[2]
										[ ] 
										[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
										[+] if (iSelect==PASS)
											[+] if (BankingPopUp.Exists(20))
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
					[+] if (BankingPopUp.Exists(20))
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
[+] testcase Test34_VerifyAddVendorCreditUsingAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
[+] testcase Test35_VerifyAddVendorRefundUsingAccountActions() appstate NavigateToHomeTab 
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
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] //Select the BUSINESS account
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
			[ ] 
			[+] if (iSelect==PASS)
				[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[+] if(BankingPopUp.Exists(20))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[+] if (AccountActionsPopUpButton.Exists(20))
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
										[+] if (BankingPopUp.Exists(20))
											[ ] BankingPopUp.SetActive()
											[ ] BankingPopUp.Close()
											[ ] WaitForState(BankingPopUp,FALSE,1)
										[ ] ////Verify that Refund in Checking 01 account register using Find and Replace dailog box///
										[ ] //Select the Checking 01 account
										[ ] sAccountName=lsTransaction[1]
										[ ] 
										[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
										[+] if (iSelect==PASS)
											[+] if (BankingPopUp.Exists(20))
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
					[+] if (BankingPopUp.Exists(20))
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
[+] testcase Test36_VerifyCustomerVendorAccountsDeletion() appstate NavigateToHomeTab 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] 
	[+] if(QuickenWindow.Exists(20))
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
