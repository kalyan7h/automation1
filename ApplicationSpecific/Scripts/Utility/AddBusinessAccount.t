[+] // FILE NAME:	<AddBusinessAccount.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This Utility add Business Accounts in Quicken application as per the data provided through .xls file
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //
	[ ] // Developed on: 		02/5/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 May 02, 2011	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] 
[-] // Global variables
	[ ] public LIST OF ANYTYPE  lsExcelData
	[ ] INTEGER i,iCount,iPos,iSelect
	[ ] LIST OF STRING lsAddAccount,lsTransactionData
	[ ] public STRING sFileName = "BusinessAccount"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sDataSheet = "AddBusinessAccount"
	[ ] public STRING sBusinessAccountSheet = "BusinessAccount"
	[ ] public STRING sStartQuicken = "{QUICKEN_ROOT}\qw.exe"
[ ] 
[+] //############### Create Business Account ##########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 AddBusinessAccountUtility()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Business accounts (Accounts Payable / Accounts Receivable) in Quicken application as per the data provided through .xls file
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Business account is added 					
		[ ] //							Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	02/5/2011  	Created By	Udita Dube
		[ ] // 											
	[ ] //*********************************************************
[-] testcase AddBusinessAccountUtility () appstate none
	[ ] 
	[+] // Variable declaration
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
		[+] if(FileExists(sDataFile))
			[ ] DeleteFile(sDataFile)
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
	[ ] // Launch Quicken
	[+] if (!QuickenMainWindow.Exists ())
		[ ] QuickenMainWindow.Start (sStartQuicken)
	[ ] 
	[-] if (QuickenMainWindow.Exists(MEDIUM_SLEEP) == True)
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
	[ ] lsExcelData = ReadExcelTable(sDataSheet, sBusinessAccountSheet)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] iSwitchState = UsePopupRegister("OFF")
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[ ] lsAddAccount=lsExcelData[i]
		[ ] 
		[+] if(IsNULL(lsAddAccount[1]))
			[ ] ReportStatus("Add Business Account", FAIL, "Please enter data for 'AccountType' column in {sDataSheet} > {sBusinessAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[+] if(IsNULL(lsAddAccount[2]))
			[ ] ReportStatus("Add Business Account", FAIL, "Please enter data for 'AccountName' column in {sDataSheet} > {sBusinessAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[ ] 
		[ ] 
		[+] do
			[ ] 
			[ ] // Quicken is launched then Add Checking Account
			[+] if (QuickenMainWindow.Exists() == True && bFlag==TRUE)
				[ ] 
				[ ] // Add Business Account (House)
				[ ] iAddAccount = AddBusinessAccount(lsAddAccount[1],  lsAddAccount[2])
				[ ] // Report Status if Business Account is created
				[+] if (iAddAccount==PASS)
					[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[2]}  is created successfully")
					[ ] 
				[+] else
					[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[2]}  is not created")
					[ ] 
				[ ] 
				[ ] //  Verify that Account is shown on account bar
				[+] if(iAddAccount==PASS)
					[ ] sHandle=Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetHandle())
					[+] for(j=0;j<iCount;j++)
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{j}")
						[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
							[ ] break
						[+] else if (j==iCount)
							[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
							[ ] 
						[+] else
							[ ] continue
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[1]} Business Account", FAIL, "Verification has not been done as {lsAddAccount[1]} Business Account -  {lsAddAccount[2]} is not created")
					[ ] 
				[ ] 
				[ ] 
			[ ] // Report Status if Quicken is not launched
			[+] else
				[ ] ReportStatus("Validate Quicken Window", FAIL, "Either Quicken is not available or Data provided for add account is not correct") 
				[ ] bFlag=TRUE
		[+] except
			[ ] QuickenMainWindow.kill()
			[ ] QuickenMainWindow.Start (sStartQuicken)
			[ ] continue
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
