[ ] 
[ ] // add awesomium control under quicken window
[+] window MainWin QuickenWindow
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
		[+] WPFMenuItem Upcoming
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
[ ] 
[ ] // Kalyan: -hard work around for sign-in
[+] public INTEGER DataFileCreate(STRING sFileName,STRING sLocation optional, STRING sEmailID optional,STRING sPassword optional,STRING sSecurityQuestion optional,STRING sSecurityQuestionAnswer optional,STRING sName optional,STRING sLastName optional,STRING sAddress optional,STRING sCity optional,STRING sState optional, STRING sZip optional,STRING sBoughtFrom optional,STRING sVaultPassword optional ,STRING sMobileNumber optional)
	[ ] 
	[+] // Variable declaration
		[ ] STRING sCaption, sExpected, sFileWithPath
		[ ] BOOLEAN bAssert, bFound , bResult
		[ ] bResult=FALSE
		[ ] bMatch=FALSE
		[ ] INTEGER iResult
		[ ] 
		[+] if(sLocation==NULL)
			[ ] sFileWithPath = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[+] else
			[ ] sFileWithPath = sLocation + "\" + sFileName + ".QDF"
			[ ] 
		[ ] 
	[-] do
		[ ] 
		[+] if (!QuickenWindow.Exists())
			[ ] LaunchQuicken()
		[ ] 
		[-] if(QuickenWindow.Exists(20))
			[ ] QuickenWindow.SetActive()
			[ ] sCaption = QuickenWindow.GetCaption ()
			[ ] bFound = MatchStr("*{sFileName}*", sCaption)
			[+] if(FileExists(sFileWithPath))
				[+] if(bFound)
					[ ] //OpenDataFile("TempFile")
					[ ] 
				[ ] Sys_Execute("taskkill /f /im qw.exe",NULL,EM_CONTINUE_RUNNING )
				[ ] sleep(5)
				[ ] DeleteFile(sFileWithPath)
				[ ] LaunchQuicken()
			[ ] 
			[-] if(QuickenWindow.Exists(20))
				[ ] START:
				[+] do
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.TypeKeys("<Alt-f>")
					[ ] sleep(1)
					[ ] QuickenWindow.File.NewQuickenFile.Select()
				[+] except 
					[ ] QuickenWindow.File.Click()
					[ ] QuickenWindow.MainMenu.Select("/*File/_New Quicken File*")
				[ ] 
				[ ] ////CreateNewFile Dailog will appear if the file to be created doesn't exist and a file is already open //// 
				[ ] 
				[+] if (CreateNewFile.Exists(2))
					[ ] CreateNewFile.SetActive()
					[ ] CreateNewFile.OK.Click()
					[ ] 
					[ ] // Alert for online payments
					[+] if(AlertMessage.No.Exists(5))
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.No.Click()
					[ ] 
					[+] if(SyncChangesToTheQuickenCloud.Exists(3))
						[ ] SyncChangesToTheQuickenCloud.Later.Click()
						[ ] WaitForState(SyncChangesToTheQuickenCloud,FALSE,5)
					[ ] WaitForState(CreateNewFile,False,1)
				[-] if (ImportExportQuickenFile.Exists(10))
					[ ] ImportExportQuickenFile.SetActive()
					[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
					[ ] 
					[ ] ImportExportQuickenFile.OK.Click()
					[ ] 
					[ ] //Check for the already existing file
					[-] if (ImportExportQuickenFile.DuplicateFileMsg.Exists())
						[ ] ImportExportQuickenFile.DuplicateFileMsg.Close()
						[ ] ImportExportQuickenFile.Cancel.Click()
						[ ] ReportStatus("Data file existence", ABORT, "Data File {sFileName} already exists") 
					[ ] 
					[ ] 
					[+] // if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
						[ ] // // RegisterQuickenConnectedServices(sEmailID, sPassword, sSecurityQuestion, sSecurityQuestionAnswer, sName, sLastName, sAddress, sCity, sState, sZip, sBoughtFrom, sVaultPassword, sMobileNumber)
						[ ] // SignInQuickenConnectedServices()
						[ ] // 
						[ ] // 
						[ ] // bMatch=TRUE
					[ ] // 
					[+] // if (bMatch==FALSE)
						[ ] // SignInQuickenConnectedServices()
					[ ] 
					[ ] sleep(20)
					[+] if ! QuickenWindow.awesomium.Exists(10)
						[ ] Agent.DisplayMessage("Check","if widget is loaded, click Yes if loaded.. u may get one more silk dialog if ST doesnt sign-in..watch out..")
					[ ] QuickenWindow.awesomium.click(MB_RIGHT,5,62)
					[ ] QuickenWindow.awesomium.Typekeys("quicken_user@test.qbn.intuit.com")
					[ ] QuickenWindow.awesomium.Typekeys("<Tab>")
					[ ] sleep(1)
					[ ] QuickenWindow.awesomium.Typekeys("a123456b")
					[ ] QuickenWindow.awesomium.Typekeys("<Enter>")
					[ ] sleep(10)
					[ ] QuickenWindow.Typekeys("<Enter>")
					[ ] sleep(10)
					[ ] QuickenWindow.Typekeys("<Enter>")
					[ ] sleep(10)
					[+] if AddAccount.Exists(10)
						[ ] AddAccount.Cancel.Click()
						[ ] sleep(3)
					[+] do
						[ ] ExpandAccountBar()
					[+] except
						[ ] // do nothing
						[ ] 
					[ ] 
					[ ] 
					[-] if ! QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Exists()
						[ ] Agent.DisplayMessage("LOGIN","Silk unable to do proper signin, sign-in and click on OK")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] sCaption = QuickenWindow.GetCaption ()
					[ ] 
					[ ] bFound = MatchStr("*{sFileName}*", sCaption)
					[-] if(bFound == TRUE)
						[ ] iFunctionResult = PASS
						[ ] 
					[-] else
						[ ] iFunctionResult = FAIL
						[ ] ReportStatus("Verify Data file name", FAIL, "Data file name actual is: {sCaption} is NOT as expected: {sFileName}.") 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] ExpandAccountBar()
				[+] else
					[ ] ReportStatus("Verify Create New Quicken File", FAIL, "Create New Quicken File dailog didn't appear.") 
					[ ] iFunctionResult=FAIL
			[+] else
				[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] iFunctionResult = FAIL
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] iFunctionResult = FAIL
			[ ] 
	[+] except
		[ ] ExceptLog()
		[ ] // QuickenWindow.Kill()
		[ ] // WaitForState(QuickenWindow , FALSE ,5)
		[ ] // App_Start(sCmdLine)
		[ ] // WaitForState(QuickenWindow , TRUE ,10)
		[ ] 
		[+] if (ImportExportQuickenFile.Exists())
			[ ] ImportExportQuickenFile.Close()
			[ ] 
		[ ] iFunctionResult = FAIL
	[ ] 
	[ ] return iFunctionResult
[ ] 
