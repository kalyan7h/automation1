[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<FileManagementVer2.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Bill Management test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  DEAN PAES
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 May 22, 2013	Dean Paes  Created
[ ] // *********************************************************
[ ] 
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[-] // Global variables 
	[ ] 
	[ ] //----------STRING-------------------
	[ ] public STRING sActual ,sDefaultPath ,sFilePath ,sHandle ,sExpectedFilePath , sExpectedCaption , sTempFile
	[ ] 
	[ ] public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] STRING sFileManagementExcelName = "File IO"
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] public STRING sDate=ModifyDate(0,sDateFormat)
	[ ] public STRING sMDIWindow="MDI"
	[ ] public STRING sFileManagementFileName="FileManagementDataFile"
	[ ] public STRING sFileManagementFilePath=AUT_DATAFILE_PATH+ "\File Management data"
	[ ] 
	[ ] //public STRING sNoBillsReadLine="You don't have any scheduled bills or deposits due for this account"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //---------LIST OF STRING-----------
	[ ] 
	[ ] 
	[ ] //---------LIST OF ANYTYPE-----------
	[ ] LIST OF ANYTYPE lsExcelData 
	[ ] 
	[ ] 
	[ ] //------------------INTEGER----------------
	[ ] public INTEGER iResult , iCount ,iCounter
	[ ] 
	[ ] public INTEGER iListCount
	[ ] 
	[ ] 
	[ ] //--------------BOOLEAN---------------
	[ ] public BOOLEAN bMatch 
	[ ] 
	[ ] 
	[ ] 
[+] //############# Verify UI for Quicken Backup Dialog Window ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_QDFFileBackup()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify UI for Quicken Backup Dialog Window
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while verifying UI for Quicken Backup Dialog Window				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/17 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_VerifyUIForQuickenBackupDialog() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sDefaultPath , sActualDefaultPath ,sActualCurrentDataFileNameText ,sActualCurrentDataFileNameValueText , sActualBackupFileNameText
		[ ] STRING sActualBackupFileNameValueText ,sExpectedCurrentDataFileNameValueText ,sExpectedBackupFileNameValueText
		[ ] STRING sExpectedCurrentDataFileNameText ,sExpectedBackupFileNameText
		[ ] sExpectedCurrentDataFileNameText ="Current data file name: "
		[ ] sExpectedBackupFileNameText ="Backup file name: "
		[ ] sDefaultPath ="C:\Users\" +USERNAME+ "\Desktop\" +sFileManagementFileName+".QDF-backup"
		[ ] sExpectedCurrentDataFileNameValueText =sFileManagementFileName + ".QDF"
		[ ] sExpectedBackupFileNameValueText =sFileManagementFileName + ".QDF-backup"
	[ ] 
	[ ] iResult=DataFileCreate(sFileManagementFileName ,sFileManagementFilePath)
	[ ] // iResult=PASS
	[-] if(iResult==PASS)
		[ ] ReportStatus("Create Data File", PASS ,"Data File: {sFileManagementFileName} created successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[+] if(QuickenBackup.Exists(10))
				[ ] QuickenBackup.SetActive()
				[ ] //// Verify default path location for Backup.
				[ ] sActualDefaultPath=QuickenBackup.BackupFile.BackupFileTextField.GetText()
				[+] if (sDefaultPath==sActualDefaultPath)
					[ ] ReportStatus("Verify default path location for Backup.", PASS , "Default path location for Backup is as expected: {sActualDefaultPath}")
				[+] else
					[ ] ReportStatus("Verify default path location for Backup.", FAIL , "Default path location for Backup actual: {sActualDefaultPath} is NOT as expected: {sDefaultPath}")
				[ ] //// Verify Current data file name: label
				[ ] sActualCurrentDataFileNameText=QuickenBackup.CurrentDataFileNameText.GetText()
				[+] if (sExpectedCurrentDataFileNameText==sActualCurrentDataFileNameText)
					[ ] ReportStatus("Verify Current data file name: label.", PASS , "Current data file name: label is as expected: {sExpectedCurrentDataFileNameText}")
				[+] else
					[ ] ReportStatus("Verify Current data file name: label.", FAIL , "Current data file name: label actual is: {sActualCurrentDataFileNameText} NOT as expected: {sExpectedCurrentDataFileNameText}")
				[ ] 
				[ ] //// Verify Current data file name: value
				[ ] sActual=QuickenBackup.CurrentDataFileNameValueText.GetText()
				[+] if (sActual==sExpectedCurrentDataFileNameValueText)
					[ ] ReportStatus("Verify Current data file name: value.", PASS , "Current data file name: value is as expected: {sExpectedCurrentDataFileNameValueText}")
				[+] else
					[ ] ReportStatus("Verify Current data file name: value.", FAIL , "Current data file name: value actual is: {sActual} NOT as expected: {sExpectedCurrentDataFileNameValueText}")
				[ ] 
				[ ] //// Verify Backup File Name t: label
				[ ] sActualBackupFileNameText=QuickenBackup.BackupFileNameText.GetText()
				[+] if (sExpectedBackupFileNameText==sActualBackupFileNameText)
					[ ] ReportStatus("Verify Backup file name: label.", PASS , "Backup file name: label is as expected: {sExpectedBackupFileNameText}")
				[+] else
					[ ] ReportStatus("Verify Backup file name: label.", FAIL , "Backup file name: label actual is: {sActualBackupFileNameText} NOT as expected: {sExpectedBackupFileNameText}")
				[ ] 
				[ ] //// Verify Current data file name: value
				[ ] sActual=QuickenBackup.BackupFileNameValueText.GetText()
				[+] if (sActual==sExpectedBackupFileNameValueText)
					[ ] ReportStatus("Verify Backup file name: Value.", PASS , "Backup file name: Value is as expected: {sActual}")
				[+] else
					[ ] ReportStatus("Verify Backup file name: Value.", FAIL , "Backup file name: Value actual is: {sActual} NOT as expected: {sExpectedBackupFileNameValueText}")
				[ ] 
				[ ] 
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.Cancel.Click()
			[+] else
				[ ] ReportStatus("Validate Backup and restore", FAIL,"QuickenBackup popup did not appear" )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[-] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be created.")
[ ] 
[+] //############# Verify Backup on My Computer Hard Drive at default path location ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_VerifyBackupOnMyComputerHardDriveAtdefaultPathLocation()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Backup on My Computer Hard Drive at default path location
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while taking Backup on My Computer Hard Drive at default path location				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/17 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_VerifyBackupOnMyComputerHardDriveAtDefaultPathLocation() appstate QuickenBaseState
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] sExpectedFilePath ="C:\Users\" +USERNAME+ "\Desktop\" +sFileManagementFileName+"-"+sDate+".QDF-backup"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sExpectedFilePath))
		[+] if (QuickenWindow.Exists(3))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,False,5)
		[ ] DeleteFile(sExpectedFilePath)
	[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[-] if(QuickenBackup.Exists(10))
				[ ] QuickenBackup.SetActive()
				[ ] //// Verify default path location for Backup.
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.AddDateToBackupFileName.Check()
				[ ] sDefaultPath=NULL
				[ ] sDefaultPath =QuickenBackup.BackupFile.BackupFileTextField.GetText()
				[-] if (sDefaultPath==sExpectedFilePath)
					[ ] ReportStatus("Verify default path location for Backup.", PASS , "Default path location for Backup is as expected: {sDefaultPath}")
					[ ] 
					[ ] QuickenBackup.BackUpNow.Click()
					[-] if(BackupConfirmation.Exists(10))
						[ ] BackupConfirmation.SetActive()
						[ ] BackupConfirmation.OK.Click()
						[ ] // Verify File exist in specific location with name and date
						[-] if(FileExists(sExpectedFilePath))
							[ ] ReportStatus("Verify Backup at default path location.", PASS,"Backup done properly at location: {sExpectedFilePath}" )
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.File.Click()
							[ ] QuickenWindow.File.OpenQuickenFile.Select()
							[-] if (ImportExportQuickenFile.Exists(10))
								[ ] ImportExportQuickenFile.SetActive()
								[ ] ImportExportQuickenFile.FileName.SetText(sExpectedFilePath)
								[ ] ImportExportQuickenFile.OK.Click()
								[-] if (QuickenRestore.Exists(10))
									[ ] QuickenRestore.SetActive()
									[ ] QuickenRestore.Cancel.Click()
									[ ] 
									[ ] 
									[ ] 
									[ ] ReportStatus("Verify Quicken will restore this backup file dialog", PASS,"Quicken will restore this backup file dialog appeared." )
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Quicken will restore this backup file dialog", FAIL,"Quicken will restore this backup file dialog didn't appear." )
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Open Quicken File", FAIL, "Open Quicken File dailog didn't appear.") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Backup at default path location.", FAIL,"Backup did not done properly at location: {sExpectedFilePath}" )
					[+] else
						[ ] ReportStatus("Validate Backup and restore", FAIL,"Confirmation popup did not appear" )
					[ ] 
				[+] else
					[ ] ReportStatus("Verify default path location for Backup.", FAIL , "Default path location for Backup actual: {sDefaultPath} is NOT as expected: {sExpectedFilePath}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken Backup dialog", FAIL,"QuickenBackup popup did not appear." )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
[ ] 
[ ] 
[ ] 
[+] //#############  Verify restore functionality by restoring data file from default location ###############################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test02A_VerifyRestoreFromMyComputerHardDriveAtDefaultPathLocation()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify restore backup from My Computer Hard Drive default path location
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying restore backup from My Computer Hard Drive default path location			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 02/03 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[-] testcase Test02A_VerifyRestoreFromMyComputerHardDriveAtDefaultPathLocation() appstate QuickenBaseState
	[-] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sTempFile ="DefaultRestoredTempFile"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] sExpectedFilePath ="C:\Users\" +USERNAME+ "\Desktop\" +sFileManagementFileName+"-"+sDate+".QDF-backup"
		[ ] 
	[ ] iResult=DataFileCreate(sTempFile , sFileManagementFilePath)
	[ ] // iResult=PASS
	[-] if(iResult==PASS)
		[ ] ReportStatus("Create Data File", PASS ,"Data File: {sTempFile} created successfully.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] // Verify File exist in specific location with name and date
			[+] if(FileExists(sExpectedFilePath))
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.BackupAndRestore.Click()
				[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
				[-] if (QuickenRestore.Exists(10))
					[ ] QuickenRestore.SetActive()
					[ ] QuickenRestore.RestoreFromBackupRadioList.Select(2)
					[ ] sleep(1)
					[-] if (QuickenRestore.Browse.IsEnabled())
						[ ] QuickenRestore.Browse.Click()
						[+] if (DlgRestoreQuickenFile.Exists(5))
							[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", PASS,"Restore Quicken File dialog appeared.")
							[ ] DlgRestoreQuickenFile.SetActive()
							[ ] DlgRestoreQuickenFile.FilesNameComboBox.SetText(sExpectedFilePath)
							[ ] DlgRestoreQuickenFile.OKButton.Click()
							[+] if (QuickenRestore.Exists(5))
								[ ] QuickenRestore.SetActive()
								[ ] QuickenRestore.RestoreBackup.Click()
								[ ] 
								[+] if (RestoreOpenFile.Exists(5))
									[ ] RestoreOpenFile.SetActive()
									[ ] RestoreOpenFile.RestoreBackup.Click()
									[ ] WaitForState(QuickenRestore , false ,2)
									[ ] 
								[-] if (QuickenRestore.Exists(5))
									[ ] QuickenRestore.SetActive()
									[ ] QuickenRestore.Yes.Click()
									[ ] sleep(2)
									[-] if(QuickenWindow.Exists(5))
										[ ] QuickenWindow.SetActive()
										[ ] sActual =QuickenWindow.GetCaption()
										[ ] bMatch = MatchStr( "*{sFileManagementFileName}*" ,sActual)
										[-] if (bMatch)
											[ ] ReportStatus("Verify restore functionality by restoring data file from default location", PASS ,"File :{sActual} has been restored fromthe default location." )
										[-] else
											[ ] ReportStatus("Verify restore functionality by restoring data file from default location", FAIL,"File :{sFileManagementFileName} couldn't be restored fromthe default location." )
									[-] else
										[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
								[-] else
									[-] ReportStatus("Verify the Open restored file dialog", FAIL,"Open restored file dialog didn't appear." )
									[ ] 
									[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
							[ ] 
						[+] else
							[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Restore Quicken File dialog didn't appear." )
						[ ] 
					[+] else
						[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Browse button is disabled on the Restore from backup file dialog" )
				[ ] 
				[+] else
					[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Backup did not done properly at location: {sExpectedFilePath}" )
				[ ] 
			[ ] 
		[-] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[-] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sTempFile} couldn't be created.")
[ ] 
[ ] 
[+] //############# Verify Backup on My Computer Hard Drive at different path location ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_VerifyBackupOnMyComputerHardDriveAtDifferentPathLocation()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Backup on My Computer Hard Drive at different path location
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while taking Backup on My Computer Hard Drive at different path location				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/17 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_VerifyBackupOnMyComputerHardDriveAtDifferentPathLocation() appstate QuickenBaseState
	[-] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] sExpectedFilePath =AUT_DATAFILE_PATH+"\" +sFileManagementFileName+"-"+sDate+".QDF-backup"
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\"+sFileManagementFileName +".QDF-backup"
		[ ] 
		[-] if(FileExists(sExpectedFilePath))
			[ ] DeleteFile(sExpectedFilePath)
		[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[ ] // iResult=PASS
	[-] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[-] if(QuickenBackup.Exists(10))
				[ ] QuickenBackup.SetActive()
				[ ] //// Verify default path location for Backup.
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.BackupFile.BackupFileTextField.SetText(sFilePath)
				[ ] QuickenBackup.AddDateToBackupFileName.Check()
				[ ] sDefaultPath=NULL
				[ ] sDefaultPath =QuickenBackup.BackupFile.BackupFileTextField.GetText()
				[-] if (sDefaultPath==sExpectedFilePath)
					[ ] ReportStatus("Verify different path location for Backup.", PASS , "Different path location for Backup is as expected: {sDefaultPath}")
					[ ] 
					[ ] QuickenBackup.BackUpNow.Click()
					[-] if(BackupConfirmation.Exists(10))
						[ ] BackupConfirmation.SetActive()
						[ ] BackupConfirmation.OK.Click()
						[ ] // Verify File exist in specific location with name and date
						[-] if(FileExists(sExpectedFilePath))
							[ ] ReportStatus("Verify Backup at default path location.", PASS,"Backup done properly at location: {sExpectedFilePath}" )
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.File.Click()
							[ ] QuickenWindow.File.OpenQuickenFile.Select()
							[-] if (ImportExportQuickenFile.Exists(10))
								[ ] ImportExportQuickenFile.SetActive()
								[ ] ImportExportQuickenFile.FileName.SetText(sExpectedFilePath)
								[ ] ImportExportQuickenFile.OK.Click()
								[-] if (QuickenRestore.Exists(10))
									[ ] QuickenRestore.SetActive()
									[ ] QuickenRestore.Cancel.Click()
									[ ] ReportStatus("Verify Quicken will restore this backup file dialog", PASS,"Quicken will restore this backup file dialog appeared." )
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Quicken will restore this backup file dialog", FAIL,"Quicken will restore this backup file dialog didn't appear." )
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Open Quicken File", FAIL, "Open Quicken File dailog didn't appear.") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Backup at default path location.", FAIL,"Backup did not done properly at location: {sExpectedFilePath}" )
					[+] else
						[ ] ReportStatus("Validate Backup and restore", FAIL,"Confirmation popup did not appear" )
					[ ] 
				[+] else
					[ ] ReportStatus("Verify different path location for Backup.", FAIL , "Different path location for Backup actual: {sDefaultPath} is NOT as expected: {sExpectedFilePath}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken Backup dialog", FAIL,"QuickenBackup popup did not appear." )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
[ ] 
[+] //############# Verify restore functionality by restoring data file from different location###############################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test03A_VerifyRestoreFromMyComputerHardDriveAtDifferentPathLocation()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify restore functionality by restoring data file from different location
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while Verifying restore functionality by restoring data file from different location			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/17 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[-] testcase Test03A_VerifyRestoreFromMyComputerHardDriveAtDifferentPathLocation() appstate QuickenBaseState
	[-] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath
		[ ] 
		[ ]   sTempFile ="DefaultRestoredTempFile"
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ] 
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] sExpectedFilePath =AUT_DATAFILE_PATH+"\" +sFileManagementFileName+"-"+sDate+".QDF-backup"
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\"+sFileManagementFileName +".QDF-backup"
	[ ] 
	[ ] iResult=DataFileCreate(sTempFile , sFileManagementFilePath)
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Create Data File", PASS ,"Data File: {sTempFile} careted successfully.")
		[-] if(QuickenWindow.Exists(5))
			[ ] // Verify File exist in specific location with name and date
			[-] if(FileExists(sExpectedFilePath))
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.BackupAndRestore.Click()
				[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
				[-] if (QuickenRestore.Exists(10))
					[ ] QuickenRestore.SetActive()
					[ ] QuickenRestore.RestoreFromBackupRadioList.Select(2)
					[ ] sleep(1)
					[-] if (QuickenRestore.Browse.IsEnabled())
						[ ] QuickenRestore.Browse.Click()
						[-] if (DlgRestoreQuickenFile.Exists(5))
							[ ] 
							[ ] DlgRestoreQuickenFile.SetActive()
							[ ] DlgRestoreQuickenFile.FilesNameComboBox.SetText(sExpectedFilePath)
							[ ] DlgRestoreQuickenFile.OKButton.Click()
							[-] if (QuickenRestore.Exists(5))
								[ ] QuickenRestore.SetActive()
								[ ] QuickenRestore.RestoreBackup.Click()
								[ ] 
								[+] if (RestoreOpenFile.Exists(5))
									[ ] RestoreOpenFile.SetActive()
									[ ] RestoreOpenFile.RestoreBackup.Click()
									[ ] WaitForState(QuickenRestore , false ,2)
									[ ] 
								[-] if (QuickenRestore.Exists(5))
									[ ] QuickenRestore.SetActive()
									[ ] QuickenRestore.Yes.Click()
									[ ] sleep(2)
									[-] if(QuickenWindow.Exists(5))
										[ ] QuickenWindow.SetActive()
										[ ] sActual =QuickenWindow.GetCaption()
										[ ] bMatch = MatchStr( "*{sFileManagementFileName}*" ,sActual)
										[-] if (bMatch)
											[ ] ReportStatus("Verify restore functionality by restoring data file from different location", PASS ,"File :{sActual} has been restored from the different location." )
										[-] else
											[ ] ReportStatus("Verify restore functionality by restoring data file from different location", FAIL,"File :{sFileManagementFileName} couldn't be restored from the different location." )
									[-] else
										[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
								[-] else
									[ ] ReportStatus("Verify the Open restored file dialog", FAIL,"Open restored file dialog didn't appear." )
									[ ] 
									[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
							[ ] 
						[+] else
							[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Restore Quicken File dialog didn't appear." )
						[ ] 
					[+] else
						[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Browse button is disabled on the Restore from backup file dialog" )
				[ ] 
				[+] else
					[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Backup did not done properly at location: {sExpectedFilePath}" )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[-] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sTempFile} couldn't be careted.")
[ ] 
[+] //############# Verify UI for Quicken Restore Dialog Window ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_VerifyUIForRestoreDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify UI for Quicken Restore Dialog Window
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying UI for Quicken Restore Dialog Window				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/20 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[-] testcase Test04_VerifyUIForRestoreDialog() appstate QuickenBaseState
		[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sBackup=".QDF-backup"
		[ ]  sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
	[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
			[+] if (QuickenRestore.Exists(10))
				[ ] QuickenRestore.SetActive()
				[ ] ReportStatus("Verify Quicken will restore this backup file dialog", PASS,"Quicken will restore this backup file dialog appeared." )
				[ ] 
				[ ] //Verify Restore from automatic backups radio button
				[+] if (QuickenRestore.RestoreFromBackupFile.Exists(2))
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Restore from automatic backups radio button exists.")
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Restore from automatic backups radio button doesn't exist.")
				[ ] 
				[ ] //Verify Restore from your backup radio button
				[+] if (QuickenRestore.RestoreFromBackupRadioList.Exists(2))
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Restore From Backup radio button exists.")
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Restore From Backup radio button doesn't exist.")
				[ ] 
				[ ] //Verify Restore from online backup radio button
				[+] if (QuickenRestore.RestoreFromOnlineBackupRadioList.Exists(2))
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Restore from online backup radio button exists.")
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Restore from online backup radio button doesn't exist.")
				[ ] 
				[ ] //Verify Learn more button
				[+] if (QuickenRestore.RequiresQuickenOnlineBackup.Exists(2))
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Learn more button exists.")
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Learn more button doesn't exist.")
				[ ] 
				[ ] //Verify Help button
				[+] if (QuickenRestore.HelpButton.Exists(2))
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Help button exists.")
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Help button doesn't exist.")
				[ ] 
				[ ] //Verify Browse button
				[+] if (QuickenRestore.Browse.Exists(2))
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Browse button exists.")
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Browse button doesn't exist.")
				[ ] 
				[ ] //Verify Restore Backup button
				[+] if (QuickenRestore.RestoreBackup.Exists(2))
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Restore Backup button exists.")
					[+] if (!QuickenRestore.RestoreBackup.IsEnabled())
						[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Restore Backup button is didsabled.")
					[+] else
						[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Restore Backup button is enabled.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Restore Backup button doesn't exist.")
				[ ] 
				[ ] //Verify Cancel button
				[+] if (QuickenRestore.Cancel.Exists(2))
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Cancel button exists.")
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Cancel button doesn't exist.")
				[ ] 
				[ ] //Verify Open Backup Directory button
				[+] if (QuickenRestore.OpenBackupDirectoryButton.Exists(2))
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Open Backup Directory button exists.")
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Open Backup Directory button doesn't exist.")
				[ ] 
				[ ] 
				[ ] //Verify Select Files listbox displays all backup files located in the “backup” directory for the currently open Quicken file.
				[ ] //For this verification point the backup shaould have been taken in the previous scripts
				[ ] sHandle = Str(QuickenRestore.ListBox1.GetHandle ())
				[ ] iListCount=QuickenRestore.ListBox1.GetItemCount() +1
				[+] for( iCounter=0;iCounter< iListCount ;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sFileManagementFileName}*{sDate}*{sBackup}*", sActual)
					[+] if ( bMatch)
						[ ] break
				[+] if(bMatch)
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", PASS , "Select Files listbox displays all backup file as expected: {sActual}")
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Select Files listbox doesn't display thebackup file as expected: {sFileManagementFileName}{sDate}{sBackup} the file displayed is: {sActual}")
				[ ] 
				[ ] //close the QuickenRestore dialog
				[ ] QuickenRestore.SetActive()
				[ ] QuickenRestore.Cancel.Click()
				[ ] WaitForState(QuickenRestore , False ,2)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify UI for Quicken Restore Dialog", FAIL,"Quicken will restore this backup file dialog didn't appear." )
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
[ ] 
[ ] 
[+] //############# Verify the Functionality of available buttons for Restore backup screen.###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_VerifytheFunctionalityOfAvailableButtonsForRestoreBackup()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the Functionality of available buttons for Restore backup screen.
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying functionality of available buttons for Restore backup screen			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/21 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_VerifytheFunctionalityOfAvailableButtonsForRestoreBackup() appstate QuickenBaseState
		[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedBackupFileType
		[ ]  sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] sExpectedBackupFileType ="Quicken Backup Files (*.QDF;*.QDF-Backup)"
		[ ] sExpectedFilePath =AUT_DATAFILE_PATH+"\File Management data\" +sFileManagementFileName+"-"+sDate
		[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
			[+] if (QuickenRestore.Exists(10))
				[ ] QuickenRestore.SetActive()
				[ ] 
				[ ] 
				[+] if (QuickenRestore.RestoreFromBackupRadioList.Exists(2))
					[ ] QuickenRestore.RestoreFromBackupRadioList.Select(2)
					[ ] QuickenRestore.Browse.Click()
					[ ] 
					[ ] //Verify Backup File Type on the Restore Quicken File dialog
					[+] if (DlgRestoreQuickenFile.Exists(2))
						[ ] DlgRestoreQuickenFile.SetActive()
						[ ] sActual=DlgRestoreQuickenFile.FilesOfTypeComboBox.GetSelectedItem()
						[+] if (sActual==sExpectedBackupFileType)
							[ ] ReportStatus("Verify the Functionality of available buttons for Restore backup screen", PASS ,"Backup File Type on the Restore Quicken File is as expected: {sExpectedBackupFileType}")
							[ ] 
							[ ] //Verify the functionality of the Restore button
							[ ] DlgRestoreQuickenFile.FilesNameComboBox.SetText(sExpectedFilePath)
							[ ] DlgRestoreQuickenFile.OKButton.DoubleClick()
							[ ] WaitForState(DlgRestoreQuickenFile , false ,2)
							[ ] QuickenRestore.SetActive()
							[+] if (QuickenRestore.RestoreBackup.IsEnabled())
								[ ] ReportStatus("Verify the Functionality of available buttons for Restore backup screen", PASS ,"Restore Backup button became enabled after selecting a backup file.")
							[+] else
								[ ] ReportStatus("Verify the Functionality of available buttons for Restore backup screen", FAIL ,"Restore Backup button didn't become enabled after selecting a backup file.")
							[ ] 
							[ ] //close the QuickenRestore dialog
							[ ] QuickenRestore.SetActive()
							[ ] QuickenRestore.Cancel.Click()
							[ ] WaitForState(QuickenRestore , False ,2)
							[ ] 
							[+] if (!QuickenRestore.Exists(5))
								[ ] ReportStatus("Verify the Functionality of available buttons for Restore backup screen", PASS ,"Restore from backup file dialog disappeared after clicking Cancel button")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify the Functionality of available buttons for Restore backup screen", FAIL ,"Restore from backup file dialog didn't disappear after clicking Cancel button")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify the Functionality of available buttons for Restore backup screen", FAIL ,"Backup File Type on the Restore Quicken File actual: {sActual} is NOT  as expected: {sExpectedBackupFileType}")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Restore Quicken File dialog. ", FAIL , "Restore Quicken File dialog didn't appear.") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Quicken will restore this backup file dialog.", FAIL , "Restore From Backup radio button doesn't exist.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify UI for Quicken Restore Dialog", FAIL,"Quicken will restore this backup file dialog didn't appear." )
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
[ ] 
[+] //############# Verfiy the Open Backup directory button for newly created data file.###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05A_VerfiyTheOpenBackupDirectoryButtonForNewlyCreatedDataFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the Functionality of Open Backup directory button for newly created data file
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying functionality of Open Backup directory button for newly created data file	
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/21 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05A_VerfiyTheOpenBackupDirectoryButtonForNewlyCreatedDataFile() appstate QuickenBaseState
		[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sExpectedBackupFileType , sBackUpDir
		[ ] sTempFile ="TempFile"
		[ ] sBackUpDir =AUT_DATAFILE_PATH+"\BackUp" 
		[ ] sExpectedCaption="The backup directory has not been created yet. It will be created when the file is backed up automatically the first time."
	[ ] 
	[ ] DeleteDir(sBackUpDir)
	[ ] 
	[ ] iResult=DataFileCreate(sTempFile ,sFileManagementFilePath)
	[ ] 
	[-] if(iResult==PASS)
		[ ] ReportStatus("Create Data File", PASS ,"Data File: {sTempFile} created successfully.")
		[ ] 
		[+] if(QuickenWindow.Exists(5))
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
			[ ] ////Verfiy the Open Backup directory button for newly created data file
			[-] if (QuickenRestore.Exists(10))
				[ ] QuickenRestore.SetActive()
				[ ] QuickenRestore.OpenBackupDirectoryButton.Click()
				[+] if (AlertMessage.Exists(5))
					[ ] AlertMessage.SetActive()
					[ ] sActual =AlertMessage.MessageText.GetText()
					[ ] AlertMessage.OK.Click()
					[+] if (sActual==sExpectedCaption)
						[ ] ReportStatus("Verfiy the Open Backup directory button for newly created data file", PASS,"Clicking Open Backup directory button for newly created data file displayed expected message: {sExpectedCaption}." )
					[+] else
						[ ] ReportStatus("Verfiy the Open Backup directory button for newly created data file", FAIL,"Clicking Open Backup directory button for newly created data file didn't display the expected message: {sExpectedCaption} , the actual message is: {sActual}." )
					[ ] 
				[+] else
					[ ] ReportStatus("Verfiy the Open Backup directory button for newly created data file", FAIL,"Alert Message didn't appear." )
			[+] else
				[ ] ReportStatus("Verfiy the Open Backup directory button for newly created data file", FAIL,"Quicken will restore this backup file dialog didn't appear." )
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sTempFile} couldn't be created.")
[ ] 
[+] //############# Verify the restore functionality by "Restoring Currently Open File".###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_VerifyTheRestoreFunctionalityByRestoringCurrentlyOpenFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the restore functionality by "Restoring Currently Open File"
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while restore functionality by "Restoring Currently Open File"
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/21 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[-] testcase Test06_VerifyTheRestoreFunctionalityByRestoringCurrentlyOpenFile() appstate QuickenBaseState
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath ,sTempFile
		[ ] STRING sBackup=".QDF-backup"
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] sTempFile ="TempFile"
		[ ] 
		[ ] sExpectedFilePath =AUT_DATAFILE_PATH+"\File Management data\" +sFileManagementFileName+"-"+sDate+".QDF-backup"
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\File Management data\"+sFileManagementFileName +".QDF-backup"
	[ ] 
	[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[ ] // iResult=PASS
	[-] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[-] if(QuickenBackup.Exists(10))
				[ ] QuickenBackup.SetActive()
				[ ] //// Verify default path location for Backup.
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.BackupFile.BackupFileTextField.SetText(sFilePath)
				[ ] QuickenBackup.AddDateToBackupFileName.Check()
				[ ] QuickenBackup.BackUpNow.Click()
				[+] if(DuplicateBackupFile.Exists(5))
					[ ] DuplicateBackupFile.SetActive()
					[ ] DuplicateBackupFile.Yes.Click()
				[ ] 
				[-] if(BackupConfirmation.Exists(10))
					[ ] BackupConfirmation.SetActive()
					[ ] BackupConfirmation.OK.Click()
					[ ] // Verify File exist in specific location with name and date
					[ ] 
					[ ] 
					[-] if(FileExists(sExpectedFilePath))
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.File.Click()
						[ ] QuickenWindow.File.BackupAndRestore.Click()
						[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
						[-] if (QuickenRestore.Exists(10))
							[ ] QuickenRestore.SetActive()
							[ ] sHandle = Str(QuickenRestore.ListBox1.GetHandle ())
							[ ] iListCount=QuickenRestore.ListBox1.GetItemCount() +1
							[-] for( iCounter=0;iCounter< iListCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
								[ ] bMatch = MatchStr("*{sFileManagementFileName}*", sActual)
								[-] if ( bMatch)
									[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,  "{iCounter}")
									[ ] break
							[-] if(bMatch)
								[ ] 
								[ ] QuickenRestore.RestoreBackup.Click()
								[+] if (RestoreOpenFile.Exists(10))
									[ ] RestoreOpenFile.SetActive()
									[ ] // Verify FileName on the Restore from backup file
									[ ] sActual = RestoreOpenFile.FileNameText.GetText()
									[ ] bMatch =MatchStr("*{sFileManagementFileName}*{sBackup}*", sActual)
									[+] if(bMatch)
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", PASS," File name:{sActual} appeared as expected on Restore from backup file dialog." )
									[+] else
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL," File name:{sActual} didn't appear as expected on Restore from backup file dialog." )
									[ ] 
									[ ] 
									[ ] 
									[ ] //Verify Overwrite the open file with restored file radio button
									[+] if (RestoreOpenFile.OverwriteTheOpenFileWithRestoredFileRadioList.Exists(2))
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", PASS , "Overwrite the open file with restored file radio button exists on  Restore from backup file dialog.")
									[+] else
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", FAIL , "Overwrite the open file with restored file radio button doesn't exist on  Restore from backup file dialog.")
										[ ] 
									[ ] 
									[ ] //Verify Create a copy radio button
									[+] if (RestoreOpenFile.CreateACopyRadioList.Exists(2))
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", PASS , "Create a copy radio button exists on Restore from backup file dialog.")
									[+] else
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", FAIL , "Create a copy radio button doesn't exist on  Restore from backup file dialog.")
										[ ] 
									[ ] 
									[ ] //Verify Restore Backup button
									[+] if (RestoreOpenFile.RestoreBackup.Exists(2))
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", PASS , "Restore Backup button exists on Restore from backup file dialog.")
									[+] else
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", FAIL , "Restore Backup radio button doesn't exist on  Restore from backup file dialog.")
										[ ] 
									[ ] //Verify Cancel button
									[+] if (RestoreOpenFile.Cancel.Exists(2))
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", PASS , "Cancel button exists on Restore from backup file dialog.")
									[+] else
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", FAIL , "Cancel button doesn't exist on  Restore from backup file dialog.")
										[ ] 
									[ ] 
									[ ] 
									[ ] //Verify Copy Quicken File Backup restore
									[ ] RestoreOpenFile.SetActive()
									[ ] RestoreOpenFile.CreateaCopy.Select(2)
									[ ] RestoreOpenFile.RestoreBackup.Click()
									[+] if (CopyQuickenFileBrowser.Exists(5))
										[ ] CopyQuickenFileBrowser.SetActive()
										[ ] CopyQuickenFileBrowser.FileNameComboBox.SetText(sTempFile)
										[ ] CopyQuickenFileBrowser.OK.Click()
										[+] if (QuickenRestore.Exists(10))
											[ ] QuickenRestore.SetActive()
											[ ] QuickenRestore.No.Click()
											[ ] WaitForState(QuickenRestore , False ,2)
											[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", PASS , "Restore from backup file confirmation dialog appeared." )
										[+] else
											[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Restore from backup file confirmation dialog didn't appear." )
									[+] else
										[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Copy Quicken File dialog didn't appear." )
									[ ] 
								[+] else
									[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Restore from backup file dialog didn't appear." )
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", FAIL , "Select Files listbox doesn't display thebackup file as expected: {sFileManagementFileName}{sDate}{sBackup} the file displayed is: {sActual}")
						[ ] 
						[+] else
							[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File.", FAIL,"Backup did not done properly at location: {sExpectedFilePath}" )
				[+] else
					[ ] ReportStatus("Validate Backup and restore", FAIL,"Confirmation popup did not appear" )
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken Backup dialog", FAIL,"QuickenBackup popup did not appear." )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
		[ ] 
[ ] 
[+] //############# Verify newly added "Save a copy as…" and "Show this file on my computer" menu option from Classic menu.###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_VerifySaveACopyAsMenuOptionFromClassicMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify "Save a copy as…"  menu option from Classic menu
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying "Save a copy as…"  menu option from Classic menu
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/25 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_VerifySaveACopyAsMenuOptionFromClassicMenu() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath ,sTempFile
		[ ] STRING sBackup=".QDF-backup"
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] sTempFile ="Copy of " +sFileManagementFileName
		[ ] 
		[ ] sExpectedFilePath =NULL
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\File Management data\"+sTempFile +".QDF"
	[ ] 
	[+] if(FileExists(sFilePath))
		[ ] DeleteFile(sFilePath)
		[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[ ] 
		[ ] ////Verify "Save a copy as…"  menu option from Classic menu
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.SaveACopyAs.Select()
			[ ] 
			[+] if(CopyQuickenFileBrowser.Exists(10))
				[ ] CopyQuickenFileBrowser.SetActive()
				[ ] CopyQuickenFileBrowser.FileNameComboBox.SetText(sFilePath)
				[ ] CopyQuickenFileBrowser.OK.Click()
				[ ] WaitForState(CopyQuickenFileBrowser , False ,2)
				[ ] 
				[ ] ReportStatus("Verify Save a copy as menu option from Classic menu", PASS,"Copy Quicken File dialog appeared." )
				[ ] 
				[+] if (DlgRestoreFromCopiedFile.Exists(5))
					[ ] DlgRestoreFromCopiedFile.SetActive()
					[ ] DlgRestoreFromCopiedFile.NoButton.Click()
					[ ] WaitForState(DlgRestoreFromCopiedFile , False ,2)
					[ ] 
					[+] if(FileExists(sFilePath))
						[ ] ReportStatus("Verify Save a copy as menu option from Classic menu.", PASS,"Copy of the file: {sFileManagementFileName} has been saved at: {sFilePath}" )
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Save a copy as menu option from Classic menu.", FAIL,"Copy of the file: {sFileManagementFileName} couldn't be saved at: {sFilePath}" )
				[+] else
					[ ] ReportStatus("Verify Save a copy as menu option from Classic menu", FAIL,"Restore from copied file dialog did not appear." )
			[+] else
				[ ] ReportStatus("Verify Save a copy as menu option from Classic menu", FAIL,"Copy Quicken File dialog did not appear." )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
		[ ] 
[ ] 
[ ] 
[+] //############# Verify restore functionality by Restoring Existing File with overwrite option ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08A_VerifyRestoreFunctionalityByRestoringExistingFileWithOverwriteOption()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify restore functionality by Restoring Existing File with overwrite option
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying restore functionality by Restoring Existing File with overwrite option
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/25 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08A_VerifyRestoreFunctionalityByRestoringExistingFileWithOverwriteOption() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sAccountName , sAccountBalance
		[ ] sAccountBalance ="9,871"
		[ ] sAccountName ="Checking 01 Account"
		[ ] sTempFile ="Register-2014-01-23.PM12.16Overwrite"
		[ ] 
		[ ] sExpectedFilePath =NULL
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\File Management data\BACKUP\"+sTempFile +".QDF-backup"
		[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[ ] // iResult=PASS
	[-] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] // Verify File exist in specific location with name and date
			[ ] 
			[ ] 
			[-] if(FileExists(sFilePath))
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.BackupAndRestore.Click()
				[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
				[-] if (QuickenRestore.Exists(10))
					[ ] QuickenRestore.SetActive()
					[ ] QuickenRestore.RestoreFromBackupRadioList.Select(2)
					[ ] sleep(1)
					[-] if (QuickenRestore.Browse.IsEnabled())
						[ ] QuickenRestore.Browse.Click()
						[+] if (DlgRestoreQuickenFile.Exists(5))
							[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", PASS,"Restore Quicken File dialog appeared.")
							[ ] DlgRestoreQuickenFile.SetActive()
							[ ] DlgRestoreQuickenFile.FilesNameComboBox.SetText(sFilePath)
							[ ] DlgRestoreQuickenFile.OKButton.Click()
							[+] if (QuickenRestore.Exists(10))
								[ ] QuickenRestore.SetActive()
								[ ] QuickenRestore.RestoreBackup.Click()
								[+] if (RestoreOpenFile.Exists(5))
									[ ] RestoreOpenFile.SetActive()
									[ ] RestoreOpenFile.OverwriteTheOpenFileWithRestoredFileRadioList.Select(1)
									[ ] RestoreOpenFile.RestoreBackup.Click()
									[ ] 
									[+] if (QuickenRestore.Exists(10))
										[ ] QuickenRestore.SetActive()
										[ ] QuickenRestore.Yes.Click()
										[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", PASS,"Restore from backup file dialog appeared." )
										[ ] 
										[ ] sleep(5)
										[ ] ////Verify the data in the restored file
										[ ] QuickenWindow.SetActive()
										[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
										[ ] iListCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()
										[+] for( iCounter=0;iCounter< iListCount ;++iCounter)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
											[ ] bMatch = MatchStr("*{sAccountName}*{sAccountBalance}*", sActual)
											[+] if (bMatch)
												[ ] break
										[ ] 
										[+] if (bMatch)
											[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", PASS,"File with account: {sAccountName} and account balance: {sAccountBalance} restored successfully." )
											[ ] 
										[+] else
											[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Account: {sAccountName} and account balance: {sAccountBalance} in the restored file didn't match with actual:{sActual}" )
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Restore from backup file confirmation dialog didn't appear." )
								[+] else
									[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Restore from backup file dialog didn't appear" )
							[+] else
								[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
							[ ] 
						[+] else
							[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Restore Quicken File dialog didn't appear." )
						[ ] 
					[+] else
						[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Browse button is disabled on the Restore from backup file dialog" )
				[ ] 
				[+] else
					[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Backup did not done properly at location: {sExpectedFilePath}" )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
		[ ] 
[ ] 
[+] //############# Verify restore functionality by Restoring Existing File with Copy option ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08B_VerifyRestoreFunctionalityByRestoringExistingFileWithCopyOption()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify restore functionality by Restoring Existing File with Copy option
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying restore functionality by Restoring Existing File with Copy option
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 01/25 2014		Mukesh created	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08B_VerifyRestoreFunctionalityByRestoringExistingFileWithCopyOption() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sAccountName , sAccountBalance ,sBackupCopyFile ,sBackupCopyFilePath
		[ ] sAccountBalance ="9,871"
		[ ] sAccountName ="Checking 01 Account"
		[ ] sTempFile ="Register-2014-01-23.PM12.16Copy"
		[ ] 
		[ ] sBackupCopyFile= "sBackupCopyFile"
		[ ] 
		[ ] sBackupCopyFilePath =AUT_DATAFILE_PATH+ "\File Management data\" +sBackupCopyFile
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\File Management data\BACKUP\"+sTempFile +".QDF-backup"
		[ ] 
		[ ] 
	[ ] //Delete the copy file if exists
	[+] if(FileExists(sBackupCopyFilePath))
		[ ] DeleteFile(sBackupCopyFilePath)
		[ ] 
	[ ] 
	[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] // Verify File exist in specific location with name and date
			[ ] 
			[ ] 
			[+] if(FileExists(sFilePath))
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.BackupAndRestore.Click()
				[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
				[+] if (QuickenRestore.Exists(10))
					[ ] QuickenRestore.SetActive()
					[ ] QuickenRestore.RestoreFromBackupRadioList.Select(2)
					[ ] sleep(1)
					[+] if (QuickenRestore.Browse.IsEnabled())
						[ ] QuickenRestore.Browse.Click()
						[+] if (DlgRestoreQuickenFile.Exists(5))
							[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", PASS,"Restore Quicken File dialog appeared.")
							[ ] DlgRestoreQuickenFile.SetActive()
							[ ] DlgRestoreQuickenFile.FilesNameComboBox.SetText(sFilePath)
							[ ] DlgRestoreQuickenFile.OKButton.Click()
							[+] if (QuickenRestore.Exists(10))
								[ ] QuickenRestore.SetActive()
								[ ] QuickenRestore.RestoreBackup.Click()
								[+] if (RestoreOpenFile.Exists(5))
									[ ] RestoreOpenFile.SetActive()
									[ ] RestoreOpenFile.CreateACopyRadioList.Select(2)
									[ ] RestoreOpenFile.RestoreBackup.Click()
									[+] if(CopyQuickenFileBrowser.Exists(10))
										[ ] CopyQuickenFileBrowser.FileNameComboBox.SetText(sBackupCopyFilePath)
										[ ] CopyQuickenFileBrowser.OK.Click()
										[ ] WaitForState(CopyQuickenFileBrowser , False ,2)
										[ ] 
										[+] if (QuickenRestore.Exists(10))
											[ ] QuickenRestore.SetActive()
											[ ] QuickenRestore.Yes.Click()
											[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", PASS,"Restore from backup file dialog appeared." )
											[ ] 
											[ ] sleep(5)
											[ ] ////Verify the data in the restored file
											[ ] QuickenWindow.SetActive()
											[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
											[ ] iListCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()
											[+] for( iCounter=0;iCounter< iListCount ;++iCounter)
												[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
												[ ] bMatch = MatchStr("*{sAccountName}*{sAccountBalance}*", sActual)
												[+] if (bMatch)
													[ ] break
											[ ] 
											[+] if (bMatch)
												[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", PASS,"File with account: {sAccountName} and account balance: {sAccountBalance} restored successfully." )
												[ ] 
											[+] else
												[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", FAIL,"Account: {sAccountName} and account balance: {sAccountBalance} in the restored file didn't match with actual:{sActual}" )
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", FAIL,"Restore from backup file confirmation dialog didn't appear." )
									[+] else
										[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option", FAIL,"Copy Quicekn File dialog did not appear." )
									[ ] 
								[+] else
									[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", FAIL,"Restore from backup file dialog didn't appear" )
							[+] else
								[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
							[ ] 
						[+] else
							[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", FAIL,"Restore Quicken File dialog didn't appear." )
						[ ] 
					[+] else
						[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", FAIL,"Browse button is disabled on the Restore from backup file dialog" )
				[ ] 
				[+] else
					[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", FAIL,"Backup did not done properly at location: {sExpectedFilePath}" )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
		[ ] 
[ ] 
[ ] 
[ ] 
