[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<FileManagement.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all File Management test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  Mukesh Mishra
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Jan 22, 2014	Mukesh Mishra  Created
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
	[ ] public STRING sActual ,sExpected, sDefaultPath ,sFilePath ,sHandle ,sExpectedFilePath , sExpectedCaption , sTempFile,sCaption,sFileName
	[ ] 
	[ ] STRING sFileManagementExcelName = "File IO"
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] public STRING sDate=ModifyDate(0,sDateFormat)
	[ ] public STRING sMDIWindow="MDI"
	[ ] public STRING sFileManagementFileName="FileManagementDataFile"
	[ ] public STRING sFileManagementFilePath=AUT_DATAFILE_PATH+ "\File Management data"
	[ ] public STRING sFileIOFilePath=AUT_DATAFILE_PATH+ "\FileIO\"
	[ ] 
	[ ] //public STRING sNoBillsReadLine="You don't have any scheduled bills or deposits due for this account"
	[ ] 
	[ ] STRING sExcelName = "File IO"
	[ ] STRING sFileWorksheet = "_File"
	[ ] 
	[ ] //---------LIST OF STRING-----------
	[ ] 
	[ ] 
	[ ] //---------LIST OF ANYTYPE-----------
	[ ] LIST OF ANYTYPE lsExcelData,lsTestData
	[ ] 
	[ ] 
	[ ] //------------------INTEGER----------------
	[ ] public INTEGER iResult , iCount ,iCounter,i
	[ ] 
	[ ] public INTEGER iListCount,iValidate,iNavigate
	[ ] 
	[ ] 
	[ ] //--------------BOOLEAN---------------
	[ ] public BOOLEAN bCaption,bStatus
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] public INTEGER QuickenRestoreNavigation(STRING sFilePath optional, STRING sFileName optional)
	[+] // Variable declaration
		[ ] STRING sActual
		[ ] INTEGER iFunctionResult
		[ ] BOOLEAN bMatch
	[ ] 
	[+] do
		[ ] 
		[ ] // Activate Quicken window
		[ ] QuickenWindow.SetActive()
		[ ] // Navigate to File > Backup and Restore > Restore from Backup file
		[ ] QuickenWindow.MainMenu.Select("/_File/_Backup and Restore/_Restore from Backup File...")
		[ ] 
		[+] if(QuickenRestore.Exists(5))
			[ ] 
			[ ] QuickenRestore.SetActive()
			[ ] // Select option: Restore from your backup
			[ ] QuickenRestore.RestoreFromBackupFile.Select(2)
			[+] if(sFilePath!=NULL && sFileName!=NULL)
				[ ] // Select option: Restore from your backup
				[ ] QuickenRestore.RestoreFromBackupFile.Select(2)
				[ ] 
				[ ] // Enter Backup file path and file name
				[ ] QuickenRestore.BackupFilePath.SetText(sFilePath + sFileName + ".QDF-backup" )
				[ ] // Click on RestoreBackup button
				[ ] QuickenRestore.RestoreBackup.Click()
			[ ] 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] iFunctionResult = FAIL
			[ ] ReportStatus("Verification of Quicken Restore Window", FAIL, "'Restore from backup file' window is not found")
			[ ] 
		[ ] 
		[ ] 
	[+] except
		[+] if(QuickenRestore.Exists(SHORT_SLEEP))
			[ ] QuickenRestore.Close()
		[ ] iFunctionResult = FAIL
	[ ] return iFunctionResult
	[ ] 
[ ] 
[+] public INTEGER QuickenBackupNavigation()
	[+] // Variable declaration
		[ ] INTEGER iFunctionResult
	[ ] 
	[+] do
		[ ] 
		[ ] // Activate Quicken window
		[ ] QuickenWindow.SetActive()
		[+] do
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[ ] 
		[+] except
			[ ] QuickenWindow.TypeKeys("<Ctrl-b>")
		[ ] 
		[+] if(QuickenBackup.Exists(2))
			[ ] QuickenBackup.SetActive()
			[ ] iFunctionResult = PASS
		[+] else
			[ ] iFunctionResult = FAIL
			[ ] ReportStatus("Verification of Quicken Backup Window", FAIL, "'Quicken Backup' window is not found")
			[ ] 
		[ ] 
		[ ] 
	[+] except
		[ ] ExceptData()
		[ ] iFunctionResult = FAIL
	[ ] return iFunctionResult
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# Verify UI for Quicken Backup Dialog Window ################################################
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
[+] testcase Test01_VerifyUIForQuickenBackupDialog() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sDefaultPath , sActualDefaultPath ,sActualCurrentDataFileNameText ,sActualCurrentDataFileNameValueText , sActualBackupFileNameText
		[ ] STRING sActualBackupFileNameValueText ,sExpectedCurrentDataFileNameValueText ,sExpectedBackupFileNameValueText
		[ ] STRING sExpectedCurrentDataFileNameText ,sExpectedBackupFileNameText
		[ ] sExpectedCurrentDataFileNameText ="Current data file name: "
		[ ] sExpectedBackupFileNameText ="Backup file name: "
		[ ]  STRING USERNAME="udita_dube"
		[ ] 
		[ ] sDefaultPath ="C:\Users\" +USERNAME+ "\Desktop\" +sFileManagementFileName+".QDF-backup"
		[ ] sExpectedCurrentDataFileNameValueText =sFileManagementFileName + ".QDF"
		[ ] sExpectedBackupFileNameValueText =sFileManagementFileName + ".QDF-backup"
		[ ] sCaption="Quicken Backup"
		[ ] 
	[ ] 
	[+] if(FileExists(sDefaultPath))
		[+] if(QuickenWindow.Exists(2))
			[ ] QuickenWindow.Kill()
		[ ] DeleteFile(sDefaultPath)
		[ ] sleep(2)
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow,TRUE,5)
	[ ] 
	[ ] iResult=DataFileCreate(sFileManagementFileName ,sFileManagementFilePath)
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Create Data File", PASS ,"Data File: {sFileManagementFileName} created successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] 
			[ ] iValidate=QuickenBackupNavigation()
			[+] if(iValidate==PASS)
				[ ] 
				[ ] // Verify Caption of the window
				[ ] QuickenBackup.SetActive()
				[ ] sActual=QuickenBackup.GetCaption()
				[+] if (sActual==sCaption)
					[ ] ReportStatus("Verify window title", PASS , "Window title is displayed correctly, window title is {sCaption}")
				[+] else
					[ ] ReportStatus("Verify window title", FAIL , "Window title is not displayed correctly, actual window title is {sActual} and expected window title is {sCaption}, Defect id=QW008566")
				[ ] 
				[ ] //// Verify default path location for Backup.
				[ ] sActualDefaultPath=QuickenBackup.BackupFile.BackupFileTextField.GetText()
				[+] if (sDefaultPath==sActualDefaultPath)
					[ ] ReportStatus("Verify default path location for Backup.", PASS , "Default path location for Backup is as expected: {sActualDefaultPath}")
				[+] else
					[ ] ReportStatus("Verify default path location for Backup.", FAIL , "Default path location for Backup actual: {sActualDefaultPath} is NOT as expected: {sDefaultPath}")
				[ ] 
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
				[ ] // Verify Cancel button functionality for Quicken Backup
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.Cancel.Click()
				[ ] 
				[+] if(!QuickenBackup.Exists(2))
					[ ] ReportStatus("Verify functionality of Cancel button on Quicken Backup dialog",PASS,"Quicken Backup dialog is closed by clicking on Cancel button")
				[+] else
					[ ] ReportStatus("Verify functionality of Cancel button on Quicken Backup dialog",FAIL,"Quicken Backup dialog does not  close by clicking on Cancel button")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to QuickenBackup ", FAIL,"Quicken Backup popup did not appear" )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be created.")
[ ] //###################################################################################################
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
[+] testcase Test02_VerifyBackupOnMyComputerHardDriveAtDefaultPathLocation() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ]  STRING USERNAME="udita_dube"
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
		[ ] LaunchQuicken()
	[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[+] if(QuickenBackup.Exists(10))
				[ ] QuickenBackup.SetActive()
				[ ] //// Verify default path location for Backup.
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.AddDateToBackupFileName.Check()
				[ ] sDefaultPath=NULL
				[ ] sDefaultPath =QuickenBackup.BackupFile.BackupFileTextField.GetText()
				[+] if (sDefaultPath==sExpectedFilePath)
					[ ] ReportStatus("Verify default path location for Backup.", PASS , "Default path location for Backup is as expected: {sDefaultPath}")
					[ ] 
					[ ] QuickenBackup.BackUpNow.Click()
					[+] if(BackupConfirmation.Exists(10))
						[ ] BackupConfirmation.SetActive()
						[ ] BackupConfirmation.OK.Click()
						[ ] // Verify File exist in specific location with name and date
						[+] if(FileExists(sExpectedFilePath))
							[ ] ReportStatus("Verify Backup at default path location.", PASS,"Backup done properly at location: {sExpectedFilePath}" )
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.File.Click()
							[ ] QuickenWindow.File.OpenQuickenFile.Select()
							[+] if (ImportExportQuickenFile.Exists(10))
								[ ] ImportExportQuickenFile.SetActive()
								[ ] ImportExportQuickenFile.FileName.SetText(sExpectedFilePath)
								[ ] ImportExportQuickenFile.OK.Click()
								[+] if (QuickenRestore.Exists(10))
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
[ ] //###################################################################################################
[ ] 
[+] //#############  Verify restore functionality by restoring data file from default location #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02A_VerifyRestoreFromMyComputerHardDriveAtDefaultPathLocation()
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
[+] testcase Test03_VerifyRestoreFromMyComputerHardDriveAtDefaultPathLocation() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sTempFile ="DefaultRestoredTempFile"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ]  STRING USERNAME="udita_dube"
		[ ] STRING sBackup=".QDF-backup"
		[ ] 
		[ ] sExpectedFilePath ="C:\Users\" +USERNAME+ "\Desktop\" +sFileManagementFileName+"-"+sDate+".QDF-backup"
		[ ] 
	[ ] iResult=DataFileCreate(sTempFile , sFileManagementFilePath)
	[+] if(iResult==PASS)
		[ ] ReportStatus("Create Data File", PASS ,"Data File: {sTempFile} created successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] // Verify File exist in specific location with name and date
			[+] if(FileExists(sExpectedFilePath))
				[ ] iValidate=QuickenRestoreNavigation()
				[+] if(iValidate==PASS)
						[ ] sleep(1)
						[+] if (QuickenRestore.Browse.IsEnabled())
							[ ] QuickenRestore.Browse.Click()
							[+] if (DlgRestoreQuickenFile.Exists(5))
								[ ] ReportStatus("Verify Restore Quicken File dialog by clicking on Browse button", PASS,"Restore Quicken File dialog appeared after clicking on Browse button")
								[ ] DlgRestoreQuickenFile.SetActive()
								[ ] DlgRestoreQuickenFile.FilesNameComboBox.SetText(sExpectedFilePath)
								[ ] DlgRestoreQuickenFile.OKButton.Click()
								[+] if (QuickenRestore.Exists(5))
									[ ] QuickenRestore.SetActive()
									[ ] QuickenRestore.RestoreBackup.Click()
									[ ] 
									[+] if (RestoreOpenFile.Exists(5))
										[ ] RestoreOpenFile.SetActive()
										[ ] 
										[ ] // Verify FileName on the Restore from backup file
										[ ] sActual = RestoreOpenFile.FileNameText.GetText()
										[ ] bMatch =MatchStr("*{sFileManagementFileName}*{sDate}*{sBackup}*", sActual)
										[+] if(bMatch)
											[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", PASS," File name:{sActual} appeared as expected on Restore from backup file dialog." )
										[+] else
											[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL," File name:{sActual} didn't appear as expected on Restore from backup file dialog." )
										[ ] 
										[ ] RestoreOpenFile.RestoreBackup.Click()
										[ ] WaitForState(QuickenRestore , false ,2)
										[ ] 
										[+] if (QuickenRestore.Exists(5))
											[ ] QuickenRestore.SetActive()
											[ ] QuickenRestore.Yes.Click()
											[ ] sleep(2)
											[ ] 
											[+] if(QuickenWindow.Exists(5))
												[ ] QuickenWindow.SetActive()
												[ ] sActual =QuickenWindow.GetCaption()
												[ ] bMatch = MatchStr( "*{sFileManagementFileName}*" ,sActual)
												[+] if (bMatch)
													[ ] ReportStatus("Verify restore functionality by restoring data file from default location", PASS ,"File :{sActual} has been restored fromthe default location." )
													[ ] ReportStatus("Verify restore functionality by selecting backup path from Browse button", PASS ,"Restore functionality by selecting backup path from Browse button is working as expected as File :{sActual} has been restored" )
												[+] else
													[ ] ReportStatus("Verify restore functionality by restoring data file from default location", FAIL,"File :{sFileManagementFileName} couldn't be restored fromthe default location." )
													[ ] ReportStatus("Verify restore functionality by selecting backup path from Browse button", FAIL ,"Restore functionality by selecting backup path from Browse button is not working as expected as File :{sActual} has not been restored" )
												[ ] 
											[+] else
												[ ] ReportStatus("Verify Quicken window",FAIL,"Quicken window is not displayed")
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Quicken Restore Exists. ", FAIL , "Quicken Restore does not exist.") 
									[+] else
										[ ] ReportStatus("Verify the Open restored file dialog", FAIL,"Open restored file dialog didn't appear." )
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
							[+] else
								[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"Restore Quicken File dialog didn't appear." )
						[+] else
							[ ] ReportStatus("Verify Quicken Restore", FAIL,"Verify Quicken Restore window")
				[+] else
					[ ] ReportStatus("Navigate to Quicken Restore", FAIL,"Navigate to Quicken Restore window")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify restore functionality of Restore.", FAIL,"Backup did not done properly at location: {sExpectedFilePath}" )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sTempFile} couldn't be created.")
[ ] //###################################################################################################
[ ] 
[+] //############# Verify Backup on My Computer Hard Drive at different path location ##############################
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
[+] testcase Test04_VerifyBackupOnMyComputerHardDriveAtDifferentPathLocation() appstate QuickenBaseState
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ]  STRING USERNAME="udita_dube"
		[ ] 
		[ ] sExpectedFilePath =AUT_DATAFILE_PATH+"\" +sFileManagementFileName+"-"+sDate+".QDF-backup"
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\"+sFileManagementFileName +".QDF-backup"
		[ ] 
		[+] if(FileExists(sExpectedFilePath))
			[ ] DeleteFile(sExpectedFilePath)
		[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[+] if(QuickenBackup.Exists(10))
				[ ] QuickenBackup.SetActive()
				[ ] //// Verify default path location for Backup.
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.BackupFile.BackupFileTextField.SetText(sFilePath)
				[ ] QuickenBackup.AddDateToBackupFileName.Check()
				[ ] sDefaultPath=NULL
				[ ] sDefaultPath =QuickenBackup.BackupFile.BackupFileTextField.GetText()
				[+] if (sDefaultPath==sExpectedFilePath)
					[ ] ReportStatus("Verify different path location for Backup.", PASS , "Different path location for Backup is as expected: {sDefaultPath}")
					[ ] 
					[ ] QuickenBackup.BackUpNow.Click()
					[+] if(BackupConfirmation.Exists(10))
						[ ] BackupConfirmation.SetActive()
						[ ] BackupConfirmation.OK.Click()
						[ ] // Verify File exist in specific location with name and date
						[+] if(FileExists(sExpectedFilePath))
							[ ] ReportStatus("Verify Backup at default path location.", PASS,"Backup done properly at location: {sExpectedFilePath}" )
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.File.Click()
							[ ] QuickenWindow.File.OpenQuickenFile.Select()
							[+] if (ImportExportQuickenFile.Exists(10))
								[ ] ImportExportQuickenFile.SetActive()
								[ ] ImportExportQuickenFile.FileName.SetText(sExpectedFilePath)
								[ ] ImportExportQuickenFile.OK.Click()
								[+] if (QuickenRestore.Exists(10))
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
[ ] //###################################################################################################
[ ] 
[+] //############# Verify restore functionality by restoring data file from different location#############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03A_VerifyRestoreFromMyComputerHardDriveAtDifferentPathLocation()
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
[+] testcase Test05_VerifyRestoreFromMyComputerHardDriveAtDifferentPathLocation() appstate QuickenBaseState
	[+] //--------------Variable Declaration-------------
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
		[+] if(QuickenWindow.Exists(5))
			[ ] // Verify File exist in specific location with name and date
			[+] if(FileExists(sExpectedFilePath))
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
							[ ] 
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
								[+] if (QuickenRestore.Exists(5))
									[ ] QuickenRestore.SetActive()
									[ ] QuickenRestore.Yes.Click()
									[ ] sleep(2)
									[ ] 
									[+] if(AlertMessage.Exists(1))
										[ ] ReportStatus("Verify user get validation message",FAIL,"User is getting validation message even if provided correct path for backup")
									[+] else
										[ ] ReportStatus("Verify user doesn't get validation message",PASS,"User is not getting validation message if provided correct path for backup")
										[ ] 
									[ ] 
									[ ] 
									[+] if(QuickenWindow.Exists(5))
										[ ] QuickenWindow.SetActive()
										[ ] sActual =QuickenWindow.GetCaption()
										[ ] bMatch = MatchStr( "*{sFileManagementFileName}*" ,sActual)
										[+] if (bMatch)
											[ ] ReportStatus("Verify restore functionality by restoring data file from different location", PASS ,"File :{sActual} has been restored from the different location." )
										[+] else
											[ ] ReportStatus("Verify restore functionality by restoring data file from different location", FAIL,"File :{sFileManagementFileName} couldn't be restored from the different location." )
									[+] else
										[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
								[+] else
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
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sTempFile} couldn't be careted.")
[ ] //###################################################################################################
[ ] 
[+] //############# Verify UI for Quicken Restore Dialog Window ################################################
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
[+] testcase Test06_VerifyUIForRestoreDialog() appstate QuickenBaseState
		[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sBackup=".QDF-backup"
		[ ]  sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] sCaption="Restore from backup file"
	[ ] 
	[+] for(i=1;i<=5;i++)
		[ ] 
		[ ] CloseQuicken()
		[+] if(QuickenBackupReminder.Exists(SHORT_SLEEP))
			[ ] QuickenBackupReminder.BackupButton.Click()
			[+] if(QuickenBackup.Exists(5))
				[ ] QuickenBackup.SetActive()
				[ ] // Click on Backup Now button
				[ ] QuickenBackup.BackUpNow.Click()
			[+] if(DuplicateBackupFile.Exists(3))
				[ ] DuplicateBackupFile.SetActive()
				[ ] DuplicateBackupFile.Yes.Click()
				[ ] 
				[ ] 
			[+] if(BackupConfirmation.Exists(3))
				[ ] 
				[ ] BackupConfirmation.SetActive()
				[ ] BackupConfirmation.OK.Click()
				[ ] 
			[ ] 
		[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] 
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow,TRUE,5)
		[ ] 
	[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
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
				[ ] // Verify Caption of the window
				[ ] QuickenRestore.SetActive()
				[ ] sActual=QuickenRestore.GetCaption()
				[+] if (sActual==sCaption)
					[ ] ReportStatus("Verify window title", PASS , "Window title is displayed correctly, window title is {sCaption}")
				[+] else
					[ ] ReportStatus("Verify window title", FAIL , "Window title is not displayed correctly, actual window title is {sActual} and expected window title is {sCaption}, Defect id=QW008566")
				[ ] 
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
				[+] if (QuickenRestore.LearnMoreLink.Exists(2))
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
[ ] //###################################################################################################
[ ] 
[+] //############# Verify the Functionality of available buttons for Restore backup screen.############################
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
[+] testcase Test07_VerifytheFunctionalityOfAvailableButtonsForRestoreBackup() appstate QuickenBaseState
		[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedBackupFileType
		[ ]  sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] sExpectedBackupFileType ="Quicken Backup Files (*.QDF;*.QDF-Backup)"
		[ ] sExpectedFilePath =AUT_DATAFILE_PATH+"\" +sFileManagementFileName+"-"+sDate+".QDF-backup"
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
				[ ] // Verify Functionality of Browse button
				[+] if (QuickenRestore.RestoreFromBackupRadioList.Exists(2))
					[ ] QuickenRestore.RestoreFromBackupRadioList.Select(2)
					[ ] QuickenRestore.Browse.Click()
					[ ] 
					[ ] //Verify Backup File Type on the Restore Quicken File dialog
					[+] if (DlgRestoreQuickenFile.Exists(2))
						[ ] DlgRestoreQuickenFile.SetActive()
						[ ] ReportStatus("Verify the Functionality of Browse for Restore backup screen", PASS ,"Restore Quicken File dialog box is displayed after clicking on Browse button ")
						[ ] 
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
						[ ] ReportStatus("Verify Restore Quicken File dialog. ", FAIL , "Restore Quicken File dialog didn't appear after clicking on Browse button.") 
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
[ ] //####################################################################################################
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
[+] testcase Test08_VerfiyTheOpenBackupDirectoryButtonForNewlyCreatedDataFile() appstate QuickenBaseState
		[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedBackupFileType , sBackUpDir
		[ ] sTempFile ="TempFile"
		[ ] sBackUpDir =AUT_DATAFILE_PATH+"\File Management data\BackUp" 
		[ ] sExpectedCaption="The backup directory has not been created yet. It will be created when the file is backed up automatically the first time."
	[ ] 
	[ ] DeleteDir(sBackUpDir)
	[ ] 
	[ ] iResult=DataFileCreate(sTempFile ,sFileManagementFilePath)
	[ ] 
	[+] if(iResult==PASS)
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
			[+] if (QuickenRestore.Exists(10))
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
[ ] //###################################################################################################
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
[+] testcase Test09_VerifyTheRestoreFunctionalityByRestoringCurrentlyOpenFile() appstate QuickenBaseState					// Add
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedFilePath ,sTempFile
		[ ] STRING sBackup=".QDF-backup"
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] sTempFile ="TempFile"
		[ ] STRING sPath = AUT_DATAFILE_PATH+"\File Management data\"
		[ ] STRING sFileName= sFileManagementFileName+"-"+sDate
		[ ] sExpectedFilePath =sPath + sFileName + sBackup
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\File Management data\"+sFileManagementFileName +".QDF-backup"
	[ ] 
	[+] for(i=1;i<=5;i++)
		[ ] 
		[ ] CloseQuicken()
		[+] if(QuickenBackupReminder.Exists(SHORT_SLEEP))
			[ ] QuickenBackupReminder.BackupButton.Click()
			[+] if(QuickenBackup.Exists(5))
				[ ] QuickenBackup.SetActive()
				[ ] // Click on Backup Now button
				[ ] QuickenBackup.BackUpNow.Click()
			[+] if(DuplicateBackupFile.Exists(3))
				[ ] DuplicateBackupFile.SetActive()
				[ ] DuplicateBackupFile.Yes.Click()
				[ ] 
				[ ] 
			[+] if(BackupConfirmation.Exists(3))
				[ ] 
				[ ] BackupConfirmation.SetActive()
				[ ] BackupConfirmation.OK.Click()
				[ ] 
			[ ] 
		[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] 
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow,TRUE,5)
		[ ] 
	[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[+] if(QuickenBackup.Exists(10))
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
				[+] if(BackupConfirmation.Exists(10))
					[ ] BackupConfirmation.SetActive()
					[ ] BackupConfirmation.OK.Click()
					[ ] // Verify File exist in specific location with name and date
					[ ] 
					[ ] 
					[+] if(FileExists(sExpectedFilePath))
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.File.Click()
						[ ] QuickenWindow.File.BackupAndRestore.Click()
						[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
						[+] if (QuickenRestore.Exists(10))
							[ ] QuickenRestore.SetActive()
							[ ] sHandle = Str(QuickenRestore.ListBox1.GetHandle ())
							[ ] iListCount=QuickenRestore.ListBox1.GetItemCount() +1
							[+] for( iCounter=0;iCounter< iListCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
								[ ] bMatch = MatchStr("*{sFileManagementFileName}*", sActual)
								[+] if ( bMatch)
									[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,  "{iCounter}")
									[ ] break
							[+] if(bMatch)
								[ ] 
								[ ] QuickenRestore.RestoreBackup.Click()
								[+] if (RestoreOpenFile.Exists(10))
									[ ] RestoreOpenFile.SetActive()
									[ ] // Verify FileName on the Restore from backup file
									[ ] sActual = RestoreOpenFile.FileNameText.GetText()
									[ ] bMatch =MatchStr("*{sFileName}*", sActual)
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
											[ ] ReportStatus("Verify that  Quicken allows to make the copy of that opened .qdf file.",PASS,"Quicken allows to make the copy of that opened restored qdf file.{sFileManagementFileName}")
											[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", PASS , "Restore from backup file confirmation dialog appeared." )
										[+] else
											[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Restore from backup file confirmation dialog didn't appear." )
											[ ] ReportStatus("Verify that  Quicken allows to make the copy of that opened .qdf file.",FAIL,"Quicken does not allow to make the copy of that opened restored qdf file.{sFileManagementFileName}")
											[ ] 
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
								[ ] QuickenRestore.SetActive()
								[ ] QuickenRestore.Close()
							[ ] 
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
[ ] //###################################################################################################
[ ] 
[+] //############# Verify newly added "Save a copy as…" and "Show this file on my computer" menu option from Classic menu.##
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
[+] testcase Test10_VerifySaveACopyAsMenuOptionFromClassicMenu() appstate none
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
[ ] //##################################################################################################
[ ] 
[ ] 
[+] //############# Verify restore functionality by Restoring Existing File with overwrite option ########################
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
[+] testcase Test11_VerifyRestoreFunctionalityByRestoringExistingFileWithOverwriteOption() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] // STRING sAccountName , sAccountBalance
		[ ] // sAccountBalance ="9,871"
		[ ] // sAccountName ="Checking 01 Account"
		[ ]   sDateFormat="yyyy-mm-dd"
		[ ]   sDate=ModifyDate(0,sDateFormat)
		[ ] sTempFile ="FileManagementDataFile"
		[ ] sFileName="Export"
		[ ] 
		[ ] sExpectedFilePath =NULL
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\File Management data\"+sTempFile +"-{sDate}.QDF-backup"
		[ ] 
	[ ] iResult=OpenDatafile(sFileName , sFileManagementFilePath)
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileName} opened successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] print(sFilePath)
			[ ] // Verify File exist in specific location with name and date
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
										[ ] // sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
										[ ] // iListCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()
										[+] // for( iCounter=0;iCounter< iListCount ;++iCounter)
											[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
											[ ] // bMatch = MatchStr("*{sAccountName}*{sAccountBalance}*", sActual)
											[+] // if (bMatch)
												[ ] // break
										[ ] sCaption=QuickenWindow.GetCaption()
										[ ] bMatch = MatchStr("*{sTempFile}*", sCaption)
										[+] if (bMatch)
											[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", PASS,"File {sTempFile} is restored successfully with overwrite option")
										[+] else
											[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Overwrite Option.", FAIL,"File {sTempFile} is not restored successfully with overwrite option")
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
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileName} couldn't be opened.")
		[ ] 
[ ] //###################################################################################################
[ ] 
[+] //############# Verify restore functionality by Restoring Existing File with Copy option ###########################
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
[+] testcase Test12_VerifyRestoreFunctionalityByRestoringExistingFileWithCopyOption() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sAccountName , sAccountBalance ,sBackupCopyFile ,sBackupCopyFilePath
		[ ] // sAccountBalance ="9,871"
		[ ] // sAccountName ="Checking 01 Account"
		[ ] // sTempFile ="Register-2014-01-23.PM12.16Copy"
		[ ] sTempFile ="FileManagementDataFile"
		[ ] sDateFormat="yyyy-mm-dd"
		[ ] sDate=ModifyDate(0,sDateFormat)
		[ ] sFileName="Export"
		[ ] 
		[ ] sBackupCopyFile= "BackupCopyFile"
		[ ] 
		[ ] sBackupCopyFilePath =AUT_DATAFILE_PATH+ "\File Management data\" +sBackupCopyFile
		[ ] sFilePath=AUT_DATAFILE_PATH+ "\File Management data\"+sTempFile +"-{sDate}.QDF-backup"
		[ ] 
		[ ] 
	[ ] 
	[ ] //Delete the copy file if exists
	[+] if(FileExists(sBackupCopyFilePath))
		[ ] DeleteFile(sBackupCopyFilePath)
		[ ] 
	[ ] 
	[ ] iResult=OpenDatafile(sFileName , sFileManagementFilePath)
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
									[+] if(CopyQuickenFileBrowser.Exists(5))
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
											[ ] // sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
											[ ] // iListCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()
											[+] // for( iCounter=0;iCounter< iListCount ;++iCounter)
												[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
												[ ] // bMatch = MatchStr("*{sAccountName}*{sAccountBalance}*", sActual)
												[+] // if (bMatch)
													[ ] // break
											[ ] 
											[ ] sCaption=QuickenWindow.GetCaption()
											[ ] bMatch = MatchStr("*{sBackupCopyFile}*", sCaption)
											[+] if (bMatch)
												[ ] ReportStatus("Verify restore functionality by Restoring Existing File with copy Option.", PASS,"File {sTempFile} is restored successfully with copy option, copied file: {sBackupCopyFile}")
											[+] else
												[ ] ReportStatus("Verify restore functionality by Restoring Existing File with copy Option.", FAIL,"File {sTempFile} is not restored successfully with copy option, copied file: {sBackupCopyFile}")
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", FAIL,"Restore from backup file confirmation dialog didn't appear." )
										[ ] 
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
				[+] else
					[ ] ReportStatus("Verify the restore functionality by Restoring Currently Open File", FAIL,"Quicken will restore this backup file dialog didn't appear." )
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify restore functionality by Restoring Existing File with Copy Option.", FAIL,"Backup did not done properly at location: {sFilePath}" )
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
		[ ] 
	[ ] 
[ ] //###################################################################################################
[ ] 
[ ] //////////////Udita//////////////////////////////////////////
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
[+] testcase Test13_FindQuickenFiles() appstate QuickenBaseState
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
				[ ] sleep(2)
				[ ] FindQuickenDataFiles.StopSearching.Click()
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
[+] //#Verify the navigation for Quicken Backup Preferences Dialog & Verify the functionality of Automatic Backup check box option  ###
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyPreferencesForAutomaticBackup ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the navigation for Quicken Backup Preferences Dialog Window and Verify the functionality of Automatic Backup check box option
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	17/2/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test14_VerifyPreferencesForAutomaticBackup() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sPreferenceType,sAutomaticBackup,sBackupPath
		[ ] 
		[ ] sPreferenceType="Backup"
		[ ] sAutomaticBackup="2"
		[ ] sBackupPath=sFileManagementFilePath+"\Backup\{sFileManagementFileName}*.QDF-backup"
		[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[+] if(iResult==PASS)
		[ ] //Check the Quicken Existence 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] iValidate=SelectPreferenceType(sPreferenceType)
			[+] if(iValidate==PASS)
				[ ] 
				[+] if(Preferences.BackupPreferencesText.Exists(2))
					[ ] ReportStatus("Verify Backup Preferences text is displayed",PASS, "Backup Preferences text is displayed after selecting Backup preference type")
					[ ] 
					[ ] // Verify default status for Automatic Backup check box
					[ ] bMatch=Preferences.AutomaticBackups.IsChecked()
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify default status for Automatic Backup check box",PASS, "Default status for Automatic Backup check box is checked")
						[ ] 
						[+] if(Preferences.BackupAfterRunningQuicken.Exists(3))
							[ ]  Preferences.BackupAfterRunningQuicken.SetText(sAutomaticBackup)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Backup after running Quicken text box",FAIL,"Backup after running Quicken text box is not present on Preferences window")
						[+] if(Preferences.MaximumNumberOfBackupCopies.Exists(3))
							[ ]  Preferences.MaximumNumberOfBackupCopies.SetText(sAutomaticBackup)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Maximum Number Of Backup Copies text box",FAIL,"Maximum Number Of Backup Copies text box is not present on Preferences window")
						[ ] 
						[ ] Preferences.OK.Click()
						[ ] 
						[+] for(i=1;i<=Val(sAutomaticBackup)*3;i++)
							[ ] CloseQuicken()
							[+] if(QuickenBackup.Exists(5))
								[ ] QuickenBackup.SetActive()
								[ ] // Click on Backup Now button
								[ ] QuickenBackup.Exit.Click()
								[ ] 
							[ ] App_Start(sCmdLine)
							[ ] sleep(1)
						[ ] 
						[ ] // QuickenWindow.SetActive()
						[ ] // QuickenWindow.File.BackupAndRestore.Click()
						[ ] // QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
						[ ] 
						[ ] // Navigate to File > Backup and Restore > Restore from Backup file
						[ ] QuickenWindow.MainMenu.Select("/_File/_Backup and Restore/_Restore from Backup File...")
						[ ] 
						[+] if(QuickenRestore.Exists(2))
							[ ] QuickenRestore.SetActive()
							[ ] iCount=PaymentDetailsListBox.GetItemCount()
							[+] if(iCount==Val(sAutomaticBackup))
									[ ] ReportStatus("Varify the functionality of 	Automatic backup",PASS,"Automatic backup is working as expected it creates automatic back up after Quicken running {sAutomaticBackup} times and saved maximum {sAutomaticBackup} backups")
									[ ] // Verify File exist in specific location with name and date
									[+] if(FileExists(sBackupPath))
										[ ] ReportStatus("Verify Backup at automatic backup location.", PASS,"Backup done properly at location: {sBackupPath}" )
										[ ] sHandle = Str(QuickenRestore.ListBox1.GetHandle ())
										[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, "1")
										[+] if(QuickenRestore.RestoreBackup.GetProperty("Enabled"))
											[ ] QuickenRestore.RestoreBackup.Click()
											[+] if (RestoreOpenFile.Exists(10))
												[ ] ReportStatus("Verify Restore Open file window",PASS,"Restore Open File window is displayed")
												[ ] RestoreOpenFile.SetActive()
												[ ] RestoreOpenFile.RestoreBackup.Click()
												[ ] sleep(2)
												[+] if(QuickenWindow.Exists(2))
													[ ] sActual=QuickenWindow.GetCaption()
													[+] if( MatchStr("*{sFileManagementFileName}*", sActual))
														[ ] ReportStatus("Validate Quicken window title", PASS, "Backup is restored successfully, {sFileManagementFileName} file opened successfully")
													[+] else
														[ ] ReportStatus("Validate Quicken window title", PASS, "Backup is not restored successfully, {sFileManagementFileName} file did not open successfully, Actual {sActual}")
													[ ] 
												[+] else
													[ ] ReportStatus("Verify Quicken window",FAIL,"Quicken window is not available")
											[+] else
												[ ] ReportStatus("Verify Restore Open file window",FAIL,"Restore Open File window is not displayed")
										[+] else
											[ ] ReportStatus("Verify Restore Backup button",FAIL,"Restore Backup button is not enabled")
									[+] else
										[ ] ReportStatus("Verify Backup at automatic backup location.", FAIL,"Backup is not done properly at location: {sBackupPath}" )
										[ ] 
									[ ] 
							[+] else
									[ ] ReportStatus("Varify the functionality of 	Automatic backup",FAIL,"Automatic backup is not working as expected it does not create automatic back up after Quicken running {sAutomaticBackup} times and not saved maximum {sAutomaticBackup} backups, Actual is {iCount}")
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Quicken Restore window",FAIL,"Quicken Restore window is not displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify default status for Automatic Backup check box",FAIL, "Default status for Automatic Backup check box is not checked")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Backup Preferences text is displayed",FAIL, "Backup Preferences text is not displayed after selecting Backup preference type")
					[ ] 
			[+] else
				[ ] ReportStatus("Select Preference type",FAIL,"Preference type {sPreferenceType} is not selected")
		[+] else
			[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
	[+] else
		[ ] ReportStatus("Open Data File", FAIL ,"Data File: {sFileManagementFileName} opened successfully.")
		[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############  Verify the navigation for Quicken Backup Preferences Dialog Window  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyPreferencesForManualBackup ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the navigation for Quicken Backup Preferences Dialog Window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	14/2/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test15_VerifyPreferencesForManualBackup() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sPreferenceType,sManualBackup,sBackupPath
		[ ] 
		[ ] sPreferenceType="Backup"
		[ ] sManualBackup="2"
		[ ] sBackupPath=sFileManagementFilePath+"\Backup\{sFileManagementFileName}*.QDF-backup"
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=SelectPreferenceType(sPreferenceType)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Verify default status for Manual Backup Reminder check box
			[ ] bMatch=Preferences.ManualBackupReminder.IsChecked()
			[+] if(bMatch)
				[ ] ReportStatus("Verify default status for Manual Backup Reminder check box",PASS, "Default status for Manual Backup Reminder check box is checked")
				[ ] 
				[+] if(Preferences.ManualBackupAfterRunningQuicken.Exists(3))
					[ ]  Preferences.BackupAfterRunningQuicken.SetText(sManualBackup)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Manual Backup after running Quicken text box",FAIL,"Manual Backup after running Quicken text box is not present on Preferences window")
				[ ] 
				[+] for(i=1;i<=Val(sManualBackup);i++)
					[ ] CloseQuicken()
					[+] if(i==Val(sManualBackup))
						[+] if(BackupConfirmation.Exists(2))
							[ ] ReportStatus("Varify the functionality of Manual Backup check box",PASS,"Manual Backup check box is working as expected it asks for taking back up after Quicken running {sManualBackup} times")
							[ ] BackupConfirmation.SetActive()
							[ ] BackupConfirmation.BackupButton.Click()
							[+] if(QuickenBackup.Exists(2))
								[ ] QuickenBackup.BackUpNow.Click()
								[+] if(BackupConfirmation.Exists(2))
									[ ] BackupConfirmation.OK.Click()
								[ ] 
						[+] else
							[ ] ReportStatus("Varify the functionality of Manual Backup check box",FAIL,"Manual Backup check box is not working as expected it doesn't asks for taking back up even after Quicken running {sManualBackup} times")
						[ ] 
					[ ] App_Start(sCmdLine)
					[ ] sleep(1)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] // Verify File exist in specific location with name and date
				[+] if(FileExists(sBackupPath))
					[ ] ReportStatus("Verify Backup at manual backup location.", PASS,"Backup done properly at location: {sBackupPath}" )
					[ ] OpenDataFile(sBackupPath)
					[+] if(QuickenRestore.RestoreBackup.GetProperty("Enabled"))
						[ ] QuickenRestore.RestoreBackup.Click()
						[+] if (RestoreOpenFile.Exists(10))
							[ ] ReportStatus("Verify Restore Open file window",PASS,"Restore Open File window is displayed")
							[ ] RestoreOpenFile.SetActive()
							[ ] RestoreOpenFile.RestoreBackup.Click()
							[ ] sleep(2)
							[+] if(QuickenWindow.Exists(2))
								[ ] sActual=QuickenWindow.GetCaption()
								[+] if( MatchStr("*{sFileManagementFileName}*", sActual))
									[ ] ReportStatus("Validate Quicken window title", PASS, "Backup is restored successfully, {sFileManagementFileName} file opened successfully")
								[+] else
									[ ] ReportStatus("Validate Quicken window title", PASS, "Backup is not restored successfully, {sFileManagementFileName} file did not open successfully, Actual {sActual}")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Quicken window",FAIL,"Quicken window is not available")
						[+] else
							[ ] ReportStatus("Verify Restore Open file window",FAIL,"Restore Open File window is not displayed")
					[+] else
						[ ] ReportStatus("Verify Restore Backup button",FAIL,"Restore Backup button is not enabled")
				[+] else
					[ ] ReportStatus("Verify Backup at manual backup location.", FAIL,"Backup is not done properly at location: {sBackupPath}" )
					[+] 
							[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify default status for Manual Backup check box",FAIL, "Default status for Manual Backup check box is not checked")
				[ ] 
		[+] else
			[ ] ReportStatus("Select Preference type",FAIL,"Preference type {sPreferenceType} is not selected")
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify whether Invalid file locations can be selected from backup directory  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyInvalidLoacationForManualBackup ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify whether Invalid file locations can be selected from backup directory menu
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	21/2/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test16_VerifyInvalidLoacationForManualBackup() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sMessage,sExpectedMessage,sBackupPath,sFileName
		[ ] 
		[ ] sFileName="Export.QDF-backup"
		[ ] sBackupPath="Y:\Intuit\Backup\"
		[ ] sExpectedMessage="Quicken can't find the drive Y:."
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // Try to take backup on non existing path
		[ ] QuickenBackup(sBackupPath,sFileName)
		[ ] // Verify Validation message
		[+] if(AlertMessage.Exists(1))
			[ ] ReportStatus("Verify user get validation message",PASS,"User is getting validation message if provided wrong path for backup")
			[ ] 
			[ ] AlertMessage.SetActive()
			[ ] sMessage=AlertMessage.StaticText.GetText()
			[+] if(sExpectedMessage==sMessage)
				[ ] ReportStatus("Verify user get proper validation message",PASS,"User is getting correct message if provided wrong path for backup, message is {sMessage}")
			[+] else
				[ ] ReportStatus("Verify user get proper validation message",FAIL,"User is not getting correct message if provided wrong path for backup, Actual message is {sMessage}, Expected message is {sExpectedMessage}")
				[ ] 
			[ ] 
			[ ] AlertMessage.OK.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify user get validation message",FAIL,"User is not getting validation message even if provided wrong path for backup")
			[ ] 
		[ ] 
		[+] if(QuickenBackup.Exists(2))
			[ ] QuickenBackup.SetActive()
			[ ] QuickenBackup.Close()
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify File menus and submenus  ################################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_VerifyFileMenu ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify File menu, sub menus
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	21/2/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test17_VerifyFileMenu() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sExpectedWindowTitle,sActualWindowTitle
		[ ] INTEGER iPos
		[ ] STRING sMainWindow="/WPFWindow[@caption='Quicken 20*']"
		[ ] WINDOW wDialogBox
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sExcelName, sFileWorksheet)
		[ ] 
	[ ] 
	[+] if(!QuickenMainWindow.QWNavigator.Business.Exists(2))
		[ ] ShowQuickenTab(sTAB_BUSINESS,TRUE)
	[ ] 
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[+] for(i=14;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ]  // Check for multiple navigation
				[ ] iPos= StrPos(">",lsExcelData[i][1])
				[+] if( iPos != 0)
					[ ] lsTestData=split(lsExcelData[i][1],">")
					[ ] 
					[+] if(StrPos("/",lsTestData[2]) > 0)
						[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
						[ ] lsTestData[2]=trim(lsTestData[2])
						[ ] lsTestData[1]=trim(lsTestData[1])
					[ ] sleep(SHORT_SLEEP)
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sFileWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
					[ ] 
				[+] else
					[ ] QuickenWindow.SetActive()
					[ ] // Select menu item
					[ ] lsExcelData[i][1]=trim(lsExcelData[i][1])
					[ ] QuickenWindow.MainMenu.Select("/{trim(sFileWorksheet)}/{lsExcelData[i][1]}*")
					[ ] 
				[ ] 
				[+] if(lsExcelData[i][3] == "Other")
					[ ] sExpectedWindowTitle = "Create Tax Export File"
					[ ] 
					[+] if (TaxDlg.Exists())
						[ ] TaxDlg.SetFocus()
						[ ] wDialogBox=TaxDlg.Getparent()
						[ ] sActualWindowTitle=wDialogBox.getproperty("caption")
						[+] if(sActualWindowTitle==sExpectedWindowTitle)
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] TaxDlg.TypeKeys(KEY_EXIT)
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] // if(QuickenMainWindow.FileDlg(lsExcelData[i][2]).Exists(5))
					[+] if(lsExcelData[i][2]=="Import RPM Data File ")
						[+]  if(Desktop.Find("/{sMainWindow}//{lsExcelData[i][4]}[@caption='{lsExcelData[i][2]}']").Exists())
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] Desktop.Find("/{sMainWindow}//{lsExcelData[i][4]}[@caption='{lsExcelData[i][2]}']").SetActive()
							[ ] Desktop.Find("/{sMainWindow}//{lsExcelData[i][4]}[@caption='{lsExcelData[i][2]}']").Close()
							[ ] 
						[ ] 
					[+] else if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] 
					[+] else if (trim(lsTestData[2])=="_Addresses")
						[ ] sCaption=ImportAddressRecords.GetCaption()
						[+] if(lsExcelData[i][2]==sCaption)
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, " Expected - {lsExcelData[i][2]} window title is displayed")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
							[ ] 
						[+] if(ImportAddressRecords.Exists())
							[ ] ImportAddressRecords.Close ()
						[+] if(AddressBookAllGroups.Exists())
							[ ] AddressBookAllGroups.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
					[ ] 
					[+] if(AddressBookAllGroups.Exists())
						[ ] AddressBookAllGroups.Close()
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
			[ ] 
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] // QuickenMainWindow.kill()
			[ ] // Sleep(3)
			[ ] // QuickenMainWindow.Start (sStartQuicken)
			[ ] // continue
		[ ] 
		[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify Restore And Overwrite For 2012 Backup File  #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_VerifyRestoreFor2012BackupFile ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify restore feature with old Quicken backup file with over write option
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	24/2/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test18_VerifyRestoreAndOverwriteFor2012BackupFile() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sBackupFileName = "WALL_FileManagement"
		[ ] 
		[ ] STRING sSource = AUT_DATAFILE_PATH+"\"+"FileIO"+"\"+"2012 data file backup\{sBackupFileName}.QDF-backup"
		[ ] STRING sTarget= AUT_DATAFILE_PATH+"\"+"FileIO"+"\{sBackupFileName}.QDF-backup"
		[ ] 
	[ ] 
	[+] if(FileExists(sTarget))
		[ ] DeleteFile(sTarget)
	[ ] CopyFile(sSource,sTarget)
	[ ] 
	[ ] iValidate= QuickenRestoreNavigation(sFileIOFilePath,sBackupFileName)
	[+] if(iValidate==PASS)
		[+] if(RestoreOpenFile.Exists(2))
			[ ] RestoreOpenFile.SetActive()
			[ ] RestoreOpenFile.RestoreBackup.Click()
			[ ] QuickenRestore.SetActive()
			[ ] // Click on No button
			[ ] QuickenRestore.No.Click()
			[ ] 
			[ ] QuickenRestoreNavigation(sFileIOFilePath,sBackupFileName)
			[+] if(RestoreOpenFile.Exists(2))
				[ ] RestoreOpenFile.SetActive()
				[ ] //Selecting copy option
				[ ] RestoreOpenFile.CreateaCopy.Select (1)
				[ ] RestoreOpenFile.RestoreBackup.Click()
				[+] if (QuickenRestore.Exists(5))
					[ ] QuickenRestore.SetActive()
					[ ] QuickenRestore.Yes.Click()
				[ ] //Convert data file if older file
				[+] if(ConvertYourData.Exists(10))
					[ ] ConvertYourData.SetActive()
					[ ] ConvertYourData.ConvertFilebutton.Click()
					[+] if (AlertMessage.OK.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage, false ,2)
					[+] if (AlertMessage.Exists(5))
						[+] while (AlertMessage.Exists())
							[ ] sleep(1)
				[ ] 
				[ ] // Verify QDF file
				[+] if(FileExists("{sFileIOFilePath}\{sBackupFileName}.QDF"))
					[ ] ReportStatus("Verify restore functionality by Restoring 2012 backup File with Copy Option.", PASS,"Data file {sBackupFileName} is saved as a copy from 2012 data file backup" )
				[+] else
					[ ] ReportStatus("Verify restore functionality by Restoring 2012 backup File with Copy Option.", FAIL,"Data file {sBackupFileName} is not saved as a copy from 2012 data file backup" )
					[ ] 
				[ ] 
				[ ] CloseQuickenConnectedServices()
				[ ] WaitForState(QuickenMainWindow.QWNavigator.Home, TRUE, 10)
				[ ] 
				[ ] // Verify caption for restored and opened data file
				[ ] QuickenWindow.SetActive()
				[ ] sleep(SHORT_SLEEP)			
				[ ] sActual= QuickenWindow.GetCaption()
				[ ] 
				[ ] // Verify backup file restored successfully or not
				[ ] bMatch = MatchStr("*{sBackupFileName}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate backup file restore", PASS, "{sBackupFileName} file restored")
					[ ] 
				[+] else
					[ ] iFunctionResult=FAIL
					[ ] ReportStatus("Validate backup file restore", FAIL, "Expected- {sBackupFileName} is not matching with actual {sActual} ")
					[ ] 
			[ ] 
		[+] else
			[ ] QuickenRestore.Yes.Click()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Restore Navigation",FAIL,"Quicken Restore Navigation is failed")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify Restore And Create A Copy For 2012 Backup File  ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_VerifyRestoreAndCreateACopyFor2012BackupFile ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify restore feature with old Quicken backup file with create a copy option
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	21/2/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test19_VerifyRestoreAndCreateACopyFor2012BackupFile() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sBackupFileName = "WALL_FileManagement"
		[ ] 
		[ ] STRING sSource = AUT_DATAFILE_PATH+"\"+"FileIO"+"\"+"2012 data file backup\{sBackupFileName}.QDF-backup"
		[ ] STRING sTarget= AUT_DATAFILE_PATH+"\"+"FileIO"+"\{sBackupFileName}.QDF-backup"
		[ ] 
	[ ] 
	[+] if(FileExists(sTarget))
		[ ] DeleteFile(sTarget)
	[ ] CopyFile(sSource,sTarget)
	[ ] 
	[ ] iValidate= QuickenRestoreNavigation(sFileIOFilePath,sBackupFileName)
	[+] if(iValidate==PASS)
		[+] if(RestoreOpenFile.Exists(2))
			[ ] RestoreOpenFile.SetActive()
			[ ] RestoreOpenFile.RestoreBackup.Click()
			[ ] QuickenRestore.SetActive()
			[ ] // Click on No button
			[ ] QuickenRestore.No.Click()
			[ ] 
			[ ] QuickenRestoreNavigation(sFileIOFilePath,sBackupFileName)
			[+] if(RestoreOpenFile.Exists(2))
				[ ] RestoreOpenFile.SetActive()
				[ ] //Selecting copy option
				[ ] RestoreOpenFile.CreateaCopy.Select ("Create a copy")
				[ ] RestoreOpenFile.RestoreBackup.Click()
				[+] if(CopyQuickenFileBrowser.Exists(3))
					[ ] CopyQuickenFileBrowser.OK.Click()
					[ ] WaitForState(CopyQuickenFileBrowser , False ,2)
					[+] if (QuickenRestore.Exists(5))
						[ ] QuickenRestore.SetActive()
						[ ] QuickenRestore.Yes.Click()
					[ ] //Convert data file if older file
					[+] if(ConvertYourData.Exists(10))
						[ ] ConvertYourData.SetActive()
						[ ] ConvertYourData.ConvertFilebutton.Click()
						[+] if (AlertMessage.OK.Exists(2))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.OK.Click()
							[ ] WaitForState(AlertMessage, false ,2)
						[+] if (AlertMessage.Exists(5))
							[+] while (AlertMessage.Exists())
								[ ] sleep(1)
					[ ] 
					[ ] // Verify QDF file
					[+] if(FileExists("{sFileIOFilePath}\{sBackupFileName}.QDF"))
						[ ] ReportStatus("Verify restore functionality by Restoring 2012 backup File with Copy Option.", PASS,"Data file {sBackupFileName} is saved as a copy from 2012 data file backup" )
					[+] else
						[ ] ReportStatus("Verify restore functionality by Restoring 2012 backup File with Copy Option.", FAIL,"Data file {sBackupFileName} is not saved as a copy from 2012 data file backup" )
						[ ] 
					[ ] 
					[ ] CloseQuickenConnectedServices()
					[ ] WaitForState(QuickenMainWindow.QWNavigator.Home, TRUE, 10)
					[ ] 
					[ ] // Verify caption for restored and opened data file
					[ ] QuickenWindow.SetActive()
					[ ] sleep(SHORT_SLEEP)			
					[ ] sActual= QuickenWindow.GetCaption()
					[ ] 
					[ ] // Verify backup file restored successfully or not
					[ ] bMatch = MatchStr("*{sBackupFileName}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate backup file restore", PASS, "{sBackupFileName} file restored")
						[ ] 
					[+] else
						[ ] iFunctionResult=FAIL
						[ ] ReportStatus("Validate backup file restore", FAIL, "Expected- {sBackupFileName} is not matching with actual {sActual} ")
						[ ] 
			[ ] 
		[+] else
			[ ] QuickenRestore.Yes.Click()
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify validation message while taking the backup of large char data file. #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_VerifyValidationMessageOfDataFileHavingMaxFileName ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify validation message while taking the backup of large char data file.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	3/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test20_VerifyValidationMessageOfDataFileHavingMaxFileName() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sFileName = "Quicken Data File having max number of characters in File name for verification of Quicken backup functionality Quicken Data File having max number of characters in File name for verificationQuicken Data FileQuicken Data File having ma"
		[ ] STRING sLongFileNameMessage1="The file name is too long."
		[ ] STRING sLongFileNameMessage2="Please use 208 or less characters."
		[ ] 
	[+] if(QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.NewQuickenFile.Select()
		[+] if (CreateNewFile.Exists(2))
			[ ] CreateNewFile.SetActive()
			[ ] CreateNewFile.OK.Click()
		[+] if (ImportExportQuickenFile.Exists(10))
			[ ] ImportExportQuickenFile.SetActive()
			[ ] ImportExportQuickenFile.FileName.SetText("{ROOT_PATH}")
			[ ] ImportExportQuickenFile.OK.Click()
			[ ] ImportExportQuickenFile.FileName.SetText("{sFileName}")
			[ ] ImportExportQuickenFile.OK.Click()
			[+] if(AlertMessage.Exists(2))
				[ ] AlertMessage.SetActive()
				[ ] sActual=AlertMessage.MessageText.GetText()
				[ ] bMatch=MatchStr("{sLongFileNameMessage1}*{sLongFileNameMessage2}",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Validate File Name",PASS,"Alert message is displayed for long file name, Message is {sLongFileNameMessage1} {sLongFileNameMessage2} ")
				[+] else
					[ ] ReportStatus("Validate File Name",FAIL,"Correct Alert message is not displayed for long file name, Actual Message is {sActual} and Expected message is {sLongFileNameMessage1} {sLongFileNameMessage2} ")
					[ ] 
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.OK.Click()
				[ ] WaitForState(AlertMessage,False,5)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify validation message for long file name",FAIL,"Validation message is not displayed for long file name")
			[ ] ImportExportQuickenFile.SetActive()
			[ ] ImportExportQuickenFile.Cancel.Click()
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not displayed")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify the action while taking the backup of large char data file. #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_VerifyBackupOfDataFileHavingMaxFileName ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the action while taking the backup of large char data file.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	3/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test21_VerifyBackupOfDataFileHavingMaxFileName() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sLongFileName="Quicken Data File having max number of characters in File name for verification of Quicken backup functionality Quicken Data File having max number of characters in File name for verification"
		[ ] sFilePath=ROOT_PATH+"\"
		[ ] 
	[ ] iResult=DataFileCreate(sLongFileName,ROOT_PATH)
	[+] if(iResult == PASS)
		[ ] ReportStatus("Verify Data file created with max file name",PASS,"Data file with long length file name is created successfully ")
		[ ] iValidate=QuickenBackup(sFilePath,sLongFileName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Backup Data File having long length file name", PASS ,"Data File: {sLongFileName} backed up successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Backup Data File having long length file name", FAIL ,"Data File: {sLongFileName} is not backed up successfully.")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Data file created with max file name",FAIL,"Data file with long length file name is not created successfully")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify Data file restore operation for large char data file ################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_VerifyRestoreOfDataFileHavingMaxFileName ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Data file restore operation for large char data file
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	07/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test22_VerifyRestoreOfDataFileHavingMaxFileName() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sLongFileName="Quicken Data File having max number of characters in File name for verification of Quicken backup functionality Quicken Data File having max number of characters in File name for verification"
		[ ] sFilePath=ROOT_PATH+"\"
		[ ] STRING sBackupFileName = "WALL_FileManagement"
		[ ] STRING sTarget= AUT_DATAFILE_PATH+"\"+"FileIO"+"\{sBackupFileName}.QDF-backup"
		[ ] 
	[ ] iResult=OpenDataFile(sBackupFileName)
	[+] if(iResult == PASS)
		[ ] ReportStatus("Verify Data file with max file name is opened",PASS,"Data file with long length file name is opened successfully ")
		[ ] 
		[ ] iValidate=QuickenRestore(sFilePath,sLongFileName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Restore Data File having long length file name", PASS ,"Data File: {sLongFileName} Restored successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Restore Data File having long length file name", FAIL ,"Data File: {sLongFileName} is not Restored successfully.")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Data file with max file name is opened",FAIL,"Data file with long length file name is not opened successfully")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify restore feature for Slient Launch #############################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_VerifyRestoreOfDataFileSilentQuickenLaunch()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify restore feature when there is no file opened with Quicken.  (Slient Launch)
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	13/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test23_VerifyRestoreOfDataFileSilentQuickenLaunch() appstate none
	[+] // Variable declaration
		[ ] 
		[ ] STRING sRestoreFilePath, sLocationToRestore,sBackupLocation,sBackupFile
		[ ]   sTempFile ="DefaultRestoredTempFile"
		[ ] sBackupFile= "{sTempFile}.QDF-backup"
		[ ] sLocationToRestore= AUT_DATAFILE_PATH + "\File Management data"
		[ ] sBackupLocation= sLocationToRestore + "\"
		[ ] 
		[ ] // sFilePath =AUT_DATAFILE_PATH+"\" +sTempFile+".QDF-backup"
		[ ] sFilePath =AUT_DATAFILE_PATH+"\" 
	[ ] 
	[ ] iResult=OpenDataFile(sTempFile,sLocationToRestore)
	[+] if(iResult == PASS)
		[ ] ReportStatus("Verify Data file {sTempFile} is opened",PASS,"Data file {sTempFile} is opened successfully ")
		[ ] 
		[ ] iValidate=QuickenBackup(sBackupLocation,sBackupFile)
		[+] if(iValidate==PASS)
			[ ] 
			[+] if(QuickenWindow.Exists(2))
				[ ] QuickenWindow. PressKeys("<Left Ctrl>")
				[ ] QuickenWindow.kill()
				[ ] WaitForState(QuickenWindow,FALSE,3)
				[ ] App_start(sCmdLine)
				[ ] WaitForState(QuickenWindow,TRUE,5)
				[ ] sleep(3)
				[ ] QuickenWindow.ReleaseKeys("<Left Ctrl>")
				[ ] 
				[ ] iValidate=QuickenRestore(sBackupLocation,sTempFile,AUT_DATAFILE_PATH)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Restore Data File with silent Quicken launch", PASS ,"Data File: {sTempFile} Restored successfully even after quicken is launched silently.")
					[ ] 
				[+] else
					[ ] ReportStatus("Restore Data File with silent Quicken launch", FAIL ,"Data File: {sTempFile} Restored successfully even after quicken is launched silently.")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not launched")
		[+] else
			[ ] ReportStatus("Verify backup of opened file",FAIL,"Opened data file is not backed up successfully")
	[+] else
		[ ] ReportStatus("Verify data file {sTempFile} open",FAIL,"Data File {sTempFile} is not opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify restore feature form New user Flow using menu on Get started window ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_VerifyRestoreFromNewUserFlowUsingMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify restore feature when there is no file opened with Quicken.  (New user Flow using menu on Get started window)
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 		if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	20/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test24_VerifyRestoreFromNewUserFlowUsingMenu() appstate none
	[+] // Variable declaration
		[ ] 
		[ ] STRING sRestoreFilePath, sLocationToRestore,sBackupLocation,sBackupFile
		[ ]   sTempFile ="DefaultRestoredTempFile"
		[ ] sBackupFile= "{sTempFile}.QDF-backup"
		[ ] sLocationToRestore= AUT_DATAFILE_PATH + "\File Management data"
		[ ] sBackupLocation= sLocationToRestore + "\"
		[ ] sFilePath =AUT_DATAFILE_PATH+"\" 
		[ ] 
	[ ] 
	[ ] // Close Quicken
	[ ] QuickenWindow.kill()
	[ ] // Delete the data File
	[+] if(!QuickenWindow.Exists(3))
		[ ] bMatch=DeleteFile("{sFilePath}{sTempFile}.QDF")
		[+] if(bMatch==TRUE)
			[ ] 
			[ ] // Verify backup file exists or not
			[ ] bCaption=FileExists("{sBackupLocation}\{sBackupFile}")
			[+] if(bCaption==TRUE)
				[ ] // Start Quicken
				[ ] App_start(sCmdLine)
				[ ] WaitForState(QuickenWindow,TRUE,5)
				[ ] 
				[ ] iValidate=QuickenRestore(sBackupLocation,sTempFile,AUT_DATAFILE_PATH)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Restore Data File form New user Flow using menu on Get started window", PASS ,"Data File: {sTempFile} Restored successfully form New user Flow using menu on Get started window.")
					[ ] 
				[+] else
					[ ] ReportStatus("Restore Data File form New user Flow using menu on Get started window", FAIL ,"Data File: {sTempFile} is not Restored successfully form New user Flow using menu on Get started window")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify backup file exists",FAIL,"Backup file does not exist at {sBackupLocation}\{sBackupFile}")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify data file is deleted",FAIL,"Data file is not deleted")
	[+] else
		[ ] ReportStatus("Verify Quicken is closed",FAIL,"Quicken is not closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify restore feature form New user Flow by clicking Get started button #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_VerifyRestoreFromNewUserFlowByClickingGetStartedButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify restore feature when there is no file opened with Quicken.  (New user Flow by clicking Get started button)
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	20/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[-] testcase Test25_VerifyRestoreFromNewUserFlowByClickingGetStartedButton() appstate none
	[+] // Variable declaration
		[ ] 
		[ ] STRING sRestoreFilePath, sLocationToRestore,sBackupLocation,sBackupFile
		[ ]   sTempFile ="DefaultRestoredTempFile"
		[ ] sBackupFile= "{sTempFile}.QDF-backup"
		[ ] sLocationToRestore= AUT_DATAFILE_PATH + "\File Management data"
		[ ] sBackupLocation= sLocationToRestore + "\"
		[ ] sFilePath =AUT_DATAFILE_PATH+"\" 
		[ ] 
	[ ] // Close Quicken
	[ ] QuickenWindow.kill()
	[ ] // Delete the data File
	[+] if(!QuickenWindow.Exists(3))
		[ ] bMatch=DeleteFile("{sFilePath}{sTempFile}.QDF")
		[-] if(bMatch==TRUE)
			[ ] 
			[ ] // Verify backup file exists or not
			[ ] bCaption=FileExists("{sBackupLocation}\{sBackupFile}")
			[-] if(bCaption==TRUE)
				[ ] // Start Quicken
				[ ] App_start(sCmdLine)
				[ ] WaitForState(QuickenWindow,TRUE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.RestoreaDataFile.Check()
				[ ] QuickenWindow.GetStarted.Select()
				[+] if(QuickenRestore.Exists(5))
					[ ] QuickenRestore.SetActive()
					[ ] QuickenRestore.Close()
				[+] else
					[ ] ReportStatus("Verify Quicken Restore window after clicking on gat started button",FAIL,"Quicken Restore window is not displayed")
				[+] if(QuickenWindow.RestoreaDataFile.Exists(2))
					[ ] QuickenWindow.RestoreaDataFile.Check()
					[ ] QuickenWindow.GetStarted.Select()
					[+] if(QuickenRestore.Exists(5))
						[ ] QuickenRestore.SetActive()
						[ ] // Select option: Restore from your backup
						[ ] QuickenRestore.RestoreFromBackupFile.Select("#2")
						[ ] // Enter Backup file path and file name
						[ ] QuickenRestore.BackupFilePath.SetText(sBackupLocation + sTempFile + ".QDF-backup" )
						[ ] // Click on RestoreBackup button
						[ ] QuickenRestore.RestoreBackup.Click()
						[+] if(QuickenRestore.LocationToRestore.Exists(3))
							[ ] QuickenRestore.SetActive()
							[ ] QuickenRestore.LocationToRestore.SetText(AUT_DATAFILE_PATH)
						[ ] 
						[ ] QuickenRestore.RestoreBackupButton.Click()
						[ ] 
						[ ] // Verify data file is restored
						[ ] QuickenWindow.SetActive()
						[ ] sActual= QuickenWindow.GetCaption()
						[ ] bMatch = MatchStr("*{sTempFile}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate backup file restore", PASS, "{sTempFile} file restored when there is no file opened with Quicken.  (New user Flow by clicking Get started button)")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate backup file restore", FAIL, "Expected- {sTempFile} is not matching with actual {sActual} ")
							[ ] ReportStatus("Validate backup file restore", FAIL, "{sTempFile} file is not restored when there is no file opened with Quicken.  (New user Flow by clicking Get started button)")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Quicken Restore window after clicking on gat started button",FAIL,"Quicken Restore window is not displayed")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify New User Flow screen after closing Restore from backup file window",FAIL,"New user flow is not displayed defect id = QW-3106")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify backup file exists",FAIL,"Backup file does not exist at {sBackupLocation}\{sBackupFile}")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify data file is deleted",FAIL,"Data file is not deleted")
	[+] else
		[ ] ReportStatus("Verify Quicken is closed",FAIL,"Quicken is not closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify Create New data file feature when there is no file opened with Quicken using menu ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_VerifyCreateNewDataFileFromNewUserFlowUsingMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Create New data file feature when there is no file opened with Quicken.  (New user Flow using menu on Get started window)
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	20/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test26_VerifyCreateNewDataFileFromNewUserFlowUsingMenu() appstate none
	[+] // Variable declaration
		[ ] STRING sFileWithPath
		[ ] sTempFile ="DefaultRestoredTempFile"
		[ ] sFilePath =AUT_DATAFILE_PATH+"\" 
		[ ] sFileWithPath = sFilePath + sTempFile + ".QDF"
		[ ] 
	[ ] // Close Quicken
	[ ] QuickenWindow.kill()
	[ ] // Delete the data File
	[+] if(!QuickenWindow.Exists(3))
		[ ] bMatch=DeleteFile("{sFilePath}{sTempFile}.QDF")
		[+] if(bMatch==TRUE)
			[ ] 
			[ ] // Start Quicken
			[ ] App_start(sCmdLine)
			[ ] WaitForState(QuickenWindow,TRUE,5)
			[ ] sleep(2)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.MainMenu.Select("/_File/_New Quicken File...")
			[+] if (ImportExportQuickenFile.Exists(10))
				[ ] ImportExportQuickenFile.SetActive()
				[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
				[ ] ImportExportQuickenFile.OK.Click()
				[ ] 
				[ ] // Verify data file is created
				[ ] QuickenWindow.SetActive()
				[ ] sActual= QuickenWindow.GetCaption()
				[ ] bMatch = MatchStr("*{sTempFile}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate create data file when there is no file opened with Quicken.  (New user Flow using menu on Get started window) ", PASS, "{sTempFile} file created when there is no file opened with Quicken.  (New user Flow using menu on Get started window)")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate create new data file", FAIL, "Expected- {sTempFile} is not matching with actual {sActual} ")
					[ ] ReportStatus("Validate create data file when there is no file opened with Quicken.  (New user Flow using menu on Get started window) ", FAIL, "{sTempFile} file is not created when there is no file opened with Quicken.  (New user Flow using menu on Get started window)")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Create Quicken File dialog",FAIL,"Create Quicken File dialog is not displayed")
		[+] else
			[ ] ReportStatus("Verify data file is deleted",FAIL,"Data file is not deleted")
	[+] else
		[ ] ReportStatus("Verify Quicken is closed",FAIL,"Quicken is not closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify Create New data file feature when there is no file opened with Quicken  by clicking Get started button ####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_VerifyCreateNewDataFileFromNewUserFlowByClickingGetStartedButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Create New data file feature when there is no file opened with Quicken.  (New user Flow by clicking Get started button)
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	21/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test27_VerifyCreateNewDataFileFromNewUserFlowByClickingGetStartedButton() appstate none
	[+] // Variable declaration
		[ ] STRING sFileWithPath
		[ ] sTempFile ="DefaultRestoredTempFile"
		[ ] sFilePath =AUT_DATAFILE_PATH+"\" 
		[ ] sFileWithPath = sFilePath + sTempFile + ".QDF"
		[ ] 
	[ ] // Close Quicken
	[ ] QuickenWindow.kill()
	[ ] // Delete the data File
	[+] if(!QuickenWindow.Exists(3))
		[ ] bMatch=DeleteFile("{sFilePath}{sTempFile}.QDF")
		[+] if(bMatch==TRUE)
			[ ] 
			[ ] // Start Quicken
			[ ] App_start(sCmdLine)
			[ ] WaitForState(QuickenWindow,TRUE,5)
			[ ] sleep(2)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.CreateNewDataFileRB.Check()
			[ ] QuickenWindow.GetStarted.Select()
			[+] if(ImportExportQuickenFile.Exists(5))
				[ ] ImportExportQuickenFile.SetActive()
				[ ] ImportExportQuickenFile.Close()
			[+] else
				[ ] ReportStatus("Verify Create Quicken File window after clicking on gat started button",FAIL,"Create Quicken File window is not displayed")
			[ ] 
			[ ] // New user flow page
			[+] if (QuickenWindow.CreateNewDataFileRB.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.CreateNewDataFileRB.Check()
				[ ] QuickenWindow.GetStarted.Select()
				[+] if(ImportExportQuickenFile.Exists(5))
					[ ] ImportExportQuickenFile.SetActive()
					[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
					[ ] ImportExportQuickenFile.OK.Click()
					[ ] // Verify data file is created
					[ ] QuickenWindow.SetActive()
					[ ] sActual= QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{sTempFile}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate create data file when there is no file opened with Quicken.(New user Flow by clicking Get started button)", PASS, "{sTempFile} file created when there is no file opened with Quicken.(New user Flow by clicking Get started button)")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate create new data file", FAIL, "Expected- {sTempFile} is not matching with actual {sActual} ")
						[ ] ReportStatus("Validate create data file when there is no file opened with Quicken. (New user Flow by clicking Get started button)", FAIL, "{sTempFile} file is not created when there is no file opened with Quicken. (New user Flow by clicking Get started button)")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Create Quicken File window after clicking on gat started button",FAIL,"Create Quicken File window is not displayed")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify New User Flow screen after closing Create Quicken File window",FAIL,"New user flow is not displayed defect id = QW-3106")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify data file is deleted",FAIL,"Data file is not deleted")
	[+] else
		[ ] ReportStatus("Verify Quicken is closed",FAIL,"Quicken is not closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify Open data file feature when there is no file opened with Quicken using menu ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_VerifyOpenDataFileFromNewUserFlowUsingMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Open data file feature when there is no file opened with Quicken.  (New user Flow using menu on Get started window)
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	21/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test28_VerifyOpenDataFileFromNewUserFlowUsingMenu() appstate none
	[+] // Variable declaration
		[ ] STRING sFileWithPath,sOpenFile
		[ ] sTempFile ="DefaultRestoredTempFile"
		[ ] sFilePath =AUT_DATAFILE_PATH+"\" 
		[ ] sOpenFile="Export"
		[ ] sFileWithPath = sFilePath + "File Management data\{sOpenFile}.QDF"
		[ ] 
	[ ] // Close Quicken
	[ ] QuickenWindow.kill()
	[ ] // Delete the data File
	[+] if(!QuickenWindow.Exists(3))
		[ ] bMatch=DeleteFile("{sFilePath}{sTempFile}.QDF")
		[+] if(bMatch==TRUE)
			[ ] 
			[ ] // Start Quicken
			[ ] App_start(sCmdLine)
			[ ] WaitForState(QuickenWindow,TRUE,5)
			[ ] sleep(2)
			[ ] 
			[+] if(FileExists(sFileWithPath))
				[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.MainMenu.Select("/_File/_Open Quicken File...")
				[ ] 
				[+] if (ImportExportQuickenFile.Exists(10))
					[ ] ImportExportQuickenFile.SetActive()
					[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
					[ ] ImportExportQuickenFile.OK.Click()
					[ ] 
					[ ] // Verify data file is created
					[ ] QuickenWindow.SetActive()
					[ ] sActual= QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{sOpenFile}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate open data file when there is no file opened with Quicken.  (New user Flow using menu on Get started window) ", PASS, "{sOpenFile} file opend when there is no file opened with Quicken.  (New user Flow using menu on Get started window)")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate open new data file", FAIL, "Expected- {sOpenFile} is not matching with actual {sActual} ")
						[ ] ReportStatus("Validate open data file when there is no file opened with Quicken.  (New user Flow using menu on Get started window) ", FAIL, "{sOpenFile} file is not opend when there is no file opened with Quicken.  (New user Flow using menu on Get started window)")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify open Quicken File dialog",FAIL,"open Quicken File dialog is not displayed")
			[+] else
				[ ] ReportStatus("Verify {sOpenFile} data file exists", FAIL,"Data file {sFileWithPath} does not exist ")
		[+] else
			[ ] ReportStatus("Verify data file is deleted",FAIL,"Data file is not deleted")
	[+] else
		[ ] ReportStatus("Verify Quicken is closed",FAIL,"Quicken is not closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify Open data file feature when there is no file opened with Quicken  by clicking Get started button #########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_VerifyOpenDataFileFromNewUserFlowByClickingGetStartedButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Open data file feature when there is no file opened with Quicken.  (New user Flow by clicking Get started button)
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	21/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test29_VerifyOpenDataFileFromNewUserFlowByClickingGetStartedButton() appstate none
	[+] // Variable declaration
		[ ] STRING sFileWithPath,sOpenFile
		[ ] sTempFile ="FMTest"
		[ ] sFilePath =AUT_DATAFILE_PATH+"\" 
		[ ] sOpenFile="DefaultRestoredTempFile.QDF-backup"
		[ ] // sFileWithPath = sFilePath + "File Management data\{sOpenFile}.QDF"
		[ ] sFileWithPath=sFilePath + "File Management data\{sOpenFile}"
		[ ] 
		[ ] 
	[ ] //Pre requisit
	[ ] iValidate=DataFileCreate(sTempFile,AUT_DATAFILE_PATH)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Close Quicken
		[ ] QuickenWindow.kill()
		[ ] // Delete the data File
		[+] if(!QuickenWindow.Exists(3))
			[ ] bMatch=DeleteFile("{sFilePath}{sTempFile}.QDF")
			[+] if(bMatch==TRUE)
				[ ] 
				[ ] //Start Quicken
				[ ] App_start(sCmdLine)
				[ ] WaitForState(QuickenWindow,TRUE,5)
				[ ] sleep(2)
				[ ] 
				[+] if(FileExists(sFileWithPath))
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] // New user flow page
					[+] if (QuickenWindow.OpenDataFileRB.Exists(5))
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.OpenDataFileRB.Check()
						[ ] QuickenWindow.GetStarted.Select()
						[+] if(ImportExportQuickenFile.Exists(5))
							[ ] ImportExportQuickenFile.SetActive()
							[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
							[ ] // ImportExportQuickenFile.FileName.SetText(sOpenFile)
							[ ] 
							[ ] ImportExportQuickenFile.OK.Click()
							[ ] 
							[+] if(QuickenRestore.Exists(3))
								[ ] QuickenRestore.SetActive()
								[ ] ReportStatus("Verify Location to Restore textbox",PASS,"Location to Restore textbox is available")
								[ ] QuickenRestore.LocationToRestore.SetText("{sFilePath}{sTempFile}.QDF")
								[ ] QuickenRestore.RestoreBackupButton.Click()
								[ ] 
								[ ] // Verify data file is Opend
								[ ] QuickenWindow.SetActive()
								[ ] sActual= QuickenWindow.GetCaption()
								[ ] bMatch = MatchStr("*{sTempFile}*", sActual)
								[+] if(bMatch == TRUE)
									[ ] ReportStatus("Validate Open data file when there is no file opened with Quicken.(New user Flow by clicking Get started button)", PASS, "{sOpenFile} file Opend when there is no file opened with Quicken.(New user Flow by clicking Get started button)")
									[ ] 
									[ ] //Verify home tab
									[+] if(QuickenMainWindow.Customize.Exists(2))
										[ ] ReportStatus("Verify Home tab",PASS,"Home tab is displayed correctly as Customize button is available")
									[+] else
										[ ] ReportStatus("Verify Home tab",FAIL,"Home tab is not displayed correctly as Customize button is not available: defect id: QW007349")
										[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Validate Open new data file", FAIL, "Expected- {sOpenFile} is not matching with actual {sActual} ")
									[ ] ReportStatus("Validate Open data file when there is no file opened with Quicken. (New user Flow by clicking Get started button)", FAIL, "{sOpenFile} file is not Opend when there is no file opened with Quicken. (New user Flow by clicking Get started button)")
									[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Location to Restore textbox",FAIL,"Location to Restore textbox is not available")
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Open Quicken File window after clicking on gat started button",FAIL,"Open Quicken File window is not displayed")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify New User Flow screen after closing Open Quicken File window",FAIL,"New user flow is not displayed defect id = QW-3106")
				[+] else
					[ ] ReportStatus("Verify {sOpenFile} data file exists", FAIL,"Data file {sFileWithPath} does not exist ")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify data file is deleted",FAIL,"Data file is not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken is closed",FAIL,"Quicken is not closed")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify data file Created",FAIL,"Data file {sTempFile} is not Created")
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify  Help link on Quicken backup dialog #########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test26_VerifyHelpLinkOnBackupDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify  Help link on Quicken backup dialog
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	24/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test30_VerifyHelpLinkOnBackupDialog() appstate none
	[+] // Variable declaration
		[ ] STRING sText
		[ ] sTempFile ="TempFileManagementFile"
		[ ] sText= "Back up my Quicken data file"
		[ ] 
		[ ] 
	[ ] // Pre requisit
	[ ] iValidate=DataFileCreate(sTempFile,AUT_DATAFILE_PATH)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Activate Quicken window
		[ ] QuickenWindow.SetActive()
		[+] do
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[ ] 
		[+] except
			[ ] QuickenWindow.TypeKeys("<Ctrl-b>")
		[ ] 
		[+] if(QuickenBackup.Exists(2))
			[ ] QuickenBackup.SetActive()
			[ ] QuickenBackup.HelpButton.Click()
			[+] if(QuickenHelp.Exists(2))
				[ ] ReportStatus("Verify Quicken Help window", PASS, "Quicken Help window is displayed by clicking on Help button on Quicken Backup window")
				[ ] QuickenHelp.SetActive()
				[+] do
					[ ] QuickenHelp.TextClick(sText)
					[ ] ReportStatus("Verify Help content",PASS,"{sText} content is opened in Quicken Help window")
					[ ] QuickenHelp.Close()
				[+] except
					[ ] QuickenHelp.Close()
					[ ] ExceptLog()
			[+] else
				[ ] ReportStatus("Verify Quicken Help window", FAIL, "Quicken Help window is not displayed by clicking on Help button on Quicken Backup window")
				[ ] 
			[ ] QuickenBackup.SetActive()
			[ ] QuickenBackup.Close()
		[+] else
			[ ] ReportStatus("Verify Quicken Backup window", FAIL,"Quicken Backup window is not displayed")
	[+] else
		[ ] ReportStatus("Verify data file Created",FAIL,"Data file {sTempFile} is not Created")
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify  Help link on Quicken Restore dialog #########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_VerifyHelpLinkOnRestoreDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify  Help link on restore dialog
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	24/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test31_VerifyHelpLinkOnRestoreDialog() appstate none
	[+] // Variable declaration
		[ ] STRING sText,sFileWithPath
		[ ] sTempFile ="TempFileManagementFile"
		[ ] sText= "Restore a Quicken data file from a backup file"
		[ ] sFileWithPath=AUT_DATAFILE_PATH+"\{sTempFile}.QDF"
		[ ] 
	[ ] // Pre requisit
	[+] if(FileExists(sFileWithPath))
		[ ] 
		[ ] START:
		[ ] 
		[ ] // Activate Quicken window
		[ ] QuickenWindow.SetActive()
		[+] do
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.RestoreFromBackupFile.Select()
			[ ] 
		[+] except
			[ ] QuickenWindow.MainMenu.Select("/_File/_Backup and Restore/_Restore from Backup File...")
		[ ] 
		[+] if(QuickenRestore.Exists(2))
			[ ] QuickenRestore.SetActive()
			[ ] QuickenRestore.HelpButton.Click()
			[+] if(QuickenHelp.Exists(2))
				[ ] ReportStatus("Verify Quicken Help window", PASS, "Quicken Help window is displayed by clicking on Help button on Quicken Restore window")
				[ ] QuickenHelp.SetActive()
				[+] do
					[ ] QuickenHelp.TextClick(sText)
					[ ] ReportStatus("Verify Help content",PASS,"{sText} content is opened in Quicken Help window")
					[ ] QuickenHelp.Close()
				[+] except
					[ ] QuickenHelp.Close()
					[ ] ExceptLog()
			[+] else
				[ ] ReportStatus("Verify Quicken Help window", FAIL, "Quicken Help window is not displayed by clicking on Help button on Quicken Restore window")
				[ ] 
			[ ] QuickenRestore.SetActive()
			[ ] QuickenRestore.Close()
		[+] else
			[ ] ReportStatus("Verify Quicken Backup window", FAIL,"Quicken Backup window is not displayed")
	[+] else
		[ ] DataFileCreate(sTempFile,AUT_DATAFILE_PATH)
		[ ] goto START
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Validation for blank file name while backing up files. ##################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_ValidateBlankFileNameOnBackupDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify validation for blank file name.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	25/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test32_ValidateBlankFileNameOnBackupDialog() appstate none
	[+] // Variable declaration
		[ ] STRING sExpectedMessage,sFileWithPath
		[ ] sTempFile ="TempFileManagementFile"
		[ ] sExpectedMessage= "Please enter a path to the backup directory."
		[ ] sFileWithPath=AUT_DATAFILE_PATH+"\{sTempFile}.QDF"
		[ ] 
	[ ] // Pre requisit
	[+] if(FileExists(sFileWithPath))
		[ ] 
		[ ] START:
		[ ] 
		[ ] // Activate Quicken window
		[ ] QuickenWindow.SetActive()
		[+] do
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.BackupAndRestore.Click()
			[ ] QuickenWindow.File.BackupAndRestore.BackUpQuickenFile.Select()
			[ ] 
		[+] except
			[ ] QuickenWindow.TypeKeys("<Ctrl-b>")
		[ ] 
		[+] if(QuickenBackup.Exists(2))
			[ ] QuickenBackup.SetActive()
			[ ] //____________________________________________________________________________________________
			[ ] // Validate blank File name
			[ ] QuickenBackup.BackupFile.SetText("")
			[ ] 
			[ ] // Click on Change button
			[ ] QuickenBackup.Change.Click()
			[+] if(QuickenBackup.DlgEnterBackupFileName.Exists(2))
				[ ] ReportStatus("Verify that Enter backup file name dialog is opened after clicking on change button",PASS,"Enter backup file name dialog is opened after clicking on change button on Quicken backup window")
				[ ] QuickenBackup.DlgEnterBackupFileName.Close()
				[ ] sleep(1)
			[+] else
				[ ] ReportStatus("Verify that Enter backup file name dialog is opened after clicking on change button",FAIL,"Enter backup file name dialog is not opened after clicking on change button on Quicken backup window")
				[ ] 
			[ ] 
			[ ] // Click on Backup Now button
			[ ] QuickenBackup.BackUpNow.Click()
			[+] if(BackupConfirmation.Exists(3))
				[ ] ReportStatus("Verify alert message displayed if blank file name entered while backup",PASS,"Validation message is displayed if blank file name provided in Quicken Backup window")
				[ ] 
				[ ] BackupConfirmation.SetActive()
				[ ] sActual= BackupConfirmation.Message.GetText()
				[ ] BackupConfirmation.OK.Click()
				[+] if(sActual==sExpectedMessage)
					[ ] ReportStatus("Verify alert message displayed if blank file name entered while backup",PASS,"Expected alert message is displayed when blank file name entered in Quicken Backup window, message - {sActual}")
				[+] else 
					[ ] ReportStatus("Verify alert message displayed if blank file name entered while backup", FAIL, "Actual alert message {sActual} is not matching with expected {sExpectedMessage} ")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify alert message displayed if blank file name entered while backup",FAIL,"Validation message is not displayed even if blank file name provided in Quicken Backup window")
				[ ] 
			[ ] //_____________________________________________________________________________________________
			[ ] // Validate File name with spaces
			[ ] QuickenBackup.BackupFile.SetText("           .QDF-backup")
			[ ] // Click on Backup Now button
			[ ] QuickenBackup.BackUpNow.Click()
			[+] if(BackupConfirmation.Exists(3))
				[ ] ReportStatus("Verify alert message displayed if file name having only spaces while backup",PASS,"Validation message is displayed if only spaces are provided as file name in Quicken Backup window")
				[ ] 
				[ ] BackupConfirmation.SetActive()
				[ ] sActual= BackupConfirmation.Message.GetText()
				[ ] BackupConfirmation.OK.Click()
				[+] if(sActual==sExpectedMessage)
					[ ] ReportStatus("Verify alert message displayed if file name having only spaces while backup",PASS,"Expected alert message is displayed when only spaces as file name entered in Quicken Backup window, message - {sActual}")
				[+] else 
					[ ] ReportStatus("Verify alert message displayed if file name having only spaces while backup", FAIL, "Actual alert message {sActual} is not matching with expected {sExpectedMessage} ")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify alert message displayed if file name having only spaces while backup",FAIL,"Validation message is not displayed even if only spaces are provided as file name in Quicken Backup window")
				[ ] 
			[ ] 
			[ ] QuickenBackup.Close()
		[+] else
			[ ] ReportStatus("Verify Quicken Backup window is opened",FAIL,"Quicken Backup window is not displayed")
		[ ] 
	[+] else
		[ ] DataFileCreate(sTempFile,AUT_DATAFILE_PATH)
		[ ] goto START
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify Quicken backup feature by putting target location "\\" ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_ValidateSpecialCharactersAsFileNameOnBackupDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Quicken backup feature by putting target location "\\".
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	25/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test33_ValidateSpecialCharactersAsFileNameOnBackupDialog() appstate none
	[+] // Variable declaration
		[ ] STRING sExpectedMessage,sFileWithPath,sMessage,sText
		[ ] sTempFile ="TempFileManagementFile"
		[ ] sExpectedMessage= "Quicken can't find the network path \\. Check the formatting of the network path. It should be formatted like this: \\network_path\..."
		[ ] sMessage="Please enter a valid directory."
		[ ] sFileWithPath=AUT_DATAFILE_PATH+"\{sTempFile}.QDF"
		[ ] sText= "Please enter a path to the backup directory."
		[ ] 
		[ ] 
	[ ] // Pre requisit
	[+] if(FileExists(sFileWithPath))
		[ ] 
		[ ] START:
		[ ] 
		[ ] iValidate=QuickenBackupNavigation()
		[+] if(iValidate==PASS)
			[ ] //____________________________________________________________________________________________
			[ ] // Validate \\ File name
			[ ] QuickenBackup.BackupFile.SetText("\\")
			[ ] // Click on Backup Now button
			[ ] QuickenBackup.BackUpNow.Click()
			[+] if(AlertMessage.Exists(3))
				[ ] ReportStatus("Verify alert message displayed if double backslash entered as file name while backup",PASS,"Validation message is displayed if double backslash entered as file name in Quicken Backup window")
				[ ] 
				[ ] AlertMessage.SetActive()
				[ ] sActual= AlertMessage.MessageText.GetText()
				[ ] AlertMessage.OK.Click()
				[+] if(sActual==sExpectedMessage)
					[ ] ReportStatus("Verify alert message displayed if double backslash entered as file name while backup",PASS,"Expected alert message is displayed when double backslash entered as file name in Quicken Backup window, message - {sActual}")
				[+] else 
					[ ] ReportStatus("Verify alert message displayed if double backslash entered as file name while backup", FAIL, "Actual alert message {sActual} is not matching with expected {sExpectedMessage} ")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify alert message displayed if double backslash file name entered while backup",FAIL,"Validation message is not displayed even if double backslash file name provided in Quicken Backup window")
				[ ] 
			[ ] 
			[ ] //____________________________________________________________________________________________
			[ ] // Validate \ File name
			[ ] QuickenBackup.BackupFile.SetText("\")
			[ ] // Click on Backup Now button
			[ ] QuickenBackup.BackUpNow.Click()
			[+] if(AlertMessage.Exists(3))
				[ ] ReportStatus("Verify alert message displayed if single backslash entered as file name while backup",PASS,"Validation message is displayed if single backslash entered as file name in Quicken Backup window")
				[ ] 
				[ ] AlertMessage.SetActive()
				[ ] sActual= AlertMessage.MessageText.GetText()
				[ ] AlertMessage.OK.Click()
				[+] if(sActual==sExpectedMessage)
					[ ] ReportStatus("Verify alert message displayed if single backslash entered as file name while backup",PASS,"Expected alert message is displayed when single backslash entered as file name in Quicken Backup window, message - {sActual}")
				[+] else 
					[ ] ReportStatus("Verify alert message displayed if single backslash entered as file name while backup", FAIL, "Actual alert message {sActual} is not matching with expected {sExpectedMessage} ")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify alert message displayed if  single backslash file name entered while backup",FAIL,"Validation message is not displayed even if single backslash file name provided in Quicken Backup window")
				[ ] 
			[ ] 
			[ ] //_____________________________________________________________________________________________
			[ ] // Validate File name as !@#$
			[ ] QuickenBackup.BackupFile.SetText("!@#$")
			[ ] // Click on Backup Now button
			[ ] QuickenBackup.BackUpNow.Click()
			[+] if(AlertMessage.Exists(3))
				[ ] ReportStatus("Verify alert message displayed if file name having only special characters while backup",PASS,"Validation message is displayed if only special characters are provided as file name in Quicken Backup window")
				[ ] 
				[ ] AlertMessage.SetActive()
				[ ] sActual= AlertMessage.MessageText.GetText()
				[ ] AlertMessage.OK.Click()
				[+] if(sActual==sMessage)
					[ ] ReportStatus("Verify alert message displayed if file name having only special characters while backup",PASS,"Expected alert message is displayed when only special characters entered as file name in Quicken Backup window, message - {sActual}")
				[+] else 
					[ ] ReportStatus("Verify alert message displayed if file name having only special characters while backup", FAIL, "Actual alert message {sActual} is not matching with expected {sExpectedMessage} ")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify alert message displayed if file name having only spaces while backup",FAIL,"Validation message is not displayed even if only spaces are provided as file name in Quicken Backup window")
				[ ] 
			[ ] 
			[ ] //_____________________________________________________________________________________________
			[ ] // Validate File name as !@#$.QDF-backup
			[ ] QuickenBackup.BackupFile.SetText("!@#$.QDF-backup")
			[ ] // Click on Backup Now button
			[ ] QuickenBackup.BackUpNow.Click()
			[+] if(BackupConfirmation.Exists(3))
				[ ] ReportStatus("Verify alert message displayed if file name !@#$.QDF-backup while backup",PASS,"Validation message is displayed if !@#$.QDF-backup is provided as file name in Quicken Backup window")
				[ ] 
				[ ] BackupConfirmation.SetActive()
				[ ] sActual= BackupConfirmation.Message.GetText()
				[ ] BackupConfirmation.OK.Click()
				[+] if(sActual==sText)
					[ ] ReportStatus("Verify alert message displayed if file name having !@#$.QDF-backup while backup",PASS,"Expected alert message is displayed when !@#$.QDF-backup as file name entered in Quicken Backup window, message - {sActual}")
				[+] else 
					[ ] ReportStatus("Verify alert message displayed if file name having !@#$.QDF-backup while backup", FAIL, "Actual alert message {sActual} is not matching with expected {sExpectedMessage} ")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify alert message displayed if file name having !@#$.QDF-backup while backup",FAIL,"Validation message is not displayed even if !@#$.QDF-backup is provided as file name in Quicken Backup window")
				[ ] 
			[ ] 
			[+] if(QuickenBackup.Exists(2))
				[ ] QuickenBackup.Close()
		[+] else
			[ ] ReportStatus("Verify Quicken backup navigation",FAIL,"Quicken backup navigation is failed")
		[ ] 
	[+] else
		[ ] DataFileCreate(sTempFile,AUT_DATAFILE_PATH)
		[ ] goto START
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Validate Backup success notification dialog ########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_ValidateBackupSuccessDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Backup success notification dialog 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	26/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test34_ValidateBackupSuccessDialog() appstate none
	[+] // Variable declaration
		[ ] INTEGER iVerify,iCreate
		[ ] STRING sExpectedMessage,sFileWithPath,sNewDataFile
		[ ] sTempFile ="TempFileManagementFile"
		[ ] sNewDataFile="NewFileMgmtDataFile"
		[ ] sExpectedMessage="Quicken data file backed up successfully."
		[ ] sFileWithPath=AUT_DATAFILE_PATH+"\{sTempFile}.QDF"
		[ ] 
	[ ] // Pre requisit
	[+] if(FileExists(sFileWithPath))
		[ ] 
		[ ] START:
		[ ] 
		[ ] iValidate=QuickenBackupNavigation()
		[+] if(iValidate==PASS)
			[ ] QuickenBackup.BackupFile.SetText(sFileWithPath)
			[ ] 
			[ ] // Click on Backup Now button
			[ ] QuickenBackup.BackUpNow.Click()
			[ ] 
			[+] if(DuplicateBackupFile.Exists(5))
				[ ] DuplicateBackupFile.SetActive()
				[ ] ReportStatus("Verify overwrite backup file",PASS,"Overwrite the previous backup file if we are taking the backup of same data file in same directory.")
				[ ] DuplicateBackupFile.DonTShowAgain.Check()
				[ ] DuplicateBackupFile.Yes.Click()
			[ ] 
			[+] if(BackupConfirmation.Exists(3))
				[ ] ReportStatus("Verify confirmation message displayed after taking backup",PASS,"Confirmation message is displayed after taking backup")
				[ ] BackupConfirmation.SetActive()
				[+] if(BackupConfirmation.DonTShowAgain.Exists(2))
					[ ] ReportStatus("Verify Do not show again checkbox on backup confirmation dialog",PASS,"Do not show again checkbox is available on backup confirmation dialog")
					[ ] sActual= BackupConfirmation.Message.GetText()
					[+] if(sActual==sExpectedMessage)
						[ ] ReportStatus("Verify message displayed on backup confirmation dialog",PASS,"Expected message is displayed on Quicken Backup confirmation dialog, message - {sActual}")
					[+] else 
						[ ] ReportStatus("Verify message displayed on backup confirmation dialog", FAIL, "Actual message {sActual} is not matching with expected {sExpectedMessage} ")
						[ ] 
					[ ] 
					[ ] // Check Do not show again checkbox
					[ ] BackupConfirmation.DonTShowAgain.Check()
					[ ] // Click on OK button
					[ ] BackupConfirmation.OK.Click()
				[+] else
					[ ] ReportStatus("Verify Do not show again checkbox on backup confirmation dialog",FAIL,"Do not show again checkbox is not available on backup confirmation dialog")
				[ ] 
				[ ] // Take backup again to verify the functionality of Do not show again checkbox
				[ ] iNavigate=QuickenBackupNavigation()
				[+] if(iNavigate==PASS)
					[ ] QuickenBackup.BackupFile.SetText(sFileWithPath)
					[ ] 
					[ ] // Click on Backup Now button
					[ ] QuickenBackup.BackUpNow.Click()
					[ ] 
					[+] if(!BackupConfirmation.Exists(3))
						[ ] ReportStatus("Verify functionality of do not show again checkbox for backup confirmation dialog",PASS,"Do not show again checkbox is working as expected as backup confirmation dialog is not displayed")
					[+] else
						[ ] ReportStatus("Verify functionality of do not show again checkbox for backup confirmation dialog",FAIL,"Do not show again checkbox is not working as expected as backup confirmation dialog is displayed")
					[ ] 
					[ ] //Verify that error message is displayed even if do not show again checkbox is checked for backup confirmation
					[ ] iVerify=QuickenBackupNavigation()
					[+] if(iVerify==PASS)
						[ ] // Validate \\ File name
						[ ] QuickenBackup.BackupFile.SetText("\\")
						[ ] // Click on Backup Now button
						[ ] QuickenBackup.BackUpNow.Click()
						[+] if(AlertMessage.Exists(3))
							[ ] ReportStatus("Verify error message is displayed even if do not show again checkbox is checked for backup confirmation dialog",PASS,"Error message is displayed even if do not show again checkbox is checked for backup confirmation dialog")
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.OK.Click()
						[+] else
							[ ] ReportStatus("Verify error message is displayed even if do not show again checkbox is checked for backup confirmation dialog",FAIL,"Error message is not displayed even if do not show again checkbox is checked for backup confirmation dialog")
							[ ] 
							[ ] 
						[+] if(QuickenBackup.Exists(2))
							[ ] QuickenBackup.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Quicken backup navigation",FAIL,"Quicken Backup navigation is failed")
					[ ] 
					[ ] // Verify that  User will be able to see the notification again only when new data file is created
					[ ] iCreate=DataFileCreate(sNewDataFile,AUT_DATAFILE_PATH)
					[+] if(iCreate==PASS)
						[ ] // Navigate to Quicken Backup dialog
						[ ] iNavigate=QuickenBackupNavigation()
						[+] if(iNavigate)
							[ ] QuickenBackup.BackupFile.SetText(AUT_DATAFILE_PATH+"\{sNewDataFile}.QDF")
							[ ] // Click on Backup Now button
							[ ] QuickenBackup.BackUpNow.Click()
							[ ] 
							[+] if(BackupConfirmation.Exists(3))
								[ ] ReportStatus("Verify functionality of do not show again settings for new data file",PASS,"Do not show again checkbox is working as expected as backup confirmation dialog is displayed for new data file")
								[ ] BackupConfirmation.SetActive()
								[ ] BackupConfirmation.Close()
							[+] else
								[ ] ReportStatus("Verify functionality of do not show again settings for new data file",FAIL,"Do not show again checkbox is not working as expected as backup confirmation dialog is not displayed for new data file")
						[+] else
							[ ] ReportStatus("Verify navigation to backup dialog",FAIL,"Navigation to backup dialog failed")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify create new data file",FAIL,"New data file {sNewDataFile} is not created")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Quicken backup navigation",FAIL,"Quicken Backup navigation is failed")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify confirmation message displayed after taking backup",FAIL,"Confirmation message is not displayed after taking backup")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Backup window is opened",FAIL,"Quicken Backup window is not displayed")
		[ ] 
	[+] else
		[ ] DataFileCreate(sTempFile,AUT_DATAFILE_PATH)
		[ ] goto START
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //############# Verify the functionality of Browse button from Quicken Restore ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test31_ValidateBrowseOnQuickenRestoreDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the functionality of Browse button from Quicken Restore
		[ ] //1. Launch Quicken and Go to File->Backup and Restore->Restore Quicken Data file.
		[ ] //2.   Enter any file path location that will end with “\” slash. E.g. “E:\Data file\QW2010 file\”
		[ ] //3. Now Click on Browse button.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	28/3/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test35_ValidateBrowseOnQuickenRestoreDialog() appstate none
	[+] // Variable declaration
		[ ] 
		[ ] iValidate=QuickenRestoreNavigation()
		[+] if(iValidate==PASS)
			[ ] // Enter Backup file path and file name
			[ ] QuickenRestore.BackupFilePath.SetText(AUT_DATAFILE_PATH + "\" )
			[ ] 
			[+] if (QuickenRestore.Browse.IsEnabled())
				[ ] QuickenRestore.Browse.Click()
				[+] if (DlgRestoreQuickenFile.Exists(5))
					[ ] ReportStatus("Verify Browse button without giving backup file name, only path is provided",PASS,"Browse button is working as expected even if only path is provided without giving backup file name")
					[ ] DlgRestoreQuickenFile.SetActive()
					[ ] DlgRestoreQuickenFile.Close()
				[+] else
					[ ] ReportStatus("Verify Restore Quicken File dialog",FAIL,"Restore Quicken File dialog is not displayed")
				[ ] 
				[ ] // Click on Resore backup button without giving backup file name, only path is provided 
				[ ] QuickenRestore.RestoreBackup.Click()
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.OK.Click()
					[ ] 
					[ ] // Click on Cancel button
					[ ] QuickenRestore.Cancel.Click()
				[+] else
					[ ] ReportStatus("Verify alert message",FAIL,"Alert message is not displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Browse button is enabled",FAIL,"Browse button is not enabled")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Restore window is opened",FAIL,"Quicken Restore window is not displayed")
		[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify whether Invalid file locations can be selected from Restore directory  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test32_VerifyInvalidLoacationForRestore ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify whether Invalid file locations can be selected from backup directory menu
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					      Fail		      if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	21/2/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test36_VerifyInvalidLoacationForRestore() appstate none
	[+] // Variable declaration
		[ ] STRING sMessage,sExpectedMessage,sBackupPath,sFileName
		[ ] 
		[ ] sFileName="Export"
		[ ] sBackupPath="Y:\Intuit\Backup\"
		[ ] sExpectedMessage="Please enter a valid file name."
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // Navigate to restore window
		[ ] QuickenRestoreNavigation(sBackupPath,sFileName)
		[ ] // Verify Validation message
		[+] if(AlertMessage.Exists(1))
			[ ] ReportStatus("Verify user get validation message",PASS,"User is getting validation message if provided wrong path for backup")
			[ ] 
			[ ] AlertMessage.SetActive()
			[ ] sMessage=AlertMessage.StaticText.GetText()
			[+] if(sExpectedMessage==sMessage)
				[ ] ReportStatus("Verify user get proper validation message",PASS,"User is getting correct message if provided wrong path for backup, message is {sMessage} - Defect id - QW1353")
			[+] else
				[ ] ReportStatus("Verify user get proper validation message",FAIL,"User is not getting correct message if provided wrong path for backup, Actual message is {sMessage}, Expected message is {sExpectedMessage}")
				[ ] 
			[ ] 
			[ ] AlertMessage.OK.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify user get validation message",FAIL,"User is not getting validation message even if provided wrong path for backup")
			[ ] 
		[ ] 
		[+] if(QuickenRestore.Exists(2))
			[ ] QuickenRestore.SetActive()
			[ ] QuickenRestore.Close()
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify available link Learn More from Restore dialog  ##################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test33_VerifyLearnMoreLinkForRestore ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify available link Learn More from Restore dialog
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					      Fail		      if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	07/04/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test37_VerifyLearnMoreLinkForRestore() appstate none
	[+] // Variable declaration
		[ ] STRING sExpectedWindowTitle
		[ ] 
		[ ]  sExpectedWindowTitle=""
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // Navigate to restore window
		[ ] QuickenRestoreNavigation()
		[+] if (QuickenRestore.LearnMoreLink.Exists(2))
			[ ] ReportStatus("Verify Learn More link on Restore from backup file dialog", PASS , "Learn more link exists on Restore from backup file dialog")
			[ ] QuickenRestore.LearnMoreLink.Click()
			[+] if(Desktop.Find("//MainWin[@caption='{sExpectedWindowTitle}']").Exists())
				[ ] sleep(SHORT_SLEEP)
				[ ] ReportStatus("Validate {sExpectedWindowTitle} window", PASS, "{sExpectedWindowTitle} window is displayed after clicking on Learn More link.  defect id - QW-3109") 
				[ ] sleep(SHORT_SLEEP)
				[ ] // Close Popup window
				[ ] Desktop.Find("//MainWin[@caption='{sExpectedWindowTitle}']").SetActive()
				[+] do
					[ ] Desktop.Find("//MainWin[@caption='{sExpectedWindowTitle}']").Close()
				[+] except
					[ ] QuickenWindow.Kill()
					[ ] App_Start(sCmdLine)
					[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Validate {sExpectedWindowTitle} window", PASS, "{sExpectedWindowTitle} window is not displayed after clicking on Learn More link. defect id - QW-3109") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Learn More link on Restore from backup file dialog", FAIL , "Learn more link does not exist on Restore from backup file dialog")
			[ ] 
		[ ] 
		[+] if(QuickenRestore.Exists(2))
			[ ] QuickenRestore.SetActive()
			[ ] QuickenRestore.Close()
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify whether user is able to restore QDF-Backup file from File->Open menu ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test34_VerifyRestoreBackupFromOpenFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify whether user is able to restore QDF-Backup file from File->Open menu
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					      Fail		      if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	08/04/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test38_VerifyRestoreBackupFromOpenFile() appstate none
	[+] // Variable declaration
		[ ] STRING sBackupFileName="DefaultRestoredTempFile"
		[ ] STRING sFileWithPath=sFileManagementFilePath+"\{sBackupFileName}.QDF-backup"
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[+] if(FileExists(sFileWithPath))
			[ ] 
			[ ] // Navigate to File > Open
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[+] if (ImportExportQuickenFile.Exists(10))
				[ ] ImportExportQuickenFile.SetActive()
				[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
				[ ] ImportExportQuickenFile.OK.Click()
				[ ] 
				[+] if(QuickenRestore.Exists(2))
					[ ] ReportStatus("Verify whether user is able to restore QDF-Backup file from File->Open menu",PASS,"User is able to restore QDF-Backup file from File->Open menu")
					[ ] QuickenRestore.SetActive()
					[+] do
						[ ] QuickenRestore.YesRestore.Click()
					[+] except
						[ ] QuickenRestore.RestoreBackup.Click()
						[+] if(QuickenRestore.YesRestore.Exists(2))
							[ ] QuickenRestore.YesRestore.Click()
					[ ] 
					[ ] WaitForState(QuickenRestore, FALSE ,5)
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] sCaption = QuickenWindow.GetCaption ()
					[ ] 
					[ ] bCaption = MatchStr("*{sBackupFileName}*", sCaption)
					[+] if(bCaption)
						[ ] ReportStatus("Verify Backup file restored from File->Open menu",PASS,"Backup file is restored from File->Open menu and opened successfully")
						[ ] 
						[ ] iNavigate=QuickenRestoreNavigation()
						[+] if(iNavigate==PASS)
							[ ] 
							[ ] QuickenRestore.SetActive()
							[ ] bStatus=QuickenRestore.RestoreBackupButton.IsEnabled()
							[+] if(bStatus)
								[ ] ReportStatus("Verify Restore backup button is disabled",PASS,"Restore backup button is disabled")
							[+] else
								[ ] ReportStatus("Verify Restore backup button is disabled",FAIL,"Restore backup button is enabled even if backup file is not selected")
								[ ] 
							[ ] QuickenRestore.SetActive()
							[ ] QuickenRestore.TypeKeys(KEY_ENTER)
							[+] if(AlertMessage.Exists(2))
								[ ] ReportStatus("Verify alert message after pressing Enter key",FAIL,"Alert message is displayed after pressing Enter key")
							[ ] QuickenRestore.SetActive()
							[ ] QuickenRestore.Close()
						[+] else
							[ ] ReportStatus("Verify navigate to Restore from backup file window",FAIL,"Navigation to Restore from backup file window is failed")
					[+] else
						[ ] ReportStatus("Verify Backup file restored from File->Open menu",FAIL,"Backup file is not restored from File->Open menu and not opened")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify whether user is able to restore QDF-Backup file from File->Open menu",FAIL,"User is not able to restore QDF-Backup file from File->Open menu")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Open Quicken File dialog is displayed",FAIL,"Open Quicken File dialog is not displayed by navigating File->Open")
		[+] else
			[ ] ReportStatus("Verify backup file at the location {sFileManagementFilePath}",FAIL,"Backup file does not exist at {sFileManagementFilePath}")
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify whether user is able to Immediately open newly created file ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test35_VerifyOpenNewCreatedFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify whether user is able to Immediately open newly created file
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					      Fail		      if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	08/04/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test39_VerifyOpenNewCreatedFile() appstate none
	[+] // Variable declaration
		[ ] STRING sNewFileName="NewDataFile"
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] // Create new data file
		[ ] iResult=DataFileCreate(sNewFileName,AUT_DATAFILE_PATH)
		[+] if(iResult==PASS)
			[ ] ReportStatus("Verify create new data file",PASS,"New data file created successfully")
			[ ] // Open newly created data file
			[ ] iValidate=OpenDataFile(sNewFileName,AUT_DATAFILE_PATH)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify whether user is able to Immediately open newly created file",PASS,"User is able to Immediately open newly created file")
			[+] else
				[ ] ReportStatus("Verify whether user is able to Immediately open newly created file",FAIL,"User is not able to Immediately open newly created file")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify create new data file",FAIL,"User is not able to create new data  file")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify file path with space in the beginning and in the end.#############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test36_VerifySpacesTrimmedForBackupFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify file path with space in the beginning and in the end.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					      Fail		      if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	08/04/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test40_VerifySpacesTrimmedForBackupFile() appstate none
	[+] // Variable declaration
		[ ] STRING sFileName="NewDataFile"
		[ ] STRING sFileWithPath=AUT_DATAFILE_PATH+"\{sFileName}.QDF-backup"
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] // Navigate to Quicken Backup window
		[ ] iResult=QuickenBackupNavigation()
		[+] if(iResult==PASS)
			[ ] // Verify Quicken file Backup window
			[+] if(QuickenBackup.Exists(5))
				[ ] 
				[ ] QuickenBackup.SetActive()
				[ ] // Enter Backup file path with leading spaces and spaces after file name
				[ ] QuickenBackup.BackupFile.SetText("                                {AUT_DATAFILE_PATH}\{sFileName}.QDF-backup                             " )
				[ ] // Click on Backup Now button
				[ ] QuickenBackup.BackUpNow.Click()
				[+] if(DuplicateBackupFile.Exists(5))
					[ ] DuplicateBackupFile.SetActive()
					[ ] DuplicateBackupFile.Yes.Click()
				[ ] 
				[ ] // If file with same name exists in backup directory
				[+] if(AlertMessage.Exists(3))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.Yes.Click()
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] // Verify backup confirmation
				[+] // if (QuickenWindow.QuickenBackup.Exists(5))
					[ ] // QuickenWindow.QuickenBackup.SetActive()
					[ ] // QuickenWindow.QuickenBackup.Close()
				[+] else if(BackupConfirmation.Exists(3))
					[ ] 
					[ ] BackupConfirmation.SetActive()
					[ ] BackupConfirmation.OK.Click()
					[ ] 
					[ ] // Verify backup file does not have spaces
					[+] if(FileExists(sFileWithPath))
						[ ] ReportStatus("Verify file path with space in the beginning and in the end while backup",PASS,"Spaces trimmed in backup file")
					[+] else
						[ ] ReportStatus("Verify file path with space in the beginning and in the end while backup",PASS,"Spaces did not trim in backup file, Defect - QW007361 needs to be reopened")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Quicken File Backup confirmation", FAIL, "Quicken file Backup confirmation is not found")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of Quicken Backup Window", FAIL, "Quicken Backup window is not found")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Quicken Backup dialog",FAIL,"Navigation to Quicken Backup dialog is failed")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
[ ] //#########################################################################################################
[ ] 
[+] //#############Verify displayed validation Quicken CD Backup dialog  ###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test37_VerifyBackupValidationMessageForEmptyCDDrive()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify displayed validation Quicken CD Backup dialog
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 		if no error occurs 						
		[ ] //					Fail			if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	9/4/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test41_VerifyBackupValidationMessageForEmptyCDDrive() appstate none
	[+] // Variable declaration
		[ ] STRING sMessage,sExpectedMessage,sBackupPath,sFileName,sDrive
		[ ] STRING sFile="NewDataFile"
		[ ] sDrive="CD-ROM Disc"
		[ ] 
		[ ] bMatch=FALSE
		[ ] 
	[ ] //Check the Quicken Existence 
	[ ] STRING sPath ="c:\a.txt"
	[ ] LIST OF ANYTYPE lsData ,lsData2
	[ ] 
	[ ] // command for getting local drive information 
	[ ] SYS_Execute("wmic logicaldisk get deviceid, volumename, description",lsData)			
	[ ] 
	[+] for(i=ListCount(lsData);i>0;i--)
		[+] if(lsData[i]==NULL)
			[ ] lsData[i]=""
		[ ] bMatch=MatchStr("*{sDrive}*",lsData[i])
		[+] if(bMatch)
			[ ] lsData2 = split (lsData[i] ,sDrive)
			[ ] sDrive=trim(lsData2[2])
			[ ] sExpectedMessage="CD Backup Error. The CD Drive is empty.  Please enter a valid disc into Drive {sDrive}"
			[ ] sBackupPath="{sDrive}\Intuit\Backup\"
			[ ] 
			[ ] break
	[+] if(bMatch==FALSE)
		[ ] ReportStatus("Get CD drive name",FAIL,"CD drive is not found on local computer")
	[+] else
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenBackupNavigation()
			[ ] // Verify Quicken file Backup window
			[+] if(QuickenBackup.Exists(5))
				[ ] 
				[ ] QuickenBackup.SetActive()
				[ ] // Enter Backup file path and file name
				[ ] QuickenBackup.BackupFile.SetText(sBackupPath + sFile+"QDF.backup")
				[ ] // Click on Backup Now button
				[ ] QuickenBackup.BackUpNow.Click()
			[ ] 
			[ ] // Verify Validation message
			[+] if(AlertMessage.Exists(1))
				[ ] ReportStatus("Verify user get validation message",PASS,"User is getting validation message if provided wrong path for backup")
				[ ] 
				[ ] AlertMessage.SetActive()
				[ ] sMessage=AlertMessage.StaticText.GetText()
				[+] if(sExpectedMessage==sMessage)
					[ ] ReportStatus("Verify user get proper validation message",PASS,"User is getting correct message if provided wrong path for backup, message is {sMessage}")
				[+] else
					[ ] ReportStatus("Verify user get proper validation message",FAIL,"User is not getting correct message if provided wrong path for backup, Actual message is {sMessage}, Expected message is {sExpectedMessage}")
					[ ] 
				[ ] 
				[ ] AlertMessage.OK.Click()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify user get validation message",FAIL,"User is not getting validation message even if provided wrong path for backup")
				[ ] 
			[ ] 
			[+] if(QuickenBackup.Exists(2))
				[ ] QuickenBackup.SetActive()
				[ ] QuickenBackup.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
[ ] //#########################################################################################################
[ ] 
[+] //#############Verify upgrade Process / Existing User data migration  ###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test38VerifyDataFileMigration()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify upgrade Process / Existing User data migration
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs 						
		[ ] //					      Fail		      if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	11/04/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test42_VerifyDataFileMigration() appstate none
	[+] // Variable declaration
		[ ] STRING sOldFileName,sPassword,sSource,sTarget,sBackupFile,sDir,sPath,sValidateDir
		[ ] 
		[ ] sOldFileName = "2012"
		[ ] sBackupFile="{sOldFileName}.QDF-backup"
		[ ] sPassword="InTuiT12#$"
		[ ] sSource = AUT_DATAFILE_PATH+"\DataConversionSource\ConversionFolder\{sOldFileName}\{sOldFileName}.QDF"
		[ ] sPath=AUT_DATAFILE_PATH+"\"+"FileIO\"
		[ ] sTarget= sPath +"{sOldFileName}.QDF"
		[ ] sDir=sPath+"Q12Files"
		[ ] sValidateDir=sPath+"VALIDATE"
		[ ] 
	[ ] 
	[+] if(FileExists(sTarget))
		[ ] DeleteFile(sTarget)
	[ ] CopyFile(sSource,sTarget)
	[ ] 
	[ ] iValidate= DataFileConversion(sOldFileName,sOldFileName,sPassword,sPath)
	[+] if(iValidate==PASS)
		[ ] 
		[+] // Verify file Name
			[ ] QuickenWindow.SetActive ()
			[ ] sCaption = QuickenWindow.GetCaption()
			[ ] bMatch = MatchStr("*{sOldFileName}*", sCaption)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate File Name", PASS, "Correct file name is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate File Name", FAIL, "Expected File name - {sOldFileName}, Actual File name - {sCaption}")
		[ ] 
		[+] // Verify Directory is crated for keeping old data file's copy
			[+] if(DirExists(sDir))
				[ ] ReportStatus("Verify {sDir} folder created after conversion",PASS,"{sDir} folder is created after connversion")
			[+] else
				[ ] ReportStatus("Verify {sDir} folder created after conversion",FAIL,"{sDir} folder is not created after connversion")
				[ ] 
			[ ] 
		[ ] 
		[+] // Take backup of currently migrated data file
			[ ] iResult=QuickenBackup(sPath,sBackupFile)
			[+] if(iResult==PASS)
				[ ] ReportStatus("Verify backup of currently migrated data file",PASS,"Backup of currently migrated data file is done successfully")
			[+] else
				[ ] ReportStatus("Verify backup of currently migrated data file",FAIL,"Backup of currently migrated data file is not done successfully")
				[ ] 
		[ ] 
		[+] // Validate migrated data file
			[ ] iResult=ValidateDataFile()
			[+] if(iResult==PASS)
				[ ] ReportStatus("Verify Validate & Repair functionality of currently migrated data file",PASS,"Validate & Repair functionality is working as expected for currently migrated data file")
			[+] else
				[ ] ReportStatus("Verify Validate & Repair functionality of currently migrated data file",FAIL,"Validate & Repair functionality is not working as expected for currently migrated data file")
				[ ] 
		[ ] 
		[+] // Verify Directory is crated for keeping old data file's copy
			[+] if(DirExists(sValidateDir))
				[ ] ReportStatus("Verify {sValidateDir} folder created after validate & repair",PASS,"{sValidateDir} folder is created after validate & repair")
			[+] else
				[ ] ReportStatus("Verify {sValidateDir} folder created after validate & repair",FAIL,"{sValidateDir} folder is not created after validate & repair")
				[ ] 
			[ ] 
		[ ] 
		[ ] // Open another data file
		[ ] OpenDataFile(sFileManagementFileName,sFileManagementFilePath)
	[+] else
		[ ] ReportStatus("Verify data file conversion",FAIL,"Data file conversion failed")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify backup feature if user specify blank spaces (>12) in file name #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test39_VerifyBackupWhenFileNameHavingMoreThan12Spaces()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify backup feature if user specify blank spaces (>12) in file name 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 		if no error occurs 						
		[ ] //					Fail			if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	14/4/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test43_VerifyBackupWhenFileNameHavingMoreThan12Spaces() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sFileName = "Backup                 Test.qdf"
		[ ] STRING sSampleFile="Sample"
	[ ] 
	[ ] //Create data file
	[ ] iResult=DataFileCreate(sFileName ,"{AUT_DATAFILE_PATH}\FileIO")
	[+] if(iResult==PASS)
		[ ] 
		[ ] // take backup 
		[ ] iValidate=QuickenBackup(sFileIOFilePath,"{sFileName}.QDF-backup")
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify backup feature if user specify blank spaces (>12) in file name",PASS,"Backup feature is working as expected even if file name having more than12 Spaces")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify backup feature if user specify blank spaces (>12) in file name",FAIL,"Backup feature is not working as expected if file name having more than12 Spaces: defect id -  QW007369")
			[ ] 
		[ ] 
		[ ] // Delete data file and backup file
		[ ] DataFileCreate(sSampleFile,AUT_DATAFILE_PATH)
		[ ] 
		[ ] DeleteFile("{AUT_DATAFILE_PATH}\FileIO\{sFileName}")
		[ ] DeleteFile("{sFileIOFilePath}{sFileName}.QDF-backup")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify data file create",FAIL,"Data file {sFileName} is not created")
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify "Don't show again" check box on backup dialog while overwriting with any existing backup file ###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test40_ValidateDontShowAgainForOverwriteBackup()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Don't show again" check box on backup dialog while overwriting with any existing backup file 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	14/4/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test44_ValidateDontShowAgainForOverwriteBackup() appstate none
	[+] // Variable declaration
		[ ] STRING sFileWithPath
		[ ] sTempFile ="TempFileManagementFile"
		[ ] sFileWithPath=AUT_DATAFILE_PATH+"\{sTempFile}.QDF"
		[ ] 
	[ ] //Pre requisit
	[+] if(FileExists(sFileWithPath))
		[ ] 
		[ ] START:
		[ ] 
		[ ] iValidate=QuickenBackup(AUT_DATAFILE_PATH,"{sTempFile}.QDF-backup")
		[ ] if(iValidate==PASS)
		[ ] 
		[ ] iValidate=QuickenBackupNavigation()
		[+] if(iValidate==PASS)
			[ ] QuickenBackup.BackupFile.SetText(sFileWithPath)
			[ ] 
			[ ] // Click on Backup Now button
			[ ] QuickenBackup.BackUpNow.Click()
			[ ] 
			[+] if(DuplicateBackupFile.Exists(5))
				[ ] DuplicateBackupFile.SetActive()
				[ ] ReportStatus("Verify overwrite backup file",PASS,"Overwrite the previous backup file if we are taking the backup of same data file in same directory.")
				[ ] 
				[+] if(DuplicateBackupFile.DonTShowAgain.Exists(2))
					[ ] ReportStatus("Quicken should show Don't show again. checkbox on overwrite notification dialog",PASS,"Don't show again. checkbox on overwrite notification dialog is displayed")
					[ ] DuplicateBackupFile.DonTShowAgain.Check()
					[ ] DuplicateBackupFile.Yes.Click()
					[ ] 
					[+] if(BackupConfirmation.Exists(3))
						[ ] BackupConfirmation.SetActive()
						[ ] BackupConfirmation.OK.Click()
					[ ] 
					[ ] // Take backup again to verify the functionality of Do not show again checkbox
					[ ] iNavigate=QuickenBackupNavigation()
					[+] if(iNavigate==PASS)
						[ ] QuickenBackup.BackupFile.SetText(sFileWithPath)
						[ ] 
						[ ] // Click on Backup Now button
						[ ] QuickenBackup.BackUpNow.Click()
						[ ] 
						[+] if(DuplicateBackupFile.DonTShowAgain.Exists(2))
							[ ] ReportStatus("Verify user will never see the backup overwrite notification for backup",FAIL,"Overwrite notification is displayed even if Do not Show again is checked")
							[ ] DuplicateBackupFile.Yes.Click()
							[ ] 
						[+] else
							[ ] ReportStatus("Verify user will never see the backup overwrite notification for backup",PASS,"Overwrite notification is not displayed once Do not Show again is checked")
							[+] if(BackupConfirmation.Exists(3))
								[ ] BackupConfirmation.SetActive()
								[ ] BackupConfirmation.OK.Click()
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Quicken backup navigation",FAIL,"Quicken Backup navigation is failed")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Quicken should show Don't show again. checkbox on overwrite notification dialog",FAIL,"Don't show again. checkbox on overwrite notification dialog is not displayed, defect id = QW007388")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Overwrite notification",FAIL,"Overwrite notification is not displayed")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Backup window is opened",FAIL,"Quicken Backup window is not displayed")
		[ ] 
	[+] else
		[ ] DataFileCreate(sTempFile,AUT_DATAFILE_PATH)
		[ ] goto START
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify action for auto backup file when user double clicks a file from list ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test41_ValidateAutoBackupRestoreByDoubleClick()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify action for auto backup file when user double clicks a file from list 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	15/4/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test45_ValidateAutoBackupRestoreByDoubleClick() appstate none
	[+] // Variable declaration
		[ ] sTempFile ="TempFileManagementFile"
		[ ] sCaption="Restore from backup file"
		[ ] 
	[ ] iResult=QuickenRestoreNavigation()
	[+] if(iResult==PASS)
		[ ] 
		[+] if(QuickenRestore.Exists(5))
			[ ] 
			[ ] QuickenRestore.SetActive()
			[ ] sHandle = Str(QuickenRestore.ListBox1.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,str(0))
			[ ] bMatch = MatchStr("*{sTempFile}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate backup listed under Restore from automatic backup", PASS, "Backup file {sActual} is displayed under Restore from automatic backup list")
				[ ] 
				[ ] QuickenRestore.SetActive()
				[ ] // Select first option : Restore from Automatic backup
				[ ] QuickenRestore.RestoreFromBackupFile.Select(1)
				[ ] // Select first automatic backup
				[ ] QuickenRestore.ListBox1.Select(1)
				[ ] QuickenRestore.TypeKeys(KEY_ENTER)
				[ ] sleep(2)
				[+] if(RestoreOpenFile.Exists(2))
					[ ] 
					[ ] // Verify Caption of the window
					[ ] QuickenRestore.SetActive()
					[ ] sActual=QuickenRestore.GetCaption()
					[+] if (sActual==sCaption)
						[ ] ReportStatus("Verify window title", PASS , "Window title is displayed correctly, window title is {sCaption}")
					[+] else
						[ ] ReportStatus("Verify window title", FAIL , "Window title is not displayed correctly, actual window title is {sActual} and expected window title is {sCaption}, Defect id=QW008573")
					[ ] 
					[ ] ReportStatus("Verify that backup can be restored from listed backup files", PASS, "Overwrite option is available hence backup can be restored from listed automatic backup file")
					[ ] RestoreOpenFile.SetActive()
					[ ] RestoreOpenFile.RestoreBackup.Click()
					[ ] // Verify automatic backup is restored successfully
					[ ] QuickenWindow.SetActive()
					[ ] sActual =QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr( "*{sTempFile}*" ,sActual)
					[+] if (bMatch)
						[ ] ReportStatus("Verify restore functionality by restoring automatic backup data file ", PASS ,"Automatic backup is restored successfully")
					[+] else
						[ ] ReportStatus("Verify restore functionality by restoring automatic backup data file ", FAIL ,"Automatic backup is not restored successfully")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that backup can be restored from listed backup files", FAIL, "Overwrite option is not available hence backup can't be restored from listed automatic backup file")
					[ ] 
			[+] else
				[ ] ReportStatus("Validate backup listed under Restore from automatic backup", FAIL, "Backup file {sTempFile} is not displayed under Restore from automatic backup list")
		[+] else
			[ ] ReportStatus("Verify Restore from backup file window",FAIL,"Restore from backup file window is not displayed")
	[+] else
		[ ] ReportStatus("Verify Quicken Restore Navigation",FAIL,"Navigation to Restore from backup file dialog is failed")
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify default focus for Quicken Backup dialog.######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test42_VerifyDefaultFocusOnQuickenBackupDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify default focus for Quicken Backup dialog.
		[ ] // Backup dialog - focus should be on Back-up now button 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	28/4/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test46_VerifyDefaultFocusOnQuickenBackupDialog() appstate none
	[ ] 
	[ ] iResult=OpenDatafile(sFileManagementFileName , sFileManagementFilePath)
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File", PASS ,"Data File: {sFileManagementFileName} opened successfully.")
		[+] if(QuickenWindow.Exists(5))
			[ ] 
			[ ] iValidate=QuickenBackupNavigation()
			[+] if(iValidate==PASS)
				[ ] 
				[+] if(QuickenBackup.Exists(5))
					[ ] QuickenBackup.SetActive()
					[ ] QuickenBackup.TypeKeys(KEY_ENTER)
					[+] if(DuplicateBackupFile.Exists(3))
						[ ] DuplicateBackupFile.SetActive()
						[ ] DuplicateBackupFile.Yes.Click()
					[+] if(BackupConfirmation.Exists(10))
						[ ] ReportStatus("Verify default focus for Quicken Backup dialog",PASS,"Backup dialog - default focus is on Back-up now button ")
						[ ] BackupConfirmation.SetActive()
						[ ] BackupConfirmation.OK.Click()
					[+] else
						[ ] ReportStatus("Verify default focus for Quicken Backup dialog",FAIL,"Backup dialog - default focus is not on Back-up now button as Confirmation popup did not appear")
						[ ] QuickenBackup.SetActive()
						[ ] QuickenBackup.Close()
				[+] else
					[ ] ReportStatus("Verify Backup from backup file window",FAIL,"Backup file window is not displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken Backup Navigation",FAIL,"Navigation to backup file dialog is failed")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sFileManagementFileName} couldn't be opened.")
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############After canceling the Open File dialog, Quicken should display last opened data file properly.##################
	[ ] // ********************************************************
	[+] // TestCase Name:Test47_VerifyCancelOperationOpensLastOpenedDataFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that After canceling the Open File dialog, Quicken should display last opened data file properly, without any UI issue. 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	29/4/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test47_VerifyCancelOperationOpensLastOpenedDataFile() appstate none
	[+] // Variable declaration
		[ ] STRING sBackupFileName="2012"
		[ ] STRING sFileWithPath=AUT_DATAFILE_PATH+"\fileIO\{sBackupFileName}.QDF-backup"
		[ ] STRING sFilePassword="InTuiT12#$"
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[+] if(FileExists(sFileWithPath))
			[ ] 
			[ ] // Navigate to File > Open
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[+] if (ImportExportQuickenFile.Exists(10))
				[ ] ImportExportQuickenFile.SetActive()
				[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
				[ ] ImportExportQuickenFile.OK.Click()
				[ ] 
				[+] if(QuickenRestore.Exists(2))
					[ ] ReportStatus("Verify whether user is able to restore QDF-Backup file from File->Open menu",PASS,"User is able to restore password protected Backup file from File->Open menu")
					[ ] QuickenRestore.SetActive()
					[+] do
						[ ] QuickenRestore.YesRestore.Click()
					[+] except
						[ ] QuickenRestore.RestoreBackup.Click()
						[+] if(QuickenRestore.YesRestore.Exists(2))
							[ ] QuickenRestore.YesRestore.Click()
					[ ] 
					[ ] WaitForState(QuickenRestore, FALSE ,5)
					[ ] 
					[+] if(EnterQuickenPassword.Exists(2))
						[ ] EnterQuickenPassword.SetActive()
						[ ] EnterQuickenPassword.CancelButton.Click()
						[ ] sleep(2)
					[+] else
						[ ] ReportStatus("Verify Enter Quicken Password dialog",FAIL,"Enter Quicken Password window is not displayed")
					[ ] 
					[+] if (ImportExportQuickenFile.Exists(10))
						[ ] ImportExportQuickenFile.SetActive()
						[ ] ImportExportQuickenFile.Cancel.Click()
					[+] else
						[ ] 
					[ ] // Verify restored data file name
					[ ] QuickenWindow.SetActive()
					[ ] sCaption = QuickenWindow.GetCaption ()
					[ ] bCaption = MatchStr("*{sBackupFileName}*", sCaption)
					[+] if(bCaption==FALSE)
						[ ] ReportStatus("Verify Backup file is not restored after cancellation",PASS,"Backup file is not restored after cancellation")
					[+] else
						[ ] ReportStatus("Backup file is not restored after cancellation",FAIL,"Backup file is restored even after cancellation")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify whether user is able to restore QDF-Backup file from File->Open menu",FAIL,"User is not able to restore QDF-Backup file from File->Open menu")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Open Quicken File dialog is displayed",FAIL,"Open Quicken File dialog is not displayed by navigating File->Open")
		[+] else
			[ ] ReportStatus("Verify backup file at the location {sFileManagementFilePath}",FAIL,"Backup file does not exist at {sFileManagementFilePath}")
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify restore functionality for password protected backup file###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test48_VerifyRestoreForPasswordProtectedDataFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify restore functionality for password protected backup file
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	30/4/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test48_VerifyRestoreForPasswordProtectedDataFile() appstate none
	[+] // Variable declaration
		[ ] STRING sBackupFileName="2012"
		[ ] STRING sFileWithPath=AUT_DATAFILE_PATH+"\fileIO\{sBackupFileName}.QDF-backup"
		[ ] STRING sFilePassword="InTuiT12#$"
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[+] if(FileExists(sFileWithPath))
			[ ] 
			[ ] // Navigate to File > Open
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[+] if (ImportExportQuickenFile.Exists(10))
				[ ] ImportExportQuickenFile.SetActive()
				[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
				[ ] ImportExportQuickenFile.OK.Click()
				[ ] 
				[+] if(QuickenRestore.Exists(2))
					[ ] QuickenRestore.SetActive()
					[+] do
						[ ] QuickenRestore.YesRestore.Click()
					[+] except
						[ ] QuickenRestore.RestoreBackup.Click()
						[+] if(QuickenRestore.YesRestore.Exists(2))
							[ ] QuickenRestore.YesRestore.Click()
					[ ] 
					[ ] WaitForState(QuickenRestore, FALSE ,5)
					[ ] 
					[+] if(EnterQuickenPassword.Exists(2))
						[ ] EnterQuickenPassword.SetActive()
						[ ] EnterQuickenPassword.Password.SetText(sFilePassword)
						[ ] EnterQuickenPassword.OK.Click()
						[ ] sleep(2)
					[+] else
						[ ] ReportStatus("Verify Enter Quicken Password dialog",FAIL,"Enter Quicken Password window is not displayed")
					[ ] 
					[ ] // Verify Open networth report
					[ ] iValidate=OpenReport(sREPORT_NETWORTH_BALANCES,sREPORT_NETWORTH)
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Verify Open Reoprts",PASS,"Networth report opened successful")
					[+] else
						[ ] ReportStatus("Verify Open Reoprts",FAIL,"Networth report open failed, defect id - QW010514")
					[+] if(NetWorthReports.Exists(2))
						[ ] NetWorthReports.SetActive()
						[ ] NetWorthReports.Close()
					[ ] 
					[ ] // Verify Navigation to Spending tab
					[ ] iValidate=NavigateQuickenTab(sTAB_BILL)
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Verify Navigation to {sTAB_BILL} tab",PASS,"Navigate to {sTAB_BILL} tab is successful")
					[+] else
						[ ] ReportStatus("Verify Navigation to {sTAB_BILL} tab",FAIL,"Navigate to {sTAB_BILL} tab is failed")
					[ ] 
					[ ] // Verify restored data file name
					[ ] QuickenWindow.SetActive()
					[ ] sCaption = QuickenWindow.GetCaption ()
					[ ] bCaption = MatchStr("*{sBackupFileName}*", sCaption)
					[+] if(bCaption)
						[ ] ReportStatus("Verify whether user is able to restore QDF-Backup file from File->Open menu",PASS,"User is able to restore password protected Backup file from File->Open menu")
					[+] else
						[ ] ReportStatus("Verify Backup file restored from File->Open menu",FAIL,"Backup file is not restored from File->Open menu and not opened")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify whether user is able to restore QDF-Backup file from File->Open menu",FAIL,"User is not able to restore QDF-Backup file from File->Open menu")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Open Quicken File dialog is displayed",FAIL,"Open Quicken File dialog is not displayed by navigating File->Open")
		[+] else
			[ ] ReportStatus("Verify backup file at the location {sFileManagementFilePath}",FAIL,"Backup file does not exist at {sFileManagementFilePath}")
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify restore feature by hitting enter key###########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test49_VerifyRestoreByHittingEnterKey()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify restore functionality for password protected backup file
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	30/4/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test49_VerifyRestoreByHittingEnterKey() appstate none
	[+] // Variable declaration
		[ ] STRING sBackupFileName="DefaultRestoredTempFile"
		[ ] STRING sFileWithPath=sFileManagementFilePath+"\{sBackupFileName}.QDF-backup"
		[ ] BOOLEAN bStatus
		[ ] 
	[ ] //Check the Quicken Existence 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[+] if(FileExists(sFileWithPath))
			[ ] 
			[ ] // Navigate to File > Open
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[+] if (ImportExportQuickenFile.Exists(10))
				[ ] ImportExportQuickenFile.SetActive()
				[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
				[ ] ImportExportQuickenFile.OK.Click()
				[ ] 
				[+] if(QuickenRestore.Exists(2))
					[ ] ReportStatus("Verify whether user is able to restore QDF-Backup file from File->Open menu",PASS,"User is able to restore QDF-Backup file from File->Open menu")
					[ ] QuickenRestore.SetActive()
					[+] do
						[ ] QuickenRestore.YesRestore.Click()
					[+] except
						[ ] QuickenRestore.RestoreBackup.Click()
						[+] if(QuickenRestore.YesRestore.Exists(2))
							[ ] QuickenRestore.YesRestore.Click()
					[ ] 
					[ ] WaitForState(QuickenRestore, FALSE ,5)
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] sCaption = QuickenWindow.GetCaption ()
					[ ] 
					[ ] bCaption = MatchStr("*{sBackupFileName}*", sCaption)
					[+] if(bCaption)
						[ ] ReportStatus("Verify Backup file restored from File->Open menu",PASS,"Backup file is restored from File->Open menu and opened successfully")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Backup file restored from File->Open menu",FAIL,"Backup file is not restored from File->Open menu and not opened")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify whether user is able to restore QDF-Backup file from File->Open menu",FAIL,"User is not able to restore QDF-Backup file from File->Open menu")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Open Quicken File dialog is displayed",FAIL,"Open Quicken File dialog is not displayed by navigating File->Open")
		[+] else
			[ ] ReportStatus("Verify backup file at the location {sFileManagementFilePath}",FAIL,"Backup file does not exist at {sFileManagementFilePath}")
	[+] else
		[ ] ReportStatus("Validate Find Quicken File Operation", FAIL,"Quicken did not launched!" )
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#############Verify whether user is able to restore backup data at new created folder location############################
	[ ] // ********************************************************
	[+] // TestCase Name:Test50_VerifyRestoreAtNewFolderLocation()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify whether user is able to restore backup data at new created folder location.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:		Pass 	if no error occurs 						
		[ ] //					Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	5/5/2014  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test50_VerifyRestoreAtNewFolderLocation() appstate none
	[+] // Variable declaration
		[ ] 
		[ ] STRING sBackupLocation,sBackupFile,sFileName,sNewLocation
		[ ] sFileName="Quicken.QDF"
		[ ] sBackupFile= "{sFileManagementFileName}.QDF-backup"
		[ ] sBackupLocation= AUT_DATAFILE_PATH + "\File Management data\"
		[ ] sExpected="The folder that you specified does not exist. Do you want to create the folder?"
		[ ] sFilePath =AUT_DATAFILE_PATH+"\"
		[ ] sNewLocation="C:\automation\INTUIT_PROJECT\persistent\"
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iResult=OpenDataFile(sFileManagementFileName,sFileManagementFilePath)
	[+] if(iResult == PASS)
		[ ] ReportStatus("Verify Data file {sFileManagementFileName} is opened",PASS,"Data file {sFileManagementFileName} is opened successfully ")
		[ ] 
		[ ] iValidate=QuickenBackup(sFilePath,sBackupFile)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] CloseQuicken()
			[+] if(!QuickenWindow.Exists(10))
				[ ] iResult=Sys_Execute("{sFilePath}\{sBackupFile}",NULL,EM_CONTINUE_RUNNING)
				[ ] sleep(5)
				[+] if(iResult==PASS)
					[ ] sleep(2)
					[+] if(QuickenRestore.Exists(20))
						[ ] QuickenRestore.SetActive()
						[ ] ReportStatus("Verify Location to Restore textbox",PASS,"Location to Restore textbox is available")
						[ ] // QuickenRestore.LocationToRestore.SetText(sBackupLocation+"NewLocation\"+sBackupFile)
						[ ] QuickenRestore.LocationToRestore.SetText(sNewLocation+sFileName)
						[ ] QuickenRestore.RestoreBackupButton.Click()
						[+] if(AlertMessage.Exists(2))
							[ ] AlertMessage.SetActive()
							[ ] sActual=AlertMessage.MessageText.GetText()
							[+] if(sActual==sExpected)
								[ ] ReportStatus("Verify alert message",PASS,"Correct alert message is displayed, message: {sExpected}")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Alert message",FAIL,"Correct alert message is not displayed, actual: {sActual}, Expected: {sExpected}")
							[ ] AlertMessage.Yes.Click()
							[ ] WaitForState(AlertMessage, FALSE, 10)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify alert message for new folder",FAIL,"Alert message is not displayed for new folder location")
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_O)
						[+] if (ImportExportQuickenFile.Exists(10))
							[ ] ImportExportQuickenFile.SetActive()
							[ ] ImportExportQuickenFile.FileName.SetText(AUT_DATAFILE_PATH+"\{sFileManagementFileName}.QDF-backup")
							[ ] ImportExportQuickenFile.OK.Click()
							[ ] 
							[+] if(QuickenRestore.Exists(2))
								[ ] QuickenRestore.SetActive()
								[ ] sActual=QuickenRestore.FileLocation.GetText()
								[+] if("{sActual}\"==sNewLocation)
									[ ] ReportStatus("Verify File Location",PASS,"Correct file location is displayed: {sNewLocation}")
								[+] else
									[ ] ReportStatus("Verify File Location",FAIL,"Correct file location is not displayed, actual: {sActual}, Expected: {sNewLocation}")
								[ ] QuickenRestore.No.Click()
								[ ] WaitForState(QuickenRestore, FALSE, 10)
							[+] else
								[ ] ReportStatus("Verify Restore from backup file dialog",FAIL,"Restore from backup file dialog is not displayed")
							[ ] 
						[+] else
							[ ] ReportStatus("Open backup file",FAIL,"File {AUT_DATAFILE_PATH}\{sFileManagementFileName}.QDF-backup is not opened")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Location to Restore textbox",FAIL,"Location to Restore textbox is not available")
					[ ] 
				[+] else
					[ ] ReportStatus("Open backup file using double click",FAIL,"backup file not opened using double click")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window exists")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify backup of opened file",FAIL,"Opened data file is not backed up successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify data file {sTempFile} open",FAIL,"Data File {sTempFile} is not opened")
	[ ] 
[ ] //##########################################################################################################
[ ] 
