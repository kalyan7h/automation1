[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<C2R.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   <This script contains all Compare 2 register test cases>
	[ ] //
	[ ] // DEPENDENCIES:	<include.inc>
	[ ] //
	[ ] // DEVELOPED BY:	Anagha Bhandare
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] // 	  Nov 18, 2013		Anagha	created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[+] // Global variables
	[ ] //public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] 
	[ ] public STRING sActual,sHandle,sCaption,sAccount,sAccept,sMessage,sAccepted,sUserName,sDataFile,sSourceFile,sCaptionText
	[ ] public STRING sMessageText,sOperationType,sExpected,sIntuitPassword
	[ ] public STRING sAcceptText,sAccountName,sPayeeName,sAcceptAllTransactions,FIWebLink,SFIWebHelpLink,sLogo,sFileName,sFileName2,sFIWebLink
	[ ] public STRING sFilePath,sLastDownloadText
	[ ] public INTEGER iSetupAutoAPI,iOpenDataFile,iSelect,iCounter,iRow,i,j,iResult,iCount,iCount1 ,iListCount
	[ ] public BOOLEAN bCaption,bExists,bCheckStatus,bMatch
	[ ] public LIST OF ANYTYPE lsExcelData,lsPayeeName,lsMessage ,lsMatchedPayeeName
	[ ] public LIST OF STRING lsInvokeOperation={"Edit Button","Right Click"}
	[ ] 
	[ ] public STRING sDateFormate="m/d/yyyy"
	[ ] 
	[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), sDateFormate) 
	[ ] 
	[ ] public STRING WindowName = "MDI"
	[ ] 
	[ ] public STRING sC2RExcelFile="DataForC2R"
	[ ] public STRING sAccountSheet="Accounts"
	[ ] public STRING sPayeeSheet="Payee"
	[ ] public STRING sMessageSheet="Message"
	[ ] public INTEGER iXcord = 1059
	[ ] public INTEGER iYcord = 24
	[ ] 
	[ ] 
[ ] // ==========================================================
[ ] // Global Function
[+] // ==========================================================
	[+] public Integer ActivateDownload(STRING sUserName, STRING sPassword)
		[+] // Variable Declaration
			[ ] STRING sErrorMsg
			[ ] BOOLEAN  bFlag
		[ ] 
		[ ] bFlag = FALSE
		[ ] 
		[+] do
			[+] if(AddAnyAccount.Exists(20) && AddAnyAccount.IsEnabled())
				[ ] AddAnyAccount.SetActive ()
				[ ] 
				[ ] AddAnyAccount.BankUserID.SetText(sUserName)      
				[ ] AddAnyAccount.BankPassword.SetText(sPassword)   
				[ ] WaitforState(AddAnyAccount.Next,TRUE,20)
				[+] if(AddAnyAccount.Next.IsEnabled() == FALSE)			
					[ ] ReportStatus("Verify Next Button Status", FAIL, "Connect (Next) button is disabled")
					[ ] bFlag = TRUE
					[ ] 
				[+] else
					[ ] AddAnyAccount.Next.Click ()
					[ ] sleep(120)
					[ ] AddAnyAccount.Next.Click ()
					[ ] WaitForstate(AddAnyAccount,FALSE,180)
					[+] if(AddAnyAccount.Exists(30) == TRUE)
						[+] while(AlertMessage.Exists(10))		// check whether any error message "Quicken is not able to connect to internet" is displayed or not
							[ ] AlertMessage.OK.Click ()
							[ ] goto ErrorMessage				
							[ ] 
						[ ] 
						[+] if(AddAnyAccount.Exists(10))
							[+] if(AddAnyAccount.BankUserID.Exists () == TRUE)			// for invalid user id/password, login window is displayed again with error message
								[ ] sErrorMsg = AddAnyAccount.ErrorMessage.GetText ()
								[ ] ReportStatus("Verify Error Message", WARN, "Error Message - {sErrorMsg} is displayed")
								[ ] bFlag = TRUE
							[ ] 
							[ ] ErrorMessage:
							[+] if(AddAnyAccount.ErrorMessage.Exists (10))
								[ ] AddAnyAccount.SetActive()
								[ ] sErrorMsg = AddAnyAccount.ErrorMessage.GetText ()
								[ ] ReportStatus("Verify Error Message", WARN, "Error Message - {sErrorMsg} is displayed")
								[ ] goto CloseWindow
								[ ] 
					[+] if(AccountAdded.Exists(140) == TRUE)
							[ ] AccountAdded.VerifyEnabled(TRUE, 5)
							[ ] AccountAdded.SetActive ()
							[ ] AccountAdded.Finish.Click()
							[ ] bFlag = FALSE
				[+] if(bFlag == TRUE)
					[+] CloseWindow:								// Close the window
						[ ] bFlag = TRUE
						[ ] AddAnyAccount.SetActive()
						[ ] AddAnyAccount.Cancel.Click()  				
						[+] if(AlertMessage.Exists(SHORT_SLEEP))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.OK.Click()
				[ ] 
				[+] // if(bFlag == FALSE)
					[ ] // ReportStatus("Verify Account", PASS, "{sBankName} account is added")
			[+] else
				[ ] ReportStatus("Verify Activate One Step Update dialog exists.", FAIL, "Verify Activate One Step Update dialog exists: Activate One Step Update dialog didn't appear.")
			[ ] 
			[ ] iFunctionResult = PASS
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] iFunctionResult = FAIL
			[ ] 
		[ ] 
		[ ] return iFunctionResult
	[ ] 
[ ] 
[+] //#############  C2R SetUp ######################################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	C2R_SetUp()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase it will setup the necessary pre-requisite for tests
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase C2R_SetUp() appstate QuickenBaseState
	[ ] 
	[ ] //------------------ Variable declaration------------------
	[ ] //Copy DC datafile
	[ ] sFileName = "DC_EWC_WEBCONNECT_CLOUD"
	[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] sSourceFile = AUT_DATAFILE_PATH + "\C2R Data File\" + sFileName + ".QDF"
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] ///Copy webconnect accounts file
	[ ] sFileName = "Compare2Register"
	[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] sSourceFile = AUT_DATAFILE_PATH + "\C2R Data File\" + sFileName + ".QDF"
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] 
	[ ] 
	[ ] LaunchQuicken()
	[ ] sleep(5)
	[ ] QuickenWindow.SetActive()
	[ ] //------------------ Open Data File------------------
	[ ] iOpenDataFile = OpenDataFile(sFileName)
	[ ] 
	[ ] // ------------------Report Staus If Data file opened successfully------------------
	[+] if ( iOpenDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is opened")
		[ ] //RegisterQuickenConnectedServices()
	[+] else 
		[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is not opened")
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //############# Accept Button present on each Transaction in C2R #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test01_AcceptButtonOnTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Accept' button in 
		[ ] //front of every transaction in C2R window.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Accept button in front of every transaction works						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_AcceptButtonOnTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] sAccount = "Checking 11" 
	[ ] sAccept = "Accept"
	[ ] iXcord = 1059
	[ ] iYcord = 24
	[ ] sAccepted="Accepted"
	[ ] sAcceptText= "Accept"
	[ ] 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Max"}
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] iCounter=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()*2
			[ ] //------------------Verify the Accept Button for each transaction------------------
			[ ] 
			[+] for(iRow=1,i=1;iRow<=iCounter;iRow=iRow+2,i++)
				[ ] 
				[ ] //iResult=C2RTransactionOperations(lsPayeeName[i],
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iRow))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccept}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Accept Button available",PASS,"Accept Button is available in C2R for '{lsPayeeName[i]}' transaction ")
				[+] else
					[ ] ReportStatus("Check the Accept Button available",FAIL,"Accept Button is not available in C2R for '{lsPayeeName[i]}' transaction")
				[ ] 
				[ ] 
			[ ] //------------------Verify the Accepted status for each transaction after click the Accept Button------------------
			[+] for(iRow=0,i=1;iRow<iCounter-1;i++)
				[ ] 
				[ ] //------------------Click on Accept Button to accept------------------
				[ ] 
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(iRow))
				[ ] 
				[ ] //MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,iXcord,iYcord)
				[ ] MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.TextClick(sAcceptText)
				[ ] sleep(1)
				[ ] //Click on older transaction accept confirmation
				[+] if (AlertMessage.Exists(5))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.DonTShowAgain.Check()
					[ ] AlertMessage.Yes.Click()
					[ ] WaitForState(AlertMessage , FALSE ,5)
					[ ] 
					[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iRow))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"Status of the transaction '{lsPayeeName[i]}' is 'Accepted' after clicking on Accept Button in C2R")
				[+] else
					[ ] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"Status of the transaction '{lsPayeeName[i]}'  is not 'Accepted' after clicking on Accept Button in C2R")
				[ ] 
				[ ] iYcord=iYcord+18
				[ ] iRow=iRow+2
				[ ] 
				[ ] 
			[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
			[+] for(i=1;i<=ListCount(lsPayeeName);i++)
				[ ] 
				[ ] iResult=FindTransaction("MDI",lsPayeeName[i])
				[ ] 
				[+] if(iResult==PASS)
					[ ] 
					[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{lsPayeeName[i]}' got added in Register after clicking on Accept Button in C2R")
				[+] else
					[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{lsPayeeName[i]}' not got added in Register after clicking on Accept Button in C2R")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Accept Button present and functionality on bottom of the C2R ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test02_AcceptButtonOnBottomOfC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Accept' button at the 
		[ ] //bottom of the C2R window.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Accept button in front of every transaction works										
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_AcceptButtonOnBottomOfC2R() appstate none
	[ ] 
	[ ] // ------------------Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 12" 
	[ ] sAccept = "Accept"
	[ ] iXcord = 1059
	[ ] iYcord = 24
	[ ] sAccepted="Accepted"
	[ ] WindowName = "MDI"
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Max"}
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify Accept Button present on bottom of the C2R window------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[+] if(MDIClient.AccountRegister.Accept.Exists(5))
				[ ] ReportStatus("Check Accept Button present",PASS,"Accept Button is present on the bottom of the C2R window")
				[ ] 
				[ ] iCounter=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()*2
				[ ] 
				[ ] //------------------Verify the Accepted status for each transaction after click the Accept Button------------------
				[+] for(iRow=0,i=1;iRow<iCounter-1;iRow=iRow+2,i++)
					[ ] 
					[ ] //------------------Click on Accept Button to accept------------------
					[ ] 
					[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(iRow))
					[ ] 
					[ ] MDIClient.AccountRegister.Accept.Click()
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iRow))
					[ ] 
					[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"Status of the transaction '{lsPayeeName[i]}' is 'Accepted' after clicking on Accept Button in C2R")
						[ ] 
					[+] else
						[ ] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"Status of the transaction '{lsPayeeName[i]}'  is not 'Accepted' after clicking on Accept Button in C2R")
					[ ] 
					[ ] 
				[ ] 
				[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
				[+] for(i=1;i<=ListCount(lsPayeeName);i++)
					[ ] 
					[ ] iResult=FindTransaction(WindowName,lsPayeeName[i])
					[ ] 
					[+] if(iResult==PASS)
						[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{lsPayeeName[i]}' got added in Register after clicking on Accept Button in C2R")
						[ ] 
						[+] if(!MDIClient.AccountRegister.Accept.IsEnabled())
							[ ] ReportStatus("Check Accept Button disabled",PASS,"Accept Button is disabled on the bottom of the C2R window")
						[+] else
							[ ] ReportStatus("Check Accept Button disabled",FAIL,"Accept Button is enabled on the bottom of the C2R window")
						[ ] 
					[+] else
						[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{lsPayeeName[i]}' not got added in Register after clicking on Accept Button in C2R")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Check Accept Button present",FAIL,"Accept Button is present on the bottom of the C2R window")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Help Button present and functionality on bottom of the C2R window ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test03_HelpButtonOnBottomOfC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Help' button at the bottom of the C2R window.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Help' button at the bottom of the C2R window.							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_HelpButtonOnBottomOfC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] sAccount = "Checking 12" 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify Accept Button present on bottom of the C2R window------------------
			[ ] 
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[+] if(MDIClient.AccountRegister.HelpIcon.Exists(5))
				[ ] ReportStatus("Check Help Button present",PASS,"Help Button is present on the bottom of the C2R window")
				[ ] 
				[ ] MDIClient.AccountRegister.HelpIcon.Click()
				[ ] Sleep(2)
				[ ] //------------------Help Dialog gets opened------------------
				[+] if(QuickenHelp.Exists(5))
					[ ] ReportStatus("Verify Help Dialog ", PASS , "Help Dialog is present ")
					[ ] QuickenHelp.Close()
				[+] else
					[ ] ReportStatus("Verify Help Dialog", FAIL , "Help Dialog is not present")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Check Help Button present",FAIL,"Help Button is not present on the bottom of the C2R window")
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Accept All Button present and functionality on bottom of the C2R window ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test04_AcceptAllButtonOnBottomOfC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Accept All' button at the bottom of the C2R window. 
		[ ] //bottom of the C2R window.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Accept All' button at the bottom of the C2R window. 					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_AcceptAllButtonOnBottomOfC2R() appstate none
	[ ] 
	[ ] // ------------------Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 13" 
	[ ] sAccept = "Accept"
	[ ] iXcord = 1059
	[ ] iYcord = 24
	[ ] sAccepted="Accepted"
	[ ] WindowName = "MDI"
	[ ] sMessage="There are no downloaded transactions to accept." 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Max"}
	[ ] sCaptionText="Undo Accept All"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify Accept All Button present on bottom of the C2R window------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] 
			[+] if(MDIClient.AccountRegister.AcceptAll.Exists(5))
				[ ] 
				[ ] ReportStatus("Check Accept All Button present",PASS,"Accept All Button is present on the bottom of the C2R window")
				[ ] 
				[ ] //------------------Click on Accept All Button for accepting all the transactions------------------
				[ ] 
				[ ] MDIClient.AccountRegister.AcceptAll.Click()
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
				[ ] 
				[+] for(i=1;i<=ListCount(lsPayeeName);i++)
					[ ] 
					[ ] iResult=FindTransaction(WindowName,lsPayeeName[i])
					[ ] 
					[+] if(iResult==PASS)
						[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{lsPayeeName[i]}' got added in Register after clicking on Accept Button in C2R")
					[+] else
						[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{lsPayeeName[i]}' not got added in Register after clicking on Accept Button in C2R")
					[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] MDIClient.AccountRegister.StaticText1.QWinChild.HideButton.DoubleClick()
				[ ] 
				[ ] Sleep(1)
				[ ] 
				[ ] //------------------Verify the Accept all button is renamed to 'Undo Accept All'-----------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sCaption=MDIClient.AccountRegister.AcceptAll.GetCaption()
				[ ] 
				[ ] bMatch=MatchStr("*{sCaptionText}*",sCaption)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check Accept all button is renamed",PASS,"Accept all button is renamed to 'Undo Accept All' in C2R window")
				[+] else
					[ ] ReportStatus("Check Accept all button is renamed",FAIL,"'{sCaption}' Accept all button is renamed to 'Undo Accept All' in C2R window")
					[ ] 
				[ ] //------------------Verify the "There are no downloaded transactions to accept." message is displayed.------------------
				[ ] 
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
				[ ] 
				[ ] bMatch= MatchStr("*{sMessage}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check Message in C2R window",PASS,"'There are no downloaded transactions to accept.' message is displayed.")
				[+] else
					[ ] ReportStatus("Check Message in C2R window",FAIL,"'{sActual}' & 'There are no downloaded transactions to accept.' message is not displayed.")
					[ ] 
				[ ] //------------------Verify the Accept, Hide Accepted buttons are disabled.------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] 
				[+] if(!MDIClient.AccountRegister.Accept.IsEnabled())
					[ ] 
					[ ] ReportStatus("Check Accept Button disabled",PASS,"Accept Button is disabled on the bottom of the C2R window")
					[ ] 
				[+] else
					[ ] ReportStatus("Check Accept Button disabled",FAIL,"Accept Button is enabled on the bottom of the C2R window")
					[ ] 
				[+] if(!MDIClient.AccountRegister.HideAccepted.IsEnabled())
					[ ] 
					[ ] ReportStatus("Check Hide Accepted Button disabled",PASS,"Hide Accepted Button is disabled on the bottom of the C2R window")
					[ ] 
				[+] else
					[ ] 
					[ ] ReportStatus("Check Hide Accepted Button disabled",FAIL,"Hide Accepted Button is enabled on the bottom of the C2R window")
				[ ] 
			[+] else
				[ ] ReportStatus("Check Accept Button present",FAIL,"Accept Button is present on the bottom of the C2R window")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Finish Later Button present and functionality on bottom of the C2R window ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test06_FinishLaterButtonOnBottomOfC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Finish Later' button at the bottom of the C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Finish Later' button at the bottom of the C2R window.					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test06_FinishLaterButtonOnBottomOfC2R() appstate none
	[ ] 
	[ ] // ------------------Variable declaration & definition------------------
	[ ] sAccount = "Checking 14" 
	[ ] sAccept = "Accept"
	[ ] iXcord = 1059
	[ ] iYcord = 24
	[ ] sAccepted="Accepted"
	[ ] sMessage="There are no downloaded transactions to accept." 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Max"}
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify Finish Later Button present on bottom of the C2R window------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[+] if(MDIClient.AccountRegister.FinishLater.Exists(5))
				[ ] 
				[ ] ReportStatus("Check Finish Later Button present",PASS,"Finish Later Button is present on the bottom of the C2R window")
				[ ] 
				[ ] //------------------Click on Finish Later Button for accepting all the transactions------------------
				[ ] 
				[ ] MDIClient.AccountRegister.FinishLater.Click()
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] 
				[ ] //------------------Verify the Accept, Hide Accepted buttons are disabled.------------------
				[ ] 
				[+] if(!MDIClient.AccountRegister.Accept.Exists(5))
					[ ] 
					[ ] ReportStatus("Check Accept Button exists",PASS,"C2R window got minimized as Accept Button not exists")
					[ ] 
				[+] else
					[ ] ReportStatus("Check Accept Button exists",FAIL,"C2R window not got minimized as Accept Button not exists")
					[ ] 
				[ ] 
				[ ] //------------------Verify all transactions are in C2R window.------------------
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] MDIClient.AccountRegister.StaticText1.QWinChild.HideButton.Click(1.13,5)
				[ ] //MDIClient.AccountRegister.StaticText1.QWinChild.HideButton.Click()
				[ ] 
				[ ] Sleep(1)
				[ ] 
				[ ] iCounter=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()*2
				[ ] 
				[+] for(iRow=1,i=1;iRow<=iCounter;iRow=iRow+2,i++)
					[ ] 
					[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iRow))
					[ ] 
					[ ] bMatch= MatchStr("*{sAccept}*",sActual)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Check the transaction",PASS,"'{lsPayeeName[i]}' transaction is available in C2R")
					[+] else
						[ ] ReportStatus("Check the transaction",FAIL,"'{lsPayeeName[i]}' transaction is not available in C2R")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Check Finish Later Button present",FAIL,"Finish Later Button is present on the bottom of the C2R window")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Renaming Rules Button present and functionality on bottom of the C2R window ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test07_RenamingRulesButtonOnBottomOfC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Renaming Rules' button at the bottom of the C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Renaming Rules' button at the bottom of the C2R window.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_RenamingRulesButtonOnBottomOfC2R() appstate none
	[ ] 
	[ ] // ------------------Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 14" 
	[ ] sAccept = "Accept"
	[ ] iXcord = 1059
	[ ] iYcord = 24
	[ ] sAccepted="Accepted"
	[ ] sMessage="There are no downloaded transactions to accept." 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Max"}
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify Renaming Rules Button present on bottom of the C2R window------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[+] if(MDIClient.AccountRegister.RenamingRules.Exists(5))
				[ ] 
				[ ] ReportStatus("Check Renaming Rules Button present",PASS,"Renaming Rules Button is present on the bottom of the C2R window")
				[ ] 
				[ ] //------------------Click onRenaming Rules Button for accepting all the transactions------------------
				[ ] 
				[ ] MDIClient.AccountRegister.RenamingRules.Click()
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Renaming Rules Dialog gets opened------------------
				[+] if(RenamingRules.Exists(5))
					[ ] ReportStatus("Verify Renaming Rules Dialog ", PASS , "Renaming Rules Dialog is present ")
					[ ] RenamingRules.Done.Click()
				[+] else
					[ ] ReportStatus("Verify Renaming Rules Dialog", FAIL , "Renaming Rules Dialog is not present")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Check Renaming Rules Button present",FAIL,"Renaming Rules Button is present on the bottom of the C2R window")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Hide Accepted Button present and functionality on bottom of the C2R window ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test08_HideAcceptedButtonOnBottomOfC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Hide Accepted' button at the bottom of C2R window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Hide Accepted' button at the bottom of C2R window							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08A_HideAcceptedButtonOnBottomOfC2R() appstate none
	[ ] 
	[ ] // ------------------Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 14" 
	[ ] sAccept = "Accept"
	[ ] iXcord = 1059
	[ ] iYcord = 24
	[ ] sAccepted="Accepted"
	[ ] sMessage="There are no downloaded transactions to accept." 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Max"}
	[ ] sCaptionText="Show Accepted"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify Hide Accepted Button present on bottom of the C2R window------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[+] if(MDIClient.AccountRegister.HideAccepted.Exists(5))
				[ ] 
				[ ] ReportStatus("Check Hide Accepted Button present",PASS,"Hide Accepted Button is present on the bottom of the C2R window")
				[ ] 
				[ ] //Verify  'Hide Accepted' button is disabled.
				[+] if(!MDIClient.AccountRegister.HideAccepted.IsEnabled())
					[ ] 
					[ ] ReportStatus("Check Hide Accepted Button is not enabled",PASS,"Hide Accepted Button is not enabled on the bottom of the C2R window")
					[ ] 
					[ ] //Accept first transaction from C2R
					[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(1))
					[ ] 
					[ ] MDIClient.AccountRegister.Accept.Click()
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(1))
					[ ] 
					[ ] bMatch= MatchStr("*{sAccept}*",sActual)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"Status of the transaction '{lsPayeeName[1]}' is 'Accepted' after clicking on Accept Button in C2R")
					[+] else
						[ ] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"Status of the transaction '{lsPayeeName[1]}'  is not 'Accepted' after clicking on Accept Button in C2R")
					[ ] 
					[ ] Sleep(2)
					[ ] 
					[ ] //Verify the transaction in Register
					[ ] iResult=FindTransaction("MDI",lsPayeeName[1])
					[ ] 
					[+] if(iResult==PASS)
						[ ] ReportStatus("Check the transaction",PASS,"'{lsPayeeName[1]}' transaction is available in Register")
					[+] else
						[ ] ReportStatus("Check the transaction",FAIL,"'{lsPayeeName[1]}' transaction is available in Register")
						[ ] 
					[ ] 
					[ ] Sleep(1)
					[ ] 
					[ ] //Verify  'Hide Accepted' button is enabled.
					[+] if(MDIClient.AccountRegister.HideAccepted.IsEnabled())
						[ ] 
						[ ] ReportStatus("Check Hide Accepted Button is  enabled",PASS,"Hide Accepted Button is enabled on the bottom of the C2R window")
						[ ] 
						[ ] //Click on Hide Accepted Button to verify the functionality
						[ ] MDIClient.AccountRegister.HideAccepted.Click()
						[ ] 
						[ ] Sleep(1)
						[ ] 
						[ ] //Verify the accepted transaction in C2R after clicking on Hide Accepted
						[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
						[ ] 
						[ ] bMatch= MatchStr("*{sAccept}*",sActual)
						[ ] 
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Check the transaction",PASS,"'{lsPayeeName[1]}' transaction is available in C2R")
						[+] else
							[ ] ReportStatus("Check the transaction",FAIL,"'{lsPayeeName[1]}' transaction is not available in C2R")
						[ ] 
						[ ] //Verify the Caption of Hide Accepted button to change to Show Accepted
						[ ] sCaption=MDIClient.AccountRegister.HideAccepted.GetCaption()
						[ ] 
						[ ] bMatch=MatchStr("*{sCaptionText}*",sCaption)
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Check Show Accepted Button is enabled",PASS,"Show Accepted Button is enabled on the bottom of the C2R window")
							[ ] 
						[+] else
							[ ] ReportStatus("Check Show Accepted Button is enabled",FAIL,"Show Accepted Button is not enabled on the bottom of the C2R window")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Check Hide Accepted Button is not enabled",FAIL,"Hide Accepted Button is not enabled on the bottom of the C2R window")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Check Hide Accepted Button is enabled",FAIL,"Hide Accepted Button is enabled on the bottom of the C2R window")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Check Hide Accepted Button present",FAIL,"Hide Accepted Button is present on the bottom of the C2R window")
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Show Accepted Button present and functionality on bottom of the C2R window ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test08_HideAcceptedButtonOnBottomOfC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Hide Accepted' button at the bottom of C2R window
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Hide Accepted' button at the bottom of C2R window						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08B_ShowAcceptedButtonOnBottomOfC2R() appstate none
	[ ] 
	[ ] // ------------------Variable declaration & definition------------------
	[ ] sAccount = "Checking 14" 
	[ ] sAccept = "Accept"
	[ ] iXcord = 1059
	[ ] iYcord = 24
	[ ] sAccepted="Accepted"
	[ ] sMessage="There are no downloaded transactions to accept." 
	[ ] lsPayeeName={"Matt","Max","Sam","David","Tom"}
	[ ] sCaptionText="Show Accepted"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] // 
		[+] // if(iSelect == PASS)
			[ ] // ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify Show Accepted Button present on bottom of the C2R window------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[+] if(MDIClient.AccountRegister.HideAccepted.Exists(5))
				[ ] 
				[ ] ReportStatus("Check Hide Accepted Button present",PASS,"Hide Accepted Button is present on the bottom of the C2R window")
				[ ] 
				[ ] //Verify the Caption of show Accepted button to change to Show Accepted
				[ ] sCaption=MDIClient.AccountRegister.HideAccepted.GetCaption()
				[ ] 
				[ ] bMatch=MatchStr("*{sCaptionText}*",sCaption)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] ReportStatus("Check Show Accepted Button is enabled",PASS,"Show Accepted Button is enabled on the bottom of the C2R window")
					[ ] 
					[ ] //Click on Hide Accepted Button to verify the functionality
					[ ] MDIClient.AccountRegister.HideAccepted.Click()
					[ ] 
					[ ] Sleep(2)
					[ ] 
					[ ] //Accept first transaction from C2R
					[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(1))
					[ ] 
					[ ] bMatch= MatchStr("*{sAccept}*",sActual)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Check the transaction",PASS,"'{lsPayeeName[1]}' transaction is available in C2R")
					[+] else
						[ ] ReportStatus("Check the transaction",FAIL,"'{lsPayeeName[1]}' transaction is not available in C2R")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Check Show Accepted Button is enabled",FAIL,"Show Accepted Button is not enabled on the bottom of the C2R window")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Check Hide Accepted Button is enabled",FAIL,"Hide Accepted Button is enabled on the bottom of the C2R window")
				[ ] 
			[ ] 
		[+] // else
			[ ] // ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Edit Menu-Delete Transaction in C2R ###################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test09_EditMenuDeleteTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that user can delete downloaded transactions from C2R.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If user can delete downloaded transactions from C2R.					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test09_EditMenuDeleteTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 14" 
	[ ] sAccept = "Edit"
	[ ] sAccepted="Accepted"
	[ ] lsPayeeName={"David","Tom","Sam","Max"}
	[ ] sCaptionText="Delete"
	[ ] sMessageText="Delete the downloaded transaction?"
	[ ] sOperationType="Delete"
	[ ] 
	[+] // //----------Retrieving Data from ExcelSheet----------
		[ ] // lsExcelData=ReadExcelTable(sC2RExcelFile, sAccountSheet)
		[ ] // lsPayeeName=ReadExcelTable(sC2RExcelFile, sPayeeSheet)
		[ ] // lsMessage=ReadExcelTable(sC2RExcelFile, sMessageSheet)
		[ ] // sAccount=lsExcelData[7][1]
		[ ] // sAccept=lsMessage[1][1]
		[ ] // sAccepted=lsMessage[2][1]
		[ ] // sCaptionText=lsMessage[2][2]
		[ ] // sMessageText=lsMessage[4][1]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify the Edit Menu-Delete for  transaction------------------
			[ ] 
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] iResult=C2RTransactionOperations(lsPayeeName[2],lsInvokeOperation[1],sOperationType)
			[+] //
				[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] // 
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(3))
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,55)
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Delete.Pick()
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[+] if(iResult==PASS)
				[+] if(AlertMessage.Exists(5))
					[ ] 
					[ ] sMessage=AlertMessage.MessageText.GetText()
					[ ] 
					[ ] bMatch=MatchStr("*{sMessageText}*",sMessage)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] ReportStatus("Delete -Edit menu in C2R",PASS,"Edit Menu-Delete downloaded transactions from C2R")
						[ ] 
						[ ] AlertMessage.Yes.Click()
						[ ] 
						[ ] Sleep(2)
						[ ] 
						[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(2))
						[ ] 
						[ ] bMatch= MatchStr("*{lsPayeeName[2]}*",sActual)
						[ ] 
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Check the Edit Menu-Delete for transaction in C2R",PASS,"'{lsPayeeName[4]}' transaction got deleted Successfully ")
						[+] else
							[ ] ReportStatus("Check the Edit Menu-Delete for transaction in C2R",FAIL,"'{lsPayeeName[4]}' transaction not got deleted Successfully ")
						[ ] 
						[ ] 
						[ ] iResult=C2RTransactionOperations(lsPayeeName[3],lsInvokeOperation[1],sOperationType)
						[ ] 
						[+] //
							[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(2))
							[ ] // 
							[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,42)
							[ ] // 
							[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Delete.Pick()
						[ ] 
						[ ] Sleep(2)
						[+] if(iResult==PASS)
							[+] if(AlertMessage.Exists(5))
								[ ] 
								[ ] sMessage=AlertMessage.MessageText.GetText()
								[ ] 
								[ ] bMatch=MatchStr("*{sMessageText}*",sMessage)
								[ ] 
								[+] if(bMatch==TRUE)
									[ ] 
									[ ] ReportStatus("Delete -Edit menu in C2R",PASS,"Edit Menu-Delete downloaded transactions from C2R")
									[ ] 
									[ ] AlertMessage.No.Click()
									[ ] 
									[ ] Sleep(2)
									[ ] 
									[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
									[ ] 
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(2))
									[ ] 
									[ ] bMatch= MatchStr("*{lsPayeeName[3]}*",sActual)
									[ ] 
									[+] if(bMatch==TRUE)
										[ ] ReportStatus("Check the Edit Menu-Delete for transaction in C2R",PASS,"'{lsPayeeName[3]}' transaction not got deleted successfully ")
									[+] else
										[ ] ReportStatus("Check the Edit Menu-Delete for transaction in C2R",FAIL,"'{lsPayeeName[3]}' transaction got deleted successfully ")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Delete -Edit menu in C2R",FAIL,"Edit Menu-Delete downloaded transactions from C2R message is not present")
							[+] else
								[ ] ReportStatus("Check Delete transaction confirmation window",FAIL,"Delete transaction confirmation window is not present")
						[+] else
							[ ] ReportStatus("Delete Operation is not performed for Second Time",FAIL,"Delete Operation is not performed for Second Time")
						[ ] 
					[+] else
						[ ] ReportStatus("Delete -Edit menu in C2R",FAIL,"Edit Menu-Delete downloaded transactions from C2R message is not present")
				[+] else
					[ ] ReportStatus("Check Delete transaction confirmation window",FAIL,"Delete transaction confirmation window is not present")
			[+] else
				[ ] ReportStatus("Delete Operation is not performed for First Time",FAIL,"Delete Operation is not performed for First Time")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Edit Menu- Match Manually Transaction in C2R ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test10_EditMatchManuallyTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that user can match transactions in C2R to checking register using 'Match Manually' option.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If user can match transactions in C2R to checking register using 'Match Manually' option					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test10_EditMatchManuallyTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 15" 
	[ ] sAccept = "Edit"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] sAccepted="Accepted"
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sMessageText="There are no transactions to match."
	[ ] sOperationType="Match Manually"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify the Match Manually -Edit Menu for transaction------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] iResult=C2RTransactionOperations(lsPayeeName[2],lsInvokeOperation[1],sOperationType)
			[+] //
				[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] // 
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,30)
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.MatchManually.Pick()
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] //--------------------------Verify the Message for Match Manually-----------------------------------
			[ ] 
			[+] if(iResult==PASS)
				[+] if(AlertMessage.Exists(5))
					[ ] 
					[ ] sMessage=AlertMessage.MessageText.GetText()
					[ ] 
					[ ] bMatch=MatchStr("*{sMessageText}*",sMessage)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] ReportStatus("Match Manually -Edit menu in C2R",PASS,"Edit Menu-Match Manually downloaded transactions from C2R")
						[ ] 
						[ ] AlertMessage.Yes.Click()
						[ ] 
						[ ] Sleep(2)
						[ ] 
						[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(3))
						[ ] 
						[ ] bMatch= MatchStr("*{lsPayeeName[2]}*",sActual)
						[ ] 
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Check the Edit Menu-Match Manually for transaction in C2R",PASS,"'{lsPayeeName[2]}' transaction got matched manually ")
						[+] else
							[ ] ReportStatus("Check the Edit Menu-Match Manually for transaction in C2R",FAIL,"'{lsPayeeName[2]}' transaction not got matched manually ")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Match Manually -Edit menu in C2R",FAIL,"Edit Menu-Match Manually downloaded transactions from C2R message is not present")
					[ ] 
				[+] else
					[ ] 
					[+] if(ManuallyMatchTransactions.Exists(5))
						[ ] ReportStatus("Match Manually -Edit menu in C2R",PASS,"Edit Menu-Match Manually downloaded transactions from C2R")
						[ ] ManuallyMatchTransactions.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Match Manually -Edit menu in C2R",FAIL,"Edit Menu-Match Manually downloaded transactions window not available")
			[+] else
				[ ] ReportStatus("Match Manually Operation is not performed",FAIL,"Match Manually Operation is not performed")
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Edit Menu- Make New Transaction in C2R ###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test11_EditMakeNewTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that user can change the status of matched transactions to New' using 'Make New' option.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If user can change the status of matched transactions to New' using 'Make New' option							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test11_EditMakeNewTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 15" 
	[ ] sAccept = "Match"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] sAccepted="New"
	[ ] sPayee="Test2"
	[ ] WindowName = "MDI"
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sOperationType="Make New"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] iResult=FindTransaction(WindowName,sPayee)
			[ ] 
			[+] if(iResult==PASS)
				[ ] 
				[ ] //------------------Verify the Make New -Edit Menu for transaction------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccept}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'Match' ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'Match' ")
				[ ] 
				[ ] 
				[ ] iResult=C2RTransactionOperations(lsPayeeName[1],lsInvokeOperation[1],sOperationType)
				[ ] 
				[+] //
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
					[ ] // 
					[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,30)
					[ ] // 
					[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.MakeNew.Pick()
				[ ] 
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Verify the Edit Button for each transaction------------------
				[ ] 
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(4))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'New'  ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is as 'New' ")
				[ ] 
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(4))
				[ ] 
				[ ] MDIClient.AccountRegister.Accept.Click()
				[ ] 
				[ ] 
				[ ] iResult=FindTransaction("MDI",lsPayeeName[1])
				[ ] 
				[+] if(iResult==PASS)
					[ ] ReportStatus("Check transaction is added as a new transaction",PASS,"Transaction is added as a new transaction ")
				[+] else
					[ ] ReportStatus("Check transaction is added as a new transaction",FAIL,"Transaction is added as a new transaction ")
				[ ] 
			[+] else
				[ ] ReportStatus("Find matched transaction in Register",FAIL,"Matched transaction in Register is not found")
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Edit Menu- Make All New Transaction in C2R #############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test12_EditMakeAllNewTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that user can change the status of all matched transactions to 'New' using 'Make all New' options.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If user can change the status of all matched transactions to 'New' using 'Make all New' options.				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test12_EditMakeAllNewTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] sAccount = "Checking 15" 
	[ ] sAccept = "Match"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] sAccepted="New"
	[ ] sPayee="Test3"
	[ ] WindowName = "MDI"
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sOperationType="Make All New"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] iResult=FindTransaction(WindowName,sPayee)
			[ ] 
			[+] if(iResult==PASS)
				[ ] 
				[ ] //------------------Verify the Make All New -Edit Menu for transaction-------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccept}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'Match' ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'Match' ")
				[ ] 
				[ ] 
				[ ] iResult=C2RTransactionOperations(lsPayeeName[2],lsInvokeOperation[1],sOperationType)
				[ ] 
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,24)
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.MakeAllNew.Pick()
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Verify the Edit Button for each transaction------------------
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'New' after selecting Edit Menu-Make All New ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is as 'New' after selecting Edit Menu-Make All New ")
				[ ] 
			[+] else
				[ ] ReportStatus("Find matched transaction in Register",FAIL,"Matched transaction in Register is not found")
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Edit Menu-UnMatch Transaction in C2R #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test13_EditUnMatchTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify functionality of 'Unmatch' option in Edit menu when Banking 
		[ ] //register contains more than one transactions matching to the single downloaded transactions in C2R.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If functionality of 'Unmatch' option in Edit menu works correctly						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test13_EditUnMatchTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 15" 
	[ ] sAccept = "Match"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] sAccepted="New"
	[ ] sPayee="Test4"
	[ ] WindowName = "MDI"
	[ ] 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sOperationType="Unmatch"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] iResult=FindTransaction(WindowName,sPayee)
			[ ] 
			[+] if(iResult==PASS)
				[ ] 
				[ ] //------------------Verify the UnMatch-Edit Menu for transaction------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(2))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccept}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'Match' ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'Match' ")
				[ ] 
				[ ] 
				[ ] iResult=C2RTransactionOperations(lsPayeeName[6],lsInvokeOperation[1],sOperationType)
				[+] 
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
					[ ] // 
					[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,30)
					[ ] // 
					[ ] // 
					[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.UnMatch.Pick()
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Verify the Edit Button for each transaction------------------
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(2))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'New' after selecting Edit Menu-UnMatch ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is as 'New' after selecting Edit Menu-UnMatch ")
				[ ] 
			[+] else
				[ ] ReportStatus("Find matched transaction in Register",FAIL,"Matched transaction in Register is not found")
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Edit Menu-Revert to Original Payee Transaction in C2R #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test14_EditRevertOriginalPayeeInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that user can revert back to Original Payee and override the payee selected by ACE or naming rules. 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	Ifuser can revert back to Original Payee and override the payee selected by ACE or naming rules. 						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test14_EditRevertOriginalPayeeInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 15" 
	[ ] sAccept = "Transworld"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] sAccepted="Transworld Air1234"
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sOperationType="Revert Payee"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] 
			[ ] //------------------Verify the Revert to Original Payee-Edit Menu for transaction------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
			[ ] 
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(4))
			[ ] 
			[ ] bMatch= MatchStr("*{sAccept}*",sActual)
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check the Payee of the matched transaction",PASS,"The Payee of the matched transaction is as '{sAccept}' ")
			[+] else
				[ ] ReportStatus("Check the Payee of the matched transaction",FAIL,"The Payee of the matched transaction is not as '{sAccept}' ")
			[ ] 
			[ ] 
			[ ] iResult=C2RTransactionOperations(lsPayeeName[5],lsInvokeOperation[1],sOperationType)
			[ ] 
			[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(4))
			[ ] // 
			[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,52)
			[ ] // 
			[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.RevertPayee.Pick()
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] //------------------Verify the Edit Button for each transaction------------------
			[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
			[ ] 
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(4))
			[ ] 
			[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check the original payee name ",PASS,"The Original Payee Name has got reverted to {sAccepted} ")
			[+] else
				[ ] ReportStatus("Check the original payee name",FAIL,"The Original Payee Name has not got reverted to {sAccepted} ")
				[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Edit Menu- Renaming RulesTransaction in C2R ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test15_RenamingRulesButtonOnBottomOfC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Renaming Rules' button at the bottom of the C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Renaming Rules' button at the bottom of the C2R window.					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test15_EditRenamingRulesTransactionInC2R() appstate none
	[ ] 
	[ ] // ------------------Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 14" 
	[ ] sAccept = "Accept"
	[ ] iXcord = 1059
	[ ] iYcord = 24
	[ ] sAccepted="Accepted"
	[ ] sOperationType="Show Renaming Rules"
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify the Renaming Rules-Edit Menu for transaction------------------
			[ ] 
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] iResult=C2RTransactionOperations(lsPayeeName[6],lsInvokeOperation[1],sOperationType)
			[ ] 
			[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
			[ ] // 
			[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(3))
			[ ] // 
			[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,52)
			[ ] // 
			[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.ShowRenamingRules.Pick()
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] //------------------Renaming Rules Dialog gets opened------------------
			[+] if(RenamingRules.Exists(5))
				[ ] ReportStatus("Verify Renaming Rules Dialog ", PASS , "Renaming Rules Dialog is present ")
				[ ] RenamingRules.Done.Click()
			[+] else
				[ ] ReportStatus("Verify Renaming Rules Dialog", FAIL , "Renaming Rules Dialog is not present")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click Menu Accept Transaction in C2R ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test17_RightClickMenuAcceptTransactionC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Acdept Transaction' Right Click menu of C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 28, 2013		Girish	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test17_RightClickMenuAcceptTransactionC2R() appstate none
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sAcceptTransaction,sPayeeName
	[ ] 
	[ ] sAccount = "Checking 14" 
	[ ] sAcceptTransaction = "Accept Transaction"
	[ ] sAccepted="Accepted"
	[ ] sPayeeName="David"
	[ ] 
	[ ] 
	[ ] sOperationType="Accept"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] 
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------Right Click-Accept Transaction From C2R into Register-----------------------
			[ ] 
			[ ] iResult=C2RTransactionOperations(sPayeeName,lsInvokeOperation[2],sOperationType)
			[ ] 
			[ ] sleep(3)
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] // MDIClient.AccountRegister.StaticText1.QWinChild.HideButton.Click()
			[ ] 
			[ ] //------------------Verify Status of the transaction should get chenged to Accepted in C2R
			[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
			[ ] 
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
			[ ] 
			[ ] bMatch= MatchStr("*{sAccepted}*{sPayeeName}*",sActual)
			[ ] 
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"Status of the transaction '{sPayeeName}' is 'Accepted' after right clicking on Accept transaction in C2R")
				[ ] 
				[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
				[ ] //As matching is done using already entered transaction
				[ ] sPayeeName="Test1"
				[ ] 
				[ ] iResult=FindTransaction("MDI",sPayeeName)
				[ ] 
				[+] if(iResult==PASS)
					[ ] 
					[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{sPayeeName}' got added in Register after right clicking on Accept transaction in C2R")
					[ ] 
				[+] else
					[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{sPayeeName}' not got added in Register after right clicking on Accept transaction in C2R")
					[ ] 
			[+] else
				[ ] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"Status of the transaction '{sPayeeName}'  is not 'Accepted' right clicking on Accept transaction in C2R")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click Menu Accept Transaction in C2R ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test18_RightClickMenuAcceptAllTransactionC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Accept All Transaction' Right Click menu of C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 28, 2013		Girish	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test18_RightClickMenuAcceptALLTransactionC2R() appstate none
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sAccepted,sAcceptAllTransaction
	[ ] INTEGER iXcord,iYcord
	[ ] 
	[ ] 
	[ ] sAccount = "Checking 14" 
	[ ] sAcceptAllTransaction = "Accept All Transactions"
	[ ] iXcord = 96
	[ ] iYcord = 13
	[ ] sAccepted="There are no downloaded transactions to accept."
	[ ] // lsPayeeName={"Tom","Max"}
	[ ] lsPayeeName={"Sam","Max"}
	[ ] 
	[ ] sOperationType="Accept All"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
				[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
				[ ] 
				[ ] //------------------Right Click Accept All Transaction from C2R into Register------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] iResult=C2RTransactionOperations(lsPayeeName[1],lsInvokeOperation[2],sOperationType)
				[+] 
					[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] // 
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
					[ ] // 
					[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(2,iXcord,iYcord)
					[ ] // 
					[ ] // //------------Right Click-Accept All Transaction From C2R into Register-----------------------
					[ ] // C2RRightClick.AcceptAllTransaction.Pick()
				[ ] 
				[ ] sleep(3)
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] // MDIClient.AccountRegister.StaticText1.QWinChild.HideButton.Click()
				[ ] sleep(1)
				[ ] 
				[ ] //------------------Verify there are no transactions left to be Accepted in C2R-------------------------
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[ ] 
				[+] if(bMatch)
					[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"There are no transactions left in the C2R to be Accepted as string:{sAccepted} displayed")
				[+] else
					[ ] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"There are some  transactions:{sActual} left in the C2R that needs to be Accepted")
					[ ] 
				[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
				[+] for(i=1;i<=ListCount(lsPayeeName);i++)		
						[ ] 
						[ ] iResult=FindTransaction("MDI",lsPayeeName[i])
						[ ] 
						[+] if(iResult==PASS)
							[ ] 
							[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{lsPayeeName[i]}' got added in Register after clicking on Accept Button in C2R")
							[ ] 
						[+] else
							[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{lsPayeeName[i]}' not got added in Register after clicking on Accept Button in C2R")
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click Menu Hide Accepted Transaction in C2R ########################################
	[+] // TestCase Name:	Test19_HideAcceptedTransactionC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'hide ' Right Click menu of C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test19_RightClickHideAcceptedTransactionC2R() appstate none
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sAcceptAllTransaction
	[ ] INTEGER count = 0
	[ ] INTEGER count1 = 0
	[ ] 
	[ ] sAccount = "Checking 15" 
	[ ] sAcceptAllTransaction = "Hide accepted transactions"
	[ ] iXcord = 96
	[ ] iYcord = 13
	[ ] sAccepted="Accepted"
	[ ] lsPayeeName={"David","Max","Transworld Air1234"}
	[ ] lsMatchedPayeeName={"Test3","Test4","Transworld Air1234"}
	[ ] 
	[ ] sCaptionText="Show Accepted"
	[ ] sOperationType="Accept"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
				[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
				[ ] 
				[ ] //------------------Right Click on Accept transaction------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] iResult=C2RTransactionOperations(lsPayeeName[2],lsInvokeOperation[2],sOperationType)
				[ ] 
				[+] //
					[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] // 
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
					[ ] // 
					[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(2,iXcord,iYcord)
					[ ] // 
					[ ] // //------------Accept Transaction From C2R into Register-----------------------
					[ ] // C2RRightClick.AcceptTransaction.Pick()
				[ ] 
				[ ] sleep(3)
				[ ] 
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"The Status of the transaction is 'Accepted'")
				[+] else
					[ ] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"The Status of the transaction is not 'Accepted'")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //Verify the transaction in Register
				[ ] iResult=FindTransaction("MDI",lsMatchedPayeeName[2])
				[ ] 
				[+] if(iResult==PASS)
					[ ] ReportStatus("Check the transaction",PASS,"'{lsMatchedPayeeName[2]}' transaction is available in Register")
				[+] else
					[ ] ReportStatus("Check the transaction",FAIL,"'{lsMatchedPayeeName[2]}' transaction is available in Register")
					[ ] 
				[ ] 
				[ ] Sleep(1)
				[ ] 
				[ ] //------------------Right Click on Accept  to accept------------------
				[ ] 
				[ ] sOperationType="Hide Accepted"
				[ ] QuickenWindow.SetActive()
				[ ] iResult=C2RTransactionOperations(lsPayeeName[2],lsInvokeOperation[2],sOperationType)
				[+] 
					[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] // 
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(2))
					[ ] // 
					[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(2,iXcord,iYcord)
					[ ] // 
					[ ] // C2RRightClick.HideAcceptedTransaction.Pick()
				[ ] 
				[ ] Sleep(1)
				[ ] 
				[ ] //Verify the accepted transaction in C2R after clicking on Hide Accepted
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[+] if(bMatch)
					[ ] ReportStatus("Check the transaction",FAIL,"'{lsPayeeName[2]}' transaction is available in C2R")
				[+] else
					[ ] ReportStatus("Check the transaction",PASS,"'{lsPayeeName[2]}' transaction is not available in C2R")
				[ ] 
				[ ] //Verify the Caption of Hide Accepted button to change to Show Accepted
				[ ] sCaption=MDIClient.AccountRegister.HideAccepted.GetCaption()
				[ ] 
				[ ] bMatch=MatchStr("*{sCaptionText}*",sCaption)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check Show Accepted Button is enabled",PASS,"Show Accepted Button is enabled on the bottom of the C2R window")
					[ ] 
				[+] else
					[ ] ReportStatus("Check Show Accepted Button is enabled",FAIL,"Show Accepted Button is not enabled on the bottom of the C2R window")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click Menu-Delete Transaction  in C2R #############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test20_DeleteTransactionRightClickC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that particular transactions in C2R can be deleted using 
		[ ] //'Delete Transaction' option in Right Click Menu.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If 'Delete Transaction' option in Right Click Menu works correctly.					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test20_RightClickDeleteTransactionC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 16" 
	[ ] sAccept = "Accept"
	[ ] iXcord = 1059
	[ ] iYcord = 24
	[ ] sAccepted="Accepted"
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Max"}
	[ ] sMessageText="Delete the downloaded transaction?"
	[ ] sOperationType="Delete"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify the Edit Menu-Delete for  transaction------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] 
			[ ] iResult=C2RTransactionOperations(lsPayeeName[4],lsInvokeOperation[2],sOperationType)
			[+] //
				[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] // 
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(3))
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,55)
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Delete.Pick()
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[+] if(iResult==PASS)
				[+] if(AlertMessage.Exists(5))
					[ ] 
					[ ] sMessage=AlertMessage.MessageText.GetText()
					[ ] 
					[ ] bMatch=MatchStr("*{sMessageText}*",sMessage)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] ReportStatus("Delete -Edit menu in C2R",PASS,"Edit Menu-Delete downloaded transactions from C2R")
						[ ] 
						[ ] AlertMessage.Yes.Click()
						[ ] 
						[ ] Sleep(2)
						[ ] 
						[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
						[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
						[+] for(iCount=0; iCount <= iListCount ; iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
							[ ] bMatch= MatchStr("*{lsPayeeName[4]}*",sActual)
							[+] if(bMatch)
								[ ] break
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Check the Edit Menu-Delete for transaction in C2R",PASS,"'{lsPayeeName[4]}' transaction got deleted Successfully ")
						[+] else
							[ ] ReportStatus("Check the Edit Menu-Delete for transaction in C2R",FAIL,"'{lsPayeeName[4]}' transaction not got deleted Successfully ")
						[ ] 
						[ ] 
						[ ] iResult=C2RTransactionOperations(lsPayeeName[2],lsInvokeOperation[2],sOperationType)
						[ ] 
						[+] //
							[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(2))
							[ ] // 
							[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,42)
							[ ] // 
							[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Delete.Pick()
						[ ] 
						[ ] Sleep(2)
						[+] if(iResult==PASS)
							[+] if(AlertMessage.Exists(5))
								[ ] 
								[ ] sMessage=AlertMessage.MessageText.GetText()
								[ ] 
								[ ] bMatch=MatchStr("*{sMessageText}*",sMessage)
								[ ] 
								[+] if(bMatch==TRUE)
									[ ] 
									[ ] ReportStatus("Delete -Edit menu in C2R",PASS,"Edit Menu-Delete downloaded transactions from C2R")
									[ ] 
									[ ] AlertMessage.No.Click()
									[ ] 
									[ ] Sleep(2)
									[ ] 
									[ ] 
									[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
									[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
									[+] for(iCount=0; iCount <= iListCount ; iCount++)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
										[ ] bMatch= MatchStr("*{lsPayeeName[2]}*",sActual)
										[+] if(bMatch)
											[ ] break
									[+] if(bMatch==TRUE)
										[ ] ReportStatus("Check the Edit Menu-Delete for transaction in C2R",PASS,"'{lsPayeeName[2]}' transaction didn't delete.")
									[+] else
										[ ] ReportStatus("Check the Edit Menu-Delete for transaction in C2R",FAIL,"'{lsPayeeName[2]}' transaction got deleted. ")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Delete -Edit menu in C2R",FAIL,"Edit Menu-Delete downloaded transactions from C2R message is not present")
							[+] else
								[ ] ReportStatus("Check Delete transaction confirmation window",FAIL,"Delete transaction confirmation window is not present")
						[+] else
							[ ] ReportStatus("Delete Operation is not performed for Second Time",FAIL,"Delete Operation is not performed for Second Time")
						[ ] 
					[+] else
						[ ] ReportStatus("Delete -Edit menu in C2R",FAIL,"Edit Menu-Delete downloaded transactions from C2R message is not present")
				[+] else
					[ ] ReportStatus("Check Delete transaction confirmation window",FAIL,"Delete transaction confirmation window is not present")
			[+] else
				[ ] ReportStatus("Delete Operation is not performed for First Time",FAIL,"Delete Operation is not performed for First Time")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click Menu- Match Manually Transaction in C2R #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test21_MatchManuallyTransactionRightClickC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that user can match transactions in C2R to checking register using 'Match Manually' option.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If user can match transactions in C2R to checking register using 'Match Manually' option.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test21_RightClickMatchManuallyTransactionC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 16" 
	[ ] sAccept = "Edit"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] sAccepted="Accepted"
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sMessageText="There are no transactions to match."
	[ ] sOperationType="Match Manually"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify the Match Manually -Edit Menu for transaction------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] iResult=C2RTransactionOperations(lsPayeeName[5],lsInvokeOperation[2],sOperationType)
			[+] //
				[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] // 
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,30)
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.MatchManually.Pick()
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] //--------------------------Verify the Message for Match Manually-----------------------------------
			[ ] 
			[+] if(iResult==PASS)
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.SetActive()
					[ ] sMessage=AlertMessage.MessageText.GetText()
					[ ] 
					[ ] bMatch=MatchStr("*{sMessageText}*",sMessage)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] ReportStatus("Match Manually -Edit menu in C2R",PASS,"Edit Menu-Match Manually downloaded transactions from C2R")
						[ ] 
						[ ] AlertMessage.Yes.Click()
						[ ] 
						[ ] Sleep(2)
						[ ] 
						[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(3))
						[ ] 
						[ ] bMatch= MatchStr("*{lsPayeeName[5]}*",sActual)
						[ ] 
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Check the Edit Menu-Match Manually for transaction in C2R",PASS,"'{lsPayeeName[2]}' transaction got matched manually ")
						[+] else
							[ ] ReportStatus("Check the Edit Menu-Match Manually for transaction in C2R",FAIL,"'{lsPayeeName[2]}' transaction not got matched manually ")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Match Manually -Edit menu in C2R",FAIL,"Edit Menu-Match Manually downloaded transactions from C2R message is not present")
					[ ] 
				[+] else
					[ ] 
					[+] if(ManuallyMatchTransactions.Exists(5))
						[ ] ManuallyMatchTransactions.SetActive()
						[ ] ReportStatus("Verify dialog Match Manually -Edit menu in C2R",PASS,"Dialog Match Manually downloaded transactions from C2R appeared.")
						[ ] ManuallyMatchTransactions.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify dialog Match Manually -Edit menu in C2R",FAIL,"Dialog Match Manually downloaded transactions from C2R didn't appear.")
			[+] else
				[ ] ReportStatus("Match Manually Operation is not performed",FAIL,"Match Manually Operation is not performed")
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click Menu-UnMatch Transaction in C2R ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test22_UnMatchTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify functionality of 'Unmatch' option in Edit menu when Banking 
		[ ] //register contains more than one transactions matching to the single downloaded transactions in C2R.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If functionality of 'Unmatch' option in Edit menu works correctly							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test22_RightClickUnMatchTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 16" 
	[ ] sAccept = "Match"
	[ ] sAccepted="New"
	[ ] sPayee="Test4"
	[ ] WindowName = "MDI"
	[ ] 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sOperationType="Unmatch"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] iResult=FindTransaction(WindowName,sPayee)
			[ ] 
			[+] if(iResult==PASS)
				[ ] 
				[ ] //------------------Verify the UnMatch-Edit Menu for transaction------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccept}*{lsPayeeName[6]}*",sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[ ] 
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'Match' ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'Match' ")
				[ ] 
				[ ] 
				[ ] iResult=C2RTransactionOperations(lsPayeeName[6],lsInvokeOperation[2],sOperationType)
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Verify the Edit Button for each transaction------------------
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount*2 ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccepted}*{lsPayeeName[6]}*",sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'New' after selecting Edit Menu-UnMatch ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'New' after selecting Edit Menu-UnMatch ")
				[ ] 
			[+] else
				[ ] ReportStatus("Find matched transaction in Register",FAIL,"Matched transaction in Register is not found")
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click Menu- Make New Transaction in C2R ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test23_MakeNewTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that user can change the status of matched transactions to New' using 'Make New' option.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If user can change the status of matched transactions to New' using 'Make New' option							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test23_RightClickMakeNewTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 16" 
	[ ] sAccept = "Match"
	[ ] sAccepted="New"
	[ ] sPayee="Test3"
	[ ] WindowName = "MDI"
	[ ] 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sOperationType="Make New"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] iResult=FindTransaction(WindowName,sPayee)
			[ ] 
			[+] if(iResult==PASS)
				[ ] 
				[ ] //------------------Verify the Make New -Edit Menu for transaction------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccept}*",sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'Match' ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'Match' ")
				[ ] 
				[ ] 
				[ ] iResult=C2RTransactionOperations(lsPayeeName[1],lsInvokeOperation[2],sOperationType)
				[ ] 
				[+] //
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
					[ ] // 
					[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,30)
					[ ] // 
					[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.MakeNew.Pick()
				[ ] 
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Verify the Edit Button for each transaction------------------
				[ ] 
				[ ] 
				[ ] 
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[ ] 
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'New'  ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is as 'New' ")
				[ ] 
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
					[+] if(bMatch)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(iCount))
						[ ] break
				[ ] 
				[ ] 
				[ ] 
				[ ] MDIClient.AccountRegister.Accept.Click()
				[ ] 
				[ ] 
				[ ] iResult=FindTransaction("MDI",lsPayeeName[1])
				[ ] 
				[+] if(iResult==PASS)
					[ ] ReportStatus("Check transaction is added as a new transaction",PASS,"Transaction is added as a new transaction ")
				[+] else
					[ ] ReportStatus("Check transaction is added as a new transaction",FAIL,"Transaction is added as a new transaction ")
				[ ] 
			[+] else
				[ ] ReportStatus("Find matched transaction in Register",FAIL,"Matched transaction in Register is not found")
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click Menu- Make All New Transaction in C2R ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test24_MakeAllNewTransactionInC2R() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that user can change the status of all matched transactions to 'New' using 'Make all New' options.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If user can change the status of all matched transactions to 'New' using 'Make all New' options.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test24_RightClickMakeAllNewTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 16" 
	[ ] sAccept = "Match"
	[ ] sAccepted="New"
	[ ] sPayee="Test1"
	[ ] WindowName = "MDI"
	[ ] sOperationType="Make All New"
	[ ] 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] iResult=FindTransaction(WindowName,sPayee)
			[ ] 
			[+] if(iResult==PASS)
				[ ] 
				[ ] //------------------Verify the Make All New -Edit Menu for transaction-------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccept}*",sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'Match' ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'Match' ")
				[ ] 
				[ ] 
				[ ] iResult=C2RTransactionOperations(lsPayeeName[2],lsInvokeOperation[2],sOperationType)
				[ ] 
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Verify the Edit Button for each transaction------------------
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'New' after selecting Edit Menu-Make All New ")
				[+] else
					[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is as 'New' after selecting Edit Menu-Make All New ")
				[ ] 
			[+] else
				[ ] ReportStatus("Find matched transaction in Register",FAIL,"Matched transaction in Register is not found")
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click-Revert to Original Payee Transaction in C2R ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test25_RevertOriginalPayeeInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that user can revert back to Original Payee and override the payee selected by ACE or naming rules. 
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If  user can revert back to Original Payee and override the payee selected by ACE or naming rules. 				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test25_RightClickRevertOriginalPayeeInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 16" 
	[ ] sAccept = "Transworld"
	[ ] sAccepted="Transworld Air1234"
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sOperationType="Revert Payee"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] 
			[+] //------------------Verify the Revert to Original Payee-Edit Menu for transaction------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount*2 ;iCount= iCount+2)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccept}*",sActual)
					[+] if(bMatch)
						[ ] break
			[ ] 
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check the Payee of the matched transaction",PASS,"The Payee of the matched transaction is as '{sAccept}' ")
			[+] else
				[ ] ReportStatus("Check the Payee of the matched transaction",FAIL,"The Payee of the matched transaction is not as '{sAccept}' ")
			[ ] 
			[ ] 
			[ ] iResult=C2RTransactionOperations(lsPayeeName[5],lsInvokeOperation[2],sOperationType)
			[ ] 
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] //------------------Verify the Edit Button for each transaction------------------
			[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
			[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
			[+] for(iCount=0; iCount <= iListCount*2 ;iCount= iCount+2)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[+] if(bMatch)
					[ ] break
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check the original payee name ",PASS,"The Original Payee Name has got reverted to {sAccepted} ")
			[+] else
				[ ] ReportStatus("Check the original payee name",FAIL,"The Original Payee Name has not got reverted to {sAccepted} ")
				[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Right Click Menu- Renaming RulesTransaction in C2R ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test26_RenamingRulesTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify availability and functionality of 'Renaming Rules' button at the bottom of the C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Renaming Rules' button at the bottom of the C2R window.					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test26_RightClickRenamingRulesTransactionInC2R() appstate none
	[ ] 
	[ ] // ------------------Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 16" 
	[ ] sAccept = "Accept"
	[ ] sAccepted="Accepted"
	[ ] sMessage="There are no downloaded transactions to accept." 
	[ ] lsPayeeName={"Matt","David","Tom","Sam","Transworld","Max"}
	[ ] sOperationType="Show Renaming Rules"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] //------------------Verify the Renaming Rules-Edit Menu for transaction------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] 
			[ ] iResult=C2RTransactionOperations(lsPayeeName[6],lsInvokeOperation[2],sOperationType)
			[ ] 
			[+] 
				[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
				[ ] // 
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(3))
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.Click(1,1138,52)
				[ ] // 
				[ ] // MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.ShowRenamingRules.Pick()
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] //------------------Renaming Rules Dialog gets opened------------------
			[+] if(RenamingRules.Exists(5))
				[ ] RenamingRules.SetActive()
				[ ] ReportStatus("Verify Renaming Rules dialog using right click in C2R", PASS , "Renaming Rules dialog launched using right click in C2R ")
				[ ] RenamingRules.Done.Click()
			[+] else
				[ ] ReportStatus("Verify Renaming Rules dialog using right click in C2R", FAIL , "Renaming Rules dialog couldn't be launched using right click in C2R ")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //###############################################################################################
[ ] 
[ ] 
[ ] // Branding is not done properly on Autolab machine so this test case will fail on autolab.
[+] // //############# Verify FI LOGO, Website link, Website Help Link in C2R #####################################
	[+] // // TestCase Name:	Test20_VerifyFILogoAndWebsiteLinkC2R()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] // 
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Dec 3, 2013		Girish	created
	[ ] // // ********************************************************
[+] // testcase Test28_VerifyFILogoAndWebsiteLinkC2R() appstate QuickenBaseState
	[ ] // 
	[ ] // // Variable declaration
	[ ] // 
	[+] // // Expected Values
		[ ] // sAccountName="Checking at Wells Fargo"
		[ ] // sFIWebLink = "<a href=http://www.wellsfargo.com/> wellsfargo.com</a>"
		[ ] // SFIWebHelpLink = "<a href=http://www.wellsfargo.com/per/wfonline/quicken/index.jhtml> Help</a>"
		[ ] // sFileName = "WellsFargo_Checking"
		[ ] // sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // // Navigate to File > File Import > Web Connect File
		[ ] // QuickenWindow.SetActive()
		[ ] // iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] // 
		[+] // if (iResult  == PASS)
			[ ] // sleep(5)
			[ ] // MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[+] // if(MDIClient.AccountRegister.DownloadedTransactionsTab.Exists(5))
				[ ] // 
				[ ] // sLogo = MDIClient.AccountRegister.StaticText1.QWinChild.FILOGO.GetCaption()
				[ ] // 
				[+] // if(sLogo!=NULL)
					[ ] // MDIClient.AccountRegister.StaticText1.QWinChild.FILOGO.Click()
					[ ] // sleep(3)
					[ ] // OnlineCenter.Close()
					[ ] // ReportStatus("Validate FI LOGO", PASS, "FI LOGO exists")
					[ ] // 
					[ ] // //------------------Verify FI website link
					[ ] // iCounter = 1
					[ ] // iCount=0
					[ ] // sHandle = str(MDIClient.AccountRegister.StaticText1.QWinChild.QWListViewer.ListBox.GetHandle())
					[+] // for(i=0;i<=iCounter;i=i+1)
						[ ] // 
						[ ] // sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
						[ ] // sleep(2)
						[ ] // bMatch = MatchStr("{sFIWebLink}", sActual)
						[+] // if(bMatch==TRUE)
							[ ] // iCount=iCount+1
					[+] // if(iCount>0)
						[ ] // ReportStatus("Validate FI Website Link", PASS, "FI link exist and is correct")
					[+] // else
						[ ] // ReportStatus("Validate FI Website Link", FAIL, "FI link is not  correct")
					[ ] // bMatch=FALSE
					[ ] // iCount1=0
					[ ] // sHandle = str(MDIClient.AccountRegister.StaticText1.QWinChild.QWListViewer.ListBox.GetHandle())
					[+] // for(i=0;i<=iCounter;i=i+1)
						[ ] // 
						[ ] // sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
						[ ] // bMatch = MatchStr("{SFIWebHelpLink}", sActual)
						[+] // if(bMatch==TRUE)
							[ ] // iCount1=iCount1+1
					[+] // if(iCount1>0)
						[ ] // ReportStatus("Validate FI Website Link", PASS, "FI help link exist and is correct")
					[+] // else
						[ ] // ReportStatus("Validate FI Website Link", FAIL, "FI help  link is not  correct")
						[ ] // 
						[ ] // 
				[+] // else
					[ ] // ReportStatus("Validate FI LOGO", FAIL, "FI LOGO do not exists, Failed to locate FI LOGO")
			[+] // else
				[ ] // ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
				[ ] // 
		[+] // else
			[+] // ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
					[ ] // 
					[ ] // 
			[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] // 
	[ ] // 
[ ] // //###############################################################################################
[ ] 
[+] //############# Verify Last Download link and Date  in C2R ###############################################
	[+] // TestCase Name:	Test21_VerifyLastDownloadLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test29_VerifyLastDownloadLink() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile,iAccount,i,iCount,iCount1
		[ ] BOOLEAN bFlag,bVerify
		[ ] STRING sOnlineTransactionDataFile, sFilePath,sFileName,sAccount,sAccountName,sCaption, sExpected,sLogo,sFIWebLink,SFIWebHelpLink,sLastDownloadText
		[ ] STRING sDate 
		[ ] sDate = DateStr () 
		[ ] 
	[+] // Expected Values
		[ ] sFileName = "WellsFargo_Checking"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sAccountName="Checking at Wells Fargo"
		[ ] sFIWebLink = "<a href=http://www.wellsfargo.com/> wellsfargo.com</a>"
		[ ] SFIWebHelpLink = "<a href=http://www.wellsfargo.com/per/wfonline/quicken/index.jhtml> Help</a>"
		[ ] sLastDownloadText="Last download"
		[ ] iCount=0
		[ ] iCount1=0
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] if(MDIClient.AccountRegister.DownloadedTransactionsTab.Exists(5))
			[+] do
				[ ] MDIClient.AccountRegister.TextClick("Last download")
				[ ] 
				[ ] ReportStatus("Validate Last Download Link and Date", PASS, "Last Download Link and Date are present and are correct")
				[+] if(DlgVerifyCashBalance.Exists(10))
					[ ] DlgVerifyCashBalance.SetActive()
					[+] if(DlgVerifyCashBalance.OnlineBalanceTextField.Exists())
						[ ] DlgVerifyCashBalance.OnlineBalanceTextField.SetText("10")
					[ ] DlgVerifyCashBalance.Done.Click()
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[+] if(OneStepUpdateSummary.Exists(10))
					[ ] OneStepUpdateSummary.SetActive()
					[ ] OneStepUpdateSummary.Close()
					[ ] ReportStatus("Verification of OSU Summary Window", PASS, "OSU Summary window is opened by clicking Last Download Link.")
				[+] else
					[ ] ReportStatus("Verification of OSU Summary Window", FAIL, "Failed to open OSU Summary window")
			[+] except
				[ ] ReportStatus("Validate Last Download Link and Date", FAIL, "Last Download Link and Date are not  correct")
		[+] else
			[ ] ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[ ] 
[+] //############# Update Transactions button in C2R #####################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test30_UpdateTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify availability and functionality of 'Update Transactions' button in C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Update Transactions' button in C2R window.			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test30_UpdateTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] sAccount = "Checking 15" 
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] MDIClient.AccountRegister.QWinChild.UpdateTransactions.DoubleClick()
			[ ] WaitforState(OnlineUpdateAccount,TRUE,3)
			[ ] 
			[+] if(OnlineUpdateAccount.Exists(5))
				[ ] ReportStatus("Verify Online Update for account Dialog ", PASS , "Online Update for Account Dialog is present ")
				[ ] OnlineUpdateAccount.SetActive()
				[ ] OnlineUpdateAccount.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Online Update for account Dialog ", FAIL , "Online Update for Account Dialog is not present ")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //############# Banking Account -  Online payment button in C2R #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test31A_OnlinePaymentButtonInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify availability and functionality of 'Set up online Payment ' button in C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of  'Set up online Payment 'button in C2R window.			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test31A_OnlinePaymentButtonInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sTextMessage
	[ ] sAccount = "Checking 17" 
	[ ] sTextMessage="Finish accepting the downloaded transactions, and then try again."
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] MDIClient.AccountRegister.QWinChild.SetUpMakeOnlinePayment.DoubleClick()
			[ ] WaitforState(AlertMessage,TRUE,3)
			[ ] 
			[+] if(AlertMessage.Exists(5))
				[ ] ReportStatus("Verify Alert Message for Setup Online Payment", PASS , " Alert Message for Setup Online Payment is present ")
				[ ] 
				[ ] sMessage=AlertMessage.MessageText.GetText()
				[ ] 
				[ ] bMatch=MatchStr("*{sTextMessage}*",sMessage)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] ReportStatus("Online payment button in C2R",PASS,"Online payment button from C2R")
					[ ] 
					[ ] AlertMessage.OK.Click()
				[+] else
					[ ] ReportStatus("Online payment button in C2R",FAIL,"Online payment button from C2R")
			[+] else
				[ ] ReportStatus("Verify Alert Message for Setup Online Payment", FAIL , " Alert Message for Setup Online Payment is not present ")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //######## Banking Account -   Pop up for transaction over a year old in C2R ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test33_OneYearTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that Quicken prompts user when user tries to enter transaction over a year old.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Quicken prompts user when user tries to enter transaction over a year old.		
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test33_OneYearTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sTextMessage
	[ ] STRING sFileName = "Compare2Register"
	[ ] // STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] // STRING sSourceFile = AUT_DATAFILE_PATH + "\C2R Data File\" + sFileName + ".QDF"
	[ ] // 
	[ ] sAccount = "Checking at Wells Fargo Bank" 
	[ ] sTextMessage="You are entering a transaction over a year"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // //------------------ Create Data File------------------
		[ ] iOpenDataFile = OpenDataFile(sFileName)
		[ ] // 
		[ ] // // ------------------Report Staus If Data file opened successfully------------------
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is opened")
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.OneStepUpdate.Select()
			[+] if (EnterIntuitPassword.Exists(20))
				[ ] EnterIntuitPassword.SetActive()
				[ ] EnterIntuitPassword.Password.SetText(sPassword)
				[ ] EnterIntuitPassword.UpdateNowButton.Click()
			[ ] 
			[+] if (UnlockYourPasswordVault.Exists(10))
				[ ] UnlockYourPasswordVault.SetActive()
				[ ] UnlockYourPasswordVault.Password.SetText(sPassword)
				[ ] UnlockYourPasswordVault.OK.Click()
			[+] if(DlgIAMSignIn.Exists(10))
				[ ] DlgIAMSignIn.SetActive()
				[ ] DlgIAMSignIn.IntuitPasswordTextBox.SetText(sPassword)
				[ ] DlgIAMSignIn.LoginButton.Click()
				[ ] 
			[+] if(OneStepUpdate.Exists(15))
				[ ] ReportStatus("Verify IAMS is Registration ", PASS, "IAMS Registration is Done")
				[ ] OneStepUpdate.Close()
			[ ] 
			[+] if(OneStepUpdateSummary.Exists(15))
				[ ] OneStepUpdateSummary.Close()
				[ ] WaitForState(OneStepUpdateSummary,FALSE ,5)
			[ ] 
			[ ] //Reset Quicken warnings to verify this test case
			[ ] iResult=ResetAlerts()
			[+] if(iResult == PASS)
					[ ] //------------------Select the Online Checking Account------------------
					[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
					[+] if(iSelect == PASS)
						[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
						[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
						[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
						[ ] 
						[ ] MDIClient.AccountRegister.Accept.Click()
						[ ] 
						[ ] sleep(1)
						[ ] 
						[+] if(AlertMessage.Exists(SHORT_SLEEP))
							[ ] AlertMessage.SetActive()
							[ ] sMessage=AlertMessage.MessageText.GetText()
							[ ] 
							[ ] bMatch=MatchStr("*{sTextMessage}*",sMessage)
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify Quicken prompts message 'user tries to enter transaction over a year old'",PASS,"Quicken prompted message 'user tries to enter transaction over a year old' successfully ")
							[+] else
								[ ] ReportStatus("Verify Quicken prompts message 'user tries to enter transaction over a year old'",FAIL,"Quicken not prompted message 'user tries to enter transaction over a year old' successfully ")
							[ ] 
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.DonTShowAgain.Check()
							[ ] AlertMessage.Yes.Click()
							[ ] WaitForState(AlertMessage , FALSE ,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert Message",FAIL,"Alert Message is not prompted")
						[ ] 
					[+] else
						[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
						[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken warnings has been reset",FAIL,"Quicken warnings couldn't be reset")
				[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
		[ ] 
		[ ] Sleep(5)
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] // 
[+] //#####Accept transactions one by one using 'Enter' key for Online Account##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test33_OneYearTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that Quicken prompts user when user tries to enter transaction over a year old.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Quicken prompts user when user tries to enter transaction over a year old.		
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test41_AcceptTrxnsEnterKeyOnline() appstate none
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sPayeeName
	[ ] sAccount ="Checking Account 19"
	[ ] sAccepted="Accepted"
	[ ] sPayeeName="Matt"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] sleep(2)
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sleep(2)
			[ ] 
			[ ] iListCount=MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetItemCount()
			[ ] 
			[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
			[ ] 
			[+] for (iCounter=0 ; iCounter<=iListCount*2 ; iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCounter))
				[ ] bMatch= MatchStr("*{sPayeeName}*",sActual)
				[+] if(bMatch)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(iCounter))
					[ ] break
			[ ] 
			[ ] MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.TypeKeys(KEY_ENTER)
			[ ] 
			[+] for (iCounter=0 ; iCounter<=iListCount*2 ; iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCounter))
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[+] if(bMatch)
					[ ] break
			[ ] 
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"Status of the transaction '{sPayeeName}' is 'Accepted' after clicking on Accept Button in C2R")
				[ ] 
				[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
				[ ] iResult=FindTransaction(WindowName,sPayeeName)
				[+] if(iResult==PASS)
					[ ] 
					[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{sPayeeName}' got added in Register after clicking on Accept Button in C2R")
				[+] else
					[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{sPayeeName}' not got added in Register after clicking on Accept Button in C2R")
				[ ] 
			[+] else
				[ ] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"Status of the transaction '{sPayeeName}'  is not 'Accepted' after clicking on Accept Button in C2R")
				[ ] 
				[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
				[ ] iResult=FindTransaction(WindowName,sPayeeName)
				[ ] 
				[+] if(iResult==PASS)
					[ ] 
					[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{sPayeeName}' got added in Register after clicking on Accept Button in C2R ,Still status is not changed to Accepted")
				[+] else
					[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{sPayeeName}' not got added in Register after clicking on Accept Button in C2R,as status is not changed to Accepted")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //#####Importing web connect files twice, Activate One Step Update pop up is displayed.########################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test33_OneYearTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that Quicken prompts user when user tries to enter transaction over a year old.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Quicken prompts user when user tries to enter transaction over a year old.		
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test38_ImportWebConnectTwice() appstate none
	[ ] //------------------ Variable declaration & definition------------------
	[ ] LIST OF STRING lsFileName
	[ ] 
	[ ] lsFileName = {"BOA 1","BOA 2"}
	[ ] sAccount="Checking at Bank of America*"
	[+] if(QuickenWindow.Exists(5))
		[ ] CloseQuicken()
		[ ] LaunchQuicken()
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Import a Web Connect File for first time------------------
		[ ] iResult = ImportWebConnectFile(lsFileName[1])
		[+] if(iResult == PASS)
			[ ] ReportStatus("Import Web Connect File ",PASS,"Web Connect file for first time is imported successfully")
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
			[ ] 
			[+] if(iSelect==PASS)
				[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
				[ ] 
				[ ] //------------------Click on Accept All Button for accepting all the transactions------------------
				[ ] sleep(2)
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sleep(2)
				[ ] MDIClient.AccountRegister.AcceptAll.Click()
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Import a Web Connect File for second time------------------
				[ ] //iResult = ImportWebConnectFile(lsFileName[2])
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.File.Click()
				[ ] QuickenWindow.File.FileImport.Click()
				[ ] QuickenWindow.File.FileImport.WebConnectFile.Select()
				[ ] 
				[ ] // open the Web connect file for Banking
				[ ] ImportExportQuickenFile.SetActive()
				[ ] ImportExportQuickenFile.FileName.SetText(lsFileName[2])
				[ ] ImportExportQuickenFile.OK.Click()
				[+] if(BofaCriticalMsg.Exists(10))
						[ ] BofaCriticalMsg.SetActive()
						[ ] //BofaCriticalMsg.DontShow.Check()
						[ ] BofaCriticalMsg.OK.Click()
				[ ] 
				[ ] 
				[+] if(ActivateOneStepUpdate.Exists(60))
					[ ] ReportStatus("Verify Activate One Step Update window",PASS,"Activate One Step Update screen is displayed successfully")
					[ ] ActivateOneStepUpdate.SetActive()
					[ ] ActivateOneStepUpdate.Cancel.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Activate One Step Update window",PASS,"Activate One Step Update screen is displayed successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Import Web Connect File ",FAIL,"Web Connect file for first time is not imported successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[ ] //****************************************************************************************************************************************************************************
[ ] 
[+] //############# Verify Last Download link and Date  in C2R of Investing Account ########################
	[+] // TestCase Name:	Test21_VerifyLastDownloadLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test57_VerifyLastDownloadLinkInvesting() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] sLastDownloadText="Last download"
		[ ] iCount=0
		[ ] iCount1=0
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iResult  == PASS)
			[ ] 
			[+] if(MDIClient.AccountRegister.DownloadedTransactionsTab.Exists(5))
				[ ] 
				[+] do
					[ ] MDIClient.AccountRegister.TextClick("Last download")
					[ ] 
					[ ] ReportStatus("Validate Last Download Link and Date", PASS, "Last Download Link and Date are present and are correct")
					[ ] 
					[+] if(OneStepUpdateSummary.Exists(10))
						[ ] OneStepUpdateSummary.SetActive()
						[ ] OneStepUpdateSummary.Close()
						[ ] ReportStatus("Verification of OSU Summary Window", PASS, "OSU Summary window is opened by clicking Last Download Link.")
					[+] else
						[ ] ReportStatus("Verification of OSU Summary Window", FAIL, "Failed to open OSU Summary window")
				[+] except
					[ ] ReportStatus("Validate Last Download Link and Date", FAIL, "Last Download Link and Date are not  correct")
			[+] else
				[ ] ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Investing Account -  Online payment button in C2R ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test59A_OnlinePaymentButtonInC2RInvesting()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify availability and functionality of 'Set up online Payment ' button in C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of  'Set up online Payment 'button in C2R window.			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test59A_OnlinePaymentButtonInC2RInvesting() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sTextMessage ,sAlertMessagePart1,sAlertMessagePart2
	[ ] sAccount = "Investment at Vanguard" 
	[ ] sTextMessage="Finish accepting transactions first and then try again"
	[ ] sAlertMessagePart1="Quicken can not edit Investment at Vanguard because there are downloaded transactions that must first be accepted into the account register or transaction list."
	[ ] sAlertMessagePart2="Finish accepting the downloaded transactions, and then try again."
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Investing Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] MDIClient.AccountRegister.QWinChild.SetUpMakeOnlinePayment.DoubleClick()
			[ ] 
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.SetActive()
				[ ] 
				[ ] sMessage=AlertMessage.MessageText.GetText()
				[ ] 
				[ ] bMatch=MatchStr("*{sAlertMessagePart1}*{sAlertMessagePart2}*",sMessage)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] ReportStatus("Verify Alert Message for Setup Online Payment", PASS , " Expected Alert Message:{sAlertMessagePart1} {sAlertMessagePart2} for Setup Online Payment appeared when there transactions in CR.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Alert Message for Setup Online Payment", FAIL , " Expected Alert Message:{sAlertMessagePart1} {sAlertMessagePart2}  for Setup Online Payment didn't appear when there transactions in CR actual message is:{sMessage}.")
				[ ] AlertMessage.OK.Click()
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Verify Alert Message for Setup Online Payment", FAIL , " Alert Message for Setup Online Payment is not present ")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[ ] 
[ ] 
[+] //############# Verify Investing Account Accept Button On Transaction #############################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test43_VerifyInvestingAccountAcceptButtonOnTransaction() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] sAccepted="Accepted"
		[ ] sPayeeName = "Vanguard Federal"
		[ ] sAcceptText="Accept"
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[ ] 
		[+] if (iResult  == PASS)
			[ ] sleep(60)
			[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
			[ ] iListCount=MDIClient.AccountRegister.C2RListBox.GetItemCount()
			[+] for(iCount=0; iCount <= iListCount*2 ;iCount= iCount+2)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
				[ ] bMatch= MatchStr("*{sPayeeName}*",sActual)
				[+] if(bMatch)
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(iCount))
					[ ] break
			[ ] 
			[ ] // MDIClient.AccountRegister.C2RListBox.TextClick(sAcceptText)
			[ ] MDIClient.AccountRegister.C2RListBox.TextClick(sAcceptText)
			[ ] 
			[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
			[ ] iListCount=MDIClient.AccountRegister.C2RListBox.GetItemCount()
			[+] for(iCount=0; iCount <= iListCount*2 ;iCount= iCount+2)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[+] if(bMatch)
					[ ] break
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"Status of the investing transaction is 'Accepted' after clicking on Accept Button in C2R")
				[ ] 
				[ ] iResult=FindTransaction("MDI",sPayeeName,ACCOUNT_INVESTING)
				[ ] 
				[+] if(iResult==PASS)
					[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{sPayeeName}' got added in Register after clicking on Accept Button in C2R")
				[+] else
					[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{sPayeeName}' not got added in Register after clicking on Accept Button in C2R")
				[ ] 
				[ ] 
			[+] else
				[+] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"Status of the investing transaction  is not 'Accepted' after clicking on Accept Button in C2R")
					[ ] 
		[+] else
			[+] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
				[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Verify Investing Account Accept Button At C2R Bottom Window########################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test44_VerifyInvestingAccountAcceptButtonAtC2RBottom() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] sAccepted="Accepted"
		[ ] sPayeeName = "Vanguard Life"
		[ ] sAcceptText="Accept"
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iResult  == PASS)
			[+] sleep(20)
				[ ] sleep(2)
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sleep(2)
			[ ] 
			[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
			[ ] iListCount=MDIClient.AccountRegister.C2RListBox.GetItemCount()
			[+] for(iCount=0; iCount <= iListCount*2 ;iCount= iCount+2)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
				[ ] bMatch= MatchStr("*{sPayeeName}*",sActual)
				[+] if(bMatch)
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(iCount))
					[ ] break
			[ ] MDIClient.AccountRegister.Accept.Click()
			[ ] 
			[ ] sleep(10)
			[ ] 
			[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
			[ ] iListCount=MDIClient.AccountRegister.C2RListBox.GetItemCount()
			[+] for(iCount=0; iCount <= iListCount*2 ;iCount= iCount+2)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[+] if(bMatch)
					[ ] break
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"Status of the investing transaction is 'Accepted' after clicking on Accept Button in C2R")
				[ ] 
				[ ] iResult=FindTransaction("MDI",sPayeeName,ACCOUNT_INVESTING)
				[ ] 
				[+] if(iResult==PASS)
					[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{sPayeeName}' got added in Register after clicking on Accept Button in C2R")
				[+] else
					[+] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{sPayeeName}' not got added in Register after clicking on Accept Button in C2R")
									[ ] 
			[+] else
				[+] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"Status of the investing transaction  is not 'Accepted' after clicking on Accept Button in C2R")
					[ ] 
		[+] else
			[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Verify Help Button in Investing Account C2R Window################################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test45_VerifyHelpButtonInvestingAccountC2RWindow() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] QuickenWindow.SetActive()
		[ ] //------------------Verify Accept Button present on bottom of the C2R window------------------
		[ ] sleep(2)
		[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
		[ ] sleep(2)
		[ ] 
		[+] if(MDIClient.AccountRegister.HelpIcon.Exists(5))
			[ ] ReportStatus("Check Help Button present",PASS,"Help Button is present on the bottom of the C2R window")
			[ ] 
			[ ] MDIClient.AccountRegister.HelpIcon.Click()
			[ ] Sleep(2)
			[ ] //------------------Help Dialog gets opened------------------
			[+] if(QuickenHelp.Exists(5))
				[ ] QuickenHelp.SetActive()
				[ ] ReportStatus("Verify Help Dialog ", PASS , "Help Dialog is present ")
				[ ] QuickenHelp.Close()
			[+] else
				[ ] ReportStatus("Verify Help Dialog", FAIL , "Help Dialog is not present")
			[ ] 
		[+] else
			[ ] ReportStatus("Check Help Button present",FAIL,"Help Button is not present on the bottom of the C2R window")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //#######################################################################################
[ ] // 
[ ] 
[+] //############# Verify Renaming Rules Button at  C2R Window of Investing Account####################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test49_VerifyRenamingRulesButtonC2R_InvestingAccount() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[ ] 
		[+] if (iResult  == PASS)
			[ ] sleep(10)
			[ ] //------------------Verify Renaming Rules Button present on bottom of the C2R window------------------
			[ ] sleep(2)
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.DoubleClick()
			[ ] sleep(2)
			[ ] 
			[+] if(MDIClient.AccountRegister.RenamingRules.Exists(5))
				[ ] 
				[ ] ReportStatus("Check Renaming Rules Button present",PASS,"Renaming Rules Button is present on the bottom of the C2R window")
				[ ] 
				[ ] //------------------Click onRenaming Rules Button for accepting all the transactions------------------
				[ ] 
				[ ] MDIClient.AccountRegister.RenamingRules.Click()
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] //------------------Renaming Rules Dialog gets opened------------------
				[+] if(RenamingRules.Exists(5))
					[ ] ReportStatus("Verify Renaming Rules Dialog ", PASS , "Renaming Rules Dialog is present ")
					[ ] RenamingRules.Done.Click()
				[+] else
					[ ] ReportStatus("Verify Renaming Rules Dialog", FAIL , "Renaming Rules Dialog is not present")
		[+] else
			[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
[ ] //#######################################################################################
[ ] 
[+] //############# Verify Edit Menu-Delete Transaction at C2R Window of Investing Account################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test50_VerifyEditMenuDeleteTransactionC2R_InvestingAccount() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] sPayeeName = "Vanguard Federal Money Market Fund"
		[ ] sOperationType="Delete"
		[ ] sExpected="13.18 shares @  $1"
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Import a Web Connect File for first time------------------
		[ ] 
		[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[ ] sleep(10)
		[+] if (iResult  == PASS)
			[ ] 
			[ ] //------------------Verify the Edit Button for each transaction------------------
			[ ] 
			[ ] iResult=C2RTransactionOperations(sPayeeName,lsInvokeOperation[1],sOperationType,ACCOUNT_INVESTING)
			[+] 
				[ ] // sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
				[ ] // 
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
				[ ] // 
				[ ] // MDIClient.AccountRegister.C2RListBox.Click(1,986,23)
				[ ] // 
				[ ] // MDIClient.AccountRegister.C2RListBox.Delete.Pick()
			[+] if(iResult==PASS)
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] iCounter=MDIClient.AccountRegister.C2RListBox.GetItemCount()
				[ ] 
				[+] for(iRow=0;iRow<iCounter;iRow=iRow+2)
					[ ] 
					[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iRow))
					[ ] 
					[ ] bMatch= MatchStr("*{sExpected}*",sActual)
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Check the transaction",PASS,"'{sPayeeName} with amount as 13.18 shares @$1' transaction is deleted in C2R")
				[+] else
					[ ] ReportStatus("Check the transaction",FAIL,"'{sPayeeName}' transaction is  available in C2R")
					[ ] 
			[+] else
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
[ ] //#######################################################################################
[ ] 
[ ] 
[+] //############# Verify Edit Menu-UnMatch at  C2R Window of Investing Account#################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test51_VerifyEditMenuUnmatchTransactionC2R_InvestingAccount() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile,iAccount,iCounter
		[ ] STRING sOnlineTransactionDataFile, sFilePath,sFileName,sAccount,sAccountName, sExpected,sFileName2,sAccepted,sAcceptAllTransaction,sActual
		[ ] STRING sWindowType,sTransactionType, sExpectedAccountName, sTransactionDate, sTickerSymbol, sNumberOfShares, sPricePaid, sCommission, sUseCashTransaction
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] sAcceptAllTransaction = "Accept All Transaction"
		[ ] sWindowType = "Buy - Shares Bought"
		[ ] sAccept = "Near Match"
		[ ] sAccepted="New"
		[ ] sOperationType="Unmatch"
		[ ] sPayeeName = "Vanguard Total Bond Market Index Fund Investor Shares"
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[ ] sleep(10)
		[+] if(iResult==PASS)
			[ ] 
			[ ] //------------------Verify the UnMatch-Edit Menu for transaction------------------
			[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
			[ ] 
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
			[ ] 
			[ ] bMatch= MatchStr("*{sAccept}*",sActual)
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'Match' ")
			[+] else
				[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'Match' ")
			[ ] 
			[ ] 
			[ ] iResult=C2RTransactionOperations(sPayeeName,lsInvokeOperation[1],sOperationType,ACCOUNT_INVESTING)
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] //------------------Verify the Edit Button for each transaction------------------
			[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
			[ ] 
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(2))
			[ ] 
			[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'New' after selecting Edit Menu-UnMatch ")
			[+] else
				[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'New' after selecting Edit Menu-UnMatch ")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
		[ ] 
		[ ] 
	[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
[ ] //#######################################################################################
[ ] 
[ ] 
[ ] //****************************************************************************************************************************************************************************
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //****************************************************************************************************************************************************************************
[ ] 
[ ] //****************************************************************************************************************************************************************************
[ ] 
[+] //######## Investing Account -   Pop up for transaction over a year old in C2R ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test61_OneYearTransactionInC2RInvesting()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that Quicken prompts user when user tries to enter transaction over a year old.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Quicken prompts user when user tries to enter transaction over a year old.		
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test61_OneYearTransactionInC2RInvesting() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sTextMessage
	[ ] STRING sFileName = "Compare2Register"
	[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\C2R Data File\" + sFileName + ".QDF"
	[ ] 
	[ ] sAccount = "Checking at Wells Fargo Bank" 
	[ ] sTextMessage="You are entering a transaction over a year"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------ Create Data File------------------
		[ ] // iOpenDataFile = OpenDataFile(sFileName)
		[ ] iOpenDataFile  = PASS
		[ ] // ------------------Report Staus If Data file opened successfully------------------
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is opened")
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.OneStepUpdate.Select()
			[ ] 
			[+] if(OneStepUpdate.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify IAMS is Registration ", PASS, "IAMS Registration is Done")
			[+] else
				[ ] RegisterQuickenConnectedServices()
			[ ] OneStepUpdate.Cancel.Click()
		[+] else 
			[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is not opened")
		[ ] 
		[ ] 
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] //Select transaction from C2R
			[ ] MDIClient.AccountRegister.TextClick("Account Maintenance Fee",2)
			[ ] MDIClient.AccountRegister.Accept.Click()
			[ ] 
			[ ] sleep(1)
			[ ] 
			[+] if(AlertMessage.Exists(SHORT_SLEEP))
				[ ] 
				[ ] sMessage=AlertMessage.MessageText.GetText()
				[ ] 
				[ ] bMatch=MatchStr("*{sTextMessage}*",sMessage)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Quicken prompts message 'user tries to enter transaction over a year old'",PASS,"Quicken prompted message 'user tries to enter transaction over a year old' successfully ")
				[+] else
					[ ] ReportStatus("Verify Quicken prompts message 'user tries to enter transaction over a year old'",FAIL,"Quicken not prompted message 'user tries to enter transaction over a year old' successfully ")
				[ ] 
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.No.Click()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Alert Message",FAIL,"Alert Message is not prompted")
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[+] //############# Investing Account -  Online payment button in C2R #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test59B_OnlinePaymentButtonInC2RInvesting()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // Verify availability and functionality of 'Set up online Payment ' button in C2R window.
		[ ] // 
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If availability and functionality of  'Set up online Payment 'button in C2R window.			
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test59B_OnlinePaymentButtonInC2RInvesting() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sText,sFileName
	[ ] 
	[ ] sAccount = "Brokerage" 
	[ ] sText="Quicken Bill Pay"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] //------------------Select the Online Investing Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} is selected successfully")
			[ ] 
			[ ] sleep(10)
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sleep(2)
			[ ] 
			[ ] MDIClient.AccountRegister.QWinChild.SetUpMakeOnlinePayment.Click()
			[ ] 
			[ ] Sleep(1)
			[ ] 
			[ ] 
			[+] if(AddAnyAccount.Exists(20))
				[ ] AddAnyAccount.SetActive()
				[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",PASS,"Add account window is displayed successfully")
				[ ] 
				[ ] 
				[ ] sCaption=AddAnyAccount.QuickenBillPay.GetCaption()
				[ ] 
				[+] if(sText==sCaption)
					[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",PASS,"Add account window for 'Quicken Bill Pay' is displayed successfully")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",FAIL,"Add account window for 'Quicken Bill Pay' is not displayed successfully")
				[ ] 
				[ ] AddAnyAccount.Close()
				[ ] 
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.OK.Click()
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",FAIL,"Add account window is not displayed successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //######## Investing Account - Download transactions with the account open for Direct Connect FI.################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test62_DownloadTransactionManualtoDCInvesting()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that Quicken prompts user when user tries to enter transaction over a year old.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Quicken prompts user when user tries to enter transaction over a year old.		
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test62_DownloadTransactionManualtoDCInvesting() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sTextMessage,sTransactionDownload,sUserName,sPassword,sAccountNumber,sFIName,sAccountId,sAccPassword
	[ ] 
	[ ] sAccount = "Brokerage Account" 
	[ ] sFIName = "T. Rowe Price"
	[ ] sTransactionDownload = "Activate Downloads"
	[ ] sAccountId="quickenqa"
	[ ] sAccPassword = "Zags2010"
	[ ] sAccountNumber="0540120459"
	[ ] sMessage="There are no downloaded transactions to accept." 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] iSelect=NavigateToAccountDetails(sAccount)
			[ ] 
			[ ] 
			[+] if(iSelect==PASS)
				[ ] ReportStatus("Verify that Account Details is opened ",PASS,"Account Details Window is opened successfully")
				[ ] 
				[ ] AccountDetails.FinancialInstitution.SetText(sFIName)
				[ ] 
				[ ] AccountDetails.AccountNumber.SetText(sAccountNumber)
				[ ] 
				[ ] AccountDetails.OK.Click()
				[ ] 
				[+] if(AccountList.Exists(5))
					[ ] ReportStatus("Verify that Account List is present ",PASS,"Account List Window is present")
					[ ] 
					[ ] AccountList.SetActive()
					[ ] AccountList.Maximize()
					[ ] AccountList.QWinChild.PersonalInvestments.Click()
					[ ] 
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
					[ ] 
					[+] for(i=0;i<AccountList.QWinChild.Order.ListBox.GetItemCount();i++)
						[ ] 
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sAccount}*",sActual)
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Account is present in Account List",PASS,"Account{sAccount} is present in Account List")
							[ ] break
						[ ] 
						[ ] 
					[ ] bMatch=MatchStr("*{sTransactionDownload}*",sActual)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Transaction Download changes",PASS,"Transaction Download status change to {sTransactionDownload} in Account List")
						[ ] 
						[ ] AccountList.QWinChild.Order.ListBox.TextClick(sTransactionDownload,1)
						[ ] 
						[ ] iResult=ActivateDownload(sAccountId,sAccPassword)
						[ ] 
						[+] if(iResult==PASS)
							[ ] 
							[ ] ReportStatus("Verify Activate Downloads is done",PASS,"Manual Investing account got linked with Online Investing account successfully.")
							[ ] 
							[ ] AccountList.SetActive()
							[ ] AccountList.Close()
							[ ] sleep(5)
							[ ] 
							[ ] //Need to confirm whether this verification point can be used as the expected message didn't appear in the list box
							[ ] // QuickenWindow.SetActive()
							[ ] // MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
							[ ] // sleep(1)
							[ ] // sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
							[ ] // iListCount=MDIClient.AccountRegister.C2RListBox.GetItemCount()
							[+] // for(iCount=0; iCount <= iListCount ; iCount++)
								[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
								[ ] // bMatch=MatchStr("*{sMessage}*",sActual)
								[+] // if(bMatch)
									[ ] // break
								[ ] // 
								[ ] // 
								[ ] // 
								[+] // if(bMatch==FALSE)
									[ ] // 
									[ ] // ReportStatus("Verify Transactions in C2R",PASS,"Transactions are downloaded in C2R")
								[+] // else
									[ ] // ReportStatus("Verify Transactions in C2R",FAIL,"Transactions are not downloaded in C2R")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Activate Downloads is done",PASS,"Manual account got linked with Online Checking account successfully.")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Transaction Download changes",FAIL,"Transaction Download status not change to {sTransactionDownload} in Account List")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Account List is present ",FAIL,"Account List Window is not present")
			[+] else
				[ ] ReportStatus("Verify that Account Details is opened ",FAIL,"Account Details Window is opened successfully")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //#####Importing web connect files twice, Activate One Step Update pop up is displayed.########################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test64_ImportWebConnectTwiceInvesting()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that Quicken prompts user when user tries to enter transaction over a year old.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Quicken prompts user when user tries to enter transaction over a year old.		
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test64_ImportWebConnectTwiceInvesting() appstate none
	[ ] //------------------ Variable declaration & definition------------------
	[ ] LIST OF STRING lsFileName
	[ ] 
	[ ] lsFileName = {"Vanguard_Investing1","Vanguard_Investing2"}
	[ ] sAccount="Investment at Vanguard"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] ///Delete Account
		[ ] iResult =DeleteAccount(ACCOUNT_INVESTING ,sAccount)
		[+] if(iResult == PASS)
			[ ] //------------------Import a Web Connect File for first time------------------
			[ ] iResult = ImportWebConnectFile(lsFileName[1])
			[+] if(iResult == PASS)
				[ ] ReportStatus("Import Web Connect File ",PASS,"Web Connect file for first time is imported successfully")
				[ ] 
				[ ] Sleep(2)
				[ ] sAccount="Investment at Vanguard"
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)	
				[ ] 
				[+] if(iSelect==PASS)
					[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
					[ ] 
					[ ] //------------------Click on Accept All Button for accepting all the transactions------------------
					[ ] 
					[ ] // MDIClient.AccountRegister.AcceptAll.Click()
					[ ] 
					[ ] Sleep(2)
					[ ] 
					[ ] //------------------Import a Web Connect File for second time------------------
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.File.Click()
					[ ] QuickenWindow.File.FileImport.Click()
					[ ] QuickenWindow.File.FileImport.WebConnectFile.Select()
					[ ] 
					[ ] // open the Web connect file for Banking
					[ ] ImportExportQuickenFile.SetActive()
					[ ] ImportExportQuickenFile.FileName.SetText(lsFileName[2])
					[ ] ImportExportQuickenFile.OK.Click()
					[+] if(BofaCriticalMsg.Exists(10))
							[ ] BofaCriticalMsg.SetActive()
							[ ] BofaCriticalMsg.OK.Click()
					[ ] 
					[ ] 
					[ ] 
					[+] if(OneStepUpdateSummary.Exists(60))
						[ ] OneStepUpdateSummary.SetActive()
						[ ] OneStepUpdateSummary.Close()
						[ ] ReportStatus("Verify OneStep Update Summary dialog." ,PASS, "OneStep Update Summary dialog appeared.")
					[+] else
						[ ] ReportStatus("Verify OneStep Update Summary dialog." ,FAIL, "OneStep Update Summary dialog didn't appear.")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
					[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Import Web Connect File ",FAIL,"Web Connect file for first time is not imported successfully")
		[+] else
			[ ] ReportStatus("Verify account: {sAccount} deleted.  ",FAIL,"Account: {sAccount} couldn't be deleted due to defect: QW-3283")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //#####Accept transactions one by one using 'Enter' key for Online Account##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test67_AcceptTrxnsEnterKeyOnline()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that Quicken prompts user when user tries to enter transaction over a year old.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Quicken prompts user when user tries to enter transaction over a year old.		
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test67_AcceptTrxnsEnterKeyOnline() appstate none
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sPayeeName
	[ ] sAccount = "Investment at Vanguard" 
	[ ] sAccepted="Accepted"
	[ ] sPayeeName="Vanguard"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)	
		[ ] 
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
			[ ] iListCount=MDIClient.AccountRegister.C2RListBox.GetItemCount()
			[+] for(iCount=0; iCount <= iListCount*2 ;iCount= iCount+2)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
				[ ] bMatch= MatchStr("*{sPayeeName}*",sActual)
				[+] if(bMatch)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(iCount))
					[ ] sleep(1)
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.TypeKeys(KEY_ENTER)
					[ ] break
			[ ] 
			[ ] 
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
			[ ] 
			[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"Status of the transaction '{lsPayeeName[i]}' is 'Accepted' after clicking on Accept Button in C2R")
				[ ] 
				[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
				[ ] iResult=FindTransaction(WindowName,sPayeeName ,ACCOUNT_INVESTING)
				[+] if(iResult==PASS)
					[ ] 
					[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{lsPayeeName[i]}' got added in Register after clicking on Accept Button in C2R")
				[+] else
					[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{lsPayeeName[i]}' not got added in Register after clicking on Accept Button in C2R: defect:QW-3577")
				[ ] 
			[+] else
				[ ] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"Status of the transaction '{sPayeeName}'  is not 'Accepted' after clicking on Accept Button in C2R- QW-3577")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[+] //############# Verify Accept All Button At C2R Bottom Window of Investing Account###################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test46_VerifyAcceptAllButtonC2RInvestingAccount() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] sAccepted="There are no downloaded transactions to accept."
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[ ] 
		[+] if (iResult  == PASS)
			[ ] 
			[ ] //------------------Verify Accept All Button present on bottom of the C2R window------------------
			[ ] sleep(2)
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sleep(2)
			[ ] 
			[+] if(MDIClient.AccountRegister.AcceptAll.Exists(5))
				[ ] 
				[ ] ReportStatus("Check Accept All Button present",PASS,"Accept All Button is present on the bottom of the C2R window")
				[ ] 
				[ ] //------------------Click on Accept All Button for accepting all the transactions------------------
				[ ] 
				[ ] MDIClient.AccountRegister.AcceptAll.Click()
				[ ] 
				[ ] Sleep(20)
				[+] if(wEnterTransaction.Exists())
					[ ] wEnterTransaction.SetActive()
					[ ] wEnterTransaction.Close()
				[+] if(AlertMessage.Exists(10))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.OK.Click()
				[+] if(SecuritiesComparisonMismatch.AcceptButton.Exists(5))
					[ ] SecuritiesComparisonMismatch.SetActive()
					[ ] SecuritiesComparisonMismatch.AcceptButton.Click()
					[ ] 
				[+] if(SecuritiesComparisonMismatch.DoneButton.Exists(5))
					[ ] SecuritiesComparisonMismatch.SetActive()
					[ ] SecuritiesComparisonMismatch.DoneButton.Click()
					[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sleep(2)
				[ ] //------------------Verify the "There are no downloaded transactions to accept." message is displayed.------------------
				[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
				[ ] iListCount=MDIClient.AccountRegister.C2RListBox.GetItemCount()
				[+] for(iCount=0; iCount <= iListCount*2 ;iCount= iCount+2)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
					[+] if(bMatch)
						[ ] break
				[ ] 
				[ ] 
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Check Message in C2R window",PASS,"'There are no downloaded transactions to accept.' message is displayed.")
				[+] else
					[ ] ReportStatus("Check Message in C2R window",FAIL,"'There are no downloaded transactions to accept.' message is not displayed.")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Check Accept Button present",FAIL,"Accept Button is present on the bottom of the C2R window")
			[ ] 
		[+] else
			[+] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
						[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //#######################################################################################
[ ] 
[ ] // /// DC account testcases
[+] //############# Banking Account -  Online payment button in C2R #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test31B_OnlinePaymentButtonInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify availability and functionality of 'Set up online Payment ' button in C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of  'Set up online Payment 'button in C2R window.			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test31B_OnlinePaymentButtonInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sText,sIntuitPassword
	[ ] 
	[ ] sAccount = "BUSINESS CHECKING XX0124" 
	[ ] sIntuitPassword="a123456b"
	[ ] sText="Quicken Bill Pay"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] sFileName = "DC_EWC_WEBCONNECT_CLOUD"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------ Create Data File------------------
		[ ] iOpenDataFile = OpenDataFile(sFileName)
		[ ] sleep(5)
		[ ] // ------------------Report Staus If Data file opened successfully------------------
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is opened")
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.OneStepUpdate.Select()
			[+] if (EnterIntuitPassword.Exists(20))
				[ ] EnterIntuitPassword.SetActive()
				[ ] EnterIntuitPassword.Password.SetText(sPassword)
				[ ] EnterIntuitPassword.UpdateNowButton.Click()
			[+] if(DlgIAMSignIn.Exists(10))
				[ ] DlgIAMSignIn.SetActive()
				[ ] DlgIAMSignIn.IntuitPasswordTextBox.SetText(sPassword)
				[ ] DlgIAMSignIn.LoginButton.Click()
				[ ] 
			[+] if(OneStepUpdate.Exists(10))
				[ ] ReportStatus("Verify IAMS is Registration ", PASS, "IAMS Registration is Done")
				[ ] OneStepUpdate.Close()
			[+] if(OneStepUpdateSummary.Exists(15))
				[ ] OneStepUpdateSummary.Close()
				[ ] WaitForState(OneStepUpdateSummary,FALSE ,5)
			[ ] 
			[ ] 
			[ ] //intuit.quicken.inveting.com alert
			[+] if(AlertMessage.No.Exists(60))
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.No.Click()
				[ ] 
			[ ] 
			[ ] //------------------Select the Online Checking Account------------------
			[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
			[ ] 
			[+] if(iSelect == PASS)
				[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
				[ ] 
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[+] if(MDIClient.AccountRegister.QWinChild.SetUpMakeOnlinePayment.Exists(5))
					[ ] MDIClient.AccountRegister.QWinChild.SetUpMakeOnlinePayment.Click()
				[ ] Sleep(1)
				[ ] 
				[+] if(ActivateOnlineBillPay.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",PASS,"Activate Online Bill Pay window is displayed successfully")
					[ ] ActivateOnlineBillPay.SetActive()
					[ ] ActivateOnlineBillPay.ActivateNow.Click()
					[+] if(DlgMsgWellsFargo.Exists(60))
						[ ] DlgMsgWellsFargo.SetActive()
						[ ] DlgMsgWellsFargo.OK.Click()
						[ ] 
					[+] if(DlgUpgradetoDirectConnect.Exists(60))
						[ ] DlgUpgradetoDirectConnect.SetActive()
						[ ] DlgUpgradetoDirectConnect.NextButton.Click()
						[ ] 
					[ ] 
					[ ] Sleep(2)
					[ ] 
					[+] if(AddAnyAccount.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",PASS,"Add account window is displayed successfully")
						[ ] 
						[ ] 
						[ ] sCaption=AddAnyAccount.QuickenBillPay.GetCaption()
						[ ] 
						[+] if(sText==sCaption)
							[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",PASS,"Add account window for 'Quicken Bill Pay' is displayed successfully")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",FAIL,"Add account window for 'Quicken Bill Pay' is not displayed successfully")
						[ ] 
						[ ] AddAnyAccount.Close()
						[ ] 
						[+] if(AlertMessage.Yes.Exists(5))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.Yes.Click()
							[ ] 
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.OK.Click()
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",FAIL,"Add account window is not displayed successfully")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify the Add account flow for 'Quicken Bill Pay'",FAIL,"Activate Online Bill Pay window is not displayed successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[+] //####### Banking Account -  Make an online payment button in C2R ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test32_MakeOnlinePaymentButtonInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify availability and functionality of 'Make an online payment' button in C2R window..
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of  'Make an online payment' button in C2R window.			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] //Duplicate to Test31B_OnlinePaymentButtonInC2R
[+] testcase Test32_MakeOnlinePaymentButtonInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sText
	[ ] sAccount = "BUSINESS ECONOMY CHECKING XX6154" 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[+] if(MDIClient.AccountRegister.QWinChild.SetUpMakeOnlinePayment.Exists())
				[ ] MDIClient.AccountRegister.QWinChild.SetUpMakeOnlinePayment.Click()
			[+] else if(MDIClient.AccountRegister.StaticText1.QWinChild.HideButton.Exists())
				[ ] MDIClient.AccountRegister.StaticText1.QWinChild.HideButton.DoubleClick()
				[ ] Sleep(1)
				[ ] MDIClient.AccountRegister.QWinChild.SetUpMakeOnlinePayment.Click()
			[ ] 
			[ ] 
			[ ] WaitforState(OnlineCenter,TRUE,3)
			[ ] 
			[+] if(OnlineCenter.Exists(5))
				[ ] ReportStatus("Verify Online Center window opened after clicking Make a Online Payment", PASS , " Online Center window opened after clicking Make a Online Payment")
				[ ] 
				[ ] sText=OnlineCenter.Account.GetText()
				[ ] 
				[+] if(sText==sAccount)
					[ ] 
					[ ] ReportStatus("Verify the Account name for which make a Online Payment is clicked",PASS,"Account Name on Online Center is similar to account for which Make a Online Payment is clicked")
					[ ] 
					[ ] OnlineCenter.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify the Account name for which make a Online Payment is clicked",FAIL,"Account Name{sText} on Online Center is not similar to account {sAccount} for which Make a Online Payment is clicked")
			[+] else
				[ ] ReportStatus("Verify Online Center window opened after clicking Make a Online Payment", FAIL , " Online Center window is not opened after clicking Make a Online Payment")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################################
[ ] 
[ ] 
[+] //############# Update Transactions button in C2R Investing Account#################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test58_UpdateTransactionInC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify availability and functionality of 'Update Transactions' button in C2R window.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If availability and functionality of 'Update Transactions' button in C2R window.			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test58_UpdateTransactionInC2R() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sFileName = "DC_EWC_WEBCONNECT_CLOUD"
	[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\C2R Data File\" + sFileName + ".QDF"
	[ ] 
	[ ] sAccount = "Investment XX0459" 
	[ ] sIntuitPassword="intuit1"
	[ ] iXcord = 1038
	[ ] iYcord = 30
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] sleep(60)
			[ ] QuickenWindow.SetActive()
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sleep(1)
			[ ] MDIClient.AccountRegister.QWinChild.UpdateTransactions.Click()
			[ ] WaitforState(OnlineUpdateAccount,TRUE,3)
			[ ] 
			[+] if(OnlineUpdateAccount.Exists(5))
				[ ] ReportStatus("Verify Online Update for account Dialog ", PASS , "Online Update for Account Dialog is present ")
				[ ] OnlineUpdateAccount.SetActive()
				[ ] OnlineUpdateAccount.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Online Update for account Dialog ", FAIL , "Online Update for Account Dialog is not present ")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //##########################################################################################
[ ] 
[ ] 
[ ] 
[+] //############# Verify Right Click Menu-Accept Transaction  in C2R of Investing Account#################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test52_VerifyRightClickMenuAcceptTransactionC2R_InvestingAccount() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] sAccepted = "Accepted"
		[ ] sPayeeName = "Vanguard Federal Money Market Fund"
		[ ] sAccepted="Accepted"
		[ ] sOperationType="Accept"
		[ ] 
	[ ] 
	[ ] ///Copy webconnect accounts file
	[ ] sFileName = "Compare2Register"
	[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] sSourceFile = AUT_DATAFILE_PATH + "\C2R Data File\" + sFileName + ".QDF"
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] LaunchQuicken()
		[ ] 
	[ ] 
	[ ] iResult =OpenDataFile(sFileName)
	[+] if (iResult==PASS)
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] //------------------ Open Data File------------------
			[ ] iOpenDataFile = OpenDataFile(sFileName)
			[ ] 
			[ ] // ------------------Report Staus If Data file opened successfully------------------
			[+] if ( iOpenDataFile  == PASS)
				[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is opened")
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
				[ ] 
				[+] if (iResult  == PASS)
					[ ] 
					[ ] ReportStatus("Select the Online Investing Account",PASS,"{sAccountName} Online Investing Account is selected successfully")
					[ ] sleep(3)
					[ ] QuickenWindow.SetActive()
					[ ] //------------Right Click-Accept Transaction From C2R into Register-----------------------
					[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
					[ ] sleep(2)
					[ ] iResult=C2RTransactionOperations(sPayeeName,lsInvokeOperation[2],sOperationType ,ACCOUNT_INVESTING)
					[ ] 
					[ ] sleep(3)
					[ ] 
					[ ] //------------------Verify Status of the transaction should get chenged to Accepted in C2R
					[ ] iListCount= MDIClient.AccountRegister.C2RListBox.GetItemCount()
					[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
					[+] for (iCounter=0 ; iCounter<=iListCount*2 ; iCounter++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCounter))
						[ ] bMatch= MatchStr("*{sAccepted}*{sPayeeName}*",sActual)
						[+] if(bMatch)
							[ ] break
					[ ] 
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"Status of the transaction '{sPayeeName}' is 'Accepted' after right clicking on Accept transaction in C2R")
						[ ] 
						[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
						[ ] 
						[ ] iResult=FindTransaction("MDI",sPayeeName,ACCOUNT_INVESTING)
						[ ] 
						[+] if(iResult==PASS)
							[ ] 
							[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{sPayeeName}' got added in Register after right clicking on Accept transaction in C2R")
							[ ] 
						[+] else
							[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{sPayeeName}' not got added in Register after right clicking on Accept transaction in C2R")
							[ ] 
					[+] else
						[+] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"Status of the transaction '{sPayeeName}'  is not 'Accepted' right clicking on Accept transaction in C2R")
							[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
			[+] else 
				[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[+] else
		[ ] ReportStatus("Verify datafile opened.", FAIL, "Datafile: {sFileName} couldn't be opened.") 
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Verify Finish Later Button at  C2R Window of Investing Account########################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test48_VerifyFinishLaterButtonC2R_InvestingAccount() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] sPayeeName = "Vanguard"
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[ ] 
		[ ] 
		[+] if (iResult  == PASS)
								[ ] 
			[ ] //------------------Verify Finish Later Button present on bottom of the C2R window------------------
			[ ] sleep(2)
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sleep(2)
			[ ] 
			[+] if(MDIClient.AccountRegister.FinishLater.Exists(5))
				[ ] 
				[ ] ReportStatus("Check Finish Later Button present",PASS,"Finish Later Button is present on the bottom of the C2R window")
				[ ] 
				[ ] //------------------Click on Finish Later Button for accepting all the transactions------------------
				[ ] 
				[ ] MDIClient.AccountRegister.FinishLater.Click()
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] 
				[ ] //------------------Verify the Accept, Hide Accepted buttons are disabled.------------------
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sleep(1)
				[+] if(!MDIClient.AccountRegister.Accept.IsEnabled())
					[ ] 
					[ ] ReportStatus("Check Accept Button exists",PASS,"C2R window got minimized as Accept Button not exists")
					[ ] 
				[+] else
					[ ] ReportStatus("Check Accept Button exists",FAIL,"C2R window not got minimized as Accept Button exists")
					[ ] 
				[ ] 
				[ ] //------------------Verify all transactions are in C2R window.------------------
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sleep(2)
				[ ] 
				[ ] iCounter=MDIClient.AccountRegister.C2RListBox.GetItemCount()*2
				[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
				[+] for(iRow=0,i=1;iRow<iCounter;iRow=iRow+2,i++)
					[ ] 
					[ ] 
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iRow))
					[ ] 
					[ ] bMatch= MatchStr("*{sPayeeName}*",sActual)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Check the transaction",PASS,"'{sActual}' transaction is available in C2R")
					[+] else
						[ ] ReportStatus("Check the transaction",FAIL,"'{sActual}' transaction is not available in C2R")
				[ ] 
			[+] else
				[ ] ReportStatus("Check Finish Later Button present",FAIL,"Finish Later Button is present on the bottom of the C2R window")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //#######################################################################################
[ ] 
[+] //############# Verify Right Click Menu-UnMatch Transaction  in C2R of Investing Account####################
	[+] // TestCase Name:	Test54_VerifyRightClickMenuDeleteTrxnsC2RInvesting()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test55_RightClickUnMatchTransactionC2RInvesting() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // Variable Definition
		[ ] sAccount="Investment at Vanguard"
		[ ] sAccepted = "Accepted"
		[ ] sPayeeName = "Vanguard Total Bond Market Index Fund Investor Shares"
		[ ] sOperationType="Unmatch"
		[ ] sAccept = "Near Match"
		[ ] sAccepted="New"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)
		[ ] 
		[ ] Sleep(2)
		[ ] 
		[+] if(iSelect == PASS)
			[ ] 
			[ ] ReportStatus("Select the Online Investing Account",PASS,"{sAccount} Online Investing Account is selected successfully")
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] //------------------Verify the UnMatch-Edit Menu for transaction------------------
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sleep(2)
			[ ] 
			[ ] iListCount=MDIClient.AccountRegister.C2RListBox.GetItemCount()
			[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
			[+] for(iCounter=0; iCounter<=iListCount ; iCounter++)
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCounter))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccept}*",sActual)
				[+] if(bMatch)
					[ ] break
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as ' Near Match' ")
			[+] else
				[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'Match' ")
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sleep(1)
			[ ] iResult=C2RTransactionOperations(sAccept,lsInvokeOperation[2],sOperationType,ACCOUNT_INVESTING)
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] //------------------Verify the Edit Button for each transaction------------------
			[ ] iListCount=MDIClient.AccountRegister.C2RListBox.GetItemCount()
			[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
			[+] for(iCounter=0; iCounter<=iListCount ; iCounter++)
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCounter))
				[ ] 
				[ ] bMatch= MatchStr("*{sAccepted}*",sActual)
				[+] if(bMatch)
					[ ] break
			[ ] 
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Check the Status of the matched transaction",PASS,"The Status of the matched transaction is as 'New' after selecting Edit Menu-UnMatch ")
			[+] else
				[ ] ReportStatus("Check the Status of the matched transaction",FAIL,"The Status of the matched transaction is not as 'New' after selecting Edit Menu-UnMatch ")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Investing Account",FAIL,"{sAccount} Online Investing Account is selected successfully")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
[ ] //#######################################################################################
[ ] //Commented as account credentials are not working
[+] // //######## Banking Account - Download transactions with the account open for Direct Connect FI.################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	Test33_OneYearTransactionInC2R()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // //Verify that Quicken prompts user when user tries to enter transaction over a year old.
		[ ] // 
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			        Pass 	If Quicken prompts user when user tries to enter transaction over a year old.		
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Nov 18, 2013		Anagha	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase Test34_DownloadTransactionManualtoDC() appstate none
	[ ] // 
	[ ] // //------------------ Variable declaration & definition------------------
	[ ] // STRING sTextMessage,sTransactionDownload,sUserName,sPassword,sAccountNumber,sFIName
	[ ] // 
	[ ] // sAccount = "Checking 01 Account" 
	[ ] // sTextMessage="You are entering a transaction over a year"
	[ ] // sFIName = "Mission Federal Credit Union"
	[ ] // sTransactionDownload = "Activate Downloads"
	[ ] // sUserName="91058197"
	[ ] // sPassword="Raiders2030"
	[ ] // sAccountNumber="91058197-09"
	[ ] // iXcord = 1038
	[ ] // iYcord = 30
	[ ] // sMessage="There are no downloaded transactions to accept." 
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // //------------------Select the Online Checking Account------------------
		[ ] // iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] // 
		[+] // if(iSelect == PASS)
			[ ] // ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] // 
			[ ] // QuickenWindow.Tools.Click()
			[ ] // QuickenWindow.Tools.AccountList.Select()
			[ ] // 
			[ ] // Sleep(2)
			[ ] // 
			[ ] // iSelect=NavigateToAccountDetails(sAccount)
			[ ] // 
			[ ] // 
			[+] // if(AccountDetails.Exists(5))
				[ ] // ReportStatus("Verify that Account Details is opened ",PASS,"Account Details Window is opened successfully")
				[ ] // AccountDetails.SetActive()
				[ ] // AccountDetails.FinancialInstitution.SetText(sFIName)
				[ ] // 
				[ ] // AccountDetails.AccountNumber.SetText(sAccountNumber)
				[ ] // 
				[ ] // AccountDetails.OK.Click()
				[ ] // 
				[+] // if(AccountList.Exists(5))
					[ ] // ReportStatus("Verify that Account List is present ",PASS,"Account List Window is present")
					[ ] // 
					[ ] // AccountList.SetActive()
					[ ] // AccountList.Maximize()
					[ ] // 
					[ ] // sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
					[ ] // 
					[+] // for(i=0;i<AccountList.QWinChild.Order.ListBox.GetItemCount();i++)
						[ ] // 
						[ ] // sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
						[ ] // 
						[ ] // bMatch=MatchStr("*{sAccount}*",sActual)
						[ ] // 
						[+] // if(bMatch==TRUE)
							[ ] // ReportStatus("Verify Account is present in Account List",PASS,"Account{sAccount} is present in Account List")
							[ ] // break
						[ ] // 
						[ ] // 
					[ ] // bMatch=MatchStr("*{sTransactionDownload}*",sActual)
					[ ] // 
					[+] // if(bMatch==TRUE)
						[ ] // ReportStatus("Verify Transaction Download changes",PASS,"Transaction Download status change to {sTransactionDownload} in Account List")
						[ ] // 
						[ ] // //AccountList.QWinChild.Order.ListBox.Click(1,1155, 293)
						[ ] // 
						[ ] // AccountList.QWinChild.Order.ListBox.TextClick(sTransactionDownload)
						[ ] // 
						[ ] // 
						[ ] // iResult=ActivateDownload(sUserName,sPassword)
						[ ] // 
						[+] // if(iResult==PASS)
							[ ] // 
							[ ] // ReportStatus("Verify Activate Downloads is done",PASS,"Manual account got linked with Online Checking account successfully.")
							[ ] // 
							[ ] // AccountList.SetActive()
							[ ] // AccountList.Close()
							[ ] // sleep(2)
							[ ] // MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
							[ ] // sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
							[ ] // 
							[ ] // sActual = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle,str(0))
							[ ] // 
							[ ] // bMatch=MatchStr("*{sMessage}*",sActual)
							[ ] // 
							[+] // if(bMatch==FALSE)
								[ ] // ReportStatus("Verify Transactions in C2R",PASS,"Transactions are downloaded in C2R")
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify Transactions in C2R",FAIL,"Transactions are not downloaded in C2R")
								[ ] // 
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify Activate Downloads is done",PASS,"Manual account got linked with Online Checking account successfully.")
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Transaction Download changes",FAIL,"Transaction Download status not change to {sTransactionDownload} in Account List")
						[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify that Account List is present ",FAIL,"Account List Window is not present")
			[+] // else
				[ ] // ReportStatus("Verify that Account Details is opened ",FAIL,"Account Details Window is opened successfully")
				[ ] // 
				[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] // 
	[ ] // 
[ ] //###############################################################################################
[+] //############# Verify Right Click Menu-Delete Transaction in C2R of Investing Account####################
	[+] // TestCase Name:	Test54_VerifyRightClickMenuDeleteTrxnsC2RInvesting()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test54_RightClickDeleteTransactionC2RInvesting() appstate none
	[+] 
		[ ] 
	[ ] 
	[+] // Variable Definition
		[ ] STRING sTxnCountBeforeDelete ,sTxnCountAfterDelete
		[ ] INTEGER iTxnCountBeforeDelete ,iTxnCountAfterDelete ,iExpectedTxnCountAfterDelete
		[ ] LIST of ANYTYPE lsTxnCountBeforeDelete ,lsTxnCountAfterDelete
		[ ] sAccount="Investment at Vanguard"
		[ ] 
		[ ] sPayeeName = "Vanguard Federal Money Market Fund"
		[ ] sOperationType="Delete"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)
		[ ] 
		[ ] Sleep(2)
		[ ] 
		[ ] 
		[+] if(iSelect == PASS)
			[ ] 
			[ ] ReportStatus("Select the Online Investing Account",PASS,"{sAccount} Online Investing Account is selected successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] //Get transaction count of C2R before delete 
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
			[ ] sleep(1)
			[ ] sTxnCountBeforeDelete=MDIClient.AccountRegister.DownloadedTransactionsTab.GetProperty("Text")
			[ ] 
			[ ] sTxnCountBeforeDelete=StrTran(StrTran(sTxnCountBeforeDelete ,")","") ,"Downloaded Transactions (","")
			[ ] 
			[ ] iTxnCountBeforeDelete=VAL(sTxnCountBeforeDelete)
			[ ] iExpectedTxnCountAfterDelete =iTxnCountBeforeDelete -1
			[ ] 
			[ ] 
			[ ] /////Verify Right Click Menu-Delete Transaction in C2R of Investing Account
			[ ] C2RTransactionOperations(sPayeeName,lsInvokeOperation[2],sOperationType ,ACCOUNT_INVESTING)
			[ ] sleep(1)
			[ ] sTxnCountAfterDelete=MDIClient.AccountRegister.DownloadedTransactionsTab.GetProperty("Caption")
			[ ] sTxnCountAfterDelete=StrTran(StrTran(sTxnCountAfterDelete ,")","") ,"Downloaded Transactions (","")
			[ ] 
			[ ] iTxnCountAfterDelete=VAL(sTxnCountAfterDelete)
			[+] if (iTxnCountAfterDelete==iExpectedTxnCountAfterDelete)
				[ ] ReportStatus("Verify that transaction deleted from investing C2R" , PASS , "Transaction has been deleted from investing C2R.")
			[+] else
				[ ] ReportStatus("Verify that transaction deleted from investing C2R" , FAIL , "Transaction couldn't be deleted from investing C2R as count after delete :{iTxnCountAfterDelete} is not one transaction less than before delete: {iTxnCountBeforeDelete}.")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Investing Account",FAIL,"{sAccount} Online Investing Account is selected successfully")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
[ ] //#######################################################################################
[ ] 
[ ] 
[+] //############# Verify Right Click Menu-AcceptAll Transaction  in C2R of Investing Account##################
	[+] // TestCase Name:	Test43_VerifyInvestingAccountAcceptButtonOnTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify FI LOGO ,FI Website link and FI WEbsite Help Link.
		[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 3, 2013		Girish	created
	[ ] // ********************************************************
[+] testcase Test53_VerifyRightClickMenuAcceptAllTransactionC2R_InvestingAccount() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile,iAccount,iCounter
		[ ] STRING sFileName1,sOnlineTransactionDataFile, sFilePath,sFileName,sAccount,sAccountName, sExpected,sFileName2,sAccepted,sAcceptAllTransaction,sActual
		[ ] LIST OF STRING lsFileName
		[ ] lsFileName = {"Vanguard_Investing1","Vanguard_Investing2"}
		[ ] sAccount="Investment at Vanguard"
		[ ] 
		[ ] 
	[+] // Expected Values
		[ ] sAccountName="Investment at Vanguard"
		[ ] sAcceptAllTransaction = "Accept All"
		[ ] sMessage="There are no downloaded transactions to accept." 
		[ ] lsPayeeName = {"Vanguard Federal Money Market Fund","Vanguard Federal Money Market Fund"}
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] ///Delete Account
		[ ] iResult =DeleteAccount(ACCOUNT_INVESTING ,sAccount)
		[+] if(iResult == PASS)
			[ ] //------------------Import a Web Connect File for first time------------------
			[ ] sAccount="Investment at Vanguard"
			[ ] iResult = ImportWebConnectFile(lsFileName[1])
			[+] if(iResult == PASS)
				[ ] ReportStatus("Import Web Connect File ",PASS,"Web Connect file for first time is imported successfully")
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)	
				[ ] 
				[+] if(iSelect==PASS)
					[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
					[ ] 
					[ ] //------------------Click on Accept All Button for accepting all the transactions------------------
					[ ] 
					[ ] 
					[ ] Sleep(2)
					[ ] 
					[ ] //------------------Import a Web Connect File for second time------------------
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.File.Click()
					[ ] QuickenWindow.File.FileImport.Click()
					[ ] QuickenWindow.File.FileImport.WebConnectFile.Select()
					[ ] 
					[ ] // open the Web connect file for Banking
					[ ] ImportExportQuickenFile.SetActive()
					[ ] ImportExportQuickenFile.FileName.SetText(lsFileName[2])
					[ ] ImportExportQuickenFile.OK.Click()
					[+] if(BofaCriticalMsg.Exists(10))
							[ ] BofaCriticalMsg.SetActive()
							[ ] BofaCriticalMsg.OK.Click()
					[ ] 
					[ ] 
					[ ] 
					[+] if(OneStepUpdateSummary.Exists(120))
						[ ] OneStepUpdateSummary.SetActive()
						[ ] OneStepUpdateSummary.Close()
						[ ] WaitForState(OneStepUpdateSummary , FALSE ,5)
						[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
						[ ] 
						[+] if (iResult  == PASS)
							[ ] sleep(10)
							[ ] 
							[ ] //------------------Right Click on Accept Button to accept-----------------
							[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
							[ ] sleep(2)
							[ ] iResult=C2RTransactionOperations(lsPayeeName[1],lsInvokeOperation[2],sAcceptAllTransaction,ACCOUNT_INVESTING)
							[ ] 
							[+] if(SecuritiesComparisonMismatch.Exists(120))
								[ ] SecuritiesComparisonMismatch.SetActive()
								[ ] SecuritiesComparisonMismatch.DoneButton.Click()
							[ ] 
							[ ] //------------------Verify there are no transactions left to be Accepted in C2R-------------------------
							[ ] sleep(2)
							[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
							[ ] sleep(2)
							[ ] sHandle = Str(MDIClient.AccountRegister.C2RListBox.GetHandle())
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
							[ ] bMatch= MatchStr("*{sMessage}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Check Status of the transaction is 'Accepted'",PASS,"There are no transactions left in the C2R to be Accepted")
							[+] else
								[ ] ReportStatus("Check Status of the transaction is 'Accepted'",FAIL,"There are some  transactions left in the C2R that needs to be Accepted")
							[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
							[ ] iResult=FindTransaction("MDI",lsPayeeName[1] ,ACCOUNT_INVESTING)
							[+] if(iResult==PASS)
								[ ] 
								[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{lsPayeeName[1]}' got added in Register after clicking on Accept Button in C2R")
								[ ] 
							[+] else
								[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction'{lsPayeeName[1]}' not got added in Register after clicking on Accept Button in C2R")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify OneStep Update Summary dialog." ,FAIL, "OneStep Update Summary dialog didn't appear.")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
					[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Import Web Connect File ",FAIL,"Web Connect file for first time is not imported successfully")
		[+] else
			[ ] ReportStatus("Verify account: {sAccount} deleted.  ",FAIL,"Account: {sAccount} couldn't be deleted due to defect: QW-3283")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //#######################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] // #####Banking Account - Download transactions with the account open for  Express Web Connect  FI.##############
	[ ] // ********************************************************
	[+] // TestCase Name:	Test33_OneYearTransactionInC2R()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // Verify that Quicken prompts user when user tries to enter transaction over a year old.
		[ ] // 
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If Quicken prompts user when user tries to enter transaction over a year old.		
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 18, 2013		Anagha	created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test35_DownloadTransactionManualtoEWC() appstate none
	[ ] 
	[ ] // ------------------ Variable declaration & definition------------------
	[ ] STRING sTextExpressWebConnect,sTransactionDownload,sUserName,sPassword,sAccountNumber,sFIName
	[ ] 
	[ ] sAccount = "Checking 02 Account" 
	[ ] sTextExpressWebConnect="Express Web Connect"
	[ ] sFIName = "CCBank"
	[ ] sTransactionDownload = "Activate Downloads"
	[ ] sUserName="quicken"
	[ ] sPassword="quicken"
	[ ] sAccountNumber="2000005555"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Checking Account",PASS,"{sAccount} Online Checking Account is selected successfully")
			[ ] 
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.AccountList.Select()
			[ ] 
			[ ] Sleep(2)
			[ ] 
			[ ] iSelect=NavigateToAccountDetails(sAccount)
			[ ] 
			[ ] 
			[+] if(iSelect==PASS)
				[ ] ReportStatus("Verify that Account Details is opened ",PASS,"Account Details Window is opened successfully")
				[ ] 
				[ ] AccountDetails.FinancialInstitution.SetText(sFIName)
				[ ] 
				[ ] AccountDetails.AccountNumber.SetText(sAccountNumber)
				[ ] 
				[ ] AccountDetails.OK.Click()
				[ ] 
				[ ] Sleep(2)
				[ ] 
				[+] if(AccountList.Exists(5))
					[ ] ReportStatus("Verify that Account List is present ",PASS,"Account List Window is present")
					[ ] 
					[ ] AccountList.SetActive()
					[ ] AccountList.Maximize()
					[ ] 
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
					[ ] 
					[+] for(i=0;i<AccountList.QWinChild.Order.ListBox.GetItemCount();i++)
						[ ] 
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sAccount}*",sActual)
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Account is present in Account List",PASS,"Account{sAccount} is present in Account List")
							[ ] break
						[ ] 
					[ ] bMatch=MatchStr("*{sTransactionDownload}*",sActual)
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Transaction Download changes",PASS,"Transaction Download status change to {sTransactionDownload} in Account List")
						[ ] 
						[ ] 
						[ ] AccountList.QWinChild.Order.ListBox.TextClick(sTransactionDownload ,1)
						[ ] 
						[ ] iResult=ActivateDownload(sUserName,sPassword)
						[ ] 
						[+] if(iResult==PASS)
							[ ] 
							[ ] ReportStatus("Verify Activate Downloads is done",PASS,"Manual account got linked with Online Checking account successfully.")
							[+] for(i=0;i<AccountList.QWinChild.Order.ListBox.GetItemCount();i++)
								[ ] 
								[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
								[ ] 
								[ ] bMatch=MatchStr("*{sAccount}*{sTextExpressWebConnect}*",sActual)
								[ ] 
								[+] if(bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Verify Activate Downloads is done",PASS,"Manual account: {sAccount} got converted to type EWC account successfully as expected:{sActual}.")
							[+] else
								[ ] ReportStatus("Verify Activate Downloads is done",FAIL,"Manual account: {sAccount} couldn't be converted to type EWC account.")
							[ ] 
							[ ] AccountList.SetActive()
							[ ] AccountList.Close()
							[ ] sleep(2)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Activate Downloads is done",PASS,"Manual account got linked with Online Checking account successfully.")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Transaction Download changes",FAIL,"Transaction Download status not change to {sTransactionDownload} in Account List")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Account List is present ",FAIL,"Account List Window is not present")
			[+] else
				[ ] ReportStatus("Verify that Account Details is opened ",FAIL,"Account Details Window is opened successfully")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Online Checking Account",FAIL,"{sAccount} Online Checking Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] // ###############################################################################################
[ ] 
