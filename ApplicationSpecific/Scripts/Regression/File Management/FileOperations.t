[ ] // *********************************************************
[+] // FILE NAME:	<FileOperations.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all File Operation test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  Udita Dube
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 May 15, 2014	Udita Dube  Created
[ ] // *********************************************************
[ ] 
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
	[ ] public BOOLEAN bCaption,bStatus,bMatch
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //#############Verify the short cuts ########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_VerifyFileShortCuts ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the short cuts Ctrl+O, Ctrl+B and Ctrl+P
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while using short cut keys				
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	16/05/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test01_VerifyFileShortCuts() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] sExpected="Open Quicken File"
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] iCount= ListCount(lsExcelData)
		[ ] 
		[ ] 
	[+] if (!QuickenWindow.Exists ())
		[ ] App_Start (sCmdLine)
	[ ] 
	[+] if (QuickenWindow.Exists(5) == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] for(i=1;i<=iCount;i++)
			[ ] 
			[ ] lsData=lsExcelData[i]
			[ ] 
			[ ] //Open existing data file
			[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
			[ ] //sleep(15)
			[ ] WaitForState(QuickenWindow,TRUE,25)
			[ ] 
			[+] if(iSelect==PASS)
				[ ] QuickenWindow.SetActive()
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] // Verify Ctrl +O
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_O)
				[+] if (ImportExportQuickenFile.Exists(10))
					[ ] ImportExportQuickenFile.SetActive()
					[ ] sActual=ImportExportQuickenFile.GetCaption()
					[+] if(sActual==sExpected)
						[ ] ReportStatus("Verify shortcut Ctrl-O", PASS,"Shortcut Ctrl -O is working as expected as {sExpected} window is displayed")
					[+] else
						[ ] ReportStatus("Verify shortcut Ctrl-O", FAIL,"Shortcut Ctrl -O is not working as expected as {sExpected} window is not displayed, Actual window is {sActual}")
						[ ] 
					[ ] ImportExportQuickenFile.Close()
				[+] else
					[ ] ReportStatus("Verify Open Quicken File window", FAIL, "Open Quicken File window is not displayed using shortcut key Ctrl -O")
				[ ] 
				[ ] // Verify Ctrl +B
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_B)
				[+] if (QuickenBackup.Exists(10))
					[ ] QuickenBackup.SetActive()
					[ ] ReportStatus("Verify shortcut Ctrl-B", PASS,"Shortcut Ctrl -B is working as expected as Quicken Backup window is displayed")
					[ ] QuickenBackup.Close()
				[+] else
					[ ] ReportStatus("Verify Backup Quicken window", FAIL, "Backup Quicken window is not displayed using shortcut key Ctrl -B")
				[ ] 
				[ ] // Verify Ctrl +P
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_P)
				[+] if (DlgPrint.Exists(10))
					[ ] DlgPrint.SetActive()
					[ ] ReportStatus("Verify shortcut Ctrl-P", PASS,"Shortcut Ctrl -P is working as expected as Print window is displayed")
					[ ] DlgPrint.Close()
				[+] else
					[ ] ReportStatus("Verify Print window", FAIL, "Print window is not displayed using shortcut key Ctrl -P")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Unable to open {lsData[1]} data file!" )
				[ ] 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Help on Copy File window ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_VerifyHelpFromCopyFileWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Help on Copy File window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Quicken help window opens	from Copy File window				
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	04/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test02_VerifyHelpFromCopyFileWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] sActual="Copy a Quicken data file"
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileOperations.Click()
		[ ] QuickenWindow.File.FileOperations.Copy.Select()
		[+] if(CopyFile.Exists(3))
			[ ] 
			[ ] CopyFile.SetActive()
			[+] if(CopyFile.HelpButton.Exists(2))
				[ ] CopyFile.HelpButton.Click()
				[+] if(QuickenHelp.Exists(2))
					[ ] ReportStatus("Verify Quicken Help window",PASS,"Quicken Help window is opened")
					[ ] QuickenHelp.SetActive()
					[+] do
						[ ] QuickenHelp.TextClick(sActual)
						[ ] ReportStatus("Verify help content",PASS,"Help content {sActual} is displayed as expected")
						[ ] 
					[+] except
						[ ] ReportStatus("Verify help content",FAIL,"Help content {sActual} is not displayed")
					[ ] QuickenHelp.Close()
				[+] else
					[ ] ReportStatus("Verify Quicken Help window",FAIL,"Quicken Help window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Help button on Copy File window",FAIL,"Help icon is not displayed on Copy File window")
			[ ] 
			[ ] CopyFile.Close()
			[+] if(!CopyFile.Exists(2))
				[ ] ReportStatus("Verify close functionality for Copy File window",PASS,"Copy File window gets closed after clicking on X")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify close functionality for Copy File window",FAIL,"Copy File window did not close after clicking on X")
			[ ] 
		[+] else
			[ ] ReportStatus("Valiade Copy File",FAIL,"Copy popup did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Cancel and Alt f4 for Copy File window ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_VerifyCancelAndAltF4ForCopyFileWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Cancel and Alt f4 for Copy File window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Cancel and Alt f4 is working for Copy File window			
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	05/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test03_VerifyCancelAndAltF4ForCopyFileWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] LIST OF STRING lsOperation= {"Cancel","Alt-F4"}
	[ ] 
	[+] for(i=1;i<=2;i++)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileOperations.Click()
			[ ] QuickenWindow.File.FileOperations.Copy.Select()
			[+] if(CopyFile.Exists(3))
				[ ] 
				[ ] CopyFile.SetActive()
				[ ] 
				[+] if(i==1)
					[ ] CopyFile.Cancel.Click()
				[+] else
					[ ] CopyFile.TypeKeys(KEY_EXIT)
				[ ] 
				[+] if(!CopyFile.Exists(2))
					[ ] ReportStatus("Verify close functionality for Copy File window",PASS,"Copy File window gets closed after clicking on {lsOperation[i]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify close functionality for Copy File window",FAIL,"Copy File window did not close after clicking on {lsOperation[i]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade Copy File",FAIL,"Copy popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //#############  Verify copy functionality by Creating a copy of file Locally  ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_VerifyCopyDataFile ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify copy functionality by Creating a copy of file Locally
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while creating copy .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	15/05/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test04_VerifyCopyDataFileWithDefaultSettings() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] 
		[ ] STRING sLocation
		[ ] STRING sNetWorth="OVERALL TOTAL"
		[ ] STRING sChanged,NetWorthActual
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] iCount= ListCount(lsExcelData)
		[ ] 
		[ ] 
	[+] if (!QuickenWindow.Exists ())
		[ ] App_Start (sCmdLine)
	[ ] 
	[+] if (QuickenWindow.Exists(5) == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] for(i=1;i<=iCount;i++)
			[ ] 
			[ ] lsData=lsExcelData[i]
			[ ] 
			[ ] //Open existing data file
			[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
			[ ] //sleep(15)
			[ ] WaitForState(QuickenWindow,TRUE,25)
			[ ] 
			[+] if(iSelect==PASS)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Graphs.Click()
				[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
				[+] if (NetWorthReports.Exists(30))
					[ ] NetWorthReports.SetActive()
					[ ] NetWorthReports.Maximize()
					[ ] NetWorthReports.ShowReport.Click()
					[+] for( j=9;;)
						[ ] sHandle=Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(j) )
						[ ] bMatch= MatchStr("*{sNetWorth}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] NetWorthActual= GetField(sActual,"@",4) 
							[ ] NetWorthReports.Close()
							[ ] break
						[+] else
							[ ] bMatch=MatchStr(sActual,"")
							[+] if(bMatch==true)
								[ ] ReportStatus("Validate Copy Operation",FAIL,"NetWorth Value is not available,Please Check!")
							[+] else
								[ ] j=j+1
				[+] else
					[ ] ReportStatus("Verify NetWorth report.",FAIL,"Verify NetWorth report: NetWorth report didn't appear.")
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.FileOperations.Click()
				[ ] QuickenWindow.File.FileOperations.Copy.Select()
				[+] if(CopyFile.Exists(3))
					[ ] sLocation=CopyFile.SpecifyADiskDriveAndPath2.GetText()
					[ ] DeleteFile(sLocation)
					[ ] sleep(5)
					[ ] CopyFile.OK.Click()
					[ ] // Select copy option from popup
					[ ] WaitForState(CopyFile,true,10)
					[ ] CopyFile.SetActive()
					[ ] CopyFile.RadioListNewcopy.Select(NEW_COPY)
					[ ] CopyFile.OK.Click()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] // Verify cpy extension in filename
					[ ] bCaption=MatchStr("*{lsData[1]+"Cpy"}*",sCaption)
					[+] if(bCaption==TRUE)
						[ ] ReportStatus("Validate Copy Operation",PASS,"File Copy with Cpy extension")
						[ ] //Verify Networth
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Reports.Click()
						[ ] QuickenWindow.Reports.Graphs.Click()
						[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
						[+] if (NetWorthReports.Exists(30))
							[ ] NetWorthReports.SetActive()
							[ ] NetWorthReports.Maximize()
							[ ] NetWorthReports.ShowReport.Click()
							[+] for( k=9;;)
								[ ] sHandle=Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(k) )
								[ ] bMatch= MatchStr("*{sNetWorth}*",sActual)
								[+] if(bMatch==TRUE)
									[ ] sChanged = GetField(sActual,"@",4) 
									[ ] Verify(sChanged,NetWorthActual)
									[ ] ReportStatus("Validate Copy Operation",PASS,"NetWorth Value is Matching!")
									[ ] NetWorthReports.Close()
									[+] if(FileExists(sLocation))
										[ ] ReportStatus("Validate Copy Operation",PASS,"File Copy in required location")
										[ ] 
									[+] else
										[ ] ReportStatus("Validate Copy Operation",FAIL,"File did not creat Copy in required location")
									[ ] break
								[+] else
									[ ] bMatch=MatchStr(sActual,"")
									[+] if(bMatch==true)
										[ ] ReportStatus("Validate Copy Operation",FAIL,"NetWorth Value is not available,Please Check!")
										[ ] break
									[+] else
										[ ] k=k+1
						[+] else
							[ ] ReportStatus("Verify NetWorth report.",FAIL,"Verify NetWorth report: NetWorth report didn't appear.")
						[ ] 
					[+] else
							[ ] ReportStatus("Validate Copy Operation",FAIL,"File did not Copy with Cpy extension")
				[+] else
					[ ] ReportStatus("Valiade Copy File",FAIL,"Copy popup did not appear")
			[+] else
				[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Unable to open {lsData[1]} data file!" )
				[ ] 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Cancel and Alt f4 for "Validate and Repair your Quicken file" window #############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_VerifyCancelAndAltF4ForValidateAndRepairWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Help for "Validate and Repair your Quicken file" window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Quicken help window opens	from Validate and Repair your Quicken file window				
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	04/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test05_VerifyCancelAndAltF4ForValidateAndRepairWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] LIST OF STRING lsOperation= {"Cancel","Alt-F4"}
	[ ] 
	[+] for(i=1;i<=2;i++)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileOperations.Click()
			[ ] QuickenWindow.File.FileOperations.ValidateAndRepair.Select()
			[+] if(ValidateAndRepair.Exists(3))
				[ ] 
				[ ] ValidateAndRepair.SetActive()
				[ ] 
				[+] if(i==1)
					[ ] ValidateAndRepair.Cancel.Click()
				[+] else
					[ ] ValidateAndRepair.TypeKeys(KEY_EXIT)
				[ ] 
				[+] if(!ValidateAndRepair.Exists(2))
					[ ] ReportStatus("Verify close functionality for Validate and Repair your Quicken file window",PASS,"Validate and Repair your Quicken file window gets closed after clicking on {lsOperation[i]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify close functionality for Validate and Repair your Quicken file window",FAIL,"Validate and Repair your Quicken file window did not close after clicking on {lsOperation[i]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade Validate and Repair your Quicken file",FAIL,"Validate and Repair your Quicken file popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Help for "Validate and Repair your Quicken file" window #######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_VerifyHelpFromValidateAndRepairWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Help for "Validate and Repair your Quicken file" window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Quicken help window opens	from Validate and Repair your Quicken file window				
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	04/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test06_VerifyHelpFromValidateAndRepairWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] sActual="Troubleshoot a damaged Quicken data file"
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileOperations.Click()
		[ ] QuickenWindow.File.FileOperations.ValidateAndRepair.Select()
		[+] if(ValidateAndRepair.Exists(3))
			[ ] 
			[ ] ValidateAndRepair.SetActive()
			[+] if(!ValidateAndRepair.OK.IsEnabled())
				[ ] ReportStatus("Verify default state of OK button",PASS,"OK button is disabled by default")
			[+] else
				[ ] ReportStatus("Verify default state of OK button",FAIL,"OK button is not disabled by default")
				[ ] 
			[ ] 
			[+] if(ValidateAndRepair.HelpButton.Exists(2))
				[ ] ValidateAndRepair.HelpButton.Click()
				[+] if(QuickenHelp.Exists(2))
					[ ] ReportStatus("Verify Quicken Help window",PASS,"Quicken Help window is opened")
					[ ] QuickenHelp.SetActive()
					[+] do
						[ ] QuickenHelp.TextClick(sActual)
						[ ] ReportStatus("Verify help content",PASS,"Help content {sActual} is displayed as expected")
						[ ] 
					[+] except
						[ ] ReportStatus("Verify help content",FAIL,"Help content {sActual} is not displayed")
					[ ] QuickenHelp.Close()
				[+] else
					[ ] ReportStatus("Verify Quicken Help window",FAIL,"Quicken Help window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Help button on Copy File window",FAIL,"Help icon is not displayed on Validate and Repair your Quicken file window")
			[ ] 
			[ ] ValidateAndRepair.Close()
			[+] if(!ValidateAndRepair.Exists(2))
				[ ] ReportStatus("Verify close functionality for Validate and Repair your Quicken file window",PASS,"Validate and Repair your Quicken file window gets closed after clicking on X")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify close functionality for Validate and Repair your Quicken file window",FAIL,"Validate and Repair your Quicken file window did not close after clicking on X")
			[ ] 
		[+] else
			[ ] ReportStatus("Valiade Validate and Repair your Quicken file File",FAIL,"Validate and Repair your Quicken file popup did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify the functionality of file Validation ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_ValidateAndRepairDataFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will validate and repair the file and no error should present in the note pad
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while validating the file .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	15/05/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test07_ValidateAndRepairDataFile() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sFileName,sTabName="ValidateAndRepair"
		[ ] BOOLEAN bChecked
		[ ] STRING sMsg1="No errors."
		[ ] STRING sMsg2="Validation has completed."
		[ ] INTEGER iPos
		[ ] STRING sExtension="OFXLOG.DAT"
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Maximize()
		[ ] // Fetching data form excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[ ] sleep(10)
			[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
			[+] if(iSelect==PASS)
				[+] if (QuickenWindow.Exists(5))
					[ ] QuickenWindow.SetActive()
					[ ] // Select Validate and repair option from File-> File Operation
					[ ] QuickenWindow.File.Click()
					[ ] QuickenWindow.File.FileOperations.Click()
					[ ] QuickenWindow.File.FileOperations.ValidateAndRepair.Select()
					[ ] //Selecting all the validation check boxes
					[+] if(ValidateAndRepair.Exists(5))
						[ ] ValidateAndRepair.SetActive()
						[ ] // Verify that default select currently open file when you open Validate
						[ ] sActual=ValidateAndRepair.FileToValidate.GetText()
						[+] if(sActual=="{lsData[1]}.QDF")
							[ ] ReportStatus("Verify default file name on Validate & Repair Quicken file window",PASS,"Opened file is displayed by default for validate and repair")
						[+] else
							[ ] ReportStatus("Verify default file name on Validate & Repair Quicken file window",FAIL,"Opened file is not displayed by default for validate and repair, Actual - {sActual} Expected - {lsData[1]}.QDF")
						[ ] 
						[ ] bChecked=ValidateAndRepair.ValidateFile.IsChecked()
						[+] if(bChecked==FALSE)
							[ ] ValidateAndRepair.ValidateFile.Check()
						[ ] bChecked=ValidateAndRepair.RebuildInvestingLots.IsChecked()
						[+] if(bChecked==FALSE)
							[ ] ValidateAndRepair.RebuildInvestingLots.Check()
						[ ] bChecked=ValidateAndRepair.DeleteInvestingPriceHistory.IsChecked()
						[+] if(bChecked==FALSE)
							[ ] ValidateAndRepair.DeleteInvestingPriceHistory.Check()
							[ ] 
						[ ] ValidateAndRepair.OK.Click()
						[ ] sleep(10)
						[ ] // Verify note pad should have error report
						[+] if(Notepad.Exists(300))
							[ ] Notepad.SetActive()
							[ ] lscontent=Notepad.TextField1.GetContents()
							[ ] iPos = ListFind (lscontent, sMsg1)
							[+] if(iPos==0)
								[ ] ReportStatus("Validate and Repair operation",FAIL,"Validation not completed and Error Found in File ")
							[+] else
								[ ] ReportStatus("Validate and Repair operation",PASS,"Validation message: {sMsg1} : found in the log File")
								[ ] 
							[ ] iPos = ListFind (lscontent, sMsg2)
							[+] if(iPos==0)
								[ ] ReportStatus("Validate and Repair operation",FAIL,"Validation not completed and Error Found in File ")
							[+] else
								[ ] Notepad.TypeKeys(KEY_EXIT)
								[ ] WaitForState(Notepad,false,1)
								[ ] ReportStatus("Validate and Repair operation",PASS,"Validation message: {sMsg2} : found  in the log File")
						[+] else
							[ ] ReportStatus("Validate and Repair operation",FAIL,"Notepad did not exists")
						[ ] 
						[ ] // Verify OFXLOG.DAT file
						[ ] // sFileName=lsData[i]+sExtension
						[+] // if(FileExists("{lsData[2]}\{sFileName}"))
							[ ] // ReportStatus("Verify {lsData[2]}\{sFileName}",PASS,"{lsData[2]}\{sFileName} file exists")
						[+] // else
							[ ] // ReportStatus("Verify {lsData[2]}\{sFileName}",FAIL,"{lsData[2]}\{sFileName} file does not exist")
							[ ] // 
						[ ] 
						[+] if(DirExists("{lsData[2]}\Validate"))
							[ ] ReportStatus("Verify {lsData[2]}\Validate",PASS,"{lsData[2]}\Validate folder exists")
						[+] else
							[ ] ReportStatus("Verify {lsData[2]}\Validate",FAIL,"{lsData[2]}\Validate folder does not exist")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate and Repair operation",FAIL,"ValidateAndRepair didn't not appear.")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate and Repair operation",FAIL,"Quicken is not active.")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate and Repair operation",FAIL,"Mentioned file name is not available in the required location")
				[ ] 
			[ ] 
	[+] else
		[ ] QuickenMainWindow.Kill()
		[ ] WaitForState(QuickenMainWindow,false,5)
		[ ] ReportStatus("Validate Opertaion Validate and Repair", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Verify Help for "Create a Year End Copy" window ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_VerifyHelpFromCreateAYearEndCopyWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Help for "Create a Year End Copy" window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Quicken help window opens	from Create a Year End Copy window				
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	04/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test08_VerifyHelpFromCreateAYearEndCopyWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] sActual="Archive Quicken information at year's end"
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileOperations.Click()
		[ ] QuickenWindow.File.FileOperations.YearEndCopy.Select()
		[+] if(CreateAYearEndCopy.Exists(3))
			[ ] 
			[ ] CreateAYearEndCopy.SetActive()
			[+] if(CreateAYearEndCopy.HelpButton.Exists(2))
				[ ] CreateAYearEndCopy.HelpButton.Click()
				[+] if(QuickenHelp.Exists(2))
					[ ] ReportStatus("Verify Quicken Help window",PASS,"Quicken Help window is opened")
					[ ] QuickenHelp.SetActive()
					[+] do
						[ ] QuickenHelp.TextClick(sActual)
						[ ] ReportStatus("Verify help content",PASS,"Help content {sActual} is displayed as expected")
						[ ] 
					[+] except
						[ ] ReportStatus("Verify help content",FAIL,"Help content {sActual} is not displayed")
					[ ] QuickenHelp.Close()
				[+] else
					[ ] ReportStatus("Verify Quicken Help window",FAIL,"Quicken Help window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Help button on Create a Year End Copy window",FAIL,"Help icon is not displayed on Create a Year End Copy window")
			[ ] 
			[ ] CreateAYearEndCopy.Close()
			[+] if(!CreateAYearEndCopy.Exists(2))
				[ ] ReportStatus("Verify close functionality for Create a Year End Copy window",PASS,"Create a Year End Copy window gets closed after clicking on X")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify close functionality for Create a Year End Copy window",FAIL,"Create a Year End Copy window did not close after clicking on X")
			[ ] 
		[+] else
			[ ] ReportStatus("Valiade Create a Year End Copy window",FAIL,"Create a Year End Copy popup did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //############# Verify Cancel and Alt f4 for "Create a Year End Copy" window #######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_VerifyCancelAndAltF4ForCreateAYearEndCopyWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Cancel and Alt f4 for "Create a Year End Copy" window 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Cancel and Alt f4 is working for "Create a Year End Copy" window 			
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	05/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test09_VerifyCancelAndAltF4ForCreateAYearEndCopyWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] LIST OF STRING lsOperation= {"Cancel","Alt-F4"}
	[ ] 
	[+] for(i=1;i<=2;i++)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileOperations.Click()
			[ ] QuickenWindow.File.FileOperations.YearEndCopy.Select()
			[+] if(CreateAYearEndCopy.Exists(3))
				[ ] 
				[ ] CreateAYearEndCopy.SetActive()
				[ ] 
				[+] if(i==1)
					[ ] CreateAYearEndCopy.Cancel.Click()
				[+] else
					[ ] CreateAYearEndCopy.TypeKeys(KEY_EXIT)
				[ ] 
				[+] if(!CreateAYearEndCopy.Exists(2))
					[ ] ReportStatus("Verify close functionality for Create a Year End Copy window",PASS,"Create a Year End Copy window gets closed after clicking on {lsOperation[i]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify close functionality for Create a Year End Copy window",FAIL,"Create a Year End Copy window did not close after clicking on {lsOperation[i]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade Create a Year End Copy",FAIL,"Create a Year End Copy popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################
[ ] 
[+] //#############  Verify the functionality of "Year End Copy" first/default option. ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyYearEndCopyOfDataFileWithDefaultSettings ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the functionality of "Year End Copy" first option.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while creating copy .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	15/05/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test10_VerifyYearEndCopyOfDataFileWithDefaultSettings() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sTabName="YearEnd"
		[ ] STRING sLocation
		[ ] LIST OF STRING lsAction = {"Current file", "Archive file"}
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Fetching the data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[ ] 
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[ ] 
			[ ] // Open existing data file
			[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
			[ ] 
			[+] if(iSelect==PASS)
				[ ] 
				[+] for(j=1; j<=ListCount(lsAction);j++)
					[ ] 
					[+] if(QuickenWindow.Exists(MEDIUM_SLEEP))
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] // Select year end copy option from File->File Operation
						[ ] QuickenWindow.File.Click()
						[ ] QuickenWindow.File.FileOperations.Click()
						[ ] QuickenWindow.File.FileOperations.YearEndCopy.Select()
						[ ] 
						[ ] //Confirmation popup for coping the file
						[+] if(CreateAYearEndCopy.Exists(MEDIUM_SLEEP))
							[ ] CreateAYearEndCopy.SetActive()
							[ ] CreateAYearEndCopy.Copyoption.Click()
							[ ] sLocation=CreateAYearEndCopy.FileName.GetText()
							[+] if (FileExists(sLocation))
								[ ] DeleteFile(sLocation)
								[ ] sleep(1)
							[ ] CreateAYearEndCopy.OK.Click()
							[ ] 
							[+] if(FileArchived.Exists(60))
								[ ] FileArchived.SetActive()
								[ ] FileArchived.OptionforFile.Select(lsAction[j])
								[ ] FileArchived.OK.Click()
								[ ] sleep(5)
								[ ] 
								[ ] QuickenWindow.SetActive()
								[ ] // Verify backup file exist or not
								[ ] sCaption = QuickenWindow.GetCaption()
								[+] if(lsAction[j]=="Archive file")
									[ ] bCaption=MatchStr("*{lsData[1]+"BKP"}*",sCaption)
								[+] else
									[ ] bCaption=MatchStr("*{lsData[1]}*",sCaption)
									[ ] 
								[+] if(bCaption)
									[ ] ReportStatus("Validate Year End Copy with default settings",PASS,"Year End Copy is created Successfully with BKP in extension in name with default settings")
									[ ] 
									[+] if(FileExists(sLocation))
										[ ] ReportStatus("Validate Year End Copy",PASS,"Year End Copy is present at  location {lsData[2]}")
									[+] else
										[ ] ReportStatus("Validate Year End Copy",FAIL,"File did not create year end copy in required location")
									[ ] 
								[+] else
									[ ] ReportStatus("Validate Copy Operation",FAIL,"File did not Copy with Cpy extension")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Year End Copy",FAIL,"Did  not asked for File Archived option popup")
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Year End Copy",FAIL,"Create a year end copy option did not appear")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Quicken Main Window",FAIL,"Quicken Main Window is not displayed")
					[ ] 
				[ ] 
			[+] else
				[ ] QuickenMainWindow.Kill()
				[ ] WaitForState(QuickenMainWindow,FALSE,5)
				[ ] ReportStatus("Validate Year End Copy",FAIL,"Mentioned file {lsData[1]} is not available at required location {lsData[2]}")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Year End Copy", FAIL,"Quicken did not launched!" )
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Validate Import AddessBook  ##################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_ValidateImportAddessBook ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify file Import (address book) functionality
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while importing the CSV file .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	23/05/2014 	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test11_ValidateImportAddessBook() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sExcelLocation=AUT_DATAFILE_PATH+"\"+"TEST.CSV"
		[ ] STRING sHandle,sActual,sValue1,sValue2,sValue,sValueCount
		[ ] LIST OF STRING lsItems
		[ ] LIST OF STRING lsSelectedItem
		[ ] lsItems=({"Payee","Last Name","First Name"})
		[ ] STRING sTabName="ImportAddress"
	[ ] //verify quicken window
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Fetching the data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName,"RecentFiles")
		[ ] 
		[+] if(!FileExists("{lsExcelData[2][2]}\{lsExcelData[2][1]}"))
			[ ] DataFileCreate(lsExcelData[2][1],lsExcelData[2][2])
		[ ] 
		[ ] lsExcelData=NULL
		[ ] // Fetching the data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[+] if(IsNULL(lsData[1]))
				[ ] break
			[ ] //Open the data file
			[ ] iValidate=OpenDataFile(lsData[1])
			[ ] sleep(20)
			[+] if(iValidate==PASS)
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
					[+] if(DlgAddressBook.Exists(5))
						[ ] DlgAddressBook.SetActive()
						[ ] sHandle=Str(DlgAddressBook.QWListViewer1.ListBox1.GetHandle ())
						[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW",sHandle,"0" )
						[ ] DlgAddressBook.Export.Click()
						[ ] // Select the location and give to import the address in excel sheet
						[+] if(AddressRecords.Exists(10))
							[ ] AddressRecords.SetActive()
							[ ] AddressRecords.File3.SetText(sExcelLocation)
							[ ] AddressRecords.Next.Click()
							[ ] lsSelectedItem=AddressRecords.FieldsToBeExported.GetContents()
							[ ] // Select the fields to import
							[ ] if(lsItems==lsSelectedItem)
							[+] else
								[ ] AddressRecords.QuickenFields.SelectList(lsItems)
								[ ] AddressRecords.Add.Click()
							[ ] AddressRecords.Done.Click()
							[ ] DlgAddressBook.Done.Click()
							[ ] QuickenWindow.SetActive()
							[ ] //Open data file to import the address  record
							[ ] 
							[ ] iValidate=OpenDataFile(lsData[2])
							[ ] sleep(10)
							[+] if(iValidate==PASS)
								[+] if (QuickenWindow.Exists(5))
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.View.Click()
									[ ] QuickenWindow.View.TabsToShow.Click()
									[+] if (QuickenWindow.View.TabsToShow.Business.IsChecked==FALSE)
										[ ] QuickenWindow.View.TabsToShow.Business.Select()
									[+] do
										[ ] QuickenWindow.MainMenu.Select("/_File/File _Import/_Addresses...")
									[+] except
										[ ] QuickenWindow.File.Click()
										[ ] QuickenWindow.File.FileImport.Click()
										[ ] QuickenWindow.File.FileImport.Addresses.Select()
									[+] if(DlgAddressBook.Exists(5))
										[ ] AddressRecords.SetActive()
										[ ] sActual=DlgAddressBook.RecordsAddress.GetText()
										[ ] //take record count of address
										[ ] sValue1=StrTran(sActual,"(","")
										[ ] sValue2=StrTran(sValue1,")","")
										[ ] sValue=GetField (sValue2, " ", 1) 
										[ ] 
										[+] if(AddressRecords.Exists(5))
											[ ] AddressRecords.SetActive()
											[ ] AddressRecords.Next.Click()
											[ ] AddressRecords.Done.Click()
											[ ] //After import verify the record count
											[+] if(DlgAddressBook.Exists(5))
												[ ] DlgAddressBook.SetActive()
												[ ] sActual=DlgAddressBook.RecordsAddress.GetText()
												[ ] sValue1=StrTran(sActual,"(","")
												[ ] sValue2=StrTran(sValue1,")","")
												[ ] sValueCount=GetField (sValue2, " ", 1) 
												[ ] Verify(Str(Val(sValue)+1),sValueCount)
												[ ] DlgAddressBook.Done.Click()
												[ ] ReportStatus("Validate Import Address book",PASS,"Address book Imported successfully")
											[+] else
												[ ] ReportStatus("Valiadate Address Book Count",FAIL,"Address Record popup did not open to import the address")
											[ ] 
										[+] else
											[ ] ReportStatus("Valiadate Address Book Count",FAIL,"Address Record popup did not open to import the address")
									[+] else
										[ ] ReportStatus("Validate Address Book",FAIL,"Address book popup did not appear after export.")
								[+] else
									[ ] ReportStatus("Validate Address book Import",FAIL,"Quicken is not active.")
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Address book Import",FAIL,"Address Item import popup did not appear")
						[+] else
							[ ] ReportStatus("Validate Address book Import",FAIL,"Address Item import popup did not appear")
					[+] else
						[ ] ReportStatus("Validate Address Book",FAIL,"Address book popup did not appear")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Import Address File ", FAIL,"Quicken did not launched!" )
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Import Address Book",FAIL,"Mentioned file is not available in required location,Please check !")
	[+] else
		[ ] ReportStatus("Validate Import Address File ", FAIL,"Quicken did not launched!" )
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Select a file on local drive from the recently opened file list in "File" menu ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_SelectRecentlyOpenedFile ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Selection of  a file on local drive from the recently opened file list in "File" menu.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while opening recent files						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	27/05/2014 	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test12_SelectRecentlyOpenedFile() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sTabName="RecentFiles"
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Fetching the data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[ ] 
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[ ] //Open the data file
			[ ] QuickenWindow.TextClick("File")
			[ ] // Select menu item
			[ ] QuickenWindow.MainMenu.Select("/_File/*{lsData[2]}\{lsData[1]}")
			[ ] // "/_File/_1 C:\automation\ApplicationSpecific\Data\TestData\File Management data\CustomerDataFiles\CopyFunctionality")
			[ ] sleep(5)
			[ ] QuickenWindow.SetActive()
			[ ] sCaption = QuickenWindow.GetCaption ()
			[ ] 
			[ ] bStatus = MatchStr("*{lsData[1]}*", sCaption)
			[+] if(bStatus)
				[ ] ReportStatus("Verify Selection of  a file on local drive from the recently opened file list in File menu.",PASS,"Recently opened file: {lsData[1]} is selected from File menu")
			[+] else
				[ ] ReportStatus("Verify Selection of  a file on local drive from the recently opened file list in File menu.",FAIL,"Recently opened file: {lsData[1]} is not selected from File menu")
				[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Import Address File ", FAIL,"Quicken did not launched!" )
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //## Verify error message when data file open from recent files which is located at local drive and deleted ####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_VerifyMessageIfRecentlyOpenedFileIsDeleted()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify error message when data file open from recent files which is located at local drive and deleted
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if error message is correct					
		[ ] //						Fail		if error message is not correct	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	27/05/2014 	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test13_VerifyMessageIfRecentlyOpenedFileIsDeleted() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sExpected, sFileWithPath, sTabName="RecentFiles"
		[ ] List of STRING lsRecentFile
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Fetching the data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[ ] lsData=lsExcelData[1]
		[ ] lsRecentFile=lsExcelData[2]
		[ ] //Open the data file
		[ ] iValidate=OpenDataFile(lsData[1],lsData[2])
		[ ] sleep(20)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] sFileWithPath="{lsRecentFile[2]}\{lsRecentFile[1]}.QDF"
			[+] if(FileExists(sFileWithPath))
				[ ] DeleteFile(sFileWithPath)
			[ ] 
			[+] if(!FileExists(sFileWithPath))
				[ ] 
				[ ] sExpected="Could not open the file: {lsRecentFile[2]}\{lsRecentFile[1]}.QDF."
				[ ] 
				[ ] QuickenWindow.TextClick("File")
				[ ] // Select menu item
				[ ] QuickenWindow.MainMenu.Select("/_File/*{lsRecentFile[2]}\{lsRecentFile[1]}")
				[ ] sleep(2)
				[ ] 
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sActual=AlertMessage.MessageText.GetText()
					[+] if(sActual==sExpected)
						[ ] ReportStatus("Verify error message",PASS,"Correct error message is displayed: {sExpected}")
					[+] else
						[ ] ReportStatus("Verify error message",FAIL,"Correct error message is not displayed: Expected- {sExpected}, Actual - {sActual}")
						[ ] 
					[ ] AlertMessage.OK.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify error message",FAIL,"Error message is not displayed when data file open from recent files which is deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Open Data File",FAIL,"Data file {lsData[1]} is not opened")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Import Address File ", FAIL,"Quicken did not launched!" )
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Verify Help for "Find Quicken Data Files" window ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_VerifyHelpFromFindQuickenDataFilesWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Help for "Find Quicken Data Files" window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Quicken help window opens	from Find Quicken Data Files window				
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	05/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test14_VerifyHelpFromFindQuickenDataFilesWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] sActual="Identify the location of your Quicken data file"
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileOperations.Click()
		[ ] QuickenWindow.File.FileOperations.FindQuickenFiles.Select()
		[+] if(FindQuickenDataFiles.Exists(3))
			[ ] 
			[ ] FindQuickenDataFiles.SetActive()
			[ ] FindQuickenDataFiles.StopSearching.Click()
			[ ] 
			[+] if(FindQuickenDataFiles.HelpButton.Exists(2))
				[ ] FindQuickenDataFiles.HelpButton.Click()
				[+] if(QuickenHelp.Exists(2))
					[ ] ReportStatus("Verify Quicken Help window",PASS,"Quicken Help window is opened")
					[ ] QuickenHelp.SetActive()
					[+] do
						[ ] QuickenHelp.TextClick(sActual)
						[ ] ReportStatus("Verify help content",PASS,"Help content {sActual} is displayed as expected")
						[ ] 
					[+] except
						[ ] ReportStatus("Verify help content",FAIL,"Help content {sActual} is not displayed")
					[ ] QuickenHelp.Close()
				[+] else
					[ ] ReportStatus("Verify Quicken Help window",FAIL,"Quicken Help window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Help button on Find Quicken Data Files window",FAIL,"Help icon is not displayed on Find Quicken Data Files window")
			[ ] 
			[ ] FindQuickenDataFiles.Close()
			[+] if(!FindQuickenDataFiles.Exists(2))
				[ ] ReportStatus("Verify close functionality for Find Quicken Data Files window",PASS,"Find Quicken Data Files window gets closed after clicking on X")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify close functionality for Find Quicken Data Files window",FAIL,"Find Quicken Data Files window did not close after clicking on X")
			[ ] 
		[+] else
			[ ] ReportStatus("Valiade Find Quicken Data Files window",FAIL,"Find Quicken Data Files popup did not appear")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Verify Cancel and Alt f4 for "Find Quicken Data Files" window ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_VerifyCancelAndAltF4ForFindQuickenDataFilesWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Cancel and Alt f4 for "Find Quicken Data Files" window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if Cancel and Alt f4 is working for Find Quicken Data Files window				
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	05/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test15_VerifyCancelAndAltF4ForFindQuickenDataFilesWindow() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] LIST OF STRING lsOperation= {"Cancel","Alt-F4"}
	[ ] 
	[+] for(i=1;i<=2;i++)
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileOperations.Click()
			[ ] QuickenWindow.File.FileOperations.FindQuickenFiles.Select()
			[+] if(FindQuickenDataFiles.Exists(3))
				[ ] 
				[ ] FindQuickenDataFiles.SetActive()
				[ ] FindQuickenDataFiles.StopSearching.Click()
				[ ] 
				[+] if(i==1)
					[ ] FindQuickenDataFiles.Cancel.Click()
				[+] else
					[ ] FindQuickenDataFiles.TypeKeys(KEY_EXIT)
				[ ] 
				[+] if(!FindQuickenDataFiles.Exists(2))
					[ ] ReportStatus("Verify close functionality for Find Quicken Data Files window",PASS,"Find Quicken Data Files window gets closed after clicking on {lsOperation[i]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify close functionality for Find Quicken Data Files window",FAIL,"Find Quicken Data Files window did not close after clicking on {lsOperation[i]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade Find Quicken Data Files window",FAIL,"Find Quicken Data Files popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Find Quicken Files  ##########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_FindQuickenFiles ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will search QDF file From quick search funtionality in specific location and  verify name.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while Searching the file .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	03/06/2014 	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test16_FindQuickenFiles() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sTabName="FindFile"
		[ ] STRING sFileName="TempFile"
		[ ] STRING DummyFile ="C:\Quicken\ApplicationSpecific\Data\TestData\Sample.QDF"
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // DataFileCreate(sFileName)
		[ ] 
		[ ] // Fetching data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[ ] 
			[ ] //Create the data file to be searched///
			[ ] DataFileCreate(lsData[2])
			[ ] ///Open the data file
			[ ] OpenDataFile(sFileName)
			[ ] sleep(10)
			[+] if (QuickenWindow.Exists(10))
				[ ] QuickenWindow.SetActive()
				[ ] //Give drive and file name and search the same
				[ ] // Select Find quicken file option from File -> File operation
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.FileOperations.Click()
				[ ] QuickenWindow.File.FileOperations.FindQuickenFiles.Select()
				[ ] 
				[+] if(FindQuickenDataFiles.Exists(10))
					[ ] FindQuickenDataFiles.StopSearching.Click()
					[ ] FindQuickenDataFiles.SetActive()
					[ ] //Provide drive
					[ ] FindQuickenDataFiles.LookIn1.Select("*{lsData[1]}*")
					[ ] FindQuickenDataFiles.Find.Click()
					[ ] //Provide File Name
					[ ] FindQuickenDataFiles.FindQuickenDataFiles.SetText(lsData[2])
					[ ] 
					[ ] FindQuickenDataFiles.FindQuickenDataFiles.TypeKeys(KEY_ENTER)
					[ ] FindQuickenDataFiles.StopSearching.Click()
					[ ] FindQuickenDataFiles.SetActive()
					[ ] 
					[ ] // sleep(20)
					[ ] FindQuickenDataFiles.Search.VerifyEnabled(TRUE,100)
					[ ] sHandle=Str(FindQuickenDataFiles.FilesFoundQWListViewer.ListBox1.GetHandle())
					[ ] //Select File
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW",sHandle,"0" )
					[ ] 
					[ ] //open the same file and verify the name 
					[+] if(FindQuickenDataFiles.OpenFile.Exists(5))
						[ ] FindQuickenDataFiles.OpenFile.VerifyEnabled(TRUE,100)
						[ ] FindQuickenDataFiles.OpenFile.Click()
						[+] if(QuickenRestore.RestoreBackup.Exists(5))
							[ ] QuickenRestore.RestoreBackup.Click()
						[+] if(QuickenRestore.Yes.Exists(5))
							[ ] QuickenRestore.Yes.Click()
							[ ] // Verify correct file should opened
							[ ] 
						[+] if (QuickenWindow.Exists(5))
							[ ] QuickenMainWindow.VerifyEnabled(TRUE,10)
							[ ] QuickenWindow.SetActive()
							[ ] 
							[ ] sCaption = QuickenWindow.GetCaption()
							[ ] bCaption=MatchStr("*{lsData[2]}*",sCaption)
							[+] if(bCaption==TRUE)
								[ ] ReportStatus("Vallidate Find Quicken File Operation",PASS,"Search done succesfully for file: {lsData[2]}!")
							[+] else
								[ ] ReportStatus("Vallidate Find Quicken File Operation",FAIL,"Search did not done succesfully for file: {lsData[2]}!")
						[+] else
							[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched after restoring the file: {lsData[1]}." )
					[+] else
						[ ] ReportStatus("Vallidate Find Quicken File Operation",FAIL,"Find Open File button  did not appear!")
					[ ] 
				[+] else
					[ ] ReportStatus("Vallidate Find Quicken File Operation",FAIL,"Find Quicken Popup did not appear!")
			[+] else
				[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
	[+] if(FileExists(DummyFile))
		[ ] QuickenMainWindow.Kill()
		[ ] WaitForState(QuickenMainWindow,False,5)
		[ ] DeleteFile(DummyFile)
[ ] //########################################################################################
[ ] 
[+] //#############Verify File menu option after silent launch of Quicken. ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_VerifyFileMenuOptionsWithSilentQuickenLaunch()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify File menu option after silent launch of Quicken.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	05/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test17_VerifyFileMenuOptionsWithSilentQuickenLaunch() appstate none
	[+] // Variable declaration
		[ ] INTEGER iPos
		[ ] STRING sFileWorksheet
		[ ] // WINDOW wDialogBox
		[ ] sFileWorksheet="SilentLaunch"
		[ ] STRING sBrowser="$C:\Program Files\Internet Explorer\iexplore.exe"
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sFileWorksheet)
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] QuickenWindow. PressKeys("<Left Ctrl>")
		[ ] QuickenWindow.Kill()
		[ ] WaitForState(QuickenWindow,FALSE,3)
		[ ] App_start(sCmdLine)
		[ ] WaitForState(QuickenWindow,TRUE,15)
		[ ] sleep(5)
		[ ] QuickenWindow.ReleaseKeys("<Left Ctrl>")
		[ ] 
		[ ] 
		[ ] // Get row counts
		[ ] iCount=ListCount(lsExcelData)
		[+] for(i=1;i<=iCount;i++)
			[ ] 
			[+] do
				[+] if (QuickenWindow.Exists())
					[ ] 
					[ ] // Active Quicken Screen
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] // Check for multiple navigation
					[ ] iPos= StrPos(">",lsExcelData[i][1])
					[+] if( iPos != 0)
						[ ] lsTestData=split(lsExcelData[i][1],">")
						[ ] 
						[ ] sleep(SHORT_SLEEP)
						[ ] // Select menu item
						[ ] QuickenWindow.MainMenu.Select("/{trim(lsExcelData[i][5])}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
						[ ] 
					[+] else
						[ ] QuickenWindow.SetActive()
						[ ] lsExcelData[i][1]=trim(lsExcelData[i][1])
						[ ] QuickenWindow.MainMenu.Select("/{trim(lsExcelData[i][5])}/{lsExcelData[i][1]}*")
						[ ] 
					[ ] 
					[+] if(lsExcelData[i][3] == "Other")
						[+] if(PopUpCalloutHolder.Exists())
							[ ] PopUpCalloutHolder.TypeKeys(KEY_ESCAPE)
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
							[ ] 
						[ ] 
					[ ] // If Popup window then check window caption and close popup
					[+] if(lsExcelData[i][3] == "Popup")
						[ ] // if(QuickenMainWindow.FileDlg(lsExcelData[i][2]).Exists(5))
						[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
							[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
					[ ] // Verify Browser for online options
					[+] else if(lsExcelData[i][3] == "Browser") 
						[ ] sleep(EXTRA_LONG_SLEEP)
						[+] if(InternetExplorer.DlgInternetSettings.Exists(3))
							[ ] InternetExplorer.DlgInternetSettings.SetActive()
							[ ] InternetExplorer.DlgInternetSettings.Close()
						[ ] InternetExplorer.SetActive()
						[ ] sCaption=InternetExplorer.GetCaption()
						[ ] bMatch = MatchStr("*{lsExcelData[i][2]}*", sCaption)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate {lsExcelData[i][1]} option", PASS, "{lsExcelData[i][1]} page is opened in Browser")
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][1]} option", FAIL, "{lsExcelData[i][1]} page is not opened in Browser")
						[ ] 
						[ ] InternetExplorer.Close()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
					[ ] 
				[ ] 
				[ ] 
			[+] except
				[ ] ExceptLog()
			[ ] 
			[ ] 
		[ ] 
		[ ] CloseQuicken()
		[ ] App_Start(sCmdLine)
		[ ] 
		[ ] sleep(10)
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not launched")
	[ ] 
	[ ] 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#############Copy File: Verify Fields validation for Copy Data File Dialog  ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_FieldsValidationForCopyDataFile ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify validation message for File name text box, From date and To date
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if correct error message is displayed					
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	06/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test18_FieldsValidationForCopyDataFile() appstate none
	[+] // Variable declaration
		[ ] 
		[ ] STRING sLocation
		[ ] STRING sExpected,sDateMessage1,sDateMessage2
		[ ] 
		[ ] sExpected="This field may not be left blank." 
		[ ] sDateMessage1="Enter a valid date."
		[ ] 
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] 
	[+] if (!QuickenWindow.Exists ())
		[ ] App_Start (sCmdLine)
	[ ] 
	[+] if (QuickenWindow.Exists(5) == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] lsData=lsExcelData[1]
		[ ] 
		[ ] //Open existing data file
		[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
		[ ] //sleep(15)
		[ ] WaitForState(QuickenWindow,TRUE,25)
		[ ] 
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileOperations.Click()
			[ ] QuickenWindow.File.FileOperations.Copy.Select()
			[+] if(CopyFile.Exists(3))
				[ ] 
				[ ] // Verify message for blank file name
				[ ] sCaption=CopyFile.SpecifyADiskDriveAndPath2.GetText()
				[ ] CopyFile.SpecifyADiskDriveAndPath2.ClearText()
				[ ] CopyFile.OK.Click()
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sActual=AlertMessage.MessageText.GetText()
					[+] if(sActual==sExpected)
						[ ] ReportStatus("Validate message if File name text field is kept blank",PASS,"{sActual} - Correct message is displayed when File name text field is kept blank")
					[+] else
						[ ] ReportStatus("Validate message if File name text field is kept blank",FAIL,"Correct message is not displayed even if File name text field is kept blank, sActual-{sActual}, Expected-{sExpected}")
						[ ] 
					[ ] AlertMessage.OK.Click()
				[+] else
					[ ] ReportStatus("Verify alert message is displayed when File name text field",FAIL,"Alert message is not displayed when File name text field")
				[ ] CopyFile.SpecifyADiskDriveAndPath2.SetText(sCaption)
				[ ] 
				[ ] // Verify message for blank From date
				[ ] sCaption=CopyFile.FromDate.GetText()
				[ ] CopyFile.FromDate.ClearText()
				[ ] CopyFile.OK.Click()
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sActual=AlertMessage.MessageText.GetText()
					[+] if(sActual==sDateMessage1)
						[ ] ReportStatus("Validate message if From Date text field is kept blank",PASS,"{sActual} - Correct message is displayed when From Date text field is kept blank")
					[+] else
						[ ] ReportStatus("Validate message if From Date text field is kept blank",FAIL,"Correct message is not displayed even if From Date text field is kept blank, sActual-{sActual}, Expected-{sDateMessage1}")
						[ ] 
					[ ] AlertMessage.OK.Click()
				[+] else
					[ ] ReportStatus("Verify alert message is displayed when From date text field",FAIL,"Alert message is not displayed when From Date text field")
				[ ] CopyFile.FromDate.SetText(sCaption)
				[ ] 
				[ ] // Verify message for blank To date
				[ ] sCaption=CopyFile.ToDate.GetText()
				[ ] CopyFile.ToDate.ClearText()
				[ ] CopyFile.OK.Click()
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sActual=AlertMessage.MessageText.GetText()
					[+] if(sActual==sDateMessage1)
						[ ] ReportStatus("Validate message if To Date text field is kept blank",PASS,"{sActual} - Correct message is displayed when To Date text field is kept blank")
					[+] else
						[ ] ReportStatus("Validate message if To Date text field is kept blank",FAIL,"Correct message is not displayed even if To Date text field is kept blank, sActual-{sActual}, Expected-{sDateMessage1}")
						[ ] 
					[ ] AlertMessage.OK.Click()
				[+] else
					[ ] ReportStatus("Verify alert message is displayed when To date text field",FAIL,"Alert message is not displayed when To date text field")
				[ ] CopyFile.ToDate.SetText(sCaption)
				[ ] 
				[ ] CopyFile.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade Copy File",FAIL,"Copy popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate open QDF FIle", FAIL,"Unable to open {lsData[1]} data file!" )
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#############Year End Copy: Verify Fields validation for Copy Data File Dialog  ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_FieldsValidationForYearEndDataFile ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify validation message for File name text box, "Starting with this date" and "transactions upto and including" for Year End Copy
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if correct error message is displayed					
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	06/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test19_FieldsValidationForYearEndDataFile() appstate none
	[+] // Variable declaration
		[ ] 
		[ ] STRING sExpected,sDateMessage1,sDateMessage2
		[ ] 
		[ ] sExpected="This field may not be left blank." 
		[ ] sDateMessage1="Enter a valid date."
		[ ] 
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] 
	[+] if (!QuickenWindow.Exists ())
		[ ] App_Start (sCmdLine)
	[ ] 
	[+] if (QuickenWindow.Exists(5) == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] lsData=lsExcelData[1]
		[ ] 
		[ ] //Open existing data file
		[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
		[ ] //sleep(15)
		[ ] WaitForState(QuickenWindow,TRUE,25)
		[ ] 
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileOperations.Click()
			[ ] QuickenWindow.File.FileOperations.YearEndCopy.Select()
			[+] if(CreateAYearEndCopy.Exists(3))
				[ ] 
				[ ] // Verify message for blank file name
				[ ] sCaption=CreateAYearEndCopy.FileName.GetText()
				[ ] CreateAYearEndCopy.FileName.ClearText()
				[ ] CreateAYearEndCopy.OK.Click()
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sActual=AlertMessage.MessageText.GetText()
					[+] if(sActual==sExpected)
						[ ] ReportStatus("Validate message if File name text field is kept blank",PASS,"{sActual} - Correct message is displayed when File name text field is kept blank for Year End Copy")
					[+] else
						[ ] ReportStatus("Validate message if File name text field is kept blank",FAIL,"Correct message is not displayed even if File name text field is kept blank for Year End Copy, sActual-{sActual}, Expected-{sExpected}")
						[ ] 
					[ ] AlertMessage.OK.Click()
				[+] else
					[ ] ReportStatus("Verify alert message is displayed when File name text field",FAIL,"Alert message is not displayed when File name text field")
				[ ] CreateAYearEndCopy.FileName.SetText(sCaption)
				[ ] 
				[ ] // Verify message for blank transactions upto and including text field
				[ ] sCaption=CreateAYearEndCopy.IncludingDate.GetText()
				[ ] CreateAYearEndCopy.IncludingDate.ClearText()
				[ ] CreateAYearEndCopy.OK.Click()
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sActual=AlertMessage.MessageText.GetText()
					[+] if(sActual==sDateMessage1)
						[ ] ReportStatus("Validate message if transactions upto and including text field is kept blank",PASS,"{sActual} - Correct message is displayed when From Date text field is kept blank for Year End Copy")
					[+] else
						[ ] ReportStatus("Validate message if transactions upto and including text field is kept blank",FAIL,"Correct message is not displayed even if From Date text field is kept blank, sActual-{sActual}, Expected-{sDateMessage1}")
						[ ] 
					[ ] AlertMessage.OK.Click()
				[+] else
					[ ] ReportStatus("Verify alert message is displayed when transactions upto and including text field is blank",FAIL,"Alert message is not displayed when transactions upto and including text field is blank")
				[ ] CreateAYearEndCopy.IncludingDate.SetText(sCaption)
				[ ] 
				[ ] // Verify message for blank Starting with this date
				[ ] CreateAYearEndCopy.Copyoption.Select(2)
				[ ] sCaption=CreateAYearEndCopy.StartingDate.GetText()
				[ ] CreateAYearEndCopy.StartingDate.ClearText()
				[ ] CreateAYearEndCopy.OK.Click()
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sActual=AlertMessage.MessageText.GetText()
					[+] if(sActual==sDateMessage1)
						[ ] ReportStatus("Validate message if Starting with this date text field is kept blank",PASS,"{sActual} - Correct message is displayed when Starting with this date text field is kept blank for Year End Copy")
					[+] else
						[ ] ReportStatus("Validate message if Starting with this date text field is kept blank",FAIL,"Correct message is not displayed even if Starting with this date text field is kept blank, sActual-{sActual}, Expected-{sDateMessage1}")
						[ ] 
					[ ] AlertMessage.OK.Click()
				[+] else
					[ ] ReportStatus("Verify alert message is displayed when Starting with this date text field",FAIL,"Alert message is not displayed when Starting with this date text field")
				[ ] CreateAYearEndCopy.StartingDate.SetText(sCaption)
				[ ] 
				[ ] CreateAYearEndCopy.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade Create a Year End Copy window",FAIL,"Create a Year End Copy popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate open QDF FIle", FAIL,"Unable to open {lsData[1]} data file!" )
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#Copy File:Deselecting checkboxes for specified date  ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_VerifyCopyForSpecifiedDate ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify copy functionality by Creating a copy of file Locally by deselecting "Include all 
		[ ] //prior uncleared TRX and Incluse all preor investment TRX" checkbox for specified date
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if transaction out of specified date are not present in copy				
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	17/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test20_VerifyCopyForSpecifiedDate() appstate none
	[+] // Variable declaration
		[ ] 
		[ ] STRING sFromDate,sField,sCriteria,sCopy
		[ ] LIST OF STRING lsTransaction
		[ ] sFromDate="01/01/2012"
		[ ] sField="Date"
		[ ] sCriteria="Less"
		[ ] 
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] lsData=lsExcelData[1]
		[ ] 
		[ ] sCopy="{lsData[2]}\{lsData[1]}Cpy.QDF"
		[ ] 
		[+] if(FileExists(sCopy))
			[ ] DeleteFile(sCopy)
			[ ] sleep(2)
		[ ] 
	[+] if (!QuickenWindow.Exists ())
		[ ] App_Start (sCmdLine)
	[ ] 
	[+] if (QuickenWindow.Exists(5) == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Open existing data file
		[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
		[ ] //sleep(15)
		[ ] WaitForState(QuickenWindow,TRUE,25)
		[ ] 
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileOperations.Click()
			[ ] QuickenWindow.File.FileOperations.Copy.Select()
			[+] if(CopyFile.Exists(3))
				[ ] 
				[ ] //Set From date
				[ ] CopyFile.FromDate.SetText(sFromDate)
				[ ] // Uncheck all checkboxes
				[ ] CopyFile.IncludeAllPriorUnclearedTxn.Uncheck()
				[ ] CopyFile.IncludeAllPriorInvestmentTxn.Uncheck()
				[ ] 
				[ ] // Click on ok button
				[ ] CopyFile.OK.Click()
				[ ] 
				[ ] // Select new copy option from popup
				[ ] WaitForState(CopyFile,TRUE,10)
				[ ] CopyFile.SetActive()
				[ ] CopyFile.RadioListNewcopy.Select(NEW_COPY)
				[ ] CopyFile.OK.Click()
				[ ] 
				[ ] WaitForState(QuickenWindow,TRUE,10)
				[ ] 
				[ ] // Verify transactions are not present before the date specified
				[ ]  lsTransaction=GetTransactionFromFindAndReplace(sFromDate,sField,sCriteria)
				[+] for(i=1;i<=ListCount(lsTransaction);i++)
					[ ] bMatch=MatchStr("*Opening Balance*",lsTransaction[i])
					[+] if(bMatch!=TRUE)
						[ ] ReportStatus("Verify transaction for specified date",FAIL,"Transactions of the prior specified date are available")
						[ ] break
				[+] if(bMatch)
					[ ] ReportStatus("Verify transaction for specified date",PASS,"Transactions are not present in copy of data file for {sField} is {sCriteria} than {sFromDate}")
				[+] else
					[ ] ReportStatus("Verify transaction for specified date",FAIL,"Transactions are present in copy of data file for {sField} is {sCriteria} than {sFromDate}")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Valiade Copy File",FAIL,"Copy popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate open QDF FIle", FAIL,"Unable to open {lsData[1]} data file!" )
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#Year End Copy File: Year End Copy for specified date  ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_VerifyYearEndCopyForSpecifiedDate()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify year end copy functionality by Creating a copy of file Locally by selecting 
		[ ] //second option for specified date
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	if transaction out of specified date are not present in year end copy				
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	19/06/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test21_VerifyYearEndCopyForSpecifiedDate() appstate none
	[+] // Variable declaration
		[ ] 
		[ ] STRING sFromDate,sField,sCriteria,sLocation,sFileName,hWnd
		[ ] LIST OF STRING lsTransaction 
		[ ] 
		[ ] sField="Check number"
		[ ] sCriteria="Less or equal"
		[ ] 
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sWorksheet)
		[ ] sFileName="{lsExcelData[1][2]}\{lsExcelData[1][1]}BKP.QDF"
		[+] if(FileExists(sFileName))
			[ ] DeleteFile(sFileName)
		[ ] 
	[+] if (!QuickenWindow.Exists ())
		[ ] App_Start (sCmdLine)
	[ ] 
	[+] if (QuickenWindow.Exists(5) == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] lsData=lsExcelData[1]
		[ ] 
		[ ] //Open existing data file
		[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
		[ ] //sleep(15)
		[ ] WaitForState(QuickenWindow,TRUE,25)
		[ ] 
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileOperations.Click()
			[ ] QuickenWindow.File.FileOperations.YearEndCopy.Select()
			[+] if(CreateAYearEndCopy.Exists(3))
				[ ] 
				[ ] CreateAYearEndCopy.Copyoption.Select(2)
				[ ] sFromDate=CreateAYearEndCopy.StartingDate.GetText()
				[ ] 
				[ ] 
				[ ] // Click on ok button
				[ ] CreateAYearEndCopy.OK.Click()
				[ ] 
				[+] if(FileArchived.Exists(60))
					[ ] FileArchived.SetActive()
					[ ] FileArchived.OptionforFile.Select("Current File")
					[ ] FileArchived.OK.Click()
					[ ] 
					[ ] sleep(3)
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] sFromDate=right(sFromDate ,4)
					[ ] //Verify reconciled transactions are not present till the date specified e.g. before 1/1/2014
					[ ] lsTransaction=GetTransactionFromFindAndReplace("107",sField,sCriteria)
					[+] for (iCounter=1; iCounter<ListCount(lsTransaction) ; iCounter++)
						[ ] bMatch=MatchStr("*/{sFromDate}*",lsTransaction[iCounter])
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Verify previous year transaction",FAIL,"previous year transactions are available even after year end copy created for last year")
							[ ] break
					[+] if(bMatch)
						[ ] ReportStatus("Verify transaction for specified date",PASS,"Transactions of the prior specified date are not available")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Year End Copy",FAIL,"File Archived option popup didn't appear")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Copy File",FAIL,"Copy popup did not appear")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate open QDF FIle", FAIL,"Unable to open {lsData[1]} data file!" )
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //########################################################################################
[ ] 
[ ] 
[ ] 
