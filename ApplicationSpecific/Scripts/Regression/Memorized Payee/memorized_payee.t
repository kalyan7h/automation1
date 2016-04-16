[ ] 
[ ] 
[ ] 
[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<MemorizedPayeeList.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Memorized Payee List test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:Shrivardhan	
	[ ] //
	[ ] // Developed on: 		1/07/2014
	[ ] //			
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "C:\automation\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[+] // Variable Declaration
	[ ] LIST OF ANYTYPE lsExcelData,lsPayee,lsAddAccount
	[ ] STRING sFileName="MEMORIZEDPAYEE_Test"
	[ ] INTEGER iResult,iFlag=0,iSelect
	[ ] public STRING sMemorizedPayeeData = "MemorizedPayee"
	[ ] public STRING sPayeeNameWorksheet = "PayeeName",sPayeeAccountWorksheet="AccountName"
	[ ] STRING sHandle,sActual,sAccount,sCategory
	[ ] BOOLEAN bMatch
	[ ] 
[ ] 
[ ] 
[+] //############# Memorized Payee  list  SetUp #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test0_MemorizedPayeeSetUpSetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the  MemorizedPayeeList_Test.QDF if it exists. It will setup the necessary pre-requisite for MemorizedPayeeList_Test tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             June  25, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[ ] 
[+] testcase Test0_MemorizedPayeeSetUp()appstate none
	[+] //variable declaration
		[ ] STRING sAccountIntent="MemorizedPayee"
		[ ] INTEGER iAddAccount
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
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
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],sAccountIntent)
			[ ] 
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
			[+] else
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] 
		[ ] //Report Status if Quicken is not launched
		[+] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
[ ] 
[ ] 
[+] //############# Test-01 Verify the Opening Memorized Payee list from tools#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_MemorizedPayeeListfromTools()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the memorized payee list window can be opened from Menu bar 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test1_MemorizedPayeeListFromTools()appstate MemorizedPayeeBaseState
	[ ] 
	[ ] // Verify from menu
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] ReportStatus("Verify the MemorizedPayee list can be opened from Menu bar", PASS, "MemorizedPayee List Window opened through menu Tools > MemorizedPayee list")
			[ ] //closing memorized payee list
			[ ] MemorizedPayeeList.Close()
			[ ] // Verify Memorized Payee list is closed
			[+] if(!MemorizedPayeeList.Exists(5))
				[ ] ReportStatus("Verify the MemorizedPayee list can be closed from Menu bar", PASS, "MemorizedPayee List Window closed through menu Tools > MemorizedPayee list")
			[+] else
				[ ] ReportStatus("Verify the MemorizedPayee list can be closed from Menu bar", FAIL,"MemorizedPayee list could not be closed")
		[+] else
			[ ] ReportStatus("verify MemorizedPayee list can be opened", FAIL,"Verify the MemorizedPayee list can be opened from Menu bar")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-02 Verify the Opening Memorized Payee list from tools#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test2_MemorizedPayeeListShortCutKeys()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the memorized payee list window can be opened from shortcut keys
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test2_MemorizedPayeeListShortCutKeys()appstate MemorizedPayeeBaseState
	[ ] 
	[ ] // Verify from shortcut keys
	[ ] // verify quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //shortcut key to navigate to memorized payee list with <ctrl+t>
		[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] ReportStatus("Verify the MemorizedPayee list can be opened from Shortcut keys", PASS, "MemorizedPayee List Window opened through ctrl+t")
			[ ] //closing memorized payee list with <alt+f4>
			[ ] MemorizedPayeeList.Typekeys(KEY_ALT_F4)
			[ ] // Verify Memorized Payee list is closed
			[+] if(!MemorizedPayeeList.Exists(5))
				[ ] ReportStatus("Verify the MemorizedPayee list can be closed from Shortcut keys", PASS, "MemorizedPayee List Window opened through alt+f4")
			[+] else
				[ ] ReportStatus("verify MemorizedPayee list can e closed from shortcut keys", FAIL,"Verify the MemorizedPayee list can be closed from Shortcut keys")
		[+] else
			[ ] ReportStatus("verify memorizedPayee list can be opened from shortcut keys", FAIL,"Verify the MemorizedPayee list can be opened from Shortcut keys")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
		[ ] 
		[ ] 
[ ] 
[ ] //############# Test-10 Verify functionality create new payee button#################################################
[+] //############# Test-05 Verify the functionality of merge/rename button#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_RenamingandMerging()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify  the merge/rename button is functional and new payeee button is functional
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test3_RenamingAndMerging()appstate MemorizedPayeeBaseState
	[ ] 
	[+] // variable declarations
		[ ] STRING sRename,sMergeName,sAmount
		[ ] INTEGER i,j,iCount,iMerge=2
	[ ] // verify quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //selecting tools
		[ ] QuickenWindow.Tools.Click()
		[ ] //select memorized payee list from tools
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] //Verify if Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // get the handle of the listbox
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetHandle())
			[ ] //read from  excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] // Adding and verifying Payees
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] lsPayee=lsExcelData[i]
				[ ] // get 2nd column from the sheet
				[ ] sAmount=lsPayee[2]
				[ ] // Add Payees
				[ ] AddPayee(lsPayee[1],sAmount)
				[+] for(j=0;j<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();j++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(j))
					[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify if payee added",PASS,"Payee-{lsPayee[1]} added successfully")
						[ ] break
				[+] if(j==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
					[ ] ReportStatus("verify if payee added",FAIL,"Payee-{lsPayee[1]} not added successfully")
				[ ] 
			[ ] iCount = MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()
			[ ] // Verify if minimum 3 Payees are present
			[+] if(iCount==3)
				[ ] ReportStatus("Minimum 3 payees should be there",PASS,"3 payees added")
			[+] else
				[ ] ReportStatus("Minimum 3 payees should be there",FAIL,"3  payees not present")
				[ ] exit
				[ ] 
			[ ] // Get 2nd row from the given Sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] // Get 1st row , 3rd column from the sheet
			[ ] sRename=lsExcelData[1][3]
			[ ] // Get 2nd row , 3rd column from the sheet
			[ ] sMergeName=lsExcelData[2][3]
			[ ] 
			[ ] // Selecting 2 rows from the Payee List
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(iMerge)
			[ ] MemorizedPayeeList.Typekeys(KEY_SHIFT_DOWN)
			[ ] 
			[ ] // Merging 2 Payees
			[ ] MemorizedPayeeList.MergeRename.Click()
			[ ] //verify if merge and rename box exists
			[+] if(MemorizedPayeeList.MergeAndRenamePayees.Exists(5))
				[ ] ReportStatus("verify merge and rename box exists",PASS,"merge and rename box exists")
				[ ] MemorizedPayeeList.MergeAndRenamePayees.NewNameTextField.SetText(sMergeName)
				[ ] 
				[ ] MemorizedPayeeList.MergeAndRenamePayees.OK.Click()
				[ ] 
				[ ] MemorizedPayeeList.AddaRenamingRule.QuickenWillRenameTheDownloadedPayeeTextField.SetText(lsPayee[1])
				[ ] MemorizedPayeeList.AddaRenamingRule.OK.Click()
				[ ] // verify if the Add a Renaming Rule exists 
				[+] if(!MemorizedPayeeList.AddaRenamingRule.Exists(5))
					[ ] ReportStatus("verify payee present in another renaming rule",PASS,"Payee name is not present in another rule")
					[ ] 
					[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] bMatch=MatchStr("*{sMergeName}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] break
					[ ] // verify if merged successfully
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify merge name exists",PASS,"Merging successful")
					[+] else
						[ ] ReportStatus("verify mere name exists",FAIL,"Merging unsuccessful")
					[ ] 
				[+] else
					[ ] MemorizedPayeeList.AddaRenamingRule.SetActive()
					[ ] MemorizedPayeeList.AddaRenamingRule.Cancel.Click()
					[ ] ReportStatus("verify payee present in another rule",FAIL,"Payee name already present in another rule...could not merge")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("verify merge and rename box exists",FAIL,"merge and rename box could not be opened")
			[ ] 
			[ ] //read from excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] 
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
			[ ] 
			[ ] //seleting a payee
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
			[ ] 
			[ ] //Renaming a Payee
			[ ] MemorizedPayeeList.MergeRename.Click()
			[ ] //verify if merge and rename box exists
			[+] if(MemorizedPayeeList.MergeAndRenamePayees.Exists(5))
				[ ] ReportStatus("verify merge and rename box exists",PASS,"merge and rename box exists")
				[ ] 
				[ ] MemorizedPayeeList.MergeAndRenamePayees.NewNameTextField.SetText(sRename)
				[ ] 
				[ ] MemorizedPayeeList.MergeAndRenamePayees.OK.Click()
				[ ] 
				[ ] MemorizedPayeeList.AddaRenamingRule.QuickenWillRenameTheDownloadedPayeeTextField.SetText(lsPayee[1])
				[ ] MemorizedPayeeList.AddaRenamingRule.OK.Click()
				[ ] // verify if Renaming was successful
				[+] if(!MemorizedPayeeList.AddaRenamingRule.Exists(5))
					[ ] 
					[ ] ReportStatus("verify payee present in another rule",PASS,"Payee name is not present in another rule")
					[ ] 
					[ ] 
					[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] bMatch=MatchStr("*{sRename}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] break
					[ ] // verify if renamed successfully
					[-] if(bMatch==TRUE)
						[ ] ReportStatus("verify if renaming name exists",PASS,"Renaming successful")
					[-] else
						[ ] ReportStatus("verify if renaming name exists",FAIL,"Renaming unsuccessful")
					[ ] 
				[+] else
					[ ] MemorizedPayeeList.AddaRenamingRule.SetActive()
					[ ] MemorizedPayeeList.AddaRenamingRule.Cancel.Click()
					[ ] ReportStatus("verify payee present in another rule",FAIL,"Payee name already present in another rule...could not rename")
					[ ] 
			[+] else
				[ ] ReportStatus("verify merge and rename box exists",FAIL,"merge and rename box could not be opened")
			[ ] 
			[ ] DeletePayees()
			[ ] //deleting the renaming rules
			[ ] QuickenWindow.SetActive()
			[ ] //navigating to edit
			[ ] QuickenWindow.Edit.Click()
			[ ] QuickenWindow.Edit.Preferences.Select()
			[ ] //chosing downloaded transactions
			[ ] Preferences.SelectPreferenceType.ListBox.Select(13)
			[ ] //clicking on renaming rules
			[ ] Preferences.RenamingRules.Click()
			[ ] //deleting rules
			[ ] RenamingRules.ListBox.Select(1)
			[ ] RenamingRules.Click(1,410,140)
			[ ] Quicken2012.OK.Click()
			[ ] RenamingRules.ListBox.Select(1)
			[ ] RenamingRules.Click(1,410,140)
			[ ] Quicken2012.OK.Click()
			[ ] 
			[ ] RenamingRules.Done.Click()
			[ ] Preferences.OK.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("verify MemorizedPayee list can be opened", FAIL,"Verify the MemorizedPayee list can be opened from Menu bar")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test-07 Verify the options menu#################################################
[+] //############# Test-08 Verify the functionality of option button#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4_Options()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the option button is functional
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test4_Options()appstate MemorizedPayeeBaseState
	[+] //Variable declaration
		[ ] INTEGER i
		[ ] STRING sName,sAmount,sLock_Calendar="OBJ=0^^OBJ=1"
		[ ] BOOLEAN bLock=FALSE,bCalendar=TRUE,bMatch=FALSE
	[ ] //verify Quicken Window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] // click on tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list from tools
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] // Reading name,amount from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] sName=lsExcelData[1][1]
			[ ] sAmount=lsExcelData[1][2]
			[ ] // Adding payee
			[ ] AddPayee(sName,sAmount,bLock,bCalendar)
			[ ] 
			[ ] 
			[ ] //select options
			[ ] MemorizedPayeeList.Options.Click()
			[ ] // select Lock option
			[ ] MemorizedPayeeList.Typekeys(KEY_DN)
			[ ] 
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] //select options
			[ ] MemorizedPayeeList.Options.Click()
			[ ] // select show on calendar option
			[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
			[ ] 
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] 
			[ ] // verify if lock option is selected
			[+] do
				[ ] MemorizedPayeeList.TextClick("Lock")
				[ ] ReportStatus("verify lock column present",PASS,"lock option selected successfully")
			[+] except
				[ ] ReportStatus("verify lock column present",FAIL,"lock column not present")
			[ ] 
			[ ] 
			[ ] // verify show on calendar option is selected
			[+] do
				[ ] MemorizedPayeeList.TextClick("Calendar")
				[ ] ReportStatus("verify show on calendar column present",PASS,"Show on calendar option selected successfully")
			[+] except
				[ ] ReportStatus("verify show on calendar column present",FAIL,"show on calendar column not present")
			[ ] 
			[ ] 
			[ ] // select view locked items only
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] // get handle of the list box
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetHandle())
			[ ] //check if non lock payee is present
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{sName}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
			[ ] 
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("verify non locked present in view locked mode",PASS,"non locked payees not shown")
			[+] else
				[ ] ReportStatus("verify non locked present in view locked mode",FAIL,"non locked payeees shown")
			[ ] // return to base state
			[ ] // unselect view locked items only
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] // unselect show lock status
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_DN)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] // unselect show on calendar option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] DeletePayees()
			[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu", FAIL," MemorizedPayee list can be opened from Menu bar")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test-28 Verify the delete button for single payee#################################################
[+] //############# Test-29 Verify the delete button for multiple payees#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test5_DeletePayeeButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if single and multiple payees are deleted from delete button
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test5_DeletePayeeButton()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER i
		[ ] STRING sAmount
		[ ] iSelect=1
	[ ] 
	[ ] //verify Quicken Window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //click on tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list from tools
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] // Adding Payees
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] lsPayee=lsExcelData[i]
				[ ] // get 2nd column from the sheet
				[ ] sAmount=lsPayee[2]
				[ ] // Add Payees
				[ ] AddPayee(lsPayee[1],sAmount)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] 
			[ ] // get handle of the listbox
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
			[ ] 
			[ ] //selecting  a payee
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(iSelect)
			[ ] 
			[ ] //deleting payees
			[ ] MemorizedPayeeList.Delete.Click()
			[ ] MemorizedPayeeList.DeletePayeeConfirmation.OK.Click()
			[ ] //verifying if single payee is deleted
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("verify single payee is deleted",PASS,"single Payee {lsPayee[1]} is deleted")
				[+] else
					[ ] ReportStatus("verify single payee is deleted",FAIL,"single Payee{lsPayee[1]} not deleted successfully")
			[ ] 
			[ ] //selecting multiple payees
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(iSelect)
			[ ] MemorizedPayeeList.Typekeys(KEY_SHIFT_DOWN)
			[ ] 
			[ ] //deleting payees
			[ ] MemorizedPayeeList.Delete.Click()
			[ ] MemorizedPayeeList.DeletePayeeConfirmation.OK.Click()
			[ ] 
			[ ] // read secon row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] 
			[ ] 
			[ ] //verifying if payee is deleted
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("verify multiple payee is deleted",PASS," Payee {lsPayee[1]} is deleted")
				[+] else
					[ ] ReportStatus("verify multiple payee is deleted",FAIL," Payee{lsPayee[1]} not deleted successfully")
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] 
			[ ] 
			[ ] //verifying if  payee is deleted
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("verify multiple payee is deleted",PASS," Payee {lsPayee[1]} is deleted")
				[+] else
					[ ] ReportStatus("verify multiple payee is deleted",FAIL," Payee{lsPayee[1]} not deleted successfully")
			[ ] 
			[ ] 
			[ ] DeletePayees()
			[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL," MemorizedPayee list can be opened from Menu bar")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test-26 Verify the row delete button for single payee#################################################
[+] //############# Test-27 Verify the row delete button for multiple payees#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_DeletingFromRowButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if single and multiple payees are deleted from row delete button
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+]  testcase Test6_DeletingFromRowButton()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER i
		[ ] STRING sAmount
		[ ] iSelect=1
	[ ] 
	[ ] //verify Quicken Window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] // Adding Payees
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] lsPayee=lsExcelData[i]
				[ ] // get 2nd column from the sheet
				[ ] sAmount=lsPayee[2]
				[ ] // Add Payees
				[ ] AddPayee(lsPayee[1],sAmount)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] 
			[ ] // get handle of the listbox
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
			[ ] 
			[ ] //selecting  a payee
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(iSelect)
			[ ] 
			[ ] //deleting payees
			[ ] MemorizedPayeeList.TextClick("Delete")
			[ ] MemorizedPayeeList.DeletePayeeConfirmation.OK.Click()
			[ ] 
			[ ] //verifying if single payee is deleted
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("verify single payee is deleted",PASS,"single Payee {lsPayee[1]} is deleted")
				[+] else
					[ ] ReportStatus("verify single payee is deleted",FAIL,"single Payee{lsPayee[1]} not deleted successfully")
			[ ] 
			[ ] 
			[ ] //selecting multiple payees
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(iSelect)
			[ ] MemorizedPayeeList.Typekeys(KEY_SHIFT_DOWN)
			[ ] 
			[ ] //deleting payees
			[ ] MemorizedPayeeList.TextClick("Delete")
			[ ] MemorizedPayeeList.DeletePayeeConfirmation.OK.Click()
			[ ] 
			[ ] // read secon row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] 
			[ ] 
			[ ] //verifying if payee is deleted
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("verify multiple payee is deleted",PASS," Payee {lsPayee[1]} is deleted")
				[+] else
					[ ] ReportStatus("verify multiple payee is deleted",FAIL," Payee{lsPayee[1]} not deleted successfully")
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] 
			[ ] 
			[ ] //verifying if  payee is deleted
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("verify multiple payee is deleted",PASS," Payee {lsPayee[1]} is deleted")
				[+] else
					[ ] ReportStatus("verify multiple payee is deleted",FAIL," Payee{lsPayee[1]} not deleted successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL," MemorizedPayee list can be opened from Menu bar")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-14 Verify show on calendar functionality when checked#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_ShowOnCalendar()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the functionality of show on calendar when checked
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test7_ShowOnCalendar()appstate MemorizedPayeeBaseState
	[ ] //verify if quicken window existds
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // reading from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] // Add Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2],NULL,TRUE)
			[ ] 
			[ ] MemorizedPayeeList.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
			[ ] exit
		[ ] // verify if memorzied payeelist is closed
		[+] if(!MemorizedPayeeList.Exists(5))
			[ ] // navigating to calendar 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.Calendar.Select()
			[ ] // verify if calendar exists
			[+] if(Calendar.Exists(5))
				[ ] // verify if "show memorized payee list "already present
				[+] do
					[ ] Calendar.TextClick("Drag")
					[ ] 
				[-] except
					[ ] // checking "show memorized payee list"
					[ ] Calendar.Options.Click()
					[ ] Calendar.Options.Typekeys(Replicate(KEY_UP,3))
					[ ] Calendar.Options.Typekeys(KEY_ENTER)
					[ ] 
					[ ] 
				[ ] 
				[ ] //verify if payee can be found in calendar
				[+] do
					[ ] Calendar.TextClick(lsPayee[1])
					[ ] ReportStatus("verify payee present in calendar",PASS,"payee successfully shown in calendar when calendar option selected")
				[+] except
					[ ] ReportStatus("verify payee present in calendar", FAIL,"payee could not be found in calendar when calendar option selected")
				[ ] 
				[ ] // unchecking "show memorized payee list"
				[ ] Calendar.Options.Click()
				[ ] Calendar.Options.Typekeys(Replicate(KEY_UP,3))
				[ ] Calendar.Options.Typekeys(KEY_ENTER)
				[ ] // close Calendar
				[ ] Calendar.Close()
				[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be closed from menu bar", FAIL,"Verify the MemorizedPayee list can be closed")
		[ ] DeletePayees()
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
[ ] 
[+] //############# Test-15 Verify show on calendar functionality when unchecked#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_DontShowOnCalendar()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the functionality of show on calendar when unchecked
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test8_DontShowOnCalendar()appstate MemorizedPayeeBaseState
	[ ] //verify quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // reading from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] // Add Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] MemorizedPayeeList.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
			[ ] exit
		[ ] // verify if memorzied payeelist is closed
		[+] if(!MemorizedPayeeList.Exists(5))
			[ ] // navigating to calendar 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.Calendar.Select()
			[ ] // verify if calendar exists
			[+] if(Calendar.Exists(5))
				[ ] 
				[ ] // verify if "show memorized payee list "already present
				[+] do
					[ ] Calendar.TextClick("Drag")
					[ ] 
				[+] except
					[ ] // checking "show memorized payee list"
					[ ] Calendar.Options.Click()
					[ ] Calendar.Options.Typekeys(Replicate(KEY_UP,3))
					[ ] Calendar.Options.Typekeys(KEY_ENTER)
					[ ] 
					[ ] 
				[ ] 
				[ ] // verify if payee is present in calendar
				[+] do
					[ ] Calendar.TextClick(lsPayee[1])
					[ ] ReportStatus("verify payee not present in calendar",FAIL,"payee found in calendar")
				[+] except
					[ ] ReportStatus("verify payee not present in calendar", PASS,"payee not shown successfully in calendar")
				[ ] 
				[ ] // unchecking "show memorized payee list"
				[ ] Calendar.Options.Click()
				[ ] Calendar.Options.Typekeys(Replicate(KEY_UP,3))
				[ ] Calendar.Options.Typekeys(KEY_ENTER)
				[ ] // close Calendar
				[ ] Calendar.Close()
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be closed from menu bar", FAIL,"Verify the MemorizedPayee list can be closed")
			[ ] 
		[ ] DeletePayees()
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test-30 Verify the transactions are unaffected when memorized payee is deleted#################################################
[ ] //############# Test-13 Verify never auto categorize functionality#################################################
[+] //############# Test-12 Verify Marked as clear functionality#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_MarkedAsClear()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the functionality marked as clear functionality , never auto categorize functionality and transaction containing payee are unaffected when memorized payees are deleted
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test9_MarkedAsClear()appstate MemorizedPayeeBaseState
	[+] // variable declaration
		[ ] INTEGER i
		[ ] 
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] // readsing from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] sCategory=lsPayee[4]
			[ ] 
			[ ] // Adding Payees with never categorize=true,lock=true
			[ ] AddPayee(lsPayee[1],lsPayee[2],TRUE,NULL,TRUE)
			[ ] //closing memorized payee list
			[ ] MemorizedPayeeList.Done.Click()
			[+] if(MemorizedPayeeList.Exists(5))
				[ ] ReportStatus("verify memorized payee list is closed",FAIL,"memorized payee list is still open")
			[+] else
				[ ] ReportStatus("verify memorized payee list is closed",PASS,"memorized payee list is closed")
			[ ] QuickenWindow.SetActive()
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeAccountWorksheet)
			[ ] lsAddAccount=lsExcelData[1]
			[ ] sAccount=lsAddAccount[2]
			[ ] 
			[ ] //open transaction register
			[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] // selecting a new payee
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(Replicate(KEY_TAB,2))
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(lsPayee[1])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] iFlag=FindTransaction("MDI",sCategory,ACCOUNT_BANKING)
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify transaction not auto categorized",PASS,"transaction not automatically categorized successfully")
				[+] else
					[ ] ReportStatus("verify transaction not auto categorized",FAIL,"transaction automatically catgorized")
				[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Tools.click()
				[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
				[ ] //delete the payee
				[ ] MemorizedPayeeList.Delete.Click()
				[ ] MemorizedPayeeList.DeletePayeeConfirmation.OK.Click()
				[ ] MemorizedPayeeList.Done.Click()
				[ ] 
				[ ] iFlag=FindTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify transaction presence after memorized payee deletion",PASS,"transaction present after payee  deleted from memorized payee list successful")
				[+] else
					[ ] ReportStatus("verify transaction presence after memorized payee deletion",FAIL,"transaction present after payee deleted from memorized payee list unsuccessful")
				[ ] 
				[ ] 
				[ ] //using quicken find
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_ENTER)
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_F)
				[ ] 
				[ ] //selecting find field in qiuckenFind)
				[ ] QuickenFind.TypeKeys(Replicate(KEY_TAB,6))
				[ ] //selecting cleared status in find field
				[ ] QuickenFind.TypeKeys(Replicate(KEY_DN,4))
				[ ] //selecting " marked as cleared " 
				[ ] QuickenFind.TypeKeys(Replicate(KEY_TAB,2))
				[ ] 
				[ ] QuickenFind.TypeKeys(KEY_DN)
				[ ] //clicking on find button
				[ ] QuickenFind.Find.Click()
				[ ] //checking for a popup "no such transaction"
				[+] do
					[ ] QuickenFind.SetActive()
					[ ] QuickenFind.Close.Click()
					[ ] ReportStatus("verify marked as clear present",PASS,"marked as clear automatically shown successful")
					[ ] 
				[+] except
					[ ] ReportStatus("verify marked as clear present",FAIL,"marked as clear automatically shown unsuccessful")
					[ ] Quicken2012.OK.Click()
					[ ] QuickenFind.Close.Click()
				[ ] 
				[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
			[+] else
				[ ] ReportStatus("verify account register can be open",FAIL,"acount transactions could not be selected")
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-25 Verify Edit button functionality for single payee#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_Edit()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the functionality of edit button
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test10_Edit()appstate MemorizedPayeeBaseState
	[+] // variable declaration
		[ ] STRING sName="Test Payee",sAmount="100" // name and amount given
		[ ] INTEGER i
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] //read from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] 
			[ ] // Adding Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] 
			[ ] //get the handle of the list box
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
			[ ] //select the row of the payee
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
			[ ] 
			[ ] //selecting  a payee
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
			[ ] //seleting edit button
			[ ] MemorizedPayeeList.TextClick("Edit")
			[ ] //new Amount
			[ ] sAmount=str(val(lsPayee[2])+100)
			[ ] //setting new amount
			[ ] CreateMemorizedPayee.AmountTextField.SetText(sAmount)
			[ ] CreateMemorizedPayee.OKButton.Click()
			[ ] //checking for new amount in the payee
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
			[ ] bMatch=MatchStr("*{sAmount}*",sActual)
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify edit  ",PASS,"edit successful")
			[+] else
				[ ] ReportStatus("verify edit ",FAIL,"edit unsuccessful")
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-17 Verify overwriting of unclocked transactions#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_Overwrite()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verifyunlocked payees are overwrittable
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test11_Overwrite()appstate MemorizedPayeeBaseState
	[+] //variable declration
		[ ] INTEGER i
		[ ] STRING sAmount
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] //read from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] 
			[ ] // Adding Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] //get the handle of the list box
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
			[ ] //verify payee added
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
			[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify payee added",FAIL,"single Payee-{lsPayee[1]} not added successfully")
			[+] else
				[ ] ReportStatus("verify payee added",PASS,"single Payee-{lsPayee[1]} added successfully")
			[ ] 
			[ ] // new Amount
			[ ] sAmount=str(val(lsPayee[2])+100)
			[ ] //overwriting Payee
			[ ] AddPayee(lsPayee[1],sAmount)
			[ ] 
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
			[ ] bMatch=MatchStr("*{sAmount}*",sActual)
			[+] if(bMatch==TRUE)
				[ ] ReportStatus(" verify payee overwritten",PASS,"overwrite successfu for payee-{lsPayee[1]}l")
			[+] else
				[ ] ReportStatus("verify payee overwritten ",FAIL,"overwrite unsuccessful for payee-{lsPayee[1]}")
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-19 Verify Autofill functionality#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_AutoFill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the autofill functionality when transactions use memorized payees
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test12_AutoFill()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER iFlag
		[ ] STRING sMemo,sTag
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // readsing from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] 
			[ ] // read second row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] 
			[ ] // Adding Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] 
			[ ] // Adding Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] sMemo=lsPayee[5]
			[ ] sTag=lsPayee[6]
			[ ] sCategory=lsPayee[4]
			[ ] // Adding Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2],TRUE,NULL,NULL,sMemo,sTag)
			[ ] 
			[ ] 
			[ ] //closing memorizedpayee list
			[ ] MemorizedPayeeList.Done.Click()
			[ ] QuickenWindow.SetActive()
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeAccountWorksheet)
			[ ] lsAddAccount=lsExcelData[1]
			[ ] sAccount=lsAddAccount[2]
			[ ] 
			[ ] //open transaction register
			[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] //adding transaction using memorized payee
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(Replicate(KEY_TAB,2))
				[ ] 
				[ ] MDIClient.AccountRegister.TxList.Typekeys(lsPayee[1])
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_ENTER)
				[ ] //verifying payee details
				[ ] //verifying payee name
				[ ] iFlag=FindTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify name auto filled",PASS,"name auto fill succesful")
				[+] else
					[ ] ReportStatus("verify name auto filled",FAIL,"name auto fill unsuccessful")
				[ ] // verifying payee amount
				[ ] iFlag=FindTransaction("MDI",lsPayee[2],ACCOUNT_BANKING)
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify amount auto filled",PASS,"amount auto fill successful")
				[+] else
					[ ] ReportStatus("verify amount auto filled",FAIL,"amount auto fill unsuccessful")
				[ ] // verifying payee category
				[ ] iFlag=FindTransaction("MDI",sCategory,ACCOUNT_BANKING)
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify categoy auto filled",PASS,"category autofill successful")
				[+] else
					[ ] ReportStatus("verify category auto filled",FAIL,"category auto fill unsuccessful")
				[ ] //verifying payee memo
				[ ] iFlag=FindTransaction("MDI",sMemo,ACCOUNT_BANKING)
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify memo auto filled",PASS,"memo auto fill succssful")
				[+] else
					[ ] ReportStatus("verify memo auto filled",FAIL,"memo auto fill unsuccessful")
				[ ] //verifying payee tag
				[ ] iFlag=FindTransaction("MDI",sTag,ACCOUNT_BANKING)
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify tag auto filled",PASS,"tag auto fill successful")
				[+] else
					[ ] ReportStatus("verify tag auto filled",FAIL,"tag auto fill unsuccessful")
				[ ] 
				[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
			[+] else
				[ ] ReportStatus("verify account register opened",FAIL,"account register could not be opened")
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test-22 Verify entries for same Payee with different cateogries#################################################
[+] //############# Test-23 Verify existence of never auto categorize box for same payee with different catgories#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_PayeesWithSameName()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify different entries for same payees with differenct categories and verify that there is only 1 never auto categorize check box for the payee
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test13_PayeesWithSameName()appstate MemorizedPayeeBaseState
	[ ] 
	[+] //variable declarations
		[ ] INTEGER iPayeeCount
		[ ] STRING sMatch="OBJ=0"
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] //count number of payees already present
			[ ] iPayeeCount=MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()
			[ ] 
			[ ] //read from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] // both payees are of same name and amount and not locked
			[ ] // Adding Payees 
			[ ] AddPayee(lsPayee[1],lsPayee[2],NULL,NULL,NULL,NULL,NULL,2)
			[ ] 
			[ ] // Adding Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2],NULL,NULL,NULL,NULL,NULL,3)
			[ ] 
			[ ] // checking if both the payees are added
			[+] if(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()==(iPayeeCount+2))
				[ ] ReportStatus("verify new payees with same named added",PASS,"payees with same name and different categories added successfully")
			[+] else
				[ ] ReportStatus("verify new payees with same named added",FAIL,"payees with same name and different categories added unsuccessfully")
				[ ] 
			[ ]  
			[ ] //checking for check for of never categorize in second payee
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(1,200,30)
			[ ] 
			[ ] //get handle of the listbox
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
			[ ] 
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(1))
			[ ] //checking if never categorize was checked
			[ ] bMatch=MatchStr("{sMatch}*",sActual)
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify only 1 check box for multiple payees with same name",PASS,"only 1 never categorize checkbox for payees with same name")
			[+] else
				[ ] ReportStatus("verify only 1 check box for multiple payees with same name",FAIL,"more than 1 never categorize button for payees with same name")
			[ ] 
			[ ] DeletePayees()
			[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
[ ] 
[+] //############# Test-18 Verify Lock and leave payee unchanged when it is edited in register functionality#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_LockPayee()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the Lock and leave paye unchanged when it is edited in register functionality
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test14_LockPayee()appstate MemorizedPayeeBaseState
	[+] //variable declarations
		[ ] INTEGER i
		[ ] STRING sNewAmount
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] // readsing from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] 
			[ ] // Adding Payees with Lock=True
			[ ] AddPayee(lsPayee[1],lsPayee[2],TRUE)
			[ ] sNewAmount=str(val(lsPayee[2])+100)
			[ ] //close Memorized payee list
			[ ] MemorizedPayeeList.Done.Click()
			[ ] QuickenWindow.SetActive()
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeAccountWorksheet)
			[ ] lsAddAccount=lsExcelData[1]
			[ ] sAccount=lsAddAccount[2]
			[ ] 
			[ ] //open transaction register
			[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
			[+] if(iSelect==PASS)
				[ ] //adding new transaction from memorized payee
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(Replicate(KEY_TAB,2))
				[ ] 
				[ ] //adding payee
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(lsPayee[1])
				[ ] //adding new amount
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(Replicate(KEY_TAB,4))
				[ ] 
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(sNewAmount)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // navigating to memorized payee list
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
				[ ] 
				[ ] //get handle of the listbox
				[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
				[ ] // verifying if the payee is changed in memorized payee list
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(0))
				[ ] //checking if new amount is edited in memorized payee list
				[ ] bMatch=MatchStr("*{lsPayee[1]}*{sNewAmount}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("verify memorized payee not changed when transaction is edited",PASS,"memorized payee not changed when locked")
				[+] else
					[ ] ReportStatus("verify memorized payee not changed when transaction is edited",FAIL,"memorized payee changed when locked ")
					[ ] 
				[ ] 
				[ ] MemorizedPayeeList.Done.Click()
				[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
				[ ] 
			[+] else
				[ ] ReportStatus("verify account register can be opened",FAIL,"account register could not be opened")
			[ ] DeletePayees()
			[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
[ ] 
[ ] 
[ ] //############# Test-46 Verify the delete functionality from context menu for single payee#################################################
[ ] //############# Test-34 Verify never auto categorize from context menu for single payee#################################################
[ ] //############# Test-35 Verify Lock from context menu for single payee#################################################
[+] //############# Test-32 Verify context menu for single payee#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_ContextMenuSinglePayee()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the context menu for a single payee,never auto categorize functionlity , lock functionlity and delete functionality from context menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test15_ContextMenuSinglePayee()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER i
		[ ] STRING sMatch1="OBJ=1^^OBJ=1^^OBJ=0" , sMatch2="OBJ=0^^OBJ=0^^OBJ=1"
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccount=lsAddAccount[2]
		[ ] 
		[ ] //open transaction register
		[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
		[+] if (iSelect==PASS)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] //click on Tools
			[ ] QuickenWindow.Tools.click()
			[ ] //select memorized payee list in tools menu
			[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
			[ ] // verify Memorized Payee list exists
			[+] if(MemorizedPayeeList.Exists(5))
				[ ] 
				[ ] // read from excel sheet
				[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
				[ ] 
				[ ] 
				[ ] // read third row of excel sheet
				[ ] lsPayee=lsExcelData[3]
				[ ] // adding payee
				[ ] AddPayee(lsPayee[1],lsPayee[2])
				[ ] 
				[ ] 
				[ ] // read first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] // adding payee
				[ ] AddPayee(lsPayee[1],lsPayee[2])
				[ ] 
				[ ] 
				[ ] // read second row of excel sheet
				[ ] lsPayee=lsExcelData[2]
				[ ] // adding payee
				[ ] AddPayee(lsPayee[1],lsPayee[2])
				[ ] 
				[ ] 
				[ ] MemorizedPayeeList.SetActive()
				[ ] 
				[+] // selecting options
					[ ] MemorizedPayeeList.Options.Click()
					[ ] // select Lock option
					[ ] MemorizedPayeeList.Typekeys(KEY_DN)
					[ ] 
					[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
					[ ] //select options
					[ ] MemorizedPayeeList.Options.Click()
					[ ] // select show on calendar option
					[ ] MemorizedPayeeList.Typekeys(KEY_DN)
					[ ] MemorizedPayeeList.Typekeys(KEY_DN)
					[ ] 
					[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] 
				[ ] 
				[ ] // selecting edit option from context menu
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_DN)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] // verifying if edit payee window exists
				[+] if(CreateMemorizedPayee.Exists(5))
					[ ] ReportStatus("verify edit option selected from context menu",PASS,"edit payee selected successfully")
					[ ] //closing edit payee box
					[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] else
					[ ] ReportStatus("verify edit option selected from context menu",FAIL,"edit Payee not selected")
					[ ] 
				[ ] 
				[ ] // selecting report from conext menu
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_UP)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] //verifying report window exists
				[+] if(PayeeReport.Exists(5))
					[ ] ReportStatus("verify report option selected from context menu",PASS,"Report selected successfully")
					[ ] //closing report window
					[ ] PayeeReport.Close()
				[+] else
					[ ] ReportStatus("verify report option selected from context menu",FAIL,"Report not selected successfully")
				[ ] //selecting new payee option from context menu
				[ ] MemorizedPayeeList.SetActive()
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_UP)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_UP)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] //verifying if new payee window exists
				[+] if(CreateMemorizedPayee.Exists(5))
					[ ] ReportStatus("verify new payee option selected from context menu",PASS,"new payee selected successfully")
					[ ] //closing new payee window
					[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] else
					[ ] ReportStatus("verify new payee option selected from context menu",FAIL,"new Payee not selected ")
					[ ] 
				[ ] 
				[ ] //seleting use option from context menu
				[ ]  MemorizedPayeeList.SetActive()
				[ ]  MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
				[ ]  MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ]  MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_DN,3))
				[ ]  MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] 
				[ ] MDIClient.AccountRegister.TxList.Typekeys(KEY_ENTER)
				[ ] //Finding transaction
				[ ] iFlag=FindTransaction("MDI",lsPayee[1])
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify use option from context menu",PASS,"use selected successfully")
				[+] else
					[ ] ReportStatus("verify use option from context menu",FAIL,"use not selected successfully")
				[ ] 
				[ ] 
				[ ] // navigate to memrorize payee list
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
				[ ] 
				[ ] // selecting lock , show on calendar and never categorize 
				[ ] 
				[ ] //select lock option from context menu
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_DN,4))
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] 
				[ ] // select show on calendar option from context menu
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_UP,3))
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_UP,3))
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] 
				[ ] 
				[ ] 
				[ ] // select never auto cateogirze option from context menu
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_UP,4))
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] 
				[ ] 
				[ ] // get handle of the listbox
				[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
				[ ] 
				[ ] // verify if lock, show on calendar , never categorize are selected
				[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bMatch=MatchStr("*{sMatch1}*{lsPayee[1]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify lock,show on calendar and never auto categorize selected from context menu",PASS,"Lock , show on calendar and never auto categorize selected successfully")
						[ ] //unselecting lock , show on calendar and never categorize
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_DN,4))
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
						[ ] 
						[ ] 
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_UP,3))
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
						[ ] 
						[ ] 
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_UP,4))
						[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
						[ ] break
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("verify lock,show on calnedar and never auto categorize selected from context menu",FAIL,"Lock, show on calendar and never auto categorize could not be selected ")
				[ ] //verifying lock, show on calendar , nver categorize are unselected
				[+] else
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bMatch=MatchStr("*{sMatch2}*{lsPayee[1]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify lock,show on calendar and never categorize unselected from context menu",PASS,"Lock , show on calendar and never auto categorize unselected successfully")
					[+] else
						[ ] ReportStatus("verify lock,show on calendar and never categorizer unseleted from context menu",FAIL,"Lock , show on calendar and never auto categorize unselected unsuccessfully")
					[ ] 
				[ ] 
				[ ] // unselecting options
				[ ] MemorizedPayeeList.SetActive()
				[ ] MemorizedPayeeList.Options.Click()
				[ ] // unselect Lock option
				[ ] MemorizedPayeeList.Typekeys(KEY_DN)
				[ ] 
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] //select options
				[ ] MemorizedPayeeList.Options.Click()
				[ ] // unselect show on calendar option
				[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] 
				[ ] // verifying delete option from context menu
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_DN,2))
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] // verifying delete confirmation box
				[+] if(MemorizedPayeeList.DeletePayeeConfirmation.Exists(5))
					[ ] ReportStatus("verify delete option from context menu",PASS,"delete payee selected successfully")
					[ ] // delete payee
					[ ] MemorizedPayeeList.DeletePayeeConfirmation.OK.Click()
				[+] else
					[ ] ReportStatus("verify delete option from context menu",FAIL,"delete Payee not seletected successfully")
					[ ] 
				[ ] // verify if payee is deleted
				[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("verify payee is deleted using delete option from context menu",PASS,"payee deleted successfully")
				[+] else
					[ ] ReportStatus("verify payee is deleted using delete option from context menu",FAIL,"payee not deleted successfully")
				[ ] DeletePayees()
			[+] else
				[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
			[ ] 
			[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
		[+] else
			[ ] ReportStatus("verify account register can be opened",FAIL,"transaction register could not be opened")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test-47 Verify the delete functionality from context menu for multiple payee#################################################
[ ] //############# Test-39 Verify Lock from context menu for multiple payee#################################################
[+] //############# Test-33 Verify context menu for multiple payee#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_ContextMenuMultiplePayee()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the context menu for a multiple payee, lock functionlity and delete functionality from context menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test16_ContextMenuMultiplePayees()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER i
		[ ] STRING sMatch1="OBJ=1^^OBJ=1^^OBJ=0" , sMatch2="OBJ=0^^OBJ=0^^OBJ=1"
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // read from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] // read second row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] 
			[ ] MemorizedPayeeList.SetActive()
			[ ] 
			[ ] 
			[+] // selecting options
				[ ] MemorizedPayeeList.Options.Click()
				[ ] // select Lock option
				[ ] MemorizedPayeeList.Typekeys(KEY_DN)
				[ ] 
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] //select options
				[ ] MemorizedPayeeList.Options.Click()
				[ ] // select show on calendar option
				[ ] MemorizedPayeeList.Typekeys(KEY_DN)
				[ ] MemorizedPayeeList.Typekeys(KEY_DN)
				[ ] 
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] // seleting lock , show on calendar and never categorize
			[ ] // selecting lock option from context menu
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(1)
			[ ] //selecting multiple payees
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_SHIFT_DOWN)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_SHIFT_DOWN)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_DN)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_DN)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] 
			[ ] // selecting show on calendar from context menu
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] 
			[ ] // selecting never auto categorize from context menu
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] 
			[ ] // get handle of the listbox
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
			[ ] 
			[ ] // verifying if lock, show on calendar , never categorize was selected for all payees
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{sMatch1}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("verify lock,show on calendar and never auto categorize selected from context mneu",PASS,"Lock , show on calendar and never auto categorize selected successfully")
				[+] else
					[ ] ReportStatus("verify lock,show on calendar and never auto catgorize selected from context menu",FAIL,"Lock, show on calendar and never auto categorize could not be selected ")
			[ ] 
			[ ] // unselecting lock , show on calendar and never categorize
			[ ] 
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_DN,2))
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] 
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] 
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_UP,2))
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] 
			[ ] // verifying if lock , how on calendar and never categorize was unselected for all payees
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{sMatch2}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("verify lock , show on calendar and never auto categorize unselected from context menu",PASS,"Lock , show on calendar and never auto categorize unselected successfully")
				[+] else
					[ ] ReportStatus("verify lock , show on calendar and never auto categorize unselected from context menu",FAIL,"Lock , show on calendar and never auto categorize unselected unsuccessfully")
				[ ] 
			[ ] 
			[ ] // selecting delete option from context menu
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_DN)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] //deleting all payees
			[+] if(MemorizedPayeeList.DeletePayeeConfirmation.Exists(5))
				[ ] ReportStatus("verify delete option from context menu",PASS,"delete payee selected successfully")
				[ ] MemorizedPayeeList.DeletePayeeConfirmation.OK.Click()
			[+] else
				[ ] ReportStatus("verify delete option from context menu",FAIL,"delete Payee not seletected successfully")
				[ ] 
			[ ] 
			[ ] 
			[ ] //unselecting options
			[ ] MemorizedPayeeList.SetActive()
			[ ] MemorizedPayeeList.Options.Click()
			[ ] // unselect Lock option
			[ ] MemorizedPayeeList.Typekeys(KEY_DN)
			[ ] 
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] //select options
			[ ] MemorizedPayeeList.Options.Click()
			[ ] //un select show on calendar option
			[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] bMatch=FALSE
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] 
			[ ] 
			[ ] // verify if payee is deleted
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
			[ ] 
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("verify multiple payees is deleted using delete option from context menu",PASS,"payee deleted successfully")
			[+] else
				[ ] ReportStatus("verify multiple payees is deleted using delete option from context menu",FAIL,"payee not deleted successfully")
			[ ] 
			[ ] // read second row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] 
			[ ] // verify if payee is deleted
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
			[ ] 
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("verify multiple payees is deleted using delete option from context menu",PASS,"payee deleted successfully")
			[+] else
				[ ] ReportStatus("verify multiple payees is deleted using delete option from context menu",FAIL,"payee not deleted successfully")
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] 
			[ ] // verify if payee is deleted
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
			[ ] 
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("verify multiple payees is deleted using delete option from context menu",PASS,"payee deleted successfully")
			[+] else
				[ ] ReportStatus("verify mutltiple payees is deleted using delete option from context menu",FAIL,"payee not deleted successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test-40 Verify functionality of never auto categorize from context menu for single payee#################################################
[+] //############# Test-43 Verify use option fucntionality when never auto categorize is true for single payee#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_UseCategoryTrue()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify functionality of use option when never auto categorize is true from context menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test17_UseCategoryTrue()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] LIST OF STRING lsPayeeDetails
		[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccount=lsAddAccount[2]
		[ ] 
		[ ] //open transaction register
		[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
		[ ] 
		[+] if(iSelect==PASS)
			[ ] //navigate to memorzied payee list
			[ ] QuickenWindow.SetActive()
			[ ] //click on Tools
			[ ] QuickenWindow.Tools.click()
			[ ] //select memorized payee list in tools menu
			[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
			[ ] // verify Memorized Payee list exists
			[+] if(MemorizedPayeeList.Exists(5))
				[ ] 
				[ ] // read from excel sheet
				[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
				[ ] 
				[ ] // read first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] sCategory=lsPayee[4]
				[ ] //adding payee
				[ ] AddPayee(lsPayee[1],lsPayee[2])
				[ ] 
				[ ] // read third row of excel sheet
				[ ] lsPayee=lsExcelData[3]
				[ ] 
				[ ] //adding payee
				[ ] AddPayee(lsPayee[1],lsPayee[2])
				[ ] 
				[ ] 
				[ ] // read second row of excel sheet
				[ ] lsPayee=lsExcelData[2]
				[ ] 
				[ ] //adding payee
				[ ] AddPayee(lsPayee[1],lsPayee[2])
				[ ] 
				[ ] 
				[ ] 
				[ ] // seleting never categorize
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_UP,4))
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] 
				[ ] 
				[ ] // selecting use option
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_DN,3))
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] QuickenWindow.Click()
				[ ] MDIClient.AccountRegister.TxList.Typekeys(KEY_ENTER)
				[ ] 
				[ ] 
				[ ] //verify if transaction added
				[ ] lsPayeeDetails=GetTransactionsInRegister(lsPayee[1])
				[ ] iFlag=ListCount(lsPayeeDetails)
				[+] if(iFlag>0)
					[ ] bMatch=MatchStr("*{lsPayee[1]}*",lsPayeeDetails[1])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify account resiter opened when use option selected",PASS,"register was set active,use option wa successful")
					[+] else
						[ ] ReportStatus("verify account register opened when use option selected",FAIL,"register could not be set active,use option was not successful")
					[ ] 
					[ ] bMatch=MatchStr("*{sCategory}*",lsPayeeDetails[1])
					[ ] 
					[+] if(bMatch==FALSE)
						[ ] 
						[ ] ReportStatus("verify transaction not auto categorized",PASS,"transaction not automatically categorized")
					[+] else
						[ ] ReportStatus("verify transaction not auto categorized",FAIL,"transaction automatically categorized")
						[ ] 
				[ ] 
				[ ] DeletePayees()
			[+] else
				[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
			[ ] 
			[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
			[ ] 
		[+] else
			[ ] ReportStatus("verify account register can be opened from account bar",FAIL,"transaction register could not be opened")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
		[ ] 
	[ ] 
[ ] 
[+] //############# Test-42 Verify use option functionality when never auto categorize is False for single payee#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_UseCategoryFalse()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify functionality of use option when never auto categorize is false from context menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test18_UseCategoryFalse()appstate MemorizedPayeeBaseState
	[+] //variable declarations
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccount=lsAddAccount[2]
		[ ] //open transaction register
		[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
		[ ] 
		[+] if(iSelect==PASS)
			[ ] //navigate to memorzied payee list
			[ ] QuickenWindow.SetActive()
			[ ] //click on Tools
			[ ] QuickenWindow.Tools.click()
			[ ] //select memorized payee list in tools menu
			[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
			[ ] //verify if memorized payee list exists
			[+] if(MemorizedPayeeList.Exists(5))
				[ ] 
				[ ] // read from excel sheet
				[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
				[ ] 
				[ ] // read first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] sCategory=lsPayee[4]
				[ ] //adding payee
				[ ] AddPayee(lsPayee[1],lsPayee[2])
				[ ] 
				[ ] // read third row of excel sheet
				[ ] lsPayee=lsExcelData[3]
				[ ] 
				[ ] //adding payee
				[ ] AddPayee(lsPayee[1],lsPayee[2])
				[ ] 
				[ ] 
				[ ] // read second row of excel sheet
				[ ] lsPayee=lsExcelData[2]
				[ ] 
				[ ] //adding payee
				[ ] AddPayee(lsPayee[1],lsPayee[2])
				[ ] 
				[ ] 
				[ ] MemorizedPayeeList.Click()
				[ ] 
				[ ] //selecting use option
				[ ]  MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
				[ ]  MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
				[ ]  MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_DN,3))
				[ ]  MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
				[ ] QuickenWindow.Click()
				[ ] MDIClient.AccountRegister.TxList.Typekeys(KEY_ENTER)
				[ ] 
				[ ] //verify if transaction added
				[ ] iFlag=FindTransaction("MDI",lsPayee[1])
				[ ] 
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify account resiter opened when use option selected",PASS,"register was set active,use option successful")
				[+] else
					[ ] ReportStatus("verify account register opened when use option selected",FAIL,"register could not be set active,use option not successful")
				[ ] 
				[ ] iFlag=FindTransaction("MDI",sCategory)
				[ ] 
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify transaction automatically categorized",PASS,"transaction automatically categorized")
				[+] else
					[ ] ReportStatus("verify transaction automatically categorized",FAIL,"trsansaction not automatically categorized")
					[ ] 
				[ ] DeletePayees()
			[+] else
				[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
			[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
		[+] else
			[ ] ReportStatus("verify transaction register is selected from account bar",FAIL,"transaction register could not be opened")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
[ ] 
[ ] 
[+] //############# Test-37 Verify new payee option functionality from context menu#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_NewPayeeFromContextMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify functionality of new payee option from context menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test19_NewPayeeFromContextMenu()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER i,iPayeeCount
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // read from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] 
			[ ] // read second row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] 
			[ ] MemorizedPayeeList.SetActive()
			[ ] 
			[ ] //get payee count
			[ ] iPayeeCount=MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()
			[ ] 
			[ ] //select new payee from context menu
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_UP,2))
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] // verify if create payee window is opened
			[+] if(CreateMemorizedPayee.Exists(5))
				[ ] ReportStatus("verify new payee was selected from context menu",PASS,"new Payee option selected successfully")
				[ ] // read third row of excel sheet
				[ ] lsPayee=lsExcelData[3]
				[ ] 
				[ ] CreateMemorizedPayee.CreateMemorizedPayeeTextField.SetText(lsPayee[1])
				[ ] CreateMemorizedPayee.AmountTextField.SetText(lsPayee[2])
				[ ] //click ok
				[ ] CreateMemorizedPayee.OKButton.Click()
				[ ] 
				[ ] MemorizedPayeeList.SetActive()
				[ ] 
				[ ] // verify if number of payees has increased by 1
				[+] if(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()==iPayeeCount+1)
					[ ] 
					[ ] //get handle of the listbox
					[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
					[ ] 
					[ ] // verify details of new payee
					[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] //checking if new payee is added in memorized payee list
						[ ] bMatch=MatchStr("*{lsPayee[1]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] break
					[-] if(bMatch==TRUE)
						[ ] ReportStatus("verify new payee was added using new payee option from context menu",PASS,"memorized payee added through context menu")
					[-] else
						[ ] ReportStatus("verify new payee was added using new payee option from context menu",FAIL,"memorized payee could not be added through context menu")
					[ ] 
				[+] else
					[ ] ReportStatus("verify new payee was added using new payee option from context menu",FAIL,"new payee not added successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("verify new payee was selected from context menu",FAIL,"new Payee option not selected ")
			[ ] 
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
[ ] 
[+] //############# Test-36 Verify new payee option functionality from context menu#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_EditPayeeFromContextMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify functionality of edit payee option from context menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test20_EditPayeeFromContextMenu()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER i,iPayeeCount
		[ ] STRING sNewAmount
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // read from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] 
			[ ] // read second row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] 
			[ ] MemorizedPayeeList.SetActive()
			[ ] 
			[ ] //get payee count
			[ ] iPayeeCount=MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()
			[ ] 
			[ ] //select edit payee from context menu
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_DN)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] // verify if create payee window is opened
			[+] if(CreateMemorizedPayee.Exists(5))
				[ ] ReportStatus("verify Edit payee option from context menu",PASS,"Edit payee option selected ")
				[ ] sNewAmount=str(val(lsPayee[2])+100)
				[ ] 
				[ ] CreateMemorizedPayee.AmountTextField.SetText(sNewAmount)
				[ ] //click ok
				[ ] CreateMemorizedPayee.OKButton.Click()
				[ ] 
				[ ] MemorizedPayeeList.SetActive()
				[ ] 
				[ ] 
				[ ] //get handle of the listbox
				[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
				[ ] 
				[ ] // verify details of edited payee
				[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] //checking if new amount is edited in memorized payee list
					[ ] bMatch=MatchStr("*{lsPayee[1]}*{sNewAmount}*",sActual)
					[ ] 
					[-] if(bMatch==TRUE)
						[ ] break
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("verify payee was edited using edit option in context menu",PASS,"memorized payee edited through context menu")
				[+] else
					[ ] ReportStatus("verify payee was edited using edit option in context menu",FAIL,"memorized payee could not be edited though context menu")
			[+] else
				[ ] ReportStatus("verify edit payee option from context menu",FAIL,"Edit Payee not selected")
				[ ] 
			[ ] 
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
[ ] 
[+] //############# Test-38 Verify Lock option functionality from context menu for single payee#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_LockFromContextMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify functionality of Lock option from context menu for single payee
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test21_LockFromContextMenu()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] STRING sName="Test Payee",sAmount="5.33"
		[ ] sCategory="Auto & Transport:Auto Payment"
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] // add payee
			[ ] AddPayee(sName,sAmount,NULL,NULL,NULL,NULL,NULL,NULL,sCategory)
			[ ] 
			[ ] // selecting lock option from context menu
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(1)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_DN,4))
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] 
			[+] // selecting options
				[ ] MemorizedPayeeList.Options.Click()
				[ ] // select view  Locked payees only option
				[ ] MemorizedPayeeList.Typekeys(KEY_UP)
				[ ] 
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] //get handle of the listbox
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
			[ ] 
			[ ] // verify details of edited payee
			[ ] 
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(0))
			[ ] //checking if payee is seen in view locked payee mode
			[ ] bMatch=MatchStr("*{sName}*{sCategory}*{sAmount}*",sActual)
			[ ] 
			[-] if(bMatch==TRUE)
				[ ] ReportStatus("verify lock option from context menu",PASS,"Lock option selected successfully")
			[-] else
				[ ] ReportStatus("verify lock option from context menu",FAIL,"Lock option selected unsuccessfully")
			[ ] 
			[ ] // unselecting options
			[ ] MemorizedPayeeList.Options.Click()
			[ ] // unselect view  Locked payees only option
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] 
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] 
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-44 Verify show on calendar option functionality from context menu for single payee#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_CalendarSinglePayeeContextMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify functionality show on calendar option from context menu for single payee
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test22_CalendarSinglePayeeContextMenu()appstate MemorizedPayeeBaseState
	[ ] //verify quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // reading from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read second row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] // Add Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] // Add Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] // Add Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] 
			[ ] // select show on calendar option from context menu
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(1)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(Replicate(KEY_UP,3))
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] 
			[ ] 
			[ ] MemorizedPayeeList.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
			[ ] exit
		[ ] // verify if memorzied payeelist is closed
		[+] if(!MemorizedPayeeList.Exists(5))
			[ ] // navigating to calendar 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.Calendar.Select()
			[ ] // verify if calendar exists
			[+] if(Calendar.Exists(5))
				[ ] // verify if "show memorized payee list "already present
				[+] do
					[ ] Calendar.TextClick("Drag")
					[ ] 
				[+] except
					[ ] // checking "show memorized payee list"
					[ ] Calendar.Options.Click()
					[ ] Calendar.Options.Typekeys(KEY_UP)
					[ ] Calendar.Options.Typekeys(KEY_UP)
					[ ] Calendar.Options.Typekeys(KEY_UP)
					[ ] Calendar.Options.Typekeys(KEY_ENTER)
					[ ] 
					[ ] 
				[ ] 
				[ ] //verify if payee can be found in calendar
				[+] do
					[ ] Calendar.TextClick(lsPayee[1])
					[ ] ReportStatus("verify payee present in calendar using show on calendar option from context menu",PASS,"payee successfully shown in calendar")
				[+] except
					[ ] ReportStatus("verify payee present in calendar using show on calendar option from context menu ", FAIL,"payee could not be found in calendar ")
				[ ] 
				[ ] // unchecking "show memorized payee list"
				[ ] Calendar.Options.Click()
				[ ] Calendar.Options.Typekeys(Replicate(KEY_UP,3))
				[ ] Calendar.Options.Typekeys(KEY_ENTER)
				[ ] // close Calendar
				[ ] Calendar.Close()
				[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be closed from menu bar", FAIL,"Verify the MemorizedPayee list can be closed")
			[ ] 
		[ ] 
		[ ] DeletePayees()
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-45 Verify show on calendar option functionality from context menu for Multiple payees#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_CalendarMultiplePayeeContextMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify functionality show on calendar option from context menu for multiple payees
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test23_CalendarMultiplePayeeContextMenu()appstate MemorizedPayeeBaseState
	[ ] 
	[ ] //verify if quicken windows exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // reading from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read second row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] // Add Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] // Add Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] // Add Payees
			[ ] AddPayee(lsPayee[1],lsPayee[2])
			[ ] 
			[ ] // select show on calendar option from context menu
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(1)
			[ ] //selecting multiple payees
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_SHIFT_DOWN)
			[ ] 
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Click(2)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Typekeys(KEY_ENTER)
			[ ] 
			[ ] 
			[ ] MemorizedPayeeList.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
			[ ] exit
		[ ] // verify if memorzied payeelist is closed
		[+] if(!MemorizedPayeeList.Exists(5))
			[ ] // navigating to calendar 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.Calendar.Select()
			[ ] // verify if calendar exists
			[+] if(Calendar.Exists(5))
				[ ] // verify if "show memorized payee list "already present
				[+] do
					[ ] Calendar.TextClick("Drag")
					[ ] 
				[+] except
					[ ] // checking "show memorized payee list"
					[ ] Calendar.Options.Click()
					[ ] Calendar.Options.Typekeys(Replicate(KEY_UP,3))
					[ ] Calendar.Options.Typekeys(KEY_ENTER)
					[ ] 
					[ ] 
				[ ] 
				[ ] //verify if payee can be found in calendar
				[+] do
					[ ] Calendar.TextClick(lsPayee[1])
					[ ] // read second row of excel sheet
					[ ] lsPayee=lsExcelData[2]
					[ ] Calendar.TextClick(lsPayee[1])
					[ ] ReportStatus("verify multiple payees present in calendar using show on calendar option from context menu",PASS,"payee successfully shown in calendar ")
				[+] except
					[ ] ReportStatus("verify multiple payees present in calendar using show on calendar option from context menu", FAIL,"payee could not be found in calendar  ")
				[ ] 
				[ ] // unchecking "show memorized payee list"
				[ ] Calendar.Options.Click()
				[ ] Calendar.Options.Typekeys(Replicate(KEY_UP,3))
				[ ] Calendar.Options.Typekeys(KEY_ENTER)
				[ ] // close Calendar
				[ ] Calendar.Close()
				[ ] 
		[+] else
			[ ] ReportStatus("verify memorized payee list can be closed from menu bar", FAIL,"Verify the MemorizedPayee list can be closed")
			[ ] 
		[ ] DeletePayees()
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test-52 Data Migration#################################################
[+] //############# Test-55 Data Migration : Verify that lock column is shown if any payee has lock option selected. #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_DataMigrationLock()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Data Migration : Verify that lock column is shown if any of payee has lock option selected., verify Data Migration : Verify 'Memorized Payee List' for Converted old data file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test24_DataMigrationLock()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER i,iPayeeCount,iFlag1=0
		[ ] STRING sMatch1="OBJ=1",sMatch2="OBJ=0"
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] print("for 2013 file")
		[ ] QuickenWindow.SetActive()
		[ ] // open 2013 file
		[ ] sFileName="MemorizedPayee_2013"
		[ ] //open the file
		[ ] iSelect=OpenDataFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] //open memorized payee list with <ctrl+t>
			[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
			[ ] //select view locked items only option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] iPayeeCount=MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()
			[+] if(iPayeeCount!=0)
				[ ] 
				[ ] ReportStatus("verify there is a payee with lock option=true",PASS,"Lock option is true for a payee")
				[ ] //verify if Lock column is shown
				[+] do
					[ ] MemorizedPayeeList.TextClick("Lock")
					[ ] ReportStatus("verify lock column is present",PASS,"Lock column is present in 2013 file when there is a payee with lock option=true")
				[+] except
					[ ] ReportStatus("verify lock column is present",FAIL,"Lock column is not present in 2013 file when there is a payee with lock option=true")
			[+] else
				[ ] 
				[ ] ReportStatus("verify there is a payee with lock option=true",FAIL,"Lock option is true for no payee")
			[ ] 
			[ ] //unslect view only locked items option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[+] if(iPayeeCount==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify there is a payee with lock option=false ",FAIL,"there is no payee with lock option =false")
				[ ] 
			[+] else
				[ ] ReportStatus("verify there is a payee with lock option=false",PASS,"there is a payee with lock option=false")
			[ ] 
			[ ] //get the handle of list box
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetHandle())
			[ ] 
			[ ] // show on calendar column automatically shown during data migration if there is a payee with show on calendar checked
			[+] do
				[ ] MemorizedPayeeList.TextClick("Calendar")
				[ ] 
			[+] except
				[ ] MemorizedPayeeList.SetActive()
				[ ] //select show on calendar option
				[ ] MemorizedPayeeList.Options.Click()
				[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] // flag to return unselect option later
				[ ] iFlag1=1
			[ ] 
			[ ] //verify of there is a payee with show on calendar not checked
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] 
				[ ] bMatch=MatchStr("{sMatch2}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify there is a payee with show on calendar option =false",PASS,"A payee present with show on calendar not checked")
			[+] else
				[ ] ReportStatus("verify there is a payee with show on calendar option =false",FAIL,"No payee present with show on calendar not checked")
			[ ] 
			[ ] 
			[ ] //verify of there is a payee with show on calendar checked
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] 
				[ ] bMatch=MatchStr("{sMatch1}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] break
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify there is a payee with show on calendar option=true",PASS,"A payee present with show on calendar checked")
			[+] else
				[ ] ReportStatus("verify there is a payee with show on calendar option=true",FAIL,"No payee present with show on calendar checked")
			[ ] 
			[ ] 
			[ ] //unselect show on calendar option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] //checking if lock column is present
			[+] do
				[ ] MemorizedPayeeList.TextClick("Lock")
				[ ] //unselecting lock option
				[ ] MemorizedPayeeList.Options.Click()
				[ ] MemorizedPayeeList.Typekeys(KEY_DN)
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] iFlag=0
			[+] except
				[ ] iFlag=1
			[ ] 
			[ ] //verify of there is a payee with never auto categorize not checked
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] 
				[ ] bMatch=MatchStr("{sMatch1}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] break
				[ ] 
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify there is a payee with never auto categorize=false",PASS,"A payee present with never auto categorize not checked")
			[+] else
				[ ] ReportStatus("verify there is a payee with never auto categorize=false",FAIL,"No payee present with never auto categorize not checked")
			[ ] 
			[ ] 
			[ ] //verify of there is a payee with never auto categorize checked
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] 
				[ ] bMatch=MatchStr("{sMatch2}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify there is a payee with never auto categorize=true",PASS,"A payee present with never auto categorize checked")
			[+] else
				[ ] ReportStatus("verify there is a payee with never auto categorize=true",FAIL,"No payee present with never auto categorize checked")
			[ ] 
			[ ] 
			[ ] //return to base state
			[+] if(iFlag1==0)
				[ ] //select show on calendar option
				[ ] MemorizedPayeeList.Options.Click()
				[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] 
			[+] if(iFlag==0)
				[ ] //selecting lock option
				[ ] MemorizedPayeeList.Options.Click()
				[ ] MemorizedPayeeList.Typekeys(KEY_DN)
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify 2013 file could be opened",FAIL,"File 2013 could not be opened")
		[ ] 
		[ ] 
		[ ] print("for 2014 file")
		[ ] QuickenWindow.SetActive()
		[ ] // open 2014 file
		[ ] sFileName="MemorizedPayee_2014"
		[ ] //open the file
		[ ] iSelect=OpenDataFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] iFlag1=0
			[ ] iFlag=0
			[ ] QuickenWindow.SetActive()
			[ ] //open memorized payee list with <ctrl+t>
			[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
			[ ] //select view locked items only option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] iPayeeCount=MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()
			[+] if(iPayeeCount!=0)
				[ ] 
				[ ] ReportStatus("verify there is a payee with lock option=true",PASS,"Lock option is true for a payee")
				[ ] //verify if Lock column is shown
				[+] do
					[ ] MemorizedPayeeList.TextClick("Lock")
					[ ] ReportStatus("verify lock column is present",PASS,"Lock column is present in 2014 file when there is a payee with lock option=true")
				[+] except
					[ ] ReportStatus("verify lock column is present",FAIL,"Lock column is not present in 2014 file when there is a payee with lock option=true")
			[+] else
				[ ] 
				[ ] ReportStatus("verify there is a payee with lock option=true",FAIL,"Lock option is true for no payee")
			[ ] 
			[ ] //unslect view only locked items option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[+] if(iPayeeCount==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify there is a payee with lock option=false ",FAIL,"there is no payee with lock option =false")
				[ ] 
			[+] else
				[ ] ReportStatus("verify there is a payee with lock option=false",PASS,"there is a payee with lock option=false")
			[ ] 
			[ ] //get the handle of list box
			[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetHandle())
			[ ] 
			[ ] // show on calendar column automatically shown during data migration if there is a payee with show on calendar checked
			[+] do
				[ ] MemorizedPayeeList.TextClick("Calendar")
				[ ] 
			[+] except
				[ ] MemorizedPayeeList.SetActive()
				[ ] //select show on calendar option
				[ ] MemorizedPayeeList.Options.Click()
				[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] // flag to return unselect option later
				[ ] iFlag1=1
			[ ] 
			[ ] //verify of there is a payee with show on calendar not checked
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] 
				[ ] bMatch=MatchStr("{sMatch2}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify there is a payee with show on calendar option =false",PASS,"A payee present with show on calendar not checked")
			[+] else
				[ ] ReportStatus("verify there is a payee with show on calendar option =false",FAIL,"No payee present with show on calendar not checked")
			[ ] 
			[ ] 
			[ ] //verify of there is a payee with show on calendar checked
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] 
				[ ] bMatch=MatchStr("{sMatch1}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] break
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify there is a payee with show on calendar option=true",PASS,"A payee present with show on calendar checked")
			[+] else
				[ ] ReportStatus("verify there is a payee with show on calendar option=true",FAIL,"No payee present with show on calendar checked")
			[ ] 
			[ ] 
			[ ] //unselect show on calendar option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] //checking if lock column is present
			[+] do
				[ ] MemorizedPayeeList.TextClick("Lock")
				[ ] //unselecting lock option
				[ ] MemorizedPayeeList.Options.Click()
				[ ] MemorizedPayeeList.Typekeys(KEY_DN)
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] iFlag=0
			[+] except
				[ ] iFlag=1
			[ ] 
			[ ] //verify of there is a payee with never auto categorize not checked
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] 
				[ ] bMatch=MatchStr("{sMatch1}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] break
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify there is a payee with never auto categorize=false",PASS,"A payee present with never auto categorize not checked")
			[+] else
				[ ] ReportStatus("verify there is a payee with never auto categorize=false",FAIL,"No payee present with never auto categorize not checked")
			[ ] 
			[ ] 
			[ ] //verify of there is a payee with never auto categorize checked
			[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] 
				[ ] bMatch=MatchStr("{sMatch2}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] break
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("verify there is a payee with never auto categorize=true",PASS,"A payee present with never auto categorize checked")
			[+] else
				[ ] ReportStatus("verify there is a payee with never auto categorize=true",FAIL,"No payee present with never auto categorize checked")
			[ ] 
			[ ] 
			[ ] //return to base state
			[+] if(iFlag1==0)
				[ ] //select show on calendar option
				[ ] MemorizedPayeeList.Options.Click()
				[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] 
			[ ] 
			[+] if(iFlag==0)
				[ ] //selecting lock option
				[ ] MemorizedPayeeList.Options.Click()
				[ ] MemorizedPayeeList.Typekeys(KEY_DN)
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify 2014 file could be opened",FAIL,"File 2014 could not be opened")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-56 Data Migration : Verify that lock column is not shown if none of payee has lock option selected #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_DataMigrationNoLock()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Data Migration : Verify that lock column is not shown if none of payee has lock option selected
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test25_DataMigrationNoLock()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER iPayeeCount
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // open 2013 file
		[ ] sFileName="MemorizedPayee2_2013"
		[ ] //open the file
		[ ] iSelect=OpenDataFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] //open memorized payee list with <ctrl+t>
			[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
			[ ] //select view locked items only option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] iPayeeCount=MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()
			[+] if(iPayeeCount==0)
				[ ] ReportStatus("verify no payee is present with lock option=true",PASS,"there are no payees present with lock option=true in 2013 file")
				[ ] //verify if Lock column is shown
				[+] do
					[ ] MemorizedPayeeList.TextClick("Lock")
					[ ] ReportStatus("verify lock column is not present when there are no payees with lock option=true",FAIL,"Lock column is present in 2013 file ")
				[+] except
					[ ] ReportStatus("verify lock column is not present when there are no payees lock option=true",PASS,"Lock column is not present in 2013 file ")
			[+] else
				[ ] ReportStatus("verify no payee is present with lock option=true",FAIL,"there is a payee with lock option=true in 2013 file")
			[ ] //unslect view only locked items option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify 2013 file was opened",FAIL,"File 2013 could not be opened")
		[ ] // open 2014 file
		[ ] sFileName="MemorizedPayee2_2014"
		[ ] //open the file
		[ ] iSelect=OpenDataFile(sFileName)
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] //open memorized payee list with <ctrl+t>
			[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
			[ ] //select view locked items only option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] iPayeeCount=MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()
			[+] if(iPayeeCount==0)
				[ ] ReportStatus("verify no payee is present with lock option=true",PASS,"there are no payees present with lock option=true in 2014 file")
				[ ] //verify if Lock column is shown
				[+] do
					[ ] MemorizedPayeeList.TextClick("Lock")
					[ ] ReportStatus("verify lock column is not present when there are no payees with lock option=true",FAIL,"Lock column is present in 2014 file ")
				[+] except
					[ ] ReportStatus("verify lock column is not present when there are no payees with lock option=true",PASS,"Lock column is not present in 2014 file")
			[+] else
				[ ] ReportStatus("verify no payee is present with lock option=true",FAIL,"there is a payee with lock option=true in 2014 file")
			[ ] //unselect view only locked items option
			[ ] MemorizedPayeeList.Options.Click()
			[ ] MemorizedPayeeList.Typekeys(KEY_UP)
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
		[+] else
			[ ] ReportStatus("verify 2014 file was opened",FAIL,"File 2014 could not be opened")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-31 Verify Edit button is disabled for multiple payees#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test26_EditMultiplePayees()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify  edit button is disabled when multiple payees are selected
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test26_EditMultiplePayees()appstate MemorizedPayeeBaseState
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //open memorized payee list with short cut keys<ctrl+t>
		[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // read from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] 
			[ ] //adding payee
			[ ] AddPayee(lsPayee[1])
			[ ] 
			[ ] // read second row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] 
			[ ] //adding payee
			[ ] AddPayee(lsPayee[1])
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] 
			[ ] //adding payee
			[ ] AddPayee(lsPayee[1])
			[ ] 
			[ ] //selecting multiple payees
			[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(1)
			[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_SHIFT_DOWN,2))
			[ ] 
			[ ] MemorizedPayeeList.TextClick("Edit")
			[ ] //verify if edit payees window is present
			[+] do
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] ReportStatus("verify edit button is not enabled when multiple payees are selected",FAIL,"Edit button was pressed successfully ")
			[+] except
				[ ] ReportStatus("verify edit button is not enabled when mutiple payees are selected",PASS,"Edit button was not pressed successfully")
			[ ] MemorizedPayeeList.Close()
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-41 Verify never auto categorize functionality for multiple payees#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_MultiplePayeesNeverCategorize()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the functionality never auto categorize functionality when multiple payees are selected
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test27_MultiplePayeesNeverCategorize()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER i
		[ ] STRING sMatch
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccount=lsAddAccount[2]
		[ ] //open transaction register
		[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
		[+] if(iSelect==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] //open memorized payee list with <ctrl+t>
			[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
			[ ] // verify Memorized Payee list exists
			[+] if(MemorizedPayeeList.Exists(5))
				[ ] 
				[ ] // read from excel sheet
				[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
				[ ] 
				[ ] // read first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] sMatch=lsPayee[4]
				[ ] //adding payee
				[ ] AddPayee(lsPayee[1])
				[ ] sCategory=lsPayee[4]
				[ ] // read second row of excel sheet
				[ ] lsPayee=lsExcelData[2]
				[ ] 
				[ ] //adding payee
				[ ] AddPayee(lsPayee[1])
				[ ] 
				[ ] // read third row of excel sheet
				[ ] lsPayee=lsExcelData[3]
				[ ] 
				[ ] //adding payee
				[ ] AddPayee(lsPayee[1])
				[ ] 
				[ ] 
				[ ] //select multiple payees
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(1)
				[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_SHIFT_DOWN,2))
				[ ] 
				[ ] //select never categorize option from context menu
				[ ] MemorizedPayeeList.Click(2)
				[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_UP,2))
				[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
				[ ] 
				[ ] //using payees in transactions
				[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
					[ ] 
					[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
					[ ] MemorizedPayeeList.Typekeys(KEY_CTRL_M)
					[ ] QuickenWindow.Click()
					[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
					[ ] 
				[ ] //closing memorized payeelist
				[ ] MemorizedPayeeList.Done.Click()
				[ ] //verify if any payee is categorized
				[ ] QuickenWindow.SetActive()
				[+] do
					[ ] QuickenWindow.Typekeys(KEY_CTRL_F)
					[ ] ReportStatus("verify transactions are not auto categorized when never auto categorize option is enabled for multiple payees",PASS,"<ctrl-f> was pressed successfuly")
					[ ] 
					[+] if(QuickenFind.Exists(5))
						[ ] ReportStatus("verify transactions are not auto categorized when never auto categorize option is enabled for multiple payees",PASS,"Quicken Find window was opened successfuly")
						[ ] QuickenFind.QuickenFind.SetText(sCategory)
						[ ] QuickenFind.Find.Click()
						[+] if(Quicken2012.Exists(5))
							[ ] Quicken2012.OK.Click()
							[ ] Reportstatus("verify transactions are not auto categorized when never auto categorize option is enabled for multiple payees",PASS,"transaction not categorized")
						[+] else
							[ ] ReportStatus("verify transaction are not auto categorized when never auto categorize option is enabled for multple payees ",FAIL,"transaction categorized")
						[ ] QuickenFind.Close.Click()
					[+] else
						[ ] ReportStatus("verify transactions are not auto categorized when never auto categorize option is enabled for multiple payees",FAIL,"Quicken Find Window could not be opened")
				[+] except
					[ ] ReportStatus("verify transactions are not auto categorized when never auto categorize option is enabled for multiple payees",FAIL,"<ctrl-f> could not be opened")
				[ ] 
				[ ] 
				[ ] 
				[ ] DeletePayees()
				[ ] // read first row of excel sheet
				[ ] lsPayee=lsExcelData[1]
				[ ] 
				[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
				[ ] 
				[ ] // read third row of excel sheet
				[ ] lsPayee=lsExcelData[3]
				[ ] 
				[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
				[ ] 
				[ ] // read second row of excel sheet
				[ ] lsPayee=lsExcelData[2]
				[ ] 
				[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
				[ ] 
			[+] else
				[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[+] else
			[ ] ReportStatus("verify transaction register can be selected from account bar",FAIL,"Account could not be selected from account bar")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test-20 Verify that for transfer category payee are not memorizes automatically#################################################
[+] //############# Test-21 Adding Transfer Category Payee to Memorized Payee List#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_QFX()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify transfer category payees are not memorized automatically , transfer category payees are memorized using <ctrl-m> from register
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test28_QFX()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] STRING sPayee1="Transfer Savings Account",sPayee2="Transfer Checking Account",sFileName="BofA_Checking_Test",sAccount="Checking at Bank of America-All Other S"
		[ ] INTEGER i,iFind
	[ ] 
	[ ] //verify quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] //import qfx file
		[ ] iSelect=ImportWebConnectFile(sFileName)
		[ ] //verify if file open was successful
		[+] if(iSelect==PASS)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] //open memorized payee list with <ctrl+t>
			[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
			[ ] //verify mermozed payee lsit exists
			[+] if(MemorizedPayeeList.Exists(5))
				[ ] MemorizedPayeeList.SetActive()
				[ ] // get handle of the listbox
				[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
				[ ] //verify if the payees are memorized
				[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bMatch=MatchStr("*{sPayee1}*",sActual)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] break
					[ ] 
					[ ] bMatch=MatchStr("*{sPayee2}*",sActual)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] break
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("verify transfer payees are not autmatically memorized",FAIL,"Transfer Payee memorized automatically")
					[ ] 
				[+] else
					[ ] ReportStatus("verify transfer payees are not automatically memorized",PASS,"Transfer Payee not memorized automatically")
					[ ] 
				[ ] //close memorized payee list
				[ ] MemorizedPayeeList.Done.Click()
				[ ] //open transaction register
				[ ] iSelect=SelectAccountfromAccountBar(sAccount,ACCOUNT_BANKING)
				[ ] 
				[+] if(iSelect==PASS)
					[ ] //find transaction -1st transaction
					[ ] iFind=FindTransaction("MDI",sPayee1)
					[+] if(iFind==PASS)
						[ ] 
						[ ] QuickenWindow.Typekeys(KEY_CTRL_M)
						[ ] Quicken2012.OK.Click()
						[ ] 
					[ ] //find transaction-2nd transaction
					[ ] iFind=FindTransaction("MDI",sPayee2)
					[+] if(iFind==PASS)
						[ ] 
						[ ] QuickenWindow.Typekeys(KEY_CTRL_M)
						[ ] Quicken2012.OK.Click()
						[ ] 
					[ ] //open memorized payee list
					[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
					[ ] MemorizedPayeeList.SetActive()
					[ ] 
					[ ] // get handle of the listbox
					[ ] sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.getHandle())
					[ ] 
					[ ] 
					[ ] //verify payee1 are memorized
					[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] bMatch=MatchStr("*{sPayee1}*",sActual)
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] break
						[ ] 
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify transfer payees are memorized using <ctrl-m>",PASS,"Transfer Payee-{sPayee1}  memorized using <ctrl-m>")
						[ ] 
					[+] else
						[ ] ReportStatus("verify transfer payees are memorized using <ctrl-m>",FAIL,"Transfer Payee-{sPayee1} not  memorized using <ctrl-m>")
						[ ] 
					[ ] 
					[ ] //verify payee2 are memorized
					[+] for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sPayee2}*",sActual)
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] break
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify transfer payees are memorized using <ctrl-m>",PASS,"Transfer Payee-{sPayee2}  memorized using <ctrl-m> ")
						[ ] 
					[+] else
						[ ] ReportStatus("verify transfer payees are memorized using <ctrl-m>",FAIL,"Transfer Payee-{sPayee2} not memorized using <ctrl-m> ")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify transaction register can be selected from account  bar",FAIL,"account could not be selected")
				[ ] MemorizedPayeeList.Close()
			[+] else
				[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
			[ ] 
			[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
			[ ] DeletePayees()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify web connect file was imported",FAIL,"Web connect file could not be imported")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //############# Test-48 Verify sorting in each column#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_Sort()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify sorting in each column (ascending and descending)
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test29_Sort()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] INTEGER i
		[ ] STRING sPayee0,sPayee1
	[ ] //verify quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // invoke memorized payee list with <ctrl+t>
		[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
		[ ] 
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] 
			[ ] // read from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] 
			[ ] // read third row of excel sheet
			[ ] lsPayee=lsExcelData[3]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2],TRUE,FALSE,TRUE,lsPayee[5],NULL,3)
			[ ] 
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2],FALSE,TRUE,TRUE,lsPayee[5],NULL,2)
			[ ] 
			[ ] 
			[ ] // read second row of excel sheet
			[ ] lsPayee=lsExcelData[2]
			[ ] // adding payee
			[ ] AddPayee(lsPayee[1],lsPayee[2],TRUE,TRUE,FALSE,lsPayee[5],NULL,1)
			[ ] 
			[ ] // selection options
			[ ] MemorizedPayeeList.Options.Click()
			[ ] // select Lock option
			[ ] MemorizedPayeeList.Typekeys(KEY_DN)
			[ ] 
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] //select options
			[ ] MemorizedPayeeList.Options.Click()
			[ ] // select show on calendar option
			[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
			[ ] 
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] 
			[ ] 
			[ ] //click on description for descending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Description")
				[ ] ReportStatus("verify Desciption column can be clicked",PASS,"Desciption pressed successfully")
			[+] except
				[ ] ReportStatus("verify Description column can be clicked",FAIL,"could not press on Description")
			[ ] //verify if list is in descending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee0=CreateMemorizedPayee.CreateMemorizedPayeeTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.CreateMemorizedPayeeTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] 
				[-] if(sPayee0<sPayee1)
					[ ] break
				[ ] 
			[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in descending order ",PASS,"sorted in descending order for description")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in descending order",FAIL,"could not sort in descending order for description")
			[ ] //click on desciption for ascending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Description")
				[ ] ReportStatus("verify Description column can be clicked",PASS,"Description presed successfully")
			[+] except
				[ ] ReportStatus("verify Description column can be clicked",FAIL,"could not press on Description")
			[ ] //verify if list is in ascending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee0=CreateMemorizedPayee.CreateMemorizedPayeeTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.CreateMemorizedPayeeTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[-] if(sPayee0>sPayee1)
					[ ] break
				[ ] 
			[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in ascending order",PASS,"sorted in ascending order for description")
				[ ] 
			[+] else
				[ ] ReportStatus("verify memorized payee list is in ascending order",FAIL,"could not sort in ascending order for description")
			[ ] 
			[ ] //click on category for ascending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Category")
				[ ] ReportStatus("verify Category column can be clicked",PASS,"Category pressed successfully")
			[+] except
				[ ] ReportStatus("verify Category column can be clicked",FAIL,"could not press on Category")
			[ ] //verify list is in ascending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee0=CreateMemorizedPayee.CategoryTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.CategoryTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] if(sPayee0>sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in ascending order",PASS,"sorted in ascending order for Category")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in ascending order",FAIL,"could not sort in ascending order for Category")
			[ ] 
			[ ] //click on category for descending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Category")
				[ ] ReportStatus("verify Category column can be clicked",PASS,"Category pressed successfully")
			[+] except
				[ ] ReportStatus("verify Category column can be clicked",FAIL,"could not press on Category")
			[ ] //verify list is in descending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee0=CreateMemorizedPayee.CategoryTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.CategoryTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[-] if(sPayee0<sPayee1)
					[ ] break
				[ ] 
			[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in descending order",PASS,"sorted in descending order for Category")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in descending order",FAIL,"could not sort in descending order for Category")
			[ ] 
			[ ] 
			[ ] 
			[ ] //click on memo for descending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Memo")
				[ ] ReportStatus("verify Memo column can be clicked",PASS,"Memo pressed successfully")
			[+] except
				[ ] ReportStatus("verify Memo column can be clicked",FAIL,"could not press on Memo")
			[ ] //verify list is in descending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee0=CreateMemorizedPayee.MemoTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.MemoTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[-] if(sPayee0<sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in descending order ",PASS,"sorted in descending order for Memo")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in descending order",FAIL,"could not sort in descending order for Memo")
			[ ] 
			[ ] //click on memo for ascending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Memo")
				[ ] ReportStatus("verify Memo column can be clicked",PASS,"Memo pressed successfully")
			[+] except
				[ ] ReportStatus("verify Memo column can be clicked",FAIL,"could not press on Memo")
			[ ] //verify list is in ascending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee0=CreateMemorizedPayee.MemoTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.MemoTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[-] if(sPayee0>sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in ascending order ",PASS,"sorted in ascending order for Memo")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in ascending order",FAIL,"could not sort in ascending order for Memo")
			[ ] 
			[ ] 
			[ ] //click on amount for descending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Amount")
				[ ] ReportStatus("verify Amount column can be clicked",PASS,"Amount pressed successfully")
			[+] except
				[ ] ReportStatus("verify Amount column can be clicked",FAIL,"could not press on Amount")
			[ ] //verify list in descending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee0=CreateMemorizedPayee.AmountTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.AmountTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[-] if(sPayee0<sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in descending order ",PASS,"sorted in descending order for Amount")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in descending order",FAIL,"could not sort in descending order for Amount")
			[ ] //click on amount for ascending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Amount")
				[ ] ReportStatus("verify Amount column can be clicked",PASS,"Amount pressed successfully")
			[+] except
				[ ] ReportStatus("verify Amount column can be clicked",FAIL,"could not press on Amount")
			[ ] //verify list is in ascending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee0=CreateMemorizedPayee.AmountTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.AmountTextField.GetText()
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] if(sPayee0>sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in ascending order ",PASS,"sorted in ascending order for Amount")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in ascending order",FAIL,"could not sort in ascending order for Amount")
			[ ] 
			[ ] 
			[ ] //click on lock for descending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Lock")
				[ ] ReportStatus("verify Lock column can be clicked",PASS,"lock pressed successfully")
			[+] except
				[ ] ReportStatus("verify Lock column can be clicked",FAIL,"could not press on Lock")
			[ ] //verify list is in descending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[+] if(CreateMemorizedPayee.LockAndLeaveThisPayeeUnchCheckBox.IsChecked())
					[ ] sPayee0="1"
				[+] else
					[ ] sPayee0="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.AmountTextField.GetText()
				[+] if(CreateMemorizedPayee.LockAndLeaveThisPayeeUnchCheckBox.IsChecked())
					[ ] sPayee1="1"
				[+] else
					[ ] sPayee1="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] if(sPayee0<sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in descending order ",PASS,"sorted in descending order for Lock")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in descending order",FAIL,"could not sort in descending order for Lock")
			[ ] //click on Lock for ascending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Lock")
				[ ] ReportStatus("verify Lock column can be clicked",PASS,"lock pressed successfully")
			[+] except
				[ ] ReportStatus("verify Lock column can be clicked",FAIL,"could not press on Lock")
			[ ] //verify list is in ascending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[+] if(CreateMemorizedPayee.LockAndLeaveThisPayeeUnchCheckBox.IsChecked())
					[ ] sPayee0="1"
				[+] else
					[ ] sPayee0="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.AmountTextField.GetText()
				[+] if(CreateMemorizedPayee.LockAndLeaveThisPayeeUnchCheckBox.IsChecked())
					[ ] sPayee1="1"
				[+] else
					[ ] sPayee1="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] if(sPayee0>sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in ascending order ",PASS,"sorted in ascending order for Lock")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in ascending order",FAIL,"could not sort in ascending order for Lock")
			[ ] 
			[ ] 
			[ ] //click on show on calendar for ascending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Calendar")
				[ ] ReportStatus("verify Show on Calendar column can be clicked",PASS,"Show on Calendar pressed successfully")
			[+] except
				[ ] ReportStatus("verify Show on Calendar column can be clicked",FAIL,"could not press on Show on calendar")
			[ ] //verify list is in ascending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[+] if(CreateMemorizedPayee.ShowThisPayeeInTheCalendaCheckBox.IsChecked())
					[ ] sPayee0="1"
				[+] else
					[ ] sPayee0="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.AmountTextField.GetText()
				[+] if(CreateMemorizedPayee.ShowThisPayeeInTheCalendaCheckBox.IsChecked())
					[ ] sPayee1="1"
				[+] else
					[ ] sPayee1="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] if(sPayee0>sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in ascending order ",PASS,"sorted in ascending order for Show on Calendar")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in ascending order",FAIL,"could not sort in ascending order for Show on Calendar")
			[ ] //click on show on calendar for descending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("Cal")
				[ ] ReportStatus("verify Show on Calendar column can be clicked",PASS,"Show on Calendar pressed successfully")
			[+] except
				[ ] ReportStatus("verify Show on Calendar column can be clicked",FAIL,"could not press on Show on Calendar")
			[ ] //verify list is in descending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[+] if(CreateMemorizedPayee.ShowThisPayeeInTheCalendaCheckBox.IsChecked())
					[ ] sPayee0="1"
				[+] else
					[ ] sPayee0="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.AmountTextField.GetText()
				[+] if(CreateMemorizedPayee.ShowThisPayeeInTheCalendaCheckBox.IsChecked())
					[ ] sPayee1="1"
				[+] else
					[ ] sPayee1="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] if(sPayee0<sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in descending order ",PASS,"sorted in descending order for Show on Calendar")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in descending order",FAIL,"could not sort in descending order for Show on Calendar")
				[ ] 
			[ ] 
			[ ] //click on never auto categorize for descending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("categorize")
				[ ] ReportStatus("verify Never auto Categorize column can be clicked",PASS,"never auto Categorize pressed successfully")
			[+] except
				[ ] ReportStatus("verify Never auto categorize column can be clicked",FAIL,"could not press on never auto categorize")
			[ ] //verify list is in descending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[+] if(CreateMemorizedPayee.NeverAutoCategorizeThisPayCheckBox.IsChecked())
					[ ] sPayee0="1"
				[+] else
					[ ] sPayee0="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.AmountTextField.GetText()
				[+] if(CreateMemorizedPayee.NeverAutoCategorizeThisPayCheckBox.IsChecked())
					[ ] sPayee1="1"
				[+] else
					[ ] sPayee1="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] if(sPayee0<sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in descending order ",PASS,"sorted in descending order for Never auto Categorize")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in descending order",FAIL,"could not sort in descending order for Never auto Categorize")
				[ ] 
			[ ] //click on never auto categorize for ascending order
			[+] do
				[ ] MemorizedPayeeList.TextClick("categorize")
				[ ] ReportStatus("verify Never auto Categorize column can be clicked",PASS,"never auto Categorize pressed successfully")
			[+] except
				[ ] ReportStatus("verify Never auto Categorize column can be clicked",FAIL,"could not press on never auto categorize")
			[ ] //verify list is in ascending order
			[+] for(i=1;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
				[ ] 
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[+] if(CreateMemorizedPayee.NeverAutoCategorizeThisPayCheckBox.IsChecked())
					[ ] sPayee0="1"
				[+] else
					[ ] sPayee0="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(i+1)
				[ ] MemorizedPayeeList.TextClick("Edit")
				[ ] sPayee1=CreateMemorizedPayee.AmountTextField.GetText()
				[+] if(CreateMemorizedPayee.NeverAutoCategorizeThisPayCheckBox.IsChecked())
					[ ] sPayee1="1"
				[+] else
					[ ] sPayee1="0"
				[ ] CreateMemorizedPayee.CancelButton.Click()
				[+] if(sPayee0>sPayee1)
					[ ] break
				[ ] 
			[+] if(i==MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount())
				[ ] ReportStatus("verify memorized payee list is in ascending order ",PASS,"sorted in ascending order for Never auto Categorize")
			[+] else
				[ ] ReportStatus("verify memorized payee list is in ascending order",FAIL,"could not sort in ascending order for Never auto Categorize")
				[ ] 
			[ ] 
			[ ] 
			[ ] // selecting options
			[ ] MemorizedPayeeList.Options.Click()
			[ ] // unselect Lock option
			[ ] MemorizedPayeeList.Typekeys(KEY_DN)
			[ ] 
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] //select options
			[ ] MemorizedPayeeList.Options.Click()
			[ ] // unselect show on calendar option
			[ ] MemorizedPayeeList.Typekeys(Replicate(KEY_DN,2))
			[ ] 
			[ ] MemorizedPayeeList.Typekeys(KEY_ENTER)
			[ ] 
			[ ] DeletePayees()
			[ ] 
		[-] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] QuickenWindow.Close()
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
[ ] 
[+] //############# Test-53 Verify  functionality of <ctrl-m>  #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_CtrlM()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify functionality <ctrl-m>
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test30_CtrlM()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] 
	[ ] 
	[ ] // verify Quicken window exists
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //click on Tools
		[ ] QuickenWindow.Tools.click()
		[ ] //select memorized payee list in tools menu
		[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
		[ ] // verify Memorized Payee list exists
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] 
			[ ] // read from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeNameWorksheet)
			[ ] 
			[ ] // read first row of excel sheet
			[ ] lsPayee=lsExcelData[1]
			[ ] 
			[ ] //adding payee
			[ ] AddPayee(lsPayee[1])
			[ ] 
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sMemorizedPayeeData, sPayeeAccountWorksheet)
			[ ] lsAddAccount=lsExcelData[1]
			[ ] sAccount=lsAddAccount[2]
			[ ] MemorizedPayeeList.SetActive()
			[ ] // using shortcut key to "use" the payee
			[ ] MemorizedPayeeList.Typekeys(KEY_CTRL_M)
			[ ] 
			[ ] // //verify if register tab is opened and set active
			[ ] 
			[ ] QuickenWindow.SetActive()
			[+] do
				[ ] QuickenWindow.Typekeys(KEY_CTRL_F)
				[+] if(QuickenFind.Exists(5))
					[ ] ReportStatus("verify <ctrl-m> doesnt work when transaction register is not opened",FAIL,"register shown successful using ctrl+m")
				[+] else
					[ ] ReportStatus("verify <ctrl-m> doesnt work when transaction register is not opened",PASS,"register not shown successfully using ctrl+m")
				[ ] 
			[+] except
				[ ] ReportStatus("verify <ctrl-m> doesnt work when transaction register is not opened",PASS,"register not shown successfully using ctrl+m")
			[ ] 
			[ ] 
			[ ] 
			[ ] //close memorized payee list
			[ ] MemorizedPayeeList.Done.Click()
			[ ] QuickenWindow.SetActive()
			[ ] // open transaction register tab
			[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
			[+] if (iSelect==PASS)
				[ ] //navigate to memorized payee list
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Tools.click()
				[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
				[ ] 
				[ ] MemorizedPayeeList.Click()
				[ ] // using shortcut key to "use" the payee
				[ ] MemorizedPayeeList.Typekeys(KEY_CTRL_M)
				[ ] MDIClient.AccountRegister.TxList.Typekeys(KEY_ENTER)
				[ ] 
				[ ] //verify if register tab is opened and set active
				[ ] iFlag=FindTransaction("MDI",lsPayee[1])
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify <ctrl-m> works when transaction register is opened",PASS,"register shown successfully , ctrl+m was succcessful")
				[+] else
					[ ] ReportStatus("verify <ctrl-m> works when transaction register is opened",FAIL,"register could not be set active,ctrl+m was unsuccesful")
					[ ] 
				[ ] DeleteTransaction("MDI",lsPayee[1],ACCOUNT_BANKING)
			[+] else
				[ ] ReportStatus("verify transactionregister could not opened from account bar",FAIL,"transaction register could not be opened")
			[ ] DeletePayees()
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# Test-51 Verify auto memorizing of downloaded transactions#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test31_DownloadTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Downloaded Transactions are Automatically memorized
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] // testcase Test31_DownloadTransaction()appstate none
	[+] // //variable declaration
		[ ] // STRING sAccountIntent="MemorizedPayee",sName
		[ ] // INTEGER iAddAccount,iSelect,i
		[ ] // sFileName="NewTransactionFile"
	[ ] // 
	[+] // if(FileExists(sTestCaseStatusFile))
		[ ] // DeleteFile(sTestCaseStatusFile)
	[ ] // // Load O/S specific paths
	[ ] // LoadOSDependency()
	[ ] //  //########Launch Quicken and open MemorizedPayee_Test File######################//
	[ ] // iResult=DataFileCreate(sFileName)
	[+] // if(iResult==PASS)
		[ ] // 
		[+] // if (QuickenWindow.Exists(5))
			[ ] // QuickenWindow.SetActive()
			[ ] // iAddAccount =  AddCCMintBankAccount("jn8","jn8","Checking")
			[ ] // 
			[ ] // // Report Status if checking Account is created
			[+] // if (iAddAccount==PASS)
				[ ] // ReportStatus("",PASS," Account is created successfully")
			[+] // else
				[ ] // //ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
			[ ] // 
			[ ] // 
		[ ] // //Report Status if Quicken is not launched
		[+] // else
			[ ] // ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
	[+] // else
		[ ] // ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] // //verify if quicken window exists
	[+] // if(QuickenWindow.Exists(5))
		[ ] // iSelect=SelectAccountFromAccountBar("Quicken_Savings XX2225",ACCOUNT_BANKING)
		[+] // if(iSelect==PASS)
			[ ] // QuickenWindow.SetActive()
			[ ] // 
			[ ] // MDIClient.Click(1,145,90)
			[ ] // MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] // sleep(2)
			[ ] // MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_C)
			[ ] // QuickenWindow.Typekeys(KEY_CTRL_T)
			[ ] // MemorizedPayeeList.NewPayee.Click()
			[ ] // CreateMemorizedPayee.CreateMemorizedPayeeTextField.Typekeys(KEY_CTRL_V)
			[ ] // sName=CreateMemorizedPayee.CreateMemorizedPayeeTextField.GetText()
			[ ] // CreateMemorizedPayee.CancelButton.Click()
			[ ] // //get handle of the list box
			[ ] // sHandle=str(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetHandle())
			[+] // //while(sName!=NULL)
				[+] // for(i=0;i<MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount();i++)
					[ ] // print(sName)
					[ ] // 
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] // 
					[ ] // bMatch=MatchStr("*{sName}*",sActual)
					[ ] // 
					[+] // if(bMatch==TRUE)
						[ ] // break
					[ ] // 
				[ ] // 
				[+] // if(bMatch==FALSE)
					[ ] // ReportStatus("",FAIL,"transaction payee was not memorized")
				[ ] // 
				[ ] // MDIClient.Click()
				[ ] // //MDIClient.Click(1,175,90)
				[ ] // MDIClient.AccountRegister.TxList.TypeKeys(KEY_DN)
		[+] // else
			[ ] // ReportStatus("",FAIL,"could not open transaction register")
		[ ] // 
	[ ] // 
	[ ] // 
[ ] 
[ ] 
[+] //############# Test-4 'Verify functionality of  'Help' icon in the 'Memorized Payee List#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test32_Help()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will'Verify functionality of  'Help' icon in the 'Memorized Payee List
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             june 25, 2014		
		[ ] //Author                         Shrivardhan 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+]  testcase Test32_Help()appstate MemorizedPayeeBaseState
	[+] //variable declaration
		[ ] 
	[ ] 
	[ ]  //verify if quicken window exists
	[+]  if(QuickenWindow.Exists(5))
		[ ] //open memorized payee
		[ ] QuickenWindow.Typekeys(KEY_CTRL_T)
		[+] if(MemorizedPayeeList.Exists(5))
			[ ] //open help window
			[ ] //MemorizedPayeeList.Click(1,35,800)
			[ ] MemorizedPayeeList.Help.Click()
			[ ] //Verify if Quicken Help window appeared
			[+] if (QuickenHelp.Exists(10))
				[ ] ReportStatus("Verify Quicken Help menu", PASS, "Help menu opened.")
				[ ] //Close Help Menu=========================================================================
				[ ] QuickenHelp.Close()
				[ ] WaitForState(QuickenHelp,FALSE,5)
			[+] else
				[ ] ReportStatus("Verify Quicken Help menu", PASS, "Help menu Deid not open.")
		[+] else
			[ ] ReportStatus("verify memorized payee list can be opened from menu bar", FAIL,"Verify the MemorizedPayee list cant be opened from Menu bar")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
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
