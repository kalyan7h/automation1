[ ] 
[ ] 
[+] // FILE NAME:	<FileInputOutput.t.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This suit will perform the file menu related operations
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Puja Verma
	[ ] //
	[ ] // Developed on: 		28/5/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //May 28, 2011	Puja Verma  Created
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
	[ ] STRING sExcelName = "File IO"
	[ ] STRING sLocation,sFileName,sAddDateCheck
	[ ] STRING sCheckBoxStatus="1"
	[ ] INTEGER iRegistration
	[ ]  LIST OF ANYTYPE  lsExcelData
	[ ] STRING sCaption
	[ ] BOOLEAN bCaption
	[ ] INTEGER iShortSleep=10
	[ ] INTEGER iMedSleep=15
	[ ] INTEGER i,iBackUpFile
	[ ] STRING sTabName
	[ ] String sValidateandRepairValidDataSheet ="ValidateandRepairValidData"
	[ ] 
    
[ ] // 
[ ] 
[+] //############# QDF File Backup ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_QDFFileBackup()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create the backup of QDF  file in mentioned location
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while taking backup					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 04/01 2011		Puja Verma created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_QDFFileBackup() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] sTabName = "FileInputOutput"
		[ ] STRING sDateTi
		[ ] STRING sDateTime = FormatDateTime (GetDateTime(), "yyyy-mm-dd")
		[ ] STRING sBackUpFilename
		[ ] STRING sFilePath=AUT_DATAFILE_PATH + "\" +"LoacationFile1.txt"
		[ ] INTEGER iSetupAutoAPI
	[ ] //AutoApi Setup
	[ ] iSetupAutoAPI = SetUp_AutoApi()			// copy qwautoap.dll to Quicken folder in Program files
	[+] if (iSetupAutoAPI==FAIL)
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] //Check the Quicken Existence 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
	[ ] // Fetch data  from the given sheet
	[+] for(i=1;i<=ListCount(lsExcelData);i++)
		[ ] lsData=lsExcelData[i]
		[ ] iBackUpFile=FIleInputOutput(lsData[1],lsData[2],lsData[3],lsData[4],lsData[5])
		[ ] //Select Quicken Backup file
		[+] if(iBackUpFile==PASS)
			[+] if (!QuickenBackup.IsActive())
				[ ] QuickenBackup.SetActive()
			[ ] QuickenBackup.BackUpNow.Click()
			[ ] // if backup file already exist
			[+] if(DuplicateBackupFile.Exists(5))
				[ ] DuplicateBackupFile.SetActive()
				[ ] DuplicateBackupFile.Yes.Click()
			[ ] // Verify confirmation popup
			[+] if(BackupConfirmation.Exists(5))
				[ ] BackupConfirmation.SetActive()
				[ ] BackupConfirmation.OK.Click()
				[ ] // Verify File exist in specific location with name and date
				[+] if(lsData[5]==sCheckBoxStatus)
					[+] if(FileExists(lsData[4]+"\"+lsData[3]+"-{sDateTime}.QDF-backup"))
						[ ] sBackUpFilename=lsData[4]+"\"+lsData[3]+"-{sDateTime}.QDF-backup"
						[ ] ListAppend(lscontent, sBackUpFilename) 
						[ ] ReportStatus("Validate Backup and restore", PASS,"Backup done properly" )
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Backup and restore", FAIL,"Backup did not done properly" )
						[ ] 
				[+] else
					[ ] // Verify File exist in specific location with name and date
					[+] if(FileExists(lsData[4]+"\"+lsData[3]+".QDF-backup"))
						[+] ReportStatus("Validate Backup and restore", PASS,"Backup done properly" )
							[ ] sBackUpFilename=lsData[4]+"\"+lsData[3]+".QDF-backup"
						[ ] ListAppend(lscontent, sBackUpFilename)
					[+] else
						[ ] ReportStatus("Validate Backup and restore", FAIL,"Backup did not done properly" )
			[+] else
				[ ] ReportStatus("Validate Backup and restore", FAIL,"Confirmation popup did not appear" )
			[ ] 
		[+] else
			[ ] 
			[ ] ReportStatus("Validate Backup and restore", FAIL,"Validate Backup did not perform successfully" )
			[ ] 
		[ ] 
	[ ] ListWrite ( lscontent, sFilePath , FT_ANSI)
	[ ] 
[ ] //##########################################################
[ ] 
[+] //#############OverWrite Back up File ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_OverWriteBackupFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Over write the existing backup file with new backup file in mentioned location
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while taking backup					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 04/01 2011		Puja Verma created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_OverWriteBackupFile() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] sTabName = "OverWriteBackUp"
		[ ] STRING sDateTime = FormatDateTime (GetDateTime(), "yyyy-mm-dd")
		[ ] STRING sBackUpFilename
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] // iRegistration=BypassRegistration()
			[ ] // ReportStatus("Bypass Registration ", iRegistration, "Registration bypassed")
			[ ] // 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[ ] // Fetch data  from the given sheet
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[ ] iBackUpFile=FIleInputOutput(lsData[1],lsData[2],lsData[3],lsData[4],lsData[5])
			[ ] 
			[+] if(iBackUpFile==PASS)
				[ ] //Clickin Backup popup to take backup
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.BackUpNow.Click()
				[ ] // Selecting the Duplicate option
				[+] if(DuplicateBackupFile.Exists(iShortSleep))
					[ ] DuplicateBackupFile.SetActive()
					[ ] DuplicateBackupFile.Yes.Click()
					[ ] // Verify Backup Confirmation popup
					[+] if (BackupConfirmation.Exists(iShortSleep) == TRUE)
						[ ] BackupConfirmation.SetActive()
						[ ] BackupConfirmation.OK.Click()
						[ ] //Verify backup  file should present in system
						[+] if(lsData[5]==sCheckBoxStatus)
							[+] if(FileExists(lsData[4]+"\"+lsData[3]+"-{sDateTime}.QDF-backup"))
								[ ] sBackUpFilename=lsData[4]+"\"+lsData[3]+"-{sDateTime}.QDF-backup"
								[ ] ReportStatus("Validate Over write  file Backup ", PASS,"Backup done properly" )
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Over Write file Backup", FAIL,"Backup did not done properly" )
								[ ] 
						[+] else
							[+] if(FileExists(lsData[4]+"\"+lsData[3]+".QDF-backup"))
								[ ] ReportStatus("Validate Backup and restore", PASS,"Backup done properly" )
								[ ] sBackUpFilename=lsData[4]+"\"+lsData[3]+".QDF-backup"
							[+] else
								[ ] ReportStatus("Validate Backup and restore", FAIL,"Backup did not done properly" )
						[ ] 
						[ ] ReportStatus("Validate Duplicate Backup popup", PASS,"Duplicate  Backup did appear" )
					[+] else
						[ ] ReportStatus("Validate Backup and restore", FAIL,"Confirmation popup did not appear" )
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Backup and restore", FAIL,"Validate Backup did not perform successfully" )
			[+] else
				[ ] ReportStatus("Validate Duplicate Backup popup", FAIL,"Duplicate  Backup did not appear" )
	[+] else
		[ ] ReportStatus("Validate Duplicate Backup popup", FAIL,"Quicken did not launched!" )
		[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################
[ ] 
[+] //#############Cancel Over write Back up File #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_CancelOverWriteBackupFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Cancel over write the existing backup file .
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while taking backup					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 04/01 2011		Puja Verma created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_CancelOverWriteBackupFile() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] sTabName = "OverWriteBackUp"
		[ ] STRING sDateTime = FormatDateTime (GetDateTime(), "yyyy-mm-dd")
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[ ] // Fetch data  from the given sheet
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[ ] iBackUpFile=FIleInputOutput(lsData[1],lsData[2],lsData[3],lsData[4],lsData[5])
			[+] if(iBackUpFile==PASS)
				[ ] //Setting Active backup popup
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.BackUpNow.Click()
				[ ] //Verify Duplicate window should appear and click on cancel
				[ ] 
				[+] if(DuplicateBackupFile.Exists(5))
					[ ] DuplicateBackupFile.SetActive()
					[ ] DuplicateBackupFile.CancelButton.Click()
					[+] if(!QuickenBackup.Exists(2))
						[ ] ReportStatus("Validate Over Write functionality ",FAIL,"Confirmation popup appeared after the cancellation of over write file " )
						[ ] 
					[+] else
						[ ] QuickenBackup.Cancel.Click()
						[ ] ReportStatus("Validate Cancel Over Write Backup File ", PASS,"Confirmation popup did not appear after the cancellation of over write file" )
				[+] else 
						[ ] ReportStatus("Validate Cancel Over Write Backup File ",FAIL,"Duplicate popup did not appear " )
			[+] else
				[ ] ReportStatus("Validate Cancel Over Write Backup File", FAIL,"Validate Backup did not perform successfully" )
	[+] else
		[ ] ReportStatus("Validate Cancel Over Write Backup File ", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
[ ] //##########################################################
[ ] // 
[+] // // //#############Online Backup  #################################
	[ ] // // // ********************************************************
	[+] // // // TestCase Name:	 Test04_OnlineBackup()
		[ ] // // //
		[ ] // // // DESCRIPTION:
		[ ] // // // This testcase will create the online backup  file and store in server (predefined server location)
		[ ] // // // PRE-REQUISITE   : 		Online setup should done prior to run the test case,Install online backup feature
		[ ] // // //
		[ ] // // // PARAMETERS:		None
		[ ] // // //
		[ ] // // // RETURNS:			Pass 		If no error occurs while taking backup					
		[ ] // // //						Fail		If any error occurs
		[ ] // // //
		[ ] // // // REVISION HISTORY: 04/04/ 2011		Puja Verma created	
    // //                      12/06/2012      Udita Dube updated
	[ ] // // // ********************************************************
[+] // testcase Test04_OnlineBackup() appstate QuickenBaseState
	[+] // // Variable declaration
		[ ] // sTabName = "OnlineFileName"
		[ ] // INTEGER iFileStatus
	[ ] // //Check the Quicken Existence 
	[+] // if (QuickenWindow.Exists(5) )
		[ ] // QuickenWindow.SetActive()
		[ ] // //Fetching data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[ ] // //Running loop to fetch multiple rows from excel
		[+] // for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] // lsData=lsExcelData[i]
			[ ] // // Open data file
			[ ] // iFileStatus=OpenDataFile(lsData[1],lsData[2])
			[+] // if(iFileStatus==PASS)
				[ ] // QuickenWindow.File.Click()
				[ ] // QuickenWindow.File.BackupAndRestore.Click()
				[ ] // QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
				[ ] // //Select Backup File 
				[+] // if(QuickenBackup.Exists(5))
					[ ] // QuickenBackup.SetActive()
					[+] // if(!QuickenBackup.AddDateToBackupFileName.IsChecked())									// Added by Udita on 12 June 2012
						[ ] // QuickenBackup.AddDateToBackupFileName.Check()
					[ ] // QuickenBackup.RadioButtonBackUpType.Select ("Use Quicken Online Backup")
					[ ] // QuickenBackup.BackUpNow.Click()
					[ ] // // Click on confirmation popup for backup
					[+] // if(QuickenOnlineBackup.OK.Exists(2))
						[ ] // QuickenOnlineBackup.SetActive()
						[ ] // QuickenOnlineBackup.OK.MoveMouse()
						[ ] // QuickenOnlineBackup.OK.Click()
						[ ] // ReportStatus("Validate Online Backup",PASS,"Online Backup completed successfully")
					[+] // else
						[ ] // ReportStatus("Validate Online Backup",FAIL,"Confirmation popup didnot appear")
					[+] // if(QuickenBackup.DuplicateBackupFile.Exists(5))
						[ ] // QuickenBackup.DuplicateBackupFile.SetActive()
						[ ] // QuickenBackup.DuplicateBackupFile.Yes.Click()
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Validate Online Backup", FAIL,"Online Backup option is not availble")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("OnlineBackup",FAIL,"{lsExcelData[1]} No Such File Name Exists")
	[+] // else
		[ ] // ReportStatus("Validate Online Backup", FAIL,"Quicken did not launched!" )
		[ ] // 
	[ ] // 
[ ] // // //###########################################################
[ ] 
[+] //########## Restore From Backup Manually with Overwrite ############
	[ ] // ********************************************************
	[+] // TestCase Name:Test05_RestoreFromBackupManuallywithOverwrite()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will restore backup file from given location and if QDF file opened then over write it 
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while restoring					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 04/07/2011		Puja Verma created	
	[ ] // ********************************************************
[+] testcase Test05_RestoreFromBackupManuallywithOverwrite() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] sTabName = "RestoreBackUp"
		[ ] INTEGER i
		[ ] STRING sHandle,sActual ,sLocation
		[ ] STRING sCaption,sAccounts,sCategories,sExpAccount,sExpCategories,slocation,sFileName,sFileLocation
		[ ] BOOLEAN bCaption,bMatch
		[ ] STRING sDateTime = FormatDateTime (GetDateTime(), "yyyy-mm-dd")
		[ ] STRING sPattern="-backup"
		[ ] STRING sDatePattern=sDateTime
		[ ] STRING DummyFile ="C:\Quicken\ApplicationSpecific\Data\TestData\File Management data\AutoTest.QDF"
		[ ] INTEGER iFileStatus
		[ ] STRING sNetWorth="OVERALL TOTAL"
		[ ] STRING sChanged
		[ ] INTEGER j
		[ ] 
		[ ] sLocation=AUT_DATAFILE_PATH + "\File Management data"
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iFileStatus=DataFileCreate("AutoTest" ,sLocation)
		[ ] // Fetching data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] 
			[ ] lsData=lsExcelData[i]
			[ ] slocation=lsData[1]
			[ ] sExpAccount=lsData[2]
			[ ] sExpCategories=lsData[3]
			[ ] // Selecting backup restore 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
			[+] if(QuickenRestore.Exists(5))
				[ ] QuickenRestore.SetActive()
				[ ] QuickenRestore.RestoreFromBackupFile.Select ("Restore from your backup")
				[ ] QuickenRestore.BackupFilePath.SetText(slocation)
				[ ] QuickenRestore.RestoreBackup.Click()
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.OK.Click()
					[ ] QuickenRestore.Cancel.Click()
					[ ] ReportStatus("Validate Restore Backup",FAIL,"Mentioned path for restore backup is not available")
				[ ] //verify over write popup and perform over write functionality
				[+] if(RestoreOpenFile.Exists(2))
					[ ] RestoreOpenFile.SetActive()
					[ ] RestoreOpenFile.OverwriteTheOpenFileWithR.Select("Overwrite the existing file with restored file")
					[ ] RestoreOpenFile.RestoreBackup.Click()
				[+] else
					[ ] ReportStatus("Validate Restore Backup",FAIL,"Backup File path is not valid path")
					[ ] 
				[ ] //Get the file location and verify in the system
				[+] if(QuickenRestore.Exists(60))
					[ ] QuickenRestore.SetActive()
					[ ] sFileLocation=QuickenRestore.FileLocation.GetText()
					[ ] sFileName=QuickenRestore.FileName.GetText()
					[ ] QuickenRestore.YesRestore.Click()
					[ ] 
					[ ] //Verifying the file exist in correct location or not
					[ ] 
					[+] if(FileExists(sFileLocation+"\"+sFileName))
						[ ] ReportStatus("Validate Restore Backup",PASS,"File restored successfully")
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bCaption = MatchStr("*{sPattern}",sCaption)
					[+] if(bCaption == TRUE)
						[ ] ReportStatus("validate Restore backup",FAIL,"-Backup extention present after restore the backup")
					[+] else
						[ ] ReportStatus("validate Restore backup",PASS,"-Backup extention is not present after restore the backup")
						[ ] 
					[ ] bCaption = MatchStr("*{sDatePattern}*",sCaption)
					[+] if(bCaption == TRUE)
						[ ] ReportStatus("validate Restore backup",FAIL,"Date  extention present after restore the backup")
					[+] else
						[ ] ReportStatus("validate Restore backup",PASS ,"Date extention is not present after restore the backup")
						[ ] 
					[ ] // Verify Networth value
					[+] if(QuickenWindow.Exists(10))
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Reports.Click()
						[ ] QuickenWindow.Reports.Graphs.Click()
						[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
						[+] if (NetWorthReports.Exists(30))
							[ ] NetWorthReports.SetActive()
							[ ] NetWorthReports.Maximize()
							[ ] 
							[ ] NetWorthReports.ShowReport.Click()
							[+] for( j=9;;)
								[ ] sHandle=Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(j) )
								[ ] bMatch= MatchStr("*{sNetWorth}*",sActual)
								[+] if(bMatch==TRUE)
									[ ] sChanged = GetField(sActual,"@",4) 
									[ ] Verify(lsData[4],sChanged)
									[ ] ReportStatus("Validate Restore Backup",PASS,"NetWorth Value is Matching!")
									[ ] NetWorthReports.Close()
									[ ] WaitForState(NetWorthReports,false,1)
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.PressKeys(KEY_CONTROL)
									[ ] QuickenWindow.Help.Click()
									[ ] QuickenWindow.Help.AboutQuicken.Select()
									[ ] 
									[ ] 
									[ ] 
									[+] if(QuickenWindow.Quicken2012FileAttribute.Exists(5))
										[ ] 
										[ ] // Set Active File Attribute window
										[ ] QuickenWindow.Quicken2012FileAttribute.SetActive()
										[ ] 
										[ ] // Get values of File attributes
										[ ] sAccounts= QuickenWindow.Quicken2012FileAttribute.AccountsVal.GetText()
										[ ] sCategories= QuickenWindow.Quicken2012FileAttribute.CategoriesVal.GetText()
										[ ] 
										[ ] // Close File Attribute Window
										[ ] QuickenWindow.Quicken2012FileAttribute.Close()
										[ ] Verify(sExpAccount,sAccounts)
										[ ] Verify(sExpCategories,sCategories)
										[ ] ReportStatus("validate Restore backup",PASS ,"Restore backup is successfully done!")
										[ ] break
									[+] else
										[ ] ReportStatus("validate Restore backup",FAIL ,"Attributes details popup is not appeared on time")
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.ReleaseKeys(KEY_CONTROL)
								[+] else
									[ ] bMatch=MatchStr(sActual,"")
									[+] if(bMatch==true)
										[ ] ReportStatus("Validate Restore Backup",FAIL,"NetWorth Value is not available,Please Check!")
										[ ] break
									[+] else
										[ ] j=j+1
						[+] else
							[ ] ReportStatus("Verify NetWorth report.",FAIL,"Verify NetWorth report: NetWorth report didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Restore Backup",FAIL,"Quicken did not active")
						[ ] 
				[+] else
					[ ] ReportStatus("Validate Restore Backup",FAIL,"File did not available in expected location")
					[ ] 
			[+] else
				[ ] ReportStatus("Validate Duplicate Backup popup", FAIL,"Quicken Restore Popup did not Appear!" )
				[+] if(FileExists(DummyFile))
					[ ] QuickenMainWindow.Kill()
					[ ] WaitForState(QuickenMainWindow,False,5)
					[ ] DeleteFile(DummyFile)
				[ ] 
	[+] else
		[ ] ReportStatus("Validate Duplicate Backup popup", FAIL,"Quicken did not launched!" )
	[+] if(FileExists(DummyFile))
		[ ] QuickenMainWindow.Kill()
		[ ] WaitForState(QuickenMainWindow,False,5)
		[ ] sleep(2)
		[ ] DeleteFile(DummyFile)
[ ] //###########################################################
[ ] 
[+] //########## Restore From Backup Manually Create Copy #############
	[ ] // ********************************************************
	[+] // TestCase Name:Test06_RestoreFromBackupManuallyCreateCopy()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will restore backup file from given location and if QDF already exists then create copy of the file 
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating copy					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 04/07/2011		Puja Verma created	
	[ ] // ********************************************************
[+] testcase Test06_RestoreFromBackupManuallyCreateCopy() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] sTabName = "RestoreBackUp"
		[ ] INTEGER i=1
		[ ] STRING sHandle,sActual,sNetWorth,sFileName,sFileLocation
		[ ] // STRING sCaption,sAccounts,sCategories,sExpAccount,sExpCategories,slocation
		[ ] BOOLEAN bCaption
		[ ] STRING sDateTime = FormatDateTime (GetDateTime(), "yyyy-mm-dd")
		[ ] STRING sPattern="-backup"
		[ ] STRING sDatePattern=sDateTime
		[ ] STRING sCaptionName="Quicken 2012 Rental Property Manager"
		[ ] STRING FileLocation
		[ ] STRING sFilePath=AUT_DATAFILE_PATH + "\" +"LoacationFile.txt"
		[ ] STRING DummyFile ="D:\Quicken\ApplicationSpecific\Data\TestData\AutoTest.QDF"
		[ ] INTEGER iSelect
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] sCaption = QuickenWindow.GetCaption()
		[ ] bCaption = MatchStr(sCaptionName, sCaption)
		[+] if(bCaption == TRUE)
			[ ] iSelect=DataFileCreate("AutoTest")
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[ ] //Loop for multiple test data
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] 
			[ ] lsData=lsExcelData[i]
			[ ] // Pick restore item from menu
			[ ] WaitForState(QuickenMainWindow,TRUE,5)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
			[ ] // Select manual restore and give location
			[+] if(QuickenRestore.Exists(5))
				[ ] if(! QuickenRestore.isActive())
				[ ] QuickenRestore.SetActive()
				[ ] QuickenRestore.RestoreFromBackupFile.Select ("Restore from your backup")
				[ ] QuickenRestore.BackupFilePath.SetText(lsData[1])
				[ ] QuickenRestore.RestoreBackup.Click()
				[ ] 
				[+] if(Quicken2012.Exists(5))
					[ ] Quicken2012.OK.Click()
					[ ] QuickenRestore.Cancel.Click()
					[ ] ReportStatus("Validate Restore Backup",FAIL,"Mentioned path for restore backup is not available")
				[+] if(RestoreOpenFile.Exists(5))
					[ ] RestoreOpenFile.SetActive()
					[ ] //Selecting copy option
					[ ] RestoreOpenFile.CreateaCopy.Select ("Create a copy")
					[ ] RestoreOpenFile.RestoreBackup.Click()
					[ ] //Verify Copy popup
				[ ] CopyQuickenFileBrowser.SetActive()
				[ ] CopyQuickenFileBrowser.Save.Click()
				[ ] // Get location and file name and verify the same in system
				[+] if(QuickenRestore.Exists(5))
					[ ] sFileLocation=QuickenRestore.FileLocation.GetText()
					[ ] sFileName=QuickenRestore.FileName.GetText()
					[ ] QuickenRestore.No.Click()
					[+] if(FileExists(sFileLocation+"\"+sFileName))
						[ ] ReportStatus("Validate Restore Backup",PASS,"File restored successfully")
						[ ] ListAppend(lscontent, sFileLocation+"\"+sFileName) 
					[+] else
						[ ] ReportStatus("Validate Restore Backup",FAIL,"Restore File is not present in the expected location")
						[ ] 
				[+] else
					[ ] ReportStatus("Validate Restore Backup",FAIL,"File did not available in expected location")
					[ ] 
			[+] else
				[ ] ReportStatus("Validate Manual Restore Backup",FAIL,"Quicken restored did not appear!")
				[ ] 
		[ ] 
		[ ] ListWrite ( lscontent, sFilePath , FT_ANSI)
		[+] if(FileExists(DummyFile))
			[ ] DeleteFile(DummyFile)
		[ ] 
		[ ] QuickenWindow.ReleaseKeys(KEY_CONTROL)
	[+] else
		[ ] ReportStatus("Validate Cancel Over Write Backup File ", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
[ ] //###########################################################
[ ] 
[+] // // //############# Restore Online Backup File ########################
	[ ] // // // ********************************************************
	[+] // // // TestCase Name:	 Test08_RestoreOnlineBackupFile()
		[ ] // // //
		[ ] // // // DESCRIPTION:
		[ ] // // // This testcase will restore the backup file from server to local drive
		[ ] // // // PRE-REQUISITE   : 		Online setup should done prior to run the test case
		[ ] // // //
		[ ] // // // PARAMETERS:		None
		[ ] // // //
		[ ] // // // RETURNS:			Pass 		If no error occurs while restoring					
		[ ] // // //						Fail		If any error occurs
		[ ] // // //
		[ ] // // // REVISION HISTORY: 11/04/ 2011		Puja Verma created
		[ ] // //                      12/06/2012      Udita Dube updated	
	[ ] // // // ********************************************************
[+] // testcase Test08_RestoreOnlineBackupFile() appstate QuickenBaseState
	[+] // // Variable declaration
		[ ] // INTEGER j
		[ ] // STRING sHandle,sActual,sAccounts,sCategories,sFileLocation1,sFileName
		[ ] // BOOLEAN bMatchResult,bCaption
		[ ] // sTabName = "OnlineFileName"
		[ ] // STRING sFileLocation="C:\Quicken\ApplicationSpecific\Data\TestData\File Management data\"
		[ ] // STRING sDateTime = FormatDateTime (GetDateTime(), "yyyy-mm-dd")
		[ ] // STRING sNetWorth="OVERALL TOTAL"
		[ ] // STRING sChanged,sCaption
		[ ] // STRING sCaptionName="Quicken 2012 Rental Property Manager"
		[ ] // 
		[ ] // 
	[ ] // //Check the Quicken Existence 
	[+] // if (QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive()
		[ ] // //Fetching the data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[+] // for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] // lsData=lsExcelData[i]
			[ ] // QuickenWindow.SetActive()
			[ ] // sCaption = QuickenWindow.GetCaption()
			[ ] // bCaption = MatchStr(sCaptionName, sCaption)
			[ ] // 
			[ ] // // Pick restore item from menu
			[ ] // QuickenWindow.File.Click()
			[ ] // QuickenWindow.File.BackupAndRestore.Click()
			[ ] // QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
			[ ] // 
			[ ] // // Select online backup option
			[+] // if(QuickenRestore.Exists(5))
				[ ] // QuickenRestore.SetActive()
				[ ] // QuickenRestore.RestoreFromBackupFile.Select ("Restore from online backup")
				[ ] // QuickenRestore.RestoreBackup.Click()
				[ ] // //Select backup file from server 
				[+] // for(i=312;;)
					[+] // if(OnlineDataFileRestore.Exists(100))
						[ ] // sHandle=Str(OnlineDataFileRestore.QuickenOnlineDataFileResto2.ListBox1.GetHandle())
						[ ] // sActual= QwAutoExecuteCommand("LISTBOX_GETROW", sHandle,Str(i) )
						[ ] // sActual=GetField (sActual, "@", 1)
						[ ] // bMatchResult=MatchStr("{sFileLocation+lsData[1]+"-"+sDateTime+".QDF-backup"}*",sActual)
						[ ] // // if search file name is found than select the file  for restore 
						[+] // if (bMatchResult==true) 
							[ ] // QwAutoExecuteCommand("LISTBOX_SELECTROW",sHandle,Str(i))
							[ ] // OnlineDataFileRestore.OK.Click()
							[ ] // // If popup asking for location
							[+] // if(QuickenRestore.BackupFilePath.Exists(5))
								[ ] // QuickenRestore.BackupFilePath.SetText(sFileLocation)
								[ ] // QuickenRestore.Yes.Click()
							[+] // if(QuickenRestore.Exists(5))
								[ ] // QuickenRestore.RestoreBackup.Click()
							[+] // if(QuickenOnlineBackup.OK.Exists(500))
								[ ] // QuickenOnlineBackup.SetActive()
								[ ] // QuickenOnlineBackup.OK.MoveMouse()
								[ ] // QuickenOnlineBackup.OK.Click()
								[ ] // // Get the file path and location  and verify the same in system
								[+] // if(QuickenRestore.Exists(5))
									[ ] // sFileLocation1=QuickenRestore.FileLocation.GetText()
									[ ] // sFileName=QuickenRestore.FileName.GetText()
									[ ] // QuickenRestore.YesRestore.Click()
									[+] // if(FileExists(sFileLocation1+"\"+sFileName))
										[ ] // ReportStatus("Validate Restore Backup Online",PASS,"File restored successfully")
								[ ] // //Verify NetWorth
								[ ] // QuickenWindow.SetActive()
								[ ] // QuickenMainWindow.Reports.Graphs.NetWorth.Select()
								[ ] // Quicken2012Popup.SetActive()
								[ ] // Quicken2012Popup.Maximize()
								[ ] // Quicken2012Popup.ShowReport.MoveMouse()
								[ ] // Quicken2012Popup.ShowReport.Click(1,5,5)
								[+] // for( j=9;;)
									[ ] // sHandle=Str(Quicken2012Popup.QWListViewer1.ListBox1.GetHandle())
									[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(j) )
									[ ] // BOOLEAN bMatch= MatchStr("*{sNetWorth}*",sActual)
									[+] // if(bMatchResult==TRUE)
										[ ] // sChanged = GetField(sActual,"@",4) 
										[ ] // Verify(lsData[4],sChanged)
										[ ] // ReportStatus("Validate Restore Backup Online",PASS,"NetWorth Value is Matching!")
										[ ] // Quicken2012Popup.Close()
										[ ] // QuickenWindow.SetActive()
										[ ] // // Open Qiucken File Attribute window
										[ ] // QuickenMainWindow.TypeKeys("<Alt-h>")
										[ ] // QuickenMainWindow.TypeKeys ("<SHIFT-q>")
										[+] // if(Quicken2012FileAttribute.Exists(5))
											[ ] // // Set Active File Attribute window
											[ ] // Quicken2012FileAttribute.SetActive()
											[ ] // 
											[ ] // // Get values of File attributes
											[ ] // sAccounts= Quicken2012FileAttribute.AccountsVal.GetText()
											[ ] // sCategories= Quicken2012FileAttribute.CategoriesVal.GetText()
											[ ] // 
											[ ] // // Close File Attribute Window
											[ ] // Quicken2012FileAttribute.Close()
											[ ] // //Verify expected with actual value
											[ ] // Verify(lsData[2],sAccounts)
											[ ] // Verify(lsData[3],sCategories)
											[ ] // ReportStatus("validate Restore backup",PASS ,"Attributes details popup is Matched")
											[ ] // break
										[+] // else
											[ ] // ReportStatus("validate Restore backup",FAIL ,"Attributes details popup is not appeared on time")
											[ ] // break
										[ ] // 
									[+] // else
										[ ] // bMatchResult=MatchStr(sActual,"")
										[+] // if(bMatchResult==true)
											[ ] // ReportStatus("Validate Restore Backup Online",FAIL,"NetWorth Value is not available,Please Check!")
											[ ] // break
										[+] // else
											[ ] // j=j+1
							[+] // else
								[ ] // ReportStatus("Validate Online BackupRestore",FAIL,"Quicken Online Backup restore confirmation popup did not appear")
								[ ] // 
							[ ] // break
						[+] // else
							[ ] // bMatchResult=MatchStr(sActual,"")
							[+] // if(bMatchResult==true)
								[ ] // OnlineDataFileRestore.OK.Click()
								[ ] // ReportStatus("Validate Online BackupRestore",FAIL,"{lsData[1]} Backup file did not found ")
								[ ] // break
							[+] // else
								[ ] // i = i + 1 
					[+] // else
						[ ] // ReportStatus("Validate Online BackupRestore",FAIL,"Online Data File Restore Popup window did not appear")
						[ ] // QuickenMainWindow.Kill()
						[ ] // WaitForState(QuickenMainWindow,False,5)
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Validate Online BackupRestore",FAIL,"Restore Popup window did not appear")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Restore Online ", FAIL,"Quicken did not launched!" )
	[ ] // 
	[ ] // 
[ ] // // //###########################################################
[ ] 
[+] //############# Import File #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_ImportFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will import the QFX file and verify the account name 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while importing				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 12/04/ 2011		Puja Verma created	
	[ ] // ********************************************************
[+] testcase Test10_ImportFile() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sFile="WebImportInv"
		[ ] STRING sFileName="Dummy"
		[ ] STRING sFileWithPath = AUT_DATAFILE_PATH + "\" + sFile+".QFX"
		[ ] STRING AccountType, Accountname , sAccount ,sCaption ,sExpected
		[ ] INTEGER iXCords,iYCords
		[ ] iXCords = 38
		[ ] iYCords = 5
		[ ] STRING sTabName="ImportFile"
		[ ] INTEGER i,iSwitchState,j ,iResult
		[ ] STRING sNetWorth="OVERALL TOTAL"
		[ ] STRING sChanged,sHandle,sActual
		[ ] BOOLEAN bMatch
		[ ] sAccount="Account"
		[ ] sExpected ="Verify Cash Balance"
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Fetching the data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[ ] //Create the new data file
			[ ] iResult =DataFileCreate(sFileName)
			[+] if (iResult==PASS)
				[ ] 
				[ ] sleep(10)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.View.Click()
				[ ] QuickenWindow.View.TabsToShow.Click()
				[+] if (QuickenWindow.View.TabsToShow.Investing.IsChecked==False)
					[ ] sleep(2)
					[+] do
						[ ] QuickenWindow.View.TabsToShow.Investing.Select()
					[+] except
						[ ] LogWarning("Failed to select Investing, trying one more time")
						[ ] QuickenWindow.View.TabsToShow.Investing.Select()
					[ ] 
				[ ] 
				[ ] //Select the wen connect option from menu and give data file name
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.MainMenu.Select("/_File/File _Import/_Web Connect File...")
				[+] if (CreateQuickenFile.Exists(5))
					[ ] CreateQuickenFile.SetActive()
					[ ] CreateQuickenFile.FileName.SetText(lsData[1])
					[ ] CreateQuickenFile.OK.Click()
					[ ] // Click the import popup and click the import button to import the file
					[+] if(ImportDownloadedTransactions.Exists(300))
						[ ] ImportDownloadedTransactions.SetActive()
						[ ] AccountType=ImportDownloadedTransactions.NewAccountDetails.PopupList2.GetSelText()
						[ ] Accountname=ImportDownloadedTransactions.NewAccountDetails.TextField1.GetText()
						[ ] bMatch = MatchStr("*Checking*" ,Accountname)
						[+] if (bMatch)
							[ ] ImportDownloadedTransactions.NewAccountDetails.TextField1.SetText("Checking" + " " +sAccount)
						[+] else
							[ ] ImportDownloadedTransactions.NewAccountDetails.TextField1.SetText(Accountname + " " +sAccount)
						[ ] Accountname=ImportDownloadedTransactions.NewAccountDetails.TextField1.GetText()
						[ ] ImportDownloadedTransactions.Import.Click()
						[ ] ///Message from WellsFargo
						[+] if (DlgMsgWellsFargo.Exists(10))
							[ ] DlgMsgWellsFargo.SetActive()
							[+] if (DlgMsgWellsFargo.DontShowAgainCheckBox.Exists())
								[ ] DlgMsgWellsFargo.DontShowAgainCheckBox.Check()
							[ ] DlgMsgWellsFargo.OK.Click()
						[ ] 
						[ ] 
						[ ] // Click the done to Summary page
						[+] if(DlgMessageFromTIAACREF.Exists(20))
							[ ] DlgMessageFromTIAACREF.SetActive()
							[ ] DlgMessageFromTIAACREF.DontShowThisMessageAgain.Check()
							[ ] DlgMessageFromTIAACREF.OK.Click()
							[ ] 
						[ ] 
						[+] if(OneStepUpdateSummary.Exists(60))
							[ ] OneStepUpdateSummary.SetActive()
							[ ] OneStepUpdateSummary.Close.Click()
						[ ] //One popup coming 
						[ ] //sleep fron investing account//
						[+] if (bMatch==FALSE)
							[ ] sleep(10)
						[ ] QuickenWindow.SetActive()
						[ ] iSwitchState = UsePopupRegister("ON")
						[+] if(iSwitchState==PASS)
							[+] if (i==1)
								[ ] SelectAccountFromAccountBar(Accountname, ACCOUNT_INVESTING)
							[+] else
								[ ] SelectAccountFromAccountBar(Accountname, ACCOUNT_BANKING )
								[ ] 
							[ ] sleep(iShortSleep)
							[+] // if(DlgVerifyCashBalance.Exists(30))
								[ ] // DlgVerifyCashBalance.SetActive()
								[ ] // DlgVerifyCashBalance.TypeKeys(KEY_EXIT)
							[+] if(DlgVerifyCashBalance.Exists(30))
								[ ] DlgVerifyCashBalance.SetActive()
								[ ] DlgVerifyCashBalance.TypeKeys(KEY_EXIT)
							[+] if (QuickenUpdateStatus.Exists(10))
								[ ] QuickenUpdateStatus.SetActive()
								[ ] QuickenUpdateStatus.StopUpdate.DoubleClick()
							[ ] sleep(30)
							[+] if(InvestingAccountPopup.Exists(200))
								[ ] InvestingAccountPopup.SetActive()
								[ ] sCaption= InvestingAccountPopup.GetProperty("Caption")
								[ ] Verify(sCaption, Accountname)
								[ ] InvestingAccountPopup.TypeKeys(KEY_EXIT)
								[+] if(FileExists(AUT_DATAFILE_PATH+"\"+sFileName+".QDF"))
									[ ] Sleep(iShortSleep)
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.Reports.Click()
									[ ] QuickenWindow.Reports.Graphs.Click()
									[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
									[+] if (NetWorthReports.Exists(30))
										[ ] NetWorthReports.SetActive()
										[ ] NetWorthReports.Maximize()
										[ ] NetWorthReports.ShowReport.Click()
										[ ] //Verify NethWorth
										[+] for( j=9;;)
											[ ] sHandle=Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())
											[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(j) )
											[ ] bMatch= MatchStr("*{sNetWorth}*",sActual)
											[+] if(bMatch==TRUE)
												[ ] sChanged = GetField(sActual,"@",4) 
												[ ] // Verify(sChanged,lsData[2])
												[ ] ReportStatus("Validate Import File {lsData[1]}",PASS,"NetWorth Value matched after importing {lsData[1]}.")
												[ ] NetWorthReports.TypeKeys(KEY_EXIT)
												[+] if (QuickenWindow.Exists ())
													[ ] QuickenMainWindow.Kill()
													[ ] WaitForState(QuickenMainWindow,False,5)
													[ ] DeleteFile(AUT_DATAFILE_PATH+"\"+sFileName+".QDF")
												[ ] break
											[+] else
												[ ] bMatch=MatchStr(sActual,"")
												[+] if(bMatch==true)
													[ ] ReportStatus("Validate Import File {lsData[1]}",FAIL,"NetWorth Value didn't match for file {lsData[1]}.")
													[ ] break
												[+] else
													[ ] j=j+1
									[+] else
										[ ] ReportStatus("Verify NetWorth report.",FAIL,"Verify NetWorth report: NetWorth report didn't appear.")
									[ ] 
								[ ] ReportStatus("Validate Import File",PASS,"File Imported successfully with correct data")
							[+] else
								[ ] ReportStatus("Validate Import File ", FAIL,"Messge box did not appear to get Name!" )
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Import File",FAIL,"Use Popup Register Fail")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate ImportDownloadedTransactions",FAIL,"ImportDownloadedTransactions dialog did not appear")
				[+] else
					[ ] ReportStatus("Validate ImportFile",FAIL,"Import dialog did not appear")
			[+] else
				[ ] ReportStatus("Validate Import File ", FAIL,"Datatfile couldn't be created." )
	[+] else
		[ ] ReportStatus("Validate Import File ", FAIL,"Quicken did not launched!" )
	[ ] 
[ ] //###########################################################
[ ] 
[+] //############# Validate Year End Copy  ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_ValidateYearEndCopy ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create  year end copy of opend file  .
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while creating copy .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	14/04/2011  	Created By	Puja Verma
	[ ] //*********************************************************
[+] testcase Test11_ValidateYearEndCopy() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sTabName="YearEnd"
		[ ] INTEGER i,iSelect
		[ ] STRING sLocation
	[ ] /// Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Fetching the data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[ ] 
			[ ] // Open existing data file
			[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
			[ ] sleep(15)
			[+] if(iSelect==PASS)
				[+] if(QuickenWindow.Exists(iMedSleep))
					[ ] QuickenWindow.SetActive()
					[ ] // Select year end copy option from File->File Operation
					[ ] QuickenWindow.File.Click()
					[ ] QuickenWindow.File.FileOperations.Click()
					[ ] QuickenWindow.File.FileOperations.YearEndCopy.Select()
					[ ] //Confirmation popup for coping the file
					[+] if(CreateAYearEndCopy.Exists(5))
						[ ] CreateAYearEndCopy.SetActive()
						[ ] CreateAYearEndCopy.Copyoption.Click()
						[ ] sLocation=CreateAYearEndCopy.FileName.GetText()
						[+] if (FileExists(sLocation))
							[ ] DeleteFile(sLocation)
							[ ] sleep(1)
						[ ] 
						[ ] CreateAYearEndCopy.OK.Click()
						[+] if(FileArchived.Exists(10))
							[ ] FileArchived.SetActive()
							[ ] FileArchived.OptionforFile.Select("Archive file")
							[ ] FileArchived.OK.Click()
							[ ] 
							[ ] // Verify backup file exist or not
							[ ] sCaption = QuickenWindow.GetCaption()
							[ ] bCaption=MatchStr("*{lsData[1]+"BKP"}*",sCaption)
							[+] if(bCaption==TRUE)
								[ ] ReportStatus("Validate Year End Cop",PASS,"File Copy Successfull with BKP in extension in name")
								[ ] 
								[+] if(FileExists(sLocation))
									[ ] QuickenMainWindow.Kill()
									[ ] WaitForState(QuickenMainWindow,False,5)
									[ ] DeleteFile(sLocation)
									[ ] ReportStatus("Validate Year End Copy",PASS,"File Copy Successfull in required location")
								[+] else
									[ ] ReportStatus("Validate Year End Copy",FAIL,"File did not create year end copy Successfull in required location")
							[+] else
								[ ] ReportStatus("Validate Copy Operation",FAIL,"File did not Copy Successfull with Cpy extension")
						[+] else
							[ ] ReportStatus("Validate Year End Copy",FAIL,"Did  not asked for File Archived option popup")
							[ ] 
					[+] else
						[ ] ReportStatus("Validate Year End Copy",FAIL,"Create a year end copy option did not appear")
			[+] else
				[ ] QuickenMainWindow.Kill()
				[ ] WaitForState(QuickenMainWindow,False,5)
				[ ] ReportStatus("Validate Year End Copy",FAIL,"Mentioned file is not available in required location")
	[+] else
		[ ] ReportStatus("Validate Year End Copy", FAIL,"Quicken did not launched!" )
	[ ] 
[ ] //###########################################################
[ ] 
[+] //############# Find Quicken Files  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_FindQuickenFiles ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will search QDF file From quick search funtionality in specific location and  verify name.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while Searching the file .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	15/4/2011  	Created By	Puja Verma
	[ ] //*********************************************************
[+] testcase Test12_FindQuickenFiles() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sTabName="FindFile"
		[ ] INTEGER i
		[ ] STRING sHandle
		[ ] STRING sFileName="Sample"
		[ ] STRING DummyFile ="C:\Quicken\ApplicationSpecific\Data\TestData\Sample.QDF"
		[ ] 
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] DataFileCreate(sFileName)
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
				[+] QuickenWindow.SetActive()
					[ ] 
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
				[ ] // sleep(20)
				[ ] FindQuickenDataFiles.Search.VerifyEnabled(TRUE,100)
				[ ] sHandle=Str(FindQuickenDataFiles.FilesFoundQWListViewer.ListBox1.GetHandle())
				[ ] //Select File
				[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW",sHandle,"0" )
				[ ] // sleep(2)
				[ ] // QwAutoExecuteCommand("LISTBOX_SELECTROW",sHandle,"0" )
				[ ] 
				[ ] //open the same file and verify the name 
				[+] if(FindQuickenDataFiles.OpenFile.Exists(5)==TRUE)
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
	[+] if(FileExists(DummyFile))
		[ ] QuickenMainWindow.Kill()
		[ ] WaitForState(QuickenMainWindow,False,5)
		[ ] DeleteFile(DummyFile)
[ ] //###########################################################
[ ] 
[+] //############# Validate Import AddessBook  #######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_ValidateImportAddessBook ()
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
[+] testcase Test13_ValidateImportAddressBook() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sExcelLocation=AUT_DATAFILE_PATH+"\"+"TEST.CSV"
		[ ] STRING sHandle,sActual,sValue1,sValue2,sValue,sValueCount
		[ ] LIST OF STRING lsItems
		[ ] LIST OF STRING lsSelectedItem
		[ ] STRING sCaptionName="- Test - [Home]"
		[ ] STRING sFileName="Test"
		[ ] lsItems=({"Payee","Last Name","First Name"})
		[ ] INTEGER iFileStatus,i
		[ ] STRING sTabName="ImportAddress"
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
							[ ] iFileStatus=OpenDataFile(lsData[2])
							[ ] sleep(10)
							[+] if(iFileStatus==PASS)
								[+] if (QuickenWindow.Exists(5))
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.View.Click()
									[ ] QuickenWindow.View.TabsToShow.Click()
									[+] if (QuickenWindow.View.TabsToShow.Business.IsChecked==FALSE)
										[ ] QuickenWindow.View.TabsToShow.Business.Select()
									[ ] QuickenWindow.MainMenu.Select("/_File/File _Import/_Addresses...")
									[ ] // QuickenWindow.File.Click()
									[ ] // QuickenWindow.File.FileImport.Click()
									[ ] // QuickenWindow.File.FileImport.Address.Select()
									[+] if(DlgAddressBook.Exists(5))
										[ ] AddressRecords.SetActive()
										[ ] sActual=DlgAddressBook.RecordsAddress.GetText()
										[ ] //take record count of address
										[ ] sValue1=StrTran(sActual,"(","")
										[ ] sValue2=StrTran(sValue1,")","")
										[ ] sValue=GetField (sValue2, " ", 1) 
										[ ] print(Val(sValue))
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
				[+] else
					[ ] ReportStatus("Validate Import Address File ", FAIL,"Quicken did not launched!" )
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Import Address Book",FAIL,"Mentioned file is not available in required location,Please check !")
	[+] else
		[ ] ReportStatus("Validate Import Address File ", FAIL,"Quicken did not launched!" )
	[ ] 
[ ] //###########################################################
[ ] 
[+] //############# Validate And Repair  #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_ValidateAndRepair ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will validate and repair the file and no error should present in the note pad
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while validating the file .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	14/4/2011  	Created By	Puja Verma
	[ ] //*********************************************************
[+] testcase Test14_ValidateAndRepair() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sTabName="ValidateAndRepair"
		[ ] BOOLEAN bChecked,bMatch
		[ ] INTEGER i,iSelect
		[ ] STRING sFilePath="C:\Documents and Settings\puja_verma\Application Data\Intuit\Quicken\Log\DATA_LOG.TXT"
		[ ] STRING sMsg1="No errors."
		[ ] STRING sMsg2="Validation has completed."
		[ ] INTEGER iPos
		[ ] 
	[ ] //Check the Quicken Existence 
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
						[ ] // Verify note pad should have error report
						[+] if(Notepad.Exists(90))
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
					[+] else
						[ ] ReportStatus("Validate and Repair operation",FAIL,"ValidateAndRepair didn't not appear.")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate and Repair operation",FAIL,"Quicken is not active.")
			[+] else
				[ ] ReportStatus("Validate and Repair operation",FAIL,"Mentioned file name is not available in the required location")
				[ ] 
	[+] else
		[ ] QuickenMainWindow.Kill()
		[ ] WaitForState(QuickenMainWindow,false,5)
		[ ] ReportStatus("Validate Opertaion Validate and Repair", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
[ ] //###########################################################
[ ] 
[+] //############# QDF File Backup and restore  ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_QDFFileBackupAndRestore()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create the backup of QDF  file in mentioned location and restore the backup
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while taking backup					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 04/01 2011		Puja Verma created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test15_QDFFileBackupAndRestore() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] sTabName = "BackupAndRestore"
		[ ] INTEGER j,k
		[ ] STRING sDateTime = FormatDateTime (GetDateTime(), "yyyy-mm-dd")
		[ ] STRING sBackUpFilename,sAccounts,sCategories,sActual,sHandle,sChanged,sBackupAccounts,sBackupCategories,sBackupChanged
		[ ] STRING sNetWorth="OVERALL TOTAL"
		[ ] BOOLEAN bMatch
		[ ] STRING sFilePath=AUT_DATAFILE_PATH + "\" +"LoacationFile1.txt"
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists ())
		[ ] QuickenWindow.SetActive()
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[ ] // Fetch data  from the given sheet
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
			[ ] iBackUpFile=FIleInputOutput(lsData[1],lsData[2],lsData[3],lsData[4],lsData[5])
			[ ] //Select Quicken Backup file
			[+] if(iBackUpFile==PASS)
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.BackUpNow.Click()
				[ ] // if backup file already exist
				[+] if(DuplicateBackupFile.Exists(5))
					[ ] DuplicateBackupFile.Yes.Click()
				[ ] // Verify confirmation popup
				[+] if(BackupConfirmation.Exists(10))
					[ ] BackupConfirmation.SetActive()
					[ ] BackupConfirmation.OK.Click()
					[ ] // Verify File exist in specific location with name and date
					[+] if(lsData[5]==sCheckBoxStatus)
						[+] if(FileExists(lsData[4]+"\"+lsData[3]+"-{sDateTime}.QDF-backup"))
							[ ] sBackUpFilename=lsData[4]+"\"+lsData[3]+"-{sDateTime}.QDF-backup"
							[ ] ListAppend(lscontent, sBackUpFilename) 
							[ ] ReportStatus("Validate Backup and restore", PASS,"Backup done properly" )
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Backup and restore", FAIL,"Backup did not done properly" )
							[ ] 
					[+] else
						[ ] // Verify File exist in specific location with name and date
						[+] if(FileExists(lsData[4]+"\"+lsData[3]+".QDF-backup"))
							[+] ReportStatus("Validate Backup and restore", PASS,"Backup done properly" )
								[ ] sBackUpFilename=lsData[4]+"\"+lsData[3]+".QDF-backup"
							[ ] ListAppend(lscontent, sBackUpFilename)
						[+] else
							[ ] ReportStatus("Validate Backup and restore", FAIL,"Backup did not done properly" )
					[ ] //  Open Report window and Verify Networth value
					[+] if(QuickenWindow.Exists(3))
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
									[ ] sBackupChanged = GetField(sActual,"@",4) 
									[ ] NetWorthReports.TypeKeys(KEY_EXIT)
									[ ] QuickenWindow.SetActive()
									[ ] QuickenMainWindow.TypeKeys("<Alt-h>")
									[ ] // Open Qiucken File Attribute window 
									[ ] QuickenMainWindow.TypeKeys ("<SHIFT-q>")
									[+] if(QuickenWindow.Quicken2012FileAttribute.Exists(10))
										[ ] 
										[ ] // Set Active File Attribute window
										[ ] QuickenWindow.Quicken2012FileAttribute.SetActive()
										[ ] 
										[ ] // Get values of File attributes
										[ ] sBackupAccounts= QuickenWindow.Quicken2012FileAttribute.AccountsVal.GetText()
										[ ] sBackupCategories= QuickenWindow.Quicken2012FileAttribute.CategoriesVal.GetText()
										[ ] 
										[ ] // Close File Attribute Window
										[ ] QuickenWindow.Quicken2012FileAttribute.Close()
										[ ] QuickenWindow.File.Click()
										[ ] QuickenWindow.File.BackupAndRestore.Click()
										[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
										[ ] // Selecting Manual restore and give the location
										[+] if(QuickenRestore.Exists(5))
											[ ] QuickenRestore.SetActive()
											[ ] QuickenRestore.RestoreFromBackupFile.Select ("Restore from your backup")
											[ ] QuickenRestore.BackupFilePath.SetText(sBackUpFilename)
											[ ] QuickenRestore.RestoreBackup.Click()
											[+] if(Quicken2012.Exists(5))
												[ ] Quicken2012.OK.Click()
												[ ] QuickenRestore.Cancel.Click()
												[ ] ReportStatus("Validate Restore Backup",FAIL,"Mentioned path for restore backup is not available")
											[ ] //verify over write popup and perform over write functionality
											[+] if(RestoreOpenFile.Exists(5))
												[ ] RestoreOpenFile.OverwriteTheOpenFileWithR.Select("Overwrite the open file with restored file")
												[ ] RestoreOpenFile.RestoreBackup.Click()
											[ ] //Get the file location and verify in the system
											[+] if(QuickenRestore.Exists(10))
												[ ] QuickenRestore.SetActive()
												[+] QuickenRestore.YesRestore.Click()
													[ ] 
												[ ] // Verify Networth value
											[+] if(QuickenWindow.Exists(10))
												[ ] QuickenWindow.SetActive()
												[ ] QuickenWindow.Reports.Click()
												[ ] QuickenWindow.Reports.Graphs.Click()
												[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
												[+] if (NetWorthReports.Exists(30))
													[ ] NetWorthReports.SetActive()
													[ ] NetWorthReports.Maximize()
													[ ] NetWorthReports.ShowReport.Click()
													[+] for(k=9;;)
														[ ] sHandle=Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())
														[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(k) )
														[ ] bMatch= MatchStr("*{sNetWorth}*",sActual)
														[+] if(bMatch==TRUE)
															[ ] sChanged = GetField(sActual,"@",4) 
															[ ] Verify(sChanged,sBackupChanged)
															[ ] ReportStatus("Validate Restore Backup",PASS,"NetWorth Value is Matching!")
															[ ] NetWorthReports.TypeKeys(KEY_EXIT)
															[ ] QuickenWindow.SetActive()
															[ ] QuickenMainWindow.TypeKeys("<Alt-h>")
															[ ] // Open Qiucken File Attribute window 
															[ ] QuickenMainWindow.TypeKeys ("<SHIFT-q>")
															[+] if(QuickenWindow.Quicken2012FileAttribute.Exists(5))
																[ ] 
																[ ] // Set Active File Attribute window
																[ ] QuickenWindow.Quicken2012FileAttribute.SetActive()
																[ ] 
																[ ] // Get values of File attributes
																[ ] sAccounts= QuickenWindow.Quicken2012FileAttribute.AccountsVal.GetText()
																[ ] sCategories= QuickenWindow.Quicken2012FileAttribute.CategoriesVal.GetText()
																[ ] 
																[ ] // Close File Attribute Window
																[ ] QuickenWindow.Quicken2012FileAttribute.Close()
																[ ] Verify(sBackupAccounts,sAccounts)
																[ ] Verify(sBackupCategories,sCategories)
																[ ] ReportStatus("validate Restore backup",PASS ,"Restore backup is successfully done!")
																[ ] break
															[+] else
																[ ] ReportStatus("validate Restore backup",FAIL ,"Attributes details popup is not appeared on time")
														[+] else
															[ ] bMatch=MatchStr(sActual,"")
															[+] if(bMatch==TRUE)
																[ ] ReportStatus("Validate Restore Backup",FAIL,"NetWorth Value is not available,Please Check!")
																[ ] break
															[+] else
																[ ] k=k+1
												[+] else
													[ ] ReportStatus("Verify NetWorth report.",FAIL,"Verify NetWorth report: NetWorth report didn't appear.")
												[ ] 
											[+] else
												[ ] ReportStatus("Validate Restore Backup",FAIL,"Quicken did not active")
											[ ] 
										[+] else
											[ ] ReportStatus("Validate Duplicate Backup popup", FAIL,"Quicken Restore Popup did not Appear!" )
									[+] else
										[ ] ReportStatus("validate Restore backup",FAIL ,"Attributes details popup is not appeared on time")
									[ ] break
								[+] else
									[ ] bMatch=MatchStr(sActual,"")
									[+] if(bMatch==TRUE)
										[ ] ReportStatus("Validate Restore Backup",FAIL,"NetWorth Value is not available,Please Check!")
										[ ] break
									[+] else
										[ ] j=j+1
						[+] else
							[ ] ReportStatus("Verify NetWorth report.",FAIL,"Verify NetWorth report: NetWorth report didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Restore Backup",FAIL,"Quicken did not active")
				[+] else
					[ ] ReportStatus("Validate Backup and restore", FAIL,"Confirmation popup did not appear" )
			[+] else
				[ ] ReportStatus("Validate Backup and restore", FAIL,"Validate Backup did not perform successfully" )
	[+] else
		[ ] ReportStatus("Validate Backup and restore", FAIL,"Quicken did not launched!" )
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenMainWindow.Kill()
		[ ] sleep(10)
	[+] for(i=1; i<=ListCount(lscontent);i++)
		[+] if(FileExists(lscontent[i]))
			[ ] DeleteFile(lscontent[i])
	[ ] 
[ ] //###########################################################
[+] //############# C2R Functionality (Banking) ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_ValidateAndRepairC2RFunctionalityBanking()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify data conversion for a datafile which has a banking account and there are transactions in the C2R
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if verification of data conversion for a datafile with banking C2R transactions is successful			
		[ ] //						Fail		if verification of data conversion for a datafile with banking C2R transactions is unsuccessful			
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  June 1, 2013	      Mukesh	Created	
	[ ] //*********************************************************
[+] testcase Test16_ValidateAndRepairC2RFunctionalityBanking() appstate QuickenBaseState 
	[+] // Variable declaration
		[ ] LIST OF ANYTYPE lsData
		[ ] INTEGER iCreateDataFile,iAccount, iResult , iCounter , iCount
		[ ] BOOLEAN bMatch,bFlag
		[ ] STRING sOnlineTransactionDataFile, sFilePath,sFileName,sAccount,sAccountName,sHandle,sActual,sEndingBalance,sIndex1,sIndex2, sCaption, sEndingBalance1, sExpected
	[ ] STRING sRow
	[+] // Expected Values
		[ ] sFileName = "WellsFargo_Checking.qfx"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sAccountName="Checking at Wells Fargo Bank"
		[ ] sEndingBalance="20"
		[ ] sEndingBalance1= "130"
		[ ] sIndex1="#12"
		[ ] sIndex2= "#14"
		[ ] bFlag = FALSE
		[ ] lsExcelData=ReadExcelTable(sExcelName, sValidateandRepairValidDataSheet)
		[ ] 
		[ ] 
	[+] // Pre-requisite
		[ ] // Delete qa_acc32.dll
		[+] if(FileExists (sAccDllDestinationPath))
			[ ] DeleteFile(sAccDllDestinationPath)
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[+] if(FileExists (sDestinationonliniFile))
			[ ] DeleteFile(sDestinationonliniFile)
		[ ] 
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[+] if(FileExists (SYS_GetEnv("WINDIR") + "\\intu_onl.ini"))
			[ ] DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
		[ ] 
	[ ] 
	[+] //Create a new data file for Online transaction download SelectPreferenceType
		[ ] iCreateDataFile = DataFileCreate(sOnlineTransactionDataFile)
		[ ] 
		[+] if (iCreateDataFile==PASS)
			[ ] 
			[ ] ReportStatus("Verify Data File ", PASS, "Data file -  {sOnlineTransactionDataFile} is created")
			[ ] // Check if Quicken is launched
			[+] if (QuickenWindow.Exists(10))
				[ ] QuickenWindow.SetActive()
				[ ] UsePopupRegister("OFF")
				[ ] // Navigate to Edit > Preferences
				[ ] sExpected = "Downloaded Transactions"
				[ ] iResult=SelectPreferenceType(sExpected)
				[+] if(iResult== PASS)
					[+] if(Preferences.Exists(5))
						[ ] Preferences.SetActive()
						[ ] // Check the checkbox if it is unchecked
						[+] if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
							[ ] Preferences.AutomaticallyAddDownloadedT.Uncheck()
							[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Automatic Transaction entry checkbox has been unchecked on preferences > {sExpected}.") 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Automatic Transaction entry checkbox on preferences > {sExpected} is already unchecked.") 
							[ ] 
						[ ] Preferences.OK.Click()
						[ ] WaitForState(Preferences,false ,1)
						[ ] sleep(2)
						[ ] // Navigate to File > File Import > Web Connect File
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.MainMenu.Select("/_File/File _Import/_Web Connect File...")
						[ ] // QuickenWindow.File.Click()
						[ ] // QuickenWindow.File.FileImport.Click()
						[ ] // QuickenWindow.File.FileImport.WebConnectFile.Select()
						[ ] // 
						[ ] // Import web connect file
						[+] if(CreateQuickenFile.Exists(SHORT_SLEEP))
							[ ] CreateQuickenFile.SetActive()
							[ ] CreateQuickenFile.FileName.SetText(sFilePath)
							[ ] CreateQuickenFile.OK.Click()
							[+] if(ImportDownloadedTransactions.Exists(300))
								[ ] ImportDownloadedTransactions.SetActive()
								[ ] // Check if default Account name is not displayed, enter account name in text field
								[ ] sAccount=ImportDownloadedTransactions.NewAccountDetails.TextField1.GetText()
								[+] if(sAccount=="")
									[ ] ImportDownloadedTransactions.NewAccountDetails.TextField1.SetText(sAccountName)
								[ ] // Click on Import
								[ ] ImportDownloadedTransactions.Import.Click()
								[ ] ///Message from WellsFargo
								[+] if (DlgMsgWellsFargo.Exists(10))
									[ ] DlgMsgWellsFargo.SetActive()
									[+] if (DlgMsgWellsFargo.DontShowAgainCheckBox.Exists())
										[ ] DlgMsgWellsFargo.DontShowAgainCheckBox.Check()
									[ ] DlgMsgWellsFargo.OK.Click()
								[ ] 
								[+] if(OneStepUpdateSummary.Exists(20))
									[ ] OneStepUpdateSummary.SetActive()
									[ ] OneStepUpdateSummary.Close()
									[ ] WaitForState(OneStepUpdateSummary, False,1)
									[ ] 
									[ ] //  Verify that Account is shown on account bar
									[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
									[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
									[ ] bMatch = MatchStr("*{sAccountName}*{sEndingBalance}*", sActual)
									[+] if(bMatch == TRUE)
										[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{sAccountName} account is available with ending balance - {sEndingBalance}")
										[ ] 
									[+] else
										[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{sActual} account is not available in Account bar")
										[ ] 
									[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
									[ ] sleep(4)
									[ ] QuickenWindow.SetActive()
									[ ] // if(CheckingAtWellsFargo.StaticText1.C2RHeader.DownloadedTransactions.Exists ())
									[+] if(MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.Exists (10))
										[ ] sCaption = MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.GetCaption ()
										[ ] sExpected = "5"
										[ ] bMatch = MatchStr("*{sExpected}*", sCaption)
										[+] if(bMatch == TRUE)
											[ ] ReportStatus("Validate No. of Transactions", PASS, "Expected no. of Transaction - {sExpected}, Actual no. of Transaction - {sCaption}")
										[+] else
											[ ] ReportStatus("Validate No. of Transactions", FAIL, "Expected no. of Transaction - {sExpected}, Actual no. of Transaction - {sCaption}")
											[ ] 
									[+] else
										[ ] ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
										[ ] 
									[ ] 
									[ ] ///Validate and Repair the file///
									[ ] QuickenWindow.SetActive()
									[ ] // Select Validate and repair option from File-> File Operation
									[ ] QuickenWindow.File.Click()
									[ ] QuickenWindow.File.FileOperations.Click()
									[ ] QuickenWindow.File.FileOperations.ValidateAndRepair.Select()
									[ ] //Selecting all the validation check boxes
									[+] if(ValidateAndRepair.Exists(5))
										[ ] ValidateAndRepair.SetActive()
										[ ] bMatch=ValidateAndRepair.ValidateFile.IsChecked()
										[+] if(bMatch==FALSE)
											[ ] ValidateAndRepair.ValidateFile.Check()
										[ ] bMatch=ValidateAndRepair.RebuildInvestingLots.IsChecked()
										[+] if(bMatch==FALSE)
											[ ] ValidateAndRepair.RebuildInvestingLots.Check()
										[ ] bMatch=ValidateAndRepair.DeleteInvestingPriceHistory.IsChecked()
										[+] if(bMatch==FALSE)
											[ ] ValidateAndRepair.DeleteInvestingPriceHistory.Check()
											[ ] 
										[ ] ValidateAndRepair.OK.Click()
										[ ] // Verify note pad should have error report
										[+] if(Notepad.Exists(90))
											[ ] Notepad.SetActive()
											[ ] lscontent=Notepad.TextField1.GetContents()
											[+] for (iCounter=1 ; iCounter < ListCount( lsExcelData) +1 ; ++iCounter)
												[ ] lsData= lsExcelData[iCounter]
												[+] if (lsData[iCounter]==NULL)
													[ ] break
												[+] for (iCount=1 ; iCount < ListCount( lsData) +1 ; ++iCount)
													[+] if (lsData[iCount]==NULL)
														[ ] break
													[+] for each sRow in lscontent
														[ ] bMatch = MatchStr("*{lsData[iCount]}*" ,sRow)
														[+] if (bMatch )
															[ ] break
													[+] if (bMatch)
														[ ] ReportStatus("Validate and Repair operation",PASS,"Validate and Repair operation: String : {sRow} found for segment: {lsData[1]} as expected {lsData[iCount]}.")
													[+] else
														[ ] ReportStatus("Validate and Repair operation",FAIL,"Validate and Repair operation: String : {sRow} is NOT found for segment: {lsData[1]} as expected {lsData[iCount]}.")
											[ ] Notepad.TypeKeys(KEY_EXIT)
											[ ] WaitForState(Notepad,false,1)
											[ ] ///Verify C2R data after validate and repair//
											[ ] //  Verify that Account is shown on account bar
											[ ] iResult = SelectAccountFromAccountBar(sAccountName, ACCOUNT_BANKING)
											[+] if (iResult==PASS)
												[ ] 
												[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
												[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
												[ ] bMatch = MatchStr("*{sAccountName}*{sEndingBalance}*", sActual)
												[+] if(bMatch == TRUE)
													[ ] ReportStatus("Verify C2R data after validate and repair", PASS, "Verify C2R data after validate and repair:{sAccountName} account is available with ending balance - {sEndingBalance}")
												[+] else
													[ ] ReportStatus("Verify C2R data after validate and repair", FAIL, "Verify C2R data after validate and repair: {sActual} account is not available in Account bar")
												[ ] 
												[+] if(MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.Exists ())
													[ ] sCaption = MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.GetCaption ()
													[ ] sExpected = "5"
													[ ] bMatch = MatchStr("*{sExpected}*", sCaption)
													[+] if(bMatch == TRUE)
														[ ] ReportStatus("Verify C2R data after validate and repair", PASS, "Verify C2R data after validate and repair: Expected no. of Transaction - {sExpected}, Actual no. of Transaction - {sCaption}")
													[+] else
														[ ] ReportStatus("Verify C2R data after validate and repair", FAIL, "Verify C2R data after validate and repair: Expected no. of Transaction - {sExpected}, Actual no. of Transaction - {sCaption}")
														[ ] 
												[+] else
													[ ] ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
											[+] else
												[ ] ReportStatus("Validate and Repair operation",FAIL,"Account :{sAccountName} couldn't be selected.")
											[ ] 
										[+] else
											[ ] ReportStatus("Validate and Repair operation",FAIL,"Notepad did not exist.")
									[+] else
										[ ] ReportStatus("Verify ValidateAndRepair Window", FAIL, "ValidateAndRepair window is not available") 
								[+] else
									[ ] ReportStatus("Verify OneStepUpdateSummary Window", FAIL, "OneStepUpdateSummary window is not available") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate ImportDownloadedTransactions Window", FAIL, "ImportDownloadedTransactions window is not available") 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate 'Import Web Connect File' Window", FAIL, "'Import Web Connect File' Window is not available") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify checkbox for Automatic Transaction entry'", FAIL, "Automatic Transaction entry checkbox is not available on preferences > {sExpected}.") 
						[ ] 
				[+] else
					[+] ReportStatus("Verify {sExpected} on preferences." , FAIL, "Verify {sExpected} on preferences: {sExpected} is not available on preferences") 
						[ ] Preferences.OK.Click()
						[ ] WaitForState(Preferences,false ,1)
						[ ] 
					[ ] 
				[ ] 
			[ ] // Report Status if Quicken is not launched
			[+] else
				[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Data File ", FAIL, "Data file -  {sOnlineTransactionDataFile} couldn't be created")
		[ ] 
		[ ] // 
	[ ] 
	[ ] 
[ ] //############################################################################
[+] //############# C2R Functionality (Investing) ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_ValidateAndRepairC2RFunctionalityInvesting()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify data conversion for a datafile which has a Investing account and there are transactions in the C2R
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if verification of data conversion for a datafile with Investing C2R transactions is successful			
		[ ] //						Fail		if verification of data conversion for a datafile with Investing C2R transactions is unsuccessful			
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	June 12   2013	      Mukesh	Created	
	[ ] //*********************************************************
[+] testcase Test17_ValidateAndRepairC2RFunctionalityInvesting() appstate none 
	[+] // Variable declaration
		[ ] LIST OF ANYTYPE lsData
		[ ] INTEGER iCreateDataFile,iAccount, iResult , iCounter , iCount
		[ ] BOOLEAN bMatch,bFlag
		[ ] STRING sOnlineTransactionDataFile, sFilePath,sFileName,sAccount,sAccountName,sHandle,sActual,sCashBalance, sCaption,  sExpectedCashBalance
		[ ] STRING sRow ,sActualCashBalance ,sImportedTransactionsCount ,sExpected , sWebFilePath2 ,sWebFile2
		[ ] STRING sMDIWindow 
	[+] // Expected Values
		[ ] sMDIWindow = "MDI"
		[ ] sFileName = "WebImportInv.qfx"
		[ ] sWebFile2="Vanguard_Investing.qfx"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sWebFilePath2 = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sWebFile2
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sAccountName="Investment at TIAA-CREF"
		[ ] bFlag = FALSE
		[ ] lsExcelData=ReadExcelTable(sExcelName, sValidateandRepairValidDataSheet)
		[ ] sImportedTransactionsCount="3"
		[ ] sExpectedCashBalance="-2,295.69"
		[ ] 
	[+] // Pre-requisite
		[ ] // Delete qa_acc32.dll
		[+] if(FileExists (sAccDllDestinationPath))
			[ ] DeleteFile(sAccDllDestinationPath)
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[+] if(FileExists (sDestinationonliniFile))
			[ ] DeleteFile(sDestinationonliniFile)
		[ ] 
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[+] if(FileExists (SYS_GetEnv("WINDIR") + "\\intu_onl.ini"))
			[ ] DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
		[ ] 
	[ ] 
	[+] //Create a new data file for Online transaction download SelectPreferenceType
		[ ] iCreateDataFile = DataFileCreate(sOnlineTransactionDataFile)
		[ ] // iCreateDataFile=PASS
		[+] if (iCreateDataFile==PASS)
			[ ] ReportStatus("Verify Data File ", PASS, "Data file -  {sOnlineTransactionDataFile} is created")
			[ ] UsePopupRegister("OFF")
			[ ] // Check if Quicken is launched
			[+] if (QuickenWindow.Exists(10))
				[ ] QuickenWindow.SetActive()
				[ ] // Navigate to Edit > Preferences
				[ ] sExpected = "Downloaded Transactions"
				[ ] iResult=SelectPreferenceType(sExpected)
				[+] if(iResult== PASS)
					[+] if(Preferences.Exists(5))
						[ ] Preferences.SetActive()
						[ ] // Check the checkbox if it is unchecked
						[+] if(Preferences.AutomaticallyAddToInvestmentTransactionLists.IsChecked())
							[ ] Preferences.AutomaticallyAddToInvestmentTransactionLists.Uncheck()
							[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Automatic Transaction entry checkbox has been unchecked on preferences > {sExpected}.") 
						[+] else
							[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Automatic Transaction entry checkbox on preferences > {sExpected} is already unchecked.") 
							[ ] 
						[ ] Preferences.OK.Click()
						[ ] WaitForState(Preferences,false ,1)
						[ ] // Navigate to File > File Import > Web Connect File
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.MainMenu.Select("/_File/File _Import/_Web Connect File...")
						[ ] 
						[ ] // Import web connect file
						[+] if(CreateQuickenFile.Exists(SHORT_SLEEP))
							[ ] CreateQuickenFile.SetActive()
							[ ] CreateQuickenFile.FileName.SetText(sFilePath)
							[ ] CreateQuickenFile.OK.Click()
							[+] if(ImportDownloadedTransactions.Exists(300))
								[ ] ImportDownloadedTransactions.SetActive()
								[ ] // Check if default Account name is not displayed, enter account name in text field
								[ ] sAccount=ImportDownloadedTransactions.NewAccountDetails.TextField1.GetText()
								[+] if(sAccount=="")
									[ ] ImportDownloadedTransactions.NewAccountDetails.TextField1.SetText(sAccountName)
								[ ] // Click on Import
								[ ] ImportDownloadedTransactions.Import.Click()
								[ ] 
								[+] if(DlgVerifyCashBalance.Exists(60))
									[ ] DlgVerifyCashBalance.SetActive()
									[ ] DlgVerifyCashBalance.OnlineBalanceTextField.SetText("10")
									[ ] DlgVerifyCashBalance.Done.Click()
									[ ] 
									[ ] 
									[ ] 
								[+] if(DlgMessageFromTIAACREF.Exists(20))
									[ ] DlgMessageFromTIAACREF.SetActive()
									[ ] DlgMessageFromTIAACREF.DontShowThisMessageAgain.Check()
									[ ] DlgMessageFromTIAACREF.OK.Click()
									[ ] 
								[ ] 
								[+] if(OneStepUpdateSummary.Exists(30))
									[ ] OneStepUpdateSummary.SetActive()
									[ ] OneStepUpdateSummary.Close()
									[ ] WaitForState(OneStepUpdateSummary, False,1)
									[ ] //The account is being selected two times to cater issue QW-2941
									[ ] 
									[ ] iResult = SelectAccountFromAccountBar(sAccountName, ACCOUNT_INVESTING)
									[+] if (iResult==PASS)
										[ ] 
										[+] if (DlgVerifyCashBalance.Exists(60))
											[ ] DlgVerifyCashBalance.SetActive()
											[ ] DlgVerifyCashBalance.typeKeys(KEY_EXIT)
											[ ] 
										[ ] sleep(20)
										[ ] //Import second webconnect file
										[ ] // Navigate to File > File Import > Web Connect File
										[ ] QuickenWindow.SetActive()
										[ ] QuickenWindow.MainMenu.Select("/_File/File _Import/_Web Connect File...")
										[+] if(CreateQuickenFile.Exists(SHORT_SLEEP))
											[ ] CreateQuickenFile.SetActive()
											[ ] CreateQuickenFile.FileName.SetText(sWebFilePath2)
											[ ] CreateQuickenFile.OK.Click()
											[ ] 
											[+] if(DlgVerifyCashBalance.Exists(60))
												[ ] DlgVerifyCashBalance.SetActive()
												[ ] DlgVerifyCashBalance.OnlineBalanceTextField.SetText("10")
												[ ] DlgVerifyCashBalance.Done.Click()
											[ ] 
											[+] if(ImportDownloadedTransactions.Exists(300))
												[ ] ImportDownloadedTransactions.SetActive()
												[ ] 
												[ ] // Check if default Account name is not displayed, enter account name in text field
												[ ] ImportDownloadedTransactions.LinkToAnExistingAccount.Select("Link to an existing account:")
												[ ] ImportDownloadedTransactions.Import.Click()
												[ ] 
												[+] if(OneStepUpdateSummary.Exists(30))
													[ ] OneStepUpdateSummary.SetActive()
													[ ] OneStepUpdateSummary.Close()
													[ ] WaitForState(OneStepUpdateSummary, False,1)
													[ ] 
													[+] if (DlgVerifyCashBalance.Exists(2))
														[ ] DlgVerifyCashBalance.SetActive()
														[ ] DlgVerifyCashBalance.TypeKeys(KEY_EXIT)
														[ ] WaitForState(DlgVerifyCashBalance,false,2)
														[ ] sleep(10)
														[ ] 
													[+] if(MDIClient.BrokerageAccount.wTransaction.DownloadTransactionsTab.Exists (10))
														[ ] sCaption = MDIClient.BrokerageAccount.wTransaction.DownloadTransactionsTab.GetCaption ()
														[ ] 
														[ ] bMatch = MatchStr("*{sImportedTransactionsCount}*", sCaption)
														[+] if(bMatch == TRUE)
															[ ] ReportStatus("Validate No. of Transactions", PASS, "Expected no. of Transaction - {sImportedTransactionsCount}, Actual no. of Transaction - {sCaption} for {sAccountName}")
														[+] else
															[ ] ReportStatus("Validate No. of Transactions", FAIL, "Expected no. of Transaction - {sImportedTransactionsCount}, Actual no. of Transaction - {sCaption} for {sAccountName}")
													[+] else
														[+] ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available for {sAccountName}.")
																[ ] 
															[ ] 
													[ ] 
													[ ] //Verify Cash Balance//
													[ ] QuickenWindow.SetActive()
													[ ] // NavigateToAccountActionInvesting(7,sMDIWindow)
													[+] // if (UpdateCashBalance.Exists(4))
														[ ] // UpdateCashBalance.SetActive()
														[ ] // sActualCashBalance=UpdateCashBalance.CashBalanceTextField.GetText()
														[+] // if (sActualCashBalance==sExpectedCashBalance)
															[ ] // ReportStatus("Verify Cash Balance amount", PASS, "Verify Cash Balance amount for {sAccountName}: Cash Balance amount: {sActualCashBalance} is as expected {sExpectedCashBalance} for {sAccountName}.")
														[+] // else
															[ ] // ReportStatus("Verify Cash Balance amount", FAIL, "Verify Cash Balance amount for {sAccountName}: Cash Balance amount: {sActualCashBalance} is NOT as expected {sExpectedCashBalance}for {sAccountName}.")
														[ ] // UpdateCashBalance.Cancel.Click()
														[ ] // WaitForState(UpdateCashBalance,FALSE,1)
													[+] // else
														[ ] // ReportStatus("Verify Update Cash Balance", FAIL, "Verify Dialog Update Cash Balance :Update Cash Balance Dialog didn't appear.")
													[ ] ///Validate and Repair the file///
													[ ] QuickenWindow.SetActive()
													[ ] // Select Validate and repair option from File-> File Operation
													[ ] QuickenWindow.File.Click()
													[ ] QuickenWindow.File.FileOperations.Click()
													[ ] QuickenWindow.File.FileOperations.ValidateAndRepair.Select()
													[ ] //Selecting all the validation check boxes
													[+] if(ValidateAndRepair.Exists(5))
														[ ] ValidateAndRepair.SetActive()
														[ ] bMatch=ValidateAndRepair.ValidateFile.IsChecked()
														[+] if(bMatch==FALSE)
															[ ] ValidateAndRepair.ValidateFile.Check()
														[ ] bMatch=ValidateAndRepair.RebuildInvestingLots.IsChecked()
														[+] if(bMatch==FALSE)
															[ ] ValidateAndRepair.RebuildInvestingLots.Check()
														[ ] bMatch=ValidateAndRepair.DeleteInvestingPriceHistory.IsChecked()
														[+] if(bMatch==FALSE)
															[ ] ValidateAndRepair.DeleteInvestingPriceHistory.Check()
															[ ] 
														[ ] ValidateAndRepair.OK.Click()
														[ ] // Verify note pad should have error report
														[+] if(Notepad.Exists(90))
															[ ] Notepad.SetActive()
															[ ] lscontent=Notepad.TextField1.GetContents()
															[+] for (iCounter=1 ; iCounter < ListCount( lsExcelData) +1 ; ++iCounter)
																[ ] lsData= lsExcelData[iCounter]
																[+] if (lsData[iCounter]==NULL)
																	[ ] break
																[+] for (iCount=1 ; iCount < ListCount( lsData) +1 ; ++iCount)
																	[+] if (lsData[iCount]==NULL)
																		[ ] break
																	[+] for each sRow in lscontent
																		[ ] bMatch = MatchStr("*{lsData[iCount]}*" ,sRow)
																		[+] if (bMatch )
																			[ ] break
																	[+] if (bMatch)
																		[ ] ReportStatus("Validate and Repair operation",PASS,"Validate and Repair operation: String : {sRow} found for segment: {lsData[1]} as expected {lsData[iCount]}.")
																	[+] else
																		[ ] ReportStatus("Validate and Repair operation",FAIL,"Validate and Repair operation: String : {sRow} is NOT found for segment: {lsData[1]} as expected {lsData[iCount]}.")
															[ ] Notepad.TypeKeys(KEY_EXIT)
															[ ] WaitForState(Notepad,false,1)
															[ ] ///Verify C2R data after validate and repair//
															[ ] //  Verify that Account is shown on account bar
															[ ] iResult = SelectAccountFromAccountBar(sAccountName, ACCOUNT_INVESTING)
															[+] if (iResult==PASS)
																[+] if(MDIClient.BrokerageAccount.wTransaction.DownloadTransactionsTab.Exists ())
																	[ ] sCaption = MDIClient.BrokerageAccount.wTransaction.DownloadTransactionsTab.GetCaption ()
																	[ ] 
																	[ ] bMatch = MatchStr("*{sImportedTransactionsCount}*", sCaption)
																	[+] if(bMatch == TRUE)
																		[ ] ReportStatus("Validate No. of Transactions", PASS, "Expected no. of Transaction - {sImportedTransactionsCount}, Actual no. of Transaction - {sCaption} for {sAccountName} after Validate and Repair process.")
																	[+] else
																		[ ] ReportStatus("Validate No. of Transactions", FAIL, "Expected no. of Transaction - {sImportedTransactionsCount}, Actual no. of Transaction - {sCaption} for {sAccountName} after Validate and Repair process defect :QW-1654.")
																		[ ] 
																[+] else
																	[ ] ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available for {sAccountName} after Validate and Repair process.")
																	[ ] 
															[+] else
																[ ] ReportStatus("Validate and Repair operation",FAIL,"Account :{sAccountName} couldn't be selected.")
															[ ] 
															[ ] // // Verify Cash Balance//
															[ ] // QuickenWindow.SetActive()
															[ ] // NavigateToAccountActionInvesting(7,sMDIWindow)
															[+] // if (UpdateCashBalance.Exists(4))
																[ ] // UpdateCashBalance.SetActive()
																[ ] // sActualCashBalance=UpdateCashBalance.CashBalanceTextField.GetText()
																[+] // if (sActualCashBalance==sExpectedCashBalance)
																	[ ] // ReportStatus("Verify Cash Balance amount", PASS, "Verify Cash Balance amount for {sAccountName}: Cash Balance amount: {sActualCashBalance} is as expected {sExpectedCashBalance} for {sAccountName} after Validate and Repair process..")
																[+] // else
																	[ ] // ReportStatus("Verify Cash Balance amount", FAIL, "Verify Cash Balance amount for {sAccountName}: Cash Balance amount: {sActualCashBalance} is NOT as expected {sExpectedCashBalance}for {sAccountName} after Validate and Repair process.")
																[ ] // UpdateCashBalance.Cancel.Click()
																[ ] // WaitForState(UpdateCashBalance,FALSE,1)
															[+] // else
																[ ] // ReportStatus("Verify Update Cash Balance", FAIL, "Verify Dialog Update Cash Balance :Update Cash Balance Dialog didn't appear.")
															[ ] 
														[+] else
															[ ] ReportStatus("Validate and Repair operation",FAIL,"Notepad did not exist.")
													[+] else
														[ ] ReportStatus("Verify ValidateAndRepair Window", FAIL, "ValidateAndRepair window is not available") 
												[+] else
													[ ] ReportStatus("Verify OneStepUpdateSummary Window", FAIL, "OneStepUpdateSummary window is not available") 
												[ ] 
											[+] else
												[ ] ReportStatus("Validate ImportDownloadedTransactions Window", FAIL, "ImportDownloadedTransactions window is not available") 
										[+] else
											[ ] ReportStatus("Validate 'Import Web Connect File' Window", FAIL, "'Import Web Connect File' Window is not available") 
										[ ] 
									[+] else
										[ ] ReportStatus("Validate and Repair operation",FAIL,"Account :{sAccountName} couldn't be selected.")
										[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify OneStepUpdateSummary Window", FAIL, "OneStepUpdateSummary window is not available") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate ImportDownloadedTransactions Window", FAIL, "ImportDownloadedTransactions window is not available") 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate 'Import Web Connect File' Window", FAIL, "'Import Web Connect File' Window is not available") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify checkbox for Automatic Transaction entry'", FAIL, "Automatic Transaction entry checkbox is not available on preferences > {sExpected}.") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify {sExpected} on preferences." , FAIL, "Verify {sExpected} on preferences: {sExpected} is not available on preferences") 
					[ ] 
				[ ] 
			[ ] // Report Status if Quicken is not launched
			[+] else
				[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Data File ", FAIL, "Data file -  {sOnlineTransactionDataFile} couldn't be created")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# ExportQIFFile ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_ExportQIFFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Export  the QDF  file into QIF and verify the account and category count 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Exporting				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 12/04/ 2011		Puja Verma created	
	[ ] // ********************************************************
[+] testcase Test09_ExportQIFFile() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sTabName="ExportFile"
		[ ] INTEGER i,iSelect,j
		[ ] STRING sLocation
		[ ] BOOLEAN bCheckStatus,bMatch
		[ ] STRING sFileName="Dummy"
		[ ] STRING sAccounts,sTransaction
		[ ] STRING sNetWorth="OVERALL TOTAL"
		[ ] STRING sChanged,sHandle,sActual
		[ ] Agent.SetOption(OPT_NO_ICONIC_MESSAGE_BOXES,True)
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // Fetching the data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsData=lsExcelData[i]
		[ ] //open existing data file 
		[ ] iSelect=OpenDataFile(lsData[1],lsData[2])
		[ ] sleep(10)
		[+] if(FileExists(lsData[2]+"\"+lsData[1]+".QIF"))
			[ ] DeleteFile((lsData[2]+"\"+lsData[1]+".QIF"))
		[+] if(iSelect==PASS)
			[ ] //Select the export option from menu
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.FileExport.Click()
			[ ] QuickenWindow.File.FileExport.QIFFile.Select()
			[ ] //verify export popup
			[+] if(QIFExportPopUp.Exists(20))
				[ ] QIFExportPopUp.SetActive()
				[ ] //Provide location
				[ ] sLocation=QIFExportPopUp.QIFFileToExportTo.GetText()
				[ ] QIFExportPopUp.QuickenAccountToExportFrom.Select("<All Accounts>")
				[ ] // Check allthe check boxes to get maximum details
				[ ] bCheckStatus=QIFExportPopUp.Transactions.IsChecked()
				[+] if(bCheckStatus==FALSE)
					[ ] QIFExportPopUp.Transactions.Check()
				[ ] bCheckStatus=QIFExportPopUp.AccountList.IsChecked()
				[+] if(bCheckStatus==FALSE)
					[ ] QIFExportPopUp.AccountList.Check()
				[ ] bCheckStatus=QIFExportPopUp.CategoryList.IsChecked()
				[+] if(bCheckStatus==FALSE)
					[ ] QIFExportPopUp.CategoryList.Check()
				[ ] bCheckStatus=QIFExportPopUp.MemorizedPayees.IsChecked()
				[+] if(bCheckStatus==FALSE)
					[ ] QIFExportPopUp.MemorizedPayees.Check()
				[ ] bCheckStatus=QIFExportPopUp.SecurityLists.IsChecked()
				[+] if(bCheckStatus==FALSE)
					[ ] QIFExportPopUp.SecurityLists.Check()
				[ ] bCheckStatus=QIFExportPopUp.BusinessLists.IsChecked()
				[+] if(bCheckStatus==FALSE)
					[ ] QIFExportPopUp.BusinessLists.Check()
				[ ] QIFExportPopUp.SetActive()
				[ ] QIFExportPopUp.OK.Click()
				[ ] //Create new data file
				[ ] DataFileCreate(sFileName)
				[ ] sleep(10)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.View.Click()
				[ ] QuickenWindow.View.TabsToShow.Click()
				[+] if(QuickenWindow.View.TabsToShow.Investing.IsChecked==FALSE)
					[ ] QuickenWindow.View.TabsToShow.Investing.Select()
				[ ] //  Click import option to import file
				[ ] QuickenWindow.TypeKeys(KEY_ESC)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.FileImport.Click()
				[ ] QuickenWindow.File.FileImport.QIFFile.Select()
				[ ] //Select all the check boxes to get maximum infortion
				[+] if(QIFImportPopUp.Exists(20))
					[ ] QIFImportPopUp.LocationOfQIFFileTextField.SetText(sLocation)
					[ ] QIFImportPopUp.QuickenAccountToImportInto.Select("<All Accounts>")
					[ ] bCheckStatus=QIFImportPopUp.Transactions.IsChecked()
					[+] if(bCheckStatus==FALSE)
						[ ] QIFImportPopUp.Transactions.Check()
					[ ] bCheckStatus=QIFImportPopUp.AccountList.IsChecked()
					[+] if(bCheckStatus==FALSE)
						[ ] QIFImportPopUp.AccountList.Check()
					[ ] bCheckStatus=QIFImportPopUp.CategoryList.IsChecked()
					[+] if(bCheckStatus==FALSE)
						[ ] QIFImportPopUp.CategoryList.Check()
					[ ] bCheckStatus=QIFImportPopUp.MemorizedPayees.IsChecked()
					[+] if(bCheckStatus==FALSE)
						[ ] QIFImportPopUp.MemorizedPayees.Check()
					[ ] bCheckStatus=QIFImportPopUp.SpecialHandlingForTransfers.IsChecked()
					[+] if(bCheckStatus==FALSE)
						[ ] QIFImportPopUp.SpecialHandlingForTransfers.Check()
					[ ] bCheckStatus=QIFImportPopUp.SecurityLists.IsChecked()
					[+] if(bCheckStatus==FALSE)
						[ ] QIFImportPopUp.SecurityLists.Check()
					[ ] QIFImportPopUp.SetActive()
					[ ] QIFImportPopUp.Import.Click()
					[ ] sleep(200)
					[+] if (QIFImportPopUpSuccessful.Exists(10))
						[ ] QIFImportPopUpSuccessful.SetActive()
						[ ] QIFImportPopUpSuccessful.Done.Click()
						[ ] 
					[+] if (QIFImportPopUp.Exists(10))
						[ ] QIFImportPopUp.SetActive()
						[ ] QIFImportPopUp.Done.Click()
						[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] QuickenMainWindow.TypeKeys("<Alt-h>")
					[ ] // Open Qiucken File Attribute window 
					[ ] QuickenMainWindow.TypeKeys ("<SHIFT-q>")
					[+] if(QuickenWindow.Quicken2012FileAttribute.Exists(5))
						[ ] 
						[ ] // Set Active File Attribute window
						[ ] QuickenWindow.Quicken2012FileAttribute.SetActive()
						[ ] // Get values of File attributes
						[ ] sAccounts= QuickenWindow.Quicken2012FileAttribute.AccountsVal.GetText()
						[ ] // Close File Attribute Window
						[ ] Verify(sAccounts,lsData[3])
						[ ] QuickenWindow.Quicken2012FileAttribute.Close()
						[ ] ReportStatus("Validate Export File",PASS,"File exported successfully with correct data")
						[ ] //verify the file exist in the system
						[+] if(FileExists(AUT_DATAFILE_PATH+"\"+sFileName+".QDF"))
							[+] if (QuickenWindow.Exists ())
								[ ] QuickenMainWindow.Kill()
								[ ] WaitForState(QuickenMainWindow,False,5)
								[ ] DeleteFile(AUT_DATAFILE_PATH+"\"+sFileName+".QDF")
							[ ] 
						[+] if(FileExists(sLocation))
								[ ] DeleteFile(sLocation)
					[+] else
						[ ] ReportStatus("Validate ExportFile",FAIL ,"Attributes details popup is not appeared on time")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Export File ", FAIL,"Import  popup window did not appear!to import file" )
			[+] else
				[ ] ReportStatus("Validate Export File ", FAIL,"Export popup window did not appear!" )
		[+] else
			[ ] ReportStatus("Validate Export File ", FAIL,"Required File is not Found" )
	[+] else
		[ ] QuickenMainWindow.Kill()
		[ ] WaitForState(QuickenMainWindow,False,5)
		[ ] ReportStatus("Validate Export File ", FAIL,"Quicken did not launched!" )
	[ ] 
[ ] 
[ ] //###########################################################
[+] //############# Validate Copy QDF File  ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_ValidateCopyQDFFile ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create copy of opend file  .
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while creating copy .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	14/04/2011  	Created By	Puja Verma
	[ ] //*********************************************************
[+] testcase Test07_ValidateCopyQDFFile() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sTabName="CopyFile"
		[ ] INTEGER i,iFileStatus,j,k
		[ ] STRING sLocation,sHandle,sActual
		[ ] BOOLEAN bMatch
		[ ] STRING sNetWorth="OVERALL TOTAL"
		[ ] STRING sChanged,NetWorthActual
		[ ] STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
		[ ] 
		[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5) == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] LaunchQuicken()
		[ ] //Fetch the record from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[+] if (!QuickenWindow.Exists (5))
				[ ] App_Start (sCmdLine)
				[ ] sleep(20)
			[ ] lsData=lsExcelData[i]
			[ ] //Open existing data file
			[ ] iFileStatus=OpenDataFile(lsData[1],lsData[2])
			[ ] sleep(15)
			[+] if(iFileStatus==PASS)
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
					[ ] CopyFile.RadioListNewcopy.Select("New copy")
					[ ] CopyFile.OK.Click()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] // Verify cpy extension in filename
					[ ] bCaption=MatchStr("*{lsData[1]+"Cpy"}*",sCaption)
					[+] if(bCaption==TRUE)
						[ ] ReportStatus("Validate Copy Operation",PASS,"File Copy Successfull with Cpy extension")
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
										[ ] 
										[ ] QuickenWindow.Kill()
										[ ] WaitForState(QuickenWindow,False,5)
										[ ] DeleteFile(sLocation)
										[ ] ReportStatus("Validate Copy Operation",PASS,"File Copy Successfull in required location")
										[ ] 
									[+] else
										[ ] ReportStatus("Validate Copy Operation",FAIL,"File did not creat Copy Successfull in required location")
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
							[ ] ReportStatus("Validate Copy Operation",FAIL,"File did not Copy Successfull with Cpy extension")
				[+] else
					[ ] ReportStatus("Valiade Copy File",FAIL,"Copy popup did not appear")
			[+] else
				[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Unable to open given data file!" )
				[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Copy QDF FIle", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################
[ ] // 
[ ] 
[+] //############# FileInputOutputCleanUp  ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 FileInputOutputCleanUp ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken, delete back up and new created file .
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while closing the window	and deleting the file .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	2/2/2011  	Created By	Puja Verma
	[ ] //*********************************************************
[+] testcase FileInputOutputCleanUp() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] INTEGER i
		[ ] STRING sLine
		[ ] STRING sFilePath=AUT_DATAFILE_PATH + "\" +"LoacationFile.txt"
		[ ] STRING sFilePath1=AUT_DATAFILE_PATH + "\" +"LoacationFile1.txt"
		[ ] HFILE FileHandle
		[ ] HFILE FileHandle1
	[ ] //Close the quicken if already exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.Exit.Select()
		[ ] sleep(5)
		[ ] WaitForState(QuickenWindow, false , 5)
	[ ] 
	[ ] //Read the data from list 
	[ ] FileHandle = FileOpen (sFilePath, FM_READ)
	[ ] FileHandle1 = FileOpen (sFilePath1, FM_READ)
	[+] while (FileReadLine (FileHandle, sLine))
		[ ] ListAppend(lscontent, sLine) 
	[ ] FileClose(FileHandle)
	[+] while (FileReadLine (FileHandle1, sLine))
		[ ] ListAppend(lscontent, sLine) 
	[ ] FileClose(FileHandle1)
	[ ] 
	[ ] // Delete one by one file from the system
	[+] for(i=1; i<=ListCount(lscontent);i++)
		[+] if(FileExists(lscontent[i]))
			[ ] DeleteFile(lscontent[i])
	[+] if(FileExists(sFilePath))
		[ ] DeleteFile(sFilePath)
	[+] if(FileExists(sFilePath1))
		[ ] DeleteFile(sFilePath1)
	[ ] // SYS_Execute("taskkill /f /im partner.exe")
[ ] //###########################################################
[ ] 
