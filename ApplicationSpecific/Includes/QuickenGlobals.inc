[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<QuickenGlobals.INC>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This file contains all Global Variables/Constants used for Quicken Desktop automation
	[ ] //
	[ ] // DEPENDENCIES:	QuickenConfig.INC
	[ ] //
	[ ] // DEVELOPED BY:	Chandan Abhyankar
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 06/Dec/10 Chandan Abhyankar	Created
	[ ] 
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\ApplicationSpecific\includes\QuickenConfig.inc" 
[ ] // ==========================================================
[ ] 
[ ] // Location of Files and Directory
[ ] public STRING sQwAutoPath = APP_PATH + "\Tools\qwauto\qwauto.exe"
[ ] public STRING sAutoApiSourcePath = APP_PATH + "\Tools\qwauto\autoapi.dll"
[ ] public STRING sAccDllSourcePath = APP_PATH + "\Tools\intuonl\Release\qa_acc32.dll"
[ ] public STRING sIntuonlSourcePath = APP_PATH + "\Tools\intuonl\Release\Intu_onl.ini"
[ ] 
[ ] public STRING sAutoApiDestinationPath = QUICKEN_ROOT + "\autoapi.dll"
[ ] public STRING sAccDllDestinationPath = QUICKEN_ROOT + "\qa_acc32.dll"
[ ] public STRING sIntuonlPath = APP_PATH + "\Tools\intuonl\Release\intuonl.exe"
[ ] //public STRING sDestinationonliniFile=ALLUSERSPROFILE+"\Application Data\Intuit\Quicken\Config\Intu_onl.ini"
[ ] public STRING sDestinationonliniFile=SYS_GetEnv("AllUserQuickenDirPath") +"\Config\Intu_onl.ini"
[ ] public STRING sQuickenIniFile=SYS_GetEnv("QuickenIniPath") 
[ ] 
[ ] public STRING sAutomationToolsPath = ROOT_PATH + "\ApplicationSpecific\Tools"
[ ] public STRING sBullseyeURLSourcePath = APP_PATH + "\Data\TestData\StageminiSetup\BullseyeURL.ini"
[ ] public STRING sintu_onlpreprodSourcePath = APP_PATH + "\Data\TestData\StageminiSetup\intu_onlpreprod.ini"
[ ] public STRING sintu_onlpreprodDestinationPath = SYS_GetEnv("AllUserQuickenDirPath") +"\Config\intu_onl.ini"
[ ] public STRING sBullseyeURLDestinationPath = SYS_GetEnv("AllUserQuickenDirPath") +"\Inet\Common\Localweb\Bullseye\BullseyeURL.ini"
[ ] public STRING  sTSMDir =SYS_GetEnv ("ALLUSERSPROFILE")+ "\Intuit\Quicken\Inet\Common\launch"
[ ] 
[ ] 
[ ] 
[ ] 
[ ] public STRING sQsapiDirPath = QUICKEN_ROOT + "\Qsapi"
[ ] public STRING sSplashPngPath = QUICKEN_ROOT + "\splash.png"
[ ] public STRING sQwmainDllPath = QUICKEN_ROOT + "\qwmain.dll"
[ ] public STRING sExe = QUICKEN_ROOT + "\qw.exe"
[ ] public STRING sQwLogPath =  USERPROFILE + "\Application Data\Intuit\Quicken\Log\qw.log"
[ ] public STRING sAllUserQuickenDirPath, sQuickenIniPath, sInstallerDirPath, sIntuitDirPath
[ ] 
[ ] // This stores the result of Test Case
[ ] public STRING sTestCaseStatusFile = APP_PATH + "\Data\TestData\TestCaseResult.txt"
[ ] 
[ ] // Source Installation Location of Files and Directory
[ ] //public const STRING INSTALL_BUILD_PATH ="\\ps7991\Quicken_Installable"  
[ ] public const STRING INSTALL_BUILD_PATH ="C:\Quicken\Installer" 
[ ] public STRING sSetUpDestPath = "C:\Setup.ini"
[ ] 
[ ] // Navigation Data File
[ ] public const STRING RPMNavigationDataFile = "RPMNavigation"
[ ] public const STRING HABNavigationDataFile = "RPMNavigation"
[ ] public const STRING QNUENavigationDataFile = "QNUENavigation"
[ ] 
[ ] // This Array indicates Test cases to be haulted if Primary Test Case is failed for Smoke suite
[+] ARRAY [5] [5] OF STRING SmokeTCsDependency = {...}
	[ ] {"Test03_AddCheckingAccount", "Test04_CreateBill, Test07_OpenFirstCheckingRegister", "Test08_AddPaymentCheckingTransaction", "Test32_ModifyTransaction"}
	[ ] {"Test06_AddOtherCheckingAccount", "Test09_OpenSecondCheckingRegister", "Test10_AddDepositCheckingTransaction"}
	[ ] {"Test11_AddBrokerageAccount", "Test12_VerifyDownloadTransactionTab", "Test13_InvestmentBuyTransaction", "Test14_InvestmentSellTransaction"}
	[ ] {"Test13_InvestmentBuyTransaction", "Test26_OpenInvestingCenter"}
	[ ] {"Test33_AddSavingAccount", "Test41_ValidateAccountChanges"}
[ ] 
[+] ARRAY [2] [2] OF STRING BatTCsDependency = {...}
	[ ] {"Test05_AddCheckingAccount", "Test06_AddTransaction"}
	[ ] {"Test06_AddTransaction", "Test08_VerifyReportTransaction"}
[ ] 
[ ] //Added by Puja
[+] ARRAY [2] [2] OF STRING PerformanceTCsDependency = {...}
	[ ] {"TestCase31_Import_web_connect_File_Investment", "Test12_Open_investment_Register"}
	[ ] {"",""}
[ ] 
[ ] // Return codes used in function
[ ] public const INTEGER PASS = 0
[ ] public const INTEGER FAIL = 1
[ ] public const INTEGER WARN = 2
[ ] public const INTEGER ABORT = -1
[ ] 
[ ] //Added by puja for File IO
[ ] public LIST OF STRING  lscontent = {}
[+] ARRAY [2] [2] OF STRING FileIOTCsDependency = {...}
	[ ] { "Test01_FileBackup","Test03_OverWriteBackupFile,Test04_CancelOverWriteBackupFile,Test05_RestoreFromBackupManuallywithOverwrite,Test06_RestoreFromBackupManuallyCreateCopy"}
	[ ] {"Test02_OnlineBackup","Test07_RestoreOnlineBackupFile"}
[ ] 
[ ] // Defined SKUs
[ ] public const STRING SKU_QNUE = "Starter Edition"
[ ] public const STRING SKU_DELUXE = "Deluxe"
[ ] public const STRING SKU_PREMIER = "Premier"
[ ] public const STRING SKU_HAB = "Home & Business"
[ ] public const STRING SKU_RPM = "Rental Property Manager"
[ ] 
[ ] 
[ ] // Record Declarations
[+] public type CategoryRecord is record
	[ ] STRING sCategoryName  //CategoryName, 
	[ ] STRING sCategoryType  //CategoryType, 
	[ ] STRING sCategoryDescription  //CategoryDescription, 
[+] public type TransactionRecord is record
	[ ] STRING sWindowType
	[ ] STRING sTransactionType
	[ ] STRING sAmount
	[ ] STRING sDate
	[ ] STRING sChequeNo
	[ ] STRING sPayee
	[ ] STRING sMemo
	[ ] STRING sCategory
	[ ] STRING sAccount
	[ ] STRING sTotal
[+] public type Inv_TransactionRecord is record
	[ ] STRING sWindowType
	[ ] STRING sTransactionType
	[ ] STRING sAccountUsedPrimarily
	[ ] STRING sAccount
	[ ] STRING sTransactionDate
	[ ] STRING sSecurity
	[ ] STRING sNumberOfShares
	[ ] STRING sPricePaid
	[ ] STRING sCommission
	[ ] STRING sMemo
	[ ] STRING sExpectedCashBalance
	[ ] STRING sUseCash
	[ ] STRING sDateAcquired
	[ ] STRING sAccruedInt
	[ ] 
[+] public type Inv_IncomeTransactionRecord is record
	[ ] STRING sTransactionType
	[ ] STRING sAccountUsedPrimarily
	[ ] STRING sAccount
	[ ] STRING sTransactionDate
	[ ] STRING sTransferAccount
	[ ] STRING sSecurity
	[ ] STRING sDividend
	[ ] STRING sInterest
	[ ] STRING sShortTermCapGains
	[ ] STRING sMidTermCapGains
	[ ] STRING sLongTermCapGains
	[ ] STRING sMisc
	[ ] STRING sMemo
	[ ] STRING sCategory
	[ ] 
[+] public type Inv_StockSplitRecord is record
	[ ] STRING sTransactionType
	[ ] STRING sAccountUsedPrimarily
	[ ] STRING sAccount
	[ ] STRING sTransactionDate
	[ ] STRING sSecurity
	[ ] STRING sNewShares
	[ ] STRING sOldShares
	[ ] STRING sPriceAfterSplit
	[ ] STRING sMemo
	[ ] 
[+] public type Inv_MiscExpRecord is record
	[ ] STRING sTransactionType
	[ ] STRING sAccountUsedPrimarily
	[ ] STRING sAccount
	[ ] STRING sTransactionDate
	[ ] STRING sTransferAccount
	[ ] STRING sSecurity
	[ ] STRING sAmount
	[ ] STRING sCategory
	[ ] STRING sMemo
	[ ] 
[+] public type Inv_ReturnCapitalRecord is record
	[ ] STRING sTransactionType
	[ ] STRING sAccountUsedPrimarily
	[ ] STRING sAccount
	[ ] STRING sTransactionDate
	[ ] STRING sTransferAccount
	[ ] STRING sSecurity
	[ ] STRING sAmount
	[ ] STRING sMarketValue
	[ ] STRING sMemo
	[ ] 
[+] public type Inv_CashAction is record
	[ ] STRING sTransactionType
	[ ] STRING sAccountUsedPrimarily
	[ ] STRING sAccount
	[ ] STRING sTransactionDate
	[ ] STRING sPayee
	[ ] STRING sAmount
	[ ] STRING sMemo
	[ ] STRING sCategory
	[ ] STRING sChequeNumber
	[ ] 
[+] public type Inv_ESPPRecord is record
	[ ] STRING sTransactionType
	[ ] STRING sAccountUsedPrimarily
	[ ] STRING sAccount
	[ ] STRING sTransactionDate
	[ ] STRING sWhichStock
	[ ] STRING sStockName
	[ ] STRING sTickerSymbol
	[ ] STRING sCashFrom
	[ ] STRING sNumberOfShares
	[ ] STRING sPricePerShare
	[ ] STRING sTransactionDate
	[ ] STRING sCommission
	[ ] STRING sOfferingDate
	[ ] STRING sEndingDate
	[ ] STRING sPriceOnOfferingDate
	[ ] STRING sPriceOnEndingDate
	[ ] STRING sDiscountRate
	[ ] STRING sSpouseESPP
	[ ] STRING sCostBasisMethod
	[ ] 
[+] public type CheckNumReordKeys is record
	[ ] STRING sATM
	[ ] STRING sDeposit
	[ ] STRING sPrintCheck
	[ ] STRING sTransfer
	[ ] STRING sEFT
	[ ] 
[+] public type IncTranReminderRecord is record
	[ ] STRING sReminderType
	[ ] STRING sPayeeName
	[ ] STRING sDate
	[ ] STRING sHowOften
	[ ] STRING sEndDate
	[ ] STRING sAmountType
	[ ] STRING sAmount
	[ ] STRING sCategory
	[ ] STRING sTag
	[ ] STRING sMemo
	[ ] STRING sToAccount
	[ ] STRING sFromAccount
	[ ] 
[+] public type rFILoginReqRespRecord is record
	[ ] STRING sAddFILogin
	[ ] STRING sContentProviderType
	[ ] STRING sCpFIId
	[ ] STRING sSuccessfulAddFILogin
	[ ] STRING sContentProviderServiceName
	[ ] STRING sFiLoginId
	[ ] STRING sContentProviderType
[ ] 
[+] public type rTransactionReqRespRecord is record
	[ ] STRING sImportTransactions
	[ ] STRING sImportedTransactions
	[ ] STRING sIsLastInImportSequence
	[ ] STRING sImportTransactionsResult
	[ ] STRING sBankcc
	[ ] STRING sImported
	[ ] STRING sfiTId
	[ ] STRING sCorrelationId
	[ ] STRING sDescription
	[ ] STRING sUserDescription
	[ ] STRING sModifiedTransactions
	[ ] STRING sTransactions
	[ ] STRING sModified
	[ ] STRING sDatePosted
	[ ] STRING sOriginalDatePosted
	[ ] STRING sUserDatePosted
	[ ] STRING sSyncID
	[ ] STRING sModifiedFrom
	[ ] STRING sCategoryId
	[ ] STRING sCategoryName
	[ ] 
[+] public type rAccountReqRespRecord is record
	[ ] STRING sGetAccountsResult
	[ ] STRING sAccounts
	[ ] STRING sSourceAccountName
	[ ] STRING sUserAccountName
	[ ] STRING  sFiLoginId
	[ ] STRING  sCurrentBalance
	[ ] STRING sSourceAccountId
	[ ] STRING sAccountId
	[ ] STRING sAddAccount
	[ ] STRING sSuccessfulAddAccount
	[ ] STRING sRequests
	[ ] STRING sAccountOpeningBalance
	[ ] STRING sRequestID
	[ ] STRING sAccount
	[ ] STRING sBankAccount
	[ ] STRING sSourceAccountNumber
	[ ] STRING sSourceAccountNumber
	[ ] STRING sCreditCardAccount
	[ ] STRING sAccountOpeningDate
[+] public type rCategoryReqRespRecord is record
	[ ] STRING sIgnoreReqFailure
	[ ] STRING sCreateCategory
	[ ] STRING sModel
	[ ] STRING sCategoryType
	[ ] STRING sCategoryName
	[ ] STRING  sDeleted
	[ ] STRING  sEditable
	[ ] STRING sResponses
	[ ] STRING sRequestID
	[ ] STRING sSingleCategoryResponse
	[ ] STRING sCategoryName
	[ ] STRING  sParentId
	[ ] STRING  sCategoryFamily
	[ ] STRING  sId
	[ ] STRING  sUpdateCategory
	[ ] STRING  sCategoriesResponse
	[ ] STRING  sCategoryId
	[ ] STRING  sEntries
	[ ] 
[ ] 
[+] public LIST OF STRING lsCategoryReqRespValue = {...}
	[ ] "ignoreReqFailure"
	[ ] "createCategory"
	[ ] "model"
	[ ] "categoryType"
	[ ] "categoryName"
	[ ] "deleted"
	[ ] "editable"
	[ ] "responses"
	[ ] "requestID"
	[ ] "singleCategoryResponse"
	[ ] "categoryName"
	[ ] "parentId"
	[ ] "categoryFamily"
	[ ] "id"
	[ ] "updateCategory"
	[ ] "categoriesResponse"
	[ ] "categoryId"
	[ ] "entries"
	[ ] 
[ ] 
[+] public LIST OF STRING lsAccountReqRespRecordValue = {...}
	[ ] "getAccountsResult"
	[ ] "accounts"
	[ ] "sourceAccountName"
	[ ] "userAccountName"
	[ ] "fiLoginId"
	[ ] "currentBalance"
	[ ] "sourceAccountId"
	[ ] "accountId"
	[ ] "addAccount"
	[ ] "successfulAddAccount"
	[ ] "requests"
	[ ] "accountOpeningBalance"
	[ ] "requestID"
	[ ] "account"
	[ ] "bankAccount"
	[ ] "sourceAccountNumber"
	[ ] "creditCardAccount"
	[ ] "accountOpeningDate"
	[ ] 
[ ] 
[+] public LIST OF STRING lsTransactionReqRespValue = {...}
	[ ] "importTransactions"
	[ ] "importedTransactions"
	[ ] "isLastInImportSequence"
	[ ] "importTransactionsResult"
	[ ] "bankcc"
	[ ] "imported"
	[ ] "fiTId"
	[ ] "correlationId"
	[ ] "description"
	[ ] "userDescription"
	[ ] "modifiedTransactions"
	[ ] "transactions"
	[ ] "modified"
	[ ] "datePosted"
	[ ] "originalDatePosted"
	[ ] "userDatePosted"
	[ ] "id"
	[ ] "modifiedFrom"
	[ ] "categoryId"
	[ ] "categoryName"
	[ ] 
[ ] 
[+] public type rReqRespRecord is record
	[ ] STRING sGetAccountsResult
	[ ] STRING sAccounts
	[ ] STRING sSourceAccountName
	[ ] STRING sUserAccountName
	[ ] STRING  sFiLoginId
	[ ] STRING  sCurrentBalance
[+] public LIST OF STRING lsReqRespRecordValue = {...}
	[ ] "getAccountsResult"
	[ ] "accounts"
	[ ] "sourceAccountName"
	[ ] "userAccountName"
	[ ] "fiLoginId"
	[ ] "currentBalance"
[ ] 
[+] public LIST OF STRING lsTransactionParams = {...}
	[ ] "modified:"
	[ ] "datePosted:"
	[ ] "originalDatePosted:"
	[ ] "userDatePosted:"
	[ ] "mintDescription:"
	[ ] "genericMintDescription:"
	[ ] "inferredCategory:"
[ ] 
[ ] ////lsTransactionReqRespValue list wiil be used to provide values to rTransactionReqRespRecord////
[+] public LIST OF STRING lsReportCategory  = {...}
	[ ] "Banking"
	[ ] "Comparison"
	[ ] "Investing"
	[ ] "Net Worth & Balances"
	[ ] "Spending"
	[ ] "Tax"
	[ ] "Rental Property"
	[ ] "Business"
	[ ] "EasyAnswer"
	[ ] "Graphs"
	[ ] "Reports & Graphs Center"
	[ ] "MySavedReportsGraphs"
[+] public LIST OF STRING lsCheckNumReordValue  = {...}
	[ ] "ATM"
	[ ] "DEP"
	[ ] "Print"
	[ ] "TXFR"
	[ ] "EFT"
[+] public LIST OF STRING lsFILoginRecordValue = {...}
	[ ] "addFILogin"
	[ ] "contentProviderType"
	[ ] "cpFIId"
	[ ] "successfulAddFILogin"
	[ ] "contentProviderServiceName"
	[ ] "fiLoginId"
	[ ] "contentProviderType"
	[ ] 
[ ] 
[ ] 
[ ] // Quicken Specific 
[ ] const STRING ACCOUNT_BANKING = "Banking"
[ ] const STRING ACCOUNT_INVESTING = "Investing"
[ ] const STRING ACCOUNT_BUSINESS = "Business"
[ ] const STRING ACCOUNT_PROPERTYDEBT = "Property & Debt"
[ ] const STRING ACCOUNT_RENTALPROPERTY = "Rental Property"		
[ ] const STRING ACCOUNT_BUSINESS_BANKING = "Business Banking"
[ ] const STRING ACCOUNT_SEPARATE = "Separate"	
[ ] const STRING ACCOUNT_SAVINGGOALS = "Savings Goals"
[ ] 
[ ] 
[ ] // Quicken Specific 
[ ] 
[ ] const STRING VIEW_STANDARD_MENU= "Standard Menu"
[ ] const STRING VIEW_CLASSIC_MENU= "Classic Menu"
[ ] 
[ ] const STRING TOOLS_ACCOUNT_LIST= "Account List"
[ ] const STRING TOOLS_CATEGORY_LIST= "Category List"
[ ] const STRING TOOLS_MEMORIZE_PAYEE_LIST= "Memorized Payee List"
[ ] const STRING TOOLS_CURRENCY_LIST= "Currency List"
[ ] const STRING TOOLS_ONE_STEP_UPDATE= "One Step Update"
[ ] 
[ ] const STRING MANAGE_BILL_AND_INCOME_REMINDER="Manage bill and income reminder"
[ ] const STRING NEW_COPY="New copy"
[ ] 
[ ] STRING sREPORT_NETWORTH = "Net Worth"
[ ] STRING sREPORT_ACCOUNT_BALANCE = "Account Balance"
[ ] STRING sREPORT_SPENDING="Spending"
[ ] STRING sREPORT_SPENDING_BY_CAT = "Spending by Category"
[ ] STRING sREPORT_SPENDING_BY_PAYEE = "Spending by Payee"
[ ] STRING sREPORT_ITEMIZED_CAT ="Itemized Categories"
[ ] STRING sREPORT_TRANSACTION= "Transaction"
[ ] STRING sREPORT_CASH_FLOW= "CashFlow"
[ ] STRING sREPORT_INVESTMENT_TRANSACTION="Investment Transactions"
[ ] STRING sREPORT_NETWORTH_BALANCES = "Net Worth & Balances"
[ ] STRING sREPORT_INVESTMENT_PERFORMANCE = "Investment Performance"
[ ] STRING sREPORT_PORTFOLIO_VALUE="Portfolio Value"
[ ] STRING sREPORT_GRAPHS="Graphs"
[ ] STRING sREPORT_TAX="Tax"
[ ] STRING sREPORT_MY_SAVED_REPORTS_GRAPHS="MySavedReportsGraphs"
[ ] STRING sREPORT_CURRENT_BUDGET = "Current Budget"
[ ] STRING sREPORT_HISTORICAL_BUDGET = "Historical Budget"
[ ] 
[ ] STRING sTAB_HOME = "Home"
[ ] STRING sTAB_MAIN_VIEW = "Main View"
[ ] STRING sTAB_SPENDING = "Spending"
[ ] STRING sTAB_TRANSACTION = "Transaction"
[ ] STRING sTAB_BILL = "Bills"
[ ] STRING sTAB_UPCOMING = "Upcoming"
[ ] STRING sTAB_PROJECTED_BALANCES = "Projected Balances"
[ ] STRING sTAB_PLANNING = "Planning"
[ ] STRING sTAB_SPENDING_PLANNER = "Spending Planner"
[ ] STRING sTAB_LIFETIME_PLANNER = "Lifetime Planner"
[ ] STRING sTAB_TAX_CENTER = "Tax Center"
[ ] STRING sTAB_SAVING_GOALS = "Saving Goals"
[ ] STRING sTAB_INVESTING = "Investing"
[ ] STRING sTAB_PORTFOLIO = "Portfolio"
[ ] STRING sTAB_PERFORMANCE = "Performance"
[ ] STRING sTAB_ALLOCATIONS = "Allocations"
[ ] STRING sTAB_PROPERTY_DEBT = "Property & Debt"
[ ] STRING sTAB_NET_WORTH = "Net Worth"
[ ] STRING sTAB_ACCOUNT_OVERVIEW = "Account Overview"
[ ] STRING sTAB_DEBT = "Debt"
[ ] STRING sTAB_BUSINESS = "Business"
[ ] STRING sTAB_PROFIT_LOSS = "Profit Loss"
[ ] STRING sTAB_RENTAL_PROPERTY = "Rental Property"
[ ] STRING sTAB_RENT_CENTER = "Rent Center"
[ ] STRING sTAB_BUDGET = "Budget"
[ ] STRING sTAB_CASH_FLOW = "Cash Flow"
[ ] STRING sTAB_PROFIT_AND_LOSS_STATEMENT = "Profit and Loss Statement"
[ ] STRING sTAB_MOBILE_ALERTS = "Mobile Alerts"
[ ] STRING sTAB_QUICKEN_MOBILE = "Quicken Mobile"
[ ] STRING sTAB_SHEDULE_E_REPORT= "Schedule E-Supplemental Profit and Loss"
[ ] STRING sTAB_TAX_SHEDULE_REPORT= "Tax Schedule"
[ ] STRING sTAB_DEBT_REDUCTION = "Debt Reduction"
[ ]  STRING sTAB_TIPS_TUTORIALS = "Tips & Tutorials"
[ ]  STRING sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE ="Intuit ID, Mobile & Alerts"
[ ] 
[ ] STRING sTAB_DISPLAY_OPTIONS= "Display Options"
[ ] STRING sTAB_GENERAL= "General"
[ ] STRING sTAB_ONLINE_SERVICES= "Online Services"
[ ] 
[ ] 
[ ] 
[ ] 
[ ] // Worksheet  of testdata file
[ ] public STRING sQuickenAttributesWorksheet
[ ] public STRING sExpectedAboutQuicken
[ ] public STRING sNavigationData
[ ] public STRING  sPayee = "Automation Payee"
[ ] public List of STRING lsClass_Map= {"QC_button=PushButton"}                                                 
[ ] 
[ ] 
[ ] 
[ ] 
