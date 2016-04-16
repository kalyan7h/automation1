[+] // FILE NAME:	<AddBankingAccount.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This Utility add Banking accounts () in Quicken application as per the data provided through .xls file
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //
	[ ] // Developed on: 		22/8/2012
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Aug 22, 2012	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] 
[+] // Global variables
	[ ] public LIST OF ANYTYPE  lsExcelData
	[ ] INTEGER i,iCount,iPos,iSelect
	[ ] LIST OF STRING lsAddAccount,lsTransactionData
	[ ] public STRING sFileName = "LargeDataFile_2013"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sDataSheet = "AddBankingAccount"
	[ ] public STRING sBankingAccountSheet = "BankingAccount"
	[ ] public STRING sStartQuicken = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sInvestingTransactionWorksheet = "Add Transaction"
	[ ] // public STRING sDataSheet =  SYS_GetEnv("var1")
[ ] 
[-] //############### Create Banking Account ############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 AddBankingAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Property accounts (House / Vehicle / Banking) in Quicken application as per the data provided through .xls file
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Banking account is added 					
		[ ] //							Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	28/4/2011  	Created By	Udita Dube
		[ ] // 											
	[ ] //*********************************************************
[+] testcase AddBankingAccount () appstate none
	[ ] 
	[-] // Variable declaration
		[ ] STRING sHandle,sActual
		[ ] BOOLEAN bMatch,bFlag
		[ ] INTEGER iAddAccount,iSwitchState,iSetupAutoAPI,iCreateDataFile,j,jCount=0
		[ ] bFlag=TRUE
	[ ] 
	[-] // Perform Setup activities
		[-] if(QuickenMainWindow.Exists())
			[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
			[ ] QuickenMainWindow.SetActive()
			[ ] QuickenMainWindow.Exit()
		[ ] 
		[ ] sleep(SHORT_SLEEP)
		[ ] 
		[-] if(FileExists(sDataFile))
			[ ] DeleteFile(sDataFile)
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
	[ ] // Launch Quicken
	[-] if (!QuickenMainWindow.Exists ())
		[ ] QuickenMainWindow.Start (sStartQuicken)
	[ ] 
	[+] if (QuickenMainWindow.Exists(MEDIUM_SLEEP) == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] // read excel table
	[ ] lsExcelData = ReadExcelTable(sDataSheet, sBankingAccountSheet)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] iSwitchState = UsePopupRegister("OFF")
	[ ] 
	[-] for(i=1;i<=iCount;i++)
		[ ] 
		[ ] lsAddAccount=lsExcelData[i]
		[ ] 
		[-] if(IsNULL(lsAddAccount[1]))
			[ ] ReportStatus("Add Banking Account", FAIL, "Please enter data for 'AccountType' column in {sDataSheet} > {sBankingAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[-] if(IsNULL(lsAddAccount[2]))
			[ ] ReportStatus("Add Banking Account", FAIL, "Please enter data for 'AccountName' column in {sDataSheet} > {sBankingAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[-] if(IsNULL(lsAddAccount[3]))
			[ ] ReportStatus("Add Banking Account", FAIL, "Please enter data for 'Date' column in {sDataSheet} > {sBankingAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[-] if(IsNULL(lsAddAccount[4]))
			[ ] ReportStatus("Add Banking Account", FAIL, "Please enter data for 'PurchasePrice' column in {sDataSheet} > {sBankingAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[-] if(IsNULL(lsAddAccount[5]))
			[ ] lsAddAccount[5]="Personal Transactions"
		[ ] 
		[ ] 
		[-] do
			[ ] 
			[ ] // Quicken is launched then Add Checking Account
			[-] if (QuickenMainWindow.Exists() == True && bFlag==TRUE)
				[ ] 
				[ ] // Add Checking Account
				[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
				[ ] // Report Status if checking Account is created
				[-] if (iAddAccount==PASS)
					[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
				[-] else
					[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is not created")
				[ ] 
				[ ] //  Verify that Account is shown on account bar
				[ ] 
				[ ] 
			[ ] // Report Status if Quicken is not launched
			[-] else
				[ ] ReportStatus("Validate Quicken Window", FAIL, "Either Quicken is not available or Data provided for add account is not correct") 
				[ ] bFlag=TRUE
		[-] except
			[ ] QuickenMainWindow.kill()
			[ ] QuickenMainWindow.Start (sStartQuicken)
			[ ] continue
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[ ] 
