[ ] // *********************************************************
[+] // FILE NAME:	<DataConversion.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Data Conversion test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	Includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube/ Mamta Jain	
	[ ] //
	[ ] // Developed on: 		21/12/2010
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 March 18, 2011	Puja Verma	Created
	[ ] //	 March 30, 2011	Mamta Jain	Modified
	[ ] // *********************************************************
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ]  
[+] // Global variables
	[ ] public LIST OF ANYTYPE lsExcelData, lsExcelData1
	[ ] public STRING sDataConversionFile = "DataConversion"
	[ ] public LIST OF STRING lsActualFileAttribute, lsFileAttributes1, lsConversionData, lsEditTransaction, lsSplit
	[ ] public STRING sActualAboutQuicken, sExpectedAttribute, sCaption
	[ ] public INTEGER i, iPos, iConversionResult, k
	[ ] public BOOLEAN bMatch, bDeleteStatus
	[ ] public LIST OF STRING lsFileAttributes = {"FileName", "Accounts", "Categories", "Memorized Payee", "Securities", "Transactions","EndingBalance"}
	[ ] // public STRING  sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sOriginalFolderName = AUT_DATAFILE_PATH+"\"+"DataConversionSource"+"\"+"ConversionFolder"
	[ ] public STRING sTempFolderName = AUT_DATAFILE_PATH+"\"+"ConversionFolder"
	[ ] public STRING sTransactionData = "Transaction"
	[ ] public STRING sFileName = "Test"
	[ ] public STRING sExportedFolder = "{AUT_DATAFILE_PATH}\ExportedImage"
[ ] 
[+] //############# DataConversionSetup ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataConversionSetup()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the temporary data conversion folder if it exists. 
		[ ] // It will setup the necessary pre-requisite for Conversion suit
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting or copying folder					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	3/18/ 2011		Created by	Puja Verma 
		[ ] //							31/03/2011	Modified by	Mamta Jain	 		
	[ ] // ********************************************************
	[ ] 
[+] testcase DataConversionSetup() appstate QuickenBaseState
	[+] // Variable declaration
		[ ] INTEGER iSetupAutoAPI
		[ ] 
		[ ] STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
		[ ] STRING sFilePath = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Kill()
		[ ] 
	[+] if SYS_DirExists(sTempFolderName)				// if temporary Data conversion folder exists then delete it 
		[ ] bDeleteStatus = DeleteDir(sTempFolderName)
		[+] if(bDeleteStatus == TRUE)
			[ ] ReportStatus("Validate Folder", PASS, "Folder is deleted") 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Folder", FAIL, "Folder is not deleted") 
			[ ] 
	[+] if SYS_DirExists(sOriginalFolderName)				// if Original Dataconversion folder exists then perform below action
		[ ] CopyDir(sOriginalFolderName,sTempFolderName)		// copy original dataconversion folder to Temporary folder
		[ ] ReportStatus("Validate Folder", PASS, "Folder Copied Successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Folder",FAIL,"Folder is not copied")
		[ ] 
	[ ] 
	[+] if SYS_DirExists(sExportedFolder)			// if folder in which exported files are saved exists, delete it
		[ ] DeleteDir(sExportedFolder)
	[ ] MakeDir(sExportedFolder)					// create the folder
	[ ] 
	[+] if(SYS_FileExists(sFilePath))
		[ ] DeleteFile(sFilePath)
	[ ] APP_Start(sCmdLine)
	[+] if(EnterQuickenPassword.Exists(SHORT_SLEEP))
		[ ] EnterQuickenPassword.Close()
		[ ] ImportExportQuickenFile.SetActive()
		[ ] ImportExportQuickenFile.Close()
	[ ] // QuickenWindow.SetActive()
	[ ] 
	[ ] // Create Data File
	[ ] DataFileCreate(sFileName)
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2001 File ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_DataConversionof2001()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2001 into latest Quicken vesion
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	1/3/ 2011	Created by	Puja Verma
		[ ] //							31/3/2011	Modified by	Mamta Jain		
	[ ] // ********************************************************
[+] testcase Test01_DataConversionof2001() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sEndingBalance, sCaption, sWorkSheet
		[ ] INTEGER iEndingBalance, i
	[ ] 
	[ ] sWorkSheet = "2001"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sDataConversionFile,sWorkSheet)
	[ ] 
	[+] if (QuickenWindow.Exists() == True)
		[+] for(k = 1; k<= ListCount(lsExcelData); k++)
			[ ] lsConversionData = lsExcelData[k]
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9])
			[+] if(iConversionResult == PASS)
				[ ] ReportStatus("Validate File Conversion", PASS, "Correct message is displayed on converting 2001 data file")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL, "Correct message is not displayed while converting the 2001 data file")
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2002 File ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_DataConversionof2002()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2002 into latest Quicken vesion
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	1/3/ 2011	Created by	Puja Verma
		[ ] //							31/3/2011	Modified by	Mamta Jain	
	[ ] // ********************************************************
[+] testcase Test02_DataConversionof2002() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sEndingBalance, sCaption, sWorkSheet
		[ ] INTEGER iEndingBalance, i
	[ ] 
	[ ] sWorkSheet = "2002"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sDataConversionFile,sWorkSheet)
	[ ] 
	[+] if (QuickenWindow.Exists() == True)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.SetActive()
		[+] for(k = 1; k<= ListCount(lsExcelData); k++)
			[ ] lsConversionData = lsExcelData[k]
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9])
			[+] if(iConversionResult == PASS)
				[ ] ReportStatus("Validate File Conversion", PASS, "Correct message is displayed on converting 2002 data file")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL, "Correct message is not displayed while converting the 2002 data file")
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
[ ] //###################################################################
[ ] 
[+] // ############# DataConversion of 2003 File ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_DataConversionof2003()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2003 into latest Quicken vesion
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	1/3/ 2011	Created by	Puja Verma
		[ ] // 31/3/2011	Modified by	Mamta Jain		
	[ ] // ********************************************************
[+] testcase Test03_DataConversionof2003() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sEndingBalance, sCaption, sWorkSheet
		[ ] INTEGER iEndingBalance, i
	[ ] 
	[ ] sWorkSheet = "2003"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sDataConversionFile,sWorkSheet)
	[ ] 
	[+] if (QuickenWindow.Exists() == True)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.SetActive()
		[+] for(k = 1; k<= ListCount(lsExcelData); k++)
			[ ] lsConversionData = lsExcelData[k]
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9])
			[+] if(iConversionResult == PASS)
				[ ] ReportStatus("Validate File Conversion", PASS, "Correct message is displayed on converting 2003 data file")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL, "Correct message is not displayed while converting the 2003 data file")
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2004 File ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_DataConversionof2004()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2004 into latest Quicken vesion
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	1/3/ 2011	Created by	Puja Verma
		[ ] //							31/3/2011	Modified by	Mamta Jain	
	[ ] // ********************************************************
[+] testcase Test04_DataConversionof2004() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sCaption, sWorkSheet
		[ ] INTEGER iEndingBalance, iBackUpStatus
		[ ] 
	[ ] 
	[ ] sWorkSheet = "2004"
	[+] if (QuickenWindow.Exists() == True)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile, sWorkSheet)
		[ ] 
		[+] for(k = 1; k<=ListCount(lsExcelData); k++)
			[ ] 
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[ ] 
			[+] if(ISNULL(lsConversionData[1]))
				[ ] lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9])
			[ ] 
			[+] if(iConversionResult == PASS)
				[ ] CloseQuickenConnectedServices()
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[+] // Verify file Name
					[ ] QuickenWindow.SetActive ()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] 
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] // Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[+] // Verify Ending Balance
					[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is same.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is not same.")
				[ ] 
				[+] // Verify Transaction password
					[+] if(lsConversionData[13] != "")
						[ ] ReportStatus("Validate Transaction Password", FAIL, "No action to perform")
					[+] else
						[ ] ReportStatus("Validate Transaction Password", PASS, "Transaction Password column is empty")
				[ ] 
				[+] // Verify Attachments
					[+] if(lsConversionData[10] == "")
						[ ] ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Attachment", FAIL, "No action to perform")
				[ ] 
				[+] // Verify Report
					[+] if(lsConversionData[11] != "")
						[ ] ReportStatus("Validate Reports Column", FAIL, "No action to perform")
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[ ] // CloseQuicken()			// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])		// take back up of converted file
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed")
			[ ] 
	[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2005 File ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_DataConversionof2005()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2005 into latest Quicken vesion
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	1/3/ 2011	Created by	Puja Verma
		[ ] //							31/3/2011	Modified by	Mamta Jain		
	[ ] // ********************************************************
[+] testcase Test05_DataConversionof2005() appstate QuickenBaseState
	[+] // Variable Declaration
		[ ] STRING sCaption, sWorkSheet
		[ ] INTEGER iEndingBalance, iBackUpStatus
	[ ] 
	[ ] sWorkSheet = "2005"
	[+] if (QuickenWindow.Exists() == True)
		[ ] // QuickenWindow.SetActive()
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile, sWorkSheet)
		[ ] 
		[+] for(k = 1; k<=ListCount(lsExcelData); k++)
			[ ] 
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[ ] 
			[+] if(ISNULL(lsConversionData[1]))
				[ ] lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9])
			[ ] 
			[+] if(iConversionResult == PASS)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[+] // Verify file Name
					[ ] QuickenWindow.SetActive ()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] 
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] // Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[+] // Verify Ending Balance
					[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is same.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", FAIL, "{lsFileAttributes[7]} : Ending balance after conversion is not same.")
				[ ] 
				[+] // Verify transaction password
					[+] if(lsConversionData[13] != "")
						[ ] ReportStatus("Validate Reports Column", FAIL, "No action to perform")
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[+] // Verify Attachments
					[+] if(lsConversionData[10] == "")
						[ ] ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Attachment", FAIL, "No action to perform")
				[ ] 
				[+] // Verify Report
					[+] if(lsConversionData[11] != "")
						[ ] ReportStatus("Validate Reports Column", FAIL, "No action to perform")
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[ ] // CloseQuicken()			// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])			// take back up of converted file
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed")
				[ ] CloseQuicken()					// back up is not taken as file is not converted
			[ ] continue
	[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2006 File ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_DataConversionof2006()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2006 into latest Quicken vesion
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	1/3/ 2011	Created by	Puja Verma
		[ ] //							31/3/2011	Modified by	Mamta Jain		
	[ ] // ********************************************************
[+] testcase Test06_DataConversionof2006() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sCaption, sWorkSheet
		[ ] INTEGER iEndingBalance, iBackUpStatus
		[ ] iConversionResult=PASS
	[ ] 
	[ ] sWorkSheet = "2006"
	[+] if (QuickenWindow.Exists() == True)
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile, sWorkSheet)
		[ ] 
		[+] for(k = 1; k<=ListCount(lsExcelData); k++)
			[ ] 
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[ ] 
			[+] if(ISNULL(lsConversionData[1]))
				[ ] lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9])
			[ ] 
			[+] if(iConversionResult == PASS)
				[ ] CloseQuickenConnectedServices()
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[+] // Verify file Name
					[ ] QuickenWindow.SetActive ()
					[ ] CloseQuickenConnectedServices()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] 
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] // Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[+] // Verify Ending Balance
					[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is same.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is not same.")
				[ ] 
				[+] // Verify transaction password
					[+] if(lsConversionData[13] != "")
						[ ] ReportStatus("Validate Reports Column", FAIL, "No action to perform")
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[+] // Verify Attachments
					[+] if(lsConversionData[10] == "")
						[ ] ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Attachment", FAIL, "No action to perform")
				[ ] 
				[+] // Verify Report
					[+] if(lsConversionData[11] != "")
						[ ] ReportStatus("Validate Reports Column", FAIL, "No action to perform")
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[ ] // CloseQuicken()			// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])			// take back up of converted file
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed")
				[ ] CloseQuicken()					// back up is not taken as file is not converted
			[ ] continue
	[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2007 File ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_DataConversionof2007()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2007 into latest Quicken vesion
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	1/3/ 2011	Created by	Puja Verma
		[ ] //							31/3/2011	Modified by	Mamta Jain	
	[ ] // ********************************************************
[+] testcase Test07_DataConversionof2007() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sCaption, sWorkSheet, sNew, sActual, sHandle, sWindowType
		[ ] INTEGER iEndingBalance, iBackUpStatus, iOpenStatus, iFind, j, iCount
		[ ] BOOLEAN bMatch, bCompare
		[ ] STRING sAttachmentImage, sCount, sImageCompare
		[ ] 
		[ ] iConversionResult=PASS
	[ ] 
	[ ] sWorkSheet = "2007"
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile, sWorkSheet)
		[ ] //ListCount(lsExcelData)
		[+] for(k = 1; k<=ListCount(lsExcelData); k++)
			[+] if (QuickenWindow.Exists() == FALSE)
				[ ] APP_Start(sCmdLine)
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[ ] 
			[+] if(ISNULL(lsConversionData[1]))
				[ ] lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9], lsConversionData[12])
			[ ] 
			[+] if(iConversionResult == PASS)
				[ ] sleep(8)
				[ ] CloseQuickenConnectedServices()
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[+] // Verify file Name
					[ ] QuickenWindow.SetActive ()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] 
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] // Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[+] // Verify Ending Balance
					[+] if(k == 1)
						[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(k == 2)
						[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is same.{lsConversionData[7]}")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", FAIL, "{lsFileAttributes[7]} : Ending balance after conversion is not same.{lsConversionData[7]}")
				[ ] 
				[+] // // Verify Transaction password
					[+] // if(lsConversionData[13] != "")
						[ ] // QuickenMainWindow.QWNavigator.Update_Accounts.Click()
						[ ] // WaitForState(UnlockYourPasswordVault,TRUE,30)
						[+] // if(UnlockYourPasswordVault.Exists())
							[ ] // UnlockYourPasswordVault.Password.SetText(lsConversionData[13])
							[ ] // UnlockYourPasswordVault.OK.Click()
							[+] // if(AlertMessage.Exists())
								[ ] // AlertMessage.Close()
								[ ] // // AnnualPrivacyNoticeForQuicken.CloseButton.Click()
							[+] // if(OneStepUpdate.Exists())
								[ ] // OneStepUpdate.Cancel.Click()
							[ ] // ReportStatus("Validate Vault Password",PASS," Vault Password popup successfully appear")
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Validate Vault Password",FAIL," Vault Password popup did not appear")
							[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate Transaction Password Column", PASS, "Transaction Password Value is empty")
				[ ] 
				[+] // // Verify Attachment
					[+] // if(lsConversionData[10] != "")
						[ ] // 
						[ ] // sAttachmentImage = AUT_DATAFILE_PATH+ "\BitMapCompare\{lsConversionData[10]}"		// path of the file Exported file
						[ ] // sImageCompare = "{AUT_DATAFILE_PATH}\BitMapCompare\Attachment.bmp"	// path of the file to which exported file needs to be compared
						[ ] // 
						[ ] // UsePopupRegister("ON")		// Turn on pop up register mode
						[+] // if FileExists(sAttachmentImage)			// if file already exists, delete it
							[ ] // DeleteFile(sAttachmentImage)
						[ ] // 
						[ ] // AccountBarSelect(ACCOUNT_PROPERTYDEBT, 1)
						[ ] // AttachmentValidationPopup.SetActive()
						[ ] // AttachmentValidationPopup.Maximize()
						[ ] // AttachmentValidationPopup.TxList.TypeKeys (KEY_UP)
						[ ] // 
						[ ] // // Selecting the attachment property
						[ ] // AttachmentValidationPopup.TxList.TxToolbar.MenuButton.MoveMouse()
						[ ] // AttachmentValidationPopup.SetActive()
						[ ] // AttachmentValidationPopup.Maximize()
						[ ] // AttachmentValidationPopup.TxList.TxToolbar.MenuButton.Click()
						[ ] // AttachmentValidationPopup.TxList.TxToolbar.MenuButton.TypeKeys(Replicate (KEY_DN, 5))		// select attachment option 
						[+] // AttachmentValidationPopup.TxList.TxToolbar.MenuButton.TypeKeys(KEY_ENTER)
							[+] // if(TransactionAttachments.Exists(SHORT_SLEEP))
								[ ] // 
								[+] // if(FileDownloadAttachment.Exists(MEDIUM_SLEEP))
									[ ] // FileDownloadAttachment.SetActive ()
									[ ] // ReportStatus("Validate Attachment", PASS, "Attachment attached after converstion successfully")
									[ ] // FileDownloadAttachment.Cancel.Click ()
								[+] // else
									[+] // do
										[ ] // TransactionAttachments.SetActive ()
										[ ] // TransactionAttachments.Export.Click (1, 36, 10)			// Click on Export button
										[+] // if(ExportAttachmentFile.Exists(SHORT_SLEEP))	
											[ ] // ExportAttachmentFile.SetActive ()
											[ ] // ExportAttachmentFile.FileName.FileNameTextField.SetText (sAttachmentImage)		// Save attachment in TestData folder
											[ ] // ExportAttachmentFile.Save.Click ()
											[ ] // 
											[ ] // bCompare = SYS_CompareBinary (sAttachmentImage, sImageCompare)
											[+] // if(bCompare)
												[ ] // ReportStatus("Validate Attachment", PASS, "Attachment matches after converstion successfully")
											[+] // else
												[ ] // ReportStatus("Validate Attachment", FAIL, "Attachment did not match after File Converstion ")
										[ ] // 
										[+] // else
											[ ] // ReportStatus("Validate Attachment", FAIL, "Export Attachment Window is not available")
											[ ] // 
									[+] // except
										[ ] // LogWarning ("Exception number: {[EXCEPTION]ExceptNum ()}") 
								[ ] // TransactionAttachments.Done.Click()
							[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate Attachment", FAIL, "Attachment window is not opened")
						[ ] // 
						[ ] // AttachmentValidationPopup.Close()
					[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
				[ ] 
				[+] // Verify Saved Report		// original code
					[+] if(lsConversionData[11] != "")
						[ ] iOpenStatus = OpenReport(lsReportCategory[12], lsConversionData[11])		// open the report
						[+] if(iOpenStatus == PASS)
							[ ] MyTransactionReport.SetActive()
							[ ] iCount = MyTransactionReport.QWListViewer1.ListBox1.GetItemCount()
							[ ] sHandle = Str(MyTransactionReport.QWListViewer1.ListBox1.GetHandle())	   // get the handle
							[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(iCount-1))
							[ ] bMatch = MatchStr("*{lsConversionData[7]}*", sActual)						// For itemized report, verify the total
							[+] if(bMatch)
								[ ] ReportStatus("Validate Report", PASS, "{lsConversionData[11]} report is opened and total is also correct i.e. {lsConversionData[7]}")
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Report", FAIL, "{lsConversionData[11]} report is opened but total displayed is {sActual}")
								[ ] 
							[ ] wReport.Close ()			// Close the report
						[+] else
							[ ] ReportStatus("Validate Report", FAIL, "{lsConversionData[11]} Report not found")
							[ ] 
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[ ] 
				[ ] OpenDataFile(sFileName)
				[ ] sleep(2)
				[ ] // CloseQuicken()				// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])			// take back up of converted file
				[ ] 
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed")		
				[ ] CloseQuicken()					// back up is not taken as file is not converted
			[ ] continue
	[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2008 File ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_DataConversionof2008()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2008 into latest Quicken vesion
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	1/3/ 2011	Created by	Puja Verma
		[ ] //							31/3/2011	Modified by	Mamta Jain		
	[ ] // ********************************************************
[+] testcase Test08_DataConversionof2008() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sCaption, sWorkSheet, sNew
		[ ] INTEGER iEndingBalance, iBackUpStatus
	[ ] iConversionResult=PASS
	[ ] sWorkSheet = "2008"
	[+] if (QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile, sWorkSheet)
		[ ] 
		[+] for(k = 1; k<=ListCount(lsExcelData); k++)
			[ ] 
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[ ] 
			[+] if(ISNULL(lsConversionData[1]))
				[ ] lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9])
			[ ] 
			[+] if(iConversionResult == PASS)
				[ ] // QuickenWindow.SetActive ()
				[ ] 
				[+] // Verify file Name
					[ ] // QuickenWindow.SetActive ()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] 
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] // Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[+] // Verify Ending Balance
					[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is same.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", FAIL, "{lsFileAttributes[7]} : Ending balance after conversion is not same.")
				[ ] 
				[+] // Verify Attachment
					[+] if(lsConversionData[10] == "")
						[ ] ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Attachment", FAIL, "No action to perform")
				[ ] 
				[+] // Verify saved reports
					[+] if(lsConversionData[11] != "")
						[ ] ReportStatus("Validate Reports Column", FAIL, "No action to perform")
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[ ] OpenDataFile(sFileName)
				[ ] sleep(2)
				[ ] // CloseQuicken()			// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])		// take back up of converted file
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed")
				[ ] CloseQuicken()						// back up is not taken as file is not converted
			[ ] continue
		[ ] 
	[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2009 File  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_DataConversionof2009()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert 2009 data file and validate all the password configure in file .
		[ ] // Also verify the attachments and saved reports after conversion
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while validating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	11/04/2011	Created by	Mamta Jain	
		[ ] //							10/10/2011      Updated by	Udita Dube
	[ ] // ********************************************************
[+] testcase Test09_DataConversionof2009() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sEditDate = "10/10/2008"
		[ ] BOOLEAN bExists, bCompare
		[ ] INTEGER iFind, iEdit, iEndingBalance, iOpenStatus, j, iBackUpStatus, iCount
		[ ] STRING sWindowType, sCaption, sWorkSheet, sActual, sHandle, sErrorMsg, sImageCompare1, sImageCompare2
		[ ] STRING sLionAttachment, sExpectedErr
		[ ] STRING sEagleAttachment
		[ ] 
	[ ] sWorkSheet = "2009"
	[ ] sExpectedErr = "Quicken is not recognizing your password. Either you entered the wrong password, or this sometimes happens because, when you convert a data file to the most recent version of Quicken, Quicken changes the password to all caps. In that case, re-enter your password in all capital letters. (You can change the password back to lower-case later.)"
	[ ] iConversionResult=PASS
	[ ] 
	[+] if (QuickenWindow.Exists() == True)
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile, sWorkSheet)
		[ ] 
		[+] for(k = 1; k<= ListCount(lsExcelData); k++)
			[ ] 
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[ ] 
			[+] if(ISNULL(lsConversionData[1]))
				[ ] lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9], lsConversionData[12])
			[ ] 
			[+] if(iConversionResult == PASS)
				[ ] 
				[ ] CloseQuickenConnectedServices()
				[ ] 
				[ ] QuickenWindow.View.Click()
				[+] if(QuickenWindow.View.UsePopUpRegisters.IsChecked)		// checking the window type
					[ ] sWindowType = "PopUp"
				[+] else
					[ ] sWindowType = "MDI"
				[ ] 
				[ ] QuickenWindow.TypeKeys(KEY_ESC)
				[ ] 
				[+] // Verify file Name
					[ ] QuickenWindow.SetActive ()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] 
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] // Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[+] // Verify Ending Balance
					[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is same.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", FAIL, "{lsFileAttributes[7]} : Ending balance after conversion is not same.")
				[ ] 
				[+] // Verify saved report		// original code
					[+] if(lsConversionData[11] != "")
						[ ] lsSplit = Split(lsConversionData[11], ",")			// Creating a list of Reports
						[+] for(j = 1; j<=ListCount(lsSplit); j++)
							[ ] iOpenStatus = OpenReport(lsReportCategory[12], lsSplit[j])		// open the report
							[+] if(iOpenStatus == PASS)
								[ ] MyTransactionReport.SetActive()
								[ ] iCount = MyTransactionReport.QWListViewer1.ListBox1.GetItemCount()
								[ ] sHandle = Str(MyTransactionReport.QWListViewer1.ListBox1.GetHandle())	   // get the handle
								[+] for (i = iCount; i>= (iCount - 3); i--)
									[ ] 
									[+] if(lsSplit[j] == "My Transaction Report")
										[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
										[ ] bMatch = MatchStr("*TOTAL OUTFLOWS*-265,636.48*", sActual)						// For My Transaction Report, verify the total
									[+] if(lsSplit[j] == "My Itemized Payees")
										[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i+50))
										[ ] bMatch = MatchStr("*OVERALL TOTAL*-3,825.01*", sActual)						// For itemized report, verify the total
									[+] if(bMatch == TRUE)
										[+] if(MyTransactionReport.Exists())
											[ ] MyTransactionReport.SetActive()
											[ ] MyTransactionReport.Close()
											[ ] 
										[ ] ReportStatus("Validate Report", PASS, "{lsSplit[j]} report is opened and total is also correct")
										[ ] break
									[+] else
										[+] if(i == (iCount - 3))
											[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[j]} report is opened but total displayed is {sActual}")
										[ ] 
									[ ] 
							[+] else
								[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[j]} Report not found")
							[ ] // wReport.SetActive()
							[ ] // wReport.Close ()			// Close the report
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[+] // // Verify saved report				// for recording and demo
					[+] // if(lsConversionData[11] != "")
						[ ] // lsSplit = Split(lsConversionData[11], ",")			// Creating a list of Reports
						[+] // for(j = 1; j<=ListCount(lsSplit); j++)
							[ ] // iOpenStatus = OpenReport(lsReportCategory[12], lsSplit[j])		// open the report
							[ ] // QuickenMainWindow.DialogBox(lsSplit[j]).SetActive()
							[ ] // sHandle = Str(QuickenMainWindow.DialogBox(lsSplit[j]).CustomWin("[QWListViewer]#1"). ListBox("#1").GetHandle())
							[ ] // 
							[+] // if(iOpenStatus == PASS)
								[ ] // iCount = QuickenMainWindow.DialogBox(lsSplit[j]).CustomWin("[QWListViewer]#1"). ListBox("#1").GetItemCount()
								[+] // for (i = iCount; i>= (iCount - 3); i --)
									[ ] // sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
									[ ] // bMatch = MatchStr("*100.00*", sActual)						// For itemized report, verify the total
									[+] // if(bMatch == TRUE)
										[ ] // ReportStatus("Validate Report", PASS, "{lsSplit[j]} report is opened and total is also correct")
										[ ] // break
									[+] // else
										[+] // if(i == (iCount - 3))
											[ ] // ReportStatus("Validate Report", FAIL, "{lsSplit[j]} report is opened but total displayed is {sActual}")
										[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate Report", FAIL, "{lsSplit[i]} Report not found")
							[ ] // QuickenMainWindow.DialogBox(lsSplit[j]).Close()			// Close the report
					[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[+] // Verify Transaction password		
					[+] if(lsConversionData[13] != "")
						[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
						[ ] QuickenWindow.SetActive()
						[+] if(QuickenWindow.CalloutHolder.ReminderHolder.Exists(3))
							[ ] QuickenWindow.CalloutHolder.ReminderHolder.Close.Click()
						[ ] iFind = FindTransaction(sWindowType, "Bonus")
						[+] if(iFind == PASS)
							[ ] 
							[+] if(sWindowType == "MDI")
								[ ] 
								[ ] 
								[ ] MDIClient.AccountRegister.TxList.TypeKeys (sEditDate)
								[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
								[+] // if(TransactionPasswordRequired.Exists())
									[ ] // TransactionPasswordRequired.SetActive()
									[ ] // TransactionPasswordRequired.TransactionPasswordTextField.SetText(lsConversionData[13])
									[ ] // TransactionPasswordRequired.CustomWin("[QC_button]OK").Click()
									[+] // if(AlertMessage.Exists(SHORT_SLEEP))
										[ ] // AlertMessage.SetActive ()
										[ ] // sErrorMsg = AlertMessage.StaticText.GetText()
										[ ] // // defect id : QW007037 which is closed, FAQ is there for this.
										[+] // if(sExpectedErr == sErrorMsg)
											[ ] // ReportStatus("Validate Password window against defect id QW007037", PASS, "Correct Error Message is displayed.")
										[+] // else
											[ ] // ReportStatus("Validate Password window against defect id QW007037", FAIL, "Actual Error Message: {sErrorMsg} is displayed, Expected: {sExpectedErr}")
											[ ] // 
										[ ] // AlertMessage.Close()
										[ ] // TransactionPasswordRequired.SetActive()
										[ ] // TransactionPasswordRequired.TransactionPasswordTextField.SetText(Upper (lsConversionData[13]))
										[ ] // TransactionPasswordRequired.CustomWin("[QC_button]OK").Click()
									[ ] // 
								[+] if(QuickenPassword.Exists())
									[ ] QuickenPassword.SetActive()
									[ ] QuickenPassword.Password.SetText(lsConversionData[13])
									[ ] QuickenPassword.OK.Click()
									[+] if(AlertMessage.Exists(SHORT_SLEEP))
										[ ] AlertMessage.SetActive ()
										[ ] sErrorMsg = AlertMessage.StaticText.GetText()
										[ ] // defect id : QW007037 which is closed, FAQ is there for this.
										[+] if(sExpectedErr == sErrorMsg)
											[ ] ReportStatus("Validate Password window against defect id QW007037", PASS, "Correct Error Message is displayed.")
										[+] else
											[ ] ReportStatus("Validate Password window against defect id QW007037", FAIL, "Actual Error Message: {sErrorMsg} is displayed, Expected: {sExpectedErr}")
											[ ] 
										[ ] AlertMessage.Close()
										[ ] QuickenPassword.SetActive()
										[ ] QuickenPassword.Password.SetText(Upper (lsConversionData[13]))
										[ ] QuickenPassword.OK.Click()
									[ ] 
								[+] else
									[ ] ReportStatus("Validate Password window", FAIL, "Password window did not appear")
									[ ] 
								[ ] 
							[+] else if (sWindowType == "PopUp")
								[ ] // BankingPopUp.VerifyEnabled(TRUE, 10)
								[ ] BankingPopUp.SetActive()
								[ ] BankingPopUp.TypeKeys (sEditDate)
								[ ] BankingPopUp.TypeKeys(Replicate(KEY_TAB, 6))
								[ ] BankingPopUp.TxList.TxToolbar.Save.Click()
								[+] if(QuickenMainWindow.DialogBox("Transaction password required").Exists())
									[ ] QuickenMainWindow.DialogBox("Transaction password required").SetActive()
									[ ] QuickenMainWindow.DialogBox("Transaction password required").TextField("$104").SetText(lsConversionData[13])
									[ ] QuickenMainWindow.DialogBox("Transaction password required").CustomWin("[QC_button]OK").Click()
									[+] if(AlertMessage.Exists(SHORT_SLEEP))
										[ ] AlertMessage.SetActive ()
										[ ] sErrorMsg = AlertMessage.StaticText.GetText()
										[ ] // defect id : QW007037 which is closed, FAQ is there for this.
										[+] if(sExpectedErr == sErrorMsg)
											[ ] ReportStatus("Validate Password window against defect id QW007037", PASS, "Correct Error Message is displayed.")
										[+] else
											[ ] ReportStatus("Validate Password window against defect id QW007037", FAIL, "Actual Error Message: {sErrorMsg} is displayed, Expected: {sExpectedErr}")
											[ ] 
										[ ] AlertMessage.Close()
										[ ] QuickenMainWindow.DialogBox("Transaction password required").SetActive()
										[ ] QuickenMainWindow.DialogBox("Transaction password required").TextField("$104").SetText(Upper (lsConversionData[13]))
										[ ] QuickenMainWindow.DialogBox("Transaction password required").CustomWin("[QC_button]OK").Click()
									[ ] 
								[+] else
									[ ] ReportStatus("Validate Password window", FAIL, "Password window did not appear")
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Window Type", FAIL, "{sWindowType} is not valid")
								[ ] 
						[ ] 
						[+] else
							[ ] ReportStatus("Verify Transaction", FAIL, "Transaction with Bonus as one of its value is not found")
					[+] else
						[ ] ReportStatus("Validate Transaction Password Column", PASS, "Transaction Password Value is empty")
				[ ] 
				[+] // // Verify attachment
					[+] // if(lsConversionData[10] != "")
						[ ] // lsSplit = Split(lsConversionData[10], ",")			// Creating a list of attachments
						[ ] // 
						[+] // if SYS_DirExists(sExportedFolder)			// if folder in which exported files are saved exists, delete it
							[ ] // DeleteDir(sExportedFolder)
							[ ] // MakeDir(sExportedFolder)					// create the folder
						[ ] // 
						[ ] // sLionAttachment = "{sExportedFolder}\Lion.bmp"	
						[ ] // sEagleAttachment = "{sExportedFolder}\Eagle.bmp"
						[ ] // sImageCompare1 =  "{AUT_DATAFILE_PATH}\BitMapCompare\{lsSplit[1]}"
						[ ] // sImageCompare2 = "{AUT_DATAFILE_PATH}\BitMapCompare\{lsSplit[2]}"
						[ ] // UsePopUpRegister("ON")	 	// Turn on pop up register mode
						[+] // // if(AlertMessage.Exists(SHORT_SLEEP))			// dialog box appears for saving the changed transaction
							[ ] // // AlertMessage.SetActive ()
							[ ] // // AlertMessage.No.Click ()
						[ ] // 
						[ ] // sWindowType = "PopUp"
						[ ] // AccountBarSelect(ACCOUNT_BANKING, 1)
						[ ] // iFind = FindTransaction(sWindowType, "Bonus")
						[+] // if(iFind == PASS)
							[ ] // BankingPopUp.SetActive()
							[ ] // BankingPopUp.Maximize()
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.Click (1, 8, 6)
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.TypeKeys(Replicate (KEY_DN, 5))		// select attachment option 
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.TypeKeys(KEY_ENTER)
							[ ] // 
							[+] // if(TransactionAttachments.Exists(SHORT_SLEEP))
								[ ] // 
								[+] // if(FileDownloadAttachment.Exists(MEDIUM_SLEEP))
									[ ] // FileDownloadAttachment.SetActive ()
									[ ] // ReportStatus("Validate Attachment", PASS, "Attachment attached after converstion successfully")
									[ ] // FileDownloadAttachment.Cancel.Click ()
								[+] // else
									[+] // do
										[ ] // TransactionAttachments.SetActive()
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.Click()
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_DN)
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_DN)
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_ENTER)
										[+] // if(ExportAttachmentFile.Exists(SHORT_SLEEP))	
											[ ] // ExportAttachmentFile.SetActive ()
											[ ] // ExportAttachmentFile.FileName.FileNameTextField.SetText (sLionAttachment)		// Save attachment in TestData folder
											[ ] // ExportAttachmentFile.Save.Click ()
											[ ] // 
											[ ] // bCompare = SYS_CompareBinary (sLionAttachment, sImageCompare1)
											[+] // if(bCompare == TRUE)
												[ ] // ReportStatus("Validate Attachment", PASS, "First Attachment (i.e. Lion) matches after converstion successfully")
											[ ] // 
											[+] // else
												[ ] // ReportStatus("Validate Attachment", FAIL, "First Attachment (i.e. Lion) did not match after File Converstion ")
										[+] // else
											[ ] // ReportStatus("Validate Attachment", FAIL, "Export Attachment Window is not available")
											[ ] // 
										[ ] // 
										[ ] // TransactionAttachments.Panel1.QWinChild1.Panel2.Click (1, 74, 34)
										[ ] // TransactionAttachments.Export.Click (1, 36, 10)			// Click on Export button
										[+] // if(ExportAttachmentFile.Exists(SHORT_SLEEP))	
											[ ] // ExportAttachmentFile.SetActive ()
											[ ] // ExportAttachmentFile.FileName.FileNameTextField.SetText (sEagleAttachment)		// Save attachment in TestData folder
											[ ] // ExportAttachmentFile.Save.Click ()
											[ ] // 
											[ ] // bCompare = SYS_CompareBinary (sEagleAttachment, sImageCompare2)
											[+] // if(bCompare == TRUE)
												[ ] // ReportStatus("Validate Attachment", PASS, "Second Attachment (i.e. Eagle) matches after converstion successfully")
											[ ] // 
											[+] // else
												[ ] // ReportStatus("Validate Attachment", FAIL, "Second Attachment (i.e. Eagle) did not match after File Converstion ")
										[ ] // 
										[+] // else
											[ ] // ReportStatus("Validate Attachment", FAIL, "Export Attachment Window is not available")
											[ ] // 
										[ ] // 
									[+] // except
										[ ] // LogWarning ("Exception number: {[EXCEPTION]ExceptNum ()}") 
									[ ] // 
								[ ] // TransactionAttachments.Done.Click()
							[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate Attachment", FAIL, "Attachment window is not opened")
							[ ] // 
							[ ] // BankingPopUp.Close()
						[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify Transaction", FAIL, "Transaction with Bonus as one of its value is not found")
					[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
				[ ] 
				[ ] OpenDataFile(sFileName)
				[ ] sleep(2)
				[ ] // CloseQuicken()		// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])			// take back up of converted file
				[ ] 
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed")
				[ ] CloseQuicken()								// back up is not taken as file is not converted
			[ ] 
			[ ] continue
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2010 File  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_DataConversionof2010()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert 2010 data file and validate all the password configure in file .
		[ ] // Also verify the attachments and Saved reports after conversion.
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while validating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	04/04/2011	Created by	Mamta Jain	
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test10_DataConversionof2010() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sEditDate = "10/10/2008"
		[ ] STRING sAccountName = "Checking"
		[ ] BOOLEAN bExists, bCompare
		[ ] INTEGER iFind, iEdit, iEndingBalance, iOpenStatus, j, iBackUpStatus, iCount
		[ ] STRING sWindowType, sCaption, sWorkSheet, sActual, sHandle
		[ ] STRING sLionAttachment, sImageCompare1, sImageCompare2, sEagleAttachment
	[ ] iConversionResult=PASS
	[ ] sWorkSheet = "2010"
	[+] if (QuickenWindow.Exists() == True)
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile, sWorkSheet)
		[ ] 
		[+] for(k = 1; k<= ListCount(lsExcelData); k++)
			[ ] 
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[ ] 
			[+] if(ISNULL(lsConversionData[1]))
				[ ] lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9], lsConversionData[12])
			[ ] 
			[+] if(iConversionResult == PASS)
				[ ] 
				[+] // if(QuickenWindow.View.UsePopUpRegisters.IsChecked)		// checking the window type
					[ ] // sWindowType = "PopUp"
				[+] // else
					[ ] sWindowType = "MDI"
				[ ] 
				[+] // Verify file Name
					[ ] QuickenWindow.SetActive ()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] 
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] //Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[+] //Verify Ending Balance
					[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is same.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", FAIL, "{lsFileAttributes[7]} : Ending balance after conversion is not same.")
				[ ] 
				[+] // Verify saved report			// Original code
					[+] if(lsConversionData[11] != "")
						[ ] lsSplit = Split(lsConversionData[11], ",")			// Creating a list of Reports
						[+] for(j = 1; j<=ListCount(lsSplit); j++)
							[ ] iOpenStatus = OpenReport(lsReportCategory[12], lsSplit[j])		// open the report
							[+] if(iOpenStatus == PASS)
								[ ] MyTransactionReport.SetActive()
								[ ] MyTransactionReport.QWCustomizeBar1.DateRangeComboBox.Select(1)
								[ ] sHandle = Str(MyTransactionReport.QWListViewer1.ListBox1.GetHandle())	   // get the handle
								[+] if(j == 1)
									[ ] 
									[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "91")
									[ ] bMatch = MatchStr("*NET TOTAL*-205,189.20*", sActual)						
									[+] if(bMatch == TRUE)
										[ ] ReportStatus("Validate Report", PASS, "{lsSplit[j]} report is opened and total is also correct i.e. -205,189.20")
										[ ] 
									[+] else
										[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[j]} report is opened but total displayed is {sActual}")
										[ ] 
									[ ] MyTransactionReport.SetActive()
									[ ] MyTransactionReport.TypeKeys(KEY_ALT_F4)
									[+] if(SaveChangesToMyReport.Exists(10))
										[ ] SaveChangesToMyReport.Save.Click()
									[ ] 
								[+] if(j ==2)
									[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "91")
									[ ] bMatch = MatchStr("*OVERALL TOTAL*-3,825.01*", sActual)						
									[+] if(bMatch == TRUE)
										[ ] ReportStatus("Validate Report", PASS, "{lsSplit[j]} report is opened and total is also correct i.e. -3,825.01")
										[ ] 
									[+] else
										[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[j]} report is opened but total displayed is {sActual}")
										[ ] 
									[ ] wReport.SetActive()
									[ ] wReport.TypeKeys(KEY_ALT_F4)
									[+] if(SaveChangesToMyReport.Exists(10))
										[ ] SaveChangesToMyReport.Save.Click()
									[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[i]} Report not found")
							[ ] 
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[+] // //Verify saved report				// for recording and demo
					[+] // if(lsConversionData[11] != "")
						[ ] // lsSplit = Split(lsConversionData[11], ",")			// Creating a list of Reports
						[+] // for(j = 1; j<=ListCount(lsSplit); j++)
							[ ] // iOpenStatus = OpenReport(lsReportCategory[12], lsSplit[j])		// open the report
							[ ] // QuickenMainWindow.DialogBox(lsSplit[j]).SetActive()
							[ ] // sHandle = Str(QuickenMainWindow.DialogBox(lsSplit[j]).CustomWin("[QWListViewer]#1"). ListBox("#1").GetHandle())
							[ ] // 
							[+] // if(iOpenStatus == PASS)
								[ ] // iCount = QuickenMainWindow.DialogBox(lsSplit[j]).CustomWin("[QWListViewer]#1"). ListBox("#1").GetItemCount()
								[+] // for (i = iCount; i>= (iCount - 3); i --)
									[ ] // sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
									[ ] // bMatch = MatchStr("*100.00*", sActual)						// For itemized report, verify the total
									[+] // if(bMatch == TRUE)
										[ ] // ReportStatus("Validate Report", PASS, "{lsSplit[j]} report is opened and total is also correct")
										[ ] // break
									[+] // else
										[+] // if(i == (iCount - 3))
											[ ] // ReportStatus("Validate Report", FAIL, "{lsSplit[j]} report is opened but total displayed is {sActual}")
										[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate Report", FAIL, "{lsSplit[i]} Report not found")
							[ ] // QuickenMainWindow.DialogBox(lsSplit[j]).Close()			// Close the report
					[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[+] // Verify Transaction password		// original code
					[+] if(lsConversionData[13] != "")
						[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
						[ ] QuickenWindow.SetActive()
						[+] if(QuickenWindow.CalloutHolder.ReminderHolder.Exists(3))
							[ ] QuickenWindow.CalloutHolder.ReminderHolder.Close.Click()
						[ ] 
						[ ] iFind = FindTransaction(sWindowType, "Bonus")
						[+] if(iFind == PASS)
							[ ] 
							[+] if(sWindowType == "MDI")
								[ ] 
								[ ] MDIClient.AccountRegister.TxList.TypeKeys (sEditDate)
								[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
								[+] if(TransactionPasswordRequired.Exists())
									[ ] TransactionPasswordRequired.SetActive()
									[ ] TransactionPasswordRequired.TransactionPasswordTextField.SetText(lsConversionData[13])
									[ ] TransactionPasswordRequired.OKButton.Click()
								[+] else
									[ ] ReportStatus("Validate Password window", FAIL, "Password window did not appear")
									[ ] 
								[ ] 
							[+] else if (sWindowType == "PopUp")
								[ ] // BankingPopUp.VerifyEnabled(TRUE, 10)
								[ ] BankingPopUp.SetActive()
								[ ] BankingPopUp.TypeKeys (sEditDate)
								[ ] BankingPopUp.TypeKeys(Replicate(KEY_TAB, 6))
								[ ] BankingPopUp.TxList.TxToolbar.Save.Click()
								[+] if(QuickenPassword.Exists())
									[ ] QuickenPassword.SetActive()
									[ ] QuickenPassword.Password.SetText(lsConversionData[13])
									[ ] QuickenPassword.OK.Click()
								[+] else
									[ ] ReportStatus("Validate Password window", FAIL, "Password window did not appear")
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Window Type", FAIL, "{sWindowType} is not valid")
								[ ] 
						[ ] 
						[+] else
							[ ] ReportStatus("Verify Transaction", FAIL, "Transaction with Bonus as one of its value is not found")
					[+] else
						[ ] ReportStatus("Validate Transaction Password Column", PASS, "Transaction Password Value is empty")
				[ ] 
				[+] // // Verify Attachment
					[+] // if(lsConversionData[10] != "")
						[ ] // lsSplit = Split(lsConversionData[10], ",")			// Creating a list of attachments
						[ ] // 
						[+] // if SYS_DirExists(sExportedFolder)			// if folder in which exported files are saved exists, delete it
							[ ] // DeleteDir(sExportedFolder)
							[ ] // MakeDir(sExportedFolder)					// create the folder
						[ ] // 
						[ ] // sLionAttachment = "{sExportedFolder}\Lion.bmp"		// Path of the Exported Image
						[ ] // sEagleAttachment = "{sExportedFolder}\Eagle.bmp"
						[ ] // sImageCompare1 =  "{AUT_DATAFILE_PATH}\BitMapCompare\{lsSplit[1]}"		// path of the image to be compared with exported image
						[ ] // sImageCompare2 = "{AUT_DATAFILE_PATH}\BitMapCompare\{lsSplit[2]}"
						[ ] // UsePopUpRegister("ON")	 	// Turn on pop up register mode
						[+] // // if(AlertMessage.Exists(SHORT_SLEEP))			// dialog box appears for saving the changed transaction
							[ ] // // AlertMessage.SetActive ()
							[ ] // // AlertMessage.No.Click ()
						[ ] // 
						[ ] // sWindowType = "PopUp"
						[ ] // iFind = FindTransaction(sWindowType, "Bonus")
						[+] // if(iFind == PASS)
							[ ] // BankingPopUp.SetActive()
							[ ] // BankingPopUp.Maximize()
							[ ] // 
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.Click (1, 8, 6)
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.TypeKeys(Replicate (KEY_DN, 5))		// select attachment option 
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.TypeKeys(KEY_ENTER)
							[ ] // 
							[+] // if(TransactionAttachments.Exists(SHORT_SLEEP))
								[ ] // 
								[+] // if(FileDownloadAttachment.Exists(MEDIUM_SLEEP))
									[ ] // FileDownloadAttachment.SetActive ()
									[ ] // ReportStatus("Validate Attachment", PASS, "Attachment attached after converstion successfully")
									[ ] // FileDownloadAttachment.Cancel.Click ()
								[+] // else
									[+] // do
										[ ] // TransactionAttachments.SetActive()
										[ ] // TransactionAttachments.Export.Click (1, 36, 10)			// Click on Export button
										[+] // if(ExportAttachmentFile.Exists(SHORT_SLEEP))	
											[ ] // ExportAttachmentFile.SetActive ()
											[ ] // ExportAttachmentFile.FileName.FileNameTextField.SetText (sLionAttachment)		// Save attachment in TestData folder
											[ ] // ExportAttachmentFile.Save.Click ()
											[ ] // 
											[ ] // bCompare = SYS_CompareBinary (sLionAttachment, sImageCompare1)		 // compare exported and already stored file
											[+] // if(bCompare == TRUE)
												[ ] // ReportStatus("Validate Attachment", PASS, "First Attachment (i.e. Lion) matches after converstion successfully")
											[ ] // 
											[+] // else
												[ ] // ReportStatus("Validate Attachment", FAIL, "First Attachment (i.e. Lion) did not match after File Converstion ")
										[ ] // 
										[+] // else
											[ ] // ReportStatus("Validate Attachment", FAIL, "Export Attachment Window is not available")
											[ ] // 
										[ ] // 
										[ ] // TransactionAttachments.Panel1.QWinChild1.Panel2.Click (1, 74, 34)		// click on second attachment
										[ ] // TransactionAttachments.Export.Click (1, 36, 10)			// Click on Export button
										[+] // if(ExportAttachmentFile.Exists(SHORT_SLEEP))	
											[ ] // ExportAttachmentFile.SetActive ()
											[ ] // ExportAttachmentFile.FileName.FileNameTextField.SetText (sEagleAttachment)		// Save attachment in TestData folder
											[ ] // ExportAttachmentFile.Save.Click ()
											[ ] // 
											[ ] // bCompare = SYS_CompareBinary (sEagleAttachment, sImageCompare2)
											[+] // if(bCompare == TRUE)
												[ ] // ReportStatus("Validate Attachment", PASS, "Second Attachment (i.e. Eagle) matches after converstion successfully")
											[ ] // 
											[+] // else
												[ ] // ReportStatus("Validate Attachment", FAIL, "Second Attachment (i.e. Eagle) did not match after File Converstion ")
										[ ] // 
										[+] // else
											[ ] // ReportStatus("Validate Attachment", FAIL, "Export Attachment Window is not available")
											[ ] // 
										[ ] // 
									[+] // except
										[ ] // LogWarning ("Exception number: {[EXCEPTION]ExceptNum ()}") 
									[ ] // 
								[ ] // TransactionAttachments.Done.Click()
							[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate Attachment", FAIL, "Attachment window is not opened")
							[ ] // 
							[ ] // BankingPopUp.Close()
						[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify Transaction", FAIL, "Transaction with Bonus as one of its value is not found")
					[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
					[ ] // 
				[ ] 
				[ ] OpenDataFile(sFileName)
				[ ] sleep(2)
				[ ] // CloseQuicken()		// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])		// take back up of converted file 
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed")
				[ ] CloseQuicken()						// back up is not taken as file is not converted
			[ ] continue
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2011 File  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_DataConversionof2011()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert 2011 data file and validate all the password configure in file .
		[ ] // Also verify the attachments and saved reports after conversion
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while validating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	04/04/2011	Created by	Mamta Jain	
		[ ] //							10/10/2011      Updated by	Udita Dube
	[ ] // ********************************************************
[+] testcase Test11_DataConversionof2011() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sEditDate = "10/10/2008"
		[ ] BOOLEAN bExists, bCompare
		[ ] INTEGER iFind, iEdit, iEndingBalance, iOpenStatus, j, iBackUpStatus, iCount
		[ ] STRING sWindowType, sCaption, sWorkSheet, sActual, sHandle
		[ ] STRING sLionAttachment, sImageCompare1, sImageCompare2, sEagleAttachment
		[ ] iConversionResult=PASS
	[ ] sWorkSheet = "2011"
	[+] if (QuickenWindow.Exists() == True)
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile, sWorkSheet)
		[ ] // 
		[+] for(k = 1; k<= ListCount(lsExcelData); k++)
			[ ] 
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[ ] 
			[+] if(ISNULL(lsConversionData[1]))
				[ ] lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9], lsConversionData[12])
			[ ] 
			[+] if(iConversionResult == PASS)
				[ ] 
				[ ] QuickenWindow.View.Click()
				[+] // if(QuickenWindow.View.UsePopUpRegisters.IsChecked)		// checking the window type
					[ ] // sWindowType = "PopUp"
				[+] // else
					[ ] sWindowType = "MDI"
				[ ] 
				[+] // Verify file Name
					[ ] QuickenWindow.SetActive ()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] 
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] // Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[+] // Verify Ending Balance
					[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is same.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", FAIL, "{lsFileAttributes[7]} : Ending balance after conversion is not same.")
				[ ] 
				[+] // Verify saved report			// original code
					[+] if(lsConversionData[11] != "")
						[ ] lsSplit = Split(lsConversionData[11], ",")			// Creating a list of Reports
						[+] for(j = 1; j<=ListCount(lsSplit); j++)
							[ ] iOpenStatus = OpenReport(lsReportCategory[12], lsSplit[j])		// open the report
							[+] if(iOpenStatus == PASS)
								[ ] MyTransactionReport.SetActive()
								[ ] sHandle = Str(MyTransactionReport.QWListViewer1.ListBox1.GetHandle())	   // get the handle
								[+] if(j == 1)
									[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "12")
									[ ] bMatch = MatchStr("*{lsConversionData[7]}*", sActual)						
									[+] if(bMatch == TRUE)
										[ ] ReportStatus("Validate Report", PASS, "{lsSplit[j]} report is opened and total is also correct")
										[ ] 
									[+] else
										[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[j]} report is opened but total displayed is {sActual}")
										[ ] 
									[ ] 
								[+] if(j ==2)
									[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "5")
									[ ] bMatch = MatchStr("*20.00*", sActual)						
									[+] if(bMatch == TRUE)
										[ ] ReportStatus("Validate Report", PASS, "{lsSplit[j]} report is opened and total is also correct")
										[ ] 
									[+] else
										[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[j]} report is opened but total displayed is {sActual}")
										[ ] 
									[ ] 
								[ ] wReport.Close ()			// Close the report
							[+] else
								[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[i]} Report not found")
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[+] // Verify Transaction password		
					[+] if(lsConversionData[13] != "")
						[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
						[ ] QuickenWindow.SetActive()
						[+] if(QuickenWindow.CalloutHolder.ReminderHolder.Exists(3))
							[ ] QuickenWindow.CalloutHolder.ReminderHolder.Close.Click()
						[ ] 
						[ ] iFind = FindTransaction(sWindowType, "Bonus")
						[+] if(iFind == PASS)
							[ ] 
							[+] if(sWindowType == "MDI")
								[ ] MDIClient.AccountRegister.TxList.TypeKeys (sEditDate)
								[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
								[+] // if(QuickenMainWindow.DialogBox("Transaction password required").Exists())
									[ ] // QuickenMainWindow.DialogBox("Transaction password required").SetActive()
									[ ] // QuickenMainWindow.DialogBox("Transaction password required").TextField("$104").SetText(lsConversionData[13])
									[ ] // QuickenMainWindow.DialogBox("Transaction password required").CustomWin("[QC_button]OK").Click()
								[+] // else
									[ ] // ReportStatus("Validate Password window", FAIL, "Password window did not appear")
									[ ] // 
								[+] if(TransactionPasswordRequired.Exists())
									[ ] TransactionPasswordRequired.SetActive()
									[ ] sleep(1)
									[ ] TransactionPasswordRequired.TransactionPasswordTextField.SetText(lsConversionData[13])
									[ ] TransactionPasswordRequired.OKButton.Click()
								[+] else
									[ ] ReportStatus("Validate Password window", FAIL, "Password window did not appear")
									[ ] 
								[ ] 
								[ ] 
							[+] else if (sWindowType == "PopUp")
								[ ] // BankingPopUp.VerifyEnabled(TRUE, 10)
								[ ] BankingPopUp.SetActive()
								[ ] BankingPopUp.TypeKeys (sEditDate)
								[ ] BankingPopUp.TypeKeys(Replicate(KEY_TAB, 6))
								[ ] BankingPopUp.TxList.TxToolbar.Save.Click()
								[+] if(QuickenMainWindow.DialogBox("Transaction password required").Exists())
									[ ] QuickenMainWindow.DialogBox("Transaction password required").SetActive()
									[ ] QuickenMainWindow.DialogBox("Transaction password required").TextField("$104").SetText(lsConversionData[13])
									[ ] QuickenMainWindow.DialogBox("Transaction password required").CustomWin("[QC_button]OK").Click()
								[+] else
									[ ] ReportStatus("Validate Password window", FAIL, "Password window did not appear")
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Window Type", FAIL, "{sWindowType} is not valid")
								[ ] 
						[ ] 
						[+] else
							[ ] ReportStatus("Verify Transaction", FAIL, "Transaction with Bonus as one of its value is not found")
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Transaction Password Column", PASS, "Transaction Password Value is empty")
				[ ] 
				[+] // // Verify attachment
					[+] // if(lsConversionData[10] != "")
						[ ] // lsSplit = Split(lsConversionData[10], ",")			// Creating a list of attachments
						[ ] // 
						[+] // if SYS_DirExists(sExportedFolder)			// if folder in which exported files are saved exists, delete it
							[ ] // DeleteDir(sExportedFolder)
							[ ] // MakeDir(sExportedFolder)					// create the folder
						[ ] // 
						[ ] // sLionAttachment = "{sExportedFolder}\Lion.bmp"		// Path of the Exported Image
						[ ] // sEagleAttachment = "{sExportedFolder}\Eagle.bmp"
						[ ] // sImageCompare1 =  "{AUT_DATAFILE_PATH}\BitMapCompare\{lsSplit[1]}"		// path of the image to be compared with exported image
						[ ] // sImageCompare2 = "{AUT_DATAFILE_PATH}\BitMapCompare\{lsSplit[2]}"
						[ ] // 
						[ ] // UsePopUpRegister("ON")	 	// Turn on pop up register mode
						[+] // // if(AlertMessage.Exists(SHORT_SLEEP))			// dialog box appears for saving the changed transaction
							[ ] // // AlertMessage.SetActive ()
							[ ] // // AlertMessage.No.Click ()
						[ ] // 
						[ ] // sWindowType = "PopUp"
						[ ] // iFind = FindTransaction(sWindowType, "Bonus")
						[+] // if(iFind == PASS)
							[ ] // BankingPopUp.SetActive()
							[ ] // BankingPopUp.Maximize()
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.Click (1, 8, 6)
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.TypeKeys(Replicate (KEY_DN, 5))		// select attachment option 
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.TypeKeys(KEY_ENTER)
							[ ] // 
							[+] // if(TransactionAttachments.Exists(SHORT_SLEEP))
								[ ] // 
								[+] // if(FileDownloadAttachment.Exists(MEDIUM_SLEEP))
									[ ] // FileDownloadAttachment.SetActive ()
									[ ] // ReportStatus("Validate Attachment", PASS, "Attachment attached after converstion successfully")
									[ ] // FileDownloadAttachment.Cancel.Click ()
								[+] // else
									[+] // do
										[ ] // TransactionAttachments.SetActive()
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.Click()
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_DN)
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_DN)
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_ENTER)
										[+] // if(ExportAttachmentFile.Exists(SHORT_SLEEP))	
											[ ] // ExportAttachmentFile.SetActive ()
											[ ] // ExportAttachmentFile.FileName.FileNameTextField.SetText(sLionAttachment)		// Save attachment in TestData folder
											[ ] // ExportAttachmentFile.Save.Click ()
											[ ] // 
											[ ] // bCompare = SYS_CompareBinary (sLionAttachment, sImageCompare1)		 // compare exported and already stored file
											[+] // if(bCompare == TRUE)
												[ ] // ReportStatus("Validate Attachment", PASS, "First Attachment (i.e. Lion) matches after converstion successfully")
											[+] // else
												[ ] // ReportStatus("Validate Attachment", FAIL, "First Attachment (i.e. Lion) did not match after File Converstion ")
										[+] // else
											[ ] // ReportStatus("Validate Attachment", FAIL, "Export Attachment Window is not available")
											[ ] // 
										[ ] // 
										[ ] // // TransactionAttachments.Panel1.QWinChild1.Panel2.Click (1, 74, 34)		// click on second attachment
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel2.Export.Click()
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_DN)
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_DN)
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_ENTER)
										[+] // if(ExportAttachmentFile.Exists(SHORT_SLEEP))	
											[ ] // ExportAttachmentFile.SetActive ()
											[ ] // ExportAttachmentFile.FileName.FileNameTextField.SetText(sEagleAttachment)		// Save attachment in TestData folder
											[ ] // ExportAttachmentFile.Save.Click ()
											[ ] // 
											[ ] // // bCompare = SYS_CompareBinary (sEagleAttachment, sImageCompare2)
											[+] // // if(bCompare == TRUE)
												[ ] // // ReportStatus("Validate Attachment", PASS, "Second Attachment (i.e. Eagle) matches after converstion successfully")
											[ ] // // 
											[+] // // else
												[ ] // // ReportStatus("Validate Attachment", FAIL, "Second Attachment (i.e. Eagle) did not match after File Converstion ")
										[ ] // 
										[+] // else
											[ ] // ReportStatus("Validate Attachment", FAIL, "Export Attachment Window is not available")
											[ ] // 
										[ ] // 
									[+] // except
										[ ] // LogWarning ("Exception number: {[EXCEPTION]ExceptNum ()}") 
									[ ] // 
								[ ] // TransactionAttachments.Done.Click()
							[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate Attachment", FAIL, "Attachment window is not opened")
							[ ] // 
							[ ] // BankingPopUp.Close()
						[ ] // 
						[+] // // else
							[ ] // // ReportStatus("Verify Transaction", FAIL, "Transaction with Bonus as one of its value is not found")
					[ ] // // 
					[+] // // else
						[ ] // // ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
					[ ] // 
				[ ] 
				[ ] OpenDataFile(sFileName)
				[ ] // CloseQuicken()		// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])		// take back up of converted file
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed due to defect id : QW011567")
				[ ] CloseQuicken()							// back up is not taken as file is not converted
			[ ] continue
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2012File  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_DataConversionof2012()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert 2012 data file and validate all the password configure in file .
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while validating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	07/06/2012	Created by	Puja Verma	
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test12_DataConversionof2012() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sCaption, sWorkSheet, sNew
		[ ] INTEGER iEndingBalance, iBackUpStatus
	[ ] 
	[ ] sWorkSheet = "2012"
	[+] if (QuickenWindow.Exists() == True)
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile,sWorkSheet)
		[ ] 
		[+] for(k = 1; k<=ListCount(lsExcelData); k++)
			[ ] 
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[+] if(ISNULL(lsConversionData[1]))
				[ ] lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9],lsConversionData[12])
			[ ] 
			[+] if(iConversionResult == PASS)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[+] // Verify file Name
					[ ] QuickenWindow.SetActive ()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] 
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] // Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[+] // Verify Ending Balance
					[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is same.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsFileAttributes[7]} : Ending balance after conversion is not same.")
				[ ] 
				[+] // Verify Attachment
					[+] if(lsConversionData[10] == "")
						[ ] ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Attachment", FAIL, "No action to perform")
				[ ] 
				[+] // Verify saved reports
					[+] if(lsConversionData[11] != "")
						[ ] ReportStatus("Validate Reports Column", FAIL, "No action to perform")
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[ ] OpenDataFile(sFileName)
				[ ] sleep(2)
				[ ] // CloseQuicken()			// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])		// take back up of converted file
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed")
				[ ] CloseQuicken()						// back up is not taken as file is not converted
			[ ] continue
		[ ] 
	[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //############# DataConversion of 2013 File  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_DataConversionof2013()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert 2013 data file and validate all the password configure in file .
		[ ] // Also verify the attachments and saved reports after conversion
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass    If no error occurs while validating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	02/09/2013	Created by	Udita Dube
	[ ] // ********************************************************
[+] testcase Test13_DataConversionof2013() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sEditDate = "10/10/2008"
		[ ] BOOLEAN bExists, bCompare
		[ ] INTEGER iFind, iEdit, iEndingBalance, iOpenStatus, j, iBackUpStatus, iCount,iSelect
		[ ] STRING sWindowType, sCaption, sWorkSheet, sActual, sHandle, sErrorMsg, sImageCompare1, sImageCompare2
		[ ] STRING sLionAttachment, sExpectedErr
		[ ] STRING sEagleAttachment
		[ ] 
	[ ] sWorkSheet = "2013"
	[ ] sWindowType = "MDI"
	[ ] 
	[ ] 
	[-] if (QuickenWindow.Exists() == True)
		[ ] QuickenWindow.SetActive()
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataConversionFile, sWorkSheet)
		[ ] 
		[-] for(k = 1; k<= ListCount(lsExcelData); k++)
			[ ] 
			[ ] // Fetch kth row from the given sheet
			[ ] lsConversionData=lsExcelData[k]
			[ ] 
			[+] if(ISNULL(lsConversionData[1]))
				[ ] break
				[ ] // lsConversionData[1] = ""
			[+] if(ISNULL(lsConversionData[2]))
				[ ] lsConversionData[2] = ""
			[+] if(ISNULL(lsConversionData[3]))
				[ ] lsConversionData[3] = ""
			[+] if(ISNULL(lsConversionData[4]))
				[ ] lsConversionData[4] = ""
			[+] if(ISNULL(lsConversionData[5]))
				[ ] lsConversionData[5] = ""
			[+] if(ISNULL(lsConversionData[6]))
				[ ] lsConversionData[6] = ""
			[+] if(ISNULL(lsConversionData[7]))
				[ ] lsConversionData[7] = ""
			[+] if(ISNULL(lsConversionData[8]))
				[ ] lsConversionData[8] = ""
			[+] if(ISNULL(lsConversionData[9]))
				[ ] lsConversionData[9] = ""
			[+] if(ISNULL(lsConversionData[10]))
				[ ] lsConversionData[10] = ""
			[+] if(ISNULL(lsConversionData[11]))
				[ ] lsConversionData[11] = ""
			[+] if(ISNULL(lsConversionData[12]))
				[ ] lsConversionData[12] = ""
			[+] if(ISNULL(lsConversionData[13]))
				[ ] lsConversionData[13] = ""
			[ ] 
			[ ] iConversionResult = DataFileConversion(lsConversionData[1], lsConversionData[9], lsConversionData[12])
			[-] if(iConversionResult == PASS)
				[ ] QuickenWindow.SetActive()
				[ ] sleep(10)
				[ ] 
				[ ] 
				[+] // Verify file Name
					[ ] QuickenWindow.SetActive ()
					[ ] sCaption = QuickenWindow.GetCaption()
					[ ] bMatch = MatchStr("*{lsConversionData[1]}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate File Name", PASS, "{lsFileAttributes[1]} : Correct file name is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate File Name", FAIL, "{lsFileAttributes[1]} : Expected File name - {lsFileAttributes[1]}, Actual File name - {sCaption}")
				[ ] QuickenWindow.SetActive()
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[+] // Verification of Actual File Attributes
					[+] for (i=2;i<=6;i++)
						[ ] sExpectedAttribute=(lsConversionData[i])
						[ ] 
						[+] if((sExpectedAttribute) == (lsActualFileAttribute[i-1]))
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i-1]}")
							[ ] 
					[ ] 
				[ ] 
				[ ] // Verify Ending Balance
				[+] if(k==1)
					[ ] iEndingBalance = CheckEndingBalance(lsConversionData[7])
					[+] if(iEndingBalance == PASS)
						[ ] ReportStatus("Validate Ending Balance", PASS, "{lsConversionData[7]} : Ending balance after conversion is same.")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance", FAIL, "{lsConversionData[7]} : Ending balance after conversion is not same.")
				[ ] 
				[+] // Verify saved report		// original code
					[+] if(lsConversionData[11] != "")
						[ ] lsSplit = Split(lsConversionData[11], ",")			// Creating a list of Reports
						[+] for(j = 1; j<=ListCount(lsSplit); j++)
							[ ] iOpenStatus = OpenReport(lsReportCategory[12], lsSplit[j])		// open the report
							[+] if(iOpenStatus == PASS)
								[ ] MyTransactionReport.SetActive()
								[ ] iCount = MyTransactionReport.QWListViewer1.ListBox1.GetItemCount()
								[ ] sHandle = Str(MyTransactionReport.QWListViewer1.ListBox1.GetHandle())	   // get the handle
								[+] for (i = iCount; i>= (iCount - 3); i--)
									[ ] 
									[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
									[ ] bMatch = MatchStr("*TOTAL OUTFLOWS*-167.25*", sActual)						// For My Transaction Report, verify the total
									[+] if(bMatch == TRUE)
										[+] if(MyTransactionReport.Exists())
											[ ] MyTransactionReport.SetActive()
											[ ] MyTransactionReport.Close()
											[ ] 
										[ ] ReportStatus("Validate Report", PASS, "{lsSplit[j]} report is opened and total is also correct i.e. -167.25")
										[ ] break
									[+] else
										[+] if(i == (iCount - 3))
											[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[j]} report is opened but total displayed is {sActual}")
										[ ] 
									[ ] 
							[+] else
								[ ] ReportStatus("Validate Report", FAIL, "{lsSplit[j]} Report not found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Reports Column", PASS, "Reports column is empty")
				[ ] 
				[+] // Verify Transaction password	
					[ ] sleep(2)
					[+] if(lsConversionData[13] != "")
						[ ] QuickenWindow.SetActive()
						[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
						[ ] QuickenWindow.SetActive()
						[+] if(QuickenWindow.CalloutHolder.ReminderHolder.Exists(3))
							[ ] QuickenWindow.CalloutHolder.ReminderHolder.Close.Click()
						[ ] 
						[ ] iFind = FindTransaction(sWindowType, "Abcde")
						[+] if(iFind == PASS)
							[ ] 
							[+] if(sWindowType == "MDI")
								[ ] 
								[ ] 
								[ ] MDIClient.AccountRegister.TxList.TypeKeys (sEditDate)
								[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
								[+] // if(TransactionPasswordRequired.Exists())
									[ ] // TransactionPasswordRequired.SetActive()
									[ ] // TransactionPasswordRequired.TransactionPasswordTextField.SetText(lsConversionData[13])
									[ ] // TransactionPasswordRequired.CustomWin("[QC_button]OK").Click()
									[+] // if(AlertMessage.Exists(SHORT_SLEEP))
										[ ] // AlertMessage.SetActive ()
										[ ] // sErrorMsg = AlertMessage.StaticText.GetText()
										[ ] // // defect id : QW007037 which is closed, FAQ is there for this.
										[+] // if(sExpectedErr == sErrorMsg)
											[ ] // ReportStatus("Validate Password window against defect id QW007037", PASS, "Correct Error Message is displayed.")
										[+] // else
											[ ] // ReportStatus("Validate Password window against defect id QW007037", FAIL, "Actual Error Message: {sErrorMsg} is displayed, Expected: {sExpectedErr}")
											[ ] // 
										[ ] // AlertMessage.Close()
										[ ] // TransactionPasswordRequired.SetActive()
										[ ] // TransactionPasswordRequired.TransactionPasswordTextField.SetText(Upper (lsConversionData[13]))
										[ ] // TransactionPasswordRequired.CustomWin("[QC_button]OK").Click()
									[ ] // 
								[+] if(QuickenPassword.Exists())
									[ ] QuickenPassword.SetActive()
									[ ] QuickenPassword.Password.SetText(lsConversionData[13])
									[ ] QuickenPassword.OK.Click()
									[ ] ReportStatus("Validate Password window", PASS, "Transaction password is set")
								[+] else
									[ ] ReportStatus("Validate Password window", FAIL, "Password window did not appear")
									[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Window Type", FAIL, "{sWindowType} is not valid")
								[ ] 
						[ ] 
						[+] else
							[ ] ReportStatus("Verify Transaction", FAIL, "Transaction with Abcde payee name is not found")
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Transaction Password Column", PASS, "Transaction Password Value is empty")
				[ ] 
				[+] // // Verify attachment
					[+] // if(lsConversionData[10] != "")
						[ ] // lsSplit = Split(lsConversionData[10], ",")			// Creating a list of attachments
						[ ] // 
						[+] // if SYS_DirExists(sExportedFolder)			// if folder in which exported files are saved exists, delete it
							[ ] // DeleteDir(sExportedFolder)
							[ ] // MakeDir(sExportedFolder)					// create the folder
						[ ] // 
						[ ] // sLionAttachment = "{sExportedFolder}\Lion.bmp"	
						[ ] // sEagleAttachment = "{sExportedFolder}\Eagle.bmp"
						[ ] // sImageCompare1 =  "{AUT_DATAFILE_PATH}\BitMapCompare\{lsSplit[1]}"
						[ ] // sImageCompare2 = "{AUT_DATAFILE_PATH}\BitMapCompare\{lsSplit[2]}"
						[ ] // UsePopUpRegister("ON")	 	// Turn on pop up register mode
						[+] // // if(AlertMessage.Exists(SHORT_SLEEP))			// dialog box appears for saving the changed transaction
							[ ] // // AlertMessage.SetActive ()
							[ ] // // AlertMessage.No.Click ()
						[ ] // 
						[ ] // sWindowType = "PopUp"
						[ ] // AccountBarSelect(ACCOUNT_BANKING, 1)
						[ ] // iFind = FindTransaction(sWindowType, "Bonus")
						[+] // if(iFind == PASS)
							[ ] // BankingPopUp.SetActive()
							[ ] // BankingPopUp.Maximize()
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.Click (1, 8, 6)
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.TypeKeys(Replicate (KEY_DN, 5))		// select attachment option 
							[ ] // BankingPopUp.TxList.TxToolbar.MoreActions.TypeKeys(KEY_ENTER)
							[ ] // 
							[+] // if(TransactionAttachments.Exists(SHORT_SLEEP))
								[ ] // 
								[+] // if(FileDownloadAttachment.Exists(MEDIUM_SLEEP))
									[ ] // FileDownloadAttachment.SetActive ()
									[ ] // ReportStatus("Validate Attachment", PASS, "Attachment attached after converstion successfully")
									[ ] // FileDownloadAttachment.Cancel.Click ()
								[+] // else
									[+] // do
										[ ] // TransactionAttachments.SetActive()
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.Click()
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_DN)
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_DN)
										[ ] // TransactionAttachments.Panel.QWinChild.QWPanel.Export.TypeKeys(KEY_ENTER)
										[+] // if(ExportAttachmentFile.Exists(SHORT_SLEEP))	
											[ ] // ExportAttachmentFile.SetActive ()
											[ ] // ExportAttachmentFile.FileName.FileNameTextField.SetText (sLionAttachment)		// Save attachment in TestData folder
											[ ] // ExportAttachmentFile.Save.Click ()
											[ ] // 
											[ ] // bCompare = SYS_CompareBinary (sLionAttachment, sImageCompare1)
											[+] // if(bCompare == TRUE)
												[ ] // ReportStatus("Validate Attachment", PASS, "First Attachment (i.e. Lion) matches after converstion successfully")
											[ ] // 
											[+] // else
												[ ] // ReportStatus("Validate Attachment", FAIL, "First Attachment (i.e. Lion) did not match after File Converstion ")
										[+] // else
											[ ] // ReportStatus("Validate Attachment", FAIL, "Export Attachment Window is not available")
											[ ] // 
										[ ] // 
										[ ] // TransactionAttachments.Panel1.QWinChild1.Panel2.Click (1, 74, 34)
										[ ] // TransactionAttachments.Export.Click (1, 36, 10)			// Click on Export button
										[+] // if(ExportAttachmentFile.Exists(SHORT_SLEEP))	
											[ ] // ExportAttachmentFile.SetActive ()
											[ ] // ExportAttachmentFile.FileName.FileNameTextField.SetText (sEagleAttachment)		// Save attachment in TestData folder
											[ ] // ExportAttachmentFile.Save.Click ()
											[ ] // 
											[ ] // bCompare = SYS_CompareBinary (sEagleAttachment, sImageCompare2)
											[+] // if(bCompare == TRUE)
												[ ] // ReportStatus("Validate Attachment", PASS, "Second Attachment (i.e. Eagle) matches after converstion successfully")
											[ ] // 
											[+] // else
												[ ] // ReportStatus("Validate Attachment", FAIL, "Second Attachment (i.e. Eagle) did not match after File Converstion ")
										[ ] // 
										[+] // else
											[ ] // ReportStatus("Validate Attachment", FAIL, "Export Attachment Window is not available")
											[ ] // 
										[ ] // 
									[+] // except
										[ ] // LogWarning ("Exception number: {[EXCEPTION]ExceptNum ()}") 
									[ ] // 
								[ ] // TransactionAttachments.Done.Click()
							[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate Attachment", FAIL, "Attachment window is not opened")
							[ ] // 
							[ ] // BankingPopUp.Close()
						[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify Transaction", FAIL, "Transaction with Bonus as one of its value is not found")
					[+] // else
						[ ] // ReportStatus("Validate Attachment", PASS, "Attachment column is empty")
				[ ] 
				[ ] // Verify Planning tab
				[ ] iSelect=NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("Navigate to Planning > Budget", PASS, "Navigation to Planning > Budget is successful")
					[+] if(Budget.AddCategoryToBudget.Exists(2))
						[ ] ReportStatus("Verify Budget page", PASS, "Select Categories to Budget button is displayed")
						[ ] // sActual= Budget.Panel.TotalSpending.GetCaption()
						[ ] // bMatch = MatchStr("*{lsConversionData[8]}*", sActual)
						[+] // if(bMatch == TRUE)
							[ ] // ReportStatus("Validate left over budget amount ", PASS, "Left over amount for the budget  is {sActual}")
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Validate left over budget amount  ", FAIL, " Left over amount for the budget is {sActual} displayed, expected is {lsConversionData[8]}")
							[ ] // 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Budget page", FAIL, "Select Categories to Budget button is not displayed")
						[ ] 
				[+] else
					[ ] ReportStatus("Navigate to Planning > Budget", FAIL, "Navigation to Planning > Budget is failed")
					[ ] 
				[ ] 
				[+] if(SyncChangesToTheQuickenCloud.Exists(5))
					[ ] SyncChangesToTheQuickenCloud.Close()
				[ ] OpenDataFile(sFileName)
				[ ] 
				[+] // if(QuickenWindow.Exists(2))
					[ ] // QuickenWindow.Kill()
					[ ] // WaitForState(QuickenWindow, false ,3)
				[ ] // 
				[ ] // // CloseQuicken()		// Close Quicken before taking back up
				[ ] // sleep(MEDIUM_SLEEP)
				[ ] // iBackUpStatus = ConvertedFileBackUp(lsConversionData[1], lsConversionData[9])			// take back up of converted file
				[ ] // 
			[+] else
				[ ] ReportStatus("Validate File Convertion", FAIL,"  File conversion failed")
				[ ] CloseQuicken()								// back up is not taken as file is not converted
			[ ] 
			[ ] continue
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //############# Data Conversion Clean up  ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataConversionCleanup ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken, delete folder which contail all the files .
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while closing the window	and deleting the folder .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	3/182011  	Created By	Puja Verma
	[ ] //*********************************************************
[+] testcase DataConversionCleanup() appstate none
	[ ] 
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] CloseQuicken()
	[ ] sleep(MEDIUM_SLEEP)
	[ ] 
	[+] if SYS_DirExists(sTempFolderName)
		[ ] bDeleteStatus = DeleteDir(sTempFolderName)
		[+] if(bDeleteStatus==TRUE)
			[ ] ReportStatus("Validate Delete Folder", PASS, "Folder  is deleted") 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Delete Folder", FAIL, "Folder is not deleted") 
	[+] if SYS_DirExists(sExportedFolder)
		[ ] DeleteDir(sExportedFolder)
	[ ] 
[ ] //###################################################################
