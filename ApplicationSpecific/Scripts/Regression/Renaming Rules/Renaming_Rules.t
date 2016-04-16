[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<Renaming_Rules.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Renaming Rules test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Shrivardhan
	[ ] //
	[ ] // Developed on: 		24/01/2014
	[ ] //			
[ ] // *********************************************************
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[-] //variable declaration
	[ ] STRING sAccountName="Checking at Bank of America-All Other S",sPath="RenamingRules_files\",sFileName,sFileName1="Renaming1",sPreferences="Downloaded Transactions"
	[ ] INTEGER iSelect,iResult,iFind,iPass
	[ ] LIST OF ANYTYPE lsExcelData,lsPayee
	[ ] public STRING sRenamingData = "RenamingRules", sRenamingWorksheet = "Details"
	[ ] 
[ ] 
[ ] //#############Enviornment Setup #################################################
[-] testcase IUS_Setup () appstate QuickenBaseState
	[ ] 
	[ ] STRING sEnviornment = "Stage-mini"   // Need to update this value as per required enviornment
	[ ] 
	[ ] LIST of STRING lsEnviornment = {"Stage-mini","Stage","Production"}
	[ ] 
	[-] if(sEnviornment=="Stage-mini")
		[ ] 
		[ ] iResult=SetUp_StageMiniConfig(lsEnviornment[1])
		[-] if(iResult==PASS)
			[ ] ReportStatus("setup {lsEnviornment[1]} enviornment",PASS,"Enviornment is set to {lsEnviornment[1]}")
		[-] else
			[ ] ReportStatus("setup {lsEnviornment[1]} enviornment",FAIL,"Enviornment is not set to {lsEnviornment[1]}")
			[ ] 
		[ ] 
	[-] else if(sEnviornment=="Stage")
		[ ] 
		[ ] iResult=SetUp_StageMiniConfig(lsEnviornment[2])
		[-] if(iResult==PASS)
			[ ] ReportStatus("setup {lsEnviornment[2]} enviornment",PASS,"Enviornment is set to {lsEnviornment[2]}")
		[-] else
			[ ] ReportStatus("setup {lsEnviornment[2]} enviornment",FAIL,"Enviornment is not set to {lsEnviornment[2]}")
			[ ] 
		[ ] 
	[-] else
		[ ] // do nothing
	[ ] 
	[-] if(sEnviornment!="Production")
		[ ] LaunchQuicken()
		[ ] sleep(5)
[ ] //##############################################################################
[ ] 
[ ] 
[+] //############# Renaming Rules  SetUp #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test0_ACESetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the ACE_Test.QDF if it exists. It will setup the necessary pre-requisite for ACE_Test tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[-] testcase Test0_RenamingRulesSetUp()appstate none
	[+] //variable declaration
		[ ] STRING sFileName="RenamingRules_Test"
		[ ] INTEGER iResult
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ]  //########Launch Quicken and open MemorizedPayee_Test File######################//
	[ ] iResult=DataFileCreate(sFileName)
	[+] if(iResult==PASS)
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[+] if (LowScreenResolution.Exists(5))
				[ ] LowScreenResolution.SetActive()
				[ ] LowScreenResolution.Dontshowthisagain.Check()
				[ ] LowScreenResolution.OK.Click()
			[ ] 
		[ ] //Report Status if Quicken is not launched
		[+] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# Test1-When Quicken will create automatic renaming rules?#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test1_AutomaticRuleCreation()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify automatic creation of renaming rules
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test1_AutomaticRuleCreation()appstate none
	[+] //variable declaration
		[ ] sFileName=sPath+sFileName1
		[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] //open preferences and select "Downloaded Transactions"
			[ ] iResult=SelectPreferenceType(sPreferences)
			[+] if(iResult==PASS)
				[ ] ReportStatus("verify preferences was opened and Downloaded Transactions was selected",PASS,"Downlaoded transactions was selected from Preferences successfully")
				[ ] Preferences.SetActive()
				[ ] // uncheck "let me review/confirm....." checkbox
				[ ] Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Uncheck()
				[ ] //close Preferences window
				[ ] Preferences.OK.Click()
				[ ] //open account from accountbar
				[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
					[ ] //read from  excel sheet
					[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
					[ ] //read the first row of excel sheet
					[ ] lsPayee=lsExcelData[1]
					[ ] //find payee in register
					[ ] iFind=FindTransaction("MDI",lsPayee[1])
					[+] if(iFind==PASS)
						[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
						[ ] //renaming the payee
						[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
						[ ] MDIClient.TypeKeys(lsPayee[2])
						[ ] MDIClient.TypeKeys(KEY_ENTER)
						[ ] //search for the renaming rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==PASS)
							[ ] ReportStatus("verify if renaming rule was created automatically",PASS,"renaming rule was created automatically")
							[ ] DeleteRenamingRule()
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was created automatically",FAIL,"renaming rule could not be created automatically")
					[+] else
						[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
					[ ] //delete account
					[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
					[ ] 
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
				[ ] //open preferneces and select "Downloaded Transactions"
				[ ] SelectPreferenceType(sPreferences)
				[ ] Preferences.SetActive()
				[ ] //check "let me review ...." checkbox
				[ ] Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Check()
				[ ] //close preferences
				[ ] Preferences.OK.Click()
			[+] else
				[ ] ReportStatus("verify preferences was opened and Downloaded Transactions was selected",FAIL,"Downlaoded transactions could not selected from Preferences")
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test 4- Verify 'Ok' button functionality on 'Create Payee Renaming Rule' dialog.#################################################
[+] //############# Test 2-User Renames payee for the first time #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test2_FirstRename()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'Create Payee Renaming rule' dialogue and verify OK button functionality
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test2_FirstRename()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //click on OK button
						[ ] CreatePayeeRenamingRule.OK.Click()
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==PASS)
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",PASS,"renaming rule was created")
							[ ] DeleteRenamingRule()
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",FAIL,"renaming rule could not be created")
						[ ] 
					[+] else
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue doesnt exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# Test 6-Verify 'Cancel' button functionality on 'Create Payee Renaming Rule' dialog..#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test3_FirstRenameCancelButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Cancel button functionality on 'Create Payee Renaming Rule' dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test3_FirstRenameCancelButton()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //click on Cancel button
						[ ] CreatePayeeRenamingRule.Cancel.Click()
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==FAIL)
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",PASS,"renaming rule was not created")
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",FAIL,"renaming rule was created")
							[ ] DeleteRenamingRule()
						[ ] 
					[+] else
						[ ] ReportStatus("verify Craete Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
[ ] 
[ ] 
[+] //############# Test 7-Verify 'X' (Cross) button functionality on 'Create Payee Renaming Rule' dialog..#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test4_FirstRenameCrossButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'X' (Cross) button functionality on 'Create Payee Renaming Rule' dialog.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test4_FirstRenameCrosslButton()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //click on X button
						[ ] CreatePayeeRenamingRule.Close()
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==FAIL)
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",PASS,"renaming rule was not created")
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",FAIL,"renaming rule was created")
							[ ] DeleteRenamingRule()
						[ ] 
					[+] else
						[ ] ReportStatus("verify Craete Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
[ ] 
[ ] 
[+] //############# Test 8-User checks 'Always create a renaming….' check box and clicks 'OK' button on 'Create Payee Renaming Rule' dialog..#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test5_AlwaysCreateOKButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Cancel button functionality on 'Create Payee Renaming Rule' dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test5_AlwaysCreateOKButton()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //check the 'always create ...' checkbox
						[ ] CreatePayeeRenamingRule.AlwaysCreateaRenamingRuleAndDontAskMeAgain.Check()
						[ ] //click on OK button
						[ ] CreatePayeeRenamingRule.OK.Click()
						[ ] 
						[ ] iResult=SelectPreferenceType(sPreferences)
						[+] if(iResult==PASS)
							[ ] ReportStatus("verify preferences was opened and Downloaded Transactions was selected",PASS,"Downlaoded transactions was selected from Preferences successfully")
							[ ] Preferences.SetActive()
							[+] if(!Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.IsChecked())
								[ ] ReportStatus("verify 'let me review/confirm ...' checkbox is unchecked",PASS," 'let me review/confirm ....' checkbox is unchecked")
								[ ] sleep(3)
								[ ] Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Check()
								[ ] 
							[+] else
								[ ] ReportStatus("verify 'let me review/confirm ...' checkbox is unchecked",FAIL," 'let me review/confirm ....' checkbox is checked")
							[ ] //close preferences
							[ ] Preferences.OK.Click()
						[+] else
							[ ] ReportStatus("verify preferences was opened and Downloaded Transactions was selected",FAIL,"Downlaoded transactions could not selected from Preferences")
						[ ] 
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==PASS)
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",PASS,"renaming rule was created")
							[ ] DeleteRenamingRule()
						[+] else
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",FAIL,"renaming rule was not created")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("verify Craete Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
[ ] 
[ ] 
[+] //#############Test 9-User checks 'Always create a renaming….' check box and clicks 'Cancel' button on 'Create Payee Renaming Rule' dialog.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test6_AlwaysCreateCancelButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Cancel button functionality on 'Create Payee Renaming Rule' dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test6_AlwaysCreateCancelButton()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //check the 'always create ...' checkbox
						[ ] CreatePayeeRenamingRule.AlwaysCreateaRenamingRuleAndDontAskMeAgain.Check()
						[ ] //click on Cancel button
						[ ] CreatePayeeRenamingRule.Cancel.Click()
						[ ] 
						[ ] iResult=SelectPreferenceType(sPreferences)
						[+] if(iResult==PASS)
							[ ] ReportStatus("verify preferences was opened and Downloaded Transactions was selected",PASS,"Downlaoded transactions was selected from Preferences successfully")
							[ ] Preferences.SetActive()
							[+] if(Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.IsChecked())
								[ ] ReportStatus("verify 'let me review/confirm ...' checkbox is checked",PASS," 'let me review/confirm ....' checkbox is checked")
							[+] else
								[ ] ReportStatus("verify 'let me review/confirm ...' checkbox is checked",FAIL," 'let me review/confirm ....' checkbox is unchecked")
								[ ] sleep(3)
								[ ] Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Check()
								[ ] 
							[ ] //close preferences
							[ ] Preferences.OK.Click()
						[+] else
							[ ] ReportStatus("verify preferences was opened and Downloaded Transactions was selected",FAIL,"Downlaoded transactions could not selected from Preferences")
						[ ] 
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==FAIL)
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",PASS,"renaming rule was not created")
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",FAIL,"renaming rule was created")
							[ ] DeleteRenamingRule()
						[ ] 
					[+] else
						[ ] ReportStatus("verify Craete Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
[ ] 
[ ] 
[+] //#############Test10-Verify 'Help' icon is working on 'Create Payee Renaming Rule' dialog.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test7_CreatePayeeRenameHelp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'Help' icon is working on 'Create Payee Renaming Rule' dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test7_CreatePayeeRenameHelp()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //click on help
						[ ] CreatePayeeRenamingRule.Help.Click()
						[ ] //Verify if Quicken Help window appeared
						[+] if (QuickenHelp.Exists(10))
							[ ] ReportStatus("Verify Quicken Help menu", PASS, "Help menu opened.")
							[ ] //Close Help Menu=========================================================================
							[ ] QuickenHelp.Close()
							[ ] WaitForState(QuickenHelp,FALSE,5)
						[+] else
							[ ] ReportStatus("Verify Quicken Help menu", PASS, "Help menu Did not open.")
							[ ] 
						[ ] 
						[ ] //click on Cancel button
						[ ] CreatePayeeRenamingRule.Cancel.Click()
						[ ] 
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==FAIL)
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",PASS,"renaming rule was not created")
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",FAIL,"renaming rule was created")
							[ ] DeleteRenamingRule()
						[ ] 
					[+] else
						[ ] ReportStatus("verify Craete Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
[ ] 
[ ] 
[+] //#############Test 3-Verify ''Create Payee Renaming Rule' dialog is as per SPEC#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test8_AlwaysCreateSPEC()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify ''Create Payee Renaming Rule' dialog is as per SPEC
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test8_AlwaysCreateSPEC()appstate none
	[ ] 
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] 
						[+] if(CreatePayeeRenamingRule.ReplaceItWithThisNameName.GetText()==lsPayee[2])
							[ ] ReportStatus("verify correct renaming name has been displayed",PASS,"correct renaming rule has been displayed")
						[+] else
							[ ] ReportStatus("verify correct renaming name has been displayed",FAIL,"correct renaming rule hasnt been displayed")
						[ ] 
						[ ] //open custom renaming rules
						[ ] CreatePayeeRenamingRule.EditCustomRule.Click()
						[ ] 
						[+] if(CreateCustomRenamingRule.Exists(5))
							[ ] ReportStatus("verify create custom renaming rule dialogue opens when clicked on edit custom renaming rules",PASS,"create custom renaming rule dialogue box opens")
							[ ] CreateCustomRenamingRule.Close()
						[+] else
							[ ] ReportStatus("verify create custom renaming rule dialogue opens when clicked on edit custom renaming rules",FAIL,"create custom renaming rule dialogue box doesnt open")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue doesnt exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] //#############Test12-Verify that  'Edit Renaming Rule' dialog is as per SPEC.#################################################
[ ] //############# Test15-Verify that 'Create New Rule' button functionality works in case of existing rule is a 'download rule'.#################################################
[+] //############# Test11-User Renames Payee When A Renaming Rule Exists.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test9_EditRename()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'Edit Renaming rule' dialogue and verify OK button functionality and Verify that 'Create New Rule' button functionality works in case of existing rule is a 'download rule'. and  Verify that  'Edit Renaming Rule' dialog is as per SPEC.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test9_EditRename()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //click on OK button
						[ ] CreatePayeeRenamingRule.OK.Click()
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==PASS)
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",PASS,"renaming rule was created")
							[ ] //find transaction
							[ ] iFind=FindTransaction("MDI",lsPayee[2])
							[+] if(iFind==PASS)
								[ ] ReportStatus("verify renamed payee was found in the register",PASS,"renamed payee was found")
								[ ] 
								[ ] //renaming the renamed payee
								[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
								[ ] MDIClient.TypeKeys(lsPayee[3])
								[ ] MDIClient.TypeKeys(KEY_ENTER)
								[ ] 
								[+] if(EditRenamingRule.Exists(5))
									[ ] ReportStatus("verify edit renaming rule window exists",PASS,"edit renaming rule exists")
									[ ] //check for specs of edit renaming rule dialogue
									[+] if(EditRenamingRule.CurrentRuleName.GetText()==lsPayee[2])
										[ ] ReportStatus("verify edit renaming box is according to specs",PASS,"current rule name shown properly")
									[+] else
										[ ] ReportStatus("verify edit renaming box is according to specs",PASS,"current rule not  name shown properly")
									[+] if(EditRenamingRule.NewRuleName.GetText()==lsPayee[3])
										[ ] ReportStatus("verify edit renaming box is according to specs",PASS,"new rule name shown properly")
									[+] else
										[ ] ReportStatus("verify edit renaming box is according to specs",PASS,"new rule not name shown properly")
									[ ] 
									[ ] //click on create new rule
									[ ] EditRenamingRule.CreateNewRule.Click()
									[ ] 
									[+] if(CreateCustomRenamingRule.Exists(5))
										[ ] ReportStatus("verify create custom renaming rule window exists upon create new rule click",PASS,"create custom renaming rule window exists")
										[ ] //click on OK button
										[ ] CreateCustomRenamingRule.OK.Click()
									[+] else
										[ ] ReportStatus("verify create custom renaming rule window exists upon create new rule click",FAIL,"create custom renaming rule window doesnt exist")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("verify edit renaming rule window exists",FAIL,"edit renaming rule doesnt exist")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("verify renamed payee was found in the register",FAIL,"renamed payee was not found")
							[ ] 
							[ ] //delete renaming rules
							[ ] DeleteRenamingRule()
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",FAIL,"renaming rule could not be created")
						[ ] 
					[+] else
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue doesnt exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //#############TTest16-Verify that 'Cancel' button functionality works in case of existing rule is a 'download rule'.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test10_EditRenameCancelButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Cancel' button functionality works in case of existing rule is a 'download rule'
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test10_EditRenameCancelButton()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //click on OK button
						[ ] CreatePayeeRenamingRule.OK.Click()
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==PASS)
							[ ] ReportStatus("verify if renaming rule was created ",PASS,"renaming rule was created")
							[ ] //find transaction
							[ ] iFind=FindTransaction("MDI",lsPayee[2])
							[+] if(iFind==PASS)
								[ ] ReportStatus("verify renamed payee was found in the register",PASS,"renamed payee was found")
								[ ] 
								[ ] //renaming the renamed payee
								[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
								[ ] MDIClient.TypeKeys(lsPayee[3])
								[ ] MDIClient.TypeKeys(KEY_ENTER)
								[ ] 
								[+] if(EditRenamingRule.Exists(5))
									[ ] ReportStatus("verify edit renaming rule window exists",PASS,"edit renaming rule exists")
									[ ] //click on cancel button
									[ ] EditRenamingRule.Cancel.Click()
									[ ] 
									[ ] //search for the Renaming Rule
									[ ] iPass=SearchRenamingRule(lsPayee[3])
									[+] if(iPass==FAIL)
										[ ] ReportStatus("verify if renaming rule was created upon clicking cancel button ",PASS,"renaming rule could not be created")
									[+] else
										[ ] ReportStatus("verify if renaming rule was created upon clicking cancel button",FAIL,"renaming rule was created")
								[+] else
									[ ] ReportStatus("verify edit renaming rule window exists",FAIL,"edit renaming rule doesnt exist")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("verify renamed payee was found in the register",FAIL,"renamed payee was not found")
							[ ] 
							[ ] //delete renaming rules
							[ ] DeleteRenamingRule()
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was created ",FAIL,"renaming rule could not be created")
						[ ] 
					[+] else
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue doesnt exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //#############Test17-Verify that 'X' (Cross) button functionality works in case of existing rule is a 'download rule'.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test11_EditRenameXButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'X' (Cross) button functionality works in case of existing rule is a 'download rule'.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test11_EditRenameXButton()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //click on OK button
						[ ] CreatePayeeRenamingRule.OK.Click()
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==PASS)
							[ ] ReportStatus("verify if renaming rule was created ",PASS,"renaming rule was created")
							[ ] //find transaction
							[ ] iFind=FindTransaction("MDI",lsPayee[2])
							[+] if(iFind==PASS)
								[ ] ReportStatus("verify renamed payee was found in the register",PASS,"renamed payee was found")
								[ ] 
								[ ] //renaming the renamed payee
								[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
								[ ] MDIClient.TypeKeys(lsPayee[3])
								[ ] MDIClient.TypeKeys(KEY_ENTER)
								[ ] 
								[+] if(EditRenamingRule.Exists(5))
									[ ] ReportStatus("verify edit renaming rule window exists",PASS,"edit renaming rule exists")
									[ ] //close edit renaming rule
									[ ] EditRenamingRule.Cancel.Click()
									[ ] 
									[ ] //search for the Renaming Rule
									[ ] iPass=SearchRenamingRule(lsPayee[3])
									[+] if(iPass==FAIL)
										[ ] ReportStatus("verify if renaming rule was created upon closing edit renaming rules ",PASS,"renaming rule could not be created")
									[+] else
										[ ] ReportStatus("verify if renaming rule was created upon closing edit renaming rules ",FAIL,"renaming rule was created")
								[+] else
									[ ] ReportStatus("verify edit renaming rule window exists",FAIL,"edit renaming rule doesnt exist")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("verify renamed payee was found in the register",FAIL,"renamed payee was not found")
							[ ] 
							[ ] //delete renaming rules
							[ ] DeleteRenamingRule()
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was created ",FAIL,"renaming rule could not be created")
						[ ] 
					[+] else
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue doesnt exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //#############Test33-Verify 'Preferences' for Renaming Rules.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test11_EditRenameXButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'Preferences' for Renaming Rules (i) Total 3 check boxes for 'During Transaction Download'  (ii). Total 3 check boxes for 'Your Renaming Rules'
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test12_Preferences()appstate none
	[+] //variable declarations
		[ ] 
		[ ] 
		[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //open preferences and go to Downloaded Transactions
		[ ] iResult=SelectPreferenceType(sPreferences)
		[ ] 
		[+] if(iResult==PASS)
			[ ] ReportStatus("verify preferences was opened and Downloaded Transactions was selected",PASS,"Downlaoded transactions was selected from Preferences")
			[ ] 
			[ ] Preferences.SetActive()
			[ ] 
			[ ] //uncheck "automatically categorize transactions" checkbox
			[ ] Preferences.AutomaticallyCategorizeTransactions.Uncheck()
			[+] if(!Preferences.AutomaticallyCategorizeTransactions.IsChecked())
				[ ] ReportStatus("verify is Automatically Categorize Transactions checkbox is unchecked",PASS,"Automatically Categorize Transactions checkbox is unchecked")
			[+] else
				[ ] ReportStatus("verify is Automatically Categorize Transactions checkbox is unchecked",FAIL,"Automatically Categorize Transactions checkbox is checked")
			[ ] 
			[ ] //check "automatically categorize transactions" checkbox
			[ ] Preferences.AutomaticallyCategorizeTransactions.Check()
			[+] if(Preferences.AutomaticallyCategorizeTransactions.IsChecked())
				[ ] ReportStatus("verify is Automatically Categorize Transactions checkbox is checked",PASS,"Automatically Categorize Transactions checkbox is checked")
			[+] else
				[ ] ReportStatus("verify is Automatically Categorize Transactions checkbox is checked",FAIL,"Automatically Categorize Transactions checkbox is unchecked")
			[ ] 
			[ ] //uncheck "Automatically Apply Quicken Suggested Name To Payee" checkbox
			[ ] Preferences.AutomaticallyApplyQuickenSuggestedNameToPayee.Uncheck()
			[+] if(!Preferences.AutomaticallyApplyQuickenSuggestedNameToPayee.IsChecked())
				[ ] ReportStatus("verify is Automatically Apply Quicken Suggested Name To Payee checkbox is unchecked",PASS,"Automatically Apply Quicken Suggested Name To Payee checkbox is unchecked")
			[+] else
				[ ] ReportStatus("verify is Automatically Apply Quicken Suggested Name To Payee checkbox is unchecked",FAIL,"Automatically Apply Quicken Suggested Name To Payee checkbox is checked")
			[ ] 
			[ ] //check "Automatically Apply Quicken Suggested Name To Payee" checkbox
			[ ] Preferences.AutomaticallyApplyQuickenSuggestedNameToPayee.Check()
			[+] if(Preferences.AutomaticallyApplyQuickenSuggestedNameToPayee.IsChecked())
				[ ] ReportStatus("verify is Automatically Apply Quicken Suggested Name To Payee checkbox is checked",PASS,"Automatically Apply Quicken Suggested Name To Payee checkbox is checked")
			[+] else
				[ ] ReportStatus("verify is Automatically Apply Quicken Suggested Name To Payee checkbox is checked",FAIL,"Automatically Apply Quicken Suggested Name To Payee checkbox is unchecked")
			[ ] 
			[ ] //uncheck "Capitalize First Letter Only In Downloaded Payee Names" checkbox
			[ ] Preferences.CapitalizeFirstLetterOnlyInDownloadedPayeeNames.Uncheck()
			[+] if(!Preferences.CapitalizeFirstLetterOnlyInDownloadedPayeeNames.IsChecked())
				[ ] ReportStatus("verify is Capitalize First Letter Only In Downloaded Payee Names checkbox is unchecked",PASS,"Capitalize First Letter Only In Downloaded Payee Names checkbox is unchecked")
			[+] else
				[ ] ReportStatus("verify is Capitalize First Letter Only In Downloaded Payee Names checkbox is unchecked",FAIL,"Capitalize First Letter Only In Downloaded Payee Names checkbox is checked")
			[ ] 
			[ ] //check "Capitalize First Letter Only In Downloaded Payee Names" checkbox
			[ ] Preferences.CapitalizeFirstLetterOnlyInDownloadedPayeeNames.Check()
			[+] if(Preferences.CapitalizeFirstLetterOnlyInDownloadedPayeeNames.IsChecked())
				[ ] ReportStatus("verify is Capitalize First Letter Only In Downloaded Payee Names checkbox is checked",PASS,"Capitalize First Letter Only In Downloaded Payee Names checkbox is checked")
			[+] else
				[ ] ReportStatus("verify is Capitalize First Letter Only In Downloaded Payee Names checkbox is checked",FAIL,"Capitalize First Letter Only In Downloaded Payee Names checkbox is unchecked")
			[ ] 
			[ ] //uncheck "Use My Existing Renaming Rules" checkbox
			[ ] Preferences.UseMyExistingRenamingRules.Uncheck()
			[+] if(!Preferences.UseMyExistingRenamingRules.IsChecked())
				[ ] ReportStatus("verify is Use My Existing Renaming Rules checkbox is unchecked",PASS,"Use My Existing Renaming Rules checkbox is unchecked")
			[+] else
				[ ] ReportStatus("verify is Use My Existing Renaming Rules checkbox is unchecked",FAIL,"Use My Existing Renaming Rules Names checkbox is checked")
			[ ] 
			[ ] //check "Use My Existing Renaming Rules" checkbox
			[ ] Preferences.UseMyExistingRenamingRules.Check()
			[+] if(Preferences.UseMyExistingRenamingRules.IsChecked())
				[ ] ReportStatus("verify isUse My Existing Renaming Rules checkbox is checked",PASS,"Use My Existing Renaming Rules checkbox is checked")
			[+] else
				[ ] ReportStatus("verify is Use My Existing Renaming Rules checkbox is checked",FAIL,"Use My Existing Renaming Rules checkbox is unchecked")
			[ ] 
			[ ] //uncheck "Automatically Create Rules When I Rename Payees" checkbox
			[ ] Preferences.AutomaticallyCreateRulesWhenIRenamePayees.Uncheck()
			[+] if(!Preferences.AutomaticallyCreateRulesWhenIRenamePayees.IsChecked())
				[ ] ReportStatus("verify is Automatically Create Rules When I Rename Payees checkbox is unchecked",PASS,"Automatically Create Rules When I Rename Payees checkbox is unchecked")
			[+] else
				[ ] ReportStatus("verify is Automatically Create Rules When I Rename Payees checkbox is unchecked",FAIL,"Automatically Create Rules When I Rename Payees checkbox is checked")
			[ ] 
			[ ] //check "Automatically Create Rules When I Rename Payees" checkbox
			[ ] Preferences.AutomaticallyCreateRulesWhenIRenamePayees.Check()
			[+] if(Preferences.AutomaticallyCreateRulesWhenIRenamePayees.IsChecked())
				[ ] ReportStatus("verify is Automatically Create Rules When I Rename Payees checkbox is checked",PASS,"Automatically Create Rules When I Rename Payees checkbox is checked")
			[+] else
				[ ] ReportStatus("verify is Automatically Create Rules When I Rename Payees checkbox is checked",FAIL,"Automatically Create Rules When I Rename Payees checkbox is unchecked")
			[ ] 
			[ ] //uncheck "Let Me Review Confirm The Automatically Created Rules" checkbox
			[ ] Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Uncheck()
			[+] if(!Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.IsChecked())
				[ ] ReportStatus("verify is Let Me Review Confirm The Automatically Created Rules checkbox is unchecked",PASS,"Let Me Review Confirm The Automatically Created Rules checkbox is unchecked")
			[+] else
				[ ] ReportStatus("verify is Let Me Review Confirm The Automatically Created Rules checkbox is unchecked",FAIL,"Let Me Review Confirm The Automatically Created Rules checkbox is checked")
			[ ] 
			[ ] //check "Let Me Review Confirm The Automatically Created Rules" checkbox
			[ ] Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Check()
			[+] if(Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.IsChecked())
				[ ] ReportStatus("verify is Let Me Review Confirm The Automatically Created Rules checkbox is checked",PASS,"Let Me Review Confirm The Automatically Created Rules checkbox is checked")
			[+] else
				[ ] ReportStatus("verify is Let Me Review Confirm The Automatically Created Rules checkbox is checked",FAIL,"Let Me Review Confirm The Automatically Created Rules checkbox is unchecked")
			[ ] 
			[ ] 
			[ ] //close preferences window
			[ ] Preferences.OK.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("verify preferences was opened and Downloaded Transactions was selected",FAIL,"Downlaoded transactions could not selected from Preferences")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //#############Test13-Verify that 'Update Rule' button functionality works in case of existing rule is a 'download rule'.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test13_EditRenameDownloadRule()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Update Rule' button functionality works in case of existing rule is a 'download rule'.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test13_EditRenameDownloadRule()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[2])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreatePayeeRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //click on OK button
						[ ] CreatePayeeRenamingRule.OK.Click()
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[2])
						[+] if(iPass==PASS)
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",PASS,"renaming rule was created")
							[ ] //find transaction
							[ ] iFind=FindTransaction("MDI",lsPayee[2])
							[+] if(iFind==PASS)
								[ ] ReportStatus("verify renamed payee was found in the register",PASS,"renamed payee was found")
								[ ] 
								[ ] //renaming the renamed payee
								[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
								[ ] MDIClient.TypeKeys(lsPayee[3])
								[ ] MDIClient.TypeKeys(KEY_ENTER)
								[ ] 
								[+] if(EditRenamingRule.Exists(5))
									[ ] ReportStatus("verify edit renaming rule window exists",PASS,"edit renaming rule exists")
									[ ] //click on Update rule button
									[ ] EditRenamingRule.UpdateRule.Click()
									[ ] 
									[ ] //find updated rule
									[ ] iFind=SearchRenamingRule(lsPayee[3])
									[ ] 
									[ ] 
									[+] if(iFind==PASS)
										[ ] ReportStatus("verify renaming rule is updated",PASS,"renaming rule is updated")
									[+] else
										[ ] ReportStatus("verify renaming rule is updated",FAIL,"renaming rule is updated")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("verify edit renaming rule window exists",FAIL,"edit renaming rule doesnt exist")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("verify renamed payee was found in the register",FAIL,"renamed payee was not found")
							[ ] 
							[ ] //delete renaming rules
							[ ] DeleteRenamingRule()
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",FAIL,"renaming rule could not be created")
						[ ] 
					[+] else
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue doesnt exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] //############# Test28-Verify if another rule exists for selected tokens and user clicks 'Ok' button.#################################################
[ ] //#############Test30-Verify 'Cancel' button functionality on 'Create Custom Renaming Rule' dialog.#################################################
[+] //#############Test32-Verify 'Help' icon is working on 'Create Custom Renaming Rule' dialog.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_CustomRenameHelp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'Help' icon is working on 'Create Custom Renaming Rule' dialog ,  if another rule exists for selected tokens and user clicks 'Ok' button is disabled and  'Cancel' button functionality on 'Create Custom Renaming Rule' dialog.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test14_CustomRenameHelp()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[4])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreateCustomRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists",PASS,"Create Renaming Rule dialogue exists")
						[ ] //click on help
						[ ] CreateCustomRenamingRule.Help.Click()
						[ ] //Verify if Quicken Help window appeared
						[+] if (QuickenHelp.Exists(10))
							[ ] ReportStatus("Verify Quicken Help menu", PASS, "Help menu opened.")
							[ ] //Close Help Menu=========================================================================
							[ ] QuickenHelp.Close()
							[ ] WaitForState(QuickenHelp,FALSE,5)
						[+] else
							[ ] ReportStatus("Verify Quicken Help menu", PASS, "Help menu Did not open.")
							[ ] 
						[ ] 
						[ ] 
						[+] do
							[ ] 
							[ ] //click on OK button
							[ ] CreateCustomRenamingRule.OK.Click()
							[ ] ReportStatus("verify create custom renaming rule dialogue box exists",FAIL,"create custom renaming rule dialogue box is closed")
						[+] except
							[ ] 
							[ ] ReportStatus("verify create custom renaming rule dialogue box exists ",PASS,"create custom renaming rule dialogue box is open")
							[ ] 
							[ ] //click on Cancel button
							[ ] CreateCustomRenamingRule.Cancel.Click()
							[ ] 
							[ ] //search for the Renaming Rule
							[ ] iPass=SearchRenamingRule(lsPayee[4])
							[+] if(iPass==FAIL)
								[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",PASS,"renaming rule was not created")
								[ ] 
							[+] else
								[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",FAIL,"renaming rule was created")
								[ ] 
						[ ] 
						[ ] DeleteRenamingRule()
						[ ] 
					[+] else
						[ ] ReportStatus("verify Craete Renaming Rule dialogue exists",FAIL,"Create Renaming Rule dialogue exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
[ ] 
[ ] 
[ ] //#############Test23-Verify that 'Create Custom Renaming Rule' dialog is as per SPEC.#################################################
[ ] //#############Test26-'Create Custom Renaming Rule' dialog, is launched from Quicken is trying to create a mint alias rule.#################################################
[+] //#############Test31-Verify 'X' (Cross) button functionality on 'Create Payee Renaming Rule' dialog.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_CustomRenameXButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'X' (Cross) button functionality on 'Create Payee Renaming Rule' dialog. and 'Create Custom Renaming Rule' dialog, is launched from Quicken is trying to create a mint alias rule.and Verify that 'Create Custom Renaming Rule' dialog is as per SPEC
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test15_CustomRenameXButton()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
		[ ] STRING sNames
		[ ] INTEGER j=1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[4])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreateCustomRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Renaming Rule dialogue exists while creating a mint alias rule",PASS,"Create Renaming Rule dialogue exists while creating a mint alias rule")
						[ ] 
						[ ] //verify specs for custom renaming rules
						[+] while(GetField(lsPayee[1]," ",j)!="")
							[ ] sNames=GetField(lsPayee[1]," ",j)
							[+] do
								[ ] 
								[ ] CreateCustomRenamingRule.BrowserWindow.TextClick(sNames)
								[ ] CreateCustomRenamingRule.BrowserWindow2.TextClick(sNames)
								[ ] ReportStatus("verify custom renaming rule window is as per SPEC",PASS,"custom renaming window is as per SPEC")
							[+] except
								[ ] ReportStatus("verify custom renaming rule window is as per SPEC",FAIL,"custom renaming window is not as per SPEC")
							[ ] ++j
						[ ] 
						[ ] //click on Close button
						[ ] CreateCustomRenamingRule.Close()
						[ ] 
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[4])
						[+] if(iPass==FAIL)
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",PASS,"renaming rule was not created")
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was not created upon Cancel button click ",FAIL,"renaming rule was created")
							[ ] 
						[ ] 
						[ ] DeleteRenamingRule()
						[ ] 
					[+] else
						[ ] ReportStatus("verify Craete Renaming Rule dialogue exists while creating a mint alias rule",FAIL,"Create Renaming Rule dialogue exists while creating a mint alias rule")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
[ ] 
[ ] 
[ ] //#############Test24-Verify user can select 'tokens' on 'Create Custom Renaming Rule' dialog.#################################################
[+] //#############Test18-Verify that 'Update Rule' button functionality works in case of existing rule is a 'mint rule'.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test16_EditRenameMintRule()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Update Rule' button functionality works in case of existing rule is a 'mint rule'. and Verify user can select 'tokens' on 'Create Custom Renaming Rule' dialog.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test16_EditRenameMintRule()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[4])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreateCustomRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Custom Renaming Rule dialogue exists",PASS,"CreateCustom Renaming Rule dialogue exists")
						[ ] //select a token from create rename window
						[ ] CreateCustomRenamingRule.BrowserWindow2.TextClick(lsPayee[2])
						[ ] 
						[ ] //click on OK button
						[ ] CreateCustomRenamingRule.OK.Click()
						[ ] 
						[+] if(!CreateCustomRenamingRule.Exists(5))
							[ ] ReportStatus("verify tokens can be selected",PASS,"Tokens were selected successfully")
						[+] else
							[ ] ReportStatus("verify tokens can be be selected",FAIL,"Tokens could not be selected")
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[4])
						[+] if(iPass==PASS)
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",PASS,"renaming rule was created")
							[ ] 
							[+] 
								[ ] // delete , import and select account 
								[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
								[ ] ImportWebConnectFile(sFileName)
								[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
							[ ] 
							[ ] //find transaction
							[ ] iFind=FindTransaction("MDI",lsPayee[4])
							[+] if(iFind==PASS)
								[ ] ReportStatus("verify renamed payee was found in the register",PASS,"renamed payee was found")
								[ ] 
								[ ] //renaming the renamed payee
								[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
								[ ] MDIClient.TypeKeys(lsPayee[3])
								[ ] MDIClient.TypeKeys(KEY_ENTER)
								[ ] 
								[+] if(EditRenamingRule.Exists(5))
									[ ] ReportStatus("verify edit renaming rule window exists",PASS,"edit renaming rule exists")
									[ ] //click on Update rule button
									[ ] EditRenamingRule.UpdateRule.Click()
									[ ] 
									[ ] //find updated rule
									[ ] iFind=SearchRenamingRule(lsPayee[3])
									[ ] 
									[ ] 
									[+] if(iFind==PASS)
										[ ] ReportStatus("verify renaming rule is updated",PASS,"renaming rule is updated")
									[+] else
										[ ] ReportStatus("verify renaming rule is updated",FAIL,"renaming rule is updated")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("verify edit renaming rule window exists",FAIL,"edit renaming rule doesnt exist")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("verify renamed payee was found in the register",FAIL,"renamed payee was not found")
							[ ] 
							[ ] //delete renaming rules
							[ ] DeleteRenamingRule()
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",FAIL,"renaming rule could not be created")
						[ ] 
					[+] else
						[ ] ReportStatus("verify Create Custom Renaming Rule dialogue exists",FAIL,"Create Custom Renaming Rule dialogue doesnt exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
		[ ] //delete all memorized payees
		[ ] DeletePayees()
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] //#############Test28-Verify if another rule exists for selected tokens and user clicks 'Ok' button..#################################################
[+] //#############Test20-Verify that 'Create New Rule' button functionality works in case of existing rule is a 'Mint rule'.#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	  Test17_EditRenameCreateNewMintRule()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Create New Rule' button functionality works in case of existing rule is a 'Mint rule'. and Verify if another rule exists for selected tokens and user clicks 'Ok' button.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  22, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test17_EditRenameCreateNewMintRule()appstate none
	[+] //variable declartions
		[ ] sFileName=sPath+sFileName1
	[ ] 
	[ ] //verify if quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //import a web connect file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Verify web connect file is imported",PASS,"web connect file was imported successfully")
			[ ] 
			[ ] //open account from accountbar
			[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify account was selected from account bar",PASS,"account was selected successfully")
				[ ] //read from  excel sheet
				[ ] lsExcelData=ReadExcelTable(sRenamingData, sRenamingWorksheet)
				[ ] //read the first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] //find payee in register
				[ ] iFind=FindTransaction("MDI",lsPayee[1])
				[+] if(iFind==PASS)
					[ ] ReportStatus("verify payee is found in register",PASS,"payee was  found in register")
					[ ] //renaming the payee
					[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
					[ ] MDIClient.TypeKeys(lsPayee[4])
					[ ] MDIClient.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(CreateCustomRenamingRule.Exists(5))
						[ ] ReportStatus("verify Create Custom Renaming Rule dialogue exists",PASS,"CreateCustom Renaming Rule dialogue exists")
						[ ] //select a token from create rename window
						[ ] CreateCustomRenamingRule.BrowserWindow2.TextClick(lsPayee[2])
						[ ] 
						[ ] //click on OK button
						[ ] CreateCustomRenamingRule.OK.Click()
						[ ] 
						[+] if(!CreateCustomRenamingRule.Exists(5))
							[ ] ReportStatus("verify tokens can be selected",PASS,"Tokens were selected successfully")
						[+] else
							[ ] ReportStatus("verify tokens can be be selected",FAIL,"Tokens could not be selected")
						[ ] //search for the Renaming Rule
						[ ] iPass=SearchRenamingRule(lsPayee[4])
						[+] if(iPass==PASS)
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",PASS,"renaming rule was created")
							[+] 
								[ ] //delete , import and select account 
								[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
								[ ] ImportWebConnectFile(sFileName)
								[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
							[ ] //find transaction
							[ ] iFind=FindTransaction("MDI",lsPayee[4])
							[+] if(iFind==PASS)
								[ ] ReportStatus("verify renamed payee was found in the register",PASS,"renamed payee was found")
								[ ] 
								[ ] //renaming the renamed payee
								[ ] MDIClient.TypeKeys(Replicate(KEY_TAB,2))
								[ ] MDIClient.TypeKeys(lsPayee[3])
								[ ] MDIClient.TypeKeys(KEY_ENTER)
								[ ] 
								[+] if(EditRenamingRule.Exists(5))
									[ ] ReportStatus("verify edit renaming rule window exists",PASS,"edit renaming rule exists")
									[ ] //click on create new rule
									[ ] EditRenamingRule.CreateNewRule.Click()
									[ ] 
									[+] if(CreateCustomRenamingRule.Exists(5))
										[ ] ReportStatus("verify create custom renaming rule window exists upon create new rule click",PASS,"create custom renaming rule window exists")
										[ ] 
										[ ] //select a token from create rename window
										[ ] CreateCustomRenamingRule.BrowserWindow2.TextClick(lsPayee[3])
										[ ] 
										[ ] //select a token from create rename window
										[ ] CreateCustomRenamingRule.BrowserWindow2.TextClick(lsPayee[2])
										[ ] 
										[ ] //click on ok
										[ ] CreateCustomRenamingRule.OK.Click()
										[ ] 
										[+] do
											[ ] //verify if a dialogue box has appeared
											[ ] CreateCustomRenamingRule.QWinChild.TextClick(lsPayee[2])
											[ ] CreateCustomRenamingRule.QWinChild.TextClick("update")
											[ ] ReportStatus("verify a dialogue box is popped after having 2 rules for the same name",PASS,"dialogue box is shown successfully")
										[+] except
											[ ] ReportStatus("verify a dialogue box is popped after having 2 rules for the same name",FAIL,"dialogue box is not shown ")
											[ ] CreateCustomRenamingRule.Close()
											[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("verify create custom renaming rule window exists upon create new rule click",FAIL,"create custom renaming rule window doesnt exist")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("verify edit renaming rule window exists",FAIL,"edit renaming rule doesnt exist")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("verify renamed payee was found in the register",FAIL,"renamed payee was not found")
							[ ] 
							[ ] //delete renaming rules
							[ ] DeleteRenamingRule()
							[ ] 
						[+] else
							[ ] ReportStatus("verify if renaming rule was created upon OK button click ",FAIL,"renaming rule could not be created")
						[ ] 
					[+] else
						[ ] ReportStatus("verify Create Custom Renaming Rule dialogue exists",FAIL,"Create Custom Renaming Rule dialogue doesnt exists")
				[+] else
					[ ] ReportStatus("verify payee is found in register",FAIL,"payee was not found in register")
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccountName)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify web connect file is imported",FAIL,"web connect file could not be imported")
		[ ] 
		[ ] 
		[ ] //delete all memorized payees
		[ ] DeletePayees()
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
