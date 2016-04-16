[+] // FILE NAME:	<AddBankingTransaction.t>
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
[-] // Global variables
	[ ] public LIST OF ANYTYPE  lsExcelData,lsExcelTransactionData
	[ ] INTEGER i,iCount,iPos,iSelect
	[ ] LIST OF STRING lsAddTransaction,lsTransactionData
	[ ] public STRING sFileName = "LargeDataFile_2013"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sDataSheet = "AddBankingTransaction"
	[ ] public STRING sBankingTransactionSheet = "BankingTransaction"
	[ ] public STRING sAccountSheet = "Account"
	[ ] public STRING sStartQuicken = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sInvestingTransactionWorksheet = "Add Transaction"
	[ ] // public STRING sDataSheet =  SYS_GetEnv("var1")
[ ] 
[-] //############### Create Banking Transaction ############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 AddBankingTransaction()
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
[-] testcase AddBankingTransaction () appstate none
	[ ] 
	[-] // Variable declaration
		[ ] STRING sHandle,sActual,sAccountName
		[ ] BOOLEAN bMatch,bFlag
		[ ] INTEGER iAddTransaction,iSwitchState,iSetupAutoAPI,iCreateDataFile,j,jCount
		[ ] bFlag=TRUE
	[ ] 
	[-] // Perform Setup activities
		[+] // if(QuickenMainWindow.Exists())
			[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
			[ ] // QuickenMainWindow.SetActive()
			[ ] // QuickenMainWindow.Exit()
		[ ] // 
		[ ] // sleep(SHORT_SLEEP)
		[ ] // 
		[+] // if(FileExists(sDataFile))
			[ ] // DeleteFile(sDataFile)
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
	[+] // if (QuickenMainWindow.Exists(MEDIUM_SLEEP) == True)
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // 
		[ ] // // Create Data File
		[ ] // iCreateDataFile = DataFileCreate(sFileName)
		[ ] // 
		[ ] // // Report Staus If Data file Created successfully
		[+] // if ( iCreateDataFile  == PASS)
			[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] // // Report Staus If Data file is not Created 
		[+] // else if ( iCreateDataFile ==FAIL)
			[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // // Report Staus If Data file already exists
		[+] // else
			[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
		[ ] // 
	[ ] // // Report Status if Quicken is not launched
	[+] // else
		[ ] // ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] // read excel table
	[ ] 
	[ ] lsExcelData = ReadExcelTable(sDataSheet, sAccountSheet)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] iSwitchState = UsePopupRegister("OFF")
	[ ] 
	[-] for(i=47;i<=48;)
		[ ] 
		[ ] 
		[ ] 
		[-] do
			[ ] 
			[ ] // Quicken is launched then Add Checking Account
			[-] if (QuickenMainWindow.Exists() == True && bFlag==TRUE)
				[ ] 
				[ ] // This will click  first Banking account on AccountBar
				[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, i)
				[ ] 
				[-] if(iSelect==PASS)
					[ ] 
					[ ] sActual= QuickenMainWindow.GetCaption()
					[-] if(i==47)
						[ ] sAccountName = lsExcelData[1][1]
					[-] else if (i==92)
						[ ] sAccountName = lsExcelData[3][1]
					[-] else
						[ ] sAccountName = lsExcelData[i][1]
					[ ] print(sAccountName)
					[ ] 
					[-] if( MatchStr("*{sAccountName}*", sActual))
						[ ] ReportStatus("Select Account", iSelect, "Account {lsExcelData[1]} is selected")
						[ ] lsExcelTransactionData = ReadExcelTable(sDataSheet, sBankingTransactionSheet)
						[ ] jCount=ListCount(lsExcelTransactionData)
						[ ] 
						[-] for(j=1;j<=jCount;j++)
							[ ] lsAddTransaction=lsExcelTransactionData[j]
							[+] if(IsNULL(lsAddTransaction[1]))
								[ ] ReportStatus("Add Banking Account", FAIL, "Please enter data for 'AccountType' column in {sDataSheet} > {sBankingTransactionSheet} sheet ")
								[ ] bFlag=FALSE
								[ ] 
							[+] if(IsNULL(lsAddTransaction[2]))
								[ ] ReportStatus("Add Banking Account", FAIL, "Please enter data for 'AccountName' column in {sDataSheet} > {sBankingTransactionSheet} sheet ")
								[ ] bFlag=FALSE
								[ ] 
							[+] if(IsNULL(lsAddTransaction[3]))
								[ ] ReportStatus("Add Banking Account", FAIL, "Please enter data for 'Date' column in {sDataSheet} > {sBankingTransactionSheet} sheet ")
								[ ] bFlag=FALSE
								[ ] 
							[+] if(IsNULL(lsAddTransaction[4]))
								[ ] ReportStatus("Add Banking Account", FAIL, "Please enter data for 'PurchasePrice' column in {sDataSheet} > {sBankingTransactionSheet} sheet ")
								[ ] bFlag=FALSE
								[ ] 
							[ ] 
							[ ] // Add Banking Transaction
							[ ] iAddTransaction= AddCheckingTransaction(lsAddTransaction[1],lsAddTransaction[2], lsAddTransaction[3], lsAddTransaction[4],lsAddTransaction[5],lsAddTransaction[6],lsAddTransaction[7],lsAddTransaction[8],lsAddTransaction[9])
							[ ] 
							[ ] // Report Status if checking Account is created
							[+] if (iAddTransaction==PASS)
								[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsAddTransaction[2]} Transaction of Amount {lsAddTransaction[3]} is added")
							[+] else
								[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsAddTransaction[2]} Transaction of Amount {lsAddTransaction[3]} is added") 
							[ ] 
						[ ] 
						[ ] // i=i+46
						[+] // if(i==94)
							[ ] // i=i-2
						[ ] 
					[-]  else
						[ ] ReportStatus("Select Account", iSelect, "FAIL------- Account {sActual} is selected")
					[ ] 
				[+] else
					[ ] ReportStatus("Select Account", iSelect, "Account {lsExcelData[i][1]} is NOT selected") 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //  Verify that Account is shown on account bar
				[ ] 
				[ ] 
			[ ] // Report Status if Quicken is not launched
			[+] else
				[ ] ReportStatus("Validate Quicken Window", FAIL, "Either Quicken is not available or Data provided for add transaction is not correct") 
				[ ] bFlag=TRUE
		[-] except
			[ ] QuickenMainWindow.kill()
			[ ] QuickenMainWindow.Start (sStartQuicken)
			[ ] continue
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
