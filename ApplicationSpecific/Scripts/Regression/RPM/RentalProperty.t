[ ] // *********************************************************
[+] // FILE NAME:	<RentalProperty.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   <This script contains all RentalProperty test cases>
	[ ] //
	[ ] // DEPENDENCIES:	<include.inc>
	[ ] //
	[ ] // DEVELOPED BY:	Mukesh
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	
[ ] // *********************************************************
[ ] 
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[+] // ==========================================================
	[ ] // Variable Declaration
	[ ] // Variable Declaration
	[ ] LIST OF ANYTYPE lsAddAccount, lsExcelData, lsAddProperty,lsAddTenant,lsRent,lsReminder,lsExpense,lsTransaction
	[ ] LIST OF ANYTYPE lsMlgTrans, lsListBoxItems, lsCategorizedExpenses, lsSpendingByPayees
	[ ] INTEGER iAmount1, iAmount2, iAmount3, iAmountTotal, iAmount ,iResult 
	[ ] 
	[ ] public INTEGER iSetupAutoAPI ,iCounter,iSelect,iNavigate, iItemCount, iCount, iListCount , iReportRowsCount
	[ ] BOOLEAN bMatch
	[ ] STRING sTab, sItem 
	[ ] STRING sMDIWindow = "MDI"
	[ ] 
	[ ] STRING sFileName="RPM_Test"
	[ ] STRING sPastDateRentalFile="PastDataRentalFile"
	[ ] STRING sEmptyRentalFile="EmptyRental"
	[ ] public STRING sEmptyRentalDataFile = AUT_DATAFILE_PATH + "\" + sEmptyRentalFile + ".QDF"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] 
	[ ] public STRING sRentalData = "RentalProperty"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sPropertyWorksheet = "Property"
	[ ] public STRING sTenantWorksheet = "TenantDetails"
	[ ] public STRING sRentWorksheet = "RentDetails"
	[ ] public STRING sReminderSheet = "Reminder"
	[ ] public STRING sExpenseSheet = "Expense"
	[ ] public STRING sTransactionSheet = "CheckingTransaction"
	[ ] public STRING sOtherAccountWorksheet = "OtherAccounts"
	[ ] public STRING sRentalTransactionsSheet = "RentalTransactions" 
	[ ] public INTEGER  iAddAccount, iReportSelect
	[ ] public STRING sHandle,sExpReportTitle ,sAmountPaid,sDateIndex
	[ ] 
	[ ] 
	[ ] 
	[ ] BOOLEAN bAssert, bEnabled, bResult
	[ ] public STRING sActualErrorMsg ,sExpectedErrorMsg,sValidationText,hWnd,sExpected, sActual, sDateRange ,sCategory , sMemo
	[ ] public STRING sFaRAmountField , sActualDialogTitle,sExpectedLabel ,sExpDialogTitle ,sReminderStatus ,sTag , sAccountIntent
	[ ] public STRING sMsg1 ,sMsg2
	[ ] STRING sAmountCollected, sAmountReturned,sDateStamp
	[ ] STRING sSecurityDepositLiability="*Security Deposit Liability*"
	[ ] public STRING sYear ,sDay ,sMonth
	[ ] INTEGER  iSelectDate ,iYear
[ ] 
[+] //############# Rental Property  SetUp #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_RentalPropertySetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the  RPM_Test.QDF if it exists. It will setup the necessary pre-requisite for RPM tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 27, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[-] testcase Test1_RentalPropertySetUp() appstate RPMBaseState
	[ ] INTEGER iSetupAutoAPI
	[ ] 
	[ ] sAccountIntent="RENTAL"
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[+] //########Launch Quicken and open RPM_Test File######################//
		[ ] 
	[ ] 
	[ ] //SkipRegistration
	[ ] SkipRegistration()
	[ ] 
	[ ] iResult=DataFileCreate(sFileName)
	[+] if (iResult==PASS)
		[ ] 
		[ ] // //########Launched Quicken and opened RPM_Test File######################//
		[ ] 
		[ ] ExpandAccountBar()
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] //############## Create New Checking Account #####################################
		[ ] // Quicken is launched then Add Checking Account
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // Add Checking Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],sAccountIntent)
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
			[+] else
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] // Report Status if Quicken is not launched
		[+] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] //############## Added New Checking Account #####################################
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test2_RentalPropertyTabandButtonsVerification #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test2_RentalPropertyTabandButtonsVerification()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the tabs and buttons available on Rental Property screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 21, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test2_RentalPropertyTabandButtonsVerification() appstate RPMBaseState
	[+] // Variable Declaration
		[ ] LIST OF STRING  lsTabs = {sTAB_RENT_CENTER,sTAB_PROFIT_LOSS,sTAB_ACCOUNT_OVERVIEW,sTAB_CASH_FLOW}
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////###Tabs verification######///
		[+] for each sTab in lsTabs
			[ ] iNavigate=NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTab)
			[+] if (iNavigate==PASS)
				[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTab} ", PASS, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTab} displayed.") 
			[+] else
				[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTab} ", FAIL, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTab} Not displayed") 
				[ ] 
		[ ] ////###Buttons verification######///
		[ ] QuickenWindow.SetActive()
		[+] if (QuickenMainWindow.QWNavigator1.AddTransactions.Exists(5))
			[ ] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", PASS, "AddTransactions button exists on Rental Property screen.") 
		[+] else
			[ ] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", FAIL, "AddTransactions button does not exist on Rental Property screen.") 
		[+] if (QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(5))
			[ ] ReportStatus(" Verify Properties & Tenants button exists on Rental Property screen", PASS, "Properties & Tenants button exists on Rental Property screen.") 
		[+] else
			[ ] ReportStatus(" Verify Properties & Tenants button exists on Rental Property screen", FAIL, "Properties & Tenants button does not exist  on Rental Property screen.") 
		[+] if (QuickenMainWindow.QWNavigator1.Reports.Exists(5))
			[ ] ReportStatus(" Verify Reports button exists on Rental Property screen", PASS, "Reports button exists on Rental Property screen.") 
		[+] else
			[ ] ReportStatus(" Verify Reports button exists on Rental Property screen", FAIL, "Reports button does not exist on Rental Property screen.") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test3_VerifyRentCenterButtonsWhenNoPropertyAdded #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_VerifyRentCenterButtonsWhenNoPropertyAdded ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Enter Rent, Enter Expense,Enter Other Income  and Add Tenant buttons when no property is added
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Enter Rent, Enter Expense,Enter Other Income  and Add Tenant buttons		
		[ ] //						Fail		If error occurs while verifying Enter Rent, Enter Expense,Enter Other Income  and Add Tenant buttons
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 27, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test3_VerifyRentCenterButtonsWhenNoPropertyAdded() appstate RPMBaseState
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] iNavigate=NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_RENT_CENTER)
		[+] if (iNavigate==PASS)
			[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} ", PASS, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} displayed.") 
			[+] if (QuickenMainWindow.QWNavigator1.AddTransactions.Exists(5))
				[ ] //############## Verify Enter Rent button when no property is added############
				[ ] sMsg1="You don't have any rental properties in Quicken."
				[ ] sMsg2="To add a transaction, you need to have at least one rental property."
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
				[+] if (AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sValidationText=AlertMessage.MessageText.GetText()
					[ ] bMatch =MatchStr("*{sMsg1}*{sMsg2}*" , sValidationText)
					[+] if (bMatch)
						[ ] ReportStatus(" Verify Enter Rent button when no property is added", PASS, "Verify Enter Rent button when no property is added: Validation message: {sValidationText} appeared as expected: {sMsg1}{sMsg2}") 
					[+] else
						[ ] ReportStatus(" Verify Enter Rent button when no property is added", FAIL, "Verify Enter Rent button when no property is added: Validation message: {sValidationText} didn't appear as expected: {sMsg1}{sMsg2}") 
						[ ] 
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,False,1)
				[+] else
					[ ] ReportStatus(" Verify Enter Rent button when no property is added", FAIL, "Verify Enter Rent button when no property is added: Validation message not displayed.") 
					[ ] 
				[ ] //############## Verify Enter Expense button when no property is added############
				[ ] sMsg1="You don't have any rental properties in Quicken."
				[ ] sMsg2="To add a transaction, you need to have at least one rental property."
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(Replicate (KEY_DN, 2))	
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
				[+] if (AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sValidationText=AlertMessage.MessageText.GetText()
					[ ] bMatch =MatchStr("*{sMsg1}*{sMsg2}*" , sValidationText)
					[+] if (bMatch)
						[ ] ReportStatus(" Verify Enter Expense button when no property is added", PASS, "Verify Enter Expense button when no property is added: Validation message: {sValidationText} appeared as expected: {sMsg1}{sMsg2}") 
					[+] else
						[ ] ReportStatus(" Verify Enter Expense button when no property is added", FAIL, "Verify Enter Expense button when no property is added: Validation message: {sValidationText} didn't appear as expected: {sMsg1}{sMsg2}") 
						[ ] 
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,False,1)
				[+] else
					[ ] ReportStatus(" Verify Enter Expense button when no property is added", FAIL, "Verify Enter Expense button when no property is added: Validation message not displayed.") 
					[ ] 
				[ ] //############## Verify Enter Other Income button when no property is added############
				[ ] sMsg1="You don't have any rental properties in Quicken."
				[ ] sMsg2="To add a transaction, you need to have at least one rental property."
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(Replicate (KEY_DN, 3))	
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
				[+] if (AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sValidationText=AlertMessage.MessageText.GetText()
					[ ] bMatch =MatchStr("*{sMsg1}*{sMsg2}*" , sValidationText)
					[+] if (bMatch)
						[ ] ReportStatus(" Verify Enter Other Income button when no property is added", PASS, "Verify Enter Other Income button when no property is added: Validation message: {sValidationText} appeared as expected: {sMsg1}{sMsg2}") 
					[+] else
						[ ] ReportStatus(" Verify Enter Other Income button when no property is added", FAIL, "Verify Enter Other Income button when no property is added: Validation message: {sValidationText} didn't appear as expected: {sMsg1}{sMsg2}") 
						[ ] 
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,False,1)
				[+] else
					[ ] ReportStatus(" Verify Enter Other Income button when no property is added", FAIL, "Verify Enter Other Income button when no property is added: Validation message not displayed.") 
			[+] else
				[ ] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", FAIL, "AddTransactions button does not exist on Rental Property screen.") 
			[+] if (QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(5))
				[ ] //############## Verify Add Tenant button when no property is added############
				[ ] sMsg1="You do not have any property entered into Quicken."
				[ ] sMsg2="To add a tenant you need to have atleast one property."
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 3))	
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
				[+] if (AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sValidationText=AlertMessage.MessageText.GetText()
					[ ] bMatch =MatchStr("*{sMsg1}*{sMsg2}*" , sValidationText)
					[+] if (bMatch)
						[ ] ReportStatus(" Verify Add Tenant button when no property is added", PASS, "Verify Add Tenant button when no property is added: Validation message: {sValidationText} appeared as expected: {sMsg1}{sMsg2}") 
					[+] else
						[ ] ReportStatus(" Verify Add Tenant button when no property is added", FAIL, "Verify Add Tenant button when no property is added: Validation message: {sValidationText} didn't appear as expected: {sMsg1}{sMsg2}") 
						[ ] 
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,False,1)
				[+] else
					[ ] ReportStatus(" Verify Add Tenant button when no property is added", FAIL,  "Verify Add Tenant button when no property is added: Validation message not displayed.") 
			[+] else
				[ ] ReportStatus(" Verify Properties & Tenants button exists on Rental Property screen", FAIL, "Properties & Tenants button does not exist  on Rental Property screen.") 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // ********************************************************
[ ] 
[+] //############# Test4_VerifyEditProperty #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4_VerifyEditProperty ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Edit property of Rental property.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while editing property						
		[ ] //						Fail		If  property not edited	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 3, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test4_VerifyEditProperty() appstate RPMBaseState
	[ ] 
	[ ] // Read data from sPropertyWorksheet excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
			[ ] //############## Verify Edit and Delete buttons disabled in the Propertylist when no property is added############
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate (KEY_DN, 2))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] PropertyListTable.Edit.Exists(1)
			[+] if (PropertyListTable.Edit.IsEnabled())
				[ ] ReportStatus(" Verify Edit button disabled on PropertyList screen", FAIL, "Edit button enabled in the Propertylist when no property is added.") 
			[+] else
				[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", PASS, "Edit  button is disabled in the Propertylist when no property is added.") 
			[+] if (PropertyListTable.Delete.IsEnabled())
				[ ] ReportStatus(" Verify Delete button is disabled on PropertyList screen", FAIL, "Delete button enabled in the Propertylist when no property is added.") 
			[+] else
				[ ] ReportStatus(" Verify Delete button is enabled on PropertyList screen", PASS, "Delete button is disabled in the Propertylist when no property is added.") 
			[ ] 
			[+] if (PropertyListTable.Done.Exists(5))
				[ ] ReportStatus(" Verify Done button is enabled on PropertyList screen", PASS, "Done button enabled in the Propertylist when no property is added.") 
			[+] else
				[ ] ReportStatus(" Verify Done button is enabled on PropertyList screen", FAIL, "Done button is disabled in the Propertylist when no property is added.") 
			[+] if (PropertyListTable.New.Exists(5))
				[ ] ReportStatus(" Verify New button is enabled on PropertyList screen", PASS, "New button enabled in the Propertylist when no property is added.") 
			[+] else
				[ ] ReportStatus(" Verify New button is enabled on PropertyList screen", FAIL, "New button is disabled in the Propertylist when no property is added.") 
			[ ] 
			[ ] PropertyListTable.Done.Click()
			[ ] WaitForState(PropertyListTable,False,2)
			[ ] 
			[ ] //Add a property
			[ ] iFunctionResult=AddRentalProperty(lsAddProperty)
			[+] if (iFunctionResult==PASS)
				[ ] 
				[ ] //############## Verify Edit buttons enabled in the Propertylist############
				[ ] // Read data from excel sheet
				[ ] lsAddProperty=NULL
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsAddProperty=lsExcelData[2]
				[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate (KEY_DN, 2))	
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[+] if (PropertyListTable.Exists(1))
					[ ] 
					[+] if (PropertyListTable.Edit.IsEnabled())
						[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", PASS, "Edit button enabled on Rental Property >PropertyList.") 
						[+] PropertyListTable.Edit.Click()
							[ ] //############## Verify Property Edited ############
							[+] if (AddEditRentalProperty.Exists(1))
								[ ] AddEditRentalProperty.AddEditRentalPropertyName.SetText(lsAddProperty[1])
								[ ] AddEditRentalProperty.AddEditRentalPropertyTag.SetText(lsAddProperty[2])
								[ ] AddEditRentalProperty.AddEditRentalPropertyStreet.SetText(lsAddProperty[3])
								[ ] AddEditRentalProperty.AddEditRentalPropertyCity.SetText(lsAddProperty[4])
								[ ] AddEditRentalProperty.OK.Click()
								[+] if (AlertMessage.Exists(5))
									[ ] AlertMessage.Yes.Click()
									[ ] WaitForState(AlertMessage,False,1)
								[ ] 
							[+] if (PropertyListTable.Exists(2))
								[ ] PropertyListTable.SetActive()
								[ ] hWnd = Str(PropertyListTable.PropertyList.QWListViewer1.ListBox1.GetHandle())
								[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
								[ ] sExpected=  lsAddProperty[3]
								[ ] bAssert = MatchStr("*{sExpected}*",sActual)
								[+] if ( bAssert == TRUE)
									[ ] ReportStatus("Verify Property edited", PASS, "Property {lsAddProperty[1]} is edited.") 
								[+] else
									[ ] ReportStatus("Verify Property edited", FAIL, "Property {lsAddProperty[1]} is not edited.") 
								[ ] 
								[+] if (PropertyListTable.Delete.IsEnabled())
									[ ] ReportStatus(" Verify Delete button enabled on PropertyList screen", PASS, "Delete button enabled on Rental Property >PropertyList.") 
									[ ] hWnd=NULL
									[ ] sActual=NULL
									[ ] bAssert=False
									[ ] // //############## Verify property deleted from the Propertylist############
									[ ] PropertyListTable.Delete.Click()
									[+] if (AlertMessage.Exists(5))
										[ ] AlertMessage.Yes.Click()
										[ ] WaitForState(AlertMessage,False,1)
										[ ] hWnd = Str(PropertyListTable.PropertyList.QWListViewer1.ListBox1.GetHandle())
										[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
										[ ] sExpected=  lsAddProperty[3]
										[ ] bAssert = MatchStr("*{sExpected}*",sActual)
										[+] if ( bAssert == TRUE)
											[ ] ReportStatus("Verify Property deleted", FAIL, "Property {Str(Val(lsAddProperty[1]), NULL, 1)} not deleted.") 
										[+] else
											[ ] ReportStatus("Verify Property deleted", PASS, "Expected -  {sExpected} is deleted.") 
									[+] else
										[ ] ReportStatus(" Verify Delete property confirmation.", FAIL, " Delete property confirmation dialog didn't appear hence property couldn't be deleted.") 
									[ ] 
								[+] else
									[ ] ReportStatus(" Verify Delete button enabled on PropertyList screen", FAIL, "Delete  button is not enabled on Rental Property >PropertyList.") 
									[ ] 
							[+] else
								[ ] ReportStatus(" Verify Delete button enabled on PropertyList screen", FAIL, "PropertyList is not enabled.") 
						[ ] PropertyListTable.SetActive()
						[ ] PropertyListTable.Done.Click()
						[ ] WaitForState(PropertyListTable,False,1)
						[ ] 
					[+] else
						[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", FAIL, "Edit  button is not enabled on Rental Property >PropertyList.") 
				[+] else
					[ ] ReportStatus(" Verify PropertyList dialog", FAIL, "PropertyList didn't appear.") 
			[+] else
				[ ] ReportStatus("Verify Property added", FAIL, "Property {lsAddProperty[1]} couldn't be added.") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test5_VerifyAddProperty #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test5_Verify_Add_Property ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add property to Rental property.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while adding a property						
		[ ] //						Fail		If  property not added	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 27, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test5_VerifyAddProperty() appstate  RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[+] QuickenWindow.SetActive()
			[ ] iFunctionResult=AddRentalProperty(lsAddProperty)
			[+] if ( iFunctionResult ==PASS)
				[ ] ReportStatus("Verify Property added", PASS, "Property {lsAddProperty[1]} is added.") 
			[+] else
				[ ] ReportStatus("Verify Property added", FAIL, "Property {lsAddProperty[1]} is not added.") 
				[ ] 
			[ ] //############## Verify Edit, Delete buttons enabled in the Propertylist############
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(2)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate (KEY_DN, 2))	
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] sleep(1)
			[ ] PropertyListTable.Exists(2)
			[ ] PropertyListTable.Edit.Exists(1)
			[+] if (PropertyListTable.Edit.IsEnabled())
				[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", PASS, "Edit button enabled on Rental Property >PropertyList.") 
			[+] else
				[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", FAIL, "Edit  button is not enabled on Rental Property >PropertyList.") 
			[+] if (PropertyListTable.Delete.IsEnabled())
				[ ] ReportStatus(" Verify Delete button enabled on PropertyList screen", PASS, "Delete button enabled on Rental Property >PropertyList.") 
			[+] else
				[ ] ReportStatus(" Verify Delete button enabled on PropertyList screen", FAIL, "Delete button is not enabled on Rental Property >PropertyList.") 
			[ ] 
			[ ] PropertyListTable.Done.Click()
			[ ] WaitForState(PropertyListTable,False,2)
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
	[ ] 
	[ ] // ********************************************************
[ ] 
[+] //############# Test6_VerifyHideProperty #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_VerifyHideProperty ()
		[ ] //
		[ ] // DESCRIPTION: This testcase will verify that a property gets hidden.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass     If no error occurs while hiding and unhiding property						
		[ ] //						Fail		If property not hidden and visible simultaneously	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 3, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test6_VerifyHideProperty() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iNavigate=NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_RENT_CENTER)
		[+] if (iNavigate==PASS)
			[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} ", PASS, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} displayed.") 
			[ ] //############## Openening the Property List############
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate (KEY_DN, 2))	
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] sleep(1)
			[ ] PropertyListTable.Edit.Exists(1)
			[+] if (PropertyListTable.Edit.IsEnabled())
				[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", PASS, "Edit button enabled on Rental Property screen.") 
			[+] else
				[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", FAIL, "Edit  button is not enabled on Rental Property screen.") 
			[+] PropertyListTable.Edit.Click()
				[ ] //############## Hiding the property############
				[+] if (AddEditRentalProperty.Exists(1))
					[ ] AddEditRentalProperty.HideProperty.Check()
					[ ] AddEditRentalProperty.OK.Click()
				[ ] //############## Verifying hidden property in Propertylist############
				[+] if  (PropertyListTable.Exists(2))
					[ ] hWnd = Str(PropertyListTable.PropertyList.QWListViewer1.ListBox1.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
					[ ] sExpected= lsAddProperty[3]+"  @" +lsAddProperty[2]
					[ ] bAssert = MatchStr("*{sExpected}*",sActual)
					[+] if ( bAssert == TRUE)
						[ ] ReportStatus("Verify Property hide feature", FAIL, "Property {lsAddProperty[1]} did not hide in PropertyListTable.") 
					[+] else
						[ ] ReportStatus("Verify Property hide feature", PASS, "Property {lsAddProperty[1]} become hidden in PropertyListTable.") 
					[ ] PropertyListTable.Done.Click()
					[ ] WaitForState(PropertyListTable,False,2)
				[ ] //############## Verifying property became hidden in RentalPropertyRentCenter############
			[+] if (QuickenWindow.Exists(1))
				[ ] QuickenWindow.SetActive()
				[+] iResult=RentalPropertyRentCenter.PopupList1.FindItem(lsAddProperty[1])
					[+] if ( iResult == 2)
						[ ] ReportStatus("Verify Property hide feature in Rent Center Properties dropdownlist.", FAIL, "Property {lsAddProperty[1]} did not hide in Rent Center Properties dropdownlist..") 
					[+] else
						[ ] ReportStatus("Verify Property hide feature in Rent Center Properties dropdownlist.", PASS, "Property {lsAddProperty[1]} become hidden in Rent Center Properties dropdownlist..") 
				[ ] //############## Verifying property became hidden in RentalProperty > Profit Loss############
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[+] if (QuickenWindow.Exists(1))
				[ ] QuickenWindow.SetActive()
				[+] iResult=RentalPropertyRentCenter.PopupList1.FindItem(lsAddProperty[1])
					[+] if ( iResult == 2)
						[ ] ReportStatus("Verify Property hide feature in Profit Loss Properties dropdownlist.", FAIL, "Property {lsAddProperty[1]} did not hide in Profit Loss Properties dropdownlist..") 
					[+] else
						[ ] ReportStatus("Verify Property hide feature in Profit Loss Properties dropdownlist.", PASS, "Property {lsAddProperty[1]} become hidden in Profit Loss Properties dropdownlist..") 
				[ ] 
				[ ] //############## Unhiding the property############
			[+] else
				[ ] ReportStatus("Verify Rental Property Rent Center Exists. ", FAIL, " Rental Property Rent Center does not didplayed. ") 
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate (KEY_DN, 2))
			[ ] sleep(1)	
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[+] if (PropertyListTable.Exists(5))
				[ ] PropertyListTable.SetActive()
				[ ] PropertyListTable.ShowHiddenProperties.Check()
				[ ] PropertyListTable.Edit.Exists(1)
				[+] if (PropertyListTable.Edit.IsEnabled())
					[+] ReportStatus(" Verify Edit button enabled on PropertyList screen", PASS, "Edit button enabled on Rental Property screen.") 
						[ ] PropertyListTable.Edit.Click()
						[ ] //############## Verify Property became visible in Propertylist ############
						[+] if (AddEditRentalProperty.Exists(1))
							[ ] AddEditRentalProperty.HideProperty.Uncheck()
							[ ] AddEditRentalProperty.OK.Click()
						[+] else
							[ ] ReportStatus(" Verify AddEditRentalProperty screen", FAIL, "AddEditRentalProperty screen did not appear.") 
				[+] else
					[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", FAIL, "Edit  button is not enabled on Rental Property screen.") 
				[+] if  (PropertyListTable.Exists(2))
					[ ] hWnd = Str(PropertyListTable.PropertyList.QWListViewer1.ListBox1.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
					[ ] sExpected=lsAddProperty[3]+"  @" +lsAddProperty[2]
					[ ] bAssert = MatchStr("*{sExpected}*",sActual)
					[+] if ( bAssert == TRUE)
						[ ] ReportStatus("Verify Property hide feature", PASS, "Property {lsAddProperty[1]} became visible in PropertyListTable.") 
					[+] else
						[ ] ReportStatus("Verify Property hide feature", FAIL, "Property {lsAddProperty[1]} did not became visible in PropertyListTable.") 
					[ ] PropertyListTable.Done.Click()
					[ ] WaitForState(PropertyListTable,False,2)
				[+] else
					[ ] ReportStatus(" Verify PropertyListTable ", FAIL, "PropertyListTable did not appear.") 
			[+] else
				[ ] ReportStatus(" Verify PropertyListTable ", FAIL, "PropertyListTable did not appear.") 
				[ ] //############## Verifying property became visible in RentalPropertyRentCenter############
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_RENT_CENTER)
			[+] if (QuickenWindow.Exists(1))
				[ ] QuickenWindow.SetActive()
				[+] iResult=RentalPropertyRentCenter.PopupList1.FindItem(lsAddProperty[1])
					[+] if ( iResult == 2)
						[ ] ReportStatus("Verify Property hide feature in Rent Center Properties dropdownlist.", PASS, "Property {lsAddProperty[1]} become visible in Rent Center Properties dropdownlist..") 
					[+] else
						[ ] ReportStatus("Verify Property hide feature in Rent Center Properties dropdownlist.", FAIL, "Property {lsAddProperty[1]} did not become visible in Rent Center Properties dropdownlist.") 
			[+] else
				[ ] ReportStatus("Verify Rental Property Rent Center Exists. ", FAIL, " Rental Property Rent Center does not didplayed. ") 
				[ ] //############## Verifying property became hidden in RentalProperty > Profit Loss############
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[+] if (QuickenWindow.Exists(1))
				[ ] QuickenWindow.SetActive()
				[+] iResult=RentalPropertyRentCenter.PopupList1.FindItem(lsAddProperty[1])
					[+] if ( iResult == 2)
						[ ] ReportStatus("Verify Property hide feature in Profit Loss Properties dropdownlist.", PASS, "Property {lsAddProperty[1]} become visible in Profit Loss Properties dropdownlist..") 
					[+] else
						[ ] ReportStatus("Verify Property hide feature in Profit Loss Properties dropdownlist.", FAIL, "Property {lsAddProperty[1]} did not become visible in Profit Loss Properties dropdownlist.") 
			[+] else
				[ ] ReportStatus("Verify Rental Property Rent Center Exists. ", FAIL, " Rental Property Profit Loss did not display. ") 
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} ", FAIL, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} Not displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] 
[+] //############# Test7_VerifyRentCenterWithAndWithoutProperty #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_VerifyRentCenterWithAndWithoutProperty()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify rent center contents when no property is added and when property is added
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying the contents of Rent Center					
		[ ] //						Fail		If error occurs while verifying the contents of Rent Center
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 3, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test7_VerifyRentCenterWithAndWithoutProperty() appstate RPMBaseState
	[ ] // Variable Declaration
	[ ] // Read data from excel sheet
	[ ] STRING sUnknownProperty , sAllProperties , sDefaultDuration ,sDefault
	[ ] sUnknownProperty= "Unknown Property"
	[ ] sAllProperties= "All Properties"
	[ ] sDefaultDuration ="Current Month"
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given  sPropertyWorksheet sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] iNavigate=1
	[+] //########Launch Quicken and open sEmptyRentalFile######################//
		[ ] 
	[ ] iResult =DataFileCreate(sEmptyRentalFile)
	[ ] //######## Quicken launched and opened sEmptyRentalFile######################//
	[+] if (iResult==PASS)
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] iNavigate=NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_RENT_CENTER)
			[+] if (iNavigate==PASS)
				[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} ", PASS, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} displayed.") 
				[+] if (RentalPropertyRentCenter.Exists(1))
					[+] QuickenWindow.SetActive()
						[ ] //######## Verify property dropdownlist display UnknownProperty" in Rent Center when no property is added#####################//
						[ ] iResult=RentalPropertyRentCenter.PopupList1.FindItem(trim(sUnknownProperty))
						[+] if ( iResult ==1)
							[ ] ReportStatus("Verify the display information on the Rent Center.", PASS, " {sUnknownProperty} option is available in Rent Center Properties dropdownlist when no property is added.") 
						[+] else
							[ ] ReportStatus("Verify the display information on the Rent Center.", FAIL, " {sUnknownProperty} option is not available in Rent Center Properties dropdownlist when no property is added.") 
						[ ] 
						[ ] //######## Verify property dropdownlist display "Current Month" in duration dropdown list in Rent Center when no property is added#####################//
						[ ] iResult=RentalPropertyRentCenter.PopupList2.FindItem(trim(sDefaultDuration))
						[+] if ( iResult ==0)
							[ ] ReportStatus("Verify the display information on the Rent Center.", PASS, " {sDefaultDuration} option is default in Rent Center Duration screen's dropdownlist when no property is added.") 
						[+] else
							[ ] ReportStatus("Verify the display information on the Rent Center.", FAIL, " {sDefaultDuration} option is not default in Rent Center Duration screen's dropdownlist when no property is added.") 
						[ ] //######## Verify property added is getting displayed in Rent Center when no property is added#####################//
						[ ] 
						[ ] AddRentalProperty(lsAddProperty)
						[ ] iResult=RentalPropertyRentCenter.PopupList1.FindItem(trim(sAllProperties))
						[+] if ( iResult ==1)
							[ ] ReportStatus("Verify the display information on the Rent Center.", PASS, " {sAllProperties} option is available in Rent Center Properties dropdownlist when a property is added.") 
						[+] else
							[ ] ReportStatus("Verify the display information on the Rent Center.", FAIL, " {sAllProperties} option is not available in Rent Center Properties dropdownlist when a property is added.") 
						[ ] iResult=RentalPropertyRentCenter.PopupList1.FindItem(trim(lsAddProperty[1]))
						[+] if ( iResult == 2)
							[ ] ReportStatus("Verify the display information on the Rent Center.", PASS, "Property {lsAddProperty[1]} is available in Rent Center Properties dropdownlist when a property is added.") 
						[+] else
							[ ] ReportStatus("Verify the display information on the Rent Center.", FAIL, "Property {lsAddProperty[1]} is not available in Rent Center Properties dropdownlist when a property is added.") 
					[+] if (QuickenMainWindow.QWNavigator1.AddTransactions.Exists(5))
							[ ] //############## Verify Enter Rent button when no property is added############
						[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
						[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_DN)
						[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
						[+] if (AlertMessage.Exists(2))
							[ ] AlertMessage.SetActive()
							[ ] sValidationText=AlertMessage.MessageText.GetText()
							[ ] ReportStatus(" Verify Enter Rent button when no account is added", PASS, " {sValidationText} ") 
							[ ] AlertMessage.OK.Click()
							[ ] WaitForState(AlertMessage,False,1)
						[+] else
							[ ] ReportStatus(" Verify Enter Rent button when no account is added", FAIL, "Validation message not displayed.") 
					[+] else
						[ ] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", FAIL, "AddTransactions button does not exist on Rental Property screen.") 
					[+] if (QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(5))
						[ ] //############## Verify Add Tenant button when no property is added############
						[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
						[ ] sleep(1)
						[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 3))	
						[ ] sleep(1)
						[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
						[+] if (AlertMessage.Exists(2))
							[ ] AlertMessage.SetActive()
							[ ] sValidationText=AlertMessage.MessageText.GetText()
							[ ] ReportStatus(" Verify Add Tenant button when no account is added", PASS, " {sValidationText} ") 
							[ ] AlertMessage.OK.Click()
							[ ] WaitForState(AlertMessage,False,1)
						[+] else
							[ ] ReportStatus(" Verify Add Tenant button when no account is added", FAIL, "Validation message not displayed.") 
				[+] else
					[ ] ReportStatus("Verify Rental Property Rent Center Exists. ", FAIL, " Rental Property Rent Center does not didplayed. ") 
			[ ] 
			[+] else
				[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} ", FAIL, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} Not displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Create New Quicken File", FAIL, "New Quicken File couldn't be created successfully.") 
	[ ] // ********************************************************
[ ] 
[+] //############# Test8_VerifyAddTenantRentDetailsUI #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_VerifyAddTenantRentDetailsUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify add Tenant Rent details UI
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying the fields of Add Tenant > Rent Details					
		[ ] //						Fail		If  error occurs while verifying the fields of Add Tenant > Rent Details
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 3, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test8_VerifyAddTenantRentDetailsUI() appstate RPMBaseState
	[ ] // Variable Declaration
	[ ] INTEGER iListCount
	[ ] 
	[ ] STRING sViewAsPopupListItem , sDueWithinNextPopupList
	[ ] sViewAsPopupListItem ="List"
	[ ] sDueWithinNextPopupList="12 Months"
	[ ] // Read Tenant data from excel sTenantWorksheet sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // #################Verify Tenant form fields###############///
		[+] if (QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(5))
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN,3))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(DlgAddRentalPropertyTenant,True,2)
			[+] if (DlgAddRentalPropertyTenant.Exists(5))
				[+] DlgAddRentalPropertyTenant.SetActive()
						[+] if ( DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditTenantName.Exists(5))
							[ ] ReportStatus("Verify Tenant Name textbox exists ", PASS, "Tenant Name exists on Add Rental property Tenant dialog.") 
						[+] else
							[ ] ReportStatus("Verify Tenant Name textbox exists ", FAIL, "Tenant Name does not exist on Add Rental property Tenant dialog.") 
						[+] if ( DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.Exists(5))
							[ ] ReportStatus("Verify PropertyPopupList  exists ", PASS, "PropertyPopupList exists on Add Rental property Tenant dialog.") 
						[+] else
							[ ] ReportStatus("Verify PropertyPopupList  exists ", FAIL, "PropertyPopupList does not exist on Add Rental property Tenant dialog.") 
						[+] if ( DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditRentAmount.Exists(5))
							[ ] ReportStatus("Verify RentAmountEdit textbox exists ", PASS, "RentAmountEdit exists on Add Rental property Tenant dialog.") 
						[+] else
							[ ] ReportStatus("Verify RentAmountEdit textbox exists ", FAIL, "RentAmountEdit does not exist on Add Rental property Tenant dialog.") 
						[+] if ( DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.Exists(5))
							[ ] ReportStatus("Verify AccountNamePopupList exists ", PASS, "AccountNamePopupList exists on Add Rental property Tenant dialog.") 
						[+] else
							[ ] ReportStatus("Verify AccountNamePopupList exists ", FAIL, "AccountNamePopupList does not exist on Add Rental property Tenant dialog.") 
						[+] if ( DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListRentDueOn.Exists(5))
							[ ] ReportStatus("Verify RentDueOnPopupList exists ", PASS, "RentDueOnPopupList exists on Add Rental property Tenant dialog.") 
						[+] else
							[ ] ReportStatus("Verify RentDueOnPopupList exists ", FAIL, "RentDueOnPopupList does not exist on Add Rental property Tenant dialog.") 
							[ ] 
						[+] if ( DlgAddRentalPropertyTenant.AddToAddressBook.Exists(5))
							[ ] ReportStatus("Verify AddToAddressBook exists ", PASS, "AddToAddressBook exists on Add Rental property Tenant dialog.") 
						[+] else
							[ ] ReportStatus("Verify AddToAddressBook exists ", FAIL, "AddToAddressBook does not exist on Add Rental property Tenant dialog.") 
						[+] if ( DlgAddRentalPropertyTenant.OK.Exists(5))
							[ ] ReportStatus("Verify OK exists ", PASS, "OK exists on Add Rental property Tenant dialog.") 
						[+] else
							[ ] ReportStatus("Verify OK exists ", FAIL, "OK does not exist on Add Rental property Tenant dialog.") 
						[+] if ( DlgAddRentalPropertyTenant.Cancel.Exists(5))
							[ ] ReportStatus("Verify Cancel exists ", PASS, "Cancel exists on Add Rental property Tenant dialog.") 
							[ ] DlgAddRentalPropertyTenant.Cancel.Click()
							[ ] WaitForState(DlgAddRentalPropertyTenant,False,2)
						[+] else
							[ ] ReportStatus("Verify Cancel exists ", FAIL, "Cancel does not exist on Add Rental property Tenant dialog.") 
			[+] else
				[ ] ReportStatus(" Verify AddRentalPropertyTenant ", FAIL, "AddRentalPropertyTenant did not appear.") 
		[+] else
			[ ] ReportStatus("Verify PropertiesTenants button exists on Rent Center. ", FAIL, " Verify PropertiesTenants button exists on Rent Center.") 
		[ ] // #################Add Tenant and verify the rent reminder###############///
		[ ] QuickenWindow.SetActive()
		[ ] iResult=AddRentalPropertyTenant(lsAddTenant)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] iNavigate=NavigateQuickenTab(sTAB_BILL , sTAB_UPCOMING)
			[+] if (iNavigate==PASS)
				[ ] QuickenWindow.SetActive()
				[ ] Bills.ViewAsPopupList.Select(sViewAsPopupListItem)
				[ ] sleep(0.5)
				[ ] Bills.DueWithinNextPopupList.Select(sDueWithinNextPopupList)
				[ ] sHandle=Str(Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] iListCount =Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
				[+] for (iCounter=0 ; iCounter<iListCount +1 ;  ++iCounter)
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  Str(iCounter))
					[ ] bMatch=MatchStr("*{lsAddTenant[1]}*{Str(Val(lsAddTenant[3]),3,2)}*" , sActual)
					[+] if (bMatch)
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify rent reminder", PASS, "Verify rent reminder: Rent reminder for Tenant {lsAddTenant[1]} with amount {lsAddTenant[3]} added as expected {sActual}.") 
					[ ] iResult=DeleteRentalPropertyTenant(lsAddTenant)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify Tenant deleted", PASS, "Tenant {lsAddTenant[1]} deleted.") 
					[+] else
						[ ] ReportStatus("Verify Tenant deleted", FAIL, "Tenant {lsAddTenant[1]} not deleted.") 
				[+] else
					[ ] ReportStatus("Verify rent reminder", FAIL, "Verify rent reminder: Rent reminder for Tenant {lsAddTenant[1]} with amount {lsAddTenant[3]} couldn't be added as expected, actual reminder data is {sActual}.") 
			[+] else
				[ ] ReportStatus("Verify navigation to {sTAB_UPCOMING}", FAIL, "It couldn't navigate to {sTAB_UPCOMING}.") 
		[+] else 
			[ ] ReportStatus("Verify Tenant added", FAIL, "Tenant {lsAddTenant[1]} did not add in TenantList.") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test9_VerifyTermsAndAgreementUI #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_VerifyTermsAndAgreementUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the fields of Add Tenant > Terms And Agreement		
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying the fields of Add Tenant > Terms And Agreement					
		[ ] //						Fail		If  error occurs while verifying the fields of Add Tenant > Terms And Agreement			
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 3, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test9_VerifyTermsAndAgreementUI() appstate RPMBaseState
	[ ] // Variable Declaration
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // #################RentalProperty>Add Tenant###############///
		[+] if (QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(5))
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 3))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(DlgAddRentalPropertyTenant,True,2)
			[+] if (DlgAddRentalPropertyTenant.Exists(5))
				[ ] DlgAddRentalPropertyTenant.SetActive()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditTenantName.SetText(lsAddTenant[1])
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.SetFocus()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.Select(lsAddTenant[2])
				[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.Click(1,275,12)
				[ ] DlgAddRentalPropertyTenant.SetActive()
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.PopupListLeaseTerms.Exists(5))
					[ ] ReportStatus("Verify LeaseTermsPopupList  exists ", PASS, "LeaseTermsPopupList exists on Add Rental property Tenant dialog.") 
				[+] else
					[ ] ReportStatus("Verify LeaseTermsPopupList  exists ", FAIL, "LeaseTermsPopupList does not exist on Add Rental property Tenant dialog.") 
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditLeaseStartDate.Exists(5))
					[ ] ReportStatus("Verify LeaseStartDate exists ", PASS, "Lease Start Date exists on Add Rental property Tenant dialog.") 
				[+] else
					[ ] ReportStatus("Verify LeaseStartDate exists ", FAIL, "Lease Start Date does not exist on Add Rental property Tenant dialog.") 
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditGracePeriod.Exists(5))
					[ ] ReportStatus("Verify GracePeriod TextField exists ", PASS, "Grace Period exists on Add Rental property Tenant dialog.") 
				[+] else
					[ ] ReportStatus("Verify GracePeriod TextField  exists ", FAIL, "Grace Period  does not exist on Add Rental property Tenant dialog.") 
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditLateFee.Exists(5))
					[ ] ReportStatus("Verify LateFee TextField exists ", PASS, "Late Fee exists on Add Rental property Tenant dialog.") 
				[+] else
					[ ] ReportStatus("Verify LateFee TextField exists ", FAIL, "Late Fee does not exist on Add Rental property Tenant dialog.") 
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveInDate.Exists(5))
					[ ] ReportStatus("Verify MoveInDate TextField exists ", PASS, " Move In Date exists on Add Rental property Tenant dialog.") 
				[+] else
					[ ] ReportStatus("Verify MoveInDate TextField exists ", FAIL, "Move In Date does not exist on Add Rental property Tenant dialog.") 
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveOutDate.Exists(5))
					[ ] ReportStatus("Verify MoveOutDate TextField exists ", PASS, " Move Out Date exists on Add Rental property Tenant dialog.") 
				[+] else
					[ ] ReportStatus("Verify MoveOutDate TextField exists ", FAIL, "Move Out Date does not exist on Add Rental property Tenant dialog.") 
				[+] if ( DlgAddRentalPropertyTenant.Help.Exists(5))
					[ ] ReportStatus("Verify Help exists ", PASS, "Help exists on Add Rental property Tenant dialog.") 
				[+] else
					[ ] ReportStatus("Verify Help exists ", FAIL, "Help does not exist on Add Rental property Tenant dialog.") 
				[+] if ( DlgAddRentalPropertyTenant.OK.Exists(5))
					[ ] ReportStatus("Verify OK exists ", PASS, "OK exists on Add Rental property Tenant dialog.") 
				[+] else
					[ ] ReportStatus("Verify OK exists ", FAIL, "OK does not exist on Add Rental property Tenant dialog.") 
					[ ] 
				[+] if ( DlgAddRentalPropertyTenant.Cancel.Exists(5))
					[ ] ReportStatus("Verify Cancel exists ", PASS, "Cancel exists on Add Rental property Tenant dialog.") 
					[ ] DlgAddRentalPropertyTenant.Cancel.Click()
					[ ] WaitForState(DlgAddRentalPropertyTenant,False,2)
				[+] else
					[ ] ReportStatus("Verify Cancel exists ", FAIL, "Cancel does not exist on Add Rental property Tenant dialog.") 
				[ ] 
			[+] else
				[ ] ReportStatus(" Verify AddRentalPropertyTenant ", FAIL, "AddRentalPropertyTenant did not appear.") 
		[+] else
			[ ] ReportStatus("Verify PropertiesTenants button exists on Rent Center. ", FAIL, " Verify PropertiesTenants button exists on Rent Center.") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test10_VerifyAddTenantTermsAndAgreementValiadation #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyAddTenantTermsAndAgreementValiadation()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the field level valiadation of Add Tenant > Terms And Agreement	
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying the field level valiadation of Add Tenant > Terms And Agreement					
		[ ] //						Fail		If  error occurs while verifying the field level valiadation of Add Tenant > Terms And Agreement	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 3, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test10_VerifyAddTenantTermsAndAgreementValiadation() appstate RPMBaseState
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] STRING sGDate,sLDate
	[ ] sGDate="10/9/2012"
	[ ] sLDate="09/9/2012"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // #################Add Tenant###############///
		[+] if (QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(5))
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 3))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(DlgAddRentalPropertyTenant,True,2)
			[+] if (DlgAddRentalPropertyTenant.Exists(5))
				[ ] DlgAddRentalPropertyTenant.SetActive()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditTenantName.SetText(lsAddTenant[1])
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.SetFocus()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.Select(lsAddTenant[2])
				[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.Click(1,275,12)
				[ ] // #################Verify Move In Date can not be later than Move Out Date###############///
				[ ] sMsg1="Move in date cannot be later than move out date."
				[ ] sMsg2="Enter a valid date in the Terms and Agreement tab."
				[ ] 
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveInDate.Exists(5))
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveInDate.SetText(sGDate)
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveOutDate.SetText(sLDate)
					[ ] DlgAddRentalPropertyTenant.OK.Click()
					[+] if (AlertMessage.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] sValidationText=AlertMessage.MessageText.GetText()
						[ ] bMatch =MatchStr("*{sMsg1}*{sMsg2}*" , sValidationText)
						[+] if (bMatch)
							[ ] ReportStatus(" Verify Move In Date can not be later than Move Out Date", PASS, "Verify Move In Date can not be later than Move Out Date: Validation message: {sValidationText} appeared as expected: {sMsg1}{sMsg2}") 
						[+] else
							[ ] ReportStatus("Verify Move In Date can not be later than Move Out Date", FAIL, "Verify Move In Date can not be later than Move Out Date: Validation message: {sValidationText} didn't appear as expected: {sMsg1}{sMsg2}") 
						[ ] 
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage, False,1)
					[+] else
						[ ] ReportStatus(" Verify Move In Date can not be later than Move Out Date.", FAIL, "Validation message not displayed.") 
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveInDate.ClearText()
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveInDate.ClearText()
				[+] else
					[ ] ReportStatus(" Verify MoveInDate field exists. ", FAIL, "Verify MoveInDate field exists: MoveInDate field is not available on TermsAndAgreement tab.") 
				[ ] // #################Verify Lease Start Date can not be later than Lease End Date###############///
				[ ] sMsg1="Lease start date cannot be later than move out date."
				[ ] sMsg2="Enter a valid date in the Terms and Agreement tab."
				[ ] 
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditLeaseStartDate.Exists(5))
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditLeaseStartDate.SetText(sGDate)
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveOutDate.SetText(sLDate)
					[ ] DlgAddRentalPropertyTenant.OK.Click()
					[+] if (AlertMessage.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] sValidationText=AlertMessage.MessageText.GetText()
						[ ] bMatch =MatchStr("*{sMsg1}*{sMsg2}*" , sValidationText)
						[+] if (bMatch)
							[ ] ReportStatus(" Verify Lease Start Date can not be later than Lease End Date", PASS, " Verify Lease Start Date can not be later than Lease End Date: Validation message: {sValidationText} appeared as expected: {sMsg1}{sMsg2}") 
						[+] else
							[ ] ReportStatus(" Verify Lease Start Date can not be later than Lease End Date", FAIL, " Verify Lease Start Date can not be later than Lease End Date: {sValidationText} didn't appear as expected: {sMsg1}{sMsg2}") 
						[ ] 
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage, False,1)
						[ ] 
					[+] else
						[ ] ReportStatus(" Verify Lease Start Date can not be later than Lease End Date.", FAIL, "Validation message not displayed.") 
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditLeaseStartDate.ClearText()
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditLeaseStartDate.ClearText()
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveOutDate.ClearText()
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditMoveOutDate.ClearText()
					[ ] 
				[+] else
					[ ] ReportStatus(" Verify LeaseStartDate field exists. ", FAIL, "Verify LeaseStartDate field exists: LeaseStartDate field is not available on TermsAndAgreement tab.") 
				[ ] 
				[ ] // #################Verify Grace Period should accept values in between 0 to 30 ###############///
				[ ] sMsg1="Please enter a number from 0 to 30."
				[ ] 
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditGracePeriod.Exists(2))
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditGracePeriod.SetText("-1")
					[ ] DlgAddRentalPropertyTenant.OK.Click()
					[+] if (AlertMessage.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] sValidationText=AlertMessage.MessageText.GetText()
						[ ] bMatch =MatchStr("*{sMsg1}*" , sValidationText)
						[+] if (bMatch)
							[ ] ReportStatus(" Verify Grace Period should accept values in between 0 to 30.", PASS, " Verify Grace Period should accept values in between 0 to 30: {sValidationText} appeared as expected: {sMsg1}") 
						[+] else
							[ ] ReportStatus(" Verify Grace Period should accept values in between 0 to 30.", FAIL, " Verify Grace Period should accept values in between 0 to 30: {sValidationText} didn't appear as expected: {sMsg1}") 
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage, False,1)
					[+] else
						[ ] ReportStatus(" Verify Grace Period should accept values in between 0 to 30.", FAIL, "Validation message not displayed.") 
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditGracePeriod.ClearText()
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditGracePeriod.SetText("31")
					[ ] DlgAddRentalPropertyTenant.OK.Click()
					[+] if (AlertMessage.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] sValidationText=AlertMessage.MessageText.GetText()
						[ ] bMatch =MatchStr("*{sMsg1}*" , sValidationText)
						[+] if (bMatch)
							[ ] ReportStatus(" Verify Grace Period should accept values in between 0 to 30.", PASS, " Verify Grace Period should accept values in between 0 to 30: {sValidationText} appeared as expected: {sMsg1}") 
						[+] else
							[ ] ReportStatus(" Verify Grace Period should accept values in between 0 to 30.", FAIL, " Verify Grace Period should accept values in between 0 to 30: {sValidationText} didn't appear as expected: {sMsg1}") 
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage, False,1)
					[+] else
						[ ] ReportStatus(" Verify Grace Period should accept values in between 0 to 30.", FAIL, "Validation message not displayed.") 
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditGracePeriod.SetText("3")
					[ ] 
				[+] else
					[ ] ReportStatus(" Verify GracePeriod field exists. ", FAIL, "Verify GracePeriod field exists: GracePeriod field is not available on TermsAndAgreement tab.") 
				[ ] 
				[ ] // #################Verify Late Fee should accept values in numerics only###############///
				[ ] sMsg1="Please enter a valid amount"
				[+] if ( DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditLateFee.Exists(5))
					[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditLateFee.SetText("-")
					[ ] DlgAddRentalPropertyTenant.OK.Click()
					[+] if (AlertMessage.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] sValidationText=AlertMessage.MessageText.GetText()
						[ ] bMatch =MatchStr("*{sMsg1}*" , sValidationText)
						[+] if (bMatch)
							[ ] ReportStatus(" Verify Late Fee should accept values in numerics only.", PASS, " Verify Late Fee should accept values in numerics only: {sValidationText} appeared as expected: {sMsg1}") 
						[+] else
							[ ] ReportStatus(" Verify Late Fee should accept values in numerics only.", FAIL, " Verify Late Fee should accept values in numerics only: {sValidationText} didn't appear as expected: {sMsg1}") 
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage, False,1)
						[ ] 
						[ ] DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.EditLateFee.SetText("3")
				[+] else
					[ ] ReportStatus(" Verify LateFee field exists. ", FAIL, "Verify LateFee field exists: LateFee field is not available on TermsAndAgreement tab.") 
					[ ] 
				[ ] // #################Verify entries in Lease terms combobox##############///
				[ ] LIST OF STRING lsActualLeaseTerms ,lsExpectedLeaseTerms
				[ ] lsExpectedLeaseTerms ={"Month to month","Six month","One year", "Other"}
				[ ] STRING sItem
				[ ] INTEGER i
				[ ] lsActualLeaseTerms=DlgAddRentalPropertyTenant.TermsAndAgreement.QWinChild1.PopupListLeaseTerms.GetContents()
				[+] for (i=1 ; i<ListCount(lsExpectedLeaseTerms); ++i)
					[+] if (lsActualLeaseTerms[i]==lsExpectedLeaseTerms[i])
						[ ] ReportStatus("Verify entries in Lease terms combobox.", PASS, " {lsExpectedLeaseTerms[i]} option is available in Lease terms combobox..") 
					[+] else
						[ ] ReportStatus("Verify entries in Lease terms combobox.", FAIL, " {lsExpectedLeaseTerms[i]} option is not available in Lease terms combobox..") 
				[ ] // #################Verify Security Deposit tab options###############///
				[ ] DlgAddRentalPropertyTenant.SecurityDeposit.Click(1,446,12)
				[+] if (DlgAddRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountCollected.Exists(5))
					[ ] ReportStatus(" Verify Amount Collected option ", PASS, "Amount Collected option is available on Security Deposit tab.") 
				[+] else
					[ ] ReportStatus(" Verify Amount Collected option ", FAIL, "Amount Collected option is not available on Security Deposit tab.") 
				[+] if (DlgAddRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountCollectedDate.Exists(5))
					[ ] ReportStatus(" Verify Amount Collected Date option ", PASS, "Amount Collected Date option is available on Security Deposit tab.") 
				[+] else
					[ ] ReportStatus(" Verify Amount Collected Date option ", FAIL, "Amount Collected option is not available on Security Deposit tab.") 
				[+] if (DlgAddRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountReturned.Exists(5))
					[ ] ReportStatus(" Verify Amount Returned option ", PASS, "Amount Returned option is available on Security Deposit tab.") 
				[+] else
					[ ] ReportStatus(" Verify Amount Returned option ", FAIL, "Amount Returned option is not available on Security Deposit tab.") 
					[ ] 
				[+] if (DlgAddRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountReturnedDate.Exists(5))
					[ ] ReportStatus(" Verify Amount Returned Date option ", PASS, "Amount Returned Date option is available on Security Deposit tab.") 
				[+] else
					[ ] ReportStatus(" Verify Amount Returned Date option ", FAIL, "Amount Returned option is not available on Security Deposit tab.") 
				[ ] 
				[ ] DlgAddRentalPropertyTenant.Cancel.Click()
				[ ] WaitForState(DlgAddRentalPropertyTenant,False,1)
		[+] else
			[ ] ReportStatus("Verify PropertiesTenants button exists on Rent Center. ", FAIL, " Verify PropertiesTenants button exists on Rent Center.") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
[ ] 
[+] //############# Test11_VerifyAddTenant #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyAddTenant()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Edit property to Rental property.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while hiding and unhiding property						
		[ ] //						Fail		If  property	not hidden and visible simultaneously	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 3, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test11_VerifyAddTenant() appstate RPMBaseState
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // #################Verify New, Edit, Delete and History buttons when no tenant is added in Tenant List###############///
		[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
		[ ] sleep(1)
		[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
		[ ] sleep(1)
		[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
		[ ] WaitForState(TenantList,true,2)
		[+] if (TenantList.Exists(2))
			[+] if (TenantList.New.IsEnabled())
				[ ] ReportStatus(" Verify New button enabled on TenantList screen", PASS, "New button enabled on when no tenant is added in Tenant List.") 
			[+] else
				[ ] ReportStatus(" Verify New button enabled on TenantList screen", FAIL, "New button is not enabled on when no tenant is added in Tenant List.") 
			[+] if (TenantList.Done.IsEnabled())
				[ ] ReportStatus(" Verify Done button enabled on TenantList screen", PASS, "Done button enabled on when no tenant is added in Tenant List.") 
			[+] else
				[ ] ReportStatus(" Verify Done button enabled on TenantList screen", FAIL, "Done button is not enabled on when no tenant is added in Tenant List.") 
			[+] if (TenantList.Edit.IsEnabled())
				[ ] ReportStatus(" Verify Edit button disabled on PropertyList screen", FAIL, "Edit button enabled in the when no tenant is added in Tenant List.") 
			[+] else
				[ ] ReportStatus(" Verify Edit button disabled on PropertyList screen", PASS, "Edit  button is disabled in when no tenant is added in Tenant List.") 
			[+] if (TenantList.Delete.IsEnabled())
				[ ] ReportStatus(" Verify Delete button disabled on PropertyList screen", FAIL, "Delete button enabled in the when no tenant is added in Tenant List.") 
			[+] else
				[ ] ReportStatus(" Verify Delete button disabled on PropertyList screen", PASS, "Delete  button is disabled in when no tenant is added in Tenant List.") 
			[+] if (TenantList.History.IsEnabled())
				[ ] ReportStatus(" Verify History button disabled on PropertyList screen", FAIL, "History button enabled in the when no tenant is added in Tenant List.") 
			[+] else
				[ ] ReportStatus(" Verify History button disabled on PropertyList screen", PASS, "History  button is disabled in when no tenant is added in Tenant List.") 
			[ ] TenantList.Done.Click()
			[ ] WaitForState(TenantList,False,2)
		[+] else
			[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
			[ ] 
		[ ] 
		[ ] // #################Add Tenant###############///
		[+] if (QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(5))
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 3))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(DlgAddRentalPropertyTenant,True,2)
			[+] if (DlgAddRentalPropertyTenant.Exists(5))
				[ ] DlgAddRentalPropertyTenant.SetActive()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditTenantName.SetText(lsAddTenant[1])
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.SetFocus()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.Select(lsAddTenant[2])
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditRentAmount.SetText(lsAddTenant[3])
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.VerifyEnabled(2)
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.SetFocus()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.Select(lsAddTenant[4])
				[ ] DlgAddRentalPropertyTenant.OK.Click()
				[ ] WaitForState(DlgAddRentalPropertyTenant,False,2)
				[ ] 
			[+] else
				[ ] ReportStatus(" Verify AddRentalPropertyTenant ", FAIL, "AddRentalPropertyTenant did not appear.") 
			[ ] 
			[ ] // #################Verify  Tenant in Tenant List###############///
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[+] WaitForState(TenantList,true,2)
				[+] if  (TenantList.Exists(2))
					[ ] hWnd = Str(TenantList.ChildTenantList.QWListViewer1.ListBox1.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
					[ ] sExpected=  lsAddTenant[1]+"@"+lsAddTenant[2]
					[ ] bAssert = MatchStr("*{sExpected}*",sActual)
					[+] if ( bAssert == TRUE)
						[ ] ReportStatus("Verify Tenant added ", PASS, "Tenant {lsAddTenant[1]} added in TenantList.") 
					[+] else
						[ ] ReportStatus("Verify Tenant added", FAIL, "Tenant {lsAddTenant[1]} did not add in TenantList.") 
					[ ] TenantList.Done.Click()
					[ ] WaitForState(TenantList,False,2)
				[+] else
					[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
					[ ] 
		[+] else
			[ ] ReportStatus("Verify PropertiesTenants button exists on Rent Center. ", FAIL, " Verify PropertiesTenants button exists on Rent Center.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test12_VerifyAddedTenantHistoryTab #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyAddedTenantHistoryTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Edit property to Rental property.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while verifying the contents of Tenant History				
		[ ] //						Fail		If  any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 17, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test12_VerifyAddedTenantHistoryTab() appstate RPMBaseState
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] // Read Property data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] 
	[ ] STRING sDateStamp
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[+] QuickenWindow.SetActive()
				[ ] 
			[ ] // #################Verify options in Tenant History###############///
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[+] WaitForState(TenantList,true,2)
				[+] if  (TenantList.Exists(2))
					[ ] TenantList.History.Click()
					[ ] WaitForState(TenantHistory,true,2)
					[+] if  (TenantHistory.Exists(2))
						[ ] // #################VerifyTenant Name option in Tenant History###############///
						[ ] 
						[+] if (TenantHistory.TenantName.Exists(5))
							[ ] ReportStatus(" Verify Tenant Name option ", PASS, "Tenant Name option is available on History tab.") 
							[ ] TenantHistory.TenantName.Click()
							[ ] TenantHistory.TenantName.Exists(1)
							[ ] sActual=NULL
							[ ] hWnd = Str(TenantHistory.QWListViewer1.ListBox1.GetHandle())
							[+] for( iCounter=0;iCounter<TenantHistory.QWListViewer1.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] // bAssert = MatchStr("*{sDateStamp}*{lsAddTenant[1]}*",sActual)
								[ ] bAssert = MatchStr("*{lsAddTenant[1]}*",sActual)
								[+] if ( bAssert == TRUE)
									[ ] break
							[+] if ( bAssert == TRUE)
								[ ] ReportStatus("Verify Tenant History ", PASS, "Current value of Tenant Name in Tenant History is {lsAddTenant[1]} as expected") 
							[+] else
								[ ] ReportStatus("Verify Tenant History ", FAIL, "Current value of Tenant Name in Tenant History is {sActual} not as expected {lsAddTenant[1]}.") 
							[ ] 
						[+] else
							[ ] ReportStatus(" Verify Tenant Name option ", FAIL, "Tenant Name option is not available on History tab.") 
						[ ] // #################Verify Property option in Tenant History###############///
						[ ] 
						[+] if (TenantHistory.Property.Exists(5))
							[ ] ReportStatus(" Verify Property  option ", PASS, "Property option is available on History tab.") 
							[ ] TenantHistory.Property.Click()
							[ ] TenantHistory.Property.Exists(1)
							[ ] hWnd = Str(TenantHistory.QWListViewer1.ListBox1.GetHandle())
							[ ] sActual=NULL
							[ ] sExpected=NULL
							[ ] sExpected=  sDateStamp+"@"+lsAddProperty[1]
							[+] for( iCounter=0;iCounter<TenantHistory.QWListViewer1.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bAssert = MatchStr("*{sExpected}*",sActual)
								[ ] 
								[+] if ( bAssert == TRUE)
									[ ] break
							[+] if ( bAssert == TRUE)
								[ ] ReportStatus("Verify Tenant History ", PASS, "Current value of Property in Tenant History is {sExpected} as expected") 
							[+] else
								[ ] ReportStatus("Verify Tenant History ", FAIL, "Current value of Property in Tenant History is {sActual} not as expected {sExpected}.") 
							[ ] 
						[+] else
							[ ] ReportStatus(" Verify Property  option ", FAIL, "Property option is not available on History tab.") 
						[ ] // #################Verify Rent Details option in Tenant History###############///
						[ ] 
						[+] if (TenantHistory.RentDetails.Exists(5))
							[ ] ReportStatus(" Verify Rent Details  option ", PASS, "Rent Details option is available on History tab.") 
							[ ] TenantHistory.RentDetails.Click()
							[ ] TenantHistory.RentDetails.Exists(1)
							[ ] sActual=NULL
							[ ] sExpected=NULL
							[ ] hWnd = Str(TenantHistory.QWListViewer1.ListBox1.GetHandle())
							[ ] sExpected=  sDateStamp+"@"+substr(lsAddTenant[3],1,6)
							[ ] 
							[+] for( iCounter=0;iCounter<TenantHistory.QWListViewer1.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bAssert = MatchStr("*{sExpected}*",sActual)
								[+] if ( bAssert == TRUE)
									[ ] break
							[+] if ( bAssert == TRUE)
								[ ] ReportStatus("Verify Tenant History ", PASS, "Current value of Tenant Rent in Tenant History is {sExpected} as expected.") 
							[+] else
								[ ] ReportStatus("Verify Tenant History ", FAIL, "Current value of Tenant Rent in Tenant History is {sActual} not as expected {sExpected}.") 
							[ ] 
						[+] else
							[ ] ReportStatus(" Verify Rent Details  option ", FAIL, "Rent Details option is not available on History tab.") 
						[ ] // #################Verify Lease Details option in Tenant History###############///
						[+] if (TenantHistory.LeaseDetails.Exists(5))
							[ ] ReportStatus(" Verify Lease Details  option ", PASS, "Lease Details option is available on History tab.") 
						[+] else
							[ ] ReportStatus(" Verify Lease Details  option ", FAIL, "Lease Details option is not available on History tab.") 
						[ ] // #################Verify Help option in Tenant History###############///
						[+] if (TenantHistory.Help.Exists(5))
							[ ] ReportStatus(" Verify Help option ", PASS, "Help option is available on History tab.") 
						[+] else
							[ ] ReportStatus(" Verify Help option ", FAIL, "Help option is not available on History tab.") 
							[ ] 
						[ ] // #################Verify Done option in Tenant History###############///
						[+] if (TenantHistory.Done.Exists(5))
							[ ] ReportStatus(" Verify Done option ", PASS, "Done option is available on History tab.") 
						[+] else
							[ ] ReportStatus(" Verify Done option ", FAIL, "Done option is not available on History tab.") 
						[ ] TenantHistory.Done.Click()
						[ ] WaitForState(TenantHistory,False,2)
						[ ] TenantList.Done.Click()
						[ ] WaitForState(TenantList,False,2)
						[ ] 
					[+] else
						[ ] ReportStatus(" Verify TenantHistory ", FAIL, "TenantHistory did not appear.") 
						[ ] TenantList.Done.Click()
						[ ] WaitForState(TenantList,False,2)
						[ ] 
				[+] else
					[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
				[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test13_VerifyEditedTenantHistoryTab #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_VerifyEditedTenantHistoryTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the contents of Edited Tenant's History	
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying the contents of Edited Tenant's History				
		[ ] //						Fail		If  any error occurs while verifying the contents of Edited Tenant's History		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 17, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test13_VerifyEditedTenantHistoryTab() appstate RPMBaseState
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[2]
	[ ] // Read Property data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] 
	[ ] STRING sDateStamp
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[+] QuickenWindow.SetActive()
				[ ] 
			[ ] // #################Verify options in Tenant History###############///
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(TenantList,true,2)
			[ ] TenantList.SetActive()
			[ ] TenantList.Edit.Click()
			[+] if (AddEditRentalPropertyTenant.Exists(2))
				[ ] AddEditRentalPropertyTenant.SetActive()
				[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditTenantName.SetText(lsAddTenant[1])
				[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.SetFocus()
				[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.Select(lsAddTenant[2])
				[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditRentAmount.SetText(lsAddTenant[3])
				[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.VerifyEnabled(2)
				[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.SetFocus()
				[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.Select(lsAddTenant[4])
				[ ] AddEditRentalPropertyTenant.OK.Click()
				[ ] WaitForState(AddEditRentalPropertyTenant,False,2)
				[+] WaitForState(TenantList,true,2)
					[+] if  (TenantList.Exists(2))
						[ ] hWnd = Str(TenantList.ChildTenantList.QWListViewer1.ListBox1.GetHandle())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
						[ ] sExpected=  lsAddTenant[1]+"@"+lsAddTenant[2]
						[ ] bAssert = MatchStr("*{sExpected}*",sActual)
						[+] if ( bAssert == TRUE)
							[ ] ReportStatus("Verify Tenant edited ", PASS, "Tenant {lsAddTenant[1]} edited in TenantList.") 
							[+] WaitForState(TenantList,true,2)
								[+] if  (TenantList.Exists(2))
									[ ] TenantList.History.Click()
									[ ] WaitForState(TenantHistory,true,2)
									[+] if  (TenantHistory.Exists(2))
										[ ] // #################VerifyTenant Name option in Tenant History###############///
										[ ] 
										[+] if (TenantHistory.TenantName.Exists(5))
											[ ] ReportStatus(" Verify Tenant Name option ", PASS, "Tenant Name option is available on History tab.") 
											[ ] TenantHistory.TenantName.Click()
											[ ] TenantHistory.TenantName.Exists(1)
											[ ] sActual=NULL
											[ ] sExpected=NULL
											[ ] hWnd = Str(TenantHistory.QWListViewer1.ListBox1.GetHandle())
											[ ] sActual= trim(QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0"))
											[ ] sExpected=  sDateStamp+"@"+lsAddTenant[1]
											[ ] bAssert = MatchStr("*{sExpected}*",sActual)
											[+] if ( bAssert == TRUE)
												[ ] ReportStatus("Verify Tenant History ", PASS, "Current value of Tenant Name in Tenant History is {sExpected} as expected") 
											[+] else
												[ ] ReportStatus("Verify Tenant History ", FAIL, "Current value of Tenant Name in Tenant History is {sActual} not as expected {sExpected}.") 
											[ ] 
										[+] else
											[ ] ReportStatus(" Verify Tenant Name option ", FAIL, "Tenant Name option is not available on History tab.") 
										[ ] // #################Verify Property option in Tenant History###############///
										[ ] 
										[+] if (TenantHistory.Property.Exists(5))
											[ ] ReportStatus(" Verify Property  option ", PASS, "Property option is available on History tab.") 
											[ ] TenantHistory.Property.Click()
											[ ] TenantHistory.Property.Exists(1)
											[ ] hWnd = Str(TenantHistory.QWListViewer1.ListBox1.GetHandle())
											[ ] sActual=NULL
											[ ] sExpected=NULL
											[ ] sActual= trim(QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0"))
											[ ] sExpected=  sDateStamp+"@"+lsAddProperty[1]
											[ ] bAssert = MatchStr("*{sExpected}*",sActual)
											[+] if ( bAssert == TRUE)
												[ ] ReportStatus("Verify Tenant History ", PASS, "Current value of Property in Tenant History is {sExpected} as expected") 
											[+] else
												[ ] ReportStatus("Verify Tenant History ", FAIL, "Current value of Property in Tenant History is {sActual} not as expected {sExpected}.") 
											[ ] 
										[+] else
											[ ] ReportStatus(" Verify Property  option ", FAIL, "Property option is not available on History tab.") 
										[ ] // #################Verify Rent Details option in Tenant History###############///
										[ ] 
										[+] if (TenantHistory.RentDetails.Exists(5))
											[ ] ReportStatus(" Verify Rent Details  option ", PASS, "Rent Details option is available on History tab.") 
											[ ] TenantHistory.RentDetails.Click()
											[ ] TenantHistory.RentDetails.Exists(1)
											[ ] sActual=NULL
											[ ] sExpected=NULL
											[ ] hWnd = Str(TenantHistory.QWListViewer1.ListBox1.GetHandle())
											[ ] sActual= trim(QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0"))
											[ ] sExpected=  sDateStamp+"@"+substr(lsAddTenant[3],1,6)
											[ ] bAssert = MatchStr("*{sExpected}*",sActual)
											[+] if ( bAssert == TRUE)
												[ ] ReportStatus("Verify Tenant History ", PASS, "Current value of Tenant Rent in Tenant History is {sExpected} as expected.") 
											[+] else
												[ ] ReportStatus("Verify Tenant History ", FAIL, "Current value of Tenant Rent in Tenant History is {sActual} not as expected {sExpected}.") 
											[ ] 
										[+] else
											[ ] ReportStatus(" Verify Rent Details  option ", FAIL, "Rent Details option is not available on History tab.") 
										[ ] // #################Verify Lease Details option in Tenant History###############///
										[+] if (TenantHistory.LeaseDetails.Exists(5))
											[ ] ReportStatus(" Verify Lease Details  option ", PASS, "Lease Details option is available on History tab.") 
										[+] else
											[ ] ReportStatus(" Verify Lease Details  option ", FAIL, "Lease Details option is not available on History tab.") 
										[ ] // #################Verify Help option in Tenant History###############///
										[+] if (TenantHistory.Help.Exists(5))
											[ ] ReportStatus(" Verify Help option ", PASS, "Help option is available on History tab.") 
										[+] else
											[ ] ReportStatus(" Verify Help option ", FAIL, "Help option is not available on History tab.") 
											[ ] 
										[ ] // #################Verify Done option in Tenant History###############///
										[+] if (TenantHistory.Done.Exists(5))
											[ ] ReportStatus(" Verify Done option ", PASS, "Done option is available on History tab.") 
										[+] else
											[ ] ReportStatus(" Verify Done option ", FAIL, "Done option is not available on History tab.") 
										[ ] TenantHistory.Done.Click()
										[ ] WaitForState(TenantHistory,False,2)
										[ ] TenantList.Done.Click()
										[ ] WaitForState(TenantList,False,2)
										[ ] 
									[+] else
										[ ] ReportStatus(" Verify TenantHistory ", FAIL, "TenantHistory did not appear.") 
										[ ] TenantList.Done.Click()
										[ ] WaitForState(TenantList,False,2)
										[ ] 
								[+] else
									[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Tenant edited", FAIL, "Tenant {lsAddTenant[1]} did not edit in TenantList.") 
							[ ] TenantList.Done.Click()
							[ ] WaitForState(TenantList,False,2)
					[+] else
						[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
				[ ] 
			[+] else
				[ ] ReportStatus(" Verify AddEditRentalPropertyTenant ", FAIL, "AddEdit Rental Property Tenant dialog did not appear.") 
			[ ] // #################Verify Tenant deletion from Tenant List###############///
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(TenantList,true,2)
			[ ] TenantList.SetActive()
			[ ] TenantList.Delete.Exists(2)
			[+] if (TenantList.Delete.IsEnabled())
				[ ] ReportStatus(" Verify Delete button enabled on TenantList screen", PASS, "Delete button enabled on Tenant List screen.") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bAssert=False
				[ ] // //############## Verify Tenant deleted from the TenantList############
				[ ] TenantList.Delete.Click()
				[ ] WaitForState(AlertMessage,True,2)
				[ ] sExpectedErrorMsg="Are you sure you want to delete the tenant named {lsAddTenant[1]}?"
				[ ] sActualErrorMsg=AlertMessage.MessageText.GetText()
				[+] if ( sActualErrorMsg == sExpectedErrorMsg)
					[ ] ReportStatus("Verify Tenant deletion error message", PASS, " {sExpectedErrorMsg} error message displayed.") 
					[ ] 
					[ ] 
					[ ] AlertMessage.Yes.Click()
					[ ] WaitForState(AlertMessage,False,2)
					[ ] hWnd = Str(TenantList.ChildTenantList.QWListViewer1.ListBox1.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
					[ ] sExpected=  lsAddTenant[1]+"@"+lsAddTenant[2]
					[ ] bAssert = MatchStr("*{sExpected}*",sActual)
					[+] if ( bAssert == TRUE)
						[ ] ReportStatus("Verify Tenant deleted", FAIL, "Property {Str(Val(lsAddTenant[1]), NULL, 1)} Tenant not deleted.") 
					[+] else
						[ ] ReportStatus("Verify Tenant deleted", PASS, "Expected -  {sExpected} Tenant is deleted.") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Tenant deletion error message", FAIL, " {sActualErrorMsg}  expected error message not displayed.") 
				[ ] 
			[+] else
				[ ] ReportStatus(" Verify Delete button enabled on TenantList screen", FAIL, "Delete button not enabled on Tenant List screen.") 
			[ ] TenantList.Done.Click()
			[ ] WaitForState(TenantList,False,2)
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test14_VerifyTenantHidden #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_VerifyTenantHidden()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the hide feature of a tenant
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while hiding the tenant and making visible it again					
		[ ] //						Fail		If  error occurs while hiding the tenant and making visible it again					
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 18, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test14_VerifyTenantHidden() appstate  none //RPMBaseState
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=AddRentalPropertyTenant(lsAddTenant)
		[+] if (iResult==PASS)
			[ ] // #################Hide Tenant ###############///
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(TenantList,true,2)
			[+] if  (TenantList.Exists(2))
				[ ] TenantList.SetActive()
				[ ] TenantList.Edit.Click()
				[+] if (AddEditRentalPropertyTenant.Exists(2))
					[ ] AddEditRentalPropertyTenant.SetActive()
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.HideTenant.Check()
					[ ] AddEditRentalPropertyTenant.OK.Click()
					[ ] WaitForState(AddEditRentalPropertyTenant,False,2)
					[ ] // //############## Verify Tenant hidden in the TenantList############
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bAssert=False
					[ ] hWnd = Str(TenantList.ChildTenantList.QWListViewer1.ListBox1.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
					[ ] sExpected=  lsAddTenant[1]+"@"+lsAddTenant[2]
					[ ] bAssert = MatchStr("*{sExpected}*",sActual)
					[+] if ( bAssert == TRUE)
						[ ] ReportStatus("Verify Tenant hidden", FAIL, "Expected -  {sExpected} Tenant did not hide in the Tenant List.") 
						[ ] TenantList.Done.Click()
						[ ] WaitForState(PropertyListTable,False,2)
					[+] else
						[ ] ReportStatus("Verify Tenant hidden", PASS, "Expected -  {sExpected} Tenant has been hidden in the Tenant List.") 
				[+] else
					[ ] ReportStatus(" Verify AddEditRentalPropertyTenant ", FAIL, "AddEdit Rental Property Tenant dialog did not appear.") 
				[ ] ////############## Verify ShowHiddenTenants option displays on the TenantList after hididng a Tenant############
				[ ] WaitForState(TenantList,true,2)
				[ ] TenantList.SetActive()
				[+] if (TenantList.ShowHiddenTenants.Exists(2))
					[ ] ReportStatus(" Verify ShowHiddenTenants option on the Tenant List", PASS, "ShowHiddenTenants option became available on Tenant List.") 
					[ ] TenantList.ShowHiddenTenants.Check()
					[ ] // //############## Verify Tenant hidden in the TenantList############
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bAssert=False
					[ ] hWnd = Str(TenantList.ChildTenantList.QWListViewer1.ListBox1.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
					[ ] sExpected=  lsAddTenant[1]+"@"+lsAddTenant[2]
					[ ] bAssert = MatchStr("*{sExpected}*",sActual)
					[+] if ( bAssert == TRUE)
						[ ] ReportStatus("Verify Tenant hidden", PASS, "Expected -  {sExpected} Tenant became visible in the Tenant List.") 
						[ ] 
						[ ] // //############## Deleting the created Tenant from the TenantList############
						[ ] WaitForState(TenantList,true,2)
						[ ] TenantList.SetActive()
						[ ] TenantList.Delete.Exists(2)
						[+] if (TenantList.Delete.IsEnabled())
							[ ] ReportStatus(" Verify Delete button enabled on TenantList screen", PASS, "Delete button enabled on Tenant List screen.") 
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bAssert=False
							[ ] // //############## Verify Tenant deleted from the TenantList############
							[ ] TenantList.Delete.Click()
							[ ] WaitForState(AlertMessage,True,2)
							[ ] sExpectedErrorMsg="Are you sure you want to delete the tenant named {lsAddTenant[1]}?"
							[ ] sActualErrorMsg=AlertMessage.MessageText.GetText()
							[+] if ( sActualErrorMsg == sExpectedErrorMsg)
								[ ] ReportStatus("Verify Tenant deletion error message", PASS, " {sExpectedErrorMsg} error message displayed.") 
								[ ] AlertMessage.Yes.Click()
								[ ] WaitForState(AlertMessage,False,2)
								[ ] hWnd=NULL
								[ ] sActual=NULL
								[ ] bAssert=False
								[ ] hWnd = Str(TenantList.ChildTenantList.QWListViewer1.ListBox1.GetHandle())
								[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
								[ ] sExpected=  lsAddTenant[1]+"@"+lsAddTenant[2]
								[ ] bAssert = MatchStr("*{sExpected}*",sActual)
								[+] if ( bAssert == TRUE)
									[ ] ReportStatus("Verify Tenant deleted", FAIL, "Property {Str(Val(lsAddTenant[1]), NULL, 1)} Tenant not deleted.") 
									[ ] iFunctionResult = FAIL
								[+] else
									[ ] ReportStatus("Verify Tenant deleted", PASS, "Expected -  {sExpected} Tenant is deleted.") 
									[ ] iFunctionResult = PASS
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Tenant deletion error message", FAIL, " {sActualErrorMsg}  expected error message not displayed.") 
							[ ] TenantList.Done.Click()
							[ ] WaitForState(TenantList,False,2)
						[+] else
							[ ] ReportStatus(" Verify Delete button enabled on TenantList screen", FAIL, "Delete button not enabled on Tenant List screen.") 
							[ ] TenantList.Done.Click()
							[ ] WaitForState(TenantList,False,2)
					[+] else
						[ ] ReportStatus("Verify Tenant hidden", FAIL, "Expected -  {sExpected} Tenant didn't become visible in the Tenant List.") 
						[ ] TenantList.Done.Click()
						[ ] WaitForState(PropertyListTable,False,2)
				[+] else
					[ ] ReportStatus(" Verify ShowHiddenTenants option on the Tenant List", FAIL, "ShowHiddenTenants option didn't appear on Tenant List.") 
					[ ] TenantList.Done.Click()
					[ ] WaitForState(PropertyListTable,False,2)
					[ ] 
			[+] else
				[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
		[+] else
			[ ] ReportStatus("Verify Tenant added", FAIL, "Tenant {lsAddTenant[1]} did not add in TenantList.") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test15_VerifyDuplicateTenantFeature #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_VerifyDuplicateTenantFeature()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the duplicate Tenant validation		
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying the duplicate Tenant validation				
		[ ] //						Fail		If  error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 18, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test15_VerifyDuplicateTenantFeature() appstate RPMBaseState
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=AddRentalPropertyTenant(lsAddTenant)
		[+] if (iResult==PASS)
			[ ] // #################Verify duplicate tenant validation###############///
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(TenantList,true,2)
			[+] if  (TenantList.Exists(2))
				[ ] TenantList.SetActive()
				[ ] TenantList.New.Click()
				[+] if (AddEditRentalPropertyTenant.Exists(2))
					[ ] AddEditRentalPropertyTenant.SetActive()
					[ ] AddEditRentalPropertyTenant.SetActive()
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditTenantName.SetText(lsAddTenant[1])
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.SetFocus()
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListProperty.Select(lsAddTenant[2])
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditRentAmount.SetText(lsAddTenant[3])
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.VerifyEnabled(2)
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.SetFocus()
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.Select(lsAddTenant[4])
					[ ] AddEditRentalPropertyTenant.OK.Click()
					[ ] sMsg1="This name is already assigned to another tenant."
					[ ] sMsg2="Enter a different name in the Rent Details tab."
					[ ] WaitForState(AlertMessage,True,2)
					[+] if ( AlertMessage.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] sValidationText=AlertMessage.MessageText.GetText()
						[ ] bMatch =MatchStr("*{sMsg1}*{sMsg2}*" , sValidationText)
						[+] if (bMatch)
							[ ] ReportStatus(" Verify duplicate Tenant validation", PASS, "Verify duplicate Tenant validation: Validation message: {sValidationText} appeared as expected: {sMsg1}{sMsg2}") 
						[+] else
							[ ] ReportStatus("Verify duplicate Tenant validation", FAIL, "Verify duplicate Tenant validation: Validation message: {sValidationText} didn't appear as expected: {sMsg1}{sMsg2}") 
							[ ] 
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage,False,1)
					[+] else
						[ ] ReportStatus("Verify duplicate Tenant validation", FAIL, " Duplicate Tenant added.") 
					[ ] AddEditRentalPropertyTenant.Cancel.Click()
					[ ] WaitForState(AddEditRentalPropertyTenant,False,1)
				[+] else
					[ ] ReportStatus(" Verify AddEditRentalPropertyTenant ", FAIL, "AddEdit Rental Property Tenant dialog did not appear.") 
				[ ] TenantList.Done.Click()
				[ ] WaitForState(PropertyListTable,False,2)
			[+] else
				[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
		[+] else
			[ ] ReportStatus("Verify Tenant added", FAIL, "Tenant {lsAddTenant[1]} did not add in TenantList.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test16_VerifyTenantListShortcutKeys #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_VerifyTenantListShortcutKeys()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Tenant List Shortcut Keys
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Tenant List Shortcut Keys	
		[ ] //						Fail		If error occurs while verifying Tenant List Shortcut Keys	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 18, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test16_VerifyTenantListShortcutKeys() appstate RPMBaseState
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=AddRentalPropertyTenant(lsAddTenant)
		[+] if (iResult==PASS)
			[ ] // #################Hide Tenant ###############/// KEY_EXIT
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(TenantList,true,2)
			[+] if  (TenantList.Exists(2))
				[ ] TenantList.SetActive()
				[ ] TenantList.TypeKeys(KEY_ALT_N)
				[+] if (AddEditRentalPropertyTenant.Exists(1))
					[ ] ReportStatus(" Verify shortcut keys on Tenant List ", PASS, "{KEY_ALT_N}  key launched Add Rental Property Tenant dialog .") 
					[ ] AddEditRentalPropertyTenant.Cancel.Click()
					[ ] WaitForState(AddEditRentalPropertyTenant,False,2)
				[+] else
					[ ] ReportStatus(" Verify shortcut keys on Tenant List ", FAIL, "{KEY_ALT_N}  key didn't launch Add Rental Property Tenant dialog  .") 
				[ ] TenantList.TypeKeys(KEY_ALT_E)
				[+] if (AddEditRentalPropertyTenant.Exists(1))
					[ ] ReportStatus(" Verify shortcut keys on Tenant List ", PASS, "{KEY_ALT_E}  key launched Edit Rental Property Tenant dialog  .") 
					[ ] AddEditRentalPropertyTenant.Cancel.Click()
					[ ] WaitForState(AddEditRentalPropertyTenant,False,2)
				[+] else
					[ ] ReportStatus(" Verify shortcut keys on Tenant List ", FAIL, "{KEY_ALT_E}  key didn't launch Edit Rental Property Tenant dialog  .") 
				[ ] TenantList.TypeKeys(KEY_ALT_D)
				[+] if (AlertMessage.Exists(1))
					[ ] AlertMessage.SetActive()
					[ ] ReportStatus(" Verify shortcut keys on Tenant List ", PASS, "{KEY_ALT_D}  key launched Delete Rental Property Tenant  confirmation dialog.") 
					[ ] AlertMessage.No.Click()
					[ ] WaitForState(AlertMessage,False,1)
				[+] else
					[ ] ReportStatus(" Verify shortcut keys on Tenant List ", FAIL, "{KEY_ALT_D}  key didn't launch Delete Rental Property Tenant  confirmation dialog.") 
				[ ] TenantList.TypeKeys(KEY_ALT_H)
				[+] if (TenantHistory.Exists(1))
					[ ] ReportStatus(" Verify shortcut keys on Tenant List ", PASS, "{KEY_ALT_H}  key launched Tenant History dialog  .") 
					[ ] TenantHistory.Done.Click()
					[ ] WaitForState(TenantHistory,False,1)
				[+] else
					[ ] ReportStatus(" Verify shortcut keys on Tenant List ", FAIL, "{KEY_ALT_H}  key didn't launch Tenant History dialog .") 
				[ ] TenantList.SetActive()
				[ ] TenantList.Done.Click()
				[ ] WaitForState(TenantList,False,1)
				[ ] 
			[+] else
				[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
		[+] else
			[ ] ReportStatus("Verify Tenant added", FAIL, "Tenant {lsAddTenant[1]} did not add in TenantList.") 
		[ ] 
		[ ] DeleteRentalPropertyTenant(lsAddTenant)
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] 
[ ] 
[+] //############# Test17_VerifySecurityDepositCollected #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_VerifySecurityDepositCollected()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Security Deposit Collected
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Amount Collected 
		[ ] //						Fail		If  error occurs while verifying Amount Collected 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 22, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test17_VerifySecurityDepositCollected() appstate RPMBaseState
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] sAmountCollected= "500.45"
	[ ] sAmountReturned="500.46"
	[ ] 
	[ ] sPayee ="Hong"
	[ ] sCategory="[*Security Deposit Liability*]"
	[ ] sMemo="Collected security deposit"
	[ ] sExpReportTitle= "Cash Flow"
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=AddRentalPropertyTenant(lsAddTenant)
		[+] if (iResult==PASS)
			[ ] // #################Verify AmountCollected can not be less than the  Amount Returned###############/// 
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(TenantList,true,2)
			[+] if  (TenantList.Exists(2))
				[ ] TenantList.SetActive()
				[ ] TenantList.Edit.Click()
				[+] if (AddEditRentalPropertyTenant.Exists(2))
					[ ] AddEditRentalPropertyTenant.SetActive()
					[ ] AddEditRentalPropertyTenant.SecurityDeposit.Click(1,446,12)
					[ ] WaitForState(AddEditRentalPropertyTenant.SecurityDeposit,true,2)
					[ ] AddEditRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountCollected.SetText(sAmountCollected)
					[ ] AddEditRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountReturned.SetText(sAmountReturned)
					[ ] AddEditRentalPropertyTenant.OK.Click()
					[ ] 
					[ ] sMsg1="Security Deposit: The amount returned cannot be more than the amount collected."
					[ ] 
					[+] if ( AlertMessage.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] sValidationText=AlertMessage.MessageText.GetText()
						[ ] bMatch =MatchStr("*{sMsg1}*" , sValidationText)
						[+] if (bMatch)
							[ ] ReportStatus("  Verify Amount Collected can not be less than the  Amount Returned.", PASS, " Verify Amount Collected can not be less than the Amount Returned: Validation message: {sValidationText} appeared as expected: {sMsg1}") 
						[+] else
							[ ] ReportStatus(" Verify Amount Collected can not be less than the  Amount Returned.", FAIL, " Verify Amount Collected can not be less than the  Amount Returned: Validation message: {sValidationText} didn't appear as expected: {sMsg1}") 
							[ ] 
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage,False,1)
						[ ] 
					[+] else
						[ ] ReportStatus(" Verify Amount Collected can not be less than the Amount Returned.", FAIL, "Amount Returned became higher than the Amount Collected .") 
					[ ] AddEditRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountCollected.ClearText()
					[ ] AddEditRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountReturned.ClearText()
					[ ] // #################Verify the *Security Deposit Liability* account gets created###############/// 
					[ ] 
					[ ] AddEditRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountCollected.SetText(sAmountCollected)
					[ ] AddEditRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountReturned.SetText("0")
					[ ] AddEditRentalPropertyTenant.OK.Click()
					[ ] WaitForState(AddEditRentalPropertyTenant,False,1)
					[ ] WaitForState(TenantList,true,2)
				[+] else
					[ ] ReportStatus(" Verify AddEditRentalPropertyTenant ", FAIL, "AddEdit Rental Property Tenant dialog did not appear.") 
				[ ] TenantList.SetActive()
				[ ] TenantList.Done.Click()
				[ ] WaitForState(TenantList,False,1)
			[+] else
				[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] iResult=SelectAccountFromAccountBar(sSecurityDepositLiability , ACCOUNT_RENTALPROPERTY)
			[ ] //Verify SecurityDepositLiability account on AccountBar
			[+] if (iResult == PASS)
				[ ] ReportStatus(" Verify Security Deposit Liability account created", PASS, "{sSecurityDepositLiability} is present in Account Bar") 
				[ ] // #################Verify AmountCollected transaction in the *Security Deposit Liability* account###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
				[+] if (DlgFindAndReplace.Exists(5))
					[ ] DlgFindAndReplace.SetActive()
					[ ] 
					[ ] DlgFindAndReplace.SearchTextField.SetText(sSecurityDepositLiability)
					[ ] DlgFindAndReplace.FindButton.Click()
					[ ] hWnd = str(DlgFindAndReplace.FoundListBox.ListBox1.GetHandle())
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
					[ ] bMatch = MatchStr("*{sPayee}*{sCategory}*{sMemo}*{sAmountCollected}*", sActual)
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Collected Amount Transaction ", PASS, "Amount Collected with Payee: {sPayee}, Category: {sCategory}, Memo: {sMemo}, Amount Collected: {sAmountCollected} has been entered in the {sSecurityDepositLiability} account.") 
					[+] else
						[ ] ReportStatus(" Verify Collected Amount Transaction ", FAIL, "AmountCollected could not be entered in the -  {sSecurityDepositLiability} account.") 
					[ ] DlgFindAndReplace.DoneButton.Click()
				[+] else
					[ ] ReportStatus("Verify Find and Replace dialog", FAIL, " Find and Replace dialog didn't appear.") 
			[+] else
				[ ] ReportStatus("Verify Security Deposit Liability account created", FAIL, "Actual -  {sActual} is not matching with Expected - {sSecurityDepositLiability}") 
				[ ] 
			[ ] // Set Activate main window
			[ ] QuickenWindow.SetActive()
			[ ] // Open Cash Flow Report
			[ ] iReportSelect = OpenReport(lsReportCategory[1], sREPORT_CASH_FLOW)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sREPORT_CASH_FLOW} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify Cash Flow Report is Opened
				[+] if (CashFlow.Exists(5))
					[ ] 
					[ ] // Set Active Cash Flow Report 
					[ ] CashFlow.SetActive()
					[ ] 
					[ ] // Maximize Cash Flow Report 
					[ ] CashFlow.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = CashFlow.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = AssertEquals(sExpReportTitle, sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] hWnd = Str(CashFlow.QWListViewer1.ListBox1.GetHandle ())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,"1")
						[ ] bMatch = MatchStr("*{sPayee}*{sCategory}*{sMemo}*{sAmountCollected}*", sActual)
						[+] if(bMatch)
							[ ] ReportStatus("Validate Report Data", FAIL, "Security Deposit collected amount is getting displayed in {sREPORT_CASH_FLOW}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", PASS, "Security Deposit collected amount is not getting displayed in {sREPORT_CASH_FLOW}.")
					[ ] // Report Status if window title is wrong
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title  -  {sActual} is not matching with Expected - {sExpReportTitle}") 
					[ ] 
					[ ] // Close Cash Flow Report window
					[ ] CashFlow.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verification of {sExpReportTitle} window", FAIL, "{sExpReportTitle} window not found") 
					[ ] 
			[+] else
				[ ] ReportStatus("Run {sREPORT_CASH_FLOW} Report", iReportSelect, "Run Report unsuccessful") 
				[ ] 
		[+] else
			[+] ReportStatus("Verify Tenant Added ", FAIL, "Tenant could not be added ") 
				[ ] 
		[ ] 
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] 
	[ ] 
[ ] 
[+] //############# Test18_VerifySecurityDepositReturned #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_VerifySecurityDepositReturned()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Security Deposit Returned
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Amount Returned 
		[ ] //						Fail		If  error occurs while verifying Amount Returned 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 22, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test18_VerifySecurityDepositReturned() appstate RPMBaseState
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] sAmountReturned="300.45"
	[ ] sPayee ="Hong"
	[ ] sCategory="[*Security Deposit Liability*]"
	[ ] sMemo="Returned security deposit"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=AddRentalPropertyTenant(lsAddTenant)
		[+] if (iResult==PASS)
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(TenantList,true,2)
			[+] if  (TenantList.Exists(2))
				[ ] TenantList.SetActive()
				[ ] TenantList.Edit.Click()
				[+] if (AddEditRentalPropertyTenant.Exists(2))
					[ ] AddEditRentalPropertyTenant.SetActive()
					[ ] AddEditRentalPropertyTenant.SecurityDeposit.Click(1,446,12)
					[ ] WaitForState(AddEditRentalPropertyTenant.SecurityDeposit,true,2)
					[ ] AddEditRentalPropertyTenant.SecurityDeposit.QWinChild1.EditAmountReturned.SetText(sAmountReturned)
					[ ] AddEditRentalPropertyTenant.OK.Click()
					[ ] WaitForState(AddEditRentalPropertyTenant,False,1)
				[+] else
					[ ] ReportStatus(" Verify AddEditRentalPropertyTenant ", FAIL, "AddEdit Rental Property Tenant dialog did not appear.") 
				[ ] WaitForState(TenantList,true,2)
				[ ] TenantList.SetActive()
				[ ] TenantList.Done.Click()
				[ ] WaitForState(TenantList,False,1)
			[+] else
				[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] iResult=SelectAccountFromAccountBar(sSecurityDepositLiability , ACCOUNT_RENTALPROPERTY)
			[ ] //Verify SecurityDepositLiability account on AccountBar
			[+] if (iResult == PASS)
				[ ] ReportStatus(" Verify Security Deposit Liability account created", PASS, "{sSecurityDepositLiability} is present in Account Bar") 
				[ ] // #################Verify Amount Returned transaction in the *Security Deposit Liability* account###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
				[+] if (DlgFindAndReplace.Exists(5))
					[ ] DlgFindAndReplace.SetActive()
					[ ] DlgFindAndReplace.SearchTextField.SetText(sSecurityDepositLiability)
					[ ] DlgFindAndReplace.FindButton.Click()
					[ ] hWnd = str(DlgFindAndReplace.FoundListBox.ListBox1.GetHandle())
					[ ] iListCount =DlgFindAndReplace.FoundListBox.ListBox1.GetItemCount()+1
					[+] for (iCount =0 ; iCount< iListCount ; ++iCount)
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, str(iCount) )
						[ ] bMatch = MatchStr("*{sPayee}*{sCategory}*{sMemo}*{sAmountReturned}*", sActual)
						[+] if ( bMatch )
							[ ] break
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Returned Amount Transaction ", PASS, "Amount Returned with Payee: {sPayee}, Category: {sCategory}, Memo: {sMemo}, Amount Returned : {sAmountReturned} has been entered in the {sSecurityDepositLiability} account.") 
					[+] else
						[ ] ReportStatus(" Verify Returned Amount Transaction ", FAIL, "Amount Returned  entered  {sActual }in the {sSecurityDepositLiability} account is not same as: expected Payee: {sPayee}, Category: {sCategory}, Memo: {sMemo}, Amount Returned : {sAmountReturned}. Defect id is =") 
					[ ] DlgFindAndReplace.DoneButton.Click()
				[+] else
					[ ] ReportStatus("Verify Find and Replace dialog", FAIL, " Find and Replace dialog didn't appear.") 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Security Deposit Liability account created", FAIL, "Verify Security Deposit Liability account create: Actual -  {sActual} is not matching with Expected - {sSecurityDepositLiability}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Tenant Added ", FAIL, "Tenant could not be added ") 
		[ ] 
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] 
	[ ] 
[ ] 
[+] //############# Test19_VerifyTenantDueDateInRentCenter #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_VerifyTenantDueDateInRentCenter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Rent due date in Rent Center
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Rent due date in Rent Center
		[ ] //						Fail		If  error occurs while verifying Rent due date in Rent Center
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 25, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
[+] testcase Test19_VerifyTenantDueDateInRentCenter() appstate RPMBaseState
	[ ] STRING  sRentDueOn , sDefaultRentDueOn
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] sAmountReturned="300.45"
	[ ] sPayee ="Hong"
	[ ] sCategory="[*Security Deposit Liability*]"
	[ ] sMemo="Returned security deposit"
	[ ] sDefaultRentDueOn="1st"
	[ ] sAmountPaid=trim(Left(lsAddTenant[3],6))
	[ ] 
	[ ] 
	[ ] sRentDueOn="5th"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=AddRentalPropertyTenant(lsAddTenant)
		[+] if (iResult==PASS)
			[ ] // #################Verify Default Rent Due date in Rent Center###############/// 
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] hWnd = str(RentalPropertyRentCenter.Panel.QWListViewer1.ListBox1.GetHandle())
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
			[ ] bMatch = MatchStr("*{lsAddTenant[6]}*{sDefaultRentDueOn}*{sAmountPaid}*", sActual)
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify Default Rent Due date for a Tenant in Rent Center ", PASS, "Tenant with: {sPayee}, Property: {lsAddTenant[6]}, Name: {sAmountPaid}, Default Rent Due On : {sDefaultRentDueOn} and with rent {lsAddTenant[3]} is present  in rent Center.") 
			[+] else
				[ ] ReportStatus(" Verify Default Rent Due date for a Tenant in Rent Center ", FAIL, "Tenant with: {sPayee}, Property: {lsAddTenant[6]}, Name: {sAmountPaid}, Default Rent Due On : {sDefaultRentDueOn} and with rent {lsAddTenant[3]} is not present  in rent Center.") 
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(Replicate (KEY_DN, 4))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.TypeKeys(KEY_ENTER)
			[ ] WaitForState(TenantList,true,2)
			[+] if  (TenantList.Exists(2))
				[ ] TenantList.SetActive()
				[ ] TenantList.Edit.Click()
				[+] if (AddEditRentalPropertyTenant.Exists(2))
					[ ] AddEditRentalPropertyTenant.SetActive()
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListRentDueOn.SetFocus()
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListRentDueOn.Select(trim(sRentDueOn))
					[ ] AddEditRentalPropertyTenant.OK.Click()
					[ ] WaitForState(AddEditRentalPropertyTenant,False,1)
				[+] else
					[ ] ReportStatus(" Verify AddEditRentalPropertyTenant ", FAIL, "AddEdit Rental Property Tenant dialog did not appear.") 
				[ ] WaitForState(TenantList,true,1)
				[ ] TenantList.SetActive()
				[ ] TenantList.Done.Click()
				[ ] WaitForState(TenantList,FALSE,1)
			[+] else
				[ ] ReportStatus(" Verify TenantList ", FAIL, "TenantList did not appear.") 
			[ ] // #################Verify Rent Due date in Rent Center when Due Date has been changed###############/// 
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] hWnd = str(RentalPropertyRentCenter.Panel.QWListViewer1.ListBox1.GetHandle())
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
			[ ] bMatch = MatchStr("*{lsAddTenant[6]}*{sRentDueOn}*{sAmountPaid}*", sActual)
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify Rent Due date in Rent Center ", PASS, "Tenant with: {sPayee}, Property: {lsAddTenant[6]}, Name: {lsAddTenant[2]}, Rent Due On : {sRentDueOn} and with rent {sAmountPaid} is present  in rent Center.") 
			[+] else
				[ ] ReportStatus(" Verify Rent Due date in Rent Center ", FAIL, "Tenant with: {sPayee}, Property: {lsAddTenant[6]}, Name: {lsAddTenant[2]}, Rent Due On : {sRentDueOn} and with rent {sAmountPaid} is not present  in rent Center.") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Tenant Added ", FAIL, "Tenant could not be added ") 
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] 
[ ] 
[+] //############# Test20_VerifyRentCenterAddTransactionsOptions ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_VerifyRentCenterAddTransactionsOptions ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Rent Center >AddTransactions options when a tenant is added
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Rent Center >AddTransactions options when a tenant is added
		[ ] //						Fail		If error occurs while verifying Rent Center >AddTransactions options when a tenant is added
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 25, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
	[ ] 
	[ ] 
[+] testcase Test20_VerifyRentCenterAddTransactionsOptions() appstate RPMBaseState
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=AddRentalPropertyTenant(lsAddTenant)
		[+] if (iResult==PASS)
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[+] if (QuickenMainWindow.QWNavigator1.AddTransactions.Exists(5))
				[ ] //############## Verify Enter Rent button when a Tenant has been added############
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
				[ ] WaitForState(DlgEnterRent,True,1)
				[+] if (DlgEnterRent.Exists(2))
					[ ] //sValidationText=DlgEnterRent.GetCaption()
					[ ] ReportStatus(" Verify Enter Rent button when a Tenant has been added", PASS, "Enter Rent dialog displayed.") 
					[ ] DlgEnterRent.CancelButton.Click()
					[ ] WaitForState(DlgEnterRent,False,1)
				[+] else
					[ ] ReportStatus(" Verify Enter Rent button when a Tenant has been added", FAIL, "Enter Rent dialog did not display.") 
			[+] else
				[ ] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", FAIL, "AddTransactions button does not exist on Rental Property screen.") 
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[+] if (QuickenMainWindow.QWNavigator1.AddTransactions.Exists(5))
				[ ] //############## Verify Enter Expense button when a Tenant has been added############
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(Replicate (KEY_DN, 2))	
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
				[ ] WaitForState(DlgEnterExpense,True,1)
				[+] if (DlgEnterExpense.Exists(4))
					[ ] ReportStatus(" Verify Enter Expense button when a Tenant has been added", PASS, "Enter Expense dialog displayed.") 
					[ ] DlgEnterExpense.CancelButton.Click()
					[ ] WaitForState(DlgEnterExpense,False,1)
				[+] else
					[ ] ReportStatus(" Verify Enter Expense button when a Tenant has been added", FAIL, "Enter Expense dialog did not display.") 
			[+] else
				[ ] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", FAIL, "AddTransactions button does not exist on Rental Property screen.") 
			[+] if (QuickenMainWindow.QWNavigator1.AddTransactions.Exists(5))
				[ ] //############## Verify Enter Expense button when a Tenant has been added############
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(Replicate (KEY_DN, 3))	
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
				[ ] WaitForState(DlgEnterOtherIncome,True,1)
				[+] if (DlgEnterOtherIncome.Exists(5))
					[ ] ReportStatus(" Verify Enter Other Income button when a Tenant has been added", PASS, "Enter Other Income dialog displayed.") 
					[ ] DlgEnterOtherIncome.CancelButton.Click()
					[ ] WaitForState(DlgEnterOtherIncome,False,1)
				[+] else
					[ ] ReportStatus(" Verify Enter Other Income button when a Tenant has been added", FAIL, "Enter Other Income dialog did not display.") 
			[+] else
				[ ] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", FAIL, "AddTransactions button does not exist on Rental Property screen.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Tenant Added ", FAIL, "Tenant could not be added ") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test21_VerifyAddRentOnProfitLoss ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_VerifyAddRentOnProfitLoss()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify ProfitLoss> Rent Paid
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying ProfitLoss> Rent Paid
		[ ] //						Fail		If  error occurs while verifying ProfitLoss> Rent Paid
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 27, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
	[ ] 
	[ ] 
[+] testcase Test21_VerifyAddRentOnProfitLoss() appstate RPMBaseState
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet 
	[ ] lsAddTenant=lsExcelData[1]
	[ ] // Read Rent data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sRentWorksheet)
	[ ] // Fetch 1st row from the given sheet sRentWorksheet
	[ ] lsRent=lsExcelData[1]
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sAmountPaid=trim(Left(lsRent[5],6))
	[ ] 
	[ ] sFaRAmountField=trim("Amount")
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate toRentalProperty > Profit Loss############
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
		[ ] QuickenWindow.SetActive()
		[+] if (QuickenMainWindow.QWNavigator1.AddTransactions.Exists(5))
			[ ] //############## Verify Enter Rent button when a Tenant has been added############
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
			[ ] WaitForState(DlgEnterRent,True,1)
			[ ] WaitForState(DlgEnterRent,True,1)
			[+] if (DlgEnterRent.Exists(2))
				[ ] DlgEnterRent.PropertyPopupList.SetFocus()
				[ ] DlgEnterRent.PropertyPopupList.Select(lsRent[1])
				[ ] DlgEnterRent.DateTextField.SetText(sDateStamp)
				[ ] DlgEnterRent.RentRecievedTextField.SetText(lsRent[5])
				[ ] DlgEnterRent.AddButton.Click()
				[ ] WaitForState(DlgEnterRent,False,1)
				[ ] WaitForState(QuickenMainWindow,True,1)
				[ ] WaitForState(RentalPropertyRentCenter,True,1)
				[ ] sleep(3)
				[ ] // #################Verify Rent Paid is displayed under Profit Loss###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] WaitForState(RentalPropertyRentCenter,True,2)
				[ ] hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
				[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Rent Paid is displayed under Profit Loss ", PASS, " {sAmountPaid} amount has been updated in the IN section of Profit and Loss.") 
					[ ] // #################Verify Rent Collected transaction in the Recorded Deposits Popup ###############/// 
					[ ] // #################Recorded Deposits Popup is clicked with the help of Location Identifier###############/// 
					[ ] RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.Click(1,49,4)
					[ ] WaitForState(RecordedDepositsCallout,True,2)
					[ ] sleep(4)
					[+] if (RecordedDepositsCallout.Exists(5))
						[ ] // ReportStatus("Verify Recorded Deposits become link. ", PASS, "Recorded Deposits text become link. ") 
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
						[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bMatch = MatchStr("*{lsRent[2]}*{sAmountPaid}*", sActual)
							[+] if (bMatch )
								[ ] break
						[ ] 
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify Rent Collected transaction in the Recorded Deposits Popup", PASS, " Transaction with Payee:{lsRent[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has been added to the Recorded Deposits CallOut. ") 
						[+] else
							[ ] ReportStatus(" Verify Rent Collected transaction in the Recorded Deposits Popup", FAIL, " Transaction with Payee:{lsRent[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Recorded Deposits CallOut is {sActual}. ") 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] sleep(1)
						[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
						[ ] sleep(1)
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
						[ ] sExpReportTitle=NULL
						[ ] sExpReportTitle="Schedule E"
						[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
						[+] if (iReportSelect==PASS)
							[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
							[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
							[+] if (ScheduleEReportWindow.Exists(5))
								[ ] 
								[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
								[ ] ScheduleEReportWindow.SetActive()
								[ ] 
								[ ] // Maximize sTAB_SHEDULE_E_REPORT 
								[ ] ScheduleEReportWindow.Maximize()
								[ ] 
								[ ] // Get window caption
								[ ] sActual = ScheduleEReportWindow.GetCaption()
								[ ] 
								[ ] // Verify window title
								[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
								[ ] 
								[ ] // Report Status if window title is as expected
								[+] if ( bMatch )
									[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
									[ ] //  Validate Report Data
									[ ] hWnd=NULL
									[ ] sActual=NULL
									[ ] bMatch=FALSE
									[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer.ListBox1.GetHandle ())
									[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,"3")
									[ ] bMatch = MatchStr("*{lsRent[2]}*{lsRent[6]}*{lsRent[1]}*{sAmountPaid}*", sActual)
									[+] if(bMatch)
										[ ] ReportStatus("Validate Report Data", PASS, " Transaction with Payee :{lsRent[2]},Cat: {lsRent[6]},Tag: {lsRent[1]} and Rent Amount: {sAmountPaid} get displayed on  {sTAB_SHEDULE_E_REPORT}.")
									[+] else
										[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with Payee: {lsRent[2]},Cat: {lsRent[6]},Tag: {lsRent[1]}  and Rent Amount: {sAmountPaid} didn't display on {sTAB_SHEDULE_E_REPORT} and actual data is {sActual}.")
								[+] else
									[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
								[ ] ScheduleEReportWindow.Close()
								[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
								[ ] /////#######Report validation done#######///
							[+] else
								[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
						[+] else
							[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
					[+] else
						[ ] ReportStatus("Verify Recorded Deposits become link. ", FAIL, "Recorded Deposits text does not become link. ") 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] // #################Verify Rent Collected transaction in the Checking Account ###############/// 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] WaitForState(QuickenWindow,True,2)
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
					[+] if (DlgFindAndReplace.Exists(5))
						[ ] 
						[ ] DlgFindAndReplace.SearchTextField.SetText(sAmountPaid)
						[ ] DlgFindAndReplace.FindButton.Click()
						[ ] hWnd = str(DlgFindAndReplace.FoundListBox.ListBox1.GetHandle())
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
						[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify Rent Paid is displayed in Checking Account ", PASS, " {sAmountPaid} amount has been added in the Checking Account. ") 
							[ ] DlgFindAndReplace.SelectAllButton.Click()
							[ ] DlgFindAndReplace.ReplacePopupList.SetFocus()
							[ ] DlgFindAndReplace.ReplacePopupList.Select(sFaRAmountField)
							[ ] DlgFindAndReplace.ReplacementTextField.SetText("-{sAmountPaid}")
							[ ] DlgFindAndReplace.ReplaceAllButton.Click()
							[ ] WaitForState(DlgFindAndReplace.DoneButton,True,1)
							[ ] DlgFindAndReplace.DoneButton.Click()
							[ ] WaitForState(DlgFindAndReplace,False,1)
							[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
							[ ] // #################Verify Rent Paid converted to Payment is displayed as negative amount under Profit Loss###############/// 
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] WaitForState(QuickenWindow,True,2)
							[ ] WaitForState(RentalPropertyRentCenter,True,2)
							[ ] hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.GetHandle())
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
							[ ] bMatch = MatchStr("*-{sAmountPaid}*", sActual)
							[+] if ( bMatch )
								[ ] ReportStatus(" Verify Rent Paid converted to Payment  ", PASS, " -{sAmountPaid} amount has been updated in the IN section of Profit and Loss.") 
							[+] else
								[ ] ReportStatus(" Verify Rent Paid converted to Payment  ", FAIL, " -{sAmountPaid} amount didn't update in the IN section of Profit and Loss.") 
						[+] else
							[ ] ReportStatus(" Verify Rent Paid Transaction ", FAIL, "{sAmountPaid} amount has not been added in the Checking Account.") 
					[+] else
						[ ] ReportStatus("Verify Find and Replace dialog", FAIL, " Find and Replace dialog didn't appear.") 
					[ ] 
				[+] else
					[ ] ReportStatus(" Verify Rent Paid is displayed under Profit Loss ", FAIL, " {sAmountPaid} amount didn't update in the IN section of Profit and Loss.") 
			[+] else
				[ ] ReportStatus(" Verify Enter Rent dialog when a Tenant has been added", FAIL, "Enter Rent dialog did not display.") 
		[+] else
			[ ] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", FAIL, "AddTransactions button does not exist on Rental Property screen.") 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] 
[+] //############# Test22_VerifyUpcomingIncomeOnProfitLoss ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_VerifyUpcomingIncomeOnProfitLoss()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify ProfitLoss> Upcoming Income
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying ProfitLoss> Upcoming Income
		[ ] //						Fail		If error occurs while verifying ProfitLoss> Upcoming Income
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 30, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test22_VerifyUpcomingIncomeOnProfitLoss() appstate RPMBaseState
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet 
	[ ] lsAddTenant=lsExcelData[1]
	[ ] // Read Rent data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sReminderSheet)
	[ ] // Fetch 1st row from the given sheet sReminderSheet
	[ ] IncTranReminderRecord rIncTranReminderRecord
	[ ] lsReminder=lsExcelData[1]
	[ ] rIncTranReminderRecord=lsReminder
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sAmountPaid=trim(Left(rIncTranReminderRecord.sAmount,6))
	[ ] STRING  sReminderStatus
	[ ] sFaRAmountField=trim("Amount")
	[ ] sReminderStatus= "Due Today"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate toRentalProperty > Profit Loss############ .Click (1, 92, 22)
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
		[ ] QuickenWindow.SetActive()
		[+] if (RentalPropertyRentCenter.Exists(1))
			[ ] RentalPropertyRentCenter.InOutProfitLoss.PanelExpenses.Click(1,113,12)
			[ ] RentalPropertyRentCenter.InOutProfitLoss.Panel2.StaticText1.StaticText3.AddReminderButton.Click()
			[ ] RentalPropertyRentCenter.TypeKeys(Replicate (KEY_DN, 2))	
			[ ] RentalPropertyRentCenter.TypeKeys(KEY_ENTER)
			[ ] WaitForState(DlgAddEditReminder,TRUE,1)
			[+] if(DlgAddEditReminder.Exists(5))
				[ ] DlgAddEditReminder.SetActive ()
				[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText(rIncTranReminderRecord.sPayeeName)
				[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
				[ ] DlgAddEditReminder.NextButton.Click()
				[ ] DlgAddEditReminder.SetActive ()
				[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText(rIncTranReminderRecord.sPayeeName)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(rIncTranReminderRecord.sAmount)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText (rIncTranReminderRecord.sToAccount)
				[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.Typekeys(KEY_TAB)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click (1, 92, 22)
				[ ] Agent.SetOption (OPT_SCROLL_INTO_VIEW, FALSE)
				[ ] DlgOptionalSetting.CategoryTextField.SetText (rIncTranReminderRecord.sCategory)
				[ ] DlgOptionalSetting.TypeKeys(KEY_TAB)
				[ ] DlgOptionalSetting.TagTextField.SetText (rIncTranReminderRecord.sTag)
				[ ] DlgOptionalSetting.MemoTextField.SetText (rIncTranReminderRecord.sMemo)
				[ ] DlgOptionalSetting.OKButton.Click()
				[+] if(DlgOptionalSetting.NewTag.Exists(2))
					[ ] DlgOptionalSetting.NewTag.SetActive ()
					[ ] DlgOptionalSetting.NewTag.TagOKButton.Click (1, 23, 13)
				[ ] 
				[ ] DlgAddEditReminder.SetActive ()
				[ ] Agent.SetOption (OPT_SCROLL_INTO_VIEW, TRUE)
				[ ] DlgAddEditReminder.DoneButton.Click ()
				[ ] WaitForState(DlgAddEditReminder,FALSE,1)
				[ ] WaitForState(QuickenWindow,True,1)
				[ ] // #################Verify Upcoming Income  Reminder in the Rental Property Reminders grid###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] QuickenWindow.SetActive()
				[ ] WaitForState(RentalPropertyRentCenter,True,2)
				[ ] sleep(5)
				[ ] hWnd = str(RentalPropertyRentCenter.ListBox5.GetHandle())
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox5.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[ ] 
				[ ] //sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
				[ ] //bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Income Reminder created ", PASS, " Income Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been created in the Rental Property Reminders section of Profit and Loss.") 
					[ ] 
					[ ] // #################Verify Upcoming Income is displayed under Profit Loss###############/// 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] WaitForState(QuickenWindow,True,2)
					[ ] WaitForState(RentalPropertyRentCenter,True,2)
					[ ] hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.GetHandle())
					[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
						[+] if ( bMatch )
							[ ] break
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Upcoming Income is displayed under Profit Loss ", PASS, " {sAmountPaid} amount has been updated in the IN section of Profit and Loss.") 
						[ ] // #################Verify Upcoming Income  transaction in the Upcoming Income Popup ###############/// 
						[ ] RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.Click(1,37,23)
						[ ] sleep(4)
						[+] if (RecordedDepositsCallout.Exists(5))
							[ ] ReportStatus("Verify Upcoming Income became link. ", PASS, "Upcoming Income text became link. ") 
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
							[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sAmountPaid}*", sActual)
								[+] if ( bMatch )
									[ ] break
							[+] if ( bMatch )
								[ ] ReportStatus(" Verify Upcoming Income in the Upcoming Income Popup", PASS, " Upcoming Income with Payee:{rIncTranReminderRecord.sPayeeName}, Date:{sDateStamp},and Amount:{sAmountPaid} has been added to the Upcoming Income CallOut. ") 
							[+] else
								[ ] ReportStatus(" Verify Upcoming Income in the Upcoming Income Popup", FAIL, " Upcoming Income with Payee:{rIncTranReminderRecord.sPayeeName}, Date:{sDateStamp},and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Upcoming Income CallOut is {sActual}. ") 
							[ ] QuickenWindow.SetActive()
							[ ] sleep(1)
							[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Upcoming Income became link. ", FAIL, "Upcoming Income text does not  become link. ") 
					[+] else
						[ ] ReportStatus(" Verify Upcoming Income is displayed under Profit Loss ", FAIL, " {sAmountPaid} amount didn't update in the IN section of Profit and Loss.") 
				[+] else
					[ ] ReportStatus(" Verify Income Reminder created ", FAIL, " Income Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been created in the Rental Property Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
			[+] else
				[ ] ReportStatus("Verify Reminder Exists. ", FAIL, "Reminder dialog does not exist. ") 
		[+] else
			[ ] ReportStatus("Verify RentalProperty > RentCenter Exists. ", FAIL, "RentalProperty > RentCenter  does not exist. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test23_VerifyAddExpenseOnProfitLoss ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_VerifyAddExpenseOnProfitLoss()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Enter Expense in Rental Property > ProfitLoss
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying ProfitLoss> Enter Expense
		[ ] //						Fail		If error occurs while verifying ProfitLoss> Enter Expense
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 30, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test23_VerifyAddExpenseOnProfitLoss() appstate RPMBaseState
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet 
	[ ] lsAddTenant=lsExcelData[1]
	[ ] // Read Expense data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sExpenseSheet)
	[ ] // Fetch 1st row from the given sheet sExpenseSheet
	[ ] lsExpense=lsExcelData[1]
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sAmountPaid=trim(Left(lsExpense[5],6))
	[ ] 
	[ ] sFaRAmountField=trim("Amount")
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate to RentalProperty > Profit Loss############
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
		[ ] QuickenWindow.SetActive()
		[+] if (QuickenMainWindow.QWNavigator1.AddTransactions.Exists(5))
			[ ] //############## Verify Enter Expense button when a Tenant has been added############
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(Replicate (KEY_DN, 2))	
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
			[ ] WaitForState(DlgEnterExpense,True,1)
			[+] if (DlgEnterExpense.Exists(4))
				[ ] DlgEnterExpense.PropertyPopupList.SetFocus()
				[ ] DlgEnterExpense.PropertyPopupList.Select(lsExpense[1])
				[ ] DlgEnterExpense.PayToTextField.SetText(lsExpense[2])
				[ ] DlgEnterExpense.CategoryTextField.SetText(lsExpense[3])
				[ ] // CategoryQuickList.SetActive()
				[ ] // CategoryQuickList.TypeKeys(KEY_ESC)
				[ ] WaitForState(DlgEnterExpense,True,1)
				[ ] DlgEnterExpense.SetActive()
				[ ] DlgEnterExpense.DateTextField.SetText(sDateStamp)
				[ ] DlgEnterExpense.AmountToBePaidTextField.SetText(lsExpense[5])
				[ ] DlgEnterExpense.AddButton.Click()
				[ ] WaitForState(DlgEnterExpense,False,1)
				[ ] WaitForState(QuickenMainWindow,True,1)
				[ ] WaitForState(RentalPropertyRentCenter,True,1)
				[ ] // #################Verify Rent Expense is displayed under Profit Loss under OUT section###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] WaitForState(RentalPropertyRentCenter,True,2)
				[ ] sleep(5)
				[ ] hWnd = str(RentalPropertyRentCenter.ListBox2.GetHandle())
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox2.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[ ] 
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Expense is displayed under Profit Loss ", PASS, " {sAmountPaid} amount has been updated in the OUT section of Profit and Loss.") 
					[ ] // #################Verify Rent Collected transaction in the Recorded Deposits Popup ###############/// 
					[ ] // #################Recorded Expense Popup is clicked with the help of Location Identifier###############/// 
					[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
					[ ] sleep(4)
					[ ] WaitForState(RecordedDepositsCallout,True,2)
					[+] if (RecordedDepositsCallout.Exists(5))
						[ ] ReportStatus("Verify Recorded Expenses text became link. ", PASS, "Recorded Expenses text became link. ") 
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
						[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bMatch = MatchStr("*{lsExpense[3]}*{sAmountPaid}*", sActual)
							[ ] 
							[+] if ( bMatch )
								[ ] break
						[ ] 
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify Rent Collected transaction in the Recorded Deposits Popup", PASS, " Transaction with Payee:{lsExpense[3]} and Amount:{sAmountPaid} has been added to the Recorded Deposits CallOut. ") 
						[+] else
							[ ] ReportStatus(" Verify Rent Collected transaction in the Recorded Deposits Popup", FAIL, " Transaction with Payee:{lsExpense[3]} and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Recorded Deposits CallOut is {sActual}. ") 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] sleep(1)
						[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
					[+] else
						[ ] ReportStatus("Verify Recorded Expenses text became link. ", FAIL, "Recorded Expenses text does not become link. ") 
						[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
					[ ] QuickenWindow.SetActive()
					[ ] // Open Schedule E Report
					[ ] sExpReportTitle=NULL
					[ ] sExpReportTitle="Schedule E Report"
					[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
					[+] if (iReportSelect==PASS)
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
						[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
						[+] if (ScheduleEReportWindow.Exists(5))
							[ ] 
							[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
							[ ] ScheduleEReportWindow.SetActive()
							[ ] 
							[ ] // Maximize sTAB_SHEDULE_E_REPORT 
							[ ] ScheduleEReportWindow.Maximize()
							[ ] 
							[ ] // Get window caption
							[ ] sActual = ScheduleEReportWindow.GetCaption()
							[ ] 
							[ ] // Verify window title
							[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
							[ ] 
							[ ] // Report Status if window title is as expected
							[+] if ( bMatch )
								[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
								[ ] //  Validate Report Data
								[ ] hWnd=NULL
								[ ] sActual=NULL
								[ ] bMatch=FALSE
								[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer.ListBox1.GetHandle ())
								[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,"5")
								[ ] bMatch = MatchStr("*{sDateStamp}*{lsExpense[4]}*{lsExpense[2]}*{lsExpense[3]}*{lsExpense[1]}*{sAmountPaid}*", sActual)
								[+] if(bMatch)
									[ ] ReportStatus("Validate Report Data", PASS, " Transaction with Payee :{lsExpense[2]},Account:{lsExpense[4]} Cat: {lsExpense[3]},Tag: {lsExpense[1]} and Expense Amount: {sAmountPaid} get displayed on  {sTAB_SHEDULE_E_REPORT}.")
								[+] else
									[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with Payee :{lsExpense[2]},Account:{lsExpense[4]} Cat: {lsExpense[3]},Tag: {lsExpense[1]} and Expense Amount: {sAmountPaid} didn't display on {sTAB_SHEDULE_E_REPORT} and actual data is {sActual}.")
							[+] else
								[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
							[ ] ScheduleEReportWindow.Close()
							[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
							[ ] /////#######Report validation done#######///
						[+] else
							[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
					[+] else
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
					[ ] 
					[ ] // #################Verify Rent Collected transaction in the Checking Account ###############/// 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] WaitForState(QuickenWindow,True,2)
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
					[+] if (DlgFindAndReplace.Exists(5))
						[ ] DlgFindAndReplace.SetActive()
						[ ] DlgFindAndReplace.SearchTextField.SetText(sAmountPaid)
						[ ] DlgFindAndReplace.FindButton.Click()
						[ ] hWnd = str(DlgFindAndReplace.FoundListBox.ListBox1.GetHandle())
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
						[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify ExpenseTransaction is displayed in Checking Account ", PASS, " {sAmountPaid} amount has been added in the Checking Account. ") 
						[+] else
							[ ] ReportStatus(" Verify ExpenseTransaction is displayed in Checking Account  ", FAIL, "{sAmountPaid} amount has not been added in the Checking Account.") 
						[ ] WaitForState(DlgFindAndReplace.DoneButton,True,1)
						[ ] DlgFindAndReplace.DoneButton.Click()
						[ ] WaitForState(DlgFindAndReplace,False,1)
					[+] else
						[ ] ReportStatus(" Verify Expense is displayed under Profit Loss ", FAIL, "Verify Expense is displayed under Profit Loss: Dialog Find and Replace didn't appear.") 
				[+] else
					[ ] ReportStatus(" Verify Expense is displayed under Profit Loss ", FAIL, " {sAmountPaid} amount didn't update in the OUT section of Profit and Loss. Actual is {sActual}") 
			[+] else
				[ ] ReportStatus(" Verify Enter Expense button when a Tenant has been added", FAIL, "Enter Expense dialog did not display.") 
		[+] else
			[+] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", FAIL, "AddTransactions button does not exist on Rental Property screen.") 
				[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] 
[+] //############# Test24_VerifyUpcomingBillOnProfitLoss ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_VerifyUpcomingBillOnProfitLoss()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify ProfitLoss> Upcoming Bill
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying ProfitLoss> Upcoming Bill
		[ ] //						Fail		If error occurs while verifying ProfitLoss> Upcoming Bill
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 31, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test24_VerifyUpcomingBillOnProfitLoss() appstate RPMBaseState
	[ ] STRING sReminderStatus
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet 
	[ ] lsAddTenant=lsExcelData[1]
	[ ] // Read Rent data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sReminderSheet)
	[ ] // Fetch 1st row from the given sheet sReminderSheet
	[ ] IncTranReminderRecord rIncTranReminderRecord
	[ ] lsReminder=lsExcelData[2]
	[ ] rIncTranReminderRecord=lsReminder
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sAmountPaid=trim(Left(rIncTranReminderRecord.sAmount,6))
	[ ] sFaRAmountField=trim("Amount")
	[ ] sReminderStatus= "Due Today"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate toRentalProperty > Profit Loss############ .Click (1, 92, 22)
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
		[ ] QuickenWindow.SetActive()
		[ ] WaitForState(RentalPropertyRentCenter,TRUE,1)
		[+] if (RentalPropertyRentCenter.Exists(1))
			[ ] RentalPropertyRentCenter.InOutProfitLoss.Panel2.StaticText1.StaticText3.AddReminderButton.Click()
			[ ] RentalPropertyRentCenter.TypeKeys(Replicate (KEY_DN, 2))	
			[ ] RentalPropertyRentCenter.TypeKeys(KEY_ENTER)
			[ ] WaitForState(DlgAddEditReminder,TRUE,1)
			[+] if(DlgAddEditReminder.Exists(5))
				[ ] DlgAddEditReminder.SetActive ()
				[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText(rIncTranReminderRecord.sPayeeName)
				[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
				[ ] DlgAddEditReminder.NextButton.Click()
				[ ] DlgAddEditReminder.SetActive ()
				[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText(rIncTranReminderRecord.sPayeeName)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(rIncTranReminderRecord.sAmount)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText (rIncTranReminderRecord.sToAccount)
				[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.Typekeys(KEY_TAB)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click (1, 92, 22)
				[ ] Agent.SetOption (OPT_SCROLL_INTO_VIEW, FALSE)
				[ ] DlgOptionalSetting.CategoryTextField.SetText (rIncTranReminderRecord.sCategory)
				[ ] DlgOptionalSetting.TypeKeys(KEY_TAB)
				[ ] DlgOptionalSetting.TagTextField.SetText (rIncTranReminderRecord.sTag)
				[ ] DlgOptionalSetting.MemoTextField.SetText (rIncTranReminderRecord.sMemo)
				[ ] DlgOptionalSetting.OKButton.Click()
				[+] if(DlgOptionalSetting.NewTag.Exists(2))
					[ ] DlgOptionalSetting.NewTag.SetActive ()
					[ ] DlgOptionalSetting.NewTag.TagOKButton.Click (1, 23, 13)
				[ ] 
				[ ] DlgAddEditReminder.SetActive ()
				[ ] DlgAddEditReminder.DoneButton.Click ()
				[ ] WaitForState(DlgAddEditReminder,FALSE,1)
				[ ] sleep(3)
				[ ] WaitForState(QuickenWindow,True,1)
				[ ] 
				[ ] // #################Verify Upcoming Bill Reminder in the Rental Property Reminders grid###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] sleep(5)
				[ ] QuickenWindow.SetActive()
				[ ] hWnd = str(RentalPropertyRentCenter.ListBox5.GetHandle())
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox5.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[ ] 
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Bill Reminder created ", PASS, " Bill Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been created in the Rental Property Reminders section of Profit and Loss.") 
					[ ] 
					[ ] // #################Verify Upcoming Bill Reminder is displayed under Profit Loss###############/// 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] WaitForState(QuickenWindow,True,2)
					[ ] QuickenWindow.SetActive()
					[ ] hWnd = str(RentalPropertyRentCenter.ListBox2.GetHandle())
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
					[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
					[ ] 
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Upcoming Bill is displayed under Profit Loss ", PASS, " {sAmountPaid} amount has been updated in the OUT section of Profit and Loss.") 
						[ ] // #################Verify Upcoming Bill Reminder  transaction in the Upcoming Bill Reminde Popup ###############/// 
						[ ] RentalPropertyRentCenter.ListBox2.Click(1,37,23)
						[ ] sleep(4)
						[+] if (RecordedDepositsCallout.Exists(2))
							[ ] ReportStatus("Verify Upcoming Bill became link. ", PASS, "Upcoming Bill text became link. ") 
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
							[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sAmountPaid}*", sActual)
								[+] if ( bMatch )
									[ ] break
							[+] if ( bMatch )
								[ ] ReportStatus(" Verify Upcoming Bill in the Upcoming Bill Popup", PASS, " Upcoming Bill with Payee:{rIncTranReminderRecord.sPayeeName}, Date:{sDateStamp},and Amount:{sAmountPaid} has been added to the Upcoming Bill CallOut. ") 
							[+] else
								[ ] ReportStatus(" Verify Upcoming Bill in the Upcoming Bill Popup", FAIL, " Upcoming Bill with Payee:{rIncTranReminderRecord.sPayeeName}, Date:{sDateStamp},and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Upcoming Bill CallOut is {sActual}. ") 
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] sleep(1)
							[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Upcoming Bill became link. ", FAIL, "Upcoming Bill text does not  become link. ") 
					[+] else
						[ ] ReportStatus(" Verify Upcoming Bill is displayed under Profit Loss ", FAIL, " {sAmountPaid} amount didn't update in the OUT section of Profit and Loss.") 
				[+] else
					[ ] ReportStatus(" Verify Bill Reminder created ", FAIL, " Bill Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been created in the Rental Property Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
			[+] else
				[ ] ReportStatus("Verify Reminder Exists. ", FAIL, "Reminder dialog does not exist. ") 
		[+] else
			[ ] ReportStatus("Verify RentalProperty > RentCenter Exists. ", FAIL, "RentalProperty > RentCenter  does not exist. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test25_VerifyExpenseInTaxDeductibleAndPossiblyDeductibleLink #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_VerifyExpenseInTaxDeductibleAndPossiblyDeductibleLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify ProfitLoss> Tax Deductible And Possibly Deductible transactions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying ProfitLoss> Tax Deductible And Possibly Deductible transactions
		[ ] //						Fail		If error occurs while verifying ProfitLoss> Tax Deductible And Possibly Deductible transactions
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Dec 20, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test25_VerifyExpenseInTaxDeductibleAndPossiblyDeductibleLink() appstate RPMBaseState
	[ ] // Read Tenant data from excel sheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet 
	[ ] lsAddTenant=lsExcelData[1]
	[ ] // Read Expense data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sReminderSheet)
	[ ] lsReminder=lsExcelData[2]
	[ ] iAmount3= VAL(lsReminder[7])
	[ ] // Read Expense data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sExpenseSheet)
	[ ] // Fetch 1st row from the given sheet sExpenseSheet
	[ ] lsExpense=lsExcelData[1]
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] iAmount1=VAL(lsExpense[5])
	[ ] lsExpense=NULL
	[ ] lsExpense=lsExcelData[2]
	[ ] iAmount2=VAL(lsExpense[5])
	[ ] iAmountTotal=iAmount1+iAmount2
	[ ] sAmountPaid=trim(Left(lsExpense[5],6))
	[ ] sFaRAmountField=trim("Amount")
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate to RentalProperty > Profit Loss############
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
		[ ] QuickenWindow.SetActive()
		[+] if (QuickenMainWindow.QWNavigator1.AddTransactions.Exists(5))
			[ ] //############## Verify Enter Expense button when a Tenant has been added############
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(Replicate (KEY_DN, 2))	
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.TypeKeys(KEY_ENTER)
			[+] if (DlgEnterExpense.Exists(4))
				[ ] DlgEnterExpense.PropertyPopupList.SetFocus()
				[ ] DlgEnterExpense.PropertyPopupList.Select(lsExpense[1])
				[ ] DlgEnterExpense.PayToTextField.SetText(lsExpense[2])
				[ ] WaitForState(DlgEnterExpense,True,1)
				[ ] DlgEnterExpense.SetActive()
				[ ] DlgEnterExpense.DateTextField.SetText(sDateStamp)
				[ ] DlgEnterExpense.AmountToBePaidTextField.SetText(lsExpense[5])
				[ ] DlgEnterExpense.AddButton.Click()
				[ ] WaitForState(DlgEnterExpense,False,5)
				[ ] sleep(5)
				[ ] 
				[ ] // #################Verify Uncategorized Expense is displayed under Profit Loss under OUT section###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] QuickenWindow.SetActive()
				[ ] hWnd = str(RentalPropertyRentCenter.ListBox2.GetHandle())
				[ ] 
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox2.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{iAmountTotal}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[ ] 
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Expense is displayed under Profit Loss ", PASS, " {iAmountTotal} amount has been updated in the OUT section of Profit and Loss.") 
					[ ] // #################Verify Expense transaction in the Recorded Expense Popup ###############/// 
					[ ] // #################Recorded Expense Popup is clicked with the help of Location Identifier###############/// 
					[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
					[ ] sleep(4)
					[ ] WaitForState(RecordedDepositsCallout,True,2)
					[+] if (RecordedDepositsCallout.Exists(5))
						[ ] ReportStatus("Verify Recorded Expenses text became link. ", PASS, "Recorded Expenses text became link. ") 
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] sExpected=NULL
						[ ] sExpected="Uncategorized"
						[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
						[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bMatch = MatchStr("*{sExpected}*{iAmount2}*", sActual)
							[+] if ( bMatch )
								[ ] break
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify Uncategorized Expense transaction in the Recorded Expense Popup", PASS, " Verify Uncategorized Expense transaction: Transaction with Payee:{sExpected} and Amount:{iAmount2} has been added to the Recorded Expense CallOut. ") 
						[+] else
							[ ] ReportStatus(" Verify Uncategorized Expense transaction in the Recorded Expense Popup", FAIL, "  Verify Uncategorized Expense transaction: Transaction with Payee:{sExpected} and Amount:{iAmount2} has not been added correctly,  the actual transaction added to the Recorded Expense CallOut is {sActual}. ") 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] sleep(1)
						[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
						[ ] 
						[ ] WaitForState(RecordedDepositsCallout,False,5)
					[+] else
						[ ] ReportStatus("Verify Recorded Expenses text became link. ", FAIL, "Recorded Expenses text does not become link. ") 
					[ ] 
					[ ] QuickenWindow.SetActive()
				[+] else
					[ ] ReportStatus(" Verify Expense is displayed under Profit Loss ", FAIL, " {iAmountTotal} amount didn't update in the OUT section of Profit and Loss.") 
				[ ] // #################Verify Tax Deductible Expense is displayed under Profit Loss under OUT section###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] sExpected=NULL
				[ ] sExpected="Tax Deductible"
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] QuickenWindow.SetActive()
				[ ] hWnd = str(RentalPropertyRentCenter.ListBox3.GetHandle())
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox3.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sExpected}*{iAmount1}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Tax Deductible link ", PASS, " {sExpected} link is displayed in the OUT section of  RentalProperty > Profit Loss.") 
					[ ] // #################Possibly Deductible Popup is clicked with the help of Location Identifier###############/// 
					[ ] RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer3.ListBox1.Click(1,40,5)
					[ ] sleep(4)
					[ ] WaitForState(RecordedDepositsCallout,True,2)
					[+] if (RecordedDepositsCallout.Exists(5))
						[ ] ReportStatus("Verify Tax Deductible become link. ", PASS, "Tax Deductible text become link. ") 
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] // Fetch 1st row from the given sheet
						[ ] lsTransaction=NULL
						[ ] lsTransaction=lsExcelData[1]
						[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
						[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bMatch = MatchStr("*{lsTransaction[2]}*{iAmount1}*", sActual)
							[+] if ( bMatch )
								[ ] break
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify Tax Deductible transaction ", PASS, " Verify Tax Deductible transaction in the Tax Deductible Popup:Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{iAmount1} has been added to the Tax Deductible  CallOut. ") 
						[+] else
							[ ] ReportStatus(" Verify Tax Deductible transaction ", FAIL, " Verify Tax Deductible transaction in the Tax Deductible Popup: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{iAmount1} has not been added correctly,  the actual transaction added to the Tax Deductible CallOut is {sActual}. ") 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] sleep(1)
						[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
						[ ] 
						[ ] sleep(2)
					[+] else
						[ ] ReportStatus("Verify Tax Deductible become link. ", FAIL, "Tax Deductible text does not become link. ") 
				[+] else
					[ ] ReportStatus(" Verify Tax Deductible link ", FAIL, " {sExpected} link is not displayed in the OUT section of  RentalProperty > Profit Loss and actual result is {sActual} .") 
				[ ] 
				[ ] // #################Verify Possibly Deductible Expense is displayed under Profit Loss under OUT section###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] sExpected=NULL
				[ ] iAmountTotal=NULL
				[ ] //Possibly deductible amount will be the deferrence of uncategorized transaction and upcoming bill
				[ ] iAmountTotal=iAmount2 - iAmount3
				[ ] sExpected="Possibly Deductible"
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] QuickenWindow.SetActive()
				[ ] hWnd = str(RentalPropertyRentCenter.ListBox3.GetHandle())
				[ ] 
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox3.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sExpected}*{iAmountTotal}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Possibly Deductible link on RentalProperty > Profit Loss", PASS, " {sExpected} link is displayed in the OUT section of  RentalProperty > Profit Loss.") 
					[ ] // #################Possibly Deductible Popup is clicked with the help of Location Identifier###############/// 
					[ ] RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer3.ListBox1.Click(1,42,23)
					[ ] 
					[+] if (RecordedDepositsCallout.Exists(2))
						[ ] ReportStatus("Verify Possibly Deductible become link. ", PASS, "Possibly Deductible text become link. ") 
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
						[ ] ////#####Verify Uncategorized transaction in the Possibly Deductible Popup###////
						[ ] // //Fetch 1st row from the given sheet lsTransaction////
						[ ] lsTransaction=NULL
						[ ] lsTransaction=lsExcelData[2]
						[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bMatch = MatchStr("*{lsTransaction[2]}*{iAmount2}*", sActual)
							[+] if ( bMatch )
								[ ] break
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify Uncategorized transaction ", PASS, " Verify Uncategorized transaction in the Possibly Deductible Popup: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{iAmount2} has been added to the Possibly Deductible  CallOut. ") 
						[+] else
							[ ] ReportStatus(" Verify Possibly Deductible transaction ", FAIL, " Verify Uncategorized transaction in the Possibly Deductible Popup: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{iAmount2} has not been added correctly,  the actual transaction added to the Possibly Deductible CallOut is {sActual}. ") 
						[ ] 
						[ ] ////#####Verify Upcoming Bill in the Possibly Deductible Popup###//// lsReminder
						[ ] // //Fetch 1st row from the given sheet lsTransaction////
						[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bMatch = MatchStr("*{lsReminder[2]}*{iAmount3}*", sActual)
							[+] if ( bMatch )
								[ ] break
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify Upcoming Bill as Possibly Deductible transaction ", PASS, " Verify Upcoming Bill as Possibly Deductible transaction in the Possibly Deductible Popup: Transaction with Payee:{lsReminder[2]}, Date:{sDateStamp},and Amount:{iAmount3} has been added to the Possibly Deductible  CallOut. ") 
						[+] else
							[ ] ReportStatus(" Verify Upcoming Bill as Possibly Deductible transaction ", FAIL, " Verify Upcoming Bill as Possibly Deductible transaction in the Possibly Deductible Popup: Transaction with Payee:{lsReminder[2]}, Date:{sDateStamp},and Amount:{iAmount3} has not been added correctly,  the actual transaction added to the Possibly Deductible CallOut is {sActual}. ") 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] sleep(1)
						[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
						[ ] 
						[ ] sleep(2)
					[+] else
						[ ] ReportStatus("Verify Possibly Deductible become link. ", FAIL, "Possibly Deductible text does not become link. ") 
				[+] else
					[ ] ReportStatus(" Verify Possibly Deductible link on RentalProperty > Profit Loss ", FAIL, " {sExpected} link is not displayed in the OUT section of  RentalProperty > Profit Loss and actual result is {sActual} .") 
				[ ] 
			[+] else
				[ ] ReportStatus(" Verify Enter Expense button when a Tenant has been added", FAIL, "Enter Expense dialog did not display.") 
		[+] else
			[ ] ReportStatus(" Verify AddTransactions button exists on Rental Property screen", FAIL, "AddTransactions button does not exist on Rental Property screen.") 
			[ ] WaitForState(QuickenWindow,True,2)
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] 
[+] //############# Test26_VerifyProfitLossDetailsLink ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test26_VerifyProfitLossDetailsLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Profit Loss Details using Projected Profit/Loss for Current Month Link
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Profit Loss Details using Projected Profit/Loss for Current Month Link
		[ ] //						Fail		If  error occurs while verifying Profit Loss Details using Projected Profit/Loss for Current Month Link
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 31, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test26_VerifyProfitLossDetailsLink() appstate RPMBaseState
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "mmmm yyyy") 
	[ ] sExpDialogTitle ="Profit/Loss Details for {sDateStamp}"
	[ ] 
	[ ] 
	[ ] LIST OF ANYTYPE lsProfitLossDetailsRows
	[ ] IncTranReminderRecord rIncTranReminderRecord
	[ ] // Fetch 1st row from the given sheet sRentWorksheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData = ReadExcelTable(sRentalData, sRentWorksheet)
	[ ] lsRent = lsExcelData[1]
	[ ] // Fetch 1st row from the given sheet sExpenseSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData = ReadExcelTable(sRentalData, sExpenseSheet)
	[ ] lsExpense = lsExcelData[1]
	[ ] // Fetch 1st row from the given sheet sReminderSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sReminderSheet)
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate to RentalProperty > Profit Loss############
		[+] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] WaitForState(RentalPropertyRentCenter,TRUE,1)
			[+] if (RentalPropertyRentCenter.Exists(1))
				[ ] RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.Profit1.ListBox1.Click()
				[ ] WaitForState(DlgProfitLossDetails,TRUE,1)
				[+] if (DlgProfitLossDetails.Exists(5))
					[ ] DlgProfitLossDetails.SetActive()
					[ ] // #################Verify Profit/Loss Details title###############/// 
					[ ] 
					[ ] sActualDialogTitle=DlgProfitLossDetails.ProfitLossDetailsStaticText.GetText()
					[ ] bMatch = MatchStr("*{sExpDialogTitle}*", sActualDialogTitle)
					[+] if (bMatch)
						[ ] ReportStatus("Verify Profit Loss Details dialog title. ", PASS, "Profit Loss Details dialog title is as expected {sActualDialogTitle} ") 
					[+] else
						[ ] ReportStatus("Verify Profit Loss Details dialog title. ", FAIL, "Profit Loss Details dialog title expected is {sExpDialogTitle} while actual is {sActualDialogTitle} ") 
						[ ] 
					[ ] // #################Read rows from Profit/Loss Details grid###############/// 
					[ ] sDateStamp = FormatDateTime (GetDateTime(), "mmm d") 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] hWnd = str(DlgProfitLossDetails.ProfitLossDetailsListViewer.ListBox1.GetHandle())
					[ ] 
					[+] for( iCounter=0;iCounter<DlgProfitLossDetails.ProfitLossDetailsListViewer.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] LISTAPPEND (lsProfitLossDetailsRows,sActual)
						[ ] sActual=NULL
					[ ] // #################Verify Profit/Loss Details > Recorded Deposits label###############/// 
					[ ] sExpectedLabel="Recorded Deposits"
					[ ] bMatch=FALSE
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{sExpectedLabel}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify Recorded Deposits label on Profit Loss Details dialog. ", PASS, "Profit Loss Details dialog > Recorded Deposits label is as expected {lsProfitLossDetailsRows[5]} ") 
					[+] else
						[ ] ReportStatus("Verify Recorded Deposits label on Profit Loss Details dialog. ", FAIL, "Profit Loss Details dialog > Recorded Deposits label expected is {sExpectedLabel} while actual is {lsProfitLossDetailsRows[5]} ") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Recorded Deposits transaction###############/// 
					[ ] sAmountPaid=NULL
					[ ] bMatch=FALSE
					[ ] sAmountPaid=trim(Left(lsRent[5],6))
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{lsRent[2]}*{sAmountPaid}*{sDateStamp}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Recorded Deposits on Profit Loss Details dialog ", PASS, " Recorded Deposits Transaction with  Payee: {lsRent[2]}, amount - {sAmountPaid} and Date: {sDateStamp} is correctly displayed on {sActualDialogTitle} .") 
					[+] else
						[ ] ReportStatus(" Verify Recorded Deposits on Profit Loss Details dialog ", FAIL, "  Recorded Deposits Transaction with Expected Payee: {lsRent[2]}, Expected amount {sAmountPaid} and Expected Date: {sDateStamp} is incorrectly displayed on {sActualDialogTitle}, the actual transaction is {lsProfitLossDetailsRows[7]}.") 
						[ ] 
					[ ] // #################Verify Profit/Loss Details > Upcoming Bills label###############/// 
					[ ] sExpectedLabel=NULL
					[ ] bMatch=FALSE
					[ ] sExpectedLabel="Upcoming Bills"
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{sExpectedLabel}*", sItem)
						[+] if (bMatch)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify Upcoming Bills label on Profit Loss Details dialog. ", PASS, "Profit Loss Details dialog Upcoming Bills label is as expected {lsProfitLossDetailsRows[9]} ") 
					[+] else
						[ ] ReportStatus("Verify Upcoming Bills label on Profit Loss Details dialog. ", FAIL, "Profit Loss Details dialog Upcoming Bills label expected is {sExpectedLabel} while actual is {lsProfitLossDetailsRows[9]} ") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Upcoming Bills transaction###############/// 
					[ ] 
					[ ] 
					[ ] bMatch=FALSE
					[ ] rIncTranReminderRecord=lsExcelData[2]
					[ ] sAmountPaid=NULL
					[ ] sAmountPaid=trim(Left(rIncTranReminderRecord.sAmount,6))
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sAmountPaid}*{sDateStamp}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Upcoming Bills on Profit Loss Details dialog ", PASS, " Bills Transaction with  Payee: {rIncTranReminderRecord.sPayeeName}, amount - {sAmountPaid} and Date: {sDateStamp} is correctly displayed on {sActualDialogTitle} .") 
					[+] else
						[ ] ReportStatus(" Verify Upcoming Bills on Profit Loss Details dialog ", FAIL, "  Bills Transaction with Expected Payee: {rIncTranReminderRecord.sPayeeName}, Expected amount - {sAmountPaid} and Expected Date: {sDateStamp} is incorrectly displayed on {sActualDialogTitle}, the actual transaction is {lsProfitLossDetailsRows[11]}.") 
					[ ] // #################Verify Profit/Loss Details > Upcoming Income label###############/// 
					[ ] sExpectedLabel="Upcoming Income"
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{sExpectedLabel}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify Upcoming Income label on Profit Loss Details dialog. ", PASS, "Profit Loss Details dialog Upcoming Income label is as expected {lsProfitLossDetailsRows[1]} ") 
					[+] else
						[ ] ReportStatus("Verify Upcoming Income label on Profit Loss Details dialog. ", FAIL, "Profit Loss Details dialog Upcoming Income label expected is {sExpectedLabel} while actual is {lsProfitLossDetailsRows[1]} ") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Upcoming Income transaction###############/// 
					[ ] sDateStamp=NULL
					[ ] sDateStamp = FormatDateTime (GetDateTime(), "mmm d") 
					[ ] bMatch=FALSE
					[ ] rIncTranReminderRecord=NULL
					[ ] rIncTranReminderRecord=lsExcelData[1]
					[ ] sAmountPaid=NULL
					[ ] sAmountPaid=trim(Left(rIncTranReminderRecord.sAmount,6))
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sAmountPaid}*{sDateStamp}*", sItem)
						[+] if (bMatch)
							[ ] break
					[ ] 
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Upcoming Income on Profit Loss Details dialog ", PASS, " Income Transaction with  Payee: {rIncTranReminderRecord.sPayeeName}, amount {sAmountPaid} and Date: {sDateStamp} is correctly displayed on {sActualDialogTitle} .") 
					[+] else
						[ ] ReportStatus(" Verify Upcoming Income on Profit Loss Details dialog ", FAIL, "  Income Transaction with Expected Payee: {rIncTranReminderRecord.sPayeeName}, Expected amount {sAmountPaid} and Expected Date: {sDateStamp} is incorrectly displayed on {sActualDialogTitle}, the actual transaction is {lsProfitLossDetailsRows[3]}.") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Recorded Expenses label###############/// 
					[ ] sExpectedLabel=NULL
					[ ] bMatch=FALSE
					[ ] sExpectedLabel="Recorded Expenses"
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{sExpectedLabel}*", sItem)
						[+] if (bMatch)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify Recorded Expenses label on Profit Loss Details dialog. ", PASS, "Profit Loss Details dialog > Recorded Expenses label is as expected {lsProfitLossDetailsRows[13]} ") 
					[+] else
						[ ] ReportStatus("Verify Recorded Expenses label on Profit Loss Details dialog. ", FAIL, "Profit Loss Details dialog > Recorded Expenses label expected is {sExpectedLabel} while actual is {lsProfitLossDetailsRows[13]} ") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Recorded Expenses transaction###############/// 
					[ ] sAmountPaid=NULL
					[ ] bMatch=FALSE
					[ ] sAmountPaid=trim(Left(lsExpense[5],6))
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{lsExpense[2]}*{sAmountPaid}*{sDateStamp}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Recorded Expenses on Profit Loss Details dialog ", PASS, " Recorded Expenses Transaction with  Payee: {lsExpense[2]}, amount - {sAmountPaid} and Date: {sDateStamp} is correctly displayed on {sActualDialogTitle} .") 
					[+] else
						[ ] ReportStatus(" Verify Recorded Expenses on Profit Loss Details dialog ", FAIL, "  Recorded Expenses Transaction with Expected Payee: {lsExpense[2]}, Expected amount {sAmountPaid} and Expected Date: {sDateStamp} is incorrectly displayed on {sActualDialogTitle}, the actual transaction is {lsProfitLossDetailsRows[15]}.") 
						[ ] 
					[ ] DlgProfitLossDetails.CloseButton.Click()
					[ ] WaitForState(DlgProfitLossDetails,FALSE,1)
				[+] else
					[ ] ReportStatus("Verify RentalProperty > Profit Loss Details dialog exists. ", FAIL, "RentalProperty > Profit Loss Details dialog does not exist. ") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify RentalProperty > RentCenter Exists. ", FAIL, "RentalProperty > RentCenter  does not exist. ") 
				[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test27_VerifyProfitLossDetailsUsingButton ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_VerifyProfitLossDetailsUsingButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Profit Loss Details using  Projected Profit/Loss for Current Month Link
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Profit Loss Details using  Projected Profit/Loss for Current Month Link
		[ ] //						Fail		If  error occurs while verifying Profit Loss Details using  Projected Profit/Loss for Current Month Link
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 1, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test27_VerifyProfitLossDetailsUsingButton() appstate RPMBaseState
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "mmmm yyyy") 
	[ ] sExpDialogTitle ="Profit/Loss Details for {sDateStamp}"
	[ ] 
	[ ] 
	[ ] LIST OF ANYTYPE lsProfitLossDetailsRows
	[ ] IncTranReminderRecord rIncTranReminderRecord
	[ ] // Fetch 1st row from the given sheet sRentWorksheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData = ReadExcelTable(sRentalData, sRentWorksheet)
	[ ] lsRent = lsExcelData[1]
	[ ] // Fetch 1st row from the given sheet sExpenseSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData = ReadExcelTable(sRentalData, sExpenseSheet)
	[ ] lsExpense = lsExcelData[1]
	[ ] // Fetch 1st row from the given sheet sReminderSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sReminderSheet)
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate to RentalProperty > Profit Loss############
		[+] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] WaitForState(RentalPropertyRentCenter,TRUE,1)
			[+] if (RentalPropertyRentCenter.Exists(1))
				[ ] RentalPropertyRentCenter.ProfitLossDetailsButton.Click()
				[ ] WaitForState(DlgProfitLossDetails,TRUE,1)
				[+] if (DlgProfitLossDetails.Exists(5))
					[ ] DlgProfitLossDetails.SetActive()
					[ ] // #################Verify Profit/Loss Details title###############/// 
					[ ] 
					[ ] sActualDialogTitle=DlgProfitLossDetails.ProfitLossDetailsStaticText.GetText()
					[ ] bMatch = MatchStr("*{sExpDialogTitle}*", sActualDialogTitle)
					[+] if (bMatch)
						[ ] ReportStatus("Verify Profit Loss Details dialog title. ", PASS, "Verify Profit Loss Details when invoked using button-> Profit Loss Details dialog title is as expected {sActualDialogTitle} ") 
					[+] else
						[ ] ReportStatus("Verify Profit Loss Details dialog title. ", FAIL, "Verify Profit Loss Details when invoked using button->Profit Loss Details dialog title expected is {sExpDialogTitle} while actual is {sActualDialogTitle} ") 
						[ ] 
					[ ] // #################Read rows from Profit/Loss Details grid###############/// 
					[ ] sDateStamp = FormatDateTime (GetDateTime(), "mmm d") 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] hWnd = str(DlgProfitLossDetails.ProfitLossDetailsListViewer.ListBox1.GetHandle())
					[ ] 
					[+] for( iCounter=0;iCounter<DlgProfitLossDetails.ProfitLossDetailsListViewer.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] LISTAPPEND (lsProfitLossDetailsRows,sActual)
						[ ] sActual=NULL
					[ ] // #################Verify Profit/Loss Details > Recorded Deposits label###############/// 
					[ ] sExpectedLabel="Recorded Deposits"
					[ ] bMatch=FALSE
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{sExpectedLabel}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify Recorded Deposits label on Profit Loss Details dialog. ", PASS, "Verify Profit Loss Details when invoked using button->Profit Loss Details dialog > Recorded Deposits label is as expected {lsProfitLossDetailsRows[5]} ") 
					[+] else
						[ ] ReportStatus("Verify Recorded Deposits label on Profit Loss Details dialog. ", FAIL, "Verify Profit Loss Details when invoked using button->Profit Loss Details dialog > Recorded Deposits label expected is {sExpectedLabel} while actual is {lsProfitLossDetailsRows[5]} ") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Recorded Deposits transaction###############/// 
					[ ] sAmountPaid=NULL
					[ ] bMatch=FALSE
					[ ] sAmountPaid=trim(Left(lsRent[5],6))
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{lsRent[2]}*{sAmountPaid}*{sDateStamp}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Recorded Deposits on Profit Loss Details dialog ", PASS, " Verify Profit Loss Details when invoked using button->Recorded Deposits Transaction with  Payee: {lsRent[2]}, amount - {sAmountPaid} and Date: {sDateStamp} is correctly displayed on {sActualDialogTitle} .") 
					[+] else
						[ ] ReportStatus(" Verify Recorded Deposits on Profit Loss Details dialog ", FAIL, "  Verify Profit Loss Details when invoked using button->Recorded Deposits Transaction with Expected Payee: {lsRent[2]}, Expected amount {sAmountPaid} and Expected Date: {sDateStamp} is incorrectly displayed on {sActualDialogTitle}, the actual transaction is {lsProfitLossDetailsRows[7]}.") 
						[ ] 
					[ ] // #################Verify Profit/Loss Details > Upcoming Bills label###############/// 
					[ ] sExpectedLabel=NULL
					[ ] bMatch=FALSE
					[ ] sExpectedLabel="Upcoming Bills"
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{sExpectedLabel}*", sItem)
						[+] if (bMatch)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify Upcoming Bills label on Profit Loss Details dialog. ", PASS, "Verify Profit Loss Details when invoked using button->Profit Loss Details dialog Upcoming Bills label is as expected {lsProfitLossDetailsRows[9]} ") 
					[+] else
						[ ] ReportStatus("Verify Upcoming Bills label on Profit Loss Details dialog. ", FAIL, "Verify Profit Loss Details when invoked using button->Profit Loss Details dialog Upcoming Bills label expected is {sExpectedLabel} while actual is {lsProfitLossDetailsRows[9]} ") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Upcoming Bills transaction###############/// 
					[ ] 
					[ ] 
					[ ] bMatch=FALSE
					[ ] rIncTranReminderRecord=lsExcelData[2]
					[ ] sAmountPaid=NULL
					[ ] sAmountPaid=trim(Left(rIncTranReminderRecord.sAmount,6))
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sAmountPaid}*{sDateStamp}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Upcoming Bills on Profit Loss Details dialog ", PASS, " Verify Profit Loss Details when invoked using button-> Bills Transaction with  Payee: {rIncTranReminderRecord.sPayeeName}, amount - {sAmountPaid} and Date: {sDateStamp} is correctly displayed on {sActualDialogTitle} .") 
					[+] else
						[ ] ReportStatus(" Verify Upcoming Bills on Profit Loss Details dialog ", FAIL, "  Verify Profit Loss Details when invoked using button-> Bills Transaction with Expected Payee: {rIncTranReminderRecord.sPayeeName}, Expected amount - {sAmountPaid} and Expected Date: {sDateStamp} is incorrectly displayed on {sActualDialogTitle}, the actual transaction is {lsProfitLossDetailsRows[11]}.") 
					[ ] // #################Verify Profit/Loss Details > Upcoming Income label###############/// 
					[ ] sExpectedLabel="Upcoming Income"
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{sExpectedLabel}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify Upcoming Income label on Profit Loss Details dialog. ", PASS, " Verify Profit Loss Details when invoked using button-> Profit Loss Details dialog Upcoming Income label is as expected {lsProfitLossDetailsRows[1]} ") 
					[+] else
						[ ] ReportStatus("Verify Upcoming Income label on Profit Loss Details dialog. ", FAIL, " Verify Profit Loss Details when invoked using button-> Profit Loss Details dialog Upcoming Income label expected is {sExpectedLabel} while actual is {lsProfitLossDetailsRows[1]} ") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Upcoming Income transaction###############/// 
					[ ] sDateStamp=NULL
					[ ] sDateStamp = FormatDateTime (GetDateTime(), "mmm d") 
					[ ] bMatch=FALSE
					[ ] rIncTranReminderRecord=NULL
					[ ] rIncTranReminderRecord=lsExcelData[1]
					[ ] sAmountPaid=NULL
					[ ] sAmountPaid=trim(Left(rIncTranReminderRecord.sAmount,6))
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sAmountPaid}*{sDateStamp}*", sItem)
						[+] if (bMatch)
							[ ] break
					[ ] 
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Upcoming Income on Profit Loss Details dialog ", PASS, "  Verify Profit Loss Details when invoked using button-> Income Transaction with  Payee: {rIncTranReminderRecord.sPayeeName}, amount {sAmountPaid} and Date: {sDateStamp} is correctly displayed on {sActualDialogTitle} .") 
					[+] else
						[ ] ReportStatus(" Verify Upcoming Income on Profit Loss Details dialog ", FAIL, "  Verify Profit Loss Details when invoked using button->  Income Transaction with Expected Payee: {rIncTranReminderRecord.sPayeeName}, Expected amount {sAmountPaid} and Expected Date: {sDateStamp} is incorrectly displayed on {sActualDialogTitle}, the actual transaction is {lsProfitLossDetailsRows[3]}.") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Recorded Expenses label###############/// 
					[ ] sExpectedLabel=NULL
					[ ] bMatch=FALSE
					[ ] sExpectedLabel="Recorded Expenses"
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{sExpectedLabel}*", sItem)
						[+] if (bMatch)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify Recorded Expenses label on Profit Loss Details dialog. ", PASS, " Verify Profit Loss Details when invoked using button-> Profit Loss Details dialog > Recorded Expenses label is as expected {lsProfitLossDetailsRows[13]} ") 
					[+] else
						[ ] ReportStatus("Verify Recorded Expenses label on Profit Loss Details dialog. ", FAIL, " Verify Profit Loss Details when invoked using button-> Profit Loss Details dialog > Recorded Expenses label expected is {sExpectedLabel} while actual is {lsProfitLossDetailsRows[13]} ") 
					[ ] 
					[ ] // #################Verify Profit/Loss Details > Recorded Expenses transaction###############/// 
					[ ] sAmountPaid=NULL
					[ ] bMatch=FALSE
					[ ] sAmountPaid=trim(Left(lsExpense[5],6))
					[+] for each sItem in lsProfitLossDetailsRows
						[ ] bMatch = MatchStr("*{lsExpense[2]}*{sAmountPaid}*{sDateStamp}*", sItem)
						[+] if (bMatch)
							[ ] break
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Recorded Expenses on Profit Loss Details dialog ", PASS, "  Verify Profit Loss Details when invoked using button-> Recorded Expenses Transaction with  Payee: {lsExpense[2]}, amount - {sAmountPaid} and Date: {sDateStamp} is correctly displayed on {sActualDialogTitle} .") 
					[+] else
						[ ] ReportStatus(" Verify Recorded Expenses on Profit Loss Details dialog ", FAIL, "   Verify Profit Loss Details when invoked using button-> Recorded Expenses Transaction with Expected Payee: {lsExpense[2]}, Expected amount {sAmountPaid} and Expected Date: {sDateStamp} is incorrectly displayed on {sActualDialogTitle}, the actual transaction is {lsProfitLossDetailsRows[15]}.") 
						[ ] 
					[ ] DlgProfitLossDetails.CloseButton.Click()
					[ ] WaitForState(DlgProfitLossDetails,FALSE,3)
				[+] else
					[ ] ReportStatus("Verify RentalProperty > Profit Loss Details dialog exists. ", FAIL, "RentalProperty > Profit Loss Details dialog does not exist. ") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify RentalProperty > RentCenter Exists. ", FAIL, "RentalProperty > RentCenter  does not exist. ") 
				[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test28_VerifyProfitLossReminders ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_VerifyProfitLossReminders()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Income/Bill reminders in the Rental Property Reminders grid
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Income/Bill reminders in the Rental Property Reminders grid
		[ ] //						Fail		If  error occurs while verifying Income/Bill reminders in the Rental Property Reminders grid
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 31, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test28_VerifyProfitLossReminders() appstate RPMBaseState
	[ ] STRING sButtonEnter ,sButtonEdit ,sButtonSkip  ,sButtonGotoregister 
	[ ] sButtonEnter="Enter"
	[ ] sButtonEdit="Edit"
	[ ] sButtonSkip="Skip"
	[ ] sButtonGotoregister="Go to Register"
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sExpDialogTitle ="Profit/Loss Details for {sDateStamp}"
	[ ] 
	[ ] LIST OF ANYTYPE lsProfitLossDetailsRows
	[ ] IncTranReminderRecord rIncTranReminderRecord
	[ ] sReminderStatus= "Due Today"
	[ ] // Read Reminder data from excel sheet sReminderSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sReminderSheet)
	[ ] // Fetch 1st row from the given sheet sReminderSheet
	[ ] rIncTranReminderRecord=NULL
	[ ] rIncTranReminderRecord=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate to RentalProperty > Profit Loss############
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
		[ ] WaitForState(RentalPropertyRentCenter,TRUE,1)
		[+] if (RentalPropertyRentCenter.Exists(1))
				[ ] // #################Verify Upcoming Income  Reminder in the Rental Property Reminders grid###############/// 
				[ ] WaitForState(RentalPropertyRentCenter,TRUE,2)
				[ ] QuickenWindow.SetActive()
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] sAmountPaid=NULL
				[ ] sAmountPaid=trim(Left(rIncTranReminderRecord.sAmount,6))
				[ ] hWnd = str(RentalPropertyRentCenter.ListBox6.GetHandle())
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox6.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] //bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
					[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[ ] 
				[ ] //bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Income Reminder created ", PASS, " Income Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been created in the Rental Property Reminders section of Profit and Loss.") 
				[+] else
					[ ] ReportStatus(" Verify Income Reminder created ", FAIL, " Income Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been created in the Rental Property Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
				[ ] // #################Verify Upcoming Bill Reminder in the Rental Property Reminders grid###############/// 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] rIncTranReminderRecord=NULL
				[ ] rIncTranReminderRecord=lsExcelData[2]
				[ ] sAmountPaid=NULL
				[ ] sAmountPaid=trim(Left(rIncTranReminderRecord.sAmount,6))
				[ ] WaitForState(RentalPropertyRentCenter,TRUE,2)
				[ ] // hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.Panel2.StaticText1.StaticText2.QWListViewer1.ListBox1.GetHandle())
				[ ] hWnd =str(RentalPropertyRentCenter.ListBox6.GetHandle())
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox6.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] // bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
					[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[ ] //bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Bill Reminder created ", PASS, " Bill Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been created in the Rental Property Reminders section of Profit and Loss.") 
				[+] else
					[ ] ReportStatus(" Verify Bill Reminder created ", FAIL, " Bill Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been created in the Rental Property Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
				[ ] 
				[ ] // #################Verify Overdue Bill Reminder in the Rental Property Reminders grid###############/// 
				[ ] WaitForState(RentalPropertyRentCenter,TRUE,2)
				[ ] QuickenWindow.SetActive()
				[ ] RentalPropertyRentCenter.InOutProfitLoss.PanelExpenses.Click(1,113,12)
				[ ] RentalPropertyRentCenter.InOutProfitLoss.Panel2.StaticText1.StaticText3.ManageRemindersButton.Click()
				[ ] WaitForState(DlgManageReminders,TRUE,2)
				[+] if(DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.SetActive()
					[ ] 
					[ ] // #################Select bill reminder from Manage Reminders grid###############/// 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] 
					[ ] hWnd = str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[+] for( iCounter=0;iCounter<DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*", sActual)
						[+] if ( bMatch == TRUE)
							[ ] DlgManageReminders.SetActive()
							[ ] DlgManageReminders.TextClick(rIncTranReminderRecord.sPayeeName)
							[ ] break
					[ ] 
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify reminder selected in Manage Reminders grid ", PASS, "Reminder selected in Manage Reminders grid. ") 
						[ ] DlgManageReminders.TypeKeys(KEY_ALT_D)
						[ ] WaitForState(DlgAddEditReminder,TRUE,2)
						[ ] sDateStamp=NULL
						[ ] sDateStamp =FormatDateTime ( AddDateTime (GetDateTime (), -1), "m/d/yyyy") 
						[+] if(DlgAddEditReminder.Exists(5))
							[ ] ReportStatus("Verify DlgEditReminder Exists. ", PASS, "Reminder dialog does not exist. ") 
							[ ] DlgAddEditReminder.SetActive ()
							[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
							[ ] DlgAddEditReminder.DoneButton.Click()
							[ ] WaitForState(DlgAddEditReminder,FALSE,1)
							[ ] WaitForState(DlgManageReminders,TRUE,1)
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] sReminderStatus=NULL
							[ ] sReminderStatus="Overdue"
							[ ] WaitForState(QuickenWindow,True,2)
							[ ] hWnd = str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
							[+] for( iCounter=0;iCounter<DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] // bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
								[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
								[+] if ( bMatch == TRUE)
									[ ] break
							[ ] 
							[ ] //sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
							[ ] //bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
							[+] if ( bMatch )
								[ ] ReportStatus(" Verify overdued Bill Reminder  ", PASS, " Bill Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been created in the Rental Property Manage Reminders section of Profit and Loss.") 
							[+] else
								[ ] ReportStatus(" Verify overdued Bill Reminder created ", FAIL, " Bill Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been created in the Rental Property Manage Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
						[+] else
							[ ] ReportStatus("Verify DlgEditReminder Exists. ", FAIL, "Reminder dialog does not exist. ") 
					[+] else
							[ ] ReportStatus("Verify reminder selected in Manage Reminders grid ", FAIL, "Reminder didn't select in Manage Reminders grid. ") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify RentalProperty >Manage Reminders dialog exists. ", FAIL, "RentalProperty >Manage Reminders dialog does not exist. ") 
				[ ] DlgManageReminders.TypeKeys(KEY_EXIT)
				[ ] WaitForState(DlgManageReminders,FALSE,1)
				[ ] sDateStamp=NULL
				[ ] sDateStamp =FormatDateTime ( AddDateTime (GetDateTime (), -1), "m/d/yyyy") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] sReminderStatus=NULL
				[ ] sReminderStatus="Overdue"
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] hWnd =str(RentalPropertyRentCenter.ListBox6.GetHandle())
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox6.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify overdued Bill Reminder created", PASS, " Bill Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been created in the Rental Property Reminders section of Profit and Loss.") 
				[+] else
					[ ] ReportStatus(" Verify overdued Bill Reminder created ", FAIL, " Bill Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been created in the Rental Property Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
				[ ] 
				[ ] 
				[ ] // #################Verify Due Soon Bill Reminder in the Rental Property Reminders grid###############/// 
				[ ] WaitForState(RentalPropertyRentCenter,TRUE,2)
				[ ] QuickenWindow.SetActive()
				[ ] RentalPropertyRentCenter.InOutProfitLoss.Panel2.StaticText1.StaticText3.ManageRemindersButton.Click()
				[ ] WaitForState(DlgManageReminders,TRUE,2)
				[ ] sReminderStatus=NULL
				[ ] sReminderStatus="Due Soon"
				[ ] sDateStamp=NULL
				[ ] sDateStamp =FormatDateTime ( AddDateTime (GetDateTime (), 1), "m/d/yyyy") 
				[+] if(DlgManageReminders.Exists(5))
					[ ] 
					[ ] DlgManageReminders.SetActive()
					[ ] 
					[ ] // #################Select bill reminder from Manage Reminders grid###############/// 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] hWnd = str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[+] for( iCounter=0;iCounter<DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*", sActual)
						[+] if ( bMatch == TRUE)
							[ ] DlgManageReminders.TextClick(rIncTranReminderRecord.sPayeeName)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify reminder selected in Manage Reminders grid ", PASS, "Reminder selected in Manage Reminders grid. ") 
						[ ] DlgManageReminders.TypeKeys(KEY_ALT_D)
						[ ] WaitForState(DlgAddEditReminder,TRUE,2)
						[+] if(DlgAddEditReminder.Exists(5))
							[ ] DlgAddEditReminder.SetActive ()
							[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
							[ ] DlgAddEditReminder.DoneButton.Click()
							[ ] WaitForState(DlgAddEditReminder,FALSE,1)
							[ ] WaitForState(DlgManageReminders,TRUE,1)
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] WaitForState(QuickenWindow,True,2)
							[ ] hWnd = str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
							[ ] //sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
							[+] for( iCounter=0;iCounter<DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] // bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
								[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
								[ ] 
								[+] if ( bMatch == TRUE)
									[+] break
										[ ] 
							[ ] //bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
							[+] if ( bMatch )
								[ ] ReportStatus(" Verify Due Soon Bill Reminder  ", PASS, " Due Soon Bill Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been created in the Rental Property Manage Reminders section of Profit and Loss.") 
							[+] else
								[ ] ReportStatus(" Verify Due Soon Bill Reminder created ", FAIL, " Due Soon Bill Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been created in the Rental Property Manage Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
						[+] else
							[ ] ReportStatus("Verify Reminder Exists. ", FAIL, "Reminder dialog does not exist. ") 
					[+] else
							[ ] ReportStatus("Verify reminder selected in Manage Reminders grid ", FAIL, "Reminder didn't select in Manage Reminders grid. ") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify RentalProperty >Manage Reminders dialog exists. ", FAIL, "RentalProperty >Manage Reminders dialog does not exist. ") 
				[ ] DlgManageReminders.TypeKeys(KEY_EXIT)
				[ ] WaitForState(DlgManageReminders,FALSE,1)
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] QuickenWindow.SetActive()
				[ ] WaitForState(RentalPropertyRentCenter,True,2)
				[ ] hWnd =str(RentalPropertyRentCenter.ListBox6.GetHandle())
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox6.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] // bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
					[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[ ] 
				[ ] 
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Due Soon Bill Reminder created", PASS, " Due Soon Bill Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been created in the Rental Property Reminders section of Profit and Loss.") 
				[+] else
					[ ] ReportStatus(" Verify Due Soon Bill Reminder created ", FAIL, " Due Soon Bill Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been created in the Rental Property Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
				[ ] 
				[ ] // #################Verify Received Bill Reminder in the Rental Property Reminders grid###############/// 
				[ ] WaitForState(RentalPropertyRentCenter,TRUE,2)
				[ ] QuickenWindow.SetActive()
				[ ] RentalPropertyRentCenter.InOutProfitLoss.Panel2.StaticText1.StaticText3.ManageRemindersButton.Click()
				[ ] sReminderStatus=NULL
				[ ] sReminderStatus="Received"
				[ ] sDateStamp=NULL
				[ ] sDateStamp =FormatDateTime ( GetDateTime (),  "m/d/yyyy") 
				[ ] WaitForState(DlgManageReminders,TRUE,2)
				[+] if(DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.SetActive()
					[ ] // #################Select bill reminder from Manage Reminders grid###############/// 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] hWnd = str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[ ] // #################Selected the Income reminder beacuse at times toolbar does not get active if 2nd row is selected at first from Manage Reminders grid###############/// 
					[ ] sActual=NULL
					[ ] DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.Click()
					[+] for( iCounter=0;iCounter<DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*", sActual)
						[+] if ( bMatch == TRUE)
							[ ] DlgManageReminders.TextClick(rIncTranReminderRecord.sPayeeName)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify reminder selected in Manage Reminders grid ", PASS, "Reminder selected in Manage Reminders grid. ") 
						[ ] DlgManageReminders.SetActive()
						[ ] DlgManageReminders.TypeKeys(KEY_ALT_E)
						[ ] 
						[+] if(DlgEnterIncomeTransaction.Exists(7))
							[ ] DlgEnterIncomeTransaction.SetActive ()
							[ ] DlgEnterIncomeTransaction.DateTextField.SetText(sDateStamp)
							[ ] DlgEnterIncomeTransaction.EnterTransactionButton.Click()
							[ ] WaitForState(DlgEnterIncomeTransaction,FALSE,1)
							[ ] WaitForState(DlgManageReminders,TRUE,1)
							[ ] DlgManageReminders.SetActive()
							[ ] DlgManageReminders.MonthlyBillsDepositsTab.Click()
							[ ] DlgManageReminders.SetActive()
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] hWnd = str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
							[+] for( iCounter=0;iCounter<DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] // bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
								[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
								[+] if ( bMatch == TRUE)
									[ ] break
							[ ] //sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "2")
							[ ] //bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
							[+] if ( bMatch )
								[ ] ReportStatus(" Verify Received Bill Reminder  ", PASS, " Received Bill Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been Received in the Rental Property >Manage Reminders section of Profit and Loss.") 
							[+] else
								[ ] ReportStatus(" Verify Received Bill Reminder created ", FAIL, " Received Bill Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been Received in the Rental Property >Manage Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
						[+] else
							[ ] ReportStatus("Verify DlgEnterIncomeTransaction Exists. ", FAIL, "DlgEnterIncomeTransaction dialog does not exist. ") 
					[+] else
							[ ] ReportStatus("Verify reminder selected in Manage Reminders grid ", FAIL, "Reminder didn't select in Manage Reminders grid. ") 
				[+] else
					[ ] ReportStatus("Verify RentalProperty >Manage Reminders dialog exists. ", FAIL, "RentalProperty >Manage Reminders dialog does not exist. ") 
				[ ] DlgManageReminders.TypeKeys(KEY_EXIT)
				[ ] WaitForState(DlgManageReminders,FALSE,1)
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] bResult=TRUE
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] QuickenWindow.SetActive()
				[ ] hWnd = str(RentalPropertyRentCenter.ListBox6.GetHandle())
				[ ] 
				[ ] 
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox6.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*{sButtonGotoregister}*", sActual)
					[ ] 
					[+] if ( bMatch == TRUE)
						[ ] break
				[ ] 
				[ ] bResult=MatchStr("*{sButtonEnter}*{sButtonEdit}*{sButtonSkip}*",sActual)
				[+] if (bMatch == TRUE && bResult==FALSE )
					[ ] ReportStatus(" Verify  Bill Reminder Received", PASS, " Received Bill Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been Received in the Rental Property Reminders section of Profit and Loss.") 
				[+] else
					[ ] ReportStatus(" Verify  Bill Reminder Received ", FAIL, " Received Bill Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been Received in the Rental Property Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
				[ ] 
				[ ] // #################Verify Skipped Bill Reminder in the Rental Property Reminders grid###############/// 
				[ ] WaitForState(RentalPropertyRentCenter,TRUE,2)
				[ ] QuickenWindow.SetActive()
				[ ] RentalPropertyRentCenter.InOutProfitLoss.Panel2.StaticText1.StaticText3.ManageRemindersButton.Click()
				[ ] WaitForState(DlgManageReminders,TRUE,2)
				[ ] sReminderStatus=NULL
				[ ] sReminderStatus="Due Today"
				[ ] sDateStamp=NULL
				[ ] sDateStamp =FormatDateTime ( GetDateTime (),  "m/d/yyyy") 
				[ ] rIncTranReminderRecord=NULL
				[ ] rIncTranReminderRecord=lsExcelData[1]
				[ ] sAmountPaid=NULL
				[ ] sAmountPaid=trim(Left(rIncTranReminderRecord.sAmount,6))
				[ ] 
				[+] if(DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.SetActive()
					[ ] 
					[ ] // #################Select bill reminder from Manage Reminders grid###############/// 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] hWnd = str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[ ] // #################Selected the Income reminder beacuse at times toolbar does not get active if 2nd row is selected at first from Manage Reminders grid###############/// 
					[ ] sActual=NULL
					[ ] DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.Click()
					[+] for( iCounter=0;iCounter<DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*", sActual)
						[+] if ( bMatch == TRUE)
							[ ] DlgManageReminders.TextClick(rIncTranReminderRecord.sPayeeName)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify reminder selected in Manage Reminders grid ", PASS, "Income Reminder selected in Manage Reminders grid. ") 
						[ ] DlgManageReminders.TypeKeys(KEY_ALT_K)
						[ ] WaitForState(DlgSkipThisReminder,TRUE,1)
						[+] if(DlgSkipThisReminder.Exists(5))
							[ ] DlgSkipThisReminder.SetActive ()
							[ ] DlgSkipThisReminder.SkipButton.Click()
							[ ] WaitForState(DlgSkipThisReminder,FALSE,1)
							[ ] WaitForState(DlgManageReminders,TRUE,1)
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] WaitForState(QuickenWindow,True,2)
							[ ] hWnd = str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
							[+] for( iCounter=0;iCounter<DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] // bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
								[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
								[+] if ( bMatch == TRUE)
									[ ] break
							[ ] 
							[ ] //sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
							[ ] //bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
							[+] if (bMatch == FALSE)
								[ ] ReportStatus(" Verify Income Reminder Skipped  ", PASS, " Skipped Income Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} has been Skipped in the Rental Property >Manage Reminders section of Profit and Loss.") 
							[+] else
								[ ] ReportStatus(" Income Reminder Skipped ", FAIL, " Skipped Income Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has not been Skipped in the Rental Property >Manage Reminders section of Profit and Loss, Actual Reminder values are {sActual}.") 
						[+] else
							[ ] ReportStatus("Verify DlgSkipThisReminder Exists. ", FAIL, "DlgSkipThisReminder dialog does not exist. ") 
					[+] else
							[ ] ReportStatus("Verify reminder selected in Manage Reminders grid ", FAIL, "Reminder didn't select in Manage Reminders grid. ") 
				[+] else
					[ ] ReportStatus("Verify RentalProperty >Manage Reminders dialog exists. ", FAIL, "RentalProperty >Manage Reminders dialog does not exist. ") 
				[ ] DlgManageReminders.TypeKeys(KEY_EXIT)
				[ ] WaitForState(DlgManageReminders,FALSE,1)
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] bResult=TRUE
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] QuickenWindow.SetActive()
				[ ] WaitForState(RentalPropertyRentCenter,True,2)
				[ ] hWnd = str(RentalPropertyRentCenter.ListBox6.GetHandle())
				[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox6.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] // bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sReminderStatus}*{sDateStamp}*{sAmountPaid}*", sActual)
					[ ] bMatch = MatchStr("*{rIncTranReminderRecord.sPayeeName}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[ ] 
				[+] if (bMatch==FALSE)
					[ ] ReportStatus(" Verify Income Reminder Skipped ", PASS, " Skipped Income Reminder with Status :{sReminderStatus},Date: {sDateStamp}, Payee: {rIncTranReminderRecord.sPayeeName} and amount {sAmountPaid} has  been Skipped in the Rental Property Reminders section of Profit and Loss") 
				[+] else
					[ ] ReportStatus(" Verify Income Reminder Skipped", FAIL, " Skipped Income Reminder with  Payee: {rIncTranReminderRecord.sPayeeName}, Status :{sReminderStatus},Date: {sDateStamp} and amount {sAmountPaid} still displayed in the Rental Property Reminders section of Profit and Loss.") 
		[+] else
			[ ] ReportStatus("Verify RentalProperty > RentCenter Exists. ", FAIL, "RentalProperty > RentCenter  does not exist. ") 
	[+] else
		[+] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
[ ] 
[+] //############# Test29_VerifyProfitLossManageRemindersCalendarGraph ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_VerifyProfitLossManageRemindersCalendarGraph()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Calendar Graph options on the Manage Reminders of Rental Property Reminders grid
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying Calendar Graph options on the Manage Reminders of Rental Property Reminders grid
		[ ] //						Fail		If  error occurs while verifying Calendar Graph options on the Manage Reminders of Rental Property Reminders grid
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 12, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test29_VerifyProfitLossManageRemindersCalendarGraph() appstate RPMBaseState
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sExpDialogTitle ="Profit/Loss Details for {sDateStamp}"
	[ ] 
	[ ] LIST OF ANYTYPE lsProfitLossDetailsRows
	[ ] IncTranReminderRecord rIncTranReminderRecord
	[ ] sReminderStatus= "Due Today"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate to RentalProperty > Profit Loss############
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
		[ ] WaitForState(RentalPropertyRentCenter,TRUE,1)
		[+] if (RentalPropertyRentCenter.Exists(1))
				[ ] QuickenWindow.SetActive()
				[ ] RentalPropertyRentCenter.InOutProfitLoss.PanelExpenses.Click(1,113,12)
				[ ] RentalPropertyRentCenter.InOutProfitLoss.Panel2.StaticText1.StaticText3.ManageRemindersButton.Click()
				[ ] WaitForState(DlgManageReminders,TRUE,2)
				[+] if(DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.SetActive()
					[ ] 
					[ ] //############## Verify RentalProperty >Manage Reminders> Show calendar checkbox checked############
					[+] if (DlgManageReminders.ShowcalendarCheckBox.Exists(5))
						[+] if (DlgManageReminders.ShowcalendarCheckBox.IsChecked())
							[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show calendar checkbox checked ", PASS, "Verify RentalProperty >Manage Reminders> Show calendar checkbox is checked.") 
							[+] if (DlgManageReminders.CalendarMonthButton.Exists(5))
								[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Calendar exists ", PASS, "Verify RentalProperty >Manage Reminders> calendar exists.") 
							[+] else
								[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Calendar exists . ", FAIL, "Verify RentalProperty >Manage Reminders> calendar does not exist.") 
						[+] else
							[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show calendar checkbox checked. ", FAIL, "Verify RentalProperty >Manage Reminders> Show calendar checkbox is not checked.") 
						[ ] //############## Verify RentalProperty >Manage Reminders> Show calendar checkbox Unchecked############
						[ ] DlgManageReminders.ShowcalendarCheckBox.Uncheck()
						[ ] sleep(1)
						[+] if (DlgManageReminders.ShowcalendarCheckBox.IsChecked())
							[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show calendar checkbox checked ", FAIL, "Verify RentalProperty >Manage Reminders> Show calendar checkbox is still checked.") 
						[+] else
							[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show calendar checkbox checked. ", PASS, "Verify RentalProperty >Manage Reminders> Show calendar checkbox became uncheck.") 
							[ ] 
							[+] if (DlgManageReminders.CalendarMonthButton.Exists(5))
								[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Calendar does not exist.", FAIL, "Verify RentalProperty >Manage Reminders> calendar didn't disappear.") 
							[+] else
								[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Calendar does not exist. ", PASS, "Verify RentalProperty >Manage Reminders> calendar disappeared.") 
					[+] else
						[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show calendar checkbox exists. ", FAIL, "Verify RentalProperty >Manage Reminders> Show calendar checkbox does not exist.") 
					[ ] //############## Verify RentalProperty >Manage Reminders> Show graph checkbox checked############
					[+] if (DlgManageReminders.ShowgraphCheckBox.Exists(5))
						[+] if (DlgManageReminders.ShowgraphCheckBox.IsChecked())
							[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show graph checkbox checked ", PASS, "Verify RentalProperty >Manage Reminders> Show graph checkbox is checked.") 
							[+] if (DlgManageReminders.QWGraphControlClass.Exists(5))
								[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Reminder Graph exists ", PASS, "Verify RentalProperty >Manage Reminders> Reminder Graph exists.") 
							[+] else
								[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Reminder Graph exists . ", FAIL, "Verify RentalProperty >Manage Reminders> Reminder Graph does not exist.") 
						[+] else
							[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show graph checkbox checked. ", FAIL, "Verify RentalProperty >Manage Reminders> Show graph checkbox is not checked.") 
						[ ] //############## Verify RentalProperty >Manage Reminders> Show graph checkbox Unchecked############
						[ ] DlgManageReminders.ShowgraphCheckBox.Uncheck()
						[ ] sleep(1)
						[+] if (DlgManageReminders.ShowgraphCheckBox.IsChecked())
							[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show graph checkbox checked ", FAIL, "Verify RentalProperty >Manage Reminders> Show graph checkbox is still checked.") 
						[+] else
							[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show Graph checkbox is checked. ", PASS, "Verify RentalProperty >Manage Reminders> Show Graph checkbox became uncheck.") 
							[+] if (DlgManageReminders.QWGraphControlClass.Exists(5))
								[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Graph does not exist.", FAIL, "Verify RentalProperty >Manage Reminders> Graph didn't disappear.") 
							[+] else
								[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Graph does not exist. ", PASS, "Verify RentalProperty >Manage Reminders> Graph disappeared.") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify RentalProperty >Manage Reminders> Show graph checkbox exists. ", FAIL, "Verify RentalProperty >Manage Reminders> Show graph checkbox does not exist.") 
				[+] else
					[ ] ReportStatus("Verify RentalProperty >Manage Reminders dialog exists. ", FAIL, "RentalProperty >Manage Reminders dialog does not exist. ") 
				[ ] DlgManageReminders.TypeKeys(KEY_EXIT)
				[ ] WaitForState(DlgManageReminders,FALSE,1)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify RentalProperty > RentCenter Exists. ", FAIL, "RentalProperty > RentCenter  does not exist. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test30_VerifySpendingByPayeeCategoryTransactionsInProfitLossTab ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_VerifySpendingByPayeeCategoryTransactionsInProfitLossTab()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] // This testcase will verify Spending By Payee and Spending By Category Transactions In ProfitLossTab
			[ ] //
			[ ] // PARAMETERS:		None
			[ ] //
			[ ] // RETURNS:			Pass 	      If no error occurs while verifying Spending By Payee and Spending By Category Transactions In ProfitLossTab
			[ ] //						Fail		      If error occurs while verifying Spending By Payee and Spending By Category Transactions In ProfitLossTab
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //Date                             Dec 31, 2012		
			[ ] //Author                          Mukesh 	
			[ ] 
			[ ] // ********************************************************
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test30_VerifySpendingByPayeeCategoryTransactionsInProfitLossTab() appstate RPMBaseState
	[ ] STRING sCategorizedExpenses ,sSpendingByPayees
	[ ] sCategorizedExpenses ="CategorizedExpenses"
	[ ] sSpendingByPayees  ="SpendingByPayees"
	[ ] // Read Tenant data from excel sheet
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet 
	[ ] lsAddTenant=lsExcelData[1]
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //############## Navigate to RentalProperty > Profit Loss############
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
		[ ] RentalPropertyRentCenter.InOutProfitLoss.PanelExpenses.Click(1,261,17)
		[ ] ////####Fetching all the Spending by category rows in list lsListBoxItems####////
		[ ] hWnd=NULL
		[ ] hWnd = Str(RentalPropertyRentCenter.ListBox6.GetHandle ())
		[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox6.GetItemCount() +1;++iCounter)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
			[ ] ListAppend (lsListBoxItems,sActual)
		[ ] //////####Verify Spending by category data under  RentalProperty > Profit Loss>Spending by category###////////
		[ ] // Read sCategorizedExpenses data from excel sheet
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRentalData, sCategorizedExpenses)
		[ ] // lsCategorizedExpenses=lsExcelData[1]
		[ ] 
		[+] for( iCounter=1; iCounter< ListCount (lsExcelData)+1; ++iCounter)
			[ ] lsCategorizedExpenses=lsExcelData[iCounter]
			[+] if (lsCategorizedExpenses[1]==NULL)
				[ ] break
			[ ] iAmount= VAL(lsCategorizedExpenses[2])
			[+] for each sItem in lsListBoxItems
				[ ] bMatch = MatchStr("*{lsCategorizedExpenses[1]}*{iAmount}*", sItem)
				[+] if ( bMatch == TRUE)
					[ ] break
			[+] if(bMatch)
				[ ] ReportStatus("Validate Report Data", PASS, " Transaction with Category :{lsCategorizedExpenses[1]} and Amount: {iAmount} get displayed on RentalProperty > Profit Loss>Spending by category as {sItem}.")
			[+] else
				[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with Category :{lsCategorizedExpenses[1]} and Amount: {iAmount} didn't display on RentalProperty > Profit Loss>Spending by category.")
		[ ] 
		[ ] //////####Verify Spending by Payee data under  RentalProperty > Profit Loss>Spending by Payee###////////
		[ ] 
		[ ] ////####Fetching all the Spending by Payee rows in list lsListBoxItems####////
		[ ] hWnd=NULL
		[ ] hWnd = Str(RentalPropertyRentCenter.ListBox7.GetHandle ())
		[+] for( iCounter=0;iCounter<RentalPropertyRentCenter.ListBox7.GetItemCount() +1;++iCounter)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
			[ ] ListAppend (lsListBoxItems,sActual)
		[ ] 
		[ ] // Read sSpendingByPayees data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRentalData, sSpendingByPayees)
		[ ] // lsSpendingByPayees=lsExcelData[1]
		[ ] 
		[+] for( iCounter=1; iCounter<  ListCount (lsExcelData)+1; ++iCounter)
			[ ] lsSpendingByPayees=lsExcelData[iCounter]
			[+] if (lsSpendingByPayees[1]==NULL)
				[ ] break
			[ ] iAmount= VAL(lsSpendingByPayees[2])
			[+] for each sItem in lsListBoxItems
				[ ] bMatch = MatchStr("*{lsSpendingByPayees[1]}*{iAmount}*", sItem)
				[+] if ( bMatch == TRUE)
					[ ] break
			[+] if(bMatch)
				[ ] ReportStatus("Validate Report Data", PASS, " Transaction with Payee: {lsSpendingByPayees[1]} and Amount: {iAmount} get displayed on RentalProperty > Profit Loss>Spending by category as {sItem}.")
			[+] else
				[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with Payee: {lsSpendingByPayees[1]} and Amount: {iAmount} didn't display on RentalProperty > Profit Loss>Spending by category.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] 
[+] //############# Test31_Verify_HiddenPropertyTransactionsOnProfitLoss ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test31_Verify_HiddenPropertyTransactionsOnProfitLoss()
		[ ] //
		[ ] // DESCRIPTION: 
		[ ] // This testcase will verify transactions after hiding and unhiding property
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying transactions after hiding and unhiding property						
		[ ] //						Fail		If error occurs while verifying transactions after hiding and unhiding property
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Oct 3, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test31_Verify_HiddenPropertyTransactionsOnProfitLoss() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_RENT_CENTER)
		[+] if (iResult==PASS)
			[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} ", PASS, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} displayed.") 
			[ ] //############## Openening the Property List############
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate (KEY_DN, 2))	
			[ ] sleep(1)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[+] if (PropertyListTable.Edit.Exists(5))
				[+] if (PropertyListTable.Edit.IsEnabled())
					[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", PASS, "Edit button enabled on Rental Property screen.") 
				[+] else
					[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", FAIL, "Edit  button is not enabled on Rental Property screen.") 
				[+] PropertyListTable.Edit.Click()
					[ ] //############## Hiding the property############
					[+] if (AddEditRentalProperty.Exists(1))
						[ ] AddEditRentalProperty.HideProperty.Check()
						[ ] AddEditRentalProperty.OK.Click()
					[ ] //############## Verifying hidden property in Propertylist############
					[+] if  (PropertyListTable.Exists(2))
						[ ] hWnd = Str(PropertyListTable.PropertyList.QWListViewer1.ListBox1.GetHandle())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
						[ ] sExpected= lsAddProperty[3]+"  @" +lsAddProperty[2]
						[ ] bAssert = MatchStr("*{sExpected}*",sActual)
						[+] if ( bAssert == TRUE)
							[ ] ReportStatus("Verify Property hide feature", FAIL, "Property {lsAddProperty[1]} did not hide in PropertyListTable.") 
						[+] else
							[ ] ReportStatus("Verify Property hide feature", PASS, "Property {lsAddProperty[1]} become hidden in PropertyListTable.") 
						[ ] PropertyListTable.Done.Click()
						[ ] WaitForState(PropertyListTable,False,1)
					[ ] //############## Verifying property became hidden in RentalPropertyRentCenter############
				[+] if (QuickenWindow.Exists(5))
					[ ] QuickenWindow.SetActive()
					[ ] iResult=RentalPropertyRentCenter.PopupList1.FindItem(lsAddProperty[1])
					[+] if ( iResult == 2)
						[ ] ReportStatus("Verify Property hide feature in Rent Center Properties dropdownlist.", FAIL, "Property {lsAddProperty[1]} did not hide in Rent Center Properties dropdownlist..") 
					[+] else
						[ ] ReportStatus("Verify Property hide feature in Rent Center Properties dropdownlist.", PASS, "Property {lsAddProperty[1]} become hidden in Rent Center Properties dropdownlist..") 
					[ ] //############## Verifying property became hidden in RentalProperty > Profit Loss############
					[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
				[+] if (QuickenWindow.Exists(5))
					[ ] QuickenWindow.SetActive()
					[ ] iResult=RentalPropertyRentCenter.PopupList1.FindItem(lsAddProperty[1])
					[+] if ( iResult == 2)
						[ ] ReportStatus("Verify Property hide feature in Profit Loss Properties dropdownlist.", FAIL, "Property {lsAddProperty[1]} did not hide in Profit Loss Properties dropdownlist..") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Property hide feature in Profit Loss Properties dropdownlist.", PASS, "Property {lsAddProperty[1]} become hidden in Profit Loss Properties dropdownlist..") 
						[ ] // #################Verify Rent Paid when property became hidden under Profit Loss###############/// 
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] // Read Rent data from excel sheet
						[ ] lsExcelData=NULL
						[ ] lsExcelData=ReadExcelTable(sRentalData, sRentWorksheet)
						[ ] // Fetch 1st row from the given sheet sRentWorksheet
						[ ] lsRent=lsExcelData[1]
						[ ] sAmountPaid=trim(Left(lsRent[5],6))
						[ ] WaitForState(QuickenWindow,True,2)
						[ ] WaitForState(RentalPropertyRentCenter,True,2)
						[ ] iListCount=RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.GetItemCount()
						[ ] hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.GetHandle())
						[+] for (iCounter=0 ; iCounter<iListCount +1 ;  ++iCounter)
							[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  Str(iCounter))
							[ ] bMatch = MatchStr("*-{sAmountPaid}*", sActual)
							[+] if (bMatch)
								[ ] break
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify Rent Paid when property became hidden ", PASS, " -{sAmountPaid} amount is displayed the IN section of Profit and Loss.") 
						[+] else
							[ ] ReportStatus(" Verify Rent Paid when property became hidden ", FAIL, " -{sAmountPaid} amount is not displayed the IN section of Profit and Loss.") 
						[ ] // #################Verify Rent Expense is displayed under Profit Loss under OUT section###############/// 
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] lsExcelData=NULL
						[ ] sAmountPaid=NULL
						[ ] lsExcelData=ReadExcelTable(sRentalData, sExpenseSheet)
						[ ] // Fetch 1st row from the given sheet sExpenseSheet
						[ ] lsExpense=lsExcelData[1]
						[ ] sAmountPaid=trim(Left(lsExpense[5],6))
						[ ] WaitForState(QuickenWindow,True,2)
						[ ] WaitForState(RentalPropertyRentCenter,True,2)
						[ ] //hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer2.ListBox1.GetHandle())
						[ ] // #################Recorded Expense Popup is clicked with the help of Location Identifier###############/// 
						[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
						[ ] sleep(4)
						[ ] WaitForState(RecordedDepositsCallout,True,2)
						[+] if (RecordedDepositsCallout.Exists(5))
							[ ] ReportStatus("Verify Recorded Expenses text became link. ", PASS, "Recorded Expenses text became link. ") 
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
							[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bMatch = MatchStr("*{lsExpense[3]}*{sAmountPaid}*", sActual)
								[+] if ( bMatch )
									[ ] break
							[+] if ( bMatch )
								[ ] ReportStatus(" Verify Expense when property became hidden under Profit Loss", PASS, " Transaction with Payee:{lsExpense[3]} and Amount:{sAmountPaid} has been diaplayed in the Recorded Expenses CallOut. ") 
							[+] else
								[ ] ReportStatus(" Verify Expense when property became hidden under Profit Loss", FAIL, " Transaction with Payee:{lsExpense[3]} and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Recorded Expenses CallOut is {sActual}. ") 
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] sleep(1)
							[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
							[ ] sleep(3)
						[+] else
							[ ] ReportStatus("Verify Recorded Expenses text became link. ", FAIL, "Recorded Expenses text does not become link. ") 
							[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
						[ ] 
					[ ] //report
					[ ] // 
					[ ] // //##############Verifying Last year Income Transaction On Schedule E Report	 ############////
					[ ] // Open Schedule E Report
					[ ] sExpReportTitle=NULL
					[ ] sExpReportTitle="Schedule E Report"
					[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
					[+] if (iReportSelect==PASS)
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
						[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
						[+] if (ScheduleEReportWindow.Exists(5))
							[ ] 
							[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
							[ ] ScheduleEReportWindow.SetActive()
							[ ] 
							[ ] // Maximize sTAB_SHEDULE_E_REPORT 
							[ ] ScheduleEReportWindow.Maximize()
							[ ] 
							[ ] // Get window caption
							[ ] sActual = ScheduleEReportWindow.GetCaption()
							[ ] 
							[ ] // Verify window title
							[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
							[ ] 
							[ ] // Report Status if window title is as expected
							[+] if ( bMatch )
								[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
								[ ] //  Validate Report Data
								[ ] 
								[ ] //####Verify transaction data "DEP,Mark,Rental Income(Royalties Received),Property1_Tag,1000"on "Schedule E" report////
								[ ] ////## When Property is hidden///
								[ ] ScheduleEReportWindow.SetActive()
								[ ] sActual=NULL
								[ ] bAssert=FALSE
								[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
								[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
								[+] for( iCounter=0;iCounter<iReportRowsCount ;++iCounter)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
									[ ] bMatch = MatchStr("*{lsExpense[2]}*{lsExpense[3]}*{lsExpense[1]}*{sAmountPaid}*", sActual)
									[+] if ( bMatch == TRUE)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Validate Report Data", PASS, " Verify transaction When Property is hidden {sTAB_SHEDULE_E_REPORT} Report:Transaction with Payee :{lsExpense[2]}, Category :{lsExpense[3]},  and Amount: {sAmountPaid} get displayed.")
								[+] else
									[ ] ReportStatus("Validate Report Data", FAIL, " Verify transaction When Property is hidden {sTAB_SHEDULE_E_REPORT} Report : Transaction with Payee :{lsExpense[2]}, Category :{lsExpense[3]},  and Amount: {sAmountPaid} didn't display.")
							[+] else
								[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
							[ ] ScheduleEReportWindow.Close()
							[+] if(SaveReportAs.Exists(5))
								[ ] SaveReportAs.SetActive()
								[ ] SaveReportAs.DonTShowMeThisAgain.Check()
								[ ] SaveReportAs.DonTSave.Click()
							[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
							[ ] /////#######Report validation done#######///
						[+] else
							[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
					[+] else
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
						[ ] 
						[ ] //report
					[ ] 
					[ ] //############## Unhiding the property############
				[+] else
					[ ] ReportStatus("Verify Rental Property Rent Center Exists. ", FAIL, " Rental Property Rent Center does not didplayed. ") 
				[ ] 
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate (KEY_DN, 2))	
				[ ] sleep(1)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[+] if (PropertyListTable.Exists(5))
					[ ] PropertyListTable.SetActive()
					[ ] PropertyListTable.ShowHiddenProperties.Check()
					[ ] PropertyListTable.Edit.Exists(1)
					[+] if (PropertyListTable.Edit.IsEnabled())
						[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", PASS, "Edit button enabled on Rental Property screen.") 
						[ ] PropertyListTable.Edit.Click()
						[ ] //############## Verify Property became visible in Propertylist ############
						[+] if (AddEditRentalProperty.Exists(1))
							[ ] AddEditRentalProperty.HideProperty.Uncheck()
							[ ] AddEditRentalProperty.OK.Click()
						[+] else
							[ ] ReportStatus(" Verify AddEditRentalProperty screen", FAIL, "AddEditRentalProperty screen did not appear.") 
					[+] else
						[ ] ReportStatus(" Verify Edit button enabled on PropertyList screen", FAIL, "Edit  button is not enabled on Rental Property screen.") 
					[+] if  (PropertyListTable.Exists(2))
						[ ] hWnd = Str(PropertyListTable.PropertyList.QWListViewer1.ListBox1.GetHandle())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
						[ ] sExpected=lsAddProperty[3]+"  @" +lsAddProperty[2]
						[ ] bAssert = MatchStr("*{sExpected}*",sActual)
						[+] if ( bAssert == TRUE)
							[ ] ReportStatus("Verify Property hide feature", PASS, "Property {lsAddProperty[1]} became visible in PropertyListTable.") 
						[+] else
							[ ] ReportStatus("Verify Property hide feature", FAIL, "Property {lsAddProperty[1]} did not became visible in PropertyListTable.") 
						[ ] PropertyListTable.Done.Click()
						[ ] WaitForState(PropertyListTable,False,1)
					[+] else
						[ ] ReportStatus(" Verify PropertyListTable ", FAIL, "PropertyListTable did not appear.") 
				[+] else
					[ ] ReportStatus(" Verify PropertyListTable ", FAIL, "PropertyListTable did not appear.") 
					[ ] //############## Verifying property became visible in RentalPropertyRentCenter############
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_RENT_CENTER)
				[+] if (QuickenWindow.Exists(5))
					[ ] QuickenWindow.SetActive()
					[+] iResult=RentalPropertyRentCenter.PopupList1.FindItem(lsAddProperty[1])
						[+] if ( iResult == 2)
							[ ] ReportStatus("Verify Property hide feature in Rent Center Properties dropdownlist.", PASS, "Property {lsAddProperty[1]} become visible in Rent Center Properties dropdownlist..") 
						[+] else
							[ ] ReportStatus("Verify Property hide feature in Rent Center Properties dropdownlist.", FAIL, "Property {lsAddProperty[1]} did not become visible in Rent Center Properties dropdownlist.") 
				[+] else
					[ ] ReportStatus("Verify Rental Property Rent Center Exists. ", FAIL, " Rental Property Rent Center does not didplayed. ") 
					[ ] //############## Verifying property became hidden in RentalProperty > Profit Loss############
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
				[+] if (QuickenWindow.Exists(5))
					[ ] QuickenWindow.SetActive()
					[+] iResult=RentalPropertyRentCenter.PopupList1.FindItem(lsAddProperty[1])
						[+] if ( iResult == 2)
							[ ] ReportStatus("Verify Property hide feature in Profit Loss Properties dropdownlist.", PASS, "Property {lsAddProperty[1]} become visible in Profit Loss Properties dropdownlist..") 
						[+] else
							[ ] ReportStatus("Verify Property hide feature in Profit Loss Properties dropdownlist.", FAIL, "Property {lsAddProperty[1]} did not become visible in Profit Loss Properties dropdownlist.") 
				[+] else
					[ ] ReportStatus("Verify Rental Property Rent Center Exists. ", FAIL, " Rental Property Profit Loss did not display. ") 
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus(" Verify PropertyListTable ", FAIL, "PropertyListTable did not appear.") 
		[+] else
			[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} ", FAIL, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_RENT_CENTER} Not displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] 
[+] //############# Test32_AddTransactionwithRentalTagAndCategory ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test32_AddTransactionwithRentalTagAndCategory()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding a transaction with rental tag	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	f no error occurs while adding a transaction with rental tag					
		[ ] //						Fail		If transaction with rental tag does not get added with rental tag	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 19, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test32_AddTransactionwithRentalTagAndCategory() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[1]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.View.Click()
		[ ] QuickenWindow.View.TabsToShow.Click()
		[+] if (!QuickenWindow.View.TabsToShow.Business.IsChecked)
			[+] do
				[ ] QuickenWindow.MainMenu.Select("/_View/Tabs to Sho_w/B_usiness")
			[+] except
				[ ] QuickenWindow.View.TabsToShow.Business.Select()
				[ ] 
		[ ] QuickenWindow.View.TabsToShow.TypeKeys(KEY_ESC)
		[ ] iSelect =SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY)  
		[ ] CloseRegisterReminderInfoPopup()
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]}  is selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] 
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] sleep(SHORT_SLEEP)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //############## Verifying transaction gets displayed on Business > Profit Loss############
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] sAmountPaid=left(lsTransaction[6],6)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] hWnd = str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.GetHandle())
			[ ] iListCount=Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.GetItemCount() 
			[+] for (iCounter=0 ; iCounter<iListCount +1 ;  ++iCounter)
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  Str(iCounter))
				[ ] bMatch = MatchStr("*-{sAmountPaid}*", sActual)
				[+] if (bMatch)
					[ ] break
			[ ] 
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify transaction gets displayed on Business > Profit Loss ", FAIL, " {sAmountPaid} amount is displayed in the OUT section of  Business > Profit Loss .") 
			[+] else
				[ ] ReportStatus(" Verify transaction gets displayed on Business > Profit Loss ", PASS, " {sAmountPaid} amount is not displayed in the OUT section of  Business > Profit Loss.") 
				[ ] 
			[ ] //############## Verifying transaction gets displayed on RentalProperty > Profit Loss############
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] // #################Recorded Expense Popup is clicked with the help of Location Identifier###############/// 
			[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
			[ ] sleep(4)
			[ ] WaitForState(RecordedDepositsCallout,True,2)
			[ ] 
			[+] if (RecordedDepositsCallout.Exists(5))
				[ ] ReportStatus("Verify Recorded Expenses text became link. ", PASS, "Recorded Expenses text became link. ") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{lsTransaction[3]}*{sAmountPaid}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Transaction with RentalTag under Profit Loss", PASS, " Verify Transaction with RentalTag under Profit Loss: Transaction with Category:{lsTransaction[3]} and Amount:{sAmountPaid} has been diaplayed in the Recorded Expenses CallOut. ") 
				[+] else
					[ ] ReportStatus(" Verify Transaction with RentalTag under Profit Loss", FAIL, " Verify Transaction with RentalTag under Profit Loss: Transaction with Category:{lsTransaction[3]} and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Recorded Expenses CallOut is {sActual}. ") 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] sleep(1)
				[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
				[ ] 
				[ ] sleep(2)
				[ ] 
				[ ] // //##############Verifying Rental Expense alongwith rental tag transaction on Schedule E Report	 ############////
				[ ] // QuickenWindow.SetActive()
				[ ] // Open Schedule E Report
				[ ] sExpReportTitle=NULL
				[ ] sExpReportTitle="Schedule E Report"
				[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
				[+] if (iReportSelect==PASS)
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
					[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
					[+] if (ScheduleEReportWindow.Exists(5))
						[ ] 
						[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
						[ ] ScheduleEReportWindow.SetActive()
						[ ] 
						[ ] // Maximize sTAB_SHEDULE_E_REPORT 
						[ ] ScheduleEReportWindow.Maximize()
						[ ] 
						[ ] // Get window caption
						[ ] sActual = ScheduleEReportWindow.GetCaption()
						[ ] 
						[ ] // Verify window title
						[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
						[ ] 
						[ ] // Report Status if window title is as expected
						[+] if ( bMatch )
							[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
							[ ] //  Validate Report Data
							[ ] //####Verifying Rental Expense alongwith rental tag transaction on Schedule E Report////
							[ ] ScheduleEReportWindow.SetActive()
							[ ] sActual=NULL
							[ ] bAssert=FALSE
							[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
							[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
							[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bAssert = MatchStr("*{lsTransaction[2]}*{lsTransaction[3]}*{lsTransaction[4]}*{sAmountPaid}*", sActual)
								[+] if ( bAssert == TRUE)
									[ ] break
							[+] if(bAssert)
								[ ] ReportStatus("Validate Report Data", PASS, " Verify expense transaction along with rental tag on {sTAB_SHEDULE_E_REPORT} Report:Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag :{lsTransaction[4]} and Amount: {sAmountPaid} get displayed.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Verify expense transaction along with rental tag on {sTAB_SHEDULE_E_REPORT} Report : Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},Tag :{lsTransaction[4]}  and Amount: {sAmountPaid} didn't display.")
						[+] else
							[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
						[ ] ScheduleEReportWindow.Close()
						[+] if(SaveReportAs.Exists(5))
							[ ] SaveReportAs.SetActive()
							[ ] SaveReportAs.DonTShowMeThisAgain.Check()
							[ ] SaveReportAs.DonTSave.Click()
						[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
						[ ] /////#######Report validation done#######///
					[+] else
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Recorded Expenses text became link. ", FAIL, "Recorded Expenses text does not become link. ") 
				[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
		[+] else
			[ ] ReportStatus("Select Account", FAIL, "Account: {lsAddAccount[2]}  couldn't be selected") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test33_AddTransactionwithRentalTagWithoutCategory ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test33_AddTransactionwithRentalTagWithoutCategory()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding a transaction with rental tag and 
		[ ] // without any category and possible deductible link appears in RentalProperty > Profit Loss		
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while adding a transaction with rental tag 
		[ ] //                                                      and without any category and possible deductible link appears in RentalProperty > Profit Loss					
		[ ] //						Fail		If transaction with rental tag does not get added with rental tag	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 19, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test33_AddTransactionwithRentalTagWithoutCategory() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[2]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] 
			[ ] 
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] //MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] sleep(SHORT_SLEEP)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //############## Verifying transaction without category gets displayed on Business > Profit Loss############
			[ ] sDateStamp=NULL
			[ ] sDateStamp = FormatDateTime (GetDateTime(), "mmm d") 
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] sAmountPaid=trim(Left(lsTransaction[6],6))
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(Business,True,2)
			[ ] iListCount = Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.GetItemCount()
			[ ] hWnd = str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.GetHandle())
			[+] for (iCounter=0 ; iCounter<iListCount +1 ;  ++iCounter)
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  Str(iCounter))
				[ ] bMatch = MatchStr("*-{sAmountPaid}*", sActual)
				[+] if (bMatch)
					[ ] break
			[ ] 
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify transaction gets displayed on Business > Profit Loss ", FAIL, " {sAmountPaid} amount is displayed in the OUT section of  Business > Profit Loss and actual amount displayed is {sActual}.") 
			[+] else
				[ ] ReportStatus(" Verify transaction gets displayed on Business > Profit Loss ", PASS, " {sAmountPaid} amount is not displayed in the OUT section of  Business > Profit Loss and actual amount displayed is {sActual}.") 
				[ ] 
			[ ] //############## Verifying transaction without category gets displayed on RentalProperty > Profit Loss############
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] sExpected=NULL
			[ ] sExpected="Possibly Deductible"
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] iListCount=RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer3.ListBox1.GetItemCount()
			[ ] hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer3.ListBox1.GetHandle())
			[+] for (iCounter=0 ; iCounter<iListCount +1 ;  ++iCounter)
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  Str(iCounter))
				[ ] bMatch = MatchStr("*{sExpected}*", sActual)
				[+] if (bMatch)
					[ ] break
			[ ] 
			[ ] 
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify Possibly Deductible link on RentalProperty > Profit Loss", PASS, " {sExpected} link is displayed in the OUT section of  RentalProperty > Profit Loss.") 
				[ ] // #################Possibly Deductible Popup is clicked with the help of Location Identifier###############/// 
				[ ] RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer3.ListBox1.Click(1,42,23)
				[ ] WaitForState(RecordedDepositsCallout,True,2)
				[ ] sleep(4)
				[+] if (RecordedDepositsCallout.Exists(5))
					[ ] ReportStatus("Verify Possibly Deductible become link. ", PASS, "Possibly Deductible text become link. ") 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] sAmountPaid=trim(Left(lsTransaction[6],6))
					[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
					[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] bMatch = MatchStr("*{lsTransaction[2]}*{sDateStamp}*{sAmountPaid}*", sActual)
						[+] if ( bMatch )
							[ ] break
					[ ] 
					[ ] 
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify Possibly Deductible transaction in the Recorded Deposits Popup", PASS, " Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has been added to the Possibly Deductible CallOut as {sActual}.") 
					[+] else
						[ ] ReportStatus(" Verify Possibly Deductible transaction in the Recorded Deposits Popup", FAIL, " Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Possibly Deductible CallOut is {sActual}. ") 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] sleep(1)
					[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
					[ ] 
					[ ] sleep(2)
				[+] else
					[ ] ReportStatus("Verify Possibly Deductible become link. ", FAIL, "Possibly Deductible text does not become link. ") 
			[+] else
				[ ] ReportStatus(" Verify Possibly Deductible link on RentalProperty > Profit Loss ", FAIL, " {sExpected} link is not displayed in the OUT section of  RentalProperty > Profit Loss and actual result is {sActual} .") 
		[+] else
			[ ] ReportStatus("Select Account", FAIL, "Account: {lsAddAccount[2]}  couldn't be selected") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test34_AddTransactionwithRentalAndBusinessTagWithoutCategory ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test34_AddTransactionwithRentalAndBusinessTagWithoutCategory()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding a transaction with rental tag and Business tag
		[ ] //  and without any category and possible deductible link appears in RentalProperty > Profit Loss	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while adding a transaction with rental tag and Business tag
		[ ] //                                              and without any category and possible deductible link appears in RentalProperty > Profit Loss					
		[ ] //						Fail		If transaction with rental tag does not get added 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 19, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test34_AddTransactionwithRentalAndBusinessTagWithoutCategory() appstate RPMBaseState
	[ ] INTEGER iAddBusiness
	[ ] STRING  sBusiness ,sBusinessTag
	[ ] sBusinessTag = "BusinessTag"
	[ ] sBusiness = "Business_Test"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[3]
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////####Add a Business#######////
		[ ] iAddBusiness= AddBusiness ( sBusiness,  sBusinessTag)
		[+] if(iAddBusiness==PASS)
			[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
			[+] if(iSelect==PASS)
				[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
				[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
				[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
				[ ] 
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] //######Adding Multitags####//
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] sleep(2)
				[ ] MultipleTagsButton.Click()
				[ ] TagListBox.Select("")
				[ ] TagListBox.MultiSelect(2)
				[ ] DoneButton.Click()
				[ ] //#######Multitags Added######////
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
				[ ] sleep(SHORT_SLEEP)
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
				[+] if (DlgSaveTransaction.Exists(5))
					[ ] DlgSaveTransaction.SetActive()
					[ ] DlgSaveTransaction.DontShowAgain.Check()
					[ ] DlgSaveTransaction.Save.Click()
					[ ] sleep(2)
				[ ] 
				[ ] 
				[ ] //############## Verifying transaction without category gets displayed on Business > Profit Loss############
				[ ] sDateStamp=NULL
				[ ] sDateStamp = FormatDateTime (GetDateTime(), "mmm d") 
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] QuickenWindow.SetActive()
				[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] sAmountPaid=trim(Left(lsTransaction[6],6))
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] WaitForState(Business,TRUE,2)
				[ ] hWnd = str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
				[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify transaction with Business Tag and Rental tag gets displayed on Business > Profit Loss ", PASS, "Transaction with Business Tag and Rental tag and with amount {sAmountPaid}  is displayed in the OUT section of  Business > Profit Loss .") 
				[+] else
					[ ] ReportStatus(" Verify transaction with Business Tag and Rental tag gets displayed on Business > Profit Loss ", FAIL, "Transaction with Business Tag and Rental tag and with amount  {sAmountPaid}  is not displayed in the OUT section of  Business > Profit Loss.") 
					[ ] 
				[ ] //############## Verifying transaction without category gets displayed on RentalProperty > Profit Loss############
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] sExpected=NULL
				[ ] sExpected="Possibly Deductible"
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] WaitForState(RentalPropertyRentCenter,True,2)
				[ ] hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer3.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
				[ ] bMatch = MatchStr("*{sExpected}*", sActual)
				[+] if ( bMatch )
					[ ] ReportStatus(" Transaction with Business Tag and Rental tag and with amount ", PASS, " {sExpected} link is displayed in the OUT section of  RentalProperty > Profit Loss.") 
					[ ] // #################Possibly Deductible Popup is clicked with the help of Location Identifier###############/// 
					[ ] RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer3.ListBox1.Click(1,42,23)
					[ ] WaitForState(RecordedDepositsCallout,True,2)
					[ ] sleep(4)
					[+] if (RecordedDepositsCallout.Exists(5))
						[ ] ReportStatus("Verify Possibly Deductible become link. ", PASS, "Recorded Deposits text become link. ") 
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] // Read data from excel sheet sTransactionSheet
						[ ] lsExcelData=NULL
						[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
						[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bMatch = MatchStr("*{lsTransaction[2]}*{sDateStamp}*{sAmountPaid}*", sActual)
							[+] if ( bMatch )
								[ ] break
						[+] if ( bMatch )
							[ ] ReportStatus(" Verify Transaction with Business Tag and Rental tag in Possibly Deductible Popup", PASS, " Transaction with Business Tag and Rental tag and with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has been added to the Possibly Deductible  CallOut. ") 
						[+] else
							[ ] ReportStatus(" Verify Transaction with Business Tag and Rental tag in Possibly Deductible Popup", FAIL, " Transaction with Business Tag and Rental tag and with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Possibly Deductible CallOut is {sActual}. ") 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] sleep(1)
						[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
						[ ] sleep(2)
					[+] else
						[ ] ReportStatus("Verify Possibly Deductible become link. ", FAIL, "Possibly Deductible text does not become link. ") 
				[+] else
					[ ] ReportStatus("Transaction with Business Tag and Rental tag and with amount  ", FAIL, " {sExpected} link is not displayed in the OUT section of  RentalProperty > Profit Loss and actual result is {sActual} .") 
			[+] else
				[ ] ReportStatus("Select Account", FAIL, "Account: {lsAddAccount[2]}  couldn't be selected") 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Add Business", FAIL, "Business is not added")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test35_AddTransactionwithRentalCategoryOnly ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test35_AddTransactionwithRentalCategoryOnly()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //// This testcase will verify adding a transaction with Rental Category Only	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	f no error occurs while adding a transaction with Rental Category Only			
		[ ] //						Fail		If transaction with rental tag does not get added with Rental Category Only		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 20, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test35_AddTransactionwithRentalCategoryOnly() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[4]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] 
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] //MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] sleep(SHORT_SLEEP)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[ ] 
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //############## Verifying transaction with rental category only does not get displayed on Business > Profit Loss############
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] sAmountPaid=trim(Left(lsTransaction[6],6))
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(Business,True,2)
			[ ] hWnd = str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.GetHandle())
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
			[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify transaction with rental category only does not get displayed on Business > Profit Loss ", FAIL, "Transaction with rental category only with amount {sAmountPaid}  is displayed in the OUT section of  Business > Profit Loss .") 
			[+] else
				[ ] ReportStatus(" Verify transaction with rental category only does not get displayed on Business > Profit Loss ", PASS, "Transaction with rental category only with amount {sAmountPaid} is not displayed in the OUT section of  Business > Profit Loss.") 
				[ ] 
			[ ] //############## Verifying transaction gets displayed on RentalProperty > Profit Loss############
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.GetHandle())
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
			[ ] bMatch = MatchStr("*-100*", sActual)
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify transaction with rental category only gets displayed on RentalProperty > Profit Loss ", PASS, " Transaction with rental category only with amount -100 is displayed in the OUT section of  RentalProperty > Profit Loss.") 
			[+] else
				[ ] ReportStatus(" Verify transaction with rental category only gets displayed on RentalProperty > Profit Loss ", FAIL, " Transaction with rental category only with amount -100 is not displayed in the OUT section of  RentalProperty > Profit Loss and actual Amount is {sActual} .") 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select Account", FAIL, "Account: {lsAddAccount[2]}  couldn't be selected") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test36_AddTransactionwithBusinessCategoryOnly ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test36_AddTransactionwithBusinessCategoryOnly()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding a transaction with Business Category Only		
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	f no error occurs while adding a transaction with Business Category Only			
		[ ] //						Fail		If transaction with rental tag does not get added with Business Category Only		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 20, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test36_AddTransactionwithBusinessCategoryOnly() appstate RPMBaseState
	[ ] STRING sUnknownBusiness
	[ ] sUnknownBusiness= "Unknown Business"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[5]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect =SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] 
			[ ] 
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] //MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] sleep(SHORT_SLEEP)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //############## Verifying transaction with Business category only get displayed on Business > Profit Loss############
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] sAmountPaid=trim(Left(lsTransaction[6],6))
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] //Commented as Unknown Business option doesn't appear
			[ ] 
			[ ] //Business.BusinessPopupList.Select(sUnknownBusiness)
			[ ] WaitForState(Business,True,2)
			[ ] hWnd = str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer1.ListBox1.GetHandle())
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
			[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify transaction with Business category displayed on Business > Profit Loss ", PASS, "Transaction with Business category and with amount {sAmountPaid}  is displayed in the IN section of  Business > Profit Loss .") 
			[+] else
				[ ] ReportStatus(" Verify transaction with Business category gets displayed on Business > Profit Loss ", FAIL, "Transaction with Business category and with amount  {sAmountPaid}  is not displayed in the IN section of  Business > Profit Loss.") 
				[ ] 
			[ ] //############## Verify Transaction with Business category only does not display under RentalProperty > Profit Loss>Recorded Deposits############
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] hWnd = str(RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.GetHandle())
			[ ] // #################Recorded Deposits Popup is clicked with the help of Location Identifier###############/// 
			[ ] RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.Click(1,49,4)
			[ ] sleep(4)
			[ ] WaitForState(RecordedDepositsCallout,True,2)
			[+] if (RecordedDepositsCallout.Exists(5))
				[ ] ReportStatus("Verify Recorded Deposits become link. ", PASS, "Recorded Deposits text become link. ") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{lsTransaction[2]}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify transaction with Business category only RentalProperty > Profit Loss>Recorded Deposits", FAIL, "Verify Transaction with Business category only does not display under RentalProperty > Profit Loss>Recorded Deposits: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has been added to the Recorded Deposits CallOut. ") 
				[+] else
					[ ] ReportStatus(" Verify transaction with Business category only RentalProperty > Profit Loss>Recorded Deposits", PASS, " Verify Transaction with Business category only does not display under RentalProperty > Profit Loss>Recorded Deposits: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has not been added to the Recorded Deposits CallOut. ") 
			[+] else
				[ ] ReportStatus("Verify Recorded Deposits become link. ", FAIL, "Recorded Deposits text does not become link. ") 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] sleep(1)
			[ ] 
			[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
			[ ] sleep(2)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account selected. ", FAIL, "Account couldn't be selected. ") 
		[ ] //############## Verifying transaction with Business category only get displayed on Business > Profit Loss after hiding the account############
		[ ] iSelect = AccountHideInAccountBarAccountList(ACCOUNT_RENTALPROPERTY,lsAddAccount[2]) 
		[ ] // 
		[+] if(iSelect==PASS)
			[ ] //############## Verifying transaction with Business category only get displayed on Business > Profit Loss############
			[ ] 
			[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] sAmountPaid=trim(Left(lsTransaction[6],6))
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(Business,True,1)
			[ ] //Commented as Unknown Business option doesn't appear
			[ ] //Business.BusinessPopupList.Select(sUnknownBusiness)
			[ ] WaitForState(Business,True,2)
			[ ] hWnd = str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer1.ListBox1.GetHandle())
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
			[ ] bMatch = MatchStr("*{sAmountPaid}*", sActual)
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify transaction with Business category displayed on Business > Profit Loss after hiding the account", PASS, "Transaction with Business category and with amount {sAmountPaid}  is displayed in the IN section of  Business > Profit Loss after hiding the account.") 
			[+] else
				[ ] ReportStatus(" Verify transaction with Business category gets displayed on Business > Profit Loss after hiding the account", FAIL, "Transaction with Business category and with amount  {sAmountPaid}  is not displayed in the IN section of  Business > Profit Loss after hiding the account.") 
			[ ] //############## Verifying transaction with Business category only get displayed on Reports>Business > Profit and Loss Statement after hiding the account############
			[ ] QuickenWindow.SetActive()
			[ ] // Open Profit Loss Statement Report
			[ ] sExpReportTitle=NULL
			[ ] sExpReportTitle="Profit and Loss Statement"
			[ ] iReportSelect = OpenReport(lsReportCategory[8], sTAB_PROFIT_AND_LOSS_STATEMENT)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sTAB_PROFIT_AND_LOSS_STATEMENT} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify Cash Flow Report is Opened
				[+] if (ProfitAndLossStatement.Exists(5))
					[ ] 
					[ ] // Set Active Cash Flow Report 
					[ ] ProfitAndLossStatement.SetActive()
					[ ] 
					[ ] // Maximize Cash Flow Report 
					[ ] ProfitAndLossStatement.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = ProfitAndLossStatement.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = AssertEquals(sExpReportTitle, sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] hWnd = Str(ProfitAndLossStatement.QWListViewer1.ListBox1.GetHandle ())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,"2")
						[ ] bMatch = MatchStr("*{lsTransaction[3]}*{sAmountPaid}*", sActual)
						[+] if(bMatch)
							[ ] ReportStatus("Validate Report Data", PASS, " Transaction with{lsTransaction[3]} and  {sAmountPaid} get displayed on Reports>Business > Profit and Loss Statement after hiding the account in {sTAB_PROFIT_AND_LOSS_STATEMENT}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with{lsTransaction[3]} and  {sAmountPaid} didn't display on Reports>Business > Profit and Loss Statement after hiding the account in {sTAB_PROFIT_AND_LOSS_STATEMENT} and actual Transaction is {sActual}.")
					[ ] // Report Status if window title is wrong
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title  -  {sActual} is not matching with Expected - {sExpReportTitle}") 
					[ ] 
					[ ] // Close Cash Flow Report window
					[ ] ProfitAndLossStatement.TypeKeys(KEY_EXIT)
					[+] if(SaveReportAs.Exists(5))
						[ ] SaveReportAs.SetActive()
						[ ] SaveReportAs.DonTShowMeThisAgain.Check()
						[ ] SaveReportAs.DonTSave.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verification of {sExpReportTitle} window", FAIL, "{sExpReportTitle} window not found") 
					[ ] 
			[+] else
				[ ] ReportStatus("Run {sTAB_PROFIT_AND_LOSS_STATEMENT} Report", iReportSelect, "Run Report unsuccessful") 
			[ ] 
			[ ] //############## Unhide the account############
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] WaitForState(AccountList,TRUE,2)
			[+] if (AccountList.Exists(2))
				[ ] AccountList.SetActive()
				[ ] AccountList.QWinChild.ShowHiddenAccounts.Check()
				[ ] WaitForState(AccountList,TRUE,1)
				[ ] AccountList.QWinChild.Order.ListBox.TextClick("Edit" ,1)
				[ ] // AccountDetails.Click(1,255,46)
				[+] if (AccountDetails.Exists(2))
					[ ] AccountDetails.TextClick("Display Options")
					[ ] AccountDetails.SetActive()
					[ ] AccountDetails.HideAccountNameInAccountB.Uncheck()
					[ ] AccountDetails.OK.Click()
					[ ] WaitForState(AccountDetails,FALSE,1)
				[+] else
					[ ] ReportStatus("Verify Account Deatils dialog appeared." , FAIL , "Account Deatils dialog didn't appear.")
				[ ] 
				[ ] 
				[ ] AccountList.Done.Click()
				[ ] WaitForState(AccountList,FALSE,1)
			[+] else
				[ ] ReportStatus("Verify Account List exists. ", FAIL, "Account List didn't appear so Account couldn't be unhidden. ") 
		[+] else
			[ ] ReportStatus("Verify Account is Hidden In Account Bar and Account List. ", FAIL, "Account is not hidden from account bar and account list ") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test37_AddTransactionwithExpenseBusinessCategoryOnly ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test37_AddTransactionwithExpenseBusinessCategoryOnly()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding a transaction with  Business Expense Category Only			
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while adding a transaction with  Business Expense Category Only			
		[ ] //						Fail		If transaction with rental tag does not get added with Business Expense Category Only		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 22, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test37_AddTransactionwithExpenseBusinessCategoryOnly() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[7]
	[ ] sAmountPaid=NULL
	[ ] sAmountPaid=trim(Left(lsTransaction[6],6))
	[ ] 
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] 
			[ ] 
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] //MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] sleep(SHORT_SLEEP)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account selected. ", FAIL, "Account couldn't be selected. ") 
		[ ] //############## Hiding the Account############
		[ ] iSelect = AccountHideInAccountBarAccountList(ACCOUNT_RENTALPROPERTY,lsAddAccount[2]) 
		[+] if(iSelect==PASS)
			[ ] // ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] // QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_E)
			[ ] // WaitForState(AccountDetails,True,2)
			[+] // if (AccountDetails.Exists(5))
				[ ] // AccountDetails.SetActive()
				[ ] // AccountDetails.Click(1,255,46)
				[ ] // AccountDetails.SetActive()
				[ ] // AccountDetails.HideAccountNameInAccountB.Check()
				[ ] // AccountDetails.OK.Click()
				[ ] // WaitForState(AccountDetails,FALSE,1)
				[ ] // WaitForState(QuickenWindow,True,2)
				[ ] // QuickenWindow.SetActive()
			[+] // else
				[ ] // ReportStatus("Verify Account Details exists. ", FAIL, "Account Details didn't appear. ") 
				[ ] // 
			[ ] //############## Verifying transaction with Business category only get displayed on Reports>Business > Spending by Payee after hiding the account############
			[ ] QuickenWindow.SetActive()
			[ ] // Open Spending by Payee Report
			[ ] sExpReportTitle=NULL
			[ ] sExpReportTitle="Spending by Payee"
			[ ] iReportSelect = OpenReport(lsReportCategory[5], sREPORT_SPENDING_BY_PAYEE)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sREPORT_SPENDING_BY_PAYEE} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify sREPORT_SPENDING_BY_PAYEE is Opened
				[+] if (SpendingByPayee.Exists(5))
					[ ] 
					[ ] // Set Actives REPORT_SPENDING_BY_PAYEE Report 
					[ ] SpendingByPayee.SetActive()
					[ ] 
					[ ] // Maximize sREPORT_SPENDING_BY_PAYEEReport 
					[ ] SpendingByPayee.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = SpendingByPayee.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = AssertEquals(sExpReportTitle, sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] hWnd = Str(SpendingByPayee.QWListViewer1.ListBox1.GetHandle ())
						[ ] iReportRowsCount=SpendingByPayee.QWListViewer1.ListBox1.GetItemCount() +1
						[+] for( iCounter=0;iCounter<iReportRowsCount ; ++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bMatch = MatchStr("*{lsTransaction[2]}*{sAmountPaid}*", sActual)
							[+] if ( bMatch == TRUE)
								[ ] break
						[ ] 
						[+] if(bMatch)
							[ ] ReportStatus("Validate Report Data", PASS, " Transaction with{lsTransaction[2]} and  {sAmountPaid} get displayed on {sREPORT_SPENDING_BY_PAYEE} after hiding the account .")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with{lsTransaction[2]} and  {sAmountPaid} didn't display on {sREPORT_SPENDING_BY_PAYEE} after hiding the account and actual Transaction is {sActual}.")
					[ ] // Report Status if window title is wrong
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title  -  {sActual} is not matching with Expected - {sExpReportTitle}") 
					[ ] 
					[ ] // Close Cash Flow Report window
					[ ] SpendingByPayee.TypeKeys(KEY_EXIT)
					[+] if(SaveReportAs.Exists(5))
						[ ] SaveReportAs.SetActive()
						[ ] SaveReportAs.DonTShowMeThisAgain.Check()
						[ ] SaveReportAs.DonTSave.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verification of {sExpReportTitle} window", FAIL, "{sExpReportTitle} window not found") 
					[ ] 
			[+] else
				[ ] ReportStatus("Run {sTAB_PROFIT_AND_LOSS_STATEMENT} Report", iReportSelect, "Run Report unsuccessful") 
			[ ] //############## Verifying transaction with Business category only get displayed on Reports>Business > Spending by Category after hiding the account############
			[ ] QuickenWindow.SetActive()
			[ ] // Open Spending by Category Report
			[ ] sExpReportTitle=NULL
			[ ] sExpReportTitle="Spending by Category"
			[ ] iReportSelect = OpenReport(lsReportCategory[5], sREPORT_SPENDING_BY_CAT)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sREPORT_SPENDING_BY_CAT} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify sREPORT_SPENDING_BY_PAYEE is Opened
				[+] if (SpendingByCategory.Exists(5))
					[ ] 
					[ ] // Set Actives sREPORT_SPENDING_BY_CAT Report 
					[ ] SpendingByCategory.SetActive()
					[ ] 
					[ ] // Maximize sREPORT_SPENDING_BY_CAT 
					[ ] SpendingByCategory.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = SpendingByCategory.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = AssertEquals(sExpReportTitle, sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] hWnd=NULL
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] hWnd = Str(SpendingByCategory.QWListViewer1.ListBox1.GetHandle ())
						[ ] 
						[ ] iReportRowsCount=SpendingByCategory.QWListViewer1.ListBox1.GetItemCount() +1
						[+] for( iCounter=0;iCounter< iReportRowsCount ; ++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bMatch = MatchStr("*{lsTransaction[3]}*{sAmountPaid}*", sActual)
							[+] if ( bMatch == TRUE)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Validate Report Data", PASS, " Transaction with{lsTransaction[3]} and  {sAmountPaid} get displayed on  {sREPORT_SPENDING_BY_CAT} after hiding the account.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with{lsTransaction[3]} and  {sAmountPaid} didn't display on {sREPORT_SPENDING_BY_CAT} after hiding the account and actual Transaction is {sActual}.")
					[ ] // Report Status if window title is wrong
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title  -  {sActual} is not matching with Expected - {sExpReportTitle}") 
					[ ] 
					[ ] // Close Cash Flow Report window
					[ ] SpendingByCategory.TypeKeys(KEY_EXIT)
					[+] if(SaveReportAs.Exists(5))
						[ ] SaveReportAs.SetActive()
						[ ] SaveReportAs.DonTShowMeThisAgain.Check()
						[ ] SaveReportAs.DonTSave.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verification of {sExpReportTitle} window", FAIL, "{sExpReportTitle} window not found") 
					[ ] 
			[+] else
				[ ] ReportStatus("Run {sTAB_PROFIT_AND_LOSS_STATEMENT} Report", iReportSelect, "Run Report unsuccessful") 
			[ ] 
			[ ] //############## Unhide the account############
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] WaitForState(AccountList,TRUE,2)
			[+] if (AccountList.Exists(5))
				[ ] AccountList.SetActive()
				[ ] AccountList.QWinChild.ShowHiddenAccounts.Check()
				[ ] WaitForState(AccountList,TRUE,1)
				[ ] AccountList.ListBox.TextClick("Edit" , 1)
				[ ] // AccountDetails.Click(1,255,46)
				[+] if (AccountDetails.Exists(5))
					[ ] AccountDetails.SetActive()
					[ ] AccountDetails.TextClick("Display Options")
					[ ] AccountDetails.SetActive()
					[ ] AccountDetails.HideAccountNameInAccountB.Uncheck()
					[ ] AccountDetails.OK.Click()
					[ ] WaitForState(AccountDetails,FALSE,5)
					[ ] AccountList.SetActive()
					[ ] AccountList.Done.Click()
					[ ] WaitForState(AccountList,FALSE,1)
					[ ] QuickenWindow.SetActive()
					[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
					[+] if(iSelect==PASS)
						[ ] ReportStatus("Select Account", iSelect, "Account is visible again.") 
					[+] else
						[ ] ReportStatus("Select Account", iSelect, "Account couldn't be made visible again.") 
				[+] else
					[ ] ReportStatus("Verify Account Details exists. ", FAIL, "Account Details didn't appear so Account couldn't be set to visible.") 
			[+] else
				[ ] ReportStatus("Verify Account List exists. ", FAIL, "Account List didn't appear so Account couldn't be set to visible.") 
		[+] else
			[ ] ReportStatus("Verify Account selected. ", FAIL, "Account couldn't be selected. ") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test38_AddIncomeTransactionwithRentalTagOnly ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test38_AddIncomeTransactionwithRentalTagOnly()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify adding a transaction with Rental Tag Only	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while adding a transaction with Rental Tag Only			
		[ ] //						Fail		If transaction with rental tag does not get added	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 21, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test38_AddIncomeTransactionwithRentalTagOnly() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] lsAddProperty=lsExcelData[1]
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[6]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] sleep(SHORT_SLEEP)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //############## Verifying transaction with rental tag only does not get displayed on Business > Profit Loss############
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
			[ ] sDateStamp=NULL
			[ ] sDateStamp = FormatDateTime (GetDateTime(), "mmm d") 
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] sAmountPaid=trim(Left(lsTransaction[6],6))
			[ ] WaitForState(QuickenMainWindow,True,1)
			[ ] WaitForState(Business,True,1)
			[ ] // #################Recorded Deposits Popup is clicked with the help of Location Identifier###############/// 
			[ ] Business.ProfitLossSnapshot.MonthPanel.QWListViewer1.ListBox1.Click(1,49,4)
			[ ] sleep(4)
			[ ] WaitForState(RecordedDepositsCallout,True,2)
			[+] if (RecordedDepositsCallout.Exists(5))
				[ ] ReportStatus("Verify Recorded Deposits become link. ", PASS, "Recorded Deposits text become link. ") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{lsTransaction[2]}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Income transaction with rental tag only in the Recorded Deposits Popup", FAIL, " Verifying Income transaction with rental tag only does not get displayed on Business > Profit Loss: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has been added to the Recorded Deposits CallOut. ") 
				[+] else
					[ ] ReportStatus(" Verify Income transaction with rental tag only in the Recorded Deposits Popup", PASS, " Verifying Income transaction with rental tag only does not get displayed on Business > Profit Loss: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has not been added to the Recorded Deposits CallOut. ") 
			[+] else
				[ ] ReportStatus("Verify Recorded Deposits become link. ", FAIL, "Recorded Deposits text does not become link. ") 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] sleep(1)
			[ ] 
			[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
			[ ] sleep(2)
			[ ] //############## Verifying transaction with rental tag only gets displayed on RentalProperty > Profit Loss############
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] WaitForState(QuickenMainWindow,True,1)
			[ ] WaitForState(RentalPropertyRentCenter,True,1)
			[ ] //// #################Recorded Deposits Popup is clicked with the help of Location Identifier###############/// 
			[ ] RentalPropertyRentCenter.InOutProfitLoss.InOutProfitLossPanel.QWListViewer1.ListBox1.Click(1,49,4)
			[ ] sleep(4)
			[ ] WaitForState(RecordedDepositsCallout,True,2)
			[+] if (RecordedDepositsCallout.Exists(5))
				[ ] ReportStatus("Verify Recorded Deposits become link. ", PASS, "Recorded Deposits text become link. ") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{lsTransaction[2]}*{sDateStamp}*{sAmountPaid}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[ ] bMatch = MatchStr("*{lsTransaction[2]}*{sAmountPaid}*", sActual)
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Income transaction with rental tag only in the Recorded Deposits Popup", PASS, "  Verifying Income transaction with rental tag only get displayed on Rental Property > Profit Loss: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has been added to the Recorded Deposits CallOut. ") 
				[+] else
					[ ] ReportStatus(" Verify Income transaction with rental tag only in the Recorded Deposits Popup", FAIL, "  Verifying Income transaction with rental tag only  get displayed on Rental Property  > Profit Loss: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Recorded Deposits CallOut is {sActual}. ") 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] sleep(1)
				[ ] 
				[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
				[ ] sleep(2)
				[ ] //report
				[ ] 
				[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
				[ ] QuickenWindow.SetActive()
				[ ] // Open Schedule E Report
				[ ] sExpReportTitle=NULL
				[ ] sExpReportTitle="Schedule E Report"
				[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
				[+] if (iReportSelect==PASS)
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
					[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
					[+] if (ScheduleEReportWindow.Exists(5))
						[ ] 
						[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
						[ ] ScheduleEReportWindow.SetActive()
						[ ] 
						[ ] // Maximize sTAB_SHEDULE_E_REPORT 
						[ ] ScheduleEReportWindow.Maximize()
						[ ] 
						[ ] // Get window caption
						[ ] sActual = ScheduleEReportWindow.GetCaption()
						[ ] 
						[ ] // Verify window title
						[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
						[ ] 
						[ ] // Report Status if window title is as expected
						[+] if ( bMatch )
							[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
							[ ] //  Validate Report Data
							[ ] hWnd=NULL
							[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
							[ ] 
							[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
							[+] for( iCounter=0;iCounter<iReportRowsCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] ListAppend (lsListBoxItems,sActual)
							[ ] 
							[ ] //####Verify "**Unspecified Rental Income**[Property]" row on "Schedule E" report
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] sExpected=NULL
							[ ] sExpected= "Unspecified Rental Income"
							[+] for each sItem in lsListBoxItems
								[ ] bMatch = MatchStr("*{sExpected}*{lsAddProperty[1]}*",sItem)
								[+] if ( bMatch == TRUE)
									[ ] break
							[ ] 
							[+] if(bMatch)
								[ ] ReportStatus("Validate Report Data", PASS, " Row {sItem} get displayed as expected {sExpected} on {sTAB_SHEDULE_E_REPORT}.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Row {sItem} didn't display as expected {sExpected} on {sTAB_SHEDULE_E_REPORT}.")
								[ ] 
							[ ] //####Verify "**Unspecified Rental Income**[Property]" row on "Schedule E" report
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] sExpected=NULL
							[ ] sExpected= "Resolve Unspecified Rental Property Expense transactions"
							[+] for each sItem in lsListBoxItems
								[ ] bMatch = MatchStr("*{sExpected}*",sItem)
								[+] if ( bMatch == TRUE)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Validate Report Data", PASS, " Row {sExpected} get displayed as expected on {sTAB_SHEDULE_E_REPORT}.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Row {sExpected} didn't display as expecte on {sTAB_SHEDULE_E_REPORT}.")
							[ ] 
							[ ] //####Verify transaction data on for **Unspecified Rental Income**[Property] row on "Schedule E" report
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[+] for each sItem in lsListBoxItems
								[ ] bMatch = MatchStr("*{lsTransaction[2]}*{lsTransaction[4]}*{sAmountPaid}*", sItem)
								[+] if ( bMatch == TRUE)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Validate Report Data", PASS, " Transaction with Payee :{lsTransaction[2]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} get displayed on  {sTAB_SHEDULE_E_REPORT}.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with Payee :{lsTransaction[2]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} didn't display on {sTAB_SHEDULE_E_REPORT}.")
								[ ] 
						[+] else
							[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
						[ ] ScheduleEReportWindow.Close()
						[+] if(SaveReportAs.Exists(5))
							[ ] SaveReportAs.SetActive()
							[ ] SaveReportAs.DonTShowMeThisAgain.Check()
							[ ] SaveReportAs.DonTSave.Click()
						[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
						[ ] /////#######Report validation done#######///
					[+] else
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
				[ ] //report
			[+] else
				[ ] ReportStatus("Verify Recorded Deposits become link. ", FAIL, "Recorded Deposits text does not become link. ") 
			[ ] 
		[+] else
			[ ] ReportStatus("Select Account", FAIL, "Account: {lsAddAccount[2]}  couldn't be selected") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test39_AddSplitTransactionwithRentalCategoryAndTag ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test39_AddSplitTransactionwithRentalCategoryAndTag()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify adding a split transaction with Rental Category Only		
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while adding a split transaction with Rental Category and rental tag			
		[ ] //						Fail		If error occurs while adding a split transaction with Rental Category and rental tag		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 22, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test39_AddSplitTransactionwithRentalCategoryAndTag() appstate RPMBaseState
	[ ] STRING sSplitCat ,sSplitCatAmount
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[8]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sSplitCat="Commissions (Rental)"
	[ ] sSplitCatAmount="10"
	[ ] iAmount1=VAL(lsTransaction[6])
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[2]
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Add one more property
		[ ] AddRentalProperty(lsAddProperty)
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[ ] //Add a split transaction with rental categories along with tags of both the properties 
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] //Split categories
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_S)
			[+] if(SplitTransaction.Exists(2))
				[ ] SplitTransaction.SetActive()
				[ ] //commented by mukesh 08/20/2012
				[ ] //SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#2")
				[ ] //commented by mukesh 08/20/2012
				[ ] //Added by mukesh 08/20/2012
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TypeKeys(KEY_ENTER)
				[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(sSplitCat)
				[ ] //Added by mukesh 08/20/2012
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
				[ ] //Property Tag for 2nd transaction
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.SetText(lsAddProperty[2])
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.SetText(sSplitCatAmount)
				[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] WaitForState(SplitTransaction,True,2)
				[+] if(SplitTransaction.Adjust.IsEnabled())
					[ ] SplitTransaction.Adjust.Click()
				[ ] WaitForState(SplitTransaction,True,1)
				[ ] SplitTransaction.OK.Click()
				[ ] WaitForState(SplitTransaction,FALSE,1)
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
				[+] if (DlgSaveTransaction.Exists(5))
					[ ] DlgSaveTransaction.SetActive()
					[ ] DlgSaveTransaction.DontShowAgain.Check()
					[ ] DlgSaveTransaction.Save.Click()
					[ ] sleep(2)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify SplitTransaction dialog. ", FAIL, "SplitTransaction dialog didn't appear. ") 
			[ ] 
			[ ] 
			[ ] //############## Verifying transaction gets displayed on RentalProperty >  Profit Loss>Property1############
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] // Read data from excel sheet
			[ ] lsExcelData=NULL
			[ ] lsAddProperty=NULL
			[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
			[ ] // Fetch 1st row from the given sheet
			[ ] lsAddProperty=lsExcelData[2]
			[ ] 
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,1)
			[ ] QuickenWindow.SetActive()
			[ ] //// selected the same property two times as it doesn't get displayed in the first attempt////
			[ ] RentalPropertyRentCenter.PopupList1.Select(lsAddProperty[1])
			[ ] RentalPropertyRentCenter.PopupList1.Select(lsAddProperty[1])
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] //// #################Recorded Expense Popup is clicked with the help of Location Identifier###############/// 
			[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
			[ ] sleep(4)
			[ ] WaitForState(RecordedDepositsCallout,True,2)
			[+] if (RecordedDepositsCallout.Exists(5))
				[ ] ReportStatus("Verify Recorded Expense become link. ", PASS, "Recorded Expense text become link for {lsAddProperty[1]}. ") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sSplitCat}*{sSplitCatAmount}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify split transaction with rental category and rental tag ", PASS, " Verify split transaction with rental category and rental tag in property : {lsTransaction[4]}:Transaction with Category:{sSplitCatAmount}, Date:{sDateStamp},and Amount:{sSplitCat} has been added in the OUT section of RentalProperty > Profit Loss>Recorded Deposits CallOut.") 
				[+] else
					[ ] ReportStatus(" Verify split transaction with rental category and rental tag ", FAIL, " Verify split transaction with rental category and rental tag property : {lsTransaction[4]}: Transaction with Category:{sSplitCatAmount}, Date:{sDateStamp},and Amount:{sSplitCat} has been added in the OUT section of RentalProperty > Profit Loss>Recorded Deposits CallOut.") 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] sleep(1)
				[ ] 
				[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Verify Recorded Expense become link. ", FAIL, "Recorded Expense text does not become link for {lsAddProperty[1]}. ") 
			[ ] 
			[ ] //############## Verifying transaction gets displayed on RentalProperty > Profit Loss>Property1_Edit############
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] // Read data from excel sheet
			[ ] 
			[ ] // Fetch 1st row from the given sheet
			[ ] lsAddProperty=lsExcelData[1]
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,1)
			[ ] QuickenWindow.SetActive()
			[ ] RentalPropertyRentCenter.PopupList1.Select(lsAddProperty[1])
			[ ] RentalPropertyRentCenter.PopupList1.Select(lsAddProperty[1])
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] //// #################Recorded Deposits Popup is clicked with the help of Location Identifier###############/// 
			[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
			[ ] sleep(4)
			[ ] WaitForState(RecordedDepositsCallout,True,2)
			[+] if (RecordedDepositsCallout.Exists(5))
				[ ] ReportStatus("Verify Recorded Expense become link. ", PASS, "Recorded Expense text become link for {lsAddProperty[1]}. ") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{lsTransaction[3]}*{iAmount1}*", sActual)
					[+] if ( bMatch )
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify split transaction with rental category and rental tag ", PASS, " Verify split transaction with rental category and rental tag in property : {lsTransaction[4]}:Transaction with Category: {lsTransaction[3]}, Date:{sDateStamp},and Amount:{iAmount1} has been added in the OUT section of RentalProperty > Profit Loss>Recorded Deposits CallOut.") 
				[+] else
					[ ] ReportStatus(" Verify split transaction with rental category and rental tag ", FAIL, " Verify split transaction with rental category and rental tag property : {lsTransaction[4]}: Transaction with Category: {lsTransaction[3]}, Date:{sDateStamp},and Amount:{iAmount1} has been added in the OUT section of RentalProperty > Profit Loss>Recorded Deposits CallOut.") 
				[ ] QuickenWindow.SetActive()
				[ ] sleep(1)
				[ ] 
				[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Verify Recorded Expense become link. ", FAIL, "Recorded Expense text does not become link for {lsAddProperty[1]}. ") 
		[+] else
			[ ] ReportStatus("Verify Account selection. ", FAIL, "Account couldn't be selected. ") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test40_AddExpenseTransactionwithRentalTagOnly ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test40_AddExpenseTransactionwithRentalTagOnly()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify adding an expense transaction with Rental Tag Only	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	f no error occurs while adding an expense transaction with Rental Tag Only			
		[ ] //						Fail		If expense transaction with rental tag does not get added	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 24, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test40_AddExpenseTransactionwithRentalTagOnly() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] lsAddProperty=lsExcelData[1]
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[9]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] sleep(SHORT_SLEEP)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] 
			[ ] //############## Verifying transaction with rental tag only does not get displayed on Business > Profit Loss############
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] QuickenWindow.SetActive()
			[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] sAmountPaid=trim(Left(lsTransaction[6],6))
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(Business,True,1)
			[ ] // #################Recorded Expenses Popup is clicked with the help of Location Identifier###############/// 
			[ ] //// Till now the total Uncategorized business transactions should be as below
			[ ] /// Uncategorized=300, RentalTag Transaction =100 which shouldn't be displayed
			[ ] sExpected="Uncategorized"
			[ ] iAmount=400
			[ ] Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.Click(1,49,4)
			[ ] sleep(4)
			[ ] WaitForState(RecordedDepositsCallout,True,2)
			[+] if (RecordedDepositsCallout.Exists(5))
				[ ] ReportStatus("Verify Recorded Expenses become link. ", PASS, "Recorded Expenses text become link. ") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sExpected}*{iAmount}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[ ] ////####################
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify transaction with rental tag does not get displayed on Business > Profit Loss ", FAIL, "Transaction with rental tag and with amount {sAmountPaid}  is displayed in the OUT section of  Business > Profit Loss .") 
				[+] else
					[ ] ReportStatus(" Verify transaction with rental tag does not get displayed on Business > Profit Loss ", PASS, "Transaction with rental tag and with amount  {sAmountPaid}  is not displayed in the OUT section of  Business > Profit Loss.") 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] sleep(1)
				[ ] 
				[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
				[ ] sleep(2)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Recorded Expenses become link. ", FAIL, "Recorded Expenses text does not become link. ") 
			[ ] 
			[ ] //############## Verifying transaction with rental tag only gets displayed on RentalProperty > Profit Loss############
			[ ] //// Till now the total Uncategorized Rental transactions should be as below
			[ ] //// 500
			[ ] /// Uncategorized=800
			[ ] sExpected="Uncategorized"
			[ ] iAmount=800
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] // #################Recorded Expenses Popup is clicked with the help of Location Identifier###############/// 
			[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
			[ ] sleep(4)
			[ ] WaitForState(RecordedDepositsCallout,True,2)
			[+] if (RecordedDepositsCallout.Exists(5))
				[ ] ReportStatus("Verify Recorded Expenses become link. ", PASS, "Recorded Expenses text become link. ") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sExpected}*{iAmount}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify transaction with rental tag only in the Recorded Expenses Popup", PASS, " Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has been added to the Recorded Expenses CallOut. ") 
				[+] else
					[ ] ReportStatus(" Verify transaction with rental tag only in the Recorded Expenses Popup", FAIL, " Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{sAmountPaid} has not been added correctly,  the actual transaction added to the Recorded Expenses CallOut is {sActual}. ") 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] sleep(1)
				[ ] 
				[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
				[ ] sleep(2)
				[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
				[ ] QuickenWindow.SetActive()
				[ ] // Open Schedule E Report
				[ ] sExpReportTitle=NULL
				[ ] sExpReportTitle="Schedule E Report"
				[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
				[+] if (iReportSelect==PASS)
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
					[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
					[+] if (ScheduleEReportWindow.Exists(5))
						[ ] 
						[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
						[ ] ScheduleEReportWindow.SetActive()
						[ ] 
						[ ] // Maximize sTAB_SHEDULE_E_REPORT 
						[ ] ScheduleEReportWindow.Maximize()
						[ ] 
						[ ] // Get window caption
						[ ] sActual = ScheduleEReportWindow.GetCaption()
						[ ] 
						[ ] // Verify window title
						[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
						[ ] 
						[ ] // Report Status if window title is as expected
						[+] if ( bMatch )
							[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
							[ ] //  Validate Report Data
							[ ] ////####Fetching all the report rows lsListBoxItems####////
							[ ] hWnd=NULL
							[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
							[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
							[+] for( iCounter=0;iCounter<iReportRowsCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] ListAppend (lsListBoxItems,sActual)
							[ ] //####Verify "**Unspecified Rental Expense**[Property]" row on "Schedule E" report
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] sExpected=NULL
							[ ] sExpected= "Unspecified Rental Expense"
							[+] for each sItem in lsListBoxItems
								[ ] bMatch = MatchStr("*{sExpected}*{lsAddProperty[1]}*",sItem)
								[+] if ( bMatch == TRUE)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Validate Report Data", PASS, " Row {sItem} get displayed as expected {sExpected} on {sTAB_SHEDULE_E_REPORT}.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Row {sItem} didn't display as expected {sExpected} on {sTAB_SHEDULE_E_REPORT}.")
								[ ] 
							[ ] //####Verify "**Unspecified Rental Income**[Property]" row on "Schedule E" report
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] sExpected=NULL
							[ ] sExpected= "Resolve Unspecified Rental Property Expense transactions"
							[+] for each sItem in lsListBoxItems
								[ ] bMatch = MatchStr("*{sExpected}*",sItem)
								[+] if ( bMatch == TRUE)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Validate Report Data", PASS, " Row get displayed as expected {sExpected} on {sTAB_SHEDULE_E_REPORT}.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Row {sExpected} didn't display as expected on {sTAB_SHEDULE_E_REPORT}.")
							[ ] //####Verify transaction data on for **Unspecified Rental Income**[Property] row on "Schedule E" report
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[+] for each sItem in lsListBoxItems
								[ ] bMatch = MatchStr("*{lsTransaction[2]}*{lsTransaction[4]}*{sAmountPaid}*", sItem)
								[+] if ( bMatch == TRUE)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Validate Report Data", PASS, " Transaction with Payee :{lsTransaction[2]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} get displayed on  {sTAB_SHEDULE_E_REPORT}.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with Payee :{lsTransaction[2]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} didn't display on {sTAB_SHEDULE_E_REPORT}.")
								[ ] 
						[+] else
							[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
						[ ] ScheduleEReportWindow.Close()
						[+] if(SaveReportAs.Exists(5))
							[ ] SaveReportAs.SetActive()
							[ ] SaveReportAs.DonTShowMeThisAgain.Check()
							[ ] SaveReportAs.DonTSave.Click()
						[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
						[ ] /////#######Report validation done#######///
					[+] else
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[+] else
				[ ] ReportStatus("Verify Recorded Expenses become link. ", FAIL, "Recorded Expenses text does not become link. ") 
			[ ] 
		[+] else
			[ ] ReportStatus("Select Account", FAIL, "Account: {lsAddAccount[2]}  couldn't be selected") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test41_VehicleMileageDetails ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test41_VehicleMileageDetails()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Vehicle Mileage Details	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while verifying Vehicle Mileage Details	
		[ ] //						Fail		if error occurs while verifying Vehicle Mileage Details	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 24, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test41_VehicleMileageDetails() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet sPropertyWorksheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] 
	[-] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.RentalProperty.Click()
		[ ] QuickenWindow.RentalProperty.MileageTracker.Select()
		[ ] WaitForState(DlgVehicleMileage,TRUE,1)
		[+] if (DlgVehicleMileage.Exists(5))
			[ ] DlgVehicleMileage.SetActive()
			[ ] ////########Verify By default trip type dropdown list should display as Rental Property ###////
			[ ] sActual=NULL
			[ ] sExpected=NULL
			[ ] sExpected="Rental Property"
			[ ] sActual=DlgVehicleMileage.TripTypePopupList.GetSelText()
			[+] if (sActual==sExpected)
				[ ] ReportStatus("Verify the default selected item in trip type PopupList ", PASS, "The default selected item in trip type PopupList is {sActual} on Dialog Vehicle Mileage.") 
			[+] else
				[ ] ReportStatus("Verify the default selected item in trip type PopupList ", FAIL, "The default selected item in trip type PopupList is {sActual} while expected item is {sExpected} on Dialog Vehicle Mileage.") 
			[ ] ////########Verify By default Rate value should be automatically populated as .585###////=
			[ ] sActual=NULL
			[ ] sExpected=NULL
			[ ] sExpected="0.575"
			[ ] sActual=DlgVehicleMileage.RateValueText.GetText()
			[+] if (sActual==sExpected)
				[ ] ReportStatus("Verify By default Rate value should be automatically populated as .585 ", PASS, "The default Rate value is as expected {sActual} on Dialog Vehicle Mileage ") 
			[+] else
				[ ] ReportStatus("Verify By default Rate value should be automatically populated as .585", FAIL, "The default Rate value is {sActual} while expected value is {sExpected} on Dialog Vehicle Mileage. ") 
			[ ] 
			[ ] ////########Verify By default Property dropdown list should display as "No property name" ###////
			[ ] sActual=NULL
			[ ] sExpected=NULL
			[ ] sExpected="No property name"
			[ ] sActual=DlgVehicleMileage.PropertyNamePopupList.GetSelText()
			[+] if (sActual==sExpected)
				[ ] ReportStatus("Verify the default selected item in Property Name PopupList ", PASS, "The default selected item in Property Name PopupList is {sActual} on Dialog Vehicle Mileage") 
			[+] else
				[ ] ReportStatus("Verify the default selected item in Property Name PopupList ", FAIL, "The default selected item in Property Name PopupList is {sActual} while expected item is {sExpected} on Dialog Vehicle Mileage. ") 
			[ ] 
			[ ] ////########Verify Property dropdown list contains the created property ###////
			[ ] sActual=NULL
			[ ] sExpected=NULL
			[ ] sExpected=trim(lsAddProperty[1])
			[ ] DlgVehicleMileage.PropertyNamePopupList.Select(lsAddProperty[1])
			[ ] WaitForState(DlgVehicleMileage,TRUE,1)
			[ ] sActual=DlgVehicleMileage.PropertyNamePopupList.GetSelText()
			[+] if (sActual==sExpected)
				[ ] ReportStatus("Verify that property created exists in Property Name PopupList ", PASS, "The property created exists in Property Name PopupList  {sActual} on Dialog Vehicle Mileage") 
			[+] else
				[ ] ReportStatus("Verify that property created exists in Property Name PopupList ", FAIL, "property created does not exist in Property Name PopupList actualt item is {sActual} while expected item is {sExpected} on Dialog Vehicle Mileage. ") 
			[ ] //Close DlgVehicleMileage
			[ ] DlgVehicleMileage.DoneButton.Click()
			[+] if (AlertMessage.Exists(5))
				[ ] AlertMessage.No.Click()
			[ ] WaitForState(AlertMessage,FALSE,1)
			[ ] WaitForState(DlgVehicleMileage,FALSE,1)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify DlgVehicleMileage Exists. ", FAIL, "Dialog Vehicle Mileage didn't appear. ") 
			[ ] 
		[ ] //Handle error condition
		[+] if (DlgVehicleMileage.Exists(5))
			[ ] DlgVehicleMileage.SetActive()
			[ ] DlgVehicleMileage.DoneButton.Click()
			[ ] sleep(2)
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test42_AddVehicleMileageTransaction ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test42_AddVehicleMileageTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Vehicle Mileage transaction on Vehicle Mileage Tracker Page	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while verifying Vehicle Mileage transaction on Vehicle Mileage Tracker Page	
		[ ] //						Fail		if error occurs while verifying Vehicle Mileage transaction on Vehicle Mileage Tracker Page	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 24, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test42_AddVehicleMileageTransaction() appstate RPMBaseState
	[ ] 
	[ ] STRING sTripTypeRental ,sTripRate ,sMileageTrackerTransactions
	[ ] sMileageTrackerTransactions = "MileageTrackerTransactions"
	[ ] // Read data from excel sheet sPropertyWorksheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] // Read data from excel sheet sPropertyWorksheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sMileageTrackerTransactions)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsMlgTrans=lsExcelData[1]
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sTripTypeRental="Rental"
	[ ] ///Rate multiplied with total miles travelled///
	[ ] INTEGER iTripCost ,iTripMiles
	[ ] iTripCost = val(lsMlgTrans[6])*val(lsMlgTrans[7])
	[ ] 
	[ ] iTripMiles=val(lsMlgTrans[6])
	[ ] 
	[ ] sTripRate=trim(Left(lsMlgTrans[7],5))
	[ ] ////########Verify the added transaction on Vehicle Mileage Tracker dialog. ###
	[ ] //// Property,Purpose:Mileage Tracking,////
	[ ] ////Start Location:New York,Destination:Mountain View,Miles Traveled:1000////
	[-] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.RentalProperty.Click()
		[ ] QuickenWindow.RentalProperty.MileageTracker.Select()
		[ ] WaitForState(DlgVehicleMileage,TRUE,1)
		[+] if (DlgVehicleMileage.Exists(5))
			[ ] DlgVehicleMileage.SetActive()
			[ ] DlgVehicleMileage.TripTypePopupList.Select(lsMlgTrans[1])
			[ ] DlgVehicleMileage.PropertyNamePopupList.Select(lsMlgTrans[2])
			[ ] DlgVehicleMileage.PurposeTextField.SetText(lsMlgTrans[3])
			[ ] DlgVehicleMileage.StartLocationTextField.SetText(lsMlgTrans[4])
			[ ] DlgVehicleMileage.DestinationTextField.SetText(lsMlgTrans[5])
			[ ] DlgVehicleMileage.MilesTraveledTextField.SetText(lsMlgTrans[6])
			[ ] DlgVehicleMileage.EnterTripButton.Click()
			[ ] WaitForState(DlgVehicleMileage,TRUE,1)
			[ ] DlgVehicleMileage.SetActive()
			[ ] hWnd=NULL
			[ ] hWnd=Str(DlgVehicleMileage.AllTripsForGrid.ListBox1.GetHandle())
			[ ] ////######Verify the trip details added in the grid###////
			[ ] sActual=NULL
			[ ] bAssert=FALSE
			[ ] 
			[ ] sExpected="Date: {sDateStamp},Triptype: {sTripTypeRental} Property: {lsMlgTrans[2]} Purpose: {lsMlgTrans[3]} StartLocation: {lsMlgTrans[4]} Destination: {lsMlgTrans[5]} MilesTraveled: {lsMlgTrans[6]} Rate: {val(lsMlgTrans[7])} TotalCost: {iTripCost}"
			[+] for( iCounter=0;iCounter<DlgVehicleMileage.AllTripsForGrid.ListBox1.GetItemCount() +1;++iCounter)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
				[ ] bAssert = MatchStr("*{sDateStamp}*{sTripTypeRental}*{lsMlgTrans[2]}*{lsMlgTrans[3]}*{lsMlgTrans[4]}*{lsMlgTrans[5]}*{sTripRate}*{iTripCost}*",sActual)
				[+] if ( bAssert == TRUE)
					[ ] break
			[+] if(bAssert)
				[ ] ReportStatus("Verify the added transaction on Vehicle Mileage Tracker dialog grid.", PASS, " Transaction added in Vehicle Mileage Tracker dialog grid {sActual} get displayed as expected {sExpected}.")
			[+] else
				[ ] ReportStatus("Verify the added transaction on Vehicle Mileage Tracker dialog grid.", FAIL, " Transaction added in Vehicle Mileage Tracker dialog grid {sActual}  displayed is not as expected {sExpected}.")
			[ ] 
			[ ] //Close DlgVehicleMileage
			[ ] DlgVehicleMileage.DoneButton.Click()
			[+] if (AlertMessage.Exists(5))
				[ ] AlertMessage.No.Click()
			[ ] WaitForState(AlertMessage,FALSE,1)
			[ ] WaitForState(DlgVehicleMileage,FALSE,1)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify DlgVehicleMileage Exists. ", FAIL, "Dialog Vehicle Mileage didn't appear. ") 
			[ ] 
		[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
		[ ] QuickenWindow.SetActive()
		[ ] // Open Schedule E Report
		[ ] sExpReportTitle=NULL
		[ ] sExpReportTitle="Schedule E Report"
		[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
		[-] if (iReportSelect==PASS)
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
			[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
			[+] if (ScheduleEReportWindow.Exists(5))
				[ ] 
				[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
				[ ] ScheduleEReportWindow.SetActive()
				[ ] 
				[ ] // Maximize sTAB_SHEDULE_E_REPORT 
				[ ] ScheduleEReportWindow.Maximize()
				[ ] 
				[ ] // Get window caption
				[ ] sActual = ScheduleEReportWindow.GetCaption()
				[ ] 
				[ ] // Verify window title
				[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
				[ ] 
				[ ] // Report Status if window title is as expected
				[+] if ( bMatch )
					[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
					[ ] //  Validate Report Data
					[ ] hWnd=NULL
					[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
					[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
					[+] for( iCounter=0;iCounter<iReportRowsCount ;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] ListAppend (lsListBoxItems,sActual)
					[ ] 
					[ ] //####Verify "Rental Property Mileage[Property1]" row on "Schedule E" report  
					[ ] ////Category:1000.0 miles at$.505,Tag:Dallas Property,Amount:$-585.00
					[ ] sActual=NULL
					[ ] bAssert=FALSE
					[ ] sExpected=NULL
					[ ] sExpected= "Rental Property Mileage"
					[+] for each sItem in lsListBoxItems
						[ ] bMatch = MatchStr("*{sExpected}*{lsAddProperty[1]}*", sItem)
						[+] if ( bMatch == TRUE)
							[ ] break
					[+] if(bMatch)
						[ ] ReportStatus("Validate Report Data", PASS, " Row {sItem} get displayed as expected {sExpected} on {sTAB_SHEDULE_E_REPORT}.")
					[+] else
						[ ] ReportStatus("Validate Report Data", FAIL, " Row didn't display as expected {sExpected} on {sTAB_SHEDULE_E_REPORT}.")
					[ ] 
					[ ] ////########///Verify the added transaction in "Schedule E" report/// ###///
					[ ] //// Property,Purpose:Mileage Tracking,////
					[ ] ////Start Location:New York,Destination:Mountain View,Miles Traveled:1000////
					[ ] 
					[+] for ( iCounter=1 ; iCounter< ListCount(lsListBoxItems)+1 ;++iCounter)
						[ ] bMatch =  MatchStr("*{lsMlgTrans[4]}*{lsMlgTrans[5]}*{lsMlgTrans[3]}*{iTripMiles}*miles at*{sTripRate}*{lsAddProperty[1]}*{iTripCost}**", lsListBoxItems[iCounter])
						[+] if ( bMatch == TRUE)
							[+] do
								[ ] 
								[ ] ///Had to hardcode as column having string is not expanded by default
								[ ] ScheduleEReportWindow.QWListViewer1.ListBox1.TextClick("Mileage")
							[+] except
								[ ] ScheduleEReportWindow.QWListViewer1.ListBox1.TextClick("Mounta")
							[ ] break
					[+] if(bMatch)
						[ ] ReportStatus("Validate Report Data", PASS, " Row {lsListBoxItems[iCounter]} get displayed as expected StartLocation: {lsMlgTrans[4]},Destination: {lsMlgTrans[5]},Purpose: {lsMlgTrans[3]},MilesTravelled at rate: {iTripMiles}miles at{sTripRate},Property: {lsAddProperty[1]}, TripCost: {iTripCost} on {sTAB_SHEDULE_E_REPORT}.")
					[+] else
						[ ] ReportStatus("Validate Report Data", FAIL, " Row {lsListBoxItems[iCounter]} didn't display as expected StartLocation: {lsMlgTrans[4]},Destination: {lsMlgTrans[5]},Purpose: {lsMlgTrans[3]},MilesTravelled at rate: {iTripMiles}miles at{sTripRate},Property: {lsAddProperty[1]}, TripCost: {iTripCost} on {sTAB_SHEDULE_E_REPORT}.")
					[ ] ///##Verify Edit button is disabled on {sTAB_SHEDULE_E_REPORT} after selecting Vehicle Mileage Transaction which is entered frm Mileage Tracker##////
					[ ] WaitForState(ScheduleEReportWindow,True,2)
					[+] if(ScheduleEReportWindow.Edit.IsEnabled())
						[ ] ReportStatus("Verify Edit button on E- Schedule Report after selecting mileage transaction.", FAIL, " Edit button is enabled on {sTAB_SHEDULE_E_REPORT} after selecting Vehicle Mileage Transaction which is entered from Mileage Tracker.")
					[+] else
						[ ] ReportStatus("Verify Edit button on E- Schedule Report after selecting mileage transaction.", PASS, " Edit button is disabled on {sTAB_SHEDULE_E_REPORT} after selecting Vehicle Mileage Transaction which is entered from Mileage Tracker.")
				[+] else
					[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
				[ ] /////Close Report////
				[ ] ScheduleEReportWindow.Close()
				[+] if(SaveReportAs.Exists(5))
					[ ] SaveReportAs.SetActive()
					[ ] SaveReportAs.DonTShowMeThisAgain.Check()
					[ ] SaveReportAs.DonTSave.Click()
				[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
				[ ] /////#######Report validation done#######///
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
			[ ] 
			[ ] /////Close Report////
			[-] if(ScheduleEReportWindow.Exists(5))
				[ ] ScheduleEReportWindow.SetActive()
				[ ] ScheduleEReportWindow.Close()
				[+] if(SaveReportAs.Exists(5))
					[ ] SaveReportAs.SetActive()
					[ ] SaveReportAs.DonTShowMeThisAgain.Check()
					[ ] SaveReportAs.DonTSave.Click()
				[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
			[ ] 
		[+] else
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test43_VehicleMileageEpenseTransaction ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test43_VehicleMileageEpenseTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify adding a Vehicle Mileage Expense Transaction with Rental Tag 	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while adding a Vehicle Mileage Expense Transaction with Rental Tag 			
		[ ] //						Fail		if error occurs while adding a Vehicle Mileage Expense Transaction with Rental Tag 	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 26, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test43_VehicleMileageEpenseTransaction() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] lsAddProperty=lsExcelData[1]
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[10]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sAmountPaid= trim(Left(lsTransaction[6],6))
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //report
			[ ] // 
			[ ] // //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
			[ ] // QuickenWindow.SetActive()
			[ ] // Open Schedule E Report
			[ ] sExpReportTitle=NULL
			[ ] sExpReportTitle="Schedule E Report"
			[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
				[+] if (ScheduleEReportWindow.Exists(5))
					[ ] 
					[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
					[ ] ScheduleEReportWindow.SetActive()
					[ ] 
					[ ] // Maximize sTAB_SHEDULE_E_REPORT 
					[ ] ScheduleEReportWindow.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = ScheduleEReportWindow.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] hWnd=NULL
						[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
						[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
						[+] for( iCounter=0;iCounter<iReportRowsCount ;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] ListAppend (lsListBoxItems,sActual)
						[ ] 
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] sExpected=NULL
						[ ] sExpected= "Rental Property Mileage"
						[ ] 
						[+] for each sItem in lsListBoxItems
							[ ] bMatch =  MatchStr("*{sExpected}*{lsAddProperty[1]}*",sItem)
							[+] if ( bMatch == TRUE)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Validate Report Data", PASS, " Row {sItem} get displayed as expected {sExpected} on {sTAB_SHEDULE_E_REPORT}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Row {sItem} didn't display as expected {sExpected} on {sTAB_SHEDULE_E_REPORT}.")
						[ ] 
						[ ] //####Verify transaction data on for Category:_MileageRent,Tag:Property1_Tag,Amount:$-100.00.row on "Schedule E" report
						[ ] sActual=NULL
						[ ] bMatch=FALSE
						[ ] 
						[+] for each sItem in lsListBoxItems
							[ ] bMatch =   MatchStr("*{lsTransaction[2]}*{lsTransaction[3]}*{lsTransaction[4]}*{sAmountPaid}*", sItem)
							[+] if ( bMatch == TRUE)
								[ ] break
						[ ] 
						[+] if(bMatch)
							[ ] ReportStatus("Validate Report Data", PASS, " Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} get displayed on  {sTAB_SHEDULE_E_REPORT} as expected {sItem}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} didn't display on {sTAB_SHEDULE_E_REPORT} and actual data is {sItem}.")
							[ ] 
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
					[ ] ScheduleEReportWindow.Close()
					[+] if(SaveReportAs.Exists(5))
						[ ] SaveReportAs.SetActive()
						[ ] SaveReportAs.DonTShowMeThisAgain.Check()
						[ ] SaveReportAs.DonTSave.Click()
					[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
					[ ] /////#######Report validation done#######///
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[ ] 
			[ ] //report
		[+] else
			[ ] ReportStatus("Verify account selected. ", FAIL, "Account didn't select. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test44_VerifyNotSureRentalExpenseCategory ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test44_VerifyNotSureRentalExpenseCategory()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Not Sure, Rental Expense Category in category list	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while Not Sure, Rental Expense Category in category list			
		[ ] //						Fail		if error occurs while verifying Not Sure, Rental Expense Category in category list	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Dec 12, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test44_VerifyNotSureRentalExpenseCategory() appstate RPMBaseState
	[ ] sCategory="Not Sure, Rental"
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Tools.Click()
		[ ] QuickenWindow.Tools.CategoryList.Select()
		[ ] WaitForState(CategoryList,TRUE,1)
		[+] if(CategoryList.Exists(3))
			[ ] CategoryList.SetActive()
			[ ] CategoryList.TextClick("Rental Property Expenses")
			[ ] //CategoryList.Panel.TextSearchCategory.SetText(sCategory)
			[ ] WaitForState(CategoryList,TRUE,1)
			[ ] ReportStatus("Category List", PASS, "Category List dialog is launched") 
			[ ] hWnd=str(CategoryList.Show.QWListViewer1.ListBox1.GetHandle())
			[+] for( iCounter=0;iCounter<CategoryList.Show.QWListViewer1.ListBox1.GetItemCount() +1;++iCounter)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
				[ ] bAssert = MatchStr("*{sCategory}*", sActual)
				[+] if ( bAssert == TRUE)
					[ ] break
			[+] if(bAssert)
				[ ] ReportStatus("Verify Not Sure, Rental Expense Category in category list", PASS, " Category: {sCategory} is displayed in category list as {sActual}  .")
			[+] else
				[ ] ReportStatus("Verify Not Sure, Rental Expense Category in category list", FAIL, " Category: {sCategory} is not displayed in category list.")
		[ ] CategoryList.Close()
		[ ] WaitForState(CategoryList,FALSE,5)
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
	[ ] 
[ ] 
[+] //############# Test45_VerifyRentalTransactionsonTaxScheduleReport ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test45_VerifyRentalTransactionsonTaxScheduleReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Rental Transactions on Tax Schedule Report	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while verifying Rental Transactions on Tax Schedule Report		
		[ ] //						Fail		if error occurs while verifying Rental Transactions on Tax Schedule Report	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Dec 12, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************//
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test45_VerifyRentalTransactionsonTaxScheduleReport() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] iItemCount=ListCount(lsExcelData)
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // //############## Verifying transactions on Reports> Rental Property> Tax Schedule Report ############
		[ ] // QuickenWindow.SetActive()
		[ ] // Open Tax Schedule Report
		[ ] sExpReportTitle=NULL
		[ ] sExpReportTitle="Tax Schedule"
		[ ] iReportSelect = OpenReport(lsReportCategory[6], sTAB_TAX_SHEDULE_REPORT)	
		[+] if (iReportSelect==PASS)
			[ ] ReportStatus("Run {sTAB_TAX_SHEDULE_REPORT} Report", iReportSelect, "Run Report successful") 
			[ ] // Verify sTAB_TAX_SHEDULE_REPORT is Opened
			[+] if (TaxSchedule.Exists(5))
				[ ] 
				[ ] // Set Actives sTAB_TAX_SHEDULE_REPORT  
				[ ] TaxSchedule.SetActive()
				[ ] 
				[ ] // Maximize sTAB_TAX_SHEDULE_REPORT 
				[ ] TaxSchedule.Maximize()
				[ ] 
				[ ] // Get window caption
				[ ] sActual = TaxSchedule.GetCaption()
				[ ] 
				[ ] // Verify window title
				[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
				[ ] 
				[ ] // Report Status if window title is as expected
				[+] if ( bMatch )
					[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
					[ ] //  Validate Report Data
					[ ] hWnd=NULL
					[ ] hWnd = Str(TaxSchedule.QWListViewer1.ListBox1.GetHandle ())
					[ ] sActual=NULL
					[ ] bAssert=FALSE
					[ ] // //############## Verifying transactions on Reports> Rental Property> Tax Schedule Report ############
					[ ] sActual=NULL
					[ ] bAssert=FALSE
					[ ] iReportRowsCount=TaxSchedule.QWListViewer1.ListBox1.GetItemCount() +1
					[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] ListAppend (lsListBoxItems,sActual)
					[ ] iListCount=ListCount(lsListBoxItems)
					[+] for( iCounter=1; iCounter< 10; ++iCounter)
						[ ] lsTransaction=lsExcelData[iCounter]
						[+] if (lsTransaction[1]==NULL)
							[ ] break
						[ ] iAmount= VAL(lsTransaction[6])
						[+] for each sItem in lsListBoxItems
							[ ] bAssert = MatchStr("*{lsTransaction[2]}*{iAmount}*", sItem)
							[+] if ( bAssert == TRUE)
								[ ] break
						[+] if(bAssert)
							[ ] ReportStatus("Validate Report Data", PASS, " Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {iAmount} get displayed on  {sExpReportTitle} as {sItem}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {iAmount} didn't display on {sExpReportTitle}.")
				[+] else
					[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
				[ ] TaxSchedule.TypeKeys(KEY_EXIT)
				[+] if(SaveReportAs.Exists(5))
					[ ] SaveReportAs.SetActive()
					[ ] SaveReportAs.DonTShowMeThisAgain.Check()
					[ ] SaveReportAs.DonTSave.Click()
				[ ] WaitForState(SaveReportAs,FALSE,1)
				[ ] /////#######Report validation done#######///
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
		[+] else
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test46_PersonalExpenseTransactionOnScheduleEReport ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test46_PersonalExpenseTransactionOnScheduleEReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify adding a Personal Expense Transaction on Schedule E Report	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while adding a Personal Expense Transaction on Schedule E Report		
		[ ] //						Fail		if error occurs while adding a Personal Expense Expense Transaction Schedule E Report	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                            Dec 18, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test46_PersonalExpenseTransactionOnScheduleEReport() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] lsAddProperty=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[12]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sAmountPaid= trim(Left(lsTransaction[6],6))
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //report
			[ ] // 
			[ ] // //############## Verifying Personal Expense transaction on Reports> Rental Property>Schedule E Report ############
			[ ] // QuickenWindow.SetActive()
			[ ] // Open Schedule E Report
			[ ] sExpReportTitle=NULL
			[ ] sExpReportTitle="Schedule E Report"
			[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
				[+] if (ScheduleEReportWindow.Exists(5))
					[ ] 
					[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
					[ ] ScheduleEReportWindow.SetActive()
					[ ] 
					[ ] // Maximize sTAB_SHEDULE_E_REPORT 
					[ ] ScheduleEReportWindow.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = ScheduleEReportWindow.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] 
						[ ] //####Verify transaction data on for Category:Auto & Transport,Amount:$-100.00.row on "Schedule E" report
						[ ] sActual=NULL
						[ ] bAssert=FALSE
						[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
						[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
						[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] bAssert = MatchStr("*{lsTransaction[2]}*{lsTransaction[3]}*{sAmountPaid}*", sActual)
							[+] if ( bAssert == TRUE)
								[ ] break
						[+] if(bAssert)
							[ ] ReportStatus("Validate Report Data", FAIL, " Verify Personal Expense transacion shouldn't display on {sTAB_SHEDULE_E_REPORT} Report:Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {sAmountPaid} get displayed.")
						[+] else
							[ ] ReportStatus("Validate Report Data", PASS, " Verify Personal Expense transacion shouldn't display on {sTAB_SHEDULE_E_REPORT} Report : Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {sAmountPaid} didn't display.")
							[ ] 
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
					[ ] ScheduleEReportWindow.Close()
					[+] if(SaveReportAs.Exists(5))
						[ ] SaveReportAs.SetActive()
						[ ] SaveReportAs.DonTShowMeThisAgain.Check()
						[ ] SaveReportAs.DonTSave.Click()
					[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
					[ ] /////#######Report validation done#######///
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[ ] 
			[ ] //report
		[+] else
			[ ] ReportStatus("Verify account selected. ", FAIL, "Account didn't select. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test47_VerifyLastMonthIncomeTransactionOnScheduleEReport ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test47_VerifyLastMonthIncomeTransactionOnScheduleEReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Last Month Income Transaction On Schedule E Report	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while Verifying Last Month Income Transaction On Schedule E Report		
		[ ] //						Fail		if error occurs while Verifying Last Month Income Transaction On Schedule E Report
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                            Dec 21, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test47_VerifyLastMonthIncomeTransactionOnScheduleEReport() appstate RPMBaseState
	[ ] sDateRange="Last month"
	[ ] sDateIndex="#14"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[13]
	[ ] 
	[ ] //Last Month
	[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") 
	[ ] sDay=FormatDateTime(GetDateTime(), "d")
	[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
	[+] if(val(sMonth)==1)
		[ ] iSelectDate=12
		[ ] iYear=val(sYear)-1
		[ ] sYear =Str(iYear)
	[+] else
		[ ] iSelectDate=val(sMonth)-1
	[ ] 
	[ ] sDateStamp="{iSelectDate}" +"/"+sDay+"/"+sYear
	[ ] 
	[ ] iAmount= VAL(lsTransaction[6])
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////Set Remind me to save reports unchecked
		[ ] 
		[ ] iResult=SelectPreferenceType("Reports only")
		[+] if (iResult==PASS)
			[ ] Preferences.SetActive()
			[ ] Preferences.RemindMeToSaveReports.Uncheck()
			[ ] Preferences.OK.Click()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Preferences dialog." ,FAIL,"Preferences dialog didn't appear.")
		[ ] 
		[ ] 
		[ ] iSelect =SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //report
			[ ] // 
			[ ] // //############## Verifying  Verifying Last Month Income Transaction On Schedule E Report ############
			[ ] // QuickenWindow.SetActive()
			[ ] // Open Schedule E Report
			[ ] sExpReportTitle=NULL
			[ ] sExpReportTitle="Schedule E Report"
			[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
				[+] if (ScheduleEReportWindow.Exists(5))
					[ ] 
					[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
					[ ] ScheduleEReportWindow.SetActive()
					[ ] 
					[ ] // Maximize sTAB_SHEDULE_E_REPORT 
					[ ] ScheduleEReportWindow.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = ScheduleEReportWindow.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] 
						[ ] //####Verify transaction data "DEP,Shaun,Rental Income(Royalties Received),Property1_Tag,1000 "on "Schedule E" report////
						[ ] //## For criteria "Last Month"
						[ ] ScheduleEReportWindow.SetActive()
						[ ] ScheduleEReportWindow.QWCustomizeBar1.PopupList1.Select(sDateIndex)
						[+] if(ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()==sDateRange)
							[ ] sActual=NULL
							[ ] bAssert=FALSE
							[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
							[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
							[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bAssert = MatchStr("*{lsTransaction[2]}*{lsTransaction[3]}*{iAmount}*", sActual)
								[+] if ( bAssert == TRUE)
									[ ] break
							[+] if(bAssert)
								[ ] ReportStatus("Validate Report Data", PASS, " Verify Income transaction for Last month on {sTAB_SHEDULE_E_REPORT} Report:Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} get displayed.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Verify Income transaction for Last month on {sTAB_SHEDULE_E_REPORT} Report : Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} didn't display.")
						[+] else
							[ ] ReportStatus("Verify Date range selection",FAIL,"Date range is not selected, expected: {sDateRange} and Actual: {ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()}")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
					[ ] ScheduleEReportWindow.Close()
					[+] if(SaveReportAs.Exists(5))
						[ ] SaveReportAs.SetActive()
						[ ] SaveReportAs.DonTShowMeThisAgain.Check()
						[ ] SaveReportAs.DonTSave.Click()
					[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
					[ ] /////#######Report validation done#######///
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[ ] 
			[ ] //report
		[+] else
			[ ] ReportStatus("Verify account selected. ", FAIL, "Account didn't select. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test48_VerifyLastMonthExpenseTransactionOnScheduleEReport ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test48_VerifyLastMonthExpenseTransactionOnScheduleEReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Last Month Expense Transaction On Schedule E Report
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while Verifying Last Month Expense Transaction On Schedule E Report		
		[ ] //						Fail		if error occurs while Verifying Last Month Expense Transaction On Schedule E Report
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                            Dec 21, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test48_VerifyLastMonthExpenseTransactionOnScheduleEReport() appstate RPMBaseState
	[ ] 
	[ ] sDateRange="Last month"
	[ ] sDateIndex="#14"
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[14]
	[ ] 
	[ ] //Last Month
	[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") 
	[ ] sDay=FormatDateTime(GetDateTime(), "d")
	[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
	[+] if(val(sMonth)==1)
		[ ] iSelectDate=12
		[ ] iYear=val(sYear)-1
		[ ] sYear =Str(iYear)
	[+] else
		[ ] iSelectDate=val(sMonth)-1
	[ ] 
	[ ] sDateStamp="{iSelectDate}" +"/"+sDay+"/"+sYear
	[ ] 
	[ ] 
	[ ] iAmount= VAL(lsTransaction[6])
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //report
			[ ] // 
			[ ] // //##############Verifying Last Month Expense Transaction On Schedule E Report	 ############////
			[ ] // QuickenWindow.SetActive()
			[ ] // Open Schedule E Report
			[ ] sExpReportTitle=NULL
			[ ] sExpReportTitle="Schedule E Report"
			[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
				[+] if (ScheduleEReportWindow.Exists(5))
					[ ] 
					[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
					[ ] ScheduleEReportWindow.SetActive()
					[ ] 
					[ ] // Maximize sTAB_SHEDULE_E_REPORT 
					[ ] ScheduleEReportWindow.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = ScheduleEReportWindow.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] 
						[ ] //####Verify transaction data "ATM,John,Rental Expenses(Cleaning and Maintenance),Property1_Tag,500 "on "Schedule E" report////
						[ ] //## For criteria "Last Month"
						[ ] ScheduleEReportWindow.SetActive()
						[ ] ScheduleEReportWindow.QWCustomizeBar1.PopupList1.Select(sDateIndex)
						[+] if(ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()==sDateRange)
							[ ] sActual=NULL
							[ ] bAssert=FALSE
							[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
							[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
							[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bAssert = MatchStr("*{lsTransaction[2]}*{lsTransaction[3]}*{iAmount}*", sActual)
								[+] if ( bAssert == TRUE)
									[ ] break
							[+] if(bAssert)
								[ ] ReportStatus("Validate Report Data", PASS, " Verify expense transaction for Last month on {sTAB_SHEDULE_E_REPORT} Report:Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} get displayed.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Verify expense transaction for Last month on {sTAB_SHEDULE_E_REPORT} Report : Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} didn't display.")
						[+] else
							[ ] ReportStatus("Verify Date range selection",FAIL,"Date range is not selected, expected: {sDateRange} and Actual: {ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()}")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
					[ ] ScheduleEReportWindow.Close()
					[+] if(SaveReportAs.Exists(5))
						[ ] SaveReportAs.SetActive()
						[ ] SaveReportAs.DonTShowMeThisAgain.Check()
						[ ] SaveReportAs.DonTSave.Click()
					[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
					[ ] /////#######Report validation done#######///
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[ ] 
			[ ] //report
		[+] else
			[ ] ReportStatus("Verify account selected. ", FAIL, "Account didn't select. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test49_VerifyLastQuarterIncomeTransactionOnScheduleEReport ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test49_VerifyLastQuarterIncomeTransactionOnScheduleEReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Last quarter Income Transaction On Schedule E Report
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while Verifying Last quarter Income Transaction On Schedule E Report		
		[ ] //						Fail		if error occurs while Verifying Last quarter Income Transaction On Schedule E Report
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                            Dec 21, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test49_VerifyLastQuarterIncomeTransactionOnScheduleEReport() appstate RPMBaseState
	[ ] DATETIME dtDateTime,newDateTime
	[ ] 
	[ ] //Integer
	[ ] 
	[ ] sDateRange="Last quarter"
	[ ] sDateIndex="#15"
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[14]
	[ ] 
	[ ] //Need to update for Last Quarter
	[ ] INTEGER iSelectDate ,iYear
	[ ] 
	[ ] //String
	[ ] STRING sCompareDay,sCompareMonth,sCompareYear
	[ ] STRING sDateFormat="m/d/yyyy"
	[ ] STRING sCompareDayFormat="d"
	[ ] STRING sCompareMonthFormat="m"
	[ ] STRING sCompareYearFormat="yyyy"
	[ ] 
	[ ] dtDateTime= GetDateTime ()
	[ ] sCompareMonth = FormatDateTime ([DATETIME] dtDateTime,  sCompareMonthFormat) 
	[ ] 
	[+] if(sCompareMonth=="3"||sCompareMonth=="6"||sCompareMonth=="9"||sCompareMonth=="12")
		[ ] 
		[ ] //For Last Quarter Month
		[ ] sDateStamp=ModifyDate(-100,sDateFormat)
		[ ] 
		[ ] 
	[+] else if(sCompareMonth=="2"||sCompareMonth=="5"||sCompareMonth=="8"||sCompareMonth=="11")
		[ ] 
		[ ] sDateStamp=ModifyDate(-65,sDateFormat)
		[ ] 
		[ ] 
	[+] else if(sCompareMonth=="1"||sCompareMonth=="4"||sCompareMonth=="7"||sCompareMonth=="10")
		[ ] 
		[ ] sDateStamp=ModifyDate(-35,sDateFormat)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iAmount= VAL(lsTransaction[6])
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect =SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //report
			[ ] // 
			[ ] // //##############Verifying Last quarter Income Transaction On Schedule E Report	 ############////
			[ ] // QuickenWindow.SetActive()
			[ ] // Open Schedule E Report
			[ ] sExpReportTitle=NULL
			[ ] sExpReportTitle="Schedule E Report"
			[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
				[+] if (ScheduleEReportWindow.Exists(5))
					[ ] 
					[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
					[ ] ScheduleEReportWindow.SetActive()
					[ ] 
					[ ] // Maximize sTAB_SHEDULE_E_REPORT 
					[ ] // ScheduleEReportWindow.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = ScheduleEReportWindow.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] 
						[ ] //####Verify transaction data "DEP,Shane,Rental Income(Royalties Received),Property1_Tag,1000"on "Schedule E" report////
						[ ] ////## For criteria "Last quarter"
						[ ] ScheduleEReportWindow.SetActive()
						[ ] ScheduleEReportWindow.QWCustomizeBar1.PopupList1.Select(sDateIndex)
						[ ] 
						[+] if(ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()==sDateRange)
							[ ] sActual=NULL
							[ ] bAssert=FALSE
							[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
							[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
							[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bAssert = MatchStr("*{lsTransaction[2]}*{lsTransaction[3]}*{iAmount}*", sActual)
								[+] if ( bAssert == TRUE)
									[ ] break
							[+] if(bAssert)
								[ ] ReportStatus("Validate Report Data", PASS, " Verify income transaction for Last quarter on {sTAB_SHEDULE_E_REPORT} Report:Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} get displayed.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Verify income transaction for Last quarter on {sTAB_SHEDULE_E_REPORT} Report : Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} didn't display.")
						[+] else
							[ ] ReportStatus("Verify Date range selection",FAIL,"Date range is not selected, expected: {sDateRange} and Actual: {ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()}")
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
					[ ] ScheduleEReportWindow.Close()
					[+] if(SaveReportAs.Exists(5))
						[ ] SaveReportAs.SetActive()
						[ ] SaveReportAs.DonTShowMeThisAgain.Check()
						[ ] SaveReportAs.DonTSave.Click()
					[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
					[ ] /////#######Report validation done#######///
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[ ] 
			[ ] //report
		[+] else
			[ ] ReportStatus("Verify account selected. ", FAIL, "Account didn't select. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test50_VerifyLastQuarterExpenseTransactionOnScheduleEReport ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test50_VerifyLastQuarterExpenseTransactionOnScheduleEReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Last quarter Expense Transaction On Schedule E Report	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while Verifying Last quarter Expense Transaction On Schedule E Report		
		[ ] //						Fail		if error occurs while Verifying Last quarter Expense Transaction On Schedule E Report
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                            Dec 21, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test50_VerifyLastQuarterExpenseTransactionOnScheduleEReport() appstate RPMBaseState
	[ ] 
	[ ] sDateRange="Last quarter"
	[ ] sDateIndex="#15"
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[21]
	[ ] 
	[ ] //Need to update for Last Quarter
	[ ] // sDateStamp =FormatDateTime ( AddDateTime (GetDateTime (), -65), "m/d/yyyy") 
	[ ] //Need to update for Last Quarter
	[ ] INTEGER iSelectDate ,iYear
	[ ] DATETIME dtDateTime,newDateTime
	[ ] //String
	[ ] STRING sCompareDay,sCompareMonth,sCompareYear
	[ ] STRING sDateFormat="m/d/yyyy"
	[ ] STRING sCompareDayFormat="d"
	[ ] STRING sCompareMonthFormat="m"
	[ ] STRING sCompareYearFormat="yyyy"
	[ ] 
	[ ] dtDateTime= GetDateTime ()
	[ ] sCompareMonth = FormatDateTime ([DATETIME] dtDateTime,  sCompareMonthFormat) 
	[ ] 
	[+] if(sCompareMonth=="3"||sCompareMonth=="6"||sCompareMonth=="9"||sCompareMonth=="12")
		[ ] 
		[ ] //For Last Quarter Month
		[ ] sDateStamp=ModifyDate(-100,sDateFormat)
		[ ] 
		[ ] 
	[+] else if(sCompareMonth=="2"||sCompareMonth=="5"||sCompareMonth=="8"||sCompareMonth=="11")
		[ ] 
		[ ] sDateStamp=ModifyDate(-65,sDateFormat)
		[ ] 
		[ ] 
	[+] else if(sCompareMonth=="1"||sCompareMonth=="4"||sCompareMonth=="7"||sCompareMonth=="10")
		[ ] 
		[ ] sDateStamp=ModifyDate(-35,sDateFormat)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iAmount= VAL(lsTransaction[6])
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] 
			[ ] iResult=AddCheckingTransaction(sMDIWindow, lsTransaction[7],  lsTransaction[6], sDateStamp,  lsTransaction[1], lsTransaction[2], "", lsTransaction[3],lsTransaction[4])
			[+] if (iResult==PASS)
				[ ] // //##############Verifying Last quarter Expense Transaction On Schedule E Report	 ############////
				[ ] QuickenWindow.SetActive()
				[ ] // Open Schedule E Report
				[ ] sExpReportTitle=NULL
				[ ] sExpReportTitle="Schedule E Report"
				[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
				[+] if (iReportSelect==PASS)
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
					[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
					[+] if (ScheduleEReportWindow.Exists(5))
						[ ] 
						[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
						[ ] ScheduleEReportWindow.SetActive()
						[ ] 
						[ ] // Maximize sTAB_SHEDULE_E_REPORT 
						[ ] ScheduleEReportWindow.Maximize()
						[ ] 
						[ ] // Get window caption
						[ ] sActual = ScheduleEReportWindow.GetCaption()
						[ ] 
						[ ] // Verify window title
						[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
						[ ] 
						[ ] // Report Status if window title is as expected
						[+] if ( bMatch )
							[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
							[ ] //  Validate Report Data
							[ ] 
							[ ] //####Verify transaction data "ATM,Christine,Rental Expenses(Cleaning and Maintenance),Property1_Tag,500"on "Schedule E" report////
							[ ] ////## For criteria "Last quarter"
							[ ] ScheduleEReportWindow.QWCustomizeBar1.PopupList1.Select(sDateIndex)
							[+] if(ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()==sDateRange)
								[ ] sActual=NULL
								[ ] bAssert=FALSE
								[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
								[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
								[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
									[ ] bAssert = MatchStr("*{lsTransaction[2]}*{lsTransaction[3]}*{iAmount}*", sActual)
									[+] if ( bAssert == TRUE)
										[ ] break
								[+] if(bAssert)
									[ ] ReportStatus("Validate Report Data", PASS, " Verify Expense transaction for Last quarter on {sTAB_SHEDULE_E_REPORT} Report:Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} get displayed.")
								[+] else
									[ ] ReportStatus("Validate Report Data", FAIL, " Verify Expense transaction for Last quarter on {sTAB_SHEDULE_E_REPORT} Report : Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} didn't display.")
							[+] else
								[ ] ReportStatus("Verify Date range selection",FAIL,"Date range is not selected, expected: {sDateRange} and Actual: {ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
						[ ] ScheduleEReportWindow.Close()
						[+] if(SaveReportAs.Exists(5))
							[ ] SaveReportAs.SetActive()
							[ ] SaveReportAs.DonTShowMeThisAgain.Check()
							[ ] SaveReportAs.DonTSave.Click()
						[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
						[ ] /////#######Report validation done#######///
					[+] else
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify add transaction",FAIL,"Verify add transaction:Transaction {lsTransaction[2]} not added to Account.")
		[+] else
			[ ] ReportStatus("Verify account selected. ", FAIL, "Account didn't select. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test51_VerifyLastYearIncomeTransactionOnScheduleEReport ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test51_VerifyLastYearIncomeTransactionOnScheduleEReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Last year Income Transaction On Schedule E Report	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while Verifying Last year Income Transaction On Schedule E Report		
		[ ] //						Fail		if error occurs while Verifying year quarter Income Transaction On Schedule E Report
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                            Dec 21, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test51_VerifyLastYearIncomeTransactionOnScheduleEReport() appstate none
	[ ] 
	[ ] sDateRange="Last year"
	[ ] sDateIndex="#16"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[22]
	[ ] 
	[ ] //Need to update for Last Quarter
	[ ] sDay=FormatDateTime(GetDateTime(), "d")
	[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
	[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
	[ ] iSelectDate=val(sYear)-1
	[ ] 
	[ ] sDateStamp= sMonth+"/"+sDay+"/"+"{iSelectDate}"
	[ ] 
	[ ] iAmount= VAL(lsTransaction[6])
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[+] if (AlertMessage.Exists(5))
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.DonTShowAgain.Check()
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage,FALSE,1)
			[ ] 
			[ ] //report
			[ ] // 
			[ ] // //##############Verifying Last year Income Transaction On Schedule E Report	 ############////
			[ ] // QuickenWindow.SetActive()
			[ ] // Open Schedule E Report
			[ ] sExpReportTitle=NULL
			[ ] sExpReportTitle="Schedule E Report"
			[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
			[+] if (iReportSelect==PASS)
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
				[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
				[+] if (ScheduleEReportWindow.Exists(5))
					[ ] 
					[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
					[ ] ScheduleEReportWindow.SetActive()
					[ ] 
					[ ] // Maximize sTAB_SHEDULE_E_REPORT 
					[ ] ScheduleEReportWindow.Maximize()
					[ ] 
					[ ] // Get window caption
					[ ] sActual = ScheduleEReportWindow.GetCaption()
					[ ] 
					[ ] // Verify window title
					[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
					[ ] 
					[ ] // Report Status if window title is as expected
					[+] if ( bMatch )
						[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
						[ ] //  Validate Report Data
						[ ] 
						[ ] //####Verify transaction data "DEP,Mark,Rental Income(Royalties Received),Property1_Tag,1000"on "Schedule E" report////
						[ ] ////## For criteria "Last year"
						[ ] ScheduleEReportWindow.SetActive()
						[ ] ScheduleEReportWindow.QWCustomizeBar1.PopupList1.Select(sDateIndex)
						[+] if(ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()==sDateRange)
							[ ] sActual=NULL
							[ ] bAssert=FALSE
							[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
							[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
							[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] bAssert = MatchStr("*{lsTransaction[2]}*{lsTransaction[3]}*{iAmount}*", sActual)
								[+] if ( bAssert == TRUE)
									[ ] break
							[+] if(bAssert)
								[ ] ReportStatus("Validate Report Data", PASS, " Verify income transaction for Last year on {sTAB_SHEDULE_E_REPORT} Report:Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} get displayed.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Verify income transaction for Last year on {sTAB_SHEDULE_E_REPORT} Report : Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]},  and Amount: {iAmount} didn't display.")
						[+] else
							[ ] ReportStatus("Verify Date range selection",FAIL,"Date range is not selected, expected: {sDateRange} and Actual: {ScheduleEReportWindow.QWCustomizeBar1.PopupList1.GetSelectedItem()}")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
					[ ] ScheduleEReportWindow.Close()
					[+] if(SaveReportAs.Exists(5))
						[ ] SaveReportAs.SetActive()
						[ ] SaveReportAs.DonTShowMeThisAgain.Check()
						[ ] SaveReportAs.DonTSave.Click()
					[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
					[ ] /////#######Report validation done#######///
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[ ] 
			[ ] //report
		[+] else
			[ ] ReportStatus("Verify account selected. ", FAIL, "Account didn't select. ") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[+] //############# Test53_AddBussinessAccountTransactionwithRentalTagOnly ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test53_AddBussinessAccountTransactionwithRentalTagOnly()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify BussinessAccount expense transaction with Rental Tag Only	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying a BussinessAccount expense transaction with Rental Tag Only			
		[ ] //						Fail		If error occurs while verifying a BussinessAccount expense transaction with Rental Tag Only			
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 24, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test53_AddBussinessAccountTransactionwithRentalTagOnly() appstate RPMBaseState
	[ ] STRING sAccountIntent
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] lsAddProperty=lsExcelData[1]
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] lsTransaction=lsExcelData[18]
	[ ] // Fetch 1st row from the given sheet
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[2]
	[ ] sAccountIntent="BUSINESS"
	[ ] 
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Variable declaration
		[ ] //############## Create New Business Account #####################################
		[ ] // Quicken is launched then Add Business Account
		[ ] 
		[ ] // Add Business Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],sAccountIntent)
		[ ] // Report Status if Business Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Business Account", iAddAccount, "Business Account -  {lsAddAccount[2]}  is created successfully")
			[ ] //############## Added New Business Account #####################################
			[ ] 
			[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_BUSINESS )  
			[+] if(iSelect==PASS)
				[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
				[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
				[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
				[ ] sleep(SHORT_SLEEP)
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
				[+] if (DlgSaveTransaction.Exists(5))
					[ ] DlgSaveTransaction.SetActive()
					[ ] DlgSaveTransaction.DontShowAgain.Check()
					[ ] DlgSaveTransaction.Save.Click()
					[ ] sleep(2)
				[ ] 
				[ ] 
				[ ] //############## Verifying transaction with rental tag only does not get displayed on Business > Profit Loss############
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] QuickenWindow.SetActive()
				[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] sAmountPaid=trim(Left(lsTransaction[6],5))
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] WaitForState(Business,True,1)
				[ ] // #################Recorded Expenses Popup is clicked with the help of Location Identifier###############/// 
				[ ] //// Till now the total Uncategorized business transactions should be as below
				[ ] /// Uncategorized=300, RentalTag Transaction =100 which shouldn't be displayed
				[ ] sExpected="Uncategorized"
				[ ] iAmount=400
				[ ] Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.Click(1,49,4)
				[ ] sleep(4)
				[ ] WaitForState(RecordedDepositsCallout,True,2)
				[+] if (RecordedDepositsCallout.Exists(5))
					[ ] ReportStatus("Verify Recorded Expenses become link. ", PASS, "Recorded Expenses text become link. ") 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
					[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] bMatch = MatchStr("*{sExpected}*{iAmount}*", sActual)
						[+] if ( bMatch == TRUE)
							[ ] break
					[ ] ////####################
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify transaction with rental tag does not get displayed on Business > Profit Loss ", FAIL, "Verify Bussiness Account Transaction with RentalTag:Transaction with rental tag and with amount {sAmountPaid}  is displayed in the OUT section of  Business > Profit Loss .") 
					[+] else
						[ ] ReportStatus(" Verify transaction with rental tag does not get displayed on Business > Profit Loss ", PASS, "Verify Bussiness Account Transaction with RentalTag:Transaction with rental tag and with amount  {sAmountPaid}  is not displayed in the OUT section of  Business > Profit Loss.") 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] sleep(1)
					[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
					[ ] sleep(2)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Recorded Expenses become link. ", FAIL, "Recorded Expenses text does not become link. ") 
				[ ] 
				[ ] //############## Verifying transaction with rental tag only gets displayed on RentalProperty > Profit Loss############
				[ ] //// Till now the total Uncategorized Rental transactions should be as below
				[ ] //// 500
				[ ] /// Uncategorized=850
				[ ] sExpected="Uncategorized"
				[ ] iAmount=850
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] WaitForState(QuickenWindow,True,2)
				[ ] WaitForState(RentalPropertyRentCenter,True,2)
				[ ] // #################Recorded Expenses Popup is clicked with the help of Location Identifier###############/// 
				[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
				[ ] sleep(4)
				[ ] WaitForState(RecordedDepositsCallout,True,2)
				[+] if (RecordedDepositsCallout.Exists(5))
					[ ] ReportStatus("Verify Recorded Expenses become link. ", PASS, "Recorded Expenses text become link. ") 
					[ ] hWnd=NULL
					[ ] sActual=NULL
					[ ] bMatch=FALSE
					[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
					[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] bMatch = MatchStr("*{sExpected}*{iAmount}*", sActual)
						[+] if ( bMatch == TRUE)
							[ ] break
					[+] if ( bMatch )
						[ ] ReportStatus(" Verify transaction with rental tag only in the Recorded Expenses Popup", PASS, "Verify Bussiness Account Transaction with RentalTag: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{iAmount} has been added to the Recorded Expenses CallOut. ") 
					[+] else
						[ ] ReportStatus(" Verify transaction with rental tag only in the Recorded Expenses Popup", FAIL, "Verify Bussiness Account Transaction with RentalTag: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{iAmount} has not been added correctly to the Recorded Expenses CallOut. ") 
					[ ] QuickenWindow.SetActive()
					[ ] sleep(1)
					[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
					[ ] sleep(2)
					[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
					[ ] QuickenWindow.SetActive()
					[ ] // Open Schedule E Report
					[ ] sExpReportTitle=NULL
					[ ] sExpReportTitle="Schedule E Report"
					[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
					[+] if (iReportSelect==PASS)
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
						[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
						[+] if (ScheduleEReportWindow.Exists(5))
							[ ] 
							[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
							[ ] ScheduleEReportWindow.SetActive()
							[ ] 
							[ ] // Maximize sTAB_SHEDULE_E_REPORT 
							[ ] ScheduleEReportWindow.Maximize()
							[ ] 
							[ ] // Get window caption
							[ ] sActual = ScheduleEReportWindow.GetCaption()
							[ ] 
							[ ] // Verify window title
							[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
							[ ] 
							[ ] // Report Status if window title is as expected
							[+] if ( bMatch )
								[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
								[ ] //  Validate Report Data
								[ ] hWnd=NULL
								[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
								[ ] 
								[ ] //####Verify transaction data Bussiness Account Transaction with RentalTag Only row on "Schedule E" report
								[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
								[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
									[ ] bMatch = MatchStr("*{lsTransaction[2]}*{lsTransaction[4]}*{sAmountPaid}*", sActual)
									[+] if ( bMatch == TRUE)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Validate Report Data", PASS, "Verify Bussiness Account Transaction with RentalTag: Transaction with Payee :{lsTransaction[2]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} get displayed on  {sTAB_SHEDULE_E_REPORT}.")
								[+] else
									[ ] ReportStatus("Validate Report Data", FAIL, " Verify Bussiness Account Transaction with RentalTag: Transaction with Payee :{lsTransaction[2]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} didn't display on {sTAB_SHEDULE_E_REPORT}.")
									[ ] 
							[+] else
								[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
							[ ] ScheduleEReportWindow.Close()
							[+] if(SaveReportAs.Exists(5))
								[ ] SaveReportAs.SetActive()
								[ ] SaveReportAs.DonTShowMeThisAgain.Check()
								[ ] SaveReportAs.DonTSave.Click()
							[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
							[ ] /////#######Report validation done#######///
						[+] else
							[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
					[+] else
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
				[+] else
					[ ] ReportStatus("Verify Recorded Expenses become link. ", FAIL, "Recorded Expenses text does not become link. ") 
			[+] else
				[ ] 
				[ ] ReportStatus("Verfiy Business Account selected.", FAIL, "Verfiy {lsAddAccount[2]} Account selected: {lsAddAccount[2]} Account couldn't be selected")
		[+] else
			[ ] ReportStatus("Business Account", FAIL, "Business Account -  {lsAddAccount[2]} couldn't be created successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test54_ModifyTransactionwithRentalTagAndCategory ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test54_ModifyTransactionwithRentalTagAndCategory()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify adding a transaction with rental tag
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	f no error occurs while adding a transaction with rental tag					
		[ ] //						Fail		If transaction with rental tag does not get added with rental tag	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 19, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test54_ModifyTransactionwithRentalTagAndCategory() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[19]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sAmountPaid = left(lsTransaction[6],5)
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.View.Click()
		[ ] QuickenWindow.View.TabsToShow.Click()
		[+] if (!QuickenWindow.View.TabsToShow.Business.IsChecked)
			[ ] QuickenWindow.View.TabsToShow.Business.Select()
		[+] else
			[ ] QuickenWindow.TypeKeys(KEY_ESC)
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[4])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] sleep(SHORT_SLEEP)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
		[ ] 
		[ ] //############## Verifying transaction gets displayed on RentalProperty > Profit Loss############
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
		[ ] hWnd=NULL
		[ ] sActual=NULL
		[ ] bMatch=FALSE
		[ ] WaitForState(QuickenWindow,True,2)
		[ ] WaitForState(RentalPropertyRentCenter,True,2)
		[ ] // #################Recorded Expense Popup is clicked with the help of Location Identifier###############/// 
		[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
		[ ] sleep(4)
		[ ] WaitForState(RecordedDepositsCallout,True,2)
		[+] if (RecordedDepositsCallout.Exists(5))
			[ ] ReportStatus("Verify Recorded Expenses text became link. ", PASS, "Recorded Expenses text became link. ") 
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
			[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
				[ ] bMatch = MatchStr("*{lsTransaction[3]}*{sAmountPaid}*", sActual)
				[+] if ( bMatch )
					[ ] break
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify Transaction with RentalTag and category under Profit Loss", PASS, " Verify Transaction with RentalTag and category under Profit Loss: Transaction with Category:{lsTransaction[3]} and Amount:{sAmountPaid} has been diaplayed in the Recorded Expenses CallOut. ") 
			[+] else
				[ ] ReportStatus(" Verify Transaction with RentalTag and category under Profit Loss", FAIL, " Verify Transaction with RentalTag and category under Profit Loss: Transaction with Category:{lsTransaction[3]} and Amount:{sAmountPaid} has not been added correctly. ") 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] sleep(1)
			[ ] 
			[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
			[ ] sleep(2)
		[+] else
			[ ] ReportStatus("Verify Recorded Expenses text became link. ", FAIL, "Recorded Expenses text does not become link. ") 
			[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
		[ ] // #################Modify transaction from expense to income category###############/// 
		[ ] 
		[ ] hWnd=NULL
		[ ] sActual=NULL
		[ ] bMatch=FALSE
		[ ] sItem="Category"
		[ ] sExpected="Rents Received"
		[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
		[ ] WaitForState(DlgFindAndReplace,True,2)
		[ ] DlgFindAndReplace.SearchTextField.SetText(lsTransaction[2])
		[ ] DlgFindAndReplace.FindButton.Click()
		[ ] DlgFindAndReplace.SelectAllButton.Click()
		[ ] DlgFindAndReplace.ReplacePopupList.Select(sItem)
		[ ] DlgFindAndReplace.ReplacementTextField.ClearText()
		[ ] DlgFindAndReplace.ReplacementTextField.SetText(sExpected)
		[ ] DlgFindAndReplace.SetActive()
		[ ] // DlgFindAndReplace.Click()
		[ ] DlgFindAndReplace.ReplaceAllButton.Click()
		[ ] WaitForState(DlgFindAndReplace,True,1)
		[ ] DlgFindAndReplace.DoneButton.Click()
		[ ] WaitForState(DlgFindAndReplace,False,1)
		[ ] // #################Recorded Expense Popup is clicked with the help of Location Identifier###############/// 
		[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
		[ ] sleep(4)
		[ ] WaitForState(RecordedDepositsCallout,True,2)
		[+] if (RecordedDepositsCallout.Exists(5))
			[ ] ReportStatus("Verify Recorded Expenses text became link. ", PASS, "Recorded Expenses text became link. ") 
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
			[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
				[ ] bMatch = MatchStr("*{lsTransaction[3]}*{sAmountPaid}*", sActual)
				[+] if ( bMatch )
					[ ] break
			[+] if ( bMatch )
				[ ] ReportStatus(" Verify Transaction with RentalTag under Profit Loss", FAIL, " Verify modified transaction is removed from recorded expenses: Transaction with Category:{lsTransaction[3]} and Amount:{sAmountPaid} still displayed under Recorded Expenses CallOut. ") 
			[+] else
				[ ] ReportStatus(" Verify Transaction with RentalTag under Profit Loss", PASS, " Verify modified transaction is removed from recorded expenses: Transaction with Category:{lsTransaction[3]} and Amount:{sAmountPaid} is removed from Recorded Expenses CallOut. ") 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] sleep(1)
			[ ] 
			[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
			[ ] sleep(2)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Recorded Expenses text became link. ", FAIL, "Recorded Expenses text does not become link. ") 
		[ ] 
		[ ] ////Open Schedule E Report
		[ ] sExpReportTitle=NULL
		[ ] sExpReportTitle="Schedule E Report"
		[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
		[+] if (iReportSelect==PASS)
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
			[+] if (ScheduleEReportWindow.Exists(5))
				[ ] 
				[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
				[ ] ScheduleEReportWindow.SetActive()
				[ ] ScheduleEReportWindow.Maximize()
				[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
				[ ] 
				[ ] // //##############Verifying Rental Expense alongwith rental tag transaction on Schedule E Report	 ############////
				[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
				[ ] ScheduleEReportWindow.SetActive()
				[ ] 
				[ ] // Maximize sTAB_SHEDULE_E_REPORT 
				[ ] ScheduleEReportWindow.Maximize()
				[ ] 
				[ ] // Get window caption
				[ ] sActual = ScheduleEReportWindow.GetCaption()
				[ ] 
				[ ] // Verify window title
				[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
				[ ] 
				[ ] // Report Status if window title is as expected
				[+] if ( bMatch )
					[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
					[ ] //  Validate Report Data
					[ ] //####Verifying Rental Expense alongwith rental tag transaction on Schedule E Report////
					[ ] ScheduleEReportWindow.SetActive()
					[ ] sActual=NULL
					[ ] bAssert=FALSE
					[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
					[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
					[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] bAssert = MatchStr("*{lsTransaction[2]}*{sExpected}*{lsTransaction[4]}*{sAmountPaid}*", sActual)
						[+] if ( bAssert == TRUE)
							[ ] break
					[+] if(bAssert)
						[ ] ReportStatus("Validate Report Data", PASS, " Verify expense transaction along with rental tag on {sTAB_SHEDULE_E_REPORT} Report:Transaction with Payee :{lsTransaction[2]}, Category :{sExpected}, Tag :{lsTransaction[4]} and Amount: {sAmountPaid} get displayed.")
					[+] else
						[ ] ReportStatus("Validate Report Data", FAIL, " Verify expense transaction along with rental tag on {sTAB_SHEDULE_E_REPORT} Report : Transaction with Payee :{lsTransaction[2]}, Category :{sExpected},Tag :{lsTransaction[4]}  and Amount: {sAmountPaid} didn't display.")
				[+] else
					[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
				[ ] ScheduleEReportWindow.Close()
				[+] if(SaveReportAs.Exists(5))
					[ ] SaveReportAs.SetActive()
					[ ] SaveReportAs.DonTShowMeThisAgain.Check()
					[ ] SaveReportAs.DonTSave.Click()
				[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
				[ ] /////#######Report validation done#######///
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
		[+] else
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test55_AddUnspecifiedExpenseTransactionwithRentalCategoryOnly ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test55_AddUnspecifiedExpenseTransactionwithRentalCategoryOnly()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Unspecified Expense transaction with Rental Category Only	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying a Unspecified Expense transaction with Rental Category Only			
		[ ] //						Fail		If error occurs while verifying a Unspecified Expense transaction with Rental Category Only			
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Nov 20, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test55_AddUnspecifiedExpenseTransactionwithRentalCategoryOnly() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[20]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sAmountPaid=trim(Left(lsTransaction[6],5))
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iSelect =  SelectAccountFromAccountBar(lsAddAccount[2], ACCOUNT_RENTALPROPERTY )  
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account: {lsAddAccount[2]} has been selected") 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (KEY_CTRL_N)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_END)
			[ ] QuickenWindow.TypeKeys (KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[1])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[2])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[3])
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (lsTransaction[6])
			[ ] sleep(SHORT_SLEEP)
			[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
			[+] if (DlgSaveTransaction.Exists(5))
				[ ] DlgSaveTransaction.SetActive()
				[ ] DlgSaveTransaction.DontShowAgain.Check()
				[ ] DlgSaveTransaction.Save.Click()
				[ ] sleep(2)
			[ ] 
			[ ] //############## Verifying transaction with rental tag only gets displayed on RentalProperty > Profit Loss############
			[ ] //// Till now the total Uncategorized Rental transactions should be as below
			[ ] //// 500
			[ ] /// Uncategorized=850
			[ ] sExpected="Uncategorized"
			[ ] iAmount=850
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] hWnd=NULL
			[ ] sActual=NULL
			[ ] bMatch=FALSE
			[ ] WaitForState(QuickenWindow,True,2)
			[ ] WaitForState(RentalPropertyRentCenter,True,2)
			[ ] // #################Recorded Expenses Popup is clicked with the help of Location Identifier###############/// 
			[ ] RentalPropertyRentCenter.ListBox2.Click(1,49,4)
			[ ] sleep(4)
			[ ] WaitForState(RecordedDepositsCallout,True,2)
			[+] if (RecordedDepositsCallout.Exists(5))
				[ ] ReportStatus("Verify Recorded Expenses become link. ", PASS, "Recorded Expenses text become link. ") 
				[ ] hWnd=NULL
				[ ] sActual=NULL
				[ ] bMatch=FALSE
				[ ] hWnd = str(RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<RecordedDepositsCallout.CalloutPopup.RecordedDeposits.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sExpected}*{iAmount}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[+] if ( bMatch )
					[ ] ReportStatus(" Verify Unspecified Expense transaction with Rental Category Only", PASS, "Verify Unspecified Expense transaction with Rental Category Only: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{iAmount} has been added to the Recorded Expenses CallOut. ") 
				[+] else
					[ ] ReportStatus(" Verify Unspecified Expense transaction with Rental Category Only", FAIL, "Verify Unspecified Expense transaction with Rental Category Only: Transaction with Payee:{lsTransaction[2]}, Date:{sDateStamp},and Amount:{iAmount} has not been added correctly to the Recorded Expenses CallOut. ") 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] sleep(1)
				[ ] 
				[ ] RecordedDepositsCallout.CalloutPopup.Close.Click()
				[ ] sleep(2)
				[ ] //############## Verifying transaction on Reports> Rental Property>Schedule E Report ############
				[ ] QuickenWindow.SetActive()
				[ ] // Open Schedule E Report
				[ ] sExpReportTitle=NULL
				[ ] sExpReportTitle="Schedule E Report"
				[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
				[+] if (iReportSelect==PASS)
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
					[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
					[+] if (ScheduleEReportWindow.Exists(5))
						[ ] 
						[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
						[ ] ScheduleEReportWindow.SetActive()
						[ ] 
						[ ] // Maximize sTAB_SHEDULE_E_REPORT 
						[ ] ScheduleEReportWindow.Maximize()
						[ ] 
						[ ] // Get window caption
						[ ] sActual = ScheduleEReportWindow.GetCaption()
						[ ] 
						[ ] // Verify window title
						[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
						[ ] 
						[ ] // Report Status if window title is as expected
						[+] if ( bMatch )
							[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
							[ ] //  Validate Report Data
							[ ] hWnd=NULL
							[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
							[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
							[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
								[ ] ListAppend (lsListBoxItems,sActual)
							[ ] 
							[ ] //####Verify "**Unspecified Rental Expense**" row on "Schedule E" report
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] sExpected=NULL
							[ ] sExpected= "Unspecified Rental Expense"
							[+] for each sItem in lsListBoxItems
								[ ] bMatch = MatchStr("*{sExpected}*",sItem)
								[+] if ( bMatch == TRUE)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Validate Report Data", PASS, "Verify Unspecified Expense transaction with Rental Category Only: Tree node is {sExpected} displayed on  {sTAB_SHEDULE_E_REPORT}.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Verify Unspecified Expense transaction with Rental Category Only: Tree node  {sExpected} didn't display on {sTAB_SHEDULE_E_REPORT}.")
							[ ] 
							[ ] //####Verify Unspecified Expense transaction with Rental Category Only row on "Schedule E" report
							[+] for each sItem in lsListBoxItems
								[ ] bMatch = MatchStr("*{lsTransaction[2]}*{lsTransaction[3]}*{sAmountPaid}*", sItem)
								[+] if ( bMatch == TRUE)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Validate Report Data", PASS, "Verify Unspecified Expense transaction with Rental Category Only: Transaction with Payee :{lsTransaction[2]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} get displayed on  {sTAB_SHEDULE_E_REPORT}.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Verify Unspecified Expense transaction with Rental Category Only: Transaction with Payee :{lsTransaction[2]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} didn't display on {sTAB_SHEDULE_E_REPORT}.")
								[ ] 
						[+] else
							[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
						[ ] ScheduleEReportWindow.Close()
						[+] if(SaveReportAs.Exists(5))
							[ ] SaveReportAs.SetActive()
							[ ] SaveReportAs.DonTShowMeThisAgain.Check()
							[ ] SaveReportAs.DonTSave.Click()
						[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
						[ ] /////#######Report validation done#######///
					[+] else
						[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
				[+] else
					[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[+] else
				[ ] ReportStatus("Verify Recorded Expenses become link. ", FAIL, "Recorded Expenses text does not become link. ") 
	[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test52_VerifyCustomDateRangeTransactionsOnScheduleEReport ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test52_VerifyCustomDateRangeTransactionsOnScheduleEReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify transactions filtered on Custom dates criteria On Schedule E Report	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while Verifying transactions filtered on Custom dates criteria On Schedule E Report		
		[ ] //						Fail		if error occurs while Verifying year transactions filtered on Custom dates criteria On Schedule E Report	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                            Dec 21, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test52_VerifyCustomDateRangeTransactionsOnScheduleEReport() appstate RPMBaseState
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] STRING sDate , sCustomDate
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sRentalTransactionsSheet)
	[ ] 
	[ ] //Get custom dates
	[ ] 
	[ ] sDate=FormatDateTime ( AddDateTime (GetDateTime (), -368), "m/d/yyyy") 
	[ ] sDateStamp =FormatDateTime ( GetDateTime (),  "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //report
		[ ] // 
		[ ] // //##############Verifying Last year Income Transaction On Schedule E Report	 ############////
		[ ] // QuickenWindow.SetActive()
		[ ] // Open Schedule E Report
		[ ] sExpReportTitle=NULL
		[ ] sExpReportTitle="Schedule E Report"
		[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
		[+] if (iReportSelect==PASS)
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
			[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
			[+] if (ScheduleEReportWindow.Exists(5))
				[ ] 
				[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
				[ ] ScheduleEReportWindow.SetActive()
				[ ] 
				[ ] // Maximize sTAB_SHEDULE_E_REPORT 
				[ ] ScheduleEReportWindow.Maximize()
				[ ] 
				[ ] // Get window caption
				[ ] sActual = ScheduleEReportWindow.GetCaption()
				[ ] 
				[ ] // Verify window title
				[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
				[ ] 
				[ ] // Report Status if window title is as expected
				[+] if ( bMatch )
					[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
					[ ] //  Validate Report Data
					[ ] 
					[ ] //####Verify transactions for criteria "Custom dates..." on "Schedule E" report////
					[ ] ////## For criteria "Custom dates..."
					[ ] sCustomDate="Custom dates..."
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.QWCustomizeBar1.PopupList1.Select(sCustomDate)
					[+] if (DlgCustomDate.Exists(5))
						[ ] ReportStatus("Verify the Custom dates dialog on {sTAB_SHEDULE_E_REPORT}", PASS, "Verify the Custom dates dialog on {sTAB_SHEDULE_E_REPORT}: Custom dates dialog displayed on {sTAB_SHEDULE_E_REPORT}.") 
						[ ] DlgCustomDate.SetActive()
						[ ] DlgCustomDate.FromTextField.SetText(sDate)
						[ ] DlgCustomDate.ToTextField.SetText(sDateStamp)
						[ ] DlgCustomDate.OKButton.Click()
						[ ] WaitForState(DlgCustomDate, false ,1)
						[ ] sActual=NULL
						[ ] bAssert=FALSE
						[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
						[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
						[ ] 
						[+] for( iCounter=0;iCounter<iReportRowsCount ; ++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
							[ ] ListAppend (lsListBoxItems,sActual)
						[ ] 
						[+] for( iCounter=1; iCounter< ListCount(lsExcelData) +1; ++iCounter)
							[ ] lsTransaction=lsExcelData[iCounter]
							[+] if (lsTransaction[1]==NULL)
								[ ] break
							[ ] iAmount= VAL(lsTransaction[6])
							[+] for each sItem in lsListBoxItems
								[ ] bAssert = MatchStr("*{lsTransaction[2]}*{iAmount}*", sItem)
								[+] if ( bAssert == TRUE)
									[ ] break
							[+] if(bAssert)
								[ ] ReportStatus("Validate Report Data", PASS, " Verify transactions filtered on Custom dates criteria: Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {iAmount} get displayed on  {sExpReportTitle} as {sItem}.")
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, " Verify transactions filtered on Custom dates criteria:{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {iAmount} didn't display on {sExpReportTitle}.")
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify the Custom dates dialog on {sTAB_SHEDULE_E_REPORT}", FAIL, "Verify the Custom dates dialog on {sTAB_SHEDULE_E_REPORT}: Custom dates dialog didn't display on {sTAB_SHEDULE_E_REPORT}.") 
				[+] else
					[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
				[ ] 
				[ ] ScheduleEReportWindow.Close()
				[+] if(SaveReportAs.Exists(5))
					[ ] SaveReportAs.SetActive()
					[ ] SaveReportAs.DonTShowMeThisAgain.Check()
					[ ] SaveReportAs.DonTSave.Click()
				[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
				[ ] /////#######Report validation done#######///
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
		[+] else
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[ ] 
			[ ] //report
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[ ] 
[+] //############# Test56_VerifyScheduleEReportExpandAllOption ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test56_VerifyScheduleEReportExpandAllOption()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Expand All option on Rental Transactions on Schedule E Report
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while verifying Expand All option on Rental Transactions on Schedule E Report		
		[ ] //						Fail		if error occurs while verifying Expand All option on Rental Transactions on Schedule E Report		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Dec 12, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************//
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test56_VerifyScheduleEReportExpandAllOption() appstate RPMBaseState
	[ ] 
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sRentalTransactionsSheet)
	[ ] iItemCount=ListCount(lsExcelData)
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // //############## Verifying transactions on Reports> Rental Property> Tax Schedule Report ############
		[ ] // QuickenWindow.SetActive()
		[ ] // Open Schedule E Report
		[ ] sExpReportTitle=NULL
		[ ] sExpReportTitle="Schedule E Report"
		[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
		[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
		[+] if (iReportSelect==PASS)
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
			[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
			[+] if (ScheduleEReportWindow.Exists(5))
				[ ] 
				[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
				[ ] ScheduleEReportWindow.SetActive()
				[ ] 
				[ ] // Maximize sTAB_SHEDULE_E_REPORT 
				[ ] ScheduleEReportWindow.Maximize()
				[ ] 
				[ ] // Get window caption
				[ ] sActual = ScheduleEReportWindow.GetCaption()
				[ ] 
				[ ] // Verify window title
				[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
				[ ] 
				[ ] // Report Status if window title is as expected
				[+] if ( bMatch )
					[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
					[ ] //  Validate Report Data
					[ ] hWnd=NULL
					[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
					[ ] // //############## Verifying transactions on Reports after clicking Collapse All> Rental Property> E- Schedule Report ############
					[ ] // sActual=NULL
					[ ] // bAssert=FALSE
					[ ] // ScheduleEReportWindow.CollapseAll.Click()
					[ ] // WaitForState(ScheduleEReportWindow,TRUE,1)
					[+] // for( iCounter=0;iCounter<ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1;++iCounter)
						[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] // ListAppend (lsListBoxItems,sActual)
					[ ] // iLsCount=ListCount(lsListBoxItems)
					[+] // for( iCounter=1; iCounter< 10; ++iCounter)
						[ ] // lsTransaction=lsExcelData[iCounter]
						[+] // if (lsTransaction[1]==NULL)
							[ ] // break
						[ ] // sAmountPaid= trim(Left(lsTransaction[6],6))
						[+] // for each sItem in lsListBoxItems
							[ ] // bAssert = MatchStr("*{lsTransaction[2]}*{sAmountPaid}*", sItem)
							[+] // if ( bAssert == TRUE)
								[ ] // break
						[+] // if(bAssert)
							[ ] // ReportStatus("Validate Report Data", FAIL, " Verify Transactions collapsed: Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} get displayed on  {sExpReportTitle} as {sItem}.")
						[+] // else
							[ ] // ReportStatus("Validate Report Data", PASS, " Verify Transactions collapsed: Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {sAmountPaid} didn't display on {sExpReportTitle}.")
						[ ] 
						[ ] 
					[ ] // //############## Verifying transactions on Reports after clicking Expand All> Rental Property> E- Schedule Report ############
					[ ] sActual=NULL
					[ ] bAssert=FALSE
					[ ] ScheduleEReportWindow.ExpandAll.Click()
					[ ] WaitForState(TaxSchedule,TRUE,1)
					[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
					[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "{iCounter}")
						[ ] ListAppend (lsListBoxItems,sActual)
					[ ] iListCount=ListCount(lsListBoxItems)
					[+] for( iCounter=1; iCounter< ListCount(lsExcelData)+1 ; ++iCounter)
						[ ] lsTransaction=lsExcelData[iCounter]
						[+] if (lsTransaction[1]==NULL)
							[ ] break
						[ ] iAmount= VAL(lsTransaction[6])
						[+] for each sItem in lsListBoxItems
							[ ] bAssert = MatchStr("*{lsTransaction[2]}*{iAmount}*", sItem)
							[+] if ( bAssert == TRUE)
								[ ] break
						[+] if(bAssert)
							[ ] ReportStatus("Validate Report Data", PASS, " Verify Transactions Expanded: Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {iAmount} get displayed on  {sExpReportTitle} as {sItem}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Verify Transactions Expanded: Transaction with Payee :{lsTransaction[2]}, Category :{lsTransaction[3]}, Tag: {lsTransaction[4]} and Amount: {iAmount} didn't display on {sExpReportTitle}.")
						[ ] 
						[ ] 
					[ ] // //############## Verifying " My Saved Reports & Graphs " option in Reports############
					[ ] WaitForState(ScheduleEReportWindow,TRUE,1)
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ALT_S)
					[ ] WaitForState(DlgSaveReport,TRUE,1)
					[+] if (DlgSaveReport.Exists(5))
						[ ] DlgSaveReport.SetActive()
						[ ] DlgSaveReport.ReportName.SetText(sExpReportTitle)
						[ ] DlgSaveReport.OK.Click()
						[ ] WaitForState(DlgSaveReport,FALSE,1)
						[+] if (ScheduleEReportWindow.Exists(5))
							[ ] ScheduleEReportWindow.SetActive()
							[ ] ScheduleEReportWindow.Close()
							[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Reports.Click()
						[+] if (QuickenWindow.Reports.MySavedReportsGraphs.Exists(2))
							[ ] ReportStatus("Verify My Saved Reports & Graphs", PASS, "Verify My Saved Reports & Graphs: My Saved Reports & Graphs menu added to the reports.")
						[+] else
							[ ] ReportStatus("Verify My Saved Reports & Graphs", FAIL, "Verify My Saved Reports & Graphs:My Saved Reports & Graphs menu didn't add to the reports.")
					[+] else
						[ ] ReportStatus("Verify Save Report Dialog", FAIL, " Save Report Dialog didn't appear.") 
						[ ] 
				[+] else
					[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
				[ ] /////#######Report validation done#######///
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
		[+] else
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
[ ] 
[+] //############# Test57_VerifyScheduleEReportOptions ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test57_VerifyScheduleEReportOptions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will verify Schedule E Report Options	
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while verifying Schedule E Report Options		
		[ ] //						Fail		if error occurs while verifying Schedule E Report Options
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Dec13, 2012		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test57_VerifyScheduleEReportOptions() appstate RPMBaseState
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sPropertyWorksheet)
	[ ] lsAddProperty=lsExcelData[2]
	[ ] // Read data from excel sheet sTransactionSheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sRentalData, sTransactionSheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransaction=lsExcelData[11]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] sAmountPaid= trim(Left(lsTransaction[6],6))
	[ ] 
	[ ] sCategory= "Commissions (Rental)"
	[ ] sMemo="sMemo"
	[ ] sTag=lsAddProperty[2]
	[ ] sPayee="Test"
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // Open Schedule E Report
		[ ] sExpReportTitle=NULL
		[ ] sExpReportTitle="Schedule E Report"
		[ ] iReportSelect = OpenReport(lsReportCategory[7], sTAB_SHEDULE_E_REPORT)	
		[+] if (iReportSelect==PASS)
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report successful") 
			[ ] // Verify sTAB_SHEDULE_E_REPORT is Opened
			[+] if (ScheduleEReportWindow.Exists(5))
				[ ] 
				[ ] // Set Actives sTAB_SHEDULE_E_REPORT  
				[ ] ScheduleEReportWindow.SetActive()
				[ ] 
				[ ] // Maximize sTAB_SHEDULE_E_REPORT 
				[ ] // ScheduleEReportWindow.Maximize()
				[ ] 
				[ ] // Get window caption
				[ ] sActual = ScheduleEReportWindow.GetCaption()
				[ ] 
				[ ] // Verify window title
				[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
				[ ] 
				[ ] // Report Status if window title is as expected
				[+] if ( bMatch )
					[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
					[ ] // //############## Verifying Schedule E Report Edit options without selecting any transaction ############
					[ ] 
					[ ] // //############## Verifying Schedule E Report Edit options without selecting any transaction>Delete transactions ############
					[ ] 
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] ScheduleEReportWindow.TypeKeys(KEY_DN)
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[+] if (AlertMessage.Exists(1))
						[ ] sValidationText=AlertMessage.MessageText.GetText()
						[ ] ReportStatus(" Verify Delete transactions menu when no transaction is selected", FAIL, "Verify Delete transactions menu when no transaction is selected:{sValidationText} mesage displayed.") 
						[ ] AlertMessage.Cancel.Click()
						[ ] WaitForState(AlertMessage,FALSE,1)
					[+] else
						[ ] ReportStatus(" Verify Delete transactions menu when no transaction is selected", PASS, "Verify Delete transactions menu when no transaction is selected: Delete transactions menu disabled.") 
					[ ] // //############## Verifying Schedule E Report Edit options without selecting any transaction>Recategorize transactions ############
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] ScheduleEReportWindow.TypeKeys(Replicate (KEY_DN, 2))	
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[+] if (OptionsDialog.Exists(1))
						[ ] sValidationText=OptionsDialog.DialogTitleText.GetText()
						[ ] ReportStatus(" Verify Recategorize transactions menu when no transaction is selected", FAIL, " Verify Recategorize transactions menu when no transaction is selected: {sValidationText} dialog displayed.") 
						[ ] OptionsDialog.Cancel.Click()
						[ ] WaitForState(OptionsDialog,FALSE,1)
					[+] else
						[ ] ReportStatus(" Verify Recategorize transactions menu when no transaction is selected", PASS, " Verify Recategorize transactions menu when no transaction is selected: Recategorize transactions menu is disabled.") 
					[ ] // //############## Verifying Schedule E Report Edit options without selecting any transaction>Retag transactions ############
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] ScheduleEReportWindow.TypeKeys(Replicate (KEY_DN, 3))	
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[+] if (OptionsDialog.Exists(1))
						[ ] sValidationText=OptionsDialog.DialogTitleText.GetText()
						[ ] ReportStatus(" Verify Retag transactions menu when no transaction is selected", FAIL, " Verify Retag transactions menu when no transaction is selected: {sValidationText} dialog displayed.") 
						[ ] OptionsDialog.Cancel.Click()
						[ ] WaitForState(OptionsDialog,FALSE,1)
					[+] else
						[ ] ReportStatus(" Verify Retag transactions menu when no transaction is selected", PASS, " Verify Retag transactions menu when no transaction is selected: Retag transactions menu is disabled.") 
					[ ] // //############## Verifying Schedule E Report Edit options without selecting any transaction>Rename payee(s)############
					[ ] 
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] ScheduleEReportWindow.TypeKeys(Replicate (KEY_DN, 4))	
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[+] if (OptionsDialog.Exists(1))
						[ ] sValidationText=OptionsDialog.DialogTitleText.GetText()
						[ ] ReportStatus(" Verify Rename payee(s) menu when no transaction is selected", FAIL, " Verify Rename payee(s) menu when no transaction is selected: {sValidationText} dialog displayed.") 
						[ ] OptionsDialog.Cancel.Click()
						[ ] WaitForState(OptionsDialog,FALSE,1)
					[+] else
						[ ] ReportStatus(" Verify Rename payee(s)  menu when no transaction is selected", PASS, " Verify Rename payee(s)  menu when no transaction is selected: Rename payee(s) menu is disabled.") 
					[ ] // //############## Verifying Schedule E Report Edit options without selecting any transaction>Edit memo(s)############
					[ ] 
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] ScheduleEReportWindow.TypeKeys(Replicate (KEY_DN, 5))	
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[+] if (OptionsDialog.Exists(1))
						[ ] sValidationText=OptionsDialog.DialogTitleText.GetText()
						[ ] ReportStatus(" Verify Edit memo(s) menu when no transaction is selected", FAIL, " Verify Retag transactions menu when no transaction is selected: {sValidationText} dialog displayed.") 
						[ ] OptionsDialog.Cancel.Click()
						[ ] WaitForState(OptionsDialog,FALSE,1)
					[+] else
						[ ] ReportStatus(" Verify Edit memo(s) menu when no transaction is selected", PASS, " Verify Retag transactions menu when no transaction is selected: Edit memo(s) menu is disabled.") 
					[ ] 
					[ ] // //############## Verifying Schedule E Report Edit options after selecting any transaction ############
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.QWListViewer1.ListBox1.Select("#2")
					[ ] WaitForState(ScheduleEReportWindow,TRUE,1)
					[ ] hWnd=NULL
					[ ] hWnd = Str(ScheduleEReportWindow.QWListViewer1.ListBox1.GetHandle ())
					[ ] 
					[ ] // //############## Verifying Schedule E Report Edit options after selecting any transaction>Recategorize transactions ############
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] ScheduleEReportWindow.TypeKeys(Replicate (KEY_DN, 2))	
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[ ] WaitForState(OptionsDialog,TRUE,1)
					[+] if (OptionsDialog.Exists(5))
						[ ] OptionsDialog.SetActive()
						[ ] sValidationText=OptionsDialog.DialogTitleText.GetText()
						[ ] ReportStatus(" Verify Recategorize transactions menu when a transaction is selected", PASS, " Verify Recategorize transactions menu when a transaction is selected: {sValidationText} dialog displayed.") 
						[ ] OptionsDialog.TextField.SetText(sCategory)
						[ ] OptionsDialog.SetActive()
						[ ] OptionsDialog.OK.Click()
						[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
						[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, " {iCounter}")
							[ ] bAssert = MatchStr("*{sCategory}*", sActual)
							[+] if ( bAssert == TRUE)
								[ ] break
						[+] if(bAssert)
							[ ] ReportStatus("Validate Report Data", PASS, " Transaction updated with Category {sCategory} on  {sTAB_SHEDULE_E_REPORT}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction didn't update with Category {sCategory} on  {sTAB_SHEDULE_E_REPORT}.")
						[ ] 
					[+] else
						[ ] ReportStatus(" Verify Recategorize transactions menu when a transaction is selected", FAIL, " Verify Recategorize transactions menu when a transaction is selected: Recategorize transactions menu is disabled.") 
					[ ] // //############## Verifying Schedule E Report Edit options after selecting any transaction>Retag transactions ############
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.QWListViewer1.ListBox1.Select("#2")
					[ ] WaitForState(OptionsDialog,TRUE,1)
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] ScheduleEReportWindow.TypeKeys(Replicate (KEY_DN, 3))	
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[ ] WaitForState(OptionsDialog,TRUE,1)
					[+] if (OptionsDialog.Exists(1))
						[ ] OptionsDialog.SetActive()
						[ ] sValidationText=OptionsDialog.DialogTitleText.GetText()
						[ ] ReportStatus(" Verify Retag transactions menu when a transaction is selected", PASS, " Verify Retag transactions menu when a transaction is selected: {sValidationText} dialog displayed.") 
						[ ] WaitForState(OptionsDialog,TRUE,1)
						[ ] OptionsDialog.TextField.SetText(sTag)
						[ ] OptionsDialog.OK.Click()
						[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
						[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, " {iCounter}")
							[ ] bAssert = MatchStr("*{sTag}*", sActual)
							[+] if ( bAssert == TRUE)
								[ ] break
						[+] if(bAssert)
							[ ] ReportStatus("Validate Report Data", PASS, " Transaction updated with Tag {sTag} on {sTAB_SHEDULE_E_REPORT}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction didn't update with Tag {sTag} on {sTAB_SHEDULE_E_REPORT}.")
						[ ] 
					[+] else
						[ ] ReportStatus(" Verify Retag transactions menu when a transaction is selected", FAIL, " Verify Retag transactions menu when a transaction is selected: Retag transactions menu is disabled.") 
					[ ] // //############## Verifying Schedule E Report Edit options after selecting any transaction>Rename payee(s)############
					[ ] 
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.QWListViewer1.ListBox1.Select("#2")
					[ ] WaitForState(OptionsDialog,TRUE,1)
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] ScheduleEReportWindow.TypeKeys(Replicate (KEY_DN, 4))	
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[ ] WaitForState(OptionsDialog,TRUE,1)
					[+] if (OptionsDialog.Exists(1))
						[ ] OptionsDialog.SetActive()
						[ ] sValidationText=OptionsDialog.DialogTitleText.GetText()
						[ ] ReportStatus(" Verify Rename payee(s) menu when a transaction is selected", PASS, " Verify Rename payee(s) menu when a transaction is selected: {sValidationText} dialog displayed.") 
						[ ] WaitForState(OptionsDialog,TRUE,1)
						[ ] OptionsDialog.SetActive()
						[ ] OptionsDialog.TextField.SetText(sPayee)
						[ ] OptionsDialog.OK.Click()
						[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
						[+] for( iCounter=0;iCounter< iReportRowsCount ; ++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, " {iCounter}")
							[ ] bAssert = MatchStr("*{sPayee}*", sActual)
							[+] if ( bAssert == TRUE)
								[ ] break
						[+] if(bAssert)
							[ ] ReportStatus("Validate Report Data", PASS, " Transaction updated with Payee {sPayee} on {sTAB_SHEDULE_E_REPORT}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction didn't update with Payee {sPayee} on {sTAB_SHEDULE_E_REPORT}.")
						[ ] 
					[+] else
						[ ] ReportStatus(" Verify Rename payee(s)  menu when a transaction is selected", FAIL, " Verify Rename payee(s)  menu when a transaction is selected: Rename payee(s) menu is disabled.") 
					[ ] // //############## Verifying Schedule E Report Edit options after selecting any transaction>Edit memo(s)############
					[ ] 
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.QWListViewer1.ListBox1.Select("#2")
					[ ] WaitForState(OptionsDialog,TRUE,1)
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] ScheduleEReportWindow.TypeKeys(Replicate (KEY_DN, 5))	
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[ ] WaitForState(OptionsDialog,TRUE,1)
					[ ] 
					[+] if (OptionsDialog.Exists(1))
						[ ] OptionsDialog.SetActive()
						[ ] sValidationText=OptionsDialog.DialogTitleText.GetText()
						[ ] ReportStatus(" Verify Edit memo(s) menu when a transaction is selected", PASS, " Verify Retag transactions menu when a transaction is selected: {sValidationText} dialog displayed.") 
						[ ] WaitForState(OptionsDialog,TRUE,1)
						[ ] OptionsDialog.TextField.SetText(sMemo)
						[ ] OptionsDialog.OK.Click()
						[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
						[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, " {iCounter}")
							[ ] bAssert = MatchStr("*{sMemo}*", sActual)
							[+] if ( bAssert == TRUE)
								[ ] break
						[+] if(bAssert)
							[ ] ReportStatus("Validate Report Data", PASS, " Transaction updated with Memo {sMemo} on {sTAB_SHEDULE_E_REPORT}.")
						[+] else
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction didn't update with Memo {sMemo} on {sTAB_SHEDULE_E_REPORT}.")
						[ ] 
					[+] else
						[ ] ReportStatus(" Verify Edit memo(s) menu when a transaction is selected", FAIL, " Verify Retag transactions menu when a transaction is selected: Edit memo(s) menu is disabled.") 
					[ ] // //############## Verifying Schedule E Report Edit options after selecting any transaction>Delete transactions ############
					[ ] ScheduleEReportWindow.QWListViewer1.ListBox1.Select("#2")
					[ ] WaitForState(ScheduleEReportWindow,TRUE,1)
					[ ] ScheduleEReportWindow.Edit.Click()
					[ ] WaitForState(OptionsDialog,TRUE,1)
					[ ] ScheduleEReportWindow.TypeKeys(KEY_DN)
					[ ] ScheduleEReportWindow.TypeKeys(KEY_ENTER)
					[ ] WaitForState(OptionsDialog,TRUE,1)
					[ ] 
					[+] if (AlertMessage.Exists(1))
						[ ] AlertMessage.SetActive()
						[ ] sValidationText=AlertMessage.MessageText.GetText()
						[ ] ReportStatus(" Verify Delete transactions menu when a transaction is selected", PASS, "Verify Delete transactions menu when a transaction is selected:{sValidationText} mesage displayed.") 
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage,FALSE,1)
						[ ] iReportRowsCount=ScheduleEReportWindow.QWListViewer1.ListBox1.GetItemCount() +1
						[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd, " {iCounter}")
							[ ] bAssert = MatchStr("*{sPayee}*", sActual)
							[+] if ( bAssert == TRUE)
								[ ] break
						[+] if(bAssert)
							[ ] ReportStatus("Validate Report Data", FAIL, " Transaction with Payee {sPayee} didn't delete from {sTAB_SHEDULE_E_REPORT}.")
							[ ] ScheduleEReportWindow.Close()
							[+] if(SaveReportAs.Exists(5))
								[ ] SaveReportAs.SetActive()
								[ ] SaveReportAs.DonTShowMeThisAgain.Check()
								[ ] SaveReportAs.DonTSave.Click()
							[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
						[+] else
							[ ] ReportStatus("Validate Report Data", PASS, "Transaction with Payee {sPayee} deleted from {sTAB_SHEDULE_E_REPORT}.")
							[ ] // #################Verify Amount Returned transaction in the *Security Deposit Liability* account###############/// 
							[ ] ScheduleEReportWindow.Close()
							[+] if(SaveReportAs.Exists(5))
								[ ] SaveReportAs.SetActive()
								[ ] SaveReportAs.DonTShowMeThisAgain.Check()
								[ ] SaveReportAs.DonTSave.Click()
							[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
							[ ] hWnd=NULL
							[ ] sActual=NULL
							[ ] bMatch=FALSE
							[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
							[ ] WaitForState(DlgFindAndReplace,True,2)
							[ ] DlgFindAndReplace.SearchTextField.SetText(sPayee)
							[ ] DlgFindAndReplace.FindButton.Click()
							[+] if (AlertMessage.Exists(2))
								[ ] ReportStatus("Validate Report Data", PASS, "Transaction with Payee {sPayee} deleted from account.")
								[ ] AlertMessage.OK.Click()
								[ ] WaitForState(AlertMessage,False,1)
							[+] else
								[ ] ReportStatus("Validate Report Data", FAIL, "Transaction with Payee {sPayee} not deleted from account.")
							[ ] DlgFindAndReplace.DoneButton.Click()
							[ ] WaitForState(DlgFindAndReplace,False,1)
					[+] else
						[ ] ReportStatus(" Verify Delete transactions menu when a transaction is selected", FAIL, "Verify Delete transactions menu when a transaction is selected: Delete transactions menu disabled.") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
				[+] if(ScheduleEReportWindow.Exists(5))
					[ ] ScheduleEReportWindow.SetActive()
					[ ] ScheduleEReportWindow.Close()
				[+] if(SaveReportAs.Exists(5))
					[ ] SaveReportAs.SetActive()
					[ ] SaveReportAs.DonTShowMeThisAgain.Check()
					[ ] SaveReportAs.DonTSave.Click()
				[ ] WaitForState(ScheduleEReportWindow,FALSE,1)
				[ ] /////#######Report validation done#######///
			[+] else
				[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
		[+] else
			[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
			[ ] 
			[ ] //report
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[+] //############# Test58_VerifyRentalPropertyAccountOverview #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test58_VerifyRentalPropertyAccountOverview()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the Checking , Credit Card and Property accouns in Rental Property account Overview tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verifying the Checking ,Credit Card and Property accouns in Rental Property account Overview tab					
		[ ] //						Fail		If any error occurs while verifying the Checking ,Credit Card and Property accouns in Rental Property account Overview tab					
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 03, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test58_VerifyRentalPropertyAccountOverview() appstate RPMBaseState
	[ ] LIST OF ANYTYPE lsOtherAccount 
	[ ] STRING sTab , sListItem ,sAccountName ,sAccountType
	[ ] sTab="Display Options"
	[ ] sListItem="Rental Property"
	[ ] sAccountIntent="RENTAL"
	[ ] sAccountType="Property & Debt"
	[ ] // Read data from excel sOtherAccountWorksheet sheet
	[ ] lsExcelData=ReadExcelTable(sRentalData, sOtherAccountWorksheet)
	[ ] lsOtherAccount=lsExcelData[1]
	[ ] // Read data from excel sAccountWorksheet sheet
	[ ] lsExcelData=ReadExcelTable(sRentalData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[3]
	[ ] //############## Create New CreditCard and Property and Debt Accounts #####################################
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // Add CreditCard Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],sAccountIntent)
		[ ] 
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] // Add Property Account
		[ ] iAddAccount=AddPropertyAccount(lsOtherAccount[1] ,lsOtherAccount[2] ,lsOtherAccount[3] ,lsOtherAccount[4] ,lsOtherAccount[5])
		[ ] sAccountName=lsOtherAccount[2]
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsOtherAccount[1]} Account", PASS, "{lsOtherAccount[1]} Account -  {lsOtherAccount[2]}  is created successfully")
			[ ] iResult=SelectAccountFromAccountBar(sAccountName,sAccountType)
			[+] if(iResult==PASS)
				[ ] iNavigate=NavigateToAccountDetails( sAccountName)
				[+] if (iNavigate==PASS)
					[ ] iNavigate=SelectAccountDetailsTabs(lsOtherAccount[1] , sTab)
					[+] if (iNavigate==PASS)
						[+] if(AccountDetails.Exists(5))
							[ ] AccountDetails.SetActive()
							[ ] AccountDetails.AccountIntent2.Select(sListItem)
							[ ] AccountDetails.OK.Click()
							[ ] WaitForState(AccountDetails , False ,1)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify {sTab} on Edit Account Details window", FAIL, ":{sTab} on Edit Account Details window didn't display for {sAccountName}")
				[+] else
					[ ] ReportStatus("Verify Edit Account Details window", FAIL, "Account Details window is Not available for {sAccountName}")
			[+] else
				[ ] ReportStatus("Verify {sAccountName} Account selected.", FAIL, "Verify {sAccountName} Account selected: {sAccountName} couldn't be selected.")
			[ ] 
		[+] else
			[ ] ReportStatus("{lsOtherAccount[1]} Account", FAIL, "{lsOtherAccount[1]} Account -  {lsOtherAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] 
		[ ] iNavigate=NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_ACCOUNT_OVERVIEW)
		[+] if (iNavigate==PASS)
			[ ] QuickenWindow.SetActive()
			[+] ///Verify Checking account and Options button available in Rental Property Account Overview//
				[ ] lsAddAccount=lsExcelData[1]
				[ ] QuickenWindow.SetActive()
				[ ] sHandle=Str(RentalPropertyRentCenter.ListBox1.GetHandle())
				[ ] iListCount=RentalPropertyRentCenter.ListBox1.GetItemCount()
				[+] for (iCounter=0 ; iCounter< iListCount+1 ;  ++iCounter)
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  Str(iCounter))
					[ ] bMatch=MatchStr("*{lsAddAccount[2]}*" , sActual)
					[+] if (bMatch)
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify{lsAddAccount[1]} Account available in Rental Property Account Overview", PASS, "Verify{lsAddAccount[1]} Account available in Rental Property Account Overview: {lsAddAccount[1]} type Account {lsAddAccount[2]} is available in Rental Property Account Overview ")
				[+] else
					[ ] ReportStatus("Verify{lsAddAccount[1]} Account available in Rental Property Account Overview", PASS, "Verify{lsAddAccount[1]} Account available in Rental Property Account Overview: {lsAddAccount[1]} type Account {lsAddAccount[2]} is NOT available in Rental Property Account Overview ")
				[+] if (RentalPropertyRentCenter.QWSnapHolder1.AccountOverviewSpendingText.OptionsText.OptionsButton.Exists(5))
					[ ] ReportStatus("Verify Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview", PASS, "Verify Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview: Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview.")
				[+] else
					[ ] ReportStatus("Verify Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview", FAIL, "Verify Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview: Options is NOT button available for {lsAddAccount[2]} Account in Rental Property Account Overview.")
				[ ] 
			[+] ///Verify Credit Card account and Options button available in Rental Property Account Overview//
				[ ] lsAddAccount=lsExcelData[3]
				[ ] QuickenWindow.SetActive()
				[ ] sHandle=Str(RentalPropertyRentCenter.ListBox2.GetHandle())
				[ ] iListCount=RentalPropertyRentCenter.ListBox2.GetItemCount()
				[ ] 
				[+] for (iCounter=0 ; iCounter< iListCount+1 ;  ++iCounter)
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  Str(iCounter))
					[ ] bMatch=MatchStr("*{lsAddAccount[2]}*" , sActual)
					[+] if (bMatch)
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify{lsAddAccount[1]} Account available in Rental Property Account Overview", PASS, "Verify{lsAddAccount[1]} Account available in Rental Property Account Overview: {lsAddAccount[1]} type Account {lsAddAccount[2]} is available in Rental Property Account Overview ")
				[+] else
					[ ] ReportStatus("Verify{lsAddAccount[1]} Account available in Rental Property Account Overview", FAIL, "Verify{lsAddAccount[1]} Account available in Rental Property Account Overview: {lsAddAccount[1]} type Account {lsAddAccount[2]} is NOT available in Rental Property Account Overview ")
				[+] if (RentalPropertyRentCenter.QWSnapHolder1.AccountOverviewCreditCardText.OptionsText.OptionsButton.Exists(5))
					[ ] ReportStatus("Verify Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview", PASS, "Verify Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview: Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview.")
				[+] else
					[ ] ReportStatus("Verify Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview", FAIL, "Verify Options button is available for {lsAddAccount[2]} Account in Rental Property Account Overview: Options is NOT button available for {lsAddAccount[2]} Account in Rental Property Account Overview.")
				[ ] 
			[+] ///Verify Property account and Options button available in Rental Property Account Overview//
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] sHandle=Str(RentalPropertyRentCenter.ListBox3.GetHandle())
				[ ] iListCount=RentalPropertyRentCenter.ListBox3.GetItemCount()
				[+] for (iCounter=0 ; iCounter< iListCount+1 ;  ++iCounter)
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  Str(iCounter))
					[ ] bMatch=MatchStr("*{lsOtherAccount[2]}*" , sActual)
					[+] if (bMatch)
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify{lsOtherAccount[1]} Account available in Rental Property Account Overview", PASS, "Verify{lsOtherAccount[1]} Account available in Rental Property Account Overview: {lsOtherAccount[1]} type Account {lsOtherAccount[2]} is available in Rental Property Account Overview ")
				[+] else
					[ ] ReportStatus("Verify{lsOtherAccount[1]} Account available in Rental Property Account Overview", FAIL, "Verify{lsOtherAccount[1]} Account available in Rental Property Account Overview: {lsOtherAccount[1]} type Account {lsOtherAccount[2]} is NOT available in Rental Property Account Overview ")
				[+] if (RentalPropertyRentCenter.QWSnapHolder1.AccountOverviewSpendingText.OptionsText.OptionsButton.Exists(5))
					[ ] ReportStatus("Verify Options button is available for {lsOtherAccount[2]} Account in Rental Property Account Overview", PASS, "Verify Options button is available for {lsOtherAccount[2]} Account in Rental Property Account Overview: Options button is available for {lsOtherAccount[2]} Account in Rental Property Account Overview.")
				[+] else
					[ ] ReportStatus("Verify Options button is available for {lsOtherAccount[2]} Account in Rental Property Account Overview", FAIL, "Verify Options button is available for {lsOtherAccount[2]} Account in Rental Property Account Overview: Options is NOT button available for {lsOtherAccount[2]} Account in Rental Property Account Overview.")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_ACCOUNT_OVERVIEW} ", FAIL, "Navigate to {sTAB_RENTAL_PROPERTY} > {sTAB_ACCOUNT_OVERVIEW} Not displayed") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
[+] // // testcase RentalPropertyClean() appstate RPMBaseState
	[ ] // // SYS_Execute("taskkill /f /im partner.exe")
	[ ] // // 
	[ ] // // 
[ ] // 
