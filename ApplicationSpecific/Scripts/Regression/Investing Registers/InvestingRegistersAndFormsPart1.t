[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<InvestingRegistersAndFormsPart1.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all automated test cases for Investing Registers part of Investing Module for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  DEAN PAES
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 March 19, 2014	 Dean Paes  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[ ] 
[ ] 
[+] // Global variables 
	[ ] 
	[ ] 
	[ ] //--------------EXCEL DATA----------------
	[ ] // .xls file
	[ ] public STRING sInvestingRegisterExcelData="Investing_Registers"
	[ ] 
	[ ] //Excel WorkSheets
	[ ] public STRING sAllAccountsSheet="AllAccounts"
	[ ] public STRING sBankingAccountsSheet="BankingAccounts"
	[ ] 
	[ ] public STRING sInvestingAccountSheet="InvestingAccountSheet"
	[ ] public STRING sEnterTransactionsExpectedSheet="EnterTransactionOptions"
	[ ] public STRING sAccountOverviewSheet="AccountOverviewSnapshot"
	[ ] public STRING sInvestingReportsSheet="Reports"
	[ ] public STRING sSecurityListSheet="SecurityList"
	[ ] public STRING sBuyTransactionDataSheet="BuySellTransactionData"
	[ ] public STRING sTransactionValidationSheet="TransactionValidation"
	[ ] public STRING sLotsValidationSheet="LotsValidation"
	[ ] public STRING sStockSplitSheet ="StockSplit"
	[ ] public STRING sStockSplitValidationSheet="StockSplitValidation"
	[ ] public STRING sStockDividendSheet="StockDividend"
	[ ] public STRING sReInvestSheet="ReInvestTransactions"
	[ ] public STRING sReInvestValidationSheet="ReInvestValidation"
	[ ] public STRING sIncomeTransactionSheet="IncomeTransactions"
	[ ] public STRING sIncomeValidationSheet="IncomeValidation"
	[ ] 
	[ ] public STRING sReturnOfCapitalSheet="ReturnOfCapital"
	[ ] public STRING sReturnOfCapitalValidationSheet="ReturnOfCapitalValidation"
	[ ] 
	[ ] 
	[ ] public STRING sCashTransactionSheet="CashTransaction"
	[ ] public STRING sCashTransactionValidationSheet="CashTransactionValidation"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //----------STRING-------------------
	[ ] 
	[ ] public STRING sDataFile1="Investing_Register_WALL_User_Data_File.QDF"
	[ ] public STRING sDataFile2="Investing_Register_Data_File"
	[ ] 
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] public STRING sDate=ModifyDate(0,sDateFormat)
	[ ] 
	[ ] public STRING sMDIWindow="MDI"
	[ ] 
	[ ] public STRING sBrowser="$C:\Program Files\Internet Explorer\iexplore.exe"
	[ ] 
	[ ] STRING sHandle,sActual,sExpected,sFileName
	[ ] 
	[ ] STRING sOptionsText="Options"
	[ ] STRING sEditText="Edit"
	[ ] 
	[ ] 
	[ ] //---------LIST OF STRING-----------
	[ ] LIST OF STRING lsAddAccount,lsExpected,lsActual,lsSecurity,lsTransactionData,lsTransactionValidation
	[ ] 
	[ ] //---------LIST OF ANYTYPE-----------
	[ ] LIST OF ANYTYPE lsExcelData
	[ ] 
	[ ] 
	[ ] //------------------INTEGER----------------
	[ ] public INTEGER iValidate,iCount,jCount,iListCount,iResult
	[ ] 
	[ ] 
	[ ] //--------------BOOLEAN---------------
	[ ] public BOOLEAN bMatch,bMatch1,bMatch2
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] //---------------------------------------------------------- Customer Data File----------------------------------------------------------------------------------------
[ ] //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[ ] // 
[ ] 
[ ] 
[+] //########## Setup : Launch and convert data file created in an older version of Quicken ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test_Setup_Launch_And_Convert_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Launch and convert data file created in an older version of Quicken
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Data file is launched and converted without any error					
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th  March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test_Setup_Launch_And_Convert_Data_File() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] //Boolean
		[ ] BOOLEAN bSource,bVerify
		[ ] STRING sTempFile ="Temp.QDF"
		[ ] //Integer
		[ ] INTEGER iDataFileConversion
		[ ] 
		[ ] //String
		[ ] sFileName= "Investing_Register_WALL_User_Data_File"
		[ ] STRING sQuicken2012File = AUT_DATAFILE_PATH + "\"
		[ ] // STRING sQuicken2012File = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
		[ ] STRING sVersion="2012"
		[ ] STRING sQuicken2012Source = AUT_DATAFILE_PATH + "\DataFile\" + sFileName + ".QDF"
		[ ] STRING sQuicken2012FileCopy= AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] Sys_Execute("taskkill /f /im qw.exe",NULL,EM_CONTINUE_RUNNING )
		[ ] sleep(5)
		[ ] 
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
			[ ] bVerify=CopyFile(sQuicken2012Source, sQuicken2012FileCopy)
			[+] if(bVerify==TRUE)
				[ ] ReportStatus("2012 Data File Conversion",PASS,"File Copied successfully")
			[+] else
				[ ] ReportStatus("2012 Data File Conversion",FAIL,"File Not Copied to location")
		[ ] 
		[ ] 
		[ ] 
		[ ] Sys_Execute("{AUT_DATAFILE_PATH}\{sTempFile}",NULL,EM_CONTINUE_RUNNING)
		[ ] sleep(20)
		[+] if(ConvertYourData.Exists(LONG_SLEEP))
			[ ] ConvertYourData.SetActive()
			[ ] ConvertYourData.Close()
			[ ] 
		[ ] 
		[+] if(!QuickenWindow.Exists(5))
			[ ] LaunchQuicken()
			[ ] 
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
[ ] 
[ ] 
[+] //########## Verify that user can Access account via Account Bar in a converted data file ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Access_Account_Via_Account_Bar_In_A_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can Access account via account bar in a converted data file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can Access account via account bar in a converted data file		
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_Access_Account_Via_Account_Bar_In_A_Converted_Data_File() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[+] if (QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.VScrollBar.Exists())
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.VScrollBar.ScrollByLine(36)
			[ ] 
			[ ] // Select Account From Account Bar
			[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Verify Account name on Register
				[ ] sActual=QuickenMainWindow.QWNavigator1.AccountName.GetCaption()
				[+] if(sActual==lsAddAccount[1])
					[ ] ReportStatus("Verify if correct Account Selected from Account Bar",PASS,"Correct Account Register {lsAddAccount[1]} as actual {sActual} opened from Account Bar")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct Account Selected from Account Bar",FAIL," Account Register {lsAddAccount[1]} NOT as actual {sActual} when opened from Account Bar")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Quicken Home Tab",FAIL,"Error while navigating to Quicken Home Tab")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#####################################################################################################
[ ] 
[+] //########## Verify that user can Access account via Account List in a converted data file ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Access_Account_Via_Account_List_In_A_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can Access account via account list in a converted data file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can Access account via account list in a converted data file		
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_Access_Account_Via_Account_List_In_A_Converted_Data_File() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] //Launch Account List
			[ ] QuickenWindow.TypeKeys("<Ctrl-a>")
			[+] if(AccountList.Exists(5))
				[ ] 
				[ ] //Select Investing tab on account list
				[ ] AccountList.QWinChild.PersonalInvestments.Click()
				[ ] 
				[ ] 
				[ ] // Click on Account name in Account List
				[ ] AccountList.QWinChild.Order.TextClick(lsAddAccount[1])
				[ ] 
				[ ] //Verify Account name on Register
				[ ] sActual=QuickenMainWindow.QWNavigator1.AccountName.GetCaption()
				[+] if(sActual==lsAddAccount[1])
					[ ] ReportStatus("Verify if correct Account Selected from Account List",PASS,"Correct Account Register {lsAddAccount[1]} as actual {sActual} opened from Account List")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct Account Selected from Account List",FAIL," Account Register {lsAddAccount[1]} NOT as actual {sActual} when opened from Account List")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Close Account List
				[ ] QuickenWindow.TypeKeys("<Ctrl-a>")
				[ ] AccountList.Close()
				[ ] WaitForState(AccountList,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Quicken Home Tab",FAIL,"Error while navigating to Quicken Home Tab")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#####################################################################################################
[ ] 
[+] //##########  Verify that user can Access account via Investing Menu in a converted data file ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_Access_Account_Via_Investing_Menu_In_A_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can Access account via Investing menu in a converted data file 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can Access account via Investing menu in a converted data file 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  20th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_Access_Account_Via_Investing_Menu_In_A_Converted_Data_File() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] STRING sInvestingMenuName="_Investing"
		[ ] STRING sInvestingAccountMenuName="Investing _Accounts"
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=SetViewMode(VIEW_CLASSIC_MENU)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] //Select account from Investing accounts menu
				[ ] QuickenWindow.Investing.Click()
				[ ] QuickenWindow.Investing.InvestingAccounts.Click()
				[ ] QuickenWindow.MainMenu.Select("/{trim(sInvestingMenuName)}/{trim(sInvestingAccountMenuName)}/{trim(lsAddAccount[1])}*")
				[ ] 
				[ ] sleep(5)
				[ ] //Verify Account name on Register
				[ ] sActual=QuickenMainWindow.QWNavigator1.AccountName.GetCaption()
				[+] if(sActual==lsAddAccount[1])
					[ ] ReportStatus("Verify if correct Account Selected from Investing > Investing Accounts Menu",PASS,"Account Register {lsAddAccount[1]} is as actual {sActual} opened from Investing > Investing Accounts Menu")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct Account Selected from Investing > Investing Accounts Menu",FAIL," Account Register {lsAddAccount[1]} NOT as actual {sActual} when opened from Investing > Investing Accounts Menu")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Set view mode to Classic menus",FAIL,"Error while setting view mode to Classic menus")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Quicken Home Tab",FAIL,"Error while navigating to Quicken Home Tab")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[+] //#########################  Verify cash balance in a converted data file ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04B_Verify_Cash_Balance_In_A_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify cash balance in a converted data file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If cash balance in a converted data file is same as before conversion
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  20th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04B_Verify_Cash_Balance_In_A_Converted_Data_File() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] STRING sCashBalance="Cash Balance"
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] 
				[ ] 
				[ ] DlgAccountOverview.SetActive()
				[ ] sHandle=Str(DlgAccountOverview.ListBox2.GetHandle())
				[ ] 
				[+] for(iCount=0;iCount<=DlgAccountOverview.ListBox2.GetItemCount();iCount++)
					[ ] 
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] // Search for Cash Balance Text in Listbox
					[ ] bMatch1=MatchStr("*{sCashBalance}*",sActual)
					[+] if(bMatch1==TRUE)
						[ ] ReportStatus("Search for String Cash Balance",PASS,"String Cash Balance found")
						[ ] 
						[ ] // Search for Cash Balance Amount in Listbox
						[ ] bMatch2=MatchStr("*{lsAddAccount[3]}*",sActual)
						[+] if(bMatch2==TRUE)
							[ ] ReportStatus("Verify for String Cash Balance Amount",PASS,"Cash Balance amount {lsAddAccount[3]} verified correctly against actual {sActual}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify for String Cash Balance Amount",FAIL,"Cash Balance amount {lsAddAccount[3]} not matched with actual {sActual}")
							[ ] 
							[ ] 
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
					[ ] 
				[+] if(bMatch1==FALSE)
					[ ] ReportStatus("Search for String Cash Balance",FAIL,"String Cash Balance NOT found in Listbox")
					[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[+] //#######################  Verify components of Holding snapshot  ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_Verify_Components_Of_Holding_Snapshot_In_A_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if following components exist in Holding snapshot
		[ ] // 1. Holdings Snapshot
		[ ] // 2. Account Status Snapshot
		[ ] // 3. Account Attributes Snapshot
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If components of Holding snapshot all exists
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  20th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test05_Verify_Components_Of_Holding_Snapshot_In_A_Converted_Data_File() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] STRING sCashBalance="Cash Balance"
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] 
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] 
				[ ] //Verify if Holding Snapshot exists
				[+] if(DlgAccountOverview.ListBox1.Exists(5))
					[ ] ReportStatus("Verify if Holding Snapshot exists",PASS,"Holding Snapshot exists")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Holding Snapshot exists",FAIL,"Holding Snapshot does NOT exists")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Verify if Account Status Snapshot exists
				[+] if(DlgAccountOverview.ListBox2.Exists(5))
					[ ] ReportStatus("Verify if Account Status Snapshot exists",PASS,"Account Status Snapshot exists")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Status Snapshot exists",FAIL,"Account Status Snapshot does NOT exists")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Verify if Account Attributes Snapshot exists
				[+] if(DlgAccountOverview.ListBox3.Exists(5))
					[ ] ReportStatus("Verify if Account Attributes Snapshot exists",PASS,"Account Attributes Snapshot exists")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Attributes Snapshot exists",FAIL,"Account Attributes Snapshot does NOT exists")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[+] //#######################  Verify components of Holding snapshot  #############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_Verify_Single_Mutual_Fund_Account_Enter_Transaction_Actions_In_A_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if following options exist for Single Mutual Fund account in a converted data file
		[ ] // Buy - Shares Bought
		[ ] // Sell - Shares Sold
		[ ] // Div - Stock Dividend (non-cash)
		[ ] // Reinvest - Income Reinvested
		[ ] // Inc - Income (Div, Int, etc.)
		[ ] // Add - Shares Added
		[ ] // Remove - Shares Removed
		[ ] // Adjust Share Balance
		[ ] // Stock Split
		[ ] // Return of Capital
		[ ] // Shares Transferred Between Accounts
		[ ] // Mutual Fund Name Change
		[ ] // Reminder Transaction
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all expected options exist for Holding snapshot all exists
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  20th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_Verify_Single_Mutual_Fund_Account_Enter_Transaction_Actions_In_A_Converted_Data_File() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsSingleMutualFundOptions
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[2]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sEnterTransactionsExpectedSheet)
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // Click on Enter Transactions button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] // Verify if Enter Transactions exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transactions dialog exists",PASS,"Enter Transactions dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] //Actual Values
				[ ] lsSingleMutualFundOptions=wEnterTransaction.EnterTransaction.GetContents()
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] wEnterTransaction.Close()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] // Match Actual and Expected values
				[+] for(iCount=1;iCount<=ListCount(lsSingleMutualFundOptions);iCount++)
					[ ] 
					[ ] //Expected Values
					[ ] lsExpected=lsExcelData[iCount]
					[ ] 
					[ ] 
					[+] if(lsSingleMutualFundOptions[iCount]==lsExpected[1])
						[ ] ReportStatus("Verify contents for Enter Transaction options for Single Mutual fund account",PASS,"Enter Transaction options for Single Mutual fund account {lsSingleMutualFundOptions[iCount]} match with expected {lsExpected[1]}")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify contents for Enter Transaction options for Single Mutual fund account",FAIL,"Enter Transaction options for Single Mutual fund account {lsSingleMutualFundOptions[iCount]} does NOT match with expected {lsExpected[1]}")
						[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transactions dialog exists",FAIL,"Enter Transactions dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#########################  Verify Account Attributes snapshot  ###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_Verify_Account_Attributes_Snapshot_In_A_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify contents of Account Attributes snapshot in a converted data file
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all expected options exist for Account Attributes snapshot exist
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test08_20_21_Verify_Account_Attributes_Snapshot_In_A_Converted_Data_File() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] 
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] //Scroll to Bottom so Account Attributes is present
				[+] if(DlgAccountOverview.AccountStatusFrame.VScrollBar.Exists())
					[ ] DlgAccountOverview.AccountStatusFrame.VScrollBar.ScrollToMax()
				[ ] 
				[ ] 
				[ ] //Verify Edit Account Details Button
				[+] if(DlgAccountOverview.EditAccountDetailsButton.Exists(5))
					[ ] ReportStatus("Verify if Edit Account Details Button is present",PASS,"Edit Account Details Button is present")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Edit Account Details Button is present",FAIL,"Edit Account Details Button is NOT present")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Verify Change Online Services Button
				[+] if(DlgAccountOverview.ChangeOnlineServices.Exists(5))
					[ ] ReportStatus("Verify if Change Online Services Button is present",PASS,"Change Online Services Button is present")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Change Online Services Button is present",FAIL,"Change Online Services Button is NOT present")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify if Account Attributes Snapshot exists
				[+] if(DlgAccountOverview.ListBox3.Exists(5))
					[ ] ReportStatus("Verify if Account Attributes Snapshot exists",PASS,"Account Attributes Snapshot exists")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify ListBox contents
					[ ] sHandle=Str(DlgAccountOverview.ListBox3.GetHandle())
					[+] for(iCount=0;iCount<=DlgAccountOverview.ListBox3.GetItemCount()-1;iCount++)
						[ ] 
						[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sAccountOverviewSheet)
						[ ] lsExpected=lsExcelData[iCount+1]
						[ ] 
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
						[ ] 
						[ ] bMatch=MatchStr("*{lsExpected[1]}*{lsExpected[2]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Account Attribute contents",PASS,"Account Attribute contents {lsExpected[1]}:{lsExpected[2]} match with {sActual}")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account Attribute contents",FAIL,"Account Attribute contents {lsExpected[1]}:{lsExpected[2]} does NOT match with {sActual}")
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
					[ ] ReportStatus("Verify if Account Attributes Snapshot exists",FAIL,"Account Attributes Snapshot does NOT exists")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#########################  Verify Account Status snapshot  #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_Verify_Account_Status_Snapshot_In_A_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify contents of Account Status snapshot in a converted data file
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If contents of Account Status snapshot all exist
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test09_Verify_Account_Status_Snapshot_In_A_Converted_Data_File() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] 
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] //Scroll to Bottom so Account Attributes is present
				[+] if(DlgAccountOverview.AccountStatusFrame.VScrollBar.Exists())
					[ ] DlgAccountOverview.AccountStatusFrame.VScrollBar.ScrollToMax()
				[ ] 
				[ ] 
				[ ] //Verify if Account Attributes Snapshot exists
				[+] if(DlgAccountOverview.ListBox2.Exists(5))
					[ ] ReportStatus("Verify if Account Attributes Snapshot exists",PASS,"Account Attributes Snapshot exists")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify ListBox contents
					[ ] sHandle=Str(DlgAccountOverview.ListBox2.GetHandle())
					[+] for(iCount=0;iCount<=DlgAccountOverview.ListBox2.GetItemCount()-1;iCount++)
						[ ] 
						[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sAccountOverviewSheet)
						[ ] lsExpected=lsExcelData[iCount+1]
						[ ] 
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
						[ ] 
						[ ] bMatch=MatchStr("*{lsExpected[3]}*{lsExpected[4]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Account Attribute contents",PASS,"Account Attribute contents {lsExpected[1]}:{lsExpected[2]} match with {sActual}")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account Attribute contents",FAIL,"Account Attribute contents {lsExpected[1]}:{lsExpected[2]} does NOT match with {sActual}")
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
					[ ] ReportStatus("Verify if Account Attributes Snapshot exists",FAIL,"Account Attributes Snapshot does NOT exists")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#########################  Verify Show Performance View   #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_Verify_Performance_View_Tab_In_A_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Show Performance View in a converted data file
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Performance View is opened
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test12_Verify_Performance_View_Tab_In_A_Converted_Data_File() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] // Navigate To Performance View
		[ ] NavigateQuickenTab(sTAB_INVESTING,sTAB_PERFORMANCE)
		[+] if(MDIClient.Investing.Panel.StaticText1.PortfolioCashBasisComparisionGraph.Exists(5))
			[ ] ReportStatus("Navigate to Performance View",PASS,"Navigated to Performance View on Investing Tab")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Performance View",FAIL,"Navigation to Performance tab NOT successful")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[ ] //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[ ] 
[ ] // 
[ ] // 
[ ] // 
[ ] // ////Open Data File 2
[ ] // 
[ ] 
[+] //#########################  Setup : Open Investing Data File in Quicken  ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test_Setup_Open_Investing_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Launch and convert data file created in an older version of Quicken
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Data file is launched and converted without any error					
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th  March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test_Setup_Open_Investing_Data_File() appstate QuickenExceptionBaseState
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
		[ ] sFileName= "Investing_Reg1"
		[ ] STRING sQuicken2012File = AUT_DATAFILE_PATH + "\"
		[ ] STRING sVersion="2012"
		[ ] STRING sQuicken2012Source = AUT_DATAFILE_PATH + "\DataFile\" + sFileName + ".QDF"
		[ ] STRING sQuicken2012FileCopy= AUT_DATAFILE_PATH + "\"  + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
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
			[ ] bVerify=CopyFile(sQuicken2012Source, sQuicken2012FileCopy)
			[+] if(bVerify==TRUE)
				[ ] ReportStatus("2012 Data File Conversion",PASS,"File Copied successfully")
			[+] else
				[ ] ReportStatus("2012 Data File Conversion",FAIL,"File Not Copied to location")
		[ ] 
		[ ] iDataFileConversion=DataFileConversion(sFileName,sVersion,"",sQuicken2012File)
		[+] if (iDataFileConversion==PASS)
			[ ] ReportStatus("2012 Data File Conversion",PASS,"File: {sFileName} Converted from 2012 to current version")
		[+] else
			[ ] ReportStatus("2012 Data File Conversion",FAIL,"File: {sFileName} couldn't be Converted from 2012 to current version")
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
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] //######################  Verify Update Options Button on Portfolio view  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_Verify_Update_Options_Button_On_Portfolio_View_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Update Options Button on Portfolio view  in a converted data file
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can select all options under Update options button
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13_Verify_Update_Options_Button_On_Investing_Tab() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] INTEGER iMenuItemCount=4
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] // Navigate To Performance View
		[ ] iValidate=NavigateQuickenTab(sTAB_INVESTING)
		[+] if(iValidate==PASS)
			[ ] //ReportStatus("Navigate to Performance View",PASS,"Navigate to Investing Tab")
			[ ] 
			[ ] 
			[+] for(iCount=1;iCount<=iMenuItemCount;iCount++)
				[ ] QuickenWindow.SetActive()
				[ ] //Click on Update menu and navigate to option
				[ ] QuickenMainWindow.QWNavigator1.Update.Click()
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.Update.Click()
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,iCount))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] 
				[+] switch iCount
					[ ] 
					[ ] 
					[+] case 1
						[ ] 
						[+] if(QuickenUpdateStatus.Exists(5))
							[ ] ReportStatus("Verfy if Quicken Update Status window is displayed",PASS,"Quicken Update Status window is displayed for Quotes option")
							[ ] sleep(10)
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Quicken Update Status window is displayed",FAIL,"Quicken Update Status window is NOT displayed for Quotes option")
							[ ] 
							[ ] 
					[ ] 
					[ ] 
					[+] case 2
						[ ] 
						[+] if(GetHistoricalPrices.Exists(5))
							[ ] ReportStatus("Verfy if Get Historical Prices dialog is displayed",PASS,"Get Historical Prices dialog is displayed")
							[ ] 
							[ ] GetHistoricalPrices.Close()
							[ ] WaitForState(GetHistoricalPrices,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Get Historical Prices dialog is displayed",FAIL,"Get Historical Prices dialog is NOT displayed")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[+] case 3
						[ ] 
						[+] if(Preferences.Exists(5))
							[ ] ReportStatus("Verfy if Preferences dialog is displayed",PASS,"Preferences dialog is displayed")
							[ ] 
							[ ] Preferences.Close()
							[ ] WaitForState(Preferences,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Preferences dialog is displayed",FAIL,"Preferences dialog is NOT displayed")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[+] case 4
						[ ] 
						[+] if(OneStepUpdate.Exists(5))
							[ ] ReportStatus("Verfy if One Step Update dialog is displayed",PASS,"One Step Update dialog is displayed")
							[ ] 
							[ ] OneStepUpdate.Close()
							[ ] WaitForState(OneStepUpdate,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if One Step Update dialog is displayed",FAIL,"One Step Update dialog is NOT displayed")
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
			[ ] ReportStatus("Navigate to Performance View",FAIL,"Did NOT Navigate to Investing tab")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //######################  Verify Tools Button on Portfolio view  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_Verify_Tools_Options_Button_On_Investing_Tab_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Tools Button on Portfolio view  in a converted data file
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can select all options under Tools button
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test14_Verify_Tools_Options_Button_On_Investing_Tab() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] INTEGER iMenuItemCount=4
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
		[ ] // Navigate To Performance View
		[ ] iValidate=NavigateQuickenTab(sTAB_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Navigate to Performance View",PASS,"Navigate to Investing Tab")
			[ ] 
			[ ] 
			[+] for(iCount=1;iCount<=iMenuItemCount;iCount++)
				[ ] 
				[ ] //Click on Tools button and navigate to option
				[ ] QuickenMainWindow.QWNavigator1.Tools.DoubleClick()
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,iCount))
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] 
				[+] switch iCount
					[ ] 
					[ ] 
					[+] case 1
						[ ] 
						[+] if(SecurityList.Exists(5))
							[ ] ReportStatus("Verfy if Security List dialog is displayed",PASS,"Security List dialog is displayed")
							[ ] 
							[ ] 
							[ ] SecurityList.Close()
							[ ] WaitForState(SecurityList,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Security List dialog is displayed",FAIL,"Security List dialog is NOT displayed")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[+] case 2
						[ ] 
						[+] if(AssetAllocationGuide.Exists(5))
							[ ] ReportStatus("Verfy if Asset Allocation Guide dialog is displayed",PASS,"Asset Allocation Guide dialog is displayed")
							[ ] 
							[ ] AssetAllocationGuide.Close()
							[ ] WaitForState(AssetAllocationGuide,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Asset Allocation Guide dialog is displayed",FAIL,"Asset Allocation Guide dialog is NOT displayed")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[+] case 3
						[ ] 
						[+] if(BuySellPreview.Exists(5))
							[ ] ReportStatus("Verfy if Buy Sell Preview dialog is displayed",PASS,"Buy Sell Preview dialog is displayed")
							[ ] 
							[ ] BuySellPreview.Close()
							[ ] WaitForState(BuySellPreview,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Buy Sell Preview dialog is displayed",FAIL,"Buy Sell Preview dialog is NOT displayed")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[+] case 4
						[ ] 
						[+] if(CapitalGainsEstimator.Exists(5))
							[ ] ReportStatus("Verfy if Capital Gains Estimator dialog is displayed",PASS,"Capital Gains Estimator dialog is displayed")
							[ ] 
							[ ] CapitalGainsEstimator.Close()
							[ ] WaitForState(CapitalGainsEstimator,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Capital Gains Estimator dialog is displayed",FAIL,"Capital Gains Estimator dialog is NOT displayed")
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
			[ ] ReportStatus("Navigate to Performance View",FAIL,"Did NOT Navigate to Investing tab")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //######################  Verify Reports Button on Portfolio view  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_Verify_Reports_Options_Button_On_Investing_Tab_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Reports Button on Portfolio view  in a converted data file
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can view all options under Reports button
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test15_Verify_Reports_Options_Button_On_Investing_Tab() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsReports
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] INTEGER iMenuItemCount=9
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] // Navigate To Performance View
		[ ] iValidate=NavigateQuickenTab(sTAB_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Navigate to Performance View",PASS,"Navigate to Investing Tab")
			[ ] 
			[ ] 
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingReportsSheet)
			[+] for(iCount=1;iCount<=iMenuItemCount;iCount++)
				[ ] 
				[ ] //Click on Reports button and navigate to option
				[ ] QuickenMainWindow.QWNavigator1.Reports.DoubleClick()
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,iCount))
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] 
				[ ] // Read account data from excel sheet
				[ ] lsReports=lsExcelData[iCount]
				[ ] 
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.Close()
					[ ] WaitForState(AlertMessage,FALSE,5)
					[ ] 
				[ ] 
				[+] if(wReport.Exists(5))
					[ ] wReport.SetActive()
					[ ] 
					[ ] sActual=wReport.GetCaption()
					[+] if(sActual==lsReports[1])
						[ ] ReportStatus("Verify if Report window is open",PASS,"Correct Report window {lsReports[1]} is opened {sActual}")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Report window is open",FAIL,"Correct Report window {lsReports[1]} is NOT opened {sActual}")
						[ ] 
						[ ] 
					[ ] wReport.Close()
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Report window is open",FAIL,"Report window for {lsReports[1]} is NOT opened from Reports button")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Performance View",FAIL,"Did NOT Navigate to Investing tab")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //######################  Verify Tools Button on Portfolio view  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_Verify_Right_Click_Menu_Options_On_Portfolio_View_Investing_Tab_Converted_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Tools Button on Portfolio view  in a converted data file
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can select all options under Tools button
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test16_Verify_Right_Click_Menu_Options_On_Portfolio_View_Investing_Tab() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] INTEGER iMenuItemCount=9
		[ ] STRING sStockName="Intuit Inc"
		[ ] 
		[ ] STRING sExpectedBrowserCaption="Intuit Services: Login"
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
		[ ] // Navigate To Performance View
		[ ] iValidate=NavigateQuickenTab(sTAB_INVESTING,sTAB_PORTFOLIO)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Navigate to Performance View",PASS,"Navigate to Investing Tab")
			[ ] 
			[ ] 
			[+] for(iCount=1;iCount<=iMenuItemCount;iCount++)
				[ ] 
				[ ] 
				[ ] MDIClient.Investing.PortfolioView.PortfolioGrid.TextClick(sStockName,NULL,CT_RIGHT)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,iCount))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] 
				[+] switch iCount
					[ ] 
					[+] case 1
						[ ] 
						[+] if(SecurityDetailView.Exists(5))
							[ ] ReportStatus("Verfy if Security Detail View dialog is displayed",PASS,"Security Detail View dialog is displayed")
							[ ] 
							[ ] 
							[ ] SecurityDetailView.Close()
							[ ] WaitForState(SecurityDetailView,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Security Detail View dialog is displayed",FAIL,"Security Detail View dialog is NOT displayed")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] case 2
						[ ] 
						[ ] 
						[ ] sleep(10)
						[+] if(QuickenBrowser.Exists(25))
							[ ] ReportStatus("Verify if Quicken Browser is launched",PASS,"Quicken Browser is launched")
							[ ] QuickenBrowser.SetActive()
							[ ] 
							[ ] sActual=QuickenBrowser.GetCaption()
							[ ] 
							[+] if(sActual==sExpectedBrowserCaption)
								[ ] ReportStatus("Verify if Browser window is open",PASS,"Browser window {sActual} is as per expected {sExpectedBrowserCaption}")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Browser window is open",FAIL,"Browser window {sActual} is not as per expected {sExpectedBrowserCaption}")
								[ ] 
								[ ] 
							[ ] 
							[ ] QuickenBrowser.Close()
							[ ] WaitForState(QuickenBrowser,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Quicken Browser is launched",FAIL,"Quicken Browser is NOT launched")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] case 3
						[ ] 
						[ ] sleep(10)
						[+] if(QuickenBrowser.Exists(25))
							[ ] ReportStatus("Verify if Quicken Browser is launched",PASS,"Quicken Browser is launched")
							[ ] QuickenBrowser.SetActive()
							[ ] 
							[ ] sActual=QuickenBrowser.GetCaption()
							[ ] 
							[+] if(sActual==sExpectedBrowserCaption)
								[ ] ReportStatus("Verify if Browser window is open",PASS,"Browser window {sActual} is as per expected {sExpectedBrowserCaption}")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Browser window is open",FAIL,"Browser window {sActual} is not as per expected {sExpectedBrowserCaption}")
								[ ] 
								[ ] 
							[ ] 
							[ ] QuickenBrowser.Close()
							[ ] WaitForState(QuickenBrowser,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Quicken Browser is launched",FAIL,"Quicken Browser is NOT launched")
						[ ] 
						[ ] 
					[ ] 
					[+] case 4
						[+] if(wReport.Exists(5))
							[ ] wReport.SetActive()
							[ ] 
							[ ] STRING sExpectedCaption="Security Report"
							[ ] 
							[ ] sActual=wReport.GetCaption()
							[+] if(sActual==sExpectedCaption)
								[ ] ReportStatus("Verify if Report window is open",PASS,"Correct Report window {sExpectedCaption} is opened {sActual}")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Report window is open",FAIL,"Correct Report window {sExpectedCaption} is NOT opened {sActual}")
								[ ] 
								[ ] 
							[ ] wReport.Close()
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Report window is open",FAIL,"Report window for {sExpectedCaption} is NOT opened from Reports button")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] case 5
						[+] if(EditSecurityDetails.Exists(5))
							[ ] ReportStatus("Verfy if Edit Security Details dialog is displayed",PASS,"Edit Security Details dialog is displayed")
							[ ] 
							[ ] EditSecurityDetails.Close()
							[ ] WaitForState(EditSecurityDetails,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Edit Security Details dialog is displayed",FAIL,"Edit Security Details dialog is NOT displayed")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] case 6
						[ ] 
						[ ] //Verify if Stock is added to watch list
						[ ] MDIClient.Investing.PortfolioView.PortfolioGrid.TextClick(sStockName,2)
						[ ] 
						[+] if(SecurityDetailView.Exists(5))
							[ ] ReportStatus("Click on Stock {sStockName} in watch list and verify if Security Detail View dialog is displayed",PASS,"Security Detail View dialog is displayed for Stock {sStockName} in watch list")
							[ ] 
							[ ] 
							[ ] SecurityDetailView.Close()
							[ ] WaitForState(SecurityDetailView,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Click on Stock {sStockName} in watch list and verify if Security Detail View dialog is displayed",PASS,"Security Detail View dialog is NOT displayed for Stock {sStockName} in watch list")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] case 7
						[+] if(EditPriceHistory.Exists(5))
							[ ] ReportStatus("Verfy if Price History dialog is displayed",PASS,"Price History dialog is displayed")
							[ ] 
							[ ] EditPriceHistory.Close()
							[ ] WaitForState(EditPriceHistory,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Price History dialog is displayed",FAIL,"Price History dialog is NOT displayed")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] case 8
						[+] if(AlertMessage.Exists(5))
							[ ] ReportStatus("Verfy if Delete Alert Message dialog is displayed",PASS,"Delete Alert Message dialog is displayed")
							[ ] 
							[ ] AlertMessage.Close()
							[ ] WaitForState(AlertMessage,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Delete Alert Message dialog is displayed",FAIL,"Delete Alert Message dialog is NOT displayed")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] case 9
						[ ] 
						[ ] 
						[+] if(AddSecurityToQuicken2.Exists(5))
							[ ] ReportStatus("Verfy if Add Security To Quicken dialog is displayed",PASS,"Add Security To Quicken dialog is displayed")
							[ ] 
							[ ] AddSecurityToQuicken2.Close()
							[ ] WaitForState(AddSecurityToQuicken2,FALSE,5)
							[ ] 
						[+] else
							[ ] ReportStatus("Verfy if Add Security To Quicken dialog is displayed",FAIL,"Add Security To Quicken dialog is NOT displayed")
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
			[ ] ReportStatus("Navigate to Performance View",FAIL,"Did NOT Navigate to Investing tab")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
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
[ ] //#######################################################################################################
[ ] // 
[+] //#################### Verify Account Attributes Options Button On Account Overview Dialog  #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_Verify_Account_Attributes_Options_Button_On_Account_Overview_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Account Attributes Options Button On Account Overview Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can select all  Account Attributes Options Button On Account Overview Dialog
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test17_Verify_Account_Attributes_Options_Button_On_Account_Overview_Dialog() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] STRING sCaption
		[ ] STRING sOptionsText="Options"
		[ ] STRING sUrl="www.google.com"
		[ ] INTEGER iMenuItemCount=6
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] //CHANGE LATER
				[+] for(iCount=1;iCount<=iMenuItemCount;iCount++)
					[ ] 
					[ ] //Click on Options button on Account Attributes Snapshot which is third occurence of 'Options button' in the Account Overview snapshot'
					[ ] DlgAccountOverview.AccountStatusFrame.TextClick(sOptionsText,4)
					[ ] DlgAccountOverview.TypeKeys(Replicate(KEY_DN,iCount))
					[ ] sleep(5)
					[ ] DlgAccountOverview.TypeKeys(KEY_ENTER)
					[ ] sleep(2)
					[ ] 
					[ ] 
					[+] switch iCount
						[ ] 
						[ ] 
						[+] case 1
							[ ] 
							[+] if(AddAnyAccount.Exists(5))
								[ ] ReportStatus("Verfy if Add Any Account window is displayed",PASS,"Add Any Account window is displayed")
								[ ] 
								[ ] 
								[ ] AddAnyAccount.Close()
								[ ] WaitForState(AddAnyAccount,FALSE,5)
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verfy if Add Any Account window is displayed",FAIL,"Add Any Account window is NOT displayed")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[ ] 
						[+] case 2
							[ ] 
							[+] if(AccountComments.Exists(5))
								[ ] ReportStatus("Verfy if Account Comments dialog is displayed",PASS,"Account Comments dialog is displayed")
								[ ] 
								[ ] 
								[ ] AccountComments.Close()
								[ ] WaitForState(AccountComments,FALSE,5)
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verfy if Account Comments dialog is displayed",FAIL,"Account Comments dialog is NOT displayed")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[ ] 
						[+] case 3
							[ ] 
							[+] if(TaxScheduleInformation.Exists(5))
								[ ] ReportStatus("Verfy if Tax Schedule Information dialog is displayed",PASS,"Tax Schedule Information dialog is displayed")
								[ ] 
								[ ] 
								[ ] TaxScheduleInformation.Close()
								[ ] WaitForState(TaxScheduleInformation,FALSE,5)
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verfy if Tax Schedule Information dialog is displayed",FAIL,"Tax Schedule Information dialog is NOT displayed")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[ ] 
						[+] case 4
							[ ] 
							[+] if(SetWebPages.Exists(5))
								[ ] ReportStatus("Verfy if Set Web Pages dialog is displayed",PASS,"Set Web Pages ialog is displayed")
								[ ] 
								[ ] SetWebPages.HomePageTextField.SetText(sUrl)
								[ ] SetWebPages.ActivityPageTextField.SetText(sUrl)
								[ ] SetWebPages.ExtraPageTextField.SetText(sUrl)
								[ ] 
								[ ] 
								[ ] SetWebPages.OK.Click()
								[ ] WaitForState(SetWebPages,FALSE,5)
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verfy if Set Web Pages dialog is displayed",FAIL,"Set Web Pages ialog is NOT displayed")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[+] // case 5
							[ ] // 
							[ ] // //Home Page
							[ ] // DlgAccountOverview.TypeKeys(KEY_RT)
							[ ] // DlgAccountOverview.TypeKeys(KEY_ENTER)
							[ ] // sleep(10)
							[ ] // sCaption=MainWin(sBrowser).GetCaption()
							[ ] // bMatch = MatchStr("*{sUrl}*", sCaption)
							[+] // if(bMatch == TRUE)
								[ ] // ReportStatus("Validate Home Page option", PASS, "{sUrl} for Home Page is opened in Browser")
							[+] // else
								[ ] // ReportStatus("Validate Home Page option", FAIL, "{sUrl} for Home Page is NOT opened in Browser")
								[ ] // 
								[ ] // 
							[ ] // MainWin(sBrowser).Close()
							[ ] // WaitForState(MainWin(sBrowser),FALSE,5)
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // //Activity Page
							[ ] // DlgAccountOverview.AccountStatusFrame.TextClick(sOptionsText,3)
							[ ] // DlgAccountOverview.TypeKeys(Replicate(KEY_DN,iCount))
							[ ] // DlgAccountOverview.TypeKeys(KEY_ENTER)
							[ ] // DlgAccountOverview.TypeKeys(KEY_RT)
							[ ] // DlgAccountOverview.TypeKeys(KEY_DN)
							[ ] // DlgAccountOverview.TypeKeys(KEY_ENTER)
							[ ] // sleep(10)
							[ ] // sCaption=MainWin(sBrowser).GetCaption()
							[ ] // bMatch = MatchStr("*{sUrl}*", sCaption)
							[+] // if(bMatch == TRUE)
								[ ] // ReportStatus("Validate Activity Page option", PASS, "{sUrl} for Activity Page is opened in Browser")
							[+] // else
								[ ] // ReportStatus("Validate Activity Page option", FAIL, "{sUrl} for Activity Page is NOT opened in Browser")
								[ ] // 
								[ ] // 
							[ ] // MainWin(sBrowser).Close()
							[ ] // WaitForState(MainWin(sBrowser),FALSE,5)
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // //Extra Page
							[ ] // DlgAccountOverview.AccountStatusFrame.TextClick(sOptionsText,3)
							[ ] // DlgAccountOverview.TypeKeys(Replicate(KEY_DN,iCount))
							[ ] // DlgAccountOverview.TypeKeys(KEY_ENTER)
							[ ] // DlgAccountOverview.TypeKeys(KEY_RT)
							[ ] // DlgAccountOverview.TypeKeys(KEY_DN)
							[ ] // DlgAccountOverview.TypeKeys(KEY_DN)
							[ ] // DlgAccountOverview.TypeKeys(KEY_ENTER)
							[ ] // sleep(10)
							[ ] // sCaption=MainWin(sBrowser).GetCaption()
							[ ] // bMatch = MatchStr("*{sUrl}*", sCaption)
							[+] // if(bMatch == TRUE)
								[ ] // ReportStatus("Validate Extra Page option", PASS, "{sUrl} for Extra Page is opened in Browser")
							[+] // else
								[ ] // ReportStatus("Validate Extra Page option", FAIL, "{sUrl} for Extra Page is NOT opened in Browser")
								[ ] // 
								[ ] // 
							[ ] // MainWin(sBrowser).Close()
							[ ] // WaitForState(MainWin(sBrowser),FALSE,5)
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
						[ ] 
						[+] case 5
							[ ] 
							[ ] DlgAccountOverview.TypeKeys(KEY_ESC)
							[ ] 
						[ ] 
						[+] case 6
							[ ] 
							[ ] 
							[+] if(TransactionFees.Exists(5))
								[ ] ReportStatus("Verfy if Transaction Fees dialog is displayed",PASS,"Transaction Fees dialog is displayed")
								[ ] 
								[ ] 
								[ ] TransactionFees.Close()
								[ ] WaitForState(TransactionFees,FALSE,5)
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verfy if Transaction Fees dialog is displayed",FAIL,"Transaction Fees dialog is NOT displayed")
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
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################### Verify Single Mutual fund option from Account Attributes snapshot  #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_Verify_Single_Mutual_Fund_Option_From_Account_Attributes_Snapshot()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Single Mutual fund option from Account Attributes snapshot
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Single Mutual fund option from Account Attributes snapshot is functional
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test18_Verify_Single_Mutual_Fund_Option_From_Account_Attributes_Snapshot() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] STRING sNoText="No"
		[ ] STRING sYesText="Yes"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] 
				[ ] // Search for No Text next to Single Mutual Fund Account
				[ ] sHandle=Str(DlgAccountOverview.ListBox3.GetHandle())
				[+] for(iCount=1;iCount<=DlgAccountOverview.ListBox3.GetItemCount();iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsAddAccount[2]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] bMatch=MatchStr("*{sNoText}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify that Account {lsAddAccount[1]} is not a Single Mutual Fund Account",PASS,"Account {lsAddAccount[1]} is not a Single Mutual Fund Account")
							[ ] break
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that Account {lsAddAccount[1]} is not a Single Mutual Fund Account",FAIL,"Account {lsAddAccount[1]} is a Single Mutual Fund Account")
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
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Search for text Single Mutual Fund Account in Account Attributes snapshot",FAIL,"Single Mutual Fund Account in Account Attributes snapshot of account {lsAddAccount[1]}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Convert Account to Single Mutual Fund Account
				[ ] //Click on No text next to Single Mutual Fund Account on Account Attributes Snapshot
				[ ] DlgAccountOverview.ListBox3.TextClick(sNoText,2)
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.Yes.Click()
					[ ] sleep(5)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Confirmation dialog appears",FAIL,"Confirmation dialog did NOT appear")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Search for Yes Text next to Single Mutual Fund Account
				[ ] sHandle=Str(DlgAccountOverview.ListBox3.GetHandle())
				[+] for(iCount=1;iCount<=DlgAccountOverview.ListBox3.GetItemCount();iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsAddAccount[2]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] bMatch=MatchStr("*{sYesText}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify that Account {lsAddAccount[1]} is not a Single Mutual Fund Account",PASS,"Account {lsAddAccount[1]} is not a Single Mutual Fund Account")
							[ ] break
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that Account {lsAddAccount[1]} is not a Single Mutual Fund Account",FAIL,"Account {lsAddAccount[1]} is a Single Mutual Fund Account")
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
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Search for text Single Mutual Fund Account in Account Attributes snapshot",FAIL,"Single Mutual Fund Account in Account Attributes snapshot of account {lsAddAccount[1]}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################### Verify Fail Single Mutual fund option from Account Attributes snapshot  #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_Verify_Fail_Single_Mutual_Fund_Option_From_Account_Attributes_Snapshot()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Fail Single Mutual fund option from Account Attributes snapshot
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Single Mutual fund option is failed if different types of shares/ cash balance is added
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test19_Verify_Fail_Single_Mutual_Fund_Option_From_Account_Attributes_Snapshot() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] STRING sNoText="No"
		[ ] STRING sYesText="Yes"
		[ ] STRING sSMF="Single Mutual Fund"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] 
				[ ] // Search for No Text next to Single Mutual Fund Account
				[ ] sHandle=Str(DlgAccountOverview.ListBox3.GetHandle())
				[+] for(iCount=1;iCount<=DlgAccountOverview.ListBox3.GetItemCount();iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{sSMF}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] bMatch=MatchStr("*{sNoText}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify that Account {lsAddAccount[1]} is not a Single Mutual Fund Account",PASS,"Account {lsAddAccount[1]} is not a Single Mutual Fund Account")
							[ ] break
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that Account {lsAddAccount[1]} is not a Single Mutual Fund Account",FAIL,"Account {lsAddAccount[1]} is a Single Mutual Fund Account")
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
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Search for text Single Mutual Fund Account in Account Attributes snapshot",FAIL,"Single Mutual Fund Account in Account Attributes snapshot of account {lsAddAccount[1]}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Convert Account to Single Mutual Fund Account
				[ ] //Click on No text next to Single Mutual Fund Account on Account Attributes Snapshot
				[ ] DlgAccountOverview.ListBox3.TextClick(sNoText,2)
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.Yes.Click()
					[ ] sleep(5)
					[ ] 
					[+] if(AlertMessage.Exists(5))
						[ ] ReportStatus("Verify that Fail dialog appears",PASS,"Fail dialog appears")
						[ ] AlertMessage.OK.Click()
						[ ] sleep(5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Fail dialog appears",FAIL,"Fail dialog did NOT appear")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Confirmation dialog appears",FAIL,"Confirmation dialog did NOT appear")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Search for Yes Text next to Single Mutual Fund Account
				[ ] sHandle=Str(DlgAccountOverview.ListBox3.GetHandle())
				[+] for(iCount=1;iCount<=DlgAccountOverview.ListBox3.GetItemCount();iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{sSMF}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] bMatch=MatchStr("*{sNoText}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify that Account {lsAddAccount[1]} is not a Single Mutual Fund Account",PASS,"Account {lsAddAccount[1]} is not a Single Mutual Fund Account")
							[ ] break
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that Account {lsAddAccount[1]} is not a Single Mutual Fund Account",FAIL,"Account {lsAddAccount[1]} is a Single Mutual Fund Account")
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
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Search for text Single Mutual Fund Account in Account Attributes snapshot",FAIL,"Single Mutual Fund Account in Account Attributes snapshot of account {lsAddAccount[1]}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] /// test22 Need to confirm the flow of single mutual fund account
[ ] 
[+] //####################### Verify Security Value From Account Status snapshot ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_Verify_Security_Value_From_Account_Status_Snapshot()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Security Value From Account Status snapshot
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Security Value is displayed on Account Status snapshot
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test22_Verify_Security_Value_From_Account_Status_Snapshot() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] STRING sSecurityValueText="Security Value", sSecurityValue
		[ ] BOOLEAN bValue=FALSE
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] 
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] 
				[ ] // Search for No Text next to Single Mutual Fund Account
				[ ] sHandle=Str(DlgAccountOverview.ListBox2.GetHandle())
				[ ] iListCount=DlgAccountOverview.ListBox2.GetItemCount()
				[+] for(iCount=0;iCount<=iListCount;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] print(sActual)
					[ ] bMatch=MatchStr("*{sSecurityValueText}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] sSecurityValue=StrTran(sActual,"Security Value@@","")
						[ ] //Close Account Overview dialog
						[ ] DlgAccountOverview.Close()
						[ ] WaitForState(DlgAccountOverview,FALSE,5)
						[ ] 
						[ ] //Launch account overview 
						[ ] NavigateToAccountActionInvesting(12,"MDI")
						[+] if(DlgAccountOverview.Exists(5))
							[ ] DlgAccountOverview.SetActive()
							[ ] iListCount=DlgAccountOverview.ListBox2.GetItemCount()
							[ ] sHandle=Str(DlgAccountOverview.ListBox2.GetHandle())
							[+] for(iCount=0;iCount<=iListCount;iCount++)
								[ ] 
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
								[ ] bValue=MatchStr("*{sSecurityValue}*",sActual)
								[+] if(bValue==TRUE)
									[ ] break
							[+] if(bValue)
								[ ] ReportStatus("Search for text Security Values in Account Status on Account Overview",PASS,"Security Value on Account overview:{sActual} is same as on Holdings: {sSecurityValue}")
							[+] else
								[ ] ReportStatus("Search for text Security Values in Account Status on Account Overview",FAIL,"Security Value on Account overview:{sActual} is NOT same as on Holdings: {sSecurityValue}")
							[ ] //Close Account Overview dialog
							[ ] DlgAccountOverview.Close()
							[ ] WaitForState(DlgAccountOverview,FALSE,5)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
						[ ] break
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Search for text Security Values in Account Status",FAIL,"Text Security Value NOT found in Account Status on Holdings ")
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
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //####################### Verify Linked Checking Account From Account Status Snapshot #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_Verify_Linked_Checking_Account_From_Account_Status_Snapshot()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Security Value From Account Status snapshot
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Security Value is displayed on Account Status snapshot
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test7_Verify_Linked_Checking_Account_From_Account_Status_Snapshot() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] STRING sLinkedBalanceText="Linked Cash Balance"
		[ ] INTEGER iResult
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] //link brokerage account with checking account
			[ ] iResult=NavigateToAccountDetails(lsAddAccount[1])
			[+] if(iResult==PASS)
				[ ] AccountDetails.SetActive()
				[ ] AccountDetails.ShowCashInACheckingAccount.Click()
				[ ] AccountDetails.OK.Click()
				[ ] //wait till cash account activates
				[ ] sleep(5)
				[ ] // Click on Holdings button
				[ ] MDIClient.BrokerageAccount.Holdings.Click()
				[ ] // Verify if Account Overview exists
				[+] if(DlgAccountOverview.Exists(5))
					[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
					[ ] 
					[ ] DlgAccountOverview.SetActive()
					[ ] 
					[ ] 
					[ ] // Search for Linked Cash Balance Text on Account Status
					[ ] sHandle=Str(DlgAccountOverview.ListBox2.GetHandle())
					[+] for(iCount=0;iCount<=DlgAccountOverview.ListBox2.GetItemCount();iCount++)
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
						[ ] 
						[ ] bMatch=MatchStr("*{sLinkedBalanceText}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] 
							[ ] bMatch=MatchStr("*{lsAddAccount[4]}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify that Linked Account Cash Balance is displayed in Account Status snapshot",PASS,"Linked Account Cash Balance {lsAddAccount[5]} for account {lsAddAccount[1]} is displayed in Account Status snapshot {lsAddAccount[1]} is displayed correctly {sActual}")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that Linked Account Cash Balance is displayed in Account Status snapshot",FAIL,"Linked Account Cash Balance {lsAddAccount[5]} for account {lsAddAccount[1]} is displayed in Account Status snapshot {lsAddAccount[1]} is NOT displayed correctly {sActual}")
								[ ] 
								[ ] 
							[ ] break
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Search for Linked Cash Balance Text on Account Status",FAIL,"Linked Cash Balance Text NOT found in Account Status ")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //Close Account Overview dialog
					[ ] DlgAccountOverview.Close()
					[ ] WaitForState(DlgAccountOverview,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Account Details window", FAIL, "Account Details window is not opened")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //################################# Verify Holding snapshot filters ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_11_Verify_Holdings_Snapshot_Filters_And_Balances_From_Account_Overview()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Holdings Snapshot Filters And Balances From Account Overview
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Holdings Snapshot Filters And Balances From Account Overview are correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  1st April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test10_11_Verify_Holdings_Snapshot_Filters_And_Balances_From_Account_Overview() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[6]
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] //STRING sLinkedBalanceText="Linked Cash Balance"
		[ ] LIST OF STRING lsActualString  //,lsAmount
		[ ] STRING sDelim="@"
		[ ] 
		[ ] STRING sActualAmount
		[ ] //INTEGER iActualAmount=0
		[ ] 
		[ ] NUMBER nActualAmount=0
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Return value of Register Amount 
			[ ] //MDIClient.BrokerageAccount.
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] 
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] 
				[ ] // Search for Linked Cash Balance Text on Account Status
				[ ] 
				[ ] DlgAccountOverview.ListBox1.Click(1,27,15)
				[ ] sleep(5)
				[ ] sHandle=Str(DlgAccountOverview.ListBox1.GetHandle())
				[+] for(iCount=1;iCount<=DlgAccountOverview.ListBox1.GetItemCount()-1;iCount++)
					[ ] 
					[ ] // Calculate value of Actual Amount of lots displayed in Holdings snapshot (Listbox)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] lsActualString=ParseString(sActual,sDelim)
					[ ] 
					[ ] nActualAmount=nActualAmount+val(lsActualString[5])
					[ ] 
					[ ] sActualAmount=Str(nActualAmount,NULL,2)
					[ ] 
					[ ] print(sActualAmount)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //print(Str(lsActualString[5],NULL,2))
					[ ] 
					[ ] 
					[ ] // iActualAmount=iActualAmount + val(lsActualString[5])
					[ ] // print(iActualAmount)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] // bMatch=MatchStr("*{sLinkedBalanceText}*",sActual)
					[+] // if(bMatch==TRUE)
						[ ] // 
						[ ] // bMatch=MatchStr("*{lsAddAccount[5]}*",sActual)
						[+] // if(bMatch==TRUE)
							[ ] // ReportStatus("Verify that Linked Account Cash Balance is displayed in Account Status snapshot",PASS,"Linked Account Cash Balance {lsAddAccount[5]} for account {lsAddAccount[1]} is displayed in Account Status snapshot {lsAddAccount[1]} is displayed correctly {sActual}")
							[ ] // break
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify that Linked Account Cash Balance is displayed in Account Status snapshot",FAIL,"Linked Account Cash Balance {lsAddAccount[5]} for account {lsAddAccount[1]} is displayed in Account Status snapshot {lsAddAccount[1]} is NOT displayed correctly {sActual}")
							[ ] // 
							[ ] // 
						[ ] // 
						[ ] // 
					[ ] 
					[ ] 
					[ ] 
				[+] // if(bMatch==FALSE)
					[ ] // ReportStatus("Search for Linked Cash Balance Text on Account Status",FAIL,"Linked Cash Balance Text NOT found in Account Status ")
					[ ] // 
					[ ] // 
					[ ] // 
					[ ] // 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################### Verify Last Reconcile link  from Account Attributes snapshot  ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_Verify_Last_Reconcile_Link_From_Account_Attributes_Snapshot()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Last Reconcile link  from Account Attributes snapshot
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Reconcile dialog is launched
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test24_Verify_Last_Reconcile_Link_From_Account_Attributes_Snapshot() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] STRING sReconcileText="None"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] 
				[ ] //Click on Reconcile Text "None" on Account Status snapshot
				[ ] DlgAccountOverview.ListBox2.TextClick(sReconcileText)
				[+] if(ReconcileDetails.Exists(5))
					[ ] ReportStatus("Verify that Reconcile Details dialog appears",PASS,"Reconcile Details dialog appears")
					[ ] 
					[ ] sActual=ReconcileDetails.GetCaption()
					[ ] 
					[ ] bMatch=MatchStr("*{lsAddAccount[1]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify that Reconcile details is open for correct account",PASS,"Reconcile details window is open for correct Account {lsAddAccount[1]}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Reconcile details is open for correct account",FAIL,"Reconcile details window is NOT open for correct Account {lsAddAccount[1]} , actual is {sActual}")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] ReconcileDetails.Close()
					[ ] WaitForState(ReconcileDetails,FALSE,5)
				[+] else
					[ ] ReportStatus("Verify that Reconcile Details dialog appears",FAIL,"Reconcile Details dialog did NOT appear")
					[ ] 
				[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //#################### Verify Reconcile on Account Status options  #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_Verify_Reconcile_On_Account_Status_Options_From_Account_Attributes_Snapshot()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Reconcile on Account Status options  from Account Attributes snapshot
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Reconcile dialog is launched
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th March 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test25_Verify_Reconcile_On_Account_Status_Options_From_Account_Attributes_Snapshot() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] STRING sReconcileText="None"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] //CHANGE LATER
				[ ] DlgAccountOverview.AccountStatusFrame.TextClick(sOptionsText,3)
				[ ] DlgAccountOverview.TypeKeys(KEY_DN)
				[ ] DlgAccountOverview.TypeKeys(KEY_ENTER)
				[ ] 
				[+] if(ReconcileDetails.Exists(5))
					[ ] ReportStatus("Verify that Reconcile Details dialog appears",PASS,"Reconcile Details dialog appears")
					[ ] 
					[ ] sActual=ReconcileDetails.GetCaption()
					[ ] 
					[ ] bMatch=MatchStr("*{lsAddAccount[1]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify that Reconcile details is open for correct account",PASS,"Reconcile details window is open for correct Account {lsAddAccount[1]}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Reconcile details is open for correct account",FAIL,"Reconcile details window is NOT open for correct Account {lsAddAccount[1]} , actual is {sActual}")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] ReconcileDetails.Close()
					[ ] WaitForState(ReconcileDetails,FALSE,5)
				[+] else
					[ ] ReportStatus("Verify that Reconcile Details dialog appears",FAIL,"Reconcile Details dialog did NOT appear")
					[ ] 
				[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#####################################################################################################
[ ] 
[+] //#################### Verify View All Accounts on Account Status options  ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test26_Verify_View_All_Accounts_From_Account_Status_Options_From_Account_Attributes_Snapshot()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify View All Accounts on Account Status options  from Account Attributes snapshot
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Account List is launched
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  9th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test26_Verify_View_All_Accounts_From_Account_Status_Options_From_Account_Attributes_Snapshot() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] STRING sReconcileText="None"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Holdings button
			[ ] MDIClient.BrokerageAccount.Holdings.Click()
			[ ] // Verify if Account Overview exists
			[+] if(DlgAccountOverview.Exists(5))
				[ ] ReportStatus("Verify if Account Overview dialog exists",PASS,"Account Overview dialog exists")
				[ ] DlgAccountOverview.SetActive()
				[ ] 
				[ ] //CHANGE LATER
				[ ] DlgAccountOverview.AccountStatusFrame.TextClick(sOptionsText,3)
				[ ] DlgAccountOverview.TypeKeys(Replicate(KEY_DN,2))
				[ ] DlgAccountOverview.TypeKeys(KEY_ENTER)
				[ ] 
				[+] if(AccountList.Exists(5))
					[ ] ReportStatus("Verify that Account List dialog appears",PASS,"Account List dialog opens")
					[ ] 
					[ ] AccountList.Close()
					[ ] WaitForState(AccountList,FALSE,5)
				[+] else
					[ ] ReportStatus("Verify that Account List dialog appears",FAIL,"Account List dialog does NOT open")
					[ ] 
				[ ] 
				[ ] 
				[ ] //Close Account Overview dialog
				[ ] DlgAccountOverview.Close()
				[ ] WaitForState(DlgAccountOverview,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Account Overview dialog exists",FAIL,"Account Overview dialog did NOT open")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################### Verify Account Value and cost filters from Performance view   ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_Account_Value_And_Cost_Filters_Performance_Tab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Account Value and cost filters from Performance view for a single account
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Account Value and cost filters from Performance view for a single account display the correct balances
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  10th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test27_Account_Value_And_Cost_Filters_Performance_Tab() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] STRING sAccountName
		[ ] LIST OF ANYTYPE lsAccountBalance
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] STRING sExpectedBalance
		[ ] STRING sExpectedReport="Portfolio Value vs. Cost Basis"
		[ ] INTEGER iAccountOption=6
		[ ] 
		[ ] 
	[ ] sAccountName= lsAddAccount[1]
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=SelectPreferenceType("Navigation")
		[+] if (iResult==PASS)
			[ ] Preferences.SetActive()
			[ ] Preferences.ShowCentsInAccountBarBalanceCheckBox.Check()
			[ ] Preferences.OK.Click()
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.GetHandle())
			[ ] iListCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.GetItemCount()
			[ ] 
			[+] for (iCount=0 ; iCount<=iListCount; iCount++)
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(iCount))
				[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] break
			[ ] 
			[+] if(bMatch)
				[ ] lsAccountBalance =split(sActual,"@")
				[ ] sExpectedBalance=lsAccountBalance[3]
				[ ] 
				[+] if(sExpectedBalance!=NULL)
					[ ] ReportStatus("Verify if account balance returned from account bar",PASS,"Value {sExpectedBalance} has been returned")
					[ ] 
					[ ] 
					[ ] // Select Account From Account Bar
					[ ] iValidate=NavigateQuickenTab(sTAB_INVESTING)
					[+] if(iValidate==PASS)
						[ ] QuickenMainWindow.QWNavigator.Performance.Click()
						[ ] 
						[ ] 
						[ ] // Navigate to graph for Account Brokerage 01 Account
						[ ] MDIClient.Investing.AccountFilter.Select(iAccountOption)
						[ ] sleep(2)
						[ ] //-----Launch Portfolio value vs Cost basis Full Report-----
						[ ] //Click on Options button on Portfolio value vs Cost basis snapshot
						[ ] MDIClient.Investing.PortfolioCashBasisGraphButton.Click()
						[ ] sleep(1)
						[ ] MDIClient.Investing.TypeKeys(KEY_DN)
						[ ] sleep(1)
						[ ] MDIClient.Investing.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] 
						[+] if(wReport.Exists(5))
							[ ] wReport.SetActive()
							[+] if (wReport.ShowReport.Exists())
								[ ] wReport.ShowReport.Click()
							[ ] wReport.QWCustomizeBar1.PopupList2.Select(1)
							[ ] sActual=wReport.GetCaption()
							[+] if(sActual==sExpectedReport)
								[ ] ReportStatus("Verify if {sExpectedReport} report is launched",PASS,"{sExpectedReport} report is launched")
								[ ] 
								[ ] wReport.TextClick("Customize")
								[+] if (CustomizeReport.Exists(5))
									[ ] CustomizeReport.SetActive()
									[ ] CustomizeReport.TextClick("Accounts")
									[ ] CustomizeReport.ClearAllButton.Click()
									[ ] CustomizeReport.QWListViewer1.ListBox1.TextClick(sAccountName)
									[ ] CustomizeReport.QWListViewer1.ListBox1.TypeKeys(KEY_SPACE)
									[ ] CustomizeReport.OKButton.Click()
									[ ] 
									[ ] 
									[ ] //Verify Expected Balance in Portfolio Value vs. Cost Basis Report 
									[ ] sHandle=Str(wReport.QWListViewer1.ListBox1.GetHandle())
									[ ] iListCount=wReport.QWListViewer1.ListBox1.GetItemCount()
									[+] for(iCount=iListCount;iCount>=0;iCount--)
										[ ] 
										[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
										[ ] 
										[ ] 
										[ ] bMatch=MatchStr("*{sExpectedBalance}*",sActual)
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("Verify if Correct balance is displayed on graph and report",PASS,"Expected balance {sExpectedBalance} is matched to actual {sActual}")
											[ ] break
											[ ] 
										[+] else
											[ ] ListAppend(lsActual,sActual)
											[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
									[ ] 
									[+] if(bMatch==FALSE)
										[ ] ReportStatus("Verify if Correct balance is displayed on graph and report",FAIL,"Expected balance {sExpectedBalance} is NOT matched to graph {lsActual}")
										[ ] 
										[ ] 
										[ ] 
									[ ] 
									[ ] wReport.Close()
									[ ] sleep(2)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Customize report dialog", FAIL,"Customize report dialog didn't appear.")
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if {sExpectedReport} report is launched",FAIL,"{sActual} is launched instead of {sExpectedReport} report")
								[ ] 
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if report window is launched",FAIL,"Report window is launched")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Navigate to Investing tab",FAIL,"Error during while navigating to Investing Tab")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if account balance returned from account bar",FAIL,"Error while returning value from account bar as NULL value has been returned")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Find Account in Account Bar", FAIL, "{sAccountName} account is NOT available in Account bar")
		[+] else
			[ ] ReportStatus("Verify Navigation option selected on Preferances dialog.", FAIL,"Navigation option couldn't be selected on Preferances dialog.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[ ] 
[+] //####################  Verify Customize Graph Options for Performance View  ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_Verify_Verify_Customize_Graph_Options_For_Performance_View()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Customize Graph Options for Performance View
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes in Customize Graph Options are displayed in Graph
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  10th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test28_Verify_Verify_Customize_Graph_Options_For_Performance_View() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] STRING sExpectedBalance=lsAddAccount[5]
		[ ] 
		[ ] 
		[ ] STRING sExpectedReport="Portfolio Value vs. Cost Basis"
		[ ] INTEGER iAccountOption=4
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=NavigateQuickenTab(sTAB_INVESTING)
		[+] if(iValidate==PASS)
			[ ] QuickenMainWindow.QWNavigator.Performance.Click()
			[ ] 
			[ ] 
			[ ] // Navigate to graph for Account Brokerage 01 Account
			[ ] //MDIClient.Investing.AccountFilter.Select(iAccountOption)
			[ ] MDIClient.Investing.AccountFilter.TypeKeys("Custom")
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(CustomizeDialog.Exists(5))
				[ ] ReportStatus("Verify if Customize dialog appears",PASS,"Customize Dialog appears")
				[ ] CustomizeDialog.SelectAll.Click()
				[ ] CustomizeDialog.OK.Click()
				[ ] WaitForState(CustomizeDialog,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //-----Launch Portfolio value vs Cost basis Full Report-----
				[ ] //Click on Options button on Portfolio value vs Cost basis snapshot
				[ ] MDIClient.Investing.PortfolioCashBasisGraphButton.Click()
				[ ] MDIClient.Investing.TypeKeys(KEY_DN)
				[ ] MDIClient.Investing.TypeKeys(KEY_ENTER)
				[+] if(wReport.Exists(5))
					[ ] 
					[ ] sActual=wReport.GetCaption()
					[+] if(sActual==sExpectedReport)
						[ ] ReportStatus("Verify if {sExpectedReport} report is launched",PASS,"{sExpectedReport} report is launched")
						[ ] 
						[ ] wReport.ShowReport.Click()
						[ ] 
						[ ] // 2015-10-15 KalyanG: Can not verify expected balance as it is dynamic and value keeps changing
						[ ] // hence commenting the below verification
						[ ] // //Verify Expected Balance in Portfolio Value vs. Cost Basis Report 
						[ ] // sHandle=Str(wReport.QWListViewer1.ListBox1.GetHandle())
						[+] // for(iCount=wReport.QWListViewer1.ListBox1.GetItemCount();iCount>=0;iCount--)
							[ ] // 
							[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
							[ ] // 
							[ ] // 
							[ ] // bMatch=MatchStr("*{sExpectedBalance}*",sActual)
							[+] // if(bMatch==TRUE)
								[ ] // ReportStatus("Verify if Correct balance is displayed on graph and report",PASS,"Expected balance {sExpectedBalance} is matched to actual {sActual}")
								[ ] // break
								[ ] // 
							[+] // else
								[ ] // ListAppend(lsActual,sActual)
								[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
						[ ] // 
						[+] // if(bMatch==FALSE)
							[ ] // ReportStatus("Verify if Correct balance is displayed on graph and report",FAIL,"Expected balance {sExpectedBalance} is NOT matched to graph {lsActual}")
							[ ] // 
							[ ] // 
							[ ] // 
						[ ] 
						[ ] wReport.Close()
						[ ] sleep(2)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if {sExpectedReport} report is launched",FAIL,"{sActual} is launched instead of {sExpectedReport} report")
						[ ] 
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if report window is launched",FAIL,"Report window is launched")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Customize dialog appears",FAIL,"Customize Dialog did NOT appear")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Investing tab",FAIL,"Error during while navigating to Investing Tab")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //###################### Verify Account Value and cost filters from Performance view   ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_30_31_32_33_Allocation_Graphs_On_The_Allocation_Tab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Allocation Snapshot
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Account Value and cost filters from Performance view for a single account display the correct balances
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  10th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test29_30_31_32_33_Allocation_Graphs_On_The_Allocation_Tab() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingReportsSheet)
		[ ] 
		[ ] STRING sExpectedReport
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] 
		[ ] //Navigate to Allocation Tab
		[ ] iValidate=NavigateQuickenTab(sTAB_INVESTING)
		[+] if(iValidate==PASS)
			[ ] QuickenMainWindow.QWNavigator.Allocations.Click()
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Full Graph view of Asset Allocation Graph
			[ ] lsExpected=lsExcelData[1]
			[ ] sExpectedReport=lsExpected[2]
			[ ] MDIClient.Investing.AssetAllocationFullGraphButton.Click()
			[+] if(wReport.Exists(5))
				[ ] 
				[ ] sActual=wReport.GetCaption()
				[+] if(sActual==sExpectedReport)
					[ ] ReportStatus("Verify if {sExpectedReport} report is launched",PASS,"{sExpectedReport} report is launched")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {sExpectedReport} report is launched",FAIL,"{sActual} is launched instead of {sExpectedReport} report")
					[ ] 
					[ ] 
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if report window is launched",FAIL,"Report window is launched")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] //Scroll to bottom of the page as the other buttons are not in focus
			[+] if(MDIClient.Investing.VScrollBar.Exists())
				[ ] MDIClient.Investing.VScrollBar.ScrollToMax()
			[ ] 
			[ ] //Verify Full Graph view of Allocation By Accounts Graph
			[ ] lsExpected=lsExcelData[2]
			[ ] sExpectedReport=lsExpected[2]
			[ ] MDIClient.Investing.AllocationByAccountsFullGraphButton.Click()
			[+] if(wReport.Exists(5))
				[ ] 
				[ ] sActual=wReport.GetCaption()
				[+] if(sActual==sExpectedReport)
					[ ] ReportStatus("Verify if {sExpectedReport} report is launched",PASS,"{sExpectedReport} report is launched")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {sExpectedReport} report is launched",FAIL,"{sActual} is launched instead of {sExpectedReport} report")
					[ ] 
					[ ] 
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if report window is launched",FAIL,"Report window is launched")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Full Graph view of Allocation By Security Graph
			[ ] lsExpected=lsExcelData[3]
			[ ] sExpectedReport=lsExpected[2]
			[ ] MDIClient.Investing.AllocationBySecurityFullGraphButton.Click()
			[+] if(wReport.Exists(5))
				[ ] 
				[ ] sActual=wReport.GetCaption()
				[+] if(sActual==sExpectedReport)
					[ ] ReportStatus("Verify if {sExpectedReport} report is launched",PASS,"{sExpectedReport} report is launched")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {sExpectedReport} report is launched",FAIL,"{sActual} is launched instead of {sExpectedReport} report")
					[ ] 
					[ ] 
				[ ] 
				[ ] wReport.Close()
				[ ] sleep(2)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if report window is launched",FAIL,"Report window is launched")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] // Verify Asset Allocation Guide Button
			[ ] MDIClient.Investing.AllocationGuideButton.Click()
			[+] if(AssetAllocationGuide.Exists(5))
				[ ] ReportStatus("Verify if Asset Allocation Guide is launched",PASS,"Asset Allocation Guide is launched")
				[ ] 
				[ ] AssetAllocationGuide.Close()
				[ ] WaitForState(AssetAllocationGuide,FALSE,5)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Asset Allocation Guide is launched",FAIL,"Asset Allocation Guide is NOT launched")
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
			[ ] ReportStatus("Navigate to Investing tab",FAIL,"Error during while navigating to Investing Tab")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //####################  Verify Enter Transaction Dialog Change Date  ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test34_35_Verify_Enter_Transaction_Dialog_Change_Date()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Transaction Dialog Change Date
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User can change date on  dialog is launched
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  15th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test34_35_Verify_Enter_Transaction_Dialog_Change_Date_Window() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] STRING sExpectedDate=ModifyDate(2,sDateFormat)
		[ ] STRING sDayString=ModifyDate(2,"d")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] 
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] // Select Date by mouse from calendar pop up (Using TextClick())
				[ ] wEnterTransaction.SetActive()
				[ ] wEnterTransaction.TransactionDate.ClearText()
				[ ] wEnterTransaction.CalendarButton.Click()
				[ ] CalendarEnterTransaction.TextClick(sDayString)
				[ ] sActual=wEnterTransaction.TransactionDate.GetText()
				[+] if(sActual==sExpectedDate)
					[ ] ReportStatus("Verify date set in textfield by MouseClick",PASS,"Actual Date set in textfield by MouseClick : {sActual} is as Expected: {sExpectedDate}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify date set in textfield by MouseClick",FAIL,"Actual Date set in textfield by MouseClick : {sActual} is NOT as Expected: {sExpectedDate}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] // Select Date by Keyboard (Using TypeKeys())
				[ ] wEnterTransaction.SetActive()
				[ ] wEnterTransaction.TransactionDate.ClearText()
				[ ] wEnterTransaction.TransactionDate.TypeKeys(sExpectedDate)
				[ ] sActual=wEnterTransaction.TransactionDate.GetText()
				[+] if(sActual==sExpectedDate)
					[ ] ReportStatus("Verify date set in textfield by Keyboard TypeKeys",PASS,"Actual Date set in textfield by Keyboard TypeKeys : {sActual} is as Expected: {sExpectedDate}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify date set in textfield by Keyboard TypeKeys",FAIL,"Actual Date set in textfield by Keyboard TypeKeys : {sActual} is NOT as Expected: {sExpectedDate}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] wEnterTransaction.Close()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //##############  Verify Existing Security Present In Security Dropdown List on Enter Transaction Dialog   ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test36_39_Existing_Security_Present_In_Security_Dropdown_List()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Existing Security Present In Security Dropdown List on Enter Transaction Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Existing Securites are Present In Security Dropdown List on Enter Transaction Dialog
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  16th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test36_39_Existing_Security_Present_In_Security_Dropdown_List() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsExpected=lsExcelData[1]
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] 
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] lsExpected=lsExcelData[1]
				[ ] wEnterTransaction.SharesMenuButton.Click()
				[ ] wEnterTransaction.TypeKeys(KEY_DN)
				[ ] wEnterTransaction.TypeKeys(KEY_ENTER)
				[ ] sActual=wEnterTransaction.SecurityName.GetText()
				[+] if(sActual==lsExpected[1])
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",PASS,"Security Name {lsExpected[1]} exists in Security Dropdown")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",FAIL,"Security Name {lsExpected[1]} does NOT exist in Security Dropdown")
					[ ] 
				[ ] 
				[ ] 
				[ ] lsExpected=lsExcelData[2]
				[ ] wEnterTransaction.SharesMenuButton.Click()
				[ ] wEnterTransaction.TypeKeys(KEY_DN)
				[ ] wEnterTransaction.TypeKeys(KEY_ENTER)
				[ ] sActual=wEnterTransaction.SecurityName.GetText()
				[+] if(sActual==lsExpected[1])
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",PASS,"Security Name {lsExpected[1]} exists in Security Dropdown")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",FAIL,"Security Name {lsExpected[1]} does NOT exist in Security Dropdown")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] wEnterTransaction.Close()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] // 
[ ] 
[+] //##############  Verify Existing Security is selected by mouseclick from Dropdown on Enter Transaction Dialog ##########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test37_Existing_Security_Present_In_Security_Dropdown_List()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Existing Security is selected by mouseclick from Dropdown on Enter Transaction Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Existing Security is selected by mouseclick from Dropdown on Enter Transaction Dialog
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  16th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test37_Select_Existing_Security_By_MouseClick() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsExpected=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] INTEGER iX=445
		[ ] INTEGER iY=140
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] 
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] // Select First Security From List as Agilent
				[ ] lsExpected=lsExcelData[1]
				[ ] wEnterTransaction.SharesMenuButton.Click()
				[ ] wEnterTransaction.Click(MB_LEFT, iX, iY)
				[ ] sActual=wEnterTransaction.SecurityName.GetText()
				[+] if(sActual==lsExpected[1])
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} is selected by mouseclick from Dropdown",PASS,"Security Name {lsExpected[1]} is selected by mouseclick from Dropdown")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} is selected by mouseclick from Dropdown",FAIL,"Security Name {lsExpected[1]} is NOT selected by mouseclick from Dropdown {sActual}")
					[ ] 
				[ ] 
				[ ] wEnterTransaction.Close()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //##############  Verify Existing Security Existing security name typed in on Enter Transaction Dialog   ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test38_Select_Existing_Security_By_Typing_First_Letter_Using_KeyBoard()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Existing Security Present In Security Dropdown List on Enter Transaction Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Existing Securites are Present In Security Dropdown List on Enter Transaction Dialog
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  16th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test38_Select_Existing_Security_By_Typing_First_Letter_Using_KeyBoard() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsExpected=lsExcelData[1]
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] 
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] lsExpected=lsExcelData[1]
				[ ] wEnterTransaction.SecurityName.TypeKeys(lsExpected[3])
				[ ] sActual=wEnterTransaction.SecurityName.GetText()
				[+] if(sActual==lsExpected[1])
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",PASS,"Security Name {lsExpected[1]} exists in Security Dropdown")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",FAIL,"Security Name {lsExpected[1]} does NOT exist in Security Dropdown")
					[ ] 
				[ ] wEnterTransaction.SecurityName.ClearText()
				[ ] 
				[ ] 
				[ ] lsExpected=lsExcelData[2]
				[ ] wEnterTransaction.SecurityName.TypeKeys(lsExpected[3])
				[ ] sActual=wEnterTransaction.SecurityName.GetText()
				[+] if(sActual==lsExpected[1])
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",PASS,"Security Name {lsExpected[1]} exists in Security Dropdown")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",FAIL,"Security Name {lsExpected[1]} does NOT exist in Security Dropdown")
				[ ] 
				[ ] 
				[ ] wEnterTransaction.Close()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //##############  Verify Typing Name of New Security in Security Name Field on Enter Transaction Dialog   ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test40_Type_Name_Of_New_Security_In_Security_Name_Field_On_Enter_Transaction_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Typing Name of New Security in Security Name Field on Enter Transaction Dialog launches Add Security Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Add security dialog appears
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  16th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test40_Type_Name_Of_New_Security_In_Security_Name_Field_On_Enter_Transaction_Dialog() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsExpected=lsExcelData[1]
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] 
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] lsExpected=lsExcelData[3]
				[ ] wEnterTransaction.SecurityName.SetText(lsExpected[1])
				[ ] wEnterTransaction.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] 
				[ ] 
				[+] if(AddSecurityToQuicken2.Exists(5))
					[ ] ReportStatus("Verify that Add Security To Quicken Dialog is Launched",PASS,"Add Security To Quicken Dialog is Launched when a new security name is typed into Security Name field")
					[ ] 
					[ ] AddSecurityToQuicken2.Close()
					[ ] WaitForState(AddSecurityToQuicken2,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Add Security To Quicken Dialog is Launched",FAIL,"Add Security To Quicken Dialog is NOT Launched when a new security name is typed into Security Name field")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] wEnterTransaction.Close()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[ ] // // Sprint 7
[ ] 
[+] //################## Verify Hidden Securities when "View Hidden Security" Option is On and Off #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test41_42_Verify_Hidden_Securities_When_View_Hidden_Security_Option_Is_On_And_Off()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Hidden Securities when "View Hidden Security" Option is On and Off under Security Name textfield in Enter Transaction dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		1. If Hidden Securities appear when "View Hidden Security" Option is On 
		[ ] //                                                    2. If Hidden Securities do NOT appear when "View Hidden Security" Option is Off
		[ ] //						Fail		       If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  23rd April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test41_42_Verify_Hidden_Securities_When_View_Hidden_Security_Option_Is_On_And_Off() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsExpected=lsExcelData[2]
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Investing.Click()
		[ ] QuickenWindow.Investing.SecurityList.Select()
		[ ] 
    
		[ ] 
		[ ] //hide security 
		[+] if(SecurityList.Exists(5))
			[ ] ReportStatus("Verify if Security List is launched",PASS,"Security List is launched")
			[ ] 
			[ ] SecurityList.SetActive()
			[ ] SecurityList.SecurityListListBox.TextClick("Stock",2,CT_RIGHT)
			[ ] SecurityList.SecurityListListBox.TypeKeys(replicate(KEY_DN,3))
			[ ] SecurityList.SecurityListListBox.TypeKeys(KEY_ENTER)
			[ ] SecurityList.Done.Click()
			[ ] WaitForState(SecurityList,FALSE,5)
			[ ] 
			[ ] 
			[ ] //-----Turn On "View Hidden Security" Option----------
			[ ] //Launch Security List
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Investing.Click()
			[ ] QuickenWindow.Investing.SecurityList.Select()
			[+] if(SecurityList.Exists(5))
				[ ] ReportStatus("Verify if Security List is launched",PASS,"Security List is launched")
				[ ] 
				[ ] SecurityList.SetActive()
				[ ] SecurityList.ShowHiddenSecurities.Check()
				[ ] SecurityList.Done.Click()
				[ ] WaitForState(SecurityList,FALSE,5)
				[ ] //-----Verify that Hidden Security is displayed----------
				[ ] // Select Account From Account Bar
				[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
				[+] if(iValidate==PASS)
					[ ] 
					[ ] // Click on Enter Transaction button
					[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
					[ ] // Verify if Enter Transaction Dialog exists
					[+] if(wEnterTransaction.Exists(5))
						[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
						[ ] 
						[ ] wEnterTransaction.SetActive()
						[ ] wEnterTransaction.SecurityName.TypeKeys(lsExpected[3])
						[ ] sActual=wEnterTransaction.SecurityName.GetText()
						[+] if(sActual==lsExpected[1])
							[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",PASS,"Security Name {lsExpected[1]} exists in Security Dropdown when View Hidden Security option is checked")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",FAIL,"Security Name {lsExpected[1]} does NOT exist in Security Dropdown when View Hidden Security option is checked")
							[ ] 
						[ ] wEnterTransaction.Close()
						[ ] WaitForState(wEnterTransaction,FALSE,5)
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
						[ ] 
					[ ] 
					[ ] 
					[ ] //-----Turn Off "View Hidden Security" Option----------
					[ ] //Launch Security List
					[ ] QuickenWindow.Investing.Click()
					[ ] QuickenWindow.Investing.SecurityList.Select()
					[+] if(SecurityList.Exists(5))
						[ ] ReportStatus("Verify if Security List is launched",PASS,"Security List is launched")
						[ ] 
						[ ] SecurityList.SetActive()
						[ ] SecurityList.ShowHiddenSecurities.UnCheck()
						[ ] SecurityList.Done.Click()
						[ ] WaitForState(SecurityList,FALSE,5)
					[+] else
						[ ] ReportStatus("Verify if Security List is launched",FAIL,"Security List is NOT launched")
					[ ] 
					[ ] //-----Verify that Hidden Security is NOT displayed----------
					[ ] // Select Account From Account Bar
					[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
					[+] if(iValidate==PASS)
						[ ] 
						[ ] // Click on Enter Transaction button
						[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
						[ ] // Verify if Enter Transaction Dialog exists
						[+] if(wEnterTransaction.Exists(5))
							[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
							[ ] 
							[ ] wEnterTransaction.SetActive()
							[ ] wEnterTransaction.SecurityName.TypeKeys(lsExpected[3])
							[ ] sActual=wEnterTransaction.SecurityName.GetText()
							[+] if(sActual!=lsExpected[1])
								[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",PASS,"Security Name {lsExpected[1]} does NOT exist in Security Dropdown when View Hidden Security option is Unchecked")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that Security Name {lsExpected[1]} exists in Dropdown",FAIL,"Security Name {lsExpected[1]} exists in Security Dropdown when View Hidden Security option is Unchecked")
								[ ] 
								[ ] 
							[ ] wEnterTransaction.Close()
							[ ] WaitForState(wEnterTransaction,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
						[ ] 
						[ ] 
					[ ] //unhide security 
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Investing.Click()
					[ ] QuickenWindow.Investing.SecurityList.Select()
					[ ] 
					[+] if(SecurityList.Exists(5))
						[ ] ReportStatus("Verify if Security List is launched",PASS,"Security List is launched")
						[ ] 
						[ ] SecurityList.SetActive()
						[ ] SecurityList.ShowHiddenSecurities.Check()
						[ ] SecurityList.SecurityListListBox.TextClick("Stock",2,CT_RIGHT)
						[ ] SecurityList.SecurityListListBox.TypeKeys(replicate(KEY_DN,3))
						[ ] SecurityList.SecurityListListBox.TypeKeys(KEY_ENTER)
						[ ] SecurityList.Done.Click()
						[ ] WaitForState(SecurityList,FALSE,5)
					[+] else
						[ ] ReportStatus("Verify if Security List is launched",FAIL,"Security List is NOT launched")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Security List is launched",FAIL,"Security List is NOT launched")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Security List is launched",FAIL,"Security List is NOT launched")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify the cash balance for the transaction adds or subtracts from the account balance ################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test43_48D_Verify_From_This_Accounts_Cash_Balance_Option_On_Enter_Transaction_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the cash balance for the transaction adds or subtracts from the account balance and functionality of Enter Done button
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		1. If cash balance for the transaction adds or subtracts from the account balance and
		[ ] //                                                    2. If  transaction is added by clicking on Enter Done button
		[ ] //						Fail		       If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  24th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test43_48D_Verify_From_This_Accounts_Cash_Balance_Option_On_Enter_Transaction_Dialog() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] NUMBER nNum=0
		[ ] STRING sTotalCost
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsExpected=lsExcelData[5]
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] wEnterTransaction.SecurityName.SetText(lsExpected[1])
				[ ] wEnterTransaction.NumberOfShares.SetText(lsExpected[5])
				[ ] wEnterTransaction.PricePaid.SetText(lsExpected[4])
				[ ] wEnterTransaction.PricePaid.TypeKeys(KEY_TAB)
				[ ] //-------Get value of transaction to be deducted from accounts cash balance------
				[ ] 
				[ ] wEnterTransaction.NumberOfShares.SetFocus()
				[ ] 
				[ ] 
				[ ] wEnterTransaction.EnterDone.Click()
				[+] if(AddSecurityToQuicken2.Exists(120))
					[ ] AddSecurityToQuicken2.SetActive()
					[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
						[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
						[ ] 
					[ ] 
					[ ] sleep(SHORT_SLEEP)
					[ ] 
					[ ] AddSecurityToQuicken2.NextButton.Click()
					[ ] 
					[ ] sleep(SHORT_SLEEP)
					[ ] 
					[+] if (AddSecurityToQuicken.Next.Exists(10))
						[ ] AddSecurityToQuicken.Next.Click()
						[ ] sleep(10)
					[ ] 
					[ ] AddSecurityToQuicken.Done.DoubleClick()
				[ ] 
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_E)
				[+] if(wEnterTransaction.Exists(5))
					[ ] wEnterTransaction.SetActive()
					[ ] sTotalCost=wEnterTransaction.TotalCost.GetText()
					[ ] wEnterTransaction.EnterDone.Click()
					[ ] // Calculate Expected CashBalance
					[ ] nNum=val(lsAddAccount[3]) - val(sTotalCost)
					[ ] sExpected=Str(nNum,NULL,2)
					[ ] sExpected=Stuff(sExpected,2,0,Chr(44))
					[ ] 
					[+] do
						[ ] 
						[ ] MDIClient.BrokerageAccount.QWHtmlView.TextClick(sExpected)
						[ ] 
					[+] except
						[ ] ReportStatus("Verify that Cash Balance is updated in Brokerage account",FAIL,"Cash Balance is NOT updated in Brokerage account {lsAddAccount[1]} : Expected is {sExpected}")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] if(UpdateCashBalance.Exists(5))
						[ ] ReportStatus("Verify that Cash Balance is updated in Brokerage account",PASS,"Cash Balance {sExpected} is updated in Brokerage account {lsAddAccount[1]}")
						[ ] 
						[ ] UpdateCashBalance.Close()
						[ ] WaitForState(UpdateCashBalance,FALSE,5)
						[ ] 
						[ ] 
						[ ] //--------Verify that Transaction is entered in the Register-------
						[ ] 
						[ ] 
						[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
						[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
							[ ] 
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
							[ ] 
							[ ] bMatch=MatchStr("*{lsExpected[1]}*{sTotalCost}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify if Transaction is added in Investing Register after using Enter/Done button",PASS,"Transaction {lsExpected[1]} is added in Investing Register after using Enter/Done button")
								[ ] break
								[ ] 
							[ ] 
							[ ] 
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Verify if Transaction is added in Investing Register after using Enter/Done button",FAIL,"Transaction {lsExpected[1]} is NOT added in Investing Register after using Enter/Done button")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Cash Balance is updated in Brokerage account",FAIL,"Update Cash Balance dialog is NOT launched")
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //######################## Verify Clear Cancel Help Options On Enter Transaction Dialog #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test48A_48B_48C_Verify_Clear_Cancel_Help_Options_On_Enter_Transaction_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Clear, Cancel and Help Options On Enter Transaction Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		A. For Cancel button : The form closes and nothing is entered
		[ ] //                                                    B. For Clear button : The form is blanked and remains open
		[ ] //                                                    C. For Help Button : A help window opens explaining how to enter a transaction.
		[ ] //						Fail		       If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test48A_48B_48C_Verify_Clear_Cancel_Help_Options_On_Enter_Transaction_Dialog() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sBlankValue=""
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsExpected=lsExcelData[5]
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] 
				[ ] // ---------Verify Clear button functionality---------
				[ ] wEnterTransaction.SetActive()
				[ ] wEnterTransaction.SecurityName.SetText(lsExpected[1])
				[ ] wEnterTransaction.NumberOfShares.SetText(lsExpected[5])
				[ ] wEnterTransaction.PricePaid.SetText(lsExpected[4])
				[ ] wEnterTransaction.Clear.Click()
				[ ] sleep(2)
				[ ] //Verify that all populated fields are cleared
				[ ] sActual=wEnterTransaction.SecurityName.GetText()
				[+] if(sActual==sBlankValue)
					[ ] ReportStatus("Verify Security Name Field is cleared",PASS,"Security Name Field is cleared")
					[ ] 
					[ ] sActual=wEnterTransaction.NumberOfShares.GetText()
					[+] if(sActual==sBlankValue)
						[ ] ReportStatus("Verify NumberOfShares Field is cleared",PASS,"NumberOfShares Field is cleared")
						[ ] 
						[ ] sActual=wEnterTransaction.PricePaid.GetText()
						[+] if(sActual==sBlankValue)
							[ ] ReportStatus("Verify PricePaid Field is cleared",PASS,"PricePaid Field is cleared")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify PricePaid Field is cleared",FAIL,"PricePaid Field is NOT cleared {sActual}")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify NumberOfShares Field is cleared",FAIL,"NumberOfShares Field is NOT cleared {sActual}")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Security Name Field is cleared",FAIL,"Security Name Field is NOT cleared {sActual}")
					[ ] 
					[ ] 
				[ ] // ---------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] 
				[ ] // ---------Verify Help button functionality---------
				[ ] wEnterTransaction.SetActive()
				[ ] wEnterTransaction.Help.Click()
				[+] if(QuickenHelp.Exists(5))
					[ ] ReportStatus("Verify if Help dialog is launched",PASS,"Help dialog is launched")
					[ ] 
					[ ] QuickenHelp.Close()
					[ ] WaitForState(QuickenHelp,FALSE,5)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Help dialog is launched",FAIL,"Help dialog is NOT launched")
					[ ] 
					[ ] 
					[ ] 
				[ ] // ---------------------------------------------------------------
				[ ] 
				[ ] // ---------Verify Cancel button functionality---------
				[ ] wEnterTransaction.SetActive()
				[ ] wEnterTransaction.Cancel.Click()
				[ ] sleep(5)
				[+] if(wEnterTransaction.Exists(5))
					[ ] ReportStatus("Verify if Enter Transaction dialog is closed",FAIL,"Enter Transaction dialog is NOT closed ")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Enter Transaction dialog is closed",PASS,"Enter Transaction dialog is closed ")
					[ ] 
					[ ] 
				[ ] // ---------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //########################################################################################################
[ ] 
[ ] 
[+] //######################## Verify Enter New button On Enter Transaction Dialog #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test48E_Verify_Enter_New_Button_On_Enter_Transaction_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter New button On Enter Transaction Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		The data is saved and new form opens
		[ ] //
		[ ] //						Fail		       If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  24th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test48E_Verify_Enter_New_Button_On_Enter_Transaction_Dialog() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] //NUMBER nNum=0
		[ ] STRING sTotalCost
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsExpected=lsExcelData[1]
		[ ] lsExpected[4]="13.20"
		[ ] lsExpected[5]="10"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] wEnterTransaction.SecurityName.SetText(lsExpected[1])
				[ ] wEnterTransaction.NumberOfShares.SetText(lsExpected[5])
				[ ] wEnterTransaction.PricePaid.SetText(lsExpected[4])
				[ ] 
				[ ] //-------Get value of transaction to be deducted from accounts cash balance------
				[ ] wEnterTransaction.NumberOfShares.SetFocus()
				[ ] wEnterTransaction.TypeKeys(KEY_TAB)
				[ ] wEnterTransaction.TypeKeys(KEY_TAB)
				[ ] sleep(3)
				[ ] sTotalCost=wEnterTransaction.TotalCost.GetText()
				[ ] 
				[ ] wEnterTransaction.EnterNew.Click()
				[ ] 
				[+] if(wEnterTransaction.Exists(5))
					[ ] ReportStatus("Verify that Enter Transaction dialog is still open",PASS,"Enter Transaction dialog is still open after clicking on Enter/New button")
					[ ] 
					[ ] wEnterTransaction.Close()
					[ ] WaitForState(wEnterTransaction,FALSE,5)
					[ ] 
					[ ] 
					[ ] //--------Verify that Transaction is entered in the Register-------
					[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
					[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
						[ ] 
						[ ] bMatch=MatchStr("*{lsExpected[1]}*{sTotalCost}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Transaction is added in Investing Register after using Enter/New button",PASS,"Transaction {lsExpected[1]} is added in Investing Register after using Enter/New button")
							[ ] break
							[ ] 
						[ ] 
						[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if Transaction is added in Investing Register after using Enter/New button",FAIL,"Transaction {lsExpected[1]} is NOT added in Investing Register after using Enter/New button")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Enter Transaction dialog is still open",FAIL,"Enter Transaction dialog is NOT open after clicking on Enter/New button")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
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
[ ] //######################################################################################################
[ ] 
[ ] 
[+] //################ Verify the option to choose cash from a linked account is not available and the default is selected ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test44_Verify_Option_To_Choose_Cash_From_A_Linked_Account()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the option to choose cash from a linked account  The linked account should default and show only the linked checking account register.  
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		1. If option to choose cash from a linked account is not available and 
		[ ] //                                                    2. If the default linked checking account is selected
		[ ] //						Fail		       If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  30th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test44_Verify_Option_To_Choose_Cash_From_A_Linked_Account() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsActual
		[ ] BOOLEAN bResult
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsExpected=lsExcelData[5]
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] // UseCashForThisTransaction should be disabled
				[ ] bResult=wEnterTransaction.UseCashForThisTransaction.IsEnabled()
				[+] if(bResult==FALSE)
					[ ] ReportStatus("Verify if From Use Cash For This Transaction ComboBox is disabled",PASS,"Use Cash For This Transaction ComboBox is disabled for a linked checking account")
				[+] else
					[ ] ReportStatus("Verify if From Use Cash For This Transaction ComboBox is disabled",FAIL,"Use Cash For This Transaction ComboBox is still enabled for a linked checking account")
				[ ] 
				[ ] // FromAccountList should be disabled
				[ ] bResult=wEnterTransaction.FromAccountList.IsEnabled()
				[+] if(bResult==FALSE)
					[ ] ReportStatus("Verify if From Account ComboBox is disabled",PASS,"From Account ComboBox is disabled for a linked checking account")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if From Account ComboBox is disabled",FAIL,"From Account ComboBox is still enabled for a linked checking account")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] // Account on list should be default linked checking account
				[ ] 
				[ ] lsActual=wEnterTransaction.FromAccountList.GetItems()
				[ ] 
				[+] if(lsActual[1]==lsAddAccount[6])
					[ ] ReportStatus("Verify if correct only single account {lsAddAccount[6]} is displayed under From Account List on Enter Transaction window",PASS,"Single account {lsActual[1]} is displayed under From Account List on Enter Transaction window is as expected : {lsAddAccount[6]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct only single account {lsAddAccount[6]} is displayed under From Account List on Enter Transaction window",FAIL,"Single account {lsActual[1]} is displayed under From Account List on Enter Transaction window is NOT as expected : {lsAddAccount[6]}")
					[ ] 
				[ ] 
				[ ] wEnterTransaction.Close()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify the option From Another Account Drop Down ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test45_Verify_Option_From_Another_Account_Drop_Down()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the option to choose cash from a linked account  The linked account should default and show only the linked checking account register.  
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		1. If option to choose cash from a linked account is not available and 
		[ ] //                                                    2. If the default linked checking account is selected
		[ ] //						Fail		       If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  30th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test45_Verify_Option_From_Another_Account_Drop_Down() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsActual
		[ ] BOOLEAN bResult
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sAllAccountsSheet)
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] // Select 2nd option on radiolist
				[ ] wEnterTransaction.UseCashForThisTransaction.Select(2)
				[ ] 
				[ ] // FromAccountList should be disabled
				[ ] bResult=wEnterTransaction.FromAccountList.IsEnabled()
				[+] if(bResult==TRUE)
					[ ] ReportStatus("Verify if From Account ComboBox is enabled",PASS,"From Account ComboBox is enabled")
					[ ] 
					[ ] 
					[ ] 
					[ ] // All Accounts should appear under list
					[ ] lsActual=wEnterTransaction.FromAccountList.GetItems()
					[+] for(iCount=1;iCount<=ListCount(lsExcelData);iCount++)
						[ ] 
						[ ] lsExpected=lsExcelData[iCount]
						[ ] 
						[+] if(lsActual[iCount]==lsExpected[1])
							[ ] ReportStatus("Verify if all accounts are displayed under From Account ComboBox on Enter Transaction window",PASS,"Account {lsActual[iCount]} is displayed under From Account ComboBox on Enter Transaction window is as expected : {lsExpected[1]}")
						[+] else
							[ ] ReportStatus("Verify if all accounts are displayed under From Account ComboBox on Enter Transaction window",FAIL,"Account {lsActual[iCount]} is displayed under From Account ComboBox on Enter Transaction window is NOT as expected : {lsExpected[1]}")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] wEnterTransaction.Close()
					[ ] WaitForState(wEnterTransaction,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if From Account ComboBox is enabled",FAIL,"From Account ComboBox is disabled")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //########################  Verify memo field on Enter Transaction dialog  #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test47A_47B_Verify_Memo_Field_On_Enter_Transaction_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify memo field on Enter Transaction dialog for the following scenarios
		[ ] //  1. Verify you receive an error message at 65 charecters and Quicken records the transaction with 64 charecters.
		[ ] //  2. Characters such as *&$%_+=~, etc. are accepted into the memo field.  
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		1. If max allowed characters are 64
		[ ] //                                                    2. If Characters such as *&$%_+=~, etc. are accepted into the memo field.  
		[ ] //						Fail		       If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  30th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test47A_47B_Verify_Memo_Field_On_Enter_Transaction_Dialog() appstate QuickenExceptionBaseState
	[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sMemoText="1234567890abcdefghijklmnopqrstuvwxyz!@#$%^&*()_+1234567890ABCDEFGHIJKLMNOP"            //74 characters
		[ ] STRING sExpectedMemoText="1234567890abcdefghijklmnopqrstuvwxyz!@#$%^&*()_+1234567890ABCDEF"  // 64 characters
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sInvestingAccountSheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sAllAccountsSheet)
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] 
		[ ] // Select Account From Account Bar
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Click on Enter Transaction button
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] // Verify if Enter Transaction Dialog exists
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] wEnterTransaction.Memo.TypeKeys(sMemoText)
				[ ] sActual=wEnterTransaction.Memo.GetText()
				[+] if(sActual==sExpectedMemoText)
					[ ] ReportStatus("Verify if Memo field accepts 64 characters as maximum including special characters",PASS,"Memo field accepts 64 characters as maximum including special characters")
					[ ] 
					[ ] 
					[ ] 
					[ ] wEnterTransaction.Close()
					[ ] WaitForState(wEnterTransaction,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Memo field accepts 64 characters as maximum including special characters",FAIL,"Memo field does NOT accept 64 characters as maximum including special characters")
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
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Account Selected from Account Bar",FAIL,"Account Not Selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Exists",FAIL,"Quicken Window does not exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
