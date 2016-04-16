[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<AccountList.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Account list test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Dean Paes	
	[ ] //
	[ ] // Developed on: 		21/12/2010
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 4 /1 /2013 	Dean Paes  Created
[ ] // *********************************************************
[ ] 
[ ] 
[ ] 
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
[ ] 
[+] //Global Variables
	[ ] public STRING sFileName = "Account List Data File"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] 
	[ ] public STRING sFIFileName="AccountListFI"
	[ ] public STRING sFIDataFile= AUT_DATAFILE_PATH + "\" + sFIFileName + ".QDF"
	[ ] 
	[ ] public STRING sHandle,sActual,sAccountListLine
	[ ] public BOOLEAN  bExist,bMatch
	[ ] public INTEGER iSwitchState,iCreateDataFile,iOpenDataFile, iNavigate, iAddAccount,iRegistration,iAction,iAccountListLine,iSelect,i,iListCount,iCount
	[ ] 
	[ ] //public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sWindowTypeMDI="MDI"
	[ ] public STRING sWindowTypePopUp="PopUp"
	[ ] 
	[ ] //For Restarting Open Agent for identification issue
	[ ] public STRING sBatchPath =AUT_DATAFILE_PATH+"\RestartOpenAgent.bat"
	[ ] 
	[ ] 
	[ ] public LIST OF ANYTYPE  lsAccountData,lsExcelData
	[ ] public LIST OF STRING lsAddAccount, IsEditAccount
	[ ] public STRING sAccountList = "AccountList"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sEditWorksheet = "General Account Details"
	[ ] public STRING sAccountUIWorksheet="Account List UI"
	[ ] public STRING sAccountSinglePurpose= "Single Purpose Account List" 
	[ ] public STRING sAccountTitle= "Account List Title"
	[ ] public STRING sAccountFI="FI Status"
	[ ] public STRING sAccountTab="Account Tabs"
	[ ] public STRING sCheckingTransactionWorksheet="Checking Transaction"
	[ ] 
	[ ] public STRING sSelectAction="Select"
	[ ] public STRING sDeSelectAction="Deselect"
	[ ] 
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] public STRING sDateStamp=ModifyDate(0,sDateFormat)
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //Global Functions
	[ ] 
	[ ] // ==========================================================
	[+] // FUNCTION: SelectAccountListOption()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This function selects/deselects  the required option from the option dropdown menu in account list 
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		STRING 	sOptionName		Navigates to Option required from Account list (e.g. "Include additional info when printing" etc) 
		[ ] //						STRING      sAction                    Select or Deselect 
		[ ] //
		[ ] // RETURNS:			INTEGER	PASS	If option is selected
		[ ] //									FAIL	If option is not selected
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	 Oct 26, 2012	Dean Paes  created
	[ ] // ==========================================================
	[+] public INTEGER SelectAccountListOption(STRING sOptionName,STRING sAction)
		[+] // Variable declaration
			[ ] INTEGER iCounter,irowcount,iFunctionResult
			[ ] 
		[ ] 
		[+] do
			[ ] 
			[+] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[+] if(AccountList.Exists(5))
					[ ] AccountList.SetActive () 
					[ ] AccountList.Options.Click()
				[+] else
					[ ] QuickenWindow.Tools.Click()
					[ ] QuickenWindow.Tools.AccountList.Select()
					[ ] AccountList.Options.Click()
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] if(sAction=="Select")
					[ ] 
					[+] switch(sOptionName)
						[+] case "Include additional info when printing"
							[+] if(AccountList.Options.IncludeAdditionalInfoWhenPrinting.IsChecked()==FALSE)
								[ ] AccountList.Options.IncludeAdditionalInfoWhenPrinting.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
							[ ] 
						[+] case "Show net worth in Account Bar"
							[+] if(AccountList.Options.ShowNetWorthInAccountBar.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowNetWorthInAccountBar.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show ending balance in Account Bar"
							[+] if(AccountList.Options.ShowEndingBalanceInAccountBar.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowEndingBalanceInAccountBar.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Payments to Send"
							[+] if(AccountList.Options.ShowPaymentsToSend.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowPaymentsToSend.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Checks to Print"
							[+] if(AccountList.Options.ShowChecksToPrint.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowChecksToPrint.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Number of Transactions"
							[+] if(AccountList.Options.ShowNumberOfTransactions.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowNumberOfTransactions.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Description"
							[+] if(AccountList.Options.ShowDescription.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowDescription.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Financial Institution"
							[+] if(AccountList.Options.ShowFinancialInstitution.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowFinancialInstitution.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Current Balance"
							[+] if(AccountList.Options.ShowCurrentBalance.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowCurrentBalance.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Ending Balance"
							[+] if(AccountList.Options.ShowEndingBalance.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowEndingBalance.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Transaction Download Status"
							[+] if(AccountList.Options.ShowTransactionDownloadStatus.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowTransactionDownloadStatus.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Online Bill Pay Status"
							[+] if(AccountList.Options.ShowOnlineBillPayStatus.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowOnlineBillPayStatus.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Last Reconcile Date"
							[+] if(AccountList.Options.ShowLastReconcileDate.IsChecked()==FALSE)
								[ ] AccountList.Options.ShowLastReconcileDate.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] default
							[ ] ReportStatus("Select Option",FAIL,"Option not found in list")
							[ ] iFunctionResult=FAIL
						[ ] 
				[+] else if(sAction=="Deselect")
					[ ] 
					[+] switch(sOptionName)
						[+] case "Include additional info when printing"
							[+] if(AccountList.Options.IncludeAdditionalInfoWhenPrinting.IsChecked()==TRUE)
								[ ] AccountList.Options.IncludeAdditionalInfoWhenPrinting.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
							[ ] 
						[+] case "Show net worth in Account Bar"
							[+] if(AccountList.Options.ShowNetWorthInAccountBar.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowNetWorthInAccountBar.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show ending balance in Account Bar"
							[+] if(AccountList.Options.ShowEndingBalanceInAccountBar.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowEndingBalanceInAccountBar.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Payments to Send"
							[+] if(AccountList.Options.ShowPaymentsToSend.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowPaymentsToSend.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Checks to Print"
							[+] if(AccountList.Options.ShowChecksToPrint.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowChecksToPrint.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Number of Transactions"
							[+] if(AccountList.Options.ShowNumberOfTransactions.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowNumberOfTransactions.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Description"
							[+] if(AccountList.Options.ShowDescription.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowDescription.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Financial Institution"
							[+] if(AccountList.Options.ShowFinancialInstitution.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowFinancialInstitution.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Current Balance"
							[+] if(AccountList.Options.ShowCurrentBalance.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowCurrentBalance.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Ending Balance"
							[+] if(AccountList.Options.ShowEndingBalance.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowEndingBalance.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Transaction Download Status"
							[+] if(AccountList.Options.ShowTransactionDownloadStatus.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowTransactionDownloadStatus.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Online Bill Pay Status"
							[+] if(AccountList.Options.ShowOnlineBillPayStatus.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowOnlineBillPayStatus.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] case "Show Last Reconcile Date"
							[+] if(AccountList.Options.ShowLastReconcileDate.IsChecked()==TRUE)
								[ ] AccountList.Options.ShowLastReconcileDate.Click()
							[+] else
								[ ] AccountList.TypeKeys(KEY_ESC)
							[ ] iFunctionResult=PASS
						[+] default
							[ ] ReportStatus("Select Option",FAIL,"Option not found in list")
							[ ] iFunctionResult=FAIL
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Select account list option",FAIL,"Wrong option")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Select Option",FAIL,"Quicken Main Window not found")
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] iFunctionResult = FAIL
		[ ] return iFunctionResult
		[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# Open Account List ##############################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_AccountListOpen()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will open the account list.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if account list opens without any errors						
		[ ] // 							Fail	if account list does not open or an error occurs
		[ ] //							Abort	if data file with same name already exists
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] //   27/09/2012
	[ ] // ********************************************************
[+] testcase Test01_OpenAccountList()  appstate QuickenBaseState
	[ ] 
	[+] //Variable definition
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] 
	[ ] 
	[ ] // Create Data File
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ",PASS, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] SwitchManualBackupOption("OFF")
		[ ] 
		[ ] //Add Checking Account with Business Intent===================================================
		[ ] 
		[ ] // Quicken is launched then Add Business Account
		[ ] // Add Business Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[6])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] //Open Account List=======================================================================
			[ ] //From Tools Menu
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[+] if (AccountList.Exists(10))
					[ ] ReportStatus("Account List ", PASS, "Account List  opened successfully from Tools menu.")
					[ ] //Close Account List
					[ ] AccountList.Close()
					[ ] WaitForState(AccountList,FALSE,5)
			[+] else 
				[ ] ReportStatus("Account List ", FAIL, "Account List  not opened from Tools menu.")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Open Account List Using shortcut Keys
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys("<Ctrl-a>")
			[+] if (AccountList.Exists(10))
				[ ] ReportStatus("Account List ",PASS, "Account List  opened using shortcut keys.")
				[ ] //Close Account List
				[ ] AccountList.Close()
				[ ] WaitForState(AccountList,FALSE,5)
			[+] else 
				[ ] ReportStatus("Account List ",FAIL , "Account List  not opened using shortcut keys.")
			[ ] //=======================================================================================
			[ ] 
			[ ] 
			[ ] //Open Single Purpose Account list=============================================================	
			[ ] //From Business Tab
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.Business.Click()
			[ ] QuickenMainWindow.QWNavigator.CashFlow.Click()
			[ ] MDIClient.Business.SelectAccounts.Click()
			[+] if (AccountList.Exists(10))
				[ ] ReportStatus("Account List ", PASS, "Single Purpose Account List opened successfully from Business Tab.")
				[ ] 
				[ ] //Close Account List
				[ ] AccountList.Close()
				[ ] WaitForState(AccountList,FALSE,5)
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Account List ", FAIL, "Single Purpose Account List not opened from Business Tab.")
			[ ] //=======================================================================================
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] //=====================================================================================
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Error during data file creation")
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# AccountListUi ###################################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_AccountListUI()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify the account list UI.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	If all required columns are present in account list.					
		[ ] // 							Fail	If any columns are missing in account list.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] //  04/10/2012
	[ ] // ********************************************************
[+] testcase Test02_AccountListUI() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER  iAddTransaction,iOptionSelect,icount,icount2,i=1,iValue
		[ ] LIST OF STRING lsTitle,lsTransactionData
		[ ] LIST OF STRING lsTitle2 = {"Show Checks to Print","Show Number of Transactions","Show Payments to Send" }
		[ ] 
		[ ] STRING sOnlineBillPay="Show Online Bill Pay Status"
		[ ] 
		[ ] 
	[ ] 
	[+] //Variable Definition
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sCheckingTransactionWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsTransactionData=lsExcelData[1]
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountTitle)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsTitle=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Customizing account list by adding Check to Print ================================================
		[ ] 
		[ ] // Add multiple Payment Transactions to Checking account
		[ ] UsePopUpRegister("OFF")
		[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BUSINESS)
		[+] while(i<4)
			[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDateStamp,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9])
			[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
			[ ] i++
			[ ] 
		[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] 
		[ ] //Open Account List========================================================================
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Tools.Click()
		[ ] QuickenWindow.Tools.AccountList.Select()
		[+] if (AccountList.Exists(10))
			[ ] ReportStatus("Account List ", PASS, "Account List  opened from tools menu.")
			[ ] 
		[+] else 
			[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] 
		[ ] //Customizing account list by adding additonal columns===============================================
		[ ] 
		[ ] //Select "Show Online Payment Status"
		[ ] iOptionSelect=SelectAccountListOption(sOnlineBillPay,sSelectAction)
		[ ] ReportStatus("Select Option", iOptionSelect, "Select option Online Bill Pay from Options Dropdown menu")
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] //Retrieve First account details from Account List===================================================
		[ ] 
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)		// Open Account List for verification
		[+] if(iNavigate == PASS)
			[ ] bExist = AccountList.Exists(10)
			[+] if(bExist== TRUE)
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] //Matching values in Data sheet and account list===================================================
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountUIWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[+] for (icount = 1; icount <6 ; icount++) 
			[ ] 
			[+] if(icount==5)
				[ ] lsAddAccount[icount]=substr(lsAddAccount[icount],1,5)
				[ ] 
			[ ] 
			[+] if(MatchStr("*{lsAddAccount[icount]}*", sActual))
				[ ] ReportStatus("Validate Account List UI",PASS," '{lsTitle[icount]}' Column matched")
			[+] else
				[ ] ReportStatus("Validate Account List UI",FAIL," '{lsTitle[icount]}' Column not matched")                                           
		[ ] 
		[ ] //========================================================================================
		[ ] 
		[ ] 
		[ ] //Verification of Columns added through options menu===================================================
		[ ] 
		[ ] //Select "Show Check to Print"
		[ ] iOptionSelect=SelectAccountListOption(lsTitle2[1],sSelectAction)
		[ ] ReportStatus("Select Option", iOptionSelect, "Select option 'Checks to print' from Options Dropdown menu")
		[ ] 
		[ ] //Select "Show  No. of Transactions"
		[ ] iOptionSelect=SelectAccountListOption(lsTitle2[2],sSelectAction)
		[ ] ReportStatus("Select Option", iOptionSelect, "Select option 'Show  No. of Transactions' from Options Dropdown menu")
		[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] 
		[ ] //Close Quicken and Restart==================================================================
		[ ] 
		[ ] //Close Account list
		[ ] AccountList.Close()
		[ ] WaitForState(AccountList,FALSE,10)
		[ ] 
		[ ] 
		[ ] 
		[ ] //Restart Quicken
		[ ] START:
		[ ] QuickenWindow.Close()
		[ ] CloseMobileSyncInfoPopup()
		[ ] WaitForState(QuickenWindow,FALSE,10)
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow,TRUE,10)
		[+] if (!QuickenMainWindow.Exists(5))
			[ ] goto START
		[ ] 
		[ ] 
		[ ] //========================================================================================
		[ ] 
		[ ] 
		[ ] //Retrieve First account details from Account List====================================================
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)		// Open Account List for verification
		[+] if(iNavigate == PASS)
			[ ] bExist = AccountList.Exists(10)
			[+] if(bExist== TRUE)
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] //Matching values in Data sheet and account list===================================================
		[ ] 
		[ ] //Verify if options are checked 
		[ ] AccountList.SetActive()
		[ ] AccountList.Options.Click()
		[+] if(AccountList.Options.ShowChecksToPrint.IsChecked() && AccountList.Options.ShowNumberOfTransactions.IsChecked())
			[ ] ReportStatus("Verify if options are checked",PASS,"Options are checked after Quicken is closed and reopened")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if options are checked",FAIL,"Options are not checked after Quicken is closed and reopened")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // "Checks to Print" and "Number of Transactions"  options are checked
		[+] for (icount = 6; icount < 8 ; icount++) 
			[ ] 
			[ ] iValue = val(lsAddAccount[icount])
			[ ] 
			[ ] 
			[+] if(MatchStr("*{iValue}*" , sActual))
				[ ] ReportStatus("Validate Account List UI",PASS," Selected column '{lsTitle[icount]}' displayed")
			[+] else
				[ ] ReportStatus("Validate Account List UI",FAIL,"  Selected Column '{lsTitle[icount]}' is not displayed")                                             
		[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] //DESELECT  OPTIONS==========================================================================
		[ ] 
		[ ] //Verification of Columns added through options menu===================================================
		[ ] 
		[ ] //DeSelect "Show Check to Print"
		[ ] iOptionSelect=SelectAccountListOption(lsTitle2[1],sDeSelectAction)
		[ ] ReportStatus("unselect Option", iOptionSelect, "Unselect option 'Checks to print' from Options Dropdown menu")
		[ ] 
		[ ] //DeSelect "Show  No. of Transactions"
		[ ] iOptionSelect=SelectAccountListOption(lsTitle2[2],sDeSelectAction)
		[ ] ReportStatus("Unselect Option", iOptionSelect, "Unselect option 'Show  No. of Transactions' from Options Dropdown menu")
		[ ] 
		[ ] //=======================================================================================
		[ ] //Retrieve First account details from Account List====================================================
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)		// Open Account List for verification
		[+] if(iNavigate == PASS)
			[ ] bExist = AccountList.Exists(10)
			[+] if(bExist== TRUE)
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] //Matching values in Data sheet and account list===================================================
		[ ] 
		[ ] // "Checks to Print" and "Number of Transactions"  options are checked
		[ ] 
		[+] for (icount = 6; icount < 8 ; icount++) 
			[ ] 
			[ ] iValue = val(lsAddAccount[icount])
			[ ] 
			[ ] 
			[+] if(MatchStr("*{iValue}*" , sActual))
				[ ] ReportStatus("Validate Account List UI",FAIL,"  Selected Column '{lsTitle[icount]}' is displayed") 
			[+] else
				[ ] ReportStatus("Validate Account List UI",PASS," Selected column '{lsTitle[icount]}' is not displayed")                                     
		[ ] 
		[ ] 
		[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] //Close Account List
		[ ] AccountList.Close()
		[ ] WaitForState(AccountList,FALSE,10)
		[ ] 
		[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# SinglePurposeAccountListUi #######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_SinglePurposeAccountListUI()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify the UiCountof a single purpose account list .
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	If all required columns are present in Single purpose account list.					
		[ ] // 							Fail	If any columns are missing in Single purpose account list.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] //  28 /09/2012
	[ ] // ********************************************************
[+] testcase Test03_SinglePurposeAccountListUI() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile
		[ ] LIST OF STRING lsSinglePurpose,lsSinglePurposeTitle
		[ ] 
	[ ] START:
	[+] if(QuickenMainWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Open Single Purpose Account list============================================================
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.Business.Click()
		[ ] QuickenMainWindow.QWNavigator.Business.Click()
		[+] if(!QuickenMainWindow.QWNavigator.CashFlow.Exists(5))
			[ ] QuickenMainWindow.QWNavigator.Business.Click()
			[ ] 
		[ ] QuickenMainWindow.QWNavigator.CashFlow.Click()
		[ ] MDIClient.Business.SelectAccounts.Click()
		[+] if (AccountList.Exists(2))
			[ ] ReportStatus("Account List ", PASS, "Single Purpose Account List  opened from Business Tab.")
		[+] else 
			[ ] ReportStatus("Account List ", FAIL, "Single Purpose  not opened.")
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet=================================================================
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountSinglePurpose)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsSinglePurposeTitle=lsExcelData[1]
		[ ] //=======================================================================================
		[ ] 
		[ ] // Read data from excel sheet=================================================================
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountSinglePurpose)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsSinglePurpose=lsExcelData[2]
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Retrieve values of Single Purpose account list====================================================
		[ ] 
		[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
		[ ] 
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
		[ ] 
		[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] 
		[ ] //Verification of Columns=====================================================================
		[+] for (i = 1; i < 3 ; i++) 
			[ ] 
			[+] if(MatchStr("*{lsSinglePurpose[i]}*" , sActual))
				[ ] ReportStatus("Validate Account List UI",PASS," Selected column '{lsSinglePurposeTitle[i]}' displayed")
			[+] else
				[ ] ReportStatus("Validate Account List UI",FAIL,"  Selected Column '{lsAddAccount[i]}' is not displayed")                                             
		[ ] 
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] //Close Account List
		[ ] AccountList.Close()
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] //ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
		[ ] QuickenWindow.Close()
		[ ] WaitForState(QuickenWindow,FALSE,10)
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow,TRUE,10)
		[ ] goto START
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# Account List Tab Name ##########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_AccountListTabName()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if accounts under all other Tabs are displayed under "All Accounts" Tab in account list.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	Accounts are present under "All Accounts" Tab .				
		[ ] // 							Fail	      All or some accounts are not displayed under "All Accounts" Tab.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] //  03/01/2013
	[ ] // ********************************************************
[+] testcase Test04_AccountListTabName() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER i=0
		[ ] STRING sBrokerage ="Brokerage01"
		[ ] STRING sOperatiion = "Delete"
		[ ] //STRING sFileName="AccountListFI"
		[ ] //////{"1","50","54","35","42","46","31"}            
		[ ] // List of String specifies the line/location of each account under All Accounts Tab 
		[ ] LIST OF STRING lsAllAccountsLines= {"1","54","58","39","46","35","31"}
		[ ] 
		[ ] LIST OF STRING lsAllAccounts ,lsAllAccountsName
		[ ] STRING sAccountLine
	[ ] 
	[+] if (QuickenWindow.Exists(10))
		[ ] 
		[ ] // Open Data File
		[ ] iOpenDataFile = OpenDataFile(sFIFileName)
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFIFileName} is opened")
			[ ] 
			[ ] //Open Account List===============================================================
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] 
			[ ] 
			[+] if (AccountList.Exists(10))
				[ ] ReportStatus("Account List ", PASS, "Account List  opened from tools menu.")
				[ ] 
				[ ] 
				[ ] 
				[ ] //Check if Accounts Listed under all tabs ===================================================
				[ ] 
				[ ] AccountList.SetActive()
				[ ] 
				[ ] //Read Data under Personal Banking Tab
				[ ] AccountList.QWinChild.PersonalBanking.Click()
				[ ] //sHandle = Str(Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())	
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] ListAppend ( lsAllAccounts,sActual)
				[ ] ListAppend (lsAllAccountsName,"Personal Banking")
				[ ] i++
				[ ] 
				[ ] //Read Data under Personal Investments Tab
				[ ] AccountList.QWinChild.PersonalInvestments.Click()
				[ ] //sHandle = Str(Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())	
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] ListAppend ( lsAllAccounts,sActual)
				[ ] ListAppend (lsAllAccountsName,"Personal Investments")
				[ ] i++
				[ ] 
				[ ] 
				[ ] //Read Data under Personal NetWorth Tab
				[ ] AccountList.QWinChild.PersonalNetWorth.Click()
				[ ] //sHandle = Str(Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())	
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] ListAppend ( lsAllAccounts,sActual)
				[ ] ListAppend (lsAllAccountsName,"Personal Net Worth")
				[ ] i++
				[ ] 
				[ ] 
				[ ] //Read Data under Business Banking Tab
				[ ] AccountList.QWinChild.BusinessBanking.Click()
				[ ] //sHandle = Str(Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())	
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] ListAppend ( lsAllAccounts,sActual)
				[ ] ListAppend (lsAllAccountsName,"Business Banking")
				[ ] i++
				[ ] 
				[ ] 
				[ ] //Read Data under Business Investments Tab
				[ ] AccountList.QWinChild.BusinessInvestments.Click()
				[ ] //sHandle = Str(Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())	
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] ListAppend ( lsAllAccounts,sActual)
				[ ] ListAppend (lsAllAccountsName,"Business Investments")
				[ ] i++
				[ ] 
				[ ] 
				[ ] //Read Data under Business Net Worth Tab
				[ ] AccountList.QWinChild.BusinessNetWorth.Click()
				[ ] //sHandle = Str(Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())	
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] ListAppend ( lsAllAccounts,sActual)
				[ ] ListAppend (lsAllAccountsName,"Business Net Worth")
				[ ] i++
				[ ] 
				[ ] 
				[ ] //Read Data under Rental Property Tab if using RPM
				[+] if(AccountList.QWinChild.RentalProperty.Exists(10))
					[ ] AccountList.QWinChild.RentalProperty.Click()
					[ ] //sHandle = Str(Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())	
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
					[ ] ListAppend ( lsAllAccounts,sActual)
					[ ] ListAppend (lsAllAccountsName,"Rental Property")
					[ ] i++
				[ ] 
				[ ] 
				[ ] // 
				[ ] // print(lsAllAccountsLines)
				[ ] // print(lsAllAccounts)
				[ ] // print(lsAllAccountsName)
				[ ] 
				[ ] 
				[ ] //Compare if accounts listed in all tabs are present in All Accounts Tab
				[ ] AccountList.SetActive()
				[ ] AccountList.QWinChild.AllAccounts.Click()
				[ ] //sHandle = Str(Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())	
				[ ] 
				[ ] // 
				[+] while(i>0)
					[ ] 
					[+] // for(j=64;j>=1;j--)
						[ ] // //sAccountLine=lsAllAccountsLines[i]
						[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(j))
						[ ] // //sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, sAccountLine)
						[ ] // bMatch=MatchStr("*{lsAllAccounts[i]}*", sActual)
						[+] // if(bMatch==TRUE)
							[ ] // ReportStatus("Verify Account List Status",PASS,"Accounts under '{lsAllAccountsName[i]}'  are displayed under All Accounts Tab.")
							[ ] // break
						[ ] // 
					[+] // if(bMatch==FALSE)
						[ ] // ReportStatus("Account Intent ",FAIL, "Account {lsAllAccounts[i]} under tab '{lsAllAccountsName[i]}' does not match with actual {sActual}.")
						[ ] // 
						[ ] // 
					[ ] 
					[ ] sAccountLine=lsAllAccountsLines[i]
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, sAccountLine)
					[ ] bMatch=MatchStr("*{lsAllAccounts[i]}*", sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Account List Status",PASS,"Accounts under '{lsAllAccountsName[i]}'  are displayed under All Accounts Tab.")
					[+] else
						[ ] ReportStatus("Account Intent ",FAIL, "Account {lsAllAccounts[i]} under tab '{lsAllAccountsName[i]}' does not match with actual {sActual}.")
					[ ] 
					[ ] i--
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] AccountList.Close()
				[ ] WaitForState(AccountList,FALSE,5)
				[ ] 
			[+] else 
				[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
			[ ] //============================================================================
		[+] else
			[ ] ReportStatus("Open Data File ", FAIL, "Data file -  {sFIFileName} is not opened")
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
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# Account List Help ###############################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_AccountList_Help()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will open the Help menu from Account List and Single Purpose Account List.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	 If Help opens from all Account List and Single Purpose account List.						
		[ ] // 							Fail	       If Help does not open from account list or any other error occurs.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 02/01/2013
	[ ] // ********************************************************
[+] testcase Test05_AccountList_Help() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Open Data File
		[ ] iOpenDataFile = OpenDataFile(sFileName)
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sFileName} is opened")
			[ ] 
			[ ] 
			[ ] //Access Help from Account List 
			[ ] //Open Account List========================================================================
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] //AccountList.QWinChild.Order.ListBox.Click()
			[+] if (AccountList.Exists(10))
				[ ] ReportStatus("Account List ", PASS, "Account List  opened.")
				[ ] 
				[ ] //Verify if help menu is opened================================================================
				[ ] AccountList.HelpButton.Click()
				[ ] 
				[ ] //QuickenHelp 
				[+] if (QuickenHelp.Exists(10))
						[ ] ReportStatus("Help menu", PASS, "Help menu opened.")
						[ ] 
						[ ] //Close Help Menu=========================================================================
						[ ] QuickenHelp.Close()
						[ ] WaitForState(QuickenHelp,FALSE,5)
						[ ] //=======================================================================================
						[ ] 
						[ ] //Close Account List=========================================================================
						[ ] AccountList.Close()
						[ ] WaitForState(AccountList,FALSE,5)
						[ ] //=======================================================================================
						[ ] 
						[ ] 
						[ ] 
				[+] else 
						[ ] ReportStatus("Help menu",FAIL , "Help menu not opened.")
				[ ] //=======================================================================================
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
			[ ] //=======================================================================================
			[ ] 
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] //Access Help from Single purpose Account List
			[ ] //Open Single Purpose Account list============================================================
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.Business.Click()
			[+] if(!QuickenMainWindow.QWNavigator.CashFlow.Exists(10))
				[ ] QuickenMainWindow.QWNavigator.Business.Click()
				[ ] 
				[ ] 
			[ ] 
			[ ] QuickenMainWindow.QWNavigator.CashFlow.Click()
			[ ] MDIClient.Business.SelectAccounts.Click()
			[+] if (AccountList.Exists(10))
				[ ] ReportStatus("Account List ", PASS, "Single Purpose Account List  opened from Business Tab.")
				[ ] 
				[ ] //Open Single Purpose Account Help
				[ ] 
				[ ] //Verify if help menu is opened================================================================
				[ ] AccountList.HelpButton.Click()
				[ ] 
				[ ] //QuickenHelp 
				[+] if (QuickenHelp.Exists(10))
						[ ] ReportStatus("Help menu", PASS, "Help menu opened.")
						[ ] 
						[ ] //Close Help Menu=========================================================================
						[ ] QuickenHelp.Close()
						[ ] //=======================================================================================
						[ ] 
						[ ] //Close Account List=========================================================================
						[ ] AccountList.Close()
						[ ] //=======================================================================================
						[ ] 
				[+] else 
						[ ] ReportStatus("Help menu",FAIL , "Help menu not opened.")
				[ ] //=======================================================================================
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Account List ", FAIL, "Single Purpose  not opened.")
			[ ] //=======================================================================================
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Data File ", FAIL, "Data file -  {sFileName} is not opened")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# Single Account Tab ###############################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_SingleAccountTab()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify that Tab is not displayed in Account List if only a single account(Banking) is added in Quicken..
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	 If Tab is not displayed in account List.						
		[ ] // 							Fail	       If Tab is displayed in account List..
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 02/01/2013
	[ ] // ********************************************************
[+] testcase Test06_SingleAccountTab() appstate none
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //Open Account List
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Tools.Click()
		[ ] QuickenWindow.Tools.AccountList.Select()
		[ ] 
		[ ] 
		[ ] //AccountList.QWinChild.Order.ListBox.Click()
		[+] if (AccountList.Exists(5))
				[ ] ReportStatus("Account List ", PASS, "Account List  opened.")
				[ ] 
				[+] if (AccountList.QWinChild.AllAccounts.Exists(5))
						[ ] ReportStatus("Account List ",FAIL,"Error: Tab is displayed .")
						[ ] 
						[ ] AccountList.Close()
						[ ] WaitForState(AccountList,FALSE,5)
						[ ] 
				[+] else 
						[ ] ReportStatus("Account List ", PASS , "Tab is not displayed for single type of  account." )
				[ ] 
				[ ] 
		[+] else 
			[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
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
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# AllAccountTypes ################################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test07_MultipleAccountTypes()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if all accounts created are displayed under respective tabs as well as all accounts when account register is  opened.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    All accounts created are displayed under respective tabs as well as all accounts				
		[ ] // 							Fail	     All accounts created are not displayed under respective tabs as well as all accounts.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 03/10/2012
	[ ] // ********************************************************
[+] testcase Test07_MultipleAccountTypes() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile
	[ ] 
	[ ] // Create Data File
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if (iCreateDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is Created")
		[ ] 
		[ ] //CREATING CHECKING ACCOUNT=============================================================
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[5]="BUSINESS"
		[ ] 
		[ ] 
		[ ] // Quicken is launched then Add Checking Account
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] //Open Account List
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] 
			[ ] 
			[ ] // AccountList.QWinChild.Order.ListBox.Click()
			[+] if (AccountList.Exists(5))
					[ ] ReportStatus("Account List ", PASS, "Account List  opened.")
					[ ] 
					[ ] //Close Account List
					[ ] AccountList.Close()
					[ ] WaitForState(AccountList,FALSE,5)
					[ ] 
					[ ] 
			[+] else 
				[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] //=======================================================================================
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //CREATING SECOND CHECKING ACCOUNT===========================================================
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountWorksheet)
		[ ] // Fetch 6th row from the given sheet
		[ ] lsAddAccount=lsExcelData[6]
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] //Open Account List
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] 
			[ ] 
			[ ] 
			[ ] //AccountList.QWinChild.Order.ListBox.Click()
			[+] if (AccountList.Exists(5))
					[ ] ReportStatus("Account List ", PASS, "Account List  opened.")
					[ ] 
					[ ] 
					[+] if (AccountList.QWinChild.PersonalBanking.Exists(2))
							[ ] ReportStatus("Verify if Account List Tabs are displayed",PASS,"Tabs are displayed for same account type with different Intents.")
							[ ] 
							[ ] //Close Account List
							[ ] AccountList.Close()
							[ ] WaitForState(AccountList,FALSE,5)
							[ ] 
					[+] else 
							[ ] ReportStatus("Verify if Account List Tabs are displayed",FAIL,"Tabs are displayed for same account type with different Intents.")
					[ ] 
					[ ] 
					[ ] 
			[+] else 
				[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] //==========================================================================
		[ ] 
		[ ] sleep(3)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // CREATING BROKERAGE ACCOUNT============================================
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountWorksheet)
		[ ] // Fetch 4th row from the given sheet
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] // Quicken is launched then Add Brokerage Account
		[ ] UsePopupRegister("OFF")
		[ ] 
		[ ] // Add Investment Accounts
		[ ] iAddAccount = AddManualBrokerageAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
		[ ] // ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[2]} is created successfully")
		[+] if(iAddAccount==PASS)
			[ ] //Open Account List
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] 
			[ ] 
			[ ] // AccountList.QWinChild.Order.ListBox.Click()
			[+] if (AccountList.Exists(2))
				[ ] ReportStatus("Account List ", PASS, "Account List  opened.")
				[ ] 
				[+] if (AccountList.QWinChild.PersonalInvestments.Exists(5))
						[ ] ReportStatus("Account List ",PASS, "Tab is displayed for Investment accounts.")
						[ ] 
						[ ] //Close Account List
						[ ] AccountList.Close()
						[ ] 
						[ ] 
				[+] else 
						[ ] ReportStatus("Account List ", FAIL , "Tab is not displayed for Investment accounts." )
				[ ] 
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
		[+] else
			[ ] ReportStatus("Add a Brokerage Account", FAIL, "Brokerage Account not added.")
			[ ] 
		[ ] //============================================================================
		[ ] 
		[ ] sleep(3)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // CREATING BUSINESS ACCOUNT=================================================
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountWorksheet)
		[ ] // Fetch 7th row from the given sheet
		[ ] lsAddAccount=lsExcelData[7]
		[ ] 
		[ ] //Adding business account
		[ ] iAddAccount=AddBusinessAccount(lsAddAccount[1], lsAddAccount[2])
		[+] if(iAddAccount==PASS)
			[ ] 
			[ ] 
			[ ] //Open Account List
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] 
			[ ] 
			[ ] // AccountList.QWinChild.Order.ListBox.Click()
			[+] if (AccountList.Exists(2))
				[ ] ReportStatus("Account List ", PASS, "Account List  opened.")
				[ ] 
				[+] if (AccountList.QWinChild.BusinessNetWorth.Exists(5))
					[ ] ReportStatus("Account List ",PASS, "Tab is displayed for Business accounts.")
					[ ] 
					[ ] //Close Account List
					[ ] AccountList.Close()
					[ ] 
					[ ] 
					[ ] 
				[+] else 
						[ ] ReportStatus("Account List ", FAIL , "Tab is not displayed for business accounts." )
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
		[+] else
			[ ] ReportStatus("Adding business account",FAIL,"Add business account to Quicken")
			[ ] 
		[ ] //============================================================================
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# DeleteAccountTab ################################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test08_DeleteAccountTab()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if the tab is still displayed for account once account is deleted.Also
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    All accounts created are displayed under respective tabs as well as all accounts				
		[ ] // 							Fail	     All accounts created are not displayed under respective tabs as well as all accounts.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 03/10/2012
	[ ] // ********************************************************
[+] testcase Test08_DeleteAccountTab() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iSelect
		[ ] STRING sBrokerage="Brokerage 01"
		[ ] BOOLEAN bMatch
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // DELETING BROKERAGE ACCOUNT==================================================
		[ ] 
		[ ] //Select Checking account
		[ ] 
		[ ] iSelect=SelectAccountFromAccountBar(sBrokerage,ACCOUNT_INVESTING)
		[+] if (iSelect == PASS)
			[ ] iAction = ModifyAccount(sWindowTypeMDI, sBrokerage, "Delete")		// Delete account
			[+] if(iAction == PASS)
				[ ] ReportStatus("Validate Account Action", PASS, "{sBrokerage} Account deleted successfully")
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] //Open Account List
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.AccountList.Select()
				[ ] 
				[+] if (AccountList.Exists(5))
						[ ] ReportStatus("Account List ", PASS, "Account List  opened.")
						[ ] 
						[ ] //Verify if Account is present in Account List
						[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
						[ ] bMatch=FALSE
						[+] for(i=1;i<=14;i++)
							[ ] 
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{i}" )
							[+] if(MatchStr(sBrokerage,sActual))
								[ ] bMatch=TRUE
								[ ] 
							[ ] 
							[ ] 
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Account List ",FAIL, "Deleted Account is displayed in Account list.")
							[ ] 
						[+] else
							[ ] ReportStatus("Account List ",PASS, "Deleted Account is not displayed in Account list.")
						[ ] 
						[ ] //Close Account List
						[ ] AccountList.Close()
						[ ] WaitForState(AccountList,FALSE,5)
						[ ] 
						[ ] 
						[ ] 
						[ ] 
				[+] else 
					[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
					[ ] 
					[ ] 
				[ ] //===========================================================================
				[ ] 
				[ ] //Verify if tab is displayed in Single purpose Account List====================================
				[ ] 
				[ ] //Open Single Purpose Account list
				[ ] QuickenWindow.SetActive()
				[ ] QuickenMainWindow.QWNavigator.Business.Click()
				[+] if(!QuickenMainWindow.QWNavigator.CashFlow.Exists(10))
					[ ] QuickenMainWindow.QWNavigator.Business.Click()
				[ ] QuickenMainWindow.QWNavigator.CashFlow.Click()
				[ ] MDIClient.Business.SelectAccounts.Click()
				[+] if (AccountList.Exists(5))
					[ ] ReportStatus("Account List ", PASS, "Single Purpose Account List  opened from Business Tab.")
					[ ] 
					[ ] 
					[ ] //Verify if Account is present in SIngle Purpose Account List
					[ ] // Quicken2012Popup.ChooseCategory.AllAccount.Click()
					[ ] AccountList.QWinChild.AllAccounts.Click()
					[ ] 
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
					[ ] //QWListViewer.CategoryList.GetHandle ())
					[ ] bMatch=FALSE
					[+] for(i=1;i<=14;i++)
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{i}" )
						[+] if(MatchStr(sBrokerage,sActual))
							[ ] bMatch=TRUE
							[ ] 
						[ ] 
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Account List ",FAIL, "Deleted Account is displayed in Account list.")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Account List ",PASS, "Deleted Account is not displayed in Account list.")
					[ ] 
					[ ] //Close Account List
					[ ] AccountList.Close()
					[ ] WaitForState(AccountList,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
				[+] else 
					[ ] ReportStatus("Account List ", FAIL, "Single Purpose  not opened.")
				[ ] 
				[ ] //=============================================================================
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Action", FAIL, "{sBrokerage} Account is not deleted")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select brokerage account",FAIL,"Brokerage account not selected")
			[ ] 
		[ ] 
		[ ] //================================================================================
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# Open Register #################################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test09_OpenRegister() 
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if account register opens when we click on account name in account list.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	Account register opens when we click on account name in account list.				
		[ ] // 							Fail	Account register does not  open when we click on account name in account list..
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 06/10/2012
	[ ] // ********************************************************
[+] testcase Test09_OpenRegister() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
		[ ] STRING sAccountName="Checking 01"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Open Account list
		[ ] QuickenWindow.TypeKeys("<Ctrl-a>")
		[+] if (AccountList.Exists(10))
			[ ] ReportStatus("Account List ",PASS, "Account List  opened.")
			[ ] 
			[ ] //Open Account Register
			[ ] //AccountList.QWinChild.Order.ListBox.Click(1,39,50)
			[ ] AccountList.QWinChild.Order.ListBox.TextClick(sAccountName)
			[ ] 
			[ ] 
			[+] if(QuickenMainWindow.QWNavigator1.AccountName.GetText()==sAccountName)
				[ ] ReportStatus("Account List ", PASS, "Account Register opened successfully.")
			[+] else
				[ ] ReportStatus("Account List ", FAIL, "Account Reigster did not open.")
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Account List ",FAIL , "Account List  not opened.")
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
[ ] //############################################################################################
[ ] 
[ ] // // 
[+] // // ############# PrintAccountList ###############################################################              
	[ ] // // ********************************************************
	[+] // // TestCase Name:	Test08_PrintAccountList()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This testcase will verify Print functionality from account register..
		[ ] // // 
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass    Print menu opens successfully when we click on Print button in Account register.				
		[ ] // // Fail	Print menu does not opens successfully when we click on Print button in Account register.
		[ ] // // 
		[ ] // // 
		[ ] // // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // // 12/10/2012
	[ ] // // ********************************************************
[+] // // // testcase Test10_PrintAccountList()appstate none
	[ ] // // // 
	[ ] // // // 
	[ ] // // // 
	[+] // // // if(QuickenWindow.Exists(5))
		[ ] // // // 
		[ ] // // // QuickenWindow.SetActive()
		[ ] // // // OpenDataFile(sFIFileName)
		[ ] // // // 
		[ ] // // // 
		[ ] // // // QuickenWindow.SetActive()
		[ ] // // // QuickenWindow.Tools.Click()
		[ ] // // // QuickenWindow.Tools.AccountList.Select()
		[ ] // // // 
		[+] // // // if (AccountList.Exists(5))
			[ ] // // // ReportStatus("Account List ", PASS, "Account List  opened.")
			[ ] // // // 
			[ ] // // // 
			[ ] // // // AccountList.PrintButton.Click()
			[+] // // // if (AccountListPrint.Exists(5))
				[ ] // // // ReportStatus("Print menu", PASS, "Print menu opened.")
				[ ] // // // 
				[ ] // // // Select option "PDF" from printer dropdown menu, Change line to be selected accordingly
				[ ] // // // AccountListPrint.PrintOptionComboBox.Select(2)
				[ ] // // // AccountListPrint.Print.Click()
				[ ] // // // 
				[+] // // // if(SaveToPDFFile.Exists(5))
					[ ] // // // ReportStatus("Verify if Save to PDF dialog is launched",PASS,"Save to PDF dialog is launched")
					[ ] // // // 
					[ ] // // // SaveToPDFFile.Close()
					[ ] // // // WaitForState(SaveToPDFFile,FALSE,5)
					[ ] // // // 
					[ ] // // // AccountList.Close()
					[ ] // // // WaitForState(AccountList,FALSE,5)
					[ ] // // // 
					[ ] // // // 
					[ ] // // // 
				[+] // // // else
					[ ] // // // ReportStatus("Print Account List",FAIL,"PDF Save To PDF window not displayed")
				[ ] // // // 
				[ ] // // // 
				[ ] // // // 
			[+] // // // else 
					[ ] // // // ReportStatus("Print menu",FAIL , "Print menu not opened.")
			[ ] // // // 
			[ ] // // // 
			[ ] // // // 
			[ ] // // // 
		[+] // // // else 
			[ ] // // // ReportStatus("Account List ", FAIL, "Account List  not opened.")
		[ ] // // // 
		[ ] // // // 
		[ ] // // // 
	[+] // // // else
		[ ] // // // ReportStatus("FiCountConnection", FAIL, "Quicken is not available") 
		[ ] // // // 
	[ ] // // // 
	[ ] // // // 
[ ] // // ########################################################################################### 
[ ] // // 
[ ] 
[+] //############# EditAccountDetails ##############################################################                                      
	[ ] // ********************************************************
	[+] // TestCase Name:	Test10_EditAccountDetails()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if editing existing account details are displayed correctly under account list when account register is  opened.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    All edited account details are reflected in account register.				
		[ ] // 							Fail	All edited account details are reflected in account register.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 14/10/2012
	[ ] // ********************************************************
[+] testcase Test11_EditAccountDetails() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile
		[ ] INTEGER sMatchCancel=0
		[ ] INTEGER sMatchSave=0
		[ ] BOOLEAN bMatch
		[ ] LIST OF STRING lsAddBrokerageAccount
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(10) )
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Open Data File
		[ ] iOpenDataFile = OpenDataFile(sFileName)
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is opened")
			[ ] 
			[ ] 
			[ ] // Add Checking Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // CREATING BROKERAGE ACCOUNT==========================================================
				[ ] 
				[ ] //Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountWorksheet)
				[ ] lsAddBrokerageAccount=lsExcelData[4]
				[ ] 
				[ ] // Quicken is launched then Add Brokerage Account
				[ ] // Add Investment Accounts
				[ ] iAddAccount = AddManualBrokerageAccount(lsAddBrokerageAccount[1], lsAddBrokerageAccount[2], lsAddBrokerageAccount[3], lsAddBrokerageAccount[4],lsAddBrokerageAccount[5],lsAddBrokerageAccount[6])
				[ ] ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddBrokerageAccount[2]} is created successfully")
				[ ] //======================================================================================
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verifying Accounts have been added to Quicken=================================================
				[ ] 
				[ ] //Open Account List
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.AccountList.Select()
				[ ] 
				[ ] 
				[+] if (AccountList.QWinChild.PersonalInvestments.Exists(2))
					[ ] ReportStatus("Account List ",PASS, "Tab is displayed for Investment accounts.")
					[ ] 
					[ ] 
					[ ] 
					[ ] //Close Account List
					[ ] AccountList.Close()
					[ ] WaitForState(AccountList,FALSE,5)
					[ ] //======================================================================================
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //Open Account Details WIndow
					[ ] 
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.Click()
					[ ] 
					[ ] SelectAccountFromAccountBar(lsAddBrokerageAccount[2],ACCOUNT_INVESTING)
					[ ] 
					[ ] NavigateToAccountDetails(lsAddBrokerageAccount[2])             
					[ ] 
					[ ] 
					[ ] 
					[ ] //Cancel Delete account
					[ ] AccountDetails.DeleteAccountButton.Click()
					[ ] AccountDetails.DeleteAccount.YesField.SetText("yes")
					[ ] AccountDetails.DeleteAccount.Cancel.Click()
					[ ] 
					[+] if(AlertMessage.Exists(5))
						[ ] AlertMessage.OK.Click()
					[ ] 
					[ ] 
					[ ] //Delete account
					[ ] AccountDetails.DeleteAccountButton.Click()
					[ ] DeleteAccount.YesField.SetText("yes")
					[ ] DeleteAccount.OK.Click()
					[ ] 
					[+] if(AlertMessage.Exists(5))
						[ ] AlertMessage.OK.Click()
					[ ] 
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsExcelData=ReadExcelTable(sAccountList, sEditWorksheet)
					[ ] // Fetch 1st row from the given sheet
					[ ] IsEditAccount=lsExcelData[1]
					[ ] 
					[ ] 
					[ ] //Make changes to Edit account list and Cancel======================================================
					[ ] 
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] 
					[ ] NavigateToAccountDetails(lsAddAccount[2])  
					[ ] 
					[ ] AccountDetails.SetActive()
					[ ] AccountDetails.AccountDetails.SetText(IsEditAccount[3])
					[ ] AccountDetails.ContactName.SetText(IsEditAccount[5])
					[ ] AccountDetails.Cancel.Click()
					[ ] // QuickenRestore.Cancel.Click()
					[ ] 
					[ ] //Verify changes should get canceled
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] NavigateToAccountDetails(lsAddAccount[2])  
					[+] if(AccountDetails.AccountDetails.GetText()!=IsEditAccount[3])
						[ ] sMatchCancel++                                             
					[+] if(AccountDetails.ContactName.GetText()!=IsEditAccount[5])
						[ ] sMatchCancel++                                   
					[ ] 
					[+] if(sMatchCancel==2)
						[ ] ReportStatus("Account List ", PASS, "Edited details saved succesfully in Account Details from Account List.")    
					[+] else
						[ ] ReportStatus("Account List ", FAIL, "Edited details not saved in Account Details from Account List.")
					[ ] AccountDetails.OK.Click()
					[ ] 
					[ ] //=========================================================================================    
					[ ] 
					[ ] 
					[ ] 
					[ ] //Make changes to Edit account list and Save======================================================
					[ ] 
					[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
					[ ] NavigateToAccountDetails(lsAddAccount[2])  
					[ ] AccountDetails.AccountDetails.SetText(IsEditAccount[3])
					[ ] AccountDetails.Phone.SetText(IsEditAccount[4])
					[ ] AccountDetails.ContactName.SetText(IsEditAccount[5])
					[ ] AccountDetails.OK.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify changes should get saved=================================================================
					[ ] 
					[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
					[ ] NavigateToAccountDetails(lsAddAccount[2])   
					[+] if(AccountDetails.AccountDetails.GetText()==IsEditAccount[3])
						[ ] sMatchSave++                                             
					[+] if( AccountDetails.Phone.GetText()==IsEditAccount[4]) 
						[ ] sMatchSave++                                                       
					[+] if(AccountDetails.ContactName.GetText()==IsEditAccount[5])
						[ ] sMatchSave++                                   
					[ ] 
					[+] if(sMatchSave==3)
						[ ] ReportStatus("Account List ", PASS, "Edited details saved succesfully in Account Details from Account List.")    
					[+] else
						[ ] ReportStatus("Account List ", FAIL, "Edited details not saved in Account Details from Account List.")
					[ ] 
					[ ] //=========================================================================================    
					[ ] 
					[ ] AccountDetails.OK.Click()
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
					[ ] // 
				[+] else 
						[ ] ReportStatus("Account List ", FAIL , "Tab is not displayed for Investment accounts." )
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
				[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is not created")
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
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# AccountIntent ###################################################################                                      
	[ ] // ********************************************************
	[+] // TestCase Name:	Test11_EditAccountDetails()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if editing existing account details are displayed correctly under account list when account register is  opened.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    All edited account details are reflected in account register.				
		[ ] // 							Fail	All edited account details are reflected in account register.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 18/10/2012
	[ ] // ********************************************************
[+] testcase Test12_AccountIntent() appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iCreateDataFile
		[ ] STRING sAccountName="Checking 01"
		[ ] STRING sTab="Display Options"
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
		[ ] 
		[ ] 
		[ ] 
		[ ] //CREATING CHECKING ACCOUNT========================================
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Quicken is launched then Add Checking Account
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountTab)
			[ ] 
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] 
				[+] for(i=1;i<=5;i++)
					[ ] 
					[ ] // Read data from excel sheet
					[ ] 
					[ ] lsAddAccount=lsExcelData[i]
					[ ] 
					[ ] QuickenWindow.TypeKeys("<Ctrl-Shift-E>")
					[ ] 
					[ ] 
					[+] if(AccountDetails.Exists(10))
						[ ] AccountDetails.Click(1,252,75) 
						[ ] 
						[ ] //Change Account Intent
						[ ] AccountDetails.AccountIntent1.Select(i)
						[ ] AccountDetails.OK.Click()
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify that change of Account Intent is visible in  Account Bar as well as Account List
						[+] switch (i)
							[ ] 
							[+] case 1
								[ ] sleep(2)
								[ ] 
								[ ] //Verify changes in Account Bar
								[ ] QuickenWindow.SetActive()
								[ ] 
								[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.Banking.Exists(10))
									[ ] ReportStatus("Account Intent ",PASS, "Account Intent is changed correctly:'{lsAddAccount[1]}' ")
									[ ] 
								[+] else
									[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account Bar")
								[ ] 
								[ ] //Verify changes in Account List
								[ ] QuickenWindow.Tools.Click()
								[ ] QuickenWindow.Tools.AccountList.Select()
								[+] if(AccountList.Exists(10))
									[ ] sHandle=Str(AccountList.QWinChild.Order.ListBox.GetHandle())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
									[+] if(MatchStr("*{lsAddAccount[1]}*", sActual))
										[ ] ReportStatus("Verify Account List Status",PASS,"Account Intent change is reflected in Account List for Spending.")
									[+] else
										[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account List for Spending.")
									[ ] 
									[ ] AccountList.Close()
									[ ] WaitForState(AccountList,FALSE,5)
									[ ] 
								[+] else
									[ ] ReportStatus("Open Account List",FAIL,"Account List not opened")
									[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[+] case 2
								[ ] sleep(2)
								[ ] 
								[ ] //Verify changes in Account Bar
								[ ] QuickenWindow.SetActive()
								[ ] 
								[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.Banking.Exists(10))
									[ ] ReportStatus("Account Intent ",PASS, "Account Intent is changed correctly:'{lsAddAccount[1]}' ")
								[+] else
									[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account Bar.")
								[ ] 
								[ ] //Verify changes in Account List
								[ ] QuickenWindow.Tools.Click()
								[ ] QuickenWindow.Tools.AccountList.Select()
								[+] if(AccountList.Exists(10))
									[ ] 
									[ ] sHandle=Str(AccountList.QWinChild.Order.ListBox.GetHandle())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
									[+] if(MatchStr("*{lsAddAccount[1]}*", sActual))
										[ ] ReportStatus("Verify Account List Status",PASS,"Account Intent change is reflected in Account List for Saving.")
									[+] else
										[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account List for Saving.")
									[ ] 
									[ ] 
									[ ] AccountList.Close()
									[ ] WaitForState(AccountList,FALSE,5)
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Open Account List",FAIL,"Account List not opened")
							[ ] 
							[+] case 3
								[ ] sleep(2)
								[ ] 
								[ ] //Verify changes in Account Bar
								[ ] QuickenWindow.SetActive()
								[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.Investing.Exists(10))
									[ ] ReportStatus("Account Intent ",PASS, "Account Intent is changed correctly:'{lsAddAccount[1]}' ")
									[ ] 
								[+] else
									[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account Bar.")
								[ ] 
								[ ] 
								[ ] //Verify changes in Account List
								[ ] QuickenWindow.Tools.Click()
								[ ] QuickenWindow.Tools.AccountList.Select()
								[+] if(AccountList.Exists(10))
									[ ] 
									[ ] sHandle=Str(AccountList.QWinChild.Order.ListBox.GetHandle())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
									[+] if(MatchStr("*{lsAddAccount[1]}*", sActual))
										[ ] ReportStatus("Verify Account List Status",PASS,"Account Intent change is reflected in Account List for Investing.")
									[+] else
										[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account List for Investing.")
										[ ] 
										[ ] 
									[ ] 
									[ ] 
									[ ] AccountList.Close()
									[ ] WaitForState(AccountList,FALSE,5)
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Open Account List",FAIL,"Account List not opened")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[+] case 4
								[ ] sleep(2)
								[ ] 
								[ ] //Verify changes in Account Bar
								[ ] QuickenWindow.SetActive()
								[ ] 
								[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.Investing.Exists(10))
									[ ] ReportStatus("Account Intent ",PASS, "Account Intent is changed correctly:'{lsAddAccount[1]}' ")
								[+] else
									[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account Bar.")
									[ ] 
								[ ] 
								[ ] 
								[ ] //Verify changes in Account List
								[ ] QuickenWindow.Tools.Click()
								[ ] QuickenWindow.Tools.AccountList.Select()
								[+] if(AccountList.Exists(10))
									[ ] 
									[ ] sHandle=Str(AccountList.QWinChild.Order.ListBox.GetHandle())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
									[+] if(MatchStr("*{lsAddAccount[1]}*", sActual))
										[ ] ReportStatus("Verify Account List Status",PASS,"Account Intent change is reflected in Account List for Retirement.")
									[+] else
										[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account List for Retirement.")
									[ ] 
									[ ] 
									[ ] AccountList.Close()
									[ ] WaitForState(AccountList,FALSE,5)
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Open Account List",FAIL,"Account List not opened")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[+] case 5
								[ ] sleep(2)
								[ ] 
								[ ] //Verify changes in Account Bar
								[ ] QuickenWindow.SetActive()
								[ ] 
								[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.PropertyDebt.Exists(10))
									[ ] ReportStatus("Account Intent ",PASS, "Account Intent is changed correctly:'{lsAddAccount[1]}' ")
								[+] else
									[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account Bar.")
								[ ] 
								[ ] //Verify changes in Account List
								[ ] QuickenWindow.Tools.Click()
								[ ] QuickenWindow.Tools.AccountList.Select()
								[ ] 
								[+] if(AccountList.Exists(10))
									[ ] 
									[ ] sHandle=Str(AccountList.QWinChild.Order.ListBox.GetHandle())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
									[+] if(MatchStr("*{lsAddAccount[1]}*", sActual))
										[ ] ReportStatus("Verify Account List Status",PASS,"Account Intent change is reflected in Account List for Asset.")
									[+] else
										[ ] ReportStatus("Account Intent ",FAIL, "Account Intent change is not reflected in Account List for Asset.")
									[ ] 
									[ ] 
									[ ] AccountList.Close()
									[ ] WaitForState(AccountList,FALSE,5)
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Open Account List",FAIL,"Account List not opened")
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
				[+] if(AccountList.Exists(5))
					[ ] AccountList.Close()
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Select Account From Account Bar ",FAIL,"Account {sAccountName} Not Selected From Account Bar ")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# FINoConnection #################################################################                                  
	[ ] // ********************************************************
	[+] // TestCase Name:	Test13_FINoConnection()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if Correct status is displayed when FiCountor Account Type does not support connections
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    CORRECT status is displayed when FiCountor Account Type does not support connections.				
		[ ] // 							Fail	     INCORRECT status is displayed when FiCountor Account Type does not support connections.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 17/10/2012
	[ ] // ********************************************************
[+] testcase Test13_FINoConnection() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iSelect
		[ ] STRING sOptionName="Show Online Bill Pay Status"
		[ ] STRING sAccountName="Savings"
		[ ] STRING sFileName="AccountListFI"
	[ ] 
	[ ] 
	[ ] 
	[+] if(!QuickenWindow.Exists(5))
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow,TRUE,10)
		[ ] 
		[ ] 
	[ ] sleep(5)
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Open Data File
		[ ] iOpenDataFile = OpenDataFile(sFileName)
		[ ] // Report Staus If Data file Opened successfully
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sFileName} is opened")
			[ ] 
			[ ] //Select Display Online Bill Pay columnn Account List i
			[ ] iSelect=SelectAccountListOption(sOptionName,sSelectAction)
			[+] if ( iSelect  == PASS)
				[ ] ReportStatus("Account List ", PASS, "Account List -  {sOptionName} is selected")
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountFI)
				[ ] lsAddAccount=lsExcelData[1]
				[ ] 
				[ ] //Veriffy FI Status for Transaction download
				[+] if (AccountList.Exists(5))
					[ ] 
					[ ] 
					[ ] 
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
					[ ] //Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())			// get handle of list box
					[ ] 
					[ ] iAccountListLine=val(lsAddAccount[8])
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iAccountListLine}")
					[ ] 
					[ ] 
					[+] for(i=1;i<=7;i++)
						[+] if(lsAddAccount[i]!=NULL)
							[ ] bMatch=MatchStr("*{lsAddAccount[i]}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify Account List Status",PASS,"Status of account of FiCountwith No Connection in Account List: {lsAddAccount[i]} matched " )
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Account List Status",FAIL,"Status of account of FiCountwith No Connection in Account List: {lsAddAccount[i]} not matched " )
								[ ] 
								[ ] 
								[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] //Verify No connection Status  in Account Details==============================================================
					[ ] 
					[ ] EditButtonFromAccountList(sAccountName)
					[ ] 
					[+] if(AccountDetails.Exists(5))
						[ ] ReportStatus("Verify Account Details",PASS,"Account Details opened")
						[ ] 
						[ ] 
						[ ] //Click on Online Details Tab 
						[ ] AccountDetails.Click(1,160,79)
						[ ] 
						[ ] //Verify Online Set Up Button
						[+] if(AccountDetails.OnlineSetUpButton.Exists(10))
							[ ] ReportStatus("Verify Online Setup button",PASS,"Online Setup button is present")
						[+] else
							[ ] ReportStatus("Verify Online Setup button",FAIL,"Online Setup button is not present")                                           
							[ ] 
						[ ] 
						[ ] //Verify Online Bill Pay 
						[+] if(AccountDetails.OnlineBillPay.Exists(10))
							[ ] ReportStatus("Verify Online Setup button",PASS,"Online Setup button is present")
						[+] else
							[ ] ReportStatus("Verify Online Setup button",FAIL,"Online Setup button is not present")                                           
						[ ] 
						[ ] 
						[ ] //Close Account Details==============================================================================
						[ ] AccountDetails.Close()
						[ ] 
						[ ] 
						[ ] AccountList.Close()
						[ ] WaitForState(AccountList,FALSE,5)
						[ ] //============================================================================================
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Account Details",FAIL,"Account Details did not open")
						[ ] 
					[ ] 
					[ ] //=============================================================================================
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Account List ", FAIL, "Account List -  {sOptionName} is NOT selected")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFIFileName} is not opened")
			[ ] 
	[+] else
		[ ] ReportStatus("FiCountConnection",FAIL,"Quicken is Not Open")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] // 
[+] // ############# FIWeb_DirectConnect#############################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test13_FIWebConnect()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will verify if Correct status is displayed when FiCountsupports Direct connect
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    Correct status is displayed when FiCountor Account Type supports Direct connect.				
		[ ] // Fail	      INCORRECT status is displayed when FiCountor Account Type supports Direct connect.
		[ ] // 
		[ ] // 
		[ ] // REVISION HISTORY: 	      Created By	Dean Paes
		[ ] // 17/10/2012
	[ ] // ********************************************************
[+] // testcase Test14_FIWeb_DirectConnect() appstate none
	[ ] // 
	[+] // //Variable Declaration
		[ ] // INTEGER iSelect
		[ ] // STRING sOptionName="Show Online Bill Pay Status"
		[ ] // STRING sFileName="AccountListFI"
	[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(10))
		[ ] // 
		[ ] // // Open Data File
		[ ] // iOpenDataFile = OpenDataFile(sFileName)
		[ ] // // Report Staus If Data file Opened successfully
		[+] // if ( iOpenDataFile  == PASS)
			[ ] // ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sFileName} is opened")
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // //Select Display Online Bill Pay columnn Account List i
			[ ] // iSelect=SelectAccountListOption(sOptionName,sSelectAction)
			[+] // if ( iSelect  == PASS)
				[ ] // ReportStatus("Account List ", iSelect, "Account List -  {sOptionName} is selected")
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // // Read data from excel sheet
			[ ] // lsExcelData=ReadExcelTable(sAccountList, sAccountFI)
			[ ] // // Fetch  row from the given sheet
			[ ] // lsAddAccount=lsExcelData[2]
			[ ] // 
			[ ] // 
			[ ] // //Veriffy Fi Status for Transaction download==========================================================
			[ ] // 
			[ ] // 
			[+] // if (AccountList.Exists(5))
				[ ] // ReportStatus("Account List ", PASS, "Account List opened.")
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // // get handle of list box
				[ ] // sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
				[ ] // 
				[ ] // iAccountListLine=val(lsAddAccount[8])
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iAccountListLine}")
				[ ] // 
				[ ] // 
				[+] // for(i=1;i<=7;i++)
					[+] // if(lsAddAccount[i]!=NULL)
						[ ] // bMatch=MatchStr("*{lsAddAccount[i]}*",sActual)
						[+] // if(bMatch==TRUE)
							[ ] // ReportStatus("Verify Account List Status",PASS,"Status of account of FiCountwith No Connection in Account List: {lsAddAccount[i]} matched " )
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify Account List Status",FAIL,"Status of account of FiCountwith No Connection in Account List: {lsAddAccount[i]} not matched " )
							[ ] // 
							[ ] // 
							[ ] // 
					[ ] // 
					[ ] // 
				[ ] // 
				[ ] // //============================================================================================
				[ ] // 
				[ ] // //Verify Connection in Account Details==============================================================
				[ ] // 
				[ ] // //Click on Edit button
				[ ] // //AccountList.QWinChild.Order.ListBox.Click(1,280, 225)
				[ ] // AccountList.SetActive()
				[ ] // AccountList.Maximize()
				[ ] // //REMOVE THIS
				[ ] // EditButtonFromAccountList(lsAddAccount[1])
				[ ] // //AccountList.QWinChild.Order.ListBox.Click(1,434,223)
				[ ] // // AccountList.QWinChild.Order.ListBox.Click(1,255, 225)
				[ ] // 
				[+] // if(AccountDetails.Exists(5))
					[ ] // ReportStatus("Verify Account Details",PASS,"Account Details opened")
					[ ] // 
					[ ] // 
					[ ] // //Click on Online Details Tab 
					[ ] // AccountDetails.Click(1,165,79)
					[ ] // 
					[+] // if(AccountDetails.Deactivate.Exists(10))
						[ ] // ReportStatus("Verify Deactivate button",PASS,"Deactivate button is present")
					[+] // else
						[ ] // ReportStatus("Verify Deactivate button",FAIL,"Deactivate button is not present")                                           
						[ ] // 
					[ ] // 
					[+] // if(AccountDetails.AutomaticEntry.Exists(10))
						[ ] // ReportStatus("Verify Automatic Entry",PASS,"Automatic Entry link is present")
					[+] // else
						[ ] // ReportStatus("Verify Automatic Entry button",FAIL,"Automatic Entry link is not present")                                           
						[ ] // 
					[ ] // 
					[+] // if(AccountDetails.ConnectionMethod.GetText()==lsAddAccount[9])
						[ ] // ReportStatus("Verify Web Connect",PASS,"Web Connect is activated")
					[+] // else
						[ ] // ReportStatus("Verify Web Connect",FAIL,"Web Connect is not activated")                                           
					[ ] // 
					[ ] // 
					[+] // if(AccountDetails.FIName.GetText()==lsAddAccount[7])
						[ ] // ReportStatus("Verify FiCountName",PASS,"FiCountname is correct")
					[+] // else
						[ ] // ReportStatus("Verify FiCountName",FAIL,"FiCountname is  incorrect")                                           
						[ ] // 
					[ ] // 
					[ ] // 
					[+] // if(AccountDetails.ImproveConnection.Exists(10))
						[ ] // ReportStatus(" Verify Improve Connection Link",PASS," Improve Connection Link is present")     
					[+] // else
						[ ] // ReportStatus(" Verify Improve Connection Link",FAIL," Improve Connection Link is not present")                                           
						[ ] // 
					[ ] // 
					[ ] // 
					[+] // if(AccountDetails.SetUpNow.Exists(10))
						[ ] // ReportStatus(" Verify Online Bill Pay button",PASS," Online Bill Pay button is present")     
					[+] // else
						[ ] // ReportStatus(" Verify Online Bill Pay button",FAIL," Online Bill Pay button is not present")                                             
						[ ] // 
					[ ] // 
					[ ] // //=============================================================================================
					[ ] // 
					[ ] // //Close Account List
					[ ] // AccountDetails.Close()
					[ ] // 
					[ ] // 
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Account Details",FAIL,"Account Details did not open")
					[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // AccountList.Close()
				[ ] // WaitForState(AccountList,FALSE,5)
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Account List ", FAIL, "Account List not opened.")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Data File ", FAIL, "Data file -  {sFIFileName} is not opened")
			[ ] // 
		[ ] // 
		[ ] // 
	[ ] // // Report Status if Quicken is not launched
	[+] // else
		[ ] // ReportStatus("FiCountConnection",FAIL,"Quicken is Not Open")
	[ ] // 
	[ ] // 
	[ ] // 
[ ] // ############################################################################################
[ ] // 
[ ] // 
[+] //############# FIExpressWebConnect ###########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test15_FIExpressWebConnect()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if Correct status is displayed when FiCountor Account Type supports Express Web connect.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    Correct status is displayed when FiCountor Account Type supports Express Web connect.				
		[ ] // 							Fail	      INCORRECT status is displayed when FiCountor Account Type supports Express Web connect.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 17/10/2012
	[ ] // ********************************************************
[+] testcase Test15_FIExpressWebConnect() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iSelect
		[ ] STRING sOptionName="Show Online Bill Pay Status"
		[ ] STRING sFileName="AccountListFI"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] // Open Data File
		[ ] iOpenDataFile = OpenDataFile(sFileName)
		[ ] // Report Staus If Data file Opened successfully
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is opened")
			[ ] 
			[ ] 
			[ ] //Select Display Online Bill Pay columnn Account List i
			[ ] iSelect=SelectAccountListOption(sOptionName,sSelectAction)
			[+] if ( iSelect  == PASS)
				[ ] ReportStatus("Account List ", iSelect, "Account List -  {sOptionName} is selected")
			[ ] 
			[ ] 
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountFI)
			[ ] // Fetch  row from the given sheet
			[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] //Veriffy Fi Status for Transaction download==========================================================
			[ ] 
			[ ] 
			[+] if (AccountList.Exists(5))
				[ ] 
				[ ] 
				[ ] ////sHandle = Str(Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetHandle ())			
				[ ] // get handle of list box
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
				[ ] 
				[ ] iAccountListLine=val(lsAddAccount[8])
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iAccountListLine}")
				[ ] 
				[+] for(i=1;i<=7;i++)
					[+] if(lsAddAccount[i]!=NULL)
						[ ] bMatch=MatchStr("*{lsAddAccount[i]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Account List Status",PASS,"Status for Accounts supporting Express Web Connect in Account List: {lsAddAccount[i]} matched " )
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account List Status",FAIL,"Status for Accounts supporting Express Web Connect in Account List: {lsAddAccount[i]} not matched " )
							[ ] 
					[ ] 
					[ ] 
				[ ] //============================================================================================
				[ ] 
				[ ] //Verify contents of Account Details==================================================================
				[ ] 
				[+] //Click on Edit button
					[ ] //AccountList.QWinChild.Order.ListBox.Click(1,280,118)
					[ ] //AccountList.QWinChild.Order.ListBox.Click(1,255, 118)
				[ ] AccountList.SetActive()
				[ ] AccountList.Maximize()
				[ ] //REMOVE THIS
				[ ] //AccountList.QWinChild.Order.ListBox.Click(1,434,121)
				[ ] EditButtonFromAccountList(lsAddAccount[1])
				[ ] 
				[+] if(AccountDetails.Exists(10))
					[ ] ReportStatus("Verify Account Details",PASS,"Account Details opened")
				[+] else
					[ ] ReportStatus("Verify Account Details",FAIL,"Account Details did not open")
					[ ] 
				[ ] 
				[ ] //Click on Online Details Tab 
				[ ] AccountDetails.Click(1,165,79)
				[ ] 
				[+] if(AccountDetails.Deactivate.Exists(10))
					[ ] ReportStatus("Verify Deactivate button",PASS,"Deactivate button is present")
				[+] else
					[ ] ReportStatus("Verify Deactivate button",FAIL,"Deactivate button is not present")                                           
					[ ] 
				[ ] 
				[+] if(AccountDetails.AutomaticEntry.Exists(10))
					[ ] ReportStatus("Verify Automatic Entry",PASS,"Automatic Entry link is present")
				[+] else
					[ ] ReportStatus("Verify Automatic Entry button",FAIL,"Automatic Entry link is not present")                                           
					[ ] 
				[ ] 
				[+] if(AccountDetails.ConnectionMethod.GetText()==lsAddAccount[4])
					[ ] ReportStatus("Verify Express Web Connect",PASS,"Express Web Connect is activated")
				[+] else
					[ ] ReportStatus("Verify Express Web Connect",FAIL,"Express Web Connect is not activated , Actual: {AccountDetails.ConnectionMethod.GetText()}")                                           
				[ ] 
				[+] if(AccountDetails.FIName.GetText()==lsAddAccount[7])
					[ ] ReportStatus("Verify FiCountName",PASS,"FiCountname is correct")
				[+] else
					[ ] ReportStatus("Verify FiCountName",FAIL,"FiCountname is  incorrect, Actual: {AccountDetails.FIName.GetText()}")                                           
					[ ] 
				[ ] 
				[+] if(AccountDetails.SetUpNow.Exists(10))
					[ ] ReportStatus(" Verify Online Bill Pay button",PASS," Online Bill Pay button is present")     
				[+] else
					[ ] ReportStatus(" Verify Online Bill Pay button",FAIL," Online Bill Pay button is not present")                                             
					[ ] 
				[ ] 
				[ ] 
				[ ] //=============================================================================================
				[ ] 
				[ ] //Close Account List==============================================================================
				[ ] AccountDetails.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] AccountList.Close()
				[ ] WaitForState(AccountList,FALSE,5)
				[ ] 
				[ ] //=============================================================================================
			[+] else
				[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFIFileName} is not opened")
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("FiCountConnection",FAIL,"Quicken is Not Open")
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# FIDirectConnect #################################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test16_FIDirectConnect()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if Correct status is displayed when FiCountor Account Type supports Direct and it is activated.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    Correct status is displayed when FiCountor Account Type  supports Direct Connect and it is activated.				
		[ ] // 							Fail	      INCORRECT status is displayed when FiCountor Account Type  supports Direct Connect and it is activated.
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 17/10/2012
	[ ] // ********************************************************
[+] testcase Test16_FIDirectConnect() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iSelect
		[ ] STRING sOptionName="Show Online Bill Pay Status"
		[ ] STRING sFileName="AccountListFI"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountFI)
		[ ] // Fetch  row from the given sheet
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] // Open Data File
		[ ] iOpenDataFile = OpenDataFile(sFileName)
		[ ] // Report Staus If Data file Opened successfully
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sFileName} is opened")
			[ ] 
			[ ] 
			[ ] //Select Display Online Bill Pay columnn Account List i
			[ ] iSelect=SelectAccountListOption(sOptionName,sSelectAction)
			[+] if ( iSelect  == PASS)
				[ ] ReportStatus("Account List ", iSelect, "Account List -  {sOptionName} is selected")
			[ ] 
			[ ] 
			[ ] 
			[ ] //Veriffy Fi Status for Transaction download==========================================================
			[ ] 
			[+] if (AccountList.Exists(5))
				[ ] 
				[ ] 
				[ ] // get handle of list box
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
				[ ] 
				[ ] iAccountListLine=val(lsAddAccount[8])
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iAccountListLine}")
				[ ] 
				[+] for(i=1;i<=7;i++)
					[+] if(lsAddAccount[i]!=NULL)
						[ ] bMatch=MatchStr("*{lsAddAccount[i]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Account List Status",PASS,"Status for Accounts supporting Direct Connect in Account List: {lsAddAccount[i]} matched " )
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account List Status",FAIL,"Status for Accounts supporting Direct Connect in Account List: {lsAddAccount[i]} not matched " )
							[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //============================================================================================
				[ ] 
				[ ] //Verify contents of Account Details==============================================================
				[ ] 
				[ ] //Click on Edit button
				[ ] // AccountList.SetActive()
				[ ] // AccountList.Maximize()
				[ ] //REMOVE THIS
				[ ] //AccountList.QWinChild.Order.ListBox.Click(1,434,86)
				[ ] EditButtonFromAccountList(lsAddAccount[1])
				[ ] //AccountList.QWinChild.Order.ListBox.Click(1,255, 87)
				[+] if(AccountDetails.Exists(10))
					[ ] ReportStatus("Verify Account Details",PASS,"Account Details opened")
				[+] else
					[ ] ReportStatus("Verify Account Details",FAIL,"Account Details did not open")
					[ ] 
				[ ] 
				[ ] //Click on Online Details Tab 
				[ ] AccountDetails.Click(1,169,79)
				[ ] 
				[+] if(AccountDetails.Deactivate.Exists(10))
					[ ] ReportStatus("Verify Deactivate button",PASS,"Deactivate button is present")
				[+] else
					[ ] ReportStatus("Verify Deactivate button",FAIL,"Deactivate button is not present")                                           
					[ ] 
				[ ] 
				[+] if(AccountDetails.AutomaticEntry.Exists(10))
					[ ] ReportStatus("Verify Automatic Entry",PASS,"Automatic Entry link is present")
				[+] else
					[ ] ReportStatus("Verify Automatic Entry button",FAIL,"Automatic Entry link is not present")                                           
					[ ] 
				[ ] 
				[+] if(AccountDetails.ConnectionMethod.GetText()==lsAddAccount[4])
					[ ] ReportStatus("Verify Direct Connect",PASS,"Direct Connect is activated")
				[+] else
					[ ] ReportStatus("Verify Direct Connect",FAIL,"Direct Connect is not activated , Actual : {(AccountDetails.ConnectionMethod.GetText())}")                                                    
				[ ] 
				[+] if(AccountDetails.FIName.GetText()==lsAddAccount[7])
					[ ] ReportStatus("Verify FiCountName",PASS,"FiCountname is correct")
				[+] else
					[ ] ReportStatus("Verify FiCountName",FAIL,"FiCountname is  incorrect, Actual : {(AccountDetails.FIName.GetText())}")                                           
				[ ] 
				[ ] 
				[+] if(AccountDetails.BillPayDeactivate.Exists(10))
					[ ] ReportStatus("Verify Bill Pay Deactivate button",PASS,"Online Bill Pay Deactivate button is present")
				[+] else
					[ ] ReportStatus("Verify Deactivate button",FAIL,"Online Bill Pay Deactivate  button is not present")                                           
					[ ] 
				[ ] 
				[+] if(AccountDetails.Deactivate.Exists(10))
					[ ] ReportStatus("Verify Online Set Up Deactivate button",PASS,"Online Set Up  Deactivate button is present")
				[+] else
					[ ] ReportStatus("Verify Online Set Up Deactivate button",FAIL,"Online Set Up Deactivate  button is not present")                                           
				[ ] 
				[ ] 
				[ ] //=============================================================================================
				[ ] 
				[ ] //Close Account List==============================================================================
				[ ] AccountDetails.Close()
				[ ] 
				[ ] 
				[ ] AccountList.Close()
				[ ] WaitForState(AccountList,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFIFileName} is not opened")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //=============================================================================================
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("FiCountConnection",FAIL,"Quicken is Not Open")
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# FI_EWC_DirectConnect ##########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test17_FI_EWC_DirectConnect()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify if Correct status is displayed when EWC is activated and FiCountsupports DC.
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    Correct status is displayed when FiCountor Account Type supports EWC and DC			
		[ ] // 							Fail	      INCORRECT status is displayed when FiCountor Account Type supports EWC and DC
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Dean Paes
		[ ] // 17/10/2012
	[ ] // ********************************************************
[+] testcase Test17_FI_EWC_DirectConnect() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iSelect
		[ ] STRING sOptionName="Show Online Bill Pay Status"
		[ ] STRING sFileName="AccountListFI"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sAccountList, sAccountFI)
		[ ] // Fetch  row from the given sheet
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] // Open Data File
		[ ] iOpenDataFile = OpenDataFile(sFileName)
		[ ] // Report Staus If Data file Opened successfully
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sFileName} is opened")
			[ ] 
			[ ] 
			[ ] //Select Display Online Bill Pay columnn Account List i
			[ ] iSelect=SelectAccountListOption(sOptionName,sSelectAction)
			[+] if ( iSelect  == PASS)
				[ ] ReportStatus("Account List ", PASS, "Account List -  {sOptionName} is selected")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Veriffy Fi Status for Transaction download==========================================================
				[ ] 
				[ ] //AccountList.QWinChild.Order.ListBox.SetActive()
				[+] if (AccountList.Exists(5))
					[ ] 
					[ ] 
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())	   // get handle of list box
					[ ] 
					[ ] iAccountListLine=val(lsAddAccount[8])
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iAccountListLine}")
					[ ] 
					[ ] 
					[+] for(i=1;i<=7;i++)
						[+] if(lsAddAccount[i]!=NULL)
							[ ] bMatch=MatchStr("*{lsAddAccount[i]}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify Account List Status",PASS,"Status for Accounts supporting Express Web and Direct Connect in Account List: {lsAddAccount[i]} matched " )
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Account List Status",FAIL,"Status for Accounts supporting Express Web and Direct Connect in Account List: {lsAddAccount[i]} not matched " )
								[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] //============================================================================================
					[ ] 
					[ ] //Verify contents of Account Details==================================================================
					[ ] 
					[ ] //Click on Edit button
					[ ] //AccountList.QWinChild.Order.ListBox.Click(1,280,156)
					[ ] //AccountList.QWinChild.Order.ListBox.Click(1,255,152)
					[ ] //AccountList.SetActive()
					[ ] //AccountList.Maximize()
					[ ] //REMOVE THIS
					[ ] //AccountList.QWinChild.Order.ListBox.Click(1,434,156)
					[ ] EditButtonFromAccountList(lsAddAccount[1])
					[ ] 
					[ ] 
					[+] if(AccountDetails.Exists(5))
						[ ] ReportStatus("Verify Account Details",PASS,"Account Details opened")
						[ ] 
						[ ] 
						[ ] 
						[ ] //Click on Online Details Tab 
						[ ] AccountDetails.Click(1,169,79)
						[ ] 
						[+] if(AccountDetails.Deactivate.Exists(10))
							[ ] ReportStatus("Verify Deactivate button",PASS,"Deactivate button is present")
						[+] else
							[ ] ReportStatus("Verify Deactivate button",FAIL,"Deactivate button is not present")                                           
							[ ] 
						[ ] 
						[+] if(AccountDetails.AutomaticEntry.Exists(10))
							[ ] ReportStatus("Verify Automatic Entry",PASS,"Automatic Entry link is present")
						[+] else
							[ ] ReportStatus("Verify Automatic Entry button",FAIL,"Automatic Entry link is not present")                                           
							[ ] 
						[ ] 
						[+] if(AccountDetails.ConnectionMethod.GetText()==lsAddAccount[9])
							[ ] ReportStatus("Verify Express Web Connect",PASS,"Express Web Connect is activated")
						[+] else
							[ ] ReportStatus("Verify Express Web Connect",FAIL,"Express Web Connect is not activated")                                           
						[ ] 
						[+] if(AccountDetails.FIName.GetText()==lsAddAccount[7])
							[ ] ReportStatus("Verify FiCountName",PASS,"FiCountname is correct")
						[+] else
							[ ] ReportStatus("Verify FiCountName",FAIL,"FiCountname is  incorrect")                                           
							[ ] 
						[ ] 
						[+] if(AccountDetails.SetUpNow.Exists(10))
							[ ] ReportStatus(" Verify Online Bill Pay button",PASS," Online Bill Pay button is present")     
						[+] else
							[ ] ReportStatus(" Verify Online Bill Pay button",FAIL," Online Bill Pay button is not present")                                             
							[ ] 
						[ ] 
						[ ] 
						[ ] //=============================================================================================
						[ ] 
						[ ] //Close Account List==============================================================================
						[ ] AccountDetails.Close()
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Account Details",FAIL,"Account Details did not open")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] AccountList.Close()
					[ ] //=============================================================================================
				[+] else
					[ ] ReportStatus("Account List ", FAIL, "Account List  not opened.")
			[+] else
				[ ] ReportStatus("Account List ", FAIL, "Account List -  {sOptionName} couldn't be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFIFileName} is not opened")
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("FiCountConnection",FAIL,"Quicken is Not Open")
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# Hidden Account in Account List  ###################################################                              
	[ ] // ********************************************************
	[+] // TestCase Name:	Test18_HiddenAccountInAccountList()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will Verify Account List behaviour in case of hide an account. 
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    if verification passed			
		[ ] // 							Fail	     if verification failed
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Udita Dube
		[ ] // 25/12/2012
	[ ] // ********************************************************
[+] testcase Test18_HiddenAccountInAccountList() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sCaption,sAccount,sTab
		[ ] BOOLEAN bCaption,bExists
		[ ] LIST of STRING lsAddAccount
		[ ] lsAddAccount={"Checking","	Business 01","237.55","01/01/2012","BUSINESS"}
		[ ] 
		[ ] STRING sFileName = "HiddenAccountBanking"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
		[ ] 
		[ ] sAccount="Checking 01"
		[ ] sTab= "Display Options"
		[ ] 
	[ ] 
	[ ] // Quicken is launched then create data file
	[+] if (QuickenWindow.Exists(10))
		[ ] 
		[ ] // Load O/S specific paths
		[ ] LoadOSDependency()
		[ ] 
		[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
		[+] else
			[ ] App_Start(sCmdLine)
			[ ] 
		[ ] 
		[ ] // Open data file
		[ ] sCaption = QuickenWindow.GetCaption()
		[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
		[+] if(bCaption == FALSE)
			[ ] DeleteFile(sDataFile)
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] OpenDataFile(sFileName)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // bExists = FileExists(sDataFile)
			[+] // if(bExists == TRUE)
				[ ] // DeleteFile(sDataFile)
				[ ] // CopyFile(sSourceFile,sDataFile)
				[ ] // OpenDataFile(sFileName)
			[ ] 
		[ ] 
		[ ] // Set Classic View
		[ ] SetViewMode(VIEW_CLASSIC_MENU)
		[ ] // Select Home tab
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] // Off Popup Register
		[ ] UsePopUpRegister("OFF")
		[ ] 
		[ ] 
		[ ] // Edit Checking Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)			// Select first checking account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Check "Hide account name from account bar and account list" checkbox
			[+] if(AccountDetails.HideAccountNameInAccountB.Exists(10))
				[ ] AccountDetails.HideAccountNameInAccountB.Check()
				[ ] AccountDetails.OK.Click()
				[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", PASS, "Third Checkbox: Hide account name from account bar and account list is checked")
				[ ] NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
				[+] if(AccountList.Exists(10))
					[ ] AccountList.SetActive()
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
					[ ] bMatch = MatchStr("*{sAccount}*",  sActual)					// check that Checking account is not present
					[+] if(bMatch == FALSE)
						[ ] ReportStatus("Validate Account hidden from Account List", PASS, "{sAccount} account is hidden from Account List") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Account hidden from Account List", FAIL, "{sAccount} account is not hidden from Account List") 
						[ ] 
					[ ] 
					[+] if(AccountList.QWinChild.ShowHiddenAccounts.Exists(10))
						[ ] ReportStatus("Verify Show Hidden Account checkbox",PASS,"Show hidden account checkbox is displayed")
						[ ] AccountList.QWinChild.ShowHiddenAccounts.Check()
						[ ] 
						[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
						[ ] bMatch = MatchStr("*{sAccount}*",  sActual)					// check that Checking account is present
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Account shown in Account List", PASS, "{sAccount} account is available in Account List after checking Show Hidden Account checkbox") 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Account shown in Account List", FAIL, "{sAccount} account is not available in Account List after checking Show Hidden Account checkbox") 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Show Hidden Account checkbox",FAIL,"Show hidden account checkbox is not displayed")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify account list displayed",FAIL, "Account list didn't display.")
				[ ] AccountList.Close()
			[+] else
				[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", FAIL, "Third Checkbox: Hide account name from account bar and account list is not available")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify account details displayed.", FAIL, "Account details didn't display.")
		[ ] 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# Unhide Account in Account List  ###################################################                              
	[ ] // ********************************************************
	[+] // TestCase Name:	Test19_UnHideAccountInAccountList()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will verify Account List behaviour in case of unhide of an account. 
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    if verification passed			
		[ ] // 							Fail	     if verification failed
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Udita Dube
		[ ] // 26/12/2012
	[ ] // ********************************************************
[+] testcase Test19_UnHideAccountInAccountList() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sCaption,sAccount,sTab
		[ ] BOOLEAN bCaption,bExists
		[ ] LIST of STRING lsAddAccount
		[ ] lsAddAccount={"Checking","	Business 01","237.55","01/01/2012","BUSINESS"}
		[ ] 
		[ ] STRING sFileName = "HiddenAccountBanking"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
		[ ] 
		[ ] sAccount="Checking 01"
		[ ] sTab= "Display Options"
		[ ] 
	[ ] 
	[ ] // Quicken is launched then create data file
	[+] if (QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
		[ ] 
		[+] if(AccountList.QWinChild.ShowHiddenAccounts.Exists(10))
			[ ] ReportStatus("Verify Show Hidden Account checkbox",PASS,"Show hidden account checkbox is displayed")
			[ ] 
			[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
			[ ] bMatch = MatchStr("*{sAccount}*",  sActual)					// check that Checking account is present
			[+] if(bMatch == FALSE)
				[ ] ReportStatus("Validate Account in Account List", PASS, "{sAccount} account is not available in Account List as it is hidden") 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account in Account List", FAIL, "{sAccount} account is available in Account List as it is not hidden") 
				[ ] 
			[ ] 
			[ ] AccountList.QWinChild.ShowHiddenAccounts.Check()
			[ ] AccountList.Maximize()
			[ ] 
			[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
			[ ] bMatch = MatchStr("*{sAccount}*",  sActual)					// check that Checking account is present
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Account in Account List", PASS, "{sAccount} account is available in Account List") 
				[ ] 
				[ ] // Edit Checking 01 account
				[ ] //REMOVE THIS
				[ ] EditButtonFromAccountList(sAccount)
				[ ] //AccountList.QWinChild.Order.ListBox.Click(1,1024,53)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] if(AccountDetails.Exists(SHORT_SLEEP))
					[ ] AccountDetails.SetActive()
					[ ] AccountDetails.Click(1, 252, 75)
					[ ] AccountDetails.HideAccountNameInAccountB.Uncheck()
					[ ] AccountDetails.OK.Click()
					[ ] AccountList.SetActive()
					[+] if(!AccountList.QWinChild.ShowHiddenAccounts.Exists(10))
						[ ] ReportStatus("Verify Show Hidden Account checkbox",PASS,"Show Hidden Account checkbox is not displayed as account is made unhide")
					[+] else
						[ ] ReportStatus("Verify Show Hidden Account checkbox",FAIL,"Show Hidden Account checkbox is displayed as there is other hidden account")
						[ ] 
					[ ] AccountList.Close()
				[+] else
					[ ] ReportStatus("Verify Account Details window", FAIL, "Account Details window not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account in Account List", FAIL, "{sAccount} account is not available in Account List") 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Show Hidden Account checkbox",FAIL,"Show hidden account checkbox is not displayed")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# Separate Account in Account List  ##################################################                        
	[ ] // ********************************************************
	[+] // TestCase Name:	Test20_SeparateAccountInAccountList()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will Verify Account List behaviour in case of account is separated
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    if verification passed			
		[ ] // 							Fail	     if verification failed
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Udita Dube
		[ ] // 26/12/2012
	[ ] // ********************************************************
[+] testcase Test20_SeparateAccountInAccountList() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sAccount,sTab
		[ ] INTEGER iSeparate
		[ ] 
		[ ] sAccount="Checking 02"
		[ ] sTab= "Display Options"
		[ ] 
	[ ] 
	[ ] // Quicken is launched then create data file
	[+] if (QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)			// Select checking account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Check "Keep This Account Separate" checkbox
			[+] if(AccountDetails.KeepThisAccountSeparate.Exists(10))
				[ ] AccountDetails.KeepThisAccountSeparate.Check()
				[ ] AccountDetails.OK.Click()
				[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", PASS, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is checked")
				[ ] 
				[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE,sAccount)
				[+] if (iSeparate == PASS)
					[ ] AccountDetails.Cancel.Click()
					[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and checking account is displayed under this seaction")
				[+] else
					[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
				[ ] 
				[ ] // Verify Account is available in account list even if "Keep This Account Separate" checkbox is checked
				[ ] QuickenWindow.SetActive()
				[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
				[+] if(iNavigate == PASS)
					[ ] AccountList.Maximize()
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
					[ ] 
					[ ] // ####### Validate Account in Account List window #####################
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "4")
					[ ] bMatch = MatchStr("*{sAccount}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Separate Account in Account List", PASS, "{sAccount} account is present in Account List") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Separate Account in Account List", FAIL, "{sAccount} account is not present in Account List") 
						[ ] 
					[ ] AccountList.Close ()
				[+] else
					[ ] ReportStatus("Validate Account List window", FAIL, "Account List  window is not opened") 
				[ ] 
			[+] else
				[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "First Banking Account is not selected from Account bar")
			[ ] 
		[ ] 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[+] //############# Hidden Account in Business Account List  ###########################################                        
	[ ] // ********************************************************
	[+] // TestCase Name:	Test21_HiddenAccountInBusinessCashFlow()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will Verify hidden account feature on Single Purpose Account List. 
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass    if verification passed			
		[ ] // 							Fail	     if verification failed
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	      	Created By	Udita Dube
		[ ] // 25/12/2012
	[ ] // ********************************************************
[+] testcase Test21_HiddenAccountInBusinessCashFlow() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sCaption,sTab
		[ ] LIST of STRING lsAddAccount
		[ ] lsAddAccount={"Checking","	Business 01","237.55","01/01/2012","BUSINESS"}
		[ ] 
		[ ] sTab= "Display Options"
		[ ] 
	[+] if (QuickenWindow.Exists(10))
		[ ] 
		[ ] // Add Business Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], trim(lsAddAccount[2]), lsAddAccount[3], lsAddAccount[4],lsAddAccount[5])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus(" Add Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] // Verify account name in Account Bar
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BUSINESS_BANKING,trim(lsAddAccount[2]),sTab)			// Select first business account
			[+] if (iSelect == PASS)
				[ ] // Check "Hide account name from account bar and account list" checkbox
				[+] if(AccountDetails.HideAccountNameInAccountB.Exists(10))
					[ ] AccountDetails.SetActive()
					[ ] AccountDetails.HideAccountNameInAccountB.Check()
					[ ] AccountDetails.OK.Click()
					[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", PASS, "Third Checkbox: Hide account name from account bar and account list is checked")
					[ ] QuickenWindow.SetActive()
					[ ] QuickenMainWindow.QWNavigator.Business.Click()
					[ ] QuickenMainWindow.QWNavigator.CashFlow.Click()
					[ ] MDIClient.Business.SelectAccounts.Click()
					[+] if (AccountList.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Account List ", PASS, "Single Purpose Account List  opened from Business Tab.")
						[+] if(AccountList.QWinChild.ShowHiddenAccounts.Exists(10))
							[ ] ReportStatus("Verify Show Hidden Account checkbox",PASS,"Show hidden account checkbox is displayed")
							[ ] 
							[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
							[ ] iListCount= AccountList.QWinChild.Order.ListBox.GetItemCount()
							[+] for(iCount=0; iCount<=iListCount; iCount++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(iCount))
								[ ] bMatch = MatchStr("*{trim(lsAddAccount[2])}*",  sActual)					// check that Checking account is present
								[+] if (bMatch)
									[ ] break
								[ ] 
							[+] if(bMatch == FALSE)
								[ ] ReportStatus("Validate Account shown in Account List", PASS, "{trim(lsAddAccount[2])} account is not available in Account List before checking Show Hidden Account checkbox") 
							[+] else
								[ ] ReportStatus("Validate Account shown in Account List", FAIL, "{ltrim(lsAddAccount[2])} account is available in Account List before checking Show Hidden Account checkbox") 
								[ ] 
							[ ] 
							[ ] AccountList.QWinChild.ShowHiddenAccounts.Check()
							[ ] sleep(2)
							[ ] AccountList.SetActive()
							[ ] AccountList.TextClick("Business Banking")
							[ ] 
							[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
							[ ] iListCount= AccountList.QWinChild.Order.ListBox.GetItemCount()
							[+] for(iCount=0; iCount<=iListCount; iCount++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(iCount))
								[ ] bMatch = MatchStr("*{trim(lsAddAccount[2])}*",  sActual)				// check that Checking account is present
								[+] if (bMatch)
									[ ] break
								[ ] 
							[ ] 
							[ ] 		// check that Checking account is present
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Validate Account shown in Account List", PASS, "{trim(lsAddAccount[2])} account is available in Account List after checking Show Hidden Account checkbox") 
							[+] else
								[ ] ReportStatus("Validate Account shown in Account List", FAIL, "{lsAddAccount[2]} account is not available in Account List after checking Show Hidden Account checkbox") 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Show Hidden Account checkbox",FAIL,"Show hidden account checkbox is not displayed")
							[ ] 
						[ ] 
					[+] else 
						[ ] ReportStatus("Verify Account List ", FAIL, "Single Purpose  not opened.")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", FAIL, "Third Checkbox: Hide account name from account bar and account list is not available")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account details displayed.",FAIL,"Account details didn't display.")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[ ] //######################  Account List Clean  ###################################################
[+] testcase AccountListClean() appstate none
	[ ] 
	[ ] 
	[+] if(AccountDetails.Exists(3))
		[ ] AccountDetails.Close()
		[ ] WaitForState(AccountDetails,FALSE,5)
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(AccountList.Exists(3))
		[ ] 
		[ ] AccountList.Close()
		[ ] WaitForState(AccountList,FALSE,5)
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.Kill()
		[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################
[ ] 
[ ] 
[ ] // 
[ ] // 
[ ] // 
[ ] // 
[ ] // 
