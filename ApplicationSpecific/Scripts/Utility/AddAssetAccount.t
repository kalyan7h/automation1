[+] // FILE NAME:	<AddAssetAccount.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This Utility add Property accounts (House / Vehicle / Other Asset) in Quicken application as per the data provided through .xls file
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //
	[ ] // Developed on: 		28/4/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 April 28, 2011	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] 
[-] // Global variables
	[ ] public LIST OF ANYTYPE  lsExcelData
	[ ] INTEGER i,iCount,iPos,iSelect
	[ ] LIST OF STRING lsAddAccount,lsTransactionData
	[ ] public STRING sFileName = "AssetAccount"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sDataSheet = "AddAssetAccount"
	[ ] public STRING sAssetAccountSheet = "AssetAccount"
	[ ] public STRING sStartQuicken = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sInvestingTransactionWorksheet = "Add Transaction"
	[ ] // public STRING sDataSheet =  SYS_GetEnv("var1")
[ ] 
[+] //############### Create Asset Account ############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 AddAssetAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Property accounts (House / Vehicle / Other Asset) in Quicken application as per the data provided through .xls file
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if asset account is added 					
		[ ] //							Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	28/4/2011  	Created By	Udita Dube
		[ ] // 											
	[ ] //*********************************************************
[-] testcase AddAssetAccount () appstate none
	[ ] 
	[-] // Variable declaration
		[ ] STRING sHandle,sActual
		[ ] BOOLEAN bMatch,bFlag
		[ ] INTEGER iAddAccount,iSwitchState,iSetupAutoAPI,iCreateDataFile,j,jCount=0
		[ ] bFlag=TRUE
	[ ] 
	[-] // Perform Setup activities
		[+] if(QuickenMainWindow.Exists())
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
	[-] if (!QuickenMainWindow.Exists ())
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
	[ ] lsExcelData = ReadExcelTable(sDataSheet, sAssetAccountSheet)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] iSwitchState = UsePopupRegister("OFF")
	[ ] 
	[-] for(i=1;i<=iCount;i++)
		[ ] 
		[ ] lsAddAccount=lsExcelData[i]
		[ ] 
		[+] if(IsNULL(lsAddAccount[1]))
			[ ] ReportStatus("Add Asset Account", FAIL, "Please enter data for 'AccountType' column in {sDataSheet} > {sAssetAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[+] if(IsNULL(lsAddAccount[2]))
			[ ] ReportStatus("Add Asset Account", FAIL, "Please enter data for 'AccountName' column in {sDataSheet} > {sAssetAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[+] if(IsNULL(lsAddAccount[3]))
			[ ] ReportStatus("Add Asset Account", FAIL, "Please enter data for 'Date' column in {sDataSheet} > {sAssetAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[+] if(IsNULL(lsAddAccount[4]))
			[ ] ReportStatus("Add Asset Account", FAIL, "Please enter data for 'PurchasePrice' column in {sDataSheet} > {sAssetAccountSheet} sheet ")
			[ ] bFlag=FALSE
			[ ] 
		[+] if(IsNULL(lsAddAccount[6]))
			[ ] lsAddAccount[6]="Personal Transactions"
		[ ] 
		[ ] 
		[-] do
			[ ] 
			[ ] // Quicken is launched then Add Checking Account
			[-] if (QuickenMainWindow.Exists() == True && bFlag==TRUE)
				[ ] 
				[ ] // Add Asset Account (House)
				[ ] iAddAccount = AddPropertyAccount(lsAddAccount[1],  lsAddAccount[2], lsAddAccount[3], lsAddAccount[4], lsAddAccount[5],lsAddAccount[6],lsAddAccount[7],lsAddAccount[8],lsAddAccount[9])
				[ ] // Report Status if Asset Account is created
				[-] if (iAddAccount==PASS)
					[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is created successfully")
					[ ] 
				[+] else
					[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is not created")
					[ ] 
				[ ] 
				[ ] //  Verify that Account is shown on account bar
				[-] if(iAddAccount==PASS)
					[+] if(MatchStr("Rental Property*", lsAddAccount[6]))
						[ ] sHandle=Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer2.ListBox.GetHandle())
					[-] else if(MatchStr("Business*", lsAddAccount[6]))
						[ ] sHandle=Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetHandle())
					[-] else
						[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.GetHandle())
					[ ] 
					[-] for(j=0;j<iCount;j++)
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{j}")
						[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
						[-] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
							[ ] break
						[+] else if (j==iCount)
							[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
							[ ] 
						[-] else
							[ ] continue
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[1]} Asset Account", FAIL, "Verification has not been done as {lsAddAccount[1]} Asset Account -  {lsAddAccount[2]} is not created")
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
