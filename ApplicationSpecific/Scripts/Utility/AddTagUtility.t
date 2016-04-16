[+] // FILE NAME:	<AddCategoryUtility.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //  This is data driven utility which is used to creatre new Categories depending upon input XLS sheet.
	[ ] //  XLS file is stored at - <Automation Root>\ApplicationSpecific\Data\TestData\DataDrivenXLS\AddCategoryData.xls
	[ ] //
	[ ] // DEPENDENCIES:	Include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Chandan Abhyankar	
	[ ] //
	[ ] // Developed on: 		03/01/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	
	[ ] // *********************************************************
[ ] // *********************************************************
[ ] 
[-] // Global variables used for AddCategoryUtility
	[ ] public STRING sFileName = "LargeDataFile_2011"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sIsValidateWorkSheet= "Is_Validate"
	[ ] public STRING sValidateLogFolder = "{APP_PATH}\Data\TestData\ValidateLog"
	[ ] public STRING sExcelData  = XLS_DATAFILE_PATH + "\" + "AddTags.xls"
	[ ] public STRING sWorkSheet  = "Tags_Data"
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# Add Tag Utility #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 AddCategoryUtility()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add category based on input XLS file.
		[ ] //
		[ ] // PARAMETERS:		None (Input XLS is supplied internally, No parameterization is required)
		[ ] //
		[ ] // RETURNS:			None 									
		[ ] //						
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  March 1, 2011		Chandan Abhyankar	created	
	[ ] // ********************************************************
[-] testcase AddTagUtility () appstate none
	[ ] // Variable Declaration
	[ ] STRING sDataLogPath, sValidatePath, sDate, sCmdLine
	[ ] 
	[ ] LIST OF STRING lsContent
	[ ] LIST OF ANYTYPE lsData
	[ ] BOOLEAN bValidate
	[ ] INTEGER iCreateDataFile,iRegistration,iSetupAutoAPI,iAddTagStatus
	[ ] sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] // sDataLogPath = USERPROFILE + "\Application Data\Intuit\Quicken\Log\DATA_LOG.TXT"
	[ ] // Datetime dTime = GetDateTime()
	[ ] // sDate = FormatDateTime(dTime, "mm_dd_yy")
	[ ] // sValidatePath = sValidateLogFolder + DELIMITER +  "VALIDATE_LOG" + "_"+ sDate + ".log"
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
	[ ] 
	[+] if (!QuickenMainWindow.Exists ())
		[ ] QuickenMainWindow.Start (sCmdLine)
	[ ] 
	[+] if (QuickenMainWindow.Exists(MEDIUM_SLEEP) == True)
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
	[ ] // Add Categories based on input XLS
	[-] if(QuickenMainWindow.Exists(SHORT_SLEEP) == TRUE)
		[ ] 
		[ ] QuickenMainWindow.SetActive() 
		[ ] 
		[ ] iAddTagStatus = AddTagGeneric(sExcelData, sWorkSheet)
		[ ] ReportStatus("Add Tag Utility", iAddTagStatus, "Utility is executed successfully") 
		[ ] 
		[ ] // // Perform Validate Operation
		[ ] // lsData=ReadExcelTable(sExcelData, sIsValidateWorkSheet)
		[ ] // lsContent = lsData[1]
		[+] // if(lsContent[1] == "YES")
			[ ] // QuickenMainWindow.SetActive()
			[ ] // QuickenMainWindow.File.FileOperations.ValidateAndRepair.Pick()
			[ ] // 
			[ ] // // Verify that "Validate and repair your Quicken file" window exists
			[+] // if(ValidateAndRepair.Exists(MEDIUM_SLEEP))
				[ ] // 
				[ ] // ValidateAndRepair.SetActive()
				[+] // if(ValidateAndRepair.OK.IsEnabled())
					[ ] // ValidateAndRepair.OK.Click()
					[ ] // 
				[+] // else
					[+] // if(!ValidateAndRepair.ValidateFile.IsChecked())
						[ ] // ValidateAndRepair.ValidateFile.Check()
					[+] // if(!ValidateAndRepair.RebuildInvestingLots.IsChecked())
						[ ] // ValidateAndRepair.RebuildInvestingLots.Check()
					[ ] // ValidateAndRepair.OK.Click()
				[ ] // 
				[ ] // Notepad.VerifyEnabled(TRUE, 20)
				[ ] // 
				[ ] // // Verify that output file (data log text file) is opened
				[+] // if(Notepad.Exists(SHORT_SLEEP))
					[ ] // Notepad.SetActive()
					[ ] // Notepad.Close()
				[ ] // 
				[ ] // CopyFile(sDataLogPath,sValidatePath)
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Validate ValidateAndRepair Window", FAIL, "ValidateAndRepair window is not found") 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Repair", WARN, "User doesn't want to perform Validate and Repair Operation") 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] // Close Quicken
	[ ] CloseQuicken()
[ ] //###########################################################################
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: AddCategoryGeneric()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will add the categories based on input XLS data.
	[ ] // This function is used when user wants to give any set of input (valid or invalid) data.
	[ ] //
	[ ] // PARAMETERS:		STRING 		sDataFile		File name where input is stored
	[ ] //						STRING 		sWorksheet	Sheet name
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If Utility is executed successfully
	[ ] //									FAIL = if Utility is not executed successfully
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Mar 01, 2011	Chandan Abhyankar	created
[ ] // ==========================================================
[-] public INTEGER AddTagGeneric(STRING sDataFile, STRING sWorkSheet)
	[-] do
		[ ] LIST of STRING lsTag
		[ ] LIST of ANYTYPE lsExcelData, lList
		[ ] LIST OF INTEGER iListIndex
		[ ] STRING sErrorMsg, sActual, sHandle, sErrorOccuredFlag
		[ ] BOOLEAN bMatch, bValidTaxLineItem
		[ ] INTEGER i, iCount, iCount1, iCount2, iFind, iFunctionResult
		[ ] iFunctionResult = PASS
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataFile, sWorkSheet)
		[ ] 
		[ ] QuickenMainWindow.SetActive ()
		[ ] QuickenMainWindow.Tools.TagList.Pick ()
		[-] if(TagList.Exists(SHORT_SLEEP))
			[ ] 
			[ ] iCount = ListCount(lsExcelData)			// Get the row count
			[ ] 
			[-] for (i = 1; i<=iCount; i++)
				[ ] 
				[-] do
					[ ] 
					[ ] // Fetch rows from the given sheet
					[ ] lsTag=lsExcelData[i]
					[ ] 
					[ ] TagList.SetActive ()
					[ ] 
					[ ] TagList.NewButton.Click()
					[ ] 
					[-] if(NewTag.Exists(SHORT_SLEEP))
						[ ] 
						[ ] NewTag.SetActive ()
						[ ] NewTag.NameTextfield.SetText(lsTag[1])
						[ ] NewTag.DescriptionTextField.SetText(lsTag[2])
						[ ] NewTag.OKButton.Click()
						[ ] 
					[ ] ReportStatus("Add Tag", PASS, "Tag -  {lsTag[1]}  is created successfully")
					[ ] 
				[ ] 
				[+] except
					[ ] // Clsoe SetupCategory window if it exists
					[+] if(NewTag.Exists() == TRUE)
						[ ] NewTag.SetActive()
						[ ] NewTag.Close()
						[ ] iFunctionResult = FAIL
						[ ] 
						[ ] // Continue execution for next iteration
						[ ] continue
			[ ] 
			[ ] // Close CategoryList window at the end..
			[ ] TagList.SetActive ()
			[ ] TagList.Close ()
		[ ] 
		[+] else
			[ ] ReportStatus("Validate Tag List window", FAIL, "Tag List is not opened")
			[ ] 
	[ ] 
	[+] except
		[ ] LogException("Error has occurred in Utility")
		[ ] iFunctionResult = FAIL
	[ ] 
	[ ] return iFunctionResult
