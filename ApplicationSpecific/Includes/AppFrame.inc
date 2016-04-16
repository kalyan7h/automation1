[ ] // *********************************************************
[+] // FILE NAME:	<AppFrame.INC>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This file contains all GUI declarations for Quicken Desktop application in open agent
	[ ] //
	[ ] // DEPENDENCIES:	None
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 14/June/13  Udita Dube	Created
	[ ] 
[ ] // *********************************************************
[ ] 
[ ] const wDynamicMainWindow = QuickenMainWindow
[ ] 
[-] window MainWin QuickenWindow
	[ ] // locator "Quicken 201*"
	[ ] locator "/WPFWindow[@caption='Quicken 201*']"
	[ ] 
	[ ] // The working directory of the application when it is invoked
	[ ] const sDir = "C:\Windows\system32"
	[ ] 
	[ ] // The command line used to invoke the application
	[ ] const sCmdLine = "%ProgramFiles%\Quicken\qw.exe"
	[ ] 
	[ ] // The list of windows the recovery system is to leave open
	[ ] // const lwLeaveOpenWindows = {?}
	[ ] // const lsLeaveOpenLocators = {?}
	[ ] 
	[+] Control awesomium
		[ ] locator "@windowClassName='Chrome_RenderWidgetHostHWND'"
	[+] WPFMenu MainMenu
		[ ] locator "@automationId='MainMenu'"
	[+] WPFMenuItem File
		[ ] locator "@automationId='*File'"
		[+] WPFMenuItem NewQuickenFile
			[ ] locator "@automationId='*New Quicken File*'"
		[+] WPFMenuItem OpenQuickenFile
			[ ] locator "@automationId='*Open Quicken File*'"
		[+] WPFMenuItem SaveACopyAs
			[ ] locator "@automationId='Save a _copy as*'"
		[+] WPFMenuItem ShowThisFileOnMyComputer
			[ ] locator "@automationId='Show this file on _my computer*'"
		[+] WPFMenuItem SetPasswordForThisDataFile
			[ ] locator "@automationId='Set Password for this _data file*'"
		[+] WPFMenuItem SetPasswordToModifyTransaction
			[ ] locator "@automationId='Set Password to modify _transactions*'"
		[+] WPFMenuItem BackupAndRestore
			[ ] locator "@automationId='_Backup and Restore*'"
			[+] WPFMenuItem BackUpQuickenFile
				[ ] locator "@automationId='_Back up Quicken File*'"
			[+] WPFMenuItem RestoreFromBackupFile
				[ ] locator "@automationId='_Restore from Backup File*'"
		[+] WPFMenuItem FileImport
			[ ] locator "@automationId='File _Import*'"
			[+] WPFMenuItem WebConnectFile
				[ ] locator "@automationId='_Web Connect File*'or @windowidd='31000*'"
			[+] WPFMenuItem QIFFile
				[ ] locator "@automationId='_QIF File*'"
			[+] WPFMenuItem QuickenTransferFormatFile
				[ ] locator "@automationId='Quicken _Transfer Format (.QXF) File*'"
			[+] WPFMenuItem Addresses
				[ ] locator "@automationId='_Addresses*'"
			[+] WPFMenuItem ImportSecurityPricesFromCSV
				[ ] locator "@automationId='_Import Security Prices from CSV file*'"
			[+] WPFMenuItem TurboTaxFile
				[ ] locator "@automationId='_TurboTax File*'"
			[+] WPFMenuItem RentalPropertyManagerVersion
				[ ] locator "@automationId='_Rental Property Manager version 2 Data*'"
			[+] WPFMenuItem MicrosoftMoneyFile
				[ ] locator "@automationId='_Microsoft Money? file*'"
		[+] WPFMenuItem FileExport
			[ ] locator "@automationId='File _Export*'"
			[+] WPFMenuItem QIFFile
				[ ] locator "@automationId='_QIF File*'"
			[+] WPFMenuItem QuickenTransferFormatQXF
				[ ] locator "@automationId='Quicken _Transfer Format (.QXF) File*'"
			[+] WPFMenuItem ExportTurboTaxTaxScheduleR
				[ ] locator "@automationId='Export TurboTax tax schedule report*'"
			[+] WPFMenuItem ExportTurboTaxCapitalGains
				[ ] locator "@automationId='Export TurboTax capital gains report*'"
		[+] WPFMenuItem FileOperations
			[ ] locator "@automationId='_File Operations*'"
			[+] WPFMenuItem Copy
				[ ] locator "@automationId='_Copy*'"
			[+] WPFMenuItem YearEndCopy
				[ ] locator "@automationId='_Year-End Copy*'"
			[+] WPFMenuItem ValidateAndRepair
				[ ] locator "@automationId='_Validate and Repair*'"
			[+] WPFMenuItem FindQuickenFiles
				[ ] locator "@automationId='Find Quicken Files*'"
			[ ] 
			[ ] 
			[ ] 
		[+] WPFMenuItem PrinterSetup
			[ ] locator "@automationId='Printer _Setup*'"
			[+] WPFMenuItem ForReportsGraphs
				[ ] locator "@automationId='For _Reports*Graphs*'"
			[+] WPFMenuItem ForPrintingChecks
				[ ] locator "@automationId='For Printing _Checks*'"
			[+] WPFMenuItem ForPrintingInvoices
				[ ] locator "@automationId='For Printing _Invoices*'"
		[+] WPFMenuItem PrintChecks
			[ ] locator "@automationId='Print _Checks*'"
		[+] WPFMenuItem PrintMainView
			[ ] locator "@automationId='_Print Main View*'"
			[ ] 
			[ ] 
		[+] WPFMenuItem Exit
			[ ] locator "@automationId='E_xit'"
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] WPFMenuItem Edit
		[ ] locator "@automationId='*Edit'"
		[+] WPFMenuItem Cut
			[ ] locator "@automationId='Cu_t*'"
		[+] WPFMenuItem Copy
			[ ] locator "@automationId='_Copy*'"
		[+] WPFMenuItem Paste
			[ ] locator "@automationId='_Paste*'"
		[+] WPFMenuItem FindReplace
			[ ] locator "[@automationId='Find/Rep_lace*'][1]"
		[+] WPFMenuItem Preferences
			[ ] locator "@automationId='*Preferences*'"
		[+] WPFMenuItem Transaction
			[ ] locator "@automationId='_Transaction'"
			[ ] 
			[+] WPFMenuItem Delete
				[ ] locator "@automationId='_Delete7106'"
		[+] WPFMenuItem Find
			[ ] locator "@automationId='_Find*'"
			[ ] //locator "@automationId='_Find...7109'"
		[+] WPFMenuItem FindNext
			[ ] locator "@automationId='Find _Next*'"
	[+] WPFMenuItem View
		[ ] locator "@automationId='_View'"
		[+] WPFMenuItem StandardMenusRecommended
			[ ] locator "@automationId='_Standard Menus (recommended)*'"
		[+] WPFMenuItem ClassicMenus
			[ ] locator "@automationId='_Classic Menus*'"
		[+] WPFMenuItem UsePopUpRegisters
			[ ] locator "@automationId='_Use Pop-Up Registers*'"
		[+] WPFMenuItem ShowToolBar
			[ ] locator "@automationId='Show T_oolbar*'"
		[+] WPFMenuItem AccountBar
			[ ] locator "@automationId='Account _Bar*'"
		[+] WPFMenuItem DockHelpAndToDoBar
			[ ] locator "@automationId='_Dock Help and To Do Bar*'"
		[+] WPFMenuItem TabsToShow
			[ ] locator "@automationId='Tabs to Sho_w*'"
			[+] WPFMenuItem Home
				[ ] locator "@automationId='_Home*'"
			[+] WPFMenuItem Spending
				[ ] locator "@automationId='_Spending*'"
			[+] WPFMenuItem Bills
				[ ] locator "@automationId='_Bills*'"
			[+] WPFMenuItem Planning
				[ ] locator "@automationId='_Planning*'"
			[+] WPFMenuItem Investing
				[ ] locator "@automationId='_Investing*'"
			[+] WPFMenuItem PropertyDebt
				[ ] locator "@automationId='Property * _Debt*'"
			[+] WPFMenuItem Business
				[ ] locator "@automationId='B_usiness*'"
			[+] WPFMenuItem RentalProperty
				[ ] locator "@automationId='_Rental Property*'"
			[+] WPFMenuItem TipsTutorials
				[ ] locator "@automationId='Tips & Tutoria_ls*'"
			[+] WPFMenuItem MobileAlerts
				[ ] locator "@automationId='_Mobile & Alerts*'"
			[ ] 
		[+] WPFMenuItem FullScreen
			[ ] locator "@automationId='_Full Screen*'"
		[+] WPFMenuItem ShowTabs
			[ ] locator "@automationId='Show _Tabs*'"
		[+] WPFMenuItem USeLargeFont
			[ ] locator "@automationId='Use _Large Fonts*'"
	[+] WPFMenuItem Tools
		[ ] locator "@automationId='_Tools'"
		[+] WPFMenuItem AccountList
			[ ] locator "@automationId='_Account List*'"
		[+] WPFMenuItem AddAccount
			[ ] locator "@automationId='A_dd Account*'"
		[+] WPFMenuItem Calendar
			[ ] locator "@automationId='Cale_ndar*'"
		[+] WPFMenuItem AlertsCenter
			[ ] locator "@automationId='Al_erts Center*'"
		[+] WPFMenuItem ManageBillIncomeReminders
			[ ] locator "@automationId='Manage Bill & Income _Reminders*'"
		[+] WPFMenuItem CategoryList
			[ ] locator "@automationId='_Category List*'"
		[+] WPFMenuItem TagList
			[ ] locator "@automationId='_Tag List*'"
		[+] WPFMenuItem Recategorize
			[ ] locator "@automationId='Recategori_ze*'"
		[+] WPFMenuItem OneStepUpdate
			[ ] locator "@automationId='One Step _Update*'"
		[+] WPFMenuItem OneStepUpdateSummary
			[ ] locator "@automationId='One Step Update _Summary*'"
		[+] WPFMenuItem ScheduleUpdates
			[ ] locator "@automationId='Sche_dule Updates*'"
		[+] WPFMenuItem MemorizedPayeeList
			[ ] locator "@automationId='Memorized Payee Lis_t*'"
		[+] WPFMenuItem WriteAndPrintChecks
			[ ] locator "@automationId='_Write and Print Checks*'"
		[+] WPFMenuItem OnlinePayeeList
			[ ] locator "@automationId='Online Payee _List*'"
		[+] WPFMenuItem AddressBook
			[ ] locator "@automationId='Address _Book*'"
		[+] WPFMenuItem Calculator
			[ ] locator "@automationId='Calcula_tor*'"
		[+] WPFMenuItem PasswordVault
			[ ] locator "@automationId='Password _Vault'"
			[+] WPFMenuItem SetupNewPasswordVault
				[ ] locator "@automationId='_Set up new Password Vault*'"
			[+] WPFMenuItem AddOrEditPasswords
				[ ] locator "@automationId='Add or _Edit Passwords*'"
			[+] WPFMenuItem DeleteVaultAndAllSavedPasswords
				[ ] locator "@automationId='Delete Vault and all Saved Passwords*'"
		[+] WPFMenuItem QuickenBillPay
			[ ] locator "@automationId='Quicken Bill _Pay'"
			[+] WPFMenuItem LearnAboutQuickenBillPay
				[ ] locator "@automationId='Learn about Quicken Bill Pay*'"
			[+] WPFMenuItem SetUpQuickenBillPayAccoun
				[ ] locator "@automationId='Set up Quicken Bill Pay Account*'"
			[+] WPFMenuItem PayBillsOnTheWeb
				[ ] locator "@automationId='Pay Bills in Quicken*'"
			[+] WPFMenuItem ViewAndPayBillsOnTheWeb
				[ ] locator "@automationId='View and Pay Bills on the Web*'"
			[+] WPFMenuItem GettingStartedInstructions
				[ ] locator "@automationId='Getting Started Instructions*'"
			[ ] 
		[+] WPFMenuItem ReconcileAnAccount
			[ ] locator "@automationId='_Reconcile an Account*'"
		[+] WPFMenuItem OnlineCenter
			[ ] locator "@automationId='Online Cen_ter*'"
		[+] WPFMenuItem ManageHiddenAccounts
			[ ] locator "@automationId='_Manage Hidden Accounts*'"
		[+] WPFMenuItem SecurityList
			[ ] locator "@automationId='_Security List*'"
		[+] WPFMenuItem CurrencyList									// Edit > Preferences > Calender & Currency > Multicurrency Support check | Default ON for Canada and OFF for US
			[ ] locator "@automationId='Currenc_y List*'"
		[+] WPFMenuItem RenamingRules								// Available only if online account is added in data file
			[ ] locator "@automationId='_Renaming Rules*'"
	[+] WPFMenuItem Home
		[ ] locator "@automationId='H_ome'"
		[+] WPFMenuItem GoToHome
			[ ] locator "@automationId='Go to _Home*'"
		[+] WPFMenuItem MainView
			[ ] locator "@automationId='    _Main View*'"
		[+] WPFMenuItem CustomizeThisView
			[ ] locator "@automationId='Customize this view*'"
		[+] WPFMenuItem AddACustomView
			[ ] locator "@automationId='Add a custom view*'"
		[+] WPFMenuItem DeleteThisView
			[ ] locator "@automationId='Delete this view*'"
	[+] WPFMenuItem Bills
		[ ] locator "@automationId='_Bills'"
		[+] WPFMenuItem GoToBills
			[ ] locator "@automationId='Go to _Bills*'"
		[-] WPFMenuItem Upcoming
			[ ] locator "@automationId='    _Upcoming*'"
		[+] WPFMenuItem ProjectedBalances
			[ ] locator "@automationId='    _Projected Balances*'"
		[+] WPFMenuItem AddReminder
			[ ] locator "@automationId='_Add Reminder'"
			[+] WPFMenuItem BillReminder
				[ ] locator "@automationId='_Bill Reminder*'"
			[+] WPFMenuItem IncomeReminder
				[ ] locator "@automationId='_Income Reminder*'"
			[+] WPFMenuItem TransferReminder
				[ ] locator "@automationId='_Transfer Reminder*'"
			[+] WPFMenuItem PaycheckReminder
				[ ] locator "@automationId='_Paycheck Reminder*'"
			[+] WPFMenuItem InvoiceReminder
				[ ] locator "@automationId='_Invoice Reminder*'"
				[ ] 
		[+] WPFMenuItem ManageBillIncomeReminders
			[ ] locator "@automationId='Manage Bill & Income _Reminders*'"
	[+] WPFMenuItem Spending
		[ ] locator "@automationId='_Spending'"
		[+] WPFMenuItem GoToSpending
			[ ] locator "@automationId='Go to _Spending*'"
		[+] WPFMenuItem SpendingAndSavingsAccounts
			[ ] locator "@automationId='Spending and Savings _Accounts'"
			[+] WPFMenuItem AccountList
				[ ] locator "@automationId='_Account List*'"
			[+] WPFMenuItem AddAccount
				[ ] locator "@automationId='A_dd Account*'"
			[ ] 
		[+] WPFMenuItem SpendingReports
			[ ] locator "@automationId='Spending _Reports'"
			[+] WPFMenuItem ItemizedCategories
				[ ] locator "@automationId='Itemi_zed Categories*'"
			[+] WPFMenuItem ItemizedPayees
				[ ] locator "@automationId='Itemized Payees*'"
			[+] WPFMenuItem ItemizedTags
				[ ] locator "@automationId='Itemized _Tags*'"
			[+] WPFMenuItem SpendingByCategory
				[ ] locator "@automationId='Spen_ding by Category*'"
			[+] WPFMenuItem SpendingByPayee
				[ ] locator "@automationId='Spending by Payee*'"
			[+] WPFMenuItem CurrentSpendingVs1
				[ ] locator "@automationId='Current Spen_ding vs. Average Spending by Category*'"
			[+] WPFMenuItem CurrentSpendingVs2
				[ ] locator "@automationId='Current Spending vs. A_verage Spending by Payee*'"
			[+] WPFMenuItem IncomeAndExpenseByCategory
				[ ] locator "@automationId='_Income and Expense by Category*'"
			[+] WPFMenuItem IncomeAndExpenseByPayee
				[ ] locator "@automationId='Income and E_xpense by Payee*'"
			[+] WPFMenuItem CurrentBudget
				[ ] locator "@automationId='_Current Budget*'"
			[+] WPFMenuItem HistoricalBudget
				[ ] locator "@automationId='_Historical Budget*'"
			[ ] 
		[+] WPFMenuItem BankingReports
			[ ] locator "@automationId='Banking _Reports'"
			[+] WPFMenuItem BankingSummary
				[ ] locator "@automationId='Banking _Summary*'"
			[+] WPFMenuItem CashFlow
				[ ] locator "@automationId='Cash _Flow*'"
			[+] WPFMenuItem CashFlowByTag
				[ ] locator "@automationId='Cash Flow by Ta_g*'"
			[+] WPFMenuItem MissingChecks
				[ ] locator "@automationId='Missing Chec_ks*'"
			[+] WPFMenuItem Reconciliation
				[ ] locator "@automationId='_Reconciliation*'"
			[+] WPFMenuItem Transaction
				[ ] locator "@automationId='_Transaction*'"
			[ ] 
	[+] WPFMenuItem MobileAlerts
		[ ] locator "@automationId='_Mobile & Alerts'"
		[+] WPFMenuItem GoToMobileAlerts
			[ ] locator "@automationId='Go to _Mobile & Alerts*'"
	[+] WPFMenuItem TipsTutorials
		[ ] locator "@automationId='Tips & Tutoria_ls'"
		[+] WPFMenuItem GoToTipsTutorials
			[ ] locator "@automationId='Go to _Mobile & Alerts*'"
		[+] WPFMenuItem UsingQuicken
			[ ] locator "@automationId='    _Using Quicken*'"
		[+] WPFMenuItem QuickenServices
			[ ] locator "@automationId='    _Quicken Services*'"
	[+] WPFMenuItem Help
		[ ] locator "@automationId='_Help'"
		[+] WPFMenuItem GettingStartedGuide
			[ ] locator "@automationId='Getting Started _Guide*'"
		[+] WPFMenuItem QuickenHelp
			[ ] locator "@automationId='Quicken Help*'"
		[+] WPFMenuItem ResetGuidance
			[ ] locator "@automationId='Reset Guidance*'"
		[+] WPFMenuItem QuickenSupport
			[ ] locator "@automationId='Quicken Su_pport*'"
		[+] WPFMenuItem SubmitFeedbackOnQuicken
			[ ] locator "@automationId='Submit _Feedback on Quicken*'"
		[+] WPFMenuItem JoinTheQuickenInnerCircle
			[ ] locator "[227]"
		[+] WPFMenuItem PrivacyPreferences
			[ ] locator "@automationId='Pri_vacy Preferences*'"
		[+] WPFMenuItem LogFiles
			[ ] locator "@automationId='_Log Files*'"
		[+] WPFMenuItem AboutQuicken
			[ ] locator "@automationId='About _Quicken*'"
		[+] WPFMenuItem DownloadLatestVersion
			[ ] locator "@automationId='_Download Latest Version*'"
		[+] WPFMenuItem RegisterQuicken
			[ ] locator "@automationId='_Register Quicken*'"
		[+] WPFMenuItem QuickenLiveCommunity
			[ ] locator "@automationId='Quicken Li_ve Community*'"
	[+] WPFMenuItem PropertyDebt
		[ ] locator "@automationId='Property & _Debt'"
		[+] WPFMenuItem GoToPropertyDebt
			[ ] locator "@automationId='Go to Property & Debt*'"
		[+] WPFMenuItem NetWorth
			[ ] locator "@automationId='    _Net Worth*'"
		[+] WPFMenuItem Property
			[ ] locator "@automationId='    _Property*'"
		[+] WPFMenuItem Debt
			[ ] locator "@automationId='    _Debt*'"
		[+] WPFMenuItem PropertyDebtAccounts
			[ ] locator "@automationId='Property & Debt _Accounts'"
			[+] WPFMenuItem AccountList
				[ ] locator "@automationId='_Account List*'"
			[+] WPFMenuItem AddAccount
				[ ] locator "@automationId='A_dd Account*"
			[ ] 
		[+] WPFMenuItem AddANewLoan
			[ ] locator "@automationId='Add a new _Loan*'"
		[+] WPFMenuItem RefinanceCalculator
			[ ] locator "@automationId='_Refinance Calculator*'"
		[+] WPFMenuItem LoanCalculator
			[ ] locator "@automationId='_Loan Calculator*'"
		[+] WPFMenuItem DebtReductionPlanner
			[ ] locator "@automationId='_Debt Reduction Planner*'"
		[+] WPFMenuItem HomeInventoryManager
			[ ] locator "@automationId='Home _Inventory Manager*'"
		[+] WPFMenuItem ERO
			[ ] locator "@automationId='_Emergency Records Organizer*"
	[+] WPFMenuItem RentalProperty
		[ ] locator "@automationId='Re_ntal Property'"
		[+] WPFMenuItem GoToRentalProperty
			[ ] locator "@automationId='Go to _Rental Property*'"
		[+] WPFMenuItem RentCenter
			[ ] locator "@automationId='    _Rent Center*'"
		[+] WPFMenuItem ProfitLoss
			[ ] locator "@automationId='    _Profit*Loss*'"
		[+] WPFMenuItem AccountOverview
			[ ] locator "@automationId='    _Account Overview*'"
		[+] WPFMenuItem RentalPropertyAccounts
			[ ] locator "@automationId='Rental Property _Accounts'"
			[+] WPFMenuItem AccountList
				[ ] locator "@automationId='_Account List*'"
			[+] WPFMenuItem AddAccount
				[ ] locator "@automationId='A_dd Account*'"
		[+] WPFMenuItem EnterRent
			[ ] locator "@automationId='Enter _Rent*'"
		[+] WPFMenuItem EnterExpense
			[ ] locator "@automationId='Enter _Expense*'"
		[+] WPFMenuItem EnterOtherIncome
			[ ] locator "@automationId='Enter _Other Income*'"
		[+] WPFMenuItem MileageTracker
			[ ] locator "@automationId='_Mileage Tracker*'"
		[+] WPFMenuItem AddProperty
			[ ] locator "@automationId='Add _Property*'"
		[+] WPFMenuItem ShowPropertyList
			[ ] locator "@automationId='Show _Property List*'"
		[+] WPFMenuItem AddTenant
			[ ] locator "@automationId='Add _Tenant*'"
		[+] WPFMenuItem ShowTenantList
			[ ] locator "@automationId='Show _Tenant List*'"
		[+] WPFMenuItem RentalPropertyReports
			[ ] locator "@automationId='_Rental Property Reports'"
			[+] WPFMenuItem CashFlow
				[ ] locator "@automationId='_Cash Flow*'"
			[+] WPFMenuItem CashFlowComparison
				[ ] locator "@automationId='Cash _Flow Comparison*'"
			[+] WPFMenuItem ScheduleE
				[ ] locator "@automationId='Schedule _E-Supplemental Income and Loss*'"
			[+] WPFMenuItem TaxSchedule
				[ ] locator "@automationId='_Tax Schedule*'"
	[+] WPFMenuItem Business			
		[ ] locator "@automationId='B_usiness'"
		[+] WPFMenuItem GoToBusiness
			[ ] locator "@automationId='Go To _Business*'"
		[+] WPFMenuItem CashFlow				
			[ ] locator "@automationId='    _Cash Flow*'"
		[+] WPFMenuItem ProfitLoss
			[ ] locator "@automationId='    _Profit/Loss*'"
		[+] WPFMenuItem AccountOverview
			[ ] locator "@automationId='    _Account Overview*'"
		[+] WPFMenuItem BusinessAccounts
			[ ] locator "@automationId='Business _Accounts'"
			[+] WPFMenuItem AccountList
				[ ] locator "@automationId='_Account List*'"
			[+] WPFMenuItem AddAccount
				[ ] locator "@automationId='A_dd Account*'"
		[+] WPFMenuItem Customers
			[ ] locator "@automationId='_Customers'"
			[+] WPFMenuItem AddCustomer
				[ ] locator "@automationId='Add _Customer*'"
			[+] WPFMenuItem CreateProjectJob
				[ ] locator "@automationId='Create Project/_Job*'"
		[+] WPFMenuItem InvoicesAndEstimates
			[ ] locator "@automationId='_Invoices and Estimates'"
			[+] WPFMenuItem CreateInvoice
				[ ] locator "@automationId='Create _Invoice*'"
			[+] WPFMenuItem ReceiveACustomerPayment
				[ ] locator "@automationId='Receive a Customer _Payment*'"
			[+] WPFMenuItem IssueACredit
				[ ] locator "@automationId='Issue a _Credit*'"
			[+] WPFMenuItem IssueARefund
				[ ] locator "@automationId='Issue a _Refund*'"
			[+] WPFMenuItem CreateAFinanceCharge
				[ ] locator "@automationId='Create a _Finance Charge*'"
			[+] WPFMenuItem ViewAllInvoices
				[ ] locator "@automationId='_View All Invoices*'"
			[+] WPFMenuItem ReportMyAccountsReceivable
				[ ] locator "@automationId='Repor_t my accounts receivable*'"
			[+] WPFMenuItem PrintStatements
				[ ] locator "@automationId='Print _Statements*'"
			[+] WPFMenuItem CreateEstimate
				[ ] locator "@automationId='Create _Estimate*'"
			[+] WPFMenuItem ViewAllInvoiceItems
				[ ] locator "@automationId='View All Invoice I_tems*'"
			[+] WPFMenuItem ViewSavedCustomerMessages
				[ ] locator "@automationId='View saved customer _messages*'"
			[+] WPFMenuItem DesignInvoiceForms
				[ ] locator "@automationId='_Design Invoice Forms*'"
		[+] WPFMenuItem BillsAndVendors
			[ ] locator "@automationId='Bills and _Vendors'"
			[+] WPFMenuItem AddAVendor
				[ ] locator "@automationId='Add a _Vendor*'"
			[+] WPFMenuItem CreateBill
				[ ] locator "@automationId='Create _Bill*'"
			[+] WPFMenuItem MakePaymentToVendor
				[ ] locator "@automationId='Make _Payment to Vendor*'"
			[+] WPFMenuItem ReceiveACredit
				[ ] locator "@automationId='Receive a _Credit*'"
			[+] WPFMenuItem ReceiveARefund
				[ ] locator "@automationId='Receive a _Refund*'"
			[+] WPFMenuItem ReportMyAccountsPayable
				[ ] locator "@automationId='Repor_t my accounts payable*'"
		[+] WPFMenuItem ProjectJobList
			[ ] locator "@automationId='Project/_Job List*'"
		[+] WPFMenuItem EstimateList
			[ ] locator "@automationId='_Estimate List*'"
		[+] WPFMenuItem PrintInvoicesInvoicesList
			[ ] locator "@automationId='_Print Invoices/Invoices List*'"
		[+] WPFMenuItem UnpaidInvoicesList
			[ ] locator "@automationId='_Unpaid Invoices List*'"
		[+] WPFMenuItem ManageBusinessInformation
			[ ] locator "@automationId='_Manage Business Information*'"
		[+] WPFMenuItem MileageTracker
			[ ] locator "@automationId='_Mileage Tracker*'"
		[+] WPFMenuItem OnlineTools
			[ ] locator "@automationId='_Online Tools'"
			[+] WPFMenuItem SmallBusinessGuidance
				[ ] locator "@automationId='Small Business _Guidance*'"
		[+] WPFMenuItem BusinessServices
			[ ] locator "@automationId='Business _Services'"
			[+] WPFMenuItem ShowAllServices
				[ ] locator "@automationId='Show _All Services*'"
		[+] WPFMenuItem BusinessReports
			[ ] locator "@automationId='_Business Reports'"
			[+] WPFMenuItem AccountsPayable
				[ ] locator "@automationId='_Accounts Payable*'"
			[+] WPFMenuItem AccountsReceivable
				[ ] locator "@automationId='Accounts _Receivable*'"
			[+] WPFMenuItem BalanceSheet
				[ ] locator "@automationId='_Balance Sheet*'"
			[+] WPFMenuItem CashFlow
				[ ] locator "@automationId='_Cash Flow*'"
			[+] WPFMenuItem CashFlowComparison
				[ ] locator "@automationId='Cash _Flow Comparison*'"
			[+] WPFMenuItem MissingChecks
				[ ] locator "@automationId='_Missing Checks*'"
			[+] WPFMenuItem Payroll
				[ ] locator "@automationId='Pa_yroll*'"
			[+] WPFMenuItem ProfitAndLossComparison
				[ ] locator "@automationId='Profit and Loss Comparison*'"
			[+] WPFMenuItem ProfitAndLossStatement
				[ ] locator "@automationId='Profit and Loss Statement*'"
			[+] WPFMenuItem ProjectJobByBusinessTag
				[ ] locator "@automationId='Project/_Job by Business Tag*'"
			[+] WPFMenuItem ProjectJobByProject
				[ ] locator "@automationId='Project/J_ob by Project*'"
			[+] WPFMenuItem ScheduleCProfitOrLossFrom
				[ ] locator "@automationId='_Schedule C-Profit or Loss from Business*'"
			[+] WPFMenuItem TaxSchedule
				[ ] locator "@automationId='_Tax Schedule*'"
	[+] WPFMenuItem Investing
		[ ] locator "@automationId='_Investing'"
		[+] WPFMenuItem GoToInvesting
			[ ] locator "@automationId='Go to Investing*'"
		[+] WPFMenuItem Portfolio
			[ ] locator "@automationId='    _Portfolio*'"
		[+] WPFMenuItem Performance
			[ ] locator "@automationId='    _Performance*'"
		[+] WPFMenuItem Allocations
			[ ] locator "@automationId='    _Allocations*'"
		[+] WPFMenuItem InvestingAccounts
			[ ] locator "@automationId='Investing _Accounts'"
			[+] WPFMenuItem AccountList
				[ ] locator "@automationId='_Account List*'"
			[+] WPFMenuItem AddAccount
				[ ] locator "@automationId='A_dd Account*'"
		[+] WPFMenuItem MemorizedInvestmentTransaction
			[ ] locator "@automationId='_Memorized Investment Transactions*'"
		[+] WPFMenuItem SecurityList
			[ ] locator "@automationId='Security List*'"
		[+] WPFMenuItem DownloadActivity
			[ ] locator "@automationId='Dow_nload Activity'"
			[+] WPFMenuItem Quotes
				[ ] locator "@automationId='Quotes*'"
			[+] WPFMenuItem HistoricalPrices
				[ ] locator "@automationId='_Historical Prices*'"
			[+] WPFMenuItem UpdatePortfolioOnQuicken
				[ ] locator "@automationId='_Update Portfolio on investing.quicken.com*'"
			[+] WPFMenuItem OneStepUpdate
				[ ] locator "@automationId='One Step _Update*'"
			[ ] 
		[+] WPFMenuItem InvestingTools
			[ ] locator "@automationId='Investing _Tools'"
			[+] WPFMenuItem AssetAllocationGuide 
				[ ] locator "@automationId='Asset Alloca_tion Guide*'"
			[+] WPFMenuItem BuySellPreview
				[ ] locator "@automationId='Buy*Sell _Preview*'"
			[+] WPFMenuItem CapitalGainsEstimator
				[ ] locator "@automationId='Capital _Gains Estimator*'"
			[+] WPFMenuItem PortfolioAnalyzer
				[ ] locator "@automationId='Port_folio Analyzer*'"
			[+] WPFMenuItem SecurityDetailView
				[ ] locator "@automationId='Security Detail View*'"
		[+] WPFMenuItem OnlineResearch
			[ ] locator "@automationId='_Online Portfolio*'"
		[+] WPFMenuItem InvestingReports
			[ ] locator "@automationId='In_vesting Reports'"
			[+] WPFMenuItem CapitalGains
				[ ] locator "@automationId='Capital Gains*'"
			[+] WPFMenuItem InvestingActivity
				[ ] locator "@automationId='Investing A_ctivity*'"
			[+] WPFMenuItem InvestmentAssetAllocation
				[ ] locator "@automationId='Investment _Asset Allocation*'"
			[+] WPFMenuItem InvestmentIncome
				[ ] locator "@automationId='Investment _Income*'"
			[+] WPFMenuItem InvestmentPerformance
				[ ] locator "@automationId='Investment _Performance*'"
			[+] WPFMenuItem InvestmentTransactions
				[ ] locator "@automationId='Investment _Transactions*'"
			[+] WPFMenuItem MaturityDatesForBondsAndC
				[ ] locator "@automationId='_Maturity Dates for Bonds and CDs*'"
			[+] WPFMenuItem PortfolioValue
				[ ] locator "@automationId='Portfolio _Value*'"
			[+] WPFMenuItem PortfolioValueCostBasis
				[ ] locator "@automationId='Portfolio Value & Cost _Basis*'"
			[ ] 
	[+] WPFMenuItem Planning
		[ ] locator "@automationId='_Planning'"
		[+] WPFMenuItem GoToPlanning
			[ ] locator "@automationId='Go to _Planning*'"
		[+] WPFMenuItem LifetimePlanner
			[ ] locator "@automationId='    _Lifetime Planner*'"
		[+] WPFMenuItem TaxCenter
			[ ] locator "@automationId='    _Tax Center*'"
		[+] WPFMenuItem SavingsGoals
			[ ] locator "@automationId='    _Savings Goals*'"
		[+] WPFMenuItem UpdatePlanningAssumptions
			[ ] locator "@automationId='Update Planning _Assumptions'"
			[+] WPFMenuItem AboutYou
				[ ] locator "@automationId='_About You*'"
			[+] WPFMenuItem Income
				[ ] locator "@automationId='_Income*''"
			[+] WPFMenuItem TaxRate
				[ ] locator "@automationId='_Tax Rate*'"
			[+] WPFMenuItem InflationRate
				[ ] locator "@automationId='_Inflation Rate*'"
			[+] WPFMenuItem SavingsInvestments   
				[ ] locator "@automationId='_Savings & Investments*'"
			[+] WPFMenuItem HomesAssets
				[ ] locator "@automationId='_Home & Assets*'"
			[+] WPFMenuItem LoansDebt
				[ ] locator "@automationId='_Loans & Debt*'"
			[+] WPFMenuItem Expenses
				[ ] locator "@automationId='_Expenses*'"
			[ ] 
		[+] WPFMenuItem Budget
			[ ] locator "@automationId='    _Budgets*'"
		[+] WPFMenuItem ProjectedBalances
			[ ] locator "@automationId='_Projected Balances*'"
		[+] WPFMenuItem DebtReductionPlanner
			[ ] locator "@automationId='    _Debt Reduction*'"
		[+] WPFMenuItem Calculators
			[ ] locator "@automationId='Calc_ulators'"
			[+] WPFMenuItem RetirementCalculator
				[ ] locator "@automationId='Retire_ment Calculator*'"
			[+] WPFMenuItem CollegeCalculator
				[ ] locator "@automationId='_College Calculator*'"
			[+] WPFMenuItem RefinanceCalculator
				[ ] locator "@automationId='_Refinance Calculator*'"
			[+] WPFMenuItem SavingsCalculator
				[ ] locator "@automationId='_Savings Calculator*'"
			[+] WPFMenuItem LoanCalculator
				[ ] locator "@automationId='_Loan Calculator*'"
		[+] WPFMenuItem TaxPlanner
			[ ] locator "@automationId='Tax _Planner*'"
		[+] WPFMenuItem DeductionFinder
			[ ] locator "@automationId='_Deduction Finder*'"
		[+] WPFMenuItem ItemizedDeductionEstimator
			[ ] locator "@automationId='_Itemized Deduction Estimator*'"
		[+] WPFMenuItem CapitalGainsEstimator
			[ ] locator "@automationId='Capital _Gains Estimator*'"
		[+] WPFMenuItem TaxWithholdingEstimator
			[ ] locator "@automationId='Tax Wit_hholding Estimator*'"
		[+] WPFMenuItem OnlineTaxTools
			[ ] locator "@automationId='_Online Tax Tools'"
			[+] WPFMenuItem TaxCalculatorsAndCommonTax
				[ ] locator "@automationId='_Tax Calculators and Common Tax Questions*'"
			[+] WPFMenuItem TaxFormsAndPublications
				[ ] locator "@automationId='Tax _Forms and Publications*'"
			[ ] 
		[+] WPFMenuItem TurboTax
			[ ] locator "@automationId='_TurboTax'"
			[+] WPFMenuItem FileYourTaxesWithTurboTax
				[ ] locator "@automationId='_TurboTax*'"
			[+] WPFMenuItem ImportTurboTaxFile
				[ ] locator "@automationId='_Import TurboTax File*'"
			[+] WPFMenuItem ExportTurboTaxTaxScheduleR
				[ ] locator "@automationId='Export TurboTax tax schedule report*'"
			[+] WPFMenuItem ExportTurboTaxCapitalGains
				[ ] locator "@automationId='Export TurboTax capital gains report*'"
			[ ] 
		[+] WPFMenuItem SpendingReports
			[ ] locator "@automationId='Spending Reports'"
			[+] WPFMenuItem ItemizedCategories
				[ ] locator "@automationId='Itemi_zed Categories*'"
			[+] WPFMenuItem ItemizedPayees
				[ ] locator "@automationId='Itemized Payees*'"
			[+] WPFMenuItem ItemizedTags
				[ ] locator "@automationId='Itemized _Tags*'"
			[+] WPFMenuItem SpendingByCategory
				[ ] locator "@automationId='Spen_ding by Category*'"
			[+] WPFMenuItem SpendingByPayee
				[ ] locator "@automationId='Spending by Payee*'"
			[+] WPFMenuItem CurrentSpendingVs1
				[ ] locator "@automationId='Current Spen_ding vs. Average Spending by Category*'"
			[+] WPFMenuItem CurrentSpendingVs2
				[ ] locator "@automationId='Current Spending vs. A_verage Spending by Payee*'"
			[+] WPFMenuItem IncomeAndExpenseByCategory
				[ ] locator "@automationId='_Income and Expense by Category*'"
			[+] WPFMenuItem IncomeAndExpenseByPayee
				[ ] locator "@automationId='Income and E_xpense by Payee*'"
			[+] WPFMenuItem CurrentBudget
				[ ] locator "@automationId='_Current Budget*'"
			[+] WPFMenuItem HistoricalBudget
				[ ] locator "@automationId='_Historical Budget*'"
			[ ] 
	[+] WPFMenuItem Reports
		[ ] locator "@automationId='_Reports'"
		[+] WPFMenuItem Banking
			[ ] locator "@automationId='Ban_king'"
			[+] WPFMenuItem BankingSummary
				[ ] locator "@automationId='Banking _Summary*'"
			[+] WPFMenuItem CashFlow
				[ ] locator "@automationId='Cash _Flow*'"
			[+] WPFMenuItem CashFlowByTag
				[ ] locator "@automationId='Cash Flow by Ta_g*'"
			[+] WPFMenuItem MissingChecks
				[ ] locator "@automationId='Missing Chec_ks*'"
			[+] WPFMenuItem Reconciliation
				[ ] locator "@automationId='_Reconciliation*'"
			[+] WPFMenuItem Transaction
				[ ] locator "@automationId='_Transaction*'"
		[+] WPFMenuItem Comparison
			[ ] locator "@automationId='Comparison'"
			[+] WPFMenuItem CurrentVsAverageSpendingByCategory
				[ ] locator "@automationId='Current Spen_ding vs. Average Spending by Category*'"
			[+] WPFMenuItem CurrentVsAverageSpendingByPayee
				[ ] locator "@automationId='Current Spending vs. A_verage Spending by Payee*'"
			[+] WPFMenuItem CashFlowComparison
				[ ] locator "@automationId='_Cash Flow Comparison*'"
			[+] WPFMenuItem IncomeAndExpenseComparison1
				[ ] locator "@automationId='Income and _Expense Comparison by Category*'"
			[+] WPFMenuItem IncomeAndExpenseComparison2
				[ ] locator "@automationId='Income and Expense Comparison by _Payee*'"
			[+] WPFMenuItem ProfitAndLoss                                                           
				[ ] locator "@automationId='Profit and Loss Comparison*'"
			[ ] 
		[+] WPFMenuItem Spending
			[ ] locator "@automationId='_Spending'"
			[+] WPFMenuItem ItemizedCategories
				[ ] locator "@automationId='Itemi_zed Categories*'"
			[+] WPFMenuItem ItemizedPayees
				[ ] locator "@automationId='Itemized Payees*'"
			[+] WPFMenuItem ItemizedTags
				[ ] locator "@automationId='Itemized _Tags*'"
				[ ] 
			[+] WPFMenuItem SpendingByCategory
				[ ] locator "@automationId='Spen_ding by Category*'"
			[+] WPFMenuItem SpendingByPayee
				[ ] locator "@automationId='Spending by Payee*'"
			[+] WPFMenuItem CurrentVsAverageSpendingByCategory
				[ ] locator "@automationId='Current Spen_ding vs. Average Spending by Category*'"
			[+] WPFMenuItem CurrentVsAverageSpendingByPayee
				[ ] locator "@automationId='Current Spending vs. A_verage Spending by Payee*'"
			[+] WPFMenuItem IncomeAndExpenseByCategory
				[ ] locator "@automationId='_Income and Expense by Category*'"
			[+] WPFMenuItem IncomeAndExpenseByPayee
				[ ] locator "@automationId='Income and E_xpense by Payee*'"
			[+] WPFMenuItem CurrentBudget
				[ ] locator "@automationId='_Current Budget*'"
			[+] WPFMenuItem HistoricalBudget
				[ ] locator "@automationId='_Historical Budget*'"
		[+] WPFMenuItem Tax
			[ ] locator "@automationId='_Tax'"
			[+] WPFMenuItem CapitalsGains
				[ ] locator "@automationId='Capital Gains*'"
			[+] WPFMenuItem ScheduleAItemizedDeductions
				[ ] locator "@automationId='Schedule _A-Itemized Deductions*'"
			[+] WPFMenuItem ScheduleBInterestAndDivide
				[ ] locator "@automationId='Schedule _B-Interest and Dividends*'"
			[+] WPFMenuItem ScheduleDCapitalGainsAndL
				[ ] locator "@automationId='Schedule _D-Capital Gains and Losses*'"
			[+] WPFMenuItem TaxSchedule
				[ ] locator "@automationId='Tax _Schedule*'"
			[+] WPFMenuItem TaxSummary
				[ ] locator "@automationId='_Tax Summary*'"
		[+] WPFMenuItem RentalProperty
			[ ] locator "@automationId='Re_ntal Property'"
			[+] WPFMenuItem CashFlow
				[ ] locator "@automationId='_Cash Flow*'"
			[+] WPFMenuItem CashFlowComparison
				[ ] locator "@automationId='Cash _Flow Comparison*'"
			[+] WPFMenuItem ScheduleE
				[ ] locator "@automationId='Schedule _E-Supplemental Income and Loss*'"
			[+] WPFMenuItem TaxSchedule
				[ ] locator "@automationId='_Tax Schedule*'"
		[+] WPFMenuItem EasyAnswer
			[ ] locator "@automationId='Easy_Answer*'"
		[+] WPFMenuItem Graphs
			[ ] locator "@automationId='Gra_phs'"
			[+] WPFMenuItem SpendingByCategory
				[ ] locator "@automationId='Spen_ding by Category*'"
			[+] WPFMenuItem SpendingByPayee
				[ ] locator "@automationId='Spending by Payee*'"
			[+] WPFMenuItem CurrentSpendingVsAverageS1
				[ ] locator "@automationId='Current Spen_ding vs. Average Spending by Category*'"
			[+] WPFMenuItem CurrentSpendingVsAverageS2
				[ ] locator "@automationId='Current Spending vs. A_verage Spending by Payee*'"
			[+] WPFMenuItem IncomeAndExpenseByCategory
				[ ] locator "@automationId='_Income and Expense by Category*'"
			[+] WPFMenuItem IncomeAndExpenseByPayee
				[ ] locator "@automationId='Income and E_xpense by Payee*'"
			[+] WPFMenuItem CurrentBudget
				[ ] locator "@automationId='_Current Budget*'"
			[+] WPFMenuItem HistoricalBudget
				[ ] locator "@automationId='_Historical Budget*'"
			[+] WPFMenuItem InvestmentAssetAllocation
				[ ] locator "@automationId='Investment _Asset Allocation*'"
			[+] WPFMenuItem InvestmentPerformance
				[ ] locator "@automationId='Investment _Performance*'"
			[+] WPFMenuItem PortfolioValuesCostBasis
				[ ] locator "@automationId='Portfolio Value & Cost _Basis*'"
			[+] WPFMenuItem AccountBalances
				[ ] locator "@automationId='_Account Balances*'"
			[+] WPFMenuItem NetWorth
				[ ] locator "@automationId='_Net Worth*'"
			[ ] 
		[+] WPFMenuItem MySavedReportsGraphs
			[ ] locator "@automationId='My _Saved Reports & Graphs'"
			[+] WPFMenuItem Report1		
				[ ] locator "My Transaction Report*"
			[+] WPFMenuItem Report2	
				[ ] locator "My Itemized Payees*"
			[+] WPFMenuItem Report3		
				[ ] locator "Account Balances_*_Premier*"
			[ ] 
		[+] WPFMenuItem ReportsGraphsCenter
			[ ] locator "@automationId='_Reports & Graphs Center*'"
		[+] WPFMenuItem Investing
			[ ] locator "@automationId='_Investing'"
			[+] WPFMenuItem CapitalGains
				[ ] locator "@automationId='Capital Gains*'"
			[+] WPFMenuItem InvestingActivity
				[ ] locator "@automationId='Investing A_ctivity*'"
			[+] WPFMenuItem InvestmentAssetAllocation
				[ ] locator "@automationId='Investment _Asset Allocation*'"
			[+] WPFMenuItem InvestmentIncome
				[ ] locator "@automationId='Investment _Income*'"
			[+] WPFMenuItem InvestmentPerformance
				[ ] locator "@automationId='Investment _Performance*'"
			[+] WPFMenuItem InvestmentTransactions
				[ ] locator "@automationId='Investment _Transactions*'"
			[+] WPFMenuItem MaturityDatesForBondsAndC
				[ ] locator "@automationId='_Maturity Dates for Bonds and CDs*'"
			[+] WPFMenuItem PortfolioValue
				[ ] locator "@automationId='Portfolio _Value*'"
			[+] WPFMenuItem PortfolioValueCostBasis
				[ ] locator "@automationId='Portfolio Value & Cost _Basis*'"
		[+] WPFMenuItem NetWorthBalances
			[ ] locator "@automationId='Net W_orth & Balances'"
			[+] WPFMenuItem AccountBalances
				[ ] locator "@automationId='_Account Balances*'"
			[+] WPFMenuItem NetWorth
				[ ] locator "@automationId='_Net Worth*'"
		[+] WPFMenuItem Business
			[ ] locator "@automationId='B_usiness'"
			[+] WPFMenuItem AccountsPayable
				[ ] locator "@automationId='_Accounts Payable*'"
			[+] WPFMenuItem AccountsReceivable
				[ ] locator "@automationId='Accounts _Receivable*'"
			[+] WPFMenuItem BalanceSheet
				[ ] locator "@automationId='_Balance Sheet*'"
			[+] WPFMenuItem CashFlow
				[ ] locator "@automationId='_Cash Flow*'"
			[+] WPFMenuItem CashFlowComparison
				[ ] locator "@automationId='Cash _Flow Comparison*'"
			[+] WPFMenuItem MissingChecks
				[ ] locator "@automationId='_Missing Checks*'"
			[+] WPFMenuItem Payroll
				[ ] locator "@automationId='Pa_yroll*'"
			[+] WPFMenuItem ProfitAndLossComparison
				[ ] locator "@automationId='Profit and Loss Comparison*'"
			[+] WPFMenuItem ProfitAndLossStatement
				[ ] locator "@automationId='Profit and Loss Statement*'"
			[+] WPFMenuItem ProjectJobByBusinesstag
				[ ] locator "@automationId='Project*_Job by Business Tag*'"
			[+] WPFMenuItem ProjectJobByProject
				[ ] locator "@automationId='Project*J_ob by Project*'"
			[+] WPFMenuItem ScheduleC
				[ ] locator "@automationId='_Schedule C*Profit or Loss from Business*'"
			[+] WPFMenuItem TaxSchedule
				[ ] locator "@automationId='_Tax Schedule*'"
		[ ] 
	[+] WPFMenuItem Debug
		[ ] locator "@automationId='Debug'"
		[+] WPFMenuItem SignOut
			[ ] locator "@automationId='SignOut - Invalidate Refresh and Access Tokens'"
		[ ] 
	[ ] 
	[+] MainWin QuickenBackup
		[ ] locator "Quicken Backup"
		[+] DialogBox DuplicateBackupFile
			[ ] locator "Quicken 20*"
			[+] StaticText ThereIsAFileWithTheSame
				[ ] locator "@windowid='65535'"
			[+] CheckBox DonTShowAgain
				[ ] locator "@windowid='242'"
			[+] PushButton Yes
				[ ] locator "@windowid='32767'"
			[+] PushButton CancelButton
				[ ] locator "@windowid='32766'"
			[ ] 
		[ ] 
		[+] PushButton Backup
			[ ] locator "@windowid='32767'"
		[+] Control Exit
			[ ] locator "@windowid='32762'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton Control32765
			[ ] locator "@windowid='32765'"
		[+] StaticText DoYouWantToBackUpThisDa
			[ ] locator "@windowid='101'"
		[+] StaticText QuickenStronglyRecommendsTh
			[ ] locator "@windowid='65535'"
		[+] StaticText YourLastBackupWasNoBack
			[ ] locator "@windowid='100'"
		[+] CheckBox DonTShowAgain
			[ ] locator "@windowid='102'"
		[ ] 
		[ ] 
	[+] DialogBox Quicken2012FileAttribute
		[+] locator "Quicken 20*"
			[+] StaticText QuickenMainWindow
				[ ] locator "@windowid='113'"
			[+] Group FileInformation
				[ ] locator "File Information"
			[+] StaticText SizeOfQDFFile
				[ ] locator "Size of QDF file:"
			[+] StaticText SizeOfQDFFileVal
				[ ] locator "@windowid='118'"
			[+] StaticText Accounts
				[ ] locator "Accounts:"
			[+] StaticText AccountsVal
				[ ] locator "@windowid='102'"
			[+] StaticText Categories
				[ ] locator "Categories:"
			[+] StaticText CategoriesVal
				[ ] locator "@windowid='114'"
			[+] StaticText MemorizedPayees
				[ ] locator "Memorized Payees*"
			[+] StaticText MemorizedPayeesVal
				[ ] locator "@windowid='117'"
			[+] StaticText Securities
				[ ] locator "Securities:"
			[+] StaticText SecuritiesVal
				[ ] locator "@windowid='116'"
			[+] StaticText Transactions
				[ ] locator "Transactions:"
			[+] StaticText TransactionsVal
				[ ] locator "@windowid='115'"
			[+] Group SystemResources
				[ ] locator "System Resources"
			[+] StaticText AvailableMemory
				[ ] locator "Available memory*"
			[+] StaticText AvailableMemoryVal
				[ ] locator "@windowid='101'"
			[+] StaticText TotalMemory
				[ ] locator "Total memory*"
			[+] StaticText TotalMemoryVal
				[ ] locator "@windowid='100'"
			[+] PushButton OK
				[ ] locator "@windowid='32767'"
			[ ] 
		[ ] 
	[+] MainWin AddBrokerageAccount
		[ ] locator "Add * Account"
		[+]  MainWin QuickenAccountSetup
			[ ] locator "Quicken Account Setup"
			[+] StaticText WhatSecuritiesAreInThisAc
				[ ] locator "What securities are in this account*"
			[+] StaticText EnterATickerSymbolForEach
				[ ] locator "Enter a ticker symbol for each security in your account*"
			[+] Control QWListViewer
				[ ] locator "@windowClassName='QWListViewer'"
			[+] ListBox Security
				[ ] locator "If you are not connected to the Internet, just enter a security name.  You can add more details later."
			[+] TextField IfYouAreNotConnectedToTheInterTextField
				[ ] locator "If you are not connected to the Internet, just enter a security name.  You can add more details later."
			[+] Control TickerSymbolLookup
				[ ] locator "Ticker Symbol Lookup"
			[+] Control AddMore
				[ ] locator "Add More*"
			[+] PushButton Next
				[ ] locator "@windowid='32764'"
			[+] PushButton Cancel
				[ ] locator "Cancel"
			[+] Control Done
				[ ] locator "Done"
			[ ] //------Add An Account > Brokerage Account > Security list setup[No Security] > No Security Alert----------------
			[+] DialogBox NoSecurityAlert
				[ ] locator "Quicken 20*"
				[+] StaticText YouHaveNotEnteredAnySecurities
					[ ] locator "You have not entered any securities.  Are you sure you want to create this account without any security holdings?"
				[+] PushButton Yes
					[ ] locator "Yes"
				[+] PushButton No
					[ ] locator "No"
			[ ] 
		[ ] 
	[+] // DialogBox Quicken2012FileAttribute
		[+] // locator "Quicken 201?*"
			[+] // StaticText QuickenMainWindow
				[ ] // locator "@windowid='113'"
			[+] // Group FileInformation
				[ ] // locator "File Information"
			[+] // StaticText SizeOfQDFFile
				[ ] // locator "Size of QDF file:"
			[+] // StaticText SizeOfQDFFileVal
				[ ] // locator "@windowid='118'"
			[+] // StaticText Accounts
				[ ] // locator "Accounts:"
			[+] // StaticText AccountsVal
				[ ] // locator "@windowid='102'"
			[+] // StaticText Categories
				[ ] // locator "Categories:"
			[+] // StaticText CategoriesVal
				[ ] // locator "@windowid='114'"
			[+] // StaticText MemorizedPayees
				[ ] // locator "Memorized Payees:"
			[+] // StaticText MemorizedPayeesVal
				[ ] // locator "@windowid='117'"
			[+] // StaticText Securities
				[ ] // locator "Securities:"
			[+] // StaticText SecuritiesVal
				[ ] // locator "@windowid='116'"
				[+] // multitag "*"
					[ ] // "$116"
			[+] // StaticText Transactions
				[ ] // locator "Transactions:"
			[+] // StaticText TransactionsVal
				[ ] // locator "@windowid='115'"
			[+] // Group SystemResources
				[ ] // locator "System Resources"
			[+] // StaticText AvailableMemory
				[ ] // locator "Available memory:"
			[+] // StaticText AvailableMemoryVal
				[ ] // locator "@windowid='101'"
			[+] // StaticText TotalMemory
				[ ] // locator "Total memory:"
			[+] // StaticText TotalMemoryVal
				[ ] // locator "@windowid='100'"
			[+] // PushButton OK
				[ ] // locator "@windowid='32767'"
			[ ] // 
		[ ] // 
	[+] MainWin QuickenAccountSetup
		[ ] locator "Quicken Account Setup"
		[+] StaticText WhatSecuritiesAreInThisAc
			[ ] locator "What securities are in this account?"
		[+] StaticText EnterATickerSymbolForEach
			[ ] locator "Enter a ticker symbol for each security in your account."
		[+] Control QWListViewer
			[ ] locator "@windowClassName='QWListViewer'"
		[+] ListBox Security
			[ ] locator "If you are not connected to the Internet, just enter a security name.  You can add more details later."
		[+] TextField IfYouAreNotConnectedToTheInterTextField
			[ ] locator "If you are not connected to the Internet, just enter a security name.  You can add more details later."
		[+] Control TickerSymbolLookup
			[ ] locator "Ticker Symbol Lookup"
		[+] Control AddMore
			[ ] locator "Add More*"
		[+] PushButton Next
			[ ] locator "Next"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] Control Done
			[ ] locator "Done"
		[ ] //------Add An Account > Brokerage Account > Security list setup[No Security] > No Security Alert----------------
		[+] DialogBox NoSecurityAlert
			[ ] locator "Quicken 201*"
			[+] StaticText YouHaveNotEnteredAnySecurities
				[ ] locator "You have not entered any securities.  Are you sure you want to create this account without any security holdings?"
			[+] PushButton Yes
				[ ] locator "Yes"
			[+] PushButton No
				[ ] locator "No"
		[ ] 
	[+] DialogBox QIFImport
		[ ] locator "QIF Import"
		[+] PushButton Done
			[ ] locator "Done"
	[+] MainWin AccountPopUp
		[ ] locator "//MainWin[@caption='*Account*']"
		[+] MainWin DlgVerifyCashBalance
			[ ] locator "//MainWin[@caption='Verify Cash Balance']"
			[+] TextField OnlineBalanceTextField
				[ ] locator "@windowid='2007'"
			[+] PushButton Done
				[ ] locator "@windowid='32767'"
	[+] Control CalloutHolder
		[ ] locator "Callout Holder"
		[+] Control ReminderHolder
			[ ] locator "[@windowClassName='INTU_CalloutPopup']"
			[+] PushButton Close
				[ ] locator "Close"
	[+] WPFButton Done
		[ ] locator "Done"
	[+] WPFRadioButton RestoreaDataFile
		[ ] locator "Restore a data file I've backed up to a CD, to a disk, or online"
	[+] WPFRadioButton CreateNewDataFileRB
		[ ] locator "Start over and create a new data file"
	[+] WPFRadioButton OpenDataFileRB
		[ ] locator "Open a data file located on this computer"
	[ ] 
	[+] WPFButton GetStarted
		[ ] locator "Get Started"
	[+] DialogBox ExistingDialogBox
		[ ] locator "//DialogBox"
		[ ] 
	[+] MainWin ExistingMainWin
		[ ] locator "//MainWin"
		[ ] 
	[ ] 
	[ ] //Added By Abhishek
	[+] DialogBox InterestRate
		[ ] locator "Interest Rate"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] StaticText InterestRate
			[ ] locator "Interest Rate"
		[+] StaticText InterestRateForThisAccountIfApplicable
			[ ] locator "Interest rate for this account, if applicable:"
		[+] TextField InterestRateForThisAccountIfApplicableTextField
			[ ] locator "Interest rate for this account, if applicable:"
		[+] PushButton OK
			[ ] locator "OK"
		[ ] //Added By Abhishek
	[+] DialogBox CreditLimit
		[ ] locator "Credit Limit"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] StaticText CreditLimit
			[ ] locator "Credit Limit"
		[+] StaticText CreditLimitForThisAccountIfApplicable
			[ ] locator "Credit limit for this account, if applicable:"
		[+] TextField CreditLimitForThisAccountIfApplicableTextField
			[ ] locator "Credit limit for this account, if applicable:"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton PushButton
			[ ] locator "[3]"
		[+] PushButton PushButton4
			[ ] locator "[4]"
	[ ] 
	[ ] 
[+] window MainWin Incorrect_QuickenMainWin
	[ ] locator "Quicken 20*"
[+] window MainWin QuickenMainWindow
	[ ] // locator "Quicken 201*"
	[ ] locator "/Control[@caption='Quicken 201*']"
	[-] Control QWNavigator
		[ ] // locator "@windowid='202'"
		[ ] locator "@windowClassName='QWNavigator'"
		[+] PushButton Home
			[ ] locator "Home"
		[+] PushButton Spending
			[ ] locator "Spending"
		[+] PushButton Bills
			[ ] locator "Bills"
		[+] PushButton Planning
			[ ] locator "Planning"
		[+] PushButton RentalProperty
			[ ] locator "@windowid='32307'"
		[+] PushButton TipsTutorials
			[ ] locator "@windowid='32309'"
		[+] PushButton MainView
			[ ] locator "@windowid='10000'"
		[+] PushButton AddView
			[ ] locator "@windowid='10140'"
		[+] PushButton AccountExpand
			[ ] locator "@windowid='11000'"
		[+] PushButton Accounts
			[ ] locator "@windowid='11001'"
		[+] PushButton Update_Accounts												
			[ ] locator "@windowid='11002'"
		[+] PushButton Customize
			[ ] locator "@windowid='11004'"
		[+] StaticText StaticText1
			[ ] locator "@windowid='400'"
		[+] Control QWNavBtnTray
			[ ] locator "@windowid='300'"
			[+] Control QWAcctBarHolder
				[ ] locator "@windowid='1000'"
				[+] PushButton Banking
					[ ] locator "@windowid='2101'"
				[+] Control QWListViewer1
					[ ] locator "@windowid='2201'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
				[+] PushButton RentalProperty
					[ ] locator "@windowid='2102'"
				[+] Control QWListViewer2
					[ ] locator "@windowid='2202'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
				[+] PushButton Business
					[ ] locator "@windowid='2103'"
				[+] Control QWListViewer3
					[ ] locator "@windowid='2203'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
				[+] PushButton Investing
					[ ] locator "@windowid='2104'"
				[+] PushButton SavingsGoals
					[ ] locator "@windowid='2106'"
				[+] Control QWListViewer4
					[ ] locator "@windowid='2204'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
				[+] PushButton PropertyDebt
					[ ] locator "@windowid='2105'"
				[+] Control QWListViewer5
					[ ] locator "@windowid='2205'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
				[+] PushButton AllTransactions
					[ ] locator "@windowid='2000'"
				[+] Control QWListViewer6
					[ ] locator "@windowid='2206'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
				[+] PushButton Separate
					[ ] locator "@windowid='2107'"
				[+] Control QWListViewer7
					[ ] locator "@windowid='2207'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
				[+] VerticalScrollBar VerticalScrollBarOnAccountBar
					[ ] locator "//VerticalScrollBar"
				[ ] 
			[+] PushButton NetWorth
				[ ] locator "@windowid='1002'"
				[+] // DefinedWin Tets
					[ ] // locator "(3,1-182,25)"
			[+] PushButton AddAnAccount
				[ ] locator "@windowid='1005'"
		[+] MenuItem CurrentBalance		//Added by Jayashree, 13-May-2014
			[ ] locator "Show Current Balance in Account Bar"
		[+] MenuItem EndingBalance		//Added by Jayashree, 13-May-2014
			[ ] locator "Show Ending Balance in Account Bar"
		[+] MenuItem SavingsGoalRegisterAndReports				//Added by Jayashree, 21-May-2014
			[ ] locator "Show Savings Goal transactions in register and reports" 	
		[ ] 
		[+] Control QSideBar
			[ ] locator "@windowid='-1'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1000'"
			[+] StaticText StaticText1
				[ ] locator "@windowid='1001'"
			[+] Control QWPanel
				[ ] locator "@windowid='-1'"
				[+] StaticText DownloadTransaction
					[ ] locator "@windowid='1000'"
				[+] PushButton OneStepUpdate
					[ ] locator "@windowid='1001'"
		[+] PushButton AddReminder
			[ ] locator "@windowid='10140'"
		[+] PushButton ManageReminders
			[ ] locator "@windowid='10141'"
		[+] PushButton Investing
			[ ] locator "@windowid='32304'"
		[+] PushButton PropertyDebt
			[ ] locator "@windowid='32305'"
		[+] PushButton Business
			[ ] locator "Business"
		[+] PushButton Budgets
			[ ] locator "@windowid='10000'"
		[+] PushButton MobileAlerts
			[ ] locator "@windowid='32309'"
		[+] PushButton QuickenMobile				
			[ ] locator "@windowid='10000'"
		[+] PushButton Portfolio
			[ ] locator "Portfolio"
			[ ] // locator "@windowid='10000'"
		[+] PushButton Performance
			[ ] locator "Performance"
			[ ] // locator "@windowid='10001'"
		[+] PushButton DebtReduction
			[ ] locator "@windowid='10001'"
		[+] PushButton Allocations
			[ ] locator "Allocations"
			[ ] // locator "@windowid='10002'"
		[+] PushButton Transactions
			[ ] locator "Transactions"
		[+] PushButton AllTransactions
			[ ] locator "All Transactions"
		[-] PushButton OnlineBills
			[ ] locator "@caption='Online Bills' or @windowid='10000'"
		[-] PushButton Upcoming
			[ ] locator "@caption='Bill Reminders' or @windowid='10001'"
		[-] PushButton ProjectedBalances
			[ ] locator "Projected Balances"
		[+] PushButton LifetimePlanner
			[ ] locator "Lifetime Planner"
		[+] PushButton TaxCenter
			[ ] locator "Tax Center"
		[+] PushButton SavingGoals		
			[ ] locator "Savings Goals"									// Added by Udita on 12 June 2012
		[+] PushButton NetWorth
			[ ] locator "Net Worth"
		[+] PushButton DebtAccountOverview
			[ ] locator "Account Overview"
		[+] PushButton Debt
			[ ] locator "Debt"
		[+] PushButton BusinessProfitLoss
			[ ] locator  "Profit?Loss"
		[+] PushButton RentCenter
			[ ] locator "Rent Center"
		[+] PushButton ProfitLoss
			[ ] locator  "Profit?Loss"
		[+] PushButton AccountOverview
			[ ] locator"Account Overview"
		[+] PushButton PropertyTenants	
			[ ] locator "Properties*Tenants"		// Updated by Udita 23/3/2011
		[+] PushButton CashFlow
			[ ] locator "Cash Flow"
		[+] PushButton Property
			[ ] locator "@windowid='10001'"
		[+] PushButton SavingsGoals		
			[ ] locator "@windowid='10004'"								// Added by Udita on 12 June 2012
		[ ] 
		[ ] 
	[+] Control QWNavigator1
		[ ] //locator "@windowid='202'"
		[ ] locator "@windowClassName='QWNavigator'"
		[+] PushButton AccountOverview
			[ ] locator "Account Overview"
		[+] PushButton AddTransactions
			[ ] locator "Add Transactions"
			[ ] //locator "@windowid='10140'"
		[+] PushButton PropertiesTenants
			[ ] //locator "@windowid='10141'"
			[ ] locator "Properties*Tenants"
		[+] PushButton Reports
			[ ] locator "Reports"
			[ ] //locator "@windowid='10142'"
		[+] StaticText AccountName      
			[ ] locator "@windowid='32702'"					              // Added by Dean on 6th Feb 2013
		[+] PushButton BusinessTools
			[ ] locator "Business Tools"
			[ ] //locator "@windowid='10140'"
		[+] PushButton BusinessActions
			[ ] locator "Business Actions"
			[ ] //locator "@windowid='10141'"
		[+] PushButton ViewGuidance
			[ ] locator "View Guidance"
		[ ] 
		[ ] //Investing Tab
		[+] PushButton Update
			[ ] locator "Update*"
			[ ] 
		[+] PushButton Tools
			[ ] locator "Tools*"
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] Control ToolBar		
		[ ] locator "@windowid='12000'"		// Updated by Udita 15/3/2011
		[+] Control MainToolBar
			[ ] locator "@windowid='12000'"		
	[+] Control QWTOOLBAR
		[ ] locator "@windowid='12000'"	
		[+] Control QW_MAIN_TOOLBAR
			[ ] locator "@windowid='12000'"	
	[+] MainWin AddingFeatures
		[ ] locator "Adding Features"
		[+] StaticText ImportantText
			[ ] locator "@windowid='9987'"
		[+] Control Control9991
			[ ] locator "@windowid='9991'"
		[+] StaticText YouAreCurrentlyUsingQuicke
			[ ] locator "@windowid='9968'"
		[+] PushButton UnlockAgain
			[ ] locator "@windowid='32767'"
		[+] PushButton UnlockLater
			[ ] locator "@windowid='32766'"
	[+] DialogBox FreeUpdateToQuickenIsAvailable
		[ ] locator "Free Update to Quicken is Available*"
		[+] Control Control101
			[ ] locator "@windowClassName='QWIconDisplay'"
		[+] StaticText FreeUpdateToQuickenIsAvai
			[ ] locator "@windowid='32702'"
		[+] PushButton UpdateNow
			[ ] locator "@windowid='32767'"
		[+] PushButton UpdateLater
			[ ] locator "@windowid='32766'"
		[+] PushButton WhatSInThisUpdate
			[ ] locator "@windowid='100'"
		[+] Control Panel
			[ ] locator "@windowid='-1'"
			[+] Control Control1000
				[ ] locator "@windowClassName='QWMsHtmlVw'"
	[+] // Control BrokerageAccountWindow
		[+] // locator "[Control]&windowClassName=MDIClient"
			[ ] // //"[Control](216,158)"
		[+] // Control Brokerage
			[+] // locator "[Control]Brokerage *"
				[ ] // "[Control]$7611"
				[ ] // "[Control]&windowClassName=QWMDI"
				[ ] // //"[Control](208,128)"
			[+] // Control EnterTransactions
				[+] // locator "[Control]Enter Transactions"
					[ ] // "[Control]^Brokerage 01"
					[ ] // "[Control]$981"
					[ ] // "[Control](222,164)"
					[ ] // "[Control]&windowClassName=QC_button"
			[+] // Control Holdings
				[+] // locator "[Control]Holdings"
					[ ] // "[Control]$999"
					[ ] // "[Control](351,164)"
					[ ] // "[Control]&windowClassName=QC_button"
			[+] // Control Find
				[+] // locator "[Control]Find"
					[ ] // "[Control]$32206"
					[ ] // "[Control](1087,164)"
					[ ] // "[Control]&windowClassName=QC_button"
			[+] // Control AccountActions
				[+] // locator "[Control]Account Actions"
					[ ] // "[Control]$32221"
					[ ] // "[Control](1141,164)"
					[ ] // "[Control]&windowClassName=QC_button"
			[+] // StaticText StaticText1
				[+] // locator "$-1"
					[ ] // "(216,192)"
				[+] // StaticText StaticText1
					[+] // locator "$-1"
						[ ] // "(216,192)"
					[+] // Control Control1000
						[+] // locator "[Control]$1000"
							[ ] // "[Control](216,711)"
							[ ] // "[Control]&windowClassName=QWHtmlView"
					[+] // MainWin MainWin982
						[ ] // locator "$982"
						[+] // ListBox ListBox1
							[+] // locator "$1"
								[ ] // "(217,218)"
							[+] // Control Control20201
								[+] // locator "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // Control Control1124
									[+] // locator "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // Control Control1128
									[+] // locator "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // Control Control20202
								[+] // locator "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control20203
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](217,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control20204
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control20205
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control20206
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control20207
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control20208
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](217,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control20209
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,217)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,217)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,217)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202010
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202011
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202012
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202013
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202014
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](217,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202015
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202016
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202017
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202018
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202019
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](217,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202020
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202021
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202022
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202023
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](217,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](217,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202024
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // TextField TextField2001
								[+] // multitag "$2001"
									[ ] // "(295,243)"
							[+] // CustomWin Control202025
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](370,243)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](370,243)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](370,243)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202026
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202027
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202028
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202029
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,217)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,217)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,217)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202030
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202031
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202032
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202033
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](205,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](205,218)"
										[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control202034
								[+] // multitag "[Control]$2020"
									[ ] // "[Control](215,218)"
									[ ] // "[Control]&windowClassName=QFBag"
								[+] // CustomWin Control1124
									[+] // multitag "[Control]$1124"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
								[+] // CustomWin Control1128
									[+] // multitag "[Control]$1128"
										[ ] // "[Control](215,218)"
										[ ] // "[Control]&windowClassName=QC_button"
						[+] // HorizontalScrollBar HorizontalScrollBar
							[+] // multitag "$HorizontalScrollBar"
								[ ] // "(217,680)"
			[+] // CustomWin Control1
				[+] // multitag "[Control]$-1"
					[ ] // "[Control](216,812)"
					[ ] // "[Control]&windowClassName=QWSnapHolder"
				[+] // StaticText StaticText1
					[+] // multitag "$-1"
						[ ] // "(228,824)"
					[+] // StaticText StaticText31000
						[+] // multitag "$31000"
							[ ] // "(228,825)"
					[+] // StaticText StaticText1
						[+] // multitag "$-1"
							[ ] // "(229,859)"
						[+] // CustomWin Control1011
							[+] // multitag "[Control]$1011"
								[ ] // "[Control](244,862)"
								[ ] // "[Control]&windowClassName=QWHtmlView"
						[+] // StaticText EnterYourFinancialInstituti1
							[+] // multitag "Enter your financial institution name"
								[ ] // "$65535"
								[ ] // "(247,891)"
						[+] // TextField EnterYourFinancialInstituti2
							[+] // multitag "Enter your financial institution name"
								[ ] // "^Enter your financial institution name"
								[ ] // "$1017"
								[ ] // "(247,906)"
						[+] // CustomWin CheckAvailability
							[+] // multitag "[Control]Check Availability"
								[ ] // "[Control]^Enter your financial institution name"
								[ ] // "[Control]$1016"
								[ ] // "[Control](479,904)"
								[ ] // "[Control]&windowClassName=QC_button"
						[+] // CustomWin Control2020
							[+] // multitag "[Control]$2020"
								[ ] // "[Control](229,859)"
								[ ] // "[Control]&windowClassName=QFBag"
							[+] // CustomWin Control1124
								[+] // multitag "[Control]$1124"
									[ ] // "[Control](229,859)"
									[ ] // "[Control]&windowClassName=QC_button"
							[+] // CustomWin Control1128
								[+] // multitag "[Control]$1128"
									[ ] // "[Control](229,859)"
									[ ] // "[Control]&windowClassName=QC_button"
			[+] // CustomWin Control
				[+] // multitag "[Control](216,749)"
					[ ] // "[Control]&windowClassName=QWinChild"
				[+] // CustomWin DownloadTransactions
					[+] // multitag "[Control]Download Transactions"
						[ ] // "[Control]$1021"
						[ ] // "[Control](228,753)"
						[ ] // "[Control]&windowClassName=QC_button"
				[+] // CustomWin BillAndIncomeReminders0D
					[+] // multitag "[Control]Bill and Income Reminders (0 Due)"
						[ ] // "[Control]$1022"
						[ ] // "[Control](393,753)"
						[ ] // "[Control]&windowClassName=QC_button"
				[+] // CustomWin SetUpDownload
					[+] // multitag "[Control]Set Up Download"
						[ ] // "[Control]$1023"
						[ ] // "[Control](228,781)"
						[ ] // "[Control]&windowClassName=QC_button"
				[+] // CustomWin SetUpOnlinePayment
					[+] // multitag "[Control]Set Up Online Payment"
						[ ] // "[Control]$1024"
						[ ] // "[Control](376,781)"
						[ ] // "[Control]&windowClassName=QC_button"
				[+] // CustomWin Control1032
					[+] // multitag "[Control]$1032"
						[ ] // "[Control](553,783)"
						[ ] // "[Control]&windowClassName=QWListViewer"
					[+] // ListBox ListBox1
						[+] // multitag "$1"
							[ ] // "(553,783)"
				[+] // CustomWin FILOGO
					[+] // multitag "[Control]FI LOGO"
						[ ] // "[Control]$1026"
						[ ] // "[Control](1064,776)"
						[ ] // "[Control]&windowClassName=QC_button"
				[+] // CustomWin Control1030
					[+] // multitag "[Control]$1030"
						[ ] // "[Control](1247,751)"
						[ ] // "[Control]&windowClassName=QC_button"
				[+] // StaticText StaticText1020
					[+] // multitag "$1020"
						[ ] // "(217,810)"
				[+] // StaticText StaticText1031
					[+] // multitag "$1031"
						[ ] // "(217,811)"
		[+] // CustomWin Home
			[+] // multitag "[Control]Home"
				[ ] // "[Control]$7610"
				[ ] // "[Control](216,158)"
				[ ] // "[Control]&windowClassName=QWMDI"
			[+] // CustomWin Customize
				[+] // multitag "[Control]Customize"
					[ ] // "[Control]$32503"
					[ ] // "[Control](230,194)"
					[ ] // "[Control]&windowClassName=QC_button"
			[+] // CustomWin Control1
				[+] // multitag "[Control]$-1"
					[ ] // "[Control](224,222)"
					[ ] // "[Control]&windowClassName=QWSnapHolder"
				[+] // StaticText StaticText11
					[+] // multitag "$-1"
						[ ] // "(236,234)"
					[+] // StaticText StaticText31000
						[+] // multitag "$31000"
							[ ] // "(236,235)"
						[+] // CustomWin Control1000
							[+] // multitag "[Control]$1000"
								[ ] // "[Control](1157,241)"
								[ ] // "[Control]&windowClassName=QC_button"
					[+] // CustomWin Panel
						[+] // multitag "[Control]Panel"
							[ ] // "[Control]$-1"
							[ ] // "[Control](237,269)"
							[ ] // "[Control]&windowClassName=QWPanel"
						[+] // StaticText LAST30DAYSSPENDING082011
							[+] // multitag "LAST 30 DAYS SPENDING (08-2011 - 09-2011)"
								[ ] // "$1002"
								[ ] // "(249,282)"
						[+] // StaticText YouHaveNoSpendingInTheSe
							[+] // multitag "You have no spending in the selected date range."
								[ ] // "$1059"
								[ ] // "(249,308)"
						[+] // MainWin ExamineYourSpending
							[+] // multitag "Examine Your Spending"
								[ ] // "$1087"
						[+] // CustomWin Panel
							[+] // multitag "[Control]Panel"
								[ ] // "[Control]$-1"
								[ ] // "[Control](972,290)"
								[ ] // "[Control]&windowClassName=QWPanel"
				[+] // StaticText StaticText12
					[+] // multitag "$-1"
						[ ] // "(236,561)"
					[+] // CustomWin Panel
						[+] // multitag "[Control]Panel"
							[ ] // "[Control]$-1"
							[ ] // "[Control](237,562)"
							[ ] // "[Control]&windowClassName=QWPanel"
						[+] // StaticText EliminateLateFeesAndOverdr
							[+] // multitag "Eliminate late fees and overdraft charges with an accurate picture of where your bank balance stands."
								[ ] // "$1003"
								[ ] // "(370,636)"
						[+] // StaticText WhyDoThisText
							[+] // multitag "Why do this?"
								[ ] // "$1017"
								[ ] // "(370,679)"
						[+] // StaticText AvoidLateFeesAndOverdraft
							[+] // multitag "Avoid late fees and overdraft charges."
								[ ] // "$1024"
								[ ] // "(373,695)"
						[+] // StaticText WhatSNeededText
							[+] // multitag "What's needed?"
								[ ] // "$1018"
								[ ] // "(592,679)"
						[+] // StaticText AMonthOrTwoOfCategorized
							[+] // multitag "A month or two of categorized transactions in your spending accounts. Quicken automatically finds your bills and income and helps you get started. So easy!"
								[ ] // "$1029"
								[ ] // "(595,695)"
						[+] // MainWin GetStarted
							[+] // multitag "Get Started"
								[ ] // "$1000"
						[+] // CustomWin Panel
							[+] // multitag "[Control]Panel"
								[ ] // "[Control]$-1"
								[ ] // "[Control](1142,562)"
								[ ] // "[Control]&windowClassName=QWPanel"
				[+] // StaticText StaticText13
					[+] // multitag "$-1"
						[ ] // "(236,841)"
					[+] // StaticText StaticText1
						[+] // multitag "$-1"
							[ ] // "(236,1092)"
					[+] // CustomWin Panel
						[+] // multitag "[Control]Panel"
							[ ] // "[Control]$-1"
							[ ] // "[Control](237,842)"
							[ ] // "[Control]&windowClassName=QWPanel"
						[+] // StaticText ChooseSpecificAreasToTrack
							[+] // multitag "Choose specific areas to track and keep under control."
								[ ] // "$1003"
								[ ] // "(370,916)"
						[+] // StaticText WhyDoThisText
							[+] // multitag "Why do this?"
								[ ] // "$1017"
								[ ] // "(370,946)"
						[+] // StaticText FeelInControlOfYourFinanc
							[+] // multitag "Feel in control of your finances and meet your long-term financial goals."
								[ ] // "$1024"
								[ ] // "(373,962)"
						[+] // StaticText WhatSNeededText
							[+] // multitag "What's needed?"
								[ ] // "$1018"
								[ ] // "(592,946)"
						[+] // StaticText NothingText
							[+] // multitag "Nothing."
								[ ] // "$1029"
								[ ] // "(595,962)"
						[+] // MainWin GetStarted
							[+] // multitag "Get Started"
								[ ] // "$1000"
						[+] // CustomWin Panel
							[+] // multitag "[Control]Panel"
								[ ] // "[Control]$-1"
								[ ] // "[Control](1142,842)"
								[ ] // "[Control]&windowClassName=QWPanel"
				[+] // VerticalScrollBar VerticalScrollBar
					[+] // multitag "$VerticalScrollBar"
						[ ] // "(1267,222)"
	[+] MainWin AccountRegisterPopUpWindow 
		[ ] 
		[+] StaticText AccName
			[ ] locator "@windowid='7'"
		[+] Control TxList
			[ ] locator "@windowid='13'"
			[+] Control TxToolbar
				[ ] locator "@windowid='8'"
				[+] CheckBox Save
					[ ] locator "@windowid='101'"
				[+] RadioList RadioList1
					[ ] locator "@windowid='143'"
			[+] Control N07022013
				[ ] locator "@windowid='3'"
			[+] Control QREdit2
				[ ] locator "@windowid='4'"
			[+] Control QREdit1
				[ ] locator "@windowid='5'"
			[+] Control WhiteRect1
				[ ] locator "@windowid='6'"
			[+] Control QFBag1
				[ ] locator "@windowid='2020'"
				[+] PushButton PushButton2
					[ ] locator "@windowid='1124'"
				[+] PushButton PushButton1
					[ ] locator "@windowid='1128'"
		[+] VerticalScrollBar ScrollBar1
			[ ] locator "@windowid='1'"
		[+] HorizontalScrollBar House4
			[ ] locator "@windowid='9'"
		[+] TextField TextField1
			[ ] locator "@windowid='482'"
		[+] PushButton C
			[ ] locator "@windowid='483'"
		[+] ComboBox House5
			[ ] locator "@windowid='452'"
		[+] ComboBox PopupList2
			[ ] locator "@windowid='454'"
		[+] ComboBox PopupList3
			[ ] locator "@windowid='451'"
		[+] PushButton Reset
			[ ] locator "@windowid='450'"
		[+] StaticText House1Text
			[ ] locator "@windowid='32702'"
		[+] StaticText House2Text
			[ ] locator "@windowid='-1'"
		[+] Control QWSnapHolder1
			[ ] locator "@windowid='-1'"
	[+] Control MDIClient
		[+] Control Bills
			[+] CheckBox IncludePaid
				[ ] locator "//CheckBox[@caption='Include Paid']"
			[+] StaticText TimeRange
				[ ] locator "Time Range"
			[ ] 
		[+] // Control Investing
			[+] // PushButton PortfolioOptionsButton
				[ ] // locator "//PushButton[@caption='Op*tions']"
			[+] // ComboBox TimeFrequency
				[ ] // locator "//ComboBox[3]"
			[+] // Control AllocationTab
				[+] // StaticText AssetAllocationSnapshot
					[ ] // locator "@windowid='-1'"
					[+] // StaticText Buttons
						[ ] // locator "@windowid='-1'"
						[+] // PushButton ShowFullGraph
							[ ] // locator "Show Full Graph"
						[+] // PushButton RebalancePortfolio
							[ ] // locator "Rebalance Portfolio"
						[+] // StaticText AllocationButtons
							[ ] // locator "@windowid='-1'"
							[+] // PushButton ShowAllocationGuide
								[ ] // locator "Show Allocation Guide"
							[ ] // 
						[ ] // 
			[+] // PushButton ShowAllocationGuide
				[ ] // locator "Show Allocation Guide"
		[+] // Control Investing
			[+] // PushButton PortfolioOptionsButton
				[ ] // locator "//PushButton[@caption='Op*tions']"
			[+] // ComboBox TimeFrequency
				[ ] // locator "//ComboBox[3]"
			[+] // Control AllocationTab
				[+] // StaticText AssetAllocationSnapshot
					[ ] // locator "@windowid='-1'"
					[+] // StaticText Buttons
						[ ] // locator "@windowid='-1'"
						[+] // PushButton ShowFullGraph
							[ ] // locator "Show Full Graph"
						[+] // PushButton RebalancePortfolio
							[ ] // locator "Rebalance Portfolio"
						[+] // StaticText AllocationButtons
							[ ] // locator "@windowid='-1'"
							[+] // PushButton ShowAllocationGuide
								[ ] // locator "Show Allocation Guide"
							[ ] // 
						[ ] // 
			[+] // PushButton ShowAllocationGuide
				[ ] // locator "Show Allocation Guide"
		[+] Control Investing
			[ ] locator "Investing"
			[+] PushButton PortfolioOptionsButton
				[ ] locator "//PushButton[@caption='Op*tions']"
			[+] ComboBox TimeFrequency
				[ ] locator "//ComboBox[3]"
			[+] Control AllocationTab
				[ ] locator "[@windowClassName='QWSnapHolder']"
				[+] StaticText AssetAllocationSnapshot
					[ ] locator "@windowid='-1'"
					[+] StaticText Buttons
						[ ] locator "@windowid='-1'"
			[+] // Control TargetChart
				[+] // locator "[@windowClassName='QWGraphControlClass'][2]"
						[ ] 
						[+] StaticText Buttons1
							[ ] locator "@windowid='31000'"
							[+] PushButton OptionsButton
								[ ] locator "@windowid='1000'"
						[ ] 
						[+] PushButton ShowFullGraph
							[ ] locator "Show Full Graph"
						[+] PushButton RebalancePortfolio
							[ ] locator "Rebalance Portfolio"
						[+] StaticText AllocationButtons
							[ ] locator "@windowid='-1'"
							[+] PushButton ShowAllocationGuide
								[ ] locator "Show Allocation Guide"
								[ ] 
								[ ] 
			[+] PushButton ShowAllocationGuide
				[ ] locator "Show Allocation Guide"
			[ ] 
		[+] Control PropertyAndDebt
			[ ] locator "Property*Debt"
			[+] Control QWSnapHolder
				[ ] locator "@windowid='-1'"
				[+] StaticText StaticText1
					[ ] locator "@windowid='-1'"
					[+] StaticText StaticText2
						[+] PushButton NetWorthSummaryReport
							[ ] locator "@windowid='30002'"
			[+] PushButton PropertyOptions
				[ ] locator "@windowid='106'"
			[+] PushButton LoanAndDebtOptions
				[ ] locator "@windowid='112'"
			[ ] 
		[+] Control Planning
			[ ] //locator "@windowid='7614'"
			[+] Control QWSnapHolder
				[ ] locator "@windowid='-1'"
				[+] Control Panel
					[ ] locator "@windowid='-1'"
					[+]  PushButton PlanActions
						[ ] locator "@windowid='1464'"
					[+]  PushButton GoalActions
						[ ] locator "@windowid='139'"
					[ ] 
			[+] PushButton BudgetActions
				[ ] locator "//PushButton[@caption='Budget Actions']"
			[+] PushButton ChangeAssumptions
				[ ] locator "Change Assumptions"
			[+] PushButton ShowTaxPlanner
				[ ] locator "Show Tax Planner"
			[ ] 
			[ ] 
		[+] // Control TipsTutorials
			[+] // Control QWPanel
				[+] // Control QWMsHtmlVw
					[+] // BrowserWindow NewUserEngagement
						[ ] // locator "New User Engagement"
						[ ] // 
		[+] Control Business
			[ ] locator "Business"
			[+]  PushButton ProfitLossDetails
				[ ] locator "@windowid='2223'"
			[+] Control QWSnapHolder
				[ ] locator "@windowid='-1'"
				[+] StaticText StaticText1
					[ ] locator "@windowid='-1'"
					[+] MainWin Business1
						[ ] locator "@windowid='120'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
					[ ] 
			[ ] 
		[+] Control RentalProperty
			[ ] locator "Rental Property"
			[+]  PushButton ProfitLossDetails
				[ ] locator "@windowid='2245'"
			[+]  ComboBox RentalPropertiesComboBox
				[ ] locator "@windowid='2241'"
			[+] Control QWSnapHolder
				[ ] locator "@windowid='-1'"
				[+] StaticText RentalSpendingAccount
					[ ] // locator "[@windowid='-1'][5]"
					[+] StaticText RentalPropertyAndDebtAccount
						[ ] // locator "[@windowid='-1']"
						[+] MainWin ListViewer
							[ ] locator "@windowid='120'"
							[+] ListBox ListBox
								[ ] locator "@windowid='1'"
			[ ] 
			[ ] 
		[+] Control TipsTutorials
			[ ] locator "Tips*Tutorials"
			[+] Control QWPanel
				[ ] 
				[+] Control QWPanel
					[ ] locator "[@windowClassName='QWMsHtmlVw']"
					[+] BrowserWindow BrowserWindow
						[ ] locator "Promotions"
			[ ] 
		[+] Control SavingsGoals
			[ ] 
		[ ] 
	[+] PushButton ViewReminders
		[ ] locator "View Reminders"
	[+] PushButton BusinessTools
		[ ] locator "Business Tools"
		[ ] //locator "@windowid='10140'"
	[+] PushButton BusinessActions
		[ ] locator "Business Actions"
		[ ] //locator "@windowid='10141'"
	[+] PushButton Reports
		[ ] locator "Reports"
		[ ] //locator "@windowid='10142'"
	[+] PushButton AddViewButton
		[ ] locator "[@caption='Add View' or @caption='Add']"
	[+] PushButton ViewGuidanceButton
		[ ] locator "View Guidance"
	[+] PushButton ShowAllAlertsButton
		[ ] locator "Show all alerts"
	[+] PushButton Customize
		[ ] locator "Customize"
	[+] PushButton ShowTaxSummaryReport
		[ ] locator "@caption='Show Tax Summary Report'"
	[+] PushButton Planning
		[ ] locator "Planning"
	[+] PushButton TaxCenter
		[ ] locator "Tax Center"
	[ ] 
	[ ] //Mobile and Alerts controls			//Added Jayashree Nagaraja, 9th Apr, 2015
	[+] StaticText IntuitIdText
		[ ] locator "@windowid='112'"
	[+] Control IntuitID
		[ ] locator "@windowid='112'"
	[+] StaticText SelectAccountsToSync
		[ ] locator "@windowid='100'"
	[+] PushButton Done
		[ ] locator "@windowid='32767'"
	[+] PushButton SyncNow
		[ ] locator "@windowid='105'"
	[+] Control LastFullSync
		[ ] locator "@windowid='121'"
	[+] Control TimeStamp
		[ ] locator "@windowid='122'"
	[+] Control ErrorIcon
		[ ] locator "@windowid='257'"
	[+] PushButton ViewErrors
		[ ] locator "@windowid='258'"
	[ ] ////////////////////////Added by Abhishek 11th May 2015////////////////////
	[+] PushButton RebalancePortfolio
		[+] locator "Rebalance Portfolio"
				[+] StaticText AllocationButtons
					[ ] locator "@windowid='-1'"
					[+] PushButton ShowAllocationGuide
						[ ] locator "Show Allocation Guide"
						[ ] 
	[+] PushButton OptionsButton
		[ ] locator "@windowid='1000'"
		[+] PushButton RebalancePortfolio
			[ ] locator "Rebalance Portfolio"
		[ ] 
[+] Window MainWin PortfolioRebalancer
	[ ] locator "Portfolio Rebalancer"
	[+] BrowserWindow BrowserWindow
		[ ] locator "//BrowserWindow"
		[+] DomElement Action
			[ ] locator "DIV[@id='action']"
		[+] DomLink AdjustmentToReach
			[ ] locator "A[@textContents='Adjustment to reach *']"
		[+] DomElement AdjustmentToReachFONT
			[ ] locator "FONT[@textContents='Adjustment to reach *']"
		[+] DomEmbeddedElement AssetAndTarget
			[ ] locator "OBJECT[@id='assetAndTarget']"
		[+] DomLink AssetClass
			[ ] locator "A[@textContents='Asset class']"
		[+] DomElement AssetClassB
			[ ] locator "B[@textContents='Asset class']"
		[+] DomElement AssetClassFONT
			[ ] locator "FONT[@textContents='Asset class']"
		[+] DomElement B
			[ ] locator "//TD[@align='center']/B"
		[+] DomElement B2
			[ ] locator "//TD[@align='center'][2]/B"
		[+] DomElement B3
			[ ] locator "//TD[@align='center'][3]/B"
		[+] DomElement B4
			[ ] locator "//TD[@align='center'][4]/B"
		[+] DomElement B5
			[ ] locator "//TD[@align='center'][5]/B"
		[+] DomElement BR
			[ ] locator "//BR"
		[+] DomElement BR2
			[ ] locator "BR[2]"
		[+] DomElement Cash
			[ ] locator "TD[@textContents='Cash']"
		[+] DomElement Center
			[ ] locator "TD[@align='center'][2]"
		[+] DomElement Center3
			[ ] locator "TD[@align='center'][3]"
		[+] DomElement Center4
			[ ] locator "TD[@align='center'][4]"
		[+] DomElement Center5
			[ ] locator "TD[@align='center'][5]"
		[+] DomLink Current
			[ ] locator "A[@textContents='Current %']"
		[+] DomElement CurrentFONT
			[ ] locator "FONT[@textContents='Current %']"
		[+] DomLink CurrentValue
			[ ] locator "A[@textContents='Current Value']"
		[+] DomElement CurrentValueFONT
			[ ] locator "FONT[@textContents='Current Value']"
		[+] DomElement DecideWhichAdjustm
			[ ] locator "LI[@textContents='Decide which adjustm*']"
		[+] DomElement DIV
			[ ] locator "//LI[@textContents='Decide which adjustm*']/DIV"
		[+] DomElement DomesticBonds
			[ ] locator "TD[@textContents='Domestic Bonds']"
		[+] DomElement DoubleClickaPies
			[ ] locator "LI[@textContents='Double-click a pie s*']"
		[+] DomLink Evaluate
			[ ] locator "A[@textContents='evaluate']"
		[+] DomElement GlobalBonds
			[ ] locator "TD[@textContents='Global Bonds']"
		[+] DomElement HEAD
			[ ] locator "//HEAD"
		[+] DomElement HTML
			[ ] locator "/HTML"
		[+] DomElement IdAmountTotal
			[ ] locator "DIV[@id='idAmountTotal']"
		[+] DomElement IdAmt1
			[ ] locator "SPAN[@id='idAmt1']"
		[+] DomElement IdAmt2
			[ ] locator "SPAN[@id='idAmt2']"
		[+] DomElement IdAmt3
			[ ] locator "SPAN[@id='idAmt3']"
		[+] DomElement IdAmt4
			[ ] locator "SPAN[@id='idAmt4']"
		[+] DomElement IdAmt5
			[ ] locator "SPAN[@id='idAmt5']"
		[+] DomElement IdAmt6
			[ ] locator "SPAN[@id='idAmt6']"
		[+] DomElement IdAmt7
			[ ] locator "SPAN[@id='idAmt7']"
		[+] DomElement IdAmt8
			[ ] locator "SPAN[@id='idAmt8']"
		[+] DomElement IdAns1
			[ ] locator "DIV[@id='idAns1']"
		[+] DomElement IdAns2
			[ ] locator "DIV[@id='idAns2']"
		[+] DomElement IdAns3
			[ ] locator "DIV[@id='idAns3']"
		[+] DomElement IdAns4
			[ ] locator "DIV[@id='idAns4']"
		[+] DomElement IdAns5
			[ ] locator "DIV[@id='idAns5']"
		[+] DomElement IdAns6
			[ ] locator "DIV[@id='idAns6']"
		[+] DomElement IdAns7
			[ ] locator "DIV[@id='idAns7']"
		[+] DomElement IdAns8
			[ ] locator "DIV[@id='idAns8']"
		[+] DomElement IdChange1
			[ ] locator "SPAN[@id='idChange1']"
		[+] DomElement IdChange2
			[ ] locator "SPAN[@id='idChange2']"
		[+] DomElement IdChange3
			[ ] locator "SPAN[@id='idChange3']"
		[+] DomElement IdChange4
			[ ] locator "SPAN[@id='idChange4']"
		[+] DomElement IdChange5
			[ ] locator "SPAN[@id='idChange5']"
		[+] DomElement IdChange6
			[ ] locator "SPAN[@id='idChange6']"
		[+] DomElement IdChange7
			[ ] locator "SPAN[@id='idChange7']"
		[+] DomElement IdChange8
			[ ] locator "SPAN[@id='idChange8']"
		[+] DomElement IdPercent1
			[ ] locator "SPAN[@id='idPercent1']"
		[+] DomElement IdPercent2
			[ ] locator "SPAN[@id='idPercent2']"
		[+] DomElement IdPercent3
			[ ] locator "SPAN[@id='idPercent3']"
		[+] DomElement IdPercent4
			[ ] locator "SPAN[@id='idPercent4']"
		[+] DomElement IdPercent5
			[ ] locator "SPAN[@id='idPercent5']"
		[+] DomElement IdPercent6
			[ ] locator "SPAN[@id='idPercent6']"
		[+] DomElement IdPercent7
			[ ] locator "SPAN[@id='idPercent7']"
		[+] DomElement IdPercent8
			[ ] locator "SPAN[@id='idPercent8']"
		[+] DomElement IdTarg1
			[ ] locator "SPAN[@id='idTarg1']"
		[+] DomElement IdTarg2
			[ ] locator "SPAN[@id='idTarg2']"
		[+] DomElement IdTarg3
			[ ] locator "SPAN[@id='idTarg3']"
		[+] DomElement IdTarg4
			[ ] locator "SPAN[@id='idTarg4']"
		[+] DomElement IdTarg5
			[ ] locator "SPAN[@id='idTarg5']"
		[+] DomElement IdTarg6
			[ ] locator "SPAN[@id='idTarg6']"
		[+] DomElement IdTarg7
			[ ] locator "SPAN[@id='idTarg7']"
		[+] DomElement IdTarg8
			[ ] locator "SPAN[@id='idTarg8']"
		[+] DomElement International
			[ ] locator "TD[@textContents='International']"
		[+] DomElement JAVASCRIPT
			[ ] locator "SCRIPT[@language='JAVASCRIPT']"
		[+] DomElement JavaScript
			[ ] locator "SCRIPT[@language='JavaScript'][4]"
		[+] DomElement LargeCap
			[ ] locator "TD[@textContents='Large Cap']"
		[+] DomLink OffByPoints
			[ ] locator "A[@textContents='Off by % points']"
		[+] DomElement OffByPointsFONT
			[ ] locator "FONT[@textContents='Off by % points']"
		[+] DomElement OL
			[ ] locator "//OL"
		[+] DomElement Other
			[ ] locator "TD[@textContents='Other']"
		[+] DomElement P
			[ ] locator "//P"
		[+] DomElement P2
			[ ] locator "P[2]"
		[+] DomElement PNFJs
			[ ] locator "SCRIPT[@src='PNF.js']"
		[+] DomElement Rebalancer
			[ ] locator "DIV[@id='rebalancer']"
		[+] DomElement RebalancingYourPor
			[ ] locator "BODY[@textContents='Rebalancing your por*']"
		[+] DomEmbeddedElement RebalQuicken
			[ ] locator "OBJECT[@id='RebalQuicken']"
		[+] DomElement Right
			[ ] locator "//TABLE[@cellSpacing='1']//TR[2]/TD[@align='right']"
		[+] DomElement Right10
			[ ] locator "//TABLE[@cellSpacing='1']//TR[3]/TD[@align='right'][5]"
		[+] DomElement Right11
			[ ] locator "//TABLE[@cellSpacing='1']//TR[4]/TD[@align='right']"
		[+] DomElement Right12
			[ ] locator "//TABLE[@cellSpacing='1']//TR[4]/TD[@align='right'][2]"
		[+] DomElement Right13
			[ ] locator "//TABLE[@cellSpacing='1']//TR[4]/TD[@align='right'][3]"
		[+] DomElement Right14
			[ ] locator "//TABLE[@cellSpacing='1']//TR[4]/TD[@align='right'][4]"
		[+] DomElement Right15
			[ ] locator "//TABLE[@cellSpacing='1']//TR[4]/TD[@align='right'][5]"
		[+] DomElement Right16
			[ ] locator "//TABLE[@cellSpacing='1']//TR[5]/TD[@align='right']"
		[+] DomElement Right17
			[ ] locator "//TABLE[@cellSpacing='1']//TR[5]/TD[@align='right'][2]"
		[+] DomElement Right18
			[ ] locator "//TABLE[@cellSpacing='1']//TR[5]/TD[@align='right'][3]"
		[+] DomElement Right19
			[ ] locator "//TABLE[@cellSpacing='1']//TR[5]/TD[@align='right'][4]"
		[+] DomElement Right2
			[ ] locator "//TABLE[@cellSpacing='1']//TR[2]/TD[@align='right'][2]"
		[+] DomElement Right20
			[ ] locator "//TABLE[@cellSpacing='1']//TR[5]/TD[@align='right'][5]"
		[+] DomElement Right21
			[ ] locator "//TABLE[@cellSpacing='1']//TR[6]/TD[@align='right']"
		[+] DomElement Right22
			[ ] locator "//TABLE[@cellSpacing='1']//TR[6]/TD[@align='right'][2]"
		[+] DomElement Right23
			[ ] locator "//TABLE[@cellSpacing='1']//TR[6]/TD[@align='right'][3]"
		[+] DomElement Right24
			[ ] locator "//TABLE[@cellSpacing='1']//TR[6]/TD[@align='right'][4]"
		[+] DomElement Right25
			[ ] locator "//TABLE[@cellSpacing='1']//TR[6]/TD[@align='right'][5]"
		[+] DomElement Right26
			[ ] locator "//TABLE[@cellSpacing='1']//TR[7]/TD[@align='right']"
		[+] DomElement Right27
			[ ] locator "//TABLE[@cellSpacing='1']//TR[7]/TD[@align='right'][2]"
		[+] DomElement Right28
			[ ] locator "//TABLE[@cellSpacing='1']//TR[7]/TD[@align='right'][3]"
		[+] DomElement Right29
			[ ] locator "//TABLE[@cellSpacing='1']//TR[7]/TD[@align='right'][4]"
		[+] DomElement Right3
			[ ] locator "//TABLE[@cellSpacing='1']//TR[2]/TD[@align='right'][3]"
		[+] DomElement Right30
			[ ] locator "//TABLE[@cellSpacing='1']//TR[7]/TD[@align='right'][5]"
		[+] DomElement Right31
			[ ] locator "//TABLE[@cellSpacing='1']//TR[8]/TD[@align='right']"
		[+] DomElement Right32
			[ ] locator "//TABLE[@cellSpacing='1']//TR[8]/TD[@align='right'][2]"
		[+] DomElement Right33
			[ ] locator "//TABLE[@cellSpacing='1']//TR[8]/TD[@align='right'][3]"
		[+] DomElement Right34
			[ ] locator "//TABLE[@cellSpacing='1']//TR[8]/TD[@align='right'][4]"
		[+] DomElement Right35
			[ ] locator "//TABLE[@cellSpacing='1']//TR[8]/TD[@align='right'][5]"
		[+] DomElement Right36
			[ ] locator "//TABLE[@cellSpacing='1']//TR[9]/TD[@align='right']"
		[+] DomElement Right37
			[ ] locator "//TABLE[@cellSpacing='1']//TR[9]/TD[@align='right'][2]"
		[+] DomElement Right38
			[ ] locator "//TABLE[@cellSpacing='1']//TR[9]/TD[@align='right'][3]"
		[+] DomElement Right39
			[ ] locator "//TABLE[@cellSpacing='1']//TR[9]/TD[@align='right'][4]"
		[+] DomElement Right4
			[ ] locator "//TABLE[@cellSpacing='1']//TR[2]/TD[@align='right'][4]"
		[+] DomElement Right40
			[ ] locator "//TABLE[@cellSpacing='1']//TR[9]/TD[@align='right'][5]"
		[+] DomElement Right5
			[ ] locator "//TABLE[@cellSpacing='1']//TR[2]/TD[@align='right'][5]"
		[+] DomElement Right6
			[ ] locator "//TABLE[@cellSpacing='1']//TR[3]/TD[@align='right']"
		[+] DomElement Right7
			[ ] locator "//TABLE[@cellSpacing='1']//TR[3]/TD[@align='right'][2]"
		[+] DomElement Right8
			[ ] locator "//TABLE[@cellSpacing='1']//TR[3]/TD[@align='right'][3]"
		[+] DomElement Right9
			[ ] locator "//TABLE[@cellSpacing='1']//TR[3]/TD[@align='right'][4]"
		[+] DomLink Search
			[ ] locator "A[@textContents='Search']"
		[+] DomElement SmallCap
			[ ] locator "TD[@textContents='Small Cap']"
		[+] DomElement STYLESHEET
			[ ] locator "LINK[@rel='STYLESHEET']"
		[+] DomTable TABLE
			[ ] locator "TABLE[3]"
		[+] DomLink Target
			[ ] locator "A[@textContents='Target %']"
		[+] DomElement TargetFONT
			[ ] locator "FONT[@textContents='Target %']"
		[+] DomElement TBODY
			[ ] locator "//TBODY"
		[+] DomElement TBODY2
			[ ] locator "TBODY[2]"
		[+] DomElement TBODY3
			[ ] locator "TBODY[3]"
		[+] DomElement TD
			[ ] locator "//DIV[@id='rebalancer']//TD"
		[+] DomElement TITLE
			[ ] locator "//TITLE"
		[+] DomElement Top
			[ ] locator "TD[@vAlign='top']"
		[+] DomTableRow TR
			[ ] locator "//DIV[@id='rebalancer']//TR"
		[+] DomTableRow TR10
			[ ] locator "//TABLE[@cellSpacing='1']//TR[9]"
		[+] DomTableRow TR11
			[ ] locator "//TABLE[@cellSpacing='1']//TR[10]"
		[+] DomTableRow TR12
			[ ] locator "//TBODY[3]/TR"
		[+] DomTableRow TR2
			[ ] locator "//TABLE[@cellSpacing='1']//TR"
		[+] DomTableRow TR3
			[ ] locator "//TABLE[@cellSpacing='1']//TR[2]"
		[+] DomTableRow TR4
			[ ] locator "//TABLE[@cellSpacing='1']//TR[3]"
		[+] DomTableRow TR5
			[ ] locator "//TABLE[@cellSpacing='1']//TR[4]"
		[+] DomTableRow TR6
			[ ] locator "//TABLE[@cellSpacing='1']//TR[5]"
		[+] DomTableRow TR7
			[ ] locator "//TABLE[@cellSpacing='1']//TR[6]"
		[+] DomTableRow TR8
			[ ] locator "//TABLE[@cellSpacing='1']//TR[7]"
		[+] DomTableRow TR9
			[ ] locator "//TABLE[@cellSpacing='1']//TR[8]"
		[+] DomElement Unclassified
			[ ] locator "TD[@textContents='Unclassified']"
		[+] DomLink WhatIfIHaveMutua
			[ ] locator "A[@textContents='What if I have mutua*']"
		[+] DomElement WhatIsRebalancing
			[ ] locator "DIV[@textContents='What is rebalancing?']"
		[+] DomLink WhenShouldIRebala
			[ ] locator "A[@textContents='When should I rebala*']"
		[+] DomElement x0
			[ ] locator "LI[@value='0'][3]"
		[+] DomTable x0TABLE
			[ ] locator "TABLE[@cellSpacing='0']"
		[+] DomTable x1
			[ ] locator "TABLE[@cellSpacing='1']"
		[+] DomElement x669999
			[ ] locator "TD[@bgColor='#669999']"
		[+] DomElement x66999910
			[ ] locator "TD[@bgColor='#669999'][10]"
		[+] DomElement x66999911
			[ ] locator "TD[@bgColor='#669999'][11]"
		[+] DomElement x66999912
			[ ] locator "TD[@bgColor='#669999'][12]"
		[+] DomElement x6699998
			[ ] locator "TD[@bgColor='#669999'][8]"
		[+] DomElement x6699999
			[ ] locator "TD[@bgColor='#669999'][9]"
	[+] DialogBox DownloadSecurityAssetClasses
		[ ] locator "Download Security Asset Classes"
		[+] StaticText AssetClassInformationProvidedByValueLineInc
			[ ] locator "(Asset class information provided by Value Line, Inc.)"
		[+] PushButton AssetClassInformationProvidedByValueLineIncPushButton
			[ ] locator "[@priorlabel='(Asset class information provided by Value Line, Inc.)'][3]"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton ClearAll
			[ ] locator "Clear All"
		[+] StaticText DownloadSecurityAssetClasses
			[ ] locator "Download Security Asset Classes"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] PushButton MarkAll
			[ ] locator "Mark All"
		[+] Control SelectTheSecuritiesYouWantAssetClassInformationFor
			[ ] locator "Select the securities you want asset class information for."
		[+] PushButton UpdateNow
			[ ] locator "Update Now"
		[+] VerticalScrollBar VerticalScrollBar
			[ ] locator "//VerticalScrollBar"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
	[+] MainWin TargetAllocation
		[ ] locator "Target Allocation"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] StaticText MustEqual100
			[ ] locator "(Must equal 100%)"
		[+] PushButton MustEqual100PushButton
			[ ] locator "@priorlabel='(Must equal 100%)'"
		[+] PushButton OK
			[ ] locator "OK"
		[+] StaticText TargetAllocation
			[ ] locator "Target Allocation"
		[+] TextField TextField
			[ ] locator "//TextField"
		[+] StaticText Total
			[ ] locator "Total:"
		[+] StaticText x100
			[ ] locator "100%"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
	[ ] 
	[+] StaticText Label
		[ ] locator "//StaticText"
	[+] Control QW_MDI_TOOLBAR
		[ ] locator "@windowClassName='QW_MDI_TOOLBAR'"
	[+] Control QWBrowserContainer
		[ ] locator "@windowClassName='QWBrowserContainer'"
[+] Window MainWin InvestmentResearch
	[ ] locator "Investment Research"
	[+] BrowserWindow BrowserWindow
		[ ] locator "//BrowserWindow"
		[+] DomElement MoneyManagement
			[ ] locator "SPAN[@textContents='Money Management']"
		[+] DomElement BODY
			[ ] locator "//BODY"
		[+] DomElement BR
			[ ] locator "//BR"
		[+] DomElement BR2
			[ ] locator "BR[2]"
		[+] DomElement BR3
			[ ] locator "BR[3]"
		[+] DomElement BR4
			[ ] locator "BR[4]"
		[+] DomElement Center
			[ ] locator "TD[@align='center']"
		[+] DomElement Center2
			[ ] locator "TD[@align='center'][2]"
		[+] DomTable Ded4b4
			[ ] locator "TABLE[@bgColor='#ded4b4']"
		[+] DomElement Evaluate
			[ ] locator "IMG[@alt='Evaluate']"
		[+] DomElement Ffffcc
			[ ] locator "TD[@bgColor='#ffffcc']"
		[+] DomElement Ffffcc3
			[ ] locator "TD[@bgColor='#ffffcc'][3]"
		[+] DomElement Ffffcc5
			[ ] locator "TD[@bgColor='#ffffcc'][5]"
		[+] DomElement Ffffcc7
			[ ] locator "TD[@bgColor='#ffffcc'][7]"
		[+] DomTableRow Ffffff
			[ ] locator "TR[@bgColor='#ffffff']"
		[+] DomLink FileCProgramDa
			[ ] locator "A[@href='file:///C:/ProgramDa*']"
		[+] DomLink FileCProgramDa2
			[ ] locator "A[@href='file:///C:/ProgramDa*'][2]"
		[+] DomLink FundFamilyDirector
			[ ] locator "A[@textContents='Fund Family Director*']"
		[+] DomElement FundFamilyDirectorB
			[ ] locator "B[@textContents='Fund Family Director*']"
		[+] DomElement HEAD
			[ ] locator "//HEAD"
		[+] DomElement HTML
			[ ] locator "/HTML"
		[+] DomElement Left
			[ ] locator "TD[@align='left']"
		[+] DomElement Left2
			[ ] locator "TD[@align='left'][2]"
		[+] DomLink PopularSearches
			[ ] locator "A[@textContents='Popular Searches']"
		[+] DomElement PopularSearchesB
			[ ] locator "B[@textContents='Popular Searches']"
		[+] DomElement Search
			[ ] locator "IMG[@alt='Search']"
		[+] DomLink StockScreener
			[ ] locator "A[@textContents='Stock Screener']"
		[+] DomElement StockScreenerB
			[ ] locator "B[@textContents='Stock Screener']"
		[+] DomElement TBODY
			[ ] locator "//TBODY"
		[+] DomElement TBODY2
			[ ] locator "TBODY[2]"
		[+] DomElement TBODY3
			[ ] locator "TBODY[3]"
		[+] DomElement TBODY4
			[ ] locator "TBODY[4]"
		[+] DomElement TD
			[ ] locator "//TABLE[@cellSpacing='0'][2]//TD[3]"
		[+] DomElement TD2
			[ ] locator "//TR[3]/TD"
		[+] DomElement TD3
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[5]/TD"
		[+] DomElement TD32
			[ ] locator "TD[32]"
		[+] DomElement TD4
			[ ] locator "//TABLE[@cellSpacing='0'][3]//TR[11]/TD"
		[+] DomElement TD6
			[ ] locator "TD[6]"
		[+] DomElement TD7
			[ ] locator "TD[7]"
		[+] DomElement TextCss
			[ ] locator "STYLE[@type='text/css']"
		[+] DomElement TITLE
			[ ] locator "//TITLE"
		[+] DomTableRow Top
			[ ] locator "TR[@vAlign='top']"
		[+] DomTableRow Top2
			[ ] locator "TR[@vAlign='top'][2]"
		[+] DomLink Top25Funds
			[ ] locator "A[@textContents='Top 25 Funds']"
		[+] DomElement Top25FundsB
			[ ] locator "B[@textContents='Top 25 Funds']"
		[+] DomTableRow TR
			[ ] locator "//TABLE[@cellSpacing='0'][2]//TR"
		[+] DomTableRow TR10
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[8]"
		[+] DomTableRow TR11
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[9]"
		[+] DomTableRow TR12
			[ ] locator "//TABLE[@cellSpacing='0'][3]//TR[11]"
		[+] DomTableRow TR2
			[ ] locator "//TABLE[@cellSpacing='0'][3]//TR"
		[+] DomTableRow TR3
			[ ] locator "TR[3]"
		[+] DomTableRow TR4
			[ ] locator "TR[4]"
		[+] DomTableRow TR5
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[2]"
		[+] DomTableRow TR6
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[3]"
		[+] DomTableRow TR7
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[4]"
		[+] DomTableRow TR8
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[5]"
		[+] DomTableRow TR9
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[7]"
		[+] DomTable x0
			[ ] locator "TABLE[@cellSpacing='0'][2]"
		[+] DomTable x03
			[ ] locator "TABLE[@cellSpacing='0'][3]"
		[+] DomTable x04
			[ ] locator "TABLE[@cellSpacing='0'][4]"
		[+] DomElement x0IMG
			[ ] locator "IMG[@border='0'][3]"
		[+] DomElement x0IMG4
			[ ] locator "IMG[@border='0'][4]"
		[+] DomElement x333366
			[ ] locator "//TR[@vAlign='top']/TD[@bgColor='#333366'][2]"
		[+] DomElement x33336610
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[8]/TD[@bgColor='#333366']"
		[+] DomElement x3333662
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[2]/TD[@bgColor='#333366']"
		[+] DomElement x3333663
			[ ] locator "//TR[@vAlign='top']/TD[@bgColor='#333366'][3]"
		[+] DomElement x3333664
			[ ] locator "//TR[@vAlign='top']/TD[@bgColor='#333366'][4]"
		[+] DomElement x3333665
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[3]/TD[@bgColor='#333366']"
		[+] DomElement x3333666
			[ ] locator "//TR[@vAlign='top'][2]/TD[@bgColor='#333366'][2]"
		[+] DomElement x3333667
			[ ] locator "//TR[@vAlign='top'][2]/TD[@bgColor='#333366'][3]"
		[+] DomElement x3333668
			[ ] locator "//TR[@vAlign='top'][2]/TD[@bgColor='#333366'][4]"
		[+] DomElement x3333669
			[ ] locator "//TABLE[@cellSpacing='0'][4]//TR[7]/TD[@bgColor='#333366']"
		[+] DomElement x4
			[ ] locator "TD[@colSpan='4']"
		[+] DomElement x42
			[ ] locator "TD[@colSpan='4'][2]"
	[+] Control HttpQwQuickenComCgiBinQdCgiw2015Ssmff_popstkPagePopular
		[ ] locator "@caption='http://qw.quicken.com/cgi-bin/qd.cgi/w/2015/ssmff_popstk/?page=Popular'"
	[+] StaticText Label
		[ ] locator "//StaticText"
	[+] Control QnetStatusBarWindow
		[ ] locator "@windowClassName='QnetStatusBarWindow'"
	[+] Control QW_BAG_TOOLBAR
		[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
	[+] Control QW_MAIN_TOOLBAR
		[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
	[+] Control QWBrowserContainer
		[ ] locator "@windowClassName='QWBrowserContainer'"
	[+] Control StatusPaneClass
		[ ] locator "[@windowClassName='StatusPaneClass'][2]"
	[+] Control StatusPaneClass3
		[ ] locator "[@windowClassName='StatusPaneClass'][3]"
	[+] Control StatusPaneClass4
		[ ] locator "[@windowClassName='StatusPaneClass'][4]"
[+] // Window MainWin AssetAllocation2
	[ ] // locator "[@caption='Asset Allocation'][2]"
	[+] // ComboBox ComboBox
		[ ] // locator "//ComboBox"
	[+] // Control DAteRange
		[ ] // locator "D&ate range:"
	[+] // PushButton HideGraph
		[ ] // locator "Hide Graph"
	[+] // ListBox ListBox
		[ ] // locator "//ListBox"
	[+] // ListBox ListBox2
		[ ] // locator "[2]"
	[+] // Control Panel
		[ ] // locator "Panel"
	[+] // Control QW_BAG_TOOLBAR
		[ ] // locator "@windowClassName='QW_BAG_TOOLBAR'"
	[+] // Control QW_MAIN_TOOLBAR
		[ ] // locator "@windowClassName='QW_MAIN_TOOLBAR'"
	[+] // Control QWCustomizeBar
		[ ] // locator "@windowClassName='QWCustomizeBar'"
	[+] // Control QWGraphControlClass
		[ ] // locator "@windowClassName='QWGraphControlClass'"
	[+] // PushButton ShowReport
		[ ] // locator "Show Report"
	[+] // VerticalScrollBar VerticalScrollBar
		[ ] // locator "//VerticalScrollBar"
	[+] // MainWin xWindow
		[ ] // locator "//MainWin"
	[+] // MainWin xWindow2
		[ ] // locator "[2]"
[+] Window MainWin AssetAllocation2
	[ ] locator "Asset Allocation"
	[+] ComboBox ComboBox
		[ ] locator "//ComboBox"
	[+] Control DAteRange
		[ ] locator "D&ate range:"
	[+] PushButton HideGraph
		[ ] locator "Hide Graph"
	[+] ListBox ListBox
		[ ] locator "//ListBox"
	[+] ListBox ListBox2
		[ ] locator "[2]"
	[+] Control Panel
		[ ] locator "Panel"
	[+] Control QW_BAG_TOOLBAR
		[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
	[+] Control QW_MAIN_TOOLBAR
		[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
	[+] Control QWCustomizeBar
		[ ] locator "@windowClassName='QWCustomizeBar'"
	[+] Control QWGraphControlClass
		[ ] locator "@windowClassName='QWGraphControlClass'"
	[+] PushButton ShowReport
		[ ] locator "Show Report"
	[+] VerticalScrollBar VerticalScrollBar
		[ ] locator "//VerticalScrollBar"
	[+] MainWin xWindow
		[ ] locator "//MainWin"
	[+] MainWin xWindow2
		[ ] locator "[2]"
	[ ] 
[+] window PushButton AcceptAll
	[ ] locator "*Accept All*"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[+] window DialogBox QuickenException
	[ ] locator "Quicken*Unexpected Error*"
	[+] PushButton DontSend
		[ ] locator "Don't Send"
[ ] 
[ ] //To handle Low Screen Resolution notification//
[+] window MainWin LowScreenResolution
	[ ] locator "//MainWin[@caption='Low screen resolution']"
	[+] PushButton OK
		[ ] locator "OK"
		[ ] 
	[+] CheckBox Dontshowthisagain
		[ ] locator "@windowid='205'"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] // File > File Operations > Validate and Repair > Notepad
[+] window MainWin Notepad
	[ ] locator "/MainWin[@caption='DATA_LOG*' or @caption='*Notepad']"
	[ ] // locator "/MainWin[@caption='*Notepad']"
	[ ] 
	[+] Menu File
		[ ] locator "File"
	[+] MenuItem New
		[ ] locator "New"
	[+] MenuItem Open
		[ ] locator "Open"
	[+] MenuItem Save
		[ ] locator "Save"
	[+] MenuItem SaveAs
		[ ] locator "Save As"
	[+] MenuItem MenuItem
		[ ] locator "[5]"
	[+] MenuItem PageSetup
		[ ] locator "Page Setup"
	[+] MenuItem Print
		[ ] locator "Print"
	[+] MenuItem MenuItem8
		[ ] locator "[8]"
	[+] MenuItem Exit
		[ ] locator "Exit"
	[+] Menu Edit
		[ ] locator "Edit"
	[+] MenuItem Undo
		[ ] locator "Undo"
	[+] MenuItem MenuItem11
		[ ] locator "[11]"
	[+] MenuItem Cut
		[ ] locator "Cut"
	[+] MenuItem Copy
		[ ] locator "Copy"
	[+] MenuItem Paste
		[ ] locator "Paste"
	[+] MenuItem Delete
		[ ] locator "Delete"
	[+] MenuItem MenuItem16
		[ ] locator "[16]"
	[+] MenuItem Find
		[ ] locator "Find"
	[+] MenuItem FindNext
		[ ] locator "Find Next"
	[+] MenuItem Replace
		[ ] locator "Replace"
	[+] MenuItem GoTo
		[ ] locator "Go To"
	[+] MenuItem MenuItem21
		[ ] locator "[21]"
	[+] MenuItem SelectAll
		[ ] locator "Select All"
	[+] MenuItem TimeDate
		[ ] locator "@caption='Time/Date'"
	[+] Menu Format
		[ ] locator "Format"
	[+] MenuItem WordWrap
		[ ] locator "Word Wrap"
	[+] MenuItem Font
		[ ] locator "Font"
	[+] Menu View
		[ ] locator "View"
	[+] MenuItem StatusBar
		[ ] locator "Status Bar"
	[+] Menu Help
		[ ] locator "Help"
	[+] MenuItem ViewHelp
		[ ] locator "View Help"
	[+] MenuItem AboutNotepad
		[ ] locator "About Notepad"
	[+] TextField TextField1
		[ ] locator "//TextField"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[+] window MainWin Quicken
	[ ] locator "Quicken"
	[+] CheckBox RemindMeLater
		[ ] locator "Remind me later"
	[+] Control Panel
		[ ] locator "@windowid='-1'"	
		[+] Control QWMsHtmlVw1
			[ ] locator "@windowid='1000'"	
			[+] Control ShellEmbedding1
				[ ] locator "@windowid='0'"	
				[+] Control ShellDocObjectView1
					[ ] locator "@windowid='0'"	
					[+] Control InternetExplorer_Server1
						[ ] locator "@windowid='0'"	
[+] window DialogBox DlgCustomDate
	[ ] locator "Custom Date"
	[+] TextField FromTextField
		[ ] locator "[@windowid='68' or @windowid='360']"	
	[+] TextField ToTextField
		[ ] locator "[@windowid='71' or @windowid='361']"	
	[+] PushButton OKButton
		[ ] locator "@windowid='32767'"	
	[+] PushButton CancelButton
		[ ] locator "@windowid='32766'"	
[+] window MainWin wReport
	[ ] locator "@windowClassName='QWinPopup'"
	[+] Control Control12000
		[ ] locator "@windowid='12000'"	
	[+] Control HideReport
		[ ] locator "@windowid='86'"	
	[+] Control HideGraph
		[ ] locator "@windowid='88'"	
	[+] Control Back
		[ ] locator "@windowid='63'"	
	[+] Control History
		[ ] locator "@windowid='91'"	
	[+] Control ForWard
		[ ] locator "@windowid='64'"	
	[+] Control PRint
		[ ] locator "@windowid='57'"	
	[+] Control SaveReport
		[ ] locator "@windowid='54'"	
	[+] Control FindReplace
		[ ] locator "@windowid='50'"	
	[+] Control CUstomize
		[ ] locator "@windowid='58'"	
	[+] MainWin MainWin73
		[ ] locator "@windowid='73'"	
		[+] ListBox ListBox1
			[ ] locator "@windowid='1'"	
	[+] Control Control5000
		[ ] locator "@windowid='5000'"	
		[+] Control DAteRange
			[ ] locator "@windowid='10'"	
		[+] ComboBox ComboBox1000
			[ ] locator "@windowid='1000'"	
		[+] Control InterVal
			[ ] locator "@windowid='30'"	
		[+] ComboBox ComboBox1011
			[ ] locator "@windowid='1011'"	
	[+] Control Control87
		[ ] locator "@windowid='87'"	
	[+] PushButton OK
		[ ] locator "@windowid='32767'"	
	[+] MainWin QWListViewer1
		[ ] locator "@windowid='73'"	
		[+] ListBox ListBox1
			[ ] locator "@windowid='1'"	
	[+] Control QWCustomizeBar1
		[ ] locator "@windowid='5000'"	
		[+] Control DateRange
			[ ] locator "@windowid='10'"	
		[+] ComboBox PopupList1
			[ ] locator "@windowid='1000'"	
		[+] Control Column
			[ ] locator "@windowid='30'"	
		[+] ComboBox PopupList2
			[ ] locator "[@windowid='1010' or @windowid='1011']"	
	[+] PushButton Edit
		[ ] locator "Edit"	
	[+] PushButton ExpandAll
		[ ] locator "@windowid='99'"	
	[+] PushButton CollapseAll
		[ ] locator "@windowid='101'"	
	[+] Control ShowReport
		[ ] locator "@windowid='86'"	
	[ ] 
[+] window Control TaxDlg
	[ ] locator "*File*"
[+] window DialogBox CreateTaxExportFile
	[ ] locator "Create Tax Export File"
[ ] 
[+] window BrowserWindow BrowserWindow1
	[ ] locator "/Control[@caption='Quicken 201*']//BrowserWindow"
	[+] DomElement DIV
		[ ] locator "//DIV[@id='content-wrapper']/DIV[2]"
	[+] DomElement Zone1
		[ ] locator "DIV[@id='zone1']"
[ ] 
[ ] 
[ ] 
[-] //************* File *************************************************************
	[ ] // -----File > New Quicken File----------------
	[+] window DialogBox CreateNewFile
		[ ] locator "//DialogBox[@caption='Create New File']"
		[ ] 
		[+] PushButton OK
			[ ] // locator "@windowid='32767'" //PushButton[@caption='OK']
			[ ] locator "OK"
		[+] StaticText CreateNewFileText
			[ ] locator "@windowid='32702'"
		[+] RadioList NewQuickenFile
			[ ] locator "@windowid='101'"
		[+] RadioList NewQuickenAccount
			[ ] locator "@windowid='102'"
		[+] StaticText ANewCollectionOfAccounts
			[ ] locator "@windowid='111'"
		[+] StaticText AddANewAccountSuchAsASi
			[ ] locator "@windowid='112'"
		[+] MainWin MainWin32765
			[ ] locator "@windowid='32765'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[ ] 
	[ ] 
	[ ] 
	[ ] //------File > Open Quicken File----------------
	[+] window DialogBox OpenQuickenFile
		[ ] locator "//DialogBox[@caption='Open Quicken File']"
		[+] ListView ListView1
			[ ] locator "@windowid='1'"
		[+] PushButton OK
			[ ] locator "@windowid='1'"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton Help
			[ ] locator "Help"
		[+] ComboBox FileName
			[ ] locator "@windowid='1148'"
	[ ] 
	[ ] //------File > Save a Copy as----------------
	[-] window DialogBox CopyQuickenFileBrowser
		[ ] locator "//DialogBox[@caption='Copy Quicken File']"
		[+] ComboBox SaveInComboBox
			[ ] locator "Save in:"
		[+] ComboBox FileNameComboBox
			[ ] //2015-08-14 KalyanG: Updated locator. Ref Build 25.1.1.1
			[ ] // locator "File name:"
			[ ] locator "ComboBox/TextField/.."
		[+] ComboBox SaveAsTypeComboBox
			[ ] locator "Save as type:"
		[+] PushButton OK
			[ ] locator "OK"
		[ ] //2015-08-14 KalyanG: added save button. Ref Build 25.1.1.1
		[+] PushButton Save
			[ ] locator "Save"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] TextField FileName
			[ ] locator "@windowid='1001'"
		[ ] 
		[ ] 
	[ ] 
	[ ] //------File > Set Password for this data file----------------
	[+] window DialogBox QuickenFilePassword
		[ ] locator "//DialogBox[@caption='Quicken File Password']"
		[+] TextField NewPasswordTextField
			[ ] locator "New Password:"
		[+] TextField ConfirmPasswordTextField
			[ ] locator "Confirm Password:"
		[+] PushButton OK
			[ ] locator "OK"
		[+] Control Cancel
			[ ] locator "Cancel"
		[+] PushButton Close
			[ ] locator "@windowid='1010'"
			[ ] 
	[ ] //------File > Set Password for this data file----------------    Added by Abhijit S Feb 2015
	[+] window DialogBox ManageDataFilePassword
		[ ] locator "//DialogBox[@caption='Manage Data File Password']"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Change
			[ ] locator "@windowid='1029'"
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
		[+] Control Cancel
			[ ] locator "Cancel"
		[+] RadioList UseMyIntuitIDPassword
			[ ] locator "//RadioList[@caption='Use my Intuit ID password']"
		[+] TextField IntuitIDPassword
			[ ] locator "@windowid='1026'"
		[+] PushButton ForgotPassword
			[ ] locator "@windowid='1099'"
		[+] PushButton IntuitForgotPassword
			[ ] locator "@windowid='1111'"
			[ ] 
		[+] RadioList UseMyCustomPassword
			[ ] locator "//RadioList[@caption='Use my Custom password']"
		[+] TextField CreateNewPassword
			[ ] locator "Create New Password"
		[+] TextField ConfirmPassword
			[ ] locator "Confirm Password"
		[+] RadioList IDoNotWantToUseDataFilePassword
			[ ] locator "//RadioList[@caption='I do not want to use data file password']"
		[+] TextField ExistingPassword
			[ ] locator "@windowid='1031'"
	[ ] //------File > Set Password to modify transactions----------------
	[+] window DialogBox PasswordToModifyExistingTransactions
		[ ] locator "//DialogBox[@caption='Password to Modify Existing Transactions']"
		[+] StaticText PasswordText
			[ ] locator "Password:"
		[+] TextField Password
			[ ] locator "Password:"
		[+] StaticText ConfirmPasswordText
			[ ] locator "Confirm Password:"
		[+] TextField ConfirmPassword
			[ ] locator "Confirm Password:"
		[+] StaticText RequiredForDatesThroughTex
			[ ] locator "Required For Dates Through:"
		[+] TextField RequiredForDatesThrough1
			[ ] locator "Required For Dates Through:"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] Control RequiredForDatesThrough2
			[ ] locator "[@priorlabel='Required For Dates Through*'][2]"
		[+] Control  RequiredForDatesThrough3
			[ ] locator "[@priorlabel='Required For Dates Through*'][4]"
	[+] window DialogBox OperationFailed //------------    Added by Abhijit S May 2015
		[ ] locator "@caption = 'Quicken 20*'"
		[+] StaticText WrongPassword
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
			[ ] 
	[+] window DialogBox ChangePassword		//------------    Added by Abhijit S May 2015
		[ ] locator "@caption='Change Password'"
		[+] StaticText OldPassword
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
		[ ] 
	[ ] 
	[ ] //------File > Backup and Restore> Backup Quicken File----------------
	[+] window MainWin QuickenBackup
		[ ] locator "//MainWin[@caption='Quicken Backup']"
		[+] CheckBox AddDateToBackupFileName
			[ ] locator "@windowid='258'"
		[+] RadioList ThisMayHelpYouIdentifyThe2
			[ ] locator "@windowid='251'"
		[+] ComboBox BackupFile
			[ ] locator "@windowid='245'"
			[+] TextField BackupFileTextField
				[ ] locator 'Backup File:'
			[ ] 
		[+] PushButton Change
			[ ] locator "@windowid='246'"
		[+] Control ProtectAllYourMostImportan2
			[ ] locator "@windowid='257'"
		[+] Control ProtectAllYourMostImportan3
			[ ] locator "@windowid='249'"
		[+] PushButton BackupFileName
			[ ] locator "@windowid='32765'"
		[+] PushButton BackUpNow
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control Backup1
			[ ] locator "@windowid='32767'"
		[+] PushButton Exit
			[ ] locator "@windowid='32762'"
		[+] PushButton Cancel1
			[+] locator "@windowid='32766'"
				[ ] 
				[ ] 
		[+] DialogBox DuplicateBackupFile
			[ ] locator "Quicken 20*"
			[+] StaticText ThereIsAFileWithTheSame
				[ ] locator "There is a file with the same file name in the backup directory or disk. Do you want to overwrite it?"
			[+] CheckBox DonTShowAgain
				[ ] locator "Don't show again."
			[+] PushButton Yes
				[ ] locator "Yes, Overwrite Existing"
			[+] PushButton CancelButton
				[ ] locator "@windowid='32766'"
			[ ] 
		[+] RadioList RadioButtonBackUpType
			[ ] locator "@windowid='251'"
			[ ] 
		[+] DialogBox Quicken2012
			[ ] locator "Quicken 20*"
			[+] Control Control105
				[ ] locator "@windowid='105'"
			[+] StaticText FolderDQuickenApplicationS
				[ ] locator "@windowid='100'"
			[+] PushButton Yes
				[ ] locator "@windowid='101'"
			[+] PushButton No
				[ ] locator "@windowid='102'"
		[ ] //Added by Mukesh
		[+] StaticText CurrentDataFileNameText
			[ ] locator "Current data file name: "
		[+] StaticText CurrentDataFileNameValueText
			[ ] locator "@windowid='239'"
		[+] StaticText BackupFileNameText
			[ ] locator "Backup file name: "
		[+] StaticText BackupFileNameValueText
			[ ] locator "@windowid='241'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] DialogBox DlgEnterBackupFileName
			[ ] locator "//DialogBox[@caption='Enter backup file name']"
			[ ] 
			[ ] // 2015-08-17 KalyanG: updated locators for textfield and OK button
			[ ] // Ref build 25.1.1.3
			[+] TextField FileTextField
				[ ] locator "[@windowid='1001']"
			[+] PushButton OKButton
				[ ] locator "//PushButton[@caption='OK' or @caption='Save']"
		[ ] 
		[ ] // File > Backup and Restore> Backup Quiken File > Use Quicken Online Backup > Quicken Online Backup
		[+] MainWin QuickenOnlineBackup
			[ ] locator "//MainWin[@caption='Quicken Backup']//MainWin[@caption='Quicken Online Backup']"
			[+] RadioList IWouldLikeToLearnMore
				[ ] locator "I would like to learn more."
			[+] Control OK
				[ ] locator "OK"
			[+] Control Cancel
				[ ] locator "Cancel"
	[ ] 
	[ ] //------File > Backup and Restore> Restore from Backup File > Restore from online backup                //Still need to be converted in Open Agent as it having defect QW-1719
	[ ] 
	[+] window DialogBox DlgRestoreQuickenFile
		[ ] locator "Restore Quicken File"
		[+] ComboBox FilesNameComboBox
			[ ] locator "File name:"
			[+] TextField FilesNameTextField
				[ ] locator "@windowid='1148'"
			[ ] 
		[+] PushButton OKButton
			[ ] //locator "OK"
			[ ] locator "@windowid='1'"
		[+] ComboBox FilesOfTypeComboBox
			[ ] // 2015-08-14: KalyanG updated locator, ref build 25.1.1.1
			[ ] // locator "Files of type:"
			[ ] locator "[@windowid=1136]"
			[ ] 
	[ ] 
	[ ] //------Backup Quicken File > Backup now > Backup Confirmation----------------
	[+] window MainWin BackupConfirmation
		[ ] locator "//MainWin[@caption='Quicken Backup']"
		[+] StaticText QuickenBackup
			[ ] locator "Quicken Backup"
		[+] StaticText Message
			[ ] //locator "Quicken data file backed up successfully."
			[ ] locator "[@windowid='100' or @windowid='267']"
		[+] Control QWIconDisplay
			[ ] locator "@windowClassName='QWIconDisplay'"
		[+] CheckBox DonTShowAgain
			[ ] locator "Don't show again."
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton BackupButton
			[ ] locator "@windowid='32767'"
		[+] PushButton Yes
			[ ] locator "Yes"
		[ ] 
	[ ] 
	[ ] //------File > Backup and Restore> Restore from Backup File----------------
	[+] // // // window MainWin QuickenRestore
		[ ] // // // locator "Restore from backup file"
		[+] // // // RadioList RestoreFromBackupFile
			[ ] // // // locator "Restore from automatic backups"
		[+] // // // // RadioList RestoreFromYourBackup
			[ ] // // // // locator "Restore from your backup"
		[+] // // // // RadioList RestoreFromOnlineBackup
			[ ] // // // // locator "Restore from online backup"
		[+] // // // Control OpenBackupDirectory
			[ ] // // // locator "Open backup &directory"
		[+] // // // ListBox ListBox1
			[ ] // // // locator "//ListBox"
		[+] // // // TextField BackupFilePath
			[ ] // // // locator "Periodic backups created automatically by Quicken."
		[+] // // // MainWin Browse
			[ ] // // // locator "B&rowse ..."
		[+] // // // StaticText RequiresQuickenOnlineBackup1
			[ ] // // // locator "Requires Quicken Online Backup service."
		[+] // // // Control RequiresQuickenOnlineBackup2
			[ ] // // // locator "@priorlabel='Requires Quicken Online Backup service.'"
		[+] // // // PushButton RestoreBackup
			[ ] // // // //locator "Restore Backup"
			[ ] // // // locator "@windowid='32767'"
		[+] // // // PushButton Cancel
			[ ] // // // //locator "Cancel"
			[ ] // // // locator "@windowid='32766'"
		[+] // // // MainWin RestoreOpenFile
			[ ] // // // locator "Restore from backup file"
			[+] // // // RadioList OverwriteTheOpenFileWithR
				[ ] // // // locator "Overwrite the existing file with restored file"
			[+] // // // // RadioList CreateaCopy
				[ ] // // // // locator "Create a copy"
			[+] // // // Control HelpIcon
				[ ] // // // locator "@priorlabel='NewData.QDF'"
			[+] // // // Control RestoreBackup
				[ ] // // // locator "Restore Backup"
			[+] // // // Control Cancel
				[ ] // // // locator "Cancel"
		[ ] // // // 
		[ ] // // // 
		[+] // // // PushButton Yes
			[ ] // // // locator "@windowid='32767'"
		[+] // // // PushButton No
			[ ] // // // locator "@windowid='32766'"
		[+] // // // PushButton RestoreBackup1
			[ ] // // // locator "@windowid='32767'"
		[+] // // // PushButton Cancel1
			[ ] // // // locator "@windowid='32766'"
		[+] // // // CustomWin YesRestore
			[ ] // // // multitag "[QC_button]Yes|^Would you like to open the restored file now?[1]"
		[ ] // // // 
		[ ] // // // 
		[ ] // // // 
		[ ] // // // 
		[ ] // // // 
	[ ] 
	[ ] //------File > File Operations > Validate and Repair----------------
	[+] // window DialogBox ValidateAndRepair
		[ ] // locator "//DialogBox[@caption='Validate and re.pair your Quicken file']"
		[+] // Control ValidateAndRepairYourQuick2
			[ ] // locator "@windowid='65535'"
		[+] // PushButton Browse
			[ ] // locator "@windowid='316'"
		[+] // Control SmokeTestQDF1
			[ ] // locator "@windowid='65535'"
		[+] // CheckBox ValidateFile
			[ ] // locator "@windowid='312'"
		[+] // Control SmokeTestQDF
			[ ] // locator "@windowid='319'"
		[+] // Control WeRecommendThatYouValidate2
			[ ] // locator "@windowid='65535'"
		[+] // Control SmokeTestQDF2
			[ ] // locator "@windowid='65535'"
		[+] // CheckBox RebuildInvestingLots
			[ ] // locator "@windowid='313'"
		[+] // Control WeRecommendThatYouValidate3
			[ ] // locator "@windowid='320'"
		[+] // Control ThisTakesAFewMinutesToCo2
			[ ] // locator "@windowid='65535'"
		[+] // CheckBox ResetAllQuickenPrinterSett
			[ ] // locator "@windowid='311'"
		[+] // PushButton OK
			[ ] // locator "@windowid='32767'"
		[+] // PushButton Cancel
			[ ] // locator "@windowid='32766'"
		[+] // PushButton FileToValidateAndRepair
			[ ] // locator "@windowid='32765'"
		[+] // PushButton ValidateRepairLog
			[ ] // locator "@windowid='325'"
		[+] // CheckBox DeleteInvestingPriceHistory
			[ ] // locator "@windowid='326'"
	[ ] 
	[+] window MainWin ValidateAndRepair
		[ ] locator "Validate and Repair your Quicken file"
		[+] PushButton Browse
			[ ] locator "@windowid='316'"
		[+] StaticText FileToValidate
			[ ] locator "@windowid='317'"
		[+] CheckBox ValidateFile
			[ ] locator "Validate file"
		[+] Control ValidateYourQuickenDataFileIfYouSuspectDataDamage
			[ ] locator "@priorlabel='Validate your Quicken data file if you suspect data damage.'"
		[+] CheckBox RebuildInvestingLots
			[ ] //locator "Rebuild investing lots"
			[ ] locator "@windowid='313'"
		[+] Control ThisTakesaFewMinutesToComplete
			[ ] locator "@priorlabel='This takes a few minutes to complete. If errors are found, your cost basis valuations could change.'"
		[+] CheckBox DeleteInvestingPriceHistory
			[ ] //locator "Delete investing price history"
			[ ] locator "@windowid='326'"
			[ ] 
		[+] Control DeleteYourInvestingPriceHistor
			[ ] locator "[@priorlabel='Delete your investing price history only if you suspect data damage. Your price history will be rebuilt after deletion, but prices older than five years will be lost.'][1]"
		[+] CheckBox ResetAllQuickenPrinterSettings
			[ ] //locator "Reset all Quicken printer settings"
			[ ] locator "@windowid='311'"
		[+] PushButton OK
			[ ] //locator "OK"
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] //locator "Cancel"
			[ ] locator "@windowid='32766'"
		[+] PushButton HelpButton
			[ ] //locator "@priorlabel='File to validate and repair:'"
			[ ] locator "@windowid='32765'"
	[ ] 
	[ ] 
	[ ] 
	[ ] // File > Open last year data file > Data Conversion wizard
	[+] window MainWin DataConversionWizard
		[ ] locator "//MainWin[@caption='Convert Your Data']"
		[ ] 
		[+] // Control Control213
			[+] // multitag "[Control]$213"
				[ ] // "[Control]&windowClassName=QWSeparator"
		[+] // CustomWin Control207
			[+] // multitag "[Control]$207"
				[ ] // "[Control]&windowClassName=QWSeparator"
		[+] // CustomWin Control32765
			[+] // multitag "[Control]$32765"
				[ ] // "[Control]&windowClassName=QC_button"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton ConvertFile
			[ ] locator "@windowid='32767'"
	[ ] 
	[+] window DialogBox DuplicateBackupFile
		[ ] locator "Quicken 20*"
		[+] CheckBox DonTShowAgain
			[ ] locator "Don't show again."
		[+] PushButton Yes
			[ ] locator "Yes, Overwrite Existing"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[ ] 
	[ ] 
	[ ] 
	[ ] //------File > File Export > QIF File----------------
	[+] window DialogBox QIFExportPopUp
		[ ] locator "QIF Export"
		[+] StaticText QIFExportText
			[ ] locator "@windowid='32702'"
		[+] StaticText QIFFileToExportToText
			[ ] locator "@windowid='117'"
		[+] TextField QIFFileToExportTo
			[ ] locator "@windowid='100'"
		[+] TextField DateFrom
			[ ] locator "@windowid='110'"
		[+] TextField DateTo
			[ ] locator "@windowid='111'"
		[+] PushButton Browse
			[ ] locator "@windowid='106'"
		[+] ComboBox QuickenAccountToExportFrom
			[ ] locator "@windowid='2302'"
		[+] CheckBox Transactions
			[ ] locator "@windowid='102'"
		[+] CheckBox AccountList
			[ ] locator "@windowid='103'"
		[+] CheckBox CategoryList
			[ ] locator "@windowid='104'"
		[+] CheckBox MemorizedPayees
			[ ] locator "@windowid='105'"
		[+] CheckBox ForQuickenMac
			[ ] locator "@windowid='112'"
		[+] CheckBox SecurityLists
			[ ] locator "@windowid='113'"
		[+] CheckBox BusinessLists
			[ ] locator "@windowid='114'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton HelpIcon
			[ ] locator "@windowid='32765'"
		[ ] 
	[ ] 
	[ ] //------File > File Import > QIF File----------------
	[+] window DialogBox QIFImportPopUp
		[ ] locator "/WPFWindow[@caption='Quicken 20*']//DialogBox[@caption='QIF Import']" 
		[+] StaticText QIFImportText
			[ ] locator "@windowid='32702'"
		[+] StaticText LocationOfQIFFileText
			[ ] locator "@windowid='117'"
		[+] TextField LocationOfQIFFileTextField
			[ ] locator "@windowid='100'"
		[ ] 
		[+] Control LocationOfQIFFile2
			[ ] locator "@windowid='32180'"
		[+] StaticText QuickenAccountToImportInto1
			[ ] locator "@windowid='65535'"
		[+] ComboBox QuickenAccountToImportInto
			[ ] locator "@windowid='2302'"
		[+] Control QIFImport
			[ ] locator "@windowid='1017'"
		[+] CheckBox Transactions
			[ ] locator "@windowid='102'"
		[+] CheckBox AccountList
			[ ] locator "@windowid='103'"
		[+] CheckBox CategoryList
			[ ] locator "@windowid='104'"
		[+] CheckBox MemorizedPayees
			[ ] locator "@windowid='105'"
		[+] CheckBox SpecialHandlingForTransfers
			[ ] locator "@windowid='2304'"
		[+] CheckBox BusinessLists
			[ ] locator "@windowid='114'"
		[ ] 
		[+] PushButton Import
			[ ] locator "@windowid='32764'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton Done
			[ ] locator "@windowid='32767'"
		[+] PushButton Browse
			[ ] locator "@windowid='106'"
		[+] PushButton HelpIcon
			[ ] locator "@windowid='32765'"
		[ ] 
		[ ] 
		[+] CheckBox SecurityLists
			[ ] locator "@windowid='113'"
		[+] StaticText QIFImportSuccessfulText
			[ ] locator "@windowid='1001'"
	[ ] 
	[ ] //------File > File Import > QXF File----------------
	[+] window MainWin QXFImportPopUp
		[ ] locator "Import .QXF File" 
		[ ] 
		[+] TextField SelectTheQXFFileToImportTextField
			[ ] locator "@windowid='1005'"
		[ ] 
		[+] StaticText NoteText
			[ ] locator "@windowid='1002'" 
		[ ] 
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton Continue
			[ ] locator "@windowid='32767'"
		[+] PushButton Browse
			[ ] locator "@windowid='1006'"
		[+] PushButton HelpIcon
			[ ] locator "@windowid='32765'"
		[ ] 
	[ ] 
	[ ] //------File > File Import > QXF File > Logs on successful import----------------
	[+] window MainWin QXFImportLogs
		[ ] locator "//MainWin[@caption='*\AppData\Roaming\Intuit\Quicken\Log\Quicken_QXF_Import_Results.htm']"
		[ ] 
	[ ] 
	[ ] 
	[+] window DialogBox QIFImportPopUpSuccessful
		[ ] locator "/WPFWindow[@caption='Quicken 20*']//DialogBox[@caption='QIF Import'][2]" 
		[+] PushButton Done
			[ ] locator "Done"
	[ ] 
	[ ] //------File > File Import > Web Connect File-----------------
	[+] window DialogBox ImportDownloadedTransactions
		[ ] locator "Import Downloaded Transactions"
		[+] StaticText ImportDownloadedTransactions
			[ ] locator "Import Downloaded Transactions"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton Import
			[ ] locator "Import"
		[+] StaticText BankOfAmericaCaliforniaLabel
			[ ] locator "*Bank of America - California"
		[+] StaticText Checking000448506152
			[ ] locator "Checking*"
		[+] RadioList CreateANewAccount
			[ ] locator "Create a new account"
		[+] ComboBox ComboBox206
			[ ] locator "[@caption='Checking*'][1]"
		[+] TextField Checking000448506152TextField
			[ ] locator "Checking*"
		[+] StaticText UsedMostlyForText
			[ ] locator "Used mostly for"
		[+] ComboBox ComboBox221
			[ ] locator "[@caption='Checking*'][2]"
		[+] StaticText NicknameText
			[ ] locator "Nickname"
		[+] RadioList LinkToAnExistingAccount
			[ ] locator "Link to an existing account:"
		[+] ComboBox Nickname
			[ ] locator "Nickname"
		[+] Control Panel2
			[+] RadioList CreateANewAccount
				[ ] locator "@windowid='200'"
			[+] ComboBox ComboBox206
				[ ] locator "@windowid='206'"
			[+] TextField TextField
				[ ] locator "@windowid='208'"
			[+] ComboBox ComboBox221
				[ ] locator "@windowid='221'"
			[+] RadioList LinkToAnExistingAccount
				[ ] locator "@windowid='201'"
			[+] ComboBox Nickname
				[ ] locator "@windowid='202'"
		[+] Control NewAccountDetails
			[ ] // locator "[@windowid='-1'][2]"
			[+] RadioList RadioList1
				[ ] locator "@windowid='200'"
			[+] PopupList PopupList1
				[ ] locator "@windowid='206'"
			[+] TextField TextField1
				[ ] locator "@windowid='208'"
			[+] StaticText UsedMostlyForText
				[ ] locator "Used mostly for"
			[+] PopupList PopupList2
				[ ] locator "@windowid='221'"
			[+] StaticText NicknameText
				[ ] locator "Nickname"
			[+] RadioList Nickname1
				[ ] locator "Nickname"
			[+] PopupList Nickname2
				[ ] locator "Nickname"
		[ ] 
	[ ] 
	[ ] 
	[ ] // File > File Import > Web Connect File
	[+] window DialogBox ImportExportQuickenFile
		[ ] locator "* File"
		[+] // ComboBox FileName
			[ ] // locator "@windowid='1148'"
		[+] TextField FileName
			[ ] locator "[@windowid='1001' or @windowid='1148']"
		[+] PushButton OK
			[ ] locator "[@windowid='1' or @caption='Save']"
		[+] ListView ListView1
			[ ] locator "@windowid='1'"
		[+] PushButton Cancel
			[ ] locator "@windowid='2'"
		[+] PushButton Help
			[ ] locator "@windowid='1038'"
		[+] Control Control
			[ ] locator "@windowid='32770'"
		[+] DialogBox DuplicateFileMsg
			[ ] locator "Quicken 20*"
			[+] Control Control105
				[ ] locator "@windowid='105'"
			[+] StaticText TheFileSmokeAlreadyExist
				[ ] locator "@windowid='100'"
			[+] PushButton OK
				[ ] locator "@windowid='101'"
		[+] PushButton YesButton
			[ ] locator "@windowid='101'"
		[+] PushButton Open
			[ ] locator "//PushButton[@caption='Open']"
			[ ] //locator "@windowid='1'"
		[+] ComboBox SaveAsType
			[ ] locator "@caption='Files of type:' or @caption='Save as type:' or @SelectedItem='QXF Files'"
		[ ] 
		[+] // ComboBox SaveAsType
			[ ] // locator "@caption='Files of type:' or @caption='Save as type:'"
		[ ] 
	[ ] 
	[ ] 
	[ ] //------File > File Import > Import security prices from CSV file-----------------
	[+] window DialogBox ImportPriceData
		[ ] locator "//DialogBox[@caption='Import Price Data']"
		[+] StaticText ImportPriceDataText
			[ ] locator "@windowid='32702'"
		[+] StaticText FileText
			[ ] locator "@windowid='65535'"
		[+] StaticText FileNameOrFullPathText
			[ ] locator "@windowid='101'"
		[+] StaticText N1Text
			[ ] locator "@windowid='65535'"
		[+] TextField File
			[ ] locator "@windowid='103'"
		[+] PushButton Browse
			[ ] locator "@windowid='106'"
		[+] StaticText DateText
			[ ] locator "@windowid='65535'"
		[+] StaticText IfNotSpecifiedText
			[ ] locator "@windowid='102'"
		[+] StaticText N2Text
			[ ] locator "@windowid='65535'"
		[+] TextField TextField2
			[ ] locator "@windowid='104'"
		[+] PushButton xDate
			[ ] locator "@windowid='32765'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control IfNotSpecified
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[ ] 
	[ ] 
	[ ] //------File > File Import > Renatal Property Manager version 2 Data----------------
	[+] window DialogBox ImportRPMDataFile
		[ ] locator "Import RPM Data File "
		[+] StaticText Step1Of4SelectTheDataF1
			[ ] locator "@windowid='32702'"
		[+] TextField Step1Of4SelectTheDataF2
			[ ] locator "@windowid='18522'"
		[+] PushButton Browse
			[ ] locator "@windowid='18521'"
		[+] PushButton WhereIsMyRentalPropertyMa
			[ ] locator "@windowid='18523'"
		[+] PushButton Next
			[ ] locator "@windowid='18526'"
		[+] PushButton Step1Of4SelectTheDataF3
			[ ] locator "@windowid='32765'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control Panel
			[ ] locator "@windowid='-1'"
			[+] Control QWMsHtmlVw1
				[ ] locator "@windowid='1000'"
				[+] Control ShellEmbedding1
					[ ] locator "@windowid='0'"
					[+] Control ShellDocObjectView1
						[ ] locator "@windowid='0'"
						[+] Control InternetExplorer_Server1
							[ ] locator "@windowid='0'"
		[+] StaticText HelpText
			[ ] locator "@windowid='32706'"
		[ ] 
	[ ] 
	[+] window DialogBox CopyFile
		[ ] locator "//DialogBox[@caption='Copy File' or @caption='File Copied']"
		[+] StaticText CopyFileText
			[ ] locator "Copy File"
		[+] TextField SpecifyADiskDriveAndPath2
			[ ] locator "@windowid='121'"
		[+] PushButton Browse
			[ ] locator "Browse"
		[+] TextField IncludeTransactionsFrom1
			[ ] locator "Include Transactions From*"
		[+] TextField To1
			[ ] locator "To:"
		[+] CheckBox IncludeAllPriorUnclearedTxn
			[ ] locator "Include All Prior Uncleared Transactions"
		[+] CheckBox IncludeAllPriorInvestmentTxn
			[ ] locator "Include All Prior Investment Transactions"
		[ ] 
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] StaticText WhichFileWouldYouLikeToU1
			[ ] locator "@windowid='65535'"
		[+] RadioList RadioListOriginalfile
			[ ] locator "Original file"
		[+] RadioList RadioListNewcopy
			[ ] locator "New copy"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] TextField FromDate
			[ ] locator "@windowid='123'"
		[+] TextField ToDate
			[ ] locator "@windowid='124'"
		[+] PushButton YesButton
			[ ] locator "Yes"
		[+] PushButton NoButton
			[ ] locator "No"
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox AddressRecords
		[ ] locator "*Address Records"
		[+] Control SelectTheFieldsToBeExport
			[ ] locator "@windowid='32100'"
		[+] StaticText QuickenFieldsText
			[ ] locator "@windowid='65535'"
		[+] ListBox QuickenFields
			[ ] locator "@caption='Quicken Fields'"
		[+] PushButton Add
			[ ] locator "@windowid='4441'"
		[+] PushButton Remove
			[ ] locator "@windowid='4442'"
		[+] StaticText FieldsToBeExportedText
			[ ] locator "@windowid='65535'"
		[+] ListBox FieldsToBeExported
			[ ] locator "@windowid='4422'"
		[+] PushButton Done
			[ ] locator "@windowid='32764'"
		[+] PushButton Back
			[ ] locator "@windowid='32763'"
		[+] PushButton QC_button3
			[ ] locator "@windowid='32765'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] TextField File3
			[ ] locator "@windowid='4433'"
		[+] PushButton Next
			[ ] locator "@windowid='32764'"
		[ ] 
	[ ] 
	[+] window DialogBox ImportAddressRecords
		[ ] locator "Import Address Records"
		[+] RadioList WhichDelimiterWouldYouLike
			[ ] locator "@windowid='4431'"
		[+] PushButton Next
			[ ] locator "@windowid='32764'"
	[ ] 
	[+] window DialogBox CreateAYearEndCopy
		[ ] locator "Create a Year End Copy"
		[+] StaticText CreateAYearEndCopyText
			[ ] locator "@windowid='32702'"
		[+] RadioList Copyoption
			[ ] locator "@windowid='141'"
		[+] // RadioList Copyoption2
			[ ] // locator "@windowid='142'"
		[+] TextField StartingDate
			[ ] locator "@windowid='123'"
		[+] StaticText QuickenWillOnlyRemoveRecon
			[ ] locator "@windowid='65535'"
		[+] StaticText ArchiveDataFileText
			[ ] locator "@windowid='132'"
		[+] StaticText QuickenWillCopyAllYourDat1
			[ ] locator "@windowid='65535'"
		[+] TextField FileName
			[ ] locator "@windowid='121'"
		[+] PushButton Browse
			[ ] locator "@windowid='127'"
		[+] TextField IncludingDate
			[ ] locator "@windowid='124'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
	[ ] 
	[+] window DialogBox FileArchived
		[ ] locator "File Archived"
		[+] RadioList OptionforFile
			[ ] locator "@windowid='101'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
	[ ] 
	[+] window MainWin FindQuickenDataFiles
		[ ] locator "Find Quicken Data Files"
		[+] StaticText FindQuickenDataFilesText
			[ ] locator "@windowid='32702'"
		[+] StaticText LookInText
			[ ] locator "@windowid='307'"
		[+] ComboBox LookIn1
			[ ] locator "@windowid='161'"
		[+] PushButton Search
			[ ] locator "@windowid='262'"
		[+] PushButton StopSearching
			[ ] locator "@windowid='263'"
		[+] StaticText FindText
			[ ] locator "@windowid='306'"
		[+] RadioList Find
			[ ] locator "@windowid='260'"
		[+] TextField FindQuickenDataFiles
			[ ] locator "Find Quicken Data Files"
		[+] StaticText N39FilesFoundText
			[ ] locator "@windowid='308'"
		[+] Control FilesFoundQWListViewer
			[ ] locator "@windowid='264'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[ ] 
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] PushButton OpenFile
			[ ] locator "@windowid='233'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] // Data Conversion
	[+] window MainWin ConvertYourData
		[ ] locator "Convert Your Data"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton ConvertFilebutton
			[ ] locator "@windowid='32767'"
	[+] window DialogBox ConvertConfirmation
		[ ] locator"Quicken 2015"
		[+] PushButton Yes
			[ ] locator"windowid=101"
	[+] window MainWin ConvertYourQuickenFile
		[ ] locator "Convert your Quicken file"
		[+] StaticText ErrorText
			[ ] locator "@windowid='32702'"
	[ ] 
	[+] window DialogBox CreateQuickenFile
		[ ] locator "* File"
		[+] ComboBox FileName
			[ ] locator "@windowid='1148'"
		[+] ComboBox FilesOfType
			[ ] locator "@windowid='1136'"
		[+] PushButton OK
			[ ] locator "@windowid='1'"
		[+] PushButton Save
			[ ] locator "@Caption='Save''"
			[ ] 
		[+] ListView ListView1
			[ ] locator "@windowid='1'"
		[+] PushButton Cancel
			[ ] locator "@windowid='2'"
		[+] PushButton Help
			[ ] locator "@windowid='1038'"
		[ ] Control Control
		[+] DialogBox DuplicateFileMsg
			[ ] locator "Quicken 201?"
			[+] Control Control105
				[ ] locator "@windowid='105'"
			[+] StaticText TheFileSmokeAlreadyExist
				[ ] locator "@windowid='100'"
			[+] MainWin OK
				[ ] locator "@windowid='101'"
		[ ] 
	[ ] 
	[+] // window MainWin QuickenRestore
		[ ] // locator "[@caption='Restore from backup file'][1]"
		[+] // RadioList RestoreFromBackupFile
			[ ] // locator "Restore from automatic backups"
		[+] // // RadioList RestoreFromYourBackup
			[ ] // // locator "Restore from your backup"
		[+] // // RadioList RestoreFromOnlineBackup
			[ ] // // locator "Restore from online backup"
		[+] // Control OpenBackupDirectory
			[ ] // locator "Open backup &directory"
		[+] // ListBox ListBox1
			[ ] // locator "//ListBox"
		[+] // TextField BackupFilePath
			[ ] // locator "Periodic backups created automatically by Quicken."
		[+] // PushButton Browse
			[ ] // locator "B&rowse ..."
		[+] // StaticText RequiresQuickenOnlineBackup1
			[ ] // locator "Requires Quicken Online Backup service."
		[+] // Control RequiresQuickenOnlineBackup2
			[ ] // locator "@priorlabel='Requires Quicken Online Backup service.'"
		[+] // PushButton RestoreBackup
			[ ] // locator "Restore Backup"
		[+] // PushButton Cancel
			[ ] // locator "Cancel"
		[+] // StaticText FileLocation
			[ ] // locator "@windowid='295'"
		[+] // StaticText FileName
			[ ] // locator "@windowid='286'"
		[+] // PushButton YesRestore
			[ ] // locator "Yes"
		[+] // PushButton No
			[ ] // locator "No"
		[+] // PushButton Yes
			[ ] // locator "Yes"
		[ ] // 
		[ ] // 
	[ ] 
	[+] window MainWin QuickenRestore
		[ ] locator "Restore from backup file"
		[+] RadioList RestoreFromBackupFile
			[ ] locator "Restore from automatic backups"
		[+] TextField LocationToRestore
			[ ] locator "Choose a location to save your restored file"
		[+] Control OpenBackupDirectory
			[ ] locator "Open backup &directory"
		[+] ListBox ListBox1
			[ ] locator "//ListBox"
		[+] TextField BackupFilePath
			[ ] locator "Periodic backups created automatically by Quicken."
		[+] PushButton Browse
			[ ] locator "Browse ..."
		[+] StaticText RequiresQuickenOnlineBackup1
			[ ] locator "Requires Quicken Online Backup service."
		[+] Control LearnMoreLink
			[ ] locator "@priorlabel='Requires Quicken Online Backup service.'"
		[+] MainWin RestoreOpenFile
			[ ] locator "Restore from backup file"
			[+] RadioList OverwriteTheOpenFileWithR
				[ ] locator "Overwrite the existing file with restored file"
			[+] // RadioList CreateaCopy
				[ ] // locator "Create a copy"
			[+] PushButton HelpIcon
				[ ] locator "@priorlabel='NewData.QDF'"
			[+] PushButton RestoreBackup
				[ ] locator "Restore Backup"
			[+] PushButton Cancel
				[ ] locator "Cancel"
		[+] StaticText FileLocation
			[ ] locator "@windowid='295'"
		[+] StaticText FileName
			[ ] locator "@windowid='286'"
		[+] PushButton Yes
			[ ] locator "Yes"
		[+] PushButton No
			[ ] locator "No"
		[+] PushButton RestoreBackup
			[ ] locator "[@windowid='32767']"
		[+] PushButton RestoreBackupButton
			[ ] // locator "[@priorlabel='Choose a location to save your restored file' or @caption='Restore Backup']"
			[ ] locator "[@windowid='32767'][2]"
			[ ] 
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton YesRestore
			[ ] locator "Yes"
		[ ] 
		[ ] ///Added by Mukesh 20/01/2014
		[ ] 
		[+] RadioList RestoreFromBackupRadioList
			[ ] locator "Restore from your backup"
		[+] RadioList RestoreFromOnlineBackupRadioList
			[ ] locator "Restore from online backup"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] PushButton OpenBackupDirectoryButton
			[ ] locator "Open backup directory"
		[+] StaticText ConfirmationMeesage
			[ ] locator "@windowid='292'"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin RestoreOpenFile
		[ ] locator "/WPFWindow[@caption='Quicken 201*']//MainWin[@caption='Restore from backup file'][2]"
		[+] RadioList OverwriteTheOpenFileWithR
			[ ] // locator "Overwrite the open file with restored file"
			[ ] locator "@windowid='289'"
		[+] RadioList CreateaCopy
			[ ] locator "Create a copy"
		[+] PushButton HelpIcon
			[ ] locator "@priorlabel='NewData.QDF'"
		[+] PushButton RestoreBackup
			[ ] locator "Restore Backup"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] StaticText FileNameText
			[ ] locator "@windowid='286'"
			[ ] 
		[+] RadioList OverwriteTheOpenFileWithRestoredFileRadioList
			[ ] locator "@windowid='289'"
		[+] RadioList CreateACopyRadioList
			[ ] locator "Create a copy"
		[ ] 
	[ ] 
	[+] window MainWin DlgRestoreFromCopiedFile
		[ ] locator "[@caption='Restore from copied file' or @caption='File Copied']"
		[+] PushButton YesButton
			[ ] locator "Yes"
		[+] PushButton NoButton
			[ ] locator "No"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] window MainWin  AttachmentValidationPopup
		[ ] locator "Asset"
		[+] Control TxList
			[ ] locator "@windowid='13'"
			[+] Control TxToolbar
				[ ] locator "@windowid='8'"
				[+] PushButton Save
					[ ] locator "Save"
				[+] // CustomWin Control143
					[+] // multitag "[Control]$143"
						[ ] // "[Control]&windowClassName=QC_button"
				[+] // CustomWin Control103
					[+] // multitag "[Control]$103"
						[ ] // "[Control]&windowClassName=QC_button"
				[ ] //Added by Puja
				[+] PushButton MenuButton
					[ ] locator "@windowid='143'"
				[ ] 
			[+] Control Control3
				[ ] locator "@windowid='3'"
			[+] Control Control4
				[ ] locator "@windowid='4'"
			[+] Control N1200
				[ ] locator "@windowid='5'"
			[+] StaticText StaticText6
				[ ] locator "@windowid='6'"
			[+] Control Control20201
				[ ] locator "@windowid='2020'"
				[+] Control Control1124
					[ ] locator "@windowid='1124'"
				[+] Control Control1128
					[ ] locator "@windowid='1128'"
			[+] Control Control20202
				[ ] locator "@windowid='2020'"
				[+] Control Control1124
					[ ] locator "@windowid='1124'"
				[+] Control Control1128
					[ ] locator "@windowid='1128'"
		[+] StaticText EndingBalance
			[ ] locator "@windowid='7'"
			[+] StaticText EndingBalance
				[ ] locator "@windowid='1'"
			[+] StaticText NumOfTransactions
				[ ] locator "@windowid='21'"
		[+] PushButton Find
			[ ] locator "Find"
		[+] PushButton AccountActions
			[ ] locator "Account Actions"
	[+] window MainWin FileDownloadAttachment
		[ ] locator "File Download"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
[ ] 
[-] //************* Edit *************************************************************
	[ ] 
	[ ] 
	[ ] //------Edit > Preferences----------------
	[+] // window DialogBox Preferences
		[ ] // locator "Preferences"
		[+] // StaticText SelectPreferenceTypeText
			[ ] // locator "Select preference type:"
		[+] // ListBox ListBox
			[ ] // locator "//ListBox"
		[+] // PushButton OK
			[ ] // locator "OK"
		[+] // PushButton Cancel
			[ ] // locator "Cancel"
		[+] // ComboBox OnStartupOpenTo
			[ ] // locator "On startup open to:"
		[+] // Control QWNewSep
			[ ] // locator "@windowClassName='QWNewSep'"
		[+] // StaticText ThisCanAlsoBeChangedAtAnyTimeB
			[ ] // locator "This can also be changed at any time by right-clicking the tab you would like to use and selecting ""Start Quicken On..."""
		[+] // Group StartupActions
			[ ] // locator "Startup Actions"
		[+] // CheckBox DownloadTransactionsWhenQuickenStarts
			[ ] // locator "Download Transactions when Quicken Starts"
		[+] // ComboBox ColorScheme
			[ ] // locator "Color scheme:"
		[+] // CheckBox DimDisabledWindows
			[ ] // locator "Dim disabled windows"
		[+] // Control Panel
			[ ] // locator "Panel"
		[+] // Control QWHtmlView
			[ ] // locator "@windowClassName='QWHtmlView'"
		[+] // StaticText DownloadTransaction
			[ ] // locator "Downloaded transactions preferences"
		[+] // Group AfterDownloadingTransactions
			[ ] // locator "After Downloading Transactions"
		[+] // CheckBox AutomaticallyAddToBankingRegister
			[ ] // locator "Automatically add to banking registers"
		[+] // CheckBox AutomaticallyAddToInvestmentTransactionLists
			[ ] // locator "Automatically add to investment transaction lists"
		[+] // StaticText IfYouDoNotUseTheseOptionsAllDo
			[ ] // locator "If you do not use these options, all downloaded transactions must be manually reviewed and accepted before they are added to your registers and lists. Unaccepted transactions will not display in reports, graphs and other product features."
		[+] // Group DuringTransactionDownload
			[ ] // locator "During Transaction Download"
		[+] // CheckBox AutomaticallyCategorizeTransactions
			[ ] // locator "Automatically categorize transactions"
		[+] // CheckBox AutomaticallyApplyQuickenSuggestedNameToPayee
			[ ] // locator "Automatically apply Quicken's suggested name to payee"
		[+] // CheckBox CapitalizeFirstLetterOnlyInDownloadedPayeeNames
			[ ] // locator "Capitalize first letter only in downloaded payee names"
		[+] // Group YourRenamingRules
			[ ] // locator "Your Renaming Rules"
		[+] // CheckBox UseMyExistingRenamingRules
			[ ] // locator "Use my existing renaming rules"
		[+] // MainWin RenamingRules
			[ ] // locator "&Renaming Rules..."
		[+] // CheckBox AutomaticallyCreateRulesWhenIRenamePayees
			[ ] // locator "Automatically create rules when I rename payees"
		[+] // CheckBox LetMeReviewConfirmTheAutomaticallyCreatedRules
			[ ] // locator "@caption='Let me review/confirm the automatically created rules'"
		[+] // Group MainNavigation
			[ ] // locator "Main Navigation"
		[+] // CheckBox UseClassicMenus
			[ ] // locator "Use Classic Menus"
		[+] // CheckBox ShowTabs
			[ ] // locator "Show Tabs"
		[+] // CheckBox ShowAccountBar
			[ ] // locator "Show Account Bar"
		[+] // RadioList AccountBar
			[ ] // locator "On Left"
		[+] // CheckBox ShowCentsInAccountBarBalanceCheckBox
			[ ] // locator "Show cents in Account Bar balances"
		[+] // CheckBox ShowQuickenToolbar
			[ ] // locator "Show Quicken Toolbar"
		[+] // CheckBox DockSideBarForWideScreen
			[ ] // locator "Dock Side Bar (for wide screens only)"
		[+] // MainWin Fonts
			[ ] // locator "F&onts..."
		[+] // Control Colors
			[ ] // locator "Co&lors..."
		[+] // CheckBox RemindMeToSaveReports
			[ ] // locator "Remind me to save reports"
		[ ] // 
		[ ] // 
		[ ] // 
		[+] // MainWin SelectPreferenceType1
			[ ] // locator "@windowid='101'"
			[+] // ListBox ListBox1
				[ ] // locator "@windowid='1'"
		[+] // CheckBox AutomaticBackups
			[ ] // locator "@windowid='1000'"
		[+] // CheckBox ManualBackupReminder
			[ ] // locator "@windowid='1011'"
		[ ] // 
		[ ] // 
		[ ] // 
		[+] // CheckBox AutomaticallyAddDownloadedT
			[ ] // locator "@windowid='1001'"
		[+] // CheckBox ApplyRenamingRulesToDownloadedT
			[ ] // locator "@windowid='125'"
		[ ] // 
	[-] window DialogBox Preferences
		[ ] locator "Preferences"
		[+] StaticText SelectPreferenceTypeText
			[ ] locator "Select preference type*"
		[+] StaticText DownloadTransaction
			[ ] locator "Downloaded transactions preferences"
		[+] MainWin SelectPreferenceType
			[ ] locator "@windowid='101'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton SelectPreferenceType2
			[ ] locator "Select preference type:"
		[+] PopupList OnStartupOpenTo
			[ ] locator "On startup open to:"
		[+] Control StartupLocation
			[ ] locator "Startup Location"
		[+] CheckBox DownloadTransactionsWhenQui
			[ ] locator "Download Transactions when Quicken Starts"
		[+] ComboBox ColorScheme
			[ ] locator "Color scheme:"
		[+] CheckBox DimDisabledWindows
			[ ] locator "Dim disabled windows"
		[+] Control Panel
			[ ] locator "@windowid='-1'"
			[+] CustomWin QWHtmlView1
				[ ] locator "@windowid='1000'"
		[+] CheckBox ApplyRenamingRulesToDownloadedT
			[ ] locator "Apply renaming rules to downloaded transactions"
		[+] CheckBox AutomaticallyAddDownloadedT
			[ ] locator "@windowid='1001'"
		[+] CheckBox AutomaticallyAddDownloadedIT
			[ ] locator "@windowid='1002'"
		[ ] 
		[+] PushButton GetStartedButton
			[ ] locator "Get Started"
		[+] PushButton UpdateYourAccountSettings
			[ ] locator "Update your account settings"
		[+] PushButton UpdateYourAlertSettings
			[ ] locator "Update your alert settings"
		[+] PushButton ResetYourPassword
			[ ] locator "Reset your password"
		[+] PushButton UpdateYourProfile
			[ ] locator "Update your profile"
		[+] PushButton ViewYourProfile
			[ ] locator "View your profile"
		[+] PushButton UnlinkThisDataFile				// Updated by Udita on 22 Jan 2013
			[ ] locator  "Unlink This Data File"
		[+] StaticText IfYouWantToCompletelyDeleteCloudData
			[ ] locator "@windowid='1026'"
		[+] PushButton ViewYourProfileAndChooseDelete
			[ ] locator  "view your profile and choose delete."
		[ ] 
		[ ] //Added By Dean On 6th Jan 2013
		[+] StaticText DownloadedTransactionsPreferences
			[ ] locator "Downloaded transactions preferences"
		[+] StaticText AfterDownloadingTransactions
			[ ] locator "@windowid='1009'"
		[+] CheckBox AutomaticallyAddToBankingRegister
			[ ] locator "Automatically add to banking registers"
		[+] CheckBox AutomaticallyAddToInvestmentTransactionLists
			[ ] locator "Automatically add to investment transaction lists"
		[+] StaticText IfYouDoNotUseTheseOptionsAllDo
			[ ] locator "If you do not use these options, all downloaded transactions must be manually reviewed and accepted before they are added to your registers and lists. Unaccepted transactions will not display in reports, graphs and other product features."
		[+] Group DuringTransactionDownload
			[ ] locator "During Transaction Download"
		[+] CheckBox AutomaticallyCategorizeTransactions
			[ ] locator "Automatically categorize transactions"
		[+] CheckBox AutomaticallyApplyQuickenSuggestedNameToPayee
			[ ] locator "Automatically apply Quicken's suggested name to payee"
		[+] CheckBox CapitalizeFirstLetterOnlyInDownloadedPayeeNames
			[ ] locator "Capitalize first letter only in downloaded payee names"
		[+] StaticText YourRenamingRulesText
			[ ] locator "@windowid='1016'"
		[+] CheckBox UseMyExistingRenamingRules
			[ ] locator "Use my existing renaming rules"
		[+] PushButton RenamingRules
			[ ] locator "Renaming Rules*"
		[+] CheckBox AutomaticallyCreateRulesWhenIRenamePayees
			[ ] locator "Automatically create rules when I rename payees"
		[+] CheckBox LetMeReviewConfirmTheAutomaticallyCreatedRules
			[ ] locator "Let me review?confirm the automatically created rules"
		[ ] 
		[ ] // For Navigation preference type 			// Added by Indrajit on 06 feb 13
		[+] CheckBox UseClassicMenus
			[ ] locator "Use Classic Menus"
		[+] CheckBox ShowTabs
			[ ] locator "Show Tabs"
		[+] CheckBox ShowAccountBar
			[ ] locator "Show Account Bar"
		[+] RadioList AccountBar
			[ ] locator "Account Bar"
		[+] CheckBox ShowCentsInAccountBarBalanceCheckBox
			[ ] locator "Show cents in Account Bar balances"
		[+] CheckBox ShowQuickenToolbar
			[ ] locator "Show Quicken Toolbar"
		[+] CheckBox DockSideBarForWideScreen
			[ ] locator "Dock Side Bar (for wide screens only)"
		[+] Group RegisterFieldsText
			[ ] locator "Register Fields"
		[+] CheckBox ShowDateBeforeCheckNumber
			[ ] locator "Show Date before Check Number"
		[+] CheckBox ShowMemoBeforeCategory
			[ ] locator "Show Memo before Category"
		[+] Group TransactionEntryText
			[ ] locator "Transaction Entry"
		[+] CheckBox AutomaticallyEnterSplitData
			[ ] locator "Automatically enter Split data"
		[+] CheckBox AutomaticallyPlaceDecimalPoint
			[ ] locator "Automatically place decimal point"
		[+] Group RegisterAppearanceText
			[ ] locator "Register Appearance"
		[+] CheckBox GrayReconciledTransactions
			[ ] locator "Gray Reconciled Transactions"
		[+] CheckBox RememberRegisterFiltersAfterQuickenCloses
			[ ] locator "Remember Register Filters after Quicken closes"
		[+] CheckBox UsePopUpRegisters
			[ ] locator "Use Pop-up Registers"
		[+] PushButton Fonts
			[ ] locator "Fonts*"
		[+] PushButton Colors
			[ ] locator "Colors*"
		[+] StaticText DataEntryAndQuickFillText
			[ ] locator "Data entry and QuickFill"
		[+] StaticText DataEntryText
			[ ] locator "Data Entry"
		[+] CheckBox UseEnterKeyToMoveBetween
			[ ] locator "Use enter key to move between fields"
		[+] CheckBox CompleteFieldsUsingPrevious
			[ ] locator "Complete fields using previous entries"
		[+] CheckBox RecallMemorizedPayeesRequi
			[ ] locator "Recall memorized payees (requires automatic completion)"
		[+] CheckBox AutomaticallyOpenDropDownL
			[ ] locator "Automatically open drop-down lists in QuickFill fields"
		[+] CheckBox CapitalizePayeesAndCategori
			[ ] locator "Capitalize payees and categories"
		[+] CheckBox ShowButtonsOnQuickFillFiel
			[ ] locator "Show buttons on QuickFill fields"
		[+] StaticText QuickFillAndMemorizedPayees1
			[ ] locator "QuickFill and Memorized Payees"
		[+] CheckBox AutomaticallyMemorizeNewPay
			[ ] locator "Automatically memorize new payees"
		[+] CheckBox AutomaticallyIncludeOnCalen
			[ ] locator "Automatically include on Calendar payee list"
		[+] CheckBox AddAddressBookQuickFillIte
			[ ] locator "Add Address Book QuickFill items to Memorized Payee List"
		[+] CheckBox RemoveMemorizedPayeesNotUs
			[ ] locator "Remove memorized payees not used in last"
		[+] TextField QuickFillAndMemorizedPayees2
			[ ] locator "QuickFill and Memorized Payees"
		[+] StaticText MonthsText
			[ ] locator "months"
		[ ] 
		[+] MainWin SelectPreferenceType1
			[ ] locator "@windowid='101'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
			[ ] 
		[+] CheckBox AutomaticBackups
			[ ] locator "@windowid='1000'"
		[+] CheckBox ManualBackupReminder
			[ ] locator "@windowid='1011'"
		[ ] 
		[ ] 
		[+] CheckBox RemindMeToSaveReports
			[ ] locator "@windowid='61'"
		[+] CheckBox RemoveMemorizedPayeesNotUsed
			[ ] locator "Remove memorized payees not used in last"
			[ ] 
		[+] CheckBox MulticurrencySupport
			[ ] locator "Multicurrency support"
			[ ] 
		[ ] //Cloud Sync options
		[+] PushButton DeleteyourCloudData
			[ ] locator "//PushButton[@caption='Delete your Cloud Data']"
		[ ] 
		[+] PushButton ResetQuickenWarnings
			[ ] locator "Reset Quicken Warnings"
		[ ] // For Instrumentation preferences	//Added by Govind on 21 Jan 2014
		[+] CheckBox ImproveQuickenBySendingAnonymousBehaviorReports
			[ ] locator "Improve Quicken by sending anonymous behavior reports"
		[+] CheckBox ImproveQuickenBySendingAnonymousUsageStatistics
			[ ] locator "Improve Quicken by sending anonymous usage statistics"
		[ ] 
		[ ] // Added by Udita 14/2/2014
		[+] StaticText BackupPreferencesText
			[ ] locator "Backup preferences"
		[+] Control HelpPreferenceLink
			[ ] locator "@windowid='1000'"
		[+] TextField BackupAfterRunningQuicken
			[ ] locator "Automatically save a copy of your data files at regular intervals"
		[+] TextField MaximumNumberOfBackupCopies
			[ ] locator "Maximum number of backup copies:"
		[+] TextField ManualBackupAfterRunningQuicken
			[ ] locator "Remind me after running Quicken:"
		[+] CheckBox RemindMeToSaveReportsCheckBox
			[ ] locator "Remind me to save reports"
		[ ] 
		[ ] 
		[ ] /// Added by Mukesh Intuit ID, Mobile & Alerts
		[+] StaticText IntuitIdFieldText
			[ ] locator "@windowid='1064'"
		[+] StaticText EmailIDFieldText
			[ ] locator "@windowid='1072'"
		[+] StaticText UserFieldText
			[ ] locator "@windowid='1081'"
		[+] StaticText AddressFieldText
			[ ] locator "@windowid='1073'"
		[+] StaticText CityStatePinFieldText
			[ ] locator "@windowid='1082'"
		[+] StaticText PhoneNumberFieldText
			[ ] locator "@windowid='1083'"
		[-] PushButton SignInAsADifferentUser
			[ ] locator "Sign in as a different User"
		[+] PushButton ChangeIntuitPassword  // Addeed By Abhijit S
			[ ] locator "Change Intuit Password"
		[ ] /// Added by Mukesh Startup preferences
		[+] StaticText StartupPreferencesText
			[ ] locator "Startup preferences"
		[+] Group StartupLocationGroup
			[ ] locator "Startup Location"
		[+] Group StartupActionsGroup
			[ ] locator "Startup Actions"
		[+] Group QuickenColorsGroup
			[ ] locator "Quicken Colors"
		[+] ComboBox OnStartupOpenToList
			[ ] locator "On startup open to:"
		[+] PushButton PreferencesHelpButton
			[ ] locator "@windowid='32765'"
		[+] CheckBox DownloadTransactionsWhenQuickenStarts
			[ ] locator "Download Transactions when Quicken Starts"
		[ ] 
		[ ] 
		[ ] // Investment transactions section
		[+] CheckBox ShowHiddenTransactionsCheckBox
			[ ] locator "Show hidden transactions"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[-] window MainWin DlgSignInAsADifferentUser
		[ ] locator "Sign in as a different user"
		[ ] 
		[+] TextField SignOutTextField
			[ ] locator "@windowid='110'"
		[+] PushButton SignOutButton
			[ ] locator "Sign Out"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] /// Added by Mukesh Startup preferences
		[+] StaticText StartupPreferencesText
			[ ] locator "Startup preferences"
		[+] Group StartupLocationGroup
			[ ] locator "Startup Location"
		[+] Group StartupActionsGroup
			[ ] locator "Startup Actions"
		[+] Group QuickenColorsGroup
			[ ] locator "Quicken Colors"
		[+] ComboBox OnStartupOpenToList
			[ ] locator "On startup open to:"
		[+] PushButton PreferencesHelpButton
			[ ] locator "@windowid='32765'"
		[+] CheckBox DownloadTransactionsWhenQuickenStarts
			[ ] locator "Download Transactions when Quicken Starts"
		[ ] 
	[ ] 
	[ ] 
	[+] window MainWin DlgChangeYourIntuitIDOrEmail // Added By Abhijit S, April 2015 
		[ ] locator "Change your Intuit ID or email"
		[ ] 
		[+] TextField NewInTuitIDTextField
			[ ] locator "@windowid='275'"
		[+] TextField NewEmailTextField
			[ ] locator "@windowid='276'"
		[+] TextField IntuitPasswordTextField
			[ ] locator "@windowid='312'"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin DlgChangeYourIntuitPassword // Added By Abhijit S, Mar 2015 
		[ ] locator "Change your Intuit password"
		[ ] 
		[+] TextField CurrentIntuitIDPassword
			[ ] locator "@windowid='295'"
		[+] TextField NewPassword
			[ ] locator "@windowid='297'"
		[+] TextField ReEnterNewPassword
			[ ] locator "@windowid='299'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
			[ ] 
		[ ] 
	[+] window DialogBox PasswordChangeAlert // Added By Abhijit S, Mar 2015 
		[ ] locator "Quicken 20*"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[+] window MainWin ChangeyourIntuitID // Added By Abhijit S, Mar 2015 
		[ ] locator "Change your Intuit ID"
		[+] TextField NewInTuitIDTextField
			[ ] locator "@windowid='275'"
		[+] TextField NewEmailTextField
			[ ] locator "@windowid='276'"
		[+] TextField IntuitPasswordTextField
			[ ] locator "@windowid='312'"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[ ] 
	[ ] 
	[ ] 
	[+] window MainWin DlgChangeYourContactInformation
		[ ] locator "Change your contact information"
		[ ] 
		[+] TextField FirstNameTextField
			[ ] locator "@windowid='282'"
		[+] TextField LastNameTextField
			[ ] locator "@windowid='283'"
		[+] TextField AddressTextField
			[ ] locator "@windowid='285'"
		[+] TextField CityTextField
			[ ] locator "@windowid='287'"
		[+] ComboBox StateComboBox
			[ ] locator "@windowid='293'"
		[+] TextField ZipTextField
			[ ] locator "@windowid='289'"
		[+] TextField MobileNumberTextField
			[ ] locator "@windowid='291'"
		[+] TextField IntuitPasswordTextField
			[ ] locator "@windowid='312'"
		[ ] 
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Edit > Find/Replace----------------
	[+] window MainWin FindAndReplace
		[ ] locator "//MainWin[@caption='Find and Replace']"
		[+] StaticText FindAndReplace1Text
			[ ] locator "Find and Replace"
		[+] StaticText FindText
			[ ] locator "Find"
		[+] ComboBox FindComboBox
			[ ] locator "Find"
		[+] ComboBox FindAndReplace
			[ ] locator "[@windowid='562']"
		[+] TextField FindAndReplace4
			[ ] locator "Find and Replace"
		[+] MainWin FindWindow
			[ ] locator "*Find"
		[+] StaticText Found
			[ ] locator "Found"
		[+] ListBox ListBox1
			[ ] locator "//ListBox"
		[+] MainWin SelectAll
			[ ] locator "*Select All"
		[+] PushButton ClearAll
			[ ] locator "C*lear All"
		[+] CheckBox ShowMatchesWithinSplits
			[ ] locator "Show matches within splits"
		[+] StaticText ReplaceText
			[ ] locator "Replace"
		[+] ComboBox Replace
			[ ] locator "@windowid='569'"
		[+] StaticText WithText
			[ ] locator "With:"
		[+] TextField With1
			[ ] locator "With:"
			[ ] //locator "@windowid='556'"
		[+] PushButton ReplaceAll
			[ ] locator "@windowid='586'"
		[+] PushButton Done
			[ ] locator "Done"
		[+] PushButton Find
			[ ] locator "Find"
		[ ] 
	[+] window MainWin DlgFindAndReplace
		[ ] locator "Find and Replace"
		[+] ComboBox FieldPopUpList
			[ ] locator "@windowid='561'"
		[+] ComboBox CriteriaPopUpList
			[ ] locator "@windowid='562'"
		[+] TextField SearchTextField
			[ ] locator "Find and Replace"
			[ ] // locator "@windowid='533'"
		[+] PushButton FindButton
			[ ] locator "@windowid='564'"
		[+] MainWin FoundListBox
			[ ] locator "@windowid='581'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton SelectAllButton
			[ ] locator "@windowid='565'"
		[+] PushButton ClearAllButton
			[ ] locator "@windowid='566'"
		[+] CheckBox ShowMatchesWithinSplits
			[ ] locator "@windowid='583'"
		[+] ComboBox ReplacePopupList
			[ ] locator "@windowid='569'"
		[+] TextField ReplacementTextField
			[ ] locator "[@windowid='556' or @windowid='552' or @windowid='554' or @caption='With:']"
		[+] PushButton DoneButton
			[ ] locator "@windowid='32766'"
		[+] PushButton ReplaceAllButton
			[ ] locator "@windowid='586'"
		[ ] 
	[ ] 
	[ ] //------Edit > Find----------------
	[+] window MainWin QuickenFind
		[ ] locator "//MainWin[@caption='Quicken Find']"
		[+] StaticText QuickenFindText
			[ ] locator "Quicken Find"
		[+] StaticText FindText
			[ ] locator "Find"
		[+] ComboBox FindAnyField
			[ ] locator "Find"
		[+] ComboBox Contains
			[ ] locator "Quicken Find"
		[+] TextField QuickenFind
			[ ] locator "Quicken Find"
		[+] PushButton Find
			[ ] locator "Find"
		[+] PushButton FindAll
			[ ] locator "Find All"
		[+] CheckBox SearchBackwards
			[ ] locator "Search Backwards"
		[+] PushButton Close
			[ ] locator "Close"
	[ ] 
	[ ] 
[ ] 
[+] //************* Account *********************************************************
	[ ] 
	[ ] 
	[ ] //------Click on Add An Account---------------- 
	[+] window MainWin AddAnyAccount 
		[ ] locator "//MainWin[@caption='Add*Account' or @caption='Activate One Step Update' or @caption='Add 529 Plan']"
		[+] StaticText AddCheckingAccountText
			[ ] locator "Add Checking Account"
		[+] PushButton Next
			[ ] locator "@windowid='1002'"
		[+] PushButton Back
			[ ] locator "Back"
		[+] PushButton Cancel
			[ ] locator "@windowid='1004'"
		[+] TextField BankName
			[ ] locator "@windowid='1125'"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] Control Panel
			[ ] locator "Panel"
			[+] Control QWHtmlView1
				[ ] locator "@windowClassName='QWHtmlView'"
				[ ] //locator "@windowid='1000'"
			[+] TextField TextField1
				[ ] locator "@windowid='2001'"
			[+] PushButton PushButton1
				[ ] locator "@windowid='2002'"
			[ ] 
		[+] DialogBox AlertMessage
			[ ] locator "Quicken *"
			[+] StaticText TextMessage		
				[ ] locator "@windowid='100'"
			[+] PushButton OK
				[ ] locator "@windowid='101'"
		[+] StaticText QuickenBillPay
			[ ] locator "@windowid='1253'"
		[ ] 
		[+] RadioList AddCheckingAccount
			[ ] locator "I want to select the connection method used to download my transactions"
		[+] PushButton BackToSimpleSetup
			[ ] locator "Back to *Simple Setup"
		[+] TextField AccountName
			[ ] locator "@caption='Account Name*Nickname'"
		[+] StaticText ThisAccountIsUsedPrimarilyFor
			[ ] locator "This account is used primarily for"
		[+] RadioList AccountUsedPrimarily
			[ ] locator "* Transactions"
		[+] RadioList BusinessTransactions
			[ ] locator "Business Transactions"
		[+] RadioList RentalPropertyTransactions
			[ ] locator "Rental Property Transactions"
		[+] TextField StatementEndingDate
			[ ] locator "@windowid='1671'"
		[+] TextField StatementEndingBalance
			[ ] locator "@windowid='1673'"
		[+] StaticText WhatCurrencyWouldYouLikeToUseForThisAccount
			[ ] locator "What currency would you like to use for this account?"
		[+] StaticText Currency
			[ ] locator "Currency"
		[+] ComboBox WhatCurrencyWouldYouLikeToUseForThisAccountComboBox
			[ ] locator "@windowid='1662'"
		[+] StaticText YouWillNotBeAbleToChangeTheCur
			[ ] locator "You will not be able to change the currency of this account once you have entered transactions"
		[ ] 
		[ ] //------Add An Account > Brokerage Account----------------
		[+] TextField Cash
			[ ] locator "[@caption='Cash'][1]"
		[+] TextField MoneyMarket
			[ ] locator "[@caption='Cash'][2]"
		[+] RadioList Mortgage
			[ ] locator "Yes"
		[ ] //------Add An Account > IRA/Keogh Account > IRA types----------------
		[+] RadioList WhoOwnsThisIRA
			[ ] locator "Myself"
		[+] RadioList IRAType
			[ ] locator "Traditional IRA"
		[ ] //------House Asset specific----------------
		[+] TextField HouseAcquireDate
			[ ] locator "@windowid='1740'"
			[ ] 
			[ ] 
		[+] TextField PurchasePrice
			[ ] locator "@windowid='1742'"
		[+] TextField EstimateCurrentValue
			[ ] locator "@windowid='1744'"
		[ ] //------Vehicle specific----------------
		[+] TextField VehicleManufacturer
			[ ] locator "[@caption='Vehicle Make*Manufacturer'][1]"
		[+] TextField VehicleModel
			[ ] locator "[@caption='Vehicle Make*Manufacturer'][2]"
		[+] TextField VehicleYear
			[ ] locator "Vehicle Model"
		[ ] //------Other Asset specific----------------
		[+] TextField DateToStartTracking
			[ ] locator "Date to start tracking"
		[+] TextField AssetValue
			[+] locator "Asset Value"
				[ ] 
		[ ] //------Other liability specific----------------
		[+] TextField LiabilityAmount
			[ ] locator "@windowid='1673'"
		[+] PushButton Tax
			[ ] locator "@windowid='1691'"
		[ ] 
		[ ] //------Online Account----------------
		[+] TextField BankUserID
			[ ] locator "@windowid='1231'"
			[ ] // locator "[@caption='for your online CCMintBank account'][1]"
		[+] TextField BankPassword
			[ ] //locator "[@caption='for your online CCMintBank account'][2]"
			[ ] locator "@windowid='1233'"
			[ ] 
			[ ] // locator "[@caption='for your online CCMintBank account'][2]"
		[+] StaticText CCMintBankLabel
			[ ] locator "CCMintBank"
		[+] ListBox ListBox1
			[ ] locator "//ListBox"
		[ ] 
		[+] TextField EnterTheNameOfYourBank
			[ ] locator "@windowid='1125'"
		[ ] 
		[+] TextField BankMemberNumber
			[ ] locator "@windowid='1231'"
			[ ] 
		[ ] 
		[+] // TextField BankPassword
			[ ] // locator "@windowid='1233'"
			[ ] 
		[ ] 
		[+] TextField EnterYourFIName
			[ ] locator "@windowid='1125'"
			[ ] 
		[ ] 
		[ ] 
		[+] PushButton Connect
			[ ] locator "@windowid='1002'"
			[ ] 
		[ ] 
		[+] MainWin BankAccounts
			[ ] locator "@windowid='1407'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[+] TextField TextField1
					[ ] locator "@windowid='1408'"
				[+] ComboBox PopupList1
					[ ] locator "@windowid='1404'"
				[+] MenuItem LinkAccount
					[ ] locator "@windowid='4264987'"
					[+] MenuItem LinkAccount
						[ ] locator "@windowid='10016'"
		[+] StaticText ErrorMessage
			[ ] locator "@windowid='1250'"
		[+] DialogBox Dlg401K403BSetup
			[ ] locator "401(k)*403(b) Setup"
			[+] StaticText NameThisAccount
				[ ] locator "Name this account:"
			[+] TextField NameThisAccountTextField
				[ ] locator "Name this account:"
			[+] StaticText ExamplesText
				[ ] locator "Examples:"
			[+] StaticText MySpouseS401KText
				[ ] locator "My spouse's 401(k)"
			[+] StaticText AcmeInc401KText
				[ ] locator "Acme Inc. 401(k)"
			[+] StaticText StatementEndingDateText
				[ ] locator "Statement Ending Date:"
			[+] TextField StatementEndingDateTextField
				[ ] locator "Acme Inc. 401(k)"
			[+] StaticText EmployerNameText
				[ ] locator "Employer Name:"
			[+] TextField EmployerNameTextField
				[ ] locator "Employer Name:"
			[+] StaticText ThisIsAText
				[ ] locator "This is a:"
			[+] RadioList EmployerName
				[ ] locator "Current Employer"
			[+] StaticText ThisIsText
				[ ] locator "This is:"
			[+] RadioList ThisIs
				[ ] locator "My Account"
			[+] StaticText DoesTheStatementListHowMa2
				[ ] locator "Does the statement list how many shares of each security you own?"
			[+] RadioList Yes
				[ ] locator "Yes"
			[+] RadioList No
				[ ] locator "No"
			[+] PushButton Next
				[ ] locator "Next"
			[+] Control QWListViewer
				[ ] locator "@windowClassName='QWListViewer'"
				[+] ListBox ListBox
					[ ] locator "@windowid='1'"
			[+] PushButton Done
				[ ] locator "Done"
			[+] DialogBox AlertMessage    
				[ ] locator "Quicken 201*"
				[+] Control Control105
					[ ] locator "@windowid='105'"
				[+] PushButton Yes
					[ ] locator "*Yes"
				[+] PushButton No
					[ ] locator "*No"
			[ ] 
			[ ] 
			[ ] 
		[+] TextField EnterFIName
			[ ] locator "@windowid='1112'"
		[+] MainWin CCBank2
			[ ] locator "@windowid='1407'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
			[ ] 
			[ ] 
			[ ] 
		[+] PushButton Finish
			[ ] locator "Finish"
			[ ] // locator "@windowid='1003'"
		[ ] 
		[+] TextField MFCUBankMemberNumber
			[ ] locator "@windowid='1231'"
			[ ] 
		[ ] 
		[+] TextField MFCUBankPassword
			[ ] locator "@windowid='1233'"
			[ ] 
		[ ] 
		[+] StaticText FINameText
			[ ] locator "@windowid='1253'"
		[ ] 
		[ ] 
		[+] // MainWin BankAccounts
			[ ] // locator "@windowid='1407'"
			[+] // ListBox ListBox1
				[ ] // locator "@windowid='1'"
				[+] // TextField TextField1
					[ ] // locator "@windowid='1408'"
				[+] // ComboBox PopupList1
					[ ] // locator "@windowid='1404'"
		[ ] 
		[+] MainWin QuickenAccountSetup
			[ ] locator "Quicken Account Setup"
			[+] StaticText WhatSecuritiesAreInThisAc
				[ ] locator "What securities are in this account?"
			[+] StaticText EnterATickerSymbolForEach
				[ ] locator "Enter a ticker symbol for each security in your account."
			[+] Control QWListViewer
				[ ] locator "@windowClassName='QWListViewer'"
			[+] ListBox Security
				[ ] locator "If you are not connected to the Internet, just enter a security name.  You can add more details later."
			[+] TextField IfYouAreNotConnectedToTheInterTextField
				[ ] locator "If you are not connected to the Internet, just enter a security name.  You can add more details later."
			[+] Control TickerSymbolLookup
				[ ] locator "Ticker Symbol Lookup"
			[+] Control AddMore
				[ ] locator "Add More*"
			[+] PushButton Next
				[ ] locator "Next"
			[+] PushButton Cancel
				[ ] locator "Cancel"
			[+] Control Done
				[ ] locator "Done"
			[ ] //------Add An Account > Brokerage Account > Security list setup[No Security] > No Security Alert----------------
			[+] DialogBox NoSecurityAlert
				[ ] locator "Quicken 201*"
				[+] StaticText YouHaveNotEnteredAnySecurities
					[ ] locator "You have not entered any securities.  Are you sure you want to create this account without any security holdings?"
				[+] PushButton Yes
					[ ] locator "Yes"
				[+] PushButton No
					[ ] locator "No"
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //For Loans
		[+] ComboBox ComboBox
			[ ] // locator "//ComboBox"
			[ ] locator "@windowid='1404'"
			[ ] 
		[+] MenuItem IgnoreMenuItem
			[ ] locator "Ignore*"
			[ ] //Ignore - Don't download into Quicken
			[ ] //locator "@windowid='1410'"
		[+] MenuItem AddMenuItem
			[ ] locator "Add*"
			[ ] //Ignore - Don't download into Quicken
			[ ] //locator "@windowid='1409'"
		[+] MenuItem LinkMenuItem
			[ ] locator "Link*"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //------Done > Add Account
	[+] window DialogBox QuickenAccountSetup
		[ ] locator "Quicken Account Setup"
		[+] StaticText WhatSecuritiesAreInThisAc
			[ ] locator "What securities are in this account*"
		[+] StaticText EnterATickerSymbolForEach
			[ ] locator "Enter a ticker symbol for each security in your account."
		[+] Control QWListViewer
			[ ] locator "@windowClassName='QWListViewer'"
		[+] ListBox Security
			[ ] locator "@windowid='1'"
		[+] TextField IfYouAreNotConnectedToTheInterTextField
			[ ] locator "@windowid='1407'"
		[+] PushButton TickerSymbolLookup
			[ ] locator "Ticker Symbol Lookup"
		[+] PushButton AddMore
			[ ] locator "Add More*"
		[+] PushButton Next
			[ ] locator "Next"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton Done
			[ ] locator "Done"
		[ ] //------Add An Account > Brokerage Account > Security list setup[No Security] > No Security Alert----------------
		[+] DialogBox NoSecurityAlert
			[ ] locator "Quicken 201*"
			[+] StaticText YouHaveNotEnteredAnySecurities
				[ ] locator "You have not entered any securities.  Are you sure you want to create this account without any security holdings?"
			[+] PushButton Yes
				[ ] locator "Yes"
			[+] PushButton No
				[ ] locator "No"
		[ ] 
	[ ] 
	[ ] //------Add An Account > 401K Account----------------
	[+] window DialogBox Dlg401K403BSetup
		[ ] locator "//DialogBox[@caption='401(k)*403(b) Setup']"
		[+] StaticText NameThisAccount
			[ ] locator "Name this account:"
		[+] TextField NameThisAccountTextField
			[ ] locator "Name this account:"
		[+] StaticText ExamplesText
			[ ] locator "Examples:"
		[+] StaticText MySpouseS401KText
			[ ] locator "My spouse's 401(k)"
		[+] StaticText AcmeInc401KText
			[ ] locator "Acme Inc. 401(k)"
		[+] StaticText StatementEndingDateText
			[ ] locator "Statement Ending Date:"
		[+] TextField StatementEndingDateTextField
			[ ] locator "Acme Inc. 401(k)"
		[+] StaticText EmployerNameText
			[ ] locator "Employer Name:"
		[+] TextField EmployerNameTextField
			[ ] locator "Employer Name:"
		[+] StaticText ThisIsAText
			[ ] locator "This is a:"
		[+] RadioList EmployerName
			[ ] locator "Current Employer"
		[+] StaticText ThisIsText
			[ ] locator "This is:"
		[+] RadioList ThisIs
			[ ] locator "My Account"
		[+] StaticText DoesTheStatementListHowMa2
			[ ] locator "Does the statement list how many shares of each security you own?"
		[+] RadioList Yes
			[ ] locator "Yes"
		[+] RadioList No
			[ ] locator "No"
		[+] PushButton Next
			[ ] locator "Next"
		[+] Control QWListViewer
			[ ] locator "@windowClassName='QWListViewer'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
		[+] ListBox ListBox
			[ ] locator "If you are not connected to the Internet, just enter a security name.  You can add more details later."
		[+] PushButton Done
			[ ] locator "Done"
		[+] DialogBox NoSecurityAlert                                       
			[ ] locator "Quicken 201*"
			[+] Control Control105
				[ ] locator "@windowid='105'"
			[+] PushButton Yes
				[ ] locator "*Yes"
			[+] PushButton No
				[ ] locator "*No"
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Add an Account > Account Added----------------
	[+] window MainWin AccountAdded //Updtaed by Abhijit s April 2015
		[ ] locator "//MainWin[@caption='Account* Added']"
		[+] PushButton Finish
			[ ] locator "@windowid='1003'"
		[+] PushButton AddAnotherAccount
			[ ] locator "Add another account"
		[+] PushButton Done    	
			[ ] locator "@windowid='1006'"
			[ ] 
		[+] ListBox AccountAddedListBox
			[ ] locator "//ListBox"					
		[ ] 					
		[ ] 				
	[ ] 
	[ ] //------Right Click on Acount > Edit Account > Account Details----------------
	[+] // window MainWin AccountDetails
		[ ] // locator "Account Details"
		[+] // TextField AccountName
			[ ] // locator "Account Name"
		[+] // TextField Description
			[ ] // locator "Description"
		[+] // RadioList TaxDeferred
			[ ] // locator "Yes"
		[+] // TextField InterestRateTextField
			[ ] // locator "Interest Rate"
		[+] // TextField MaxBalance
			[ ] // locator "Max. Balance"
		[+] // TextField MinBalance
			[ ] // locator "Min. Balance"
		[+] // TextField FinancialInstitution
			[ ] // locator "Financial Institution"
		[+] // TextField AccountNumber
			[ ] // locator "Account Number"
		[+] // PushButton HelpIcon
			[ ] // locator "@windowid='32765'"
		[+] // PushButton DeleteAccountButton
			[ ] // locator "Delete Account"
		[+] // PushButton TaxSchedule
			[ ] // locator "Tax Schedule"
		[+] // PushButton OK
			[ ] // locator "OK"
		[+] // PushButton Cancel
			[ ] // locator "Cancel"
		[+] // ComboBox AccountIntent1
			[ ] // locator "[@caption='Account Intent'][1]"
		[+] // ComboBox AccountIntent2
			[ ] // locator "[@caption='Account Intent'][2]"
		[+] // CheckBox KeepThisAccountSeparate
			[ ] // locator "Keep this account separate- account will be excluded from Quicken reports and features"
		[+] // CheckBox HideInTransactionEntryList
			[ ] // locator "Hide in transaction entry lists"
		[+] // TextField InvestingAccountNumber
			[ ] // locator "@windowid='2031'"
		[+] // CheckBox HideAccountNameInAccountB
			[ ] // locator "Hide account name in account bar and account list"
		[+] // PushButton CloseAccount
			[ ] // locator "@windowid='1004'"
			[ ] // //locator "Close Account..."
		[+] // RadioList ShowCashInACheckingAccount
			[ ] // locator "@priorlabel='Show cash in a checking account'"
		[+] // PushButton FeesButton
			[ ] // locator "Fees"
		[ ] // 
		[ ] // //------Account Details > Delete Account > Delete Account Dialog----------------
		[+] // DialogBox DeleteAccount
			[ ] // locator "Delete Account"
			[+] // TextField YesField
				[ ] // locator "Type ""yes"" to confirm:"
			[+] // MainWin OK
				[ ] // locator "OK"
			[+] // Control Cancel
				[ ] // locator "Cancel"
			[ ] // 
			[ ] // 
			[ ] // 
		[ ] // 
		[ ] // //------Account Details > Close Account----------------
		[+] // DialogBox PermanentlyCloseAccount
			[ ] // locator "Permanently Close Account"
			[+] // StaticText PermanentlyCloseAccountText
				[ ] // locator "Permanently Close Account"
			[+] // StaticText ClosingTheAccountWillText
				[ ] // locator "Closing the account will:"
			[+] // StaticText SetTheAccountBalanceToZ
				[ ] // locator "- Set the account balance to zero"
			[+] // StaticText NoDataWillBeDeletedText
				[ ] // locator "No data will be deleted:"
			[+] // StaticText TransactionsWillBeAvailab1
				[ ] // locator "- Transactions will be available for historical reporting"
			[+] // TextField TypeYesToConfirm
				[ ] // locator "Type ""yes"" to confirm"
			[+] // Control LearnMore
				[ ] // locator "- Learn More*"
			[+] // MainWin OK
				[ ] // locator "OK"
			[+] // Control Cancel
				[ ] // locator "Cancel"
		[ ] // 
		[ ] // //------Account Details > Close Account > Alert message when securities are added to investing account----------------
		[+] // DialogBox AlertMessageForCloseAccount
			[ ] // locator "Quicken 201*"
			[+] // Control QWIconDisplay
				[ ] // locator "@windowClassName='QWIconDisplay'"
			[+] // StaticText Message
				[ ] // locator "This account has securities balances, please clear the securities before you close the account."
			[+] // MainWin OK
				[ ] // locator "OK"
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[+] // PushButton OnlineSetUpButton
			[ ] // locator "@windowid='3005'"
			[ ] // 
		[+] // PushButton OnlineBillPay
			[ ] // locator "@windowid='2053'"
			[ ] // 
		[+] // PushButton OnlineBillPayment
			[ ] // locator "@windowid='32765'"
			[ ] // 
		[ ] // 
		[ ] // //Web Connect to Direct Connect
		[+] // StaticText AccountNameText
			[ ] // locator "@windowid='2066'"
		[+] // StaticText IsSetUpForTransactionDown
			[ ] // locator "@windowid='2062'"
		[+] // PushButton AutomaticEntry
			[ ] // locator "@windowid='2073'"
		[+] // PushButton Deactivate
			[ ] // locator "@windowid='3006'"
		[+] // PushButton SetUpNow
			[ ] // locator "@windowid='2053'"
		[+] // StaticText ConnectionMethodText
			[ ] // locator "@windowid='2092'"
		[+] // StaticText ConnectionMethod
			[ ] // locator "@windowid='3000'"
		[+] // StaticText Connection
			[ ] // locator "@windowid='2100'"
		[+] // PushButton ImproveConnection
			[ ] // locator "@windowid='2114'"
		[+] // StaticText FIName
			[ ] // locator "@windowid='2093'"
		[ ] // // //Bill Pay Active
		[+] // PushButton BillPayDeactivate
			[ ] // locator "@windowid='12024'"
		[+] // CheckBox HideAccountNameInAccountB1
			[ ] // locator "@windowid='2502'"
		[ ] // 
		[ ] // 
		[+] // TextField AccountDetails
			[ ] // locator "@windowid='2030'"
			[ ] // 
		[+] // TextField MaxBalanceTextField
			[ ] // locator "@windowid='2006'"
		[+] // TextField ContactName
			[ ] // locator "@windowid='2034'"
		[+] // TextField Phone
			[ ] // locator "@windowid='2035'"
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[+] // // window DialogBox AccountDetails		
			[ ] // // tag "Account Details"
			[ ] // // parent QuickenMainWindow
			[+] // // TextField Description
				[+] // // multitag "Description"
					[ ] // // "$2001"
			[+] // // CustomWin OK
				[+] // // multitag "[QC_button]OK"
					[ ] // // "[QC_button]$32767"
			[+] // // CustomWin Cancel
				[+] // // multitag "[QC_button]Cancel"
					[ ] // // "[QC_button]$32766"
			[+] // // CustomWin TaxSchedule
				[+] // // multitag "[QC_button]Tax Schedule"
					[ ] // // "[QC_button]^Account Intent[3]"
					[ ] // // "[QC_button]#4"
					[ ] // // "[QC_button]$1019"
					[ ] // // "[QC_button]@(209,469)"
			[+] // // TextField AccountName
				[+] // // multitag "Account Name"
					[ ] // // "$2000"
			[+] // // RadioList TaxDeferred
				[+] // // multitag "Tax-Deferred"
					[ ] // // "$2003"
			[+] // // CustomWin DeleteAccount
				[+] // // multitag "$1003"
					[ ] // // "Delete Account|[QC_button]Delete Account"
					[ ] // // 
			[+] // // PopupList AccountIntent1
				[+] // // multitag "Account Intent[1]"
					[ ] // // "^Account Intent[1]"
					[ ] // // "#1"
					[ ] // // "$2029"
					[ ] // // "@(133,249)"
			[+] // // PopupList AccountIntent2
				[+] // // multitag "Account Intent[2]"
					[ ] // // "^Account Intent[2]"
					[ ] // // "#2"
					[ ] // // "$2048"
					[ ] // // "@(133,275)"
			[+] // // CheckBox KeepThisAccountSeparate
				[+] // // multitag "Keep this account separate- account will be excluded from Quicken reports and features"
					[ ] // // "^Account Display[1]"
					[ ] // // "#1"
					[ ] // // "$2501"
					[ ] // // "@(258,112)"
			[+] // // CheckBox HideInTransactionEntryList
				[+] // // multitag "Hide in transaction entry lists"
					[ ] // // "^Account Display[2]"
					[ ] // // "#2"
					[ ] // // "$2500"
					[ ] // // "@(183,130)"
			[+] // // CheckBox HideAccountNameInAccountB
				[+] // // multitag "Hide account name in account bar and account list"
					[ ] // // "^Account Display[3]"
					[ ] // // "#3"
					[ ] // // "$2502"
					[ ] // // "@(210,148)"
			[+] // // CustomWin CloseAccount
				[+] // // multitag "[QC_button]Close Account"
					[ ] // // "^Account Display"
					[ ] // // "#1"
					[ ] // // "$1004"
					[ ] // // "@(89,179)"
			[+] // // RadioList ShowCashInACheckingAccount
				[+] // // multitag "[QC_button]Show cash in a checking account"
					[ ] // // "[QC_button]^Show cash in a checking account[1]"
					[ ] // // "[QC_button]#4"
					[ ] // // "[QC_button]$32765"
					[ ] // // "[QC_button]@(34,470)"
			[+] // // CheckBox HideAccountInAccountBar
				[+] // // multitag "Hide account name in account bar and account list"
					[ ] // // "#3"
					[ ] // // "$2502"
			[+] // // StaticText ThisAccountIsAlreadyClosed
				[+] // // multitag "This account is already closed."
					[ ] // // "#3"
					[ ] // // "$3003"
					[ ] // // "@(322,179)"
			[ ] // // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[+] window MainWin AccountDetails
		[ ] locator "Account Details"
		[+] TextField AccountName
			[ ] locator "Account Name"
		[+] TextField Description
			[ ] locator "Description"
		[+] RadioList TaxDeferred
			[ ] locator "Yes"
		[+] TextField InterestRateTextField
			[ ] locator "Interest Rate"
		[+] TextField MaxBalance
			[ ] locator "Max. Balance"
		[+] TextField MinBalance
			[ ] locator "Min. Balance"
		[+] TextField FinancialInstitution
			[ ] locator "Financial Institution"
		[+] TextField AccountNumber
			[ ] locator "Account Number"
		[+] PushButton HelpIcon
			[ ] locator "@windowid='32765'"
		[+] PushButton DeleteAccountButton
			[ ] locator "Delete Account"
		[+] PushButton TaxSchedule
			[ ] locator "Tax Schedule"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] ComboBox AccountIntent1
			[ ] locator "[@caption='Account Intent'][1]"
		[+] ComboBox AccountIntent2
			[ ] locator "[@caption='Account Intent'][2]"
		[+] CheckBox KeepThisAccountSeparate
			[ ] locator "Keep this account separate- account will be excluded from Quicken reports and features"
		[+] CheckBox HideInTransactionEntryList
			[ ] locator "Hide in transaction entry lists"
		[+] TextField InvestingAccountNumber
			[ ] locator "@windowid='2031'"
		[+] CheckBox HideAccountNameInAccountB
			[ ] locator "Hide account name in account bar and account list"
		[+] PushButton CloseAccount
			[ ] locator "@windowid='1004'"
			[ ] //locator "Close Account..."
		[+] RadioList ShowCashInACheckingAccount
			[ ] locator "@priorlabel='Show cash in a checking account'"
		[+] PushButton FeesButton
			[ ] locator "Fees"
		[ ] 
		[ ] 
		[+] ComboBox LoanTypeComboBox
			[ ] locator "@windowid='2505'"
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] //------Account Details > Delete Account > Delete Account Dialog----------------
		[+] DialogBox DeleteAccount
			[ ] locator "Delete Account"
			[+] TextField YesField
				[ ] locator "Type ""yes"" to confirm:"
			[+] MainWin OK
				[ ] locator "OK"
			[+] Control Cancel
				[ ] locator "Cancel"
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] //------Account Details > Close Account----------------
		[+] DialogBox PermanentlyCloseAccount
			[ ] locator "Permanently Close Account"
			[+] StaticText PermanentlyCloseAccountText
				[ ] locator "Permanently Close Account"
			[+] StaticText ClosingTheAccountWillText
				[ ] locator "Closing the account will:"
			[+] StaticText SetTheAccountBalanceToZ
				[ ] locator "- Set the account balance to zero"
			[+] StaticText NoDataWillBeDeletedText
				[ ] locator "No data will be deleted:"
			[+] StaticText TransactionsWillBeAvailab1
				[ ] locator "- Transactions will be available for historical reporting"
			[+] TextField TypeYesToConfirm
				[ ] locator "Type ""yes"" to confirm"
			[+] Control LearnMore
				[ ] locator "- Learn More*"
			[+] MainWin OK
				[ ] locator "OK"
			[+] Control Cancel
				[ ] locator "Cancel"
		[ ] 
		[ ] //------Account Details > Close Account > Alert message when securities are added to investing account----------------
		[+] DialogBox AlertMessageForCloseAccount
			[ ] locator "Quicken 201*"
			[+] Control QWIconDisplay
				[ ] locator "@windowClassName='QWIconDisplay'"
			[+] StaticText Message
				[ ] locator "This account has securities balances, please clear the securities before you close the account."
			[+] MainWin OK
				[ ] locator "OK"
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] PushButton OnlineSetUpButton
			[ ] locator "@windowid='3005'"
			[ ] 
		[+] PushButton OnlineBillPay
			[ ] locator "@windowid='2053'"
			[ ] 
		[+] PushButton OnlineBillPayment
			[ ] locator "@windowid='32765'"
			[ ] 
		[ ] 
		[ ] //Web Connect to Direct Connect
		[+] StaticText AccountNameText
			[ ] locator "@windowid='2066'"
		[+] StaticText IsSetUpForTransactionDown
			[ ] locator "@windowid='2062'"
		[+] PushButton AutomaticEntry
			[ ] locator "@windowid='2073'"
		[+] PushButton Deactivate
			[ ] locator "@windowid='3006'"
		[+] PushButton SetUpNow
			[ ] locator "@windowid='2053'"
		[+] StaticText ConnectionMethodText
			[ ] locator "@windowid='2092'"
		[+] StaticText ConnectionMethod
			[ ] locator "@windowid='3000'"
		[+] StaticText Connection
			[ ] locator "@windowid='2100'"
		[+] PushButton ImproveConnection
			[ ] locator "@windowid='2114'"
		[+] StaticText FIName
			[ ] locator "@windowid='2093'"
		[ ] // //Bill Pay Active
		[+] PushButton BillPayDeactivate
			[ ] locator "@windowid='12024'"
		[+] CheckBox HideAccountNameInAccountB1
			[ ] locator "@windowid='2502'"
		[ ] 
		[ ] 
		[+] TextField AccountDetails
			[ ] locator "@windowid='2030'"
			[ ] 
		[+] TextField MaxBalanceTextField
			[ ] locator "@windowid='2006'"
		[+] TextField ContactName
			[ ] locator "@windowid='2034'"
		[+] TextField Phone
			[ ] locator "@windowid='2035'"
		[ ] 
		[+] TextField LinkedAssetAccount
			[ ] locator "@windowid='2010'"
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] // window DialogBox AccountDetails		
			[ ] // tag "Account Details"
			[ ] // parent QuickenMainWindow
			[+] // TextField Description
				[+] // multitag "Description"
					[ ] // "$2001"
			[+] // CustomWin OK
				[+] // multitag "[QC_button]OK"
					[ ] // "[QC_button]$32767"
			[+] // CustomWin Cancel
				[+] // multitag "[QC_button]Cancel"
					[ ] // "[QC_button]$32766"
			[+] // CustomWin TaxSchedule
				[+] // multitag "[QC_button]Tax Schedule"
					[ ] // "[QC_button]^Account Intent[3]"
					[ ] // "[QC_button]#4"
					[ ] // "[QC_button]$1019"
					[ ] // "[QC_button]@(209,469)"
			[+] // TextField AccountName
				[+] // multitag "Account Name"
					[ ] // "$2000"
			[+] // RadioList TaxDeferred
				[+] // multitag "Tax-Deferred"
					[ ] // "$2003"
			[+] // CustomWin DeleteAccount
				[+] // multitag "$1003"
					[ ] // "Delete Account|[QC_button]Delete Account"
					[ ] // 
			[+] // PopupList AccountIntent1
				[+] // multitag "Account Intent[1]"
					[ ] // "^Account Intent[1]"
					[ ] // "#1"
					[ ] // "$2029"
					[ ] // "@(133,249)"
			[+] // PopupList AccountIntent2
				[+] // multitag "Account Intent[2]"
					[ ] // "^Account Intent[2]"
					[ ] // "#2"
					[ ] // "$2048"
					[ ] // "@(133,275)"
			[+] // CheckBox KeepThisAccountSeparate
				[+] // multitag "Keep this account separate- account will be excluded from Quicken reports and features"
					[ ] // "^Account Display[1]"
					[ ] // "#1"
					[ ] // "$2501"
					[ ] // "@(258,112)"
			[+] // CheckBox HideInTransactionEntryList
				[+] // multitag "Hide in transaction entry lists"
					[ ] // "^Account Display[2]"
					[ ] // "#2"
					[ ] // "$2500"
					[ ] // "@(183,130)"
			[+] // CheckBox HideAccountNameInAccountB
				[+] // multitag "Hide account name in account bar and account list"
					[ ] // "^Account Display[3]"
					[ ] // "#3"
					[ ] // "$2502"
					[ ] // "@(210,148)"
			[+] // CustomWin CloseAccount
				[+] // multitag "[QC_button]Close Account"
					[ ] // "^Account Display"
					[ ] // "#1"
					[ ] // "$1004"
					[ ] // "@(89,179)"
			[+] // RadioList ShowCashInACheckingAccount
				[+] // multitag "[QC_button]Show cash in a checking account"
					[ ] // "[QC_button]^Show cash in a checking account[1]"
					[ ] // "[QC_button]#4"
					[ ] // "[QC_button]$32765"
					[ ] // "[QC_button]@(34,470)"
			[+] // CheckBox HideAccountInAccountBar
				[+] // multitag "Hide account name in account bar and account list"
					[ ] // "#3"
					[ ] // "$2502"
			[+] // StaticText ThisAccountIsAlreadyClosed
				[+] // multitag "This account is already closed."
					[ ] // "#3"
					[ ] // "$3003"
					[ ] // "@(322,179)"
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //-----Account Register Pop Up Mode--------
	[+] window MainWin BankingPopUp
		[ ] locator "@caption='*Account*'"
		[+] StaticText EndingBalance
			[ ] locator "@windowid='7'"
			[+] StaticText OnlineBalance
				[ ] locator "@windowid='1'"
			[+] StaticText EndingBalance
				[ ] locator "Ending Balance"
			[+] StaticText NumOfTransactions
				[ ] locator "@windowid='21'"
		[+] Control TxList
			[ ] locator "TxList"
			[+] Control TxToolbar
				[ ] locator "TxToolbar"
				[+] PushButton Save
					[ ] locator "@windowid='101'"
				[+] PushButton AccountActions
					[ ] locator "@windowid='143'"
				[+] PushButton SplitButton
					[ ] locator "@windowid='103'"
					[ ] 
				[+] PushButton MoreAccountActions
					[ ] locator "@windowid='143'"
				[ ] 
		[+] TextField SearchWindow
			[ ] locator "@windowid='482'"
		[+] ComboBox DateFilter
			[ ] locator "@windowid='452'" 
		[+] ComboBox TypeFilter
			[ ] locator "@windowid='454'" 
		[+] ComboBox TransactionTypeFilter
			[ ] locator "@windowid='451'" 
		[+] PushButton Reset
			[ ] locator "Reset"
		[+] Control QWSnapHolder1
			[ ] locator "@windowClassName='QWSnapHolder'"
			[+] StaticText StaticText1
				[ ] //locator "@windowid='-1'"
				[+] MainWin DownloadedTransactions
					[ ] locator "@windowid='8200'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
						[ ] 
				[+] StaticText StaticText
					[+] PushButton HelpIcon
						[ ] locator "@windowid='27006'"
					[+] PushButton AcceptAll
						[ ] locator "@windowid='27002'"
					[ ] 
			[ ] 
		[+] RadioList RadioList
			[ ] locator "@windowid='17660'" 
		[+] ComboBox AccountName
			[ ] locator "@windowid='17681'" 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //------------Account Register MDI Object-----------
	[ ] 
	[-] window Control MDIClient
		[ ] locator "@windowClassName='MDIClient'"
		[ ] 
		[+] Control AccountRegister 
			[ ] locator "@windowClassName='QWMDI'"
			[+] StaticText Balances
				[ ] locator "@windowid='7'"
				[ ] 
				[+] StaticText EndingBalanceText
					[ ] locator "Ending Balance"
				[+] StaticText EndingBalance
					[ ] locator "@windowid='1'"
				[+] StaticText TransactionCount
					[ ] locator "@windowid='21'"
				[+] StaticText OnlineBalance
					[ ] locator "[@windowid='1'][2]"
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] Control TxList
				[ ] locator "@windowid='13'"
				[ ] 
				[+] Control TxToolBar
					[ ] locator "@windowid='8'"
					[ ] 
					[+] PushButton Save
						[ ] locator "@windowid='101'"
					[ ] 
					[+] PushButton MoreActions
						[ ] locator "@windowid='143'"
					[ ] 
					[+] PushButton SplitButton
						[ ] locator "@windowid='103'"
				[+] PushButton TagButton
					[ ] locator "@windowid='1124'"
					[ ] // locator "//PushButton[4]"
					[ ] 
					[ ] 
				[+] PushButton AddedSplitButton
					[ ] locator "[1]"//"[@windowid='103'][1]"
				[+] PushButton ClearSplitlinesButton
					[ ] locator "@windowid='162'"
				[+] PushButton SplitReportButton
					[ ] locator "@windowid='456'"
				[+] MenuItem Notes
					[ ] locator "@windowid='7138'"
				[ ] 
				[ ] 
			[+] PushButton C
				[ ] locator "@windowid='483'"
			[+] ComboBox DateFilter
				[ ] locator "@windowid='452'"
			[+] ComboBox TypeFilter
				[ ] locator "@windowid='454'"
			[+] ComboBox TransactionTypeFilter
				[ ] locator "@windowid='451'"
			[+] PushButton Reset
				[ ] locator "@windowid='450'"
			[+] TextField SearchWindow
				[ ] locator "@windowid='482'"
			[+] StaticText StaticText1
				[ ] locator "@windowid='7'"
				[+] Control QWinChild
					[ ] locator "@windowClassName='QWinChild'"
					[+] PushButton DownloadedTransactions
						[ ] locator "@windowid='1021'"
					[+] PushButton HideButton
						[ ] locator "@windowid='1030'"
						[ ] 
						[ ] 
					[+] PushButton FILOGO
						[ ] locator "@windowid='1026'"
					[+] Control QWListViewer
						[ ] locator "@windowid='1027'"
						[+] Control ListBox
							[ ] locator "@windowid='1'"
					[+] Control QWListViewerLastDownload
						[ ] locator "@windowid='1029'"
						[+] Control ListBox
							[ ] locator "@windowid='1'"
					[ ] 
			[+] Control QWSnapHolder1
				[ ] locator "@windowClassName='QWSnapHolder'"
				[+] StaticText StaticText1
					[ ] //locator "@windowid='-1'"
					[+] MainWin DownloadedTransactions
						[ ] locator "@windowid='8200'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
							[+] MenuItem Delete
								[ ] locator "@windowid='27003'"
							[+] MenuItem MatchManually
								[ ] locator "@windowid='27005'"
							[+] MenuItem MakeNew
								[ ] locator "@windowid='27004'"
							[+] MenuItem MakeAllNew
								[ ] locator "@windowid='27007'"
							[+] MenuItem UnMatch
								[ ] locator "@windowid='27012'"
							[+] MenuItem RevertPayee
								[ ] locator "@windowid='27008'"
							[+] MenuItem ShowRenamingRules
								[ ] locator "@windowid='27010'"
							[+] MenuItem AcceptTransaction
								[ ] locator "@windowid='27001'"
							[+] MenuItem AcceptAllTransaction
								[ ] locator "@windowid='27002'"
							[+] MenuItem HideAcceptedTransaction
								[ ] locator "@windowid='27009'"
								[ ] 
								[ ] 
					[ ] 
					[+] StaticText StaticText2
						[ ] locator "@windowid='-1'"
						[+] PushButton AcceptAll
							[ ] //locator "*Accept*"
							[ ] locator "@windowid='27002' or @windowid='22599'"
						[+] PushButton Accept
							[ ] locator "@windowid='27015'"
						[+] PushButton FinishLater
							[ ] locator "@windowid='27011'"
						[+] PushButton HelpIcon
							[ ] locator "@windowid='27006'"
						[+] PushButton  RenamingRules 
							[ ] locator "@windowid='27010'"
						[+] PushButton  HideAccepted 
							[ ] //locator "*Accepted*"
							[ ] locator "@windowid='27009'"
						[ ] 
						[ ] 
					[ ] 
				[+] StaticText StaticText2
					[ ] locator "@windowid='-1'"
					[+] PushButton AcceptAll
						[ ] locator "@windowid='27002'"
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // 
				[+] // StaticText StaticText1
					[ ] // locator "@windowid='7'"
					[+] // Control C2RHeader
						[ ] // locator "@windowid='0'"
						[+] // PushButton DownloadedTransactions
							[ ] // locator "@windowid='1021'"
				[+] // Control QWSnapHolder1
					[ ] // locator "@windowClassName='QWSnapHolder'"
					[+] // StaticText StaticText1
						[+] // StaticText StaticText2
							[+] // PushButton AcceptAll
								[ ] // locator "@windowid='27002'"
			[+] StaticText EndingBalance
				[ ] locator "@windowid='7'"
				[+] StaticText EndingBalanceAmount
					[ ] locator "@windowid='1'"
				[+] StaticText EndingBalance
					[ ] locator "Ending Balance"
				[+] StaticText NumOfTransactions
					[ ] locator "@windowid='21'"
				[+] StaticText OnlineBalance
					[ ] locator "@windowid='1'"
				[ ] 
			[+] Control QWinChild
				[ ] locator "@windowClassName='QWinChild'"
				[+] PushButton UpdateTransactions
					[ ] locator "@windowid='1023'"
				[+] PushButton SetUpMakeOnlinePayment
					[ ] locator "@windowid='1024'"
					[ ] 
			[+] PushButton BillandIncomeRemindersTab
				[ ] locator "@windowid='1022'"
			[+] PushButton DownloadedTransactionsTab
				[ ] locator "@windowid='1021'"
				[ ] 
			[+] ListBox RegisterListBox
				[ ] locator "//ListBox"
			[+] ListBox C2RListBox
				[ ] locator "//ListBox[2]"
			[+] PushButton HelpIcon
				[ ] locator "@windowid='27006'"
			[+] PushButton Accept
				[ ] locator "@windowid='27015'"
			[+] PushButton FinishLater
				[ ] locator "@windowid='27011'"
			[+] PushButton  RenamingRules 
				[ ] locator "@windowid='27010'"
			[+] PushButton  HideAccepted 
				[ ] //locator "*Accepted*"
				[ ] locator "@windowid='27009'"
			[+] PushButton AcceptAll
				[ ] //locator "*Accept*"
				[ ] locator "[@windowid='27002' or @windowid='22599']"
			[ ] 
			[+] PushButton AddReminderButton
				[ ] locator "@windowid='518'"
			[+] PushButton ManageReminderButton
				[ ] locator "@windowid='507'"
			[+] TextField EnterFINameTextField
				[ ] locator "@windowid='1017'"						
			[+] PushButton CheckAvailabilityButton
				[ ] locator "Check Availability"
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[+] Control Home
			[ ] locator "Home"
			[+] Control QWStayOnTopOfMonthlyBills
				[ ] locator "@windowClassName='QWSnapHolder'"
				[+] StaticText StaticTextSMB
					[+] Control Panel
						[ ] locator "@windowClassName='QWPanel'"
						[+] StaticText LAST30DAYS											
							[ ] locator "@windowid='1002'"
						[+] PushButton GetStarted
							[ ] locator "[@caption='Get Started'][1]"
						[+] StaticText BILLANDINCOMEREMINDERSNE											
							[ ] locator "@windowid='1066'"
							[+] MainWin QWListViewer
								[ ] locator "@windowid='1'"
								[+] ListBox ListBox
									[ ] locator "@windowid='1'"
						[+] VerticalScrollBar VerticalScrollBar
							[ ] locator "//VerticalScrollBar[1]"
						[+] Control SpendingPieChart									
							[ ] locator "@windowClassName='QWGraphControlClass'"
							[+] Control Panel
								[ ] locator "@windowClassName='QWPanel'"
								[+] MainWin QWListViewer
									[ ] locator "@windowid='1'"
									[+] ListBox ListBox
										[ ] locator "@windowid='1'"
						[+] PushButton ExamineYourSpendingButton
							[ ] locator "@windowid='1087'"
						[ ] 
						[ ] 
				[+] StaticText StaticTextTSG
					[+] Control Panel
						[+] PushButton GetStarted
							[ ] locator "@windowid='1000'"
							[ ] //locator "[@caption='Get Started'][2]"
						[+] CustomWin Panel
							[+] multitag "[QWPanel]Panel"
								[ ] "$-1"
						[+] Control QWinChild
							[ ] locator "@windowid='0'"
							[+] MainWin MonthlyGoal
								[ ] locator "@windowid='2400'"
								[+] ListBox ListBox
									[ ] locator "@windowid='1'"
					[+] Control Budget
						[ ] locator "@windowClassName='QWinChild'"
						[+] Control Panel
							[ ] //locator "[5]"
							[+] Control Label
								[ ] locator "@windowid='1861'"
				[ ] 
				[+] VerticalScrollBar VerticalScrollBar
					[ ] locator "//VerticalScrollBar[1]"
				[ ] 
				[ ] 
				[ ] 
				[+] // StaticText SeeWhereYourMoneyGoes
					[+] // multitag "#1"
						[ ] // "$-1[1]"
					[+] // CustomWin Panel
						[+] // multitag "[QWPanel]Panel"
							[ ] // "$-1"
						[+] // StaticText LAST30DAYSSPENDING
							[+] // multitag "#1"
								[ ] // "$1002"
								[ ] // "LAST 30 DAYS SPENDING (* - *)"
						[ ] // // StaticText("LAST 30 DAYS SPENDING (08-2012 - 09-2012)|#1|$1002|@(237,21)")
			[+] PushButton SMBOptionsButton
				[ ] locator "//PushButton[@priorlabel='Projected Payoff']"
			[+] ListBox SMBListBox
				[ ] locator "//ListBox[2]"
			[ ] 
			[+] ListBox LoanSummaryListBox
				[ ] locator "//ListBox[1]"
			[+] ListBox NetWorthListBox
				[ ] locator "//ListBox[2]"
			[+] ListBox PropertyDebtAccountsListBox
				[ ] locator "//ListBox[3]"
			[ ] 
			[ ] //Calendar Snapshot
			[+] PushButton GoButton
				[ ] locator "Go"
				[ ] 
				[ ] 
			[ ] //All Accounts Snapshot
			[+] ListBox ListBox2
				[ ] locator "//ListBox[2]"
			[+] ListBox ListBox1
				[ ] locator "//ListBox[1]"
			[ ] 
			[ ] //Budget Snapshot
			[+] PushButton ViewupdatesButton
				[ ] locator "View updates"
				[ ] 
				[ ] 
			[+] Control GraphViewSummaryTotalSpending
				[ ] locator "@windowid='1861'"
			[+] Control GraphViewSummaryTotalBudget
				[ ] locator "@windowid='1870'"
			[+] Control GraphViewSummaryTotalSavings
				[ ] locator "@windowid='1873'"
			[+] Control GraphViewSummaryTotalLeft
				[ ] locator "@windowid='1867'"
			[ ] 
			[ ] 
			[ ] //Alerts SnapShot
			[+] PushButton ShowAllAlertsButton
				[ ] locator "Show all alerts"
			[ ] ////See Where Your Money Goes Snapshot
			[+] PushButton ExamineYourSpendingButton
				[ ] locator "Examine Your Spending"
			[ ] 
			[ ] 
		[ ] 
		[+] Control BrokerageAccount
			[ ] locator "@windowClassName='QWMDI'"										// updated by Udita on 20 Aug
			[+] PushButton EnterTransactions
				[ ] locator "@windowid='981'"
			[+] PushButton Holdings
				[ ] //locator "@windowid='999'"
				[ ] locator "Holdings"
			[ ] 
			[+] PushButton Find
				[ ] locator "@windowid='32206'"
			[+] StaticText StaticText1
				[ ] //locator "@windowid='-1'"
				[+] StaticText StaticText2
					[ ] //locator "@windowid='-1'"
					[+] MainWin RegisterListBox
						[ ] locator "@windowid='982'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
					[ ] 
			[ ] 
			[+] PushButton AccountActions
				[ ] locator "@windowid='32221'"
				[ ] 
			[+] Control QWSnapHolder1
				[ ] locator "@windowClassName='QWSnapHolder'"
				[+] StaticText StaticText1
					[ ] //locator "@windowid='-1'"
					[+] StaticText StaticText2
						[ ] //locator "@windowid='-1'"
						[+] PushButton AcceptAll
							[ ] locator "@windowid='27002'"
					[+] MainWin QWListViewer1
						[ ] locator "@windowid='8200'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[ ] 
					[ ] 
			[+] Control wTransaction
				[ ] locator "@windowClassName='QWinChild'"
				[+] PushButton DownloadTransactionsTab
					[ ] locator "@windowid='1021'"
				[+] PushButton BillAndIncomeRemindersTab
					[ ] locator "@windowid='1022'"
				[+] PushButton SetUpDownload
					[ ] locator "@windowid='1023'"
				[+] PushButton SetUpOnlinePayment
					[ ] locator "@windowid='1024'"
			[+] Control QWHtmlView
				[ ] locator "//Control[@windowClassName='QWHtmlView'][1]"
			[ ] 
			[+] // StaticText StaticText
				[ ] // locator "@windowid='7'"
				[+] // StaticText Balance
					[+] // locator "Balance"
						[ ] // //"^Cash Balance:"
						[ ] // 
				[+] // // StaticText StaticText1
					[+] // // multitag "#1|$-1|@(530,278)"
						[ ] // // "$-1"
					[+] // // CustomWin QWHtmlView1
						[+] // // multitag "[QWHtmlView]#1"
							[ ] // // "$1000"
					[+] // // CustomWin QWHtmlViewer
						[+] // // multitag "[QWListViewer]#1"
							[ ] // // "$982"
							[ ] // // "@(530,251)"
						[+] // // ListBox CashBalance
							[+] // // multitag "#1|$1|@(530,260)"
								[ ] // // "$1"
			[ ] 
			[ ] 
		[ ] 
		[+] // Control Business
			[ ] // locator "Business"
			[+] // PushButton SelectAccounts
				[ ] // locator "@windowid='2225'"
			[+] // PushButton CashFlowDetails
				[ ] // locator "@windowid='2226'"
			[+] // PushButton ProjectedBalances
				[ ] // locator "@windowid='2227'"
		[+] Control Business
			[ ] //locator "Business"
			[ ] locator "@windowClassName='QWMDI'"	
			[+] PushButton SelectAccounts
				[ ] locator "@windowid='2225'"
			[+] PushButton CashFlowDetails
				[ ] locator "Cash Flow Details"
			[+] PushButton ProjectedBalances
				[ ] locator "@windowid='2227'"
			[ ] 
			[+] Control ProfitLossSnapshot
				[ ] //locator "@windowid='0'"
				[ ] locator "@windowClassName='QWinChild'"
				[+] Control MonthPanel
					[ ] locator "//Control[@caption='Panel'][1]"
					[ ] //locator "@windowid='-1'"
					[+] Control QWListViewer1
						[ ] locator "@windowid='2030'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] StaticText TotalIn
						[ ] locator "@windowid='2051'"
					[+] StaticText TotalOut
						[ ] locator "@windowid='2091'"
					[+] Control QWListViewer2
						[ ] locator "@windowid='2070'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] StaticText LastMonthProjectedText
						[ ] locator "@windowid='2131'"
				[+] Control Panel2
					[ ] locator "//Control[@caption='Panel'][2]"
					[ ] //locator "@windowid='-1'"
					[+] StaticText StaticText1
						[ ] //locator "@windowid='-1'"
						[+] PushButton AddReminderButton
							[ ] locator "@windowid='518'"
						[+] PushButton OptionsButton
							[ ] locator "@windowid='1000'"
						[+] StaticText StaticText1
							[ ] locator "@windowid='31000'"
							[+] PushButton OptionsButton
								[ ] locator "@windowid='1000'"
							[+] StaticText StaticText1
								[ ] locator "@windowid='-1'"
							[+] ComboBox ShowPopupList
									[ ] locator "@windowid='200'"
						[+] StaticText StaticText2
							[ ] locator "@windowid='-1'"
							[+] PushButton ManageRemindersButton
								[ ] locator "@windowid='507'"
							[+] PushButton AddReminderButton
								[ ] locator "@windowid='518'"
							[ ] 
					[+] StaticText StaticText2
						[ ] locator "@windowid='-1'"
						[+] PushButton ManageRemindersButton
							[ ] locator "@windowid='507'"
						[+] PushButton AddReminderButton
							[ ] locator "@windowid='518'"
						[ ] 
					[+] StaticText StaticText3
						[ ] locator "@windowid='31000'"
						[+] Control OptionsButton
							[ ] locator "@windowid='1000'"
					[+] Control QWHtmlView1
						[ ] locator "@windowid='-1'"
				[ ] 
			[ ] 
			[+] Control CashFlowTab
				[ ] locator "@windowClassName='QWinChild'"
				[ ] 
				[+] Control Panel2
					[ ] locator "//Control[@caption='Panel'][2]"
					[ ] //locator "Panel"
					[ ] 
					[+] StaticText StaticText1
						[ ] //locator "//StaticText[16]"
						[ ] 
						[+] StaticText StaticText2
							[ ] // locator "@(582,228)"
							[ ] //locator "//StaticText[17]"
							[ ] 
							[+] PushButton AddReminderButton
								[ ] locator "Add Reminder"
								[ ] //locator "@windowid='518'"
								[ ] 
							[+] PushButton ManageRemindersButton
								[ ] locator "Manage Reminders"
								[ ] //locator "@windowid='507'"
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] StaticText StaticText3
						[ ] //locator "@windowid='-1'"
						[+] StaticText StaticText1
							[+] StaticText StaticText
								[+] ComboBox ShowPopupList
										[ ] locator "@windowid='200'"
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[+] Control AccountOverviewTab
				[ ] //locator "@windowid='-1'"
				[ ] locator "[@windowClassName='QWSnapHolder']"
				[+] StaticText InvoiceAccounts
					[ ] locator "[1]"
					[ ] //locator "@windowid='-1'"
					[+] StaticText ShowInvoice
						[ ] //locator "@windowid='-1'"
						[+] MainWin ShowInvoiceAccounts
							[ ] locator "@windowid='120'"
							[+] ListBox ListBox1
								[ ] locator "@windowid='1'"
							[ ] 
				[+] StaticText SpendingAccounts
					[ ] locator "[4]"
					[ ] //locator "@windowid='-1'"
					[+] StaticText ShowSpending
						[ ] //locator "@windowid='-1'"
						[+] MainWin ShowSpendingAccounts
							[ ] locator "@windowid='120'"
							[+] ListBox ListBox1
								[ ] locator "@windowid='1'"
						[ ] 
				[+] StaticText CreditCardAccounts
					[ ] locator "[7]"
					[+] MainWin ShowCreditCardAccounts
						[ ] locator "@windowid='1'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
							[ ] 
				[+] StaticText AssetAccounts
					[ ] locator "[9]"
					[ ] //locator "@windowid='-1'"
					[+] StaticText ShowAsset
						[ ] //locator "@windowid='-1'"
						[+] MainWin ShowAssetAccounts
							[ ] locator "@windowid='120'"
							[+] ListBox ListBox1
								[ ] locator "@windowid='1'"
					[ ] 
					[ ] 
					[ ] 
				[+] StaticText TaxCenter
					[ ] // locator "@windowid='-1'"
					[+] StaticText TaxRelatedExpensesYTD
						[ ] // locator "@windowid='-1'"
						[+] PushButton AssignTaxCategories
							[ ] locator "@windowid='503'"
					[+] MainWin QWListViewer
						[ ] locator "@windowid='1'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
						[ ] 
					[+] StaticText StaticText1
						[ ] locator "@windowid='31000'"
					[ ] 
					[+] Control TaxRelatedExpensesYTDPane
						[ ] locator "@windowid='-1'"
					[ ] 
				[+] Control Panel
					[ ] //locator "@windowid='-1'"
					[ ] locator "[@windowClassName='QWPanel']"
					[+] Control SetupScreenHolder
						[ ] locator "Savings Goals"
						[+] Control Panel1
							[ ] //locator "@windowid='-1'"
							[ ] locator "[@windowClassName='QWPanel']"
							[+] StaticText IdentifyYourDebtsText
								[ ] locator "@windowid='10001'"
							[+] PushButton SavingGoal
								[ ] locator "@windowid='125'"
							[+] StaticText GoalAmount
								[ ] locator "@windowid='135'"
							[+] StaticText FinishDate
								[ ] locator "@windowid='137'"
							[+] PushButton DeleteIcon
								[ ] locator "@windowid='140'"
							[+] PushButton ContributeButton
								[ ] locator "@windowid='127'"
							[ ] 
						[+] Control Panel
							[ ] locator "[@windowClassName='QWPanel']"
							[ ] // locator "@windowid='-1'"
							[ ] 
							[+] PushButton QC_button2
								[ ] locator "@windowid='140'"
							[+] PushButton SmokeSavingGoal
								[ ] locator "@windowid='125'"
							[+] PushButton QC_button3
								[ ] locator "@windowid='126'"
							[+] PushButton Contribute
								[ ] locator "@windowid='127'"
							[+] PushButton QC_button5
								[ ] locator "@windowid='128'"
							[+] PushButton Withdraw
								[ ] locator "@windowid='129'"
							[+] PushButton By01Jan2013
								[ ] locator "@windowid='130'"
							[+] PushButton EditGoal
								[ ] locator "@windowid='131'"
							[+] StaticText StaticText2
								[ ] locator "@windowid='138'"
							[+] StaticText N2000Text
								[ ] locator "@windowid='135'"
							[+] StaticText By01Jan2013Text
								[ ] locator "@windowid='137'"
							[+] StaticText MonthlyContributionToMeetG
								[ ] locator "@windowid='136'"
							[+] MainWin QWGoalViewer1
								[ ] locator "@windowid='132'"
						[ ] 
						[ ] 
					[ ] 
					[+] PushButton GoalActions
						[ ] locator "@windowid='139'"
					[+] // Control SavingsGoals
						[ ] // locator "@windowid='0'"
						[+] // Control Panel
							[ ] // locator "[@windowClassName='QWPanel']"
							[ ] // // locator "@windowid='-1'"
							[+] // PushButton QC_button2
								[ ] // locator "@windowid='140'"
							[+] // PushButton SmokeSavingGoal
								[ ] // locator "@windowid='125'"
							[+] // PushButton QC_button3
								[ ] // locator "@windowid='126'"
							[+] // PushButton Contribute
								[ ] // locator "@windowid='127'"
							[+] // PushButton QC_button5
								[ ] // locator "@windowid='128'"
							[+] // PushButton Withdraw
								[ ] // locator "@windowid='129'"
							[+] // PushButton By01Jan2013
								[ ] // locator "@windowid='130'"
							[+] // PushButton EditGoal
								[ ] // locator "@windowid='131'"
							[+] // StaticText StaticText2
								[ ] // locator "@windowid='138'"
							[+] // StaticText N2000Text
								[ ] // locator "@windowid='135'"
							[+] // StaticText By01Jan2013Text
								[ ] // locator "@windowid='137'"
							[+] // StaticText MonthlyContributionToMeetG
								[ ] // locator "@windowid='136'"
							[+] // MainWin QWGoalViewer1
								[ ] // locator "@windowid='132'"
						[ ] 
					[+] StaticText YourSavingsGoalsText
						[ ] locator "@windowid='134'"
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[+] PushButton ProfitLossDetails
				[ ] locator "Profi*Loss Details"
			[ ] 
			[+] Control QWSnapHolder
				[ ] locator "@windowid='-1'"
				[+] StaticText InvoiceAccounts
					[ ] locator "@windowid='-1'"
					[+] StaticText Account
						[ ] locator "@windowid='-1'"
						[+] Control QWListViewer
							[ ] locator "@windowid='120'"
							[+] ListBox InvoiceAccount
								[ ] locator "@windowid='1'"
			[+] Control Panel2		
				[ ] locator "@windowid='-1'"						
				[+] StaticText StaticText1
					[ ] locator "@windowid='-1'"
				[+] StaticText StaticText2
					[ ] locator "@windowid='-1'"
					[+] Control AddReminder
						[ ] locator "@windowid='518'"
					[+] PushButton ManageRemindersButton
						[ ] locator "@windowid='507'"
					[ ] 
				[ ] 
			[+] ComboBox BusinessPopupList
				[ ] locator "@windowid='2221'"
			[+] PushButton ProfitLossDetailsButton
				[ ] locator "@windowid='2223'"
			[+] PushButton PreMonth
				[ ] locator "@windowid='32351'"
			[+] StaticText CurrentMonth
				[ ] locator "@windowid='32352'"
			[+] PushButton PostMonth
				[ ] locator "@windowid='32353'"
				[ ] 
			[+] Control SnapShotGraph
				[ ] locator "@windowClassName='QWinChild'"
				[ ] //locator "@windowid='0'"
				[+] Control Panel1
					[ ] locator "//Control[@caption='Panel'][1]"
					[ ] //locator "@windowid='-1'"
					[+] Control INSnopshot
						[ ] locator "@windowid='2030'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] StaticText Total1Text
						[ ] locator "@windowid='2041'"
					[+] StaticText N0005Text
						[ ] locator "@windowid='2051'"
					[+] Control OUTSnopshot
						[ ] locator "@windowid='2070'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] StaticText Total2Text
						[ ] locator "@windowid='2081'"
					[+] StaticText N0006Text
						[ ] locator "@windowid='2091'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='2110'"
					[+] StaticText CurrentProfitText
						[ ] locator "@windowid='2111'"
					[+] StaticText OnMay3Text
						[ ] locator "@windowid='2112'"
					[+] StaticText N0001Text
						[ ] locator "@windowid='2120'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='2130'"
					[+] StaticText LastMonthSText
						[ ] locator "@windowid='2131'"
					[+] StaticText ProfitText
						[ ] locator "@windowid='2132'"
					[+] PushButton QC_button4
						[ ] locator "@windowid='2133'"
					[+] Control Profit1
						[ ] locator "@windowid='2134'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] Control Profit2
						[ ] locator "@windowid='2135'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] PushButton QC_button3
						[ ] locator "@windowid='2136'"
					[+] StaticText ProjectedChangeFromText
						[ ] locator "@windowid='2137'"
					[+] StaticText LastMonthText
						[ ] locator "@windowid='2138'"
					[+] StaticText N0002Text
						[ ] locator "@windowid='2140'"
					[+] StaticText N0003Text
						[ ] locator "@windowid='2141'"
					[+] StaticText N0004Text
						[ ] locator "@windowid='2142'"
					[+] Control ListViewer1
						[ ] locator "@windowid='2134'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
				[+] Control Panel2
					[ ] locator "@windowid='-1'"
					[+] StaticText StaticText1
						[ ] locator "@windowid='-1'"
						[+] Control AddReminder
							[ ] locator "@windowid='518'"
						[+] Control QWListViewer
							[ ] locator "@windowid='1'"
							[+] ListBox ListBox1
								[+] locator "@windowid='1'"
									[ ] 
			[ ] 
		[ ] 
		[-] Control Bills	
			[ ] locator "Bills"
			[+] CheckBox IncludePaid
				[ ] locator "@windowid='105'"
			[+] Control Panel									
				[ ] // locator "@windowClassName='QWPanel'"	
				[+] Control QWMsHtmlVw1
					[ ] locator "@windowid='1000'"
					[+] // CustomWin ShellEmbedding1
						[ ] // locator "@windowid='0'"
						[+] // CustomWin ShellDocObjectView1
							[+] // locator "@windowid='0'"
								[ ] // "[Shell DocObject View]$0"
							[+] // CustomWin GetStartedBillsButton
								[+] // multitag "[Internet Explorer_Server]#1"
									[ ] // "[Internet Explorer_Server]$0"
				[+] Control Panel1
					[ ] //locator "@windowClassName='QWPanel'"	
					[+] Control QWinChild
						[ ] // locator "@windowid='0'"
						[ ] // locator "@windowClassName='QWinChild'"	
						[ ] 
						[+] PushButton GoToRegisterButton
							[ ] locator "Go to Register"
						[+] PushButton WebsiteLink
							[ ] locator "@windowid='1003'"
						[+] PushButton Enter
							[ ] //locator "Enter"
							[ ] locator "@windowid='1005'"
						[+] PushButton Skip
							[ ] //locator "Skip"
							[ ] locator "@windowid='1006'"
						[+] PushButton Edit
							[ ] //locator "Edit"
							[ ] locator "@windowid='1021'"
						[+] PushButton ShowHistory
							[ ] //locator "Show History"
							[ ] locator "@windowid='1019'"
						[ ] 
					[+] Control QWinChild1
						[ ] // locator "@windowid='0'"
						[ ] // locator "@windowClassName='QWinChild'"	
						[+] PushButton EnterButton
							[ ] locator "Enter"
						[+] PushButton SkipButton
							[ ] locator "Skip"
						[+] PushButton Edit
							[ ] locator "Edit"
							[ ] 
							[+] MenuItem EditSingleInstance
								[ ] locator "@windowid='1022'"
								[ ] 
							[+] MenuItem EditMultipleInstance
								[ ] locator "@windowid='1020'"
								[ ] 
							[ ] 
							[ ] 
						[+] PushButton ShowHistory
							[ ] locator "Show History"
						[ ] 
						[ ] 
				[+] // Control Panel2
					[+] // multitag "[QWPanel]Panel[2]"
						[ ] // "[QWPanel]#2"
						[ ] // "[QWPanel]$-1[2]"
						[ ] // "[QWPanel]@(594,448)"
					[+] // Control QWinChild1
						[+] // multitag "[QWinChild]#1"
							[ ] // "[QWinChild]$0"
							[ ] // "[QWinChild]@(580,188)"
						[+] // Control Panel
							[+] // multitag "[QWPanel]Panel"
								[ ] // "[QWPanel]#1"
								[ ] // "[QWPanel]$-1"
								[ ] // "[QWPanel]@(85,186)"
							[+] // CustomWin Panel1
								[+] // multitag "[QWPanel]Panel[1]"
									[ ] // "[QWPanel]#1"
									[ ] // "[QWPanel]$-1[1]"
									[ ] // "[QWPanel]@(85,61)"
							[+] // CustomWin Panel2
								[+] // multitag "[QWPanel]Panel[2]"
									[ ] // "[QWPanel]#2"
									[ ] // "[QWPanel]$-1[2]"
									[ ] // "[QWPanel]@(85,112)"
						[ ] // 
				[ ] 
			[+] // StaticText ViewAs1Text										
				[+] // multitag "View as"
					[ ] // "#1"
					[ ] // "$100"
			[+] ComboBox ViewAsPopupList								
				[ ] locator "@windowid='101'"
			[+] // StaticText AccountTextStaticText							  
				[+] // multitag "Account"
					[ ] // "#2"
					[ ] // "$107"
			[+] ComboBox AccountPopupList								 
				[ ] locator "@windowid='108'"
			[+] // StaticText DueWithinNextTextStaticText					
				[+] // multitag "Due within next"
					[ ] // "#3"
					[ ] // "$102"
			[+] ComboBox DueWithinNextPopupList						
				[ ] locator "@windowid='103'"
			[+] StaticText ViewAs2TextStaticText
				[ ] // locator "View as"					
				[+] StaticText ViewAsSubTextStaticText		
					[ ] // locator "@windowid='0'"
					[+] MainWin ViewAsQWListViewer	
						[ ] // locator "@windowClassName='QWListViewer'"	
						[ ] locator "@windowid='1'"				             
						[+] ListBox ReminderListBox	
							[ ] locator "@windowid='1'"			
					[ ] 
			[+] PushButton SyncToOutlookButton				
				[ ] locator "@windowid='106'"
			[+] Control Calendar						
				[ ] locator "@windowClassName='QWinChild'"	
				[+] Control Panel
					[ ] locator "@windowClassName='QWPanel'"	
					[+] StaticText PanelText1
						[ ] //locator "@windowid='-1'"
						[+] StaticText PanelText2
							[ ] //locator "@windowid='-1'"
							[+] PushButton AddReminderButton
								[ ] locator "@windowid='518'"
							[+] PushButton ManageRemindersrButton
								[ ] locator "@windowid='507'"
								[ ] 
							[ ] 
							[ ] 
					[ ] 
				[ ] 
				[+] PushButton ShowFullCalendarButton
					[ ] locator "Show Full Calendar"
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Added By Dean on 29th May 2013 for Month Selector of Monthly List View on Upcoming Tab for Bill Management
			[+] PushButton PreviousMonth
				[ ] locator "@windowid='32351'"
			[+] StaticText MonthSelectorText
				[ ] locator "@windowid='32352'"
			[+] PushButton NextMonth
				[ ] locator "@windowid='32353'"
				[ ] 
			[ ] 
			[+] PushButton Enter
				[ ]   //locator "Enter"
				[ ] locator "@windowid='1005'"
			[+]  PushButton Skip
				[ ] //locator "Skip"
				[ ] locator "@windowid='1006'"
			[+] PushButton Edit
				[ ] locator "Edit"
			[ ] 
			[ ] //List View 
			[+] ListBox ListBox
				[ ] locator "//ListBox"
				[ ] 
			[ ] 
			[ ] //Projected Balances
			[+] ComboBox TimeRangePopupList								 
				[ ] locator "@windowid='203'"
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[+] Control Planning
			[ ] locator "Planning"
			[+] Control PlanningSubTab
				[ ] //locator "@windowid='-1'"
				[ ] locator "[@windowClassName='QWSnapHolder']"
				[+] StaticText SpendingPlanner
					[ ] locator "@windowid='-1'"
					[+] StaticText CategorizedSpending 
						[ ] locator "@windowid='-1'"
						[+] Control MonthlySpendingSavingPlan
							[ ] locator "@windowid='0'"
							[+] MainWin QWListViewer1
								[ ] locator "@windowid='2400'"
								[+] ListBox ListBox1
									[ ] locator "@windowid='1'"
					[+] StaticText ShowSpending 
						[ ] locator "@windowid='-1'"
						[+] Control ShowSpendingReport
							[ ] locator "@windowid='2410'"
					[ ] 
				[ ] 
				[+] StaticText TaxRelatedExpenses
					[ ] locator "[7]"
					[ ] // locator "@windowid='-1'"
					[+] StaticText TaxRelatedExpensesYTD
						[ ] // locator "@windowid='-1'"
						[+] PushButton AssignTaxCategories
							[ ] locator "@windowid='503'"
					[+] MainWin QWListViewer
						[ ] locator "@windowid='1'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
						[ ] 
					[ ] 
					[+] StaticText StaticText1
						[ ] locator "@windowid='31000'"
					[ ] 
					[+] Control TaxRelatedExpensesYTDPane
						[ ] locator "@windowid='-1'"
					[ ] 
				[ ] 
				[+] StaticText TaxRelatedIncome
					[ ] locator "[10]"
					[ ] // locator "@windowid='-1'"
					[+] StaticText TaxRelatedExpensesYTD
						[ ] // locator "@windowid='-1'"
						[+] PushButton AssignTaxCategories
							[ ] locator "@windowid='503'"
					[+] MainWin QWListViewer
						[ ] locator "@windowid='1'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
						[ ] 
					[ ] 
					[+] StaticText StaticText1
						[ ] locator "@windowid='31000'"
					[ ] 
					[+] Control TaxRelatedIncomeYTDPane
						[ ] locator "@windowid='-1'"
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] Control Panel
					[ ] //locator "@windowid='-1'"
					[ ] locator "[@windowClassName='QWPanel']"
					[+] Control SetupScreenHolder
						[ ] locator "Savings Goals"
						[+] Control Panel1
							[ ] //locator "@windowid='-1'"
							[ ] locator "[@windowClassName='QWPanel']"
							[+] StaticText IdentifyYourDebtsText
								[ ] locator "@windowid='10001'"
							[+] PushButton SavingGoal
								[ ] locator "@windowid='125'"
							[+] StaticText GoalAmount
								[ ] locator "@windowid='135'"
							[+] StaticText FinishDate
								[ ] locator "@windowid='137'"
							[+] PushButton DeleteIcon
								[ ] locator "@windowid='140'"
							[+] PushButton ContributeButton
								[ ] locator "@windowid='127'"
							[ ] 
						[+] Control Panel
							[ ] locator "[@windowClassName='QWPanel']"
							[ ] // locator "@windowid='-1'"
							[ ] 
							[+] PushButton QC_button2
								[ ] locator "@windowid='140'"
							[+] PushButton SmokeSavingGoal
								[ ] locator "@windowid='125'"
							[+] PushButton QC_button3
								[ ] locator "@windowid='126'"
							[+] PushButton Contribute
								[ ] locator "@windowid='127'"
							[+] PushButton QC_button5
								[ ] locator "@windowid='128'"
							[+] PushButton Withdraw
								[ ] locator "@windowid='129'"
							[+] PushButton By01Jan2013
								[ ] locator "@windowid='130'"
							[+] PushButton EditGoal
								[ ] locator "@windowid='131'"
							[+] StaticText StaticText2
								[ ] locator "@windowid='138'"
							[+] StaticText N2000Text
								[ ] locator "@windowid='135'"
							[+] StaticText By01Jan2013Text
								[ ] locator "@windowid='137'"
							[+] StaticText MonthlyContributionToMeetG
								[ ] locator "@windowid='136'"
							[+] MainWin QWGoalViewer1
								[ ] locator "@windowid='132'"
						[ ] 
						[ ] 
					[ ] 
					[+] PushButton GoalActions
						[ ] locator "@windowid='139'"
					[+] // Control SavingsGoals
						[ ] // locator "@windowid='0'"
						[+] // Control Panel
							[ ] // locator "[@windowClassName='QWPanel']"
							[ ] // // locator "@windowid='-1'"
							[+] // PushButton QC_button2
								[ ] // locator "@windowid='140'"
							[+] // PushButton SmokeSavingGoal
								[ ] // locator "@windowid='125'"
							[+] // PushButton QC_button3
								[ ] // locator "@windowid='126'"
							[+] // PushButton Contribute
								[ ] // locator "@windowid='127'"
							[+] // PushButton QC_button5
								[ ] // locator "@windowid='128'"
							[+] // PushButton Withdraw
								[ ] // locator "@windowid='129'"
							[+] // PushButton By01Jan2013
								[ ] // locator "@windowid='130'"
							[+] // PushButton EditGoal
								[ ] // locator "@windowid='131'"
							[+] // StaticText StaticText2
								[ ] // locator "@windowid='138'"
							[+] // StaticText N2000Text
								[ ] // locator "@windowid='135'"
							[+] // StaticText By01Jan2013Text
								[ ] // locator "@windowid='137'"
							[+] // StaticText MonthlyContributionToMeetG
								[ ] // locator "@windowid='136'"
							[+] // MainWin QWGoalViewer1
								[ ] // locator "@windowid='132'"
						[ ] 
					[+] StaticText YourSavingsGoalsText
						[ ] locator "@windowid='134'"
					[ ] 
			[ ] 
			[+] PushButton ChangeAssumptions
				[ ] locator "Change Assumptions"
				[ ] // locator "//PushButton[@windowid='2202']"
				[ ] 
			[+] Control DebtReduction   	
				[ ] locator "[@windowClassName='QWSnapHolder']"
				[ ] //locator "@windowid='-1'"					
				[+] Control Panel
					[ ] //locator "@windowid='-1'"
					[+] Control SetupScreenHolder	
						[ ] //locator "@windowid='0'"						
						[+] Control SetupScreen
							[ ] //locator "@windowid='0'"
							[+] StaticText IdentifyTheDebtsYouWantTo
								[ ] locator "@windowid='1031'"
							[+] StaticText ListedBelowAreTheDebtsYou
								[ ] locator "@windowid='1350'"
							[+] StaticText BeingCompleteIsImportantI
								[ ] locator "@windowid='1351'"
							[+] StaticText ACCOUNTSTOINCLUDEINTHISPL
								[ ] locator "@windowid='1022'"
							[+] StaticText BALANCEText
								[ ] locator "@windowid='1023'"
							[+] MainWin BALANCE1
								[ ] locator "@windowid='1011'"
								[+] ListBox ListBox1
									[ ] locator "@windowid='1'"
							[+] MainWin BALANCE2
								[ ] locator "@windowid='1012'"
								[+] ListBox ListBox1
									[ ] locator "@windowid='1'"
							[+] StaticText TotalInPlanText
								[ ] locator "@windowid='1024'"
							[+] StaticText N10000Text
								[ ] locator "@windowid='1025'"
							[+] StaticText TipBeSureToIncludeAllCr
								[ ] locator "@windowid='1352'"
						[+] Control Panel1
							[ ] locator "@windowid='-1'"
						[+] Control Panel2
							[ ] locator "@windowid='-1'"
							[+] PushButton QC_button1
								[ ] locator "@windowid='32765'"
							[+] PushButton NEXT
								[ ] locator "@windowid='32767'"
					[ ] 
				[+] StaticText TaxableIncomeStaticText	
					[+] CustomWin QWListViewer
						[ ] locator "@windowid='1'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
					[+] Control TaxRelatedIncomeYTDPane
						[ ] locator "@windowid='-1'"
			[ ] 
			[ ] 
		[ ] 
		[+] Control Budget
			[ ] locator "[@caption='Budge*']"
			[+] Control Panel  
				[ ] locator "Control[@windowClassName='QWPanel']"
				[+] Control TotalSpending 				
					[ ] locator "@windowid='1861'"
				[ ] 
			[+] MainWin ListViewer					
				[ ] locator "@windowid='1400'"
				[+] ListBox ListBox
					[ ] locator "@windowid='1'"
					[+] TextField Amount
						[ ] locator "@windowid='2076'"
			[+] PushButton BudgetActions				
				[ ] locator "@windowid='1451'"
			[+] PushButton AddCategoryToBudget
				[ ] locator "@windowid='1435'"
				[ ] 
			[ ] //Summary Bar Controls
			[ ] 
			[+] Control GraphViewSummaryTotalSpending
				[ ] locator "@windowid='1861'"
			[+] Control GraphViewSummaryTotalBudget
				[ ] locator "@windowid='1870'"
			[+] Control GraphViewSummaryTotalSavings
				[ ] locator "@windowid='1873'"
			[+] Control GraphViewSummaryTotalLeft
				[ ] locator "@windowid='1867'"
			[+] ComboBox BudgetViewTypeComboBox		
				[ ] locator "@windowid='1463'"
			[+] PushButton SelectCategoryToBudgetLink
				[ ] locator "Select Categories to Budget"
				[ ] 
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
				[+] TextField Amount
					[ ] locator "//TextField"
			[ ] ///Added on April 17 2014
			[+] PushButton BackWardMonthButton
				[ ] locator "[@windowid='32351' or @windowid='32354']"
				[ ] 
			[+] PushButton ForwardMonthButton
				[ ] locator "[@windowid='32353' or @windowid='32356']"
				[ ] 
				[ ] 
			[+] StaticText CurrentMonthStaticText
				[ ] 
				[ ] locator "[@windowid='32352' or @windowid='32355']"
			[+] ComboBox  AnnualViewTypeComboBox
				[ ] locator "@windowid='1464'"
			[+] CheckBox ShowBalanceInFutureMonthsCheckBox
				[ ] locator "[@windowid='1440' or @windowid='1441']"
			[+] ComboBox BudgetDurationComboBox		
				[ ] locator "@windowid='1461'"
			[+] Control SummaryBarNotification	
				[ ] locator "@windowid='1869'"
			[+] ComboBox BudgetNameComboBox		
				[ ] locator "@windowid='1450'"
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] // Control Investing 
			[ ] // locator "Investing"
			[ ] // 
			[+] // ComboBox AccountFilter
				[ ] // locator "@windowid='2015'"
			[+] // ComboBox SecurityFilter
				[ ] // locator "@windowid='2014'"
			[+] // ComboBox DateFilter
				[ ] // locator "@windowid='2017'"
				[ ] // 
				[ ] // 
			[ ] // 
			[+] // Control Panel
				[ ] // locator "@windowClassName='QWSnapHolder'"
				[+] // StaticText StaticText1
					[ ] // 
					[+] // Control PortfolioCashBasisComparisionGraph
						[ ] // locator "@windowClassName='QWGraphControlClass'"
						[ ] // 
						[ ] // 
						[ ] // 
					[ ] // 
					[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
			[ ] // 
			[+] // Control PortfolioView
				[ ] // //locator "@windowid='3007'"
				[ ] // locator "@windowClassName='QWListViewer'"
				[+] // ListBox PortfolioGrid
					[ ] // locator "@windowid='1'"
					[ ] // 
					[ ] // 
					[ ] // 
				[ ] // 
				[ ] // 
			[ ] // 
			[ ] // 
			[ ] // //3007
			[ ] // 
		[+] Control Investing 
			[ ] locator "Investing"
			[ ] 
			[+] ComboBox AccountFilter
				[ ] locator "@windowid='2015'"
			[+] ComboBox SecurityFilter
				[ ] locator "@windowid='2014'"
			[+] ComboBox DateFilter
				[ ] locator "@windowid='2017'"
				[ ] 
				[ ] 
			[ ] 
			[+] Control Panel
				[ ] locator "@windowClassName='QWSnapHolder'"
				[+] StaticText StaticText1
					[ ] //locator "//StaticText"
					[+] Control PortfolioCashBasisComparisionGraph
						[ ] locator "@windowClassName='QWGraphControlClass'"
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[ ] 
			[ ] 
			[+] PushButton PortfolioCashBasisGraphButton
				[ ] locator "[@windowid='1000'][1]"
			[+] PushButton AverageAnnualReturnGraphButton
				[ ] locator "[@windowid='1000'][2]"
			[ ] 
			[ ] 
			[+] Control PortfolioCashBasisComparisionGraph1
				[ ] locator "[@windowClassName='QWGraphControlClass'][1]"
			[ ] 
			[ ] 
			[ ] 
			[+] PushButton AssetAllocationFullGraphButton
				[ ] locator "[@caption='Show Full Graph']"
			[+] PushButton AllocationByAccountsFullGraphButton
				[ ] locator "[@caption='Show Full Graph'][2]"
			[+] PushButton AllocationBySecurityFullGraphButton
				[ ] locator "[@caption='Show Full Graph'][3]"
			[+] PushButton AllocationGuideButton
				[ ] locator "[@caption='Show Allocation Guide']"
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] Control PortfolioView
				[ ] //locator "@windowid='3007'"
				[ ] locator "@windowClassName='QWListViewer'"
				[+] ListBox PortfolioGrid
					[ ] locator "@windowid='1'"
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //3007
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //-------------Calendar-------------
	[+] window MainWin CalendarPopUpWindow
		[ ] locator "Calendar"
		[+] TextField GoToDateTextField
			[ ] locator "Go to date"
		[+] PushButton GoToDatePushButton
			[ ] locator "[@priorlabel='Go to date'][1]"
		[+] PushButton PushButton
			[ ] locator "[2]"
		[+] PushButton Go
			[ ] locator "Go"
		[+] StaticText September2013
			[ ] locator "September 2013"
		[+] PushButton AddNote
			[ ] locator "Add Note"
		[+] PushButton Options
			[ ] locator "Options"
		[+] PushButton Print
			[ ] locator "Print"
		[+] PushButton Help
			[ ] locator "Help"
	[ ] 
	[ ] 
	[ ] //-------------Delete Account DialogBox--------
	[+] window DialogBox DeleteAccount
		[ ] locator "Delete Account"
		[+] TextField YesField
			[ ] locator "@windowid='109'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
	[ ] 
	[ ] //------Account Actions > Set Up Online----------------
	[+] window MainWin DlgActivateOneStepUpdate
		[ ] locator "Activate One Step Update"
		[+] PushButton Next
			[ ] locator "@windowid='1002'"
		[+] PushButton Cancel
			[ ] locator "@windowid='1004'"
	[ ] 
	[ ] 
	[ ] //------More Actions > Tax Line Item Assignments----------------
	[+] window MainWin TaxLineItemAssignments
		[ ] locator "/MainWin[@caption='Tax Line Item Assignments']"
		[+] StaticText TaxLineItemAssignmentsText
			[ ] locator "Tax Line Item Assignments"
		[+] RadioList TaxLineItemAssignments
			[ ] locator "Standard list"
		[+] StaticText TaxItemText
			[ ] locator "Tax item:"
		[+] ComboBox TaxItem
			[ ] locator "Tax item:"
		[+] StaticText TaxItemExplanationText
			[ ] locator "Tax item explanation:"
		[+] TextField TaxItemExplanation1
			[ ] locator "Tax item explanation:"
		[+] Control TaxItemExplanation2
			[ ] locator "@windowClassName='QWHtmlView'"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Account Actions > Set Up Online----------------
	[+] window MainWin ActivateOneStepUpdate
		[ ] locator "Activate One Step Update"
		[+] RadioList Yes
			[ ] locator "Yes*"
		[+] RadioList No
			[ ] locator "No*"
			[ ] 
		[+] PushButton Next
			[ ] locator "@windowid='1002'"
		[+] // PushButton Cancel
			[ ] // locator "@windowid='1004'"
		[+] PushButton Activate
			[ ] locator "Activate"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton Close
			[ ] locator "Close"
		[ ] 
	[ ] 
	[ ] //------------------- OSU Summary------------------
	[-] window MainWin OneStepUpdateSummary
		[ ] locator "One Step Update Summary"
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
		[+] PushButton Close
			[ ] locator "@windowid='32767'"
		[+] CheckBox ShowJustTheLastUpdate
			[ ] locator "Show just the last update"
		[+] CheckBox ShowThisWindowOnlyWhenThereAreErrors
			[ ] locator "Show this window only when there are errors"
		[+] Control Panel
			[ ] //locator "[1]"
			[ ] locator "[@caption='Panel'][1]"
			[+] Control QWinChild
				[ ] locator "@windowClassName='QWinChild'"
				[+] Control Panel2
					[ ] //locator "[2]"
					[ ] locator "[@caption='Panel'][2]"
					[+] Control QWIconDisplay
						[ ] locator "[@windowClassName='QWIconDisplay'][2]"
					[+] MainWin OneStepUpdateSummary1
						[ ] locator "//MainWin"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
		[+] Control QWinChild
			[ ] locator "@windowClassName='QWinChild'"
		[+] Control Panel2
			[ ] locator "[@caption='Panel'][2]"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] Control QWIconDisplay
			[ ] locator "[@windowClassName='QWIconDisplay'][2]"
			[ ] 
			[ ] 
		[+] Control OneStepUpdateSummary
			[ ] locator "[@priorlabel='One Step Update Summary'][1]"
		[+] StaticText OneStepUpdateSummaryLabel
			[ ] locator "One Step Update Summary"
		[ ] 
	[ ] 
	[+] window DialogBox DlgReconcileDetails
		[ ] locator "Reconcile*"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] TextField PriorCashBalanceTextField
			[ ] locator "@windowid='100'"
		[+] TextField StartingCashBalanceTextField
			[ ] locator "Starting Cash Balance:"
		[+] TextField EndingCashBalanceTextField
			[ ] locator "Ending Cash Balance:"
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Account Actions> Account Overview----------------
	[+] window MainWin DlgAccountOverview
		[ ] locator "Account Overview*"
		[+] Control AccountStatusFrame
			[ ] locator "@windowClassName='QWSnapHolder'"
			[+] StaticText Frame2
				[ ] //locator "@windowid='-1'"
				[+] MainWin QWListViewer
					[ ] locator "@windowid='1'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
			[+] StaticText FrameAccountAttributes
				[ ] //locator "[@windowid='-1'][3]"
				[ ] locator "@windowClassName='Static'"
				[+] Control QWListViewer
					[ ] locator "@windowid='1'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
			[ ] 
		[+] ListBox ListBox1
			[ ] locator "[1]"
		[+] ListBox ListBox2
			[ ] locator "[2]"
		[+] ListBox ListBox3
			[ ] locator "//ListBox[3]"
		[ ] 
		[+] PushButton EditAccountDetailsButton
			[ ] locator "Edit Account Details"
			[ ] 
			[ ] 
		[+] PushButton ChangeOnlineServices
			[ ] locator "Change Online Services"
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Account Actions> Reconcile Details----------------
	[+] window DialogBox ReconcileDetails
		[ ] locator "Reconcile*"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] TextField StartingCashBalanceTextField
			[ ] locator "Starting Cash Balance:"
		[+] TextField EndingCashBalanceTextField
			[ ] locator "Ending Cash Balance:"
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Account Actions>Print Transactions----------------
	[+] window DialogBox PrintRegister
		[ ] locator "Print Register"
		[+] StaticText PrintRegister
			[ ] locator "Print Register"
		[+] StaticText PrintedTitle
			[ ] locator "Printed title:"
		[+] TextField PrintedTitleTextField
			[ ] locator "Printed title:"
		[+] StaticText From
			[ ] locator "From:"
		[+] TextField FromTextField
			[ ] locator "From:"
		[+] StaticText To
			[ ] locator "to:"
		[+] TextField ToTextField
			[ ] locator "to:"
		[+] CheckBox PrintSplitTransactions
			[ ] locator "Print Split Transactions"
		[+] PushButton Print
			[ ] locator "Print..."
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[ ] 
	[ ] //------Account Actions > Transfer Money----------------
	[+] window DialogBox TransferMoneyWithinQuicken
		[ ] locator "Transfer Money Within Quicken"
		[+] StaticText TransferMoneyWithinQuicken
			[ ] locator "Transfer Money Within Quicken"
		[+] StaticText TransferDate
			[ ] locator "Transfer date"
		[+] TextField TransferDateTextField
			[ ] locator "Transfer date"
		[+] StaticText Amount
			[ ] locator "Amount"
		[+] TextField AmountTextField
			[ ] locator "Amount"
		[+] StaticText FromAccount
			[ ] locator "From account"
		[+] ComboBox FromAccountComboBox
			[ ] locator "From account"
		[+] StaticText ToAccount
			[ ] locator "To account"
		[+] ComboBox ToAccountComboBox
			[ ] locator "To account"
		[+] StaticText PayeeDescription
			[ ] locator "@caption='Payee/Description'"
		[+] TextField PayeeDescriptionTextField
			[ ] locator "@caption='Payee/Description'"
		[+] StaticText Optional
			[ ] locator "(optional)"
		[+] StaticText Memo
			[ ] locator "Memo"
		[+] TextField MemoTextField
			[ ] locator "Memo"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] //------Account Actions > Account Attachments------------
	[+] window MainWin DlgAccountAttachments
		[ ] locator "Account Attachments*"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] Control AccountAttachments
			[ ] locator "Account Attachments*"
			[+] StaticText StaticText1
				[ ] locator "@windowid='-1'"
				[+] StaticText StaticText2
					[ ] tag"@windowid='-1'"
					[+] PushButton AddButton
						[ ] locator "Add"
						[ ] 
				[ ] 
			[ ] 
		[+] PushButton AddButton
			[ ] locator "Add"
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //------Account Actions > Update 401(k)403B Holdings------------
	[+] window DialogBox DlgUpdate401K403BAccount
		[ ] locator "//DialogBox[@caption='Update 401(k)*403(b) Account*']"
		[+] StaticText WelcomeTo401k403bUpdate
			[ ] locator "@caption='Welcome to 401(k)*403(b) Update.'"
		[+] Control WelcomeTo401k403bUpdateControl
			[ ] locator "@priorlabel='Welcome to 401(k)*403(b) Update.'"
		[+] Control DidYouTakeOutaNewLoanAgainstTh
			[ ] locator "[@priorlabel='Did you take out a new loan against this account during the last statement period*'][1]"
		[+] StaticText UseYourMostRecentStatementToUpdateThisAccount
			[ ] locator "Use your most recent statement to update this account."
		[+] StaticText ThePreviousStatementEnded
			[ ] locator "The previous statement ended:"
		[+] StaticText x6142013
			[ ] locator "@caption='6/14/2013'"
		[+] StaticText ThisStatementEnds
			[ ] locator "This statement ends:"
		[+] TextField ThisStatementEndTextField
			[ ] locator "This statement ends:"
		[+] RadioList No
			[ ] locator "[@caption='No'][1]"
		[+] RadioList Yes
			[ ] locator "[@caption='Yes'][1]"
		[+] Control Next
			[ ] locator "Next"
		[+] Control HelpIcon
			[ ] locator "[@priorlabel='Did you take out a new loan against this account during the last statement period?'][5]"
		[+] Control Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] //------Account Actions>CustomizeActionBar------------
	[+] window DialogBox CustomizeActionBar
		[ ] locator "//DialogBox[@caption='Customize Action Bar']"
		[+] StaticText CustomizeActionBar
			[ ] locator "Customize Action Bar"
		[+] StaticText AvailableToolbarButtons
			[ ] locator "Available toolbar buttons:"
		[+] StaticText YourToolbarButtons
			[ ] locator "Your toolbar buttons:"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] ListBox ListBox
			[ ] locator "[1]"
		[+] MainWin xWindow2
			[ ] locator "[2]"
		[+] ListBox ListBox2
			[ ] locator "[2]"
		[+] MainWin Add
			[ ] locator "&Add ->"
		[+] Control Remove
			[ ] locator "<- &Remove"
		[+] Control MoveUp
			[ ] locator "Move &Up"
		[+] Control MoveDown
			[ ] locator "Move &Down"
		[+] Control AvailableToolbarButtonsControl
			[ ] locator "[@priorlabel='Available toolbar buttons:'][1]"
		[+] Control ReSetToDefault
			[ ] locator "Re&set to Default"
		[+] Control Done
			[ ] locator "Done"
	[ ] 
	[+] window Control InvestingAccountActions
		[ ] locator "/Control[@caption='Quicken 201*']//Control[@windowClassName='QW_MAIN_TOOLBAR'][3]"
	[ ] 
	[+] window MenuItem InvestingMenuItemUpdateCashBalance
		[ ] locator "/Control[@caption='Quicken 201*']//MenuItem[179]"
	[ ] 
	[+] window DialogBox PermanentlyCloseAccount
		[ ] locator "Permanently Close Account"
		[+] StaticText PermanentlyCloseAccountText
			[ ] locator "@windowid='32702'"
		[+] StaticText ClosingTheAccountWillText
			[ ] locator "@windowid='112'"
		[+] StaticText SetTheAccountBalanceToZ
			[ ] locator "@windowid='113'"
		[+] StaticText NoDataWillBeDeletedText
			[ ] locator "@windowid='114'"
		[+] StaticText TransactionsWillBeAvailab1
			[ ] locator "@windowid='115'"
		[+] Control TransactionsWillBeAvailab2
			[ ] locator "@windowid='116'"
		[+] StaticText AreYouSureYouWantToClose
			[ ] locator "@windowid='107'"
		[+] StaticText TypeYesToConfirmText
			[ ] locator "@windowid='108'"
		[+] TextField TypeYesToConfirm
			[ ] locator "@windowid='109'"
		[+] PushButton LearnMore
			[ ] locator "@windowid='111'"
		[+] PushButton TransactionsWillBeAvailab3
			[ ] locator "@windowid='32765'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
	[ ] 
	[+] // window FileDlg AlertMessageForCloseAccount
		[ ] // tag "~/[DialogBox]Quicken 201?"
		[+] // CustomWin QWIconDisplay1
			[+] // multitag "[QWIconDisplay]#1"
				[ ] // "[QWIconDisplay]$105"
				[ ] // "[QWIconDisplay]@(32,32)"
		[+] // StaticText Message
			[+] // multitag "#1"
				[ ] // "$100"
				[ ] // "@(293,31)"
				[ ] // //  "This account has securities balances, please clear the securities before you close the account."
		[+] // CustomWin OK
			[+] // multitag "[QC_button]OK"
				[ ] // "[QC_button]#1"
				[ ] // "[QC_button]$101"
		[+] // CustomWin Yes
			[+] // multitag "[QC_button]Yes"
				[ ] // "[QC_button]#1"
				[ ] // "[QC_button]$101"
				[ ] // "[QC_button]^Are you sure you want to cancel?[1]"
				[ ] // // "[QC_button]@(86,76)"
		[+] // CustomWin No
			[+] // multitag "[QC_button]No"
				[ ] // "[QC_button]^Are you sure you want to cancel?[2]"
				[ ] // "[QC_button]#2"
				[ ] // "[QC_button]$102"
				[ ] // "[QC_button]@(162,76)"
	[ ] 
	[+] window DialogBox RegisterCustomDate                              //Added By Dean on 14th Feb 2013
		[ ] locator "Custom Date"
		[+] StaticText CustomDateText
			[ ] locator "Custom Date"
		[+] StaticText FromText
			[ ] locator "From:"
		[+] TextField CustomDate1
			[ ] locator "@windowid='360'"
		[+] StaticText ToText
			[ ] locator "To:"
		[+] TextField CustomDate2
			[ ] locator "@windowid='361'"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] 
	[+] window DialogBox DlgCreateExcelCompatibleFile
		[ ] locator "Create Excel compatible file"
		[+] PushButton SaveButton
			[ ] locator "@windowid='1'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='2'"
	[ ] 
	[+] window DialogBox DlgYourAccountMaybeoutofdate   
		[ ] locator "Your account may be out of date."
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] RadioList Reconcilewithoutdownloading
			[ ] locator "Reconcile without downloading"
		[ ] 
	[ ] 
	[+] window DialogBox TransactionPasswordRequired		
		[ ] locator "Transaction password required"
		[+] StaticText TransactionPasswordRequiredT
			[ ] locator "Transaction password required"
		[+] StaticText TransactionPasswordText
			[ ] locator "Transaction password"
		[+] TextField TransactionPasswordTextField
			[ ] locator "Transaction password"
		[+] RadioList TransactionPasswordRequired2
			[ ] locator "Transaction password required"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton OKButton
			[ ] locator "OK"
	[ ] 
	[+] window DialogBox ManuallyMatchTransactions
		[ ] locator "Manually Match Transactions"
		[+] StaticText ManuallyMatchTransactions
			[ ] locator "Manually Match Transactions"
		[+] StaticText DownloadedTransaction
			[ ] locator "Downloaded Transaction"
		[+] Control DownloadedTransactionControl
			[ ] locator "@priorlabel='Downloaded Transaction'"
		[+] StaticText SelectTheMatchingRegisterTransactions
			[ ] locator "Select the matching register transactions."
		[+] MainWin MatchTransaction
			[ ] locator "@windowid='100'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
		[+] StaticText RegisterTransactionTotal
			[ ] locator "Register Transaction Total:"
		[+] StaticText Difference
			[ ] locator "Difference:"
		[+] PushButton SelectTheMatchingRegisterTransactionsPushButton
			[ ] locator "@priorlabel='Select the matching register transactions.'"
		[+] PushButton AcceptMatch
			[ ] locator "Accept Match"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] 	
	[+] window MainWin ConvertAssetLendingLoan
		[ ] locator "Convert this Asset to a Lending Loan"
		[+] PushButton Convert
			[ ] locator "Convert"
		[+] // PushButton Cancel
			[ ] // locator "@windowid='1004'"
		[+] PushButton Activate
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 		
	[ ] //Added by Shrivardhan
	[+] window MainWin CreatePayeeRenamingRule
		[ ] locator "Create Payee Renaming Rule"
		[+] StaticText CreatePayeeRenamingRule
			[ ] locator "Create Payee Renaming Rule"
		[+] StaticText RenamingRule
			[ ] locator "Renaming Rule:"
		[+] StaticText IfTheDownloadedPayeeNameContainsThisText
			[ ] locator "If the downloaded payee name contains this text:"
		[+] StaticText Label
			[ ] locator "[4]"
		[+] StaticText ReplaceItWithThisName
			[ ] locator "Replace it with this name:"
		[+] StaticText ReplaceItWithThisNameName
			[ ] locator "@windowid='127'"
		[+] StaticText Label7
			[ ] locator "[7]"
		[+] StaticText PayeeNameDownloadedFromYourFinancialInstitution
			[ ] locator "Payee name downloaded from your financial institution:"
		[+] StaticText PayeeNameDownloadedFromYourFinancialInstitutionName
			[ ] locator "@windowid='125'"
		[+] Control QWMsHtmlVw
			[ ] locator "@windowClassName='QWMsHtmlVw'"
		[+] BrowserWindow BrowserWindow
			[ ] locator "//BrowserWindow"
			[+] DomElement HTML
				[ ] locator "/HTML"
			[+] DomElement HEAD
				[ ] locator "//HEAD"
			[+] DomElement TITLE
				[ ] locator "//TITLE"
			[+] DomElement STYLE
				[ ] locator "//STYLE"
		[+] CheckBox AlwaysCreateaRenamingRuleAndDontAskMeAgain
			[ ] locator "Always create a renaming rule and don't ask me again."
		[+] PushButton PayeeNameDownloadedFromYourFinancialInstitutionPushButton
			[ ] locator "[@priorlabel='Payee name downloaded from your financial institution:'][1]"
		[+] PushButton EditCustomRule
			[ ] locator "Edit Custom Rule"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
	[ ] //Added by Shrivardhan
	[+] window MainWin CreateCustomRenamingRule
		[ ] locator "Create Custom Renaming Rule"
		[+] StaticText CreateCustomRenamingRule
			[ ] locator "Create Custom Renaming Rule"
		[+] StaticText ThePayeeNameDownloadedFromYourFinancialInstitution
			[ ] locator "The payee name downloaded from your financial institution:"
		[+] Control ThePayeeNameDownloadedFromYourFinancialInstitutionControl
			[ ] locator "@priorlabel='The payee name downloaded from your financial institution:'"
		[+] BrowserWindow BrowserWindow
			[ ] locator "[1]"
			[+] DomElement HTML
				[ ] locator "/HTML"
			[+] DomElement HEAD
				[ ] locator "//HEAD"
			[+] DomElement TITLE
				[ ] locator "//TITLE"
			[+] DomElement STYLE
				[ ] locator "//STYLE"
		[+] StaticText IfTheDownloadedPayeeNameContainsTheseWordsClickAllThatApply
			[ ] locator "If the downloaded payee name contains these words: (Click all that apply)"
		[+] StaticText Label
			[ ] locator "[4]"
		[+] StaticText ReplaceTheDownloadedPayeeNameWithThisName
			[ ] locator "Replace the downloaded payee name with this name:"
		[+] TextField ReplaceTheDownloadedPayeeNameWithThisNameTextField
			[ ] locator "Replace the downloaded payee name with this name:"
		[+] PushButton ReplaceTheDownloadedPayeeNameWithThisNamePushButton
			[ ] locator "[@priorlabel='Replace the downloaded payee name with this name:'][1]"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] Control Panel
			[ ] locator "Panel"
		[+] Control IfTheDownloadedPayeeNameContainsTheseWordsClickAllThatApplyControl
			[ ] locator "[@priorlabel='If the downloaded payee name contains these words: (Click all that apply)'][2]"
		[+] BrowserWindow BrowserWindow2
			[ ] locator "[2]"
			[+] DomElement HTML
				[ ] locator "/HTML"
			[+] DomElement HEAD
				[ ] locator "//HEAD"
			[+] DomElement TITLE
				[ ] locator "//TITLE"
			[+] DomElement STYLE
				[ ] locator "STYLE[1]"
			[+] DomElement x002db4
				[ ] locator "BODY[@aLink='#002db4']"
			[+] DomElement TextCss
				[ ] locator "STYLE[@type='text/css']"
			[+] DomLink x0
				[ ] locator "A[@id='0']"
			[+] DomElement B
				[ ] locator "//B"
			[+] DomLink x1
				[ ] locator "A[@id='1']"
			[+] DomLink x2
				[ ] locator "A[@id='2']"
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
		[+] Control CalloutHolder
			[ ] locator "Callout Holder"
		[+] Control ARenamingRule
			[ ] locator "//Control[@caption='Callout Holder']//Control[@caption='A renaming rule']"
		[+] Control QWinChild
			[ ] locator "//Control[@caption='Callout Holder']//Control[@windowClassName='QWinChild']"
		[+] Control QWIconDisplay
			[ ] locator "//Control[@caption='Callout Holder']//Control[@windowClassName='QWIconDisplay']"
		[ ] 
		[ ] 
		[ ] 
	[ ] //Added by Shrivardhan
	[+] window MainWin EditRenamingRule
		[ ] locator "Edit Renaming Rule"
		[+] StaticText EditRenamingRule
			[ ] locator "Edit Renaming Rule"
		[+] Control EditRenamingRuleControl
			[ ] locator "@priorlabel='Edit Renaming Rule'"
		[+] StaticText YouUpdatedaTransactionWithAnExistingRenamingRule
			[ ] locator "You updated a transaction with an existing renaming rule."
		[+] StaticText IfTheDownloadedTransactionContainsTheseWords
			[ ] locator "If the downloaded transaction contains these words:"
		[+] Control IfTheDownloadedTransactionContainsTheseWordsControl
			[ ] locator "@priorlabel='If the downloaded transaction contains these words:'"
		[+] BrowserWindow BrowserWindow
			[ ] locator "//BrowserWindow"
			[+] DomElement HTML
				[ ] locator "/HTML"
			[+] DomElement HEAD
				[ ] locator "//HEAD"
			[+] DomElement TITLE
				[ ] locator "//TITLE"
			[+] DomElement STYLE
				[ ] locator "//STYLE"
			[+] DomElement Internet
				[ ] locator "BODY[@textContents='Internet']"
			[+] DomElement InternetI
				[ ] locator "I[@textContents='Internet']"
		[+] StaticText RenamePayeeTo
			[ ] locator "Rename payee to:"
		[+] StaticText CurrentRule
			[ ] locator "Current Rule:"
		[+] StaticText CurrentRuleName
			[ ] locator "@windowid=125"
		[+] StaticText NewName
			[ ] locator "New Name:"
		[+] StaticText NewRuleName
			[ ] locator "@windowid=127"
		[+] PushButton UpdateRule
			[ ] locator "Update Rule"
		[+] StaticText AreYouCleaningUpTheNameOrFixingaTypo
			[ ] locator "Are you cleaning up the name or fixing a typo?"
		[+] StaticText UpdateTheExistingRuleWithTheNewPayeeName
			[ ] locator "Update the existing rule with the new payee name."
		[+] PushButton CreateNewRule
			[ ] locator "Create New Rule..."
		[+] StaticText AreYouHavingProblemsWithThisPayeeName
			[ ] locator "Are you having problems with this payee name?"
		[+] StaticText KeepTheExistingRuleAndCreateaN
			[ ] locator "Keep the existing rule and create a new rule for this payee name. (Can be useful if Quicken is assigning different payees the same name.)"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] 
[ ] 
[+] //*******************C2R ****************************************************
	[ ] //Right Click Menu for C2R
	[+] window Control C2RRightClick
		[+] MenuItem DeleteTransaction
			[ ] locator "@windowid='27003'"
		[+] MenuItem MatchManuallyTransaction
			[ ] locator "@windowid='27005'"
		[+] MenuItem MakeNewTransaction
			[ ] locator "@windowid='27004'"
		[+] MenuItem MakeAllNewTransaction
			[ ] locator "@windowid='27007'"
		[+] MenuItem UnMatchTransaction
			[ ] locator "@windowid='27012'"
		[+] MenuItem RevertPayeeTransaction
			[ ] locator "@windowid='27008'"
		[+] MenuItem ShowRenamingRules
			[ ] locator "@windowid='27010'"
		[+] MenuItem AcceptTransaction
			[ ] locator "@windowid='27001'"
		[+] MenuItem AcceptAllTransaction
			[ ] locator "@windowid='27002'"
		[+] MenuItem HideAcceptedTransaction
			[ ] locator "@windowid='27009'"
			[ ] 
		[ ] 
	[ ] 
	[+] window MainWin ActivateOnlineBillPay
		[ ] locator "Activate Online Bill Pay"
		[+] StaticText ActivateOnlineBillPay
			[ ] locator "Activate Online Bill Pay"
		[+] StaticText ThereAreTwoOnlineBillPayOptionsForThisAccountInQuicken
			[ ] locator "There are two online Bill Pay options for this account in Quicken."
		[+] StaticText Option1QuickenBillPay
			[ ] locator "Option 1: Quicken Bill Pay"
		[+] StaticText PayBillsFromYourQuickenRegister
			[ ] locator "Pay bills from your Quicken register"
		[+] StaticText PayAnyoneWithinTheUS
			[ ] locator "Pay anyone within the U.S."
		[+] StaticText SchedulePaymentsInAdvance
			[ ] locator "Schedule payments in advance"
		[+] StaticText TransferFundsBetweenAccounts
			[ ] locator "Transfer funds between accounts"
		[+] StaticText MakePaymentsFromUpTo10Accounts
			[ ] locator "Make payments from up to 10 accounts"
		[+] StaticText GuaranteedOnTimeAndAccuratePayment
			[ ] locator "Guaranteed on time and accurate payment"
		[+] Control GuaranteedOnTimeAndAccuratePaymentControl
			[ ] locator "@priorlabel='Guaranteed on time and accurate payment'"
		[+] StaticText AlreadySignedUp
			[ ] locator "Already signed up?"
		[+] PushButton ActivateNow
			[ ] locator "@windowid='6'"
		[+] StaticText Option2WellsFargoBankPaymentService
			[ ] locator "Option 2: Wells Fargo Bank payment service"
		[+] StaticText IfYouVeAlreadyEnrolledInTheWel
			[ ] locator "If you've already enrolled in the Wells Fargo Bank bill payment service, click Activate Now to begin using it."
		[+] StaticText ToLearnMoreAboutTheWellsFargoB
			[ ] locator "To learn more about the Wells Fargo Bank bill payment service, call 1-800-956-4442."
		[+] StaticText AlreadyEnrolled1
			[ ] locator "Already enrolled?"
		[+] PushButton AlreadyEnrolled
			[ ] locator "@windowid='7'"
		[+] PushButton HelpIcon
			[ ] locator "@windowid='32765'"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] // 
	[+] // window MainWin ActivateOneStepUpdate
		[ ] // locator "Activate One Step Update"
		[+] // StaticText ActivateOneStepUpdate
			[ ] // locator "Activate One Step Update"
		[+] // StaticText ConnectToBankOfAmericaAllOther
			[ ] // locator "Connect to Bank of America-All Other States directly through Quicken with One Step Update."
		[+] // RadioList Yes
			[ ] // locator "Yes, "
		[+] // StaticText ActivateOneStepUpdateIWantToCo
			[ ] // locator "activate One Step Update. I want to connect to Bank of America-All Other States directly through Quicken."
		[+] // RadioList No
			[ ] // locator "No, "
		[+] // StaticText DoNotActivateOneStepUpdateIWan
			[ ] // locator "do not activate One Step Update. I want to go to my financial institution website"
		[+] // StaticText EveryTimeIWantToUpdateMyAccountData
			[ ] // locator "every time I want to update my account data."
		[+] // Control QWIconDisplay
			[ ] // locator "@windowClassName='QWIconDisplay'"
		[+] // StaticText Label
			[ ] // locator "[6]"
		[+] // MainWin xWindow
			[ ] // locator "//MainWin"
		[+] // ListBox ListBox
			[ ] // locator "//ListBox"
		[+] // CheckBox DontShowAgain
			[ ] // locator "Don't show again"
		[+] // PushButton Activate
			[ ] // locator "Activate"
		[+] // PushButton Cancel
			[ ] // locator "Cancel"
		[+] // PushButton ActivateOneStepUpdatePushButton
			[ ] // locator "@priorlabel='Activate One Step Update'"
		[+] // Control QWHtmlView
			[ ] // locator "@windowClassName='QWHtmlView'"
	[+] window MainWin DlgUpgradetoDirectConnect
		[ ] locator "Upgrade to Direct Connect"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton NextButton
			[ ] locator "Next"
		[ ] 
	[+] window DialogBox BofaCriticalMsg // Added by Abhijit April 2015
		[ ] locator "@caption='Important message from Bank of America-All Other States'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] CheckBox DontShow
			[ ] locator "@windowid='27540'"
[ ] 
[+] //************* Transaction ******************************************************
	[+] window DialogBox Transaction  
		[ ] locator "Transaction"                                          
		[+] Control QWListViewer1
			[ ] locator "@windowid='73'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowid='5000'"
			[+] Control DateRangeLabel
				[ ] locator "@windowid='10'"
			[+] ComboBox DateRange
				[ ] locator "@windowid='1000'"
			[+] Control SubtotalBy
				[ ] locator "@windowid='30'"
			[+] ComboBox PopupList2
				[ ] locator "@windowid='1012'"
			[+] Control SortBy
				[ ] locator "@windowid='40'"
			[+] ComboBox PopupList3
				[ ] locator "@windowid='1014'"
		[+] PushButton Edit
			[ ] locator "@windowid='98'"
	[ ] 
	[ ] 
	[ ] //------Right Click on transaction > Delete------------  
	[+] window DialogBox DeleteTransaction
		[ ] locator "//DialogBox[@caption='Quicken 201*']"
		[+] Control Control105
			[ ] locator "@windowClassName='QWIconDisplay'"
		[+] StaticText DeleteTheCurrentTransaction
			[ ] locator "Delete the Current Transaction?"
		[+] PushButton Yes
			[ ] locator "Yes"
		[+] PushButton No
			[ ] locator "No"
	[ ] 
	[ ] //------Right Click on transaction > Attachments------------  
	[+] window MainWin TransactionAttachments
		[ ] locator "//MainWin[@caption='Transaction Attachments']"
		[+] StaticText AttachNew
			[ ] locator "Attach new"
		[+] ComboBox AttachNewComboBox
			[ ] locator "Attach new"
		[+] MainWin File
			[ ] locator "[1]"
		[+] Control Scanner
			[ ] locator "[@priorlabel='Attach new'][2]"
		[+] Control Clipboard
			[ ] locator "[@priorlabel='Attach new'][3]"
		[+] MainWin Help
			[ ] locator "[2]"
		[+] Control Print
			[ ] locator "[@priorlabel='Attach new'][4]"
		[+] PushButton Done
			[ ] locator "Done"
		[+] Control QWMsHtmlVw
			[ ] locator "@windowClassName='QWMsHtmlVw'"
		[+] BrowserWindow BrowserWindow
			[ ] locator "//BrowserWindow"
			[+] DomElement HTML
				[ ] locator "/HTML"
			[+] DomElement HEAD
				[ ] locator "//HEAD"
			[+] DomElement TITLE
				[ ] locator "//TITLE"
			[+] DomElement STYLE
				[ ] locator "//STYLE"
			[+] DomElement x002db4
				[ ] locator "BODY[@aLink='#002db4']"
			[+] DomElement UseTheButtonsBelo
				[ ] locator "P[@textContents='Use the buttons belo*']"
			[+] DomElement YouCanAttachAnyt
				[ ] locator "P[@textContents='You can attach any t*']"
		[+] Control Panel
			[ ] locator "[@caption='Panel'][1]"
		[+] Control QWinChild
			[ ] locator "@windowClassName='QWinChild'"
		[+] Control Panel2
			[ ] locator "[@caption='Panel'][2]"
		[+] Scale AttachNewScale
			[ ] locator "@priorlabel='Attach new'"
	[ ] 
	[ ] //------Right Click on transaction > Split------------  
	[+] window MainWin SplitTransaction
		[ ] locator "Split Transaction"
		[+] StaticText SplitTransactionText
			[ ] locator "Split Transaction"
		[+] StaticText EnterMultipleCategoriesToI1
			[ ] locator "@windowid='65535'"
		[+] MainWin EnterMultipleCategoriesToI2
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[+] TextField TextField1
					[ ] locator "@windowid='1002'"
				[+] TextField TextField2
					[ ] locator "@windowid='1003'"
				[+] TextField TextField3
					[ ] locator "@windowid='1004'"
				[+] TextField TextField4
					[ ] locator "@windowid='1005'"
				[+] TextField TextField13
					[ ] locator "@windowid='1012'"
		[+] PushButton AddLines
			[ ] locator "Add Lines"
		[+] PushButton ClearAll
			[ ] locator "Clear All"
		[+] PushButton Allocate
			[ ] locator "Allocate"
		[+] PushButton Adjust
			[ ] locator "Adjust"
		[+] StaticText SplitTotalText
			[ ] locator "Split Total:"
		[+] StaticText SplitTotalAmountText
			[ ] locator "@windowid='242'"
		[+] StaticText RemainderText
			[ ] locator "@windowid='258'"
		[+] StaticText RemainderAmountText
			[ ] locator "@windowid='203'"
		[+] StaticText TransactionTotalText
			[ ] locator "@windowid='259'"
		[+] StaticText TransactionTotalAmountText
			[ ] locator "@windowid='204'"
		[+] PushButton EnterMultipleCategoriesToI3
			[ ] locator "@windowid='32765'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] StaticText SplitTransactionsTotalText
			[ ] locator "@windowid='204'"
		[+] DialogBox NewTagForSplit
			[ ] locator "New Tag"
			[+] PushButton OK
				[ ] locator "@windowid='32767'"
		[ ] 
	[ ] 
	[+] window DialogBox DidYouForgetSomething
		[ ] locator "Did You Forget Something*"
		[+] StaticText DidYouForgetSomething
			[ ] locator "Did You Forget Something*"
		[+] StaticText QuickenUsesCategoriesLikeTheseToHelpYouTrackYourFinances
			[ ] locator "Quicken uses categories like these to help you track your finances."
		[+] StaticText WouldYouLikeToSelectOneFromTheList
			[ ] locator "Would you like to select one from the list*"
		[+] CheckBox DontShowThisMessageAgain
			[ ] locator "Don't show this message again"
		[+] MainWin Yes
			[ ] locator "&Yes"
		[+] Control No
			[ ] locator "&No"
	[ ] 
	[ ] //------Right Click on transaction > Move------------
	[+] window DialogBox MoveTransactionS
		[ ] locator "Move Transaction*"
		[+] StaticText MoveToAccountText
			[ ] locator "Move to account:"
		[+] ComboBox MoveToAccount
			[ ] locator "Move to account:"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] //------Right Click on transaction > Notes and Flags------------
	[+] window DialogBox TransactionNotesAndFlags
		[ ] locator "Transaction Notes and Flags"
		[+] StaticText TransactionNotesAndFlags
			[ ] locator "Transaction Notes and Flags"
		[+] TextField Notes
			[ ] locator "Notes:"
		[+] CheckBox FlagThisTransaction
			[ ] locator "Flag this transaction:"
		[+] ComboBox FlagColor
			[ ] locator "Transaction Notes and Flags"
		[+] CheckBox AlertForFollowUpOn
			[ ] locator "Alert for follow-up on:"
		[+] TextField FollowUpDateSelect
			[ ] locator "Transaction Notes and Flags"
		[+] PushButton Delete
			[ ] locator "Delete"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] Control CalendarButton
			[ ] locator "@windowClassName='QFBag'"
		[ ] 
	[ ] 
	[+] window DialogBox AcceptTransaction
		[ ] locator  "Quicken 20*"
		[+] Control QWIconDisplay1
			[ ] locator "@windowid='105'"
		[+] StaticText Message
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[ ] 
	[+] window DialogBox DlgPaymentOrDeposit        
		[ ] locator "Payment or Deposit*"
		[+] StaticText PaymentOrDepositText
			[ ] locator "@windowid='32702'"
		[+] StaticText SplitTotalText
			[ ] locator "@windowid='65535'"
		[+] StaticText SplitTotalAmountText
			[ ] locator "@windowid='201'"
		[+] RadioList PaymentRadioButton
			[ ] locator "Payment"
		[+] RadioList DepositRadioButton
			[ ] locator "Deposit"
			[ ] 
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] 
	[+] window MainWin DlgTransactionAttachments
		[ ] locator "*Attachments"
		[+] PushButton FileButton
			[ ] locator "2000"
		[+] PushButton AddButton
			[ ] locator "@windowid='2000'"
		[+] PushButton DeleteButton
			[ ] locator "@windowid='2011'"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] CustomWin ScannerButton
			[+] multitag "[QC_button]Scanner"
				[ ] "[QC_button]$2003"
		[+] CustomWin ClipboardButton
			[+] multitag "[QC_button]Clipboard"
				[ ] "[QC_button]$2004"
		[+] CustomWin Panel2
			[+] multitag "[QWPanel]Panel[2]"
				[ ] "$-1[2]"
		[+] CustomWin AttachedPanel
			[+] multitag "[QWPanel]Panel[1]"
				[ ] "$-1[1]"
			[+] CustomWin QWinChild1
				[+] multitag "[QWinChild]#1"
					[ ] "$0"
				[+] CustomWin Panel2
					[+] multitag "[QWPanel]Panel[2]"
						[ ] "$-1[2]"
				[+] CustomWin Panel1
					[+] multitag "[QWPanel]Panel[1]"
						[ ] "$-1[1]"
		[+] CustomWin ExportButton
			[+] multitag "[QC_button]Export"
				[ ] "^image from:[5]"
				[ ] "#5"
				[ ] "$2006"
				[ ] "[QC_button]$2006"
				[ ] 
		[+] CustomWin OpenButton
			[+] multitag "[QC_button]Open"
				[ ] "[QC_button]$2012"
		[+] CustomWin EncryptionButton
			[+] multitag "[QC_button]Encryption"
				[ ] "[QC_button]$2011"
		[+] StaticText AttachNewText
			[+] multitag "Attach new"
				[ ] "$2007"
		[+] PopupList AttachNewPopupList
			[+] multitag "Attach new"
				[ ] "$2008"
		[+] CheckBox FitAttachmentToScreenCheckBox
			[+] multitag "Fit Attachment to screen"
				[ ] "$2010"
		[+] CustomWin HelpButton
			[+] multitag "[QC_button]#8"
				[ ] "[QC_button]$32765"
		[+] CustomWin PrintButton
			[+] multitag "[QC_button]#9"
				[ ] "[QC_button]$32760"
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox ExportAttachmentFile
		[ ] locator "Export Attachment File"
		[+] StaticText SaveInText
			[ ] locator "Save in:"
		[+] PopupList SaveIn
			[ ] locator "Save in:"
		[+] Control SaveIn1
			[ ] locator "@windowid='1088'"
			[+] PushButton PushButton1
				[ ] locator "@windowid='40971'"
			[+] PushButton PushButton2
				[ ] locator "@windowid='40961'"
			[+] PushButton PushButton3
				[ ] locator "@windowid='40962'"
			[+] PushButton PushButton4
				[ ] locator "@windowid='40970'"
		[+] ComboBox FileName
			[ ] locator "File name:"
			[+] TextField FileNameTextField
				[ ] locator "File name:"
		[+] PushButton Save
			[ ] locator "Save"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[+] window MainWin DlgEnterMissingTransactions
		[ ] locator "Enter Missing Transactions"
		[+] PushButton EnterMissingTransactionButton
			[ ] locator "Enter Missing Transaction*"
		[+] PushButton EstimateAverageCostButton
			[ ] locator "Estimate Average Cost*"
		[+] PushButton FinishLaterButton
			[ ] locator "Finish Later"
		[+] TextField Cost
			[ ] locator "//TextField[2]"
		[+] TextField Price
			[ ] locator "//TextField"
		[+] PushButton OK
			[ ] locator "OK"
		[ ] 
	[ ] 
	[+] window MainWin DlgSaveTransaction
		[ ] locator "Save transaction?"
		[+] PushButton Save
			[ ] locator "Save"
			[ ] 
		[+] PushButton Cancel
			[ ] locator "Cancel"
			[ ] 
		[+] CheckBox DontShowAgain
			[ ] locator "Don't ask me again"
			[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] 
[+] //************* Loans ***********************************************************
	[ ] // ------Add A Account > Loans > Loan Details----------------
	[+] // window MainWin LoanDetails
		[ ] // locator "Loan Details"
		[+] // PushButton HelpButton
			[ ] // locator "@priorlabel='Monthly Payment'"
		[+] // StaticText LoanDetails1Text
			[ ] // locator "Loan Details"
		[+] // PushButton NextButton
			[ ] // locator "Next"
		[+] // PushButton OKButton
			[ ] // locator "OK"
		[+] // PushButton BackButton
			[ ] // locator "&Back"
		[+] // PushButton CancelButton
			[ ] // locator "Cancel"
		[+] // TextField LoanNameTextField
			[ ] // locator "Loan Details"
		[+] // StaticText NameOfThisLoanInQuicken
			[ ] // locator "Name of this loan in Quicken"
		[+] // ComboBox LoanTypePopupList
			[ ] // locator "Loan Details"
		[+] // StaticText LoanTypeText
			[ ] // locator "Loan Type"
		[+] // StaticText OpeningDateText
			[ ] // locator "Opening date"
		[+] // TextField OpeningDateTextField
			[ ] // locator "Opening date"
		[+] // StaticText DateThisLoanStartedText
			[ ] // locator "Date this loan started "
		[+] // StaticText OriginalBalanceText
			[ ] // locator "Original balance"
		[+] // TextField OriginalBalanceTextField
			[ ] // locator "Original balance"
		[+] // StaticText CurrentInterestRateText
			[ ] // locator "Current interest rate"
		[+] // TextField CurrentInterestRateTextField
			[ ] // locator "Current interest rate"
		[+] // TextField OriginalLengthTextField
			[ ] // locator "Original length"
		[+] // ComboBox OriginalLength
			[ ] // locator "Original length"
		[+] // StaticText CompoundingPeriodText
			[ ] // locator "Compounding period"
		[+] // ComboBox CompoundingPeriod
			[ ] // locator "Compounding period"
		[+] // StaticText PaymentSchedule
			[ ] // locator "Payment schedule"
		[+] // ComboBox PaymentScheduleComboBox
			[ ] // locator "Payment schedule"
		[+] // StaticText CurrentBalance
			[ ] // locator "Current balance"
		[+] // TextField CurrentBalanceTextField
			[ ] // locator "[@caption='Current balance'][1]"
		[+] // StaticText OnlineCurrentBalanceText
			[ ] // locator "[@windowid='1771']"
			[ ] // //locator "(as reported by your financial institution)"
		[+] // PushButton FrequencyPaymentCalculator
			[ ] // locator "//PushButton[@priorlabel='(as reported by your financial institution)']"
		[+] // PushButton HelpIconForCompoundingPeriod
			[ ] // locator "@windowid='1774'"
		[+] // StaticText MonthlyPaymentLabel
			[ ] // locator "Monthly payment"
		[+] // TextField MonthlyPaymentTextField
			[ ] // locator "[@caption='Current balance'][2]"
		[+] // StaticText PrincipalInterestAmountOnly
			[ ] // locator "Principal + Interest amount only"
		[+] // StaticText YouMayNeedToCheckYourLatestLoa
			[ ] // locator "You may need to check your latest loan statement or lender website to complete this form."
		[+] // Control QWIconDisplay
			[ ] // locator "@windowClassName='QWIconDisplay'"
		[+] // Control DetailsCalendar
			[ ] // locator "[@priorlabel='You may need to check your latest loan statement or lender website to complete this form.'][2]"
		[+] // Control DetailsCalculator1
			[ ] // locator "[@priorlabel='Date this loan started '][1]"
		[+] // Control DetailsCalculator2
			[ ] // locator "[@priorlabel='Date this loan started '][4]"
		[+] // Control DetailsCalculator3
			[ ] // locator "[@priorlabel='Current balance'][3]"
		[+] // TextField NextPaymentDueTextField
			[ ] // locator "Next payment due"
		[+] // // TextField ExtraPrincipalPaidMonthly1
			[ ] // // locator "$1.03"
		[+] // TextField ExtraPrincipalPaidMonthly
			[ ] // // locator "Extra principal paid Monthly"
			[ ] // locator "@windowid='1985'"
		[+] // StaticText ExtraPrincipalPaidMonthlyText
			[ ] // locator "@windowid='1986'"
		[+] // RadioList ExtraPrincipalDeterminesTotal
			[ ] // locator "Extra principal determines total"
		[+] // MainWin xWindow
			[ ] // locator "[3]"
		[+] // MainWin xWindow4
			[ ] // locator "[4]"
		[+] // StaticText Label18
			[ ] // locator "[18]"
		[+] // Control PaymentCalendar
			[ ] // locator "[@priorlabel='Monthly Payment'][1]"
		[+] // Control PaymentCalculator1
			[ ] // locator "[@priorlabel='(required)'][1]"
		[+] // Control PaymentCalculator2
			[ ] // locator "[@priorlabel='(required)'][4]"
		[+] // TextField FrequencyPaymentTextField
			[ ] // locator "@windowid='1769'"
		[ ] // 
		[ ] // //Loan Details Step2
		[+] // StaticText TotalPaymentAmount
			[ ] // locator "@windowid='1989'"
		[+] // RadioList PrincipaldDeterminesTotalOptionRadioList
			[ ] // locator "//RadioList"
		[+] // TextField OtherTextField
			[ ] // locator "@windowid='1983'"
		[+] // TextField PrincipalTextField
			[ ] // locator "Extra principal paid Monthly"
		[+] // StaticText PrincipalText
			[ ] // locator "@windowid='1979'"
		[+] // StaticText InterestText
			[ ] // locator "@windowid='1981'"
		[+] // Control GreenArrowIcon
			[ ] // locator "@windowid='1990'"
		[ ] // 
		[ ] // 
		[+] // PushButton RecalculateCurrentBalanceButton
			[ ] // // locator "@windowid='2330'"
			[ ] // locator "Recalculate"
			[ ] // 
		[ ] // 
		[+] // PushButton RecalculatePaymentFrequencyButton
			[ ] // locator "@windowid='2326'"
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // //-------
		[+] // StaticText PrincipalAmount
			[ ] // locator "@windowid='1979'"
			[ ] // 
		[+] // StaticText InterestAmount
			[ ] // locator "@windowid='1981'"
			[ ] // 
		[+] // PushButton PaymentOptionsButton
			[ ] // locator "[@caption='*Payment Options*']"
			[ ] // //locator "@windowid='2001'"
			[ ] // 
			[ ] // 
		[+] // PushButton EditLoanReminderButton
			[ ] // locator "[@caption='*Edit Loan Reminder*']"
			[ ] // // //locator "@windowid='1992'"
			[ ] // // 
			[ ] // 
		[+] // PushButton EditCategoryButton
			[ ] // locator "@caption='(Edit)'"
			[ ] // 
		[+] // PushButton AddLoanReminder
			[ ] // locator "[@caption='*Add Loan Reminder*']"
			[ ] // 
			[ ] // 
		[ ] // //-------
		[ ] // 
		[ ] // 
		[+] // ComboBox MultiCurrencyComboBox
			[ ] // locator "Currency*"
			[ ] // 
		[ ] // 
		[ ] // 
	[+] window MainWin LoanDetails
		[ ] locator "Loan Details"
		[+] PushButton HelpButton
			[ ] locator "@priorlabel='Monthly Payment'"
		[+] StaticText LoanDetails1Text
			[ ] locator "Loan Details"
		[+] PushButton NextButton
			[ ] locator "Next"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton BackButton
			[ ] locator "Back"
		[ ] //both of the cancel declarations are needed mukesh 9/28/2014
		[+] PushButton CancelButton
			[ ] locator "[@caption='Cancel' or @windowid='2401']" 
			[ ] 
			[ ] 
		[+] PushButton Cancel
			[ ] locator "@windowid='2401'"
			[ ] 
			[ ] 
		[ ] 
		[+] TextField LoanNameTextField
			[ ] locator "Loan Details"
		[+] StaticText NameOfThisLoanInQuicken
			[ ] locator "Name of this loan in Quicken"
		[+] ComboBox LoanTypePopupList
			[ ] locator "Loan Details"
		[+] StaticText LoanTypeText
			[ ] locator "Loan Type"
		[+] StaticText OpeningDateText
			[ ] locator "Opening date"
		[+] TextField OpeningDateTextField
			[ ] locator "Opening date"
		[ ] 
		[+] PushButton OpeningDateCalendarButton
			[ ] locator "@windowid='1124'"
		[ ] 
		[ ] 
		[+] StaticText DateThisLoanStartedText
			[ ] locator "Date this loan started "
		[+] StaticText OriginalBalanceText
			[ ] locator "Original balance"
		[+] TextField OriginalBalanceTextField
			[ ] locator "Original balance"
		[+] StaticText CurrentInterestRateText
			[ ] locator "Current interest rate"
		[+] TextField CurrentInterestRateTextField
			[ ] locator "Current interest rate"
		[+] TextField OriginalLengthTextField
			[ ] locator "Original length"
		[+] ComboBox OriginalLength
			[ ] locator "Original length"
		[+] StaticText CompoundingPeriodText
			[ ] locator "Compounding period"
		[+] ComboBox CompoundingPeriod
			[ ] locator "Compounding period"
		[+] StaticText PaymentSchedule
			[ ] locator "Payment schedule"
		[+] ComboBox PaymentScheduleComboBox
			[ ] locator "Payment schedule"
		[+] StaticText CurrentBalance
			[ ] locator "Current balance"
		[+] TextField CurrentBalanceTextField
			[ ] locator "[@caption='Current balance'][1]"
		[+] StaticText OnlineCurrentBalanceText
			[ ] locator "[@windowid='1771']"
			[ ] //locator "(as reported by your financial institution)"
		[+] PushButton FrequencyPaymentCalculator
			[ ] locator "//PushButton[@priorlabel='(as reported by your financial institution)']"
		[+] PushButton HelpIconForCompoundingPeriod
			[ ] locator "@windowid='1774'"
		[+] StaticText MonthlyPaymentLabel
			[ ] locator "Monthly payment"
		[+] TextField MonthlyPaymentTextField
			[ ] //locator "[@caption='Current balance'][2]"
			[ ] locator "@windowid='1769'"
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[+] StaticText PrincipalInterestAmountOnly
			[ ] locator "Principal + Interest amount only"
		[+] StaticText YouMayNeedToCheckYourLatestLoa
			[ ] locator "You may need to check your latest loan statement or lender website to complete this form."
		[+] Control QWIconDisplay
			[ ] locator "@windowClassName='QWIconDisplay'"
		[+] Control DetailsCalendar
			[ ] locator "[@priorlabel='You may need to check your latest loan statement or lender website to complete this form.'][2]"
		[+] Control DetailsCalculator1
			[ ] locator "[@priorlabel='Date this loan started '][1]"
		[+] Control DetailsCalculator2
			[ ] locator "[@priorlabel='Date this loan started '][4]"
		[+] Control DetailsCalculator3
			[ ] locator "[@priorlabel='Current balance'][3]"
		[+] TextField NextPaymentDueTextField
			[ ] locator "Next payment due"
		[+] // TextField ExtraPrincipalPaidMonthly1
			[ ] // locator "$1.03"
		[+] TextField ExtraPrincipalPaidMonthly
			[ ] // locator "Extra principal paid Monthly"
			[ ] locator "@windowid='1985'"
		[+] StaticText ExtraPrincipalPaidMonthlyText
			[ ] locator "@windowid='1986'"
		[+] RadioList ExtraPrincipalDeterminesTotal
			[ ] locator "Extra principal determines total"
		[+] MainWin xWindow
			[ ] locator "[3]"
		[+] MainWin xWindow4
			[ ] locator "[4]"
		[+] StaticText Label18
			[ ] locator "[18]"
		[+] Control PaymentCalendar
			[ ] locator "[@priorlabel='Monthly Payment'][1]"
		[+] Control PaymentCalculator1
			[ ] locator "[@priorlabel='(required)'][1]"
		[+] Control PaymentCalculator2
			[ ] locator "[@priorlabel='(required)'][4]"
		[+] TextField FrequencyPaymentTextField
			[ ] locator "@windowid='1769'"
		[ ] 
		[ ] //Loan Details Step2
		[+] StaticText TotalPaymentAmount
			[ ] locator "@windowid='1989'"
		[+] RadioList PrincipaldDeterminesTotalOptionRadioList
			[ ] locator "//RadioList"
		[+] TextField OtherTextField
			[ ] locator "@windowid='1983'"
		[+] TextField PrincipalTextField
			[ ] //locator "Extra principal paid Monthly"
			[ ] locator "@windowid='1985'"
			[ ] 
		[+] StaticText PrincipalText
			[ ] locator "@windowid='1979'"
		[+] StaticText InterestText
			[ ] locator "@windowid='1981'"
		[+] Control GreenArrowIcon
			[ ] locator "@windowid='1990'"
		[ ] 
		[ ] 
		[+] PushButton RecalculateCurrentBalanceButton
			[ ] // locator "@windowid='2330'"
			[ ] locator "Recalculate"
			[ ] 
		[ ] 
		[+] PushButton RecalculatePaymentFrequencyButton
			[ ] locator "@windowid='2326'"
			[ ] 
		[ ] 
		[ ] 
		[ ] //-------
		[+] StaticText PrincipalAmount
			[ ] locator "@windowid='1979'"
			[ ] 
		[+] StaticText InterestAmount
			[ ] locator "@windowid='1981'"
			[ ] 
		[+] PushButton PaymentOptionsButton
			[ ] locator "[@caption='*Payment Options*']"
			[ ] //locator "@windowid='2001'"
			[ ] 
			[ ] 
		[+] PushButton EditLoanReminderButton
			[ ] locator "[@caption='*Edit Loan Reminder*']"
			[ ] // //locator "@windowid='1992'"
			[ ] // 
			[ ] 
		[+] PushButton EditCategoryButton
			[ ] locator "@caption='(Edit)'"
			[ ] 
		[+] PushButton AddLoanReminder
			[ ] locator "[@caption='*Add Loan Reminder*']"
			[ ] 
			[ ] 
		[ ] //-------
		[ ] 
		[ ] 
		[+] ComboBox MultiCurrencyComboBox
			[ ] locator "Currency*"
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //------Loan Details > Next > Your Loan Reminder----------------
	[+] window MainWin YourLoanReminder
		[ ] locator "Your Loan Reminder"
		[+] Control Loan
			[ ] locator "[@priorlabel='Loan'][1]"
		[+] StaticText YourLoanReminder
			[ ] locator "Your Loan Reminder"
		[+] PushButton Next
			[ ] locator "Next"
		[+] PushButton Back
			[ ] locator "Back"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] StaticText Label
			[ ] locator "[2]"
		[+] StaticText LoanLabel
			[ ] locator "Loan"
		[+] Control QWIconDisplay
			[ ] locator "@windowClassName='QWIconDisplay'"
		[+] StaticText QuickenWillAddaLoanReminderForThisAccount
			[ ] locator "Quicken will add a Loan Reminder for this account."
		[+] StaticText AScheduledLoanReminderIsUsedTo
			[ ] locator "A scheduled loan reminder is used to maintain the correct balance in your loan account."
		[+] StaticText QuickenUsesTheLoanDetailsYouJu
			[ ] locator "Quicken uses the loan details you just provided to automatically calculate the principal and interest due for each payment."
		[+] StaticText ItWillBeVisibleOnTheBillsTabAn
			[ ] locator "It will be visible on the Bills tab and anywhere else in Quicken where you see reminders."
		[+] StaticText JustClickEnterOnTheReminderAtE
			[ ] locator "Just click ""enter"" on the reminder at each billing period and your loan balance will be adjusted automatically based on the payment you make."
		[+] StaticText IfYouWantTheReminderToEnteredAutomaticallyChooseThisOption
			[ ] locator "If you want the reminder to entered automatically choose this option:"
		[+] CheckBox AutomaticallyEnterTheTransactionIntoTheRegister
			[ ] locator "Automatically enter the transaction into the register"
		[+] TextField IfYouWantTheReminderToEnteredAutomaticallyChooseThisOptionTextField
			[ ] locator "If you want the reminder to entered automatically choose this option:"
		[+] UpDownEx IfYouWantTheReminderToEnteredAutomaticallyChooseThisOptionUpDown
			[ ] locator "@priorlabel='If you want the reminder to entered automatically choose this option:'"
		[+] StaticText DaysBeforeTheDueDate
			[ ] locator "days before the due date"
		[+] Control QWinLightbox
			[ ] locator "@windowClassName='QWinLightbox'"
		[ ] 
	[+] window MainWin LoanPaymentReminder
		[ ] locator "*Payment Reminder"
		[+] StaticText LoanPaymentReminder
			[ ] locator "Loan Payment Reminder"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] StaticText AmountDueText
			[ ] locator "@windowid='131'"
		[+] TextField DueNextOnTextField
			[ ] locator "Due Next On"
		[+] PushButton DeleteButton
			[ ] locator "Delete"
		[+] TextField FromAccountTextField
			[ ] locator "@windowid='110'"
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Loan Details > Next > Your Loan Reminder----------------
	[+] window MainWin DlgLoanReminder
		[ ] locator "Loan Reminder"
		[+] RadioList LoanReminderOptionRadioList
			[ ] locator "//RadioList"
		[+] PushButton NextButton
			[ ] locator "Next"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] StaticText FirstOptionPaymentAmount
			[ ] locator "@windowid='2306'"
		[+] StaticText TotalPaymentTextOnReminder
			[ ] locator "@windowid='2319'"
		[+] StaticText OtherTextOnReminder
			[ ] // locator "@windowid='2315'"
			[ ] locator "@windowid='2317'"
		[+] StaticText PrincipalTextOnReminder
			[ ] locator "@windowid='2315'"
			[ ] // locator "@windowid='2317'"
		[+] PushButton BackButton
			[ ] locator "Back"
		[ ] 
	[ ] 
	[ ] //------Payment Details > Full Payment Schedule----------------
	[+] window DialogBox DlgLoanSchedule
		[ ] locator "Loan Schedule: *"
		[+] RadioList LoanReminderOptionRadioList
			[ ] locator "//RadioList"
		[+] PushButton NextButton
			[ ] locator "Next"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] StaticText FirstOptionPaymentAmount
			[ ] locator "@windowid='2306'"
	[ ] 
	[ ] 
	[+] window MainWin LoanInterestRate
		[ ] locator "Loan Interest Rate"
		[+] PushButton AddNewRate
			[ ] locator "Add new rate"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] TextField EffectiveAsOfDate
			[ ] locator "@windowid='4'"
			[ ] 
		[+] PushButton OK
			[ ] locator "OK"
		[+] Control Panel
			[ ] locator "@windowClassName='QWPanel'"
			[+] MainWin QWListViewer
				[ ] locator "@windowClassName='QWListViewer'"
				[+] ListBox VariableInterestListBox
					[ ] locator "@windowid='1'"
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] MainWin AdjustableRates
				[ ] locator "@windowid='2'"
				[+] ListBox ListBox
					[ ] locator "@windowClassName='ListBox'"
			[ ] 
			[+] PushButton AdjustRateLoans
				[ ] locator "@windowid='32758'"
				[ ] 
				[ ] 
			[ ] 
		[+] TextField EffectiveInterestRate
			[ ] locator "*Effective as of date*"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] MainWin VariableInterestRate
			[ ] locator "Variable Interest Rate"
			[+] TextField EffectiveDate
				[ ] locator "Effective Date"
			[+] TextField EffectiveRate
				[ ] locator "Interest Rate"
			[+] TextField RegularPayment
				[ ] locator "Regular Payment"
			[+] PushButton OKButton
				[ ] locator "OK"
			[+] PushButton CancelButton
				[ ] locator "Cancel"
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin ConvertAssetToLoanWindow
		[ ] locator "Convert this Asset to a Lending Loan"
		[ ] 
		[+] PushButton ConvertButton
			[ ] locator "Convert"
			[ ] 
		[+] PushButton CancelButton
			[ ] locator "Cancel"
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //--------Loans Objects------------------
	[ ] 
	[+] window MainWin LoanPaymentOptions
		[ ] locator "Loan Payment Options"
		[+] CheckBox AutomaticallyEnterTransactionsIntoRegister
			[ ] //locator "Automatically enter the transaction into the register"
			[ ] locator "@windowid='10'"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] TextField EnterAutomaticallyDaysBeforeTextField
			[ ] //locator "If you want the reminder to be entered automatically choose this option:"
			[ ] locator "@windowid='11'"
			[ ] 
		[+] RadioList LoanReminder
			[ ] locator "Loan Reminder"
		[+] RadioList MemorizedPayee
			[ ] locator "Memorized Payee"
		[+] PushButton OK
			[ ] locator "OK"
	[ ] 
	[+] window Control MDIClientLoans
		[ ] locator "@windowClassName='MDIClient'"
		[+] Control LoanWindow
			[ ] //locator "/Control[@caption='Loan*']"
			[ ] //locator "*"
			[ ] //locator "@className='QWMDI'"
			[ ] 
			[ ] 
			[ ] //Pushbutton
			[+] PushButton WhatIfTool
				[ ] locator "*What If Tool*"
			[+] PushButton Equity
				[ ] locator "*Equity*"
			[+] PushButton PaymentDetails
				[ ] locator "*Payment Details*"
			[+] PushButton LoanDetails
				[ ] locator "*Loan Details*"
				[ ] 
			[+] PushButton AddLoanDetails
				[ ] locator "Add Loan Details"
				[ ] 
			[ ] 
			[+] PushButton EditTerms
				[ ] locator "@windowid='218'"
				[ ] 
			[+] PushButton EditInterestRateAmountButton
				[ ] //locator "*edit*"
				[ ] locator "@windowid='18108'"
				[ ] 
			[+] PushButton EditPaymentFrequencyButton
				[ ] //locator "/Control[@caption='Quicken 2014 Rental Property Manager - Register - [Loan]']//PushButton[@caption='edit'][2]"
				[ ] locator "@windowid='18103'"
				[ ] 
			[+] PushButton AddLoanDetailsButton
				[ ] locator "*Add Loan Details*"
				[ ] 
			[+] PushButton AddLinkedAssetAccount
				[ ] locator "Add linked asset account*"
			[+] PushButton EditPaymentDetails
				[ ] locator "Edit payment details"
			[ ] 
			[ ] 
			[ ] //Control
			[+] Control CurrentDate
				[ ] locator "@windowid='17106'"
			[+] Control LoanBalanceAmount
				[ ] // locator "/Control[@caption='Quicken 2014 Rental Property Manager - Register - [Loan]']//Control[@caption='150.00'][1]"
				[ ] locator "@windowid='17102'"
			[+] Control InterestRateText
				[ ] //locator "*INTEREST RATE*"
				[ ] locator "@windowid='18106'"
			[+] Control InterestRateAmount
				[ ] locator "@windowid='18107'"
			[+] Control OriginationDateText
				[ ] locator "@windowid='211'"
			[+] Control OriginalLengthText
				[ ] locator "@windowid='212'"
			[+] Control CompoundingPeriodText
				[ ] locator "@windowid='216'"
			[+] Control PaymentText
				[ ] locator "@windowid='18101'"
			[+] Control PaymentAmount
				[ ] locator "@windowid='18102'"
			[+] Control NextDueText
				[ ] locator "@windowid='18104'"
			[+] Control NextDueDate
				[ ] locator "@windowid='18105'"
				[ ] 
			[+] Control LoanBalanceText
				[ ] locator "@windowid='17101'"
			[+] Control CurrentInterestAmount
				[ ] locator "@windowid='215'"
			[ ] 
			[+] Control ClosingInterestRateText
				[ ] locator "[@caption='Closing interest rate:']"
			[+] Control ClosingInterestRateValue
				[ ] locator "@windowid='215'"
			[ ] 
			[+] Control PaymentScheduleLabel
				[ ] locator "[@windowid='18101' and @windowClassName='QWLabel']"
				[ ] 
			[+] Control WhatIf
				[ ] locator "@windowClassName='QWPanel'"
				[+] Control QWChild
					[ ] locator "@windowClassName='QWinChild'"
					[+] RadioList PaidExtra
						[ ] locator "I paid an extra*"
					[+] RadioList OneTimePayment
						[ ] locator "I made a one time payment of*"
					[+] Control Panel1
						[ ] locator "@windowClassName='QWPanel'"
						[+] Control Panel2
							[ ] locator "@windowClassName='QWPanel'"
							[+] Control PayoffSchedule
								[ ] locator "@windowid='991'"
								[+] Control ListBox
									[ ] locator "@windowid='1'"
									[+] Control QWChild
										[ ] locator "@windowClassName='QWinChild'"
										[+] StaticText InterestRateYear
											[ ] locator "@windowid='976'"
										[+] StaticText InterestRateDate
											[ ] locator "@windowid='978'"
										[+] StaticText TotalInterest
											[ ] locator "@windowid='979'"
											[ ] 
									[ ] 
						[ ] 
						[ ] 
				[ ] 
			[ ] 
			[+] Control LoanNameText
				[ ] locator "@windowid='32702'"
				[ ] 
			[ ] 
			[+] Control OriginalBalanceText
				[ ] locator "@windowid='772'"
			[ ] 
			[+] Control PaymentDetailsPanel
				[ ] locator "Panel"
				[ ] 
				[ ] 
				[+] PushButton FullPaymentButton
					[ ] locator "@windowid='551'"
					[ ] 
				[ ] 
				[+] Control PaymentPieChart
					[ ] locator "@windowClassName='QWinChild'"
					[+] PushButton FullPaymentScheduleButton
						[ ] //locator "Full payment schedule"
						[ ] locator "@windowid='551'"
					[+] Control Panel
						[ ] locator "[@caption='Panel'][2]"
						[+] MainWin PaymentDetailsMainWin
							[ ] locator "@windowClassName='QWListViewer'"
							[+] ListBox ListBox
								[ ] locator "//ListBox"
						[ ] 
						[ ] 
				[+] Control QWChild
					[ ] locator "@windowClassName='QWinChild'"
					[+] Control DashboardPanel
						[ ] locator "Panel"
						[+] StaticText PAYOFFDATE
							[ ]  locator "*PAYOFF DATE*"
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
			[ ] 
			[ ] //StaticText
			[+] StaticText LoanTypeText
				[ ] locator "@windowid='301'"
				[ ] 
				[ ] 
			[ ] 
			[+] StaticText FINameText
				[ ] locator "@windowid='1'"
				[ ] 
			[+] StaticText RemainingPaymentAmount
				[ ] locator "@windowid='655'"
				[ ] 
			[+] StaticText PayOffMonthText
				[ ] locator "@windowid='652'"
				[ ] 
			[+] StaticText PayOffYearText
				[ ] locator "@windowid='656'"
				[ ] 
			[+] StaticText EquityLinkedToAssetText
				[ ] locator "@windowid='151'"
				[ ] 
			[+] StaticText EquityLinkedToAssetAmount
				[ ] locator "@windowid='152'"
				[ ] 
			[+] StaticText NextDueDateOnPayOffLegendText
				[ ] locator "@windowid='404'"
				[ ] 
				[ ] 
			[ ] 
			[ ] //ListBox
			[+] ListBox DebtAccountsCurrentValueListBox
				[ ] locator "//ListBox"
				[ ] 
				[ ] 
			[+] ListBox DebtAccountsCurrentValueListBox2
				[ ] locator "//ListBox[2]"
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] Control DebtAccountsQWListViewer
				[ ] locator "@windowClassName='QWListViewer'"
				[ ] 
				[+] ListBox DebtAccountsCurrentValueListBox
					[ ] //locator "@windowid='1'"
					[ ] locator "@windowClassName='ListBox'"
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[+] Control TxList
				[ ] locator "@windowid='13'"
				[ ] 
				[+] Control TxToolBar
					[ ] locator "@windowid='8'"
					[ ] 
					[+] PushButton Save
						[ ] locator "@windowid='101'"
					[ ] 
					[+] PushButton MoreActions
						[ ] locator "@windowid='143'"
					[ ] 
					[+] PushButton SplitButton
						[ ] locator "@windowid='103'"
				[+] PushButton TagButton
					[ ] locator "@windowid='1124'"
					[ ] // locator "//PushButton[4]"
					[ ] 
					[ ] 
				[+] PushButton AddedSplitButton
					[ ] locator "[1]"//"[@windowid='103'][1]"
				[+] PushButton ClearSplitlinesButton
					[ ] locator "@windowid='162'"
				[+] PushButton SplitReportButton
					[ ] locator "@windowid='456'"
				[+] MenuItem Notes
					[ ] locator "@windowid='7138'"
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[ ] 
	[ ] 
	[+] window ListBox PaymentDetailsListBox
		[ ] locator "//ListBox"
	[ ] 
	[+] window DialogBox LoanSchedule
		[ ] locator "Loan Schedule:*"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] MainWin QWListViewer
			[ ] locator "@windowid='701'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
			[ ] 
		[ ] 
		[ ] 
		[+] CheckBox ShowRunningBalance
			[ ] locator "@windowid='709'"
			[ ] 
		[+] PushButton Done
			[ ] locator "Done"
			[ ] 
			[ ] 
		[+] StaticText CurrentBalanceAmount
			[ ] locator "@windowid='704'"
			[ ] 
			[ ] 
		[+] StaticText RemainingPaymentAmount
			[ ] locator "@windowid='707'"
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] StaticText PayOffDateText
			[ ] locator "@windowid='708'"
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] Control LoanDetailsLinkPanel
			[ ] locator "@windowid='702'"
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //Confirm Principal and Interest dialog
	[+] window DialogBox DlgConfirmPrincipalandInterest
		[ ] locator "Confirm Principal and Interest"
		[+] PushButton OKButton
			[ ] locator "OK"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //************* Investing *********************************************************
	[ ] //------Investing > Add Account----------------
	[+] window MainWin AddAccount
		[ ] locator "Add*Account"
		[+] Control QC_button
			[ ] locator "@windowClassName='QC_button'"
		[+] // StaticText AddAccount
			[ ] // locator "Add Account"
		[+] PushButton Next
			[ ] locator "@windowid='1002'"
		[+] PushButton Cancel
			[ ] locator "@windowid='1004'"
			[ ] 
		[+] // RadioList Brokerage
			[ ] // locator "Brokerage"
		[+] // RadioList IRAOrKeoghPlan
			[ ] // locator "IRA or Keogh Plan"
		[+] // RadioList x401kOr403b
			[ ] // locator "401(k) or 403(b)"
		[+] // RadioList x529Plan
			[ ] // locator "529 Plan"
		[ ] 
		[ ] //---------All Account Buttons------------
		[+] PushButton Checking
			[ ] locator "Checking"
		[+] PushButton CreditCard
			[ ] locator "Credit Card"
		[+] PushButton Savings
			[ ] locator "Savings"
		[+] PushButton CashButton
			[ ] locator "Cash"
		[+] PushButton Brokerage
			[ ] locator "Brokerage"
		[+] PushButton IRAOrKeoghPlan
			[ ] locator "IRA or Keogh Plan"
		[+] PushButton x401kOr403b
			[ ] locator "401(k) or 403(b)"
		[+] PushButton x529Plan
			[ ] locator "529 Plan"
		[+] PushButton House
			[ ] locator "House"
		[+] PushButton Vehicle
			[ ] locator "Vehicle"
		[+] PushButton OtherAsset
			[ ] locator "Other Asset"
		[+] PushButton Loan
			[ ] locator "Loan"
		[+] PushButton HomeEquityLineHELOC
			[ ] locator "Home Equity Line (HELOC)"
		[+] PushButton OtherLiability
			[ ] locator "Other Liability"
		[+] PushButton AccountsPayable
			[ ] locator "Accounts Payable"
		[+] PushButton AccountsReceivable
			[ ] locator "Accounts Receivable"
		[+] PushButton No
			[ ] locator "@windowid='32766'"
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Investing > Memorized Investment Transactions----------------
	[+] window MainWin InvestmentTransactionListWindow
		[ ] locator "//MainWin[@caption='Investment Transaction List']"
		[+] StaticText InvestmentTransactionList
			[ ] locator "Investment Transaction List"
		[+] Control QWListViewer
			[ ] locator "@windowClassName='QWListViewer'"
		[+] ListBox ListBox1
			[ ] locator "Investment Transaction List"
		[+] PushButton Print
			[ ] locator "[@priorlabel='Investment Transaction List'][1]"
		[+] PushButton Help
			[ ] locator "[@priorlabel='Investment Transaction List'][2]"
		[+] PushButton Done
			[ ] locator "Done"
		[+] PushButton Delete
			[ ] locator "Delete"
		[+] PushButton Use
			[ ] locator "Use"
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Investing > Download Activity > Quotes----------------		
	[+] // window DialogBox QuickenUpdateStatus
		[ ] // locator "[@caption='Quicken Update Status']"
		[+] // PushButton StopUpdate
			[ ] // locator "Stop Update"
	[+] window MainWin QuickenUpdateStatus
		[ ] locator "*Quicken Update Status*"
		[+] PushButton StopUpdate
			[ ] locator "Stop Update"
	[ ] 
	[ ] //------Investing > Download Activity > Historical Prices----------------		
	[+] window DialogBox GetHistoricalPrices
		[ ] locator "//DialogBox[@caption='Get Historical Prices']"
		[+] StaticText GetHistoricalPricesText
			[ ] locator "Get Historical Prices"
		[+] StaticText SelectTheSecuritiesYouWant1
			[ ] locator "Select the securities you want historical prices for:"
		[+] StaticText GetPricesForTheLastText
			[ ] locator "Get prices for the last"
		[+] ComboBox SelectTheSecuritiesYouWant2
			[ ] locator "Select the securities you want historical prices for:"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] PushButton MarkAll
			[ ] locator "Mark All"
		[+] PushButton ClearAll
			[ ] locator "Clear All"
		[+] PushButton GetPricesForTheLast1
			[ ] locator "[@priorlabel='Get prices for the last'][3]"
		[+] PushButton UpdateNow
			[ ] locator "Update Now"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] //------Brokerage Account window---------------- Still need to convert some objects to open agent
	[+] window MainWin BrokerageAccount
		[ ] locator "//Control[@windowClassName='MDIClient']"
		[+] PushButton EnterTransactions
			[ ] locator "@caption='Enter Transactions'"
		[+] PushButton Holdings
			[ ] locator "//PushButton[@caption='Holdings']"
		[+] PushButton Find
			[ ] locator "@windowid='32206'"
		[+] PushButton AccountActions
			[ ] locator "@windowid='32221'"
		[+] Control QWSnapHolder1
			[ ] locator "@windowid='-1'"
			[+] StaticText StaticText1
				[ ] locator "@windowid='-1'"
				[+] StaticText StaticText2
					[ ] locator "@windowid='-1'"
					[+] PushButton AcceptAll
						[ ] locator "@windowid='27002'"
				[+] Control QWListViewer1
					[ ] locator "@windowid='8200'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[ ] 
		[+] Control wTransaction
			[ ] //locator "@windowid='0'"
			[ ] 
			[+] PushButton DownloadTransactionsTab
				[ ] locator "@windowid='1021'"
			[+] PushButton BillAndIncomeRemindersTab
				[ ] locator "@windowid='1022'"
			[+] PushButton SetUpDownload
				[ ] locator "@windowid='1023'"
			[+] PushButton SetUpOnlinePayment
				[ ] locator "@windowid='1024'"
		[+] StaticText StaticText1
			[ ] locator "@windowid='7'"
			[+] StaticText Balance
				[+] locator "Balance"
					[ ] 
			[+] StaticText StaticText1
				[ ] locator "@windowid='-1'"
				[+] CustomWin QWHtmlView1
					[ ] locator "@windowid='1000'"
				[+] CustomWin QWHtmlViewer
					[ ] locator "@windowid='982'"
					[+] ListBox CashBalance
						[ ] locator "@windowid='1'"
		[+] Control InvestingAccountRegister
			[ ] locator "//Control[@windowClassName='QWMDI']"
			[+] StaticText AccountRegisterChild
				[ ] locator "@windowid='-1'"
				[+] StaticText StaticText1
					[ ] locator "@windowid='-1'"
					[+] MainWin QWListViewer
						[ ] locator "@windowid='982'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
		[+] ListBox ListBox2
			[ ] locator "//ListBox[2]"
		[+] ListBox ListBox1
			[ ] locator "//ListBox[1]"
		[+] PushButton PlaceholderEntriesTab
			[ ] locator "@windowid='1033'"
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Investing > Security List
	[ ] 
	[+] window MainWin wEnterTransaction
		[ ] locator "[@caption='*Buy - Shares Bought' or @caption='Sell - Shares Sold' or @caption='Short Sale' or @caption='Inc - Income (Div, Int, etc.)' or @caption='Add - Shares Added' or @caption='Reinvest - Income Reinvested'  or @caption='Remove - Shares Removed' or @caption='Stock Split' or @caption='Bonds Bought' or @caption='Miscellaneous Expense' or @caption='Cover Short Sale' or @caption='Adjust Share Balance' or @caption='Withdraw' or @caption='Deposit' or @caption='Bought ESPP Shares' or @caption='Sold ESPP Shares' or @caption='Cash Transferred into Account' or @caption='Cash Transferred out of Account' or @caption='Shares Transferred Between Accounts' or @caption='Edit*' or @caption='*Stock Dividend*' or @caption='*Return of Capital*' or @caption='*Write Check*' or @caption='*Withdraw*' or @caption='*Deposit*']"
		[+] ComboBox EnterTransaction
			[ ] locator "@windowid='100'"
		[+] TextField TransactionDate
			[ ] locator "[@windowid='102' or @windowid='10200']"
			[ ] 
			[ ] 
			[ ] 
		[+] TextField SecurityName
			[ ] locator "@windowid='104'"
		[+] ComboBox Account
			[ ] locator "Account:"
			[ ] //locator "@windowid='103'"
			[ ] 
			[ ] 
			[ ] 
		[+] TextField NumberOfShares
			[ ] locator "Number of shares:"
		[+] TextField Amount
			[ ] //locator "@windowid='1501'"
			[ ] //locator "@windowid='1301'"
			[ ] locator "//TextField[@caption='Amount:']"
			[ ] 
			[ ] 
		[+] TextField Category
			[ ] //locator "[@windowid='1303' or @windowid='1503']"
			[ ] //locator "@windowid='1303'"
			[ ] locator "//TextField[@caption='Category:']"
			[ ] 
			[ ] 
		[+] TextField PricePaid
			[ ] locator "@windowid='2803' or @windowid='2821' or @windowid='2881'"
		[+] TextField Commission
			[ ] locator "Commission:"
		[+] Control QWCommission
			[ ] locator "@windowid='2800'"
		[+] TextField TotalCost
			[ ] locator "@windowid='2805'"
		[+] Control QWMemo
			[ ] locator "@windowid='2801'"
		[+] RadioList UseCashForThisTransaction
			[ ] locator "@windowid='2807'"
		[+] ComboBox FromAccountList
			[ ] locator "@windowid='2809'"
		[+] TextField Memo
			[ ] //locator "@windowid='108'"
			[ ] locator "//TextField[@caption='Memo:']"
			[ ] 
		[+] PushButton EnterNew
			[ ] locator "@windowid='32767'"
		[+] PushButton EnterDone
			[ ] locator "@windowid='32762'"
		[+] PushButton QWUseCashForThisTransaction
			[ ] locator "@windowid='32765'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton Clear
			[ ] locator "@windowid='32761'"
		[ ] 
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
			[ ] 
		[ ] 
		[+] Control CalendarButton
			[ ] locator "[@windowid='2020'][1]"
			[ ] 
			[+] // PushButton QC_button2
				[ ] // locator "@windowid='1124'"
			[+] // PushButton QC_button1
				[ ] // locator "@windowid='1128'"
		[+] Control SharesMenuButton
			[ ] locator "[@windowid='2020'][2]"
			[ ] 
			[+] // PushButton QC_button2
				[ ] // locator "@windowid='1124'"
			[+] // PushButton QC_button1
				[ ] // locator "@windowid='1128'"
		[+] // Control QFBag1
			[ ] // locator "@windowid='2020'"
			[+] // PushButton QC_button2
				[ ] // locator "@windowid='1124'"
			[+] // PushButton QC_button1
				[ ] // locator "@windowid='1128'"
		[+] // Control BuySharesBought2
			[ ] // locator "@windowid='2020'"
			[+] // PushButton QC_button2
				[ ] // locator "@windowid='1124'"
			[+] // PushButton QC_button1
				[ ] // locator "@windowid='1128'"
		[ ] 
		[+] PushButton SpecifyLotsButton
			[ ] locator "[@caption='Specify Lots*']"
			[ ] 
		[ ] 
		[+] Control QWTotalCost
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] TextField Dividend
			[ ] locator "Dividend:"
			[ ] //locator "@windowid='2101'"
		[+] TextField Interest
			[ ] locator "Interest:"
			[ ] //locator "@windowid='2103'"
		[+] TextField ShortTermCapGainDist
			[ ] locator "Short-term cap gain dist:"
			[ ] //locator "@windowid='2105'"
		[+] TextField MidTermCapGainDist
			[ ] locator "Mid-term cap gain dist:"
			[ ] //locator "@windowid='2107'"
		[+] TextField LongTermCapGainDist
			[ ] //locator "'Long-term cap gain dist:'"
			[ ] locator "@windowid='2013' or @windowid='2109'"
		[+] TextField Miscellaneous
			[ ] locator "@windowid='2111'"
		[+] TextField CategoryForMiscellaneous
			[ ] locator "@windowid='2113'"
		[+] TextField TransferAccount
			[ ] locator "@windowid='111'"
		[+] TextField DateAcquired
			[ ] locator "@windowid='2884'"
		[+] TextField NewShares
			[ ] locator "@windowid='1103'"
		[+] TextField OldShares
			[ ] locator "@windowid='1101'"
		[+] TextField PriceAfterSplit
			[ ] locator "@windowid='1105'"
		[+] TextField NumberOfBonds
			[ ] locator "@windowid='2928'"
		[+] TextField Price
			[ ] locator "@windowid='2929'"
		[+] TextField AccruedInt
			[ ] locator "@windowid='2931'"
		[+] DialogBox AlertMessage
			[+] Control Control105
				[ ] locator "@windowid='105'"
			[+] StaticText Message
				[ ] locator "@windowid='100'"
			[+] PushButton OK
				[ ] locator "@windowid='101'"
		[+] StaticText PayeeText
			[ ] locator "@windowid='10301'"
		[+] TextField Payee
			[ ] locator "@windowid='10202'"
		[+] StaticText NumberText
			[ ] locator "@windowid='10300'"
		[+] TextField ChequeNumber
			[ ] locator "@windowid='10206'"
		[+] PushButton LaunchWizard
			[ ] locator "@windowid='2601'"
		[+] TextField AmountToTransfer
			[ ] locator "@windowid='2201'"
		[+] TextField PriceRecieved 
			[ ] locator "Price received:"
		[+] TextField DividentShare
			[ ] locator "@windowid='2002'"                                                     
		[+] TextField IntrestShare
			[ ] locator "@windowid='2005'"                                                            
		[+] TextField ShortShare
			[ ] locator"@windowid='2008'"                                                             
		[+] TextField MidShare
			[ ] locator"@windowid='2011'"                                                       
		[+] TextField LongShare
			[ ] locator"@windowid='2014'"                                                              
		[+] TextField MarketValue
			[ ] locator "Market value:"
		[ ] 
		[+] DialogBox AddSecurityToQuicken     													
			[ ] locator "Add Security to Quicken"							
			[+] Control EnterSymbol
				[ ] locator "Enter symbol or name for this new security"
			[+] TextField TickerSymbol
				[ ] locator "Ticker Symbol:"
			[+] PushButton LookUp
				[ ] locator "Look Up"
			[+] TextField Name
				[ ] locator "Name:"
			[+] CheckBox AddSecurityToWatchList
				[ ] locator "@windowid='207'"
			[+] PushButton Next
				[ ] locator "Next"
			[+] Control ConnectionError
				[ ] locator "Connection Error"
			[+] Control NoDataFoundFor
				[ ] locator  "@windowid='32100'"
			[+] RadioList AddManually
				[ ] locator  "@windowid='2708'"
			[+] RadioList SelectTickerSymbol
				[ ] locator "@windowid='2707'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='32765'"
			[+] PushButton Cancel
				[ ] locator "@windowid='32766'"
			[+] PushButton Done
				[ ] locator "@windowid='32764'"
			[ ] 
		[ ] 
		[+] Control QuickFillHolder
			[ ] locator "[@windowClassName='QWQuickfillHolder']"
			[+] Control ExistingSecurityListBox
				[ ] //locator "[@windowClassName='QFlistbox']"
				[ ] locator "@windowid='1'"
				[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // sprint 10
		[+] TextField NewSharesIssued
			[ ] locator"@windowid='1201'"                                                              
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //------Investing > Portfolio------					
	[+] window Control Investing
		[ ] locator "[@caption='Investing']"
		[+] StaticText ShowText
			[ ] locator "@windowid='3039'"
		[+] ComboBox Show
			[ ] locator "@windowid='3009'"
		[+] StaticText GroupByText
			[ ] locator "@windowid='3069'"
		[+] ComboBox GroupBy
			[ ] locator "@windowid='3005'"
		[+] PushButton Customize
			[ ] locator "@windowid='3048'"
		[+] TextField AsOf1
			[ ] locator "@windowid='3006'"
		[+] PushButton Options
			[ ] locator "@windowid='3083'"
		[+] Control ShowValue
			[ ] locator "@windowid='3007'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] Control AsOf2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control QWSnapHolder
			[ ] locator "@windowid='-1'"
			[+] StaticText PerfSnap
				[ ] locator "@windowid='-1'"
				[+] StaticText PerfAverageAnnualReturn
					[ ] locator "@windowid='31000'"
					[+] PushButton Options
						[ ] locator "@windowid='1000'"
			[+] StaticText AllocationSnap
				[ ] locator "@windowid='-1'"
				[+] StaticText AssetAllocation
					[ ] locator "@windowid='-1'"
					[+] PushButton ShowAllocationGuide
						[ ] locator "@windowid='500'"
			[+] StaticText AllocationByAccount
				[ ] locator "@windowid='-1'"
				[+] Control QwGraph
					[ ] locator "@windowid='-1'"
	[ ] 
	[ ] //------Investing > Portfolio > Security name > Right click > Price History----------------
	[+] window DialogBox PriceHistory
		[ ] locator "Price History for*"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control QW_MDI_TOOLBAR1
			[ ] locator "@windowid='12000'"
		[+] MainWin QWListViewer1
			[ ] locator "@windowid='125'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
	[ ] 
	[ ] 
	[ ] //Brokerage Account > Enter Transaction > Buy Share- Add Security window----------------
	[+] window WPFWindow AddSecurityToQuicken2								
		[ ] locator "/WPFWindow[@caption='Add Security to Quicken']"
		[ ] 
		[+] WPFListBox SecurityListBox
			[ ]  locator "//WPFListBox"
			[ ] // locator "//WPFListBox[@automationId='simpleResult']"
		[+] WPFTextBox TickerSymbolTextField
			[ ] // locator "//WPFTextBox[@automationId='userText']"
			[ ] locator "[@className='TextBox']"
		[+] WPFButton NextButton
			[ ] locator "Next"
			[ ] // locator "//WPFButton[@automationId='NextBtn']"
			[ ] 
		[+] WPFButton AddManuallyButton
			[ ] locator  "//WPFButton[@caption='Add Manually']"
			[ ] 
		[+] WPFButton CancelButton
			[ ] locator  "//WPFButton[@caption='Cancel']"
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] window DialogBox AddSecurityToQuicken     													
		[ ] locator "Add Security to Quicken"							
		[+] Control EnterSymbol
			[ ] locator "Enter symbol or name for this new security"					
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] TextField TickerSymbol
			[ ] locator "Ticker Symbol:"
		[+] PushButton LookUp
			[ ] locator "Look Up"
		[+] TextField Name
			[ ] locator "Name:"
		[+] CheckBox AddSecurityToWatchList
			[ ] locator "@windowid='207'"
		[+] PushButton Next
			[ ] locator "Next"
		[+] Control ConnectionError
			[ ] locator "Connection Error"
		[+] Control NoDataFoundFor
			[ ] locator  "@windowid='32100'"
		[+] RadioList AddManually
			[ ] locator  "@windowid='2708'"
		[+] RadioList SelectTickerSymbol
			[ ] locator "@windowid='2707'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton Done
			[ ] locator "@windowid='32764'"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] window DialogBox ESPP
		[ ] locator "ESPP"
		[+] StaticText Message
			[ ] locator "@windowid='100'"
		[+] PushButton Yes
			[ ] locator "@windowid='101'"
		[+] PushButton No
			[ ] locator "@windowid='102'"
			[ ] 
	[ ] 					
	[+] window DialogBox BoughtAddedESPPShares
		[ ] locator "Bought*Added ESPP Shares"
		[+] PushButton EasyStep
			[ ] locator "EasyStep"
		[+] PushButton Summary
			[ ] locator "Summary"
		[+] Control QWIconDisplay1
			[ ] locator "[QWIconDisplay]#1"
		[+] Control WhichStockDoesThisESPPAll
			[ ] locator "Which stock does this ESPP allow you to purchase*"
		[+] RadioList CashFrom
			[ ] locator "@windowid='605'"
		[+] ComboBox FromAccount
			[ ] locator "@windowid='207'"
		[+] StaticText StockText
			[ ] locator "@windowid='32150'"
		[+] ComboBox Stock
			[ ] locator "@windowid='600'"
		[+] StaticText NameText
			[ ] locator "@windowid='32151'"
		[+] TextField Name
			[ ] locator  "@windowid='601'"
		[+] StaticText TickerSymbolText
			[ ] locator "Ticker Symbol:"
		[+] TextField TickerSymbol
			[ ] locator "@windowid='602'"
		[+] PushButton LookUp
			[ ] locator "@windowid='603'"
		[+] PushButton Next
			[ ] locator "@windowid='32764'"
		[+] PushButton QC_button2
			[ ] locator  "@windowid='32765'"
		[+] PushButton Cancel
			[ ] locator  "@windowid='32766'"
		[+] Control QWLabel1
			[ ] locator  "@windowid='32100'"
		[+] Control QWSeparator1
			[ ] locator "@windowid='32180'"
		[+] StaticText NumberOfSharesText
			[ ] locator "Number of shares:"
		[+] TextField NumberOfShares
			[ ] locator "@windowid='203'"
		[+] TextField PricePerShare
			[ ] locator "Price per share:"
		[+] TextField TransactionDate
			[ ] locator "Transaction date:"
		[+] TextField CommissionFee1
			[ ] locator "Commission?fee:"
		[+] Control TransactionDateEasyStep
			[ ] locator "@windowid='32181'"
		[+] StaticText EmployeeStockPurchasePlanI1
			[ ] locator "@windowid='32102'"
		[+] TextField OfferingDate
			[ ] locator "Employee Stock Purchase Plan Information[1]"
		[+] TextField EndingDate
			[ ] locator "Employee Stock Purchase Plan Information[2]"
		[+] TextField PriceOnOffering
			[ ] locator "Employee Stock Purchase Plan Information[3]"
		[+] TextField PriceOnEnding
			[ ] locator "Employee Stock Purchase Plan Information[4]"
		[+] StaticText DiscountRateText
			[ ] locator "Discount rate:"
		[+] TextField DiscountRate
			[ ] locator "Price on offering date:"
		[+] StaticText SpouseSESPPText
			[ ] locator "Spouse's ESPP*"
		[+] CheckBox SpouseSESPP
			[ ] locator "Price on ending date:"
		[+] PushButton Back
			[ ] locator  "@windowid='32763'"
		[+] Control TransactionDate3
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator  "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control CommissionFee2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control EmployeeStockPurchasePlanI6
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1             
				[ ] locator "@windowid='1128'"
		[+] PushButton Done
			[ ] locator "@windowid='32764'"
		[+] RadioList CostBasisMethod
			[ ] locator "Cost Basis Method"
		[+] ComboBox WhichSecurity
			[ ] locator "Which security*"
	[ ] 
	[+] window DialogBox SoldRemovedESPPShares
		[ ] locator "Sold*Removed ESPP Shares"
		[+] Control QWIconDisplay1
			[ ] locator "@windowid=32193"
		[+] PushButton EasyStep
			[ ] locator "@windowid=32300"
		[+] PushButton Summary
			[ ] locator "Summary"
		[+] Control IWantToSellOrRemoveESP
			[ ] locator  "@windowid=32100"
		[+] StaticText WhichSecurityText
			[ ] locator  "@windowid=32110"
		[+] StaticText ChooseASecurityFromTheLis
			[ ] locator  "@windowid=32111"
		[+] PushButton Next
			[ ] locator  "@windowid=32764"
		[+] PushButton QC_button1
			[ ] locator  "@windowid=32765"
		[+] PushButton Cancel
			[ ] locator  "@windowid=32766"
	[ ] 
	[ ] 
	[+] window MainWin InvestingAccountPopup
		[ ] locator "*"
		[+] StaticText Brokerage01
			[ ] locator "Brokerage 01"
			[+] PushButton EnterTransactionsButton
				[ ] locator "@windowid='981'"
		[+] PushButton EnterTransactionsButton
			[ ] locator "@windowid='981'"
		[+] PushButton Holdings
			[ ] locator "Holdings"
		[+] PushButton Find
			[ ] locator "Find"
		[+] ListBox ListBox
			[ ] locator "[1]"
		[+] Control QWSnapHolder
			[ ] locator "@windowClassName='QWSnapHolder'"
		[+] Control Brokerage01Control5
			[ ] locator "[@priorlabel='Brokerage*'][5]"
		[+] StaticText EnterYourFinancialInstitutionName
			[ ] locator "Enter your financial institution name"
		[+] TextField EnterYourFinancialInstitutionNameTextField
			[ ] locator "Enter your financial institution name"
		[+] PushButton CheckAvailability
			[ ] locator "Check Availability"
		[+] Control QWinChild
			[ ] locator "@windowClassName='QWinChild'"
			[+] PushButton DownloadTransactions
				[ ] locator "Download Transactions"
			[+] PushButton BillAndIncomeReminders0Due
				[ ] locator "Bill and Income Reminders*"
			[+] PushButton SetUpDownload
				[ ] locator "Set Up Download"
			[+] PushButton SetUpOnlinePayment
				[ ] locator "Set Up Online Payment"
			[+] Control QWListViewer
				[ ] locator "@windowClassName='QWListViewer'"
				[+] ListBox ListBox1
					[ ] locator "Brokerage 01"
		[+] PushButton FILOGO
			[ ] locator "FI LOGO"
		[+] PushButton Brokerage01PushButton
			[ ] locator "[@priorlabel='Brokerage 01'][9]"
		[+] StaticText Label8
			[ ] locator "[8]"
		[+] StaticText Label9
			[ ] locator "[9]"
	[ ] 
	[+] window MainWin UpdateCashBalance
		[ ] locator "Update Cash Balance"
		[+] TextField CashBalanceTextField
			[ ] locator "@windowid='2012'"
		[+] TextField AdjustBalanceDateTextField
			[ ] locator "Adjust the balance as of this date:"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Done
			[ ] locator "Done"
		[ ] 
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[+] window DialogBox Update401KAccountHoldings
		[ ] locator "Update 401(k)*403(b) Account*"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton Done
			[ ] locator "Done"
		[+] // CustomWin WelcomeTo401K403BUpdat2
			[+] // multitag "[QWNewSep]Welcome to 401(k)?403(b) Update."
				[ ] // "[QWNewSep]^Welcome to 401(k)?403(b) Update."
				[ ] // "[QWNewSep]#1"
				[ ] // "[QWNewSep]$32180"
				[ ] // "[QWNewSep]@(306,40)"
		[+] // CustomWin DidYouTakeOutANewLoanAg1
			[+] // multitag "[QWNewSep]Did you take out a new loan against this account during the last statement period?"
				[ ] // "[QWNewSep]^Did you take out a new loan against this account during the last statement period?"
				[ ] // "[QWNewSep]#2"
				[ ] // "[QWNewSep]$32181"
				[ ] // "[QWNewSep]@(306,321)"
		[+] TextField ThisStatementEndsTextField
			[ ] locator "@windowid='2166'"
		[+] PushButton Next
			[ ] locator "Next"
		[+] TextField EmployeeContributionsTextField
			[ ] locator "@windowid='2190'"
		[+] TextField EmployerMatchingContributionTextField
			[ ] locator "@windowid='2191'"
		[+] TextField FederalTaxWithheldTextField
			[ ] locator "@windowid='3401'"
		[+] TextField StateTaxWithheldTextField
			[ ] locator "@windowid='3402'"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin AdjustShareBalance
		[ ] locator "Adjust Share Balance"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] ComboBox EnterTransaction
			[ ] locator "Enter transaction:"
		[+] TextField TransactionDate
			[ ] locator "Transaction date:"
		[+] TextField SecurityName
			[ ] locator "Security name:"
		[+] ComboBox Account
			[ ] locator "Account:"
		[+] TextField NumberOfShares
			[ ] locator "Number of shares:"
		[+] PushButton EnterNew
			[ ] locator "@windowid='32767'"
		[+] PushButton EnterDone
			[ ] locator "@windowid='32762'"
		[+] PushButton Clear
			[ ] locator "@windowid='32761'"
		[ ] 
	[ ] 
	[+] window MainWin AdjustHoldingsAmount
		[ ] locator "Adjust holdings amount"
		[+] PushButton AcceptButton
			[ ] locator "Accept"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[ ] 
	[+] window MainWin SecuritiesComparisonMismatch
		[ ] locator "//MainWin[@caption='Securities Comparison Mismatch']"
		[+] PushButton AcceptButton
			[ ] locator "Accept"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] window DialogBox DlgUpdate401KAccountHoldings
		[ ] locator "Update 401(k)?403(b) Account*"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton Done
			[ ] locator "Done"
		[+] // CustomWin WelcomeTo401K403BUpdat2
			[+] // multitag "[QWNewSep]Welcome to 401(k)?403(b) Update."
				[ ] // "[QWNewSep]^Welcome to 401(k)?403(b) Update."
				[ ] // "[QWNewSep]#1"
				[ ] // "[QWNewSep]$32180"
				[ ] // "[QWNewSep]@(306,40)"
		[+] // CustomWin DidYouTakeOutANewLoanAg1
			[+] // multitag "[QWNewSep]Did you take out a new loan against this account during the last statement period?"
				[ ] // "[QWNewSep]^Did you take out a new loan against this account during the last statement period?"
				[ ] // "[QWNewSep]#2"
				[ ] // "[QWNewSep]$32181"
				[ ] // "[QWNewSep]@(306,321)"
		[+] TextField ThisStatementEndsTextField
			[ ] locator "@windowid='2166'"
		[+] PushButton Next
			[ ] locator "Next"
		[+] TextField EmployeeContributionsTextField
			[ ] locator "@windowid='2190'"
		[+] TextField EmployerMatchingContributionTextField
			[ ] locator "@windowid='2191'"
		[+] TextField FederalTaxWithheldTextField
			[ ] locator "@windowid='3401'"
		[+] TextField StateTaxWithheldTextField
			[ ] locator "@windowid='3402'"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin DlgAdjustHoldingsAmount
		[ ] locator "Adjust holdings amount"
		[+] PushButton AcceptButton
			[ ] locator "Accept"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[ ] 
	[+] window MainWin DlgSecuritiesComparisonMismatch
		[ ] locator "//MainWin[@caption='Securities Comparison Mismatch']"
		[+] PushButton AcceptButton
			[ ] locator "Accept"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox DlgMessageFromTIAACREF
		[ ] locator "Important message from TIAA-CREF"
		[+] PushButton OK
			[ ] locator  "OK"
		[+] CheckBox DontShowThisMessageAgain
			[ ] locator "Don't show this message again"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Investing Registers
	[ ] 
	[+] window MainWin AssetAllocationGuide
		[ ] locator "Asset Allocation Guide"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin CapitalGainsEstimator
		[ ] locator "Capital Gains Estimator"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin SecurityDetailView
		[ ]  locator "Security Detail View*"
		[+] PushButton EditSecurityDetails
			[ ]  locator "Edit Security Details"
		[+] PushButton UpdateButton
			[ ]  locator "Update*"
		[ ] 
	[ ] 
	[+] window MainWin EditSecurityDetails
		[ ]  locator "Edit Security Details"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
			[ ] 
		[ ] 
	[ ] 
	[+] window MainWin EditPriceHistory
		[ ]  locator "Price History*"
		[+] PushButton New
			[ ] locator "New"
			[ ] 
		[+] PushButton Edit
			[ ] locator "Edit"
			[ ] 
		[+] PushButton Delete
			[ ] locator "Delete"
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox AccountComments
		[ ] locator "Account Comments*"
		[+] PushButton OK
			[ ] locator "OK"
			[ ] 
		[+] PushButton Cancel
			[ ] locator "Cancel"
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox SetWebPages
		[ ] locator "Set Web Pages"
		[ ] 
		[+] TextField HomePageTextField
			[ ] locator "@windowid='50000'"
		[+] TextField ActivityPageTextField
			[ ] locator "@windowid='50001'"
		[+] TextField ExtraPageTextField
			[ ] locator "@windowid='50002'"
		[ ] 
		[+] PushButton OK
			[ ] locator "OK"
			[ ] 
		[+] PushButton Cancel
			[ ] locator "Cancel"
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox TaxScheduleInformation
		[ ]  locator "Tax Schedule Information"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
			[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox TransactionFees
		[ ] locator "Transaction Fee*"
		[+] PushButton OK
			[ ] locator "OK"
			[ ] 
		[+] PushButton Cancel
			[ ] locator "Cancel"
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin CustomizeDialog
		[ ] locator "Customize"
		[ ] 
		[+] PushButton SelectAll
			[ ] locator "Select All"
		[+] PushButton ClearAll
			[ ] locator "Clear All"
		[+] Control QWListViewer
			[ ] locator "@windowid='402'"
			[+] ListBox AccountListBox
				[ ] locator "@windowid='1'"
				[ ] 
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[ ] 
		[ ] 
	[ ] 
	[+] window Control CalendarEnterTransaction
		[ ] locator "[@windowClassName='PopupCalendar']"
		[ ] 
	[ ] 
	[+] window DialogBox RecalculateInvTxn
		[ ] locator "Recalculate Investment Transaction"
		[ ] 
		[ ] 
		[+] RadioList RecalculateOptionRadioList
			[ ] locator "@windowid='104'"
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] PushButton OK
			[ ] locator "OK"
			[ ] 
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin BuySellPreview
		[ ]  locator "[@caption='Buy/Sell Preview']"
		[+] PushButton DoneButton
			[ ]  locator "Done"
		[ ] 
	[ ] 
	[+] window DialogBox SpecifyLotsDialog
		[ ] locator "Specify Lots Sold in this Transaction"
		[+] // StaticText AutoSelectSharesSoldWithTheseStrategies
			[ ] // locator "Auto Select shares sold with these strategies:"
		[+] PushButton AutoSelectSharesSoldWithTheseStrategiesPushButton
			[ ] locator "[@priorlabel='Auto Select shares sold with these strategies:'][5]"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton FirstSharesIn
			[ ] locator "First Shares In"
		[+] PushButton LastSharesIn
			[ ] locator "Last Shares In"
		[+] PushButton MaximumGain
			[ ] locator "Maximum Gain"
		[+] PushButton MinimumGain
			[ ] locator "Minimum Gain"
		[+] PushButton OK
			[ ] locator "OK"
		[+] // StaticText RemainingToSelect
			[ ] // locator "Remaining to select:"
		[+] PushButton ResetSelections
			[ ] locator "Reset selections"
		[+] // StaticText Sold5SharesOfYHOOAt20PerShareOn112014
			[ ] // locator "@caption='Sold 5 shares of YHOO at 20 per share on 1/1/2014'"
		[+] // Control Sold5SharesOfYHOOAt20PerShareOn112014Control
			[ ] // locator "@priorlabel='Sold 5 shares of YHOO at 20 per share on 1/1/2014'"
		[ ] 
		[+] MainWin QWListViewer
			[ ] locator "@windowid='110'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
		[+] TextField SharesToSellTextField
			[ ] locator "@windowid='148'"
			[ ] 
		[ ] 
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
			[ ] 
		[ ] 
		[+] StaticText SecurityNameText
			[ ] locator "@windowid='180'"
		[+] StaticText RemainingSharesText
			[ ] locator "@windowid='173'"
		[+] StaticText TotalSharesToSellText
			[ ] locator "@windowid='104'"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //************* Help *************************************************************
	[+] window MainWin QuickenHelp
		[ ] locator "/MainWin[@caption='Quicken Help']"
		[+] ToolBar ToolBar
			[ ] locator "//ToolBar"
		[+] PushToolItem Show
			[ ] locator "Show"
		[+] PushToolItem Hide
			[ ] locator "Hide"
		[+] PushToolItem Back
			[ ] locator "Back"
		[+] PushToolItem Home
			[ ] locator "Home"
		[+] PushToolItem Print
			[ ] locator "Print"
		[+] Control HHChild
			[ ] locator "[@windowClassName='HH Child'][1]"
		[+] BrowserWindow BrowserWindow
			[ ] locator "//BrowserWindow"
			[+] DomElement HTML
				[ ] locator "/HTML"
			[+] DomElement HEAD
				[ ] locator "//HEAD"
			[+] DomElement TITLE
				[ ] locator "//TITLE"
			[+] DomElement TextHtmlCharseti
				[ ] locator "META[@content='text/html; charset=i*']"
			[+] DomElement BODY
				[ ] locator "//BODY"
			[+] DomElement Stylesheet
				[ ] locator "LINK[@rel='stylesheet']"
			[+] DomElement x0
				[ ] locator "IMG[@border='0']"
			[+] DomTable TABLE
				[ ] locator "//TABLE"
			[+] DomElement TBODY
				[ ] locator "//TBODY"
			[+] DomTableRow TR
				[ ] locator "TR[1]"
			[+] DomElement P
				[ ] locator "//TR[1]/P"
			[+] DomLink NewToQuicken
				[ ] locator "A[@textContents='New to Quicken?']"
			[+] DomElement NewToQuickenSTRONG
				[ ] locator "STRONG[@textContents='New to Quicken?']"
			[+] DomElement BR
				[ ] locator "BR[1]"
			[+] DomTableRow TR2
				[ ] locator "TR[2]"
			[+] DomElement P2
				[ ] locator "//TR[2]/P"
			[+] DomLink Upgrading
				[ ] locator "A[@textContents='Upgrading?']"
			[+] DomElement UpgradingSTRONG
				[ ] locator "STRONG[@textContents='Upgrading?']"
			[+] DomElement BR2
				[ ] locator "BR[2]"
			[+] DomTableRow TR3
				[ ] locator "TR[3]"
			[+] DomElement P3
				[ ] locator "//TR[3]/P"
			[+] DomLink NeedHelpOnHelp
				[ ] locator "A[@textContents='Need help on Help?']"
			[+] DomElement NeedHelpOnHelpSTRONG
				[ ] locator "STRONG[@textContents='Need help on Help?']"
			[+] DomElement BR3
				[ ] locator "BR[3]"
			[+] DomElement BR4
				[ ] locator "BR[4]"
			[+] DomTableRow TR4
				[ ] locator "TR[4]"
			[+] DomLink QuickenIntuitCom
				[ ] locator "A[@textContents='quicken.intuit.com']"
			[+] DomElement TrackingMileage
				[ ] locator "P[@Text='Business > Tracking mileage']"
			[ ] ////////Added by Abhishek////////////////
			[+] DomElement WhenShouldIRebala
				[ ] locator "H1[@textContents='When should I rebala*']"
				[ ] 
			[+] DomElement WhatIfIHaveMutua
				[ ] locator "H1[@textContents='What if I have mutua*']"
				[ ] 
			[+] DomElement AssetClass
				[ ] locator "H1[@textContents='Asset class']"
				[ ] 
			[+] DomElement Current
				[ ] locator "H1[@textContents='Current %']"
				[ ] 
			[+] DomElement CurrentValue
				[ ] locator "H1[@textContents='Current Value']"
			[ ] 
		[+] Control HHSizeBar
			[ ] locator "@windowClassName='HH SizeBar'"
		[+] Control HHChild2
			[ ] locator "[@windowClassName='HH Child'][2]"
		[+] PageList TabControl
			[ ] locator "//PageList"
		[+] TreeView Tree
			[ ] locator "//TreeView"
		[+] DomTextField SearchTextField
			[ ] locator "edtSearch"
		[+] DomButton iSearchButton 
			[ ] locator "//INPUT[@id='eAsk']"
		[ ] 
	[ ] // Help > Ctrl + About Quicken
	[+] window DialogBox AboutQuicken
		[ ] locator "Quicken 201*"
		[+] StaticText QuickenVersion
			[ ] locator "Quicken 201* Rental Property Manager QA0"
		[+] Group FileInformation
			[ ] locator "File Information"
		[+] StaticText SizeOfQDFFile
			[ ] locator "Size of QDF file:"
		[+] StaticText x2622K
			[ ] locator "2622K"
		[+] StaticText Accounts
			[ ] locator "Accounts:"
		[+] StaticText Categories
			[ ] locator "Categories:"
		[+] StaticText x178
			[ ] locator "178"
		[+] StaticText MemorizedPayees
			[ ] locator "Memorized Payees*"
		[+] StaticText x2
			[ ] locator "2"
		[+] StaticText Securities
			[ ] locator "Securities*"
		[+] StaticText x5
			[ ] locator "5"
		[+] StaticText Transactions
			[ ] locator "Transactions*"
		[+] StaticText x14
			[ ] locator "14"
		[+] Group SystemResources
			[ ] locator "System Resources"
		[+] StaticText AvailableMemory
			[ ] locator "Available memory*"
		[+] StaticText x284860K
			[ ] locator "284860K"
		[+] StaticText TotalMemory
			[ ] locator "Total memory*"
		[+] StaticText x2059928K
			[ ] locator "2059928K"
		[+] MainWin OK
			[ ] locator "OK"
	[ ] // Help > Register Quicken
	[+] window MainWin QuickenRegistration
		[ ] locator "Quicken Registration"
		[+] Control QW_MDI_TOOLBAR
			[ ] locator "@windowClassName='QW_MDI_TOOLBAR'"
		[+] Control Cancel
			[ ] locator "Cancel"
		[+] Control QWBrowserContainer
			[ ] locator "@windowClassName='QWBrowserContainer'"
		[+] StaticText Label
			[ ] locator "//StaticText"
		[+] BrowserWindow BrowserWindow
			[ ] locator "//BrowserWindow"
			[+] DomElement HTML
				[ ] locator "/HTML"
			[+] DomElement HEAD
				[ ] locator "//HEAD"
			[+] DomElement TITLE
				[ ] locator "//TITLE"
			[+] DomElement GENERATOR
				[ ] locator "META[@name='GENERATOR']"
			[+] DomElement CODE_LANGUAGE
				[ ] locator "META[@name='CODE_LANGUAGE']"
			[+] DomElement Vs_defaultClientScri
				[ ] locator "META[@name='vs_defaultClientScri*']"
			[+] DomElement Vs_targetSchema
				[ ] locator "META[@name='vs_targetSchema']"
			[+] DomElement Stylesheet
				[ ] locator "LINK[@rel='stylesheet']"
			[+] DomElement CommonJs
				[ ] locator "SCRIPT[@src='../../Common.js']"
			[+] DomElement Body
				[ ] locator "BODY[@id='Body']"
			[+] DomForm Ctl00
				[ ] locator "FORM[@id='ctl00']"
			[+] DomElement DIV
				[ ] locator "DIV[1]"
			[+] DomElement __EVENTTARGET
				[ ] locator "INPUT[@id='__EVENTTARGET']"
			[+] DomElement __EVENTARGUMENT
				[ ] locator "INPUT[@id='__EVENTARGUMENT']"
			[+] DomElement __VIEWSTATE
				[ ] locator "INPUT[@id='__VIEWSTATE']"
			[+] DomElement TextJavascript
				[ ] locator "//FORM[@id='ctl00']/SCRIPT[@type='text/javascript'][1]"
			[+] DomElement RegWebResourceAxd
				[ ] locator "SCRIPT[@src='/Reg/WebResource.axd*'][1]"
			[+] DomElement Javascript
				[ ] locator "SCRIPT[@language='javascript']"
			[+] DomElement RegWebResourceAxd2
				[ ] locator "SCRIPT[@src='/Reg/WebResource.axd*'][2]"
			[+] DomElement TextJavascript4
				[ ] locator "//FORM[@id='ctl00']/SCRIPT[@type='text/javascript'][4]"
			[+] DomElement DIV2
				[ ] locator "DIV[2]"
			[+] DomElement __EVENTVALIDATION
				[ ] locator "INPUT[@id='__EVENTVALIDATION']"
			[+] DomElement HeaderImage
				[ ] locator "IMG[@id='HeaderImage']"
			[+] DomTable Table1
				[ ] locator "TABLE[@id='Table1']"
			[+] DomElement TBODY
				[ ] locator "//TABLE[@id='Table1']/TBODY"
			[+] DomTableRow TR
				[ ] locator "//TABLE[@id='Table1']//TR[1]"
			[+] DomElement TD
				[ ] locator "//TABLE[@id='Table1']//TD[1]"
			[+] DomTable Table2
				[ ] locator "TABLE[@id='Table2']"
			[+] DomElement TBODY2
				[ ] locator "//TABLE[@id='Table2']/TBODY"
			[+] DomTableRow TR2
				[ ] locator "//TABLE[@id='Table2']//TR"
			[+] DomElement RegisterQuicken
				[ ] locator "TD[@textContents='Register Quicken']"
			[+] DomElement RegisterQuickenSTRONG
				[ ] locator "STRONG[@textContents='Register Quicken']"
			[+] DomTable Table3
				[ ] locator "TABLE[@id='Table3']"
			[+] DomElement TBODY3
				[ ] locator "//TABLE[@id='Table3']/TBODY"
			[+] DomTableRow TR1
				[ ] locator "//TABLE[@id='Table3']//TR[1]"
			[+] DomElement TD1
				[ ] locator "//TABLE[@id='Table3']//TD[1]"
			[+] DomElement TD2
				[ ] locator "//TABLE[@id='Table3']//TD[2]"
			[+] DomElement CustomerInfoFieldGro
				[ ] locator "SPAN[@id='CustomerInfoFieldGro*'][1]"
			[+] DomTable x0
				[ ] locator "TABLE[@cellPadding='0'][1]"
			[+] DomElement TBODY4
				[ ] locator "TBODY[4]"
			[+] DomTableRow TR3
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[1]"
			[+] DomElement TD3
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[1]/TD[1]"
			[+] DomElement CustomerInfoFieldGro2
				[ ] locator "SPAN[@id='CustomerInfoFieldGro*'][2]"
			[+] DomTable x02
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][2]/TABLE[@border='0']"
			[+] DomElement TBODY5
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][2]//TBODY"
			[+] DomTableRow Left
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][2]//TR[@align='left']"
			[+] DomElement LeftTD
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][2]//TD[@align='left']"
			[+] DomElement SPAN
				[ ] locator "SPAN[@textContents='?'][1]"
			[+] DomElement FirstName
				[ ] locator "SPAN[@textContents='First Name:']"
			[+] DomTextField x64
				[ ] locator "INPUT[@maxLength='64'][1]"
			[+] DomElement x2
				[ ] locator "TD[@colSpan='2'][1]"
			[+] DomElement CustomerInfoFieldGro3
				[ ] locator "//TD[@colSpan='2'][1]/SPAN[@id='CustomerInfoFieldGro*']"
			[+] DomElement TBODY6
				[ ] locator "//TD[@colSpan='2'][1]/SPAN[@id='CustomerInfoFieldGro*']//TBODY"
			[+] DomElement LastName
				[ ] locator "SPAN[@textContents='Last Name:']"
			[+] DomElement Top
				[ ] locator "//TD[@colSpan='2'][1]/SPAN[@id='CustomerInfoFieldGro*']//TD[@vAlign='top'][2]"
			[+] DomTextField x642
				[ ] locator "INPUT[@maxLength='64'][2]"
			[+] DomTableRow TR4
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[4]"
			[+] DomElement x3
				[ ] locator "TD[@colSpan='3'][1]"
			[+] DomElement CustomerInfoFieldGro4
				[ ] locator "//TD[@colSpan='3'][1]/SPAN[@id='CustomerInfoFieldGro*']"
			[+] DomElement TBODY7
				[ ] locator "//TD[@colSpan='3'][1]/SPAN[@id='CustomerInfoFieldGro*']//TBODY"
			[+] DomElement Address
				[ ] locator "SPAN[@textContents='Address:']"
			[+] DomElement Top2
				[ ] locator "//TD[@colSpan='3'][1]/SPAN[@id='CustomerInfoFieldGro*']//TD[@vAlign='top'][2]"
			[+] DomTextField x643
				[ ] locator "INPUT[@maxLength='64'][3]"
			[+] DomTableRow TR6
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[6]"
			[+] DomElement x32
				[ ] locator "TD[@colSpan='3'][2]"
			[+] DomElement CustomerInfoFieldGro5
				[ ] locator "//TD[@colSpan='3'][2]/SPAN[@id='CustomerInfoFieldGro*']"
			[+] DomElement TBODY8
				[ ] locator "//TD[@colSpan='3'][2]/SPAN[@id='CustomerInfoFieldGro*']//TBODY"
			[+] DomElement SPAN2
				[ ] locator "//TD[@colSpan='3'][2]/SPAN[@id='CustomerInfoFieldGro*']//SPAN"
			[+] DomElement Top3
				[ ] locator "//TD[@colSpan='3'][2]/SPAN[@id='CustomerInfoFieldGro*']//TD[@vAlign='top'][2]"
			[+] DomTextField x60
				[ ] locator "INPUT[@maxLength='60']"
			[+] DomTableRow TR8
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[8]"
			[+] DomElement TD4
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[8]/TD[1]"
			[+] DomElement CustomerInfoFieldGro6
				[ ] locator "SPAN[@id='CustomerInfoFieldGro*'][6]"
			[+] DomTable x03
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][6]/TABLE[@border='0']"
			[+] DomElement TBODY9
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][6]//TBODY"
			[+] DomTableRow Left2
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][6]//TR[@align='left']"
			[+] DomElement LeftTD2
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][6]//TD[@align='left']"
			[+] DomElement SPAN4
				[ ] locator "SPAN[@textContents='?'][4]"
			[+] DomElement City
				[ ] locator "SPAN[@textContents='City:']"
			[+] DomTextField x644
				[ ] locator "INPUT[@maxLength='64'][4]"
			[+] DomElement LeftTD7
				[ ] locator "TD[@align='left'][7]"
			[+] DomElement CustomerInfoFieldGro7
				[ ] locator "SPAN[@id='CustomerInfoFieldGro*'][7]"
			[+] DomTable x04
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][7]/TABLE[@border='0']"
			[+] DomElement TBODY10
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][7]//TBODY"
			[+] DomTableRow Left3
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][7]//TR[@align='left']"
			[+] DomElement LeftTD3
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][7]//TD[@align='left']"
			[+] DomElement SPAN5
				[ ] locator "SPAN[@textContents='â¢'][5]"
			[+] DomElement State
				[ ] locator "SPAN[@textContents='State:']"
			[+] DomListBox CustomerInfoFieldGroSELECT
				[ ] locator "SELECT[@id='CustomerInfoFieldGro*']"
			[+] DomElement Select
				[ ] locator "OPTION[@textContents='--Select--']"
			[+] DomElement AK
				[ ] locator "OPTION[@textContents='AK']"
			[+] DomElement AL
				[ ] locator "OPTION[@textContents='AL']"
			[+] DomElement AR
				[ ] locator "OPTION[@textContents='AR']"
			[+] DomElement AS
				[ ] locator "OPTION[@textContents='AS']"
			[+] DomElement AZ
				[ ] locator "OPTION[@textContents='AZ']"
			[+] DomElement CA
				[ ] locator "OPTION[@textContents='CA']"
			[+] DomElement CO
				[ ] locator "OPTION[@textContents='CO']"
			[+] DomElement CT
				[ ] locator "OPTION[@textContents='CT']"
			[+] DomElement DC
				[ ] locator "OPTION[@textContents='DC']"
			[+] DomElement DE
				[ ] locator "OPTION[@textContents='DE']"
			[+] DomElement FL
				[ ] locator "OPTION[@textContents='FL']"
			[+] DomElement FM
				[ ] locator "OPTION[@textContents='FM']"
			[+] DomElement GA
				[ ] locator "OPTION[@textContents='GA']"
			[+] DomElement GU
				[ ] locator "OPTION[@textContents='GU']"
			[+] DomElement HI
				[ ] locator "OPTION[@textContents='HI']"
			[+] DomElement IA
				[ ] locator "OPTION[@textContents='IA']"
			[+] DomElement ID
				[ ] locator "OPTION[@textContents='ID']"
			[+] DomElement IL
				[ ] locator "OPTION[@textContents='IL']"
			[+] DomElement IN
				[ ] locator "OPTION[@textContents='IN']"
			[+] DomElement KS
				[ ] locator "OPTION[@textContents='KS']"
			[+] DomElement KY
				[ ] locator "OPTION[@textContents='KY']"
			[+] DomElement LA
				[ ] locator "OPTION[@textContents='LA']"
			[+] DomElement MA
				[ ] locator "OPTION[@textContents='MA']"
			[+] DomElement MD
				[ ] locator "OPTION[@textContents='MD']"
			[+] DomElement ME
				[ ] locator "OPTION[@textContents='ME']"
			[+] DomElement MH
				[ ] locator "OPTION[@textContents='MH']"
			[+] DomElement MI
				[ ] locator "OPTION[@textContents='MI']"
			[+] DomElement MN
				[ ] locator "OPTION[@textContents='MN']"
			[+] DomElement MO
				[ ] locator "OPTION[@textContents='MO']"
			[+] DomElement MP
				[ ] locator "OPTION[@textContents='MP']"
			[+] DomElement MS
				[ ] locator "OPTION[@textContents='MS']"
			[+] DomElement MT
				[ ] locator "OPTION[@textContents='MT']"
			[+] DomElement NC
				[ ] locator "OPTION[@textContents='NC']"
			[+] DomElement ND
				[ ] locator "OPTION[@textContents='ND']"
			[+] DomElement NE
				[ ] locator "OPTION[@textContents='NE']"
			[+] DomElement NH
				[ ] locator "OPTION[@textContents='NH']"
			[+] DomElement NJ
				[ ] locator "OPTION[@textContents='NJ']"
			[+] DomElement NM
				[ ] locator "OPTION[@textContents='NM']"
			[+] DomElement NV
				[ ] locator "OPTION[@textContents='NV']"
			[+] DomElement NY
				[ ] locator "OPTION[@textContents='NY']"
			[+] DomElement OH
				[ ] locator "OPTION[@textContents='OH']"
			[+] DomElement OK
				[ ] locator "OPTION[@textContents='OK']"
			[+] DomElement OR
				[ ] locator "OPTION[@textContents='OR']"
			[+] DomElement PA
				[ ] locator "OPTION[@textContents='PA']"
			[+] DomElement PR
				[ ] locator "OPTION[@textContents='PR']"
			[+] DomElement PW
				[ ] locator "OPTION[@textContents='PW']"
			[+] DomElement RI
				[ ] locator "OPTION[@textContents='RI']"
			[+] DomElement SC
				[ ] locator "OPTION[@textContents='SC']"
			[+] DomElement SD
				[ ] locator "OPTION[@textContents='SD']"
			[+] DomElement TN
				[ ] locator "OPTION[@textContents='TN']"
			[+] DomElement TX
				[ ] locator "OPTION[@textContents='TX']"
			[+] DomElement UT
				[ ] locator "OPTION[@textContents='UT']"
			[+] DomElement VA
				[ ] locator "OPTION[@textContents='VA']"
			[+] DomElement VI
				[ ] locator "OPTION[@textContents='VI']"
			[+] DomElement VT
				[ ] locator "OPTION[@textContents='VT']"
			[+] DomElement WA
				[ ] locator "OPTION[@textContents='WA']"
			[+] DomElement WI
				[ ] locator "OPTION[@textContents='WI']"
			[+] DomElement WV
				[ ] locator "OPTION[@textContents='WV']"
			[+] DomElement WY
				[ ] locator "OPTION[@textContents='WY']"
			[+] DomElement LeftTD9
				[ ] locator "TD[@align='left'][9]"
			[+] DomElement CustomerInfoFieldGro8
				[ ] locator "SPAN[@id='CustomerInfoFieldGro*'][8]"
			[+] DomTable x05
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][8]/TABLE[@border='0']"
			[+] DomElement TBODY11
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][8]//TBODY"
			[+] DomTableRow Left4
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][8]//TR[@align='left']"
			[+] DomElement LeftTD4
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][8]//TD[@align='left']"
			[+] DomElement SPAN6
				[ ] locator "SPAN[@textContents='?'][6]"
			[+] DomElement Zip
				[ ] locator "SPAN[@textContents='Zip:']"
			[+] DomTextField x10
				[ ] locator "INPUT[@maxLength='10']"
			[+] DomTableRow TR12
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[12]"
			[+] DomElement x33
				[ ] locator "TD[@colSpan='3'][3]"
			[+] DomElement CustomerInfoFieldGro9
				[ ] locator "//TD[@colSpan='3'][3]/SPAN[@id='CustomerInfoFieldGro*']"
			[+] DomElement TBODY12
				[ ] locator "//TD[@colSpan='3'][3]/SPAN[@id='CustomerInfoFieldGro*']//TBODY"
			[+] DomElement EMailAddress
				[ ] locator "SPAN[@textContents='E-mail Address:']"
			[+] DomElement Top4
				[ ] locator "//TD[@colSpan='3'][3]/SPAN[@id='CustomerInfoFieldGro*']//TD[@vAlign='top'][2]"
			[+] DomTextField x255
				[ ] locator "INPUT[@maxLength='255'][1]"
			[+] DomTableRow TR14
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[14]"
			[+] DomElement x34
				[ ] locator "TD[@colSpan='3'][4]"
			[+] DomElement CustomerInfoFieldGro10
				[ ] locator "//TD[@colSpan='3'][4]/SPAN[@id='CustomerInfoFieldGro*']"
			[+] DomElement TBODY13
				[ ] locator "//TD[@colSpan='3'][4]/SPAN[@id='CustomerInfoFieldGro*']//TBODY"
			[+] DomElement ReEnterEmailAddre
				[ ] locator "SPAN[@textContents='Re-enter Email Addre*']"
			[+] DomElement Top5
				[ ] locator "//TD[@colSpan='3'][4]/SPAN[@id='CustomerInfoFieldGro*']//TD[@vAlign='top'][2]"
			[+] DomTextField x2552
				[ ] locator "INPUT[@maxLength='255'][2]"
			[+] DomTableRow TR16
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[16]"
			[+] DomElement TD5
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[16]/TD[1]"
			[+] DomElement CustomerInfoFieldGro11
				[ ] locator "SPAN[@id='CustomerInfoFieldGro*'][11]"
			[+] DomTable x06
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][11]/TABLE[@border='0']"
			[+] DomElement TBODY14
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][11]//TBODY"
			[+] DomTableRow Left5
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][11]//TR[@align='left']"
			[+] DomElement LeftTD5
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][11]//TD[@align='left']"
			[+] DomElement DayPhone
				[ ] locator "SPAN[@textContents='Day Phone:']"
			[+] DomElement SPAN1
				[ ] locator "SPAN[@textContents='.'][1]"
			[+] DomTextField x32INPUT
				[ ] locator "INPUT[@maxLength='32'][1]"
			[+] DomElement x22
				[ ] locator "TD[@colSpan='2'][2]"
			[+] DomElement CustomerInfoFieldGro12
				[ ] locator "//TD[@colSpan='2'][2]/SPAN[@id='CustomerInfoFieldGro*']"
			[+] DomElement TBODY15
				[ ] locator "//TD[@colSpan='2'][2]/SPAN[@id='CustomerInfoFieldGro*']//TBODY"
			[+] DomElement Ext
				[ ] locator "SPAN[@textContents='Ext:'][1]"
			[+] DomElement Top6
				[ ] locator "//TD[@colSpan='2'][2]/SPAN[@id='CustomerInfoFieldGro*']//TD[@vAlign='top'][2]"
			[+] DomTextField x16
				[ ] locator "INPUT[@maxLength='16'][1]"
			[+] DomTableRow TR19
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[19]"
			[+] DomElement TD6
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[19]/TD[1]"
			[+] DomElement CustomerInfoFieldGro13
				[ ] locator "SPAN[@id='CustomerInfoFieldGro*'][13]"
			[+] DomTable x07
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][13]/TABLE[@border='0']"
			[+] DomElement TBODY16
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][13]//TBODY"
			[+] DomTableRow Left6
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][13]//TR[@align='left']"
			[+] DomElement LeftTD6
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][13]//TD[@align='left']"
			[+] DomElement EveningPhone
				[ ] locator "SPAN[@textContents='Evening Phone:']"
			[+] DomElement SPAN3
				[ ] locator "SPAN[@textContents='.'][2]"
			[+] DomTextField x32INPUT2
				[ ] locator "INPUT[@maxLength='32'][2]"
			[+] DomElement x23
				[ ] locator "TD[@colSpan='2'][3]"
			[+] DomElement CustomerInfoFieldGro14
				[ ] locator "//TD[@colSpan='2'][3]/SPAN[@id='CustomerInfoFieldGro*']"
			[+] DomElement TBODY17
				[ ] locator "//TD[@colSpan='2'][3]/SPAN[@id='CustomerInfoFieldGro*']//TBODY"
			[+] DomElement Ext2
				[ ] locator "SPAN[@textContents='Ext:'][2]"
			[+] DomElement Top7
				[ ] locator "//TD[@colSpan='2'][3]/SPAN[@id='CustomerInfoFieldGro*']//TD[@vAlign='top'][2]"
			[+] DomTextField x162
				[ ] locator "INPUT[@maxLength='16'][2]"
			[+] DomTableRow TR22
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[22]"
			[+] DomElement x35
				[ ] locator "TD[@colSpan='3'][5]"
			[+] DomElement CustomerInfoFieldGro15
				[ ] locator "//TD[@colSpan='3'][5]/SPAN[@id='CustomerInfoFieldGro*']"
			[+] DomElement TBODY18
				[ ] locator "//TD[@colSpan='3'][5]/SPAN[@id='CustomerInfoFieldGro*']//TBODY"
			[+] DomElement Company
				[ ] locator "SPAN[@textContents='Company:']"
			[+] DomElement SPAN7
				[ ] locator "SPAN[@textContents='.'][3]"
			[+] DomElement Top8
				[ ] locator "//TD[@colSpan='3'][5]/SPAN[@id='CustomerInfoFieldGro*']//TD[@vAlign='top'][2]"
			[+] DomTextField x645
				[ ] locator "INPUT[@maxLength='64'][5]"
			[+] DomTableRow TR24
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[24]"
			[+] DomElement x36
				[ ] locator "TD[@colSpan='3'][6]"
			[+] DomElement IfYouUseQuicken
				[ ] locator "DIV[@textContents='(If you use Quicken *']"
			[+] DomTableRow TR25
				[ ] locator "//SPAN[@id='CustomerInfoFieldGro*'][1]//TR[25]"
			[+] DomElement x37
				[ ] locator "TD[@colSpan='3'][7]"
			[+] DomTable Table5
				[ ] locator "TABLE[@id='Table5']"
			[+] DomElement TBODY19
				[ ] locator "//TABLE[@id='Table5']/TBODY"
			[+] DomTableRow TR5
				[ ] locator "//TABLE[@id='Table5']//TR"
			[+] DomElement WeAppreciateYouri
				[ ] locator "TD[@textContents='We appreciate your i*']"
			[+] DomElement WeAppreciateYouriSTRONG
				[ ] locator "STRONG[@textContents='We appreciate your i*']"
			[+] DomTable Table6
				[ ] locator "TABLE[@id='Table6']"
			[+] DomElement TBODY20
				[ ] locator "//TABLE[@id='Table6']/TBODY"
			[+] DomTableRow TR7
				[ ] locator "//TABLE[@id='Table6']//TR[1]"
			[+] DomElement TD7
				[ ] locator "//TABLE[@id='Table6']//TD[1]"
			[+] DomElement TD8
				[ ] locator "//TABLE[@id='Table6']//TD[2]"
			[+] DomElement MainSurveyFieldGroup
				[ ] locator "SPAN[@id='MainSurveyFieldGroup*'][1]"
			[+] DomTable x4
				[ ] locator "TABLE[@cellSpacing='4']"
			[+] DomElement TBODY1
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TBODY[1]"
			[+] DomTableRow TR9
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TR[1]"
			[+] DomElement TD9
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TR[1]/TD[1]"
			[+] DomElement TD10
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TR[1]/TD[2]"
			[+] DomElement MainSurveyFieldGroup2
				[ ] locator "SPAN[@id='MainSurveyFieldGroup*'][2]"
			[+] DomTable x08
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][2]/TABLE[@border='0']"
			[+] DomElement TBODY21
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][2]//TBODY"
			[+] DomTableRow Left7
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][2]//TR[@align='left']"
			[+] DomElement LeftTD8
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][2]//TD[@align='left']"
			[+] DomElement SPAN8
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][2]//SPAN[@textContents='?']"
			[+] DomElement WhereDidYouBuyTh
				[ ] locator "SPAN[@textContents='Where did you buy th*']"
			[+] DomListBox MainSurveyFieldGroupSELECT
				[ ] locator "SELECT[@id='MainSurveyFieldGroup*']"
			[+] DomElement SelectOne
				[ ] locator "OPTION[@textContents='--Select one--']"
			[+] DomElement DirectlyFromIntuit
				[ ] locator "OPTION[@textContents='Directly from Intuit']"
			[+] DomElement Costco
				[ ] locator "OPTION[@textContents='Costco']"
			[+] DomElement Walmart
				[ ] locator "OPTION[@textContents='Walmart']"
			[+] DomElement Staples
				[ ] locator "OPTION[@textContents='Staples']"
			[+] DomElement BestBuy
				[ ] locator "OPTION[@textContents='Best Buy']"
			[+] DomElement Sams
				[ ] locator "OPTION[@textContents='Sams']"
			[+] DomElement OfficeMax
				[ ] locator "OPTION[@textContents='Office Max']"
			[+] DomElement OfficeDepot
				[ ] locator "OPTION[@textContents='Office Depot']"
			[+] DomElement Target
				[ ] locator "OPTION[@textContents='Target']"
			[+] DomElement AmazonCom
				[ ] locator "OPTION[@textContents='Amazon.com']"
			[+] DomElement Other
				[ ] locator "OPTION[@textContents='Other']"
			[+] DomTableRow TR10
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TR[3]"
			[+] DomElement TD11
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TR[3]/TD[1]"
			[+] DomElement TD12
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TR[3]/TD[2]"
			[+] DomElement MainSurveyFieldGroup3
				[ ] locator "SPAN[@id='MainSurveyFieldGroup*'][3]"
			[+] DomTable x09
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][3]/TABLE[@border='0']"
			[+] DomElement TBODY22
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][3]//TBODY[1]"
			[+] DomTableRow Left8
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][3]//TR[@align='left']"
			[+] DomElement LeftTD10
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][3]//TD[@align='left']"
			[+] DomElement PriorToPurchasing
				[ ] locator "SPAN[@textContents='Prior to purchasing *']"
			[+] DomTable MainSurveyFieldGroupTABLE
				[ ] locator "TABLE[@id='MainSurveyFieldGroup*'][1]"
			[+] DomElement TBODY23
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]/TBODY"
			[+] DomTableRow TR11
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[1]"
			[+] DomElement TD13
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[1]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[1]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement QuickenSoftwareIns
				[ ] locator "LABEL[@textContents='Quicken software ins*']"
			[+] DomTableRow TR13
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[2]"
			[+] DomElement TD14
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[2]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT2
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[2]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement QuickenOnline
				[ ] locator "LABEL[@textContents='Quicken Online']"
			[+] DomTableRow TR15
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[3]"
			[+] DomElement TD15
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[3]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT3
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[3]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement OnlineBankingServi
				[ ] locator "LABEL[@textContents='Online banking servi*']"
			[+] DomTableRow TR17
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[4]"
			[+] DomElement TD16
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[4]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT4
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[4]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement SpreadsheetSuchAs
				[ ] locator "LABEL[@textContents='Spreadsheet (such as*']"
			[+] DomTableRow TR18
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[5]"
			[+] DomElement TD17
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[5]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT5
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[5]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement PaperStatementsFro
				[ ] locator "LABEL[@textContents='Paper statements fro*']"
			[+] DomTableRow TR20
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[6]"
			[+] DomElement TD18
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[6]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT6
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[6]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement MicrosoftMoney
				[ ] locator "LABEL[@textContents='Microsoft Money']"
			[+] DomTableRow TR21
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[7]"
			[+] DomElement TD19
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[7]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT7
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[7]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement MintCom
				[ ] locator "LABEL[@textContents='Mint.com']"
			[+] DomTableRow TR23
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[8]"
			[+] DomElement TD20
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[8]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT8
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[8]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement OtherSoftware
				[ ] locator "LABEL[@textContents='Other software']"
			[+] DomTableRow TR26
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[9]"
			[+] DomElement TD21
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[9]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT9
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][1]//TR[9]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement WasNotUsingAnyMe
				[ ] locator "LABEL[@textContents='Was not using any me*']"
			[+] DomTableRow TR27
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TR[14]"
			[+] DomElement TD22
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TR[14]/TD[1]"
			[+] DomElement TD23
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][1]//TR[14]/TD[2]"
			[+] DomElement MainSurveyFieldGroup4
				[ ] locator "SPAN[@id='MainSurveyFieldGroup*'][4]"
			[+] DomTable x010
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][4]/TABLE[@border='0']"
			[+] DomElement TBODY24
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][4]//TBODY[1]"
			[+] DomTableRow Left9
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][4]//TR[@align='left']"
			[+] DomElement LeftTD11
				[ ] locator "//SPAN[@id='MainSurveyFieldGroup*'][4]//TD[@align='left']"
			[+] DomElement WhichOfTheFollowi
				[ ] locator "SPAN[@textContents='Which of the followi*']"
			[+] DomTable MainSurveyFieldGroupTABLE2
				[ ] locator "TABLE[@id='MainSurveyFieldGroup*'][2]"
			[+] DomElement TBODY25
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]/TBODY"
			[+] DomTableRow TR28
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]//TR[1]"
			[+] DomElement TD24
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]//TR[1]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT10
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]//TR[1]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement TrackingPersonalFi
				[ ] locator "LABEL[@textContents='Tracking personal fi*']"
			[+] DomTableRow TR29
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]//TR[2]"
			[+] DomElement TD25
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]//TR[2]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT11
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]//TR[2]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement TrackingBusinessFi
				[ ] locator "LABEL[@textContents='Tracking business fi*']"
			[+] DomTableRow TR30
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]//TR[3]"
			[+] DomElement TD26
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]//TR[3]/TD"
			[+] DomCheckBox MainSurveyFieldGroupINPUT12
				[ ] locator "//TABLE[@id='MainSurveyFieldGroup*'][2]//TR[3]/TD/INPUT[@id='MainSurveyFieldGroup*']"
			[+] DomElement TrackingRentalProp
				[ ] locator "LABEL[@textContents='Tracking rental prop*']"
			[+] DomTable Table7
				[ ] locator "TABLE[@id='Table7']"
			[+] DomElement TBODY26
				[ ] locator "//TABLE[@id='Table7']/TBODY"
			[+] DomTableRow TR31
				[ ] locator "//TABLE[@id='Table7']//TR"
			[+] DomElement TD27
				[ ] locator "//TABLE[@id='Table7']//TD"
			[+] DomElement TheInformationYou
				[ ] locator "P[@textContents='The information you *']"
			[+] DomLink PrivacyStatement
				[ ] locator "A[@textContents='Privacy Statement']"
			[+] DomLink ContactYouLinkButton
				[ ] locator "A[@id='ContactYouLinkButton']"
			[+] DomTable Table10
				[ ] locator "TABLE[@id='Table10']"
			[+] DomElement TBODY27
				[ ] locator "//TABLE[@id='Table10']/TBODY"
			[+] DomTableRow TR32
				[ ] locator "//TABLE[@id='Table10']//TR"
			[+] DomElement Center
				[ ] locator "TD[@align='center']"
			[+] DomButton RegisterButton
				[ ] locator "INPUT[@id='RegisterButton']"
			[+] DomButton WindowCloser
				[ ] locator "INPUT[@id='WindowCloser']"
			[+] DomElement TextJavascript5
				[ ] locator "//FORM[@id='ctl00']/SCRIPT[@type='text/javascript'][5]"
			[+] DomElement TextJavascript6
				[ ] locator "//FORM[@id='ctl00']/SCRIPT[@type='text/javascript'][6]"
			[+] DomElement TextJavascript7
				[ ] locator "//FORM[@id='ctl00']/SCRIPT[@type='text/javascript'][7]"
			[+] DomElement Regstatus
				[ ] locator "INPUT[@id='regstatus']"
		[+] Control QnetStatusBarWindow
			[ ] locator "@windowClassName='QnetStatusBarWindow'"
		[+] Control Done
			[ ] locator "Done"
		[+] Control StatusPaneClass
			[ ] locator "[@windowClassName='StatusPaneClass'][2]"
		[+] Control StatusPaneClass3
			[ ] locator "[@windowClassName='StatusPaneClass'][3]"
		[+] Control StatusPaneClass4
			[ ] locator "[@windowClassName='StatusPaneClass'][4]"
	[ ] // Product Registration
	[+] window DialogBox ProductRegistration
		[ ] locator "/DialogBox[@caption='Product Registration']"
		[+] Control QWIconDisplay
			[ ] locator "@windowClassName='QWIconDisplay'"
		[+] Control WelcomeToQuicken2014
			[ ] locator "Welcome to Quicken 201?!"
		[+] StaticText WhetherYouAreNewToQuickenOrUpg
			[ ] locator "Whether you are new to Quicken or upgrading from a previous version, please register your software so you can:"
		[+] StaticText DownloadTransactionsFromYourBankingCreditCardAnd
			[ ] locator "- Download transactions from your banking, credit card, and"
		[+] StaticText InvestmentAccounts
			[ ] locator "  investment accounts."
		[+] StaticText DownloadFreeOnlineStockQuotes
			[ ] locator "- Download free online stock quotes."
		[+] StaticText ReceiveFreeOnlineSoftwareUpdatesIncludingUpdatesFor
			[ ] locator "- Receive free online software updates, including updates for"
		[+] StaticText NewTaxLaws
			[ ] locator "  new tax laws."
		[+] StaticText NoteRequiresInternetAccessFeat
			[ ] locator "Note: Requires Internet access. Features and service options subject to change."
		[+] MainWin RegisterNow
			[ ] locator "Register Now"
		[+] MainWin xWindow
			[ ] locator "[2]"
		[+] MainWin RegisterLater
			[ ] locator "Register Later"
	[ ] // Help > About Quicken
	[+] window Control PopUpCalloutHolder
		[ ] locator "//Control[@caption='Callout Holder']"
		[+] Control CalloutPopup
			[ ] locator "//Control[@windowClassName='INTU_CalloutPopup']"
			[+] Control Close
				[ ] locator "//Control[@caption='close']"
			[+] PushButton Go
				[ ] locator "@windowid='1007'"
			[+] PushButton NotNow
				[ ] //locator "//PushButton[@caption='Not Now']"
				[ ] locator "@windowid='1005'"
			[+] CheckBox DontRemindMe
				[ ] locator "@windowid='1006'"
			[ ] 
			[ ] 
			[ ] 
	[ ] // Help > Log Files
	[+] window MainWin QuickenLogFiles
		[ ] locator "//MainWin[@caption='Quicken Log Files']"
		[+] Control QW_MDI_TOOLBAR
			[ ] locator "@windowClassName='QW_MDI_TOOLBAR'"
		[+] Control QWBrowserContainer
			[ ] locator "@windowClassName='QWBrowserContainer'"
		[+] StaticText Label
			[ ] locator "//StaticText"
		[+] BrowserWindow BrowserWindow
			[ ] locator "//BrowserWindow"
			[+] DomElement HTML
				[ ] locator "/HTML"
			[+] DomElement HEAD
				[ ] locator "//HEAD"
			[+] DomElement TITLE
				[ ] locator "//TITLE"
			[+] DomElement TextCss
				[ ] locator "STYLE[@type='text/css']"
			[+] DomElement BODY
				[ ] locator "//BODY"
			[+] DomElement QuickenLogFiles
				[ ] locator "H1[@textContents='Quicken Log Files']"
			[+] DomElement DIV
				[ ] locator "DIV[1]"
			[+] DomElement QuickenSupportMay
				[ ] locator "P[@textContents='Quicken Support may *']"
			[+] DomElement ConnectionTroublesh
				[ ] locator "DIV[@textContents='Connection Troublesh*']"
			[+] DomElement DIV3
				[ ] locator "DIV[3]"
			[+] DomLink OFXLog
				[ ] locator "A[@textContents='OFX Log']"
			[+] DomElement DIV4
				[ ] locator "DIV[4]"
			[+] DomLink CloudSyncLog
				[ ] locator "A[@textContents='Cloud Sync Log']"
			[+] DomElement DIV5
				[ ] locator "DIV[5]"
			[+] DomLink ConnectionLogCONN
				[ ] locator "A[@textContents='Connection Log [CONN*']"
			[+] DomElement DIV6
				[ ] locator "DIV[6]"
			[+] DomLink ConnectionLogOld
				[ ] locator "A[@textContents='Connection Log (old)*']"
			[+] DomElement FileTroubleshooting
				[ ] locator "DIV[@textContents='File Troubleshooting*']"
			[+] DomElement DIV8
				[ ] locator "DIV[8]"
			[+] DomLink QXFFileImportRes
				[ ] locator "A[@textContents='.QXF File Import Res*']"
			[+] DomElement DIV9
				[ ] locator "DIV[9]"
			[+] DomLink MicrosoftMoneyFil
				[ ] locator "A[@textContents='Microsoft Money: Fil*']"
			[+] DomElement InstallationLogs
				[ ] locator "DIV[@textContents='Installation Logs:']"
			[+] DomElement DIV11
				[ ] locator "DIV[11]"
			[+] DomLink MSILog
				[ ] locator "A[@textContents='MSI Log']"
			[+] DomElement DIV12
				[ ] locator "DIV[12]"
			[+] DomLink SetupLog
				[ ] locator "A[@textContents='Setup Log']"
			[+] DomElement DIV13
				[ ] locator "DIV[13]"
			[+] DomLink BCLog
				[ ] locator "A[@textContents='BC Log']"
			[+] DomElement DIV14
				[ ] locator "DIV[14]"
			[+] DomLink UpdateLog
				[ ] locator "A[@textContents='Update log']"
	[ ] // Help > Log Files > Cloud Sync Log
	[+] window Control MDICalloutHolder
		[ ] locator "Callout Holder"
		[+] Control CalloutPopup
			[ ] locator "@windowid='12345'"
			[+] PushButton Tag
				[ ] locator "Tag"
			[+] PushButton Notes
				[ ] locator "Notes"
			[+] PushButton Done
				[ ] locator "Done"
			[+] PushButton ShowReport             //Added By Dean Paes on 2nd May 2013
				[ ] locator "Show Report"
			[ ] 
			[ ] 
	[ ] 
	[+] window DialogBox ViewCloudSyncLog
		[ ] locator "View Cloud Sync Log"
		[+] PushButton SaveAs
			[ ] locator "Save As*"
		[+] PushButton Close
			[ ] locator "Close"
			[ ] 
		[ ] 
	[+] window DialogBox SaveAsDialog
		[ ] locator "Save As"
		[+] PushButton Save
			[ ] locator "Save"
		[+] TextField FileName
			[ ] locator "File name*"
	[ ] // Help > Log Files > Cloud Sync Log
	[+] window DialogBox FreeUpdatetoQuickenisAvailable
		[ ] locator "//DialogBox[@caption='Free Update to Quicken is Available!']" 
		[+] PushButton UpdateLater
			[ ] locator "@windowid = '32766'"
	[ ] 
	[ ] 
	[ ] //Added by Shrivardhan
	[+] window DialogBox ViewOFXLog
		[ ] locator "View OFX Log"
		[+] PushButton SaveAs
			[ ] locator "Save As*"
		[+] PushButton Close
			[ ] locator "Close"
			[ ] 
		[ ] 
	[ ] 
[ ] 
[+] //************* Tips & Tutorials ****************************************************
	[ ] 
	[+] window ChildWin TipsTutorials
		[ ] locator "Tips * Tutorials"
		[+] Control Panel
			[ ] // locator "[QWPanel]Panel"
			[+] Control QWMsHtmlVw1
				[ ] 
				[+] Control ShellEmbedding1
					[ ] 
					[+] Control ShellDocObjectView1
						[ ] locator  "[Shell DocObject View]#1"
						[+] Control InternetExplorer_Server1
							[ ] locator "[Internet Explorer_Server]#1"
	[ ] 
	[ ] 
[ ] 
[+] //************* Category & Tag *****************************************************
	[ ] 
	[ ] //-----------------Category-------------------
	[+] window MainWin SetUpCategory
		[ ] locator "Set Up Category"
		[+] StaticText CategoryNameText
			[ ] locator "Category Name:"
		[+] TextField CategoryName
			[ ] locator "@windowid='100'"
		[+] RadioList CategoryType
			[ ] locator "Income"
		[+] // RadioList Expense
			[ ] // locator "Expense"
		[+] // RadioList SubcategoryOf
			[ ] // locator "Subcategory of:"
		[+] ComboBox SubCategoryName
			[ ] locator "Category Name:"
		[+] CheckBox TaxRelatedCategory
			[ ] locator "Tax related category"
		[+] RadioList StandardLineItemList
			[ ] locator "Standard line item list"
		[+] RadioList ExtendedLineItemList
			[ ] locator "Extended line item list"
		[+] StaticText TaxLineItemForThisCategory
			[ ] locator "Tax line item for this category"
		[+] ComboBox TaxLineItemForThisCategoryComboBox
			[ ] locator "Tax line item for this category"
		[+] StaticText TaxLineItemDescription
			[ ] locator "Tax Line Item Description:"
		[+] TextField TaxLineItemDescriptionTextField
			[ ] locator "Tax Line Item Description:"
		[+] StaticText DescriptionText
			[ ] locator "Description:"
		[+] StaticText Optional
			[ ] locator "(optional)"
		[+] TextField Description
			[ ] locator "@windowid='101'"
		[+] StaticText SetUpCategory
			[ ] locator "Set Up Category"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] 
	[+] // window MainWin CategoryList
		[ ] // locator "//MainWin[@caption='Category List']"
		[+] // StaticText Show
			[ ] // locator "Show"
		[+] // ComboBox ShowComboBox
			[ ] // locator "Show"
		[+] // MainWin AddCategory
			[ ] // locator "Add Category"
		[+] // MainWin xWindow
			[ ] // locator "[2]"
		[+] // Control ShowControl
			[ ] // locator "[@priorlabel='Show'][2]"
		[+] // Control Options
			[ ] // locator "&Options"
		[+] // CheckBox ShowHiddenCategories
			[ ] // locator "Show hidden categories"
		[+] // MainWin Done
			[ ] // locator "Done"
		[+] // Control Panel
			[ ] // locator "Panel"
		[+] // Control QWIconDisplay
			[ ] // locator "@windowClassName='QWIconDisplay'"
		[+] // TextField ShowTextField
			[ ] // locator "Show"
		[+] // Control QWinChild
			[ ] // locator "@windowClassName='QWinChild'"
		[+] // Control BusinessIncome
			[ ] // locator "Business Income"
		[+] // Control BusinessExpenses
			[ ] // locator "Business Expenses"
		[+] // Control PersonalIncome
			[ ] // locator "Personal Income"
		[+] // Control PersonalExpenses
			[ ] // locator "Personal Expenses"
		[+] // Control Investment
			[ ] // locator "Investment"
		[+] // Control RentalPropertyIncome
			[ ] // locator "Rental Property Income"
		[+] // Control RentalPropertyExpenses
			[ ] // locator "Rental Property Expenses"
		[+] // Control Transfers
			[ ] // locator "Transfers"
		[+] // Control AllCategories
			[ ] // locator "All Categories"
		[+] // Control Title
			[ ] // locator "Title"
		[+] // Control QWinLightbox
			[ ] // locator "@windowClassName='QWinLightbox'"
	[ ] 
	[+] window DialogBox DeleteCategory
		[ ] locator "Delete Category"
		[+] Control QWIconDisplay
			[ ] locator "@windowClassName='QWIconDisplay'"
		[+] StaticText YouAreAboutToPermanentlyDeleteTheCategory
			[ ] locator "You are about to permanently delete the category:"
		[+] StaticText CreditCardPayment
			[ ] locator "Credit Card Payment"
		[+] StaticText ItIsCurrentlyUnused
			[ ] locator "It is currently unused."
		[+] StaticText IfThereAreSubcategoriesAssocia
			[ ] locator "If there are subcategories associated with this category, the subcategories will be deleted as well."
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] MainWin xWindow
			[ ] locator "[2]"
	[ ] 
	[+] window DialogBox NewCategory
		[ ] locator "New Category"
		[+] StaticText DoYouWantToCreateANewCat
			[ ] locator "Do you want to create a new category with the name"
		[+] PushButton Yes
			[ ] locator "Yes"
		[+] PushButton No
			[ ] locator "No"
		[+] CheckBox PromptBeforeCreatingNewCat
			[ ] locator "Prompt before creating new categories"
		[ ] 
		[ ] 
	[ ] 
	[ ] //-----------------Tag--------------------------
	[ ] 
	[+] window DialogBox NewTag
		[ ] locator "New Tag"
		[+] TextField NameTextField
			[ ] locator "[1]"
		[+] TextField DescriptionTextField
			[ ] locator "Description"
		[+] TextField CopyNumberTextField
			[ ] locator "Copy number"
		[+] PushButton TellMeMore
			[ ] locator "Tell me more"
		[+] PushButton CopyNumberPushButton
			[ ] locator "[@priorlabel='Copy number'][2]"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[ ] 
	[+] window MainWin TagListWindow
		[ ] locator "//MainWin[@caption='Tag List']"
		[+] PushButton TagList
			[ ] locator "[@priorlabel='Tag List'][1]"
		[+] PushButton TagList2
			[ ] locator "[@priorlabel='Tag List'][2]"
		[+] PushButton New
			[ ] locator "New"
		[+] PushButton Done
			[ ] locator "Done"
		[+] Control QWinChild
			[ ] locator "@windowClassName='QWinChild'"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] Control Title
			[ ] locator "Title"
		[+] StaticText TagListLabel
			[ ] locator "Tag List"
	[ ] 
	[ ] // New tag dialog box need to be added in SplitTransaction window
	[+] window Control AccountQuickFillIncome
		[ ] locator "//Control[@windowClassName='QWQuickfillHolder']"
		[+] Control QWinChild
			[ ] locator "//Control[@windowClassName='QWinChild']"
			[+] PushButton PersonalBankingButton
				[ ] locator "Personal Banking"
				[ ] 
			[+] PushButton AllAccountsButton
				[ ] locator "All Accounts"
				[ ] 
			[+] ListBox ListBox
				[ ] locator "//ListBox"
			[ ] 
			[ ] 
		[ ] 
	[+] window Control AccountQuickFillBill
		[ ] locator "//Control[@windowClassName='QWQuickfillHolder'][2]"
		[+] Control QWinChild
			[ ] locator "//Control[@windowClassName='QWinChild']"
			[+] PushButton PersonalBankingButton
				[ ] locator "Personal Banking"
				[ ] 
			[+] PushButton AllAccountsButton
				[ ] locator "All Accounts"
				[ ] 
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] CheckBox ShowHiddenAccountsCheckBox
			[ ] locator "[@caption='Show hidden accounts']"
			[ ] 
			[ ] 
		[ ] 
	[+] window Control AccountQuickFillTransfer
		[ ] locator "//Control[@windowClassName='QWQuickfillHolder'][3]"
		[+] Control QWinChild
			[ ] locator "//Control[@windowClassName='QWinChild']"
			[+] PushButton PersonalBankingButton
				[ ] locator "Personal Banking"
				[ ] 
			[+] PushButton AllAccountsButton
				[ ] locator "All Accounts"
				[ ] 
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] CheckBox ShowHiddenAccountsCheckBox
			[ ] locator "[@caption='Show hidden accounts']"
			[ ] 
			[ ] 
		[ ] 
	[+] window Control AccountQuickFill
		[ ] locator "//Control[@windowClassName='QWQuickfillHolder']"
		[+] Control QWinChild
			[ ] locator "//Control[@windowClassName='QWinChild']"
			[+] PushButton PersonalBankingButton
				[ ] locator "Personal Banking"
				[ ] 
			[+] PushButton AllAccountsButton
				[ ] locator "All Accounts"
				[ ] 
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] CheckBox ShowHiddenAccountsCheckBox
			[ ] locator "[@caption='Show hidden accounts']"
			[ ] 
			[ ] 
		[ ] 
	[ ] 
	[ ] ///Assign Category Groups
	[+] window DialogBox DlgAssignCategoryGroups
		[ ] locator "Assign Category Groups"
		[+] ComboBox CategoriesinComboBox
			[ ] locator "Categories in: "
		[+] ListBox AvailableCategoriesListBox
			[ ] locator "//ListBox"
		[+] ListBox AddedCategoriesListBox
			[ ] locator "//ListBox[2]"
		[+] PushButton AddButton
			[ ] locator "Add ->"
		[+] PushButton RemoveButton
			[ ] locator "<- Remove"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] PushButton AddRenameCustomGroupsButton
			[ ] locator "Add*Custom Groups"
		[+] ComboBox CustomCategoryGroupComboBox
			[ ] locator "2. Assign it to a custom category group"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] ///Custom Category Groups
	[ ] 
	[+] window DialogBox DlgCustomCategoryGroups
		[ ] locator "Custom Category Groups"
		[+] PushButton NewButton
			[ ] locator "New..."
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] PushButton DeleteButton
			[ ] locator "Delete"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] ///Create Custom Group
	[+] window MainWin DlgCreateCategoryGroup
		[ ] locator "Create Custom Group"
		[+] PushButton NewButton
			[ ] locator "New..."
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] TextField GroupNameTextField
			[ ] locator "Group Name:"
		[+] PushButton OKButton
			[ ] locator "OK"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //************* Planning **********************************************************
	[ ] 
	[+] // window Control Planning
		[ ] // locator "/Control[@caption='Quicken 201*']//Control[@windowClassName='QWMDI']" 
		[ ] // // locator "Planning"
		[+] // Control PlanningSubTab
			[ ] // //locator "@windowid='-1'"
			[ ] // locator "[@windowClassName='QWSnapHolder']"
			[+] // StaticText SpendingPlanner
				[ ] // locator "@windowid='-1'"
				[+] // StaticText CategorizedSpending 
					[ ] // locator "@windowid='-1'"
					[+] // Control MonthlySpendingSavingPlan
						[ ] // locator "@windowid='0'"
						[+] // MainWin QWListViewer1
							[ ] // locator "@windowid='2400'"
							[+] // ListBox ListBox1
								[ ] // locator "@windowid='1'"
				[+] // StaticText ShowSpending 
					[ ] // locator "@windowid='-1'"
					[+] // Control ShowSpendingReport
						[ ] // locator "@windowid='2410'"
				[ ] // 
			[+] // StaticText TaxCenter
				[ ] // // locator "@windowid='-1'"
				[+] // StaticText TaxRelatedExpensesYTD
					[ ] // // locator "@windowid='-1'"
					[+] // PushButton AssignTaxCategories
						[ ] // locator "@windowid='503'"
				[+] // MainWin QWListViewer
					[ ] // locator "@windowid='1'"
					[+] // ListBox ListBox
						[ ] // locator "@windowid='1'"
					[ ] // 
				[+] // StaticText StaticText1
					[ ] // locator "@windowid='31000'"
				[ ] // 
				[+] // Control TaxRelatedExpensesYTDPane
					[ ] // locator "@windowid='-1'"
			[+] // StaticText TaxableIncomeStaticText
				[ ] // // locator "@windowid='-1'"
				[+] // MainWin QWListViewer
					[ ] // locator "@windowid='1'"
					[+] // ListBox ListBox
						[ ] // locator "@windowid='1'"
				[+] // Control TaxRelatedIncomeYTDPane
					[ ] // locator "@windowid='-1'"
				[+] // StaticText TaxableIncomeYTD
					[ ] // // locator "@windowid='-1'"
					[+] // PushButton AddPayCheck
						[ ] // locator "@windowid='503'"
				[ ] // 
			[+] // Control Panel
				[ ] // //locator "@windowid='-1'"
				[ ] // locator "[@windowClassName='QWPanel']"
				[ ] // 
				[+] // Control SetupScreenHolder
					[ ] // locator "Savings Goals"
					[+] // Control Panel1
						[ ] // //locator "@windowid='-1'"
						[ ] // locator "[@windowClassName='QWPanel']"
						[ ] // 
						[+] // StaticText IdentifyYourDebtsText
							[ ] // locator "@windowid='10001'"
						[+] // PushButton SavingGoal
							[ ] // locator "@windowid='125'"
						[+] // StaticText GoalAmount
							[ ] // locator "@windowid='135'"
						[+] // StaticText FinishDate
							[ ] // locator "@windowid='137'"
						[+] // PushButton DeleteIcon
							[ ] // locator "@windowid='140'"
						[+] // PushButton ContributeButton
							[ ] // locator "@windowid='127'"
						[ ] // 
				[ ] // 
				[+] // PushButton GoalActions
					[ ] // locator "@windowid='139'"
				[+] // Control SavingsGoals
					[ ] // locator "@windowid='0'"
					[+] // Control Panel
						[ ] // locator "[@windowClassName='QWPanel']"
						[ ] // // locator "@windowid='-1'"
						[+] // PushButton QC_button2
							[ ] // locator "@windowid='140'"
						[+] // PushButton SmokeSavingGoal
							[ ] // locator "@windowid='125'"
						[+] // PushButton QC_button3
							[ ] // locator "@windowid='126'"
						[+] // PushButton Contribute
							[ ] // locator "@windowid='127'"
						[+] // PushButton QC_button5
							[ ] // locator "@windowid='128'"
						[+] // PushButton Withdraw
							[ ] // locator "@windowid='129'"
						[+] // PushButton By01Jan2013
							[ ] // locator "@windowid='130'"
						[+] // PushButton EditGoal
							[ ] // locator "@windowid='131'"
						[+] // StaticText StaticText2
							[ ] // locator "@windowid='138'"
						[+] // StaticText N2000Text
							[ ] // locator "@windowid='135'"
						[+] // StaticText By01Jan2013Text
							[ ] // locator "@windowid='137'"
						[+] // StaticText MonthlyContributionToMeetG
							[ ] // locator "@windowid='136'"
						[+] // MainWin QWGoalViewer1
							[ ] // locator "@windowid='132'"
					[ ] // 
					[ ] // 
				[ ] // 
				[+] // // PushButton GoalActions
					[ ] // // locator "@windowid='139'"
				[+] // // Control SavingsGoals
					[ ] // // locator "@windowid='0'"
					[+] // // Control Panel
						[ ] // // locator "[@windowClassName='QWPanel']"
						[ ] // // // locator "@windowid='-1'"
						[+] // // PushButton QC_button2
							[ ] // // locator "@windowid='140'"
						[+] // // PushButton SmokeSavingGoal
							[ ] // // locator "@windowid='125'"
						[+] // // PushButton QC_button3
							[ ] // // locator "@windowid='126'"
						[+] // // PushButton Contribute
							[ ] // // locator "@windowid='127'"
						[+] // // PushButton QC_button5
							[ ] // // locator "@windowid='128'"
						[+] // // PushButton Withdraw
							[ ] // // locator "@windowid='129'"
						[+] // // PushButton By01Jan2013
							[ ] // // locator "@windowid='130'"
						[+] // // PushButton EditGoal
							[ ] // // locator "@windowid='131'"
						[+] // // StaticText StaticText2
							[ ] // // locator "@windowid='138'"
						[+] // // StaticText N2000Text
							[ ] // // locator "@windowid='135'"
						[+] // // StaticText By01Jan2013Text
							[ ] // // locator "@windowid='137'"
						[+] // // StaticText MonthlyContributionToMeetG
							[ ] // // locator "@windowid='136'"
						[+] // // MainWin QWGoalViewer1
							[ ] // // locator "@windowid='132'"
					[ ] // 
				[+] // StaticText YourSavingsGoalsText
					[ ] // locator "@windowid='134'"
				[+] // Control QWMsHtmlVw1
					[ ] // locator "@windowid='$1000'"
					[+] // Control ShellEmbedding1
						[ ] // locator "@windowid='$0'"
						[+] // Control ShellDocObjectView1
							[ ] // locator "@windowid='$0'"
							[+] // Control InternetExplorer_Server1
								[ ] // locator "@windowid='$0'"
				[ ] // 
				[ ] // 
		[ ] // 
		[+] // PushButton ChangeAssumptions
			[ ] // locator "Change Assumptions"
			[ ] // // locator "//PushButton[@windowid='2202']"
		[ ] // 
		[+] // CustomWin DebtReduction   	
			[ ] // locator "@windowid='-1'"					
			[+] // Control Panel
				[ ] // locator "@windowid='-1'"
				[+] // Control SetupScreenHolder	
					[ ] // locator "@windowid='0'"						
					[+] // Control SetupScreen
						[ ] // locator "@windowid='0'"
						[+] // StaticText IdentifyTheDebtsYouWantTo
							[ ] // locator "@windowid='1031'"
						[+] // StaticText ListedBelowAreTheDebtsYou
							[ ] // locator "@windowid='1350'"
						[+] // StaticText BeingCompleteIsImportantI
							[ ] // locator "@windowid='1351'"
						[+] // StaticText ACCOUNTSTOINCLUDEINTHISPL
							[ ] // locator "@windowid='1022'"
						[+] // StaticText BALANCEText
							[ ] // locator "@windowid='1023'"
						[+] // MainWin BALANCE1
							[ ] // locator "@windowid='1011'"
							[+] // ListBox ListBox1
								[ ] // locator "@windowid='1'"
						[+] // MainWin BALANCE2
							[ ] // locator "@windowid='1012'"
							[+] // ListBox ListBox1
								[ ] // locator "@windowid='1'"
						[+] // StaticText TotalInPlanText
							[ ] // locator "@windowid='1024'"
						[+] // StaticText N10000Text
							[ ] // locator "@windowid='1025'"
						[+] // StaticText TipBeSureToIncludeAllCr
							[ ] // locator "@windowid='1352'"
					[+] // Control Panel1
						[ ] // locator "@windowid='-1'"
					[+] // Control Panel2
						[ ] // locator "@windowid='-1'"
						[+] // PushButton QC_button1
							[ ] // locator "@windowid='32765'"
						[+] // PushButton NEXT
							[ ] // locator "@windowid='32767'"
				[ ] // 
			[+] // StaticText TaxableIncomeStaticText					//Added by Anagha 02/04/2013
				[+] // multitag "#4"
					[ ] // "$-1[4]"
				[+] // CustomWin QWListViewer
					[+] // multitag "[QWListViewer]"
						[ ] // "#1"
						[ ] // "$1"
					[+] // ListBox ListBox
						[ ] // locator "@windowid='1'"
				[+] // Control TaxRelatedIncomeYTDPane
					[ ] // locator "@windowid='-1'"
		[ ] 
		[+] // PushButton ChangeAssumptions
			[ ] // locator "Change Assumptions"
			[ ] // // locator "//PushButton[@windowid='2202']"
		[ ] 
	[+] window Control Planning
		[ ] locator "/Control[@caption='Quicken 201*']//Control[@windowClassName='QWMDI']" 
		[+] Control PlanningSubTab
			[ ] locator "@windowid='-1'"
			[+] StaticText SpendingPlanner
				[ ] locator "@windowid='-1'"
				[+] StaticText CategorizedSpending 
					[ ] locator "@windowid='-1'"
					[+] Control MonthlySpendingSavingPlan
						[ ] locator "@windowid='0'"
						[+] MainWin QWListViewer1
							[ ] locator "@windowid='2400'"
							[+] ListBox ListBox1
								[ ] locator "@windowid='1'"
				[+] StaticText ShowSpending 
					[ ] locator "@windowid='-1'"
					[+] Control ShowSpendingReport
						[ ] locator "@windowid='2410'"
				[ ] 
			[+] StaticText TaxCenter
				[ ] // locator "@windowid='-1'"
				[+] StaticText TaxRelatedExpensesYTD
					[ ] // locator "@windowid='-1'"
					[+] PushButton AssignTaxCategories
						[ ] locator "@windowid='503'"
				[+] MainWin QWListViewer
					[ ] locator "@windowid='1'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
					[ ] 
				[+] StaticText StaticText1
					[ ] locator "@windowid='31000'"
				[ ] 
				[+] Control TaxRelatedExpensesYTDPane
					[ ] locator "@windowid='-1'"
				[ ] 
			[+] Control Panel
				[ ] locator "@windowid='-1'"
				[+] Control SetupScreenHolder
					[ ] locator "Savings Goals"
					[+] Control Panel1
						[ ] locator "@windowid='-1'"
						[+] StaticText IdentifyYourDebtsText
							[ ] locator "@windowid='10001'"
						[+] PushButton SavingGoal
							[ ] locator "@windowid='125'"
						[+] StaticText GoalAmount
							[ ] locator "@windowid='135'"
						[+] StaticText FinishDate
							[ ] locator "@windowid='137'"
						[+] PushButton DeleteIcon
							[ ] locator "@windowid='140'"
						[+] PushButton ContributeButton
							[ ] locator "@windowid='127'"
						[+] PushButton WithdrawButton
							[ ] locator "@windowid='129'"
						[+] Control GoalBar
							[ ] locator "@windowid='132'"
						[ ] 
				[ ] 
				[+] PushButton GoalActions
					[ ] locator "@windowid='139'"
				[+] Control SavingsGoals
					[ ] locator "Savings Goals"
					[ ] // locator "@windowid='0'"
					[+] Control Panel
						[ ] locator "@windowid='-1'"
						[+] PushButton QC_button2
							[ ] locator "@windowid='140'"
						[+] PushButton SmokeSavingGoal
							[ ] locator "@windowid='125'"
						[+] PushButton QC_button3
							[ ] locator "@windowid='126'"
						[+] PushButton Contribute
							[ ] locator "@windowid='127'"
						[+] PushButton QC_button5
							[ ] locator "@windowid='128'"
						[+] PushButton Withdraw
							[ ] locator "@windowid='129'"
						[+] PushButton By01Jan2013
							[ ] locator "@windowid='130'"
						[+] PushButton EditGoal
							[ ] locator "Edit goal"
							[ ] // locator "@windowid='131'"
						[+] StaticText StaticText2
							[ ] locator "@windowid='138'"
						[+] StaticText N2000Text
							[ ] locator "@windowid='135'"
						[+] StaticText By01Jan2013Text
							[ ] locator "@windowid='137'"
						[+] StaticText MonthlyContributionToMeetG
							[ ] locator "@windowid='136'"
						[+] MainWin QWGoalViewer1
							[ ] locator "@windowid='132'"
				[+] StaticText YourSavingsGoalsText
					[ ] locator "@windowid='134'"
				[ ] 
		[ ] 
		[+] PushButton ChangeAssumptions
			[ ] locator "Change Assumptions"
			[ ] // locator "//PushButton[@windowid='2202']"
		[ ] 
	[ ] 
	[+] window Control GetStarted
		[ ] //locator"//BrowserWindow[1]//IMG[@id='Img1']"
		[ ] locator"//BrowserWindow//IMG[@id='Img1']"
	[+] window Control GetStartedBrowserWindow
		[ ] locator "/Control[@caption='Quicken 201*']//BrowserWindow"
		[+] DomElement GetStarted
			[ ] locator "IMG[@id='Img1']"
	[ ] 
	[ ] 
	[+] window Control Budget
		[ ] locator "*Budget*"
		[+] Control Panel  ///will be removed after confirmation Mukesh July 1 ,2013
			[ ] locator "Control[@windowClassName='QWPanel']"
			[+] Control TotalSpending 				// Added by Udita on 11 May 2012
				[ ] locator "@windowid='1867'"
		[+] MainWin ListViewer					
			[ ] locator "@windowid='1400'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
				[+] TextField Amount
					[ ] locator "@windowid='2076'"
		[+] PushButton BudgetActions				
			[ ] locator "Budget &Actions"
		[+] PushButton AddCategoryToBudget
			[ ] locator "Select Categories to Budget"
		[ ] 
    
		[ ] 
	[ ] 
	[ ] // Planning > Tax Planner
	[+] window MainWin TaxPlanner
		[ ] locator "//MainWin[@caption='Tax Planner']"
		[+] Control QW_MDI_TOOLBAR1
			[ ] locator "@windowid='12000'"
		[+] Control QWBrowserContainer1
			[ ] locator "@windowid='-1'"
			[+] StaticText StaticText1
				[ ] locator "@windowid='-1'"
				[+] Control CapitalGains
					[ ] locator "//BrowserWindow[@caption='Quicken Tax Planner']"
					[ ] 
				[+] // Control ShellEmbedding1
					[+] // locator "[Shell Embedding]#1"
						[ ] // "$0"
					[+] // Control ShellDocObjectView1
						[+] // locator "[Shell DocObject View]#1"
							[ ] // "$0"
						[+] // Control InternetExplorer_Server1
							[+] // locator "[Internet Explorer_Server]#1"
								[ ] // "$0"
							[+] // Control ATL0602B1801
								[+] // locator "[ATL:0602B180]#1"
									[ ] // "$229353072"
								[+] // StaticText StaticText1
									[+] // locator "#1"
										[ ] // "$-1"
									[+] // DialogBox DialogBox1
										[+] // locator "#1"
											[ ] // "$1"
										[+] // TextField RegularTax1
											[+] // locator "Regular Tax[1]"
												[ ] // "$4001"
							[+] // Control ATL04B0B1801
								[+] // locator "[ATL:04B0B180]#1"
									[ ] // "$140966400"
								[+] // StaticText StaticText1
									[+] // locator "#1"
										[ ] // "$-1"
									[+] // DialogBox DialogBox1
										[+] // locator "#1"
											[ ] // "$1"
										[+] // Control ShortTermGainsAndLosses
											[+] // locator "[QTLink]Short-Term Gains and Losses"
												[ ] // "$503"
										[+] // TextField RegularTax1
											[+] // locator "Regular Tax[1]"
												[ ] // "$4001"
							[+] // Control ATL048CB1801
								[+] // locator "$31606544"
									[ ] // "[ATL:048CB180]"
									[ ] // "#1"
								[+] // StaticText StaticText1
									[+] // locator "#1"
										[ ] // "$-1"
									[+] // DialogBox DialogBox1
										[+] // locator "#1"
											[ ] // "$1"
										[+] // TextField RegularTax1
											[+] // locator "Regular Tax[1]"
												[ ] // "$4001"
		[ ] 
	[ ]                                                   //Whether this is used anywhere///
	[ ] // Planning > Budget 
	[+] // window DialogBox SelectCategoriesToBudget
		[ ] // locator "Select Categories to Budget"
		[ ] // parent MonthlySpendingGoals
		[+] // CustomWin OK
			[+] // multitag "[QC_button]OK"
				[ ] // "[QC_button]$32767"
		[+] // CustomWin Cancel
			[+] // multitag "[QC_button]Cancel"
				[ ] // "[QC_button]$32766"
		[+] // CustomWin ChooseTheCategories
			[+] // multitag "[QWinChild]Choose the categories you want to budget.??You can add or remove categories from your budget at any time."
				[ ] // "[QWinChild]$0"
			[+] // CustomWin BusinessIncome
				[+] // multitag "[QC_button]Business Income"
					[ ] // "[QC_button]$1003"
			[+] // CustomWin BusinessExpenses
				[+] // multitag "[QC_button]Business Expenses"
					[ ] // "[QC_button]$1004"
			[+] // CustomWin PersonalIncome
				[+] // multitag "[QC_button]Personal Income"
					[ ] // "[QC_button]$1005"
			[+] // CustomWin PersonalExpenses
				[+] // multitag "[QC_button]Personal Expenses"
					[ ] // "[QC_button]$1006"
			[+] // CustomWin RentalIncome
				[+] // multitag "[QC_button]Rental Income"
					[ ] // "[QC_button]$1011"
			[+] // CustomWin RentalExpenses
				[+] // multitag "[QC_button]Rental Expenses"
					[ ] // "[QC_button]$1012"
			[+] // CustomWin Transfers
				[+] // multitag "[QC_button]Transfers"
					[ ] // "[QC_button]$1008"
			[+] // CustomWin QC_button8
				[ ] // tag "[QC_button]$1013"
			[+] // CheckBox ShowHiddenCategories
				[+] // multitag "Show hidden categories"
					[ ] // "$1010"
			[+] // CustomWin QWListViewer
				[ ] // tag "[QWListViewer]$1001"
				[+] // ListBox ListBox
					[ ] // tag "$1"
	[+] window MainWin SelectCategoriesToBudget
		[ ] locator "Select Categories to Budget"
		[+] StaticText SelectCategoriesToBudgetTex
			[ ] locator "@windowid='32702'"
		[+] PushButton SelectCategoriesToBudget1
			[ ] locator "@windowid='9000'"
		[+] StaticText ChooseTheCategoriesYouWant1
			[ ] locator "@windowid='9002'"
		[+] PushButton SelectCategoriesToBudget2
			[ ] locator "@windowid='32765'"
		[+] CheckBox ShowHiddenCategories
			[ ] locator "@windowid='9010'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control ChooseTheCategories
			[ ] locator "@windowClassName='QWinChild'"
			[+] Control Panel
				[ ] locator "@windowid='-1'"
				[+] Control QWinChild1
					[ ] locator "@windowClassName='QWinChild'"
					[+] Control Panel1 
						[ ] locator "@windowClassName='QWPanel'"
						[+] PushButton BusinessExpenses 
							[ ] locator "Business Expenses"
					[+] Control Panel2
						[+] PushButton BusinessIncome
							[ ] locator "Business Income"
					[+] Control Panel3
						[+] PushButton PersonalExpenses
							[ ] locator "Personal Expenses"
					[+] Control Panel4
						[+] PushButton PersonalIncome
							[ ] locator "Personal Income"
					[+] Control Panel5
						[+] PushButton RentalPropertyExpenses
							[ ] locator "Rental Property Expenses"
					[+] Control Panel6
						[+] PushButton RentalPropertyIncome
							[ ] locator "Rental Property Income"
					[+] Control Panel7
						[+] PushButton TransfersIn
							[ ] locator "Transfers In"
					[+] Control Panel8
						[+] PushButton TransfersOut
							[ ] locator "Transfers Out"
					[+] Control Panel9
						[+] PushButton AllCategories
							[ ] locator "All Categories"
					[+] Control Panel10
						[ ] locator "@windowid='-1[10]'"
					[ ] 
			[+] MainWin QWListViewer
				[ ] locator "@windowid='1001'"
				[+] ListBox ListBox
					[ ] locator "@windowid='1'"
		[+] PushButton AllCategories
			[ ] locator "All Categories"
		[+] PushButton BusinessExpenses
			[ ] locator "Business Expenses"
			[ ] 
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[ ] 
	[ ] 
	[ ] // Planning > Savings Goal
	[+] window DialogBox AddEditSavingsGoal	
		[ ] locator "*Savings Goal"                        						// Updated by Udita on 13 Feb 2013					
		[+] StaticText CreateNewSavingsGoalText
			[ ] locator "Create New Savings Goal"     
		[+] StaticText GoalNameText
			[ ] locator "Goal Name:"
		[+] TextField GoalName
			[ ] locator "Goal Name:"
		[+] StaticText GoalAmountText
			[ ] locator "Goal Amount:"
		[+] TextField GoalAmount
			[ ] locator "Goal Amount:"
		[+] StaticText FinishDateText
			[ ] locator "Finish Date:"
		[+] TextField FinishDate
			[ ] locator "Finish Date:"
		[+] PushButton FinishDate2
			[ ] locator "Finish Date:"          
		[+] PushButton OK
			[ ] locator "OK"          
		[+] PushButton Cancel
			[ ] locator "Cancel"          
	[+] window DialogBox DeleteSavingsGoal
		[ ] locator "Delete Savings Goal"     						 	     	
		[+] StaticText DeleteSavingsGoalText
			[ ] locator "Delete Savings Goal"     		
		[+] StaticText DeletingASavingsGoalWillR
			[ ] locator "Deleting a Savings Goal will return all funds to their source accounts."		
		[+] RadioList AfterThatWhatShouldQuicke2
			[ ] locator "@windowid='110'"
		[+] RadioList AfterThatWhatShouldQuicke4
			[ ] locator "@windowid='109'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton AfterThatWhatShouldQuicke3
			[ ] locator "@windowid='32765'"
	[+] window DialogBox AddABudgetCategory  ///will be removed after confirmation Mukesh July 1 ,2013  
		[ ] locator "Add a budget category"
		[+] StaticText AddABudgetCategoryText
			[ ] locator "@windowid='32702'"
		[+] PushButton AddABudgetCategory
			[ ] locator "@windowid='32765'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton AdvancedSetup
			[ ] locator "@windowid='9104'"
		[+] PushButton Next
			[ ] locator "@windowid='9108'"
		[+] PushButton Back
			[ ] locator "@windowid='9106'"
		[+] PushButton Done
			[ ] locator"@windowid='32767'"
		[+] Control Panel
			[ ] locator "@windowid='-1'"
			[+] Control QWinChild
				[ ] locator "@windowid='0'"
				[+] StaticText SelectACategoryToBudgetTe
					[ ] locator "@windowid='9122'"
				[+] Control SelectACategoryToBudget1
					[ ] locator "@windowid='9110'"
				[+] TextField SelectACategoryToBudget
					[ ] locator "@windowid='9124'"
				[+] Control QFBag1
					[ ] locator "@windowid='2020'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='1124'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='1128'"
				[+] TextField Amount
					[ ] locator "@windowid='9148'"
				[+] ComboBox IPlanToSpendAbout
					[ ] locator "@windowid='9152'"
				[ ] 
				[ ] 
	[+] window DialogBox DlgContributeToGoal
		[ ] locator "Contribute To Goal*"
		[+] StaticText ContributeToGoalText
			[ ] locator "@windowid='32702'"
		[+] StaticText FromAccountText
			[ ] locator "@windowid='112'"
		[+] ComboBox FromAccountPopupList
			[ ] locator "@windowid='111'"
		[+] StaticText DateText
			[ ] locator "@windowid='106'"
		[+] TextField DateTextField
			[ ] locator "@windowid='105'"
		[+] StaticText AmountText
			[ ] locator "@windowid='113'"
		[+] TextField AmountTextField
			[ ] locator "@windowid='103'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[+] window DialogBox DlgWithdrawFromGoal						//Added Jayashree Nagaraja 19/5/2014
		[ ] locator "Withdrawal from:*"
		[+] StaticText WithdrawFromGoalText
			[ ] locator "@windowid='32702'"
		[+] StaticText TotalSavedForThisGoal
			[ ] locator "@windowid='117'"
		[+] StaticText TotalSavedAmount
			[ ] locator "@windowid='118'"
		[+] StaticText PutFundsBack
			[ ] locator "@windowid='112'"
		[+] ComboBox WithdrawalAccount
			[ ] locator "@windowid='111'"
		[+] StaticText Amount
			[ ] locator "@windowid='104'"
		[+] TextField AmountToWithdraw
			[ ] locator "@windowid='103'"
		[+] StaticText DateofWithdrawal
			[ ] locator "@windowid='106'"
		[+] TextField WithdrawalDate
			[ ] locator "@windowid='105'"
		[+] StaticText TotalContributed
			[ ] locator "@windowid='114'"
		[+] StaticText AmountAvailableToMoveBack
			[ ] locator "@windowid='115'"
		[+] PushButton OKButton
			[ ] locator "@windowid='1'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[ ] 
    
	[ ] 
	[+] window MainWin CreateANewBudget
		[ ] locator "Create a New Budget"
		[+] StaticText CreateANewBudgetText
			[ ] locator "@windowid='32702'"
		[+] StaticText BudgetNameText
			[ ] locator "@windowid='9202'"
		[+] TextField BudgetName
			[ ] locator "@windowid='9204'"
		[+] RadioList BudgetName2
			[ ] locator "@windowid='9212'"
		[+] StaticText QuickenScansYourTransaction
			[ ] locator "Quicken scans your transactions and creates a budget for your top five spending categories."
		[+] StaticText QuickenCreatesABudgetBased
			[ ] locator "@windowid='9218'"
		[+] PushButton CreateANewBudget2
			[ ] locator "@windowid='32765'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] RadioList UseDifferentCalendarRadioList
			[ ] locator "@windowid='9256'"
		[+] ComboBox CalendarComboBox
			[ ] locator "@windowid='9260'"
		[+] PushButton AdvanceBudgetSettingsButton
			[ ] locator "@windowid='32758'"
	[ ] 
	[+] window DialogBox DlgEditBudgetName
		[ ] locator "Edit Budget Name"
		[+] TextField EditBudgetNameTextField
			[ ] locator "Budget Name"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[ ] 
	[+] window DialogBox DlgDuplicateBudget
		[ ] locator "Duplicate Budget"
		[+] TextField BudgetNameTextField
			[ ] locator "Budget Name"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[+] window MainWin DlgBudgetPreferences
		[ ] locator "Budget Preferences"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] CheckBox FirstCheckBox
			[ ] locator "Don't include savings account to savings account transfers"
		[+] CheckBox SecondCheckBox
			[ ] locator "Don't include savings account to savings goal transfers"
		[+] Control TransferswhichareignoredwillText
			[ ] locator "Transfers which are ignored will"
		[+] Control  NotbeincludedinyourbudgetText
			[ ] locator " not be included in your budget."
		[+] Control  ThesePreferencesApplyToAllBudgetsText
			[ ] locator "These preferences apply to all budgets."
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // Planning > Savings Goal>SavingGoal Register
	[+] window MainWin DlgSavingGoalRegister
		[ ] locator "@caption='*Goal*'"
		[ ] //locator "SavingGoal"
	[ ] 
	[ ] //Planning >Happy New (Budget) Year///
	[+] window MainWin DlgBudgetMessageBox
		[ ] locator "Happy New (Budget) Year!"
		[+] PushButton OKButton
			[ ] locator "OK"
			[ ] // locator "@windowid='32767'"
	[ ] 
	[ ] //Planning > Tax Planner > Capital Gains > Get value of "Short Term Gains and Losses"
	[+] window FileDlg QuickenPatchWindow
		[ ] tag "Quicken 201*"
	[+] window CustomWin  WindowsForm1
		[ ] tag "[WindowsForms10.Window.8.app.0.*]#1"
		[ ] parent QuickenPatchWindow
	[+] window CustomWin  WindowsForm2
		[ ] tag "[WindowsForms10.Window.8.app.0.*]#2"
		[ ] parent WindowsForm1
	[+] window FileDlg IntermediateDialogbox
		[ ] tag "Quicken 201*"
		[ ] parent WindowsForm2
	[+] window FileDlg DlgTaxPlanner
		[ ] tag "Tax Planner"
		[ ] parent IntermediateDialogbox
		[+] CustomWin QW_MDI_TOOLBAR1
			[ ] tag "[QW_MDI_TOOLBAR]$12000"
		[+] CustomWin QWBrowserContainer1
			[+] multitag "[QWBrowserContainer]#1"
				[ ] "$-1"
			[+] StaticText StaticText1
				[+] multitag "#1"
					[ ] "$-1"
				[+] CustomWin ShellEmbedding1
					[+] multitag "[Shell Embedding]#1"
						[ ] "$0"
					[+] CustomWin ShellDocObjectView1
						[+] multitag "[Shell DocObject View]#1"
							[ ] "$0"
						[+] CustomWin InternetExplorer_Server1
							[+] multitag "[Internet Explorer_Server]#1"
								[ ] "$0"
							[+] CustomWin ATL0602B1801
								[ ] multitag "[ATL:*]#1"
								[+] StaticText StaticText1
									[+] multitag "#1"
										[ ] "$-1"
									[+] FileDlg DialogBox1
										[+] multitag "#1"
											[ ] "$1"
										[+] TextField RegularTax1
											[+] multitag "Regular Tax[1]"
												[ ] "$4001"
		[ ] 
	[ ] 
	[ ] 
	[ ] // Planning > UpdatePlanningAssumptions > SavingsInvestments
	[+] window MainWin PlannerSavingsInvestments
		[ ] locator "Quicken Planner: Savings and Investments"
		[+] StaticText N1Text
			[ ] locator "@windowid='145'"
		[+] MainWin SelectTheBankAccountsThat2
			[ ] locator "@windowid='101'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] MainWin SelectTheBankAccountsThat1
			[ ] locator "@windowid='114'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[ ] 
		[+] PushButton New1
			[ ] locator "@windowid='102'"
		[+] CheckBox ExcludeFromPlan1
			[ ] locator "@windowid='104'"
			[ ] 
		[+] CheckBox ShowExcludedAccounts
			[ ] locator "@windowid='105'"
		[+] PushButton Details
			[ ] locator "@windowid='106'"
		[+] StaticText ContributionsToChecking01Te
			[ ] locator "@windowid='146'"
		[+] Control ContributionsToChecking01
			[ ] locator "@windowid='65535'"
		[+] StaticText N2Text
			[ ] locator "@windowid='147'"
		[+] StaticText ToEnterTheContributionsTha
			[ ] locator "@windowid='107'"
		[+] MainWin N21
			[ ] locator "@windowid='108'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton New2
			[ ] locator "@windowid='109'"
		[+] PushButton Edit
			[ ] locator "@windowid='110'"
		[+] PushButton Delete
			[ ] locator "@windowid='111'"
		[+] CheckBox ExcludeFromPlan2
			[ ] locator "@windowid='112'"
		[+] StaticText QuickenPlannerSavingsAndI
			[ ] locator "@windowid='32702'"
		[+] PushButton N22
			[ ] locator "@windowid='32765'"
		[+] PushButton Done
			[ ] locator "@windowid='32767'"
	[ ] 
	[ ] // Planning > UpdatePlanningAssumptions > HomesAssets
	[+] window MainWin PlannerHomesAssets
		[ ] locator "Quicken Planner: Homes and Assets"
		[+] StaticText SelectTheAssetAccountsThat
			[ ] locator "@windowid='100'"
		[+] StaticText ToCorrectThePurchaseDateO1
			[ ] locator "@windowid='101'"
		[+] MainWin ToCorrectThePurchaseDateO2
			[ ] locator "@windowid='102'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton New
			[ ] locator "@windowid='103'"
		[+] CheckBox ExcludeFromPlan
			[ ] locator "@windowid='106'"
		[+] PushButton SaleInfo
			[ ] locator "@windowid='107'"
		[+] StaticText GoalText
			[ ] locator "@windowid='108'"
		[+] Control Goal
			[ ] locator "@windowid='65535'"
		[+] StaticText ThereAreNoLoansAssociated
			[ ] locator "@windowid='109'"
		[+] PushButton Loans
			[ ] locator "@windowid='110'"
		[+] StaticText ThereAreNoExpensesAssociat
			[ ] locator "@windowid='111'"
		[+] PushButton Expenses
			[ ] locator "@windowid='112'"
		[+] StaticText ThereIsNoIncomeAssociated1
			[ ] locator "@windowid='113'"
		[+] PushButton Income
			[ ] locator "@windowid='114'"
		[+] StaticText QuickenPlannerHomesAndAss
			[ ] locator "@windowid='32702'"
		[+] PushButton ThereIsNoIncomeAssociated2
			[ ] locator "@windowid='32765'"
		[+] PushButton Done
			[ ] locator "@windowid='32767'"
	[ ] 
	[ ] // Planning > UpdatePlanningAssumptions > LoansDebt
	[+] window MainWin PlannerLoansDebt
		[ ] locator "Quicken Planner: Loans and Debt"
		[+] Control QuickenPlannerLoansAndDeb1
			[ ] locator "@windowid='100'"
		[+] MainWin QuickenPlannerLoansAndDeb2
			[ ] locator "@windowid='102'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton New
			[ ] locator "@windowid='103'"
		[+] CheckBox ExcludeFromPlan
			[ ] locator "@windowid='106'"
		[+] PushButton Payoff
			[ ] locator "@windowid='120'"
		[+] StaticText LoanText
			[ ] locator "@windowid='107'"
		[+] Control Loan
			[ ] locator "@windowid='65535'"
		[+] StaticText OriginalLoanAmountText
			[ ] locator "@windowid='108'"
		[+] StaticText N44444Text
			[ ] locator "@windowid='109'"
		[+] StaticText PaymentText
			[ ] locator "@windowid='110'"
		[+] StaticText N1004Text
			[ ] locator "@windowid='111'"
		[+] StaticText InterestRateText
			[ ] locator "@windowid='112'"
		[+] StaticText N40Text
			[ ] locator "@windowid='113'"
		[+] StaticText RemainingPaymentsText
			[ ] locator "@windowid='116'"
		[+] StaticText N48Text
			[ ] locator "@windowid='117'"
		[+] StaticText DateOfLastPaymentText
			[ ] locator "@windowid='118'"
		[+] StaticText N042017Text
			[ ] locator "@windowid='119'"
		[+] StaticText QuickenPlannerLoansAndDeb3
			[ ] locator "@windowid='32702'"
		[+] PushButton DateOfLastPayment
			[ ] locator "@windowid='32765'"
		[+] PushButton Done
			[ ] locator "@windowid='32767'"
	[ ] 
	[ ] // Planning > Budget > Remove Category confirmation dialog
	[+] window MainWin DlgRemoveCategory
		[ ] locator "Remove Category from Budget"
		[+] PushButton RemoveButton
			[ ] locator "Remove"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[ ] 
	[ ] 
	[ ] // Planning > Budget > Gear Menu >Edit Yearly Budget
	[+] window MainWin DlgEditYearlyBudget
		[ ] locator "Edit Yearly Budget"
		[+] PushButton OKButton
			[ ] locator "OK"
			[ ] // locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] TextField JanTextField
			[ ] locator "201*"
			[ ] 
		[+] TextField FebTextField
			[ ] locator "@windowid='1'"
			[ ] 
		[+] TextField MarTextField
			[ ] locator "@windowid='2'"
			[ ] 
		[+] TextField AprTextField
			[ ] locator "@windowid='3'"
			[ ] 
		[+] TextField MayTextField
			[ ] locator "@windowid='4'"
			[ ] 
		[+] TextField JunTextField
			[ ] locator "@windowid='5'"
			[ ] 
		[+] TextField JulTextField
			[ ] locator "@windowid='6'"
			[ ] 
		[+] TextField AugTextField
			[ ] locator "@windowid='7'"
			[ ] 
		[+] TextField SeptTextField
			[ ] locator "@windowid='8'"
			[ ] 
		[+] TextField OctTextField
			[ ] locator "@windowid='9'"
			[ ] 
		[+] TextField NovTextField
			[ ] locator "@windowid='10'"
			[ ] 
		[+] TextField DecTextField
			[ ] locator "@windowid='11'"
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // Planning > Budget > Gear Menu >Calculate Average Budget
	[+] window MainWin DlgCalculateAverageBudget
		[ ] locator "Calculate Average Budget"
		[+] PushButton OKButton
			[ ] locator "OK"
			[ ] // locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] TextField BudgetTextField
			[ ] locator "Budget*"
			[ ] 
		[+] ComboBox ApplyComboBox
			[ ] locator "Apply"
		[+] PushButton RolloverOptionsButton
			[ ] locator "@windowid='9215'"
		[ ] 
		[ ] 
		[ ]  
		[ ] 
	[ ] // Planning > Budget > Add a Budget for 2015
	[+] window MainWin DlgAddABudgetForNextOrPreviousYear
		[ ] locator "Add a Budget for 201*"
		[+] PushButton OKButton
			[ ] locator "OK"
			[ ] // locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] RadioList RadioListCopyThisYearsCategoriesAndAsBudget
			[ ] locator "@windowid='9310'"
			[ ] 
		[+] RadioList RadioListCopyThisYearsCategoriesAndActualsAsBudget
			[ ] locator "@windowid='9316'"
			[ ] 
		[+] RadioList RadioListCopyThisYearsCategories
			[ ] locator "@windowid='9316'"
			[ ] 
		[ ] 
		[ ]  
		[ ] 
	[ ] 
	[ ] ///Generic control for call out popups
	[+] window Control CalloutPopup
		[ ] locator "Callout Holder"
		[+] PushButton Close
			[ ] locator "close"
		[+] StaticText TotalText
			[ ] locator "Total"
		[+] StaticText TotalAmountText
			[ ] locator "@windowid= '2218'"
		[+] ListBox ListBox
			[ ] locator "@windowid= '1'"
		[+] Control GraphControl
			[ ] locator "[@windowClassName='QWGraphControlClass']"
		[ ] 
	[+] window Control RolloverCalloutPopup
		[ ] locator "@windowid='12345'"
		[+] PushButton Close
			[ ] locator "close"
		[+] StaticText CategoryText
			[ ] locator "@windowid='2082'"
		[+] StaticText MonthText
			[ ] locator "@windowid='2083'"
		[+] StaticText RolloverAmountText
			[ ] locator "@windowid='2092'"
		[+] StaticText BudgetAmountText
			[ ] locator "@windowid='2085'"
		[+] StaticText ActualAmountText
			[ ] locator "@windowid='2088'"
		[+] StaticText BalanceAmountText
			[ ] locator "@windowid='2095'"
		[+] TextField RolloverAmountTextField
			[ ] locator "//TextField"
		[+] PushButton EditResetButton
			[ ] locator "@windowid='2101'"
		[+] PushButton SaveButton
			[ ] locator "Save"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //************* Messages *********************************************************
	[ ] 
	[ ] //Converted to OA//
	[+] window DialogBox Quicken2012
		[ ] locator "Quicken 201*"
		[+] PushButton OK
			[ ] locator "@windowid='101'"	
		[+] Control QWSnapHolder
			[ ] locator "@windowid='-1'"
			[+] StaticText AcceptClearenceTransaction
				[ ] locator "@windowid='-1'"
				[+] Control TransactionFrame
					[+] PushButton AcceptAllButton
						[ ] locator "@windowid='27002'"	
				[ ] 
		[+] PushButton Yes
			[ ] locator "@windowid='101'"	
		[+] PushButton No
			[ ] locator "@windowid='102'"	
	[+] window DialogBox ConfirmFileDelete
		[ ] locator "Confirm File Delete"
		[+] PushButton Yes
			[ ] locator "@windowid='6'"	
	[+] window DialogBox ErrorDeletingFileOrFolder
		[ ] locator "Error Deleting File or Folder"
		[+] PushButton OK
			[ ] locator "@windowid='2'"	
	[ ] 
	[+] window DialogBox QuickenBackupReminder
		[ ] locator "Quicken Backup"
		[+] PushButton Exit
			[ ] locator "@windowid='32762'"
		[+] PushButton BackupButton
			[ ] locator "@caption='Backup'"
		[+] CheckBox DontShowAgainCheckBox
			[ ] locator "Don't show again"
			[ ] 
		[+] PushButton LaterButton
			[ ] locator "Later"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] window DialogBox QuickenForWindowsPopUp
		[ ] locator "Quicken 201? for Windows"
		[+] StaticText Message
			[ ] locator "@windowid='100'"	
		[+] PushButton Yes
			[ ] locator "@windowid='32767'"	
	[+] window DialogBox QuickenForWindowsMDI
		[ ] locator "Quicken 201? for Windows"
		[+] StaticText Message
			[ ] locator "@windowid='100'"	
		[+] PushButton Yes
			[ ] locator "@windowid='32767'"	
	[+] window DialogBox FreeUpdateToQuicken
		[ ] locator "Free Update to Quicken is Available!"
		[+] PushButton UpdateNow
			[ ] locator "@windowid='32767'"	
		[+] PushButton UpdateLater
			[ ] locator "@windowid='32766'"	
	[+] window DialogBox AlertMessage
		[ ] locator "Quicken 20*"
		[+] PushButton Yes
			[ ] locator "Yes"
		[+] PushButton No
			[ ] locator "[@windowid='102' or @caption='No']"	
		[+] PushButton OK
			[ ] locator "[@windowid='101' or @caption='OK']"	
		[+] PushButton Help
			[ ] locator "@windowid='104'"	
		[ ] 
		[+] Control QWSnapHolder
			[ ] locator "@windowid='-1'"
			[+] StaticText AcceptClearenceTransaction
				[ ] locator "@windowid='-1'"
				[+] Control TransactionFrame
					[+] PushButton AcceptAllButton
						[ ] locator "@windowid='27002'"	
				[ ] 
				[+] Control QWListViewer1
					[ ] locator "@windowid='8200'"	
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"	
			[ ] 
		[+] DialogBox SplitTransaction
			[ ] locator "Split Transaction"
			[+] PushButton OkButton
				[ ] locator "@windowid='32767'"	
			[+]  DialogBox NewTagForSplit
				[ ] locator "New Tag"
				[+] PushButton OK
					[ ] locator "@windowid='32767'"	
			[+] Control EnterMultipleCategories
				[ ] locator "Enter multiple categories to itemize this transaction*"
				[+] ListBox SplitWindow
					[ ] locator "@windowid='1'"	
					[+] Control Rectanglebox
						[ ] locator "@windowid='8'"	
						[+] PushButton NextButton
							[ ] locator "@windowid='211'"	
					[+] TextField TextField1
						[ ] locator "@windowid='1002'"	
					[+] Control QFBag3
						[+] PushButton QC_button1
							[ ] locator "@windowid='1124'"	
			[ ] 
		[+] StaticText StaticText
			[ ] locator "@windowid='100'"
		[+] TextField Password
			[ ] locator "@windowid='104'"
		[+] CheckBox DonTShowAgain
			[ ] locator "@windowid='110'"
		[+] StaticText MessageText
			[ ] locator "@windowid='100'"
		[+] Control ChooseCategory
			[ ] locator "@windowid='0'"
			[+] Control QWListViewer
				[ ] locator "@windowid='1001'"
				[+] ListBox CategoryList
					[ ] locator "@windowid='1'"
			[+] PushButton AllAccount
				[ ] locator "@windowid='9807'"
			[+] CheckBox ShowHiddenAccount
				[ ] locator "@windowid='9808'"
			[+] PushButton BusinessNetworth	
				[ ] locator "@windowid='9806'"															//Added by Udita on 15 Oct 2012
			[+] PushButton PersonalNetworth	
				[ ] locator "@windowid='9803'"															//Added by Udita on 30 Oct 2012
		[+] Control QWListViewer1
			[ ] locator "@windowid='73'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton HideGraph
			[ ] locator "@windowid='88'"
		[+] PushButton ShowReport
			[ ] locator "@windowid='86'"
		[+] StaticText RecordsAddress
			[ ] locator "@windowid='3011'"
		[+] PushButton Export
			[ ] locator "@windowid='4411'"
		[+] PushButton Done
			[ ] locator "@windowid='32766'"
		[+] Control Message
			[ ] 
			[+] StaticText EndingBalance
				[ ] locator "@priorlabel='EndingBalance:'"
			[+] StaticText OnlineBalance
				[ ] locator "@priorlabel='Online Balance:'"
			[+] StaticText TotalTxn
				[ ] locator "@windowid='21'"
			[ ] 
			[+] Control RegisterFrame
				[ ] locator "@windowid='0'"
				[+] PushButton DownloadTab
					[ ] locator "@windowid='1021'"
				[+] PushButton QC_button1
					[ ] locator "@windowid='1030'"
		[+] PushButton Cancel
			[ ] locator "Cancel"
			[ ] 
		[ ] 
		[ ] 
	[+] window DialogBox QuickenAlertMessage
		[ ] locator "Quicke*"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
		[ ] 
	[ ] 
	[+] window DialogBox DlgQIFImportSuccessful
		[ ] locator "QIF Import"
		[+] PushButton Done
			[ ] locator "@windowid='32767'"
	[+] window DialogBox Additional401KInformationPopup
		[ ] locator "Additional 401(k) Information"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
	[+] window DialogBox SavedReportAlert
		[ ] locator "Saved Report Alert"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
	[ ] 
	[+] window DialogBox SaveChangesToMyReport
		[ ] locator "Save Changes to *"
		[+] StaticText WouldYouLikeToSaveTheChangesMadeToThisReport
			[ ] locator "Would you like to save the changes made to this report?"
		[+] StaticText YouHaveMadeChangesToTheSetting
			[ ] locator "You have made changes to the settings of this report since it was last saved."
		[+] PushButton Save
			[ ] locator "Save"
		[+] PushButton SaveAs
			[ ] locator "Save As..."
		[+] PushButton DontSave
			[ ] locator "Don't Save"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[+] window DialogBox PleaseEnterYourPasswords
		[ ] locator "Please Enter Your Passwords"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
	[+] window DialogBox StockSplitsMayBeMissing
		[ ] locator "Stock Splits May be Missing"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
	[+] window DialogBox AlertPopup
		[ ] locator "Alert!"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
	[+] window DialogBox EnterQuickenPassword											// Updated by Udita on 12 feb 2013
		[ ] locator "Enter*Password"
		[+] StaticText PasswordText
			[ ] locator "Password:"
		[+] TextField Password
			[ ] locator "@windowid='1002'"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] StaticText WrongPassword
			[ ] locator "@windowid='1013'"
		[+] StaticText CheckToMake
			[ ] locator "@windowid='1014'"
		[+] StaticText ProtectedFile
			[ ] locator "@windowid='1000'"
			[ ] 
		[ ] 
		[ ] 
	[+] window DialogBox UnlockYourPasswordVault
		[ ] locator "Enter Password"
		[+] StaticText UnlockYourPasswordVaultText
			[ ] locator "@windowid='32702'"
		[+] Control UnlockYourPasswordVault1
			[ ] locator "@windowid='1010'"
		[+] StaticText PasswordText
			[ ] locator "@windowid='65535'"
		[+] TextField Password
			[ ] locator "@windowid='1004'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Skip
			[ ] locator "@windowid='32766'"
		[+] PushButton UpdateNow
			[ ] locator "@windowid='1011'"
			[ ] 
		[+] PushButton UnlockYourPasswordVault2
			[ ] locator "@windowid='32765'"
	[+] window DialogBox Quicken2012ForWindows
		[ ] locator "Quicken 201? for Windows"
		[+] StaticText Message
			[ ] locator "@windowid='100'"
		[+] CheckBox DonTShowAgain
			[ ] locator "@windowid='110'"
		[+] PushButton Yes
			[ ] locator "@windowid='32767'"
		[+] PushButton No
			[ ] locator "@windowid='32766'"
	[+] window DialogBox RenameYourPayees
		[ ] locator "Rename Your Payees"
		[+] PushButton ApplySettings
			[ ] locator "@windowid='32767'"
	[+] window DialogBox QuickenPassword
		[ ] locator "Transaction Password Required"
		[+] TextField Password
			[ ] locator "@windowid='104'"
		[+] StaticText TransactionPasswordRequiredT
			[ ] locator "@windowid='105'"
		[+] StaticText PasswordText
			[ ] locator "@windowid='117'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
	[+] window DialogBox SaveReportAs          //Added by Udita
		[ ] locator "Save Report As"
		[+] StaticText DoYouWishToSaveThisRepor
			[ ] locator "@windowid='101'"
		[+] StaticText SavingReportsAllowsYouToM
			[ ] locator "@windowid='65535'"
		[+] CheckBox DonTShowMeThisAgain
			[ ] locator "@windowid='100'"
		[+] PushButton Save
			[ ] locator "@windowid='32767'"
		[+] PushButton DonTSave
			[ ] locator "@windowid='32762'"
		[+] PushButton Cancel
			[ ] locator "@windowid='2'"
	[ ] //Transfer Cancelled MessageBox ---Added By Mukesh Nov 6 2012
	[+] window DialogBox TransferCancelledMessageBox
		[ ] locator "Quicken 201*"
		[+] StaticText TransferCancelledText
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
		[ ] 
	[ ] // Added by Dean
	[+] window DialogBox SaveAs
		[ ] locator "Save As"
		[+] StaticText FileNameText
			[ ] locator "@windowid='1090'"
		[+] ComboBox FileName
			[ ] locator "@windowid='1148'"
		[+] StaticText SaveAsTypeText
			[ ] locator "@windowid='1089'"
		[+] ComboBox SaveAsType
			[ ] locator "@windowid='1136'"
		[+] PushButton Save
			[ ] locator "@windowid='1'"
		[+] PushButton Cancel
			[ ] locator "@windowid='2'"
		[+] PushButton Help
			[ ] locator "@windowid='1038'"
		[+] DialogBox DialogBox1
			[ ] locator "$0"
		[+] PushButton Open
			[ ] locator "Open"
		[ ] 
	[+] window DialogBox ConfirmSaveAs
		[ ] locator "Confirm Save As"
		[+] PushButton Yes
			[ ] locator "Yes"
		[+] Control DirectUIHWND1
			[ ] locator "@windowid='0'"
			[+] Control CtrlNotifySink1
				[+] PushButton Yes
					[ ] locator "Yes"
			[+] Control CtrlNotifySink2
				[+] PushButton No
					[ ] locator "No"
		[ ] 
	[+] window DialogBox DlgEnteringBusinessTransactions
		[ ] locator "Entering Business Transactions"
		[+] StaticText EnteringBusinessTransactionsText 
			[ ] locator "@windowid='32702'"
		[+] StaticText QuickenRecommendsText 
			[ ] locator "Quicken recommends*"
		[+] StaticText FromTheAccountActionsMenuText
			[ ] locator "From the 'Account Actions' menu choose the action you'd like to perform.*"
		[+] StaticText WouldYouLikeToGoToTheFormText
			[ ] locator "Would you like to go to the form now?"
		[+] CheckBox DonTShowThisMessageAgainCheckBox
			[ ] locator "@windowid='301'"
		[+] PushButton YesButton
			[ ] locator "@windowid='32767'"
		[+] PushButton NoButton
			[ ] locator "@windowid='32762'"
	[+] window MainWin DlgVerifyCashBalance
		[ ] locator "Verify Cash Balance"
		[+] TextField OnlineBalanceTextField
			[ ] locator "@windowid='2007'"
		[+] PushButton Done
			[ ] locator "@windowid='32767'"
	[ ] 
	[+] window MessageBoxClass MessageBox
		[ ] locator "@windowid='$MessageBox'"
		[ ] 
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] // PushButton Yes    ///Commented by Mukesh on March 13, 2013
			[+] // locator "?Yes"
				[ ] // "[QC_button]Yes"
				[ ] // "$101"
		[+] PushButton Yes
			[ ] locator "@windowid='101'"
		[+] PushButton No
			[ ] locator "@windowid='102'"
		[+] StaticText ErrorMsg
			[ ] locator "@windowid='100'"
		[+] Control DoneButton
			[ ] locator "Done"
		[ ] 
		[+] PushButton StopUpdate
			[ ] locator "Stop Update"
			[ ] //"$1002"
		[+] PushButton Next
			[ ] locator "@windowid='24120'"
		[+] PushButton EnterTransactionsButton
			[ ] locator "@windowid='981'"
		[ ] 
	[ ] 
	[ ] 
	[+] window DialogBox AlertWellsFargoBank
		[ ] locator "Wells Fargo Bank"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
	[ ] 
	[+] window MainWin MessageForWindows
		[ ] locator "Quicken 201? for Windows"
		[+] MainWin QWListViewer1
			[ ] locator "@windowid='27531'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton OK
			[+] multitag "[QC_button]OK"
				[ ] "[QC_button]$32767"
	[ ] 
	[+] window DialogBox NewDataDownload
		[ ] locator "New Data Download"
		[+] StaticText HowShouldQuickenHandleThes
			[ ] locator "@windowid='201'"
		[+] // StaticText QuickenHasDownloadedNewTra1
			[+] // multitag "Quicken has downloaded new transactions from your financial institution.  Do you want to review them first, or accept them str*"
				[ ] // "$65535"
		[+] RadioList DownloadedTransactionOptions
			[ ] locator "@windowid='203'"
		[+] // CustomWin HTMLBODYBAfHrefReview
			[+] // multitag "[QWHtmlView]<HTML><BODY><b><af href=review>Review first<?a>:nbsp;<?b> (Recommended if your account data is currently correct).  Examine e*"
				[ ] // "[QWHtmlView]$206"
		[+] // CustomWin HTMLBODYBAfHrefAccept
			[+] // multitag "[QWHtmlView]<HTML><BODY><b><af href=accept>Accept all<?a>:nbsp;<?b>  Quicken will accept all new transactions 'as is' and bring your Quic*"
				[ ] // "[QWHtmlView]$205"
		[+] PushButton Next
			[ ] locator "@windowid='32764'"
		[+] CustomWin QC_button1
			[ ] locator "@windowid='32765'"
	[ ] 
	[+] window MainWin InvestingPopup
		[ ] locator "@caption='Investment*'"
		[+] MainWin VerifyCashBalance
			[ ] locator "Verify Cash Balance"
			[+] TextField OnlineBalanceTextField
				[ ] locator "@windowid='2007'"
			[+] PushButton Done
				[ ] locator "@windowid='32767'"
	[ ] 
	[ ] 
	[ ] 
	[+] window MainWin SearchResultsWindow
		[ ] locator "//MainWin[@caption='Search Results']"
		[+] StaticText SearchResults
			[ ] locator "Search Results"
		[+] StaticText Found
			[ ] locator "Found"
		[+] MainWin QWListViewer
			[ ] locator"@windowid='581'"
			[+] ListBox ListBox
				[ ] locator"@windowid='1'"
		[+] CheckBox ShowMatchesWithinSplits
			[ ] locator "Show matches within splits"
		[+] StaticText ToSelectaRangeClickTheFirstIte
			[ ] locator "To select a range, click the first item you want then hold Shift while clicking the last item you want."
		[+] StaticText TransactionCount
			[ ] locator"@windowid='584'"
		[+] PushButton EditTransactions
			[ ] locator "Edit Transaction(s)"
		[+] PushButton ToSelectaRangeClickTheFirstItePushButton
			[ ] locator "[@priorlabel='To select a range, click the first item you want then hold Shift while clicking the last item you want.'][1]"
		[+] PushButton ToSelectaRangeClickTheFirstItePushButton2
			[ ] locator "[@priorlabel='To select a range, click the first item you want then hold Shift while clicking the last item you want.'][2]"
		[+] PushButton Close
			[ ] locator "Close"
	[ ] 
	[+] window MainWin OneStepUpdateMessagebox
		[ ] locator "One Step Update"
		[+] PushButton Yes
			[ ] locator "@windowid='32767'"
		[+] PushButton No
			[ ] locator "@windowid='32766'"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] window DialogBox UnableToConnect
		[ ] locator "Chase"
		[+] CustomWin QWListViewer1
			[ ] locator "@windowid='27531'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton MoreInfo
			[ ] locator "@windowid='27534'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
	[ ] 
	[+] window MainWin DeleteBudget                                                                          //Added by Anagha 04/04/2013
		[ ] locator "Delete Budget"
		[+] StaticText DeleteBudgetText
			[ ] locator "@windowid='32702'"
		[+] Control DeleteBudget
			[ ] locator "@windowid='1845'"
		[+] StaticText YouAreAboutToDeleteTheBu
			[ ] locator "@windowid='1846'"
		[+] StaticText Budget1Text
			[ ] locator "@windowid='1844'"
		[+] StaticText AllInformationAssociatedWit
			[ ] locator "@windowid='1847'"
		[+] PushButton DeleteButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] 
	[ ] 
	[+] window Control RegisterRemindersBarMessage
		[ ] locator "@windowClassName='INTU_CalloutHolder'"
		[+] Control RegisterRemindersBarMessageChild
			[ ] //locator "@windowid='12345'"
			[ ] //locator "@winddowClassName='INTU_CalloutHolder'"
			[ ] locator "@windowClassName='INTU_CalloutPopup'"
			[+] PushButton CloseButton
				[ ] locator "@windowid='32766'"
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox DlgSelectAttachment
		[ ] locator "Select Attachment File"
		[+] StaticText FileNameText
			[ ] locator "@windowid='1090'"
		[+] ComboBox FileName
			[ ] locator "File name:"
		[+] StaticText SaveAsTypeText
			[ ] locator "@windowid='1089'"
		[+] ComboBox SaveAsType
			[ ] locator "@windowid='1136'"
		[+] PushButton Save
			[ ] locator "@windowid='1'"
		[+] PushButton Cancel
			[ ] locator "@windowid='2'"
		[+] PushButton Help
			[ ] locator "@windowid='1038'"
		[+] DialogBox DialogBox1
			[ ] locator "$0"
		[+] PushButton Open
			[ ] locator "Open"
		[ ] 
	[ ] 
	[ ] //Old Finish Date Warning Dialog	For Savings Goals			//Updated by Jayashree on 28th April 2014
	[+] window DialogBox FinishDateWarning
		[ ] locator "*Quicken 201*"
		[+] StaticText FinishDateWarningText
			[ ] locator "Finish date must be after the start date."
		[+] PushButton OK
			[ ]  locator "OK"
	[+] 
		[ ] 
		[ ] 
	[ ] ///Message from WellsFargo
	[+] window DialogBox DlgMsgWellsFargo
		[ ] locator "Important message from Wells Fargo Bank"
		[+] CheckBox DontShowAgainCheckBox
			[ ] locator "Don't show this message again"
		[+] PushButton OK
			[ ] locator "OK"
	[ ] 
	[+] window DialogBox EnterIntuitPassword											// Updated by Udita on 12 feb 2013
		[ ] locator "Enter Password"
		[+] StaticText PasswordText
			[ ] locator "Password:"
		[+] TextField Password
			[ ] locator "Password"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton UpdateNowButton
			[ ] locator "Update Now"
		[ ] 
	[ ] 
[ ] 
[-] //************* Tools *************************************************************
	[ ] 
	[ ] 
	[ ] // Tools > Account List						Ctrl + A
	[+] window MainWin AccountList             
		[ ] locator "Account List"
		[+] // MainWin QWinChild
			[ ] // locator "@windowid='0'"
			[+] // Control Order
				[ ] // locator "@windowid='9814'"
				[+] // ListBox ListBox
					[ ] // locator "@windowid='1'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] PushButton PrintButton
			[ ] locator "@windowid='32760'"
		[+] PushButton Options
			[ ] locator "@windowid='32211'"
			[+] MenuItem IncludeAdditionalInfoWhenPrinting
				[ ] locator "Include additional info when printing"
			[+] MenuItem ShowNetWorthInAccountBar
				[ ] locator "Show net worth in Account Bar"
			[+] MenuItem ShowEndingBalanceInAccountBar
				[ ] locator "Show ending balance in Account Bar"
			[+] MenuItem ShowPaymentsToSend
				[ ] locator "Show Payments to Send"
			[+] MenuItem ShowChecksToPrint
				[ ] locator "Show Checks to Print"
			[+] MenuItem ShowNumberOfTransactions
				[ ] locator "Show Number of Transactions"
			[+] MenuItem ShowDescription
				[ ] locator "Show Description"
			[+] MenuItem ShowFinancialInstitution
				[ ] locator "Show Financial Institution"
			[+] MenuItem ShowCurrentBalance
				[ ] locator "Show Current Balance"
			[+] MenuItem ShowEndingBalance
				[ ] locator  "Show Ending Balance"
			[+] MenuItem ShowTransactionDownloadStatus
				[ ] locator "Show Transaction Download Status"
			[+] MenuItem ShowOnlineBillPayStatus
				[ ] locator "Show Online Bill Pay Status"
			[+] MenuItem ShowLastReconcileDate
				[ ] locator "Show Last Reconcile Date"
			[ ] 
		[ ] 
		[+] PushButton Done
			[ ] locator "@windowid='32766'"
		[+] PushButton AddAnAccount
			[ ] locator "@windowid='102'"
		[+] Control QWinChild
			[ ] //locator "@windowClassName='QWinChild'"
			[+] PushButton OrderShiftUp
				[ ] locator "@windowid='9815'"
			[+] StaticText OrderText
				[ ] locator "@windowid='9839'"
			[+] PushButton OrderShiftDown
				[ ] locator "@windowid='9816'"
			[ ] 
			[+] PushButton PersonalBanking
				[ ] locator "Personal Banking"
			[+] PushButton PersonalInvestments
				[ ] locator "Personal Investments"
			[+] PushButton PersonalNetWorth
				[ ] locator "Personal Net Worth"
			[+] PushButton BusinessBanking
				[ ] locator "Business Banking"
			[+] PushButton BusinessInvestments
				[ ] locator "Business Investments"
			[+] PushButton BusinessNetWorth
				[ ] locator "Business Net Worth"
			[+] PushButton RentalProperty
				[ ] locator "Rental Property"
			[+] PushButton AllAccounts
				[ ] locator "All Accounts"
			[ ] 
			[+] CheckBox ShowHiddenAccounts
				[ ] locator "@windowid='9808'"
			[+] Control Order
				[ ] locator "@windowid='9814'"
				[+] ListBox ListBox
					[ ] locator "@windowid='1'"
		[+] Control Title
			[ ] locator "@windowid='32705'"
			[+] StaticText AccountListText
				[ ] locator "@windowid='1000'"
		[+] MenuItem OnlineBillPayStatus       
			[ ] locator "@windowid='120'"
		[+] MainWin AccountDetails
			[ ] locator "Account Details"
			[+] TextField AccountName
				[ ] locator "Account Name"
			[+] TextField Description
				[ ] locator "Description"
			[+] RadioList TaxDeferred
				[ ] locator "Yes"
			[+] TextField InterestRateTextField
				[ ] locator "Interest Rate"
			[+] TextField MaxBalance
				[ ] locator "Max. Balance"
			[+] TextField MinBalance
				[ ] locator "Min. Balance"
			[+] TextField FinancialInstitution
				[ ] locator "Financial Institution"
			[+] TextField AccountNumber
				[ ] locator "Account Number"
			[+] PushButton HelpIcon
				[ ] locator "@windowid='32765'"
			[+] PushButton DeleteAccountButton
				[ ] locator "Delete Account"
			[+] PushButton TaxSchedule
				[ ] locator "Tax Schedule"
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton Cancel
				[ ] locator "Cancel"
			[+] ComboBox AccountIntent1
				[ ] locator "[@caption='Account Intent'][1]"
			[+] ComboBox AccountIntent2
				[ ] locator "[@caption='Account Intent'][2]"
			[+] CheckBox KeepThisAccountSeparate
				[ ] locator "Keep this account separate- account will be excluded from Quicken reports and features"
			[+] CheckBox HideInTransactionEntryList
				[ ] locator "Hide in transaction entry lists"
			[+] TextField InvestingAccountNumber
				[ ] locator "@windowid='2031'"
			[+] CheckBox HideAccountNameInAccountB
				[ ] locator "Hide account name in account bar and account list"
			[+] PushButton CloseAccount
				[ ] locator "@windowid='1004'"
				[ ] //locator "Close Account..."
			[+] RadioList ShowCashInACheckingAccount
				[ ] locator "@priorlabel='Show cash in a checking account'"
			[+] PushButton FeesButton
				[ ] locator "Fees"
			[ ] 
			[ ] //------Account Details > Delete Account > Delete Account Dialog----------------
			[+] DialogBox DeleteAccount
				[ ] locator "Delete Account"
				[+] TextField YesField
					[ ] locator "Type ""yes"" to confirm:"
				[+] MainWin OK
					[ ] locator "OK"
				[+] Control Cancel
					[ ] locator "Cancel"
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] //------Account Details > Close Account----------------
			[+] DialogBox PermanentlyCloseAccount
				[ ] locator "Permanently Close Account"
				[+] StaticText PermanentlyCloseAccountText
					[ ] locator "Permanently Close Account"
				[+] StaticText ClosingTheAccountWillText
					[ ] locator "Closing the account will:"
				[+] StaticText SetTheAccountBalanceToZ
					[ ] locator "- Set the account balance to zero"
				[+] StaticText NoDataWillBeDeletedText
					[ ] locator "No data will be deleted:"
				[+] StaticText TransactionsWillBeAvailab1
					[ ] locator "- Transactions will be available for historical reporting"
				[+] TextField TypeYesToConfirm
					[ ] locator "Type ""yes"" to confirm"
				[+] Control LearnMore
					[ ] locator "- Learn More*"
				[+] MainWin OK
					[ ] locator "OK"
				[+] Control Cancel
					[ ] locator "Cancel"
			[ ] 
			[ ] //------Account Details > Close Account > Alert message when securities are added to investing account----------------
			[+] DialogBox AlertMessageForCloseAccount
				[ ] locator "Quicken 201*"
				[+] Control QWIconDisplay
					[ ] locator "@windowClassName='QWIconDisplay'"
				[+] StaticText Message
					[ ] locator "This account has securities balances, please clear the securities before you close the account."
				[+] MainWin OK
					[ ] locator "OK"
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] PushButton OnlineSetUpButton
				[ ] locator "@windowid='3005'"
				[ ] 
			[+] PushButton OnlineBillPay
				[ ] locator "@windowid='2053'"
				[ ] 
			[+] PushButton OnlineBillPayment
				[ ] locator "@windowid='32765'"
				[ ] 
			[ ] 
			[ ] //Web Connect to Direct Connect
			[+] StaticText AccountNameText
				[ ] locator "@windowid='2066'"
			[+] StaticText IsSetUpForTransactionDown
				[ ] locator "@windowid='2062'"
			[+] PushButton AutomaticEntry
				[ ] locator "@windowid='2073'"
			[+] PushButton Deactivate
				[ ] locator "@windowid='3006'"
			[+] PushButton SetUpNow
				[ ] locator "@windowid='2053'"
			[+] StaticText ConnectionMethodText
				[ ] locator "@windowid='2092'"
			[+] StaticText ConnectionMethod
				[ ] locator "@windowid='3000'"
			[+] StaticText Connection
				[ ] locator "@windowid='2100'"
			[+] PushButton ImproveConnection
				[ ] locator "@windowid='2114'"
			[+] StaticText FIName
				[ ] locator "@windowid='2093'"
			[ ] // //Bill Pay Active
			[+] PushButton BillPayDeactivate
				[ ] locator "@windowid='12024'"
			[+] CheckBox HideAccountNameInAccountB1
				[ ] locator "@windowid='2502'"
			[ ] 
			[ ] 
			[+] TextField AccountDetails
				[ ] locator "@windowid='2030'"
				[ ] 
			[+] TextField MaxBalanceTextField
				[ ] locator "@windowid='2006'"
			[+] TextField ContactName
				[ ] locator "@windowid='2034'"
			[+] TextField Phone
				[ ] locator "@windowid='2035'"
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] // window DialogBox AccountDetails		
				[ ] // tag "Account Details"
				[ ] // parent QuickenMainWindow
				[+] // TextField Description
					[+] // multitag "Description"
						[ ] // "$2001"
				[+] // CustomWin OK
					[+] // multitag "[QC_button]OK"
						[ ] // "[QC_button]$32767"
				[+] // CustomWin Cancel
					[+] // multitag "[QC_button]Cancel"
						[ ] // "[QC_button]$32766"
				[+] // CustomWin TaxSchedule
					[+] // multitag "[QC_button]Tax Schedule"
						[ ] // "[QC_button]^Account Intent[3]"
						[ ] // "[QC_button]#4"
						[ ] // "[QC_button]$1019"
						[ ] // "[QC_button]@(209,469)"
				[+] // TextField AccountName
					[+] // multitag "Account Name"
						[ ] // "$2000"
				[+] // RadioList TaxDeferred
					[+] // multitag "Tax-Deferred"
						[ ] // "$2003"
				[+] // CustomWin DeleteAccount
					[+] // multitag "$1003"
						[ ] // "Delete Account|[QC_button]Delete Account"
						[ ] // 
				[+] // PopupList AccountIntent1
					[+] // multitag "Account Intent[1]"
						[ ] // "^Account Intent[1]"
						[ ] // "#1"
						[ ] // "$2029"
						[ ] // "@(133,249)"
				[+] // PopupList AccountIntent2
					[+] // multitag "Account Intent[2]"
						[ ] // "^Account Intent[2]"
						[ ] // "#2"
						[ ] // "$2048"
						[ ] // "@(133,275)"
				[+] // CheckBox KeepThisAccountSeparate
					[+] // multitag "Keep this account separate- account will be excluded from Quicken reports and features"
						[ ] // "^Account Display[1]"
						[ ] // "#1"
						[ ] // "$2501"
						[ ] // "@(258,112)"
				[+] // CheckBox HideInTransactionEntryList
					[+] // multitag "Hide in transaction entry lists"
						[ ] // "^Account Display[2]"
						[ ] // "#2"
						[ ] // "$2500"
						[ ] // "@(183,130)"
				[+] // CheckBox HideAccountNameInAccountB
					[+] // multitag "Hide account name in account bar and account list"
						[ ] // "^Account Display[3]"
						[ ] // "#3"
						[ ] // "$2502"
						[ ] // "@(210,148)"
				[+] // CustomWin CloseAccount
					[+] // multitag "[QC_button]Close Account"
						[ ] // "^Account Display"
						[ ] // "#1"
						[ ] // "$1004"
						[ ] // "@(89,179)"
				[+] // RadioList ShowCashInACheckingAccount
					[+] // multitag "[QC_button]Show cash in a checking account"
						[ ] // "[QC_button]^Show cash in a checking account[1]"
						[ ] // "[QC_button]#4"
						[ ] // "[QC_button]$32765"
						[ ] // "[QC_button]@(34,470)"
				[+] // CheckBox HideAccountInAccountBar
					[+] // multitag "Hide account name in account bar and account list"
						[ ] // "#3"
						[ ] // "$2502"
				[+] // StaticText ThisAccountIsAlreadyClosed
					[+] // multitag "This account is already closed."
						[ ] // "#3"
						[ ] // "$3003"
						[ ] // "@(322,179)"
				[ ] // 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] ListBox ListBox
			[ ] locator "Account List"
		[ ]   
		[ ] 
	[ ] 
	[ ] // // Tools > Currency List						Ctrl + Q
	[+] window MainWin CurrencyList
		[ ] locator "Currency List"
		[+] StaticText CurrencyList
			[ ] locator "Currency List"
		[+] MainWin xWindow
			[ ] locator "@windowid='300'"
		[+] ListBox ListBox
			[ ] locator "@windowid='1'"
		[+] VerticalScrollBar VerticalScrollBar
			[ ] locator "//VerticalScrollBar"
		[+] PushButton New
			[ ] locator "@windowid='500'"
		[+] PushButton Use
			[ ] locator "Use"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton Delete
			[ ] locator "Delete"
		[+] PushButton Home
			[ ] locator "Home"
		[+] PushButton Update
			[ ] locator "Update"
		[+] PushButton CurrencyListPushButton
			[ ] locator "[@priorlabel='Currency List'][7]"
		[+] PushButton CurrencyListPushButton8
			[ ] locator "[@priorlabel='Currency List'][8]"
		[+] PushButton Done
			[ ] locator "Done"
		[+] Control QWinLightbox
			[ ] locator "@windowClassName='QWinLightbox'"
		[+] DialogBox HomeSetConfirmation
			[ ] locator "Quicken 2015"
			[+] Control QWIconDisplay
				[ ] locator "@windowClassName='QWIconDisplay'"
			[+] StaticText ChangingTheHomeCurrencyMayChangeThe
				[ ] locator "Changing the home currency may change the"
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton Cancel
				[ ] locator "Cancel"
			[+] PushButton Help
				[ ] locator "Help"
		[+] DialogBox SetUpNewCurrency
			[ ] locator "Set Up New Currency"
			[+] StaticText SetUpNewCurrency
				[ ] locator "Set Up New Currency"
			[+] StaticText Label
				[ ] locator "[2]"
			[+] StaticText RequiredFields
				[ ] locator "Required fields"
			[+] StaticText CurrencyName
				[ ] locator "Currency Name:"
			[+] StaticText Label5
				[ ] locator "[5]"
			[+] TextField CurrencyNameTextField
				[ ] locator "Currency Name:"
			[+] StaticText CurrencySymbol
				[ ] locator "Currency Symbol:"
			[+] StaticText Label7
				[ ] locator "[7]"
			[+] TextField CurrencySymbolTextField
				[ ] locator "Currency Symbol:"
			[+] StaticText CurrencyCode
				[ ] locator "Currency Code:"
			[+] TextField CurrencyCodeTextField
				[ ] locator "Currency Code:"
			[+] StaticText ShortcutLetter
				[ ] locator "Shortcut letter:"
			[+] TextField ShortcutLetterTextField
				[ ] locator "@windowid='103'"
			[+] StaticText AmtPer
				[ ] locator "Amt per*"
			[+] TextField AmtPerTextField
				[ ] locator "@windowid='105'"
			[+] StaticText PerAmt
				[ ] locator "$ per Amt:"
			[+] TextField PerAmtTextField 
				[ ] locator "$ per Amt:"
			[+] PushButton PerAmtPushButton
				[ ] locator "@priorlabel='$ per Amt:'"
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton Cancel
				[ ] locator "Cancel"
		[+] DialogBox DeleteCurrencyConfirmation
			[ ] locator "Quicken 2015"
			[+] Control QWIconDisplay
				[ ] locator "@windowClassName='QWIconDisplay'"
			[+] StaticText YouAreAboutToDeleteaCurrency
				[ ] locator "You are about to delete a currency."
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton Cancel
				[ ] locator "Cancel"
		[+] DialogBox CannotDeleteHomeCurrencyConfirmation
			[ ] locator "Quicken 2015"
			[+] Control QWIconDisplay
				[ ] locator "@windowClassName='QWIconDisplay'"
			[+] StaticText CannotDeleteHomeCurrency
				[ ] locator "Cannot delete home currency."
			[+] PushButton OK
				[ ] locator "OK"
		[+] DialogBox EditCurrency
			[ ] locator "Edit Currency"
			[+] StaticText EditCurrency
				[ ] locator "Edit Currency"
			[+] StaticText Label
				[ ] locator "[2]"
			[+] StaticText RequiredFields
				[ ] locator "Required fields"
			[+] StaticText CurrencyName
				[ ] locator "Currency Name:"
			[+] StaticText Label5
				[ ] locator "[5]"
			[+] TextField CurrencyNameTextField
				[ ] locator "Currency Name:"
			[+] StaticText CurrencySymbol
				[ ] locator "Currency Symbol:"
			[+] StaticText Label7
				[ ] locator "[7]"
			[+] TextField CurrencySymbolTextField
				[ ] locator "Currency Symbol:"
			[+] StaticText CurrencyCode
				[ ] locator "Currency Code:"
			[+] TextField CurrencyCodeTextField
				[ ] locator "Currency Code:"
			[+] StaticText ShortcutLetter
				[ ] locator "Shortcut letter:"
			[+] TextField ShortcutLetterTextField
				[ ] locator "[@caption='Shortcut letter:'][1]"
			[+] StaticText AmtPer
				[ ] locator "@windowid='104'"
			[+] TextField AmtPerTextField
				[ ] locator "@windowid='105'"
			[+] StaticText PerAmt
				[ ] locator "$ per €:"
			[+] TextField PerAmtTextField
				[ ] locator "$ per €:"
			[+] PushButton PerPushButton
				[ ] locator "@priorlabel='$ per €:'"
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton Cancel
				[ ] locator "Cancel"
			[ ] 
			[ ] 
	[ ] 
	[ ] //Account List > Print Button
	[ ] // window DialogBox AccountListPrint
	[+] window DialogBox DlgPrint
		[ ] locator "Print"
		[+] RadioList RadioList1
			[ ] locator "Printer"
		[+] ComboBox PopupList1
			[ ] locator "[1]"
		[+] Control Properties
			[ ] locator "Properties"
		[+] StaticText ThisPrinterPrintsToPaper
			[ ] locator "This printer prints to paper."
		[+] RadioList ExportTo
			[ ] locator "Export to:"
		[+] ComboBox ThisPrinterPrintsToPaperComboBox
			[ ] locator "This printer prints to paper."
		[+] Group Group
			[ ] locator "[1]"
		[+] CheckBox PrintInColor
			[ ] locator "Print in color"
		[+] CheckBox PrintInDraftMode
			[ ] locator "Print in draft mode"
		[+] CheckBox FitToOnePageWide
			[ ] locator "Fit to one page wide"
		[+] Group Orientation
			[ ] locator "Orientation"
		[+] RadioList Portrait
			[ ] locator "Portrait"
		[+] RadioList Landscape
			[ ] locator "Landscape"
		[+] StaticText ORIENT_PORTRAIT
			[ ] locator "ORIENT_PORTRAIT"
		[+] StaticText ORIENT_LANDSCAPE
			[ ] locator "ORIENT_LANDSCAPE"
		[+] Group PrintRange
			[ ] locator "Print Range"
		[+] RadioList All
			[ ] locator "All"
		[+] RadioList Pages
			[ ] locator "Pages:"
		[+] StaticText From
			[ ] locator "From:"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] StaticText To
			[ ] locator "To:"
		[+] Control PR_NumEd
			[ ] locator "@windowClassName='PR_NumEd'"
		[+] StaticText NumberOfCopies
			[ ] locator "Number of copies:"
		[+] MainWin x1
			[ ] locator "1"
		[+] UpDownEx PrintRangeUpDown
			[ ] locator "@priorlabel='Print Range'"
		[+] Control NumberOfCopiesControl
			[ ] locator "@priorlabel='Number of copies:'"
		[+] MainWin xWindow3
			[ ] locator "[3]"
		[+] MainWin PrinterSetup
			[ ] locator "Printer Setup"
		[+] MainWin PreView
			[ ] locator "Pre&view"
		[+] MainWin Print
			[ ] locator "Print"
		[+] Control Cancel
			[ ] locator "Cancel"
		[+] PushButton PreviewButton
			[ ] locator "Preview"
		[ ] 
	[ ] 
	[ ] //Account List > Print Button > Select Print to PDF > Print
	[+] window DialogBox SaveToPDFFile
		[ ] locator "Save to PDF File"
		[+] StaticText SaveIn
			[ ] locator "Save in:"
		[+] ComboBox SaveInComboBox
			[ ] locator "Save in:"
		[+] ToolBar SaveInToolBar
			[ ] locator "[@priorlabel='Save in:'][1]"
		[+] PushToolItem PushToolItem
			[ ] locator "[1]"
		[+] PushToolItem PushToolItem2
			[ ] locator "[2]"
		[+] PushToolItem PushToolItem3
			[ ] locator "[3]"
		[+] PushToolItem PushToolItem4
			[ ] locator "[4]"
		[+] ToolBar SaveInToolBar2
			[ ] locator "[@priorlabel='Save in:'][2]"
		[+] PushToolItem RecentPlaces
			[ ] locator "Recent Places"
		[+] PushToolItem Desktop
			[ ] locator "Desktop"
		[+] PushToolItem Libraries
			[ ] locator "Libraries"
		[+] PushToolItem Computer
			[ ] locator "Computer"
		[+] PushToolItem Network
			[ ] locator "Network"
		[+] Control SHELLDLL_DefView
			[ ] locator "@windowClassName='SHELLDLL_DefView'"
		[+] ListViewEx ListView
			[ ] locator "//ListViewEx"
		[+] VerticalScrollBar VerticalScrollBar
			[ ] locator "//VerticalScrollBar"
		[+] StaticText FileName
			[ ] locator "File name:"
		[+] ComboBox FileNameComboBox
			[ ] locator "File name:"
		[+] TextField FileNameTextField
			[ ] locator "File name:"
		[+] StaticText SaveAsType
			[ ] locator "Save as type:"
		[+] ComboBox SaveAsTypeComboBox
			[ ] locator "Save as type:"
		[+] PushButton Save
			[ ] locator "Save"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] Control x32770
			[ ] locator "@windowClassName='#32770'"
	[ ] 
	[ ] // Tools > Calendar > Options > Select Calendar Accounts
	[+] window MainWin CalendarAccounts
		[ ] locator "Calendar Accounts"
		[+] StaticText CalendarAccountsText
			[ ] locator "@windowid='32702'"
		[+] StaticText SelectAccountsToIncludeTex
			[ ] locator "@windowid='108'"
		[+] CustomWin Account
			[ ] locator "@windowid='551'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton MarkAll
			[ ] locator "@windowid='552'"
		[+] PushButton ClearAll
			[ ] locator "@windowid='553'"
		[+] PushButton SelectAccountsToInclude
			[ ] locator "@windowid='32765'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
	[+] window DialogBox DlgEditHomeCurrency
		[ ] locator "Edit Home Currency"
		[+] TextField CurrencyNameTextField
			[ ] locator "@windowid='101'"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[ ] 
	[ ] 
	[ ] // Tools > Calendar							  Ctrl + K
	[+] window MainWin Calendar
		[ ] locator "Calendar"
		[+] TextField GoToDateTextField
			[ ] locator "Go to date"
		[+] StaticText GoToDateText
			[ ] locator "Go to date"
		[+] TextField GoToDate1
			[ ] locator "Go to date"
		[+] Control GoToDate2
			[ ] locator "@windowClassName='QFBag'"
		[+] Control GoToDateControl
			[ ] locator "[@priorlabel='Go to date'][3]"
		[+] // Control QC_button
			[ ] // locator "[@windowClassName='QC_button'][2]"
		[+] Control Go
			[ ] locator "Go"
		[+] Control May
			[ ] locator "May"
		[+] StaticText June2013
			[ ] locator "June 2013"
		[+] Control Jul
			[ ] locator "Jul"
		[+] Control AddNote
			[ ] locator "Add Note"
		[+] Control Options
			[ ] locator "Options"
		[+] Control Print
			[ ] locator "Print"
		[+] Control Help
			[ ] locator "Help"
		[+] Control Panel
			[ ] locator "Panel"
		[+] StaticText Label
			[ ] locator "[3]"
		[+] StaticText Label4
			[ ] locator "[4]"
		[+] Control AddReminder
			[ ] locator "Add Reminder"
		[+] Control ManageReminders
			[ ] locator "Manage Reminders"
		[+] StaticText Label5
			[ ] locator "[5]"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] VerticalScrollBar VerticalScrollBar
			[ ] locator "//VerticalScrollBar"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // Tools > Alerts Center
	[+] window MainWin AlertsCenter
		[ ] locator "Alerts Center"
		[+] Control QW_MDI_TOOLBAR
			[ ] locator "@windowClassName='QW_MDI_TOOLBAR'"
		[+] PushButton ShowAll
			[ ] locator "Show All"
		[+] PushButton Setup
			[ ] locator "Setup"
		[+] StaticText ThisTableIsaListOfAllYourAlert
			[ ] locator "This table is a list of all your alerts. You can delete alerts by clicking on the checkbox and then clicking on the delete button at the bottom of the table."
		[+] StaticText Label
			[ ] locator "[2]"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] Control Delete
			[ ] locator "Delete"
		[+] Control Cancel
			[ ] locator "Cancel"
		[+] Control ThisTableIsaListOfAllYourAlertControl
			[ ] locator "[@priorlabel='This table is a list of all your alerts. You can delete alerts by clicking on the checkbox and then clicking on the delete button at the bottom of the table.'][3]"
	[ ] 
	[ ] // Tools > Manage Bill & Income Reminders	  Ctrl + J	
	[+] window MainWin BillAndIncomeReminders
		[ ] locator "Bill and Income Reminders"
		[+] StaticText Label
			[ ] locator "[1]"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] StaticText Label2
			[ ] locator "[2]"
		[+] StaticText Label3
			[ ] locator "[3]"
		[+] Control QWGraphControlClass
			[ ] locator "@windowClassName='QWGraphControlClass'"
		[+] StaticText Label4
			[ ] locator "[4]"
		[+] StaticText ForAccount
			[ ] locator "For account"
		[+] ComboBox ForAccountComboBox
			[ ] locator "For account"
		[+] MainWin xWindow2
			[ ] locator "[2]"
		[+] MainWin June2013
			[ ] locator "June 2013"
		[+] MainWin xWindow4
			[ ] locator "[4]"
		[+] StaticText Label6
			[ ] locator "[6]"
		[+] CheckBox ShowGraph
			[ ] locator "Show graph"
		[+] CheckBox ShowCalendar
			[ ] locator "Show calendar"
		[+] Control QWSeparator
			[ ] locator "@windowClassName='QWSeparator'"
		[+] Control May
			[ ] locator "May"
		[+] StaticText June2013Label
			[ ] locator "June 2013"
		[+] Control Jul
			[ ] locator "Jul"
		[+] Control QW_MDI_TOOLBAR
			[ ] locator "@windowClassName='QW_MDI_TOOLBAR'"
		[+] PushButton MonthlyBillsDeposits
			[ ] locator "Monthly Bills && Deposits"
		[+] PushButton AllBillsDeposits
			[ ] locator "All Bills && Deposits"
		[+] PushButton Scheduled
			[ ] locator "Scheduled"
		[+] PushButton RepeatingOnline
			[ ] locator "Repeating Online"
	[ ] 
	[ ] // Tools > Manage Hidden Accounts                 Ctrl + Shift + M
	[+] window MainWin ManageHiddenAccounts
		[ ] locator "Manage Hidden Accounts"
		[+] StaticText ManageHiddenAccountsText
			[ ] locator "Manage Hidden Accounts"
		[+] StaticText HidingOptionsText
			[ ] locator "Hiding Options"
		[+] PushButton HidingOptions1
			[ ] locator "@windowid='105'"
		[+] MainWin HidingOptions2
			[ ] locator "@windowid='102'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] StaticText AClosedAccountCannotBeReOpened
			[ ] locator "* A closed account cannot be re-opened."
		[+] PushButton LearnMoreAboutWhenToCloseAnAccount
			[ ] locator "Learn more about when to close an account."
		[+] PushButton Done
			[ ] locator "Done"
	[ ] 
	[ ] 
	[ ] // Tools > Category List						  Ctrl + Shift + C
	[+] window MainWin CategoryList
		[ ] locator "Category List"
		[ ] 
		[+] ComboBox ShowComboBox
			[ ] locator "@windowid='101'"
		[+] MainWin Title
			[ ] locator "@windowid='32705'"
			[+] StaticText CategoryListText
				[ ] locator "@windowid='1000'"
		[+] Control Show
			[+] MainWin QWListViewer1
				[ ] locator "@windowid='1001'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
		[+] PushButton New
			[ ] locator "@windowid='1000'"
		[+] Control Panel
			[+] TextField TextSearchCategory
				[ ] locator "@windowid='2001'"
			[+] PushButton PushButton1
				[ ] locator "@windowid='2002'"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] PushButton OptionsButton
			[ ] locator "Options"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // Tools > Tag List							  Ctrl + L
	[+] window MainWin TagList
		[ ] locator "Tag List"
		[+] MainWin HelpButton
			[ ] locator "[1]"
		[+] Control PrintButton
			[ ] locator "@windowClassName='QC_button'"
		[+] MainWin NewButton
			[ ] locator "New"
		[+] MainWin DoneButton
			[ ] locator "Done"
		[+] Control QWinChild
			[ ] locator "@windowClassName='QWinChild'"
		[+] MainWin xWindow4
			[ ] locator "[4]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] Control TitleText
			[ ] locator "Title"
		[+] StaticText TagList
			[ ] locator "Tag List"
	[ ] 
	[ ] // Tools > Security List						  Ctrl + Y
	[+] window MainWin SecurityList
		[ ] locator "Security List"
		[+] StaticText SecurityListText
			[ ] locator "Security List"
		[+] Control SecurityList
			[ ] locator "@windowClassName='QWListViewer'"
		[+] ListBox SecurityListListBox
			[ ] locator "Security List"
		[+] Control NewSecurity
			[ ] locator "New Security"
		[+] Control ChooseMarketIndexes
			[ ] locator "Choose Market Indexes"
		[+] Control MarkAll
			[ ] locator "Mark All"
		[+] CheckBox ShowHiddenSecurities
			[ ] locator "Show hidden securities"
		[+] Control SecurityList1
			[ ] locator "[@priorlabel='Security List'][7]"
		[+] Control SecurityList2
			[ ] locator "[@priorlabel='Security List'][8]"
		[+] Control Done
			[ ] locator "Done"
	[ ] 
	[ ] // Tools > Recategorize
	[+] window MainWin Recategorize
		[ ] locator "Recategorize"
		[+] StaticText Recategorize1Text
			[ ] locator "Recategorize"
		[+] StaticText FindText
			[ ] locator "Find"
		[+] ComboBox Find1
			[ ] locator "Find"
		[+] StaticText WithCategoryText
			[ ] locator "with category"
		[+] TextField WithCategory
			[ ] locator "with category"
		[+] MainWin Find2
			[ ] locator "&Find"
		[+] CheckBox ExactMatch
			[ ] locator "Exact match"
		[+] StaticText FoundText
			[ ] locator "Found"
		[+] MainWin Found
			[ ] locator "[2]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] MainWin SelectAll
			[ ] locator "Select All"
		[+] MainWin ClearAll
			[ ] locator "Clear All"
		[+] CheckBox ShowMatchesWithinSplits
			[ ] locator "Show matches within splits"
		[+] StaticText RecategorizeAsText
			[ ] locator "Recategorize as"
		[+] TextField RecategorizeAs3
			[ ] locator "Recategorize as"
		[+] MainWin RecategorizeAll
			[ ] locator "Recategorize All"
		[+] MainWin RecategorizeAs1
			[ ] locator "[6]"
		[+] Control RecategorizeAs2
			[ ] locator "[@priorlabel='Recategorize as'][2]"
		[+] StaticText Recategorize2Text
			[ ] locator "[6]"
		[+] MainWin Done
			[ ] locator "Done"
		[+] Control Recategorize
			[ ] locator "[@priorlabel='Recategorize'][2]"
		[+] Control RecategorizeControl3
			[ ] locator "[@priorlabel='Recategorize'][3]"
		[+] Control RecategorizeControl4
			[ ] locator "[@priorlabel='Recategorize'][4]"
		[+] Control RecategorizeAsControl3
			[ ] locator "[@priorlabel='Recategorize as'][3]"
		[+] Control RecategorizeAsControl4
			[ ] locator "[@priorlabel='Recategorize as'][4]"
		[+] Control WithCategoryControl
			[ ] locator "[@priorlabel='with category'][3]"
	[ ] 
	[ ] 
	[ ] // Tools > One Step Update
	[-] window MainWin OneStepUpdate
		[ ] locator "One Step Update Settings"
		[+] Control OneStepUpdateSettings
			[ ] locator "[@priorlabel='One Step Update Settings'][1]"
		[+] StaticText OneStepUpdateSettingsLabel
			[ ] locator "One Step Update Settings"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] TextField TextField
			[ ] locator "//TextField"
		[+] PushButton ScheduleUpdates
			[ ] locator "&Schedule Updates..."
		[+] CheckBox ShowPasswordCharacters
			[ ] locator "Show password characters"
		[+] MainWin xWindow2
			[ ] locator "[2]"
		[+] PushButton UpdateNow
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control OneStepUpdateSettings1
			[ ] locator "@windowid='142'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] Control OneStepUpdateSettings2
			[ ] locator "@windowid='157'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[+] TextField AccountPassword
					[ ] locator "@windowid='128'"
		[+] MainWin OneStepUpdateSettings3
			[ ] locator "@windowid='106'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[+] TextField AccountPassword
					[ ] locator "@windowid='128'"
				[ ] 
		[+] Control OneStepUpdateSettings4
			[ ] locator "@windowid='146'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] Control OneStepUpdateSettings5
			[ ] locator "@windowid='137'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[ ] 
		[+] StaticText Label
			[ ] locator "[2]"
		[+] Control Panel
			[ ] locator "Panel"
		[+] Control QWHtmlView
			[ ] locator "@windowClassName='QWHtmlView'"
		[ ] 
		[ ] 
		[+] // Control OneStepUpdateSettings2
			[ ] // //locator "//MainWin"
			[ ] // //locator "@windowid='157'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[+] TextField AccountPassword
					[ ] locator "@windowid='128'"
		[ ] 
	[ ] 
	[+] window MainWin OnlineUpdateAccount
		[ ] locator "Online Update for this account"
		[+] CheckBox ShowPasswordCharacters
			[ ] locator "Show password characters"
		[+] PushButton UpdateNow
			[ ] locator "Update Now"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton PushButton
			[ ] locator "[3]"
		[+] Control QWIconDisplay
			[ ] locator "@windowClassName='QWIconDisplay'"
		[+] StaticText OneStepUpdateSettings
			[ ] locator "One Step Update Settings"
		[+] MainWin OneStepUpdateSettings1
			[ ] locator "@windowid='106'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
		[+] TextField TextField
			[ ] locator "//TextField"
	[ ] 
	[ ] 
	[ ] // Tools > One Step Schedule Updates
	[+] window DialogBox ScheduleUpdates
		[ ] locator "Schedule Updates"
		[+] StaticText ScheduleUpdates
			[ ] locator "Schedule Updates"
		[+] StaticText UpdateTheseFinancialInstitutions
			[ ] locator "Update these Financial Institutions"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] StaticText UpdateOnlineServices
			[ ] locator "Update online services"
		[+] CheckBox UpdateQuotesAssetClassesHeadlinesAndAlerts
			[ ] locator "Update quotes, asset classes headlines and alerts"
		[+] Control HTMLVIEWER
			[ ] locator "[@caption='HTML VIEWER'][1]"
		[+] StaticText Optional
			[ ] locator "[@caption='-optional'][1]"
		[+] CheckBox UpdateMyPortfolioOnQuickenCom
			[ ] locator "Update my Portfolio on Quicken.com"
		[+] Control HTMLVIEWER2
			[ ] locator "[@caption='HTML VIEWER'][2]"
		[+] StaticText Optional2
			[ ] locator "[@caption='-optional'][2]"
		[+] StaticText Schedule
			[ ] locator "Schedule"
		[+] Control ScheduleControl
			[ ] locator "[@priorlabel='Schedule'][1]"
		[+] StaticText On
			[ ] locator "On:"
		[+] CheckBox Mon
			[ ] locator "Mon"
		[+] CheckBox Tue
			[ ] locator "Tue"
		[+] CheckBox Wed
			[ ] locator "Wed"
		[+] CheckBox Thu
			[ ] locator "Thu"
		[+] CheckBox Fri
			[ ] locator "Fri"
		[+] CheckBox Sat
			[ ] locator "Sat"
		[+] CheckBox Sun
			[ ] locator "Sun"
		[+] StaticText At
			[ ] locator "At:"
		[+] ComboBox AtComboBox
			[ ] locator "At:"
		[+] StaticText UpdatesWillRunWithin15MinutesOfTimeSpecified
			[ ] locator "Updates will run within 15 minutes of time specified."
		[+] StaticText Passwords
			[ ] locator "Passwords"
		[+] Control PasswordsControl
			[ ] locator "[@priorlabel='Passwords'][1]"
		[+] StaticText PromptForPasswordVaultPassword
			[ ] locator "Prompt for Password Vault password:"
		[+] RadioList AtWindowsStartup
			[ ] locator "at Windows startup"
		[+] RadioList BeforeEachScheduledUpdate
			[ ] locator "before each scheduled update"
		[+] Control HTMLVIEWER3
			[ ] locator "[@caption='HTML VIEWER'][3]"
		[+] Control HTMLVIEWER4
			[ ] locator "[@caption='HTML VIEWER'][4]"
		[+] MainWin xWindow2
			[ ] locator "[2]"
		[+] MainWin OK
			[ ] locator "OK"
		[+] Control Cancel
			[ ] locator "Cancel"
		[+] Control QWHtmlView
			[ ] locator "[@windowClassName='QWHtmlView'][5]"
	[ ] 
	[ ] // Tools > Renaming Rules
	[+] window MainWin RenamingRules
		[ ] locator "Renaming Rules"
		[+] StaticText RenamingRules
			[ ] locator "Renaming Rules"
		[+] StaticText RenameTheDownloadedPayeeTo
			[ ] locator "Rename the downloaded payee to:"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] MainWin xWindow2
			[ ] locator "[2]"
		[+] MainWin AddaRule
			[ ] locator "Add a Rule"
		[+] MainWin Preferences
			[ ] locator "Preferences"
		[+] MainWin xWindow5
			[ ] locator "[5]"
		[+] MainWin HavingTrouble
			[ ] locator "Having trouble?"
		[+] PushButton Done
			[ ] locator "Done"
	[ ] 
	[ ] // Tools > Memorized Payee List
	[+] window MainWin MemorizedPayeeList
		[ ] locator "//MainWin[@caption='Memorized Payee List']"
		[+] // StaticText MemorizedPayeeList
			[ ] // locator "Memorized Payee List"
		[+] Control MemorizedPayeeList
			[ ] //locator "@windowClassName='QWListViewer'"
			[ ] locator "@windowid='125'"
			[+] ListBox ListBox
				[ ] //locator "Memorized Payee List"
				[ ] locator "@windowid='1'"
				[ ] 
				[ ] 
		[+] PushButton Options
			[ ] locator "Options"
		[+] PushButton NewPayee
			[ ] locator "New Payee"
		[+] PushButton RenamingRules
			[ ] locator "Renaming Rules"
		[+] PushButton MergeRename
			[ ] locator "@caption='Merge / Rename'"
		[+] PushButton Delete
			[ ] locator "Delete"
		[+] Control MemorizedPayeeList2
			[ ] locator "[@priorlabel='Memorized Payee List'][8]"
		[+] Control MemorizedPayeeList1
			[ ] locator "[@priorlabel='Memorized Payee List'][9]"
		[+] PushButton Done
			[ ] locator "Done"
		[+] Control QC_button1
			[ ] locator "[@windowClassName='QC_button'][9]"
		[+] Control QC_button2
			[ ] locator "[@windowClassName='QC_button'][10]"
		[ ] //added by shrivardhan
		[+] DialogBox MergeAndRenamePayees
			[ ] locator "Merge and Rename Payees"
			[+] StaticText MergeAndRenamePayees
				[ ] locator "Merge and Rename Payees"
			[+] StaticText ThisWillRenameThePayeeOfTheSelectedTransactions
				[ ] locator "This will rename the payee of the selected transactions."
			[+] StaticText NewName
				[ ] locator "New Name:"
			[+] TextField NewNameTextField
				[ ] locator "New Name:"
			[+] PushButton NewNamePushButton
				[ ] locator "@priorlabel='New Name:'"
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton Cancel
				[ ] locator "Cancel"
		[+] MainWin AddaRenamingRule
			[ ] locator "Add a Renaming Rule"
			[+] StaticText AddaRenamingRule
				[ ] locator "Add a Renaming Rule"
			[+] StaticText ChangePayeeTo
				[ ] locator "Change payee to:"
			[+] TextField ChangePayeeToTextField
				[ ] locator "Change payee to:"
			[+] StaticText QuickenWillRenameTheDownloadedPayee
				[ ] locator "Quicken will rename the downloaded payee:"
			[+] ComboBox QuickenWillRenameTheDownloadedPayeeComboBox
				[ ] locator "Quicken will rename the downloaded payee:"
			[+] TextField QuickenWillRenameTheDownloadedPayeeTextField
				[ ] locator "Quicken will rename the downloaded payee:"
			[+] PushButton QuickenWillRenameTheDownloadedPayeePushButton
				[ ] locator "[@priorlabel='Quicken will rename the downloaded payee:'][1]"
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton Cancel
				[ ] locator "Cancel"
			[+] Control QFBag
				[ ] locator "@windowClassName='QFBag'"
			[+] PushButton AddaRenamingRulePushButton
				[ ] locator "[@priorlabel='Add a Renaming Rule'][1]"
			[+] PushButton AddaRenamingRulePushButton2
				[ ] locator "[@priorlabel='Add a Renaming Rule'][2]"
		[+] DialogBox DeletePayeeConfirmation
			[ ] locator "Quicken 2016"
			[+] Control QWIconDisplay
				[ ] locator "@windowClassName='QWIconDisplay'"
			[+] StaticText YouAreAboutToDeleteaCurrency
				[ ] locator "OK to delete one item?"
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton Cancel
				[ ] locator "Cancel"
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
			[ ] //locator "32765"
		[ ] 
	[ ] 
	[ ] // Tools >  Write and Print Checks
	[+] // window MainWin WriteChecks 
		[ ] // locator "Write Checks:*"
		[+] // StaticText WriteChecksBUSINESSSELECTCHKG0508
			[ ] // locator "Write Checks: BUSINESSSELECT CHKG 0508"
		[+] // StaticText WriteChecksFrom
			[ ] // locator "Write checks from:"
		[+] // ComboBox WriteChecksFromComboBox
			[ ] // locator "Write checks from:"
		[+] // StaticText xDate
			[ ] // locator "Date"
		[+] // TextField xDateTextField
			[ ] // locator "Date"
		[+] // StaticText PayToTheOrderOf
			[ ] // locator "Pay to the order of"
		[+] // TextField PayToTheOrderOfTextField
			[ ] // locator "[@caption='Pay to the order of'][1]"
		[+] // StaticText Label
			[ ] // locator "$"
		[+] // TextField TextField
			[ ] // locator "$"
		[+] // StaticText Label6
			[ ] // locator "[6]"
		[+] // StaticText Dollars
			[ ] // locator "Dollars"
		[+] // StaticText BillPayAddress
			[ ] // locator "Bill Pay Address"
		[+] // TextField PayToTheOrderOfTextField2
			[ ] // locator "[@caption='Pay to the order of'][2]"
		[+] // TextField BillPayAddress1
			[ ] // locator "[@caption='Bill Pay Address'][1]"
		[+] // TextField BillPayAddress2
			[ ] // locator "[@caption='Bill Pay Address'][2]"
		[+] // TextField BillPayAddress3
			[ ] // locator "[@caption='Bill Pay Address'][3]"
		[+] // TextField BillPayAddress4
			[ ] // locator "[@caption='Bill Pay Address'][4]"
		[+] // Control EditAddress
			[ ] // locator "Edit &Address..."
		[+] // StaticText Memo
			[ ] // locator "Memo"
		[+] // TextField Memo1
			[ ] // locator "Memo"
		[+] // StaticText Category
			[ ] // locator "Category"
		[+] // TextField Category1
			[ ] // locator "Category"
		[+] // MainWin xWindow
			[ ] // locator "[1]"
		[+] // StaticText Label11
			[ ] // locator "[11]"
		[+] // MainWin ReCordCheck
			[ ] // locator "Re&cord Check"
		[+] // Control QWListViewer
			[ ] // locator "@windowClassName='QWListViewer'"
		[+] // ListBox CategoryListBox
			[ ] // locator "Category"
		[+] // MainWin NewCheck
			[ ] // locator "New Check"
		[+] // StaticText EndingBalance
			[ ] // locator "Ending Balance:"
		[+] // StaticText x29927
			[ ] // locator "299.27"
		[+] // MainWin xWindow4
			[ ] // locator "[4]"
		[+] // MainWin OrderChecks
			[ ] // locator "Order Checks"
		[+] // MainWin Reports
			[ ] // locator "Reports"
		[+] // MainWin Print
			[ ] // locator "&Print"
		[+] // MainWin Done
			[ ] // locator "Done"
		[+] // Control xDateControl
			[ ] // locator "[@priorlabel='Date'][2]"
		[+] // Control xDateControl3
			[ ] // locator "[@priorlabel='Date'][3]"
	[+] window MainWin WriteChecks
		[ ] locator "Write Checks: *"
		[+] ComboBox WriteChecksFrom
			[ ] locator "Write checks from:"
		[+] PushButton Print
			[ ] locator "Print" 
		[+] PushButton Done
			[ ] locator "Done" 
	[ ] 
	[ ] // Tools > Reconcile an Account
	[+] window MainWin ChooseReconcileAccount
		[ ] locator "Choose Reconcile Account"
		[+] StaticText ChooseReconcileAccount
			[ ] locator "Choose Reconcile Account"
		[+] StaticText ChooseTheAccountThatYouWantToReconcile
			[ ] locator "Choose the account that you want to reconcile."
		[+] ComboBox ChooseAccount
			[ ] locator "Choose the account that you want to reconcile."
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] // 
	[+] // window DialogBox ReconcileDetails
		[ ] // locator "Reconcile Details"
		[+] // // StaticText ReconcileDetails
			[ ] // // locator "Reconcile Details"
		[+] // // StaticText Label
			[ ] // // locator "[2]"
		[+] // // StaticText RequiredFields
			[ ] // // locator "Required fields"
		[+] // // StaticText TheLastStatementEndingDateNA
			[ ] // // locator "@caption='The last statement ending date:  N/A'"
		[+] // // StaticText OpeningBalance
			[ ] // // locator "Opening Balance:"
		[+] // // StaticText Label6
			[ ] // // locator "[6]"
		[+] // TextField TheLastStatementEndingDate2
			[ ] // locator "@caption='The last statement ending date:  N/A'"
		[+] // // StaticText EndingBalance
			[ ] // // locator "Ending Balance:"
		[+] // // StaticText Label8
			[ ] // // locator "[8]"
		[+] // TextField TextField
			[ ] // locator "[2]"
		[+] // StaticText NewStatementEndingDate
			[ ] // locator "New Statement Ending Date:"
		[+] // StaticText Label10
			[ ] // locator "[10]"
		[+] // TextField TextField3
			[ ] // locator "[3]"
		[+] // StaticText ServiceCharge
			[ ] // locator "Service Charge:"
		[+] // TextField ServiceChargeTextField
			[ ] // locator "Service Charge:"
		[+] // StaticText xDate
			[ ] // locator "[@caption='Date:'][1]"
		[+] // TextField xDateTextField
			[ ] // locator "[@caption='Date:'][1]"
		[+] // StaticText Category
			[ ] // locator "[@caption='Category:'][1]"
		[+] // TextField xDateTextField2
			[ ] // locator "[@caption='Date:'][2]"
		[+] // StaticText InterestEarned
			[ ] // locator "Interest Earned:"
		[+] // TextField InterestEarnedTextField
			[ ] // locator "Interest Earned:"
		[+] // StaticText xDate2
			[ ] // locator "[@caption='Date:'][2]"
		[+] // TextField xDateTextField3
			[ ] // locator "[@caption='Date:'][3]"
		[+] // StaticText Category2
			[ ] // locator "[@caption='Category:'][2]"
		[+] // TextField CategoryTextField
			[ ] // locator "Category:"
		[+] // MainWin xWindow
			[ ] // locator "[1]"
		[+] // MainWin OK
			[ ] // locator "OK"
		[+] // Control Cancel
			[ ] // locator "Cancel"
		[+] // // Control RequiredFieldsControl
			[ ] // // locator "[@priorlabel='Required fields'][2]"
		[+] // // Control RequiredFieldsControl3
			[ ] // // locator "[@priorlabel='Required fields'][3]"
		[+] // // Control RequiredFieldsControl4
			[ ] // // locator "[@priorlabel='Required fields'][4]"
		[+] // // Control RequiredFieldsControl5
			[ ] // // locator "[@priorlabel='Required fields'][5]"
		[+] // // Control RequiredFieldsControl6
			[ ] // // locator "[@priorlabel='Required fields'][6]"
		[+] // // Control RequiredFieldsControl7
			[ ] // // locator "[@priorlabel='Required fields'][7]"
		[+] // // Control xDateControl
			[ ] // // locator "[@priorlabel='Date:'][4]"
		[+] // // Control xDateControl5
			[ ] // // locator "[@priorlabel='Date:'][5]"
		[+] // // Control TheLastStatementEndingDateNAControl
			[ ] // // locator "[@priorlabel='The last statement ending date:  N/A'][2]"
		[+] // // Control xDateControl6
			[ ] // // locator "[@priorlabel='Date:'][6]"
		[+] // // Control xDateControl7
			[ ] // // locator "[@priorlabel='Date:'][7]"
		[+] // // Control RequiredFieldsControl8
			[ ] // // locator "[@priorlabel='Required fields'][8]"
		[+] // // Control RequiredFieldsControl9
			[ ] // // locator "[@priorlabel='Required fields'][9]"
		[+] // // Control RequiredFieldsControl10
			[ ] // // locator "[@priorlabel='Required fields'][10]"
		[+] // // Control RequiredFieldsControl11
			[ ] // // locator "[@priorlabel='Required fields'][11]"
		[+] // // Control CategoryControl
			[ ] // // locator "[@priorlabel='Category:'][2]"
		[+] // // Control CategoryControl3
			[ ] // // locator "[@priorlabel='Category:'][3]"
		[+] // // Control RequiredFieldsControl12
			[ ] // // locator "[@priorlabel='Required fields'][12]"
		[+] // // Control xDateControl8
			[ ] // // locator "[@priorlabel='Date:'][8]"
		[+] // // Control xDateControl9
			[ ] // // locator "[@priorlabel='Date:'][9]"
		[+] // // Control TheLastStatementEndingDateNAControl3
			[ ] // // locator "[@priorlabel='The last statement ending date:  N/A'][3]"
		[+] // // Control xDateControl10
			[ ] // // locator "[@priorlabel='Date:'][10]"
		[+] // // Control xDateControl11
			[ ] // // locator "[@priorlabel='Date:'][11]"
		[+] // // Control RequiredFieldsControl13
			[ ] // // locator "[@priorlabel='Required fields'][13]"
		[+] // // Control CategoryControl4
			[ ] // // locator "[@priorlabel='Category:'][4]"
		[+] // // Control CategoryControl5
			[ ] // // locator "[@priorlabel='Category:'][5]"
		[+] // // Control RequiredFieldsControl14
			[ ] // // locator "[@priorlabel='Required fields'][14]"
	[ ] 
	[ ] // Tools > Online Center
	[+] window MainWin OnlineCenter
		[ ] locator "Online Center"
		[+] Control QW_MDI_TOOLBAR
			[ ] locator "@windowClassName='QW_MDI_TOOLBAR'"
		[+] PushButton Transactions
			[ ] locator "Transactions"
		[+] PushButton Payments
			[ ] locator "Payments"
		[+] PushButton EMail
			[ ] locator "E-mail"
		[+] PushButton Marketplace
			[ ] locator "Marketplace"
		[+] StaticText ClearedTransactionsAndOnlineBalancesDownloadedOn1082012
			[ ] locator "@caption='Cleared transactions and online balances downloaded on 10/8/2012.'"
		[+] Control ClearedTransactionsAndOnlin2
			[ ] locator "@windowClassName='QWListViewer'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] MainWin xWindow
			[ ] locator "@windowid='1201'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
		[+] MainWin xWindow2
			[ ] locator "@windowid='1101'"
			[+] ListBox ListBox3
				[ ] locator "@windowid='1'"
		[+] PushButton CompareToRegister
			[ ] locator "@windowid='1202'"
		[+] // StaticText FinancialInstitution
			[ ] // locator "Financial Institution:"
		[+] ComboBox FinancialInstitution
			[ ] locator "@windowid='1004'"
		[+] ComboBox Account
			[ ] locator "@windowid='10201'"
			[ ] 
		[+] PushButton UpdateSend
			[ ] locator "@windowid='1002'"
			[ ] 
	[ ] 
	[ ] // Tools > Online Payee List
	[+] window MainWin OnlinePayeeList
		[ ] locator "Online Payee List"
		[+] StaticText FinancialInstitution
			[ ] locator "Financial Institution:"
		[+] ComboBox FinancialInstitutionComboBox
			[ ] locator "Financial Institution:"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] MainWin xWindow2
			[ ] locator "[2]"
		[+] MainWin xWindow3
			[ ] locator "[3]"
		[+] MainWin New
			[ ] locator "New"
		[+] MainWin Edit
			[ ] locator "Edit"
		[+] MainWin Use
			[ ] locator "Use"
		[+] MainWin Report
			[ ] locator "Report"
		[+] MainWin Delete
			[ ] locator "Delete"
		[+] MainWin Done
			[ ] locator "Done"
	[ ] 
	[ ] //Tools > Address Book
	[+] window MainWin AddressBookAllGroups
		[ ] locator "Address Book :*"
		[+] StaticText AddressBookAllGroups
			[ ] locator "Address Book : <All Groups>"
		[+] StaticText Group
			[ ] locator "Group:"
		[+] ComboBox GroupComboBox
			[ ] locator "Group:"
		[+] StaticText x0Record
			[ ] locator "(0 Record)"
		[+] StaticText ColumnSets
			[ ] locator "Column Sets:"
		[+] ComboBox ColumnSetsComboBox
			[ ] locator "Column Sets:"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] PushButton New
			[ ] locator "New"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] Control Delete
			[ ] locator "Delete"
		[+] Control EXport
			[ ] locator "Export"
		[+] PushButton Options
			[ ] locator "Options"
		[+] MainWin xWindow5
			[ ] locator "[5]"
		[+] Control GroupControl
			[ ] locator "[@priorlabel='Group:'][2]"
		[+] PushButton Done
			[ ] locator "Done"
	[ ] 
	[ ] //Tools > Calculator
	[+] window MainWin QuickenCalc
		[ ] locator "/MainWin[@caption='Quicken Calc']"
		[+] Control x0
			[ ] locator "0"
		[+] Control x1
			[ ] locator "1"
		[+] Control x2
			[ ] locator "2"
		[+] Control x3
			[ ] locator "3"
		[+] Control x4
			[ ] locator "4"
		[+] Control x5
			[ ] locator "5"
		[+] Control x6
			[ ] locator "6"
		[+] Control x7
			[ ] locator "7"
		[+] Control x8
			[ ] locator "8"
		[+] Control x9
			[ ] locator "9"
		[+] Control Control
			[ ] locator "+"
		[+] Control Control2
			[ ] locator "-"
		[+] Control X
			[ ] locator "X"
		[+] Control Control3
			[ ] locator "@caption='/'"
		[+] Control Control4
			[ ] locator "="
		[+] Control Control5
			[ ] locator "%"
		[+] Control MS
			[ ] locator "MS"
		[+] Control MR
			[ ] locator "MR"
		[+] Control MC
			[ ] locator "MC"
		[+] Control Paste
			[ ] locator "Paste"
		[+] Control Control6
			[ ] locator "@caption='.'"
		[+] Control Control7
			[ ] locator "<-"
		[+] Control C
			[ ] locator "C"
		[+] Control CE
			[ ] locator "CE"
		[+] Control QC_button
			[ ] locator "[@windowClassName='QC_button'][25]"
	[ ] 
	[ ] //Account Actions> Transfer Money
	[+] window DialogBox DlgTransferMoneyWithinQuicken
		[ ] locator "Transfer Money*"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] StaticText TransferMoneyText 
			[ ] locator "Transfer Money*"
		[+] StaticText TransferDateText
			[ ] locator "Transfer date"
		[+] TextField TransferDateTextField
			[ ] locator "Transfer date"
		[+] StaticText AmountText
			[ ] locator "Amount"
		[+] TextField AmountTextField
			[ ] locator "Amount"
		[+] StaticText FromAccountText
			[ ] locator "From account"
		[+] PopupList FromAccountPopupList
			[ ] locator "From account"
		[+] StaticText ToAccountText
			[ ] locator "To account"
		[+] PopupList ToAccountPopupList
			[ ] locator "To account"
		[+] StaticText PayeeDescriptionText
			[ ] locator "Payee*"
		[+] TextField PayeeDescriptionTextField
			[ ] locator "Payee*"
		[+] StaticText OptionalText
			[ ] locator "(optional)"
		[+] StaticText MemoText
			[ ] locator "Memo"
		[+] TextField MemoTextField
			[ ] locator "Memo"
		[+] PushButton HelpButton
			[ ] locator "Memo"
		[ ] 
	[ ] 
	[ ] // Tools > Password Vault > Set Up Your Password Vault
	[+] window DialogBox PasswordVaultSetup
		[ ] locator "Password Vault Setup"
		[+] Control QC_button
			[ ] locator "[@windowClassName='QC_button'][1]"
		[+] Control QWIconDisplay
			[ ] locator "@windowClassName='QWIconDisplay'"
		[+] PushButton Welcome
			[ ] locator "Welcome"
		[+] PushButton SelectBankCC
			[ ] locator "@caption='Select Bank/CC'"
		[+] PushButton Summary
			[ ] locator "Summary"
		[+] Control PasswordVaultSetup
			[ ] locator "Password Vault Setup"
		[+] StaticText YourFinancialInstitutionsRequi
			[ ] locator "Your financial institutions require a password to access online services and download transactions. Some Quicken connected services may also require a password."
		[+] StaticText SettingUpaPasswordVaultIsEasy
			[ ] locator "Setting up a Password Vault is easy:"
		[+] StaticText x1EnterThePasswordsYoudLikeToStore
			[ ] locator "1. Enter the passwords you'd like to store"
		[+] StaticText x2CreateaSinglePasswordForThePasswordVault
			[ ] locator "2. Create a single password for the Password Vault"
		[+] StaticText ThatsIt
			[ ] locator "That's it!"
		[+] MainWin Next
			[ ] locator "Next"
		[+] Control QC_button2
			[ ] locator "[@windowClassName='QC_button'][2]"
		[+] Control Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] // Tools > Calendar > Right Click > Transactions
	[+] window MainWin TransactionsOnDate
		[ ] locator "@caption='Transactions on*'"
		[+] StaticText TransactionsOn6112013
			[ ] locator "@caption='Transactions on: 6/11/2013'"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] Control EnTer
			[ ] locator "Enter"
		[+] Control Edit
			[ ] locator "Edit"
		[+] Control Delete
			[ ] locator "Delete"
		[+] Control Schedule
			[ ] locator "Schedule"
		[+] StaticText Label
			[ ] locator "[2]"
		[+] Control TransactionsOn6112013Control
			[ ] locator "[@priorlabel='Transactions on: 6/11/2013'][5]"
		[+] Control Add
			[ ] locator "Add"
		[+] Control Close
			[ ] locator "Close"
	[ ] 
	[ ] // Tools > Calendar > Right Click > Transactions > Edit
	[+] window MainWin EditRegisterTransaction
		[ ] locator "Edit *"
		[+] PushButton Done
			[ ] locator "Done"
		[+] PushButton Delete
			[ ] locator "Delete"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] ComboBox AccountToUse
			[ ] locator "@windowid='10201'"
			[ ] 
		[+] Control Panel
			[ ] locator "[@caption='Panel'][1]"
		[+] Control PayTo
			[ ] locator "[@priorlabel='Pay to'][2]"
		[+] StaticText PayToLabel
			[ ] locator "Pay to"
		[+] TextField PayToTextField
			[ ] locator "Pay to"
		[+] Control Panel2
			[ ] locator "[@caption='Panel'][2]"
		[+] Control x3rdOfEveryMonth
			[ ] locator "[@priorlabel='3rd of every month'][2]"
		[+] StaticText DueNextOn
			[ ] locator "Due Next On"
		[+] TextField DueNextOnTextField
			[ ] locator "Due Next On"
		[+] StaticText x3rdOfEveryMonthLabel
			[ ] locator "3rd of every month"
		[+] StaticText AmountDue
			[ ] locator "Amount due"
		[+] StaticText x2948
			[ ] locator "$29.48"
		[+] Control Edit
			[ ] locator "(Edit)"
		[+] StaticText FromAccount
			[ ] locator "From account"
		[+] TextField x2948TextField
			[ ] locator "$29.48"
		[+] StaticText Details
			[ ] locator "Details"
		[+] StaticText Label
			[ ] locator "[9]"
		[+] Control EditLoanPaymentReminderControl
			[ ] locator "[@priorlabel='Edit Loan Payment Reminder'][1]"
		[+] Control EditLoanPaymentReminderControl2
			[ ] locator "[@priorlabel='Edit Loan Payment Reminder'][2]"
		[+] Control EditLoanPaymentReminderControl3
			[ ] locator "[@priorlabel='Edit Loan Payment Reminder'][3]"
		[+] Control Panel3
			[ ] locator "[@caption='Panel'][3]"
		[+] Control Category
			[ ] locator "Category: "
		[+] Control x3rdOfEveryMonth3
			[ ] locator "[@priorlabel='3rd of every month'][3]"
		[+] Control Split
			[ ] locator "Split"
		[+] Control Tag
			[ ] locator "Tag: "
		[+] Control NoTag
			[ ] locator "no tag"
		[+] Control Memo
			[ ] locator "Memo: "
		[+] Control NoMemo
			[ ] locator "no memo"
		[+] Control Panel4
			[ ] locator "[@caption='Panel'][4]"
		[+] Control DetailsControl
			[ ] locator "[@priorlabel='Details'][7]"
		[+] Control OptionalSettings
			[ ] locator "Optional Settings"
	[ ] 
	[ ] // Tools > Calendar > Right Click > Enter expense/Enter income
	[+] window DialogBox EnterExpenseIncomeTxn
		[ ] locator "Enter * transaction"
		[+] PushButton BillPay
			[ ] locator "<bill pay>"
		[+] TextField PayeeInformationTextField
			[ ] locator "Payee Information"
		[+] PushButton Address
			[ ] locator "Address..."
		[+] TextField CategoryTextField
			[ ] locator "Category"
		[+] PushButton Split
			[ ] locator "Split..."
		[+] TextField TagTextField
			[ ] locator "Tag"
		[+] TextField MemoTextField
			[ ] locator "Memo"
		[+] ComboBox PaymentInformationComboBox
			[ ] locator "Payment Information"
		[+] TextField MethodCheckNumberTextField
			[ ] locator "@caption='Method/Check Number'"
		[+] StaticText PayOnlineAt
			[ ] locator "Pay online at"
		[+] Control LearnMore
			[ ] locator "Learn More"
		[+] TextField TextField
			[ ] locator "[6]"
		[+] TextField TextField7
			[ ] locator "[7]"
		[+] PushButton EnterTransactionButton
			[ ] locator "Enter Transaction"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton xDatePushButton
			[ ] locator "@priorlabel='Date'"
		[+] Control PayeeInformationControl
			[ ] locator "[@priorlabel='Payee Information'][4]"
		[+] PushButton PayeeInformationPushButton
			[ ] locator "[@priorlabel='Payee Information'][3]"
		[+] PushButton PayeeInformationPushButton4
			[ ] locator "[@priorlabel='Payee Information'][4]"
		[+] Control PaymentInformationControl
			[ ] locator "[@priorlabel='Payment Information'][4]"
		[+] PushButton PaymentInformationPushButton
			[ ] locator "[@priorlabel='Payment Information'][3]"
		[+] PushButton PaymentInformationPushButton4
			[ ] locator "[@priorlabel='Payment Information'][4]"
		[+] Control PayeeInformationControl7
			[ ] locator "[@priorlabel='Payee Information'][7]"
		[+] PushButton PayeeInformationPushButton5
			[ ] locator "[@priorlabel='Payee Information'][5]"
		[+] PushButton PayeeInformationPushButton6
			[ ] locator "[@priorlabel='Payee Information'][6]"
		[+] Control QFBag
			[ ] locator "[@windowClassName='QFBag'][4]"
		[+] PushButton PushButton
			[ ] locator "[13]"
		[+] PushButton PushButton14
			[ ] locator "[14]"
		[+] Control PaymentInformationControl7
			[ ] locator "[@priorlabel='Payment Information'][7]"
		[+] PushButton PaymentInformationPushButton5
			[ ] locator "[@priorlabel='Payment Information'][5]"
		[+] PushButton PaymentInformationPushButton6
			[ ] locator "[@priorlabel='Payment Information'][6]"
		[+] Control PaymentInformationControl10
			[ ] locator "[@priorlabel='Payment Information'][10]"
		[+] PushButton PaymentInformationPushButton7
			[ ] locator "[@priorlabel='Payment Information'][7]"
		[+] PushButton PaymentInformationPushButton8
			[ ] locator "[@priorlabel='Payment Information'][8]"
		[ ] 
		[ ] 
		[+] TextField AmountTextField
			[ ] locator "@windowid='10200'"
		[ ] 
		[+] StaticText PaymentInformationText
			[ ] locator "Payment Information"
		[+] ComboBox AccountToUse
			[ ] locator "Payment Information"
		[+] TextField MethodCheckNumber
			[ ] locator "Method?Check Number"
		[+] TextField PaymentDateTextField
			[ ] locator "@windowid='10200'"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Account Actions > Reconcile ---------- Credit Card Account
	[+] window DialogBox ReconcileCreditCardAccount
		[ ] locator "Reconcile:*"
		[+] StaticText ReconcileCreditCard
			[ ] locator "Reconcile: Credit Card"
		[+] StaticText Label
			[ ] locator "[2]"
		[+] StaticText RequiredFields
			[ ] locator "Required fields"
		[+] StaticText TheLastStatementEndingDateNA
			[ ] locator "@caption='The last statement ending date:  N/A'"
		[+] StaticText ChargesCashAdvances
			[ ] locator "Charges, Cash Advances:"
		[+] StaticText Label6
			[ ] locator "[6]"
		[+] TextField TextField
			[ ] locator "[1]"
		[+] StaticText OtherThanFinanceCharges
			[ ] locator "(other than finance charges)"
		[+] StaticText PaymentsCredits
			[ ] locator "Payments, Credits:"
		[+] StaticText Label9
			[ ] locator "[9]"
		[+] TextField TextField2
			[ ] locator "[2]"
		[+] StaticText EndingBalance
			[ ] locator "Ending Balance:"
		[+] StaticText Label11
			[ ] locator "[11]"
		[+] TextField TextField3
			[ ] locator "[3]"
		[+] StaticText NewStatementEndingDate
			[ ] locator "New Statement Ending Date:"
		[+] StaticText Label13
			[ ] locator "[13]"
		[+] TextField TextField4
			[ ] locator "[4]"
		[+] StaticText FinanceCharges
			[ ] locator "Finance Charges:"
		[+] TextField FinanceChargesTextField
			[ ] locator "Finance Charges:"
		[+] StaticText xDate
			[ ] locator "Date:"
		[+] TextField xDateTextField
			[ ] locator "Date:"
		[+] StaticText Category
			[ ] locator "Category:"
		[+] TextField CategoryTextField
			[ ] locator "Category:"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] MainWin OK
			[ ] locator "OK"
		[+] Control Cancel
			[ ] locator "Cancel"
		[+] Control RequiredFieldsControl
			[ ] locator "[@priorlabel='Required fields'][2]"
		[+] Control RequiredFieldsControl3
			[ ] locator "[@priorlabel='Required fields'][3]"
		[+] Control RequiredFieldsControl4
			[ ] locator "[@priorlabel='Required fields'][4]"
		[+] Control RequiredFieldsControl5
			[ ] locator "[@priorlabel='Required fields'][5]"
		[+] Control RequiredFieldsControl6
			[ ] locator "[@priorlabel='Required fields'][6]"
		[+] Control RequiredFieldsControl7
			[ ] locator "[@priorlabel='Required fields'][7]"
		[+] Control RequiredFieldsControl8
			[ ] locator "[@priorlabel='Required fields'][8]"
		[+] Control RequiredFieldsControl9
			[ ] locator "[@priorlabel='Required fields'][9]"
		[+] Control RequiredFieldsControl10
			[ ] locator "[@priorlabel='Required fields'][10]"
		[+] Control xDateControl
			[ ] locator "[@priorlabel='Date:'][2]"
		[+] Control xDateControl3
			[ ] locator "[@priorlabel='Date:'][3]"
		[+] Control TheLastStatementEndingDateNAControl
			[ ] locator "@priorlabel='The last statement ending date:  N/A'"
		[+] Control xDateControl4
			[ ] locator "[@priorlabel='Date:'][4]"
		[+] Control xDateControl5
			[ ] locator "[@priorlabel='Date:'][5]"
		[+] Control RequiredFieldsControl11
			[ ] locator "[@priorlabel='Required fields'][11]"
		[+] Control CategoryControl
			[ ] locator "[@priorlabel='Category:'][2]"
		[+] Control CategoryControl3
			[ ] locator "[@priorlabel='Category:'][3]"
		[+] Control RequiredFieldsControl12
			[ ] locator "[@priorlabel='Required fields'][12]"
		[+] Control QFBag
			[ ] locator "[@windowClassName='QFBag'][7]"
		[+] Control QC_button
			[ ] locator "[@windowClassName='QC_button'][14]"
		[+] Control RequiredFieldsControl13
			[ ] locator "[@priorlabel='Required fields'][13]"
	[ ] 
	[ ] //Account Actions > Update balance ----------Cash Account
	[+] window MainWin UpdateBalance
		[ ] locator "/MainWin[@caption='Update Balance']"
		[+] StaticText UpdateBalance
			[ ] locator "Update Balance"
		[+] StaticText NewBalance
			[ ] locator "New Balance"
		[+] TextField NewBalanceTextField
			[ ] locator "New Balance"
		[+] StaticText AdjustmentDate
			[ ] locator "Adjustment Date"
		[+] TextField AdjustmentDateTextField
			[ ] locator "Adjustment Date"
		[+] StaticText CategoryForAdjustment
			[ ] locator "Category for Adjustment"
		[+] TextField CategoryForAdjustmentTextField
			[ ] locator "Category for Adjustment"
		[+] MainWin xWindow
			[ ] locator "[1]"
		[+] MainWin OK
			[ ] locator "OK"
		[+] Control Cancel
			[ ] locator "Cancel"
		[+] Control UpdateBalanceControl
			[ ] locator "[@priorlabel='Update Balance'][2]"
		[+] Control UpdateBalanceControl3
			[ ] locator "[@priorlabel='Update Balance'][3]"
		[+] Control UpdateBalanceControl4
			[ ] locator "[@priorlabel='Update Balance'][4]"
		[+] Control UpdateBalanceControl5
			[ ] locator "[@priorlabel='Update Balance'][5]"
		[+] Control UpdateBalanceControl6
			[ ] locator "[@priorlabel='Update Balance'][6]"
		[+] Control UpdateBalanceControl7
			[ ] locator "[@priorlabel='Update Balance'][7]"
		[+] Control UpdateBalanceControl8
			[ ] locator "[@priorlabel='Update Balance'][8]"
		[+] Control UpdateBalanceControl9
			[ ] locator "[@priorlabel='Update Balance'][9]"
		[+] Control UpdateBalanceControl10
			[ ] locator "[@priorlabel='Update Balance'][10]"
	[ ] 
	[ ] 
	[ ] //Account Actions>CustomizeActionBar
	[+] window DialogBox DlgCustomizeActionBar
		[ ] locator "Customize Action Bar"
		[+] PushButton DoneButton
			[ ] locator"Done"
	[ ] 
	[ ] 
	[ ] //Customer /Vendor Account Actions> Print> Invoices
	[+] window MainWin DlgPrintInvoices
		[ ] locator "Print Invoic*"
		[+] PushButton DoneButton
			[ ] locator "Done"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
			[ ] 
	[ ] 
	[ ] 
	[ ] //Customer /Vendor Account Actions> Print> Statements
	[+] window MainWin DlgCustomerStatements
		[ ] locator "Customer Statements"
		[+] PushButton PrintButton
			[ ] locator "Print"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
			[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] window DialogBox SetUpYourPasswordVault
		[ ] locator "Password Vault Setup"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
			[ ] 
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] ComboBox StorePasswordFor
			[ ] locator "Store password for"
			[ ] //locator "@windowid='1004'"
		[+] ComboBox ToStoreAPassword
			[ ] locator "@windowid='1016'"
		[+] PushButton Next
			[+] locator "@windowid='32764'"
				[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] window DialogBox EditPasswordVault
		[ ] locator "Edit Password Vault"
		[+] PushButton Done
			[ ] locator "@windowid='32764'"
			[ ] 
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton AddPassword
			[ ] locator "@windowid='1009'"
			[ ] 
		[+] PushButton ManagePaswordVault   // Added by Abhijit S, Mar 2015
			[ ] locator "@windowid='1018'"
		[+] MainWin QWListViewer
			[ ] locator "@windowClassName='QWListViewer'"
			[+] ListBox AccountListBox
				[ ] locator "//ListBox"
	[ ] //Manage password vault dialog // Added by Abhijit S, Mar 2015
	[+] window DialogBox ManageVaultPassword 
		[ ] locator "Manage Vault Password"
		[+] RadioList UseMyIntuitIDPassword
			[ ] locator "@windowid='1027'"
		[+] RadioList UseCustomPassword
			[ ] locator "@windowid='1028'"
		[+] PushButton Save
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
		[ ] 
		[+] MainWin QWListViewer
			[ ] locator "@windowClassName='QWListViewer'"
			[+] ListBox AccountListBox
				[ ] locator "//ListBox"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //Add Password dialog // Added by Abhijit S, May 2015
	[+] window DialogBox AddAPassword
		[ ] locator "@caption='Add a password'"
		[+] TextField Password
			[ ] locator "@windowid='1005'"
		[+] TextField ReenterPassword
			[ ] locator "@windowid='1006'"
		[+] PushButton Add
			[ ] locator "@windowid='32767'"
			[ ] 
	[+] window MainWin OnlineUpdateForThisAccount
		[ ] locator "Online Update for this account"
		[+] CheckBox ShowPasswordCharacters
			[ ] locator "Show password characters"
		[+] PushButton UpdateNowButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] StaticText OneStepUpdateSettings
			[ ] locator "One Step Update Settings"
		[+] MainWin QWListViewer
			[ ] locator "@windowid='106'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
				[+] TextField TextField
					[ ] locator "@windowid='128'"
		[ ] 
	[ ] 
	[+] window Control AccountActionsButton
		[ ] locator "//Control[@windowClassName='QW_MAIN_TOOLBAR'][3]"
	[+] window Control AccountActionsPopUpButton
		[ ] locator "/WPFWindow[@caption='Quicken 20*']//Control[@windowid='12002']"
		[+] MenuItem SavingsGoalTransactions
			[ ] locator "@windowid='200'"
	[ ] //To  identify Export to excel compatible format dialog//
	[+] window Control FileName
		[ ] locator "*File*"
	[ ] 
	[+] // window DialogBox EnterExpenseIncomeTxn
		[ ] // locator "Enter*transaction"
		[+] // TextField PayeeInformation
			[ ] // locator "Payee Information"
		[+] // PushButton Address
			[ ] // locator "Address"
		[+] // TextField Category
			[ ] // locator "Category"
		[+] // PushButton Split
			[ ] // locator "Split"
		[+] // TextField Tag
			[ ] // locator "Tag"
		[+] // TextField Memo
			[ ] // locator "Memo"
		[+] // StaticText PaymentInformationText
			[ ] // locator "Payment Information"
		[+] // ComboBox AccountToUse
			[ ] // locator "Payment Information"
		[+] // StaticText MethodCheckNumberText
			[ ] // locator "Method?Check Number"
		[+] // TextField MethodCheckNumber
			[ ] // locator "Method?Check Number"
		[+] // StaticText AmountText
			[ ] // locator "Amount"
		[+] // TextField AmountTextField
			[ ] // locator "@windowid='10200'"
		[+] // PushButton EnterTransactionButton
			[ ] // locator "Enter Transaction"
		[+] // PushButton Cancel
			[ ] // locator "Cancel"
	[ ] // 
	[ ] 
	[+] window MainWin DlgAddAttachment
		[ ] locator "Add Attachment"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[ ] 
	[ ] //OSU Issue
	[+] window DialogBox ChooseProfile
		[ ] tag "Choose Profile"
		[+] PushButton OK
			[+] multitag "OK"
				[ ] "$1"
		[+] PushButton Cancel
			[+] multitag "Cancel"
				[ ] "$2"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin DlgReconcileTransactions
		[ ] locator "Reconcile*"
		[+] PushButton MarkAllButton
			[ ] locator "Mark All"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton FinishLaterButton
			[ ] locator "Finish Later"
		[+] PushButton DoneButton
			[ ] locator "Done"
	[ ] //Account Actions> Reconcile Details>Reconcile>AdjustOpeningBalance
	[+] window MainWin DlgAdjustOpeningBalance
		[ ] locator "Adjust Opening Balance"
		[+] TextField AdjustmentDateTextField
			[ ] locator "@windowid='113'"
		[+] PushButton AdjustButton
			[ ] locator "Adjust"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[ ] //Account Actions> Reconcile Details>Reconcile>AdjustOpeningBalance>AdjustBalance
	[+] window DialogBox DlgAdjustBalance
		[ ] locator "Adjust Balance"
		[+] StaticText AdjustmentAmountText
			[ ] locator "@windowid='124'"
		[+] PushButton AdjustButton
			[ ] locator "Adjust"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[ ] //Account Actions> Reconcile Details>Reconcile>AdjustOpeningBalance>AdjustBalance>Reconciliation Complete
	[+] window DialogBox DlgReconciliationComplete
		[ ] locator "Reconciliation Complete"
		[+] PushButton YesButton
			[ ] locator "Yes"
		[+] PushButton NoButton
			[ ] locator "No"
	[ ] 
	[+] window DialogBox DlgStockSplitsMaybeMissing
		[ ] locator "Stock Splits May be Missing"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
	[ ] 
	[+] window DialogBox DlgUnlockYourPasswordVault
		[ ] locator "[@caption='Unlock your Password Vault' or @caption='Enter Password']"
		[+] StaticText UnlockYourPasswordVaultText
			[ ] locator "Unlock your Password Vault"
		[+] StaticText PasswordText
			[ ] locator "Password"
		[+] TextField PasswordTextField
			[ ] locator "Password"
		[+] PushButton UpdateNowButton
			[ ] locator "Update Now"
		[+] PushButton SkipButton
			[ ] locator "Skip"
		[+] PushButton SettingsButton
			[ ] locator "Settings"
		[ ] 
	[+] window DialogBox ResetVault
		[ ] locator "[@caption='Reset Vault']"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton OK  // Added by Abhijit S, Mar 2015
			[ ] locator "@windowid='1016'"
		[+] TextField Password
			[ ] locator "@windowid='1004'"
		[+] TextField ConfirmPassword
			[ ] locator "@windowid='1021'"
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin DlgQuickenOnePassword
		[ ] locator "Quicken One Password"
		[+] PushButton OKButton
			[ ] locator "OK"
	[ ] 
	[+] window DialogBox DlgEnterIntuitPassword
		[ ] locator "*Password"
		[+] TextField Password
			[ ] locator "@windowid='1004'"
		[+] PushButton Skip
			[ ] locator "@windowid='32766'"
		[+] PushButton UpdateNow
			[ ] locator "Update Now"
			[ ] 
		[+] PushButton UnlockYourPasswordVault2
			[ ] locator "@windowid='32765'"
		[+] PushButton Cancel
			[ ] locator "Cancel"
			[ ] 
		[ ] 
	[ ] 
	[+] window MainWin DlgConsolidatePassword
		[ ] locator "Consolidate your passwords?"
		[+] StaticText CosolidatePassword
			[ ] locator "@windowid='32702'" 
		[+] StaticText YouCurrentlyRequire
			[ ] locator "@windowid='65535'" 
		[+] StaticText RequireForQuicken
			[ ] locator "@windowid='102'" 
		[+] StaticText WouldYouLike
			[ ] locator "@windowid='103'" 
		[+] StaticText WhatWouldChange
			[ ] locator "@windowid='109'" 
		[+] StaticText YouWouldEnter
			[ ] locator "@windowid='111'" 
		[+] StaticText WhatWouldNo
			[ ] locator "@windowid='110'" 
		[+] StaticText YourPasswordVault
			[ ] locator "Your Password Vault still remains encrypted on your local computer and is never uploaded or shared with Intuit.'" 
		[ ] 
		[+] TextField Password
			[ ] locator "Enter your existing vault password to confirm:"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton Help
			[ ] locator "@windowid='32765'" 
			[ ] 
		[+] RadioList PasswordVaultOptions
			[ ] locator "@windowid='106'"
		[+] RadioList ExistingVaultOptions
			[ ] locator "@windowid='108'"
			[ ] 
[+] //------Wrong Password Alert in Consolidate Password dialog---------------- Added by Abhijit S,Mar 2105
	[+] window DialogBox WrongPasswordAlert
		[ ] locator "Quicken 20*"
		[+] StaticText PlesaeEnterCorrectPAssword
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //************* Home *************************************************************
	[+] window DialogBox CustomizeView
		[ ] locator "//DialogBox[@caption='Customize View']"
		[+] StaticText CustomizeViewText
			[ ] locator "Customize View"
		[+] StaticText ViewNameText
			[ ] locator "View Name:"
		[+] TextField ViewName
			[ ] locator "View Name:"
		[+] StaticText AvailableItemsText
			[ ] locator "Available Items:"
		[+] ListBox AvailableItemsListBox
			[ ] locator "//ListBox"
		[+] VerticalScrollBar VerticalScrollBar
			[ ] locator "//VerticalScrollBar"
		[+] PushButton Add
			[ ] // locator "Add ?"
			[ ] locator "Add »"
		[+] PushButton Remove
			[ ] locator "? Remove"
		[+] PushButton MoveUp
			[ ] locator "Move Up"
		[+] PushButton MoveDown
			[ ] locator "Move Down"
		[+] StaticText ChosenItems
			[ ] locator "Chosen Items:"
		[+] ListBox ChosenItemsListBox
			[ ] locator "//ListBox[2]"
		[+] StaticText AlertsRemindersAndScheduledBillsAndDeposits
			[ ] locator "Alerts, Reminders, and Scheduled Bills and Deposits"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] PushButton AlertsRemindersAndSchedul2
			[ ] locator "[@priorlabel='Alerts, Reminders, and Scheduled Bills and Deposits'][1]"
		[+] PushButton DeleteThisView
			[ ] locator "Delete this View"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[ ] 
	[ ] 
	[+] // window ChildWin Home
		[ ] // locator "Home"
		[+] // Control QWStayOnTopOfMonthlyBills
			[ ] // locator "[QWSnapHolder]$-1"
			[+] // StaticText StaticTextSMB
				[ ] // locator  "#2"
				[+] // Control Panel
					[ ] // locator  "[QWPanel]Panel"
					[+] // Control GetStarted
						[ ] // locator "1000"
					[+] // StaticText BILLANDINCOMEREMINDERSNE															// Udapted by Udita on 16 Oct 2012
						[ ] // locator  "1066"
						[+] // Control QWListViewer
							[ ] // locator "[QWListViewer]#1"
							[+] // ListBox ListBox
								[ ] // locator "#1|[ListBox]#1"
			[+] // StaticText StaticTextTSG
				[ ] // locator "#3"
				[+] // Control Panel
					[ ] // locator "[QWPanel]Panel"
					[+] // Control GetStarted
						[ ] // locator "$1000"
					[+] // Control Panel
						[ ] // locator  "[QWPanel]Panel"
					[+] // Control QWinChild
						[ ] // locator "[QWinChild]#1"
						[+] // Control MonthlyGoal
							[ ] // locator "$2400"
							[+] // ListBox ListBox
								[ ] // locator "#1"
				[+] // Control Budget
					[ ] // locator  "[QWinChild]Budget"
					[+] // Control Panel
						[ ] // locator "[QWPanel]Panel"
						[+] // StaticText Label
							[ ] // locator "$1861"
			[+] // StaticText SeeWhereYourMoneyGoes
				[ ] // locator "#1"
				[+] // Control Panel
					[ ] // locator "Panel"
					[+] // StaticText LAST30DAYSSPENDING
						[ ] // locator "$1002"
[ ] // 
[+] //************* Online ************************************************************
	[ ] // Dailog for Local File Testing
	[+] //OLD/ window MainWin FakeResponse
		[ ] // locator "/MainWin[@caption='Fake response from: https://preprod.ccore.intuit.com/CustomerCentral/api']"
		[+] // StaticText RecvaccDlg
			[ ] // locator "{chr(123)}recvacc.dlg{chr(125)}"
		[+] // ComboBox RecvaccDlgComboBox
			[ ] // locator "{chr(123)}recvacc.dlg{chr(125)}"
		[+] // TextField LocalFileSource
			[ ] // locator "{chr(123)}recvacc.dlg{chr(125)}"
		[+] // PushButton Browse
			[ ] // locator "@caption='Browse...'"
		[+] // StaticText IfYouWishToCancelPressCancel
			[ ] // locator "@caption='If you wish to cancel, press Cancel'"
		[+] // StaticText IfYouPressCancelTheFollowingOE
			[ ] // locator "@caption='If you press Cancel, the following OENetStatus will be used (default is what we always used before):'"
		[+] // ComboBox IfYouPressCancelTheFollowingOEComboBox
			[ ] // locator "@caption='If you press Cancel, the following OENetStatus will be used (default is what we always used before):'"
		[+] // PushButton Cancel
			[ ] // locator "@caption='Cancel'"
		[+] // PushButton Continue
			[ ] // locator "@caption='Continue'"
	[ ] 
	[+] window MainWin FakeResponse
		[ ] locator "/MainWin[@caption='Fake response from:*']"
		[+] StaticText RecvaccDlg
			[ ] locator "{chr(123)}recvacc.dlg{chr(125)}"
		[+] ComboBox RecvaccDlgComboBox
			[ ] locator "{chr(123)}recvacc.dlg{chr(125)}"
		[+] TextField RecvaccDlgTextField
			[ ] locator "{chr(123)}recvacc.dlg{chr(125)}"
		[+] PushButton Browse
			[ ] locator "@caption='Browse...'"
		[+] StaticText IfYouWishToCancelPressCancel
			[ ] locator "@caption='If you wish to cancel, press Cancel'"
		[+] StaticText IfYouPressCancelTheFollowingOE
			[ ] locator "@caption='If you press Cancel, the following OENetStatus will be used (default is what we always used before):'"
		[+] ComboBox IfYouPressCancelTheFollowingOEComboBox
			[ ] locator "@caption='If you press Cancel, the following OENetStatus will be used (default is what we always used before):'"
		[+] PushButton Cancel
			[ ] locator "@caption='Cancel'"
		[+] PushButton Continue
			[ ] locator "@caption='Continue'"
			[ ] 
		[ ] 
		[+] ComboBox LocalFileSource
			[ ] locator "@windowid='201'"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin LocalWebRequest
		[ ] locator "Local Web Request"
		[+] // Control HttpsCategorizationPlatformInt
			[ ] // locator "@caption='https://categorization.platform.intuit.com/categorize/categorize/v1/quicken'"
		[+] // Control GettingCategorizationInformation
			[ ] // locator "Getting Categorization information"
		[+] Control FailRequest
			[ ] locator "Fail Request"
		[+] // Control TokenTransactions0BJohn0314200
			[ ] // locator "token&transactions=0,B John,03-14-2008,-1.99;1,Don REFUND,02-20-2010,1.00;2,Jack,01-31-2010,-6.00;3,Jill Withdrawal,03-15-2010,-600.00;4,Mike Dividend,04-20-2010,1.69;5,Micky Refund,03-24-2010,100.00&appId=quicken"
		[+] // VerticalScrollBar VerticalScrollBar
			[ ] // locator "[1]"
		[+] // Control RequestContent
			[ ] // locator "Request Content"
		[+] // Control AcceptLanguageEnUs
			[ ] // locator "Accept-Language=en-us"
		[+] // Control HeaderPairs
			[ ] // locator "Header Pairs"
		[+] // Control POST
			[ ] // locator "POST"
		[+] // Control Method
			[ ] // locator "Method"
		[+] // Control SubmitRequestToServer
			[ ] // locator "Submit Request to Server"
		[+] // Control UseLocalResponse
			[ ] // locator "Use Local Response"
		[+] // Control FillFromFile
			[ ] // locator "Fill From File..."
		[+] // Control FillFromClipboard
			[ ] // locator "Fill From Clipboard"
		[+] // Control LocalResponse
			[ ] // locator "Local Response"
		[+] // Control RequestParameters
			[ ] // locator "Request Parameters"
		[ ] 
	[ ] 
	[+] window MainWin AccountsAdded
		[ ] locator "Accounts*Added"
		[+] PushButton Finish
			[ ] locator "@windowid='1003'"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // Dialog for ACE request
	[+] window MainWin QuickenLogFiles1
		[ ] locator "/MainWin[@caption='Quicken Log Files']"
		[+] Control QW_MDI_TOOLBAR
			[ ] locator "@windowClassName='QW_MDI_TOOLBAR'"
		[+] Control QWBrowserContainer
			[ ] locator "@windowClassName='QWBrowserContainer'"
		[+] StaticText Label
			[ ] locator "//StaticText"
		[+] Control ShellEmbedding
			[ ] locator "@windowClassName='Shell Embedding'"
		[+] Control ShellDocObjectView
			[ ] locator "@windowClassName='Shell DocObject View'"
		[+] Control InternetExplorer_Server
			[ ] locator "@windowClassName='Internet Explorer_Server'"
		[+] DialogBox ViewOFXLog
			[ ] locator "//DialogBox[@caption='View OFX Log']"
			[+] StaticText ViewOFXLog
				[ ] locator "@windowid='32702'"
			[+] TextField ViewOFXLogTextField
				[ ] locator "@caption='View OFX Log'"
			[+] ComboBox View
				[ ] locator "@caption='View'"
			[+] StaticText ViewLabel
				[ ] locator "@caption='View'"
			[+] PushButton SaveAs
				[ ] locator "@caption='Save As...'"
			[+] PushButton Close
				[ ] locator "@caption='Close'"
	[ ] 
	[ ] //Quicken Browser Window
	[+] window MainWin QuickenBrowser
		[ ] locator "@windowClassName='QWinPopup'"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //************* Property & Debt ***************************************************
	[ ] // Property & Debt
	[+] window Control MDIClientPropertyDebt
		[ ] locator "@windowClassName='MDIClient'"
		[+] Control PropertyDebtWindow
			[ ] locator "@windowClassName='QWMDI'"
			[+] ComboBox AllAccountsNetWorth
				[ ] locator "@windowid='100' or @windowid='105' or @windowid='108' "
			[+] ComboBox EarliestToDate
				[ ] locator "@windowid='101'"
			[+] ComboBox Interval
				[ ] locator "@windowid='103'"
			[+] Control QWSnapHolder
				[ ] locator "@windowClassName='QWSnapHolder'"
			[+] StaticText NetWorthSnap
				[ ] //locator "@windowid='101'"
				[ ] locator "[2]"
				[ ] 
				[+] Control QWGraphControl
					[ ] locator "@windowClassName='QWGraphControlClass'"
					[ ] //locator "@windowid='-1'"
				[+] StaticText NetWorthOptions
					[+] PushButton NetWorthSummaryReport
						[ ] locator "@windowid='30002'"
						[ ] 
			[+] StaticText NetWorthAccountTypeSnap
				[ ] //locator "@windowid='-1'"
				[ ] locator "[5]"
				[+] Control QWGraphControl
					[ ] locator "@windowClassName='QWGraphControlClass'"
					[ ] //locator "@windowid='1000'"
					[ ] 
				[+] StaticText AccountTypeOptions
					[+] PushButton AccountBalancesReport
						[ ] locator "@windowid='500'"
					[ ] 
				[ ] 
			[+] StaticText DebtBalanceGraphText
				[ ] locator "//StaticText[3]"
			[+] StaticText LiabilityGraphText
				[ ] locator "//StaticText[5]"
				[+] // StaticText DebtBalanceGraphText
					[ ] // locator "@windowid='31000'"
				[+] // StaticText LiabilityGraphText
					[ ] // locator "[@windowid='31000']"
					[ ] 
			[+] ComboBox AllAccountsProperty
				[ ] locator "@windowid='105'"
			[+] PushButton PropertyOptions
				[ ] locator "@windowid='106'"
			[+] PushButton LoanandDebtOptions
				[ ] locator "@windowid='112'"
			[+] Control tooltip
				[+] ListBox ListBox1
					[ ] locator "@windowClassName='ListBox'"
			[+] StaticText ZeroDataStateMessage1
				[ ] locator "[@caption='Not*'][1]"
			[+] StaticText ZeroDataStateMessage2
				[ ] locator "[@caption='Not*'][2]"
			[+] Control QWGraphControlClass
				[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] StaticText DateRangeMessage
				[ ] //locator "[3]"
				[ ] locator "[@windowid='31000'][1]"
			[+] ListBox ListBox
				[ ] locator "/Control[@caption='Quicken 2015 Rental Property Manager - PropertyDebt - [Property & Debt]']//ListBox"
			[+] ComboBox AllAccountsDebt
				[ ] locator "@windowid='108'"
			[+] ComboBox Dates
				[ ] locator "@windowid='109'"
			[+] ComboBox IntervalDropDown
				[ ] locator "@windowid='111'"
			[+] Control SelectedAssetAccount
				[ ] locator "@windowClassName='QWSnapHolder'"
				[ ] 
			[+] //StaticText SelectedAssetAccount
				[ ] //locator "@windowid='-1'"
			[+] Control QWinChild
				[ ] locator "@windowClassName='QWinChild'"
				[+] StaticText ZeroData
					[ ] locator "There is no data for this item to display."
				[+] Control QWPanel
					[ ] locator "@windowClassName='QWPanel'"
					[+] PushButton Asset
						[ ] locator "@windowid='100'"
					[+] PushButton AddLoan
						[ ] locator "@windowid='104'"
						[ ] 
					[+] Control QWListViewer
						[ ] locator "@windowClassName='QWListViewer'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
							[ ] 
							[ ] 
			[+] Control QWinChild1
				[ ] locator "@windowClassName='QWinChild'"
				[+] Control QWListViewer
					[ ] locator "@windowClassName='QWListViewer'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
				[+] Control QWGraphControlClass
					[ ] locator "@windowClassName='QWGraphControlClass'"
			[ ] 
	[+] window MainWin EquityAssetWindow
		[ ] locator "@windowClassName='QWinDlg'"
		[+] PushButton Done
			[ ] locator "Done"
		[+] StaticText EquityAssetTitle
			[ ] locator "@windowid='100'"
		[+] PushButton OptionsButton
			[ ] locator "@windowid='1000'"
		[+] StaticText Label
			[ ] locator "[2]"
		[+] StaticText Label3
			[ ] locator "[3]"
		[+] // StaticText Label
			[ ] // locator "[2]"
		[+] // StaticText Label1
			[ ] // locator "@windowid='-1'"
			[+] // StaticText DefaultDateRange
				[ ] // locator "@windowid='31000'"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] Control QWGraphControlClass
			[ ] locator "@windowClassName='QWGraphControlClass'"
		[+] MainWin xWindow
			[ ] locator "@windowClassName='QWListViewer'"
		[+] MainWin Customize
			[ ] locator "Customize"
			[+] PushButton Cancel
				[ ] locator "Cancel"
			[+] MainWin Category
				[ ] locator "Category"
			[+] PushButton ClearAll
				[ ] locator "Clear All"
			[+] PushButton CollapseAll
				[ ] locator "Collapse All"
			[+] StaticText DateRange
				[ ] locator "Date range:"
			[+] ComboBox DateRangeComboBox
				[ ] locator "@windowid='102'"
			[+] PushButton ExpandAll
				[ ] locator "Expand All"
			[+] StaticText From
				[ ] locator "From:"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton SelectAll
				[ ] locator "Select All"
			[+] Group SelectCategories
				[ ] locator "Select Categories"
			[+] CheckBox ShowHiddenCategories
				[ ] locator "Show (hidden categories)"
			[+] StaticText To
				[ ] locator "To:"
			[+] StaticText TypeCategoryNameToSearchList
				[ ] locator "Type category name to search list:"
			[+] PushButton TypeCategoryNameToSearchListPushButton
				[ ] locator "@priorlabel='Type category name to search list:'"
			[+] TextField TypeCategoryNameToSearchListTextField
				[ ] locator "Type category name to search list:"
			[+] VerticalScrollBar VerticalScrollBar
				[ ] locator "//VerticalScrollBar"
			[+] StaticText x622014
				[ ] locator "@caption='6/2/2014'"
			[+] StaticText x632013
				[ ] locator "@caption='6/3/2013'"
		[ ] 
	[+] window MainWin AddLoanAccount
		[ ] locator "Add Loan Account"
		[+] StaticText AddLoanAccount
			[ ] locator "Add Loan Account"
		[+] StaticText EnterTheNameOfYourLoanProvider
			[ ] locator "Enter the name of your loan provider"
		[+] TextField EnterTheNameOfYourLoanProviderTextField
			[ ] locator "Enter the name of your loan provider"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] PushButton Next
			[ ] locator "Next"
		[+] PushButton OrChooseFromThesePopularProviders
			[ ] locator "@priorlabel='Or choose from these popular providers'"
		[+] StaticText OrChooseFromThesePopularProvidersLabel
			[ ] locator "Or choose from these popular providers"
		[+] Control Panel
			[ ] locator "Panel"
		[+] StaticText ProviderNotOnTheListPreferNotToDownload
			[ ] locator "Provider not on the list? Prefer not to download?"
		[+] Control QWHtmlView
			[ ] locator "@windowClassName='QWHtmlView'"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
		[+] PushButton Cancel
			[ ] locator "@windowid='1004'"
			[ ] 
	[+] window MainWin AddCreditCardAccount
		[ ] locator "Add Credit Card Account"
		[+] StaticText AddCreditCardAccount
			[ ] locator "Add Credit Card Account"
		[+] StaticText BankNotOnTheListPreferNotToDow
			[ ] locator "Bank not on the list? Prefer not to download? Interested in advanced connection methods?"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] StaticText EnterTheNameOfYourBank
			[ ] locator "Enter the name of your bank"
		[+] TextField EnterTheNameOfYourBankTextField
			[ ] locator "Enter the name of your bank"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] PushButton Next
			[ ] locator "Next"
		[+] PushButton OrChooseFromThesePopularBanks
			[ ] locator "@priorlabel='Or choose from these popular banks'"
		[+] StaticText OrChooseFromThesePopularBanksLabel
			[ ] locator "Or choose from these popular banks"
		[+] Control Panel
			[ ] locator "Panel"
		[+] Control QWHtmlView
			[ ] locator "@windowClassName='QWHtmlView'"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
	[+] window MainWin AccountPopUpRegister
		[ ] locator "@windowClassName='QWinPopup'"
		[+] StaticText AccountName      
			[ ] locator "@windowid='32702'"	
		[+] Control LoanBalance
			[ ] locator "@windowid='17102'"
			[ ] 				              
			[ ] 
			[ ] //////////////////////////////////////////////////////////////
		[ ] 
	[ ] 
	[ ] // Property & Debt > Refinance Calculator
	[+] window DialogBox RefinanceCalculator
		[ ] locator "Refinance Calculator"
		[+] StaticText RefinanceCalculator
			[ ] locator "Refinance Calculator"
		[+] StaticText ExistingMortgage
			[ ] locator "Existing Mortgage"
		[+] StaticText MonthlyPaymentTotal
			[ ] locator "Monthly Payment(total):"
		[+] TextField ExistingMortgageTextField
			[ ] locator "Existing Mortgage"
		[+] StaticText ImpoundEscrowAmount
			[ ] locator "@caption='Impound/escrow amount:'"
		[+] TextField ImpoundEscrowAmountTextField
			[ ] locator "@caption='Impound/escrow amount:'"
		[+] StaticText MonthlyPrincipalInterestPaid
			[ ] locator "[@caption='Monthly principal/interest paid:'][1]"
		[+] StaticText Calculated
			[ ] locator "[@caption='<calculated>'][1]"
		[+] StaticText Label
			[ ] locator "[7]"
		[+] StaticText ProposedMortgage
			[ ] locator "Proposed Mortgage"
		[+] StaticText PrincipalAmount
			[ ] locator "Principal Amount:"
		[+] TextField PrincipalAmountTextField
			[ ] locator "Principal Amount:"
		[+] StaticText Years
			[ ] locator "Years:"
		[+] TextField YearsTextField
			[ ] locator "Years:"
		[+] StaticText InterestRate
			[ ] locator "Interest Rate:"
		[+] TextField InterestRateTextField
			[ ] locator "Interest Rate:"
		[+] StaticText MortgageClosingCosts
			[ ] locator "Mortgage Closing Costs:"
		[+] TextField MortgageClosingCostsTextField
			[ ] locator "Mortgage Closing Costs:"
		[+] StaticText MortgagePoints
			[ ] locator "Mortgage Points:"
		[+] TextField MortgagePointsTextField
			[ ] locator "Mortgage Points:"
		[+] StaticText Label14
			[ ] locator "[14]"
		[+] PushButton Calculate
			[ ] locator "Calculate"
		[+] StaticText BreakEvenAnalysis
			[ ] locator "Break Even Analysis"
		[+] StaticText TotalClosingCosts
			[ ] locator "Total Closing Costs:"
		[+] StaticText Calculated2
			[ ] locator "[@caption='<calculated>'][2]"
		[+] StaticText MonthlyPrincipalInterestPaid2
			[ ] locator "[@caption='Monthly principal/interest paid:'][2]"
		[+] StaticText Calculated3
			[ ] locator "[@caption='<calculated>'][3]"
		[+] StaticText MonthlySavings
			[ ] locator "Monthly savings:"
		[+] StaticText Calculated4
			[ ] locator "[@caption='<calculated>'][4]"
		[+] StaticText MonthsToBreakEven
			[ ] locator "Months to break even:"
		[+] StaticText Calculated5
			[ ] locator "[@caption='<calculated>'][5]"
		[+] StaticText Label24
			[ ] locator "[24]"
		[+] PushButton BreakEvenAnalysisPushButton
			[ ] locator "@priorlabel='Break Even Analysis'"
		[+] PushButton Done
			[ ] locator "Done"
	[ ] 
	[ ] // Property & Debt > Loan Calculator
	[+] window DialogBox LoanCalculator
		[ ] locator "Loan Calculator"
		[+] StaticText LoanCalculator
			[ ] locator "Loan Calculator"
		[+] StaticText Calculate
			[ ] locator "Calculate:"
		[+] RadioList LoanAmount
			[ ] locator "Loan amount"
		[+] RadioList PaymentPerPeriod
			[ ] locator "Payment per period"
		[+] StaticText AnnualInterestRate
			[ ] locator "Annual interest rate:"
		[+] TextField AnnualInterestRateTextField
			[ ] locator "Annual interest rate:"
		[+] StaticText NumberOfYears
			[ ] locator "Number of years:"
		[+] TextField NumberOfYearsTextField
			[ ] locator "Number of years:"
		[+] StaticText PeriodsPerYear
			[ ] locator "Periods per year:"
		[+] TextField PeriodsPerYearTextField
			[ ] locator "Periods per year:"
		[+] StaticText CompoundingPeriod
			[ ] locator "Compounding period:"
		[+] ComboBox CompoundingPeriodComboBox
			[ ] locator "Compounding period:"
		[+] StaticText LoanAmountLabel
			[ ] locator "Loan amount:"
		[+] TextField LoanAmountTextField
			[ ] locator "Loan amount:"
		[+] StaticText Payment
			[ ] locator "Payment:"
		[+] PushButton ViewSchedule
			[ ] locator "View Schedule..."
		[+] PushButton CalculatePushButton
			[ ] locator "Calculate"
		[+] PushButton PaymentPushButton
			[ ] locator "@priorlabel='Payment:'"
		[+] PushButton Done
			[ ] locator "Done"
		[+] StaticText CALCULATED
			[ ] locator "CALCULATED"
	[ ] 
	[ ] // Property & Debt > Net Worth
	[+] window DialogBox NetWorth
		[ ] locator "Net Worth"
		[+] Control QWListViewer1
			[ ] locator "[QWListViewer]#1"
			[+] ListBox ListBox1
				[ ] locator "#1"
	[+] window MainWin AssetsLiabilitiesWindow
		[ ] locator "Assets*Liabilities"
		[+] PushButton Done
			[ ] locator "Done"
		[+] Control Panel
			[ ] locator "@windowClassName='QWPanel'"
			[+] Control QWChild
				[ ] locator "@windowClassName='QWinChild'"
				[+] StaticText NetWorthText
					[ ] locator "@windowid='103'"
				[+] StaticText AsOfDateText
					[ ] locator "@windowid='107'"
				[+] StaticText TotalNoOfAccountText
					[ ] locator "@windowid='104'"
				[ ] 
				[ ] 
		[+] StaticText AssetLiabilities
			[ ] locator "[@caption='Assets*']"
	[+] window MainWin CustomizeWindow
		[ ] locator "Customize"
		[+] Control AccountOrderQWListViewer
			[ ] locator "@windowid='401'"
			[ ] 
		[+] PushButton SelectAllButton
			[ ] locator "@windowid='403'"
		[+] PushButton ClearAllButton
			[ ] locator "@windowid='404'"
		[+] CheckBox ShowHiddenAccount
			[ ] locator "@windowid='405'"
		[+] MainWin AccountListQWListViewer
			[ ] locator "@windowid='402'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton OKButton
			[ ] locator "OK"
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[ ] 
[ ] 
[+] //************* Reports ***********************************************************
	[ ] 
	[ ] 
	[ ] 
	[ ] //--------------All Banking Reports objects-------------
	[+] window MainWin BankingSummary
		[ ] //locator "/Control[@caption='Quicken 2014 Rental Property Manager - AccountListFI - [Home]']//MainWin[@caption='Banking Summary']"
		[ ] locator "//MainWin[@caption='Banking Summary']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Column:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[+] window MainWin CustomizeReport
		[ ] locator "Customize*"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
		[+] PushButton OKButton
			[ ] locator "OK"
			[ ] 
		[+] PushButton CancelButton
			[ ] locator "Cancel"
		[+] PushButton ClearAllButton
			[ ] locator "Clear All"
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin CashFlow
		[ ] //locator "/Control[@caption='Quicken 2014 Rental Property Manager - AccountListFI - [Home]']//MainWin[@caption='Banking Summary']"
		[ ] locator "//MainWin[@caption='Cash Flow']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin CashFlowByTag
		[ ] //locator "/Control[@caption='Quicken 2014 Rental Property Manager - AccountListFI - [Home]']//MainWin[@caption='Banking Summary']"
		[ ] locator "//MainWin[@caption='Cash Flow by Tag']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin MissingChecks
		[ ] locator "//MainWin[@caption='Missing Checks']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin TransactionReports
		[ ] locator "Transaction"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "@windowid='73'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
			[ ] 
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] ComboBox DateRange
				[ ] locator "@windowid='1000'"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin MyTransactionReport
		[ ] locator "//MainWin[@caption='My Transaction Report' or @caption='My Itemized Payees' or @caption='Account Balances_2007_Premier']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin[@windowid='73']"
			[+] ListBox ListBox1
				[ ] locator "//ListBox[@windowid='1']"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox DateRangeComboBox
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin PayeeReport
		[ ] locator "Payee Report"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] ComboBox DateRange
				[ ] locator "@windowid='1000'"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[ ] //------------All Comparison Reports objects------------
	[+] window MainWin CurrentVsAverageSpendingByCategory
		[ ] locator "//MainWin[@caption='Current Spending vs. Average Spending by Category']"
		[+] Control QW_BAG_TOOLBAR
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
		[+] Control QW_MAIN_TOOLBAR
			[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox
				[ ] locator "[1]"
		[+] Control QWCustomizeBar
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "#1"
					[+] ListBox ListBox1
						[ ] locator "#1"
	[ ] 
	[+] window MainWin CurrentVsAverageSpendingByPayee
		[ ] locator "//MainWin[@caption='Current Spending vs. Average Spending by Payee']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "#1"
					[+] ListBox ListBox1
						[ ] locator "#1"
	[ ] 
	[+] window MainWin CashFlowComparison
		[ ] //locator "/Control[@caption='Quicken 2014 Rental Property Manager - AccountListFI - [Home]']//MainWin[@caption='Banking Summary']"
		[ ] locator "//MainWin[@caption='Cash Flow Comparison']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin IncomeExpenseComparisonByC
		[ ] locator "//MainWin[@caption='Income?Expense Comparison by Category']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin IncomeExpenseComparisonByP
		[ ] locator "//MainWin[@caption='Income?Expense Comparison by Payee']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin ProfitAndLossComparison
		[ ] locator "//MainWin[@caption='Profit and Loss Comparison']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "//ComboBox"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
			[ ] 
	[ ] 
	[ ] 
	[ ] //--------All NetWorth&Balances Reports objects--------
	[+] window MainWin AccountBalances
		[ ] locator "//MainWin[@caption='Account Balances']"
		[+] Control QW_BAG_TOOLBAR
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
		[+] Control QW_MAIN_TOOLBAR
			[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Interval
				[ ] locator "Interval"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "#1"
					[+] ListBox ListBox1
						[ ] locator "#1"
	[ ] 
	[+] window MainWin NetWorthReports
		[ ] locator "[@caption='Net Worth']"
		[+] Control QW_BAG_TOOLBAR
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
		[+] Control QW_MAIN_TOOLBAR
			[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] PushButton ShowReport
			[ ] locator "Show Report"
			[ ] 
		[+] MainWin QWListViewer1
			[ ] locator "@windowid='73'"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Interval
				[ ] locator "Interval"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[1]"
					[+] ListBox ListBox1
						[ ] locator "[1]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[ ] 
	[ ] 
	[ ] 
	[ ] //----------------All Spending report objects-----------------
	[+] window MainWin ItemizedCategories
		[ ] locator "//MainWin[@caption='Itemized Categories']"
		[+] Control QW_BAG_TOOLBAR
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
		[+] Control QW_MAIN_TOOLBAR
			[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton UpdateToShow
			[ ] locator "Update to Show"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control SortBy
				[ ] locator "S&ort by:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin ItemizedPayees
		[ ] locator "//MainWin[@caption='Itemized Payees']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer1
			[ ] locator "#1"
			[+] ListBox ListBox1
				[ ] locator "#1"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control SortBy
				[ ] locator "S&ort by:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin ItemizedTags
		[ ] locator "//MainWin[@caption='Itemized Tags']"
		[+] Control QW_BAG_TOOLBAR
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
		[+] Control QW_MAIN_TOOLBAR
			[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer1
			[ ] locator "#1"
			[+] ListBox ListBox1
				[ ] locator "#1"
		[+] Control QWCustomizeBar
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control SortBy
				[ ] locator "S&ort by:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin SpendingByCategory
		[ ] locator "//MainWin[@caption='Spending by Category']"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin SpendingByPayee
		[ ] locator "//MainWin[@caption='Spending by Payee']"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "D&ate range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin SCurrentVsAverageSpendingByCategory
		[ ] locator "//MainWin[@caption='Current Spending vs. Average Spending by Category']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin SCurrentVsAverageSpendingByPayee
		[ ] locator "//MainWin[@caption='Current Spending vs. Average Spending by Payee']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin IncomeExpenseByCategory
		[ ] locator "//MainWin[@caption='Income/Expense by Category']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Interval
				[ ] locator "Inter&val:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
		[+] Control QWGraphControlClass
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin IncomeExpenseByPayee
		[ ] locator "//MainWin[@caption='Income/Expense by Payee']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Interval
				[ ] locator "Inter&val:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
		[+] Control QWGraphControlClass
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin CurrentBudget
		[ ] locator "//MainWin[@caption='Current Budget']"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Budget
				[ ] locator "Budget:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control BudgetYear
				[ ] locator "Budget Year:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
			[+] Control InterVal
				[ ] locator "Inter&val:"
			[+] ComboBox PopupList4
				[ ] locator "[4]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[ ] 
	[ ] 
	[+] window MainWin HistoricalBudget
		[ ] locator "//MainWin[@caption='Historical Budget']"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Budget
				[ ] locator "Budget:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control BudgetYear
				[ ] locator "Budget Year:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
			[+] Control InterVal
				[ ] locator "Inter&val:"
			[+] ComboBox PopupList4
				[ ] locator "[4]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //----------------All Investing Report objects-------------------
	[+] window MainWin CapitalGains
		[ ] locator "Capital Gains"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
	[ ] 
	[+] window MainWin InvestingActivity
		[ ] locator "Investing Activity"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin AssetAllocation
		[ ] locator "Asset Allocation"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin InvestmentIncome
		[ ] locator "Investment Income"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin InvestmentPerformance
		[ ] locator "Investment Performance"
		[ ] 
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin InvestmentTransactions
		[ ] locator "Investment Transactions"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[ ] 
	[ ] 
	[+] window MainWin MaturityDatesForBondsAndCDs
		[ ] locator "Maturity Dates for Bonds and CDs"
		[ ] 
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
	[ ] 
	[+] window MainWin PortfolioValue
		[ ] locator "Portfolio Value"
		[ ] 
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[+] window MainWin PortfolioValueAndCostBasis
		[ ] locator "Portfolio Value and Cost Basis"
		[ ] 
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control CompareTo
				[ ] locator "Compare &to: "
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control SubtotalBy
				[ ] locator "Subtota&l by:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[ ] 
	[ ] //-------------------All Business Report objects-----------------
	[+] window MainWin APByVendor
		[ ] locator "A?P by Vendor"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin ARByCustomer
		[ ] locator "A?R by Customer"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin BalanceSheet
		[ ] locator "Balance Sheet"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin ProfitAndLossStatement
		[ ] locator "Profit and Loss Statement"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[ ] 
		[ ] 
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[ ] 
		[+] Control DateRange
			[ ] locator "Date range:"
		[+] ComboBox PopupList1
			[ ] locator "[1]"
		[+] Control QWLabel2
			[ ] locator " "
		[+] ComboBox PopupList2
			[ ] locator "[2]"
	[ ] 
	[+] window MainWin ProjectJobByBusinessTag
		[ ] locator "Project?Job by Business Tag"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
	[ ] 
	[+] window MainWin ProjectJobByProject
		[ ] locator "Project?Job by Project"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Column
				[ ] locator "Co&lumn:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
		[ ] 
	[ ] 
	[+] window MainWin ScheduleCReport
		[ ] locator "Schedule C Report"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] Control QWCustomizeBar1
			[ ] locator"@windowid='5000'"
			[+] Control TaxYear
				[ ] locator "Tax year:"
			[+] ComboBox PopupList1
				[ ] locator"[@windowid='1016' or @windowid='1000']"
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin TaxSchedule
		[ ] locator "Tax Schedule"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control SortBy
				[ ] locator "S&ort by:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
		[ ] 
	[ ] 
	[ ] //Business > Unpaid Invoices List
	[+] window MainWin DlgUnpaidInvoices
		[ ] locator "Unpaid Invoices"
		[+] Control QW_MDI_TOOLBAR1
			[ ] locator "@windowClassName='QW_MDI_TOOLBAR'"
		[+] StaticText SelectAccountText
			[ ] locator "Select account:"
		[+] ComboBox SelectAccountPopupList
			[ ] locator "Select account:"
		[+] MainWin SelectAccountQWListViewer
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //----------------All Tax Report objects--------------------------
	[+] window MainWin ScheduleA
		[ ] locator "Schedule A-Itemized Deductions"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] Control QWCustomizeBar1
			[ ] locator"@windowid='5000'"
			[+] Control TaxYear
				[ ] locator "Tax year:"
			[+] ComboBox PopupList1
				[ ] locator"[@windowid='1016' or @windowid='1000']"
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin ScheduleB
		[ ] locator "Schedule B-Interest and Dividends"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] Control QWCustomizeBar1
			[ ] locator"@windowid='5000'"
			[+] Control TaxYear
				[ ] locator "Tax year:"
			[+] ComboBox PopupList1
				[ ] locator"[@windowid='1016' or @windowid='1000']"
	[ ] 
	[+] window MainWin ScheduleD
		[ ] locator "Schedule D-Capital Gains and Losses"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] Control QWCustomizeBar1
			[ ] locator"@windowid='5000'"
			[+] Control TaxYear
				[ ] locator "Tax year:"
			[+] ComboBox PopupList1
				[ ] locator"[@windowid='1016' or @windowid='1000']"
		[ ] 
	[ ] 
	[+] window MainWin TaxScheduleReport
		[ ] locator "Tax Schedule"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
	[ ] 
	[+] window MainWin TaxSummary
		[ ] locator "Tax Summary"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton HideReport
			[ ] locator "Hide Report"
		[+] PushButton HideGraph
			[ ] locator "Hide Graph"
		[+] MainWin QWListViewer1
			[ ] locator "[1]"
			[+] ListBox ListBox1
				[ ] locator "[1]"
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] Control DateRange
				[ ] locator "Date range:"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[+] Control Budget
				[ ] locator "Budget:"
			[+] ComboBox PopupList2
				[ ] locator "[2]"
			[+] Control BudgetYear
				[ ] locator "Budget Year:"
			[+] ComboBox PopupList3
				[ ] locator "[3]"
			[+] Control InterVal
				[ ] locator "Inter&val:"
			[+] ComboBox PopupList4
				[ ] locator "[4]"
		[+] Control QWGraphControlClass1
			[ ] locator "@windowClassName='QWGraphControlClass'"
			[+] Control Panel
				[ ] locator "Panel"
				[+] MainWin QWListViewer1
					[ ] locator "[2]"
					[+] ListBox ListBox1
						[ ] locator "[2]"
	[ ] 
	[ ] 
	[ ] //---------------All RentalProperty Report objects---------------
	[+] window MainWin ScheduleEReportWindow
		[ ] locator "//MainWin[@caption='Schedule E Report']"
		[+] Control QW_BAG_TOOLBAR1
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
			[+] Control QW_MAIN_TOOLBAR1
				[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] PushButton Edit
			[ ] locator "Edit"
		[+] PushButton ExpandAll
			[ ] locator "Expand All"
		[+] PushButton CollapseAll
			[ ] locator "Collapse All"
		[+] MainWin QWListViewer
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[+] MainWin QWListViewer1
			[ ] locator "//MainWin"
			[+] ListBox ListBox1
				[ ] locator "//ListBox"
			[+] HorizontalScrollBar ScrollBar1
				[ ] locator "//HorizontalScrollBar"
			[+] PushButton FileYourTaxesWithTurboTax
				[ ] locator "File your taxes with TurboTax"
		[ ] 
		[ ] 
		[+] Control QWCustomizeBar1
			[ ] locator "@windowClassName='QWCustomizeBar'"
			[+] ComboBox PopupList1
				[ ] locator "[1]"
			[ ] 
		[+] Control DateRange
			[ ] locator "Date range:"
		[+] ComboBox PopupList1
			[ ] locator "[1]"
		[+] Control QWLabel2
			[ ] locator " "
		[+] ComboBox PopupList2
			[ ] locator "[2]"
	[ ] 
	[ ] 
	[ ] //------Dialog boxes invoked from transaction report from register------
	[+] window DialogBox RetagTransactions
		[ ] locator "Retag transactions"
		[+] TextField TagS
			[ ] locator "Tag(s)"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] Control RetagTheSelectedTransaction2
			[ ] locator "@windowClassName='QFBag'"
			[+] PushButton PushButton
				[ ] locator "[3]"
			[+] PushButton PushButton4
				[ ] locator "[4]"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox RecategorizeTransactions
		[ ] locator "Recategorize transactions"
		[+] TextField CategoryTextField
			[ ] locator "Category:"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] Control RecategorizeTheSelectedTran2
			[ ] locator "@windowClassName='QFBag'"
			[+] PushButton RecategorizeTheSelectedTransactionAsPushButton
				[ ] locator "[@priorlabel='Recategorize the selected transaction as:'][3]"
			[+] PushButton RecategorizeTheSelectedTransactionAsPushButton4
				[ ] locator "[@priorlabel='Recategorize the selected transaction as:'][4]"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox RenamePayee
		[ ] locator "Rename Payee"
		[+] TextField PayeeName
			[ ] locator "Payee:"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[+] Control RenameThePayeeForTheSelec2
			[ ] locator "@windowClassName='QFBag'"
			[+] PushButton RenameThePayeeForTheSelectedTransactionPushButton
				[ ] locator "[@priorlabel='Rename the payee for the selected transaction'][3]"
			[+] PushButton RenameThePayeeForTheSelectedTransactionPushButton4
				[ ] locator "[@priorlabel='Rename the payee for the selected transaction'][4]"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox EditMemo
		[ ] locator "Edit Memo"
		[+] TextField EditMemoTextField
			[ ] locator "with the following memo:"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[-] //************* Bills **************************************************************
	[ ] 
	[ ] //------Bills------------
	[+] window Control Bills	
		[ ] locator "Bills"
		[+] CheckBox IncludePaid
			[ ] locator "//CheckBox[@caption='Include Paid']"
		[+] Control Panel
			[ ] locator "@caption='Panel[1]'"						
			[+] Control QWMsHtmlVw1
				[ ] locator "@windowClassName='QWMsHtmlVw'"
				[+] Control ShellEmbedding1
					[ ] locator "@windowClassName='Shell Embedding'"
					[+] Control ShellDocObjectView1
						[ ] locator "@windowClassName='Shell DocObject View'"
						[+] Control GetStartedBillsButton
							[ ] locator "@windowClassName='Internet Explorer_Server'"
			[+] Control Panel1
				[ ] locator "@caption='Panel[6]'"
				[+] Control QWinChild
					[ ] locator "@windowClassName='QWinChild[2]'"
					[+] PushButton GoToRegisterButton
						[ ] locator "@caption='Go to Register'"
					[+] PushButton WebsiteLink
						[ ] locator "@windowid='1003'"
					[+] PushButton Enter
						[ ] locator "@caption='Enter'"
					[+] PushButton Skip
						[ ] locator "@caption='Skip'"
					[+] PushButton Edit
						[ ] locator "@caption='Edit[1]'"
					[+] PushButton ShowHistory
						[ ] locator "@caption='Show History'"
					[ ] 
				[+] Control QWinChild1
					[ ] locator "@windowClassName='QWinChild[2]'"
					[+] PushButton EnterButton
						[ ] locator "@caption='Enter'"
					[+] PushButton SkipButton
						[ ] locator "@caption='Skip'"
					[+] PushButton Edit
						[ ] locator "@caption='Edit[1]'"
					[+] PushButton ShowHistory
						[ ] locator "@caption='Show History'"
					[ ] 
			[+] Control Panel2
				[ ] locator "@windowid='-1[2]'"
				[+] Control QWinChild1
					[ ] locator "@windowid='0'"
					[+] Control Panel
						[ ] locator "@windowid='-1'"
						[+] Control Panel1
							[ ] locator "@windowid='-1[1]'"
						[+] Control Panel2
							[ ] locator "@windowid='-1[2]'"
							[+] Control Panel
								[ ] locator "@windowid='-1'"
								[ ] 
			[ ] 
		[+] StaticText ViewAsText		
			[ ] locator "@caption='View as'"								
		[+] ComboBox ViewAsPopupList	
			[ ] locator "@windowid=101"							    
		[+] StaticText AccountTextStaticText	
			[ ] locator "@caption='Account'"						    
		[+] ComboBox AccountPopupList	
			[ ] locator "@windowid='108'"								  
		[+] StaticText DueWithinNextTextStaticText	
			[ ] locator "@caption='Due within next'"				 
		[+] ComboBox DueWithinNextPopupList
			[ ] locator "@windowid='103'"							 
		[+] StaticText ViewAs2TextStaticText
			[ ] locator "@windowid='-1'"								
			[+] Control ViewAsSubTextStaticText	
				[+] MainWin ViewAsQWListViewer	
					[ ] locator "@windowid=1"					             
					[+] ListBox ReminderListBox	
						[ ] locator "@windowid=1"				
				[ ] 
		[+] PushButton SyncToOutlookButton	
			[ ] locator"@caption='Sync to Outlook'"			
		[+] Control Calendar	
			[ ] locator "@caption='Calendar'"
			[+] Control Panel
				[ ] locator "@windowid='-1'"
				[+] StaticText PanelText1
					[ ] locator "@windowid='-1'"
					[+] StaticText PanelText2
						[ ] locator "@windowid='-1'"
						[+] PushButton AddReminderButton
							[ ] locator "@windowid='518'"
						[+] PushButton ManageRemindersrButton
							[ ] locator "@windowid='507'"
							[ ] 
						[ ] 
						[ ] 
				[ ] 
			[ ] 
		[+] PushButton PreviousMonth
			[ ] locator "@windowid='32351'"
		[+] StaticText MonthSelectorText
			[ ] locator "@windowid='32352'"
		[+] PushButton NextMonth
			[ ] locator "@windowid='32353'"
		[+] PushButton Enter
			[ ] locator "Enter"
		[ ] 
	[ ] 
	[ ] //------Bill > Enter > Enter Expense Transaction------------
	[+] window DialogBox EnterTransaction											
		[ ] locator "//DialogBox[@caption='Enter*transaction']"
		[+] StaticText EnterIncomeTransactionText
			[ ] locator "@windowid='32702'"
		[+] StaticText N1Text
			[ ] locator "@windowid='10400'"
		[+] StaticText RequiredFieldsText
			[ ] locator "@windowid='10401'"
		[+] StaticText PayeeInformationText
			[ ] locator "@windowid='10404'"
		[+] StaticText PayeeText
			[ ] locator "@windowid='10301'"
		[+] StaticText N2Text
			[ ] locator "@windowid='10406'"
		[+] TextField PayeeInformation
			[ ] locator "@windowid='10202'"
		[+] StaticText CategoryText
			[ ] locator "@windowid='10306'"
		[+] TextField Category
			[ ] locator "@windowid='10204'"
		[+] PushButton Split
			[ ] locator "@windowid='10207'"
		[+] StaticText TagText
			[ ] locator "@windowid=''10216'"
		[+] TextField Tag
			[ ] locator "@windowid='10217'"
		[+] StaticText MemoText
			[ ] locator "@windowid='10302'"
		[+] TextField Memo
			[ ] locator "@windowid='10203'"
		[+] StaticText PaymentInformationText
			[ ] locator "@windowid='10412'"
		[+] StaticText AccountToUseText
			[ ] locator "@windowid='10413'"
		[+] ComboBox PaymentInformation
			[ ] locator "@windowid='10201'"
		[+] StaticText MethodCheckNumberText
			[ ] locator "@windowid='10300'"
		[+] TextField MethodCheckNumber
			[ ] locator "@windowid='10206'"
		[+] StaticText PayOnlineAtText
			[ ] locator "@windowid='10214'"
		[+] Control LearnMore
			[ ] locator "@windowid='10215'"
		[+] StaticText AmountText
			[ ] locator "@windowid='10303'"
		[+] TextField N1
			[ ] locator "@windowid='10205'"
		[+] StaticText DateText
			[ ] locator "@windowid='10417'"
		[+] TextField N2
			[ ] locator "@windowid='10200'"
		[+] PushButton EnterTransactionButton
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] //------Add Reminders------------
	[-] window MainWin DlgAddEditReminder
		[ ] locator "*Reminder"
		[ ] 
		[+] StaticText AddBillReminderText
			[ ] locator "@windowid='100'"
		[+] PushButton NextButton
			[ ] locator "@windowid='32764'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton DoneButton
			[ ] locator "@caption='Done' or @windowid='32767'"
		[+] PushButton DeleteButton
			[ ] locator "@windowid='32754'"
		[+] PushButton BackButton 
			[ ] locator "@windowid='32763'"
		[+] PushButton HelpButton										
			[ ] locator "@windowid='32765'"
		[+] Control Step1Panel
			[ ] locator "@windowClassName='QWPanel'"
			[+] Control HomeChildPanel
				[ ] locator "@windowClassName='QWinChild'"
				[+] StaticText PayToText				
					[ ] locator "@windowid='101'"
				[+] TextField PayToTextField			
					[ ] locator "@windowid='102' or @windowid='107'"
				[+] PushButton GoToWebsite
					[ ] locator "@windowid='104'"
				[+] StaticText PayeeNameText			
					[ ] locator "@windowid='101'"
				[+] TextField PayeeNameTextField		
					[ ] locator "[@windowid='102' or @windowid='107']"
				[ ] //Invoice related object
				[+] ComboBox InvoiceType							
					[ ] locator "@windowid='106'"
			[+] StaticText PayeeNameText	
				[ ] locator "@windowid='101'"	
			[+] TextField PayeeNameTextField		
				[ ] locator "@windowid='102'"
			[+] StaticText ChangedPayeeNameText			
				[ ] locator "@windowid='103'"
			[ ] 
		[-] Control Step2Panel
			[ ] // locator "@windowClassName='QWPanel'"
			[-] Control QWinChild1
				[ ] //locator "[@windowClassName='QWinChild' or @windowClassName='QWinChild']"
				[+] StaticText DueNextOnText
					[ ] locator "@windowid='121'"
				[+] TextField DueNextOnTextField
					[ ] locator "@windowid='122'"
				[+] StaticText DueDateText
					[ ] locator "@windowid='123'"
				[+] PushButton DueDateChangeLink
					[ ] locator "@windowid='124'"
				[+] StaticText AmountDueText
					[ ] locator "@windowid='125'"
				[+] StaticText EstimatedAmountText
					[ ] locator "@windowid='131'"
				[+] TextField AmountDueTextField
					[ ] locator "@windowid='126'"
				[+] StaticText FromAccountText
					[ ] locator "@windowid='109'"
				[+] TextField FromAccountTextField
					[ ] locator "From account"
				[+] StaticText ToAccountText
					[ ] locator "@windowid='113'"
				[+] TextField ToAccountTextField
					[ ] locator "To account"
				[+] ComboBox IncomeMethodPopupList					
					[ ] locator "@windowid='116'"
				[+] StaticText SecurityTextStaticText					
					[ ] locator "@windowid='117'"
				[+] TextField SecurityTextField							
					[ ] locator "@windowid='118'"
				[ ] //Invoice related objects
				[+] TextField InvoiceAccount 								
					[ ] locator "@windowid='110'"
				[+] TextField ToCustomer									
					[ ] locator "@windowid='101'"
				[+] StaticText DetailsText
					[ ] locator "@windowid='129'"
				[-] Control AddCategoryTagMemoPanel1			
					[+] Control AddCategoryTagMemoButton
						[ ]  locator "Add*tag or memo"
					[+] Control QWIconDisplay1
						[ ] locator "@windowid='106'"
						[ ] 
					[ ] //Invoice related object
					[-] Control AddDetails	
						[ ] locator "@windowid='104'"						
					[+] Control ButtonAfterReminderAdded
						[ ] locator "@windowid='105'"
						[ ] 
					[ ] 
					[ ]       
				[+] Control Panel2 
					[+] Control QWIconDisplay1
						[ ] locator "@windowid='100'"
					[+] Control OptionalSettingsButton
						[ ] //locator "@windowid='101'"
						[ ] locator "Optional Settings"
				[+] Control OptionalSettingsPanel2
					[+] PushButton OptionalSettingsButton
						[ ] locator "[@priorlabel='Details'][5]"
					[ ] 
				[+] Control OptionalSettingsPanel3
					[+] StaticText RemindDaysInAdvanceText
						[ ] locator "@windowid='100'"
					[+] PushButton RemindDaysInAdvanceChangeLink
						[ ] locator "@windowid='101'"
					[+] StaticText RelatedWebsiteText
						[ ] locator "@windowid='102'"
					[+] PushButton RelatedWebsiteAddLink
						[ ] locator "@windowid='103'"
					[+] PushButton RelatedWebsiteChangeLink
						[ ] locator "@caption='(change)'"
					[ ] 
					[+] StaticText EstimateAmountText
						[ ] locator "@windowid='106'"
					[+] PushButton EstimateAmountChangeLink
						[ ] locator "@windowid='107'"
					[+] CheckBox SyncToOutlookCheckBox
						[ ] locator "@windowid='104'"
					[+] CheckBox PrintCheckWithQuickenCheckBox
						[ ] locator "@windowid='105'"
					[+] CheckBox MakeThisARepeatingOnlinePay
						[ ] locator "@windowid='105'"
				[+] CheckBox UseBillPayCheckBox				
					[ ] locator "@windowid='111'"
		[+] StaticText PaycheckSetupText 		
			[ ] locator "@windowid='102'"
		[ ] //Skip Functionality related objects
		[+] PushButton SkipConfirmButton
			[ ] locator "Skip"							     		       
		[+] PushButton DonTSkipButton	
			[ ] locator "Don't Skip"			  		
		[ ] 
		[+] Control BillReminder
			[ ] locator "@windowClassName='QWinDlg'"
			[+] StaticText CategoryText
				[ ] locator "@windowid='102'"
			[+] TextField Category
				[ ] locator "@windowid='103'"
			[+] // CustomWin Wallmart4
				[+] // multitag "[QC_button]Wallmart"
					[ ] // "[QC_button]^Wallmart[1]"
					[ ] // "[QC_button]#1"
					[ ] // "[QC_button]$104"
					[ ] // "[QC_button]@(305,54)"
			[+] StaticText TagText
				[ ] locator "@windowid='105'"
			[+] TextField Tag
				[ ] locator "@windowid='106'"
			[+] StaticText MemoText
				[ ] locator "@windowid='107'"
			[+] TextField Memo
				[ ] locator "@windowid='108'"
			[+] PushButton OK
				[ ] locator "@windowid='32767'"
			[+] PushButton Cancel
				[ ] locator "@windowid='32766'"
		[+] PushButton FromAccountButton
			[ ] locator "[@priorlabel='Add*Reminder'][7]"
		[+] PushButton ToAccountButton
			[ ] locator "//PushButton[@priorlabel='*month'][2]"
		[+] PushButton ToAccountForTransferButton
			[ ] locator "//PushButton[@priorlabel='Add Transfer Reminder'][9]"
		[ ] 
		[ ] 
		[ ] 
		[+] DialogBox AddSecurityToQuicken     													
			[ ] locator "Add Security to Quicken"							
			[+] Control EnterSymbol
				[ ] locator "Enter symbol or name for this new security"
			[+] TextField TickerSymbol
				[ ] locator "Ticker Symbol:"
			[+] PushButton LookUp
				[ ] locator "Look Up"
			[+] TextField Name
				[ ] locator "Name:"
			[+] CheckBox AddSecurityToWatchList
				[ ] locator "@windowid='207'"
			[+] PushButton Next
				[ ] locator "Next"
			[+] Control ConnectionError
				[ ] locator "Connection Error"
			[+] Control NoDataFoundFor
				[ ] locator  "@windowid='32100'"
			[+] RadioList AddManually
				[ ] locator  "@windowid='2708'"
			[+] RadioList SelectTickerSymbol
				[ ] locator "@windowid='2707'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='32765'"
			[+] PushButton Cancel
				[ ] locator "@windowid='32766'"
			[+] PushButton Done
				[ ] locator "@windowid='32764'"
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // 
	[+] // window Control DlgOptionalSetting		
		[ ] // locator "@windowClassName='QWinDlg'"						
		[+] // StaticText ST_PayeeText
			[ ] // locator "@windowid='100'"
		[+] // Control ST_Payee3
			[ ] // locator "@windowid='101'"
		[+] // RadioList RemindMeRadioList
			[ ] // locator "@windowid='102'"
		[+] // TextField DaysBeforeTheDueDateTextField
			[ ] // locator "@windowid='103'"
		[+] // StaticText DaysInAdvanceText
			[ ] // locator "@windowid='105'"
		[+] // TextField DaysInAdvanceTextField
			[ ] // locator "@windowid='107'"
		[+] // StaticText DaysBeforeTheDueDateText
			[ ] // locator "@windowid='109'"
		[+] // Control DaysBeforeTheDueDate
			[ ] // locator "@windowid='110'"
		[+] // CheckBox UseOnlyBusinessDaysCheckBox
			[ ] // locator "@windowid='111'"
		[+] // PushButton OKButton
			[ ] // locator "@windowid='32767'"
		[+] // PushButton CancelButton
			[ ] // locator "@windowid='32766'"
		[ ] // //  Due next on change link					
		[+] // StaticText StartDateText
			[ ] // locator "@windowid='100'"
		[+] // TextField StartDateTextField
			[ ] // locator "@windowid='101'"
		[+] // StaticText HowOftenText
			[ ] // locator "@windowid='102'"
		[+] // ComboBox HowOftenPopupList
			[ ] // locator "@windowid='103'"
		[+] // StaticText EndDateText
			[ ] // locator "@windowid='126'"
		[+] // ComboBox EndDatePopupList
			[ ] // locator "@windowid='127'"
		[+] // StaticText EveryWeekText
			[ ] // locator "@windowid='111'"
		[+] // TextField EveryWeekTextField
			[ ] // locator "@windowid='112'"
		[+] // StaticText EveryTwoWeeksText
			[ ] // locator "@windowid='140'"
		[+] // TextField EveryTwoWeekTextField
			[ ] // locator "@windowid='141'"
		[+] // UpDown EveryUpDown
			[ ] // locator "@windowid='113'"
		[+] // ComboBox WeeksOnPopupList
			[ ] // locator "@windowid='110'"
		[+] // ComboBox MonthOnThePopupList
			[ ] // locator "@windowid='115'"
		[+] // ComboBox DayPopupList
			[ ] // locator "@windowid='116'"
		[+] // ComboBox TwiceAMonthOnPopupList
			[ ] // locator "@windowid='118'"
		[+] // ComboBox TwiceAMonthAndPopupList
			[ ] // locator "@windowid='120'"
		[+] // StaticText QuarterlyText
			[ ] // locator "@windowid='133'"
		[+] // StaticText YearlyText
			[ ] // locator "@windowid='134'"
		[+] // StaticText OnlyOnceText
			[ ] // locator "@windowid='132'"
		[+] // StaticText ToPayEstimatedTaxesText
			[ ] // locator "@windowid='121'"
		[+] // TextField TwiceAYearOnTextField
			[ ] // locator "@windowid='123'"
		[+] // TextField TwiceAYearAndTextField
			[ ] // locator "@windowid='125'"
		[ ] // // Tag Memo Category    					
		[+] // StaticText ReminderCategoryTagMemoText
			[ ] // locator "@windowid='100'"
		[+] // StaticText CategoryText
			[ ] // locator "@windowid='102'"
		[+] // TextField CategoryTextField
			[ ] // locator "@windowid='103'"
		[+] // PushButton SplitCategoryButton
			[ ] // locator "@windowid='104'"
		[+] // StaticText TagText
			[ ] // locator "@windowid='105'"
		[+] // TextField TagTextField
			[ ] // locator "@windowid='106'"
		[+] // StaticText MemoText
			[ ] // locator "@windowid='107'"
		[+] // TextField MemoTextField
			[ ] // locator "@windowid='108'"
		[ ] // //Transfer related objects
		[+] // TextField TagTextFieldTxn		
			[ ] // locator "@windowid='106'"								
		[+] // TextField MemoTextFieldTxn	
			[ ] // locator "@windowid='108'"										
		[+] // TextField WebsiteTextField
			[ ] // locator "@windowid='103'"
		[ ] // //New Tag Dialog							
		[+] // DialogBox NewTag
			[ ] // locator "@caption='New Tag'"
			[+] // StaticText NewTagText
				[ ] // locator "@windowid='32702'"
			[+] // StaticText N1Text
				[ ] // locator "@windowid='32740'"
			[+] // StaticText RequiredFieldsText
				[ ] // locator "@windowid='32741'"
			[+] // StaticText NameText
				[ ] // locator "@windowid='107'"
			[+] // StaticText N2Text
				[ ] // locator "@windowid='108'"
			[+] // TextField TextField1
				[ ] // locator "@windowid='101'"
			[+] // StaticText DescriptionText
				[ ] // locator "@windowid='109'"
			[+] // TextField Description
				[ ] // locator "@windowid='102'"
			[+] // StaticText CopyNumberText
				[ ] // locator "@windowid='110'"
			[+] // TextField CopyNumber1
				[ ] // locator "@windowid='103'"
			[+] // PushButton TellMeMore
				[ ] // locator "@windowid='111'"
			[+] // PushButton CopyNumber2
				[ ] // locator "@windowid='32765'"
			[+] // PushButton TagOKButton
				[ ] // locator "@windowid='32767'"
			[+] // PushButton TagCancelButton
				[ ] // locator "@windowid='32766'"
				[ ] // 
			[ ] // 
		[+] // StaticText QuickenCanHelpYouEstimateText
			[ ] // locator "@windowid='100'" 
		[+] // StaticText EstimateText
			[ ] // locator "@windowid='103'"
		[+] // ComboBox QuickenCanHelpYouEstimatePopupList
			[ ] // locator "@windowid='105'"
		[+] // TextField QuickenCanHelpYouEstimateTextField
			[ ] // locator "@windowid='114'"
		[+] // StaticText LastText
			[ ] // locator "@windowid='106'"
		[+] // TextField LastTextField
			[+] // locator "@windowid='107'"
				[ ] // 
		[ ] // // Enter Transaction by Enter Button on Bills                                    			
		[+] // PushButton EnterTransactionButton
			[ ] // locator "@windowid='32767'"
	[ ] 
	[+] window Control DlgOptionalSetting		
		[ ] locator "@windowClassName='QWinDlg'"						
		[+] StaticText ST_PayeeText
			[ ] locator "@windowid='100'"
		[+] Control ST_Payee3
			[ ] locator "@windowid='101'"
		[+] RadioList RemindMeRadioList
			[ ] locator "@windowid='102'"
		[+] TextField DaysBeforeTheDueDateTextField
			[ ] locator "@windowid='103'"
		[+] StaticText DaysInAdvanceText
			[ ] locator "@windowid='105'"
		[+] TextField DaysInAdvanceTextField
			[ ] locator "@windowid='107'"
		[+] StaticText DaysBeforeTheDueDateText
			[ ] locator "@windowid='109'"
		[+] Control DaysBeforeTheDueDate
			[ ] locator "@windowid='110'"
		[+] CheckBox UseOnlyBusinessDaysCheckBox
			[ ] locator "@windowid='111'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[ ] //  Due next on change link
		[+] StaticText DueNextOnOptionalSettingDialogTitle
			[ ] locator "@windowid='104'"
		[+] StaticText RemindMeOptionalSettingDialogTitle
			[ ] locator "@windowid='100'"
		[ ] 
		[ ] //  Due next on change link					
		[+] StaticText StartDateText
			[ ] locator "@windowid='100'"
		[+] TextField StartDateTextField
			[ ] locator "@windowid='101'"
		[+] StaticText HowOftenText
			[ ] locator "@windowid='102'"
		[+] ComboBox HowOftenPopupList
			[ ] locator "@windowid='103'"
		[+] StaticText EndDateText
			[ ] locator "@windowid='126'"
		[+] ComboBox EndDatePopupList
			[ ] locator "@windowid='127'"
		[+] TextField EndOnTextField
			[ ] locator "@windowid='128'"
			[ ] 
		[+] TextField EndAfterTextField
			[ ] locator "@windowid='129'"
		[ ] 
		[+] StaticText EveryWeekText
			[ ] locator "@windowid='111'"
		[+] TextField EveryWeekTextField
			[ ] locator "@windowid='112'"
		[+] StaticText EveryTwoWeeksText
			[ ] locator "@windowid='140'"
		[+] TextField EveryTwoWeekTextField
			[ ] //locator "@windowid='114'"
			[ ] locator "@windowid='141'"
			[ ] 
		[+] UpDown EveryUpDown
			[ ] locator "@windowid='113'"
		[+] ComboBox WeeksOnPopupList
			[ ] locator "@windowid='110'"
		[+] ComboBox MonthOnThePopupList
			[ ] locator "@windowid='115'"
		[+] ComboBox DayPopupList
			[ ] locator "@windowid='116'"
		[+] ComboBox TwiceAMonthOnPopupList
			[ ] locator "@windowid='118'"
		[+] ComboBox TwiceAMonthAndPopupList
			[ ] locator "@windowid='120'"
		[+] StaticText QuarterlyText
			[ ] locator "@windowid='133'"
		[+] StaticText YearlyText
			[ ] locator "@windowid='134'"
		[+] StaticText OnlyOnceText
			[ ] locator "@windowid='132'"
		[+] StaticText ToPayEstimatedTaxesText
			[ ] locator "@windowid='121'"
		[+] TextField TwiceAYearOnTextField
			[ ] locator "@windowid='123'"
		[+] TextField TwiceAYearAndTextField
			[ ] locator "@windowid='125'"
		[+] ComboBox EveryTwoWeeksOnPopupList
			[ ] locator "@windowid='141'"
		[ ] 
		[ ] // Tag Memo Category    					
		[+] StaticText ReminderCategoryTagMemoText
			[ ] locator "@windowid='100'"
		[+] StaticText CategoryText
			[ ] locator "@windowid='102'"
		[+] TextField CategoryTextField
			[ ] locator "@windowid='103'"
		[+] PushButton SplitCategoryButton
			[ ] locator "@windowid='104'"
		[+] StaticText TagText
			[ ] locator "@windowid='105'"
		[+] TextField TagTextField
			[ ] locator "@windowid='106'"
		[+] StaticText MemoText
			[ ] locator "@windowid='107'"
		[+] TextField MemoTextField
			[ ] locator "@windowid='108'"
		[ ] //Transfer related objects
		[+] TextField TagTextFieldTxn		
			[ ] locator "@windowid='106'"								
		[+] TextField MemoTextFieldTxn	
			[ ] locator "@windowid='108'"										
		[+] TextField WebsiteTextField
			[ ] locator "@windowid='103'"
		[ ] //New Tag Dialog							
		[+] DialogBox NewTag
			[ ] locator "@caption='New Tag'"
			[+] StaticText NewTagText
				[ ] locator "@windowid='32702'"
			[+] StaticText N1Text
				[ ] locator "@windowid='32740'"
			[+] StaticText RequiredFieldsText
				[ ] locator "@windowid='32741'"
			[+] StaticText NameText
				[ ] locator "@windowid='107'"
			[+] StaticText N2Text
				[ ] locator "@windowid='108'"
			[+] TextField TextField1
				[ ] locator "@windowid='101'"
			[+] StaticText DescriptionText
				[ ] locator "@windowid='109'"
			[+] TextField Description
				[ ] locator "@windowid='102'"
			[+] StaticText CopyNumberText
				[ ] locator "@windowid='110'"
			[+] TextField CopyNumber1
				[ ] locator "@windowid='103'"
			[+] PushButton TellMeMore
				[ ] locator "@windowid='111'"
			[+] PushButton CopyNumber2
				[ ] locator "@windowid='32765'"
			[+] PushButton TagOKButton
				[ ] locator "@windowid='32767'"
			[+] PushButton TagCancelButton
				[ ] locator "@windowid='32766'"
				[ ] 
			[ ] 
		[+] StaticText QuickenCanHelpYouEstimateText
			[ ] locator "@windowid='100'" 
		[+] StaticText EstimateText
			[ ] locator "@windowid='103'"
		[+] ComboBox QuickenCanHelpYouEstimatePopupList
			[ ] locator "@windowid='105'"
		[+] TextField QuickenCanHelpYouEstimateTextField
			[ ] locator "@windowid='114'"
		[+] StaticText LastText
			[ ] locator "@windowid='106'"
		[+] TextField LastTextField
			[+] locator "@windowid='107'"
				[ ] 
		[ ] // Enter Transaction by Enter Button on Bills                                    			
		[+] PushButton EnterTransactionButton
			[ ] locator "@windowid='32767'"
	[ ] 
	[ ] 
	[ ] 
	[ ] //------Income Reminder > Paycheck Setup------------
	[+] window MainWin PayCheckSetup
		[ ] locator "Paycheck Setup"
		[+] TextField CompanyName
			[ ] locator "@windowid='2001'"
		[+] TextField MemoOptional
			[ ] locator "@windowid='2002'"
			[ ] 
		[+] Control QWSnapHolder
			[ ] locator "@windowid='-1'"
			[+] StaticText AcceptClearenceTransaction
				[ ] locator "@windowid='-1'"
				[+] Control ListViewer
					[ ] locator "@windowid='1'"
					[+] ListBox Earnings
						[ ] locator "@windowid='1'"
						[+] TextField Amount
							[ ] locator "@windowid='2'"
				[+] StaticText TransactionFrame
					[ ] locator "@windowid='-1'"
					[+] PushButton AcceptAllButton
						[ ] locator "@windowid='27002'"
					[+] PushButton AddEarning
						[+] locator "@windowid='505'"
							[ ] 
				[ ] 
		[+] TextField Amount1
			[ ] locator "@windowid='2006'"
		[+] TextField StartOn
			[ ] locator "@windowid='1024'"
		[+] ComboBox Frequency
			[ ] locator "@windowid='1028'"
		[+] PushButton TrackDeductions
			[ ] locator "@windowid='2018'"
		[+] PushButton Next
			[ ] locator "@windowid='24120'"
		[+] RadioList HowMuchPaycheck
			[ ] //locator "Net amount"
			[ ] locator "@windowid='2016'"
		[ ] 
		[+] PushButton Done
			[ ] locator "@windowid='32767'"
		[+] ComboBox Account
			[ ] locator "@windowid='2005'"
			[ ] 
		[ ] 
		[+] RadioList NetPaycheckTypeRadioList
			[ ] locator "@windowid='2017'"
			[ ] 
			[ ] 
		[+] RadioList GrossPaycheckTypeRadioList
			[ ] locator "@windowid='2016'"
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin EnterYearToDateInformation
		[ ] locator "@caption='Enter Year-to-Date Information'"
		[+] StaticText EnterYearToDateInformation
			[ ] locator "@windowid='32702'"
		[+] StaticText DoYouWantToEnterTheYear
			[ ] locator "@windowid='65535'"
		[+] StaticText QuickenWillUseTheYearToD1
			[ ] locator "@windowid='65535'"
		[+] RadioList QuickenWillUseTheYearToD2
			[ ] locator "@windowid='2022'"
		[+] PushButton QuickenWillUseTheYearToD3
			[ ] locator "@windowid='32765'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[ ] 
	[ ] 
	[+] window MainWin PaycheckYearToDateAmounts
		[ ] locator "@caption='Paycheck Year-to-Date Amounts'"
		[+] StaticText CompanyNameText
			[ ] locator "@windowid='65535'"
		[+] StaticText PersistentText
			[ ] locator "@windowid='2001'"
		[+] StaticText MemoOptionalText
			[ ] locator "@windowid='65535'"
		[+] StaticText PaycheckForPersistentText
			[ ] locator "@windowid='2002'"
		[+] StaticText DateText
			[ ] locator "@windowid='65535'"
		[+] StaticText N09212011Text
			[ ] locator "@windowid='2003'"
		[+] StaticText YouWillBeAbleToEditThis1
			[ ] locator "@windowid='2021'"
		[+] PushButton Enter
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton N09212011
			[ ] locator "@windowid='32765'"
		[+] Control YouWillBeAbleToEditThis2
			[ ] locator "@windowid='-1'"
			[+] StaticText StaticText1
				[ ] locator "@windowid='-1'"
			[+] StaticText StaticText2
				[ ] locator "@windowid='-1'"
			[+] StaticText StaticText3
				[ ] locator "@windowid='1'"
	[ ] 
	[+] window DialogBox PayCheckError
		[ ] locator "@caption='Quicken 201?'"
		[+] Control QWIconDisplay1
			[ ] locator "@windowid='105'"
		[+] StaticText ThisPaycheckNameIsAlready
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
			[ ] 
	[ ] 
	[+] window DialogBox AddEarning	
		[ ] locator "@caption='Add Earning'"			
		[+] StaticText AddEarningText
			[ ] locator "@windowid='32702'"
		[+] StaticText NameText
			[ ] locator "@caption='Name:'"
		[+] TextField Name
			[ ] locator "@windowid='1101'"
		[+] StaticText CategoryText
			[ ] locator "@windowid='105'"
		[+] TextField Category
			[ ] locator "@windowid='1102'"
		[+] StaticText AmountText
			[ ] locator "@caption='Amount:'"
		[+] TextField AmountTextField
			[ ] locator "@windowid='1104'"
		[+] PushButton Amount2
			[ ] locator "@windowid='32765'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control AddEarning2
			[ ] locator "@windowid='2020'"
			[+] PushButton PushButton2
				[ ] locator "@windowid='1124'"
			[+] PushButton PushButton1
				[ ] locator "@windowid='1128'"
		[+] Control AddEarning1
			[ ] locator "@windowid='2020'"
			[+] PushButton PushButton2
				[ ] locator "@windowid='1124'"
			[+] PushButton PushButton1
				[ ] locator "@windowid='1128'"
	[ ] 
	[ ] //-------Link for BPS------
	[+] window WPFWindow BillReminder
		[ ] locator "/WPFWindow[@caption='Bill reminder']"
		[+] WPFPage BillReminder
			[ ] locator "Bill reminder"
		[+] WPFLabel SetupBillReminder
			[ ] locator "Setup Bill Reminder"
		[+] WPFTextBlock PayTo
			[ ] locator "Pay To: "
		[+] WPFTextBlock AmountDue
			[ ] locator "Amount Due: "
		[+] WPFTextBlock DueDate
			[ ] locator "Due Date: "
		[+] WPFTextBlock Account
			[ ] locator "Account: "
		[+] WPFTextBlock Sds
			[ ] locator "Sds"
		[+] WPFTextBlock x6000
			[ ] locator "$60.00"
		[+] WPFTextBlock x20150907
			[ ] locator "@caption='2015/09/07'"
		[+] WPFTextBlock Checking01Account
			[ ] locator "Checking 01 Account"
		[+] WPFTextBlock SeeIfYouCanLinkThisBillToQuicken
			[ ] locator "See if you can link this bill to Quicken"
		[+] WPFTextBlock OnceYouLinkaBillItLlUpdateItse
			[ ] locator "Once you link a bill, it'll update itself. Due dates and amounts will update automatically, you'll be able to see statements in Quicken, and more."
		[+] WPFButton LinkItNow
			[ ] locator "Link it Now"
		[+] WPFButton Close
			[ ] locator "Close"
		[ ] 
		[ ] 
		[ ] // //------Register > C2R ------------
		[+] // window ChildWin C2RReminders		
			[ ] // 		
			[+] // Control QWSnapHolder1
				[+] // StaticText StaticText1
					[ ] // locator "@windowid='-1'"
					[+] // StaticText StaticText2
						[ ] // locator "@windowid='-1'"
						[+] // PushButton AddReminderButton
							[ ] // locator "@windowid='518'"
						[+] // PushButton ManageReminderButton
							[ ] // locator "@windowid='507'"
						[+] // PushButton AcceptAll       
							[ ] // locator "@windowid='27002'"                              
						[+] // TextField EnterFINameTextField
							[ ] // locator "@windowid='1017'"						
					[+] // Control QWHtmlView
						[ ] // locator "@windowid='-1'"
						[ ] // 
					[ ] // 
			[+] // StaticText C2RText
				[ ] // locator "@windowid='7'"
				[+] // Control QWinChild
					[ ] // locator "@windowid='0'"
					[+] // PushButton BillandIncomeRemindersTab
						[ ] // locator "@windowid='1022'"
					[+] // PushButton DownloadedTransactionsTab
						[ ] // locator "@windowid='1021'"
						[ ] // 
		[ ] 
	[ ] //------Register > C2R ------------
	[+] window ChildWin C2RReminders		
		[ ] 		
		[+] Control QWSnapHolder1
			[+] StaticText StaticText1
				[ ] locator "@windowid='-1'"
				[+] StaticText StaticText2
					[ ] locator "@windowid='-1'"
					[+] PushButton AddReminderButton
						[ ] locator "@windowid='518'"
					[+] PushButton ManageReminderButton
						[ ] locator "@windowid='507'"
					[+] PushButton AcceptAll       
						[ ] locator "@windowid='27002'"                              
					[+] // TextField EnterFINameTextField
						[ ] // locator "@windowid='1017'"						
					[ ]       
				[+] Control QWHtmlView
					[ ] locator "@windowid='-1'"
					[ ] 
				[ ] 
		[+] StaticText C2RText
			[ ] locator "@windowid='7'"
			[+] Control QWinChild
				[ ] //locator "@windowid='0'"
				[+] PushButton BillandIncomeRemindersTab
					[ ] locator "@windowid='1022'"
				[+] PushButton DownloadedTransactionsTab
					[ ] locator "@windowid='1021'"
					[ ] 
		[+] TextField EnterFINameTextField
			[ ] locator "@windowid='1017'"						
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // 
	[ ] // //------Add Category tag memo > split transaction------------
	[+] // window DialogBox ReminderSplitTransaction                 
		[ ] // locator "@caption='Split Transaction'"		
		[+] // StaticText SplitTransactionText
			[ ] // locator "@windowid='32702'"
		[+] // StaticText EnterMultipleCategoriesToI1
			[ ] // locator "@windowid='65535'"
		[+] // Control EnterMultipleCategoriesToI2
			[ ] // locator "@windowid='200'"
			[+] // ListBox ListBox1
				[ ] // locator "@windowid='1'"
				[+] // TextField TextField1
					[ ] // locator "@windowid='1002'"
				[+] // TextField TextField11
					[ ] // locator "@windowid='1003'"
				[+] // TextField TextField12
					[ ] // locator "@windowid='1004'"
				[+] // TextField TextField13
					[ ] // locator "@windowid='1012'"
				[+] // TextField TextField14
					[ ] // locator "@windowid='1005'"
		[+] // PushButton AddLinesButton
			[ ] // locator "@windowid='233'"
		[+] // PushButton ClearAllButton
			[ ] // locator "@windowid='239'"
		[+] // PushButton AllocateButton
			[ ] // locator "@windowid='240'"
		[+] // PushButton AdjustButton
			[ ] // locator "@windowid='201'"
		[+] // StaticText SplitTotalText
			[ ] // locator "@windowid='241'"
		[+] // StaticText N0001Text
			[ ] // locator "@windowid='242'"
		[+] // StaticText RemainderText
			[ ] // locator "@windowid='258'"
		[+] // StaticText N0002Text
			[ ] // locator "@windowid='203'"
		[+] // Control N000
			[ ] // locator "@windowid='243'"
		[+] // StaticText TransactionTotalText
			[ ] // locator "@windowid='259'"
		[+] // StaticText N0003Text
			[ ] // locator "@windowid='204'"
		[+] // PushButton EnterMultipleCategoriesToI3
			[ ] // locator "@windowid='32765'"
		[+] // PushButton OKButton
			[ ] // locator "@windowid='32767'"
		[+] // PushButton CancelButton
			[ ] // locator "@windowid='32766'"
	[ ] 
	[ ] //------Add Category tag memo > split transaction------------
	[+] window MainWin ReminderSplitTransaction                 
		[ ] locator "@caption='Split Transaction'"		
		[+] StaticText SplitTransactionText
			[ ] locator "@windowid='32702'"
		[+] StaticText EnterMultipleCategoriesToI1
			[ ] locator "@windowid='65535'"
		[+] MainWin EnterMultipleCategoriesToI2
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[+] TextField TextField1
					[ ] locator "@windowid='1002'"
				[+] TextField TextField11
					[ ] locator "@windowid='1003'"
				[+] TextField TextField12
					[ ] locator "@windowid='1004'"
				[+] TextField TextField13
					[ ] locator "@windowid='1012'"
				[+] TextField TextField14
					[ ] locator "@windowid='1005'"
		[+] PushButton AddLinesButton
			[ ] locator "@windowid='233'"
		[+] PushButton ClearAllButton
			[ ] locator "@windowid='239'"
		[+] PushButton AllocateButton
			[ ] locator "@windowid='240'"
		[+] PushButton AdjustButton
			[ ] locator "@windowid='201'"
		[+] StaticText SplitTotalText
			[ ] locator "@windowid='241'"
		[+] StaticText N0001Text
			[ ] locator "@windowid='242'"
		[+] StaticText RemainderText
			[ ] locator "@windowid='258'"
		[+] StaticText N0002Text
			[ ] locator "@windowid='203'"
		[+] Control N000
			[ ] locator "@windowid='243'"
		[+] StaticText TransactionTotalText
			[ ] locator "@windowid='259'"
		[+] StaticText N0003Text
			[ ] locator "@windowid='204'"
		[+] PushButton EnterMultipleCategoriesToI3
			[ ] locator "@windowid='32765'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] // window DialogBox StayOnTopOfMonthlyBills
		[ ] // locator "@caption='Stay On Top of Monthly Bills'"		
		[+] // PushButton AddABill
			[ ] // locator "@windowid='1072'"
		[+] // PushButton Next
			[ ] // locator "@windowid='1084'"
		[+] // PushButton Done
			[ ] // locator "@windowid='1084'"
		[+] // Control LetSTakeALookAtTheBills        
			[ ] // locator "@windowid='1'"
			[+] // ListBox ListBox1
				[ ] // locator "@windowid='1'"
	[ ] 
	[+] window MainWin StayOnTopOfMonthlyBills
		[ ] locator "Stay On Top of Monthly Bills"
		[+] PushButton AddABill
			[ ] locator "@windowid='1072'"
		[+] PushButton Next
			[ ] //locator "Next"
			[ ] locator "@windowid='1084'"
		[+] PushButton Done
			[ ] locator "Done"
		[+] MainWin LetSTakeALookAtTheBills 
			[ ] locator "@windowid='1'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[ ] 
		[+] MainWin AddBillReminder
			[ ] locator "Add Bill Reminder"
			[+] Control AddCategoryTagOrMemo
				[ ] locator "Add category, tag or memo"
			[+] Control QWinDlg
				[ ] locator "@windowClassName='QWinDlg'"
			[+] PushButton Cancel
				[ ] locator "//Control[@windowClassName='QWinDlg']//PushButton[@caption='Cancel']"
		[+] PushButton Cancel
			[ ] locator "Cancel"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] // window FileDlg AddBillReminder
		[ ] // tag "Add Bill Reminder"
		[ ] // parent StayOnTopOfMonthlyBills
		[+] // StaticText AddBillReminderText
			[+] // multitag "Add Bill Reminder"
				[ ] // "#1"
				[ ] // "$100"
				[ ] // "@(298,21)"
		[+] // Control Next
			[+] // multitag "[QC_button]Next"
				[ ] // "[QC_button]^Add Bill Reminder[3]"
				[ ] // "[QC_button]#3"
				[ ] // "[QC_button]$32764"
				[ ] // "[QC_button]@(548,343)"
		[+] // Control Done
			[+] // multitag "[QC_button]Done"
				[ ] // "[QC_button]^Add Bill Reminder[4]"
				[ ] // "[QC_button]#4"
				[ ] // "[QC_button]$32767"
				[ ] // "[QC_button]@(548,343)"
		[+] // Control Back
			[+] // multitag "[QC_button]Back"
				[ ] // "[QC_button]^Add Bill Reminder[3]"
				[ ] // "[QC_button]#3"
				[ ] // "[QC_button]$32763"
				[ ] // "[QC_button]@(464,343)"
		[+] // Control Cancel
			[+] // multitag "[QC_button]Cancel"
				[ ] // "[QC_button]^Add Bill Reminder[2]"
				[ ] // "[QC_button]#2"
				[ ] // "[QC_button]$32766"
				[ ] // "[QC_button]@(84,343)"
		[+] // Control AddBillReminder
			[+] // multitag "[QC_button]Add Bill Reminder"
				[ ] // "[QC_button]^Add Bill Reminder[1]"
				[ ] // "[QC_button]#1"
				[ ] // "[QC_button]$32765"
				[ ] // "[QC_button]@(23,344)"
		[+] // Control Panel
			[+] // multitag "[QWPanel]Panel[1]"
				[ ] // "[QWPanel]^Add Bill Reminder[1]"
				[ ] // "[QWPanel]#1"
				[ ] // "[QWPanel]$-1[1]"
				[ ] // "[QWPanel]@(301,71)"
			[+] // Control Control
				[+] // multitag "[QWinChild]#1"
					[ ] // "[QWinChild]$-1"
					[ ] // "[QWinChild]@(286,140)"
				[+] // StaticText PayToText
					[+] // multitag "Pay to"
						[ ] // "#1"
						[ ] // "$100"
						[ ] // "@(54,21)"
				[+] // TextField PayTo
					[+] // multitag "Pay to"
						[ ] // "^Pay to"
						[ ] // "#1"
						[ ] // "$101"
						[ ] // "@(323,22)"
				[+] // Control PayTo2
					[+] // multitag "[QFBag]Pay to"
						[ ] // "[QFBag]^Pay to"
						[ ] // "[QFBag]#1"
						[ ] // "[QFBag]$2020"
						[ ] // "[QFBag]@(535,22)"
					[+] // Control QC_button2
						[+] // multitag "[QC_button]#2"
							[ ] // "[QC_button]$1124"
							[ ] // "[QC_button]@(9,9)"
					[+] // Control QC_button1
						[+] // multitag "[QC_button]#1"
							[ ] // "[QC_button]$1128"
							[ ] // "[QC_button]@(0,0)"
				[+] // StaticText DueNextOnText
					[+] // multitag "Due Next On"
						[ ] // "^Pay to"
						[ ] // "#2"
						[ ] // "$121"
						[ ] // "@(54,64)"
				[+] // TextField DueNextOn
					[+] // multitag "Due Next On"
						[ ] // "^Due Next On"
						[ ] // "#2"
						[ ] // "$122"
						[ ] // "@(147,61)"
				[+] // StaticText N23rdOfEveryMonthText
					[+] // multitag "23rd of every month"
						[ ] // "^Due Next On[1]"
						[ ] // "#3"
						[ ] // "$123"
						[ ] // "@(265,61)"
				[+] // Control Change
					[+] // multitag "[QC_button](change)"
						[ ] // "[QC_button]^23rd of every month"
						[ ] // "[QC_button]#1"
						[ ] // "[QC_button]$124"
						[ ] // "[QC_button]@(343,60)"
				[+] // StaticText AmountDueText
					[+] // multitag "Amount due"
						[ ] // "^Due Next On[2]"
						[ ] // "#4"
						[ ] // "$125"
						[ ] // "@(54,90)"
				[+] // TextField AmountDue
					[+] // multitag "Amount due"
						[ ] // "^Amount due"
						[ ] // "#3"
						[ ] // "$126"
						[ ] // "@(147,87)"
				[+] // StaticText FromAccountText
					[+] // multitag "From account"
						[ ] // "^Amount due"
						[ ] // "#5"
						[ ] // "$109"
						[ ] // "@(54,116)"
				[+] // ComboBox FromAccount
					[+] // multitag "From account"
						[ ] // "^From account"
						[ ] // "#1"
						[ ] // "$110"
						[ ] // "@(254,114)"
				[+] // StaticText DetailsText
					[+] // multitag "Details"
						[ ] // "^From account"
						[ ] // "#6"
						[ ] // "$129"
						[ ] // "@(54,142)"
				[+] // Control Details
					[+] // multitag "[EtchedHorz]Details"
						[ ] // "[EtchedHorz]^Details"
						[ ] // "[EtchedHorz]#2"
						[ ] // "[EtchedHorz]$133"
						[ ] // "[EtchedHorz]@(277,232)"
				[+] // Control PayTo3
					[+] // multitag "[QFBag]Pay to"
						[ ] // "[QFBag]^Pay to"
						[ ] // "[QFBag]#1"
						[ ] // "[QFBag]$2020[1]"
						[ ] // "[QFBag]@(427,22)"
					[+] // Control QC_button2
						[+] // multitag "[QC_button]#2"
							[ ] // "[QC_button]$1124"
							[ ] // "[QC_button]@(9,9)"
					[+] // Control QC_button1
						[+] // multitag "[QC_button]#1"
							[ ] // "[QC_button]$1128"
							[ ] // "[QC_button]@(0,0)"
				[+] // Control DueNextOn2
					[+] // multitag "[QFBag]Due Next On"
						[ ] // "[QFBag]^Due Next On"
						[ ] // "[QFBag]#2"
						[ ] // "[QFBag]$2020[2]"
						[ ] // "[QFBag]@(195,61)"
					[+] // Control QC_button2
						[+] // multitag "[QC_button]#2"
							[ ] // "[QC_button]$1124"
							[ ] // "[QC_button]@(9,9)"
					[+] // Control QC_button1
						[+] // multitag "[QC_button]#1"
							[ ] // "[QC_button]$1128"
							[ ] // "[QC_button]@(0,0)"
				[+] // Control AmountDue2
					[+] // multitag "[QFBag]Amount due"
						[ ] // "[QFBag]^Amount due"
						[ ] // "[QFBag]#3"
						[ ] // "[QFBag]$2020[3]"
						[ ] // "[QFBag]@(195,87)"
					[+] // Control QC_button2
						[+] // multitag "[QC_button]#2"
							[ ] // "[QC_button]$1124"
							[ ] // "[QC_button]@(9,9)"
					[+] // Control QC_button1
						[+] // multitag "[QC_button]#1"
							[ ] // "[QC_button]$1128"
							[ ] // "[QC_button]@(0,0)"
				[+] // Control Panel1
					[+] // multitag "[QWPanel]Panel[1]"
						[ ] // "[QWPanel]^Details[1]"
						[ ] // "[QWPanel]#1"
						[ ] // "[QWPanel]$-1[1]"
						[ ] // "[QWPanel]@(326,178)"
					[+] // Control QWIconDisplay1
						[+] // multitag "[QWIconDisplay]#1"
							[ ] // "[QWIconDisplay]$106"
							[ ] // "[QWIconDisplay]@(22,47)"
					[+] // Control AddCategoryTagOrMemo
						[+] // multitag "[QWLabel]Add category, tag or memo"
							[ ] // "[QWLabel]#1"
							[ ] // "[QWLabel]$107"
							[ ] // "[QWLabel]@(234,44)"
				[+] // Control Panel2
					[+] // multitag "[QWPanel]Panel[2]"
						[ ] // "[QWPanel]^Details[2]"
						[ ] // "[QWPanel]#2"
						[ ] // "[QWPanel]$-1[2]"
						[ ] // "[QWPanel]@(278,247)"
					[+] // Control QWIconDisplay1
						[+] // multitag "[QWIconDisplay]#1"
							[ ] // "[QWIconDisplay]$100"
							[ ] // "[QWIconDisplay]@(15,9)"
					[+] // Control OptionalSettings
						[+] // multitag "[QWLabel]Optional Settings"
							[ ] // "[QWLabel]#1"
							[ ] // "[QWLabel]$101"
							[ ] // "[QWLabel]@(117,9)"
				[ ] // 
		[+] // Control Panel2
			[+] // multitag "[QWPanel]Panel[2]"
				[ ] // "[QWPanel]^Add Bill Reminder[2]"
				[ ] // "[QWPanel]#2"
				[ ] // "[QWPanel]$-1[2]"
				[ ] // "[QWPanel]@(298,211)"
			[+] // Control QWinChild
				[+] // multitag "[QWinChild]#1"
					[ ] // "[QWinChild]$-1"
					[ ] // "[QWinChild]@(280,111)"
				[+] // StaticText DueNextOnText
					[+] // multitag "Due Next On"
						[ ] // "#1"
						[ ] // "$121"
						[ ] // "@(54,12)"
				[+] // TextField DueNextOn
					[+] // multitag "Due Next On"
						[ ] // "^Due Next On"
						[ ] // "#1"
						[ ] // "$122"
						[ ] // "@(147,9)"
				[+] // StaticText N27thOfEveryMonthText
					[+] // multitag "27th of every month"
						[ ] // "^Due Next On[1]"
						[ ] // "#2"
						[ ] // "$123"
						[ ] // "@(265,9)"
				[+] // Control Change
					[+] // multitag "[QC_button](change)"
						[ ] // "[QC_button]^27th of every month"
						[ ] // "[QC_button]#1"
						[ ] // "[QC_button]$124"
						[ ] // "[QC_button]@(343,8)"
				[+] // StaticText AmountDueText
					[+] // multitag "Amount due"
						[ ] // "^Due Next On[2]"
						[ ] // "#3"
						[ ] // "$125"
						[ ] // "@(54,38)"
				[+] // TextField AmountDue
					[+] // multitag "Amount due"
						[ ] // "^Amount due"
						[ ] // "#2"
						[ ] // "$126"
						[ ] // "@(147,35)"
				[+] // StaticText FromAccountText
					[+] // multitag "From account"
						[ ] // "^Amount due"
						[ ] // "#4"
						[ ] // "$109"
						[ ] // "@(54,64)"
				[+] // // PopupList FromAccount
					[+] // // multitag "From account"
						[ ] // // "^From account"
						[ ] // // "$110"
						[ ] // // "#1"
				[+] // TextField FromAccount
					[+] // multitag "From account"
						[ ] // "^From account"
						[ ] // "$110"
						[ ] // "#1"
					[ ] // 
				[+] // StaticText DetailsText
					[+] // multitag "Details"
						[ ] // "^From account"
						[ ] // "#5"
						[ ] // "$129"
						[ ] // "@(54,93)"
				[+] // Control Details
					[+] // multitag "[EtchedHorz]Details"
						[ ] // "[EtchedHorz]^Details"
						[ ] // "[EtchedHorz]#1"
						[ ] // "[EtchedHorz]$133"
						[ ] // "[EtchedHorz]@(271,181)"
				[+] // Control DueNextOn2
					[+] // multitag "[QFBag]Due Next On"
						[ ] // "[QFBag]^Due Next On"
						[ ] // "[QFBag]#1"
						[ ] // "[QFBag]$2020[1]"
						[ ] // "[QFBag]@(195,9)"
					[+] // Control QC_button2
						[+] // multitag "[QC_button]#2"
							[ ] // "[QC_button]$1124"
							[ ] // "[QC_button]@(9,9)"
					[+] // Control QC_button1
						[+] // multitag "[QC_button]#1"
							[ ] // "[QC_button]$1128"
							[ ] // "[QC_button]@(0,0)"
				[+] // Control AmountDue2
					[+] // multitag "[QFBag]Amount due"
						[ ] // "[QFBag]^Amount due"
						[ ] // "[QFBag]#2"
						[ ] // "[QFBag]$2020[2]"
						[ ] // "[QFBag]@(195,35)"
					[+] // Control QC_button2
						[+] // multitag "[QC_button]#2"
							[ ] // "[QC_button]$1124"
							[ ] // "[QC_button]@(9,9)"
					[+] // Control QC_button1
						[+] // multitag "[QC_button]#1"
							[ ] // "[QC_button]$1128"
							[ ] // "[QC_button]@(0,0)"
				[+] // Control Panel1
					[+] // multitag "[QWPanel]Panel[1]"
						[ ] // "[QWPanel]^Details[1]"
						[ ] // "[QWPanel]#1"
						[ ] // "[QWPanel]$-1[1]"
						[ ] // "[QWPanel]@(320,130)"
					[+] // Control QWIconDisplay1
						[+] // multitag "[QWIconDisplay]#1"
							[ ] // "[QWIconDisplay]$106"
							[ ] // "[QWIconDisplay]@(22,47)"
					[+] // Control AddCategoryTagOrMemo
						[+] // multitag "[QWLabel]Add category, tag or memo"
							[ ] // "[QWLabel]#1"
							[ ] // "[QWLabel]$107"
							[ ] // "[QWLabel]@(228,44)"
				[+] // Control Panel2
					[+] // multitag "[QWPanel]Panel[2]"
						[ ] // "[QWPanel]^Details[2]"
						[ ] // "[QWPanel]#2"
						[ ] // "[QWPanel]$-1[2]"
						[ ] // "[QWPanel]@(272,196)"
					[+] // Control QWIconDisplay1
						[+] // multitag "[QWIconDisplay]#1"
							[ ] // "[QWIconDisplay]$100"
							[ ] // "[QWIconDisplay]@(15,9)"
					[+] // Control OptionalSettings
						[+] // multitag "[QWLabel]Optional Settings"
							[ ] // "[QWLabel]#1"
							[ ] // "[QWLabel]$101"
							[ ] // "[QWLabel]@(117,9)"
	[ ] 
	[ ] // 2015-09-08 KalyanG: Added, Ref Build 25.0.0.395
	[+] window WPFWindow AddBiller
		[ ] locator "Add Biller"
		[+] WPFButton btnClose
			[ ] locator "Close"
	[ ] 
	[ ] // 2015-10-19 KalyanG: Added, Ref Build 25.0.0.452
	[+] window WPFWindow LinkBiller
		[ ] locator "Link Biller"
		[+] WPFButton btnClose
			[ ] locator "Close"
	[+] window WPFWindow AddLinkBiller
		[ ] locator "* Biller"
		[-] WPFButton btnClose
			[ ] locator "Close"
	[ ] 
	[ ] 
	[ ] 
	[+] window MainWin DlgManageReminders
		[ ] locator "Bill and Income Reminders"
		[ ] 
		[+] MenuItem Enter
			[ ] locator "@windowid='508'"
			[ ] //locator "Enter"
			[ ] 
			[ ] 
		[+] MenuItem Skip
			[ ] //locator "Skip"
			[ ] locator "@windowid='509'"
			[ ] 
			[ ] 
		[+] MenuItem Edit
			[ ] //locator "Edit"
			[ ] locator "@windowid='510'"
		[+] MenuItem Delete
			[ ] locator "Delete"
			[ ] // locator "@windowid='513'"
			[ ] 
			[ ] 
		[ ] 
		[+] StaticText StaticText1
			[ ] //locator "@windowid='0'"
			[+] StaticText AllBillsDepositsText
				[ ] //locator "@windowid='-1'"
				[+] CheckBox  ShowgraphCheckBox
					[ ] locator "@windowid='101'"
				[+] CheckBox  ShowcalendarCheckBox
					[ ] locator "@windowid='100'"
				[+] Control ReminderGraph
					[ ] //locator "@windowid='0'"
					[ ] locator "@windowClassName='QWGraphControlClass'"
					[ ] 
				[ ] 
			[+] StaticText ReminderCalendar
				[ ] locator "@windowid='-1'"
			[+] StaticText CalendarText
				[ ] locator "@windowid='-1'"
				[+] Control CalendarNextButton
					[ ] locator "@windowid='204'"
				[+] Control CalendarPreviousButton
					[ ] locator "@windowid='203'"
				[+] Control CalendarMonthLabel
					[ ] locator "@windowid='205'"
			[ ] 
		[ ] 
		[+] PushButton CalendarNextButton
			[ ] locator "@windowid='204'"
		[+] PushButton CalendarPreviousButton
			[ ] locator "@windowid='203'"
		[+] PushButton CalendarMonthButton
			[ ] locator "@windowid='205'"
		[+] Control QWGraphControlClass
			[ ] locator "//Control[@windowClassName='QWGraphControlClass']"
			[ ] 
		[+] CheckBox  ShowgraphCheckBox
			[ ] locator "@windowid='101'"
		[+] CheckBox  ShowcalendarCheckBox
			[ ] locator "@windowid='100'"
		[+] Control ReminderGraph
			[ ] locator "@windowid='0'"
			[+] StaticText AllBillsDepositsText
				[ ] locator "@windowid='-1'"
				[+] CheckBox  ShowgraphCheckBox
					[ ] locator "@windowid='101'"
				[+] CheckBox  ShowcalendarCheckBox
					[ ] locator "@windowid='100'"
				[+] Control ReminderGraph
					[ ] locator "@windowid='0'"
				[ ] 
			[+] StaticText ReminderCalendar
				[ ] locator "@windowid='-1'"
			[+] StaticText CalendarText
				[ ] locator "@windowid='-1'"
				[+] Control CalendarNextButton
					[ ] locator "@windowid='204'"
				[+] Control CalendarPreviousButton
					[ ] locator "@windowid='203'"
				[+] Control CalendarMonthLabel
					[ ] locator "@windowid='205'"
			[ ] 
		[+] Control QW_MDI_TOOLBAR1
			[ ] locator "@windowid='12000'"
		[+] PushButton MonthlyBillsDepositsTab
			[ ] locator "@windowid='32300'"
		[+] PushButton AllBillsDepositsTab
			[ ] locator "@windowid='32301'"
		[+] StaticText StaticText2
			[ ] // locator "@windowid='1072'"
			[+] MainWin ManageRemindersListViewer
				[ ] // locator "@windowid='1'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
				[+] MenuItem Delete
					[ ] locator "Delete"
					[ ] // locator "@windowid='513'"
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[+] StaticText StaticText3
				[ ] 
				[+] ComboBox ForAccountComboBox
					[ ] locator "@windowid='200'"
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin EditReminder
		[ ] locator "Edit Reminder"
		[+] TextField AmountTextField
			[ ] locator "@windowid='1019'"
		[+] TextField DueDateTextField
			[ ] locator "@windowid='1024'"
		[+] PushButton DueDatePushButton
			[ ] locator "@windowid='32766'"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[ ] 
	[+] // window DialogBox DlgEditReminder
		[ ] // locator "*Reminder"
		[+] // StaticText EditBillReminderText
			[ ] // locator "@windowid='100'"
		[+] // PushButton Done
			[ ] // locator "@windowid='32767'"
		[+] // PushButton Delete
			[ ] // locator "@windowid='32754'"
		[+] // PushButton Cancel
			[ ] // locator "@windowid='32766'"
		[+] // PushButton EditBillReminder
			[ ] // locator "@windowid='32765'"
		[+] // Control Panel1
			[ ] // locator "@windowid='-1'"
			[+] // Control QWinChild1
				[ ] // locator "@windowid='-1'"
				[+] // StaticText PayToText
					[ ] // locator "@windowid='101'"
				[+] // TextField PayTo
					[ ] // locator "@windowid='107'"
		[+] // Control Panel2
			[ ] // locator "@windowid='-1'"
			[+] // Control QWinChild1
				[ ] // locator "@windowid='-1'"
				[+] // TextField DueNextOnTextField
					[ ] // locator "@windowid='122'"
				[+] // Control ChangeLink
					[ ] // locator "@windowid='124'"
				[+] // TextField AmountDueTextField
					[ ] // locator "@windowid='126'"
				[+] // TextField FromAccountTextField
					[ ] // locator "@windowid='110'"
	[ ] 
	[+] window DialogBox DlgEnterIncomeTransaction
		[ ] locator "Enter * transaction"
		[+] StaticText EnterIncomeTransactionText
			[ ] locator "@windowid='32702'"
		[+] TextField PayeeInformationTextField
			[ ] locator "@windowid='10202'"
		[+] Control AddressButton
			[ ] locator "@windowid='10208'"
		[+] TextField CategoryTextField
			[ ] locator "@windowid='10204'"
		[+] Control SplitCategoryButton
			[ ] locator "@windowid='10207'"
		[+] TextField TagTextField
			[ ] locator "@windowid='10217'"
		[+] TextField MemoTextField
			[ ] locator "@windowid='10203'"
		[+] ComboBox AccountToUsePopupList
			[ ] locator "@windowid='10201'"
		[+] TextField MethodCheckNumberTextField
			[ ] locator "@windowid='10206'"
		[+] TextField AmountTextField
			[ ] locator "@windowid='10205'"
		[+] TextField DateTextField
			[ ] locator "@windowid='10200'"
		[+] PushButton EnterTransactionButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
	[ ] 
	[+] window DialogBox EnterExpenseTransaction                        //Added By Mukesh on 27th Feb 2013
		[ ] locator "Enter expense transaction"
		[+] PushButton EnterTransaction
			[ ] locator "Enter Transaction"
		[+] PushButton Cancel
			[ ] locator "Cancel"
	[ ] 
	[+] window MainWin SkipThisReminder
		[ ] locator "Skip this reminder"
		[+] CheckBox DontShowMeThisAgain
			[ ] locator "Don't show me this again"
		[+] PushButton SkipConfirmButton
			[ ] locator "@windowid=32767"
		[+] PushButton DontSkipButton
			[ ] locator "@windowid=32766"
	[ ] 
	[+] window DialogBox EditEarning
		[ ] locator "Edit Earning"
		[+] TextField NameTextField
			[ ] locator "@windowid='1101'"
		[+] TextField CategoryTextField
			[ ] locator "@windowid='1102'"
		[+] TextField AmountTextField
			[ ] locator "@windowid='1104'"
		[+] PushButton OKButton
			[ ] locator "@windowid=32767"
		[+] PushButton CancelButton
			[ ] locator "@windowid=32766"
	[ ] 
	[+] window MainWin CreateTransactionGroup
		[ ] locator "Create Transaction Group"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 							
[ ] 
[ ] //************* Spending *********************************************************
[+] 
	[+] window Control MDIClientSpending
		[ ] locator "@windowClassName='MDIClient'"
		[+] Control SpendingWindow
			[ ] locator "@windowClassName='QWMDI'"
			[+] StaticText TransactionsText
				[ ] locator "@windowid='7'"
				[ ] 
				[+] StaticText TotalText
					[ ] locator "Total*"
				[+] StaticText TotalValText
					[ ] locator "@windowid='1'"
				[+] StaticText TransactionCount
					[ ] locator "@windowid='21'"
			[+] TextField SearchWindow
				[ ] locator "@windowid='482'"
			[ ] 
			[+] Control ExamineYourSpending
				[ ] locator "@windowClassName='QWinChild'"
				[+] Control QWListViewer1
					[ ] locator "@windowid='4003'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] Control Panel
					[ ] locator "@windowid='-1'"
				[+] Control QWGraphControlClass1
					[ ] locator "@windowClassName='QWGraphControlClass'"
					[+] Control Panel
						[ ] locator "@windowClassName='QWPanel'"
						[+] MainWin Window1
							[ ] locator "@windowClassName='QWListViewer'"
							[+] ListBox ListBox1
								[ ] locator "@windowid='1'"
			[+] Control QWSnapHolder1
				[ ] locator "@windowid='-1'"
			[+] PushButton ResetButton
				[ ] locator "@windowid='450'"
			[+] ComboBox AccountsPopUpList
				[ ] locator "@windowid='449'"
			[+] ComboBox DatePopUpList
				[ ] locator "@windowid='452'"
			[+] ComboBox TransactionTypePopUpList
				[ ] locator "@windowid='454'"
			[ ] 
			[ ] 
			[ ] 
[ ] 
[-] //************* Business **********************************************************
	[ ] 
	[ ] // ------Business------------
	[+] window Control Business	
		[ ] locator "@caption='Business'"
		[+] Control ProfitLossSnapshot
			[ ] //locator "@windowid='0'"
			[ ] locator "@windowClassName='QWinChild'"
			[+] Control MonthPanel
				[ ] locator "@windowid='-1'"
				[+] Control QWListViewer1
					[ ] locator "@windowid='2030'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] StaticText TotalIn
					[ ] locator "@windowid='2051'"
				[+] StaticText TotalOut
					[ ] locator "@windowid='2091'"
				[+] Control QWListViewer2
					[ ] locator "@windowid='2070'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] StaticText LastMonthProjectedText
					[ ] locator "@windowid='2131'"
			[+] Control Panel2
				[ ] locator "@windowid='-1'"
				[+] PushButton AddReminderButton
					[ ] locator "@windowid='518'"
				[+] PushButton OptionsButton
					[ ] locator "@windowid='1000'"
				[+] StaticText StaticText1
					[ ] locator "@windowid='-1'"
					[+] PushButton AddReminderButton
						[ ] locator "@windowid='518'"
					[+] PushButton OptionsButton
						[ ] locator "@windowid='1000'"
					[+] StaticText StaticText1
						[ ] locator "@windowid='-1'"
						[+] PushButton AddReminderButton
							[ ] locator "@windowid='518'"
						[+] PushButton OptionsButton
							[ ] locator "@windowid='1000'"
						[+] StaticText StaticText1
							[ ] locator "@windowid='31000'"
							[+] PushButton OptionsButton
								[ ] locator "@windowid='1000'"
							[+] StaticText StaticText1
								[ ] locator "@windowid='-1'"
							[+] ComboBox ShowPopupList
									[ ] locator "@windowid='200'"
						[+] StaticText StaticText2
							[ ] locator "@windowid='-1'"
							[+] PushButton ManageRemindersButton
								[ ] locator "@windowid='507'"
							[+] PushButton AddReminderButton
								[ ] locator "@windowid='518'"
							[ ] 
					[+] StaticText StaticText2
						[ ] locator "@windowid='-1'"
						[+] PushButton ManageRemindersButton
							[ ] locator "@windowid='507'"
						[+] PushButton AddReminderButton
							[ ] locator "@windowid='518'"
						[ ] 
					[+] StaticText StaticText3
						[ ] locator "@windowid='31000'"
						[+] Control OptionsButton
							[ ] locator "@windowid='1000'"
					[+] Control QWHtmlView1
						[ ] locator "@windowid='-1'"
			[+] PushButton ProfitLossDetails
				[ ] locator "Profi*Loss Details"
			[+] Control QWSnapHolder
				[ ] locator "@windowid='-1'"
				[+] StaticText InvoiceAccounts
					[ ] locator "@windowid='-1'"
					[+] StaticText Account
						[ ] locator "@windowid='-1'"
						[+] Control QWListViewer
							[ ] locator "@windowid='120'"
							[+] ListBox InvoiceAccount
								[ ] locator "@windowid='1'"
			[+] PushButton SelectAccounts
				[ ] locator "@windowid='2225'"
			[+] PushButton CashFlowDetails
				[ ] locator "Cash Flow Details"
				[ ] //locator "@windowid='2226'"
			[+] PushButton ProjectedBalances
				[ ] locator "@windowid='2227'"
			[ ] 
			[ ] 
			[+] // Control Panel2		
				[ ] // locator "@windowid='-1'"						
				[+] // StaticText StaticText1
					[ ] // locator "@windowid='-1'"
				[+] // StaticText StaticText2
					[ ] // locator "@windowid='-1'"
					[+] // Control AddReminder
						[ ] // locator "@windowid='518'"
					[+] // PushButton ManageRemindersButton
						[ ] // locator "@windowid='507'"
					[ ] // 
			[ ] // 
			[+] ComboBox BusinessPopupList
				[ ] locator "@windowid='2221'"
			[+] PushButton ProfitLossDetailsButton
				[ ] locator "@windowid='2223'"
			[+] PushButton PreMonth
				[ ] locator "@windowid='32351'"
			[+] StaticText CurrentMonth
				[ ] locator "@windowid='32352'"
			[+] PushButton PostMonth
				[ ] locator "@windowid='32353'"
				[ ] 
			[+] Control SnapShotGraph
				[ ] locator "[@windowClassName='QWinChild']"
				[ ] //locator "@windowid='0'"
				[+] Control Panel1
					[ ] locator "//Control[@caption='Panel'][1]"
					[ ] //locator "@windowid='-1'"
					[+] Control INSnopshot
						[ ] locator "@windowid='2030'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] StaticText Total1Text
						[ ] locator "@windowid='2041'"
					[+] StaticText N0005Text
						[ ] locator "@windowid='2051'"
					[+] Control OUTSnopshot
						[ ] locator "@windowid='2070'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] StaticText Total2Text
						[ ] locator "@windowid='2081'"
					[+] StaticText N0006Text
						[ ] locator "@windowid='2091'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='2110'"
					[+] StaticText CurrentProfitText
						[ ] locator "@windowid='2111'"
					[+] StaticText OnMay3Text
						[ ] locator "@windowid='2112'"
					[+] StaticText N0001Text
						[ ] locator "@windowid='2120'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='2130'"
					[+] StaticText LastMonthSText
						[ ] locator "@windowid='2131'"
					[+] StaticText ProfitText
						[ ] locator "@windowid='2132'"
					[+] PushButton QC_button4
						[ ] locator "@windowid='2133'"
					[+] Control Profit1
						[ ] locator "@windowid='2134'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] Control Profit2
						[ ] locator "@windowid='2135'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
					[+] PushButton QC_button3
						[ ] locator "@windowid='2136'"
					[+] StaticText ProjectedChangeFromText
						[ ] locator "@windowid='2137'"
					[+] StaticText LastMonthText
						[ ] locator "@windowid='2138'"
					[+] StaticText N0002Text
						[ ] locator "@windowid='2140'"
					[+] StaticText N0003Text
						[ ] locator "@windowid='2141'"
					[+] StaticText N0004Text
						[ ] locator "@windowid='2142'"
					[+] Control ListViewer1
						[ ] locator "@windowid='2134'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
				[+] Control Panel2
					[ ] locator "@windowid='-1'"
					[+] StaticText StaticText1
						[ ] locator "@windowid='-1'"
						[+] Control AddReminder
							[ ] locator "@windowid='518'"
						[+] Control QWListViewer
							[ ] locator "@windowid='1'"
							[+] ListBox ListBox1
								[+] locator "@windowid='1'"
									[ ] 
			[ ]                                
		[+] ComboBox BusinessPopupList
			[ ] locator "@windowid='2221'"
		[+] PushButton ProfitLossDetailsButton
			[ ] locator "@windowid='2223'"
		[+] PushButton PreMonth
			[ ] locator "@windowid='32351'"
		[+] StaticText CurrentMonth
			[ ] locator "@windowid='32352'"
		[+] PushButton PostMonth
			[ ] locator "@windowid='32353'"
			[ ] 
		[+] Control SnapShotGraph
			[ ] locator "[@windowClassName='QWinChild']"
			[ ] //locator "@windowid='0'"
			[+] Control Panel1
				[ ] locator "//Control[@caption='Panel'][1]"
				[ ] //locator "@windowid='-1'"
				[+] Control INSnopshot
					[ ] locator "@windowid='2030'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] StaticText Total1Text
					[ ] locator "@windowid='2041'"
				[+] StaticText N0005Text
					[ ] locator "@windowid='2051'"
				[+] Control OUTSnopshot
					[ ] locator "@windowid='2070'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] StaticText Total2Text
					[ ] locator "@windowid='2081'"
				[+] StaticText N0006Text
					[ ] locator "@windowid='2091'"
				[+] PushButton QC_button1
					[ ] locator "@windowid='2110'"
				[+] StaticText CurrentProfitText
					[ ] locator "@windowid='2111'"
				[+] StaticText OnMay3Text
					[ ] locator "@windowid='2112'"
				[+] StaticText N0001Text
					[ ] locator "@windowid='2120'"
				[+] PushButton QC_button2
					[ ] locator "@windowid='2130'"
				[+] StaticText LastMonthSText
					[ ] locator "@windowid='2131'"
				[+] StaticText ProfitText
					[ ] locator "@windowid='2132'"
				[+] PushButton QC_button4
					[ ] locator "@windowid='2133'"
				[+] Control Profit1
					[ ] locator "@windowid='2134'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] Control Profit2
					[ ] locator "@windowid='2135'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] PushButton QC_button3
					[ ] locator "@windowid='2136'"
				[+] StaticText ProjectedChangeFromText
					[ ] locator "@windowid='2137'"
				[+] StaticText LastMonthText
					[ ] locator "@windowid='2138'"
				[+] StaticText N0002Text
					[ ] locator "@windowid='2140'"
				[+] StaticText N0003Text
					[ ] locator "@windowid='2141'"
				[+] StaticText N0004Text
					[ ] locator "@windowid='2142'"
				[+] Control ListViewer1
					[ ] locator "@windowid='2134'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
			[+] Control Panel2
				[ ] locator "@windowid='-1'"
				[+] StaticText StaticText1
					[ ] locator "@windowid='-1'"
					[+] Control AddReminder
						[ ] locator "@windowid='518'"
					[+] Control QWListViewer
						[ ] locator "@windowid='1'"
						[+] ListBox ListBox1
							[+] locator "@windowid='1'"
								[ ] 
		[+] PushButton ProfitLossDetails
			[ ] locator "Profi*Loss Details"
		[+] Control Panel2		
			[ ] locator "@windowid='-1'"						
			[+] StaticText StaticText1
				[ ] locator "@windowid='-1'"
			[+] StaticText StaticText2
				[ ] locator "@windowid='-1'"
				[+] Control AddReminder
					[ ] locator "@windowid='518'"
				[+] PushButton ManageRemindersButton
					[ ] locator "@windowid='507'"
				[ ] 
		[+] PushButton SelectAccounts
			[ ] locator "@windowid='2225'"
		[+] PushButton CashFlowDetails
			[ ] locator "Cash Flow Details"
			[ ] //locator "@windowid='2226'"
		[+] PushButton ProjectedBalances
			[ ] locator "@windowid='2227'"
		[+] StaticText ProjectedLossText
			[ ] locator "@windowid='2141'"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // ------Business > Invoices and Estimates > Print Statment > Print------------                                          
	[+] window DialogBox DlgPrintInvoice
		[ ] // locator "Customer Statements"
		[ ] locator "[@caption='Print Invoice']"
		[+] RadioList RadioList1
			[ ] locator "@windowid='121'"
		[+] ComboBox PopupList1
			[ ] locator "@windowid='31'"
		[+] PushButton Properties
			[ ] locator "@windowid='132'"
		[+] StaticText ThisPrinterPrintsToAPDFF1
			[ ] locator "@windowid='136'"
		[+] ComboBox ThisPrinterPrintsToAPDFF2
			[ ] locator "@windowid='135'"
		[+] StaticText ThisPrinterPrintsToAPDFF3
			[ ] locator "@windowid='65535'"
		[+] CheckBox PrintInColor
			[ ] locator "@windowid='238'"
		[+] CheckBox PrintInDraftMode
			[ ] locator "@windowid='202'"
		[+] CheckBox FitToOnePageWide
			[ ] locator "@windowid='649'"
		[+] StaticText OrientationText
			[ ] locator "@windowid='206'"
		[+] RadioList Orientation
			[ ] locator "@windowid='204'"
		[+] Control Orientation1
			[ ] locator "@windowid='65535'"
		[+] Control Orientation2
			[ ] locator "@windowid='65535'"
		[+] StaticText PrintRangeText
			[ ] locator "@windowid='201'"
		[+] RadioList PrintRange1
			[ ] locator "@windowid='126'"
		[+] StaticText FromText
			[ ] locator "@windowid='130'"
		[+] Control From
			[ ] locator "@windowid='128'"
		[+] StaticText ToText
			[ ] locator "@windowid='131'"
		[+] Control To
			[ ] locator "@windowid='129'"
		[+] StaticText NumberOfCopiesText
			[ ] locator "@windowid='65535'"
		[+] Control N1
			[ ] locator "@windowid='211'"
		[+] UpDown PrintRange2
			[ ] locator "@windowid='212'"
		[+] Control NumberOfCopies
			[ ] locator "@windowid='65535'"
		[+] Control QC_button2
			[ ] locator "@windowid='32765'"
		[+] PushButton PrinterSetupButton
			[ ] locator "@windowid='133'"
		[+] PushButton PreviewButton
			[ ] locator "Preview"
			[ ] // locator "@windowid='287'"
		[+] PushButton PrintButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[ ] 
	[ ] 
	[ ] //------Customer Invoices Account Actions > New Customer Invoice > New Tax Account ------------   
	[+] window DialogBox CreateTaxAccount
		[ ] locator "Create Tax Account"
		[+] StaticText CreateTaxAccountText
			[ ] locator "@windowid='32702'"
		[+] StaticText AccountNameText
			[ ] locator "@windowid='200'"
		[+] TextField AccountNameTextField
			[ ] locator "@windowid='201'"
		[+] StaticText DescriptionText
			[ ] locator "@windowid='202'"
		[+] TextField DescriptionTextField
			[ ] locator "@windowid='203'"
		[+] StaticText TaxRateText
			[ ] locator "@windowid='204'"
		[+] TextField TaxRateTextField
			[ ] locator "@windowid='205'"
		[+] PushButton TaxRate2
			[ ] locator "@windowid='32765'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] //------Business > Invoices and Estimates > Print Statment > Print > Preview------------				
	[+] window DialogBox DlgPrintPreview
		[ ] locator "Print Preview*"
		[+] PushButton PrintButton
			[ ] locator "@windowid='106'"
		[+] PushButton PrevPage
			[ ] locator "@windowid='108'"
		[+] PushButton NextPage
			[ ] locator "@windowid='107'"
		[+] PushButton ZoomIn
			[ ] locator "@windowid='109'"
		[+] PushButton QC_button5
			[ ] locator "@windowid='32765'"
		[+] Control PR_Preview1
			[ ] locator "@windowid='105'"
		[+] Control PR_HLine1
			[ ] locator "@windowid='110'"
	[ ] 
	[ ] //------Business > Invoices and Estimates > Create Invoice------------
	[+] window MainWin ChooseInvoiceAccount
		[ ] locator "Choose*Account"
		[+] StaticText ChooseInvoiceAccountText
			[ ] locator "@windowid='32702'"
		[+] StaticText PleaseChooseAnInvoiceAccou1
			[ ] locator "@windowid='3011'"
		[+] ComboBox ChooseInvoiceAccount
			[ ] locator "@windowid='3012'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
			[ ] 
	[ ] 
	[ ] //------Business -> Bills and Vendors ->Create Bill.------------
	[+] window MainWin ChooseBillAccount
		[ ] locator "Choose*Account"
		[+] ComboBox ChooseBillAccount
			[ ] locator "@windowid='3012'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
	[ ] 
	[+] window MainWin RefundVendorInvoice
		[ ] locator "Refund*"
		[+] ComboBox AccountToDepositTo
			[ ] locator "@windowid='10201'"
		[+] TextField Vendor
			[ ] locator "@windowid='10202'"
		[+] PushButton Address
			[ ] locator "@windowid='10208'"
		[+] TextField xDate
			[ ] locator "@windowid='222'"
		[+] TextField Customer
			[ ] locator "@windowid='206'"
		[+] TextField ProjectJob
			[ ] locator "@windowid='300'"
		[+] PushButton AssignProjectJob
			[ ] locator "@windowid='302'"
		[+] TextField Amount
			[ ] locator "@windowid='10205'"
		[+] TextField Memo1
			[ ] locator "@windowid='10203'"
		[+] TextField xNumber
			[ ] locator "@windowid='268'"
		[+] PushButton Memo2
			[ ] locator "@windowid='32765'"
		[+] PushButton Enter
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control RefundVendorInvoices1
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control RequiredFields1
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control RequiredFields2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
	[ ] 
	[+] window MainWin DlgManageBusinessInformation
		[ ] locator "Manage Business Information"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] PushButton DoneButton
			[ ] locator "@windowid='32766'"
		[+] Control ManageBusinessInformationList
			[ ] locator "//Control[@windowClassName='QWinChild']"
			[+] MainWin QWListViewer1
				[ ] locator "@windowid='1000'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
			[+] PushButton AddButton
				[ ] locator "@windowid='1001'"
			[+] PushButton EditButton
				[ ] locator "@windowid='1002'"
			[+] PushButton DeleteButton
				[ ] locator "@windowid='1003'"
	[ ] 
	[+] window MainWin DlgAddBusiness
		[ ] locator "*Business"
		[+] TextField BusinessNameTextField
			[ ] locator "@windowid='1002'"
		[+] TextField DescriptionTextField
			[ ] locator "@windowid='1004'"
		[+] RadioList DescriptionRadioList
			[ ] locator "@windowid='1007'"
		[+] TextField BusinessTagTextField
			[ ] locator "@windowid='1012'"
		[+] CheckBox BusinessTransactionsWithout
			[ ] locator "@windowid='1014'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
	[ ] 
	[+] // window MainWin DlgInvoice
		[ ] // locator "[@caption='Invoice*' or @caption='Bill*']"
		[+] // PushButton SaveAndNewButton
			[ ] // locator "@windowid='296'"
		[+] // PushButton SaveAndDoneButton
			[ ] // locator "@windowid='295'"
		[+] // PushButton CancelButton
			[ ] // locator "@windowid='32766'"
		[+] // PushButton EnterButton
			[ ] // locator "@windowid='32767'"
		[+] // StaticText CustomerText
			[ ] // locator "@windowid='65535'"
		[+] // StaticText DATEText
			[ ] // locator "@windowid='221'"
		[+] // TextField DATETextField
			[ ] // locator "@windowid='222'"
		[+] // TextField INVOICETextField
			[ ] // locator "@windowid='226'"
		[+] // TextField PONUMBERTextField
			[ ] // locator "@windowid='228'"
		[+] // PushButton AddLinesButton
			[ ] // locator "@windowid='233'"
		[+] // StaticText DUEDATEText
			[ ] // locator "@windowid='223'"
		[+] // TextField DUEDATETextField
			[ ] // locator "@windowid='224'"
		[+] // TextField CustomerTextField
			[ ] // locator "@windowid='10202'"
		[+] // StaticText ProjectJobText
			[ ] // locator "@windowid='301'"
		[+] // TextField ProjectJobTextField
			[ ] // locator "@windowid='300'"
		[+] // StaticText LayoutText     
			[ ] // locator "@windowid='260'"       
		[+] // ComboBox LayoutPopupList  
			[ ] // locator "@windowid='261'"
		[+] // StaticText BusinessTagText
			[ ] // locator "@windowid='1000'"
		[+] // TextField BusinessTagTextField
			[ ] // locator "@windowid='1001'"
		[+] // StaticText BILLTOText
			[ ] // locator "@windowid='209'"
		[+] // TextField BILLTO1TextField
			[ ] // locator "@windowid='210'"
		[+] // TextField BILLTO2TextField
			[ ] // locator "@windowid='211'"
		[+] // TextField BILLTO3TextField
			[ ] // locator "@windowid='212'"
		[+] // TextField BILLTO4TextField
			[ ] // locator "@windowid='213'"
		[+] // TextField BILLTO5TextField
			[ ] // locator "@windowid='214'"
		[+] // StaticText SHIPTOText
			[ ] // locator "@windowid='215'"
		[+] // TextField SHIPTO1TextField
			[ ] // locator "@windowid='216'"
		[+] // TextField SHIPTO2TextField
			[ ] // locator "@windowid='217'"
		[+] // TextField SHIPTO3TextField
			[ ] // locator "@windowid='218'"
		[+] // TextField SHIPTO4TextField
			[ ] // locator "@windowid='219'"
		[+] // TextField SHIPTO5TextField
			[ ] // locator "@windowid='220'"
		[+] // StaticText TaxText
			[ ] // locator "@windowid='231'"
		[+] // TextField TaxTextField
			[ ] // locator "@windowid='232'"
		[+] // StaticText TotalText
			[ ] // locator "@windowid='259'"
		[+] // StaticText TotalAmountText
			[ ] // locator "@windowid='204'"
		[+] // StaticText CustomerMessageText
			[ ] // locator "@windowid='229'"
		[+] // TextField CustomerMessageTextField
			[ ] // locator "@windowid='230'"
		[+] // StaticText MemoText
			[ ] // locator "@windowid='244'"
		[+] // TextField MemoTextField
			[ ] // locator "@windowid='245'"
		[+] // StaticText TaxAccountText
			[ ] // locator "@windowid='246'"
		[+] // ComboBox TaxAccountPopupList          
			[ ] // locator "@windowid='247'"                 
		[+] // PushButton ReceivePaymentButton
			[ ] // locator "@windowid='250'"
		[+] // PushButton PaymentHistoryButton
			[ ] // locator "@windowid='251'"
		[+] // PushButton ExpensesButton
			[ ] // locator "@windowid='252'"
		[+] // PushButton EMailSendToClipboardButton
			[ ] // locator "@windowid='293'"
		[+] // MainWin QWListViewerItem
			[ ] // locator "@windowid='200'"
			[+] // ListBox ListBox
				[ ] // locator "@windowid='1'"
				[+] // // TextField TextField1
					[ ] // // locator "@windowid='1002'"
					[ ] // // 
				[+] // TextField ItemNameTextField
					[ ] // locator "@windowid='1007'"
				[+] // TextField CategoryTextField
					[ ] // locator "@windowid='1002'"
				[+] // TextField DescriptionTextField
					[ ] // locator "@windowid='1004'"
				[+] // TextField QuantityTextField
					[ ] // locator "@windowid='1008'"
				[+] // TextField RateTextField
					[ ] // locator "@windowid='1009'"
				[+] // TextField AmountTextField
					[ ] // locator "@windowid='1005'"
				[ ] // 
		[+] // DialogBox DlgSendInvoiceByEMail
			[ ] // locator "Send Invoice by E-mail"
			[+] // StaticText SendInvoiceByEMailText
				[ ] // locator "@windowid='32702'"
			[+] // StaticText FormatText
				[ ] // locator "@windowid='65535'"
			[+] // RadioList FormatRadioList
				[ ] // locator "@windowid='3042'"
			[+] // StaticText OutputText
				[ ] // locator "@windowid='65535'"
			[+] // RadioList OutputRadioList
				[ ] // locator "@windowid='3032'"
			[+] // StaticText SendText
				[ ] // locator "@windowid='65535'"
			[+] // RadioList Send1RadioList
				[ ] // locator "@windowid='3051'"
			[+] // StaticText AText
				[ ] // locator "@windowid='3021'"
			[+] // StaticText EMailAddressText
				[ ] // locator "@windowid='65535'"
			[+] // TextField EMailAddressTextField
				[ ] // locator "@windowid='3022'"
			[+] // PushButton HelpButton
				[ ] // locator "@windowid='32765'"
			[+] // PushButton OKButton
				[ ] // locator "@windowid='32767'"
			[+] // PushButton CancelButton
				[ ] // locator "@windowid='32766'"
		[+] // DialogBox DlgFormToClipBoard
			[ ] // locator "Quicken 20*"
			[+] // Control QWIconDisplay1
				[ ] // locator "@windowid='105'"
			[+] // StaticText TheFormText
				[ ] // locator "@windowid='100'"
			[+] // PushButton OKButton
				[ ] // locator "@windowid='101'"
				[ ] // 
				[ ] // 
		[ ] // //Other Window UI
		[ ] // 
		[+] // PushButton OK
			[ ] // locator "@windowid='32767'"
		[+] // ComboBox DepositToPopupList
			[ ] // locator "@windowid='270'"
		[+] // TextField CheckNumberTextField
			[ ] // locator "@windowid='268'"
		[+] // PushButton ClearPaymentsButton
			[ ] // locator "@windowid='262'"
		[+] // TextField AmountTextField
			[ ] // locator "@windowid='266'"
		[ ] // //Add for Vendor Invoice
		[ ] // 
		[+] // TextField BILLNOTextField
			[ ] // locator "@windowid='226'"
		[ ] // 
		[+] // MainWin CategoryList
			[ ] // locator "@windowid='200'"
			[+] // ListBox ListBox1
				[ ] // locator "@windowid='1'"
				[+] // TextField TextField1
					[ ] // locator "@windowid='1002'"
				[+] // TextField TextField11
					[ ] // locator "@windowid='1003'"
				[+] // TextField TextField12
					[ ] // locator "@windowid='1004'"
				[+] // TextField TextField13
					[ ] // locator "@windowid='1012'"
				[+] // TextField TextField14
					[ ] // locator "@windowid='1005'"
		[ ] // 
		[+] // PushButton CreatePaymentButton
			[ ] // locator "@windowid='250'"
		[ ] // 
		[+] // TextField VendorTextField
			[ ] // locator "@windowid='10202'"
		[+] // TextField VendorCheckNumberTextField
			[ ] // locator "@windowid='10206'"
		[ ] // 
		[+] // PushButton AssignProjectJobButton
			[ ] // locator "@windowid='302'"
			[ ] // 
		[+] // ComboBox WithdrawFromPopupList
			[ ] // locator "@windowid='10201'"
		[+] // DialogBox SelectProjectJob
			[ ] // locator "Select Project?Job"
			[+] // MainWin QWListViewerProjectJob
				[ ] // locator "@windowid='3335'"
				[+] // ListBox ListBox1
					[ ] // locator "@windowid='1'"
					[ ] // 
			[+] // PushButton NewProjectJob
				[ ] // locator "@windowid='3336'"
			[+] // PushButton OK
				[ ] // locator "OK"
			[+] // PushButton Cancel
				[ ] // locator "Cancel"
			[ ] // 
			[ ] // 
		[ ] // 
		[ ] // 
	[-] window MainWin DlgInvoice
		[ ] locator "[@caption='Invoice*' or @caption='Bill*' or @caption='Payment*']"
		[+] PushButton SaveAndNewButton
			[ ] locator "@windowid='296'"
		[+] PushButton SaveAndDoneButton
			[ ] locator "@windowid='295'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton EnterButton
			[ ] locator "@windowid='32767'"
		[+] StaticText CustomerText
			[ ] locator "@windowid='65535'"
		[+] StaticText DATEText
			[ ] locator "@windowid='221'"
		[+] TextField DATETextField
			[ ] locator "DATE"
			[ ] //locator "@windowid='222'"
		[+] TextField INVOICETextField
			[ ] locator "@windowid='226'"
		[+] TextField PONUMBERTextField
			[ ] locator "@windowid='228'"
		[+] PushButton AddLinesButton
			[ ] locator "@windowid='233'"
		[+] StaticText DUEDATEText
			[ ] locator "@windowid='223'"
		[+] TextField DUEDATETextField
			[ ] locator "DUE DATE"
			[ ] //locator "@windowid='224'"
		[+] TextField CustomerTextField
			[ ] locator "@windowid='10202'"
		[+] StaticText ProjectJobText
			[ ] locator "@windowid='301'"
		[+] TextField ProjectJobTextField
			[ ] locator "@windowid='300'"
		[+] StaticText LayoutText     
			[ ] locator "@windowid='260'"       
		[+] ComboBox LayoutPopupList  
			[ ] locator "@windowid='261'"
		[+] StaticText BusinessTagText
			[ ] locator "@windowid='1000'"
		[+] TextField BusinessTagTextField
			[ ] locator "@windowid='1001'"
		[+] StaticText BILLTOText
			[ ] locator "@windowid='209'"
		[+] TextField BILLTO1TextField
			[ ] locator "@windowid='210'"
		[+] TextField BILLTO2TextField
			[ ] locator "@windowid='211'"
		[+] TextField BILLTO3TextField
			[ ] locator "@windowid='212'"
		[+] TextField BILLTO4TextField
			[ ] locator "@windowid='213'"
		[+] TextField BILLTO5TextField
			[ ] locator "@windowid='214'"
		[+] StaticText SHIPTOText
			[ ] locator "@windowid='215'"
		[+] TextField SHIPTO1TextField
			[ ] locator "@windowid='216'"
		[+] TextField SHIPTO2TextField
			[ ] locator "@windowid='217'"
		[+] TextField SHIPTO3TextField
			[ ] locator "@windowid='218'"
		[+] TextField SHIPTO4TextField
			[ ] locator "@windowid='219'"
		[+] TextField SHIPTO5TextField
			[ ] locator "@windowid='220'"
		[+] StaticText TaxText
			[ ] locator "@windowid='231'"
		[+] TextField TaxTextField
			[ ] locator "@windowid='232'"
		[+] StaticText TotalText
			[ ] locator "@windowid='259'"
		[+] StaticText TotalAmountText
			[ ] locator "@windowid='204'"
		[+] StaticText CustomerMessageText
			[ ] locator "@windowid='229'"
		[+] TextField CustomerMessageTextField
			[ ] locator "@windowid='230'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField MemoTextField
			[ ] locator "@windowid='245'"
		[+] StaticText TaxAccountText
			[ ] locator "@windowid='246'"
		[+] ComboBox TaxAccountPopupList          
			[ ] locator "@windowid='247'"                 
		[+] PushButton ReceivePaymentButton
			[ ] locator "@windowid='250'"
		[+] PushButton PaymentHistoryButton
			[ ] locator "@windowid='251'"
		[+] PushButton ExpensesButton
			[ ] locator "@windowid='252'"
		[+] PushButton EMailSendToClipboardButton
			[ ] locator "@windowid='293'"
		[+] MainWin QWListViewerItem
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
				[+] // TextField TextField1
					[ ] // locator "@windowid='1002'"
					[ ] // 
				[+] TextField ItemNameTextField
					[ ] locator "@windowid='1007'"
				[+] TextField CategoryTextField
					[ ] locator "@windowid='1002'"
				[+] TextField DescriptionTextField
					[ ] locator "@windowid='1004'"
				[+] TextField QuantityTextField
					[ ] locator "@windowid='1008'"
				[+] TextField RateTextField
					[ ] locator "@windowid='1009'"
				[+] TextField AmountTextField
					[ ] locator "@windowid='1005'"
				[ ] 
		[+] DialogBox DlgSendInvoiceByEMail
			[ ] locator "Send Invoice by E-mail"
			[+] StaticText SendInvoiceByEMailText
				[ ] locator "@windowid='32702'"
			[+] StaticText FormatText
				[ ] locator "@windowid='65535'"
			[+] RadioList FormatRadioList
				[ ] locator "@windowid='3042'"
			[+] StaticText OutputText
				[ ] locator "@windowid='65535'"
			[+] RadioList OutputRadioList
				[ ] locator "@windowid='3032'"
			[+] StaticText SendText
				[ ] locator "@windowid='65535'"
			[+] RadioList Send1RadioList
				[ ] locator "@windowid='3051'"
			[+] StaticText AText
				[ ] locator "@windowid='3021'"
			[+] StaticText EMailAddressText
				[ ] locator "@windowid='65535'"
			[+] TextField EMailAddressTextField
				[ ] locator "@windowid='3022'"
			[+] PushButton HelpButton
				[ ] locator "@windowid='32765'"
			[+] PushButton OKButton
				[ ] locator "@windowid='32767'"
			[+] PushButton CancelButton
				[ ] locator "@windowid='32766'"
		[+] DialogBox DlgFormToClipBoard
			[ ] locator "Quicken 20*"
			[+] Control QWIconDisplay1
				[ ] locator "@windowid='105'"
			[+] StaticText TheFormText
				[ ] locator "@windowid='100'"
			[+] PushButton OKButton
				[ ] locator "@windowid='101'"
				[ ] 
				[ ] 
		[ ] //Other Window UI
		[ ] 
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] ComboBox DepositToPopupList
			[ ] locator "@windowid='270'"
		[+] TextField CheckNumberTextField
			[ ] locator "@windowid='268'"
		[+] PushButton ClearPaymentsButton
			[ ] locator "@windowid='262'"
		[+] TextField AmountTextField
			[ ] locator "@windowid='266'"
		[ ] //Add for Vendor Invoice
		[ ] 
		[+] TextField BILLNOTextField
			[ ] locator "@windowid='226'"
		[ ] 
		[+] MainWin CategoryList
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[+] TextField TextField1
					[ ] locator "@windowid='1002'"
				[+] TextField TextField11
					[ ] locator "@windowid='1003'"
				[+] TextField TextField12
					[ ] locator "@windowid='1004'"
				[+] TextField TextField13
					[ ] locator "@windowid='1012'"
				[+] TextField TextField14
					[ ] locator "@windowid='1005'"
		[ ] 
		[+] PushButton CreatePaymentButton
			[ ] locator "@windowid='250'"
		[ ] 
		[+] TextField VendorTextField
			[ ] locator "@windowid='10202'"
		[+] TextField VendorCheckNumberTextField
			[ ] locator "@windowid='10206'"
		[ ] 
		[+] PushButton AssignProjectJobButton
			[ ] locator "@windowid='302'"
			[ ] 
		[+] ComboBox WithdrawFromPopupList
			[ ] locator "@windowid='10201'"
		[+] DialogBox SelectProjectJob
			[ ] locator "Select Project?Job"
			[+] MainWin QWListViewerProjectJob
				[ ] locator "@windowid='3335'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
					[ ] 
			[+] PushButton NewProjectJob
				[ ] locator "@windowid='3336'"
			[+] PushButton OK
				[ ] locator "OK"
			[+] PushButton Cancel
				[ ] locator "Cancel"
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //------Business >> Invoices and Estimates >> View All Invoice------------
	[+] window MainWin DlgViewAllInvoice
		[ ] locator "//MainWin[@caption='Print Invoices']"
		[+] StaticText PrintInvoicesText
			[ ] locator "@windowid='32702'"
		[+] StaticText SelectAccountText
			[ ] locator "@windowid='3001'"
		[+] ComboBox PrintInvoices1
			[ ] locator "@windowid='3007'"
		[+] StaticText ShowInvoicesCreatedSinceTe
			[ ] locator "@windowid='3002'"
		[+] TextField PrintInvoices2
			[ ] locator "@windowid='3009'"
		[+] MainWin SelectAccount
			[ ] locator "@windowid='3010'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton MarkAll
			[ ] locator "@windowid='32215'"
		[+] PushButton ClearAll
			[ ] locator "@windowid='32216'"
		[+] PushButton Options
			[ ] locator "@windowid='32756'"
		[+] PushButton SelectAccount1
			[ ] locator "@windowid='32765'"
		[+] PushButton SelectAccount2
			[ ] locator "@windowid='32760'"
		[+] PushButton Done
			[ ] locator "@windowid='32766'"
		[+] Control PrintInvoices3
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[ ] 
	[ ] 
	[ ] //------Customer Invoices Account Actions> New Payment Invoice------------
	[+] window MainWin DlgPaymentInvoices
		[ ] locator "Payment*"
		[+] PushButton EnterButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] StaticText CustomerVendorText
			[ ] locator "@windowid='65535'"
		[+] TextField CustomerVendorTextField
			[ ] locator "@windowid='10202'"
		[+] StaticText AmountText
			[ ] locator "@windowid='265'"
		[+] TextField AmountTextField
			[ ] locator "@windowid='266'"
		[+] StaticText DepositToText
			[ ] locator "@windowid='269'"
		[+] ComboBox ToFromAccountPopupList
			[ ] locator "@windowid='270' or @windowid='10201'"
		[+] StaticText CheckNumberText
			[ ] locator "@windowid='267'"
		[+] TextField CheckNumberTextField
			[ ] locator "@windowid='10206' or @windowid='268'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField MemoTextField
			[ ] locator "@windowid='245'"
		[+] StaticText DATEText
			[ ] locator "@windowid='221'"
		[+] TextField DATETextField
			[ ] locator "@windowid='222'"
		[ ] 
	[ ] 
	[ ] 
	[ ] //------Customer Invoices Account Actions> New Credit Invoice------------
	[+] window MainWin DlgCreditInvoices
		[ ] locator "Credit*"
		[+] PushButton EnterButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] StaticText CustomerText
			[ ] locator "@windowid='65535'"
		[+] TextField CustomerTextField
			[ ] locator "@windowid='10202'"
		[+] StaticText ProjectJobText
			[ ] locator "@windowid='301'"
		[+] TextField ProjectJobTextField
			[ ] locator "@windowid='300'"
		[+] StaticText BusinessTagText
			[ ] locator "@windowid='1000'"
		[+] TextField BusinessTagTextField
			[ ] locator "@windowid='1001'"
		[+] StaticText LayoutText     
			[ ] locator "@windowid='260'"       
		[+] ComboBox LayoutPopupList 
			[ ] locator "@windowid='261'"
		[+] StaticText DATEText 
			[ ] locator "@windowid='221'"
		[+] TextField xDATE1TextField
			[ ] locator "@windowid='222'"
		[+] TextField PONUMBERTextField
			[ ] locator "@windowid='228'"
		[+] StaticText CUSTOMERText
			[ ] locator "@windowid='209'"
		[+] TextField CUSTOMER1TextField
			[ ] locator "@windowid='210'"
		[+] TextField CUSTOMER2TextField
			[ ] locator "@windowid='211'"
		[+] TextField CUSTOMER3TextField
			[ ] locator "@windowid='212'"
		[+] TextField CUSTOMER4TextField
			[ ] locator "@windowid='213'"
		[+] TextField CUSTOMER5TextField
			[ ] locator "@windowid='214'"
		[+] StaticText TaxText
			[ ] locator "@windowid='231'"
		[+] TextField TaxTextField
			[ ] locator "@windowid='232'"
		[+] StaticText TotalText
			[ ] locator "@windowid='259'"
		[+] StaticText TotalAmountText
			[ ] locator "@windowid='204'"
		[+] StaticText CustomerMessageText
			[ ] locator "@windowid='229'"
		[+] TextField CustomerMessageTextField
			[ ] locator "@windowid='230'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField MemoTextField
			[ ] locator "@windowid='245'"
		[+] StaticText TaxAccountText
			[ ] locator "@windowid='246'"
		[+] ComboBox TaxAccountPopupList
			[ ] locator "@windowid='247'"
		[+] PushButton ReceivePaymentButton
			[ ] locator "@windowid='250'"
		[+] PushButton PaymentHistoryButton
			[ ] locator "@windowid='251'"
		[+] PushButton ExpensesButton
			[ ] locator "@windowid='252'"
		[+] PushButton EMailSendToClipboardButton
			[ ] locator "@windowid='293'"
		[+] MainWin QWListViewerItem
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox
				[ ] locator "@windowid='1'"
				[+] TextField CategoryTextField
					[ ] locator "@windowid='1002'"
					[ ] 
				[+] TextField DescriptionTextField
					[ ] locator "@windowid='1004'"
				[+] TextField AmountTextField
					[ ] locator "@windowid='1005'"
					[ ] 
				[ ] 
		[+] PushButton RefundButton          
			[ ] locator "@windowid='283'"                                                                                  
		[+] PushButton AddLinesButton
			[ ] locator "@windowid='233'"
		[ ] //Vendor Invoice Specific fields
		[+] StaticText VendorText
			[ ] locator "@windowid='65535'"
		[+] TextField VendorTextField
			[ ] locator "@windowid='10202'"
		[+] TextField TextFieldCustomerTextField
			[ ] locator "@windowid='206'"
		[+] TextField TextFieldProjectJobTextField
			[ ] locator "@windowid='300'"
		[+] PushButton AssignProjectJobButton
			[ ] locator "@windowid='302'"
		[+] TextField VENDORADDRESS1TextField
			[ ] locator "@windowid='210'"
		[ ] 
	[ ] 
	[ ] 
	[ ] //------Customer Invoices Account Actions> New Refund------------
	[+] window MainWin DlgRefund
		[ ] locator "Refund*"
		[+] PushButton EnterButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] ComboBox AccountToFromPopupList
			[ ] locator "@windowid='10201'"
		[+] StaticText BusinessTagText
			[ ] locator "@windowid='1000'"
		[+] TextField BusinessTagTextField
			[ ] locator "@windowid='1001'"
		[+] StaticText CustomerText
			[ ] locator "@windowid='311'"
		[+] TextField CustomerTextField
			[ ] locator "@windowid='10202'"
		[+] PushButton AddressButton
			[ ] locator "@windowid='10208'"
		[+] StaticText DateText
			[ ] locator "@windowid='221'"
		[+] TextField DateTextField
			[ ] locator "@windowid='10200'"
		[+] StaticText ProjectJobText
			[ ] locator "@windowid='301'"
		[+] TextField ProjectJobTextField
			[ ] locator "@windowid='300'"
		[+] StaticText AmountText
			[ ] locator "@windowid='265'"
		[+] TextField AmountTextField
			[ ] locator "@windowid='10205'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField MemoTextField
			[ ] locator "@windowid='10203'"
		[+] StaticText NumberText
			[ ] locator "@windowid='267'"
		[+] TextField NumberTextField
			[ ] locator "Number:"
			[ ] // locator "@windowid='10206'"
		[+] TextField VendorTextField
			[ ] locator "@windowid='10202'"
		[+] PushButton AssignProjectJobButton
			[ ] locator "@windowid='302'"
		[ ] 
	[ ] 
	[ ] //------Business > Invoices And Estimates > Create a Finance Charge------------
	[+] window MainWin DlgCreateFinanceCharge
		[ ] locator "Create Finance Charge"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] TextField CustomerTextField
			[ ] locator "@windowid='3200'"
		[+] TextField ProjectJobTextField
			[ ] locator "@windowid='3216'"
		[+] TextField DateTextField
			[ ] locator "@windowid='3211'"
		[+] TextField CategoryTextField
			[ ] locator "@windowid='3201'"
		[+] TextField NumberTextField
			[ ] locator "@windowid='3212'"
		[+] TextField MemoTextField
			[ ] locator "@windowid='3214'"
		[+] TextField DueDateTextField
			[ ] locator "@windowid='3215'"
		[+] Control UnpaidInvoicesQWListViewer
			[ ] locator "@windowid='3202'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] TextField FinanceChargeTextField
			[ ] locator "@windowid='3213'"
		[ ] 
	[ ] 
	[ ] 
	[ ] //------Customer Invoices Account Actions> Set Invoice Defaults------------
	[+] window DialogBox DlgSetInvoiceDefaults
		[ ] locator "Set Invoice Defaults"
		[+] StaticText DefaultText
			[ ] locator "@windowid='200'"
		[+] StaticText DueDateText
			[ ] locator "@windowid='201'"
		[+] TextField DueDateTextField
			[ ] locator "@windowid='202'"
		[+] StaticText DaysAfterInvoiceDateText
			[ ] locator "@windowid='203'"
		[+] StaticText TaxAccountText
			[ ] locator "@windowid='204'"
		[+] ComboBox TaxAccountPopupList
			[ ] locator "@windowid='205'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
	[ ] 
	[ ] 
	[ ] //------Customer Invoices Account Actions> New Customer Invoice>New Item------------
	[ ] 
	[+] window MainWin DlgNewItem
		[ ] locator "New Item"
		[+] TextField NewItemTextField
			[ ] locator "@windowid='202'"
		[+] TextField CategoryTagTextField
			[ ] locator "@windowid='204'"
		[+] TextField DescriptionTextField
			[ ] locator "@windowid='206'"
		[+] CheckBox SubtotalOfThePrecedingItemCheckBox
			[ ] locator "@windowid='211'"
		[+] CheckBox PrintExtraBlankLineCheckBox
			[ ] locator "@windowid='213'"
		[+] TextField PerItemRateTextField
			[ ] locator "@windowid='208'"
		[+] CheckBox TaxableCheckBox
			[ ] locator "@windowid='209'"
		[+] CheckBox PercentageCheckBox
			[ ] locator "@windowid='212'"
		[+] CheckBox InactiveCheckBox
			[ ] locator "@windowid='210'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] //------Customer Invoices Account Actions> New Customer Invoice>NewProjectJob------------
	[+] window MainWin DlgNewProjectJob
		[ ] locator "*Project*"
		[+] TextField CustomerTextField
			[ ] locator "@windowid='3321'"
		[+] StaticText ProjectJobText
			[ ] locator "@windowid='65535'"
		[+] TextField ProjectJobTextField
			[ ] locator "@windowid='3320'"
		[+] StaticText StatusText
			[ ] locator "@windowid='65535'"
		[+] ComboBox StatusPopupList
			[ ] locator "@windowid='3322'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
			[ ] 
	[ ] //------Customer Invoices Account Actions> New Vendor Invoice>NewProjectJob------------
	[ ] 
	[ ] //------Customer Invoices Account Actions> New Vendor Invoice>NewProjectJob------------
	[+] window MainWin DlgSelectProjectJob
		[ ] locator "*Project*"
		[+] StaticText SelectProjectJobText
			[ ] locator "@caption='Select Project?Job'"
		[+] MainWin SelectProjectJobQWListViewer
			[ ] locator "@windowid='3335'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton NewProjectJobButton
			[ ] locator "@windowid='3336'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] 
	[ ] //------Business >  Invoices And Estimates > Create Invoice------------
	[+] window MainWin DlgInvoiceCustomerInvoicesAccount
		[ ] locator "Invoice*"
		[+] StaticText InvoiceCustomerInvoicesAc1
			[ ] locator "@windowid='32702'"
		[+] StaticText CustomerText
			[ ] locator "@windowid='65535'"
		[+] TextField Customer
			[ ] locator "@windowid='10202'"
		[+] StaticText ProjectJobText
			[ ] locator "@windowid='301'"
		[+] TextField ProjectJob
			[ ] locator "@windowid='300'"
		[+] StaticText LayoutText
			[ ] locator "@windowid='260'"
		[+] ComboBox Layout
			[ ] locator "@windowid='261'"
		[+] StaticText BusinessTagText
			[ ] locator "@windowid='1000'"
		[+] TextField BusinessTag
			[ ] locator "@windowid='1001'"
		[+] StaticText CustomerInvoiceText
			[ ] locator "@windowid='202'"
		[+] StaticText BILLTOText
			[ ] locator "@windowid='209'"
		[+] TextField BILLTO1
			[ ] locator "@windowid='210'"
		[+] TextField BILLTO2
			[ ] locator "@windowid='211'"
		[+] TextField BILLTO3
			[ ] locator "@windowid='212'"
		[+] TextField BILLTO4
			[ ] locator "@windowid='213'"
		[+] TextField BILLTO5
			[ ] locator "@windowid='214'"
		[+] StaticText SHIPTOText
			[ ] locator "@windowid='215'"
		[+] TextField SHIPTO1
			[ ] locator "@windowid='216'"
		[+] TextField SHIPTO2
			[ ] locator "@windowid='217'"
		[+] TextField SHIPTO3
			[ ] locator "@windowid='218'"
		[+] TextField SHIPTO4
			[ ] locator "@windowid='219'"
		[+] TextField SHIPTO5
			[ ] locator "@windowid='220'"
		[+] StaticText DATEText
			[ ] locator "@windowid='221'"
		[+] TextField xDATE1
			[ ] locator "@windowid='222'"
		[+] StaticText INVOICEText
			[ ] locator "@windowid='225'"
		[+] TextField INVOICE
			[ ] locator "@windowid='226'"
		[+] StaticText DUEDATEText
			[ ] locator "@windowid='223'"
		[+] TextField DUEDATE1
			[ ] locator "@windowid='224'"
		[+] StaticText PONUMBERText
			[ ] locator "@windowid='227'"
		[+] TextField PONUMBER
			[ ] locator "@windowid='228'"
		[+] Control DUEDATE2
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton AddLines
			[ ] locator "@windowid='233'"
		[+] StaticText SubtotalText
			[ ] locator "@windowid='241'"
		[+] StaticText N0001Text
			[ ] locator "@windowid='242'"
		[+] StaticText TaxText
			[ ] locator "@windowid='231'"
		[+] TextField Tax
			[ ] locator "@windowid='232'"
		[+] StaticText N0002Text
			[ ] locator "@windowid='234'"
		[+] Control N000
			[ ] locator "@windowid='243'"
		[+] StaticText TotalText
			[ ] locator "@windowid='259'"
		[+] StaticText N0003Text
			[ ] locator "@windowid='204'"
		[+] StaticText CustomerMessageText
			[ ] locator "@windowid='229'"
		[+] TextField CustomerMessage
			[ ] locator "@windowid='230'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField Memo
			[ ] locator "@windowid='245'"
		[+] StaticText TaxAccountText
			[ ] locator "@windowid='246'"
		[+] ComboBox TaxAccount
			[ ] locator "@windowid='247'"
		[+] StaticText BalanceDueText
			[ ] locator "@windowid='284'"
		[+] StaticText N0004Text
			[ ] locator "@windowid='263'"
		[+] PushButton ReceivePayment
			[ ] locator "@windowid='250'"
		[+] PushButton PaymentHistory
			[ ] locator "@windowid='251'"
		[+] PushButton Expenses
			[ ] locator "@windowid='252'"
		[+] PushButton EMailSendToClipboard
			[ ] locator "@windowid='293'"
		[+] PushButton Memo1
			[ ] locator "@windowid='32765'"
		[+] PushButton Memo2
			[ ] locator "@windowid='32760'"
		[+] PushButton SaveAndNew
			[ ] locator "@windowid='296'"
		[+] PushButton SaveAndDone
			[ ] locator "@windowid='295'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control InvoiceCustomerInvoicesAc2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control InvoiceCustomerInvoicesAc3
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control xDATE2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control DUEDATE3
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control SHIPTO
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] window MainWin DlgProjectJobList
		[ ] locator "Project*List"
		[+] StaticText ProjectJobListText
			[ ] locator "@windowid='32702'"
		[+] StaticText CustomerText
			[ ] locator "@windowid='3301'"
		[+] ComboBox Customer3
			[ ] locator "@windowid='3310'"
		[+] StaticText SelectAccountText
			[ ] locator "@windowid='3302'"
		[+] ComboBox SelectAccount
			[ ] locator "@windowid='3311'"
		[+] Control Customer4
			[ ] locator "@windowid='3300'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton New
			[ ] locator "@windowid='3337'"
		[+] PushButton Edit
			[ ] locator "@windowid='3338'"
		[+] PushButton Delete
			[ ] locator "@windowid='3339'"
		[+] PushButton Options
			[ ] locator "@windowid='3341'"
		[+] PushButton Customer1
			[ ] locator "@windowid='32765'"
		[+] PushButton Customer2
			[ ] locator "@windowid='32760'"
		[+] PushButton Done
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] window MainWin DlgEstimateList		
	[ ] 
	[ ] 
	[ ] 
	[ ] //------Business >  Invoices And Estimates > Receive a Customer Payment------------
	[+] window MainWin DlgPaymentCustomerInvoicesAccount
		[ ] locator "Payment*"
		[+] StaticText PaymentCustomerInvoicesAc1
			[ ] locator "@windowid='32702'"
		[+] StaticText CustomerText
			[ ] locator "@windowid='65535'"
		[+] TextField Customer
			[+] locator "@windowid='10202'"
				[ ] 
		[+] StaticText AmountText
			[ ] locator "@windowid='265'"
		[+] TextField Amount
			[ ] locator "@windowid='266'"
		[+] StaticText DepositToText
			[ ] locator "@windowid='269'"
		[+] ComboBox PaymentCustomerInvoicesAc2
			[ ] locator "@windowid='270'"
		[+] StaticText CheckNumberText
			[ ] locator "@windowid='267'"
		[+] TextField CheckNumber
			[ ] locator "@windowid='268'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField Memo
			[ ] locator "@windowid='245'"
		[+] StaticText DATEText
			[ ] locator "@windowid='221'"
		[+] TextField xDATE1
			[ ] locator "@windowid='222'"
		[+] StaticText BALANCEText
			[ ] locator "@windowid='248'"
		[+] TextField BALANCE
			[ ] locator "@windowid='249'"
		[+] StaticText ExistingCreditsText
			[ ] locator "@windowid='272'"
		[+] StaticText N0001Text
			[ ] locator "@windowid='273'"
		[+] CheckBox ApplyExistingCredits
			[ ] locator "@windowid='274'"
		[+] StaticText TotalToApplyText
			[ ] locator "@windowid='275'"
		[+] StaticText N0002Text
			[ ] locator "@windowid='276'"
		[+] StaticText UnappliedAmountText
			[ ] locator "@windowid='277'"
		[+] StaticText N0003Text
			[ ] locator "@windowid='278'"
		[+] StaticText OutstandingInvoicesText
			[ ] locator "@windowid='271'"
		[+] MainWin OutstandingInvoices1
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] StaticText TotalsText
			[ ] locator "@windowid='259'"
		[+] StaticText N0004Text
			[ ] locator "@windowid='263'"
		[+] StaticText N0005Text
			[ ] locator "@windowid='264'"
		[+] PushButton ClearPayments
			[ ] locator "@windowid='262'"
		[+] PushButton OutstandingInvoices2
			[ ] locator "@windowid='32765'"
		[+] PushButton Enter
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control xDATE2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control PaymentCustomerInvoicesAc3
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control PaymentCustomerInvoicesAc4
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
	[ ] 
	[ ] //------Business > Invoices And Estimates > Issue a Credit------------
	[+] window MainWin DlgCreditCustomerInvoicesAccount
		[ ] locator "Credit*"
		[+] StaticText CreditCustomerInvoicesAcc1
			[ ] locator "@windowid='32702'"
		[+] StaticText CustomerText
			[ ] locator "@windowid='65535'"
		[+] TextField Customer
			[ ] locator "@windowid='10202'"
		[+] StaticText ProjectJobText
			[ ] locator "@windowid='301'"
		[+] TextField ProjectJob
			[ ] locator "@windowid='300'"
		[+] StaticText LayoutText
			[ ] locator "@windowid='260'"
		[+] PopupList Layout
			[ ] locator "@windowid='261'"
		[+] StaticText BusinessTagText
			[ ] locator "@windowid='1000'"
		[+] TextField BusinessTag
			[ ] locator "@windowid='1001'"
		[+] StaticText CreditText
			[ ] locator "@windowid='202'"
		[+] StaticText CUSTOMERText
			[ ] locator "@windowid='209'"
		[+] TextField CUSTOMER1
			[ ] locator "@windowid='210'"
		[+] TextField CUSTOMER2
			[ ] locator "@windowid='211'"
		[+] TextField CUSTOMER3
			[ ] locator "@windowid='212'"
		[+] TextField CUSTOMER4
			[ ] locator "@windowid='213'"
		[+] TextField CUSTOMER5
			[ ] locator "@windowid='214'"
		[+] StaticText DATEText
			[ ] locator "@windowid='221'"
		[+] TextField xDATE1
			[ ] locator "@windowid='222'"
		[+] StaticText CREDITNOText
			[ ] locator "@windowid='225'"
		[+] TextField CREDITNO
			[ ] locator "@windowid='226'"
		[+] StaticText PONUMBERText
			[ ] locator "@windowid='227'"
		[+] TextField PONUMBER1
			[ ] locator "@windowid='228'"
		[+] MainWin PONUMBER2
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton AddLines
			[ ] locator "@windowid='233'"
		[+] StaticText SubtotalText
			[ ] locator "@windowid='241'"
		[+] StaticText N0001Text
			[ ] locator "@windowid='242'"
		[+] StaticText TaxText
			[ ] locator "@windowid='231'"
		[+] TextField Tax
			[ ] locator "@windowid='232'"
		[+] StaticText N0002Text
			[ ] locator "@windowid='234'"
		[+] Control N000
			[ ] locator "@windowid='243'"
		[+] StaticText TotalText
			[ ] locator "@windowid='259'"
		[+] StaticText N0003Text
			[ ] locator "@windowid='204'"
		[+] StaticText CustomerMessageText
			[ ] locator "@windowid='229'"
		[+] TextField CustomerMessage
			[ ] locator "@windowid='230'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField Memo
			[ ] locator "@windowid='245'"
		[+] StaticText TaxAccountText
			[ ] locator "@windowid='246'"
		[+] ComboBox TaxAccount
			[ ] locator "@windowid='247'"
		[+] StaticText RemainingCreditText
			[ ] locator "@windowid='284'"
		[+] StaticText N0004Text
			[ ] locator "@windowid='263'"
		[+] PushButton ReceivePayment
			[ ] locator "@windowid='250'"
		[+] PushButton PaymentHistory
			[ ] locator "@windowid='251'"
		[+] PushButton Refund
			[ ] locator "@windowid='283'"
		[+] PushButton EMailSendToClipboard
			[ ] locator "@windowid='293'"
		[+] PushButton Memo1
			[ ] locator "@windowid='32765'"
		[+] PushButton Memo2
			[ ] locator "@windowid='32760'"
		[+] PushButton Enter
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control CreditCustomerInvoicesAcc2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control CreditCustomerInvoicesAcc3
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control xDATE2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control CreditCustomerInvoicesAcc4
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
	[ ] 
	[ ] //------Business > Invoices And Estimates > Issue a Refund------------
	[+] window MainWin DlgRefundCustomerInvoicesAccount
		[ ] locator "Refund*"
		[+] StaticText RefundCustomerInvoicesAcc
			[ ] locator "@windowid='32702'"
		[+] StaticText N1Text
			[ ] locator "@windowid='32740'"
		[+] StaticText RequiredFieldsText
			[ ] locator "@windowid='32741'"
		[+] StaticText AccountToPayFrom1Text
			[ ] locator "@windowid='269'"
		[+] StaticText N2Text
			[ ] locator "@windowid='310'"
		[+] ComboBox AccountToPayFrom
			[ ] locator "@windowid='10201'"
		[+] StaticText BusinessTagText
			[ ] locator "@windowid='1000'"
		[+] TextField BusinessTag1
			[ ] locator "@windowid='1001'"
		[+] StaticText AccountToPayFrom2Text
			[ ] locator "@windowid='65535'"
		[+] StaticText CustomerText
			[ ] locator "@windowid='311'"
		[+] StaticText N3Text
			[ ] locator "@windowid='312'"
		[+] TextField Customer
			[ ] locator "@windowid='10202'"
		[+] PushButton Address
			[ ] locator "@windowid='10208'"
		[+] StaticText DateText
			[ ] locator "@windowid='221'"
		[+] TextField xDate
			[ ] locator "@windowid='10200'"
		[+] StaticText ProjectJobText
			[ ] locator "@windowid='301'"
		[+] TextField ProjectJob
			[ ] locator "@windowid='300'"
		[+] StaticText AmountText
			[ ] locator "@windowid='265'"
		[+] StaticText N4Text
			[ ] locator "@windowid='313'"
		[+] TextField Amount
			[ ] locator "@windowid='10205'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField Memo
			[ ] locator "@windowid='10203'"
		[+] StaticText NumberText
			[ ] locator "@windowid='267'"
		[+] TextField xNumber
			[ ] locator "@windowid='10206'"
		[+] PushButton QC_button2
			[ ] locator "@windowid='32765'"
		[+] PushButton Enter
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] Control BusinessTag2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control QFBag2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control QFBag3
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control QFBag4
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control QFBag5
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
	[ ] 
	[ ] //------Business > Invoices And Estimates > Create Estimate------------
	[+] window MainWin EstimateList
		[ ] locator "Estimate List"
		[+] StaticText EstimateListText
			[ ] locator "@windowid='32702'"
		[+] MainWin EstimateList
			[ ] locator "@windowid='3003'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton NewButton
			[ ] locator "@windowid='3020'"
		[+] PushButton EditButton
			[ ] locator "@windowid='3021'"
		[+] PushButton ConvertButton
			[ ] locator "@windowid='3022'"
		[+] PushButton DeleteButton
			[ ] locator "@windowid='3007'"
		[+] PushButton EstimateList1
			[ ] locator "@windowid='32765'"
		[+] PushButton EstimateList2
			[ ] locator "@windowid='32760'"
		[+] PushButton SaveAndNewButton
			[ ] locator "@windowid='296'"
		[+] PushButton SaveAndDoneButton
			[ ] locator "@windowid='295'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] MainWin DlgEstimate
			[ ] locator "Estimate"
			[+] StaticText Estimate1Text
				[ ] locator "@windowid='32702'"
			[+] StaticText CustomerText
				[ ] locator "@windowid='65535'"
			[+] TextField CustomerTextField
				[ ] locator "@windowid='10202'"
			[+] StaticText ProjectJobText
				[ ] locator "@windowid='301'"
			[+] TextField ProjectJobTextField
				[ ] locator "@windowid='300'"
			[+] StaticText LayoutText
				[ ] locator "@windowid='260'"
			[+] ComboBox LayoutPopupList
				[ ] locator "@windowid='261'"
			[+] StaticText BusinessTagText
				[ ] locator "@windowid='1000'"
			[+] TextField BusinessTagTextField
				[ ] locator "@windowid='1001'"
			[+] StaticText Estimate2Text
				[ ] locator "@windowid='202'"
			[+] StaticText BILLTOText
				[ ] locator "@windowid='209'"
			[+] TextField BILLTO1TextField
				[ ] locator "@windowid='210'"
			[+] TextField BILLTO2
				[ ] locator "@windowid='211'"
			[+] TextField BILLTO3
				[ ] locator "@windowid='212'"
			[+] TextField BILLTO4
				[ ] locator "@windowid='213'"
			[+] TextField BILLTO5
				[ ] locator "@windowid='214'"
			[+] StaticText DATEText
				[ ] locator "@windowid='221'"
			[+] TextField xDATE1TextField              
				[ ] locator "@windowid='222'"                                  
			[+] StaticText ESTIMATEText
				[ ] locator "@windowid='225'"
			[+] TextField ESTIMATETextField
				[ ] locator "@windowid='226'"
			[+] MainWin QWListViewerItem
				[ ] locator "@windowid='200'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
			[+] PushButton AddLinesButton
				[ ] locator "@windowid='233'"
			[+] StaticText SubtotalText
				[ ] locator "@windowid='241'"
			[+] StaticText N0001Text
				[ ] locator "@windowid='242'"
			[+] StaticText TaxText
				[ ] locator "@windowid='231'"
			[+] TextField TaxTextField
				[ ] locator "@windowid='232'"
			[+] StaticText N0002Text
				[ ] locator "@windowid='234'"
			[+] Control N000
				[ ] locator "@windowid='243'"
			[+] StaticText TotalText
				[ ] locator "@windowid='259'"
			[+] StaticText N0003Text
				[ ] locator "@windowid='204'"
			[+] StaticText CustomerMessageText
				[ ] locator "@windowid='229'"
			[+] TextField CustomerMessageTextField
				[ ] locator "@windowid='230'"
			[+] StaticText MemoText
				[ ] locator "@windowid='244'"
			[+] TextField MemoTextField
				[ ] locator "@windowid='245'"
			[+] StaticText TaxAccountText
				[ ] locator "@windowid='246'"
			[+] ComboBox TaxAccountPopupList
				[ ] locator "@windowid='247'"
			[+] PushButton EMailSendToClipboardButton
				[ ] locator "@windowid='293'"
			[+] PushButton HelpButton
				[+] locator "@windowid='32765'"
					[ ] 
			[+] PushButton Memo2
				[ ] locator "@windowid='32760'"
			[+] PushButton SaveAndNewButton
				[ ] locator "@windowid='296'"
			[+] PushButton SaveAndDoneButton
				[ ] locator "@windowid='295'"
			[+] PushButton CancelButton
				[ ] locator "@windowid='32766'"
			[+] Control Estimate1
				[ ] locator "@windowid='2020'"
				[+] PushButton QC_button2
					[ ] locator "@windowid='1124'"
				[+] PushButton QC_button1
					[ ] locator "@windowid='1128'"
			[+] Control Estimate2
				[ ] locator "@windowid='2020'"
				[+] PushButton QC_button2
					[ ] locator "@windowid='1124'"
				[+] PushButton QC_button1
					[ ] locator "@windowid='1128'"
			[+] Control xDATE2
				[ ] locator "@windowid='2020'"
				[+] PushButton QC_button2
					[ ] locator "@windowid='1124'"
				[+] PushButton QC_button1
					[ ] locator "@windowid='1128'"
			[+] Control Estimate3
				[ ] locator "@windowid='2020'"
				[+] PushButton QC_button2
					[ ] locator "@windowid='1124'"
				[+] PushButton QC_button1
					[ ] locator "@windowid='1128'"
	[ ] 
	[ ] //------Business > Invoices And Estimates > View All Invoice Items------------
	[+] window DialogBox DlgCustomizeInvoiceItems
		[ ] locator "Customize Invoice Items"
		[+] StaticText CustomizeInvoiceItemsText
			[ ] locator "@windowid='32702'"
		[+] MainWin CustomizeInvoiceItems1
			[ ] locator "@windowid='201'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton NewButton
			[ ] locator "@windowid='202'"
		[+] PushButton EditButton
			[ ] locator "@windowid='203'"
		[+] PushButton DeleteButton
			[ ] locator "@windowid='204'"
		[+] PushButton CustomizeInvoiceItems2
			[ ] locator "@windowid='32765'"
		[+] PushButton DoneButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] //------Business > Invoices And Estimates > View saved customer messages------------
	[+] window DialogBox DlgEditCustomerMessages
		[ ] locator "Edit Customer Messages"
		[+] StaticText EditCustomerMessagesText
			[ ] locator "@windowid='32702'"
		[+] StaticText CustomerMessagesText
			[ ] locator "@windowid='3200'"
		[+] MainWin CustomerMessages
			[ ] locator "@windowid='3201'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton Delete
			[ ] locator "@windowid='3204'"
		[+] StaticText MessageToAddReplaceText
			[ ] locator "@windowid='65535'"
		[+] TextField MessageToAddReplace1TextField
			[ ] locator "@windowid='3205'"
		[+] PushButton AddButton
			[ ] locator "@windowid='3202'"
		[+] PushButton ReplaceButton
			[ ] locator "@windowid='3203'"
		[+] PushButton MessageToAddReplace2
			[ ] locator "@windowid='32765'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] //------Business > Invoices And Estimates >Design Invoice Forms------------
	[+] window MainWin DlgFormsDesigner
		[ ] locator "Forms Designer*"
		[+] Control QW_MDI_TOOLBAR1
			[ ] locator "@windowid='12000'"
		[+] Control QWBrowserContainer1
			[ ] locator "@windowid='-1'"
			[+] StaticText StaticText1
				[ ] locator "@windowid='-1'"
	[ ] 
	[ ] //------Verify Business -> Bills & Vendors > Add a Vendor------------
	[ ] 
	[+] window MainWin AddressBookRecord
		[ ] locator "Address Book*"
		[+] MainWin QWListViewer1
			[ ] locator "@windowid='3010'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[ ] 
				[ ] 
				[ ] 
			[ ] 
		[+] PushButton Export
			[ ] locator "Export"
		[+] PushButton Done
			[ ] locator "Done"
		[+] StaticText RecordsAddress
			[ ] locator "@windowid='3011'"
		[+] MainWin DlgEditAddressBookRecord
			[ ] locator "*Address Book*"
			[+] TextField Payee
				[ ] locator "@windowid='4101'"
			[+] TextField Street
				[ ] locator "@windowid='4111'"
			[+] TextField City
				[ ] locator "@windowid='4112'"
			[+] TextField State
				[ ] locator "@windowid='4113'"
			[+] TextField ZipCode
				[ ] locator "@windowid='4114'"
			[+] TextField Country
				[ ] locator "@windowid='4115'"
			[+] TextField AttnLine
				[ ] locator "@windowid='4108'"
			[+] TextField EMail
				[ ] locator "@windowid='4118'"
			[+] StaticText IncludeThisPayeeInText
				[ ] locator "@windowid='65535'"
			[+] CheckBox QuickFillList
				[ ] locator "@windowid='4212'"
			[+] CheckBox CustomerList
				[ ] locator "@windowid='4151'"
			[+] CheckBox VendorList
				[ ] locator "@windowid='4152'"
			[+] PushButton Groups
				[ ] locator "@windowid='32765'"
			[+] PushButton Group
				[ ] locator "@windowid='4201'"
			[+] PushButton Format
				[ ] locator "@windowid='4202'"
			[+] PushButton OKButton
				[ ] locator "@windowid='32767'"
			[+] PushButton CancelButton
				[ ] locator "@windowid='32766'"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] // window DialogBox DlgEditAddressBookRecord
		[+] // TextField Payee
			[ ] // locator "@windowid='4101'"
		[+] // TextField Street
			[ ] // locator "@windowid='4111'"
		[+] // TextField City
			[ ] // locator "@windowid='4112'"
		[+] // TextField State
			[ ] // locator "@windowid='4113'"
		[+] // TextField ZipCode
			[ ] // locator "@windowid='4114'"
		[+] // TextField Country
			[ ] // locator "@windowid='4115'"
		[+] // TextField AttnLine
			[ ] // locator "@windowid='4108'"
		[+] // TextField EMail
			[ ] // locator "@windowid='4118'"
		[+] // StaticText IncludeThisPayeeInText
			[ ] // locator "@windowid='65535'"
		[+] // CheckBox QuickFillList
			[ ] // locator "@windowid='4212'"
		[+] // CheckBox CustomerList
			[ ] // locator "@windowid='4151'"
		[+] // CheckBox VendorList
			[ ] // locator "@windowid='4152'"
		[+] // PushButton Groups
			[ ] // locator "@windowid='32765'"
		[+] // PushButton Group
			[ ] // locator "@windowid='4201'"
		[+] // PushButton Format
			[ ] // locator "@windowid='4202'"
		[+] // PushButton OKButton
			[ ] // locator "@windowid='32767'"
		[+] // PushButton CancelButton
			[ ] // locator "@windowid='32766'"
	[ ] 
	[+] window MainWin DlgAddressBook
		[ ] locator "Address Book*"
		[+] MainWin QWListViewer1
			[ ] locator "@windowid='3010'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[ ] 
				[ ] 
				[ ] 
			[ ] 
		[+] PushButton Export
			[ ] locator "Export"
		[+] PushButton Done
			[ ] locator "Done"
		[+] StaticText RecordsAddress
			[ ] locator "@windowid='3011'"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //------Verify Business -> Bills & Vendors > Create Bill------------
	[+] window MainWin DlgBillVendorInvoices
		[ ] locator "Bill*"
		[ ] // locator "[@windowClassName='QWinDlg']"
		[+] StaticText BillVendorInvoicesText
			[ ] locator "@windowid='32702'"
		[+] StaticText VendorText
			[ ] locator "@windowid='65535'"
		[+] TextField VendorTextField
			[ ] locator "@windowid='10202'"
		[+] StaticText BusinessTagText
			[ ] locator "@windowid='1000'"
		[+] TextField BusinessTagTextField
			[ ] locator "@windowid='1001'"
		[+] StaticText Customer1Text
			[ ] locator "@windowid='65535'"
		[+] TextField CustomerTextField
			[ ] locator "@windowid='206'"
		[+] StaticText Customer2Text
			[ ] locator "@windowid='304'"
		[+] StaticText ProjectJob1Text
			[ ] locator "@windowid='65535'"
		[+] TextField ProjectJobTextField
			[ ] locator "@windowid='300'"
		[+] StaticText ProjectJob2Text
			[ ] locator "@windowid='303'"
		[+] PushButton AssignProjectJob
			[ ] locator "@windowid='302'"
		[+] StaticText VendorInvoiceText
			[ ] locator "@windowid='202'"
		[+] StaticText VENDORADDRESSText
			[ ] locator "@windowid='209'"
		[+] TextField VENDORADDRESS1
			[ ] locator "@windowid='210'"
		[+] TextField VENDORADDRESS2
			[ ] locator "@windowid='211'"
		[+] TextField VENDORADDRESS3
			[ ] locator "@windowid='212'"
		[+] TextField VENDORADDRESS4
			[ ] locator "@windowid='213'"
		[+] TextField VENDORADDRESS5
			[ ] locator "@windowid='214'"
		[+] StaticText DATEText
			[ ] locator "@windowid='221'"
		[+] TextField xDATE1TextField
			[ ] locator "@windowid='222'"
		[+] StaticText BILLNOText
			[ ] locator "@windowid='225'"
		[+] TextField BILLNOTextField
			[ ] locator "@windowid='226'"
		[+] StaticText DUEDATEText
			[ ] locator "@windowid='223'"
		[+] TextField DUEDATE1TextField
			[ ] locator "@windowid='224'"
		[+] StaticText PONUMBERText
			[ ] locator "@windowid='227'"
		[+] TextField PONUMBERTextField
			[ ] locator "@windowid='228'"
		[+] MainWin QWListViewerItem
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton AddLinesButton
			[ ] locator "@windowid='233'"
		[+] StaticText TotalText
			[ ] locator "@windowid='259'"
		[+] StaticText N0001Text
			[ ] locator "@windowid='204'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField MemoTextField
			[ ] locator "@windowid='245'"
		[+] StaticText BalanceDueText
			[ ] locator "@windowid='284'"
		[+] StaticText N0002Text
			[ ] locator "@windowid='263'"
		[+] PushButton CreatePaymentButton
			[ ] locator "@windowid='250'"
		[+] PushButton PaymentHistoryButton
			[ ] locator "@windowid='251'"
		[+] PushButton Memo1
			[ ] locator "@windowid='32765'"
			[ ] 
		[+] PushButton Memo2
			[ ] locator "@windowid='32760'"
		[+] PushButton SaveAndNewButton
			[ ] locator "@windowid='296'"
		[+] PushButton SaveAndDoneButton
			[ ] locator "@windowid='295'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] Control BillVendorInvoices1
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control BillVendorInvoices2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control xDATE2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control DUEDATE3
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] PushButton EMailSendToClipboardButton
			[ ] locator "@windowid='293'"
	[ ] 
	[ ] //------Verify Business -> Bills & Vendors > Make Payment to Vendor------------
	[+] window MainWin DlgPaymentVendorInvoices
		[ ] locator "Payment*"
		[+] StaticText PaymentToVendorText
			[ ] locator "@windowid='202'"
		[+] StaticText DATEText
			[ ] locator "@windowid='221'"
		[+] TextField xDATE1TextField
			[ ] locator "@windowid='10200'"
		[+] StaticText BALANCEText
			[ ] locator "@windowid='248'"
		[+] TextField BALANCETextField
			[ ] locator "@windowid='249'"
		[+] StaticText VendorText
			[ ] locator "@windowid='65535'"
		[+] TextField VendorTextField
			[ ] locator "@windowid='10202'"
		[+] StaticText AmountText
			[ ] locator "@windowid='265'"
		[+] TextField AmountTextField
			[ ] locator "@windowid='266'"
		[+] StaticText WithdrawFromText
			[ ] locator "@windowid='269'"
		[+] ComboBox WithdrawFromPopupList
			[ ] locator "@windowid='10201'"
		[+] StaticText CheckNumberText
			[ ] locator "@windowid='267'"
		[+] TextField CheckNumberTextField
			[ ] locator "@windowid='10206'"
		[+] StaticText Memo1Text
			[ ] locator "@windowid='244'"
		[+] TextField MemoTextField
			[ ] locator "@windowid='245'"
		[+] StaticText Memo2Text
			[ ] locator "@windowid='289'"
		[+] StaticText ExistingCreditsText
			[ ] locator "@windowid='272'"
		[+] StaticText N0001Text
			[ ] locator "@windowid='273'"
		[+] CheckBox ApplyExistingCredits
			[ ] locator "@windowid='274'"
		[+] StaticText TotalToApplyText
			[ ] locator "@windowid='275'"
		[+] StaticText N0002Text
			[ ] locator "@windowid='276'"
		[+] StaticText UnappliedAmountText
			[ ] locator "@windowid='277'"
		[+] StaticText N0003Text
			[ ] locator "@windowid='278'"
		[+] StaticText OutstandingBillsText
			[ ] locator "@windowid='271'"
		[+] MainWin OutstandingBills1
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] StaticText TotalsText
			[ ] locator "@windowid='259'"
		[+] StaticText N0004Text
			[ ] locator "@windowid='263'"
		[+] StaticText N0005Text
			[ ] locator "@windowid='264'"
		[+] PushButton ClearPaymentsButton
			[ ] locator "@windowid='262'"
		[+] PushButton EnterButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton OutstandingBills2
			[ ] locator "@windowid='32765'"
		[+] Control xDATE2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control PaymentToVendor
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control BALANCE1
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control BALANCE2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
	[ ] 
	[ ] //------Verify Business -> Bills & Vendors > Receive a Credit------------
	[+] window MainWin DlgCreditVendorInvoices
		[ ] locator "Credit*"
		[+] StaticText VendorText
			[ ] locator "@windowid='65535'"
		[+] TextField Vendor1TextField
			[ ] locator "@windowid='10202'"
		[+] StaticText Customer1Text
			[ ] locator "@windowid='65535'"
		[+] TextField CustomerTextField
			[ ] locator "@windowid='206'"
		[+] StaticText Customer2Text
			[ ] locator "@windowid='304'"
		[+] StaticText ProjectJobText
			[ ] locator "@windowid='65535'"
		[+] TextField TextField3
			[ ] locator "@windowid='300'"
		[+] StaticText StaticText5
			[ ] locator "@windowid='303'"
		[+] PushButton AssignProjectJob
			[ ] locator "@windowid='302'"
		[+] StaticText CreditText
			[ ] locator "@windowid='202'"
		[+] StaticText VENDORADDRESSText
			[ ] locator "@windowid='209'"
		[+] TextField VENDORADDRESS1
			[ ] locator "@windowid='210'"
		[+] TextField VENDORADDRESS2
			[ ] locator "@windowid='211'"
		[+] TextField VENDORADDRESS3
			[ ] locator "@windowid='212'"
		[+] TextField VENDORADDRESS4
			[ ] locator "@windowid='213'"
		[+] TextField VENDORADDRESS5
			[ ] locator "@windowid='214'"
		[+] StaticText DATEText
			[ ] locator "@windowid='221'"
		[+] TextField xDATE1TextField
			[ ] locator "@windowid='222'"
		[+] StaticText CREDITNOText
			[ ] locator "@windowid='225'"
		[+] TextField CREDITNOTextField
			[ ] locator "@windowid='226'"
		[+] StaticText DUEDATEText
			[ ] locator "@windowid='223'"
		[+] TextField DUEDATE1TextField
			[ ] locator "@windowid='224'"
		[+] StaticText PONUMBERText
			[ ] locator "@windowid='227'"
		[+] TextField PONUMBERTextField
			[ ] locator "@windowid='228'"
		[+] MainWin QWListViewerItem
			[ ] locator "@windowid='200'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton AddLinesButton
			[ ] locator "@windowid='233'"
		[+] StaticText TotalText
			[ ] locator "@windowid='259'"
		[+] StaticText N0001Text
			[ ] locator "@windowid='204'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField Memo1TextField
			[ ] locator "@windowid='245'"
		[+] StaticText RemainingCreditText
			[ ] locator "@windowid='284'"
		[+] StaticText N0002Text
			[ ] locator "@windowid='263'"
		[+] PushButton CreatePaymentButton
			[ ] locator "@windowid='250'"
		[+] PushButton PaymentHistoryButton
			[ ] locator "@windowid='251'"
		[+] PushButton RefundButton
			[ ] locator "@windowid='283'"
		[+] PushButton EnterButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] PushButton Memo2
			[ ] locator "@windowid='32765'"
		[+] Control Vendor2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control xDATE2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control DUEDATE3
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
	[ ] 
	[ ] //------Verify Business -> Bills & Vendors > Receive a Refund------------
	[+] window MainWin DlgRefundVendorInvoices
		[ ] locator "Refund*"
		[+] StaticText N1Text
			[ ] locator "@windowid='32740'"
		[+] StaticText RequiredFieldsText
			[ ] locator "@windowid='32741'"
		[+] StaticText RefundVendorInvoicesText
			[ ] locator "@windowid='32702'"
		[+] StaticText AccountToDepositToText
			[ ] locator "@windowid='269'"
		[+] StaticText N2Text
			[ ] locator "@windowid='310'"
		[+] ComboBox AccountToDepositTo
			[ ] locator "@windowid='10201'"
		[+] StaticText VendorText
			[ ] locator "@windowid='311'"
		[+] StaticText N3Text
			[ ] locator "@windowid='312'"
		[+] TextField VendorTextField
			[ ] locator "@windowid='10202'"
		[+] PushButton Address
			[ ] locator "@windowid='10208'"
		[+] StaticText DateText
			[ ] locator "@windowid='221'"
		[+] TextField xDateTextField
			[ ] locator "@windowid='222'"
		[+] StaticText Customer1Text
			[ ] locator "@windowid='65535'"
		[+] TextField CustomerTextField
			[ ] locator "@windowid='206'"
		[+] StaticText Customer2Text
			[ ] locator "@windowid='304'"
		[+] StaticText ProjectJob1Text
			[ ] locator "@windowid='65535'"
		[+] TextField ProjectJobTextField
			[ ] locator "@windowid='300'"
		[+] StaticText ProjectJob2Text
			[ ] locator "@windowid='303'"
		[+] PushButton AssignProjectJob
			[ ] locator "@windowid='302'"
		[+] StaticText AmountText
			[ ] locator "@windowid='265'"
		[+] TextField AmountTextField
			[ ] locator "@windowid='10205'"
		[+] StaticText MemoText
			[ ] locator "@windowid='244'"
		[+] TextField Memo1TextField
			[ ] locator "@windowid='10203'"
		[+] StaticText NumberText
			[ ] locator "@windowid='267'"
		[+] TextField xNumberTextField
			[ ] locator "@windowid='268'"
		[+] PushButton Memo2
			[ ] locator "@windowid='32765'"
		[+] PushButton EnterButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] Control RefundVendorInvoices
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control RequiredFields1
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
		[+] Control RequiredFields2
			[ ] locator "@windowid='2020'"
			[+] PushButton QC_button2
				[ ] locator "@windowid='1124'"
			[+] PushButton QC_button1
				[ ] locator "@windowid='1128'"
	[ ] 
	[ ] 
	[+] window MainWin DlgMicrosoftOutlook
		[ ] locator "Microsoft Outlook"
		[+] PushButton DenyButton
			[ ] locator "@windowid='4775'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='4776'"
		[+] Control Icon1Button
			[ ] locator "@windowid='4512'"
		[+] StaticText AProgramIsTryingToAccess1
			[ ] locator "@windowid='4772'"
		[+] CheckBox AllowAccessFor
			[ ] locator "@windowid='4771'"
		[+] ComboBox AProgramIsTryingToAccess2
			[ ] locator "@windowid='4773'"
		[+] PushButton AllowButton
			[ ] locator "@windowid='4774'"
	[ ] 
	[+] window DialogBox DlgInvoiceMessage
		[+] Control MsoDockTop
			[ ] locator "@windowid='0'"
			[+] Control Ribbon
				[ ] locator "@windowid='0'"
				[+] Control Ribbon
					[ ] locator "@windowid='0'"
					[+] Control NUIPane1
						[ ] locator "@windowid='0'"
						[+] Control NetUIHWND1
							[ ] locator "@windowid='0'"
		[+] Control AfxWndW1
			[ ] locator "@windowid='103'"
			[+] Control AfxWndW1
				[ ] locator "@windowid='258'"
				[+] DialogBox DialogBox1
					[+] StaticText ToText
						[ ] locator "@windowid='4527'"
					[+] Control RichEdit20WPT1
						[ ] locator "@windowid='4099'"
					[+] StaticText CcText
						[ ] locator "@windowid='4528'"
					[+] Control RichEdit20WPT2
						[ ] locator "@windowid='4100'"
					[+] StaticText BccText
						[ ] locator "@windowid='4529'"
					[+] StaticText SubjectText
						[ ] locator "@windowid='4516'"
					[+] Control ThisIsYourInvoice
						[ ] locator "@windowid='4101'"
					[+] StaticText AttachedText
						[ ] locator "@windowid='4536'"
					[+] Control RichEdit20WPT4
						[ ] locator "@windowid='4104'"
					[+] StaticText MessageText
						[ ] locator "@windowid='4550'"
					[+] Control Attached
						[ ] locator "@windowid='4159'"
						[+] StaticText MessageText
							[ ] locator "@windowid='0'"
						[+] Control Document1
							[ ] locator "@windowid='0'"
							[+] Control MSOGenericControlContainer
								[ ] locator "@windowid='0'"
							[+] Control Message
								[ ] locator "@windowid='0'"
							[+] Control Vertical
								[ ] locator "@windowid='0'"
								[+] Control NetUIHWND1
									[ ] locator "@windowid='0'"
							[+] Control _WwC1
								[ ] locator "@windowid='0'"
					[+] PushButton Rctrl_renwnd321
						[ ] locator "@windowid='4265'"
					[+] PushButton Send
						[ ] locator "@windowid='4256'"
					[+] PushButton To
						[ ] locator "@windowid='4352'"
					[+] PushButton Cc
						[ ] locator "@windowid='4353'"
	[ ] 
	[+] window DialogBox DlgSendInvoiceByEMail
		[+] StaticText SendInvoiceByEMailText
			[ ] locator "@windowid='32702'"
		[+] StaticText FormatText
			[ ] locator "@windowid='65535'"
		[+] RadioList FormatRadioList
			[ ] locator "@windowid='3042'"
		[+] StaticText OutputText
			[ ] locator "@windowid='65535'"
		[+] RadioList OutputRadioList
			[ ] locator "@windowid='3032'"
		[+] StaticText SendText
			[ ] locator "@windowid='65535'"
		[+] RadioList Send1RadioList
			[ ] locator "@windowid='3051'"
		[+] StaticText AText
			[ ] locator "@windowid='3021'"
		[+] StaticText EMailAddressText
			[ ] locator "@windowid='65535'"
		[+] TextField EMailAddressTextField
			[ ] locator "@windowid='3022'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[+] window DialogBox DlgFormToClipBoard
		[+] Control QWIconDisplay1
			[ ] locator "@windowid='105'"
		[+] StaticText TheFormText
			[ ] locator "@windowid='100'"
		[+] PushButton OKButton
			[ ] locator "@windowid='101'"
			[ ] 
	[ ] 
	[ ] 
	[+] window MainWin DlgSmallBusinessGuidance
		[ ] locator "Small Business Guidance"
		[+] CustomWin QW_MDI_TOOLBAR1
			[ ] locator "@windowid='12000'"
		[+] CustomWin QWBrowserContainer1
			[ ] locator "@windowid='-1'"
			[+] StaticText StaticText1
				[ ] locator "@windowid='1007'"
				[+] TreeView TreeView1
					[ ] locator "@windowid='0'"
	[ ] 
	[+] window MainWin DlgBalanceSheet
		[ ] locator "//MainWin[@caption='Balance Sheet'][1]"
		[+] Control QW_BAG_TOOLBAR
			[ ] locator "@windowClassName='QW_BAG_TOOLBAR'"
		[+] Control QW_MAIN_TOOLBAR
			[ ] locator "@windowClassName='QW_MAIN_TOOLBAR'"
		[+] MainWin xWindow
			[ ] locator "//MainWin"
		[+] ListBox ListBox
			[ ] locator "//ListBox"
		[+] Control QWCustomizeBar
			[ ] locator "@windowClassName='QWCustomizeBar'"
		[+] Control DAteRange
			[ ] locator "Date range:"
		[+] ComboBox ComboBox
			[ ] locator "[1]"
		[+] Control InterVal
			[ ] locator "Inter&val:"
		[+] ComboBox ComboBox2
			[+] locator "[2]"
				[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //************* Rental Property ***************************************************
	[ ] 
	[ ] 
	[+] window MainWin RentalProperty	
		[ ] locator "Rental Property"
		[+] Control ProfitLossDetails
			[ ] locator "@windowid='2245'"
		[+] Control QWSnapHolder
			[ ] locator "@windowid='-1'"
			[+] StaticText RentalSpendingAccount
				[ ] locator "@windowid='1'"
				[+] StaticText RentalPropertyText
					[ ] locator "@windowid='31000'"
					[+] Control Options
						[ ] locator "@windowid='1000'"
				[+] Control AddRentalPropertyAccount
					[ ] locator "@windowid='-1"
					[ ] 
	[ ] 
	[ ] //---DUPLICATE of AddEditRentalProperty--
	[+] window MainWin AddRentalProperty
		[ ] locator "Add Rental Property" //Add Rental Property|
		[+] TextField PropertyName
			[ ] locator "@windowid='17631'"
		[+] TextField PropertyTag
			[ ] locator "@windowid='17636'"
		[+] TextField PropertyStreet
			[ ] locator "@windowid='17643'"
		[+] TextField City
			[ ] locator "@windowid='17645'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] 
			[ ] locator "@windowid='32766'"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin PropertyListTable
		[ ] locator "Property List"
		[+] StaticText PropertyListText
			[ ] locator "@windowid='32702'"
		[+] PushButton New
			[ ] locator "@windowid='17687'"
		[+] PushButton Edit
			[ ] locator "@windowid='17688'"
		[+] PushButton Delete
			[ ] locator "@windowid='17689'"
		[+] PushButton PropertyList1
			[ ] locator "@windowid='32765'"
		[+] PushButton PropertyList2
			[ ] locator "@windowid='32760'"
		[+] PushButton Done
			[ ] locator "@windowid='32766'"
		[+] Control PropertyList
			[ ] //locator "@windowid='0'"
			[+] MainWin QWListViewer1
				[ ] locator "@windowid='17624'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
		[+] CheckBox ShowHiddenProperties
			[ ] locator "@windowid='17626'"
		[ ] 
	[ ] 
	[+] window DialogBox NoRentalPropMessageBox
		[ ] locator "Quicken 201?"
		[+] // CustomWin QWIconDisplay1
			[+] // multitag "[QWIconDisplay]#1"
				[ ] // "[QWIconDisplay]$105"
				[ ] // "[QWIconDisplay]@(32,32)"
		[+] StaticText YouDonTHaveAnyRentalProp
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[+] window MainWin AddEditRentalProperty
		[ ] // locator "[@Caption='Add Rental Property' or @Caption='Edit Rental Property']"
		[ ] locator "*Rental Property"
		[+] TextField AddEditRentalPropertyName
			[ ] locator "@windowid='17631'"
		[+] TextField AddEditRentalPropertyTag
			[ ] locator "@windowid='17636'"
		[+] TextField AddEditRentalPropertyStreet
			[ ] locator "@windowid='17643'"
		[+] TextField AddEditRentalPropertyCity
			[ ] locator "@windowid='17645'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] CheckBox HideProperty
			[ ] locator "@windowid='17697'"
		[+] RadioList HouseAccountName
			[ ] locator "@windowid='17662'"
		[+] ComboBox AccountName
			[ ] locator "@windowid='17681'"
			[ ] 
	[ ] 
	[+] // window ChildWin RentalPropertyRentCenter
		[ ] // tag "Rental Property|Business"
		[ ] // parent QuickenMainWindow
		[+] // PopupList PopupList1
			[+] // multitag "#1"
				[ ] // "$2241"
				[ ] // "@(84,16)"
		[+] // PopupList PopupList2
			[+] // multitag "#2"
				[ ] // "$2010"
				[ ] // "@(222,16)"
		[+] // CustomWin QWSnapHolder1
			[+] // multitag "[QWSnapHolder]#1"
				[ ] // "[QWSnapHolder]$-1"
				[ ] // "[QWSnapHolder]@(526,815)"
		[+] // CustomWin Panel
			[+] // multitag "[QWPanel]Panel"
				[ ] // "[QWPanel]#1"
				[ ] // "[QWPanel]$-1"
				[ ] // "[QWPanel]@(526,424)"
			[+] // CustomWin QWListViewer1
				[+] // multitag "[QWListViewer]#1"
					[ ] // "[QWListViewer]$2143"
					[ ] // "[QWListViewer]@(526,377)"
				[+] // ListBox ListBox1
					[+] // multitag "#1"
						[ ] // "$1"
						[ ] // "@(526,376)"
		[+] // CustomWin ProfitLossDetailsButton
			[+] // multitag "[QC_button]Profit?Loss Details"
				[ ] // "[QC_button]#3"
				[ ] // "[QC_button]$2245"
				[ ] // "[QC_button]@(380,17)"
		[+] // CustomWin InOutProfitLoss
			[+] // multitag "[QWinChild]"
				[ ] // "[QWinChild]#1"
				[ ] // "[QWinChild]$0"
				[ ] // //"[QWinChild]@(526,422)"
			[+] // CustomWin InOutProfitLossPanel
				[+] // multitag "[QWPanel]Panel[1]"
					[ ] // "[QWPanel]#1"
					[ ] // "[QWPanel]$-1[1]"
					[ ] // "[QWPanel]@(514,200)"
				[+] // CustomWin QWListViewer1
					[+] // multitag "[QWListViewer]#1"
						[ ] // "[QWListViewer]$2030"
						[ ] // "[QWListViewer]@(166,173)"
					[+] // ListBox ListBox1
						[+] // multitag "#1"
							[ ] // "$1"
							[ ] // "@(156,108)"
				[+] // CustomWin QWListViewer2
					[+] // multitag "[QWListViewer]#2"
						[ ] // "[QWListViewer]$2070"
						[ ] // "[QWListViewer]@(509,173)"
					[+] // ListBox ListBox1
						[+] // multitag "#1"
							[ ] // "$1"
							[ ] // "@(156,108)"
				[+] // CustomWin QWListViewer3
					[+] // multitag "[QWListViewer]#5"
						[ ] // "[QWListViewer]$2095"
					[+] // ListBox ListBox1
						[+] // multitag "#1"
							[ ] // "$1"
				[+] // CustomWin Profit1
					[+] // multitag "[QWListViewer]Profit[1]"
						[ ] // "[QWListViewer]^Profit[1]"
						[ ] // "[QWListViewer]#3"
						[ ] // "[QWListViewer]$2134"
						[ ] // "[QWListViewer]@(758,162)"
					[+] // ListBox ListBox1
						[+] // multitag "#1"
							[ ] // "$1"
							[ ] // "@(41,6)"
				[+] // CustomWin Profit2
					[+] // multitag "[QWListViewer]Profit[2]"
						[ ] // "[QWListViewer]^Profit[2]"
						[ ] // "[QWListViewer]#4"
						[ ] // "[QWListViewer]$2135"
						[ ] // "[QWListViewer]@(737,175)"
					[+] // ListBox ListBox1
						[+] // multitag "#1"
							[ ] // "$1"
							[ ] // "@(20,6)"
			[+] // CustomWin Panel2
				[+] // multitag "[QWPanel]Panel[2]"
					[ ] // "[QWPanel]#2"
					[ ] // "[QWPanel]$-1[2]"
					[ ] // "[QWPanel]@(514,588)"
				[+] // StaticText StaticText1
					[+] // multitag "#1"
						[ ] // "$-1"
						[ ] // "@(514,205)"
					[+] // StaticText StaticText2
						[+] // multitag "#1"
							[ ] // "$0"
							[ ] // "@(502,152)"
						[+] // CustomWin QWListViewer1
							[+] // multitag "[QWListViewer]#1"
								[ ] // "[QWListViewer]$1"
								[ ] // "[QWListViewer]@(501,163)"
							[+] // ListBox ListBox1
								[+] // multitag "#1"
									[ ] // "$1"
									[ ] // "@(501,150)"
						[ ] // 
					[+] // StaticText StaticText3
						[+] // multitag "#2"
							[ ] // "$-1"
							[ ] // "@(502,316)"
						[+] // CustomWin AddReminderButton
							[+] // multitag "[QC_button]Add Reminder"
								[ ] // "[QC_button]#1"
								[ ] // "[QC_button]$518"
								[ ] // "[QC_button]@(58,15)"
								[ ] // 
						[+] // CustomWin ManageRemindersButton
							[+] // multitag "[QC_button]Manage Reminders"
								[ ] // "[QC_button]#2"
								[ ] // "[QC_button]$507"
								[ ] // "[QC_button]@(185,15)"
						[ ] // 
					[ ] // //CustomWin("[QC_button]Manage Reminders|#2|$507|@(185,15)")
	[+] window Control RentalPropertyRentCenter
		[ ] locator "[@caption='Rental Property' or @caption='Business']"
		[ ] //locator "@Caption='Rental Property' or @Caption='Business'"     //'Business'"
		[ ] 
		[+] ComboBox PopupList1
			[ ] locator "[@windowid='2241' or @windowid='2243']"
		[+] ComboBox PopupList2
			[ ] locator "@windowid='2010'"
		[+] Control QWSnapHolder1
			[ ] locator "@windowid='-1'"
			[+] StaticText AccountOverviewSpendingText
				[ ] // locator "[@windowid='-1'][6]"
				[+] StaticText RentalSpendingText
					[ ] // locator "[@windowid='-1'][7]"
					[+] MainWin QWListViewer
						[ ] locator "[@windowid='120']"
						[+] ListBox ListBox
							[ ] locator "[@windowid='1']"
				[+] StaticText OptionsText
					[ ] locator "@windowid='31000'"
					[+] PushButton OptionsButton
						[ ] locator "@windowid='1000'"
				[ ] 
			[+] StaticText AccountOverviewCreditCardText
				[ ] // locator "[@windowid='-1'][2]"
				[+] MainWin QWListViewer
					[ ] locator "@windowid='120'"
					[+] ListBox ListBox
						[ ] locator "@windowid='1'"
				[+] StaticText OptionsText
					[ ] locator "@windowid='31000'"
					[+] PushButton OptionsButton
						[ ] locator "@windowid='1000'"
				[ ] 
			[+] StaticText AccountOverviewPropertyText
				[ ] // locator "[@windowid='-1'][3]"
				[+] StaticText PropetyAccountText
					[ ] // locator "[@windowid='-1'][2]"
					[+] MainWin QWListViewer
						[ ] locator "@windowid='120'"
						[+] ListBox ListBox
							[ ] locator "@windowid='1'"
					[ ] 
				[+] StaticText OptionsText
					[ ] locator "@windowid='31000'"
					[+] PushButton OptionsButton
						[ ] locator "@windowid='1000'"
				[ ] 
				[ ] 
			[ ] 
		[+] Control Panel
			[ ] locator "//Control[@caption='Panel'][1]"
			[+] MainWin QWListViewer1
				[ ] locator "@windowid='2143'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
		[+] Control ProfitLossDetailsButton
			[ ] locator "@windowid='2245'"
		[+] Control InOutProfitLoss
			[ ] // locator "//Control[@windowClassName='INTU_CalloutHolder']"
			[+] Control InOutProfitLossPanel
				[ ] // locator "//Control[@@windowClassName='INTU_CalloutPopup']"
				[+] Control QWListViewer1
					[ ] locator "@windowid='2030'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] Control QWListViewer2
					[ ] locator "@windowClassName='QWListViewer'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] Control QWListViewer3
					[ ] locator "@windowid='2095'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] Control Profit1
					[ ] locator "@windowid='2134'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] Control Profit2
					[ ] locator "@windowid='2135'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
			[+] Control Panel2
				[ ] locator "//Control[@caption='Panel'][2]"
				[+] StaticText StaticText1
					[ ] locator "@windowid='-1'"
					[+] StaticText StaticText2
						[ ] locator "//StaticText[18]"
						[+] MainWin QWListViewer1
							[ ] locator "@windowid='1'"
							[+] ListBox ListBox1
								[ ] locator "@windowid='1'"
						[ ] 
					[+] StaticText StaticText3
						[ ] locator "@windowid='-1'"
						[+] PushButton AddReminderButton
							[+] locator "@windowid='518'"
								[ ] 
						[+] PushButton ManageRemindersButton
							[ ] locator "@windowid='507'"
						[ ] 
					[ ] //CustomWin("[QC_button]Manage Reminders|#2|$507|@(185,15)")
			[+] Control PanelExpenses
				[ ] locator "//Control[@caption='Panel'][2]"
				[+] StaticText StaticText1
					[ ] //multitag "#1"
					[+] Control GraphPanel
						[ ] // tag "[QWGraphControlClass]#1|$-1"
						[+] Control Panel
							[ ] // tag "[QWPanel]Panel|#1|$-1"
							[+] CustomWin QWListViewer1
								[+] // multitag "[QWListViewer]#1"
									[ ] // "[QWListViewer]$1"
								[ ] locator "@windowid='1'"
								[+] ListBox ListBox1
									[+] // multitag "#1"
										[ ] // "$1"
									[ ] locator "[1]"
				[+] StaticText StaticText3
					[ ] locator "//StaticText[2]"
					[+] Control GraphPanel
						[ ] locator "@windowid='-1'"
						[+] Control Panel
							[ ] tag "[QWPanel]Panel|#1|$-1"
							[+] MainWin QWListViewer1
								[ ] locator "@windowid='0'"
								[+] ListBox ListBox1
									[ ] locator "@windowid='1'"
				[ ] 
				[+] // StaticText StaticText2
					[+] // multitag "#2"
						[ ] // "$-1[2]"
			[ ] 
		[+] ListBox ListBox1
			[ ] locator "//ListBox[1]"
		[+] ListBox ListBox2
			[ ] locator "//ListBox[2]"
		[+] ListBox ListBox3
			[ ] locator "//ListBox[3]"
		[+] ListBox ListBox4
			[ ] locator "//ListBox[4]"
		[+] ListBox ListBox5
			[ ] locator "//ListBox[5]"
		[+] ListBox ListBox6
			[ ] locator "//ListBox[6]"
		[+] ListBox ListBox7
			[ ] locator "//ListBox[7]"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //---DUPLICATE of AddEditRentalPropertyTenant--
	[+] window MainWin DlgAddRentalPropertyTenant
		[ ] locator "Add Rental Property Tenant"
		[+] PushButton AddRentalPropertyTenant
			[ ] locator "@windowid='32765'"
		[+] PushButton AddToAddressBook
			[ ] locator "@windowid='17608'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
		[+] Control Panel2
			[ ] //locator "@windowid='-1[2]'"
			[+] Control QWMsHtmlVw1
				[ ] locator "@windowid='1000'"
				[+] Control ShellEmbedding1
					[ ] locator "@windowid='0'"
					[+] Control ShellDocObjectView1
						[ ] locator "@windowid='0'"
						[+] Control InternetExplorer_Server1
							[ ] locator "@windowid='0'"
		[+] Control AddEditTenantDetails
			[ ] //locator "@windowid='-1[1]'"
			[+] Control QWinChild1
				[ ] //locator "@windowid='0'"
				[+] TextField EditTenantName
					[ ] locator "@windowid='17503'"
				[+] ComboBox PopupListProperty
					[ ] locator "@windowid='17513'"
				[+] TextField EditRentAmount
					[ ] locator "@windowid='17506'"
				[+] ComboBox PopupListRentDueOn
					[ ] locator "@windowid='17508'"
				[+] ComboBox PopupListAccountName
					[ ] locator "@windowid='17523'"
		[+] Control TermsAndAgreement
			[ ] locator "//Control[@caption='Panel'][2]"
			[+] Control QWinChild1
				[ ] locator "//Control[@windowClassName='QWinChild']"
				[+] ComboBox PopupListLeaseTerms
					[ ] locator "@windowid='17558'"
				[+] TextField EditLeaseStartDate
					[ ] locator "@windowid='17512'"
				[+] TextField EditGracePeriod
					[ ] locator "@windowid='17560'"
				[+] TextField EditLateFee
					[ ] locator "@windowid='17563'"
				[+] TextField EditMoveInDate
					[ ] locator "@windowid='17552'"
				[+] TextField EditMoveOutDate
					[ ] locator "@windowid='17554'"
				[+] Control LeaseStartDate2
					[ ] //locator "@Caption='Lease start date'"
					[ ] //locator "@windowid='2020[1]'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='1124'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='1128'"
				[+] Control Days
					[ ] //locator "Days"
					[ ] //locator "@windowid='2020[3]'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='1124'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='1128'"
				[+] Control MoveOutDate2
					[ ] //locator "Move-out date"
					[ ] //locator "@windowid='2020[]'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='1124'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='1128'"
				[+] Control LateFee2
					[ ] //locator "Late Fee"
					[ ] //locator "@windowid='2020[2]'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='1124'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='1128'"
		[+] Control Contact
			[ ] locator "//Control[@caption='Panel'][2]"
			[+] Control QWinChild1
				[ ] locator "//Control[@windowClassName='QWinChild']"
				[+] StaticText HomePhoneText
					[ ] locator "@windowid='17536'"
				[+] TextField HomePhone
					[ ] locator "@windowid='17537'"
				[+] StaticText EmailText
					[ ] locator "@windowid='17538'"
				[+] TextField Email
					[ ] locator "@windowid='17539'"
				[+] StaticText WorkPhoneText
					[ ] locator "@windowid='17534'"
				[+] TextField WorkPhone
					[ ] locator "@windowid='17535'"
				[+] StaticText OtherIDText
					[ ] locator "@windowid='17542'"
				[+] TextField OtherID
					[ ] locator "@windowid='17543'"
				[+] StaticText CellPhoneText
					[ ] locator "@windowid='17532'"
				[+] TextField CellPhone
					[ ] locator "@windowid='17533'"
				[+] StaticText CarLicenseText
					[ ] locator "@windowid='17540'"
				[+] TextField CarLicense
					[ ] locator "@windowid='17541'"
				[+] StaticText DateOfBirthText
					[ ] locator "@windowid='17548'"
				[+] TextField DateOfBirth1
					[ ] locator "@windowid='17549'"
				[+] StaticText OtherPhoneText
					[ ] locator "@windowid='17546'"
				[+] TextField OtherPhone
					[ ] locator "@windowid='17547'"
				[+] StaticText NotesText
					[ ] locator "@windowid='17581'"
				[+] TextField Notes
					[ ] locator "@windowid='17582'"
				[+] Control DateOfBirth2
					[ ] locator  "@windowid='2020'"
					[+] Control QC_button2
						[ ] locator  "@windowid='1124'"
					[+] Control QC_button1
						[ ] locator  "@windowid='1128'"
		[+] Control SecurityDeposit
			[ ] locator "//Control[@caption='Panel'][2]"
			[+] Control QWinChild1
				[ ] locator "//Control[@windowClassName='QWinChild']"
				[+] TextField EditAmountCollected
					[ ] locator "@windowid='17570'"
				[+] TextField EditAmountCollectedDate
					[ ] locator "@windowid='17574'"
				[+] TextField EditAmountReturned
					[ ] locator "@windowid='17572'"
				[+] TextField EditAmountReturnedDate
					[ ] locator "@windowid='17576'"
	[ ] 
	[+] window MainWin AddEditRentalPropertyTenant
		[ ] locator "*Rental Property Tenant"
		[+] PushButton EditRentalPropertyTenant
			[ ] locator "@windowid='32765'"
		[+] PushButton AddToAddressBook
			[ ] locator "@windowid='17608'"
		[+] Control OK
			[ ] locator "@windowid='32767'"
		[+] Control Cancel
			[ ] locator "@windowid='32766'"
		[+] Control AddEditTenantDetails
			[ ] locator "//Control[@caption='Panel'][2]"
			[+] Control QWinChild1
				[ ] locator "//Control[@windowClassName='QWinChild']"
				[+] TextField EditTenantName
					[ ] locator "@windowid='17503'"
				[+] ComboBox PopupListProperty
					[ ] locator "@windowid='17513'"
				[+] TextField EditRentAmount
					[ ] locator "@windowid='17506'"
				[+] ComboBox PopupListRentDueOn
					[ ] locator "@windowid='17508'"
				[+] ComboBox PopupListAccountName
					[ ] locator "@windowid='17523'"
				[+] CheckBox HideTenant
					[ ] locator "@windowid='17517'"
				[+] RadioList SelectReminder
					[ ] locator "@windowid='17518'"
		[+] Control TermsAndAgreement
			[ ] locator "//Control[@caption='Panel'][2]"
			[+] Control QWinChild1
				[ ] locator "//Control[@windowClassName='QWinChild']"
				[+] ComboBox PopupListLeaseTerms
					[ ] locator "@windowid='17558'"
				[+] TextField EditLeaseStartDate
					[ ] locator "@windowid='17512'"
				[+] TextField EditGracePeriod
					[ ] locator "@windowid='17560'"
				[+] TextField EditLateFee
					[ ] locator "@windowid='17563'"
				[+] TextField EditMoveInDate
					[ ] locator "@windowid='17552'"
				[+] TextField EditMoveOutDate
					[ ] locator "@windowid='17554'"
				[+] Control LeaseStartDate2
					[ ] locator "@windowid='2020[1]'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='1124'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='1128'"
				[+] Control Days
					[ ] locator "@windowid='2020[3]'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='1124'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='1128'"
					[ ] 
				[+] Control MoveOutDate2
					[ ] locator "@windowid='2020'"
					[+] Control QC_button2
						[ ] locator "@windowid='1124'"
					[+] Control QC_button1
						[ ] locator "@windowid='1128'"
				[+] Control LateFee2
					[ ] locator "@windowid='2020'"
					[+] Control QC_button2
						[ ] locator "@windowid='1124'"
					[+] Control QC_button1
						[ ] locator "@windowid='1128'"
		[+] Control Contact
			[ ] locator "//Control[@caption='Panel'][2]"
			[+] Control QWinChild1
				[ ] locator "//Control[@windowClassName='QWinChild']"
				[+] StaticText HomePhoneText
					[ ] locator "@windowid='17536'"
				[+] TextField HomePhone
					[ ] locator "@windowid='17537'"
				[+] StaticText EmailText
					[ ] locator "@windowid='17538'"
				[+] TextField Email
					[ ] locator "@windowid='17539'"
				[+] StaticText WorkPhoneText
					[ ] locator "@windowid='17534'"
				[+] TextField WorkPhone
					[ ] locator "@windowid='17535'"
				[+] StaticText OtherIDText
					[ ] locator "@windowid='17542'"
				[+] TextField OtherID
					[ ] locator "@windowid='17543'"
				[+] StaticText CellPhoneText
					[ ] locator "@windowid='17532'"
				[+] TextField CellPhone
					[ ] locator "@windowid='17533'"
				[+] StaticText CarLicenseText
					[ ] locator "@windowid='17540'"
				[+] TextField CarLicense
					[ ] locator "@windowid='17541'"
				[+] StaticText DateOfBirthText
					[ ] locator "@windowid='17548'"
				[+] TextField DateOfBirth1
					[ ] locator "@windowid='17549'"
				[+] StaticText OtherPhoneText
					[ ] locator "@windowid='17546'"
				[+] TextField OtherPhone
					[ ] locator "@windowid='17547'"
				[+] StaticText NotesText
					[ ] locator "@windowid='17581'"
				[+] TextField Notes
					[ ] locator "@windowid='17582'"
				[+] Control DateOfBirth2
					[ ] //locator "@windowid='2020'"
					[+] PushButton QC_button2
						[ ] locator "@windowid='1124'"
					[+] PushButton QC_button1
						[ ] locator "@windowid='1128'"
		[+] Control SecurityDeposit
			[ ] locator "//Control[@caption='Panel'][2]"
			[+] Control QWinChild1
				[ ] locator "//Control[@windowClassName='QWinChild']"
				[+] TextField EditAmountCollected
					[ ] locator "@windowid='17570'"
				[+] TextField EditAmountCollectedDate
					[ ] locator "@windowid='17574'"
				[+] TextField EditAmountReturned
					[ ] locator "@windowid='17572'"
				[+] TextField EditAmountReturnedDate
					[ ] locator "@windowid='17576'"
	[ ] 
	[+] window DialogBox MessageBoxLeaseStartDateCannotBeLater
		[ ] locator "Quicken 2013"
		[+] // CustomWin QWIconDisplay1
			[+] // multitag "[QWIconDisplay]#1"
				[ ] // "[QWIconDisplay]$105"
				[ ] // "[QWIconDisplay]@(32,32)"
		[+] StaticText LeaseStartDateCannotBeLater
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[+] window DialogBox MessageBoxMoveInDateCannotBeLater
		[ ] locator "Quicken 2013"
		[+] // CustomWin QWIconDisplay1
			[+] // multitag "[QWIconDisplay]#1"
				[ ] // "[QWIconDisplay]$105"
				[ ] // "[QWIconDisplay]@(32,32)"
		[+] StaticText MoveInDateCannotBeLater
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[+] window DialogBox MessageBoxGracePeriodValidation
		[ ] locator "Quicken 2013"
		[+] // CustomWin QWIconDisplay1
			[+] // multitag "[QWIconDisplay]#1"
				[ ] // "[QWIconDisplay]$105"
				[ ] // "[QWIconDisplay]@(32,32)"
		[+] StaticText EnterANumberFrom0To30
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[+] window DialogBox MessageBoxLateFee
		[ ] locator "Quicken 2013"
		[+] // CustomWin QWIconDisplay1
			[+] // multitag "[QWIconDisplay]#1"
				[ ] // "[QWIconDisplay]$105"
				[ ] // "[QWIconDisplay]@(32,32)"
		[+] StaticText EnterAValidAmount
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[+] window DialogBox ValidationMessageBox
		[ ] locator "Quicken 2013"
		[+] // CustomWin QWIconDisplay1
			[+] // multitag "[QWIconDisplay]#1"
				[ ] // "[QWIconDisplay]$105"
				[ ] // "[QWIconDisplay]@(32,32)"
		[+] StaticText ErrorMsg
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[+] window DialogBox MessageBoxDepositValidation
		[ ] locator "Quicken 2013"
		[+] // CustomWin QWIconDisplay1
			[+] // multitag "[QWIconDisplay]#1"
				[ ] // "[QWIconDisplay]$105"
				[ ] // "[QWIconDisplay]@(32,32)"
		[+] StaticText SecurityDepositAmount
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
	[ ] 
	[+] window MainWin TenantList
		[ ] locator "Tenant List"
		[+] PushButton New
			[ ] locator "@windowid='17598'"
		[+] PushButton Edit
			[ ] locator "@windowid='17599'"
		[+] PushButton Delete
			[ ] locator "@windowid='17600'"
		[+] PushButton History
			[ ] locator "@windowid='17602'"
		[+] PushButton HelpTenantList
			[ ] locator "@windowid='32765'"
		[+] PushButton PrintTenantList
			[ ] locator "@windowid='32760'"
		[+] PushButton Done
			[ ] locator "@windowid='32766'"
		[+] Control ChildTenantList
			[ ] //locator "@windowClassName='QWinChild'"
			[+] MainWin QWListViewer1
				[ ] locator "@windowid='17597'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
		[+] CheckBox ShowHiddenTenants
			[ ] locator "@windowid='17601'"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] window MainWin TenantHistory
		[ ] locator "Tenant History"
		[+] MainWin QWListViewer1
			[ ] locator "@windowid='17596'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton TenantName
			[ ] locator "@windowid='17604'"
		[+] PushButton Property
			[ ] locator "@windowid='17605'"
		[+] PushButton RentDetails
			[ ] locator "@windowid='17606'"
		[+] PushButton LeaseDetails
			[ ] locator "@windowid='17607'"
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
		[+] PushButton Done
			[ ] locator "@windowid='32766'"
		[+] PushButton Print
			[ ] locator "@windowid='32760'"
		[+] Control Title
			[ ] //locator "@windowClassName='QWinChild'"
			[+] StaticText TenantHistoryForHongText
				[ ] locator "@windowid='1000'"
				[ ] 
	[ ] 
	[+] window MainWin DlgEnterRent
		[ ] locator "Enter Rent"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] ComboBox PropertyPopupList
			[ ] locator "@windowid='10506'"
		[+] ComboBox TenantNamePopupList
			[ ] locator "@windowid='10503'"
		[+] TextField Memo
			[ ] locator "@windowid='10203'"
		[+] ComboBox AccountPopupList
			[ ] locator "@windowid='10201'"
		[+] TextField DateTextField
			[ ] locator "@windowid='10200'"
		[+] TextField RentRecievedTextField
			[ ] locator "@windowid='10509'"
		[+] TextField LateFeeTextField
			[ ] locator "@windowid='10511'"
		[+] TextField MethodCheckNumberTextField
			[ ] locator "@windowid='10206'"
		[+] PushButton AddButton
			[ ] locator "@windowid='32767'"
	[+] window MainWin DlgEnterExpense
		[ ] locator "Enter Expense"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] ComboBox PropertyPopupList
			[ ] locator "@windowid='10506'"
		[+] TextField PayToTextField
			[ ] locator "@windowid='10202'"
		[+] TextField CategoryTextField
			[ ] locator "@windowid='10204'"
		[+] PushButton SplitCategoryButton
			[ ] locator "@windowid='10207'"
		[+] TextField Memo
			[ ] locator "@windowid='10203'"
		[+] ComboBox AccountPopupList
			[ ] locator "@windowid='10201'"
		[+] TextField DateTextField
			[ ] locator "@windowid='10200'"
		[+] TextField AmountToBePaidTextField
			[ ] locator "@windowid='10512'"
		[+] TextField LateFeeTextField
			[ ] locator "@windowid='10511'"
		[+] TextField MethodCheckNumberTextField
			[ ] locator "@windowid='10206'"
		[+] PushButton AddButton
			[ ] locator "@windowid='32767'"
		[ ] 
		[ ] 
		[ ] 
	[+] window MainWin DlgEnterOtherIncome
		[ ] locator "Enter Other Income"
		[+] Control CancelButton
			[ ] locator "@windowid='32766'"
		[+] ComboBox PropertyPopupList
			[ ] locator "@windowid='10506'"
		[+] ComboBox AccountPopupList
			[ ] locator "@windowid='10201'"
		[ ] 
		[ ] 
		[ ] 
	[+] window Control RecordedDepositsCallout
		[ ] locator "Callout Holder"
		[+] Control CalloutPopup
			[ ] // locator "@windowid= '12345'"
			[ ] // locator "l[@windowClassName='INTU_CalloutPopup']"
			[+] PushButton Close
				[ ] locator "close"
			[+] StaticText RecordedDepositsText
				[ ] locator "Recorded Deposits"
			[+] Control RecordedDeposits
				[ ] // locator "@windowid= '2002'"
				[+] ListBox ListBox1
					[ ] locator "@windowid= '1'"
			[+] StaticText TotalText
				[ ] locator "Total"
			[+] StaticText TotalAmountText
				[ ] locator "@windowid= '2005'"
		[+] ListBox ListBox1
			[ ] locator "@windowid= '1'"
		[ ] 
	[ ] 
	[ ] // Added for adding multitags in transaction
	[+] window PushButton MultipleTagsButton
		[ ] locator "/Control[@caption='Quicken 201*']//Control[@windowClassName='QWQuickfillHolder'][3]//PushButton[@caption='Multiple Tags']"
	[+] window ListBox TagListBox
		[ ] locator "/Control[@caption='Quicken 201? Rental Property Manager *']//Control[@windowClassName='QWQuickfillHolder'][3]//ListBox"
	[+] window PushButton DoneButton
		[ ] locator "/Control[@caption='Quicken 201? Rental Property Manager *']//Control[@windowClassName='QWQuickfillHolder'][3]//PushButton[@caption='Done']"
	[ ] 
	[ ] 
	[ ] // DUPLICATE : Will be added in Bills by Anagha
	[+] // window FileDlg DlgManageReminders
		[+] // multitag  "~ActiveApp/[DialogBox]$MessageBox|FileDlg|"
			[ ] // "Bill and Income Reminders"
		[ ] // parent QuickenMainWindow
		[+] // StaticText StaticText1
			[+] // multitag "#1"
				[ ] // "$0"
				[ ] // "@(507,422)"
			[+] // StaticText AllBillsDepositsText
				[+] // multitag"#1"
					[ ] // "$-1[1]"
					[ ] // "@(487,16)"
				[+] // CheckBox  ShowgraphCheckBox
					[+] // multitag "Show graph"
						[ ] // "#1"
						[ ] // "$101"
						[ ] // "@(271,15)"
				[+] // CheckBox  ShowcalendarCheckBox
					[+] // multitag "Show calendar"
						[ ] // "#2"
						[ ] // "$100"
						[ ] // "@(382,15)"
				[+] // CustomWin ReminderGraph
					[+] // multitag "[QWGraphControlClass]"
						[ ] // "#1"
						[ ] // "$0"
				[ ] // 
			[+] // StaticText ReminderCalendar
				[+] // multitag "#4"
					[ ] // "$-1[4]"
			[ ] // 
			[+] // StaticText CalendarText
				[+] // multitag"#2|#3"
					[ ] // "$-1[2]"
					[ ] // "@(487,558)"
				[+] // CustomWin CalendarNextButton
					[+] // multitag "[QC_button]For account[2]"
						[ ] // "#3"
						[ ] // "$204"
						[ ] // //"@(944,25)"
				[+] // CustomWin CalendarPreviousButton
					[+] // multitag "[QC_button]For account[1]"
						[ ] // "#1"
						[ ] // "$203"
				[+] // CustomWin CalendarMonthLabel
					[+] // multitag "[QC_button]"
						[ ] // "#2"
						[ ] // "$205"
						[ ] // 
						[ ] // //"@(787,25)"  CustomWin("[QC_button]November 2012|^For account[2]|#2|$205|@(863,27)")
			[ ] // 
		[+] // CustomWin QW_MDI_TOOLBAR1
			[+] // multitag "[QW_MDI_TOOLBAR]#1"
				[ ] // "[QW_MDI_TOOLBAR]$12000"
				[ ] // "[QW_MDI_TOOLBAR]@(507,11)"
		[+] // PushButton MonthlyBillsDepositsTab
			[+] // multitag "Monthly Bills & Deposits"
				[ ] // "#1"
				[ ] // "$32300"
				[ ] // "@(88,39)"
		[+] // PushButton AllBillsDepositsTab
			[+] // multitag "All Bills & Deposits"
				[ ] // "#2"
				[ ] // "$32301"
				[ ] // "@(235,39)"
		[+] // StaticText StaticText2
			[+] // tag"#2|#1"
				[ ] // 
			[+] // CustomWin ManageRemindersListViewer
				[+] // multitag "[QWListViewer]"
					[ ] // "[QWListViewer]#1"
					[ ] // "[QWListViewer]$1"
					[ ] // "[QWListViewer]@(487,248)"
				[+] // ListBox ListBox1
					[+] // multitag "#1"
						[ ] // "$1"
						[ ] // "@(487,227)"
				[ ] // 
				[ ] // 
			[ ] // 
		[ ] // 
		[ ] // 
	[+] // window FileDlg DlgEditReminder
		[ ] // tag "Edit Income Reminder|Edit Bill Reminder"
		[ ] // parent BillAndIncomeReminders
		[+] // StaticText EditBillReminderText
			[+] // multitag "Edit Bill Reminder"
				[ ] // "#1"
				[ ] // "$100"
				[ ] // "@(298,24)"
		[+] // CustomWin Done
			[+] // multitag "[QC_button]Done"
				[ ] // "[QC_button]^Edit Bill Reminder[4]"
				[ ] // "[QC_button]#4"
				[ ] // "[QC_button]$32767"
				[ ] // "[QC_button]@(548,416)"
		[+] // CustomWin Delete
			[+] // multitag "[QC_button]Delete"
				[ ] // "[QC_button]^Edit Bill Reminder[3]"
				[ ] // "[QC_button]#3"
				[ ] // "[QC_button]$32754"
				[ ] // "[QC_button]@(168,416)"
		[+] // CustomWin Cancel
			[+] // multitag "[QC_button]Cancel"
				[ ] // "[QC_button]^Edit Bill Reminder[2]"
				[ ] // "[QC_button]#2"
				[ ] // "[QC_button]$32766"
				[ ] // "[QC_button]@(84,416)"
		[+] // CustomWin EditBillReminder
			[+] // multitag "[QC_button]Edit Bill Reminder"
				[ ] // "[QC_button]^Edit Bill Reminder[1]"
				[ ] // "[QC_button]#1"
				[ ] // "[QC_button]$32765"
				[ ] // "[QC_button]@(23,417)"
		[+] // CustomWin Panel1
			[+] // multitag "[QWPanel]Panel[1]"
				[ ] // "[QWPanel]^Edit Bill Reminder[1]"
				[ ] // "[QWPanel]#1"
				[ ] // "[QWPanel]$-1[1]"
				[ ] // "[QWPanel]@(301,71)"
			[+] // CustomWin QWinChild1
				[+] // multitag "[QWinChild]#1"
					[ ] // "[QWinChild]$-1"
					[ ] // "[QWinChild]@(274,26)"
				[+] // StaticText PayToText
					[+] // multitag "Pay to"
						[ ] // "#1"
						[ ] // "$101"
						[ ] // "@(66,24)"
				[+] // TextField PayTo
					[+] // multitag "Pay to"
						[ ] // "^Pay to"
						[ ] // "#1"
						[ ] // "$107"
						[ ] // "@(275,22)"
		[+] // CustomWin Panel2
			[+] // multitag "[QWPanel]Panel[2]"
				[ ] // "[QWPanel]^Edit Bill Reminder[2]"
				[ ] // "[QWPanel]#2"
				[ ] // "[QWPanel]$-1[2]"
				[ ] // "[QWPanel]@(298,246)"
			[+] // CustomWin QWinChild1
				[+] // multitag "[QWinChild]#1"
					[ ] // "[QWinChild]$-1"
					[ ] // "[QWinChild]@(280,146)"
				[+] // TextField DueNextOnTextField
					[+] // multitag "Due next on"
						[ ] // "^Due next on"
						[ ] // "#1"
						[ ] // "$122"
						[ ] // "@(147,9)"
				[+] // CustomWin ChangeLink
					[+] // multitag "[QC_button](change)"
						[ ] // "[QC_button]^1st of every month"
						[ ] // "[QC_button]#1"
						[ ] // "[QC_button]$124"
						[ ] // "[QC_button]@(336,8)"
				[+] // TextField AmountDueTextField
					[+] // multitag "Amount due"
						[ ] // "^Amount due"
						[ ] // "#2"
						[ ] // "$126"
						[ ] // "@(147,35)"
				[+] // TextField FromAccountTextField
					[+] // multitag "From account"
						[ ] // "^From account"
						[ ] // "#3"
						[ ] // "$110"
						[ ] // "@(239,61)"
	[+] // window FileDlg DlgEnterIncomeTransaction
		[ ] // tag "Enter income transaction|Enter expense transaction"
		[ ] // parent BillAndIncomeReminders
		[+] // StaticText EnterIncomeTransactionText
			[+] // multitag "Enter income transaction"
				[ ] // "#1"
				[ ] // "$32702"
				[ ] // "@(237,20)"
		[+] // TextField PayeeInformationTextField
			[+] // multitag "Payee Information"
				[ ] // "^Payee Information"
				[ ] // "#1"
				[ ] // "$10202"
				[ ] // "@(232,192)"
		[+] // CustomWin AddressButton
			[+] // multitag "[QC_button]Address"
				[ ] // "[QC_button]^Payee Information[1]"
				[ ] // "[QC_button]#1"
				[ ] // "[QC_button]$10208"
				[ ] // "[QC_button]@(381,191)"
		[+] // TextField CategoryTextField
			[+] // multitag "Category"
				[ ] // "^Category"
				[ ] // "#2"
				[ ] // "$10204"
				[ ] // "@(232,221)"
		[+] // CustomWin SplitCategoryButton
			[+] // multitag "[QC_button]Split"
				[ ] // "[QC_button]^Payee Information[2]"
				[ ] // "[QC_button]#2"
				[ ] // "[QC_button]$10207"
				[ ] // "[QC_button]@(381,221)"
		[+] // TextField TagTextField
			[+] // multitag "Tag"
				[ ] // "^Tag"
				[ ] // "#3"
				[ ] // "$10217"
				[ ] // "@(232,251)"
		[+] // TextField MemoTextField
			[+] // multitag "Memo"
				[ ] // "^Memo"
				[ ] // "#4"
				[ ] // "$10203"
				[ ] // "@(287,280)"
		[+] // PopupList AccountToUsePopupList
			[+] // multitag "Payment Information"
				[ ] // "^Payment Information"
				[ ] // "#1"
				[ ] // "$10201"
				[ ] // "@(241,353)"
		[+] // TextField MethodCheckNumberTextField
			[+] // multitag "Method?Check Number"
				[ ] // "^Method?Check Number"
				[ ] // "#5"
				[ ] // "$10206"
				[ ] // "@(232,395)"
		[+] // TextField AmountTextField
			[+] // multitag "?[1]"
				[ ] // "^?[1]"
				[ ] // "#6"
				[ ] // "$10205"
				[ ] // "@(232,454)"
		[+] // TextField DateTextField
			[+] // multitag "?[2]"
				[ ] // "^?[2]"
				[ ] // "#7"
				[ ] // "$10200"
				[ ] // "@(200,483)"
		[+] // CustomWin EnterTransactionButton
			[+] // multitag "[QC_button]Enter Transaction"
				[ ] // "[QC_button]^Payment Information[1]"
				[ ] // "[QC_button]#4"
				[ ] // "[QC_button]$32767"
				[ ] // "[QC_button]@(287,537)"
		[+] // CustomWin CancelButton
			[+] // multitag "[QC_button]Cancel"
				[ ] // "[QC_button]^Payment Information[2]"
				[ ] // "[QC_button]#5"
				[ ] // "[QC_button]$32766"
				[ ] // "[QC_button]@(393,537)"
		[+] // Control HelpButton
			[+] // locator "[QC_button]Date"
				[ ] // "[QC_button]^Date"
				[ ] // "[QC_button]#3"
				[ ] // "[QC_button]$32765"
				[ ] // "[QC_button]@(35,536)"
	[ ] 
	[ ] 
	[ ] 
	[+] window MainWin DlgSkipThisReminder
		[ ] locator "Skip this reminder"
		[+] StaticText SkipThisReminderText
			[ ] locator "@windowid='32702'"
		[+] StaticText AreYouSureYouWantToSkip
			[ ] locator "@windowid='65535'"
		[+] CheckBox DonTShowMeThisAgain
			[ ] locator "@windowid='1020'"
		[+] PushButton SkipButton
			[ ] locator "@windowid='32767'"
		[+] PushButton DonTSkipButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[+] window MainWin DlgTagList
		[ ] locator "Tag List"
		[+] PushButton QC_button1
			[ ] locator "@windowid='32765'"
		[+] PushButton QC_button2
			[ ] locator "@windowid='32760'"
		[+] PushButton NewButton
			[ ] locator "@windowid='32200'"
		[+] PushButton DoneButton
			[ ] locator "@windowid='32766'"
		[+] Control QWinChild1
			[+] Control BusinessListItem
				[ ] locator "@windowid='1002'"
			[+] Control PropertyListItem
				[ ] locator "@windowid='1006'"
			[+] Control OtherListItem
				[ ] locator "@windowid='1003'"
			[+] Control AllTagsListItem
				[ ] locator "@windowid='1004'"
			[+] MainWin QWListViewer1
				[ ] locator "@windowid='1001'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
		[+] Control Title
			[+] StaticText TagListText
				[ ] locator "@windowid='1000'"
	[ ] 
	[+] window MainWin DlgVehicleMileage
		[ ] locator "Vehicle Mileage"
		[+] StaticText BusinessNameText
			[ ] locator "@windowid='3412'"
		[+] ComboBox BusinessNamePopupList
			[ ] locator "@windowid='3455'"
			[ ] 
		[+] TextField TripDatesTextField
			[ ] locator "@windowid='3441'"
		[+] TextField ToDateTextField
			[ ] locator "@windowid='3442'"
		[+] ComboBox TripTypePopupList
			[ ] locator "@windowid='3443'"
		[+] StaticText RateText
			[ ] locator "@windowid='3411'"
		[+] StaticText RateValueText
			[ ] locator "@windowid='3431'"
		[+] ComboBox PropertyNamePopupList
			[ ] locator "@windowid='3456'"
		[+] TextField PurposeTextField
			[ ] locator "@windowid='3444'"
		[+] TextField StartLocationTextField
			[ ] locator "@windowid='3457'"
		[+] TextField DestinationTextField
			[ ] locator "@windowid='3445'"
		[+] TextField VehicleUsedTextField
			[ ] locator "@windowid='3446'"
		[+] TextField ParkingAndTollTextField
			[ ] locator "@windowid='3452'"
		[+] PushButton SaveChangesButton
			[ ] locator "@windowid='3454'"
		[ ] 
		[ ] 
		[+] TextField OdometerAtStartTextField
			[ ] locator "@windowid='3447'"
		[+] TextField OdometerAtEndTextField
			[ ] locator "@windowid='3449'"
		[+] TextField MilesTraveledTextField
			[ ] locator "@windowid='3451'"
		[+] // Control MilesTraveled2
			[+] // locator "[QWHtmlView]Miles traveled"
				[ ] // "[QWHtmlView]#1"
				[ ] // "[QWHtmlView]$3464"
		[+] PushButton EnterTripButton
			[ ] locator "@windowid='3454'"
		[+] MainWin AllTripsForGrid
			[ ] locator "@windowid='3471'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton NewButton
			[ ] locator "@windowid='32200'"
		[+] PushButton EditButton
			[ ] locator "@windowid='32204'"
		[+] PushButton DeleteButton
			[ ] locator "@windowid='32201'"
		[+] PushButton CopyButton
			[ ] locator "@windowid='135'"
		[+] PushButton PasteButton
			[ ] locator "@windowid='136'"
		[+] PushButton CustomizeButton
			[ ] locator "@windowid='32207'"
		[+] PushButton RatesButton
			[ ] locator "@windowid='32209'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] PushButton PrintButton
			[ ] locator "@windowid='32760'"
		[+] Control linkNotSureHowFarItWas
			[ ] locator "@windowid='3464'"
		[ ] 
		[+] Control DoneButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[+] window DialogBox VehicleMileageDeleteConfirmationDialog
		[ ] locator "@caption='Quicken 20*'"
		[+] StaticText textYouAreAboutToDelete
			[ ] locator "@windowid='100'"
		[+] PushButton OK
			[ ] locator "@windowid='101'"
			[ ] // locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='102'"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] window DialogBox CustomizeMileageList
		[ ] locator "@caption='Customize Mileage List'"
		[+] CheckBox chkboxPurpose
			[ ] locator "@windowid='3564'"
		[+] ComboBox ddlType
			[ ] locator "@windowid='3443'"
		[+] ComboBox ddlBusinessName
			[ ] locator "@windowid='3455'"
		[+] TextField textFieldTravelledAtLeast
			[ ] locator "@windowid='3571'"
		[+] PushButton buttonOK
			[ ] locator "@windowid='32767'"
		[+] PushButton buttonCancel
			[ ] locator "@windowid='32766'"
		[+] PushButton buttonReset
			[ ] locator "@windowid='3560'"
		[ ] 
	[ ] 
	[ ] 
	[+] window DialogBox MileageRates
		[ ] locator "@caption='*Mileage Rates per IRS'"
		[ ] 
		[+] ListBox listboxRates
			[ ] locator "@windowid='1'"
		[+] PushButton buttonClose
			[ ] locator "@windowid='32766'"
		[ ] 
	[ ] 
	[+] window DialogBox OptionsDialog
		[ ] locator "[1]"
		[+] StaticText DialogTitleText
			[ ] locator "@windowid='32702'"
		[+] StaticText DialogMessageText
			[ ] locator "@windowid='25007'"
		[+] PushButton OK
			[ ] locator "OK"
			[ ] // locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] TextField TextField
			[ ] locator "@windowid='25010'"
		[ ] 
		[ ] 
	[ ] 
	[+] window DialogBox DlgSaveReport
		[ ] locator "Save Report*"
		[+] TextField ReportName
			[ ] locator "@windowid='101'"
		[+] TextField Description
			[ ] locator "@windowid='102'"
		[+] PopupList SaveIn
			[ ] locator "@windowid='104'"
		[+] CheckBox SaveReportHistory
			[ ] locator "@windowid='108'"
		[+] MainWin MySavedReportsContents1
			[ ] locator "@windowid='106'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[+] PushButton MySavedReportsContents2
			[ ] locator "@windowid='32765'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] CheckBox DontShowMeThisAgain
			[ ] locator "@windowid='100'"
			[ ] 
		[+] PushButton DontShowThisAgainButton
			[ ] locator "@windowid='32762'"
		[ ] 
	[ ] 
	[+] window DialogBox CategoryQuickList
		[ ] locator "[1]"
		[+] PushButton AddCategory
			[ ] locator "@windowid='1002'"
		[+] Control QWinChild1
			[+] PushButton BusinessIncome
				[ ] locator "@windowid='1003'"
			[+] PushButton BusinessExpenses
				[ ] locator "@windowid='1004'"
			[+] PushButton PersonalIncome
				[ ] locator "@windowid='1005'"
			[+] PushButton PersonalExpenses
				[ ] locator "@windowid='1006'"
			[+] PushButton RentalPropertyIncome
				[ ] locator "@windowid='1011'"
			[+] PushButton RentalPropertyExpenses
				[ ] locator "@windowid='1012'"
			[+] PushButton Transfers
				[ ] locator "@windowid='1008'"
			[+] PushButton AllCategories
				[ ] locator "@windowid='1009'"
			[+] PushButton QC_button9
				[ ] locator "@windowid='1013'"
			[+] MainWin QWListViewer1
				[ ] locator "@windowid='1001'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
	[ ] 
	[+] window Control TagQuickList
		[ ] locator "Control[@windowClassName='QWQuickfillHolder']"
		[+] PushButton ShowFullListButton
			[ ] locator "@windowid='1000'"
		[+] PushButton MultipleTagsButton
			[ ] locator "@windowid='1003'"
		[+] PushButton AddTagButton
			[ ] locator "@windowid='1001'"
		[+] PushButton DoneButton
			[ ] locator "@windowid='32767'"
		[+] Control QWinChild1
			[+] PushButton Business
				[ ] locator "@windowid='1002'"
			[+] PushButton Property
				[ ] locator "@windowid='1006'"
			[+] PushButton Other
				[ ] locator "@windowid='1003'"
			[+] PushButton AllTags
				[ ] locator "@windowid='1004'"
			[+] Control QWListViewer1
				[ ] locator "@windowid='1001'"
				[+] ListBox ListBox1
					[ ] locator "@windowid='1'"
					[ ]  
			[ ] 
		[+] ListBox ListBox1
			[ ] locator "@windowid='1'"
			[ ] // locator "//ListBox"
		[+] PushButton AllTags
			[ ] // locator "@windowid='1004'"
			[ ] locator "All Tags"
	[+] window PushButton MultipleTags
		[ ] locator "/Control[@caption='Quicken 201*']//Control[@windowClassName='QWQuickfillHolder']//PushButton[@caption='Multiple Tags']"
	[+] window PushButton AllTags
		[ ] locator "/Control[@caption='Quicken 201*']//Control[@windowClassName='QWQuickfillHolder']//PushButton[@caption='AllTags']"
	[ ] 
	[ ] 
	[ ] 
	[ ] //Mukesh Sept 07 2013
	[+] window MainWin DlgProfitLossDetails
		[ ] locator "Profit?Loss*"
		[+] StaticText ProfitLossDetailsStaticText
			[ ] locator "@windowid='32702'"
			[+] StaticText ProfitLossDetailsSubStaticText
				[ ] locator "*"
				[ ] 
		[+] MainWin ProfitLossDetailsListViewer
			[ ] locator "@windowid='2000'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
			[ ] 
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] PushButton PrintButton
			[ ] locator "@windowid='32760'"
		[+] PushButton CloseButton
			[ ] locator "@windowid='32766'"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //**********************Separate Objects*********************************
	[ ] // Objects defined here may be child objects of any window but we are not able to perform any actions on them when identified in the hierarchy
	[ ] 
	[ ] 
	[+] window PushButton AddReminderButton
		[ ] //locator "//PushButton[@caption='Add Reminder'][2]"
		[ ] locator "//PushButton[@caption='*Add*Reminder*']"
		[ ] //locator "@caption='*Add*Reminder*'"
		[ ] 
		[+] MenuItem BillReminder
			[ ] locator "@windowid='3058'"
		[ ] 
	[ ] 
	[+] window PushButton ManageReminderButton
		[ ] locator "//PushButton[@caption='*Manage*Reminder*']"
		[ ] //locator "@caption='*Manage*Reminder*'"
		[ ] 
		[ ] 
	[ ] 
	[+] window Control BusinessRemindersList
		[ ] locator "@windowClassName='QWHtmlView'"
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] //************* MoblieSync ********************************************************
	[+] window Control WinMoblieSync
		[ ] locator "/Control[@caption='Quicken 201*']//Control[@windowClassName='MDIClient']"
		[+] Control QWSnapHolder1
			[ ] locator "@windowid='-1'"
			[+] Control CreateQuickenCloudIDPanel
				[ ] locator "@windowid='101'"
				[+] Control QWinChild1
					[ ] locator "@windowid='-1'"
					[+] StaticText PanelMoblieSyncHeaderStaticText
						[ ] locator  "@windowid='100'"
					[+] TextField YourEmailTextField
						[ ] locator "@windowid='104'"
					[+] TextField ConfirmEmailTextField
						[ ] locator "@windowid='107'"
					[+] TextField PasswordTextField
						[ ] locator "@windowid='110'"
					[+] TextField ConfirmPasswordTextField
						[ ] locator "@windowid='113'"
					[+] TextField ZipCodeTextField
						[ ] locator "@windowid='116'"
					[+] StaticText SelectTheAccountsYouWantText
						[ ] locator "@windowid='100'"
					[+] MainWin QWListViewer1
						[ ] locator "@windowid='104'"
						[+] ListBox ListBox1
							[ ] locator "@windowid='1'"
							[+] TextField AccountPasswordTextField
								[ ] locator "@windowid='104'"
								[ ] 
					[+] PushButton AllButton
						[ ] locator "@windowid='133'"
					[+] PushButton NoneButton
						[ ] locator "@windowid='135'"
					[+] Control HTTP500Error
						[ ] locator "@windowid='111'"
					[+] StaticText IntuitIDValue1Text
						[ ] locator "@windowid='112'"
				[+] PushButton NextButton
					[ ] locator "@windowid='32764'"
				[+] PushButton CancelButton
					[ ] locator "@windowid='32766'"
				[+] PushButton HelpButton
					[ ] locator "@windowid='32765'"
				[+] PushButton DoneButton
					[ ] locator "@windowid='32767'"
			[+] Control Panel
				[ ] locator "@windowid='-1'"
				[+] Control QWMsHtmlVw1
					[ ] locator "@windowid='1000'"
					[+] Control ShellEmbedding1
						[ ] locator "@windowid='0'"
						[+] Control ShellDocObjectView1
							[ ] locator "@windowid='0'"
							[+] Control InternetExplorer_Server1
								[ ] locator "@windowid='0'"
			[+] Control PanelMoblieSyncOverview
				[ ] locator "@windowid='104'"
				[+] Control QWIconDisplay1
					[ ] locator "@windowid='118'"
				[+] Control QuickenCloud
					[ ] locator "@windowid='100'"
				[+] Control OverviewText
					[ ] locator "@windowid='119'"
				[+] PushButton EditProfileLink
					[ ] locator "@windowid='120'"
				[+] Control EmailIDLinkText
					[ ] locator "@windowid='112'"
				[+] Control LastFullSyncText
					[ ] locator "@windowid='121'"
				[+] Control LastSyncDateTimeText
					[ ] locator "@windowid='122'"
				[+] PushButton SyncNowButton
					[ ] locator "@windowid='105'"
				[+] StaticText ACCOUNTSENABLEDFORMOBILEText
					[ ] locator "@windowid='129'"
				[+] PushButton EditAccountSettingsLink
					[ ] locator "@windowid='124'"
				[+] StaticText EMAILANDTEXTALERTSText
					[ ] locator "@windowid='208'"
				[+] Control EMAILANDTEXTALERTSQWListViewer
					[ ] locator "@windowid='251'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] Control ACCOUNTSENABLEDFORMOBILEAN2
					[ ] locator "@windowid='145'"
				[+] StaticText NoOfAccountsSyncedText
					[ ] locator "@windowid='144'"
				[+] StaticText BUDGETTOSHOWONPHONEORTABtext
					[ ] locator "@windowid='139'"
				[+] Control ACCOUNTSENABLEDQWListViewer
					[ ] locator "@windowid='104'"
					[+] ListBox ListBox1
						[ ] locator "@windowid='1'"
				[+] PushButton ReplaceAccountsOnQuickenCloudButton
					[ ] locator "@windowid='129'"
				[+] PushButton DoneButton
					[ ] locator "@windowid='32767'"
				[+] PushButton EditAlertsSettingsLink
					[ ] locator "@windowid='209'"
				[ ] 
			[+] StaticText ReplaceTheAccount
				[ ] locator "@windowid='105'"
				[+] PushButton ReplaceAccountsOnQuickenCloudButton
					[ ] locator "@windowid='129'"
				[+] PushButton DoneButton
					[ ] locator "@windowid='32767'"
			[ ] //<< Added by Govind on 22Jan2014...
			[+] //Control QWinChild1
				[ ] //locator "@windowid='-1'"
				[+] //Control QWinChild11
					[ ] //locator "@windowid='-1'"
					[+] //StaticText CreateQuickenCloudAccountHeaderText
						[ ] //locator "@caption='Create a Quicken Cloud Account to receive alerts or access your data from mobile devices'"
					[+] //StaticText YourIntuitIDText
						[ ] //locator "@caption='Your Intuit ID:'"
					[+] //StaticText VerifyYourZipCodeText
						[ ] //locator "@caption='Verify your zip code:'"
			[+] StaticText CreateQuickenCloudAccountHeaderText
				[ ] locator "@caption='Create a Quicken Cloud Account to receive alerts or access your data from mobile devices'"
			[+] StaticText YourIntuitIDText
				[ ] locator "@caption='Your Intuit ID:'"
			[+] StaticText VerifyYourZipCodeText
				[ ] locator "@caption='Verify your zip code:'"
			[+] StaticText IntuitIDValueText
				[ ] locator "@windowid='104'"
			[+] TextField ZipCodeTextField
				[ ] locator "@windowid='116'"
			[+] PushButton NextButton
				[ ] locator "@windowid='32764'"
			[+] //StaticText SelectAccountsToSyncText
				[ ] //locator "@caption='Select the accounts you want to access from mobile devices'"
				[ ] 
			[ ] //...Added by Govind on 22Jan2014>>
	[+] window MainWin DlgSignInMoblieSync
		[ ] locator "Sign in with your Quicken Cloud ID"
		[+] StaticText SignInDialogText
			[ ] locator "@windowid='144'"
		[+] TextField QuickenCloudIDTextField
			[ ] locator "@windowid='101'"
		[+] TextField QuickenCloudPasswordTextField
			[ ] locator "@windowid='105'"
		[+] CheckBox RememberThisCheckBox
			[ ] locator "@windowid='128'"
		[+] PushButton ForgotYourPasswordButton
			[ ] locator "@windowid='124'"
		[+] PushButton SignInButton
			[ ] locator "@windowid='122'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[+] window MainWin DlgEditBudgetSettings
		[ ] locator "Edit Budget Settings"
		[+] StaticText EditBudgetSettingsText
			[ ] locator "@windowid='32702'"
		[+] StaticText SpendingBudgetToSyncToPhoneText
			[ ] locator "@windowid='187'"
		[+] RadioList SpendingBudgetToSyncRadioList
			[ ] locator "@windowid='181'"
		[+] PushButton HelpButton
			[ ] locator "@windowid='32765'"
		[+] PushButton OKButton
			[ ] locator "@windowid='184'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[+] window MainWin DlgEditAccountSettings
		[ ] locator "Edit Account Settings"
		[+] StaticText EditAccountSettingsText
			[ ] locator "@windowid='32702'"
		[+] StaticText AccountsEnabledForMobileText
			[ ] locator "@windowid='155'"
		[+] PushButton Help
			[ ] locator "@windowid='32765'"
		[+] PushButton WhyArenTAllMyAccountsLis
			[ ] locator "@windowid='156'"
		[+] PushButton AccountsEnabledForMobile2
			[ ] locator "@windowid='32765'"
		[+] PushButton UpdateAccountsButton
			[ ] locator "@windowid='157'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
		[+] Control AccountsEnabledForMobileQWListViewer
			[ ] locator "@windowid='150'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
		[ ] 
	[+] window MainWin DlgEditAlertsSettings
		[ ] locator "Edit Alerts Settings"
		[+] StaticText AccountSummaryNotificationsT
			[ ] locator "@windowid='184'"
		[+] StaticText HowOftenYouDLikeToReceiveMailsText
			[ ] locator "How often you'd like to receive account activity summaries?"
		[+] StaticText SummaryEmailsText
			[ ] locator "@windowid='195'"
		[+] ComboBox SummaryEmailsPopupList
			[ ] locator "@windowid='187'"
		[+] StaticText EmailTextAlertsText
			[ ] locator "Email & Text Alerts"
		[+] StaticText EmailAlertsWillBeSentToT
			[ ] locator "Email alerts will be sent to:"
		[+] Control EmailIDText
			[ ] locator "@priorlabel='Email alerts will be sent to:'"
		[+] CheckBox SecondaryEmailForAlerts
			[ ] locator "Secondary email for alerts"
		[+] TextField SecondaryEmailForAlertsTextField
			[ ] locator "Email alerts will be sent to:"
		[+] Control EmailAlertsWillBeSentToQWListViewer
			[ ] locator "@windowid='173'"
			[+] ListBox ListBox1
				[ ] locator "@windowid='1'"
				[+] ComboBox AmountPopupList
					[ ] locator "@windowid='5'"
		[+] PushButton EnableTextAlerts
			[ ] locator "@windowid='220'"
		[+] PushButton EmailTextAlerts2
			[ ] locator "@windowid='32765'"
		[+] StaticText EditAlertsSettingsText
			[ ] locator "@windowid='32702'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[ ] 
		[ ] 
	[+] window MainWin DlgEditQuickenCloudProfile
		[ ] locator "Edit Quicken Cloud Profile"
		[+] StaticText DlgEditQuickenCloudProfileText
			[ ] locator "@windowid='32702'"
		[+] StaticText CloudIDText
			[ ] locator "@windowid='249'"
		[+] TextField QuickenCloudIDTextField
			[ ] locator "@windowid='174'"
		[+] StaticText PasswordText
			[ ] locator "@windowid='248'"
		[+] TextField PasswordTextField
			[ ] locator "@windowid='175'"
		[+] TextField ConfirmPasswordTextField
			[ ] locator "@windowid='176'"
		[+] StaticText ZipCodeText
			[ ] locator "@windowid='247'"
		[+] TextField ZipCode
			[ ] locator "@windowid='161'"
		[+] StaticText SyncedDevicesText
			[ ] locator "@windowid='163'"
		[+] Control DeleteQuickenCloudAccountButton
			[ ] locator "@windowid='166'"
		[+] Control OKButton
			[ ] locator "@windowid='32767'"
		[+] Control CancelButton
			[ ] locator "@windowid='32766'"
	[+] window MainWin DlgDeleteQuickenCloudAccount
		[ ] locator "Delete Quicken Cloud Data"
		[+] StaticText DeleteQuickenCloudAccountText
			[ ] locator "@windowid='32702'"
		[+] StaticText TypeYesToConfirmDeletionText
			[ ] locator "@windowid='177'"
		[+] TextField TypeYesToConfirmDeletionTextField
			[ ] locator "@windowid='168'"
		[+] PushButton DeleteButton
			[ ] locator "@windowid='178'"
		[+] PushButton CancelButton
			[ ] locator "@windowid='32766'"
	[+] window MainWin DlgCloudSyncComplete
		[ ] locator "Cloud Sync Complete"
		[+] StaticText CloudSyncCompleteText
			[ ] locator "@windowid='32702'"
		[+] PushButton CloudSyncComplete
			[ ] locator "@windowid='1001'"
		[+] CheckBox DonTShowThisAgain
			[ ] locator "@windowid='1002'"
		[+] PushButton OKButton
			[ ] locator "@windowid='32767'"
	[+] window MainWin DlgAccountsSynced
		[ ] locator "Accounts Synced"
		[+] StaticText AccountsSyncedText
			[ ] locator "@windowid='32702'"
		[+] PushButton OK
			[ ] locator "@windowid='32767'"
		[+] StaticText IntuitIDValueText
			[ ] locator "@windowid='134'"
	[+] window MainWin DlgForgotYourQuickenCloudPassword
		[ ] locator "Forgot your Quicken Cloud Password?"
		[ ] 
		[+] StaticText ForgotYourQuickenCloudPass1
			[ ] locator "@windowid='32702'"
		[+] PushButton OK
			[ ] locator "@windowid='1100'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton ForgotYourQuickenCloudPass2
			[ ] locator "@windowid='32765'"
		[+] StaticText ZipCodeText
			[ ] locator "Zip code"
		[+] TextField ZipCode
			[ ] locator "Zip code"
		[+] StaticText TheEmailWillBeSentToText
			[ ] locator "The email will be sent to:"
		[+] StaticText MailLink
			[ ] locator "@windowid='1108'"
	[+] window MainWin DlgResetYourQuickenCloudPassword
		[ ] locator "Reset your Quicken Cloud Password"
		[+] StaticText ResetYourQuickenCloudPassw1
			[ ] locator "@windowid='32702'"
		[+] PushButton OK
			[ ] locator "@windowid='1100'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
		[+] PushButton ConfirmNewPassword1
			[ ] locator "@windowid='32765'"
		[+] StaticText AccessCodeText
			[ ] locator "@windowid='1110'"
		[+] TextField AccessCode1
			[ ] locator "@windowid='1111'"
		[+] StaticText ChangeYourQuickenCloudPass
			[ ] locator "@windowid='1112'"
		[+] StaticText NewPasswordText
			[ ] locator "New password"
		[+] TextField NewPassword
			[ ] locator "@windowid='1113'"
		[+] StaticText ConfirmNewPasswordText
			[ ] locator "Confirm new password"
		[+] TextField ConfirmNewPassword2
			[ ] locator "@windowid='1114'"
	[+] window MainWin UnlinkThisDataFile
		[ ] locator "Unlink This Data File"
		[+] StaticText UnlinkThisDataFileText
			[ ] locator "@windowid='32702'"
		[+] Control UnlinkThisDataFile
			[ ] locator "@windowid='148'"
		[+] StaticText UnlinkingThisDataFileWill1
			[ ] locator "@windowid='65535'"
		[+] PushButton UnlinkingThisDataFileWill2
			[ ] locator "@windowid='32765'"
		[+] PushButton Unlink
			[ ] locator "@windowid='32767'"
		[+] PushButton Cancel
			[ ] locator "@windowid='32766'"
	[+] window TextField AccountPasswordTextField 
		[ ] tag "~/[TextField]#1|$104"
	[+] window WPFWindow DlgSyncCreatePasswordVault
		[ ] locator "/WPFWindow[@caption='Create Password Vault']"
		[+] WPFContentControl PasswordVaultContentControl
			[ ] locator "//WPFContentControl[@caption='Create Password Vault']"
			[+] WPFButton OK
				[ ] locator "OK"
			[+] WPFButton Cancel
				[ ] locator "Cancel"
			[ ] 
			[ ] 
		[ ] 
		[ ] 
[ ] 
[ ] 
[ ] //************* MoblieSync *************************************
[ ] 
[ ] // // //----------Quicken Connected Services / IAM Registration--------
[+] // // window WPFWindow QuickenConnectedServices
	[ ] // // locator "/WPFWindow[@caption='Quicken Connected Services']"
	[ ] // // //First Page of Quicken Connected Services Log In Process
	[+] // // WPFButton Later
		[ ] // // locator "Later"
	[+] // // WPFButton LetsGo
		[ ] // // locator "Let's Go"
	[ ] // // 
	[+] // // WPFContentControl QCSCControl
		[ ] // // locator "Quicken Connected Services"
		[ ] // // 
		[ ] // // //Second Page of Quicken Connected Services Log In Process
		[+] // // WPFTextBox EmailID
			[ ] // // locator "@automationId='tb_email'"
		[+] // // WPFPasswordBox Password
			[ ] // // locator "@automationId='pb_password'"
		[+] // // WPFPasswordBox ConfirmPassword
			[ ] // // locator "@automationId='pb_confirmed'"
		[+] // // WPFComboBox SecurityQuestion
			[ ] // // locator "//WPFComboBox"
		[+] // // WPFTextBox SecurityQuestionAnswer
			[ ] // // locator "@automationId='tb_answer'"
		[+] // // WPFButton SignIn
			[ ] // // locator "Sign In"
		[+] // // WPFButton Later
			[ ] // // locator "Later"
		[+] // // WPFButton Back
			[ ] // // locator "Back"
		[+] // // WPFButton NextButton
			[ ] // // locator "Next"
		[ ] // // //Third Page of Quicken Connected Services Log In Process
		[+] // // WPFTextBox Name
			[ ] // // locator "@automationId='tb_fname'"
		[+] // // WPFTextBox LastName
			[ ] // // locator "@automationId='tb_LName'"
		[+] // // WPFTextBox Address
			[ ] // // locator "@automationId='tb_Address'"
		[+] // // WPFTextBox City
			[ ] // // locator "@automationId='tb_city'"
		[+] // // WPFComboBox State
			[ ] // // locator "@automationId='tb_state'"
		[+] // // WPFTextBox Zip
			[ ] // // locator "@automationId='tb_zip'"
		[+] // // WPFTextBox Phone
			[ ] // // locator "[6]"
		[+] // // WPFCheckBox Quicken
			[ ] // // locator "Quicken"
		[+] // // WPFCheckBox Mint
			[ ] // // locator "Mint"
		[+] // // WPFCheckBox OnlineBanking
			[ ] // // locator "Online Banking"
		[+] // // WPFCheckBox Spreadsheet
			[ ] // // locator "Spreadsheet"
		[+] // // WPFCheckBox PaperStatements
			[ ] // // locator "Paper Statements"
		[+] // // WPFCheckBox MicrosoftMoney
			[ ] // // locator "Microsoft Money"
		[+] // // WPFCheckBox OtherSoftware
			[ ] // // locator "Other Software"
		[+] // // WPFCheckBox NoOtherMethod
			[ ] // // locator "No other Method"
		[+] // // WPFComboBox WhereDidYouPurchaseQuicken
			[ ] // // locator "@automationId='cb_purchase'"
		[ ] // // //Fourth Page of Quicken Connected Services Log In Process
		[+] // // WPFPasswordBox VaultPassword
			[ ] // // locator "Password must be 6 characters in length"
		[+] // // WPFButton SkipThisStep
			[ ] // // locator "Skip this step"
		[ ] // // //Final Page of Quicken Connected Services Log In Process
		[+] // // WPFButton GetBackToQuicken
			[ ] // // locator "Get back to Quicken"
		[ ] // // //Page In case of using an existing ID
		[+] // // WPFPasswordBox PasswordExisting
			[ ] // // locator "//WPFPasswordBox"
			[ ] // // 
		[ ] // // //Password Valut condition in case of Registered User
		[+] // // WPFTextBlock YourPersonalPasswordVault
			[ ] // // locator "Your Personal Password Vault"
		[+] // // WPFPasswordBox PasswordVaultpassword
			[ ] // // locator "@automationId='tb_password'"
		[+] // // WPFPasswordBox PasswordsMustMatch
			[ ] // // locator "Passwords must match."
		[ ] // // 
		[ ] // // 
		[ ] // // 
	[ ] // // 
	[ ] // // 
	[ ] // // 
[ ] 
[ ] //----------Quicken Connected Services / IAM Registration--------
[+] // window WPFWindow QuickenConnectedServices
	[ ] // //locator "Quicken Connected Services"
	[ ] // locator "Quicken Cloud Services"
	[ ] // //First Page of Quicken Connected Services Log In Process
	[+] // WPFButton Later
		[ ] // locator "Later"
	[+] // WPFButton LetsGo
		[ ] // locator "Let's Go"
	[ ] // 
	[+] // WPFContentControl SignUp
		[ ] // //locator "Quicken Cloud Services"
		[ ] // locator "Sign Up to Access Quicken Cloud Services"
		[ ] // 
		[ ] // //Second Page of Quicken Connected Services Log In Process
		[+] // WPFTextBox EmailID
			[ ] // locator "@automationId='tb_email'"
		[+] // // WPFTextBox ExistingUserName
			[ ] // // locator "@automationId='tb_username'"
		[ ] // 
		[+] // WPFPasswordBox Password
			[ ] // locator "@automationId='pb_password'"
		[+] // WPFPasswordBox ConfirmPassword
			[ ] // locator "@automationId='pb_confirmed'"
		[+] // WPFComboBox SecurityQuestion
			[ ] // locator "//WPFComboBox"
		[+] // WPFTextBox SecurityQuestionAnswer
			[ ] // locator "@automationId='tb_answer'"
		[+] // WPFButton SignIn
			[ ] // locator "Sign In"
		[+] // WPFButton Later
			[ ] // locator "Later"
		[+] // WPFButton Back
			[ ] // locator "Back"
		[+] // WPFButton NextButton
			[ ] // locator "Next"
		[ ] // //Third Page of Quicken Connected Services Log In Process
		[+] // WPFTextBox Name
			[ ] // locator "@automationId='tb_fname'"
		[+] // WPFTextBox LastName
			[ ] // locator "@automationId='tb_LName'"
		[+] // WPFTextBox Address
			[ ] // locator "@automationId='tb_Address'"
		[+] // WPFTextBox City
			[ ] // locator "@automationId='tb_city'"
		[+] // WPFComboBox State
			[ ] // locator "@automationId='tb_state'"
		[+] // WPFTextBox Zip
			[ ] // locator "@automationId='tb_zip'"
		[+] // WPFTextBox Phone
			[ ] // locator "[6]"
		[+] // WPFCheckBox Quicken
			[ ] // locator "Quicken"
		[+] // WPFCheckBox Mint
			[ ] // locator "Mint"
		[+] // WPFCheckBox OnlineBanking
			[ ] // locator "Online Banking"
		[+] // WPFCheckBox Spreadsheet
			[ ] // locator "Spreadsheet"
		[+] // WPFCheckBox PaperStatements
			[ ] // locator "Paper Statements"
		[+] // WPFCheckBox MicrosoftMoney
			[ ] // locator "Microsoft Money"
		[+] // WPFCheckBox OtherSoftware
			[ ] // locator "Other Software"
		[+] // WPFCheckBox NoOtherMethod
			[ ] // locator "No other Method"
		[+] // WPFComboBox WhereDidYouPurchaseQuicken
			[ ] // locator "@automationId='cb_purchase'"
		[ ] // //Fourth Page of Quicken Connected Services Log In Process
		[ ] // //Final Page of Quicken Connected Services Log In Process
		[ ] // //Page In case of using an existing ID
		[ ] // //Password Valut condition in case of Registered User
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
	[+] // WPFContentControl SignIn
		[ ] // //locator "Quicken Cloud Services"
		[ ] // locator "Sign In"
		[+] // WPFTextBox ExistingUserName
			[ ] // locator "@automationId='tb_username'"
		[+] // WPFPasswordBox Password
			[ ] // locator "@automationId='pb_password'"
		[+] // WPFButton NextButton
			[ ] // locator "Next"
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
	[+] // WPFContentControl PasswordVault
		[ ] // locator "Your Personal Password Vault"
		[+] // // WPFTextBlock YourPersonalPasswordVault
			[ ] // // locator "Your Personal Password Vault"
		[+] // WPFPasswordBox PasswordVaultpassword
			[ ] // locator "@automationId='tb_password'"
		[+] // WPFPasswordBox PasswordsMustMatch
			[ ] // locator "Passwords must match."
			[ ] // 
		[+] // WPFPasswordBox VaultPassword
			[ ] // locator "Password must be 6 characters in length"
		[+] // WPFButton SkipThisStep
			[ ] // locator "Skip this step"
		[+] // WPFButton NextButton
			[ ] // locator "Next"
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
	[+] // WPFContentControl DonePage
		[ ] // locator "Thanks !"
		[+] // WPFButton GetBackToQuicken
			[ ] // locator "Get back to Quicken"
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
[ ] 
[ ] 
[ ] //----------Quicken Connected Services / IAM Registration--------till 23.1.1.11
[+] // window WPFWindow QuickenConnectedServices
	[ ] // locator "'Activate Quicken'"
	[ ] // //First Page of Quicken Connected Services Log In Process
	[+] // WPFButton Later
		[ ] // locator "Later"
	[+] // WPFButton LetsGo
		[ ] // locator "Let's Go"
	[+] // WPFContentControl SignUp
		[ ] // //locator "Quicken Cloud Services"
		[ ] // locator "Sign Up to Access Quicken Cloud Services"
		[ ] // 
		[ ] // //Second Page of Quicken Connected Services Log In Process
		[+] // WPFTextBox EmailID
			[ ] // locator "@automationId='tb_email'"
		[+] // // WPFTextBox ExistingUserName
			[ ] // // locator "@automationId='tb_username'"
		[ ] // 
		[+] // WPFPasswordBox Password
			[ ] // locator "@automationId='pb_password'"
		[+] // WPFPasswordBox ConfirmPassword
			[ ] // locator "@automationId='pb_confirmed'"
		[+] // WPFComboBox SecurityQuestion
			[ ] // locator "//WPFComboBox"
		[+] // WPFTextBox SecurityQuestionAnswer
			[ ] // locator "@automationId='tb_answer'"
		[+] // WPFButton SignIn
			[ ] // locator "Sign In"
		[+] // WPFButton Later
			[ ] // locator "Later"
		[+] // WPFButton Back
			[ ] // locator "Back"
		[+] // WPFButton NextButton
			[ ] // locator "Next"
		[ ] // //Third Page of Quicken Connected Services Log In Process
		[+] // WPFTextBox Name
			[ ] // locator "@automationId='tb_fname'"
		[+] // WPFTextBox LastName
			[ ] // locator "@automationId='tb_LName'"
		[+] // WPFTextBox Address
			[ ] // locator "@automationId='tb_Address'"
		[+] // WPFTextBox City
			[ ] // locator "@automationId='tb_city'"
		[+] // WPFComboBox State
			[ ] // locator "@automationId='tb_state'"
		[+] // WPFTextBox Zip
			[ ] // locator "@automationId='tb_zip'"
		[+] // WPFTextBox Phone
			[ ] // locator "[6]"
		[+] // WPFCheckBox Quicken
			[ ] // locator "Quicken"
		[+] // WPFCheckBox Mint
			[ ] // locator "Mint"
		[+] // WPFCheckBox OnlineBanking
			[ ] // locator "Online Banking"
		[+] // WPFCheckBox Spreadsheet
			[ ] // locator "Spreadsheet"
		[+] // WPFCheckBox PaperStatements
			[ ] // locator "Paper Statements"
		[+] // WPFCheckBox MicrosoftMoney
			[ ] // locator "Microsoft Money"
		[+] // WPFCheckBox OtherSoftware
			[ ] // locator "Other Software"
		[+] // WPFCheckBox NoOtherMethod
			[ ] // locator "No other Method"
		[+] // WPFComboBox WhereDidYouPurchaseQuicken
			[ ] // locator "@automationId='cb_purchase'"
		[ ] // //Fourth Page of Quicken Connected Services Log In Process
		[ ] // //Final Page of Quicken Connected Services Log In Process
		[ ] // //Page In case of using an existing ID
		[ ] // //Password Valut condition in case of Registered User
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
[+] // window WPFWindow SignUp
	[ ] // locator "Register Quicken"
	[ ] // 
	[+] // WPFContentControl SignUp
		[ ] // //locator "Quicken Cloud Services"
		[ ] // locator "Register Quicken"
		[ ] // 
		[ ] // //Second Page of Quicken Connected Services Log In Process
		[+] // WPFTextBox EmailID
			[ ] // locator "@automationId='tb_email'"
		[+] // // WPFTextBox ExistingUserName
			[ ] // // locator "@automationId='tb_username'"
		[ ] // 
		[+] // WPFPasswordBox Password
			[ ] // locator "@automationId='pb_password'"
		[+] // WPFPasswordBox ConfirmPassword
			[ ] // locator "@automationId='pb_confirmed'"
		[+] // WPFComboBox SecurityQuestion
			[ ] // locator "//WPFComboBox"
		[+] // WPFTextBox SecurityQuestionAnswer
			[ ] // locator "@automationId='tb_answer'"
		[+] // WPFButton SignIn
			[ ] // locator "Sign In"
		[+] // WPFButton Later
			[ ] // locator "Later"
		[+] // WPFButton Back
			[ ] // locator "Back"
		[+] // WPFButton NextButton
			[ ] // locator "Next"
		[ ] // //Third Page of Quicken Connected Services Log In Process
		[+] // WPFTextBox Name
			[ ] // locator "@automationId='tb_fname'"
		[+] // WPFTextBox LastName
			[ ] // locator "@automationId='tb_LName'"
		[+] // WPFTextBox Address
			[ ] // locator "@automationId='tb_Address'"
		[+] // WPFTextBox City
			[ ] // locator "@automationId='tb_city'"
		[+] // WPFComboBox State
			[ ] // locator "@automationId='tb_state'"
		[+] // WPFTextBox Zip
			[ ] // locator "@automationId='tb_zip'"
		[+] // WPFTextBox Phone
			[ ] // locator "[6]"
		[+] // WPFCheckBox Quicken
			[ ] // locator "Quicken"
		[+] // WPFCheckBox Mint
			[ ] // locator "Mint"
		[+] // WPFCheckBox OnlineBanking
			[ ] // locator "Online Banking"
		[+] // WPFCheckBox Spreadsheet
			[ ] // locator "Spreadsheet"
		[+] // WPFCheckBox PaperStatements
			[ ] // locator "Paper Statements"
		[+] // WPFCheckBox MicrosoftMoney
			[ ] // locator "Microsoft Money"
		[+] // WPFCheckBox OtherSoftware
			[ ] // locator "Other Software"
		[+] // WPFCheckBox NoOtherMethod
			[ ] // locator "No other Method"
		[+] // WPFComboBox WhereDidYouPurchaseQuicken
			[ ] // locator "@automationId='cb_purchase'"
		[ ] // //Fourth Page of Quicken Connected Services Log In Process
		[ ] // //Final Page of Quicken Connected Services Log In Process
		[ ] // //Page In case of using an existing ID
		[ ] // //Password Valut condition in case of Registered User
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
[+] // window WPFWindow SignIn
	[ ] // locator "*Sign In*"
	[+] // WPFContentControl SignIn
		[ ] // locator "Sign In with your Intuit ID"
		[+] // WPFTextBox ExistingUserName
			[ ] // locator "@automationId='tb_username'"
		[+] // WPFPasswordBox Password
			[ ] // locator "@automationId='pb_password'"
		[+] // WPFButton NextButton
			[ ] // locator "Next"
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
[+] // window WPFWindow PasswordVault
	[ ] // locator "*Password Vault*"
	[+] // WPFContentControl PasswordVault
		[ ] // locator "*Password Vault*"
		[+] // // WPFTextBlock YourPersonalPasswordVault
			[ ] // // locator "Your Personal Password Vault"
		[+] // WPFPasswordBox PasswordVaultpassword
			[ ] // locator "@automationId='tb_password'"
		[+] // WPFPasswordBox PasswordsMustMatch
			[ ] // locator "Passwords must match."
			[ ] // 
		[+] // WPFPasswordBox VaultPassword
			[ ] // locator "Password must be 6 characters in length"
		[+] // WPFButton SkipThisStep
			[ ] // locator "Skip this step"
		[+] // WPFButton NextButton
			[ ] // locator "Next"
		[ ] // 
		[ ] // 
		[ ] // 
[+] // window WPFWindow DonePage
	[ ] // locator "*Thanks !*"
	[+] // WPFContentControl DonePage
		[ ] // locator "Thanks !"
		[+] // WPFButton GetBackToQuicken
			[ ] // locator "Get back to Quicken"
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
[ ] //----------Quicken Connected Services / IAM Registration--------from 23.0.0142
[ ] //----------Quicken Connected Services / IAM Registration--------from 23.1.2.2
[ ] 
[+] window WPFWindow QuickenConnectedServices
	[ ] locator "[@caption='*Quicken Cloud Services' or @caption='Setup your Intuit ID to get connected']"
	[ ] //First Page of Quicken Connected Services Log In Process
	[+] WPFButton Later
		[ ] locator "*Use Quicken without connecting*"
	[+] WPFButton GetStarted
		[ ] locator "Get Started"
	[+] WPFContentControl SignUp
		[ ] locator "[@caption='*Quicken*' or @caption='*Intuit*']"
		[+] WPFTextBox EmailID
			[ ] locator "@automationId='tb_email'"
		[+] WPFTextBox ExistingUserName
			[ ] locator "@automationId='tb_username'"
		[+] WPFPasswordBox Password
			[ ] locator "@automationId='pb_password'"
		[+] WPFPasswordBox ConfirmPassword
			[ ] locator "@automationId='pb_confirmed'"
		[+] WPFComboBox SecurityQuestion
			[ ] locator "//WPFComboBox"
		[+] WPFTextBox SecurityQuestionAnswer
			[ ] locator "@automationId='tb_answer'"
		[+] WPFButton SignIn
			[ ] locator "Sign In"
		[+] WPFButton Later
			[ ] locator "Later"
		[+] WPFButton Back
			[ ] locator "Back"
		[+] WPFButton NextButton
			[ ] locator "Next"
		[ ] //Third Page of Quicken Connected Services Log In Process
		[+] WPFTextBox Name
			[ ] locator "@automationId='tb_fname'"
		[+] WPFTextBox LastName
			[ ] locator "@automationId='tb_LName'"
		[+] WPFTextBox Address
			[ ] locator "@automationId='tb_Address'"
		[+] WPFTextBox City
			[ ] locator "@automationId='tb_city'"
		[+] WPFComboBox State
			[ ] locator "@automationId='tb_state'"
		[+] WPFTextBox Zip
			[ ] locator "@automationId='tb_zip'"
		[+] WPFTextBox Phone
			[ ] locator "[6]"
		[+] WPFCheckBox Quicken
			[ ] locator "Quicken"
		[+] WPFCheckBox Mint
			[ ] locator "Mint"
		[+] WPFCheckBox OnlineBanking
			[ ] locator "Online Banking"
		[+] WPFCheckBox Spreadsheet
			[ ] locator "Spreadsheet"
		[+] WPFCheckBox PaperStatements
			[ ] locator "Paper Statements"
		[+] WPFCheckBox MicrosoftMoney
			[ ] locator "Microsoft Money"
		[+] WPFCheckBox OtherSoftware
			[ ] locator "Other Software"
		[+] WPFCheckBox NoOtherMethod
			[ ] locator "No other Method"
		[+] WPFComboBox WhereDidYouPurchaseQuicken
			[ ] locator "@automationId='cb_purchase'"
		[+] WPFButton Done
			[ ] locator "Done"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[+] window WPFWindow SignUp
	[ ] locator "Register Quicken"
	[ ] 
	[+] WPFContentControl SignUp
		[ ] locator "[@caption='*Quicken*' or @caption='*Intuit*']"
		[ ] //Second Page of Quicken Connected Services Log In Process
		[+] WPFTextBox EmailID
			[ ] locator "@automationId='tb_email'"
		[+] // WPFTextBox ExistingUserName
			[ ] // locator "@automationId='tb_username'"
		[ ] 
		[+] WPFPasswordBox Password
			[ ] locator "@automationId='pb_password'"
		[+] WPFPasswordBox ConfirmPassword
			[ ] locator "@automationId='pb_confirmed'"
		[+] WPFComboBox SecurityQuestion
			[ ] locator "//WPFComboBox"
		[+] WPFTextBox SecurityQuestionAnswer
			[ ] locator "@automationId='tb_answer'"
		[+] WPFButton SignIn
			[ ] locator "Sign In"
		[+] WPFButton Later
			[ ] locator "Later"
		[+] WPFButton Back
			[ ] locator "Back"
		[+] WPFButton NextButton
			[ ] locator "Next"
		[ ] //Third Page of Quicken Connected Services Log In Process
		[+] WPFTextBox Name
			[ ] locator "@automationId='tb_fname'"
		[+] WPFTextBox LastName
			[ ] locator "@automationId='tb_LName'"
		[+] WPFTextBox Address
			[ ] locator "@automationId='tb_Address'"
		[+] WPFTextBox City
			[ ] locator "@automationId='tb_city'"
		[+] WPFComboBox State
			[ ] locator "@automationId='tb_state'"
		[+] WPFTextBox Zip
			[ ] locator "@automationId='tb_zip'"
		[+] WPFTextBox Phone
			[ ] locator "[6]"
		[+] WPFCheckBox Quicken
			[ ] locator "Quicken"
		[+] WPFCheckBox Mint
			[ ] locator "Mint"
		[+] WPFCheckBox OnlineBanking
			[ ] locator "Online Banking"
		[+] WPFCheckBox Spreadsheet
			[ ] locator "Spreadsheet"
		[+] WPFCheckBox PaperStatements
			[ ] locator "Paper Statements"
		[+] WPFCheckBox MicrosoftMoney
			[ ] locator "Microsoft Money"
		[+] WPFCheckBox OtherSoftware
			[ ] locator "Other Software"
		[+] WPFCheckBox NoOtherMethod
			[ ] locator "No other Method"
		[+] WPFComboBox WhereDidYouPurchaseQuicken
			[ ] locator "@automationId='cb_purchase'"
		[ ] //Fourth Page of Quicken Connected Services Log In Process
		[ ] //Final Page of Quicken Connected Services Log In Process
		[ ] //Page In case of using an existing ID
		[ ] //Password Valut condition in case of Registered User
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[+] window WPFWindow SignIn
	[+] locator "*Sign In*"
		[ ] 
	[+] WPFContentControl SignIn
		[ ] locator "Sign In*"
		[+] WPFTextBox ExistingUserName
			[ ] locator "@automationId='tb_username' "
		[+] WPFPasswordBox Password
			[ ] locator "[@automationId='pb_password' or @automationId='UserPassword']"
		[+] WPFButton NextButton
			[ ] locator "Next"
		[+] WPFButton SignInButton // Added by Abhijit S, Mar 2015
			[ ] locator "@caption ='Sign In'"
		[ ] 
[+] window WPFWindow PasswordVault
	[ ] locator "*Password Vault*"
	[+] WPFContentControl PasswordVault
		[ ] locator "*Password Vault*"
		[+] // WPFTextBlock YourPersonalPasswordVault
			[ ] // locator "Your Personal Password Vault"
		[+] WPFPasswordBox PasswordVaultpassword
			[ ] locator "@automationId='tb_password'"
		[+] WPFPasswordBox PasswordsMustMatch
			[ ] locator "Passwords must match."
			[ ] 
		[+] WPFPasswordBox VaultPassword
			[ ] locator "Password must be 6 characters in length"
		[+] WPFButton SkipThisStep
			[ ] locator "Skip this step"
		[+] WPFButton NextButton
			[ ] locator "Next"
		[ ] 
		[ ] 
		[ ] 
[+] window WPFWindow DonePage
	[ ] locator "*Thanks*"
	[+] WPFContentControl DonePage
		[ ] locator "*You're ready to use Quicken*"
		[+] WPFButton GetBackToQuicken
			[ ] locator "Done"
		[+] WPFTextBlock IntuitIDValueText
			[ ] locator "*@*.*"
		[ ] 
	[+] WPFButton DoneButton
		[ ] locator "[@caption='Done' or @caption='Add Account']"
	[ ] 
[+] window MainWin SyncChangesToTheQuickenCloud				// Added on 16 dec 2013
	[ ] locator "Sync changes to the Quicken Cloud?"
	[+] CheckBox DontRemindMeToSync
		[ ] locator "Don't remind me to sync"
	[+] PushButton SyncNow
		[ ] locator "Sync now"
	[+] PushButton Exit
		[ ] locator "Exit"
	[+] PushButton Close
		[ ] locator "Close"
	[+] PushButton Later
		[ ] locator "Later"
	[ ] 
[+] window WPFWindow MobileAppRegistration
	[ ] locator "/WPFWindow[@caption='Mobile Ap*']"
	[+] WPFButton NextButton
		[ ] locator "//WPFButton[@caption='Next']"
	[+] WPFRadioButton UseMobileOption
		[ ] locator "//WPFRadioButton[@caption='Don’t use mobile']"
[+] window MainWin UpgradeToTheQuickenmobileApp				// Added on 16 dec 2013
	[ ] locator "Upgrade*"
	[+] PushButton CancelButton
		[ ] locator "Cancel"
[ ] 
[ ] //Sept 05 
[-] window WPFWindow QuickenIAMMainWindow
	[ ] locator "Quicken*"
	[ ] 
	[-] WPFUserControl IAMUserControl
		[ ] // locator "[@caption='*Quicken*' or @caption='*Intuit*' or @caption='*Successful*'or @caption='*Mobil*'or  @caption='*About*']"
		[ ] locator "[@caption='*Quicken*' or @caption='*Intuit*' or @caption='*Successful*'or @caption='*Mobil*'or  @caption='*About*' or @caption='Sign-in with your' or @caption='Create your']"
		[ ] 
		[-] WPFContentControl IAMContentControl 
			[ ] locator "[@caption='*Quicken*' or @caption='*Intuit*' or @caption='*Successful*'or @caption='*Mobil*'or  @caption='*About*' or @caption='Sign-in with your' or @caption='Create your']"
			[ ] 
			[ ] // locator "[@caption='*Quicken*' or @caption='*Intuit*' or @caption='*Successful*'or @caption='*Mobil*'or  @caption='*About*']"
			[+] WPFButton IamNew
				[ ] locator "*New"
				[ ] 
			[+] WPFTextBlock linkCreateOneHere
				[ ] locator "[@caption='Create one here']"
				[ ] 
			[+] WPFTextBlock linkSignInWithDifferentID //KG
				[ ] locator "[@caption='Create a new ID for your data file or Sign in with a different Intuit ID']"
				[ ] 
			[ ] 
			[+] WPFTextBox EmailID
				[ ] locator "@automationId='tb_email'"
			[+] WPFTextBox UserName
				[ ] locator "@automationId='tb_username'"
			[+] WPFPasswordBox UserPassword
				[ ] locator "@automationId='pb_password'"
			[ ] 
			[ ] 
			[+] WPFTextBox MobileNumber
				[ ] locator "//WPFTextBox[6]"
			[+] WPFPasswordBox Password
				[ ] locator "@automationId='pb_password'"
			[+] WPFPasswordBox ConfirmPassword
				[ ] locator "@automationId='pb_confirmed'"
			[+] WPFComboBox SecurityQuestion
				[ ] locator "//WPFComboBox"
			[+] WPFTextBox SecurityQuestionAnswer
				[ ] locator "@automationId='tb_answer'"
			[+] WPFButton SignIn
				[ ] locator "Sign In"
			[+] WPFButton Later
				[ ] locator "Later"
			[+] WPFButton Back
				[ ] locator "Back"
			[+] WPFButton NextButton
				[ ] locator "Next"
			[ ] //Existing user id
			[+] WPFTextBox ExistingUserName
				[ ] locator "@automationId='tb_username'"
			[ ] //Third Page of Quicken Connected Services Log In Process
			[+] WPFTextBox Name
				[ ] locator "@automationId='tb_fname'"
			[+] WPFTextBox LastName
				[ ] locator "@automationId='tb_LName'"
			[+] WPFTextBox Address
				[ ] locator "@automationId='tb_Address'"
			[+] WPFTextBox City
				[ ] locator "@automationId='tb_city'"
			[+] WPFComboBox State
				[ ] locator "@automationId='tb_state'"
			[+] WPFTextBox Zip
				[ ] locator "@automationId='tb_zip'"
			[+] WPFTextBox Phone
				[ ] locator "[6]"
			[+] WPFCheckBox Quicken
				[ ] locator "Quicken"
			[+] WPFCheckBox Mint
				[ ] locator "Mint"
			[+] WPFCheckBox OnlineBanking
				[ ] locator "Online Banking"
			[+] WPFCheckBox Spreadsheet
				[ ] locator "Spreadsheet"
			[+] WPFCheckBox PaperStatements
				[ ] locator "Paper Statements"
			[+] WPFCheckBox MicrosoftMoney
				[ ] locator "Microsoft Money"
			[+] WPFCheckBox OtherSoftware
				[ ] locator "Other Software"
			[+] WPFCheckBox NoOtherMethod
				[ ] locator "No other Method"
			[+] WPFComboBox WhereDidYouPurchaseQuicken
				[ ] locator "@automationId='cb_purchase'"
			[+] WPFTextBlock CompleteProfile					//Added Jayashree Nagaraja, 8th Apr, 2015
				[ ] locator "@caption='Complete your Intuit Profile'"
			[ ] //LastPage Done
			[ ] 
			[+] WPFButton Done
				[ ] locator "Done"
			[ ] 
			[ ] //PasswordVault
			[+] WPFPasswordBox PasswordVaultpassword
				[ ] locator "@automationId='tb_password'"
			[+] WPFPasswordBox PasswordsMustMatch
				[ ] locator "Passwords must match."
				[ ] 
			[+] WPFPasswordBox VaultPassword
				[ ] locator "Password must be 6 characters in length"
			[+] WPFButton SkipThisStep
				[ ] locator "Skip this step"
			[+] WPFRadioButton UseMobileOption
				[ ] locator "//WPFRadioButton[@caption='Don’t use mobile']"
			[+] WPFButton AddAccount
				[ ] locator "Add Account"
			[+] WPFButton Upgrade
				[ ] locator "Upgrade"
			[+] WPFTextBlock RegistrationStatus
				[ ] locator "[@caption='Registration Successful']"
			[ ] 
			[+] WPFRadioButton UseExistingDataFilePasswordOption
				[ ] locator "@automationId='rb_OIPAsDataFilePwd'" 
			[+] WPFRadioButton UseIntuitIDDataFilePasswordOption
				[ ] locator "//WPFRadioButton[2]"
			[-] WPFControl webBrowser
				[ ] locator "//WPFControl[@name='webBrowser']"
			[ ] 
			[ ] 
			[ ] 
			[ ] 
	[+] Control Chrome_RenderWidgetHostHWND
		[ ] locator "//Control[@automationId='PART_Presenter']//Control[@windowClassName='Chrome_RenderWidgetHostHWND']"
	[ ] 
[+] window WPFWindow QuickenIAMGetStarted
	[ ] locator "Quicken*"
	[+] WPFTextBlock SelectYourExisitingDataFileToGetStartedTextBlock
		[ ] locator "Select your exisiting data file to get started"
	[+] WPFRadioButton OpenaDataFileLocatedOnThisComputer
		[ ] locator "Open a data file located on this computer"
	[+] WPFRadioButton RestoreaDataFileIVeBackedUpToaCDToaDiskOrOnline
		[ ] locator "Restore a data file I've backed up to a CD, to a disk, or online"
	[+] WPFRadioButton StartOverAndCreateaNewDataFile
		[ ] locator "Start over and create a new data file"
	[+] WPFButton GetStarted
		[ ] locator "Get Started"
	[+] WPFButton AddAccount
		[ ] locator "Add Account"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] window WPFWindow DlgIAMSignIn
	[ ] locator "Sign In*"
	[ ] 
	[+] WPFTextBlock IntuitIdText
		[ ] locator "*.intuit.com"
	[+] WPFPasswordBox IntuitPasswordTextBox
		[ ] locator "//WPFPasswordBox"
	[+] WPFButton LoginButton
		[ ] locator "Sign In"
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] window MainWin DlgReplaceExistingID
	[ ] locator "A Cloud Account already exists for this Intuit ID"
	[+] PushButton YesButton
		[ ] locator "Yes"
	[+] PushButton NoButton
		[ ] locator "No"
	[ ] 
[ ] 
[+] window DialogBox QuickenTSM
	[ ] locator "//DialogBox"
	[+] CheckBox RemindMeLater
		[ ] locator "@windowid='1002'"
	[+] Control Panel
		[ ] locator "@windowid='-1'"
		[+] Control QWMsHtmlVw1
			[ ] locator "@windowid='1000'"
			[+] Control ShellEmbedding1
				[ ] locator "@windowid='0'"
				[+] Control ShellDocObjectView1
					[ ] locator "@windowid='0'"
					[+] Control InternetExplorer_Server1
						[ ] locator "@windowid='0'"
[ ] 
[ ] // Quciken SKU upgrade window
[+] window MainWin QuickenUpgrade
	[ ]  locator "Upgrade Quicken"
	[+] PushButton Cancel
		[ ] locator "Cancel"
[ ] 
[ ] 
[+] window DialogBox CreateMemorizedPayee 	
	[+] StaticText CreateMemorizedPayeeText
		[ ] locator "@windowid='32702'"
	[+] StaticText PayeeNameText
		[ ] locator "@windowid='10301'"
	[+] TextField CreateMemorizedPayeeTextField
		[ ] locator "@windowid='10202'"
	[+] PushButton Address
		[ ] locator "@windowid='10208'"
	[+] Control PayeeName
		[ ] locator "@windowid='10218'"
	[+] StaticText TheInformationBelowWillBe1
		[ ] locator "@windowid='10220'"
	[+] Control TheInformationBelowWillBe2
		[ ] locator "@windowid='10219'"
	[+] StaticText TypeOfTransactionText
		[ ] locator "@windowid='10307'"
	[+] ComboBox TypeOfTransactionPopupList
		[ ] locator "@windowid='10210'"
	[+] StaticText CategoryText
		[ ] locator "@windowid='10306'"
	[+] TextField CategoryTextField
		[+] locator "@windowid='10204'"
			[ ] 
	[+] PushButton Split
		[ ] locator "@windowid='10207'"
	[+] StaticText TagText
		[ ] locator "@windowid='10216'"
	[+] TextField TagTextField
		[ ] locator "@windowid='10217'"
	[+] StaticText MemoText
		[ ] locator "@windowid='10302'"
	[+] TextField MemoTextField
		[ ] locator "@windowid='10203'"
	[+] StaticText AmountText
		[ ] locator "@windowid='10303'"
	[+] TextField AmountTextField
		[ ] locator "@windowid='10205'"
	[+] CheckBox MarkAsClearedCheckBox
		[+] locator "@windowid='255'"
			[ ] 
	[+] CheckBox NeverAutoCategorizeThisPayCheckBox
		[ ] locator "@windowid='257'"
	[+] CheckBox LockAndLeaveThisPayeeUnchCheckBox
		[ ] locator "@windowid='258'"
	[+] CheckBox ShowThisPayeeInTheCalendaCheckBox
		[ ] locator "@windowid='259'"
	[+] StaticText TipItSOKToLeaveTheCate1
		[ ] locator "@windowid='10221'"
	[+] Control TipItSOKToLeaveTheCate2
		[ ] locator "@windowid='32704'"
	[+] PushButton OKButton
		[ ] locator "@windowid='32767'"
	[+] PushButton CancelButton
		[ ] locator "@windowid='32766'"
	[+] PushButton TipItSOKToLeaveTheCate3
		[ ] locator "@windowid='0'"
	[+] PushButton EditRenamingRule
		[ ] locator "@windowid='260'"
	[+] Control TheInformationBelowWillBe4
		[ ] locator "@windowid='2020'"
		[+] PushButton QC_button2
			[ ] locator "@windowid='1124'"
		[+] PushButton QC_button1
			[ ] locator "@windowid='1128'"
	[+] Control QFBag1
		[ ] locator "@windowid='2020'"
		[+] PushButton QC_button2
			[ ] locator "@windowid='1124'"
		[+] PushButton QC_button1
			[ ] locator "@windowid='1128'"
	[+] Control Amount2
		[ ] locator "@windowid='2020'"
		[+] PushButton QC_button2
			[ ] locator "@windowid='1124'"
		[+] PushButton QC_button1
			[ ] locator "@windowid='1128'"
[ ] 
[ ] // 05/21/2015 KalyanG: Added the dialog 
[+] window DialogBox dialogBoxToDismiss
	[ ] locator "//DialogBox"
	[ ] 
	[+] StaticText AreYouSureYouWantToCancel
		[ ] locator "Are you sure you want to cancel?"
	[+] PushButton buttonYes
		[ ] locator "Yes"
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] ///////////////Added By Shrivardhan////////////////////////////////////////////////////////////////////////////////////////////
[+]  window PushButton PushButton1
	[ ] locator "PushButton[1]"
[ ] 
[+] window PushButton Done
	[ ] locator "Done"
[ ] 
[+]  window PushButton Amount
	[ ] locator "Amount"
[ ] 
[+] window  PushButton Attachments
	[ ] locator "Attachments"
[ ] 
[+]  window PushButton Balance
	[ ] locator "Balance"
[ ] 
[+]  window PushButton Category
	[ ] locator "Category"
[ ] 
[+] window PushButton Check
	[ ] locator "Check #"
[ ] 
[+]  window PushButton Cleared
	[ ] locator "Cleared"
[ ] 
[+]  window PushButton xDate
	[ ] locator "Date"
[ ] 
[+]  window PushButton Deposit
	[ ] locator "Deposit"
[ ] 
[+]  window PushButton Expensed
	[ ] locator "Expensed"
[ ] 
[+]  window PushButton Flags
	[ ] locator "Flags"
[ ] 
[+]  window PushButton Memo
	[ ] locator "Memo"
[ ] 
[+]  window PushButton Notes
	[ ] locator "Notes"
[ ] 
[+]  window PushButton Payee
	[ ] locator "Payee"
[ ] 
[+]  window PushButton Payment
	[ ] locator "Payment"
[ ] 
[+]  window PushButton Status
	[ ] locator "Status"
[ ] 
[+]  window PushButton Tag
	[ ] locator "Tag"
[ ] 
[+]  window PushButton TaxLineItem
	[ ] locator "Tax Line-item"
[ ] 
[+]  window PushButton TaxRelated
	[ ] locator "Tax-related"
[ ] 
[+]  window PushButton DownloadedAmount
	[ ] locator "Downloaded Amount"
[ ] 
[+]  window PushButton DownloadedID
	[ ] locator "Downloaded ID"
[ ] 
[+]  window PushButton DownloadedMemo
	[ ] locator "Downloaded Memo"
[ ] 
[+]  window PushButton DownloadedPayee
	[ ] locator "Downloaded Payee"
[ ] 
[+]  window PushButton DownloadedPostingDate
	[ ] locator "Downloaded Posting Date"
[ ] 
[+]  window PushButton DownloadedReference
	[ ] locator "Downloaded Reference"
[ ] 
[+]  window PushButton ActionButtons
	[ ] locator "Action Buttons"
[ ] 
[+] window BrowserApplication InternetExplorer
	[ ] locator "/BrowserApplication"
	[+] BrowserWindow BrowserWindow
		[ ] locator "/BrowserWindow"
		[+] DomElement Alert
			[ ] locator "//DIV[@id='oo_invitation_prompt']"
			[+] DomElement Close
				[ ] locator "[@text='Close Comment Card']"
		[+] DomElement textMapQuest
			[ ] locator "A[@id='topLogo' and @href='http://www.mapquest.com/']"
		[ ] 
	[+] DialogBox DlgInternetSettings
		[ ] locator "//DialogBox"
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] // *********************************************************
[ ] // Application states for Quicken Application
[ ] // *********************************************************
[ ] 
[-] appstate QuickenBaseState ()
	[ ] STRING sTempFile ="Temp.QDF"
	[ ] STRING sFileWithPath = AUT_DATAFILE_PATH + "\" + sTempFile + ".QDF"
	[ ] // string sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] STRING sConf_FilePath, sValue, sBlock, sKey
	[ ] sConf_FilePath = QUICKEN_CONFIG + "\Quicken.ini"
	[ ] handle hIni
	[ ] INTEGER iSetupAutoAPI
	[ ] 
	[ ] // Load O/S specific Paths and Variables
	[ ] LoadOSDependency()
	[ ] 
	[ ] 
	[ ] // Load SKU specific dependencies
	[ ] LoadSKUDependency()
	[ ] 
	[ ] sleep(SHORT_SLEEP)
	[ ] 
	[ ]  SetUp_AutoApi()
	[ ] 
	[+] // // update ini file
		[+] // if (FileExists(sConf_FilePath))
			[ ] // // Open File
			[ ] // hIni = SYS_IniFileOpen (sConf_FilePath)
			[ ] // // Set Values for keys
			[ ] // SYS_IniFileSetValue (hIni, "autopatch" , "PatchFatalError", "1")
			[ ] // // Close File
			[ ] // SYS_IniFileClose (hIni)
		[ ] // 
	[ ] 
	[ ] //########commented by mukesh suggested by Govind - 14/08/2012 #######To disable Qcards######################//
	[ ] sConf_FilePath=NULL
	[ ] sConf_FilePath=SYS_GetEnv("AllUserQuickenDirPath") + "\Inet\Common\Localweb\QCards\Overview_UserDefinedView_1\Deck1\Overview_UserDefinedView_1.ini"
	[ ] 
	[+] // update ini file
		[+] if (FileExists(sConf_FilePath))
			[ ] // Open File
			[ ] hIni = SYS_IniFileOpen (sConf_FilePath)
			[ ] // Set Values for keys
			[ ] SYS_IniFileSetValue (hIni, "2013" , "NumFiles", "0")
			[ ] // Close File
			[ ] SYS_IniFileClose (hIni)
			[ ] 
	[ ] sConf_FilePath=NULL
	[ ] sConf_FilePath=SYS_GetEnv("AllUserQuickenDirPath") + "\Inet\Common\Localweb\QCards\Quicken_AccountTransactions\Deck1\Quicken_AccountTransactions.ini"
	[ ] 
	[-] // update ini file
		[-] if (FileExists(sConf_FilePath))
			[ ] // Open File
			[ ] hIni = SYS_IniFileOpen (sConf_FilePath)
			[ ] // Set Values for keys
			[ ] SYS_IniFileSetValue (hIni, "2013" , "NumFiles", "0")
			[ ] // Close File
			[ ] SYS_IniFileClose (hIni)
			[ ] 
		[ ] // 
	[ ] // 
	[ ] // //########commented by mukesh suggested by Govind - 14/08/2012 #######To disable Qcards######################//
	[ ] 
	[ ] sleep (1)
	[ ] 
	[-] if(Incorrect_QuickenMainWin.Exists(3))
		[ ] Sys_Execute("taskkill /f /im qw.exe",NULL,EM_CONTINUE_RUNNING )
		[ ] sleep(5)
		[ ] 
	[+] if (!QuickenWindow.Exists(SHORT_SLEEP))
		[ ] App_Start (sCmdLine)
		[ ] sleep(20)
		[ ] 
	[+] if (LowScreenResolution.Exists(1))
		[ ] LowScreenResolution.SetActive()
		[ ] LowScreenResolution.Dontshowthisagain.Check()
		[ ] LowScreenResolution.OK.Click()
		[ ] WaitForState(LowScreenResolution,False,1)
	[+] if(Incorrect_QuickenMainWin.Exists(10))
		[ ] LaunchQuicken()
	[-] if (QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[+] // if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.IamNew.Exists(5))
			[ ] // RegisterQuickenConnectedServices()
		[ ] 
		[ ] 
		[ ] ////Coomented by Mukesh as this no longer seems to be needed curreently testing this on autolab March 29 2014
		[ ] ///this was needed for NavigateQuickenTab(sTAB_HOME)
		[ ] // sleep(2)
		[+] // if (QuickenIAMGetStarted.GetStarted.Exists() || QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists())
			[+] // if(FileExists(sFileWithPath))
				[ ] // OpenDataFile(sFile)
			[+] // else
				[ ] // DataFileCreate(sFile)
			[ ] // 
		[ ] // sleep(2)
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // // NavigateQuickenTab(sTAB_HOME)
		[ ] // ExpandAccountBar()
		[ ]  SetUp_AutoApi()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken launch", FAIL, "Quicken couldn't be launched")
	[ ] 
	[ ] 
[ ] 
[+] appstate BillsBaseState()
	[ ] 
	[ ] // string sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] 
	[ ] INTEGER iSetupAutoAPI
	[ ] 
	[ ] // Load O/S specific Paths and Variables
	[ ] LoadOSDependency()
	[ ] 
	[ ] sleep(SHORT_SLEEP)
	[ ] 
	[+] if (!QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.Kill()
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow, true , 10)
		[ ] 
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] ExpandAccountBar()
		[ ] sleep(2)
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken launch", FAIL, "Quicken couldn't be launched")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] appstate SmokeBaseState() basedon QuickenBaseState
	[ ] STRING sCaption
	[ ] BOOLEAN bCaption, bExists
	[ ] QuickenWindow.SetActive ()
	[ ] sCaption = QuickenWindow.GetCaption()
	[ ] bCaption = MatchStr("*Smoke Test*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists("{APP_PATH}\Data\TestData\Smoke Test.QDF")
		[+] if(bExists == FALSE)
			[ ] DataFileCreate("Smoke Test")
		[+] else
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[ ] OpenQuickenFile.SetActive ()
			[ ] //OpenQuickenFile.FileName.SetText ("Smoke Test")
			[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\" + "Smoke Test" + ".QDF")
			[ ] OpenQuickenFile.OK.Click ()
			[ ] QuickenWindow.SetActive ()
			[ ] // NavigateQuickenTab("Home")
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] UsePopUpRegister("OFF")
	[ ] // QuickenWindow.TypeKeys(KEY_ESC)
	[ ] sleep(SHORT_SLEEP)
[ ] 
[+] appstate PerformanceBaseState() basedon QuickenBaseState
	[ ] 
	[ ] STRING sCaption
	[ ] BOOLEAN bCaption, bExists
	[ ] 
	[ ] QuickenWindow.SetActive ()
	[ ] sCaption = QuickenWindow.GetCaption()
	[ ] bCaption = MatchStr("*{PerformanceDataFile}*", sCaption)
	[ ] 
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists("{APP_PATH}\Data\TestData\{PerformanceDataFile}.QDF")
		[+] if(bExists == FALSE)
			[ ] ReportStatus("Verify Performance data file",FAIL,"Copy data file {PerformanceDataFile}.QDF in {AUT_DATAFILE_PATH}")
		[+] else 
			[ ] QuickenWindow.File.Click()
			[ ] 
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[ ] 
			[ ] OpenQuickenFile.SetActive ()
			[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\" + PerformanceDataFile+ ".QDF")
			[ ] OpenQuickenFile.OK.Click ()
			[ ] QuickenWindow.SetActive ()
			[ ] CloseQuickenConnectedServices()
			[ ] NavigateQuickenTab("Home")
	[ ] sleep(SHORT_SLEEP)
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] sleep(SHORT_SLEEP)
	[ ] UsePopUpRegister("OFF")
[ ] 
[-] appstate NavigationBaseState() basedon none
	[-] // Variable declaration
		[ ] STRING sCaption,sPath
		[ ] BOOLEAN bCaption, bExists
		[ ] INTEGER iRegistration
		[ ] sPath= AUT_DATAFILE_PATH + "\DataFile"
	[ ] 
	[ ] SKU_TOBE_TESTED= LoadSKUDependency()
	[ ] QuickenWindow.SetActive ()
	[ ] sCaption = QuickenWindow.GetCaption()
	[-] if(SKU_TOBE_TESTED!="RPM")
		[ ] bCaption = MatchStr("*{RPMNavigationDataFile}*", sCaption)
		[-] if(bCaption == FALSE)
			[ ] bExists = FileExists("{APP_PATH}\Data\TestData\{RPMNavigationDataFile}.QDF")
			[-] if(bExists == FALSE)
				[ ] OpenDataFile_OII(RPMNavigationDataFile)
			[+] else
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.OpenQuickenFile.Select()
				[ ] 
				[ ] OpenQuickenFile.SetActive ()
				[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\DataFile\" + RPMNavigationDataFile+ ".QDF")
				[ ] OpenQuickenFile.OK.Click ()
				[ ] WaitForState(OpenQuickenFile , false ,2)
				[ ] QuickenWindow.SetActive ()
				[ ] NavigateQuickenTab(sTAB_HOME)
	[-] else
		[ ] bCaption = MatchStr("*{RPMNavigationDataFile}*", sCaption)
		[-] if(bCaption == FALSE)
			[ ] // bExists = FileExists("{APP_PATH}\Data\TestData\DataFile\{RPMNavigationDataFile}.QDF")
			[ ] // if(bExists == FALSE)
			[ ] OpenDataFile_OII(RPMNavigationDataFile,sPath)
			[+] // else
				[ ] // QuickenWindow.SetActive()
				[+] // do
					[ ] // QuickenWindow.File.Click()
					[ ] // QuickenWindow.File.OpenQuickenFile.Select()
				[+] // except
					[ ] // QuickenWindow.SetActive()
					[+] // do
						[ ] // QuickenWindow.TypeKeys(KEY_CTRL_O)
					[+] // except
						[+] // do
							[ ] // QuickenWindow.File.Click()
							[ ] // QuickenWindow.File.OpenQuickenFile.Select()
						[+] // except
							[ ] // QuickenWindow.MainMenu.Select("/_File/_Open Quicken File...")
					[ ] // 
				[ ] // 
				[ ] // OpenQuickenFile.SetActive ()
				[ ] // OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\DataFile\" + RPMNavigationDataFile+ ".QDF")
				[ ] // OpenQuickenFile.OK.Click ()
				[ ] // sleep(2)
				[ ] // SignInQuickenConnectedServices()
		[ ] 
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] iRegistration=BypassRegistration()
	[ ] // NavigateQuickenTab(sTAB_HOME)
	[ ] UsePopUpRegister("OFF")
[ ] 
[+] appstate QuickenRegistration() basedon QuickenBaseState
	[ ] STRING sCaption
	[ ] BOOLEAN bCaption,bExists
	[ ] QuickenWindow.SetActive ()
	[ ] sCaption = QuickenMainWindow.GetCaption()
	[ ] bCaption = MatchStr("*Quicken Registration*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists("{APP_PATH}\Data\TestData\Quicken Registration.QDF")
		[+] if(bExists == FALSE)
			[ ] DataFileCreate("Quicken Registration")
		[+] else
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[ ] OpenQuickenFile.SetActive ()
			[ ] //OpenQuickenFile.FileName.SetText ("Smoke Test")
			[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\" + "Quicken Registration" + ".QDF")
			[ ] OpenQuickenFile.OK.Click ()
			[ ] QuickenWindow.SetActive ()
			[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
[ ] 
[+] appstate HiddenAccountBaseState() basedon QuickenBaseState
	[+] // Variable declaration
		[ ] STRING sCaption
		[ ] BOOLEAN bCaption, bExists
		[ ] INTEGER iRegistration
		[ ] STRING sFileName = "HiddenAccountBanking"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
	[ ] 
	[ ] QuickenWindow.SetActive ()
	[ ] sCaption = QuickenMainWindow.GetCaption()
	[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists(sDataFile)
		[+] if(bExists == TRUE)
			[ ] DeleteFile(sDataFile)
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] OpenDataFile(sFileName)
		[+] else
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] OpenDataFile(sFileName)
	[ ] QuickenWindow.SetActive ()
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] iRegistration=BypassRegistration()
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] UsePopUpRegister("OFF")
	[ ] 
[ ] 
[+] appstate RPMBaseState() basedon none
	[ ] STRING sCaption
	[ ] BOOLEAN bCaption, bExists
	[ ] INTEGER iSetupAutoAPI
	[ ] STRING sFileName="RPM_Test"
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] 
	[ ] QuickenWindow.SetActive ()
	[ ] sCaption = QuickenWindow.GetCaption()
	[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
	[-] if(bCaption == FALSE)
		[ ] bExists = FileExists("{APP_PATH}\Data\TestData\{sFileName}.QDF")
		[+] if(bExists == FALSE)
			[ ] DataFileCreate(sFileName)
		[-] else
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select ()
			[ ] OpenQuickenFile.SetActive ()
			[ ] //OpenQuickenFile.FileName.SetText ("Smoke Test")
			[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\" + sFileName + ".QDF")
			[ ] OpenQuickenFile.OK.Click ()
			[ ] QuickenWindow.SetActive ()
			[ ] ExpandAccountBar()
	[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_RENT_CENTER)
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] UsePopUpRegister("OFF")
	[ ] sleep(SHORT_SLEEP)
[ ] 
[+] appstate ClosedSeparateAccountTaxCenter() basedon QuickenBaseState
	[ ] STRING sCaption
	[ ] BOOLEAN bCaption, bExists
	[ ] INTEGER iSetupAutoAPI
	[ ] STRING sFileName="ClosedSeparateAccountTaxCenter"
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] 
	[ ] QuickenWindow.SetActive ()
	[ ] sCaption = QuickenMainWindow.GetCaption()
	[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists("{APP_PATH}\Data\TestData\{sFileName}.QDF")
		[+] if(bExists == FALSE)
			[ ] DataFileCreate(sFileName)
		[+] else
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[ ] OpenQuickenFile.SetActive ()
			[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\" + sFileName + ".QDF")
			[ ] OpenQuickenFile.OK.Click ()
			[ ] QuickenWindow.SetActive ()
	[ ] ExpandAccountBar()
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] UsePopUpRegister("OFF")
	[ ] sleep(SHORT_SLEEP)
[ ] 
[+] appstate DataSyncBaseState () basedon QuickenBaseState
	[ ] STRING sFileName = "EWCDataFile"
	[ ] STRING sSyncResultFile="SyncResult"
	[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\Data Sync\" + sFileName + ".QDF"
	[ ] STRING sOriginalDataFile = AUT_DATAFILE_PATH + "\DataSyncTestData\" + sFileName + ".QDF"
	[ ] STRING sOriginalSyncResultFile = AUT_DATAFILE_PATH + "\DataSyncTestData\" + sSyncResultFile + ".xls"
	[ ] STRING sCopiedSyncResultFile =AUT_DATAFILE_PATH + "\" + sSyncResultFile+".xls"
	[ ] STRING sSyncLogFile = AUT_DATAFILE_PATH + "\Data Sync\" + sFileName +"_SyncLog.dat"
	[ ] STRING sDataFileLocation = AUT_DATAFILE_PATH + "\Data Sync" 
	[ ] // STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] // Variable declaration
	[ ] INTEGER iSetupAutoAPI
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] /////Delete the existing file/////
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[+] if(FileExists(sSyncLogFile))
		[ ] DeleteFile(sSyncLogFile)
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[+] if (iSetupAutoAPI==0)
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[+] else
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup unsuccessful.") 
		[ ] 
	[ ] 
	[ ] // SetUp_StageMiniConfig()
	[ ] 
	[ ] // Open data file
	[ ] 
	[+] if(FileExists(sDataFile))
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.Kill()
		[ ] Waitforstate(QuickenWindow,False,5)
		[ ] DeleteFile(sDataFile)
	[ ] SYS_CopyFile (sOriginalDataFile,sDataFile)
	[ ] 
	[ ] //copy Syncresult file to TestData folder
	[ ] 
	[+] if(FileExists(sCopiedSyncResultFile))
		[ ] DeleteFile(sCopiedSyncResultFile)
	[ ] SYS_CopyFile (sOriginalSyncResultFile,sCopiedSyncResultFile)
	[ ] 
	[+] if (!QuickenWindow.Exists(3))
		[ ] App_Start(sCmdLine)
		[ ] sleep(20)
	[+] if (QuickenWindow.Exists(15))
		[ ] QuickenWindow.SetActive()
		[ ] sleep(1)
		[ ] QuickenWindow.Maximize()
		[ ] sleep(1)
		[ ] OpenDataFile(sFileName,sDataFileLocation)
		[ ] 
	[ ] // Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] // Bypass Registration
	[ ] BypassRegistration()
	[ ] // Select Home tab
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] // Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] 
	[ ] 
[ ] 
[+] appstate DataSyncDcAccountBaseState () basedon QuickenBaseState
	[ ] STRING sFileName = "DCDataFile"
	[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\Data Sync\" + sFileName + ".QDF"
	[ ] STRING sOriginalDataFile = AUT_DATAFILE_PATH + "\DataSyncTestData\" + sFileName + ".QDF"
	[ ] STRING sSyncLogFile = AUT_DATAFILE_PATH + "\Data Sync\" + sFileName +"_SyncLog.dat"
	[ ] STRING sDataFileLocation = AUT_DATAFILE_PATH + "\Data Sync" 
	[ ] // STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] STRING sSyncResultFile="SyncResult"
	[ ] STRING sOriginalSyncResultFile = AUT_DATAFILE_PATH + "\DataSyncTestData\" + sSyncResultFile + ".xls"
	[ ] STRING sCopiedSyncResultFile =AUT_DATAFILE_PATH + "\" + sSyncResultFile+".xls"
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iSetupAutoAPI
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] /////Delete the existing file/////
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[+] if(FileExists(sSyncLogFile))
		[ ] DeleteFile(sSyncLogFile)
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[+] if (iSetupAutoAPI==0)
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[+] else
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup unsuccessful.") 
		[ ] 
	[ ] 
	[ ] // iMobileSetup=SetUp_StageMiniConfig()
	[ ] // ReportStatus("Stagemini Setup",iMobileSetup,"StageMini Setup done" )
	[ ] 
	[ ] // Open data file
	[ ] 
	[+] if(FileExists(sDataFile))
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.Kill()
		[ ] Waitforstate(QuickenWindow,False,5)
		[ ] DeleteFile(sDataFile)
	[ ] SYS_CopyFile (sOriginalDataFile,sDataFile)
	[ ] //copy Syncresult file to TestData folder
	[ ] 
	[+] if(FileExists(sCopiedSyncResultFile))
		[ ] DeleteFile(sCopiedSyncResultFile)
	[ ] SYS_CopyFile (sOriginalSyncResultFile,sCopiedSyncResultFile)
	[+] if (!QuickenWindow.Exists(3))
		[ ] App_Start(sCmdLine)
		[ ] 
	[+] if (QuickenWindow.Exists(15))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Maximize()
		[ ] sleep(1)
		[ ] OpenDataFile(sFileName,sDataFileLocation)
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] // Bypass Registration
	[ ] BypassRegistration()
	[ ] // Select Home tab
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] // Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] 
	[ ] 
[ ] 
[+] appstate RegisterBaseState() basedon QuickenBaseState
	[ ] 
	[ ] STRING sRegisterDataFile="Register"
	[ ] STRING sCaption
	[ ] BOOLEAN bCaption, bExists
	[ ] QuickenWindow.SetActive ()
	[ ] sCaption = QuickenMainWindow.GetCaption()
	[ ] bCaption = MatchStr("*{sRegisterDataFile}*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists("{APP_PATH}\Data\TestData\{sRegisterDataFile}.QDF")
		[+] if(bExists == TRUE)
			[ ] OpenDataFile(sRegisterDataFile)
		[+] else
			[ ] ReportStatus("Register Base State",FAIL,"File Not found")
			[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[+] appstate NavigateToHomeTab() basedon QuickenBaseState
	[ ] QuickenWindow.SetActive()
	[ ] QuickenMainWindow.QWNavigator.Home.DoubleClick ()
[ ] 
[+] appstate CurrencyListBaseState() basedon QuickenBaseState
	[ ] STRING sCaption
	[ ] BOOLEAN bCaption, bExists, bCheckStatus
	[ ] INTEGER iSetupAutoAPI
	[ ] STRING sFileName="CURRENCYLIST_Test"
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] QuickenWindow.SetActive ()
	[ ] sCaption = QuickenWindow.GetCaption()
	[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists("{APP_PATH}\Data\TestData\{sFileName}.QDF")
		[+] if(bExists == FALSE)
			[ ] DeleteFile(sFileName)
			[ ] DataFileCreate(sTestCaseStatusFile)
		[+] else
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select ()
			[ ] OpenQuickenFile.SetActive ()
			[ ] //OpenQuickenFile.FileName.SetText ("Smoke Test")
			[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\" + sFileName + ".QDF")
			[ ] OpenQuickenFile.OK.Click ()
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[ ] Preferences.SelectPreferenceType1.ListBox.Select(4)
		[ ] bCheckStatus = Preferences.MulticurrencySupport.IsChecked()
		[+] if(bCheckStatus == 	TRUE)
			[ ] Preferences.OK.Click()
		[+] else
			[ ] Preferences.MulticurrencySupport.Check()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,4)
			[ ] sleep(SHORT_SLEEP)
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[+] if(CurrencyList.Exists(10))
			[ ] CurrencyList.SetActive()
			[ ] CurrencyList.ListBox.Select(36)
			[ ] CurrencyList.Home.Click()
			[ ] CurrencyList.HomeSetConfirmation.OK.Click()
			[ ] CurrencyList.Done.Click()
[ ] 
[+] appstate MemorizedPayeeBaseState()basedon QuickenBaseState
	[ ] STRING sCaption
	[ ] STRING sFileName="MEMORIZEDPAYEE_Test"
	[ ] BOOLEAN bCaption,bExists
	[ ] INTEGER iSetupAutoAPI=SetUp_AutoApi()
	[ ] QuickenWindow.SetActive()
	[ ] sCaption=QuickenWindow.GetCaption()
	[ ] bCaption=Matchstr("*{sFileName}*",sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists("{APP_PATH}\Data\TestData\{sFileName}.QDF")
		[+] if(bExists == FALSE)
			[ ] DataFileCreate(sFileName)
		[+] else
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[ ] OpenQuickenFile.SetActive ()
			[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\" + sFileName + ".QDF")
			[ ] OpenQuickenFile.OK.Click ()
			[ ] QuickenWindow.SetActive ()
		[ ] 
	[ ] 
[+] appstate QuickenExceptionBaseState ()
	[+] if(QuickenException.Exists())
		[ ] Sys_Execute("taskkill /f /im qw.exe",NULL,EM_CONTINUE_RUNNING )
		[ ] LaunchQuicken()
		[ ] ExpandAccountBar()
		[ ] 
	[ ] print("PF")
[+] appstate MileageTracker() basedon QuickenBaseState
	[ ] 
	[ ] STRING sFileName = "MileageTracker"
	[ ] QuickenWindow.SetActive()
	[ ] STRING sCaption = QuickenWindow.GetCaption()
	[ ] BOOLEAN bCaption = MatchStr("*{sFileName}*", sCaption)
	[ ] 
	[+] if (! bCaption)
		[+] if (! FileExists("{APP_PATH}\Data\TestData\{sFileName}.QDF"))
			[ ] DeleteFile(sFileName)
			[ ] DataFileCreate(sTestCaseStatusFile)
		[+] else
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select ()
			[ ] OpenQuickenFile.SetActive ()
			[ ] OpenQuickenFile.FileName.SetText (AUT_DATAFILE_PATH + "\" + sFileName + ".QDF")
			[ ] OpenQuickenFile.OK.Click ()
	[ ] 
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] UsePopUpRegister("OFF")
	[ ] sleep(SHORT_SLEEP)
[ ] 
[ ] 
