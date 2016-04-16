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
[ ] 
[-] // Global variables used for AddCategoryUtility
	[ ] public STRING sFileName = "CategoryValidation"
	[ ] public STRING sExcelData  = XLS_DATAFILE_PATH + "\" + "AddCategoryData.xls"
	[ ] public STRING  sWorkSheet  = "Category_Data"
	[ ] 
	[ ] 
	[ ] // public STRING sFileName = SYS_GetEnv("var2")
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sIsValidateWorkSheet= "Is_Validate"
	[ ] public STRING sValidateLogFolder = "{APP_PATH}\Data\TestData\ValidateLog"
[ ] 
[ ] // Window Declarations required for this Utility
[+] window DialogBox SetUpCategory
	[ ] tag "Set Up Category"
	[ ] parent CategoryList
	[+] TextField CategoryName
		[-] multitag "Category Name:"
			[ ] "$100"
	[+] RadioList CategoryType
		[-] multitag "Category Name:"
			[ ] "$103"
	[+] TextField Description
		[-] multitag "(optional)"
			[ ] "$101"
	[+] CustomWin OK
		[-] multitag "[QC_button]OK"
			[ ] "$32767"
	[+] CheckBox TaxRelatedCategory
		[-] multitag "Tax related category"
			[ ] "$107"
	[+] PopupList SubCategoryName
		[-] multitag "Category Name:"
			[ ] "$106"
	[+] RadioList ItemListOption
		[-] multitag "Complete this form to use the category in tax related features."
			[ ] "$113"
[+] window MessageBoxClass MessageBox
	[ ] tag "~ActiveApp/[DialogBox]$MessageBox"
	[+] PushButton OK
		[-] multitag "OK"
			[ ] "$32767"
			[ ] "[QC_button]OK"
	[+] PushButton Cancel
		[ ] tag "Cancel"
	[+] PushButton Yes
		[-] multitag "?Yes"
			[ ] "[QC_button]Yes"
			[ ] "$101"
	[+] PushButton No
		[ ] tag "No"
	[+] StaticText Message
		[ ] motif tag "#2"
		[ ] tag "#1"
	[+] CustomWin StopUpdate
		[-] multitag "[QC_button]Stop Update"
			[ ] "$1002"
	[+] CustomWin CalloutPopup
		[-] multitag "[INTU_CalloutPopup]Callout Popup"
			[ ] "$12345"
		[-] CustomWin Close
			[-] multitag "[QC_button]close"
				[ ] "$32766"
	[+] StaticText ContinueSearchFromEndOfRe
		[-] multitag "Continue search from?end of register?"
			[ ] "$100"
	[+] CustomWin Next
		[+] multitag "[QC_button]Next »"
			[ ] "$24120"
	[+] CustomWin QWBrowserContainer1
		[-] multitag "[QWBrowserContainer]#1"
			[ ] "$-1"
		[-] StaticText StaticText1
			[-] multitag "#1"
				[ ] "$-1"
			[-] CustomWin ShellEmbedding1
				[-] multitag "[Shell Embedding]#1"
					[ ] "$0"
				[-] CustomWin ShellDocObjectView1
					[-] multitag "[Shell DocObject View]#1"
						[ ] "$0"
					[-] CustomWin InternetExplorer_Server1
						[-] multitag "[Internet Explorer_Server]#1"
							[ ] "$0"
						[-] CustomWin ATL0602B1801
							[-] multitag "[ATL:0602B180]#1"
								[ ] "$229353072"
							[-] StaticText StaticText1
								[-] multitag "#1"
									[ ] "$-1"
								[-] FileDlg DialogBox1
									[-] multitag "#1"
										[ ] "$1"
									[-] TextField RegularTax1
										[-] multitag "Regular Tax[1]"
											[ ] "$4001"
						[-] CustomWin ATL04B0B1801
							[-] multitag "[ATL:04B0B180]#1"
								[ ] "$140966400"
							[-] StaticText StaticText1
								[-] multitag "#1"
									[ ] "$-1"
								[-] FileDlg DialogBox1
									[+] multitag "#1"
										[ ] "$1"
									[+] CustomWin ShortTermGainsAndLosses
										[-] multitag "[QTLink]Short-Term Gains and Losses"
											[ ] "$503"
									[-] TextField RegularTax1
										[-] multitag "Regular Tax[1]"
											[ ] "$4001"
	[+] CustomWin OK1
		[-] multitag "[QC_button]OK"
			[ ] "$101"
	[+] CustomWin EnterTransactionsButton
		[-] tag "[QC_button]Enter Transactions"
			[ ] //"$981"
	[+] StaticText ErrorMsg
		[-] multitag "This field may not be left blank."
			[ ] "$100"
[ ] 
[ ] 
[+] //############# Add Category Utility #################################################
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
[-] testcase AddCategoryUtility () appstate none
	[ ] // Variable Declaration
	[ ] STRING sDataLogPath, sValidatePath, sDate, sCmdLine
	[ ] LIST OF STRING lsContent
	[ ] LIST OF ANYTYPE lsData
	[ ] BOOLEAN bValidate
	[ ] INTEGER iCreateDataFile,iRegistration,iSetupAutoAPI,iAddCategoryStatus
	[ ] //  sExcelData  = SYS_GetEnv("var1")
	[ ] sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] sDataLogPath = USERPROFILE + "\Application Data\Intuit\Quicken\Log\DATA_LOG.TXT"
	[ ] Datetime dTime = GetDateTime()
	[ ] sDate = FormatDateTime(dTime, "mm_dd_yy")
	[ ] sValidatePath = sValidateLogFolder + DELIMITER +  "VALIDATE_LOG" + "_"+ sDate + ".log"
	[ ] 
	[-] //Perform Setup activities
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
		[-] if(FileExists(sTestCaseStatusFile))
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
		[ ] QuickenMainWindow.Start (sCmdLine)
	[ ] 
	[+] if (QuickenMainWindow.Exists(MEDIUM_SLEEP) == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[-] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] // Report Staus If Data file is not Created 
		[ ] else if ( iCreateDataFile ==FAIL)
		[-] 
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[-] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
		[ ] 
	[ ] //Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] // Add Categories based on input XLS
	[-] if(QuickenMainWindow.Exists(SHORT_SLEEP) == TRUE)
		[ ] 
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] iAddCategoryStatus = AddCategoryGeneric(sExcelData, sWorkSheet)
		[ ] ReportStatus("Add Category Utility", iAddCategoryStatus, "Utility is executed successfully") 
		[ ] 
		[ ] // Perform Validate Operation
		[ ] // lsData=ReadExcelTable(sExcelData, sIsValidateWorkSheet)
		[ ] // lsContent = lsData[1]
		[+] // if(lsContent[1] == "YES")
			[ ] // QuickenMainWindow.SetActive()
			[ ] // QuickenMainWindow.File.FileOperations.ValidateAndRepair.Pick()
			[ ] // 
			[ ] // // Verify that "Validate and repair your Quicken file" window exists
			[-] // if(ValidateAndRepair.Exists(MEDIUM_SLEEP))
				[ ] // 
				[ ] // ValidateAndRepair.SetActive()
				[-] // if(ValidateAndRepair.OK.IsEnabled())
					[ ] // ValidateAndRepair.OK.Click()
					[ ] // 
				[-] // else
					[-] // if(!ValidateAndRepair.ValidateFile.IsChecked())
						[ ] // ValidateAndRepair.ValidateFile.Check()
					[-] // if(!ValidateAndRepair.RebuildInvestingLots.IsChecked())
						[ ] // ValidateAndRepair.RebuildInvestingLots.Check()
					[ ] // ValidateAndRepair.OK.Click()
				[ ] // 
				[ ] // Notepad.VerifyEnabled(TRUE, 20)
				[ ] // 
				[ ] // // Verify that output file (data log text file) is opened
				[-] // if(Notepad.Exists(SHORT_SLEEP))
					[ ] // Notepad.SetActive()
					[ ] // Notepad.Close()
				[ ] // 
				[ ] // CopyFile(sDataLogPath,sValidatePath)
				[ ] // 
			[-] // else
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
[+] // public INTEGER AddCategoryGeneric(STRING sDataFile, STRING sWorkSheet)
	[-] // do
		[ ] // LIST of STRING lsCategory
		[ ] // LIST of ANYTYPE lsExcelData, lList
		[ ] // LIST OF INTEGER iListIndex
		[ ] // STRING sErrorMsg, sActual, sHandle, sErrorOccuredFlag
		[ ] // BOOLEAN bMatch, bValidTaxLineItem
		[ ] // INTEGER i, iCount, iCount1, iCount2, iFind, iFunctionResult
		[ ] // iFunctionResult = PASS
		[ ] // 
		[ ] // // Read data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sDataFile, sWorkSheet)
		[ ] // 
		[ ] // QuickenMainWindow.SetActive ()
		[ ] // QuickenMainWindow.Tools.CategoryList.Pick ()
		[-] // if(CategoryList.Exists(SHORT_SLEEP))
			[ ] // 
			[ ] // iCount = ListCount(lsExcelData)			// Get the row count
			[ ] // 
			[-] // for (i = 1; i<=iCount; i++)
				[ ] // 
				[-] // do
					[ ] // 
					[ ] // // This flag is used to skip verification part if error is encountered
					[ ] // sErrorOccuredFlag = "NoError"
					[ ] // bValidTaxLineItem = TRUE
					[ ] // // Fetch rows from the given sheet
					[ ] // lsCategory=lsExcelData[i]
					[ ] // 
					[ ] // CategoryList.SetActive ()
					[ ] // iCount1 = CategoryList.Show.QWListViewer1.ListBox1.GetItemCount ()	// Get the category Count before adding new category 
					[ ] // 
					[ ] // CategoryList.New.Click ()
					[-] // if(SetUpCategory.Exists(SHORT_SLEEP))
						[ ] // 
						[ ] // SetUpCategory.SetActive ()
						[ ] // 
						[+] // if(lsCategory[1] != NULL)
							[ ] // SetUpCategory.CategoryName.SetText (lsCategory[1])
						[+] // if(lsCategory[4] != NULL)
							[ ] // SetUpCategory.Description.SetText (lsCategory[4])
						[-] // if(lsCategory[2] != NULL)
							[ ] // bMatch = MatchStr("*Subcategory*", lsCategory[2])
							[-] // if(bMatch == TRUE)
								[-] // if(lsCategory[3] != NULL)
									[ ] // SetUpCategory.CategoryType.Select (lsCategory[2])
									[ ] // lList = SetUpCategoryPopup.FileType.GetContents()			// Get the all Subcategory list items 
									[ ] // iFind = ListFind (lList, lsCategory[3])						// find the item in the list, if not find iFind = 0
									[-] // if(iFind == 0)
										[ ] // ReportStatus("Validate SubCategory", WARN, "Category - '{lsCategory[3]}' is not found in 'SubCategory of:' list")
										[ ] // 
									[ ] // 
									[-] // else					
										[ ] // SetUpCategory.SetActive ()
										[ ] // SetUpCategory.SubCategoryName.Select (lsCategory[3])			//if found, select the option
										[ ] // 
							[-] // else
								[ ] // SetUpCategory.CategoryType.Select (lsCategory[2])
						[ ] // 
						[ ] // SetUpCategory.SetActive ()
						[ ] // SetUpCategory.Click (1, 124, 42)		// Click on "Tax Reporting" tab
						[ ] // 
						[+] // if( MessageBox.Exists(SHORT_SLEEP))
							[ ] // MessageBox.SetActive ()
							[ ] // sErrorMsg = MessageBox.ErrorMsg.GetText()
							[ ] // ReportStatus("Validate Error Meassage", WARN, "Error Message - '{sErrorMsg}' is observed")
							[ ] // 
							[-] // if(MessageBox.OK.Exists() == TRUE)
								[ ] // MessageBox.OK.Click ()
							[-] // else
								[ ] // MessageBox.OK1.Click ()
								[ ] // 
							[ ] // sErrorOccuredFlag = "FoundError"
							[ ] // SetUpCategory.SetActive()
							[ ] // SetUpCategory.Close()
							[ ] // 
						[-] // else
							[-] // if((lsCategory[6] != NULL) ) 
								[ ] // SetUpCategoryPopup.SetActive()
								[ ] // lList = SetUpCategoryPopup.FileType.GetContents()			// Get the Tax line items for "Standard Line Item List" 
								[ ] // iFind = ListFind (lList, lsCategory[6])						// find the item in the list, if not find iFind = 0
								[-] // if(iFind == 0)	
									[ ] // SetUpCategory.SetActive()
									[ ] // SetUpCategory.ItemListOption.Select ("Extended line item list")	// Select "Extended Line Item list" option
									[ ] // lList = SetUpCategoryPopup.FileType.GetContents()			// Get the Tax line items for "Extended Line Item list" 
									[ ] // iFind = ListFind (lList, lsCategory[6])						// find the item in the list, if not find iFind = 0
									[-] // if(iFind == 0)
										[ ] // ReportStatus("Search Tax Line Item", WARN, "'{lsCategory[6]}' is not found in 'Standard Tax Line' as well as 'Extended Tax line'")
										[ ] // bValidTaxLineItem = FALSE
									[ ] // 
									[+] // else					
										[ ] // SetUpCategory.SetActive ()
										[ ] // SetUpCategoryPopup.FileType.Select (lsCategory[6])			// if found, select the option
								[+] // else
										[ ] // SetUpCategory.SetActive ()
										[ ] // SetUpCategoryPopup.FileType.Select (lsCategory[6])
								[ ] // 
								[ ] // 
							[+] // if(lsCategory[5] == "UnCheck")
								[ ] // SetUpCategory.TaxRelatedCategory.Uncheck ()
								[ ] // 
							[+] // else
								[ ] // //SetUpCategory.TaxRelatedCategory.Check()
							[ ] // 
							[ ] // // Save Category
							[ ] // SetUpCategory.OK.Click (1, 30, 10)
							[ ] // 
							[-] // if( MessageBox.Exists())
								[ ] // MessageBox.SetActive()
								[ ] // sErrorMsg = MessageBox.ErrorMsg.GetText()
								[ ] // ReportStatus("Validate Error Meassage", WARN, "Error message - '{sErrorMsg}' is observed")
								[ ] // 
								[-] // if (MessageBox.OK.Exists() == TRUE)
									[ ] // MessageBox.OK.Click ()
								[-] // else
									[ ] // MessageBox.OK1.Click ()
								[ ] // 
								[ ] // sleep(SHORT_SLEEP)
								[ ] // SetUpCategory.SetActive()
								[ ] // SetUpCategory.Close()
								[ ] // sErrorOccuredFlag = "FoundError"
								[ ] // ReportStatus("Validate Category Addition", FAIL, "Category  - '{lsCategory[1]}' is not added, Error Observed - {sErrorMsg}")
								[ ] // 
							[ ] // 
							[-] // if((lsCategory[6] != NULL))
								[ ] // sleep(SHORT_SLEEP)
								[ ] // CategoryList.VerifyEnabled(TRUE, 10)
								[ ] // CategoryList.SetActive()
								[ ] // sHandle = Str(CategoryList.Show.QWListViewer1.ListBox1.GetHandle())
								[ ] // iListIndex = CategoryList.Show.QWListViewer1.ListBox1.GetMultiSelIndex()		// get the index of the selected row
								[ ] // 
								[+] // if (bValidTaxLineItem != FALSE)
									[ ] // 
									[ ] // sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iListIndex[1]-1))
									[ ] // bMatch = MatchStr("*{lsCategory[6]}*", sActual)			// Verify tax line item, if category is added
									[-] // if(bMatch == TRUE)
										[ ] // ReportStatus("Validate Tax Line Item", PASS, "Tax Line Item - '{lsCategory[6]}' is added for Category - {lsCategory[1]}")
									[-] // else
										[ ] // ReportStatus("Validate Tax Line Item", FAIL, "Actual -' {sActual}', Expected - '{lsCategory[6]}' is found on Category List window")
									[ ] // 
								[-] // else
									[ ] // ReportStatus("Validate Taxline Item", WARN, "Taxline Item is not verified on 'Category List' window as  - '{lsCategory[6]}' is invalid item")
					[-] // else
						[ ] // ReportStatus("Validate New Category window", FAIL, "Set up Category window for adding new category is not opened")
					[ ] // 
					[ ] // CategoryList.SetActive()
					[ ] // CategoryList.Show.QWListViewer1.ListBox1.SetFocus()
					[ ] // iCount2 = CategoryList.Show.QWListViewer1.ListBox1.GetItemCount ()		// get the category count after above actions are performed
					[-] // if(iCount2 == iCount1+1)
						[ ] // ReportStatus("Validate Category Count", PASS, "Category '{lsCategory[1]}' is added, Count before addition -{iCount1} and after addition - {iCount2}")
						[ ] // 
					[-] // else
						[ ] // ReportStatus("Validate Category Count", FAIL, "Category '{lsCategory[1]}' is not added as incomplete/inappropriate input data is provided.")
				[ ] // 
				[-] // except
					[ ] // // Clsoe SetupCategory window if it exists
					[-] // if(SetUpCategory.Exists() == TRUE)
						[ ] // SetUpCategory.SetActive()
						[ ] // SetUpCategory.Close()
						[ ] // iFunctionResult = FAIL
						[ ] // 
						[ ] // // Continue execution for next iteration
						[ ] // continue
			[ ] // 
			[ ] // // Close CategoryList window at the end..
			[ ] // CategoryList.SetActive ()
			[ ] // CategoryList.Close ()
		[ ] // 
		[-] // else
			[ ] // ReportStatus("Validate Category List window", FAIL, "Category List is not opened")
			[ ] // 
	[ ] // 
	[-] // except
		[ ] // LogException("Error has occurred in Utility")
		[ ] // iFunctionResult = FAIL
	[ ] // 
	[ ] // return iFunctionResult
[ ] 
[ ] 
