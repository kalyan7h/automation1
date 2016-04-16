[ ] // *********************************************************
[+] // FILE NAME:	<FileImportExport.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all File Import Export test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  Udita Dube
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 June 26, 2014	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] // Global variables 
	[ ] 
	[ ] //----------STRING-------------------
	[ ] public STRING sActual ,sExpected,sCaption,sHandle
	[ ] 
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] public STRING sDate=ModifyDate(0,sDateFormat)
	[ ] 
	[ ] STRING sExcelName = "FileOperations"
	[ ] STRING sWorksheet = "CopyFile"
	[ ] 
	[ ] //---------LIST OF STRING-----------
	[ ] 
	[ ] 
	[ ] //---------LIST OF ANYTYPE-----------
	[ ] LIST OF ANYTYPE lsExcelData,lsTestData
	[ ] 
	[ ] 
	[ ] //------------------INTEGER----------------
	[ ] public INTEGER iResult , iCount ,iCounter,i,j,k
	[ ] 
	[ ] public INTEGER iListCount,iValidate,iNavigate,iSelect
	[ ] 
	[ ] 
	[ ] //--------------BOOLEAN---------------
	[ ] public BOOLEAN bCaption,bStatus,bFlag,bMatch
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Verify QIF Export UI ##########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_VerifyQIFExportUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QIF Export UI 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	26/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test01_VerifyQIFExportUI() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sHelpContent, sExpected,sFileName
		[ ] LIST OF STRING lsQuickenFileAttributes
		[ ] INTEGER iDataFileAccounts,iNumberOfAccounts
		[ ] 
		[ ] sExpected= "Export to QIF File"
		[ ] sHelpContent="Export data from Quicken"
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] sFileName=AUT_DATAFILE_PATH+"\{lsExcelData[1][1]}.QIF"
		[ ] lsData=lsExcelData[1]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Open existing data file
		[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
		[ ] //sleep(15)
		[ ] WaitForState(QuickenWindow,TRUE,25)
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileExport.Click()
			[ ] QuickenWindow.File.FileExport.QIFFile.Select()
			[+] if(QIFExportPopUp.Exists(3))
				[ ] 
				[ ] QIFExportPopUp.SetActive()
				[ ] 
				[ ] // Verify Quicken account to extract from dropdown
				[+] if(QIFExportPopUp.QuickenAccountToExportFrom.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Quicken account to extract from dropdown",PASS,"Quicken account to extract from dropdown is displayed on QIF export popup")
					[ ] iNumberOfAccounts=QIFExportPopUp.QuickenAccountToExportFrom.GetItemCount()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Quicken account to extract from dropdown",FAIL,"Quicken account to extract from dropdown is not displayed on QIF export popup")
					[ ] 
				[ ] 
				[ ] // Verify From Date text field
				[+] if(QIFExportPopUp.DateFrom.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Date From text field",PASS,"Date From text field is displayed on QIF export popup")
				[+] else
					[ ] ReportStatus("Verify Date From text field",FAIL,"Date From text field is not displayed on QIF export popup")
					[ ] 
				[ ] 
				[ ] // Verify To Date text field
				[+] if(QIFExportPopUp.DateTo.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify To Date text field",PASS,"To Date text field is displayed on QIF export popup")
				[+] else
					[ ] ReportStatus("Verify To Date text field",FAIL,"To Date text field is not displayed on QIF export popup")
					[ ] 
				[ ] 
				[ ] // Verify Browse button
				[+] if(QIFExportPopUp.Browse.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Browse button",PASS,"Browse button is displayed on QIF export popup")
					[ ] QIFExportPopUp.Browse.Click()
					[+] if(ImportExportQuickenFile.Exists(2))
						[ ] sActual=ImportExportQuickenFile.GetCaption()
						[+] if(sActual==sExpected)
							[ ] ReportStatus("Verify window name after clicking on Browse button",PASS,"{sExpected} window is opened after clicking on Browse button")
							[ ] ImportExportQuickenFile.FileName.SetText(sFileName)
							[ ] ImportExportQuickenFile.OK.Click()
						[+] else
							[ ] ReportStatus("Verify window name after clicking on Browse button",FAIL,"{sExpected} window is not opened after clicking on Browse button, Actual window is {sActual}")
							[ ] ImportExportQuickenFile.Close()
							[ ] 
					[+] else
						[ ] ReportStatus("Verify window after clicking on Browse button",FAIL,"{sExpected} window is not opened after clicking on Browse button")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Browse button",FAIL,"Browse button is not displayed on QIF export popup")
					[ ] 
				[ ] 
				[ ] // Verify QIF File to Export to text field
				[+] if(QIFExportPopUp.QIFFileToExportTo.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify QIF File to Export to text field",PASS,"QIF File to Export to text field is displayed on QIF export popup")
					[ ] sActual=QIFExportPopUp.QIFFileToExportTo.GetText()
					[+] if(sActual==sFileName)
						[ ] ReportStatus("Verify QIF File to Export to text field's value",PASS,"QIF File to Export to text field is displayed with correct value which was selected from Browse")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify QIF File to Export to text field's value",FAIL,"QIF File to Export to text field is not displayed with correct value which was selected from Browse, Actual = {sActual}, Expected = {sFileName}")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify QIF File to Export to text field",FAIL,"QIF File to Export to text field is not displayed on QIF export popup")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Verify For Quicken Mac checkbox
				[+] if(QIFExportPopUp.ForQuickenMac.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify For Quicken Mac checkbox",PASS,"For Quicken Mac checkbox is displayed on QIF export popup")
				[+] else
					[ ] ReportStatus("Verify For Quicken Mac checkbox",FAIL,"For Quicken Mac checkbox is not displayed on QIF export popup")
					[ ] 
				[ ] 
				[+] // Verify Include in Export checkboxes
					[ ] 
					[ ] // Verify Transactions checkbox
					[+] if(QIFExportPopUp.Transactions.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Transactions checkbox",PASS,"Transactions checkbox is displayed on QIF export popup")
					[+] else
						[ ] ReportStatus("Verify Transactions checkbox",FAIL,"Transactions checkbox is not displayed on QIF export popup")
					[ ] 
					[ ] // Verify Account List checkbox
					[+] if(QIFExportPopUp.AccountList.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Account List checkbox",PASS,"Account List checkbox is displayed on QIF export popup")
					[+] else
						[ ] ReportStatus("Verify Account List checkbox",FAIL,"Account List checkbox is not displayed on QIF export popup")
					[ ] 
					[ ] // Verify Category List checkbox
					[+] if(QIFExportPopUp.CategoryList.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Category List checkbox",PASS,"Category List checkbox is displayed on QIF export popup")
					[+] else
						[ ] ReportStatus("Verify Category List checkbox",FAIL,"Category List checkbox is not displayed on QIF export popup")
					[ ] 
					[ ] // Verify Memorized Payees checkbox
					[+] if(QIFExportPopUp.MemorizedPayees.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Memorized Payees checkbox",PASS,"Memorized Payees checkbox is displayed on QIF export popup")
					[+] else
						[ ] ReportStatus("Verify Memorized Payees checkbox",FAIL,"Memorized Payees checkbox is not displayed on QIF export popup")
					[ ] 
					[ ] // Verify Security List checkbox
					[+] if(QIFExportPopUp.SecurityLists.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Security List checkbox",PASS,"Security List checkbox is displayed on QIF export popup")
					[+] else
						[ ] ReportStatus("Verify Security List checkbox",FAIL,"Security List checkbox is not displayed on QIF export popup")
					[ ] 
					[ ] // Verify Business List checkbox
					[+] if(QIFExportPopUp.BusinessLists.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Business List checkbox",PASS,"Business List checkbox is displayed on QIF export popup")
					[+] else
						[ ] ReportStatus("Verify Business List checkbox",FAIL,"Business List checkbox is not displayed on QIF export popup")
					[ ] 
					[ ] 
				[ ] 
				[ ] // Verify Help Icon
				[+] if(QIFExportPopUp.HelpIcon.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Help Icon",PASS,"Help Icon is displayed on QIF export popup")
					[ ] QIFExportPopUp.HelpIcon.Click()
					[+] if(QuickenHelp.Exists(2))
						[ ] QuickenHelp.SetActive()
						[+] do
							[ ] QuickenHelp.TextClick(sHelpContent)
						[+] except
							[ ] ReportStatus("Verify Help content",FAIL,"{sHelpContent} text is not displayed on Quicken Help window")
						[ ] 
						[ ] QuickenHelp.Close()
					[+] else
						[ ] ReportStatus("Verify window after clicking on Help icon",FAIL,"Quicken Help window is not opened after clicking on Help icon")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Help Icon",FAIL,"Help Icon is not displayed on QIF export popup")
					[ ] 
				[ ] 
				[ ] // Verify OK button
				[+] if(QIFExportPopUp.OK.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify OK button",PASS,"OK button is displayed on QIF export popup")
				[+] else
					[ ] ReportStatus("Verify OK button",FAIL,"OK button is not displayed on QIF export popup")
					[ ] 
				[ ] 
				[ ] // Verify Cancel button
				[+] if(QIFExportPopUp.Cancel.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Cancel button",PASS,"Cancel button is displayed on QIF export popup")
					[ ] QIFExportPopUp.Cancel.Click()
					[+] if(!QIFExportPopUp.Exists(2))
						[ ] ReportStatus("Verify Cancel button functionality",PASS,"QIF Export window is closed after clicking on cancel button")
					[+] else
						[ ] ReportStatus("Verify Cancel button functionality",FAIL,"QIF Export window is not closed after clicking on cancel button")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Cancel button",FAIL,"Cancel button is not displayed on QIF export popup")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Verify number of accounts in Quicken account to extract from dropdown
				[ ] lsQuickenFileAttributes=QuickenFileAttributes(lsQuickenFileAttributes)
				[ ] iDataFileAccounts=Val(lsQuickenFileAttributes[1])
				[+] if(iNumberOfAccounts==iDataFileAccounts+1)
					[ ] ReportStatus("Verify number of accounts in Quicken account to extract from dropdown",PASS,"Correct number of accounts are available in Quicken account to extract from dropdown")
				[+] else
					[ ] ReportStatus("Verify number of accounts in Quicken account to extract from dropdown",FAIL,"Correct number of accounts are not available in Quicken account to extract from dropdown")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade QIF Export PopUp",FAIL,"QIF Export PopUp did not appear")
		[+] else
			[ ] ReportStatus("Open QDF FIle", FAIL,"Unable to open {lsData[1]} data file!" )
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Close and Alt f4 for QIF Export window ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_VerifyCloseAndAltF4ForQIFExportWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Close and Alt f4 for  QIF Export  window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Close and Alt f4 is working for  QIF Export  window			
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	27/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test02_VerifyCloseAndAltF4ForQIFExportWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] LIST OF STRING lsOperation= {"Close","Alt-F4"}
	[ ] 
	[+] for(i=1;i<=2;i++)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileExport.Click()
			[ ] QuickenWindow.File.FileExport.QIFFile.Select()
			[+] if(QIFExportPopUp.Exists(3))
				[ ] 
				[ ] QIFExportPopUp.SetActive()
				[ ] 
				[+] if(i==1)
					[ ] QIFExportPopUp.Close()
				[+] else
					[ ] QIFExportPopUp.TypeKeys(KEY_EXIT)
				[ ] 
				[+] if(!CopyFile.Exists(2))
					[ ] ReportStatus("Verify close functionality for QIF Export  window",PASS,"QIF Export window gets closed after {lsOperation[i]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify close functionality for QIF Export window",FAIL,"QIF Export window did not close after {lsOperation[i]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade QIF Export",FAIL,"QIF Export popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Check the Date Fields special case ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_VerifyDateFieldsForQIFExport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Date Fields For QIF Export
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	27/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test03_VerifyDateFieldsForQIFExport() appstate QuickenBaseState
	[ ] // Variable declaration
	[ ] LIST OF STRING lsDate
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileExport.Click()
		[ ] QuickenWindow.File.FileExport.QIFFile.Select()
		[+] if(QIFExportPopUp.Exists(3))
			[ ] 
			[ ] QIFExportPopUp.SetActive()
			[ ] sExpected=QIFExportPopUp.DateFrom.GetText()
			[ ] lsDate=split(sExpected,"/")
			[ ] QIFExportPopUp.DateFrom.Click()
			[ ] QIFExportPopUp.DateFrom.TypeKeys("r")
			[ ] sActual=QIFExportPopUp.DateFrom.GetText()
			[ ] bMatch=MatchStr("12*31*{lsDate[3]}",sActual)
			[+] if(bMatch)
				[ ] ReportStatus("Verify that if user types 'r' then it sets the date to the end of the last year",PASS,"Date is being set to the end of the last year when user types 'r' in date field")
			[+] else
				[ ] ReportStatus("Verify that if user types 'r' then it sets the date to the end of the last year",FAIL,"Date is not being set to the end of the last year when user types 'r' in date field, Actual - {sActual}")
			[ ] QIFExportPopUp.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Valiade QIF Export PopUp",FAIL,"QIF Export PopUp did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify the Date Field validation ################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_ValidateDateFieldsForQIFExport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //  QIF Export: This testcase will verify validation message when Delete the date from the 1st date field
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	09/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test04_ValidateDateFieldsForQIFExport() appstate QuickenBaseState
	[ ] // Variable declaration
	[ ] LIST OF STRING lsField= {"From", "To"}
	[ ] sExpected="Enter a valid date."
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[+] for(i=1;i<=2;i++)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileExport.Click()
			[ ] QuickenWindow.File.FileExport.QIFFile.Select()
			[+] if(QIFExportPopUp.Exists(3))
				[ ] 
				[ ] // Verify From Date validation
				[ ] QIFExportPopUp.SetActive()
				[+] if(i==1)
					[ ] QIFExportPopUp.DateFrom.ClearText()
				[+] else
					[ ] QIFExportPopUp.DateTo.ClearText()
				[ ] 
				[ ] QIFExportPopUp.OK.Click()
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sActual=AlertMessage.MessageText.GetText()
					[+] if(sActual==sExpected)
						[ ] ReportStatus("Verify validation message when {lsField[i]} date is blank",PASS,"Correct validation message is displayed when {lsField[i]} date is blank")
					[+] else
						[ ] ReportStatus("Verify validation message when {lsField[i]} date is blank",FAIL,"Correct validation message is not displayed when {lsField[i]} date is blank, Actual-{sActual}, Expected- {sExpected}")
						[ ] 
					[ ] AlertMessage.OK.Click()
				[+] else
					[ ] ReportStatus("Verify validation message box",FAIL,"No validation message is appeared when {lsField[i]} date is blank")
				[ ] QIFExportPopUp.Close()
			[+] else
				[ ] ReportStatus("Valiade QIF Export PopUp",FAIL,"QIF Export PopUp did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify QIF Export Functionality ################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_VerifyQIFExport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QIF Export functionality 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	08/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test05_VerifyQIFExport() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sFileName
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}.QIF"
		[+] if(FileExists(sFileName))
			[ ] DeleteFile(sFileName)
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileExport.Click()
		[ ] QuickenWindow.File.FileExport.QIFFile.Select()
		[+] if(QIFExportPopUp.Exists(3))
			[ ] 
			[ ] QIFExportPopUp.SetActive()
			[ ] 
			[ ] QIFExportPopUp.QIFFileToExportTo.SetText(sFileName)
			[ ] 
			[ ] // Verify Quicken account to extract from dropdown
			[+] if(QIFExportPopUp.QuickenAccountToExportFrom.Exists(SHORT_SLEEP))
				[ ] QIFExportPopUp.QuickenAccountToExportFrom.Select("<All Accounts>")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken account to extract from dropdown",FAIL,"Quicken account to extract from dropdown is not displayed on QIF export popup")
				[ ] 
			[ ] 
			[ ] // Verify For Quicken Mac checkbox
			[+] if(QIFExportPopUp.ForQuickenMac.Exists(SHORT_SLEEP))
				[ ] QIFExportPopUp.ForQuickenMac.Uncheck()
			[+] else
				[ ] ReportStatus("Verify For Quicken Mac checkbox",FAIL,"For Quicken Mac checkbox is not displayed on QIF export popup")
				[ ] 
			[ ] 
			[+] // Check Include in Export checkboxes
				[ ] 
				[ ] // Check Transactions checkbox
				[+] if(!QIFExportPopUp.Transactions.IsChecked())
					[ ] QIFExportPopUp.Transactions.Check()
				[ ] 
				[ ] // Check Account List checkbox
				[+] if(!QIFExportPopUp.AccountList.IsChecked())
					[ ] QIFExportPopUp.AccountList.Check()
				[ ] 
				[ ] // Check Category List checkbox
				[+] if(!QIFExportPopUp.CategoryList.IsChecked())
					[ ] QIFExportPopUp.CategoryList.Check()
				[ ] 
				[ ] // Check Memorized Payees checkbox
				[+] if(!QIFExportPopUp.MemorizedPayees.IsChecked())
					[ ] QIFExportPopUp.MemorizedPayees.Check()
				[ ] 
				[ ] // Check Security List checkbox
				[+] if(!QIFExportPopUp.SecurityLists.IsChecked())
					[ ] QIFExportPopUp.SecurityLists.Check()
				[ ] 
				[ ] // Check Business List checkbox
				[+] if(QIFExportPopUp.BusinessLists.Exists(SHORT_SLEEP))
					[ ] 
					[+] if(!QIFExportPopUp.BusinessLists.IsChecked())
						[ ] QIFExportPopUp.BusinessLists.Check()
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Click OK button
			[ ] QIFExportPopUp.OK.Click()
			[ ] 
			[+] if(AlertMessage.Exists(2))
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.Yes.Click()
			[ ] 
			[+] if(FileExists(sFileName))
				[ ] ReportStatus("Verify QIF export functionality",PASS,"QIF file is exported successfully")
			[+] else
				[ ] ReportStatus("Verify QIF export functionality",FAIL,"QIF file is not exported successfully")
		[+] else
			[ ] ReportStatus("Valiade QIF Export PopUp",FAIL,"QIF Export PopUp did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify For Quicken Mac checkbox QIF Export ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_VerifyForQuickenMacCheckboxOnQIFExport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify For Quicken Mac Checkbox On QIFExport popup
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	09/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test06_VerifyForQuickenMacCheckboxOnQIFExport() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sFileName,sText,sMessage
		[ ] 
		[ ] sText = "Export my Quicken for Windows data to Quicken for Mac"
		[ ] sMessage="File already exists.  Are you sure you want to replace it?"
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}.QIF"
		[+] // if(FileExists(sFileName))
			[ ] // DeleteFile(sFileName)
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileExport.Click()
		[ ] QuickenWindow.File.FileExport.QIFFile.Select()
		[+] if(QIFExportPopUp.Exists(3))
			[ ] 
			[ ] QIFExportPopUp.SetActive()
			[ ] QIFExportPopUp.QuickenAccountToExportFrom.Select("<All Accounts>")
			[ ] 
			[ ] 
			[ ] // check For Quicken Mac checkbox
			[+] if(QIFExportPopUp.ForQuickenMac.Exists(SHORT_SLEEP))
				[ ] QIFExportPopUp.ForQuickenMac.Check()
			[+] else
				[ ] ReportStatus("Verify For Quicken Mac checkbox",FAIL,"For Quicken Mac checkbox is not displayed on QIF export popup")
				[ ] 
			[ ] 
			[+] // Check Include in Export checkboxes
				[ ] 
				[ ] // Verify Transactions checkbox
				[+] if(!QIFExportPopUp.Transactions.IsChecked())
					[ ] QIFExportPopUp.Transactions.Check()
				[+] else
					[ ] ReportStatus("Verify Transactions checkbox",FAIL,"Transactions checkbox is not displayed on QIF export popup")
				[ ] 
				[ ] // Verify Account List checkbox
				[+] if(!QIFExportPopUp.AccountList.IsChecked())
					[ ] QIFExportPopUp.AccountList.Check()
				[+] else
					[ ] ReportStatus("Verify Account List checkbox",FAIL,"Account List checkbox is not displayed on QIF export popup")
				[ ] 
				[ ] // Verify Category List checkbox
				[+] if(!QIFExportPopUp.CategoryList.IsChecked())
					[ ] QIFExportPopUp.CategoryList.Check()
				[+] else
					[ ] ReportStatus("Verify Category List checkbox",FAIL,"Category List checkbox is not displayed on QIF export popup")
				[ ] 
				[ ] // Verify Memorized Payees checkbox
				[+] if(!QIFExportPopUp.MemorizedPayees.IsChecked())
					[ ] QIFExportPopUp.MemorizedPayees.Check()
				[+] else
					[ ] ReportStatus("Verify Memorized Payees checkbox",FAIL,"Memorized Payees checkbox is not displayed on QIF export popup")
				[ ] 
				[ ] // Verify Security List checkbox
				[+] if(!QIFExportPopUp.SecurityLists.IsChecked())
					[ ] QIFExportPopUp.SecurityLists.Check()
				[+] else
					[ ] ReportStatus("Verify Security List checkbox",FAIL,"Security List checkbox is not displayed on QIF export popup")
				[ ] 
				[ ] // Verify Business List checkbox
				[+] if(QIFExportPopUp.BusinessLists.Exists(SHORT_SLEEP))
					[ ] 
					[+] if(!QIFExportPopUp.BusinessLists.IsChecked())
						[ ] QIFExportPopUp.BusinessLists.Check()
					[+] else
						[ ] ReportStatus("Verify Business List checkbox",FAIL,"Business List checkbox is not displayed on QIF export popup")
					[ ] 
				[ ] 
			[ ] 
			[ ] // Click OK button
			[ ] QIFExportPopUp.OK.Click()
			[ ] 
			[+] if(AlertMessage.Exists(2))
				[ ] AlertMessage.SetActive()
				[+] if(AlertMessage.Help.Exists(2))
					[ ] AlertMessage.Help.Click()
					[+] if(QuickenHelp.Exists(2))
						[ ] QuickenHelp.SetActive()
						[+] do
							[ ] QuickenHelp.TextClick(sText)
						[+] except
							[ ] ReportStatus("Verify Help content for Quicken Mac checkbox",FAIL,"Help content for Quicken Mac is not displayed on Help window")
						[ ] QuickenHelp.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Quicken Help window",FAIL,"Quicken Help window is not opened")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Help button on Alert message",FAIL,"Help button is not found on alert message")
				[ ] sActual=AlertMessage.MessageText.GetText()
				[ ] bMatch=MatchStr("CAUTION*",sActual)
				[+] if(bMatch)
					[ ] ReportStatus("Verify caution on alert message",PASS,"Caution message is displayed on alert message, message is- {sActual}")
				[+] else
					[ ] ReportStatus("Verify caution on alert message",FAIL,"Caution message is not displayed on alert message, Actual is- {sActual}")
				[ ] 
				[+] if(AlertMessage.OK.Exists(2))
					[ ] AlertMessage.OK.Click()
				[+] else
					[ ] ReportStatus("Verify OK button on alert message",FAIL,"OK button is not found on alert message")
					[ ] AlertMessage.Close()
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Alert message",FAIL,"Alert message box is not displayed")
				[ ] 
			[ ] 
			[ ] sActual=NULL
			[+] if(AlertMessage.Exists(2))
				[ ] AlertMessage.SetActive()
				[ ] sActual=AlertMessage.MessageText.GetText()
				[ ] print(sActual)
				[+] if(sMessage==sActual)
					[ ] ReportStatus("Verify alert message for replacement of QIF file",PASS,"Correct message is displayed for replacement of existing QIF file")
				[+] else
					[ ] ReportStatus("Verify alert message for replacement of QIF file",FAIL,"Correct message is not displayed for replacement of existing QIF file, Actual - {sActual}, Expected- {sMessage}")
					[ ] 
				[ ] AlertMessage.Yes.Click()
				[ ] 
			[+] if(FileExists(sFileName))
				[ ] ReportStatus("Verify QIF export functionality",PASS,"QIF file is exported successfully")
			[+] else
				[ ] ReportStatus("Verify QIF export functionality",FAIL,"QIF file is not exported successfully")
		[+] else
			[ ] ReportStatus("Valiade QIF Export PopUp",FAIL,"QIF Export PopUp did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# QIF Export - saying no to overwrite file #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_VerifyQIFExportForNotOverwriting()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QIF is not overwrite the exported data file when user click on NO for overwrite
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	10/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test07_VerifyQIFExportForNotOverwriting() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] // STRING sFileName
		[ ] // 
		[ ] // //Fetch the record from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] // sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}.QIF"
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileExport.Click()
		[ ] QuickenWindow.File.FileExport.QIFFile.Select()
		[+] if(QIFExportPopUp.Exists(3))
			[ ] 
			[ ] QIFExportPopUp.SetActive()
			[ ] // Uncheck For Quicken Mac checkbox
			[+] if(QIFExportPopUp.ForQuickenMac.Exists(SHORT_SLEEP))
				[ ] QIFExportPopUp.ForQuickenMac.Uncheck()
			[ ] 
			[ ] // Click OK button
			[ ] QIFExportPopUp.OK.Click()
			[ ] 
			[+] if(AlertMessage.Exists(2))
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.No.Click()
				[+] if(QIFExportPopUp.Exists(2))
					[ ] QIFExportPopUp.SetActive()
					[ ] ReportStatus("Verify cancellation of overwriting of QIF",PASS,"Overwriting of QIF file is cancelled successfully")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify QIF Export popup",FAIL,"QIF Export dialog is not displayed")
			[+] else
				[ ] ReportStatus("Verify alert message for overwriting the QIF file",FAIL,"Alert message is not displayed for overwriting the QIF file")
			[ ] QIFExportPopUp.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Valiade QIF Export PopUp",FAIL,"QIF Export PopUp did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify QIF Import UI ##########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_VerifyQIFImportUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QIF Import UI 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	04/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test08_VerifyQIFImportUI() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sHelpContent, sExpected,sFileName
		[ ] LIST OF STRING lsQuickenFileAttributes
		[ ] INTEGER iDataFileAccounts,iNumberOfAccounts,iPropertyAccount,iSavingGoalAccount
		[ ] 
		[ ] sExpected= "Import from QIF File"
		[ ] sHelpContent="Import data into Quicken"
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}.QIF"
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileImport.Click()
		[ ] QuickenWindow.File.FileImport.QIFFile.Select()
		[+] if(QIFImportPopUp.Exists(3))
			[ ] 
			[ ] QIFImportPopUp.SetActive()
			[ ] 
			[ ] // Verify Browse button
			[+] if(QIFImportPopUp.Browse.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Browse button",PASS,"Browse button is displayed on QIF Import popup")
				[ ] QIFImportPopUp.Browse.Click()
				[+] if(ImportExportQuickenFile.Exists(2))
					[ ] sActual=ImportExportQuickenFile.GetCaption()
					[+] if(sActual==sExpected)
						[ ] ReportStatus("Verify window name after clicking on Browse button",PASS,"{sExpected} window is opened after clicking on Browse button")
						[ ] ImportExportQuickenFile.FileName.SetText(sFileName)
						[ ] ImportExportQuickenFile.OK.Click()
					[+] else
						[ ] ReportStatus("Verify window name after clicking on Browse button",FAIL,"{sExpected} window is not opened after clicking on Browse button, Actual window is {sActual}")
						[ ] ImportExportQuickenFile.Close()
						[ ] 
				[+] else
					[ ] ReportStatus("Verify window after clicking on Browse button",FAIL,"{sExpected} window is not opened after clicking on Browse button")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Browse button",FAIL,"Browse button is not displayed on QIF import popup")
				[ ] 
			[ ] 
			[ ] // Verify  Location of QIF file text field
			[+] if(QIFImportPopUp.LocationOfQIFFileTextField.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Location of QIF file text field",PASS,"Location of QIF file text field is displayed on QIF import popup")
				[ ] sActual=QIFImportPopUp.LocationOfQIFFileTextField.GetText()
				[+] if(sActual==sFileName)
					[ ] ReportStatus("Verify Location of QIF file text field's value",PASS,"Location of QIF file text field is displayed with correct value")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Location of QIF file text field's value",FAIL,"Location of QIF file text field is not displayed with correct value, Actual-{sActual},Expected- {sFileName}")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Location of QIF file text field",FAIL,"Location of QIF file text field is not displayed on QIF import popup")
				[ ] 
			[ ] 
			[ ] 
			[ ] // Verify Quicken account to import into dropdown
			[+] if(QIFImportPopUp.QuickenAccountToImportInto.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Quicken account to import into dropdown",PASS,"Quicken account to import into dropdown is displayed on QIF import popup")
				[ ] iNumberOfAccounts=QIFImportPopUp.QuickenAccountToImportInto.GetItemCount()
			[+] else
				[ ] ReportStatus("Verify Quicken account to import into dropdown",FAIL,"Quicken account to import into dropdown is not displayed on QIF import popup")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] // Verify Include in Import checkboxes
				[ ] 
				[ ] // Verify Transactions checkbox
				[+] if(QIFImportPopUp.Transactions.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Transactions checkbox",PASS,"Transactions checkbox is displayed on QIF export popup")
				[+] else
					[ ] ReportStatus("Verify Transactions checkbox",FAIL,"Transactions checkbox is not displayed on QIF export popup")
				[ ] 
				[ ] // Verify Account List checkbox
				[+] if(QIFImportPopUp.AccountList.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Account List checkbox",PASS,"Account List checkbox is displayed on QIF Import popup")
				[+] else
					[ ] ReportStatus("Verify Account List checkbox",FAIL,"Account List checkbox is not displayed on QIF Import popup")
				[ ] 
				[ ] // Verify Category List checkbox
				[+] if(QIFImportPopUp.CategoryList.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Category List checkbox",PASS,"Category List checkbox is displayed on QIF Import popup")
				[+] else
					[ ] ReportStatus("Verify Category List checkbox",FAIL,"Category List checkbox is not displayed on QIF Import popup")
				[ ] 
				[ ] // Verify Memorized Payees checkbox
				[+] if(QIFImportPopUp.MemorizedPayees.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Memorized Payees checkbox",PASS,"Memorized Payees checkbox is displayed on QIF Import popup")
				[+] else
					[ ] ReportStatus("Verify Memorized Payees checkbox",FAIL,"Memorized Payees checkbox is not displayed on QIF Import popup")
				[ ] 
				[ ] // Verify Security List checkbox
				[+] if(QIFImportPopUp.SecurityLists.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Security List checkbox",PASS,"Security List checkbox is displayed on QIF Import popup")
				[+] else
					[ ] ReportStatus("Verify Security List checkbox",FAIL,"Security List checkbox is not displayed on QIF Import popup")
				[ ] 
				[ ] // Verify Business List checkbox
				[+] if(QIFImportPopUp.BusinessLists.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Business List checkbox",PASS,"Business List checkbox is displayed on QIF Import popup")
				[+] else
					[ ] ReportStatus("Verify Business List checkbox",FAIL,"Business List checkbox is not displayed on QIF Import popup")
				[ ] 
				[ ] // Verify Special Handling For Transfers checkbox
				[+] if(QIFImportPopUp.SpecialHandlingForTransfers.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Special Handling For Transfers checkbox",PASS,"Special Handling For Transfers checkbox is displayed on QIF Import popup")
				[+] else
					[ ] ReportStatus("Verify Special Handling For Transfers checkbox",FAIL,"Special Handling For Transfers checkbox is not displayed on QIF Import popup")
				[ ] 
			[ ] 
			[ ] // Verify Help Icon
			[+] if(QIFImportPopUp.HelpIcon.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Help Icon",PASS,"Help Icon is displayed on QIF Import popup")
				[ ] QIFImportPopUp.HelpIcon.Click()
				[+] if(QuickenHelp.Exists(2))
					[ ] QuickenHelp.SetActive()
					[+] do
						[ ] QuickenHelp.TextClick(sHelpContent)
					[+] except
						[ ] ReportStatus("Verify Help content",FAIL,"{sHelpContent} text is not displayed on Quicken Help window")
					[ ] 
					[ ] QuickenHelp.Close()
				[+] else
					[ ] ReportStatus("Verify window after clicking on Help icon",FAIL,"Quicken Help window is not opened after clicking on Help icon")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Help Icon",FAIL,"Help Icon is not displayed on QIF Import popup")
				[ ] 
			[ ] 
			[ ] // Verify Import button
			[+] if(QIFImportPopUp.Import.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Import button",PASS,"Import button is displayed on QIF Import popup")
			[+] else
				[ ] ReportStatus("Verify Import button",FAIL,"Import button is not displayed on QIF Import popup")
				[ ] 
			[ ] 
			[ ] // Verify Cancel button
			[+] if(QIFImportPopUp.Cancel.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Cancel button",PASS,"Cancel button is displayed on QIF Import popup")
				[ ] QIFImportPopUp.Cancel.Click()
				[+] if(!QIFImportPopUp.Exists(2))
					[ ] ReportStatus("Verify Cancel button functionality",PASS,"QIF Import window is closed after clicking on cancel button")
				[+] else
					[ ] ReportStatus("Verify Cancel button functionality",FAIL,"QIF Import window is not closed after clicking on cancel button")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Cancel button",FAIL,"Cancel button is not displayed on QIF Import popup")
				[ ] 
			[ ] 
			[ ] 
			[ ] // Verify number of accounts in Quicken account to import into dropdown
			[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.Exists(2))
				[ ] iPropertyAccount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.GetItemCount()
			[+] else
				[ ] ReportStatus("Verify Property accounts",FAIL,"Property accounts are not present in the data file")
			[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer6.ListBox.Exists(2))
				[ ] iSavingGoalAccount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer6.ListBox.GetItemCount()
			[+] else
				[ ] ReportStatus("Verify Saving Goal accounts",FAIL,"Saving Goal accounts are not present in the data file")
			[ ] 
			[ ] iDataFileAccounts=iPropertyAccount+iSavingGoalAccount
			[+] if(iNumberOfAccounts==iDataFileAccounts+1)		// +1 for "All Accounts" entry
				[ ] ReportStatus("Verify number of accounts in Quicken account to import into dropdown",PASS,"{iNumberOfAccounts} accounts are available in Quicken account to import into dropdown")
			[+] else
				[ ] ReportStatus("Verify number of accounts in Quicken account to import into dropdown",FAIL,"Correct number of accounts are not available in Quicken account to import into dropdown, Actual-{iNumberOfAccounts}, Expected-{iDataFileAccounts+1}")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Valiade QIF Import PopUp",FAIL,"QIF Import PopUp did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Close and Alt f4 for QIF Import window ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_VerifyCloseAndAltF4ForQIFImportWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Close and Alt f4 for  QIF Import  window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Close and Alt f4 is working for  QIF Import  window			
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	30/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test09_VerifyCloseAndAltF4ForQIFImportWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] LIST OF STRING lsOperation= {"Close","Alt-F4"}
	[ ] 
	[+] for(i=1;i<=2;i++)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileImport.Click()
			[ ] QuickenWindow.File.FileImport.QIFFile.Select()
			[+] if(QIFImportPopUp.Exists(3))
				[ ] 
				[ ] QIFImportPopUp.SetActive()
				[ ] 
				[+] if(i==1)
					[ ] QIFImportPopUp.Close()
				[+] else
					[ ] QIFImportPopUp.TypeKeys(KEY_EXIT)
				[ ] 
				[+] if(!CopyFile.Exists(2))
					[ ] ReportStatus("Verify close functionality for QIF Import  window",PASS,"QIF Import window gets closed after {lsOperation[i]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify close functionality for QIF Import window",FAIL,"QIF Import window did not close after {lsOperation[i]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade QIF Import",FAIL,"QIF Import popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify QIF Import Functionality ################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyQIFImport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QIF import functionality with all options
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	14/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[-] testcase Test10_VerifyQIFImport() appstate QuickenBaseState
	[+] //Variable declaration
		[ ] STRING sFileName,sTempDataFile, sExpectedTotalAsset,sExpectedTotalInvesting,sActualTotalAsset,sActualTotalInvesting
		[ ] INTEGER iActualInvestingAccount,iActualPropertyAccount,iExpectedInvestingAccount,iExpectedPropertyAccount,iOpenReport
		[ ] BOOLEAN bTotalAsset,bTotalInvesting
		[ ] LIST of STRING lsList
		[ ] sTempDataFile="TempDataFile"
		[ ] bMatch=FALSE
		[ ] bFlag=FALSE
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}.QIF"
		[+] if(FileExists(sTempDataFile))
			[ ] DeleteFile(sTempDataFile)
		[ ] 
		[+] if(FileExists(sFileName))
			[ ] DeleteFile(sFileName)
		[ ] 
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iExpectedInvestingAccount=GetNoOfAccountsOnAccountBar(ACCOUNT_INVESTING)
		[ ] iExpectedPropertyAccount=GetNoOfAccountsOnAccountBar(ACCOUNT_PROPERTYDEBT)
		[ ] 
		[ ] iOpenReport=OpenReport(sREPORT_NETWORTH_BALANCES,sREPORT_ACCOUNT_BALANCE)
		[+] if(iOpenReport==PASS)
			[ ] 
			[+] if(AccountBalances.Exists(10))
				[ ] AccountBalances.SetActive()
				[ ] iCount=AccountBalances.QWListViewer.ListBox.GetItemCount()
				[ ] sHandle = Str(AccountBalances.QWListViewer.ListBox.GetHandle ())
				[+] for(i=iCount;i>=1;--i)
					[ ] sActual=NULL
					[ ] lsList=NULL
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bTotalAsset = MatchStr("*TOTAL Asset Accounts*", sActual)
					[+] if(bTotalAsset)
						[ ] sActual=StrTran (sActual, "@@", "@")
						[ ] lsList=split(sActual,"@")
						[ ] sExpectedTotalAsset=lsList[3]
						[ ] bMatch=TRUE
					[ ] bTotalInvesting = MatchStr("*TOTAL Investment Accounts*", sActual)
					[+] if(bTotalInvesting)
						[ ] sActual=StrTran (sActual, "@@", "@")
						[ ] lsList=split(sActual,"@")
						[ ] sExpectedTotalInvesting=lsList[3]
						[ ] bFlag=TRUE
					[+] if(bMatch==TRUE && bFlag==TRUE)
						[ ] break
					[+] else
						[ ] continue
				[ ] 
				[ ] AccountBalances.Close()
			[+] else
				[ ] ReportStatus("Open {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_ACCOUNT_BALANCE} report is not opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Open {sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report is not opened")
		[ ] 
		[ ] iResult=ExportQIFFile(sFileName)
		[-] if(iResult==PASS)
			[ ] 
			[ ] iValidate=DataFileCreate(sTempDataFile)
			[-] if(iValidate==PASS)
				[ ] 
				[ ] iResult=NULL
				[ ] iResult=ImportQIFFile(sFileName)
				[-] if(iResult==PASS)
					[ ] 
					[-] if(QuickenWindow.Exists(2))
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] iActualInvestingAccount=GetNoOfAccountsOnAccountBar(ACCOUNT_INVESTING)
						[ ] iActualPropertyAccount=GetNoOfAccountsOnAccountBar(ACCOUNT_PROPERTYDEBT)
						[ ] 
						[+] if(iActualInvestingAccount==iExpectedInvestingAccount)
							[ ] ReportStatus("Verify number of Investing accounts after QIF import",PASS,"{iExpectedInvestingAccount} Investing accounts are displayed after QIF import")
						[+] else
							[ ] ReportStatus("Verify number of Investing accounts after QIF import",FAIL,"{iExpectedInvestingAccount} Investing accounts are not displayed after QIF import, Actual is {iActualInvestingAccount}")
						[+] // if(iActualPropertyAccount==iExpectedPropertyAccount)
							[ ] // ReportStatus("Verify number of Investing accounts after QIF import",PASS,"{iExpectedPropertyAccount} Investing accounts are displayed after QIF import")
						[+] // else
							[ ] // ReportStatus("Verify number of Investing accounts after QIF import",FAIL,"{iExpectedPropertyAccount} Investing accounts are not displayed after QIF import, Actual is {iActualPropertyAccount}- defect id = QW-3125")
						[ ] 
						[+] if(iOpenReport==PASS)
							[ ] iResult=NULL
							[ ] bMatch=FALSE
							[ ] bFlag=FALSE
							[ ] 
							[ ] iResult=OpenReport(sREPORT_NETWORTH_BALANCES,sREPORT_ACCOUNT_BALANCE)
							[+] if(iResult==PASS)
								[ ] 
								[+] if(AccountBalances.Exists(10))
									[ ] AccountBalances.SetActive()
									[ ] iCount=AccountBalances.QWListViewer.ListBox.GetItemCount()
									[ ] sHandle = Str(AccountBalances.QWListViewer.ListBox.GetHandle ())
									[+] for(i=iCount;i>=1;i--)
										[ ] sActual=NULL
										[ ] lsList=NULL
										[ ] 
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
										[ ] bTotalAsset = MatchStr("*TOTAL Asset Accounts*", sActual)
										[+] if(bTotalAsset)
											[ ] sActual=StrTran (sActual, "@@", "@")
											[ ] lsList=split(sActual,"@")
											[ ] sActualTotalAsset=lsList[3]
											[ ] bMatch=TRUE
										[ ] bTotalInvesting = MatchStr("*TOTAL Investment Accounts*", sActual)
										[+] if(bTotalInvesting)
											[ ] sActual=StrTran (sActual, "@@", "@")
											[ ] lsList=split(sActual,"@")
											[ ] sActualTotalInvesting=lsList[3]
											[ ] bFlag=TRUE
										[+] if(bMatch==TRUE && bFlag==TRUE)
											[ ] break
										[+] else
											[ ] continue
									[ ] 
									[ ] // Commented this code as QW-3412 is marked as "Not a bug"
									[+] // if(sActualTotalInvesting==sExpectedTotalInvesting)
										[ ] // ReportStatus("Verify total amount of Investing accounts after QIF import",PASS,"{sExpectedTotalInvesting} total amount for Investing accounts is displayed in Account balances report after QIF import")
									[+] // else
										[ ] // ReportStatus("Verify total amount of Investing accounts after QIF import",FAIL,"{sExpectedTotalInvesting} total amount for Investing accounts is not displayed in Account balances report after QIF import, Actual is {sActualTotalInvesting} - QW-3412")
									[+] if(sActualTotalAsset==sExpectedTotalAsset)
										[ ] ReportStatus("Verify total amount of Asset accounts after QIF import",PASS,"{sExpectedTotalAsset} total amount for Asset accounts is displayed in Account balances report after QIF import")
									[+] else
										[ ] ReportStatus("Verify total amount of Asset accounts after QIF import",FAIL,"{sExpectedTotalAsset} total amount for Asset accounts is not displayed in Account balances report after QIF import, Actual is {sActualTotalAsset}- defect id = QW-3125")
									[ ] 
								[+] else
									[ ] ReportStatus("Open {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_ACCOUNT_BALANCE} report is not opened")
									[ ] 
								[ ] 
								[ ] AccountBalances.Close()
							[+] else
								[ ] ReportStatus("Open {sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report is not opened")
						[+] else
							[ ] ReportStatus("Verify open report",FAIL,"Balances are not captured before exporting QIF")
					[+] else
						[ ] ReportStatus("Verify Quicken existance", FAIL,"Quicken did not Open" )
					[ ] 
					[ ] ReportStatus("Verify data file import",PASS,"Import Successful")
				[+] else
					[ ] ReportStatus("Verify data file import",FAIL,"Data file import is failed")
			[+] else
				[ ] ReportStatus("Create data file - {sTempDataFile}",FAIL,"{sTempDataFile} is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify export QIF file",FAIL,"Export QIF file failed")
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify QXF Export UI #######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_VerifyQXFExportUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QXF Export UI 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	10/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test11_VerifyQXFExportUI() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sExpectedFileType, sExpected,sFileName
		[ ] 
		[ ] sExpected= "Export to Quicken Transfer Format (.QXF) File"
		[ ] sExpectedFileType="QXF Files"
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] lsData=lsExcelData[1]
	[ ] 
	[+] if(QIFImportPopUp.Exists(3))
		[ ] QIFImportPopUp.SetActive()
		[ ] QIFImportPopUp.Close()
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Open existing data file
		[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
		[ ] //sleep(15)
		[ ] WaitForState(QuickenWindow,TRUE,25)
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileExport.Click()
			[ ] QuickenWindow.File.FileExport.QuickenTransferFormatQXF.Select()
			[+] if(ImportExportQuickenFile.Exists(3))
				[ ] 
				[ ] ImportExportQuickenFile.SetActive()
				[ ] 
				[ ] // Verify window name
				[ ] sActual= ImportExportQuickenFile.GetCaption()
				[+] if(sActual==sExpected)
					[ ] ReportStatus("Verify QXF export window name",PASS,"Export to Quicken Transfer Format (.QXF) File window is opened for QXF export")
				[+] else
					[ ] ReportStatus("Verify QXF export window name",FAIL,"Export to Quicken Transfer Format (.QXF) File is not opened for QXF export, Actual window is {sActual}")
					[ ] 
				[ ] 
				[ ] sActual=NULL
				[ ] // Verify File name: by default opened data file name should be displayed.
				[+] if(ImportExportQuickenFile.FileName.Exists(2))
					[ ] sActual=ImportExportQuickenFile.FileName.GetText()
					[+] if(MatchStr("{lsExcelData[1][1]}*",sActual))
						[ ] ReportStatus("Verify File name field and its default value",PASS,"File name text field is displayed with default value as opened file name")
					[+] else
						[ ] ReportStatus("Verify File name field and its default value",FAIL,"File name text field is not displayed with default value as opened file name, Actual - {sActual} and Expected - {lsExcelData[1][1]}")
						[ ] 
				[+] else
						[ ] ReportStatus("Verify File name field on Export to Quicken Transfer Format (.QXF) File PopUp",FAIL,"File name text field is not displayed on Export to Quicken Transfer Format (.QXF) File PopUp")
					[ ] 
				[ ] 
				[ ] sActual=NULL
				[ ] // Verify Save as type: QXF files should be the default value
				[+] if(ImportExportQuickenFile.SaveAsType.Exists(2))
					[ ] sActual=ImportExportQuickenFile.SaveAsType.GetText()
					[+] if(sActual==sExpectedFileType)
						[ ] ReportStatus("Verify Save As Type field and its default value",PASS,"Save As Type field is displayed with default value as QXF files")
					[+] else
						[ ] ReportStatus("Verify Save As Type field and its default value",FAIL,"Save As Type field is not displayed with default value, Actual - {sActual} and Expected - {sExpectedFileType}")
						[ ] 
				[+] else
						[ ] ReportStatus("Verify Save As Type field on Export to Quicken Transfer Format (.QXF) File PopUp",FAIL,"Save As Type field is not displayed on Export to Quicken Transfer Format (.QXF) File PopUp")
					[ ] 
				[ ] 
				[ ] // Verify Save button
				[+] if(ImportExportQuickenFile.OK.Exists(2))
					[ ] ReportStatus("Verify Save button on Export to Quicken Transfer Format (.QXF) File window",PASS,"Save button is present on Export to Quicken Transfer Format (.QXF) File window")
				[+] else
					[ ] ReportStatus("Verify Save button on Export to Quicken Transfer Format (.QXF) File window",FAIL,"Save button is not present on Export to Quicken Transfer Format (.QXF) File window")
				[ ] 
				[ ] //Verify Cancel button
				[+] if(ImportExportQuickenFile.Cancel.Exists(2))
					[ ] ReportStatus("Verify Cancel button on Export to Quicken Transfer Format (.QXF) File window",PASS,"Cancel button is present on Export to Quicken Transfer Format (.QXF) File window")
					[ ] ImportExportQuickenFile.Cancel.Click()
					[+] if(!ImportExportQuickenFile.Exists(2))
						[ ] ReportStatus("Verify Cancel button functionality",PASS,"Export to Quicken Transfer Format (.QXF) File window is closed when user clicks on Cancel button")
					[+] else
						[ ] ReportStatus("Verify Cancel button functionality",FAIL,"Export to Quicken Transfer Format (.QXF) File window is not closed when user clicks on Cancel button")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Cancel button on Export to Quicken Transfer Format (.QXF) File window",FAIL,"Cancel button is not present on Export to Quicken Transfer Format (.QXF) File window")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade Export to Quicken Transfer Format (.QXF) File PopUp",FAIL,"Export to Quicken Transfer Format (.QXF) File PopUp did not appear")
		[+] else
			[ ] ReportStatus("Open QDF FIle", FAIL,"Unable to open {lsData[1]} data file!" )
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Close and Alt f4 for QXF Export window ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_VerifyCloseAndAltF4ForQXFExportWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Close and Alt f4 for  QXF Export  window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Close and Alt f4 is working for  QXF Export  window			
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	11/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test12_VerifyCloseAndAltF4ForQXFExportWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] LIST OF STRING lsOperation= {"Close","Alt-F4"}
	[ ] 
	[+] for(i=1;i<=2;i++)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileExport.Click()
			[ ] QuickenWindow.File.FileExport.QuickenTransferFormatQXF.Select()
			[+] if(ImportExportQuickenFile.Exists(3))
				[ ] 
				[ ] ImportExportQuickenFile.SetActive()
				[ ] 
				[+] if(i==1)
					[ ] ImportExportQuickenFile.Close()
				[+] else
					[ ] ImportExportQuickenFile.TypeKeys(KEY_EXIT)
				[ ] 
				[+] if(!ImportExportQuickenFile.Exists(2))
					[ ] ReportStatus("Verify close functionality for QXF Export  window",PASS,"Export to Quicken Transfer Format (.QXF) File window gets closed after {lsOperation[i]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify close functionality for QXF Export window",FAIL,"Export to Quicken Transfer Format (.QXF) File window did not close after {lsOperation[i]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade QXF Export",FAIL,"QXF Export popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify QXF Export UI #######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_VerifyQXFExport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QXF Export functionality 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	22/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test13_VerifyQXFExport() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING  sFileName
		[ ] 
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}.qxf"
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=ExportQXFFile(sFileName)
		[+] if(iResult==PASS)
			[ ] ReportStatus("Verify QXF file export",PASS,"{lsExcelData[1][1]}.qxf file exported successfully.")
		[+] else
			[ ] ReportStatus("Verify QXF file export",FAIL,"{lsExcelData[1][1]}.qxf file is not exported successfully.")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify QXF Import UI ########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_VerifyQXFImportUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QXF Import UI 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	04/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test14_VerifyQXFImportUI() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sHelpContent, sExpected,sExpectedFileType,sText,sFileName
		[ ] 
		[ ] sExpectedFileType="QXF Files"
		[ ] sExpected= "Import from Quicken Transfer Format (.QXF) File"
		[ ] sHelpContent="Import a Quicken Transfer Format (.QXF) file"
		[ ] sText =  "see this help topic"
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}.qxf"
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileImport.Click()
		[ ] QuickenWindow.File.FileImport.QuickenTransferFormatFile.Select()
		[+] if(QXFImportPopUp.Exists(3))
			[ ] 
			[ ] QXFImportPopUp.SetActive()
			[ ] 
			[ ] // Verify Browse button
			[+] if(QXFImportPopUp.Browse.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Browse button",PASS,"Browse button is displayed on QXF Import popup")
				[ ] QXFImportPopUp.Browse.Click()
				[+] if(ImportExportQuickenFile.Exists(2))
					[ ] sActual=NULL
					[ ] sActual=ImportExportQuickenFile.GetCaption()
					[+] if(sActual==sExpected)
						[ ] ReportStatus("Verify window name after clicking on Browse button",PASS,"{sExpected} window is opened after clicking on Browse button")
					[+] else
						[ ] ReportStatus("Verify window name after clicking on Browse button",FAIL,"{sExpected} window is not opened after clicking on Browse button, Actual window is {sActual}")
						[ ] 
					[ ] 
					[ ] sActual=NULL
					[ ] // Verify File name: by default it should be blank
					[+] if(ImportExportQuickenFile.FileName.Exists(2))
						[ ] sActual=ImportExportQuickenFile.FileName.GetText()
						[+] if(sActual=="")
							[ ] ReportStatus("Verify File name field and its default value",PASS,"File name text field is displayed with no default value")
						[+] else
							[ ] ReportStatus("Verify File name field and its default value",FAIL,"File name text field is not displayed with no default value, Actual - {sActual}")
							[ ] 
					[+] else
							[ ] ReportStatus("Verify File name field on Import to Quicken Transfer Format (.QXF) File PopUp",FAIL,"File name text field is not displayed on Import to Quicken Transfer Format (.QXF) File PopUp")
						[ ] 
					[ ] 
					[ ] sActual=NULL
					[ ] // Verify Save as type: QXF files should be the default value
					[+] if(ImportExportQuickenFile.SaveAsType.Exists(2))
						[ ] sActual=ImportExportQuickenFile.SaveAsType.GetText()
						[+] if(sActual==sExpectedFileType)
							[ ] ReportStatus("Verify Save As Type field and its default value",PASS,"Save As Type field is displayed with default value as QXF files")
						[+] else
							[ ] ReportStatus("Verify Save As Type field and its default value",FAIL,"Save As Type field is not displayed with default value, Actual - {sActual} and Expected - {sExpectedFileType}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Save As Type field on Import to Quicken Transfer Format (.QXF) File PopUp",FAIL,"Save As Type field is not displayed on Import to Quicken Transfer Format (.QXF) File PopUp")
						[ ] 
					[ ] 
					[ ] ImportExportQuickenFile.FileName.SetText(sFileName)
					[ ] ImportExportQuickenFile.SetActive()
					[ ] ImportExportQuickenFile.Open.DoubleClick()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify window after clicking on Browse button",FAIL,"{sExpected} window is not opened after clicking on Browse button")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Browse button",FAIL,"Browse button is not displayed on QXF import popup")
				[ ] 
			[ ] 
			[ ] // Verify  Select The QXF File To Import text field
			[+] if(QXFImportPopUp.SelectTheQXFFileToImportTextField.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Select The QXF File To Import text field",PASS,"Select The QXF File To Import text field is displayed on QIF import popup")
				[ ] sActual=NULL
				[ ] sActual=QXFImportPopUp.SelectTheQXFFileToImportTextField.GetText()
				[+] if(sActual==sFileName)
					[ ] ReportStatus("Verify Select The QXF File To Import text field's value",PASS,"The QXF File To Import text field is displayed with correct value")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify The QXF File To Import text field's value",FAIL,"The QXF File To Import text field is not displayed with correct value, Actual-{sActual},Expected- {sFileName}")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify The QXF File To Import text field",FAIL,"The QXF File To Import file text field is not displayed on QXF import popup")
				[ ] 
			[ ] 
			[ ] // Verify "Investing accounts will not be imported" text on QXF import window
			[+] if(QXFImportPopUp.NoteText.Exists(2))
				[ ] sActual=NULL
				[ ] sActual=QXFImportPopUp.NoteText.GetText()
				[ ] ReportStatus("Verify note on QXF import window",PASS,"{sActual} note is displayed on The QXF File To Import text field is displayed on QIF import popup")
			[+] else
				[ ] ReportStatus("Verify note on QXF import window",FAIL,"Correct note is not displayed on The QXF File To Import text field is displayed on QIF import popup, Actual is {sActual}")
				[ ] 
			[ ] 
			[ ] 
			[ ] // Verify "See this help topic" link
			[+] do
				[ ] QXFImportPopUp.TextClick(sText)
			[+] except
				[ ] ReportStatus("Verify See this help topic link on QXF import window",FAIL,"See this help topic link is not displayed on QXF import window")
			[ ] 
			[ ] QXFImportPopUp.SetActive()
			[ ] 
			[ ] // Verify Help Icon
			[+] if(QXFImportPopUp.HelpIcon.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Help Icon",PASS,"Help Icon is displayed on QXF Import popup")
				[ ] QXFImportPopUp.SetActive()
				[ ] QXFImportPopUp.HelpIcon.Click()
				[+] if(QuickenHelp.Exists(5))
					[ ] ReportStatus("Verify QuickenHelp dialog",PASS,"QuickenHelp dialog is displayed")
					[ ] 
					[ ] QuickenHelp.SetActive()
					[+] do
						[ ] QuickenHelp.TextClick(sHelpContent)
					[+] except
						[ ] ReportStatus("Verify Help content",FAIL,"{sHelpContent} text is not displayed on Quicken Help window")
					[ ] 
					[ ] QuickenHelp.Close()
				[+] else
					[ ] ReportStatus("Verify window after clicking on Help icon",FAIL,"Quicken Help window is not opened after clicking on Help icon")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Help Icon",FAIL,"Help Icon is not displayed on QXF Import popup")
				[ ] 
			[ ] 
			[ ] // Verify Continue button
			[+] if(QXFImportPopUp.Continue.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Continue button",PASS,"Continue button is displayed on QXF Import popup")
			[+] else
				[ ] ReportStatus("Verify Continue button",FAIL,"Continue button is not displayed on QXF Import popup")
				[ ] 
			[ ] 
			[ ] // Verify Cancel button
			[+] if(QXFImportPopUp.Cancel.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Cancel button",PASS,"Cancel button is displayed on QXF Import popup")
				[ ] QXFImportPopUp.SetActive()
				[ ] QXFImportPopUp.Cancel.Click()
				[+] if(!QXFImportPopUp.Exists(2))
					[ ] ReportStatus("Verify Cancel button functionality",PASS,"QXF Import window is closed after clicking on cancel button")
				[+] else
					[ ] ReportStatus("Verify Cancel button functionality",FAIL,"QXF Import window is not closed after clicking on cancel button")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Cancel button",FAIL,"Cancel button is not displayed on QXF Import popup")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Valiade QIF Import PopUp",FAIL,"QXF Import PopUp did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Close and Alt f4 for QXF Import window ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_VerifyCloseAndAltF4ForQXFImportWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Close and Alt f4 for  QXF Import  window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Close and Alt f4 is working for QXF Import  window			
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	14/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test15_VerifyCloseAndAltF4ForQXFImportWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] LIST OF STRING lsOperation= {"Close","Alt-F4"}
	[ ] 
	[+] for(i=1;i<=2;i++)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileImport.Click()
			[ ] QuickenWindow.File.FileImport.QuickenTransferFormatFile.Select()
			[+] if(QXFImportPopUp.Exists(3))
				[ ] 
				[ ] QXFImportPopUp.SetActive()
				[ ] 
				[+] if(i==1)
					[ ] QXFImportPopUp.Close()
				[+] else
					[ ] QXFImportPopUp.TypeKeys(KEY_EXIT)
				[ ] 
				[+] if(!QXFImportPopUp.Exists(2))
					[ ] ReportStatus("Verify close functionality for QXF Import  window",PASS,"QXF Import window gets closed after {lsOperation[i]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify close functionality for QXF Import window",FAIL,"QXF Import window did not close after {lsOperation[i]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade QXF Import",FAIL,"QXF Import popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify QXF Import functionality: by viewing logs ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_VerifyQXFImport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QXF Import functionality: by viewing logs
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	23/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test16_VerifyQXFImport() appstate QuickenBaseState
	[+] //Variable declaration
		[ ] STRING sFileName,sTempDataFile, sExpectedTotalAsset,sActualTotalAsset,sExpectedTotalCreditCard,sActualTotalCreditCard
		[ ] INTEGER iActualInvestingAccount,iActualPropertyAccount,iExpectedPropertyAccount,iOpenReport
		[ ] BOOLEAN bTotalAsset,bTotalInvesting
		[ ] LIST of STRING lsList
		[ ] sTempDataFile="TempDataFile"
		[ ] bMatch=FALSE
		[ ] bFlag=FALSE
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}.qxf"
		[ ] 
		[+] if(FileExists(sTempDataFile))
			[ ] DeleteFile(sTempDataFile)
		[ ] 
		[+] if(FileExists(sFileName))
			[ ] DeleteFile(sFileName)
		[ ] 
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iOpenReport=OpenReport(sREPORT_NETWORTH_BALANCES,sREPORT_ACCOUNT_BALANCE)
		[+] if(iOpenReport==PASS)
			[ ] 
			[+] if(AccountBalances.Exists(10))
				[ ] AccountBalances.SetActive()
				[ ] iCount=AccountBalances.QWListViewer.ListBox.GetItemCount()
				[ ] sHandle = Str(AccountBalances.QWListViewer.ListBox.GetHandle ())
				[+] for(i=iCount;i>=1;--i)
					[ ] sActual=NULL
					[ ] lsList=NULL
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bTotalAsset = MatchStr("*TOTAL Asset Accounts*", sActual)
					[+] if(bTotalAsset)
						[ ] sActual=StrTran (sActual, "@@", "@")
						[ ] lsList=split(sActual,"@")
						[ ] sExpectedTotalAsset=lsList[3]
						[ ] bMatch=TRUE
					[ ] bTotalInvesting = MatchStr("*TOTAL Credit Card Accounts*", sActual)
					[+] if(bTotalInvesting)
						[ ] sActual=StrTran (sActual, "@@", "@")
						[ ] lsList=split(sActual,"@")
						[ ] sExpectedTotalCreditCard=lsList[3]
						[ ] bFlag=TRUE
					[+] if(bMatch==TRUE && bFlag==TRUE)
						[ ] break
					[+] else
						[ ] continue
				[ ] 
				[ ] AccountBalances.Close()
			[+] else
				[ ] ReportStatus("Open {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_ACCOUNT_BALANCE} report is not opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Open {sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report is not opened")
		[ ] 
		[ ] iResult=ExportQXFFile(sFileName)
		[+] if(iResult==PASS)
			[ ] 
			[ ] iValidate=DataFileCreate(sTempDataFile)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] iResult=NULL
				[ ] iResult=ImportQXFFile(sFileName,TRUE)
				[+] if(iResult==PASS)
					[ ] 
					[+] if(QuickenWindow.Exists(2))
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] iActualInvestingAccount=GetNoOfAccountsOnAccountBar(ACCOUNT_INVESTING)
						[ ] 
						[+] if(iActualInvestingAccount==0)
							[ ] ReportStatus("Verify number of Investing accounts after QXF import",PASS,"No Investing account is displayed after QXF import")
						[+] else
							[ ] ReportStatus("Verify number of Investing accounts after QXF import",FAIL,"Investing accounts are displayed after QXF import, Actual is {iActualInvestingAccount}, Expected=0")
						[ ] 
						[+] if(iOpenReport==PASS)
							[ ] iResult=NULL
							[ ] bMatch=FALSE
							[ ] bFlag=FALSE
							[ ] 
							[ ] iResult=OpenReport(sREPORT_NETWORTH_BALANCES,sREPORT_ACCOUNT_BALANCE)
							[+] if(iResult==PASS)
								[ ] 
								[+] if(AccountBalances.Exists(10))
									[ ] AccountBalances.SetActive()
									[ ] iCount=AccountBalances.QWListViewer.ListBox.GetItemCount()
									[ ] sHandle = Str(AccountBalances.QWListViewer.ListBox.GetHandle ())
									[+] for(i=iCount;i>=1;i--)
										[ ] sActual=NULL
										[ ] lsList=NULL
										[ ] 
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
										[ ] bTotalAsset = MatchStr("*TOTAL Asset Accounts*", sActual)
										[+] if(bTotalAsset)
											[ ] sActual=StrTran (sActual, "@@", "@")
											[ ] lsList=split(sActual,"@")
											[ ] sActualTotalAsset=lsList[3]
											[ ] bMatch=TRUE
										[ ] bTotalInvesting = MatchStr("*TOTAL Credit Card Accounts*", sActual)
										[+] if(bTotalInvesting)
											[ ] sActual=StrTran (sActual, "@@", "@")
											[ ] lsList=split(sActual,"@")
											[ ] sActualTotalCreditCard=lsList[3]
											[ ] bFlag=TRUE
										[+] if(bMatch==TRUE && bFlag==TRUE)
											[ ] break
										[+] else
											[ ] continue
									[ ] 
									[+] if(sActualTotalCreditCard==sExpectedTotalCreditCard)
										[ ] ReportStatus("Verify total amount of credit card accounts after QXF import",PASS,"{sExpectedTotalCreditCard} total amount for credit card accounts is displayed in Account balances report after QXF import")
									[+] else
										[ ] ReportStatus("Verify total amount of Investing accounts after QIF import",FAIL,"{sExpectedTotalCreditCard} total amount for credit card accounts is not displayed in Account balances report after QXF import, Actual is {sActualTotalCreditCard}")
									[+] if(sActualTotalAsset==sExpectedTotalAsset)
										[ ] ReportStatus("Verify total amount of Asset accounts after QIF import",PASS,"{sExpectedTotalAsset} total amount for Asset accounts is displayed in Account balances report after QXF import")
									[+] else
										[ ] ReportStatus("Verify total amount of Asset accounts after QIF import",FAIL,"{sExpectedTotalAsset} total amount for Asset accounts is not displayed in Account balances report after QXF import, Actual is {sActualTotalAsset}")
									[ ] 
								[+] else
									[ ] ReportStatus("Open {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_ACCOUNT_BALANCE} report is not opened")
									[ ] 
								[ ] 
								[ ] AccountBalances.Close()
							[+] else
								[ ] ReportStatus("Open {sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report is not opened")
						[+] else
							[ ] ReportStatus("Verify open report",FAIL,"Balances are not captured before exporting QIF")
					[+] else
						[ ] ReportStatus("Verify Quicken existance", FAIL,"Quicken did not Open" )
					[ ] 
					[ ] 
					[ ] ReportStatus("Verify QXF file import",PASS,"Import Successful")
				[+] else
					[ ] ReportStatus("Verify QXF file import",FAIL,"QXF file import is failed")
			[+] else
				[ ] ReportStatus("Create data file - {sTempDataFile}",FAIL,"{sTempDataFile} is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify QXF export for opened data file",FAIL,"QXF file is not exported successfully befor import activity")
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify QXF Import functionality: without opening logs ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_VerifyQXFImportWithoutViewingLogs()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify QXF Import functionality: without opening logs
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	08/08/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test17_VerifyQXFImportWithoutViewingLogs() appstate QuickenBaseState
	[+] //Variable declaration
		[ ] STRING sFileName,sTempDataFile, sExpectedTotalAsset,sActualTotalAsset,sExpectedTotalCreditCard,sActualTotalCreditCard
		[ ] INTEGER iActualInvestingAccount,iActualPropertyAccount,iExpectedPropertyAccount,iOpenReport
		[ ] BOOLEAN bTotalAsset,bTotalInvesting
		[ ] LIST of STRING lsList
		[ ] sTempDataFile="TempDataFile"
		[ ] bMatch=FALSE
		[ ] bFlag=FALSE
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] lsData=lsExcelData[1]
		[ ] sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}.qxf"
		[ ] 
		[+] if(FileExists(sTempDataFile))
			[ ] DeleteFile(sTempDataFile)
		[ ] 
		[+] if(FileExists(sFileName))
			[ ] DeleteFile(sFileName)
		[ ] 
	[ ] 
	[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
	[+] if(iSelect==PASS)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] iOpenReport=OpenReport(sREPORT_NETWORTH_BALANCES,sREPORT_ACCOUNT_BALANCE)
			[+] if(iOpenReport==PASS)
				[ ] 
				[+] if(AccountBalances.Exists(10))
					[ ] AccountBalances.SetActive()
					[ ] iCount=AccountBalances.QWListViewer.ListBox.GetItemCount()
					[ ] sHandle = Str(AccountBalances.QWListViewer.ListBox.GetHandle ())
					[+] for(i=iCount;i>=1;--i)
						[ ] sActual=NULL
						[ ] lsList=NULL
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] bTotalAsset = MatchStr("*TOTAL Asset Accounts*", sActual)
						[+] if(bTotalAsset)
							[ ] sActual=StrTran (sActual, "@@", "@")
							[ ] lsList=split(sActual,"@")
							[ ] sExpectedTotalAsset=lsList[3]
							[ ] bMatch=TRUE
						[ ] bTotalInvesting = MatchStr("*TOTAL Credit Card Accounts*", sActual)
						[+] if(bTotalInvesting)
							[ ] sActual=StrTran (sActual, "@@", "@")
							[ ] lsList=split(sActual,"@")
							[ ] sExpectedTotalCreditCard=lsList[3]
							[ ] bFlag=TRUE
						[+] if(bMatch==TRUE && bFlag==TRUE)
							[ ] break
						[+] else
							[ ] continue
					[ ] 
					[ ] AccountBalances.Close()
				[+] else
					[ ] ReportStatus("Open {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_ACCOUNT_BALANCE} report is not opened")
					[ ] 
			[+] else
				[ ] ReportStatus("Open {sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report is not opened")
			[ ] 
			[ ] iResult=ExportQXFFile(sFileName)
			[+] if(iResult==PASS)
				[ ] 
				[ ] iValidate=DataFileCreate(sTempDataFile)
				[+] if(iValidate==PASS)
					[ ] 
					[ ] iResult=NULL
					[ ] iResult=ImportQXFFile(sFileName,FALSE)
					[+] if(iResult==PASS)
						[ ] 
						[+] if(QuickenWindow.Exists(2))
							[ ] QuickenWindow.SetActive()
							[ ] 
							[ ] iActualInvestingAccount=GetNoOfAccountsOnAccountBar(ACCOUNT_INVESTING)
							[ ] 
							[+] if(iActualInvestingAccount==0)
								[ ] ReportStatus("Verify number of Investing accounts after QXF import",PASS,"No Investing account is displayed after QXF import")
							[+] else
								[ ] ReportStatus("Verify number of Investing accounts after QXF import",FAIL,"Investing accounts are displayed after QXF import, Actual is {iActualInvestingAccount}, Expected=0")
							[ ] 
							[+] if(iOpenReport==PASS)
								[ ] iResult=NULL
								[ ] bMatch=FALSE
								[ ] bFlag=FALSE
								[ ] 
								[ ] iResult=OpenReport(sREPORT_NETWORTH_BALANCES,sREPORT_ACCOUNT_BALANCE)
								[+] if(iResult==PASS)
									[ ] 
									[+] if(AccountBalances.Exists(10))
										[ ] AccountBalances.SetActive()
										[ ] iCount=AccountBalances.QWListViewer.ListBox.GetItemCount()
										[ ] sHandle = Str(AccountBalances.QWListViewer.ListBox.GetHandle ())
										[+] for(i=iCount;i>=1;i--)
											[ ] sActual=NULL
											[ ] lsList=NULL
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
											[ ] bTotalAsset = MatchStr("*TOTAL Asset Accounts*", sActual)
											[+] if(bTotalAsset)
												[ ] sActual=StrTran (sActual, "@@", "@")
												[ ] lsList=split(sActual,"@")
												[ ] sActualTotalAsset=lsList[3]
												[ ] bMatch=TRUE
											[ ] bTotalInvesting = MatchStr("*TOTAL Credit Card Accounts*", sActual)
											[+] if(bTotalInvesting)
												[ ] sActual=StrTran (sActual, "@@", "@")
												[ ] lsList=split(sActual,"@")
												[ ] sActualTotalCreditCard=lsList[3]
												[ ] bFlag=TRUE
											[+] if(bMatch==TRUE && bFlag==TRUE)
												[ ] break
											[+] else
												[ ] continue
										[ ] 
										[+] if(sActualTotalCreditCard==sExpectedTotalCreditCard)
											[ ] ReportStatus("Verify total amount of credit card accounts after QXF import",PASS,"{sExpectedTotalCreditCard} total amount for credit card accounts is displayed in Account balances report after QXF import")
										[+] else
											[ ] ReportStatus("Verify total amount of Investing accounts after QIF import",FAIL,"{sExpectedTotalCreditCard} total amount for credit card accounts is not displayed in Account balances report after QXF import, Actual is {sActualTotalCreditCard}")
										[+] if(sActualTotalAsset==sExpectedTotalAsset)
											[ ] ReportStatus("Verify total amount of Asset accounts after QIF import",PASS,"{sExpectedTotalAsset} total amount for Asset accounts is displayed in Account balances report after QXF import")
										[+] else
											[ ] ReportStatus("Verify total amount of Asset accounts after QIF import",FAIL,"{sExpectedTotalAsset} total amount for Asset accounts is not displayed in Account balances report after QXF import, Actual is {sActualTotalAsset}")
										[ ] 
									[+] else
										[ ] ReportStatus("Open {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_ACCOUNT_BALANCE} report is not opened")
										[ ] 
									[ ] 
									[ ] AccountBalances.Close()
								[+] else
									[ ] ReportStatus("Open {sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report",FAIL,"{sREPORT_NETWORTH_BALANCES} > {sREPORT_ACCOUNT_BALANCE} report is not opened")
							[+] else
								[ ] ReportStatus("Verify open report",FAIL,"Balances are not captured before exporting QIF")
						[+] else
							[ ] ReportStatus("Verify Quicken existance", FAIL,"Quicken did not Open" )
						[ ] 
						[ ] 
						[ ] ReportStatus("Verify QXF file import",PASS,"Import Successful")
					[+] else
						[ ] ReportStatus("Verify QXF file import",FAIL,"QXF file import is failed")
				[+] else
					[ ] ReportStatus("Create data file - {sTempDataFile}",FAIL,"{sTempDataFile} is not created")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify QXF export for opened data file",FAIL,"QXF file is not exported successfully befor import activity")
			[ ] 
			[ ] // Open data file
			[ ] OpenDataFile(lsData[1],lsData[2])
		[+] else
			[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[+] else
		[ ] ReportStatus("Open data file {lsData[1]}",FAIL,"Data file {lsData[1]} couldn't open")
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Webconnect Import UI #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_VerifyQWebConnectImportUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Webconnect Import UI 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error		
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	18/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test18_VerifyQWebConnectImportUI() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sExpected,sFileName,sExpectedFileType
		[ ] 
		[ ] sExpectedFileType="Web Connect File (*.QFX)"
		[ ] sExpected= "Import Web Connect File"
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileImport.Click()
		[ ] QuickenWindow.File.FileImport.WebConnectFile.Select()
		[+] if (CreateQuickenFile.Exists(5))
			[ ] CreateQuickenFile.SetActive()
			[ ] 
			[ ] // Verify window name
			[ ] sActual=CreateQuickenFile.GetCaption()
			[+] if(sActual==sExpected)
				[ ] ReportStatus("Verify {sExpected} window",PASS,"{sExpected} window is displayed")
			[+] else
				[ ] ReportStatus("Verify {sExpected} window",FAIL,"{sExpected} window is displayed")
				[ ] 
			[ ] 
			[ ] sActual=NULL
			[ ] // Verify File name: by default it should be blank
			[+] if(CreateQuickenFile.FileName.Exists(SHORT_SLEEP))
				[ ] sActual=CreateQuickenFile.FileName.GetText()
				[+] if(sActual=="")
					[ ] ReportStatus("Verify File name field and its default value",PASS,"File name text field is displayed and default value is blank")
				[+] else
					[ ] ReportStatus("Verify File name field and its default value",FAIL,"File name text field is displayed but default value is not blank, Actual - {sActual}")
					[ ] 
			[+] else
					[ ] ReportStatus("Verify File name field on Import Web Connect File PopUp",FAIL,"File name text field is not displayed on Import Web Connect File PopUp")
				[ ] 
			[ ] 
			[ ] sActual=NULL
			[ ] // Verify FilesOf Type: QFX files should be the default value
			[+] if(CreateQuickenFile.FilesOfType.Exists(SHORT_SLEEP))
				[ ] sActual=CreateQuickenFile.FilesOfType.GetText()
				[+] if(sActual==sExpectedFileType)
					[ ] ReportStatus("Verify Files Of Type field and its default value",PASS,"Files Of Type field is displayed with default value as {sExpectedFileType}")
				[+] else
					[ ] ReportStatus("Verify Files Of Type field and its default value",FAIL,"Files Of Type field is not displayed with default value, Actual - {sActual} and Expected - {sExpectedFileType}")
					[ ] 
			[+] else
					[ ] ReportStatus("Verify Files Of Type field on Import Web Connect File PopUp",FAIL,"Files Of Type field is not displayed on Import Web Connect File PopUp")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Verify Open button
			[+] if(CreateQuickenFile.OK.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Open button",PASS,"Open button is displayed on Webconnect Import popup")
			[+] else
				[ ] ReportStatus("Verify Open button",FAIL,"Open button is not displayed on Webconnect Import popup")
				[ ] 
			[ ] 
			[ ] // Verify Cancel button
			[+] if(CreateQuickenFile.Cancel.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Cancel button",PASS,"Cancel button is displayed on Webconnect Import popup")
				[ ] CreateQuickenFile.Cancel.Click()
				[+] if(!CreateQuickenFile.Exists(2))
					[ ] ReportStatus("Verify Cancel button functionality",PASS,"Webconnect Import window is closed after clicking on cancel button")
				[+] else
					[ ] ReportStatus("Verify Cancel button functionality",FAIL,"Webconnect Import window is not closed after clicking on cancel button")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Cancel button",FAIL,"Cancel button is not displayed on Webconnect Import popup")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Valiade QIF Import PopUp",FAIL,"QXF Import PopUp did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Close and Alt f4 for Webconnect Import window ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_VerifyCloseAndAltF4ForWebConnectImportWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Close and Alt f4 for Webconnect Import  window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Close and Alt f4 is working for Webconnect Import  window			
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	18/07/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test19_VerifyCloseAndAltF4ForWebConnectImportWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] LIST OF STRING lsOperation= {"Close","Alt-F4"}
	[ ] 
	[+] for(i=1;i<=2;i++)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileImport.Click()
			[ ] QuickenWindow.File.FileImport.WebConnectFile.Select()
			[+] if(CreateQuickenFile.Exists(3))
				[ ] 
				[ ] CreateQuickenFile.SetActive()
				[ ] 
				[+] if(i==1)
					[ ] CreateQuickenFile.Close()
				[+] else
					[ ] CreateQuickenFile.TypeKeys(KEY_EXIT)
				[ ] 
				[+] if(!CreateQuickenFile.Exists(2))
					[ ] ReportStatus("Verify close functionality for Webconnect Import  window",PASS,"Webconnect Import window gets closed after {lsOperation[i]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify close functionality for Webconnect Import window",FAIL,"Webconnect Import window did not close after {lsOperation[i]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade Webconnect Import",FAIL,"Webconnect Import popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# C2R Functionality (Investing) #######################################
	[ ] //********************************************************
	[+] //TestCase Name:	 Test20_InvestingWebConnectImport()
		[ ] 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Web Connect Import functionality
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs						
		[ ] // 						Fail			If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Aug 08, 2014	      Udita Dube 	Created	
	[ ] //*********************************************************
[+] testcase Test20_InvestingWebConnectImport() appstate QuickenBaseState 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile,iAccount, iBrokerage
		[ ] BOOLEAN bFlag,bVerify
		[ ] STRING sOnlineTransactionDataFile,sFilePath,sFileName,sIndex1,sIndex2, sCaption, sEndingBalance, sExpected, sBrokerageAccountType, sCash,sBrokerageAccount,sStatementEndingDate
	[ ] // Expected Values
	[+] 
		[ ] sFileName = "Vanguard_Investing.qfx"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sEndingBalance = "6,589"
		[ ] sIndex1="#12"
		[ ] sIndex2= "#14"
		[ ] bFlag = TRUE
		[ ] sBrokerageAccountType = "Brokerage"
		[ ] sBrokerageAccount= "Brokerage 01"
		[ ] sStatementEndingDate = "01/01/2011"
		[ ] sCash = "6,575"
	[ ] 
	[+] // Pre-requisite
		[ ] // Delete qa_acc32.dll
		[+] if(FileExists (sAccDllDestinationPath))
			[ ] DeleteFile(sAccDllDestinationPath)
		[ ] 
		[+] if(FileExists(AUT_DATAFILE_PATH + "\" + "{sOnlineTransactionDataFile}.QDF"))
			[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +  "{sOnlineTransactionDataFile}.QDF")
	[ ] iResult = DataFileCreate(sOnlineTransactionDataFile)
	[ ] //Create a new data file for Online transaction download
	[+] if (iResult==PASS)
		[ ] 
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOnlineTransactionDataFile} is created")
		[+] if (QuickenWindow.Exists(5))
			[ ] 
			[ ] iResult=SelectPreferenceType("Downloaded Transactions")
			[+] if(iResult== PASS)
				[ ] Preferences.SetActive()
				[+] if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
					[ ] // Check the checkbox if it is unchecked
					[ ] bVerify=Preferences.AutomaticallyAddDownloadedIT.IsChecked()
					[+] if(bVerify==TRUE)
						[ ] Preferences.AutomaticallyAddDownloadedT.Uncheck()
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is unchecked") 
						[ ] 
					[+] else
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is already unchecked") 
						[ ] 
					[ ] Preferences.OK.Click()
					[ ] WaitForState(Preferences,False,2)
					[ ] //Add manual account
					[ ] iResult = AddManualBrokerageAccount(sBrokerageAccountType, sBrokerageAccount, sCash, sStatementEndingDate) 
					[+] if (iResult==PASS)
						[ ] ReportStatus("Add Brokerage Account", PASS, "BrokerageAccount -  {sBrokerageAccount} is created")
						[ ] 
						[ ] UsePopupRegister("OFF")
						[ ] 
						[ ] // Navigate to File > File Import > Web Connect File
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.File.Click()
						[ ] QuickenWindow.File.FileImport.Click()
						[ ] QuickenWindow.File.FileImport.WebConnectFile.Select()
						[ ] 
						[ ] 
						[ ] // Import web connect file
						[+] if(ImportExportQuickenFile.Exists(3))
							[ ] ImportExportQuickenFile.SetActive()
							[ ] ImportExportQuickenFile.FileName.SetText(sFilePath)
							[ ] ImportExportQuickenFile.Open.Click()
							[ ] 
							[+] if(ImportDownloadedTransactions.Exists(40))
								[ ] ImportDownloadedTransactions.SetActive()
								[ ] // Select Existing account
								[ ] ImportDownloadedTransactions.Panel2.LinkToAnExistingAccount.Click()
								[ ] // Click on Import
								[ ] ImportDownloadedTransactions.Import.Click()
								[ ] 
								[+] if(OneStepUpdateSummary.Exists(30))
									[ ] OneStepUpdateSummary.SetActive()
									[ ] OneStepUpdateSummary.Close()
								[+] if (DlgVerifyCashBalance.Exists(30))
									[ ] DlgVerifyCashBalance.SetActive()
									[ ] DlgVerifyCashBalance.TypeKeys(KEY_EXIT)
									[ ] WaitForState(DlgVerifyCashBalance,false,2)
									[ ] sleep(10)
								[ ] 
								[ ] 
								[ ] iResult=SelectAccountFromAccountBar(sBrokerageAccount,ACCOUNT_INVESTING)
								[+] if (iResult==PASS)
									[+] if(MDIClient.BrokerageAccount.wTransaction.DownloadTransactionsTab.Exists (10))
										[ ] sCaption = MDIClient.BrokerageAccount.wTransaction.DownloadTransactionsTab.GetCaption ()
										[ ] sExpected = "0"
										[ ] bMatch = MatchStr("*{sExpected}*", sCaption)
										[+] if(bMatch == TRUE)
											[ ] ReportStatus("Validate No. of Transactions", PASS, "No. of Transactions = {sExpected}")
										[+] else
											[ ] ReportStatus("Validate No. of Transactions", FAIL, "Expected no. of Transaction - {sExpected}, Actual no. of Transaction - {sCaption}")
											[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
										[ ] 
								[+] else
									[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sBrokerageAccount} account couldn't be selected from Account bar")
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate ImportDownloadedTransactions Window", FAIL, "ImportDownloadedTransactions window is not available") 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate 'Import Web Connect File' Window", FAIL, "'Import Web Connect File' Window is not available") 
							[ ] 
					[+] else
						[ ] ReportStatus("Add Brokerage Account", FAIL, "BrokerageAccount -  {sBrokerageAccount} couldn't be created")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate checkbox for Automatic Transaction entry'", FAIL, "Downloaded Investing Transactions Checkbox is not available") 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Downloaded Transactions on preferences dialog", FAIL, "Downloaded Transactions not available on preferences dialog.") 
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sOnlineTransactionDataFile} couldn't be created")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Validate Import AddessBook  #######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_VerifyImportAddressBook ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will save selected address in CSV file and once the file import then addresses will add in address book and increase the address count  .
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while importing the CSV file .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	13/04/2011  	Created By	Puja Verma
	[ ] //*********************************************************
[+] testcase Test21_VerifyImportAddressBook() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sExcelLocation=AUT_DATAFILE_PATH+"\"+"TEST.CSV"
		[ ] INTEGER iFileStatus
		[ ] STRING sTabName="ImportAddress"
		[ ] 
		[ ] 
		[ ] //Check the Quicken Existence 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // Fetching the data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] lsData=lsExcelData[i]
				[ ] //Open the data file
				[ ] iFileStatus=OpenDataFile(lsData[1])
				[ ] sleep(20)
				[+] if(iFileStatus==PASS)
					[+] if (QuickenWindow.Exists(50))
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.View.Click()
						[ ] QuickenWindow.View.TabsToShow.Click()
						[+] if (QuickenWindow.View.TabsToShow.Business.IsChecked==FALSE)
							[ ] QuickenWindow.View.TabsToShow.Business.Select()
						[ ] QuickenWindow.TypeKeys(KEY_ESC)
						[ ] //Select the Address book option from Tools
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Tools.Click()
						[ ] QuickenWindow.Tools.AddressBook.Select()
						[+] if(AddressBookAllGroups.Exists(5))
							[ ] AddressBookAllGroups.SetActive()
							[ ] AddressBookAllGroups.SetActive()
							[ ] AddressBookAllGroups.Options.Click()
							[ ] AddressBookAllGroups.TypeKeys(Replicate(KEY_DN,5))
							[ ] AddressBookAllGroups.TypeKeys(KEY_ENTER)
							[ ] sExpected=DlgAddressBook.RecordsAddress.GetText()
							[ ] print(sExpected)
							[ ] DlgAddressBook.Export.Click()
							[ ] // Select the location and give to import the address in excel sheet
							[+] if(AddressRecords.Exists(10))
								[ ] AddressRecords.SetActive()
								[ ] AddressRecords.File3.SetText(sExcelLocation)
								[ ] AddressRecords.Next.Click()
								[ ] AddressRecords.Done.Click()
								[ ] DlgAddressBook.Done.Click()
								[ ] QuickenWindow.SetActive()
								[ ] // Open data file to import the address  record
								[ ] 
								[ ] iFileStatus=OpenDataFile(lsData[2])
								[ ] sleep(10)
								[+] if(iFileStatus==PASS)
									[+] if (QuickenWindow.Exists(5))
										[ ] QuickenWindow.SetActive()
										[ ] QuickenWindow.View.Click()
										[ ] QuickenWindow.View.TabsToShow.Click()
										[+] if (QuickenWindow.View.TabsToShow.Business.IsChecked==FALSE)
											[ ] QuickenWindow.View.TabsToShow.Business.Select()
										[ ] QuickenWindow.TypeKeys(KEY_ESC)
										[ ] QuickenWindow.SetActive()
										[+] do
											[ ] QuickenWindow.MainMenu.Select("/_File/File _Import/_Addresses...")
										[+] except
											[ ] QuickenWindow.File.Click()
											[ ] QuickenWindow.File.FileImport.Click()
											[ ] QuickenWindow.File.FileImport.Addresses.Select()
										[ ] 
										[+] if(DlgAddressBook.Exists(5))
											[ ] 
											[+] if(AddressRecords.Exists(5))
												[ ] AddressRecords.SetActive()
												[ ] AddressRecords.Next.Click()
												[ ] AddressRecords.Done.Click()
												[ ] // After import verify the record count
												[+] if(DlgAddressBook.Exists(5))
													[ ] DlgAddressBook.SetActive()
													[ ] sActual=DlgAddressBook.RecordsAddress.GetText()
													[ ] DlgAddressBook.Done.Click()
													[+] if(sActual==sExpected)
														[ ] ReportStatus("Validate Import Address book",PASS,"Address book Imported {sExpected} successfully")
														[ ] 
													[+] else
														[ ] ReportStatus("Validate Import Address book",FAIL,"Address book is not Imported successfully, Actual-{sActual}, Expected-{sExpected}")
														[ ] 
													[ ] 
												[+] else
													[ ] ReportStatus("Valiadate Address Book Count",FAIL,"Address Book popup did not open to import the address")
												[ ] 
											[+] else
												[ ] ReportStatus("Valiadate Address Book Count",FAIL,"Address Record popup did not open to import the address")
										[+] else
											[ ] ReportStatus("Validate Address Book",FAIL,"Address book popup did not appear after export.")
									[+] else
										[ ] ReportStatus("Validate Address book Import",FAIL,"Quicken is not active.")
									[ ] 
								[+] else
									[ ] ReportStatus("Validate Address book Import",FAIL,"{lsData[2]} data file not opened")
							[+] else
								[ ] ReportStatus("Validate Address book Import",FAIL,"Address Record popup did not appear")
						[+] else
							[ ] ReportStatus("Validate Address Book",FAIL,"Address book popup did not appear")
					[+] else
						[ ] ReportStatus("Validate Import Address File ", FAIL,"Quicken did not launch!" )
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Import Address Book",FAIL,"Mentioned file is not available in required location,Please check !")
		[+] else
			[ ] ReportStatus("Validate Import Address File ", FAIL,"Quicken did not launch!" )
[ ] //###########################################################
[ ] 
