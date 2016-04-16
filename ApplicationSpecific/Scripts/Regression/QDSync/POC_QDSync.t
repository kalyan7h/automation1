[ ] // *********************************************************
[+] // FILE NAME:	<POC_QDSync.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains test cases that syncs the changes to the resources (tags, categories, budgets, transactions etc) to cloud.
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Jayashree Nagaraja
	[ ] //
	[ ] // Developed on: 		03/27/2015
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 03/27/2015,	Jayashree Nagaraja  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "C:\automation\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[-] // Global variables
	[ ] public STRING sFileName = "POC_QDSync"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sQDSyncData = "POC_QDSync"
	[ ] public STRING sQDSyncWorksheet = "AddAccount", sQDSyncWorksheet2 = "AddTransactions", sQDSyncWorksheet3 = "IntuitID"
	[ ] public LIST OF ANYTYPE  lsExcelData, lsExcelData2, lsExcelData3, lsQDSyncData, lsQDSyncData2, lsQDSyncData3, lsQDSyncData4, lsQDSyncData5, lsQDSyncData6
	[ ] public INTEGER iSelect
	[ ] 
[ ] 
[ ] 
[-] //#############  NewUserSignUpAndCloudAccountCreation #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 NewUserSignUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the QDSync.QDF if it exists. It will sign up the new user, create manual checking account, add transactions and sync account to cloud
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file and signing up and syncing new user account to cloud.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Mar 27, 2014		Jayashree Nagaraja	created
	[ ] // ********************************************************
	[ ] 
[-] testcase NewUserSignUp () appstate none
	[-] //Variable Declaration
		[ ] INTEGER iSetupAutoAPI, iCreateDataFile, iSelect, iNavigate, iAddTransaction, iSelect2, iResult, iRand, iZip
		[ ] STRING sCurrentDate, sAccountEndingBalance, sIntuitID
		[ ] LIST OF ANYTYPE lsDataToVerify
		[ ] 
		[ ] // Read data from excel sheet1
		[ ] lsExcelData=ReadExcelTable(sQDSyncData, sQDSyncWorksheet)
		[ ] 
		[ ] // Fetch 1st row from the given sheet
		[ ] lsQDSyncData = lsExcelData[1]
		[ ] 
		[ ] STRING sAccountType = lsQDSyncData[1]
		[ ] STRING sAccountName = lsQDSyncData[2]
		[ ] STRING sAccountBalance = lsQDSyncData[3]
		[ ] STRING sAccGroup = lsQDSyncData[4]
		[ ] STRING sDate
		[ ] 
		[ ] //Read data from excel sheet2
		[ ] lsExcelData2=ReadExcelTable(sQDSyncData, sQDSyncWorksheet2)
		[ ] //Fetch 1st, 2nd, 3rd and 4th row from the given sheet
		[ ] lsQDSyncData2 = lsExcelData2[1]
		[ ] lsQDSyncData3 = lsExcelData2[2]
		[ ] lsQDSyncData4 = lsExcelData2[3]
		[ ] lsQDSyncData5 = lsExcelData2[4]
		[ ] 
		[ ] sDate =FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] 
		[ ] STRING sWindowType1 = lsQDSyncData2[1]
		[ ] STRING sTransactionType1 = lsQDSyncData2[2]
		[ ] STRING sAmount1 = lsQDSyncData2[3]
		[ ] STRING sPayee1 = lsQDSyncData2[4]
		[ ] STRING sCategory1 = lsQDSyncData2[5]
		[ ] STRING sChequeNo1 = lsQDSyncData2[6]
		[ ] STRING sMemo1 = lsQDSyncData2[7]
		[ ] 
		[ ] STRING sWindowType2 = lsQDSyncData3[1]
		[ ] STRING sTransactionType2 = lsQDSyncData3[2]
		[ ] STRING sAmount2 = lsQDSyncData3[3]
		[ ] STRING sPayee2 = lsQDSyncData3[4]
		[ ] STRING sCategory2 = lsQDSyncData3[5]
		[ ] STRING sChequeNo2 = lsQDSyncData3[6]
		[ ] STRING sMemo2 = lsQDSyncData3[7]
		[ ] 
		[ ] STRING sWindowType3 = lsQDSyncData4[1]
		[ ] STRING sTransactionType3 = lsQDSyncData4[2]
		[ ] STRING sAmount3 = lsQDSyncData4[3]
		[ ] STRING sPayee3 = lsQDSyncData4[4]
		[ ] STRING sCategory3 = lsQDSyncData4[5]
		[ ] 
		[ ] STRING sWindowType4 = lsQDSyncData5[1]
		[ ] STRING sTransactionType4 = lsQDSyncData5[2]
		[ ] STRING sAmount4 = lsQDSyncData5[3]
		[ ] STRING sPayee4 = lsQDSyncData5[4]
		[ ] STRING sCategory4 = lsQDSyncData5[5]
		[ ] 
		[ ] //Read data from excel sheet3
		[ ] lsExcelData3 = ReadExcelTable(sQDSyncData, sQDSyncWorksheet3)
		[ ] 
		[ ] //Fetch 1st row from the given sheet
		[ ] lsQDSyncData6 = lsExcelData3[1]
		[ ] 
		[ ] STRING sEmailID = lsQDSyncData6[1]
		[ ] STRING sPassword = lsQDSyncData6[2]
		[ ] STRING sSecurityQuestion = lsQDSyncData6[3]
		[ ] STRING sSecurityQuestionAnswer = lsQDSyncData6[4]
		[ ] STRING sName = lsQDSyncData6[5]
		[ ] STRING sLastName = lsQDSyncData6[6]
		[ ] STRING sAddress = lsQDSyncData6[7]
		[ ] STRING sCity = lsQDSyncData6[8]
		[ ] STRING sState = lsQDSyncData6[9]
		[ ] STRING sZip = lsQDSyncData6[10]
		[ ] STRING sBoughtFrom = lsQDSyncData6[11]
		[ ] STRING sMobileNumber = lsQDSyncData6[12]
	[ ]  
	[-] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[ ] 
	[-] if (LowScreenResolution.Exists(75))
		[ ] LowScreenResolution.Dontshowthisagain.Check()
		[ ] LowScreenResolution.OK.Click()
		[ ] Sleep(3)
		[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
	[-] else
		[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
	[ ] 
	[ ] // Create Data File
	[ ] iCreateDataFile = DataFileCreate(sFileName, NULL, sEmailID, sPassword, sSecurityQuestion, sSecurityQuestionAnswer, sName, sLastName, sAddress, sCity, sState, sZip, sBoughtFrom, NULL, sMobileNumber)
	[ ] 
	[ ] // Report Staus If Data file Created successfully
	[-] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] //Navigate to Home Tab and create a checking account
		[ ] NavigateQuickenTab(sTAB_HOME)
		[-] if (QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Exists())
			[ ] ReportStatus("Validate if  Account Bar is expanded", PASS, "Account Bar is expanded")
		[-] else
			[ ] QuickenMainWindow.QWNavigator.AccountExpand.Click()
		[ ] 
		[ ] sCurrentDate = FormatDateTime(GetDateTime(), "mm/dd/yyyy")
		[ ] 
		[ ] iSelect = AddManualSpendingAccount(sAccountType, sAccountName, sAccountBalance, sCurrentDate)
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Validate Account Creation ", PASS, "Checking Account -  {sAccountName} is created")
			[ ] 
			[ ] //Select the checking account from account bar
			[ ] iSelect2 = SelectAccountFromAccountBar(sAccountName, sAccGroup)
			[+] if (iSelect2 == PASS)
				[ ] ReportStatus ("Select Checking Account From Account Bar", PASS, " {sAccountName} Checking Account is selected from the account bar")
				[ ] 
				[ ] //Add a few transactions to the checking account register
				[ ] //1st transaction
				[ ] iAddTransaction = AddCheckingTransaction(sWindowType1, sTransactionType1, sAmount1, sDate, sChequeNo1, sPayee1, sMemo1, sCategory1, NULL)
				[-] if (iAddTransaction == PASS)
					[ ] ReportStatus("Adding first transaction", PASS, "First transaction with category {sCategory1} is added")
					[ ] //2nd transaction
					[ ] iAddTransaction = AddCheckingTransaction(sWindowType2, sTransactionType2, sAmount2, sDate, sChequeNo2, sPayee2, sMemo2,sCategory2, NULL)
					[-] if (iAddTransaction == PASS)
						[ ] ReportStatus("Adding second transaction", PASS, "Second transaction with category {sCategory2} is added")
						[ ] //3rd transaction
						[ ] iAddTransaction = AddCheckingTransaction(sWindowType3, sTransactionType3, sAmount3, sDate, NULL, sPayee3, NULL,sCategory3, NULL)
						[-] if (iAddTransaction == PASS)
							[ ] ReportStatus("Adding third transaction", PASS, "Third transaction with category {sCategory3} is added")
							[ ] //4th transaction
							[ ] iAddTransaction = AddCheckingTransaction(sWindowType4, sTransactionType4, sAmount4, sDate, NULL, sPayee4, NULL,sCategory4, NULL)
							[-] if (iAddTransaction == PASS)
								[ ] ReportStatus("Adding fourth transaction", PASS, "Fourth transaction with category {sCategory4} is added")
							[+] else
								[ ] ReportStatus("Adding fourth transaction", FAIL, "Fourth transaction with category {sCategory4} could not be added")
						[+] else
							[ ] ReportStatus("Adding second transaction", FAIL, "Second transaction with category {sCategory3} could not be added")
					[+] else
						[ ] ReportStatus("Adding second transaction", FAIL, "Second transaction with category {sCategory2} could not be added")
				[+] else
					[ ] ReportStatus("Adding first transaction", FAIL, "First transaction with category {sCategory1} could not be added")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus ("Select Checking Account From Account Bar", FAIL, " {sAccountName} Checking Account could not be selected from the account bar")
		[+] else
			[ ] ReportStatus("Validate Account Creation ", FAIL, "Checking Account -  {sAccountName} could not be created")
		[ ] 
		[ ] iSelect2 = SelectAccountFromAccountBar(sAccountName, sAccGroup)
		[ ] 
		[ ] //Get Account Balance
		[ ] sAccountEndingBalance = MDIClient.AccountRegister.EndingBalance.EndingBalanceAmount.GetText()
		[ ] print (sAccountEndingBalance)
		[ ] 
		[ ] //Create a cloud account
		[ ] iResult = MobileSignUp(sPassword)
		[-] if (iResult==PASS)
			[ ] ReportStatus("Cloud Account Creation", PASS, "Cloud account creation is successful.")
			[ ] 
			[ ] //Get IntuitID
			[ ] QuickenMainWindow.QWNavigator.MobileAlerts.DoubleClick()
			[ ] Sleep(3)
			[ ] sIntuitID = QuickenMainWindow.IntuitID.GetCaption()
			[ ] print (sIntuitID)
		[-] else
			[ ] ReportStatus("Cloud Account Creation", FAIL, "Cloud account creation failed.")
	[+] else
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is not created")
		[ ] 
[ ] //###########################################################################
[ ] 
