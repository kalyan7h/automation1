[ ] // *********************************************************
[+] // FILE NAME:	<OnlineAccountUtility.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script is used to add online accounts as per user needs.
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Mamta Jain	
	[ ] //
	[ ] // Developed on: 		18/03/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	March 18, 2011	Mamta Jain created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: AddOnlineAccount()
	[ ] //
	[ ] // DESCRIPTION:		This function will add Online Accounts (Banking and Investing Accounts)
	[ ] // 
	[ ] //
	[ ] // PARAMETERS:		STRING 	sDataFile			Name of the Data file
	[ ] //						STRING 	sWorkSheet	      Name of the worksheet
	[ ] //
	[ ] // RETURNS:			None
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] // March 18, 2011	Mamta Jain created
[ ] // ==========================================================
[+] public VOID AddOnlineAccounts(STRING sDataFile, STRING sWorkSheet)
	[+] // Variable Declaration
		[ ] LIST OF ANYTYPE lsExcelData
		[ ] LIST OF STRING lsAccountData, lsSplit, lsSplit1,lsQuestion, lsAnswer
		[ ] INTEGER iCount, i, j,k
		[ ] STRING sText, sActual, sErrorMsg
		[ ] BOOLEAN bMatch, bFlag
	[ ] 
	[ ] // Variable Defination
	[ ] sActual = "Select Connection Method"
	[ ] bFlag = FALSE
	[ ] 
	[+] do
		[ ] lsExcelData=ReadExcelTable(sDataFile, sWorkSheet)		// Get data from data file
		[ ] iCount = ListCount(lsExcelData)			// Get the row count
		[ ] 
		[+] for (i = 1; i<=iCount; i++)
			[+] do
				[ ] // Fetch rows from the given sheet
				[ ] lsAccountData = lsExcelData[i]
				[+] if(IsNULL(lsAccountData[1]))
					[ ] lsAccountData[1] = ""
				[+] if(IsNULL(lsAccountData[2]))
					[ ] lsAccountData[2] = ""
				[+] if(IsNULL(lsAccountData[3]))
					[ ] lsAccountData[3] = ""
				[+] if(IsNULL(lsAccountData[4]))
					[ ] lsAccountData[4] = ""
				[+] if(IsNULL(lsAccountData[5]))
					[ ] lsAccountData[5] = ""
				[+] else
					[ ] lsSplit = Split(lsAccountData[5], ",")			// splitting the Question/Answer pairs
					[+] for(k=1; k<=ListCount(lsSplit); k++)
						[ ] lsSplit1 = Split(lsSplit[k], ":")
						[+] for(j= 1; j<= ListCount(lsSplit1); j++)
							[+] if(j%2 == 0)
								[ ] ListAppend(lsAnswer, lsSplit1[j])		// creating a list of Answers
							[+] else
								[ ] ListAppend(lsQuestion, lsSplit1[j])	// creating a list of Questions
					[ ] 
				[+] if(IsNULL(lsAccountData[6]))
					[ ] lsAccountData[6] = ""
				[+] if(IsNULL(lsAccountData[7]))
					[ ] lsAccountData[7] = ""
				[ ] 
				[ ] 
				[ ] QuickenMainWindow.SetActive()
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
				[ ] AddAccount.CustomWin(lsAccountData[1]).Click()
				[+] if(AddAnyAccount.Exists(700) && AddAnyAccount.IsEnabled())
					[ ] AddAnyAccount.SetActive()
				[ ] 
				[ ] // AddAccount.Next.Click ()
				[ ] AddAnyAccount.VerifyEnabled(TRUE,150)
				[ ] AddAnyAccount.BankName.SetText(lsAccountData[2])  // Enter the name of the bank
				[ ] 
				[ ] AddAnyAccount.SetActive ()
				[+] if(AddAnyAccount.BankList.ListBox1.GetContents () == {})			// Check whether entered bank name is valid or not
					[ ] ReportStatus("Verify Bank Name", WARN, "Bank name - {lsAccountData[2]}, you entered doen't exists")
					[ ] goto CloseWindow
				[ ] 
				[ ] AddAnyAccount.Next.Click ()
				[ ] AddAnyAccount.VerifyEnabled(TRUE,150)
				[ ] AddAnyAccount.SetActive ()
				[ ] sText = Quicken2012Popup.CurrentDir.GetText ()		// for Wells Fargo, it asks for Connection type
				[ ] bMatch = MatchStr("*{sText}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] AddAnyAccount.AddSavingsAccount.Select(lsAccountData[6])
					[ ] AddAnyAccount.Next.Click ()
				[ ] 
				[ ] AddAnyAccount.BankUserID.SetText(lsAccountData[3])      //Enter user id      d_knievel17	Quicken70
				[ ] AddAnyAccount.BankPassword.SetText(lsAccountData[4])   // Enter password
				[+] if(AddAnyAccount.AccountNumber.Exists() == TRUE)			// Enter Account no. (for some bank it is mandatory e.g. Scottrade )
					[ ] AddAnyAccount.AccountNumber.SetText(lsAccountData[7])
				[ ] 
				[+] if(AddAnyAccount.Next.IsEnabled() == FALSE)			// Connect/Next button is disabled for blank user id and password
					[ ] ReportStatus("Verify Next Button Status", WARN, "Connect (Next) button is disabled")
					[ ] bFlag = TRUE
					[ ] 
				[+] else
					[ ] AddAnyAccount.Next.Click ()
					[+] if(AddAnyAccount.Exists(150) == TRUE)
						[+] while(UnableToConnect.Exists(10))		// check whether any error message "Quicken is not able to connect to internet" is displayed or not
							[ ] UnableToConnect.OK.Click ()
							[ ] goto ErrorMessage				
							[ ] 
						[ ] 
						[+] if(BankAccess.Exists(10))				// for some bank security key / MFA is asked
							[ ] BankAccess.SetActive()
							[+] if(ListCount(lsQuestion)>0 && ListCount(lsAnswer)>0)					// check whether list of Question and answer is not empty
								[ ] sText = BankAccess.SecurityMessage.SecurityQuestion.GetText()	// get the question from security window
								[+] for(j=1;j<=ListCount(lsQuestion);j++)			
									[ ] bMatch = MatchStr("*{lsQuestion[j]}*", sText)				// verify the question displayed in security window matches with any of the questions mentioned in data sheet
									[+] if(bMatch == TRUE)
										[ ] BankAccess.SecurityMessage.SecurityAnswer.SetText(lsAnswer[j])	// enter the answer after the match is successful
										[ ] break
									[+] else
										[ ] continue
							[ ] 
							[ ] BankAccess.OK.Click()
							[+] if(MessageBox.Exists(SHORT_SLEEP))
								[ ] MessageBox.SetActive()
								[ ] MessageBox.OK.Click()
								[ ] BankAccess.Cancel.Click()
						[ ] 
						[+] if(AddAnyAccount.Exists(150))
							[ ] //AddAnyAccount.VerifyEnabled(TRUE, 300)
							[+] if(AddAnyAccount.Nickname.Exists (10))			// For some account type Account nick name window is displayed
								[ ] AddAnyAccount.SetActive ()
								[ ] AddAnyAccount.Next.Click()
								[ ] AddAnyAccount.VerifyEnabled(TRUE, 150)
								[ ] AddAnyAccount.SetActive()
							[ ] 
							[+] if(AddAnyAccount.BankUserID.Exists () == TRUE)			// for invalid user id/password, login window is displayed again with error message
								[ ] sErrorMsg = AddAnyAccount.ErrorMessage.GetText ()
								[ ] ReportStatus("Verify Error Message", WARN, "Error Message - {sErrorMsg} is displayed")
								[ ] bFlag = TRUE
							[ ] 
							[+] if(AddAnyAccount.SignUpNow.Exists (5))			// for brokerage window, on entering invalid user id/ password different window is displayed with error message
								[ ] AddAnyAccount.SetActive ()
								[ ] sText  = AddAnyAccount.NeedACustomerIDAndPasswor.GetText ()
								[ ] ReportStatus("Verify Error Message", WARN, "Message - {sText} is displayed")
								[ ] //bFlag = TRUE
								[ ] goto CloseWindow
							[ ] 
							[ ] ErrorMessage:
							[+] if(AddAnyAccount.ErrorMessage.Exists (10))
								[ ] AddAnyAccount.SetActive()
								[ ] sErrorMsg = AddAnyAccount.ErrorMessage.GetText ()
								[ ] ReportStatus("Verify Error Message", WARN, "Error Message - {sErrorMsg} is displayed")
								[ ] goto CloseWindow
								[ ] 
							[ ] 
							[+] if(SKU_TOBE_TESTED == "RPM" || SKU_TOBE_TESTED == "HAB")
								[+] if(AddAnyAccount.BankAccounts.ListBox1.Exists (300))			// for valid user id and password, verify Listbox presence for HAB and RPM sku
									[ ] bFlag = FALSE
									[ ] //AddAnyAccount.WellsFargoBank.ListBox1.TextField1.SetText(lsAccountData[5])		// Enter Account name
									[ ] AddAnyAccount.SetActive ()
									[ ] AddAnyAccount.BankAccounts.ListBox1.Select ("#4")
									[ ] AddAnyAccount.BankAccounts.ListBox1.PopupList1.Select (lsAccountData[1])		// Select correct account type
									[ ] AddAnyAccount.Next.Click ()	
							[ ] 
							[+] if(AccountAdded.Exists(300) == TRUE)
								[ ] AccountAdded.VerifyEnabled(TRUE, 300)
								[ ] AccountAdded.SetActive ()
								[ ] AccountAdded.Finish.Click ()
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] bFlag = TRUE
						[ ] 
				[ ] 
				[+] if(bFlag == TRUE)
					[+] CloseWindow:								// Close the window
						[ ] bFlag = TRUE
						[ ] AddAnyAccount.SetActive()
						[ ] AddAnyAccount.Cancel.Click()  				
						[+] if(MessageBox.Exists(SHORT_SLEEP))
							[ ] MessageBox.SetActive()
							[ ] MessageBox.OK1.Click()
				[ ] 
				[+] if(bFlag == FALSE)
					[ ] ReportStatus("Verify Account", PASS, "{lsAccountData[1]} account is added")
				[ ] 
			[+] except
				[ ] ExceptLog()
				[ ] AddAnyAccount.Cancel.Click()  				 //Close the window
				[+] if(MessageBox.Exists(SHORT_SLEEP))		// on clicking cancel button, message box is displayed for confirmation of closing the window
					[ ] MessageBox.SetActive()
					[ ] MessageBox.OK1.Click()
				[ ] 
				[ ] continue
		[ ] 
	[+] except
		[ ] LogException("Some error has occurred")
[ ] 
[ ] // testcase for adding online account
[+] //############# CrerateOnlineAccount #############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 AddOnlineAccountUtility()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase is for adding online accounts
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating online account							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	March 19, 2011	Mamta Jain	created
	[ ] //*********************************************************
[+] testcase AddOnlineAccountUtility () appstate QuickenBaseState    
	[ ] 
	[+] // Variable declarations
		[ ] STRING sDataFile, sWorkSheet
		[ ] sDataFile = "Online_Account_Data"
		[ ] sWorkSheet = "Account_Data"
	[ ] 
	[ ] // Check Quicken main window is enabled
	[ ] QuickenMainWindow.VerifyEnabled(TRUE,50)
	[ ] QuickenMainWindow.SetActive()
	[ ] //Expand Account Bar
	[ ] ExpandAccountBar()
	[ ] // Call data from excel sheet to create online account
	[ ] AddOnlineAccounts(sDataFile, sWorkSheet)
[ ] //############################################################################
[ ] 
[ ] 
