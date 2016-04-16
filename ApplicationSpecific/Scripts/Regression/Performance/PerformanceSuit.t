[ ] 
[+] // Global variables used for PerformanceSuit Test cases
	[ ] public STRING sHomeTab = "Home"
	[ ] public STRING sFileNameSmallFile = "BASIC_DATA_FILE"
	[ ] public STRING sFileNamelargeFile = "LARGE_DATA_FILE"
	[ ] 
	[ ] public STRING sDataFileforLarge = AUT_DATAFILE_PATH + "\" + sFileNamelargeFile + ".QDF"
	[ ] public STRING sDataFileforSmall = AUT_DATAFILE_PATH + "\" + sFileNameSmallFile + ".QDF"
	[ ] public STRING sNLForPerformanceDll =(QUICKEN_ROOT+"\"+"performance.dll")
	[ ] 
	[ ] 
	[ ] public STRING sPopUpWindow = "PopUp"
	[ ] public STRING sMDIWindow = "MDI"
	[ ] 
	[ ] //public STRING sExpectedAboutQuicken="Quicken 2012 Rental Property Manager"
	[ ] public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ]  INTEGER  iReportSelect
	[ ] INTEGER iNavigate
	[ ] INTEGER iUploadResult
	[ ] INTEGER iSelect,iOpenDataFile
	[ ] INTEGER iRegistration
	[ ] public INTEGER iAddTransaction, iCount,iSwitchState
	[ ]  STRING sExcelName = "PerformanceTestData"
	[ ] public LIST OF ANYTYPE  lsAccountData,lsExcelData
	[ ] public  STRING sInvestingTransactionWorksheet = "Investing Transaction"
	[ ] public  LIST OF STRING lsTransactionData
	[ ] BOOLEAN bCaption
	[ ] STRING sCaption,sAccountName,sFileName
	[ ] 
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] //############# Performance SetUp ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 PerformanceSetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the Large and basic file .QDF if it exists. 
		[ ] // It will setup the necessary pre-requisite for Performance Suit
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  1/2/ 2011		Chandan Abhyankar created	
	[ ] // ********************************************************
	[ ] 
[+] testcase PerformanceSetUp () appstate none
	[ ] 
	[+] //Variable
		[ ] HFILE hQuickenINIFileHandle
		[ ] STRING sOriginalLocation=(AUT_DATAFILE_PATH+"\"+"PerformanceDataFile"+"\"+"BASIC_DATA_FILE.QDF")
		[ ] STRING sNewLocation =(AUT_DATAFILE_PATH+"\"+"BASIC_DATA_FILE.QDF")
		[ ] 
		[ ] STRING sOriginalLocationforLargeFile=(AUT_DATAFILE_PATH+"\"+"PerformanceDataFile"+"\"+"LARGE_DATA_FILE.QDF")
		[ ] STRING sNewLocationforLargeFile=(AUT_DATAFILE_PATH+"\"+"LARGE_DATA_FILE.QDF")
		[ ] 
		[ ] STRING sOLForPerformancedll=(AUT_DATAFILE_PATH+"\"+"PerformanceDataFile"+"\"+"performance.dll")
		[ ] STRING sNLForPerformanceDll =(QUICKEN_ROOT+"\"+"performance.dll")
		[ ] 
		[ ] STRING sOLForBankingWebFile=(AUT_DATAFILE_PATH+"\"+"PerformanceDataFile"+"\"+"WebImportBank.QFX")
		[ ] STRING sNLForBankingWebFile =(AUT_DATAFILE_PATH+"\"+"WebImportBank.QFX")
		[ ] 
		[ ] STRING sOLForInvestingWebFile=(AUT_DATAFILE_PATH+"\"+"PerformanceDataFile"+"\"+"WebImportInv.QFX")
		[ ] STRING sNLForInvestingWebFile =(AUT_DATAFILE_PATH+"\"+"WebImportInv.QFX")
		[ ] STRING sLine, sFilePath
		[ ] 
		[ ] // Set the Path for Config.ini file
		[+] if (OPERATING_SYSTEM == "Windows 7" || OPERATING_SYSTEM == "Windows Vista")
			[ ]  sQuickenIniPath =ALLUSERSPROFILE + "\Intuit\Quicken\Config\Quicken.ini"
			[ ] 
		[+] if (OPERATING_SYSTEM == "Windows XP")
			[ ]   sQuickenIniPath =ALLUSERSPROFILE + "\Application Data\Intuit\Quicken\Config\Quicken.ini"
			[ ] 
		[ ] sFilePath = sQuickenIniPath
		[ ] STRING sCreateDataFile =AUT_DATAFILE_PATH+"\"+"Performance Test.QDF"
		[ ] 
	[ ] 
	[ ] // Close quicken
	[-] if (QuickenWindow.Exists() == TRUE)
		[ ] QuickenWindow.Kill()
		[ ] WaitForState(QuickenWindow, false,5)
		[ ] // QuickenWindow.Exit()
		[ ] 
	[ ] 
	[ ] //For Large Data file
	[-] if(FileExists(sDataFileforLarge))
		[ ] DeleteFile(sDataFileforLarge)
	[ ] 
	[ ] //For Small Data file
	[-] if(FileExists(sDataFileforSmall))
		[ ] DeleteFile(sDataFileforSmall)
	[ ] 
	[ ] //File Delete for performance dll
	[+] if(FileExists(sNLForPerformanceDll))
		[ ] DeleteFile(sNLForPerformanceDll)
	[ ] 
	[ ] //File Delete Banking web file
	[+] if(FileExists(sNLForBankingWebFile))
		[ ] DeleteFile(sNLForBankingWebFile)
	[ ] 
	[ ] //File Delete Investing  web file
	[+] if(FileExists(sNLForInvestingWebFile))
		[ ] DeleteFile(sNLForInvestingWebFile)
	[ ] 
	[ ] //Test Case Result  Status Delete
	[+] // if(FileExists(sTestCaseStatusFile))
		[ ] // DeleteFile(sTestCaseStatusFile)
	[ ] 
	[ ] //Delete Test data file
	[ ] 
	[+] if(FileExists(sCreateDataFile))
		[ ] DeleteFile(sCreateDataFile)
	[ ] 
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] // Copy original file into test data location
	[ ] SYS_CopyFile (sOriginalLocation,sNewLocation)
	[ ] SYS_CopyFile (sOriginalLocationforLargeFile,sNewLocationforLargeFile)
	[ ] SYS_CopyFile (sOLForPerformancedll,sNLForPerformanceDll)
	[ ] 
	[ ] SYS_CopyFile (sOLForBankingWebFile,sNLForBankingWebFile)
	[ ] SYS_CopyFile (sOLForInvestingWebFile,sNLForInvestingWebFile)
	[ ] 
	[ ] //Adding configuration for performance
	[ ] hQuickenINIFileHandle = SYS_FileOpen (sFilePath,FM_APPEND)
	[ ] SYS_FileWriteLine (hQuickenINIFileHandle, "[PerfMeasure]")
	[ ] SYS_FileWriteLine (hQuickenINIFileHandle, "Enabled=1")
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //############# Launch Quicken #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test01_LaunchQuicken () 
		[ ] // 
		[ ] // DESCRIPTION:			This testcase will  Launch Quicken 
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	If Launch Quicken Successfully						
		[ ] // 							Fail	If System unable to launch Quicken
		[ ] //
		[ ] // REVISION HISTORY: 	28/1/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test01_LaunchQuicken () appstate none
	[-] //Variable
		[ ] string sCmdLine = "{QUICKEN_ROOT}\qw.exe"
		[ ] INTEGER iResult
	[ ] 
	[-] if (!QuickenWindow.Exists())
		[ ] App_Start (sCmdLine)
		[ ] 
	[-] if(QuickenWindow.Exists(10))
		[ ] ReportStatus("Validate Quicken Launch",PASS,"Quicken launch successfully")
		[ ] iResult =OpenDataFile(PerformanceDataFile)
		[-] if (iResult==FAIL)
			[ ] ReportStatus("Verify {PerformanceDataFile} opened.",FAIL,"Verify {PerformanceDataFile} couldn't be opened.")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Launch",FAIL,"Unable to launch quiken")
		[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[+] //############## Open Register for checking account  ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test02_OpenRegisterChecking () 
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will  Open the Checking account with popup 
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Open the Checking account with popup 						
		[ ] // 							Fail	if any error occurs
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test02_OpenRegisterChecking() appstate PerformanceBaseState
	[ ] 
	[+] //----------Variable Defination and Declaration----------
		[ ] INTEGER iSwitchState, iSelect
		[ ] sAccountName="Checking 01 Account"
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[ ] 
		[ ] sleep(2)
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] //----------Select the Banking account----------
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)		// Select first checking account
		[ ] 
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Validate Checking Account", PASS, "Checking account open successfully")
		[ ] 
		[+] else
			[ ] ReportStatus("Validate Checking Account", FAIL, "Checking account not open successfully")
			[ ] 
		[ ] 
	[+] if(BankingPopUp.Exists())
		[ ] BankingPopUp.SetActive()
		[ ] BankingPopUp.Maximize()
		[ ] BankingPopUp.Close()
		[ ] 
[ ] //###################################################################
[ ] 
[+] //############### Add  Transaction using Popup Register ON with  C2R mode ##########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_EnterTransactionIntoCheckingRegisterWithC2R()
		[ ] //
		[ ] // DESCRIPTION: 				This Test Case will  add payment transaction for Checking account with Popup Register mode ON and C2R mode
		[ ] // 
		[ ] // PARAMETERS:			none
		[ ] //
		[ ] // Returns:			        	Pass 		if payment transaction is added successfully 						
		[ ] //						 	Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 2/2/2011 	Created By	Chandan Abhyankar
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test03_EnterTransactionIntoCheckingRegisterWithC2R () appstate PerformanceBaseState
	[ ] 
	[+] //----------Variable Defination and Declaration----------
		[ ] INTEGER iSelect,iAddTransaction,iSwitchState
		[ ] STRING sAccountWorksheet
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData
		[ ] STRING sCheckingTransactionWorksheet
		[ ] LIST OF STRING lsTransactionData
		[ ] BOOLEAN bTowLineDisplayOFF
		[ ] 
		[ ] bTowLineDisplayOFF = FALSE
		[ ] sAccountName="Checking 01 Account"
		[ ] sAccountWorksheet = "Account"
		[ ] sCheckingTransactionWorksheet = "Checking Transaction"
	[ ] 
	[ ] //----------Read data from excel sheet----------
	[ ] lsExcelData=ReadExcelTable(sExcelName, sCheckingTransactionWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransactionData=lsExcelData[1]
	[ ] 
	[ ] // ----------Quicken is launched then add Payment transaction to Checking account----------
	[-] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ----------Turn ON Popup mode----------
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] // ----------This will click  first Banking account on AccountBar----------
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)		// Select first checking account
		[ ] 
		[-] if(iSelect==PASS)
			[ ] 
			[ ] WaitForState(BankingPopUp,True,5)
			[ ] 
			[ ] // ----------Select "TWO LINE DISPLAY" option from Actions menus----------
			[ ] BankingPopUp.SetActive()
			[ ] // QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Click(MB_LEFT, 61,13)
			[ ] // QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(Replicate (KEY_DN, 15)) 
			[ ] // QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(KEY_ENTER)
			[ ] sleep(2)
			[ ] bTowLineDisplayOFF = TRUE
			[ ] 
			[ ] //---------- Add Payment Transaction to Checking account----------
			[ ] 
			[ ] 
			[ ] iAddTransaction= AddCheckingTransactionForPerformance(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
			[+] if(iAddTransaction==0)
				[ ] ReportStatus("Validate Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is not added") 
			[ ] 
		[-] if(BankingPopUp.Exists())
			[ ] BankingPopUp.SetActive()
			[ ] BankingPopUp.Maximize()
			[ ] 
			[ ] //---------- Restore Two Line Display to original----------
			[+] if(bTowLineDisplayOFF == TRUE)
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Click(MB_LEFT,61,13)
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(Replicate (KEY_DN, 15)) 
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(KEY_ENTER)
				[ ] sleep(2)
				[ ] BankingPopUp.Close()
			[ ] 
	[+] else
		[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] // //############### Enter Transaction into Checking Register With C2R mode  Split ########
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test04_EnterSplitTransactionWithC2Rmode()
		[ ] // //
		[ ] // // DESCRIPTION : 				This Test Case will add split  transaction  with Popup Register mode ON and C2R mode
		[ ] // // 
		[ ] // // PARAMETERS:			none
		[ ] // //
		[ ] // // Returns:			        	Pass 		if  transaction is added successfully 						
		[ ] // //						 	Fail		if any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:	 2/2/2011	Created By	Chandan Abhyankar
		[ ] // //	  
	[ ] // // ********************************************************
[+] testcase Test04_EnterSplitTransactionWithC2Rmode() appstate PerformanceBaseState
	[ ] 
	[+] //----------Variable Defination and Declaration----------
		[ ] INTEGER iSelect,iAddTransaction,iSwitchState
		[ ] STRING sAccountWorksheet
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData
		[ ] STRING sCheckingTransactionWorksheet
		[ ] LIST OF STRING lsTransactionData
		[ ] BOOLEAN bTowLineDisplayOFF 
		[ ] 
		[ ] bTowLineDisplayOFF = FALSE
		[ ] sCheckingTransactionWorksheet = "Checking Transaction"
		[ ]  sAccountWorksheet = "Account"
		[ ] sAccountName="Checking 01 Account"
	[ ] 
	[ ] // ---------- Read data from excel sheet ----------
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sExcelName, sCheckingTransactionWorksheet)
	[ ] 
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] 
	[ ] //  ----------Quicken is launched then add Payment transaction to Checking account ----------
	[-] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ----------Turn ON Popup mode----------
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] // ---------- This will click  first Banking account on AccountBar ----------
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)		// Select first checking account
		[ ] 
		[-] if(iSelect==PASS)
			[ ] WaitForState(BankingPopUp,True,5)
			[ ] 
			[ ] // ----------Select "TWO LINE DISPLAY" option from Actions menus----------
			[ ] BankingPopUp.SetActive()
			[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Click(MB_LEFT,61,13)
			[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(Replicate (KEY_DN, 15)) 
			[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] bTowLineDisplayOFF = TRUE
			[ ] sleep(2)
			[ ] 
			[ ]  iAddTransaction= AddCheckingTransactionForPerformance(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13])
			[ ] 
			[+] if(iAddTransaction == PASS)
				[ ] ReportStatus("Validate Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
			[+] else
				[ ] ReportStatus("Validate Add Transaction", FAIL, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is not added") 
				[ ] 
			[+] if(BankingPopUp.Exists())
				[ ] 
				[ ] //---------- Restore Two Line Display to original----------
				[+] if(bTowLineDisplayOFF == TRUE)
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Maximize()
					[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Click(MB_LEFT,61,13)
					[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(Replicate (KEY_DN, 15)) 
					[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(KEY_ENTER)
					[ ] sleep(2)
					[ ] BankingPopUp.Close()
			[ ] 
	[+] else
		[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
	[ ] 
[ ] //#########################################################################
[ ] 
[+] //############## Open Register for checking account 02 ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test05_OpenRegisterChecking02() 
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will  Open the Checking02 account with popup 
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Open the Checking account with popup 						
		[ ] // 							Fail	if any error occurs
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test05_OpenRegisterChecking02() appstate PerformanceBaseState
	[ ] 
	[+] //----------Variable Defination and Declaration----------
		[ ] INTEGER iSwitchState, iSelect
		[ ] 
		[ ] sAccountName="Checking 01 Account"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ----------Turn ON Popup mode----------
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] // ----------Selecting the Checking 02 Account ----------
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)		
		[ ] 
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Validate Checking Account 02", PASS, "Checking account open successfully")
		[+] else
			[ ] ReportStatus("Validate Checking Account 02", FAIL, "Checking account not open successfully")
			[ ] 
		[ ] //----------Closing the account details popup window----------
		[ ] 
	[+] if(BankingPopUp.Exists())
		[ ] BankingPopUp.SetActive()
		[ ] BankingPopUp.Maximize()
		[ ] BankingPopUp.Close()
[ ] //########################################################################
[ ] 
[+] //############### Add  Transaction using Popup Register ON #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_EnterTransactionIntoCheckingRegister()
		[ ] //
		[ ] // Description: 				This Test Case will add payment transaction for Checking account with Popup Register mode ON
		[ ] // 
		[ ] // PARAMETERS:			none
		[ ] //
		[ ] // Returns:			        	Pass 		if payment transaction is added successfully 						
		[ ] //						 	Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 	2/2/2011 	Created By	Chandan Abhyankar
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test06_EnterTransactionIntoCheckingRegister () appstate PerformanceBaseState
	[ ] 
	[+] //----------Variable Defination and Declaration----------
		[ ] INTEGER iSelect,iAddTransaction,iSwitchState
		[ ]  STRING sAccountWorksheet
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData
		[ ]  STRING sCheckingTransactionWorksheet 
		[ ] LIST OF STRING lsTransactionData
		[ ] BOOLEAN bTowLineDisplayOFF 
		[ ] 
		[ ] 
		[ ] 
		[ ] bTowLineDisplayOFF = FALSE
		[ ] sAccountWorksheet = "Account"
		[ ] sCheckingTransactionWorksheet = "Adding Transaction"
		[ ] sAccountName="Checking 01 Account"
		[ ] 
	[ ] //---------- Read data from excel sheet----------
	[ ] lsExcelData=ReadExcelTable(sExcelName, sCheckingTransactionWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransactionData=lsExcelData[1]
	[ ] 
	[ ] // ----------Quicken is launched then add Payment transaction to Checking account
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ----------Turn ON Popup mode
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[+] // ----------This will click first Banking account on AccountBar
			[ ] 
			[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)		// Select first checking account
			[ ] 
			[ ] 
			[+] if(iSelect==PASS)
				[ ] // ----------Select "TWO LINE DISPLAY" option from Actions menus----------
				[ ] BankingPopUp.SetActive()
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Click(MB_LEFT,61,13)
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(Replicate (KEY_DN, 15)) 
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(KEY_ENTER)
				[ ] bTowLineDisplayOFF = TRUE
				[ ] sleep(2)
			[ ] 
			[ ] 
		[ ] 
		[ ] // ----------Add Payment Transaction to Checking account ----------
		[ ] iAddTransaction= AddCheckingTransactionForPerformance(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
		[ ] 
		[+] if(iAddTransaction == PASS )
			[ ] ReportStatus("Validate Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
		[+] else
			[ ] ReportStatus("Validate Add Transaction", FAIL, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is not added") 
			[ ] 
		[+] if(BankingPopUp.Exists())
			[ ] 
			[ ] //---------- Restore Two Line Display to original----------
			[+] if(bTowLineDisplayOFF == TRUE)
				[ ] BankingPopUp.SetActive()
				[ ] BankingPopUp.Maximize()
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Click(MB_LEFT,61,13)
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(Replicate (KEY_DN, 15)) 
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(KEY_ENTER)
				[ ] sleep(2)
				[ ] BankingPopUp.Close()
				[ ] 
	[+] else
		[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############### Enter Split Transaction in banking  Account #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_EnterSplitTransaction()
		[ ] //
		[ ] // DESCRIPTION: 				This Test Case will add split  transaction  with Popup Register mode ON 
		[ ] // 
		[ ] // PARAMETERS:			none
		[ ] //
		[ ] // Returns:			        	Pass 		if  transaction is added successfully 						
		[ ] //						 	Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 	2/2/2011 	Created By	Chandan Abhyankar
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test07_EnterSplitTransaction () appstate PerformanceBaseState
	[+] //----------Variable Defination and Declaration----------
		[ ] INTEGER iSelect,iAddTransaction,iSwitchState
		[ ] STRING sAccountWorksheet 
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData
		[ ] STRING sCheckingTransactionWorksheet
		[ ] LIST OF STRING lsTransactionData
		[ ] BOOLEAN bTowLineDisplayOFF
		[ ] sAccountName="Checking 01 Account"
		[ ] 
		[ ] sAccountWorksheet = "Account"
		[ ] sCheckingTransactionWorksheet = "Adding Transaction"
		[ ] 
		[ ] 
	[ ] 
	[ ] // ----------Read data from excel sheet----------
	[ ] lsExcelData=ReadExcelTable(sExcelName, sCheckingTransactionWorksheet)
	[ ] // Fetch 2ndrow from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] 
	[ ] // ----------Quicken is launched then ----------
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ----------Turn ON Popup mode----------
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[+] // ----------This will click  first Banking account on AccountBar----------
			[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)		// Select first checking account
			[ ] 
			[+] if(iSelect==PASS)
				[ ] 
				[ ] // ----------Select "TWO LINE DISPLAY" option from Actions menus----------
				[ ] BankingPopUp.SetActive()
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Click(MB_LEFT,61,13)
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(Replicate (KEY_DN, 15)) 
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(KEY_ENTER)
				[ ] bTowLineDisplayOFF = TRUE
				[ ] sleep(2)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransactionForPerformance(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13])
				[ ] 
				[+] if(iAddTransaction==0)
					[ ] ReportStatus("Validate Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is not added") 
			[ ] 
		[+] if(BankingPopUp.Exists())
			[ ] 
			[ ] // ----------Restore Two Line Display to original----------
			[+] if (bTowLineDisplayOFF == TRUE)
				[ ] BankingPopUp.SetActive()
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Click(MB_LEFT,61,13)
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(Replicate (KEY_DN, 15)) 
				[ ] QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.TypeKeys(KEY_ENTER)
				[ ] sleep(2)
			[ ] BankingPopUp.Close()
		[ ] 
	[+] else
		[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
	[ ] 
[ ] //##################################################################
[ ] 
[+] //################### OpenManage Bill Income And reminder #############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	  Test08_OpenManageBillAndReminderReport () 
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will  Open the Manage bill and reminder report with popup 
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if testcase open the Manage bill and reminder report with popup  						
		[ ] // 							Fail	if any error occurs
		[ ] //							
		[ ] // 
		[ ] // REVISION HISTORY: 	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] // **************************************************************************************
[+]  testcase Test08_OpenManageBillAndReminderReport() appstate PerformanceBaseState
	[ ] 
	[ ] //  ----------If Quicken is launched  ----------
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] //  ----------Set Activate main window ----------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ----------Navigate to Bill Reminder category ----------
		[ ] 
		[ ] iNavigate = NavigateQuickenTools(MANAGE_BILL_AND_INCOME_REMINDER)
		[ ] 
		[+] if(iNavigate == PASS)
			[ ] ReportStatus("Validate Manage Bill and account reminder popup case", PASS, "Manage Bill and account reminder popup opened successfully")
		[+] else
			[ ] ReportStatus("Validate Manage Bill and account reminder popup case",FAIL, "Manage Bill and account reminder popup not opened successfully")
			[ ] 
		[ ] //  ----------Closing Bill and Income Reminder dialog ----------
		[+] if (BillAndIncomeReminders.Exists())
			[ ] BillAndIncomeReminders.SetActive()
			[ ] BillAndIncomeReminders.Maximize()
			[ ] BillAndIncomeReminders.Close()
[ ] //###############################################################
[ ] 
[+] //########## Open Account List Dialog  from Tools Menu  #################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test09_OpenAccountList()
		[ ] //
		[ ] // DESCRIPTION:This testcase will invoke Account list from Tools menu and check window title
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking account list							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	 2/2/2011  	Created By	Chandan Abhyankar
	[ ] //*********************************************************
[+] testcase Test09_OpenAccountList() appstate PerformanceBaseState
	[ ] 
	[ ] //  ----------If Quicken is launched  ----------
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] //  ----------Set Activate main window ----------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ----------Navigate to Account List----------
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
		[ ] 
		[+] if(iNavigate == PASS)
			[ ] ReportStatus("Validate Launch Account List", PASS, "Account List is launched successfully")
		[+] else
			[ ] ReportStatus("Validate Launch Account List", FAIL, "Account List is not launched successfully")
			[ ] 
		[+] if(AccountList.Exists())
			[ ] AccountList.SetActive()
			[ ] AccountList.Maximize()
			[ ] AccountList.Close ()
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Open Category List Dialog from Tools Menu  #################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test10_OpenCategoryList()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Category list from Tools menu 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking category list							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  2/2/2011  	Created By	Chandan Abhyankar	
	[ ] //*********************************************************
[+] testcase Test10_OpenCategoryList() appstate PerformanceBaseState
	[+] // Variable Declaration
		[ ] BOOLEAN bExist
	[ ] 
	[ ] //  ----------If Quicken is launched  ----------
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] //  ----------Set Activate main window -------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ----------Navigate to Category List----------
		[ ] iNavigate = NavigateQuickenTools(TOOLS_CATEGORY_LIST)
		[+] if(iNavigate == PASS)
			[ ] ReportStatus("Validate Launch Category List", PASS, "Category List is launched successfully")
		[+] else
			[ ] ReportStatus("Validate Launch Category List", FAIL, "Category List is not launched successfully")
			[ ] 
		[ ] // ----------Closing the Catagory list popup ----------
		[ ] 
		[+] if CategoryList.Exists()
			[ ] CategoryList.SetActive()
			[ ] CategoryList.Close ()
			[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Open Memorized Payee List from Tools Menu  ##############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test11_OpenMemorizedPayeeList()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Memorized Payee List from Tools menu 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking Memorized Payee List 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	 2/2/2011  	Created By	Chandan Abhyankar	
	[ ] //*********************************************************
[+] testcase Test11_OpenMemorizedPayeeList() appstate PerformanceBaseState
	[ ] 
	[ ] //  ----------If Quicken is launched  ----------
	[+] if(QuickenWindow.Exists())
		[ ] 
		[ ] //  ----------Set Activate main window -------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ----------Navigate to Payee List----------
		[ ] iNavigate = NavigateQuickenTools(TOOLS_MEMORIZE_PAYEE_LIST)
		[ ] 
		[+] if(iNavigate == PASS)
			[ ] ReportStatus("Validate Memorized Payee List", PASS, "Memorized Payee List is launched successfully")
		[ ] 
		[+] else
			[ ] ReportStatus("Validate Launch Memorized Payee List", FAIL, "Memorized Payee List is not launched successfully")
			[ ] 
		[ ] //----------Close the window----------
		[ ] 
		[+] if(MemorizedPayeeList.Exists())
			[ ] MemorizedPayeeList.SetActive()
			[+] MemorizedPayeeList.Close ()
					[ ] 
[ ] //##############################################################################
[ ] 
[+] // //############### Open Investment Account #################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test12_OpenInvestmentRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Click on investment Register 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Click on investment Register  						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	 2/2/2011  	Created By	Chandan Abhyankar	
	[ ] //*********************************************************
[-] testcase Test12_OpenInvestmentRegister() appstate PerformanceBaseState
	[-] //----------Variable----------
		[ ] STRING sFileName= "WebImportInv"
		[ ] STRING sCaption
		[ ] BOOLEAN bCaption
		[ ] STRING sAccountName="MWC Elite Inves Account"  
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] sCaption = QuickenWindow.GetCaption()
	[ ] 
	[ ] bCaption = MatchStr("*{sFileNameSmallFile}*", sCaption)
	[-] 
		[-] if(bCaption==TRUE)
			[ ] 
			[ ] //  ----------If Quicken is launched  ----------
			[-] if (QuickenWindow.Exists() == TRUE)
				[ ] 
				[ ] //  ----------Set Activate main window -------
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] // ----------Import the web connect file  ----------
				[ ] iUploadResult= ImportWebConnectFile(sFileName , sAccountName)
				[ ] 
				[-] if(iUploadResult == PASS)
					[ ] ReportStatus("Validate Investing  web file ", iUploadResult, "Investing  web file import successfully")
				[-] else
					[ ] ReportStatus("Validate Investing  web file ", FAIL , "Investing web file did not successfully")
				[ ] 
				[ ] Sleep(LONG_SLEEP)
				[ ] 
				[ ] //   ----------This is to Handle New Patch download Popup  ----------
				[-] if (QuickenMainWindow.FreeUpdateToQuickenIsAvailable.Exists(SHORT_SLEEP) == TRUE)
					[ ] QuickenMainWindow.FreeUpdateToQuickenIsAvailable.SetActive()
					[ ] QuickenMainWindow.FreeUpdateToQuickenIsAvailable.Close()
	[ ] 
	[-] if (QuickenWindow.Exists())
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] UsePopupRegister("ON")
		[ ] 
		[ ] 
		[ ] iSelect =SelectAccountFromAccountBar(sAccountName , ACCOUNT_INVESTING)
		[-] if(iSelect == PASS)
			[ ] ReportStatus("Validate Investment Account", PASS, "Investment Account  is launched successfully")
		[+] else
			[ ] ReportStatus("Validate Investment Account", FAIL, "Investment Account didnot launch")
			[ ] 
	[ ] //   ----------Close Account Register   ----------
	[-] if(BankingPopUp.Exists())
		[ ] BankingPopUp.SetActive()
		[ ] BankingPopUp.Close()
		[ ] 
[ ]  //#############################################################################
[ ] 
[+] //############### Buy Transaction in  Account ###############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test13_InvestmentBuyTransaction()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Testcase will add  Buy transaction for Investing  Account
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Enter  Buy transaction is correctly entered	
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] //*********************************************************
[-] testcase Test13_InvestmentBuyTransaction  () appstate PerformanceBaseState
	[ ] 
	[-] // ----------Variable declaration----------
		[ ] INTEGER iAddTransaction, iSelect,iCount,iSwitchState
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData
		[ ]  STRING sInvestingTransactionWorksheet 
		[ ]  LIST OF STRING lsTransactionData
		[ ] sAccountName="MWC Elite Inves Account"  
		[ ] sInvestingTransactionWorksheet = "Investing Transaction"
		[ ] 
		[ ] 
	[ ] 
	[ ] // ----------Read data from excel sheet----------
	[ ] lsExcelData=ReadExcelTable(sExcelName, sInvestingTransactionWorksheet)
	[ ] // Fetch 1th row from the given sheet
	[ ] lsTransactionData=lsExcelData[1]
	[ ] 
	[ ] // ----------If Quicken is launched ----------
	[-] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[-] if(InvestingAccountPopup.Exists())
			[ ] InvestingAccountPopup.Close()
			[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[-] // ----------This will click  first Investment account on AccountBar----------
			[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
			[ ] 
		[ ] 
		[-] if (InvestingAccountPopup.Exists(SHORT_SLEEP))
			[ ] 
			[ ] InvestingAccountPopup.SetActive()
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] // ----------Buy Transaction with all data----------
			[ ] iAddTransaction= AddInvestingTransaction(sPopUpWindow, lsTransactionData[1], lsTransactionData[2], lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
			[ ] 
			[-] if(iAddTransaction==PASS)
				[ ] ReportStatus("Validate Buy transaction", PASS, " Buy transaction added succesfully")
			[-] else
				[ ] ReportStatus("Validate Buy transaction", FAIL, "Buy transaction did not added succesfully")
			[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Verification of {lsTransactionData[2]} account window", FAIL, "{lsTransactionData[2]} account window not found") 
		[ ] 
	[ ] // ----------Report Status if Quicken is not launched----------
	[ ] 
	[-] if(InvestingAccountPopup.Exists())
		[ ] InvestingAccountPopup.SetActive()
		[ ] InvestingAccountPopup.Close()
	[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
[ ] //######################################################################\
[ ] 
[+] // //############### Sell Transaction in Account ###############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test14_InvestmentSellTransaction()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Testcase will add sell transaction from Investing  Account
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Enter  sell transaction is correct	ly entered
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] //*********************************************************
[+] testcase Test14_InvestmentSellTransaction () appstate PerformanceBaseState
	[ ] 
	[-] // ----------Variable declaration ----------
		[ ] BOOLEAN bMatch
		[ ] INTEGER iAddTransaction, iSelect,iCount
		[ ] STRING sActualCashBalance,sExpectedCashBalance,sHandle,sActual
		[ ] LIST OF STRING lsRow
		[ ] sAccountName="MWC Elite Inves Account" 
		[ ] 
	[ ] 
	[ ] //  ----------Read data from excel sheet ----------
	[ ] lsExcelData=ReadExcelTable(sExcelName, sInvestingTransactionWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] 
	[ ] // ----------If Quicken is launched  ----------
	[-] if (QuickenWindow.Exists() == TRUE)
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[-] //  ----------This will click  first Investment account on AccountBar ----------
			[ ] 
			[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
			[ ] 
		[ ] 
		[-] if (InvestingAccountPopup.Exists(SHORT_SLEEP))
			[ ] 
			[ ] InvestingAccountPopup.SetActive()
			[ ] 
			[ ] sleep(2)
			[ ] // ----------Sell Transaction with all data ----------
			[ ] iAddTransaction= AddInvestingTransaction(sPopUpWindow ,lsTransactionData[1], lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9])
			[ ] 
			[+] if(iAddTransaction==PASS)
				[ ] ReportStatus("Validate Sell transaction", PASS, "Added succesfully")
			[+] else
				[ ] ReportStatus("Validate Sell transaction", FAIL, "Did not added succesfully")
			[ ] 
		[+] if(InvestingAccountPopup.Exists())
			[ ] InvestingAccountPopup.SetActive()
			[ ] InvestingAccountPopup.Close()
		[ ] 
		[ ] 
	[ ] //  ----------Report Status if Quicken is not launched ----------
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
[ ] //###################################################################
[ ] 
[+] // //############### Investment Income Transaction ###############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test15_InvestmentIncomeTransaction()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Testcase will  add Income  transaction from Investing  Account
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Enter  income transaction is correctly entered	
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] //*********************************************************
[+] testcase Test15_InvestmentIncomeTransaction() appstate PerformanceBaseState
	[ ] 
	[-] //  ----------Variable declaration ----------
		[ ] INTEGER iAddTransaction, iSelect,iCount,iSwitchState
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData
		[ ]  STRING sInvestingTransactionWorksheet = "Transaction Income and Reinvest"
		[ ]  LIST OF STRING lsTransactionData
		[ ] 
		[ ] sAccountName= "MWC Elite Inves Account"
		[ ] 
	[ ] 
	[ ] // ---------- Read data from excel sheet ----------
	[ ] lsExcelData=ReadExcelTable(sExcelName, sInvestingTransactionWorksheet)
	[ ] // Fetch 1th row from the given sheet
	[ ] lsTransactionData=lsExcelData[1]
	[ ] 
	[ ] //  ----------If Quicken is launched  ----------
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] // ---------- This will click  first Investment account on AccountBar ----------
		[+] 
			[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
			[ ] 
		[ ] 
		[+] if (InvestingAccountPopup.Exists())
			[ ] 
			[ ] InvestingAccountPopup.SetActive()
			[ ] 
			[ ] sleep(2)
			[ ] //  ----------Buy Transaction with all data ----------
			[ ] iAddTransaction= AddInvestingTransactionForInvestIncome(sPopUpWindow,lsTransactionData[1], lsTransactionData[2], lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10])
			[+] if(iAddTransaction==PASS)
				[ ] ReportStatus("Validate Transaction added", PASS, "Transction is added properly")
			[+] else
				[ ] ReportStatus("Validate Transaction added", FAIL, "Transaction  is not added ") 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of {lsTransactionData[2]} account window", FAIL, "{lsTransactionData[2]} account window not found") 
		[ ] 
		[+] 
			[ ] 
		[ ] 
		[+] if(InvestingAccountPopup.Exists())
			[ ] InvestingAccountPopup.SetActive()
			[ ] InvestingAccountPopup.Close()
		[ ] 
	[ ] //  ----------Report Status if Quicken is not launched ----------
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
[ ] // //#############################################################################
[ ] // 
[+] // //############### Reinvest Transaction for an account ###############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test16_InvestmentReinvestTransaction()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Testcase will add Reinvest  transaction from Investing  Account
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Enter  reinvest transaction is correctly entered	
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] //*********************************************************
[+] testcase Test16_InvestmentReinvestTransaction() appstate PerformanceBaseState
	[ ] // 
	[+] //  ---------- Variable declaration  ----------
		[ ] INTEGER iAddTransaction, iSelect,iCount,iSwitchState
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData
		[ ] STRING sInvestingTransactionWorksheet = "Transaction Income and Reinvest"
		[ ] LIST OF STRING lsTransactionData
		[ ] sAccountName= "MWC Elite Inves Account"
		[ ] 
	[ ] 
	[ ] //  ---------- Read data from excel sheet  ----------
	[ ] lsExcelData=ReadExcelTable(sExcelName, sInvestingTransactionWorksheet)
	[ ] // Fetch 1th row from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] 
	[ ] //   ----------If Quicken is launched   ----------
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[+] //   ----------This will click  first Investment account on AccountBar  ----------
			[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
			[ ] 
		[ ] 
		[+] if (InvestingAccountPopup.Exists())
			[ ] 
			[ ] InvestingAccountPopup.SetActive()
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] //    ----------Add Reinvest Transaction with all data  ----------
			[ ] iAddTransaction= AddInvestingTransactionForInvestIncome(sPopUpWindow,lsTransactionData[1], lsTransactionData[2], lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13],lsTransactionData[14],lsTransactionData[15])
			[ ] 
			[+] if(iAddTransaction==PASS)
				[ ] ReportStatus("Validate Transaction added", PASS, "Transction is added properly")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Transaction added", FAIL, "Transaction  is not added ") 
			[ ] 
			[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Verification of {lsTransactionData[2]} account window", FAIL, "{lsTransactionData[2]} account window not found") 
			[ ] 
			[ ] 
		[+] if(InvestingAccountPopup.Exists())
			[ ] InvestingAccountPopup.SetActive()
			[ ] InvestingAccountPopup.Close()
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //################### Open Net Worth Report #########################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test17_OpenNetWorthReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Open Net Worth report
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while opening  on Net Worth report						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	 2/2/2011  	Created By	Chandan Abhyankar	
	[ ] //*********************************************************
[+]  testcase Test17_OpenNetWorthReport() appstate PerformanceBaseState
	[ ] 
	[ ] // If Quicken is launched then run Net Worth Report
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] //----------Need to remove----------------
			[ ] // // Open Net Worth Report
			[ ] // iReportSelect = OpenReport("Graphs", sREPORT_NETWORTH)	
			[+] // if(iReportSelect==PASS)
				[ ] // ReportStatus("Validate Run Net Worth Report", iReportSelect, "Run Report successful") 
			[+] // else
				[ ] // ReportStatus("Validate Run Net Worth Report", iReportSelect, "Run Report unsuccessful") 
			[ ] 
		[ ] 
		[ ] QuickenWindow.Reports.Click()
		[ ] QuickenWindow.Reports.Graphs.Click()
		[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
		[ ] 
		[ ] 
		[ ] // Verify Net Worth window is Opened
		[+] if (NetWorthReports.Exists())
			[ ] ReportStatus("Validate Net Worth report", PASS, "Net Worth report opened successful") 
			[ ] // Set Activate Net Worth window
			[ ] NetWorthReports.SetActive()
			[ ] NetWorthReports.Close()
		[+] else
			[ ] ReportStatus("Validate Net Worth Report", FAIL, "Net Worth Report not opened successful") 
			[ ] 
[ ] //###############################################################
[ ] 
[+] //############### Run Spending By Category report #################################
	[ ] //*********************************************************
	[+] // TestCase Name:Test18_RunSpendingReport()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Tesecase will  open  Spending Report 
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Spending Report  open successfully 					
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] //*********************************************************
[+]  testcase Test18_RunSpendingReport () appstate PerformanceBaseState
	[ ] // If Quicken is launched then run Spending by Category Report
	[ ] 
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Reports.Click()
		[ ] QuickenWindow.Reports.Graphs.Click()
		[ ] QuickenWindow.Reports.Graphs.SpendingByCategory.Select()
		[ ] 
		[+] //----------Need to remove----------------
			[ ] // // Open Spending by Category Report
			[ ] // iReportSelect = OpenReport("MySavedReportsGraphs", "Spending")	
			[+] // // if(iReportSelect==PASS)
				[ ] // // ReportStatus("Validate MySavedReportsGraphs", iReportSelect, "Run Report successful") 
				[ ] // 
			[+] // else
				[ ] // ReportStatus(" Validate MySavedReportsGraphs", iReportSelect, "Run Report unsuccessful") 
				[ ] 
			[ ] 
			[+] // if(SavedReportAlert.Exists(1))
				[ ] // SavedReportAlert.OK.Click()
		[ ] 
		[ ] //Close the popup
		[+] if (SpendingByCategory.Exists())
			[ ] ReportStatus("Validate Spending by Category Report", PASS, "Spending by Category Report opened successful") 
			[ ] 
			[ ] // Set Activate Spending Report
			[ ] SpendingByCategory.SetActive()
			[ ] SpendingByCategory.Close()
		[+] else
			[ ] ReportStatus("Validate Spending by Category Report", FAIL, "Spending by Category Report not opened successful") 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //################### Open Investment Performance Report #############################
	[ ] //*********************************************************
	[+] // TestCase Name:Test19_OpenInvestmentPerformanceReport()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Tesecase will  open  Investing Performance  Report 
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Investing Performance Report  open successfully 					
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] //*********************************************************
[+]  testcase Test19_OpenInvestmentPerformanceReport() appstate PerformanceBaseState
	[ ] 
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Reports.Click()
		[ ] QuickenWindow.Reports.Investing.Click()
		[ ] QuickenWindow.Reports.Investing.InvestmentPerformance.Select()
		[ ] 
		[+] //----------Need to remove----------------.
			[ ] // Open Investment Performance Report
			[ ] // iReportSelect = OpenReport("Graphs", "Investment Performance")	
			[+] // if(iReportSelect==PASS)
				[ ] // ReportStatus("Validate Investment Performance", iReportSelect, "Run Report successful") 
			[+] // else
				[ ] // ReportStatus("Validate Investment Performance", iReportSelect, "Run Report unsuccessful") 
		[ ] 
		[ ] //Closing the Investment Performance report popup
		[+] if (InvestmentPerformance.Exists())
			[ ] ReportStatus("Validate Investment Performance report", PASS, "Investment Performance report opened successful") 
			[ ] InvestmentPerformance.SetActive()
			[ ] InvestmentPerformance.Close()
		[+] else
			[ ] ReportStatus("Validate Investment Performance Report", FAIL, "Investment Performance Report not opened successful") 
			[ ] 
[ ] //###############################################################
[ ] 
[+] //################### Open Payee Report #########################
	[ ] //*********************************************************
	[+] // TestCase Name:Test20_PayeeReport()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Tesecase will  open  Payee Report 
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Payee Report  open successfully 					
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] //*********************************************************
[+]  testcase Test20_PayeeReport() appstate PerformanceBaseState
	[ ] 
	[+] if (QuickenMainWindow.Exists() == TRUE)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Reports.Click()
		[ ] QuickenWindow.Reports.Graphs.Click()
		[ ] QuickenWindow.Reports.Graphs.SpendingByPayee.Select()
		[ ] 
		[ ] 
		[+] //----------Need to remove----------------
			[ ] // Open Spending by Payee Report
			[ ] // iReportSelect = OpenReport("Graphs", sREPORT_SPENDING_BY_PAYEE)	
			[ ] // 
			[+] // if(iReportSelect==PASS)
				[ ] // ReportStatus("Validate Payee window", iReportSelect, "Run Report successful") 
			[+] // else
				[ ] // ReportStatus("Validate Payee window", iReportSelect, "Run Report unsuccessful") 
		[ ] 
		[ ] //Closing the payee report window
		[+] if (SpendingByPayee.Exists())
			[ ] ReportStatus("Validate Payee report", PASS, "Payee report opened successful") 
			[ ] SpendingByPayee.SetActive()
			[ ] SpendingByPayee.Close()
		[+] else
			[ ] ReportStatus("Validate Payee Report", FAIL, "Payee Report not opened successful") 
			[ ] 
[ ] //###############################################################
[ ] 
[+] //################### Open Itemized Categories Report #########################
	[ ] //*********************************************************
	[+] // TestCase Name:Test21_ItemizedCategories()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Tesecase will open Itemized Categories Report 
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Itemized Categories open successfully 					
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	2/2/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] //*********************************************************
[+]  testcase Test21_ItemizedCategories() appstate PerformanceBaseState
	[ ] 
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Reports.Click()
		[ ] QuickenWindow.Reports.Spending.Click()
		[ ] QuickenWindow.Reports.Spending.ItemizedCategories.Select()
		[ ] 
		[+] //----------Need to remove----------------
			[ ] // // Open Net Worth Report
			[ ] // iReportSelect = OpenReport("Spending", "Itemized Categories")	
			[ ] // 
			[+] // if(iReportSelect==PASS)
				[ ] // ReportStatus("Validate Itemized Categories Report", iReportSelect, "Run Report successful") 
			[+] // else
				[ ] // ReportStatus("Validate Itemized Categories Report", iReportSelect, "Run Report unsuccessful") 
			[ ] // 
		[ ] 
		[ ] //Closing Itemized Categories Report.
		[+] if (ItemizedCategories.Exists())
			[ ] ReportStatus("Validate Itemized Categories report", PASS, "Itemized Categories report opened successful") 
			[ ] ItemizedCategories.SetActive()
			[ ] ItemizedCategories.Close()
		[+] else
			[ ] ReportStatus("Validate Itemized Categories Report", FAIL, "Itemized Categories Report not opened successful") 
			[ ] 
[ ] //###############################################################
[ ] 
[+] //################### Open Investment Performance Report #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_InvestmentPerformance ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open the investment performance  window and close the same
		[ ] // 
    //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while opening investment performance  window and close the same 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  2/2/2011  	Created By	Chandan Abhyankar
	[ ] // ********************************************************
[+]  testcase Test22_InvestmentPerformance() appstate PerformanceBaseState
	[ ] 
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] //Click on Investing Tab
		[ ] QuickenMainWindow.QWNavigator.Investing.Click()
		[ ] //Click on Performance tab
		[+] if(QuickenMainWindow.QWNavigator.Performance.Exists())
			[ ] QuickenMainWindow.QWNavigator.Performance.Click()
			[ ] ReportStatus("Validate Investing Performance" ,PASS ,"Successfull opened")
		[+] else 
			[ ] ReportStatus("Valiade Investing Performance" ,FAIL ,"Not Successfully open")
[ ] //###############################################################
[ ] 
[+] //########## Quotes Download #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_QuotesDownload ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open the summary of quotes download window and close the same
		[ ] // 
    //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while opening  the summary of quotes download window and close the same 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  2/2/2011  	Created By	Chandan Abhyankar
	[ ] // ********************************************************
[-] testcase Test24_QuotesDownload() appstate PerformanceBaseState
	[ ] //Ckecking quicken exists
	[-] if (QuickenWindow.Exists() == TRUE)
		[ ] QuickenWindow.SetActive ()
		[+] // iRegistration=BypassRegistration()
			[ ] // ReportStatus("Bypass Registration ", iRegistration, "Registration bypassed")
			[ ] 
		[ ] 
		[ ] iNavigate = NavigateQuickenTools("One Step Update")
		[ ] 
		[-] if(iNavigate == PASS)
			[ ] 
			[+] if(UnlockYourPasswordVault.Exists())
				[ ] UnlockYourPasswordVault.SetActive()
				[ ] UnlockYourPasswordVault.Skip.Click()
			[ ] 
			[ ] 
			[-] if(OneStepUpdate.Exists(20))
				[ ] OneStepUpdate.SetActive ()
				[ ] OneStepUpdate.OneStepUpdateSettings3.ListBox1.Click(1,249,13)
				[ ] OneStepUpdate.UpdateNow.Click ()	
				[ ] WaitForState(OneStepUpdate, false , 200)
				[-] if ( DlgStockSplitsMaybeMissing.Exists(35))
					[ ] DlgStockSplitsMaybeMissing.SetActive()
					[ ] DlgStockSplitsMaybeMissing.CancelButton.Click()
					[ ] WaitForState(DlgStockSplitsMaybeMissing, false , 5)
				[-] if(OneStepUpdateSummary.Exists(200))
					[ ] OneStepUpdateSummary.SetActive()
					[ ] OneStepUpdateSummary.Close.Click ()
					[ ] ReportStatus("Validate Quotes down loaded ",PASS, "Quotes download is successful")
				[-] else
					[ ] ReportStatus("Validate Quotes down loaded ",FAIL, "Quotes download is failed")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("OneStepUpdate ",FAIL, "OneStepUpdate window is not launched")
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Quotes down loaded ",FAIL, "Quotes down updated unsucesfull")
			[ ] 
		[ ] // This is to Handle New Patch download Popup
		[+] if (QuickenMainWindow.FreeUpdateToQuickenIsAvailable.Exists(SHORT_SLEEP) == TRUE)
			[ ] QuickenMainWindow.FreeUpdateToQuickenIsAvailable.SetActive()
			[ ] QuickenMainWindow.FreeUpdateToQuickenIsAvailable.Close()
	[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window ",FAIL, "Quicken Main Window is not available")
[ ] //########################################################################
[ ] 
[+] //########## Planning Center ###################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_PlanningCenter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Open the planning center
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while verification planning center						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 20, 2011		Chandan Abhyankar created	
	[ ] // ********************************************************
[+]  testcase Test25_PlanningCenter() appstate PerformanceBaseState
	[ ] 
	[ ] // If Quicken is launched 
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] //Click on Planning Center
		[+] if(!QuickenMainWindow.QWNavigator.Planning.Exists(3))
			[ ] 
			[ ] ReportStatus("Planning tab  ",FAIL, "Planning tab open unsuccessfull")
			[ ] 
		[ ] QuickenMainWindow.QWNavigator.Planning.Click()
		[ ] 
		[ ] ReportStatus("Validate Planning tab  ",PASS, "Validate Planning tab open successfull")
		[ ] 
[ ] //#########################################################################
[ ] 
[+] //########## Tax Center ####################### ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test26_TaxCenter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open the Tax center 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while opening the tax center							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  2/2/2011  	Created By	Chandan Abhyankar
	[ ] // ********************************************************
[+]  testcase Test26_TaxCenter() appstate PerformanceBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sTab,sSubTab
    
	[+] // Expected Values
		[ ] sTab="Planning"
		[ ] sSubTab="Tax Center"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Planning > Tax Center tab
		[ ] iNavigate=NavigateQuickenTab(sTab,sSubTab)
		[ ] 
		[+] if(iNavigate == PASS)
			[ ] ReportStatus("Validate Tax Center", PASS, "Tax Center opened successfully")
		[+] else
			[ ] ReportStatus("Validate Tax Center", FAIL, "Tax Center not opened successfully")
			[ ] 
[ ] //########################################################################
[ ] 
[+] //########## Spending Planner ###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_SpendingPlanner()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open spending center reports
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while opening spending center						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
	[ ] // ********************************************************
[+]  testcase Test27_SpendingPlanner() appstate PerformanceBaseState
	[ ] 
	[ ] // If Quicken is launched 
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] //Click on Planning Center
		[+] if(!QuickenMainWindow.QWNavigator.Spending.Exists(SHORT_SLEEP))
			[ ] ReportStatus("Validate Spending Planner", FAIL, "spending Center did not opened")
		[ ] 
		[ ] QuickenMainWindow.QWNavigator.Spending.Click()
		[ ] ReportStatus("Validate Spending Planner", PASS, "spending Planner opened successfully")
		[ ] 
[ ] //#######################################################################
[ ] 
[+] //################### Open Protfolio View Report #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_OpenProtfolioView()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open Portfolio View
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while opening  Portfolio View				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
	[ ] // ********************************************************
[+]  testcase Test28_OpenProtfolioView() appstate PerformanceBaseState
	[ ] 
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] //Click on Investing Tab
		[ ] QuickenMainWindow.QWNavigator.Investing.Click()
		[ ] //Click on Protfolio tab
		[+] if(QuickenMainWindow.QWNavigator.Portfolio.Exists())
			[ ] QuickenMainWindow.QWNavigator.Portfolio.Click()
			[ ] ReportStatus("Validate Portfolio View", PASS, "Portfolio View opened successfully")
		[+] else 
			[ ] ReportStatus("Validate Portfolio View", FAIL, "Portfolio View  did not opened successfully")
[ ] //#######################################################################
[ ] 
[+] //############## Open Reconcile Dialog box ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_OpenReconcileDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open Reconcile dialog box and close the same
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while opening  Reconcile dialog box 				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
	[ ] // ********************************************************
[+] testcase Test29_OpenReconcileDialog () appstate PerformanceBaseState
	[-] //Variable Declaration
		[ ] INTEGER iSwitchState
		[ ] STRING sCaption
		[ ] BOOLEAN bCaption
		[ ] sAccountName="Checking 01 Account"
		[ ] 
	[-] if(QuickenWindow.Exists())
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
	[ ] QuickenWindow.SetActive ()
	[-] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] 
		[ ] //Select the reconcile item
		[ ] NavigateToAccountActionBanking(5 , sPopUpWindow)
	[ ] 
	[ ] //Checking Reconcile popup
	[-] if (DlgYourAccountMaybeoutofdate.Exists(3))
		[ ] DlgYourAccountMaybeoutofdate.SetActive()
		[ ] DlgYourAccountMaybeoutofdate.Reconcilewithoutdownloading.Select("Reconcile without downloading")
		[ ] DlgYourAccountMaybeoutofdate.OKButton.Click()
		[ ] 
		[ ] 
	[-] if(!ReconcileDetails.Exists(5))	
		[ ] ReportStatus("Validate Reconcile Popup", FAIL, "Reconcile Popup did not opened successfully")
		[ ] 
	[-] else
		[ ] ReconcileDetails.SetActive()
		[ ] ReconcileDetails.Cancel.Click()
		[ ] ReportStatus("Validate Reconcile Popup", PASS, "Reconcile Popup  opened successfully")
		[ ] 
	[ ] 
	[+] if(BankingPopUp.Exists())
		[ ] BankingPopUp.SetActive()
		[ ] BankingPopUp.Close()
		[ ] 
		[ ] 
[ ] //########################################################################
[ ] 
[+] //############ Import Web Connect File Banking ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_ImportWebConnectFileBanking()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will import the web connect file for banking account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while uploading the file			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
	[ ] // ********************************************************
[-] testcase Test30_ImportWebConnectFileBanking() appstate PerformanceBaseState
	[-] //Vairable
		[ ] STRING sFileName= "WebImportBank"
		[ ] STRING sAccountName ="Arvest Bank Account" 
	[-] if (QuickenWindow.Exists() == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Import the web connect file
		[ ] iUploadResult= ImportWebConnectFile(sFileName , sAccountName)
		[ ] 
		[-] if(iUploadResult==PASS)
			[ ] ReportStatus("Validate Banking web file ", iUploadResult, "Banking web file import successfully")
		[+] else
			[ ] ReportStatus("Validate Banking web file ", iUploadResult, "Banking web file not imported successfully")
			[ ] 
		[ ] 
		[ ] 
[ ] //##########################################################################
[ ] 
[+] //############ Import Web Connect File for Investing ################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test31_ImportWebConnectFileInvestment()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Import the web connect file for investment account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while uploading the file			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
	[ ] // ********************************************************
[+] testcase Test31_ImportWebConnectFileInvestment() appstate PerformanceBaseState
	[+] //Variable
		[ ] STRING sFileName= "WebImportInv"
		[ ] STRING sCaption
		[ ] BOOLEAN bCaption
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists() == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] sCaption = QuickenWindow.GetCaption()
		[ ] bCaption = MatchStr("*{sFileNameSmallFile}*", sCaption)
		[+] if(bCaption==TRUE)
				[ ] ReportStatus("Validate Investing  web file ", PASS, "Investing  web file is already imported in Test12")
		[+] else 
			[ ] bCaption = MatchStr("*{sFileNamelargeFile}*", sCaption)
			[ ] 
			[+] if(bCaption==TRUE)
				[ ] 
				[ ] ReportStatus("Validate Investing  web file ", PASS, "Investing  web file is already imported in Test12")
				[ ] 
			[+] else
				[ ] //Import the wen connect file
				[ ] iUploadResult= ImportWebConnectFile(sFileName)
				[ ] 
				[+] if(iUploadResult==PASS)
					[ ] ReportStatus("Validate Investing  web file ", iUploadResult, "Investing  web file import successfully")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Investing  web file ", iUploadResult, "Investing web file did not successfully")
					[ ] 
			[+] 
				[ ] 
			[ ] 
[ ] //##########################################################################
[ ] 
[+] //##################### Accepting All The Banking Transactions ######################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Testcase33_AcceptingBankingTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will accept the web transaction of banking
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while accepting the web transaction							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	 2/2/2011  	Created By	Chandan Abhyankar	
	[ ] //*********************************************************
[-] testcase Test32_AcceptingBankingTransaction() appstate PerformanceBaseState
	[ ] 
	[-] //-------------Variable Declaration-------------
		[ ] LIST OF STRING lsAccountName
		[ ] 
		[ ] lsAccountName ={"Checking at Arvest Bank - Web Connect" ,"Arvest Bank Account"}
	[ ] 
	[ ] 
	[-] if (QuickenWindow.Exists() == TRUE)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // -------------Turn ON Popup mode-------------
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] // -------------This will click  first Banking account on AccountBar based on file type-------------
		[ ] sCaption = QuickenWindow.GetCaption()
		[ ] 
		[ ] bCaption = MatchStr("*{sFileNamelargeFile}*", sCaption)
		[ ] 
	[-] if(bCaption == TRUE)
		[ ] iSelect = SelectAccountFromAccountBar(lsAccountName[1],ACCOUNT_BANKING)
		[ ] 
	[-] else 
		[ ] iSelect = SelectAccountFromAccountBar(lsAccountName[2],ACCOUNT_BANKING)
		[ ] 
		[ ] 
		[-] if(BankingPopUp.Exists(MEDIUM_SLEEP))
			[ ] BankingPopUp.SetActive()
			[ ] 
			[ ] BankingPopUp.Maximize()
			[ ] 
			[ ] //-------------Click on accept all button to accept the transaction-------------
			[ ] 
			[ ] AcceptAll.Click()
			[ ] 
			[ ] ReportStatus("Validate Accept all transactions",PASS,  "Accepted successfully")
			[ ] 
			[ ] BankingPopUp.Close()
		[ ] 
		[-] else
			[ ] ReportStatus("Validate Accept all transactions",FAIL,  "Not accepted successfully")
			[ ] 
[ ] //##########################################################################
[ ] 
[+] //############## Create  Banking Account #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test33_AddCheckingAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Checking Account - Checking03.
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if checking account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	3/3/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test33_AddCheckingAccount () appstate PerformanceBaseState
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER  iAddAccount
		[ ] STRING sAccountWorksheet="Account"
		[ ] LIST OF STRING lsAddAccount
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sExcelName, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] sAccountName ="Checking 03 Account"
	[ ] // Quicken is launched then Add Checking Account
	[+] if (QuickenWindow.Exists() == True)
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], sAccountName, lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {sAccountName}  is created successfully")
		[+] else
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {sAccountName}  is not created")
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############### Create Investment Account ########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test34_AddBrokerageAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Investment (Brokerage) Account - Brokerage 01
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if brokerage account is added correctly					
		[ ] //							Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	03/03/2020  	Created By	Chandan Abhyankar
		[ ] // 											
	[ ] //*********************************************************
[+] testcase Test34_AddBrokerageAccount () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount, iSwitchState
		[ ] BOOLEAN bMatch
		[ ] STRING sActual,sHandle
		[ ] STRING sAccountWorksheet="Account"
		[ ] LIST OF STRING lsAddAccount
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sExcelName, sAccountWorksheet)
	[ ] // Fetch 4th row from the given sheet
	[ ] lsAddAccount=lsExcelData[2]
	[ ] 
	[ ] // Quicken is launched then Add Brokerage Account
	[-] if (QuickenWindow.Exists(5) == True)
		[ ] 
		[ ] //iSwitchState = UsePopupRegister("OFF")
		[ ] 
		[ ] // Add Investment Accounts
		[ ] iAddAccount = AddManualBrokerageAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5])
		[-] if (iAddAccount==PASS)
			[ ] ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[2]} is created successfully")
		[+] else
			[ ] ReportStatus("Add Brokerage Account", FAIL, "Brokerage Account -  {lsAddAccount[2]} couldn't be created successfully")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //########## Add Category in Category list  #################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test35_AddCategoryInCategoryList()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add Category in Category list  
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while adding category 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  2/2/2011  	Created By	Chandan Abhyankar	
	[ ] //*********************************************************
[+] testcase Test35_AddCategoryInCategoryList() appstate PerformanceBaseState
	[+] // Variable Declaration
		[ ] INTEGER iAdd
		[ ] STRING sCategoryName="ShoppingPerf"
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iAdd = AddCategory(sCategoryName, "Income", "Category added for testing")			// Add new category
		[ ] 
		[ ] ReportStatus("Add Category", iAdd, "Category -  {sCategoryName} is added ") 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not availabley")
[ ] //##############################################################################
[ ] 
[+] //############# Create New Data file ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test36_NewDataFileCreation()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will create New Data File
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if data file is created without any errors						
		[ ] // 							Fail	if any error occurs
		[ ] //							Abort	if data file with same name already exists
		[ ] // 
		[ ] // REVISION HISTORY: 	3/3/2011  	Created By	Chandan Abhyankar
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test36_NewDataFileCreation () appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile,iRegistration
		[ ] STRING sFileName="Performance Test"
		[ ] STRING sDataFile =AUT_DATAFILE_PATH+"\"+"Performance Test.QDF"
		[ ] 
	[ ] 
	[ ] // Quicken is launched then create data file
	[+] if (QuickenWindow.Exists() == True)
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
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Close Quicken ####################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test37_CloseQuicken()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken  if open.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while closing the window							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
	[ ] //*********************************************************
[+] testcase Test37_CloseQuicken() appstate PerformanceBaseState
	[+] if(QuickenWindow.Exists() == TRUE)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Kill()
		[ ] WaitForState(QuickenWindow, false,2)
		[ ] // QuickenWindow.File.Click()
		[ ] // QuickenWindow.File.Exit.Select()
	[ ] 
	[ ] //Checking Quicken backup window exists
	[+] if(QuickenWindow.QuickenBackup.Exists())
		[ ] QuickenBackup.Exit.Click()
		[ ] sleep(2)
	[+] if(QuickenWindow.Exists() == FALSE)
		[ ] ReportStatus("Validate Shut down ", PASS, "Quicken shut down successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Vadiate Shut down ", FAIL, "Quicken shut down unsuccessfully")
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //############# Performance Clean  ################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 PerformanceClean ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken, delete performance dll file  and log file .
		[ ] 
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while closing the window	and deleting the file .						
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	2/2/2011  	Created By	Chandan Abhyankar
	[ ] //*********************************************************
[+] testcase PerformanceClean() appstate none
	[+] //VARIABLE DECLARATION
		[ ] LIST OF STRING lsContentValue, lscontent = {}
		[ ]  STRING sLine, sFilePath
		[ ]  BOOLEAN bMatch
		[ ]  INTEGER i = 1
		[ ] HFILE hFile
		[ ] 
		[ ] // Set the Path for Config.ini file
		[+] if (OPERATING_SYSTEM == "Windows 7" || OPERATING_SYSTEM == "Windows Vista")
			[ ]  sQuickenIniPath =ALLUSERSPROFILE + "\Intuit\Quicken\Config\Quicken.ini"
			[ ] 
		[+] if (OPERATING_SYSTEM == "Windows XP")
			[ ]   sQuickenIniPath =ALLUSERSPROFILE + "\Application Data\Intuit\Quicken\Config\Quicken.ini"
		[ ] 
		[ ] sFilePath = sQuickenIniPath
	[ ] 
	[+] if(QuickenWindow.Exists() == TRUE)
		[ ] QuickenWindow.Exit()
	[ ] 
	[ ] //File Delete for performance
	[+] if(FileExists(sNLForPerformanceDll))
		[ ] DeleteFile(sNLForPerformanceDll)
	[ ] 
	[ ] //Configuration Delete from INI file
	[ ] 
	[ ]  hFile = FileOpen (sFilePath, FM_READ)
	[ ]  lsContentValue = {}
	[+]   while (FileReadLine (hFile, sLine))
		[ ] ListAppend(lscontent, sLine) 
	[ ] FileClose(hFile)
	[+]   for(i=1; i<=ListCount(lscontent);i++)
		[ ]   bMatch= MatchStr("*[PerfMeasure]*", lscontent[i])
		[+]   if(bMatch == TRUE)
			[ ]   lscontent[i] = StrTran (lscontent[i], "[PerfMeasure]","" )
	[+]   for(i=1; i<=ListCount(lscontent);i++)
		[ ]   bMatch= MatchStr("*Enabled=1*", lscontent[i])
		[+]   if(bMatch == TRUE)
			[ ]  lscontent[i] = StrTran (lscontent[i], "Enabled=1","" )
		[ ]   ListAppend(lsContentValue, lscontent[i]) 
	[ ] hFile = FileOpen (sFilePath, FM_WRITE)
	[+] for(i=1; i<=ListCount(lsContentValue); i++)
		[ ] FileWriteLine (hFile,lsContentValue[i])
		[ ] 
	[ ] 
	[ ] sys_execute("taskkill /f partner.exe")
[ ] //#############################################################################
[ ] 
