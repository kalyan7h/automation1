﻿[ ] // *********************************************************
[+] // FILE NAME:	<ACE.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Memorized Payee List test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:Shrivardhan	
	[ ] //
	[ ] // Developed on: 		13/07/2014
	[ ] //			
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "C:\automation\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] // Variable Declaration
	[ ] 
	[ ] STRING sFileName1="ACE_Test",sAccount,sFileName,sTab="Check #"
	[ ] INTEGER iResult,iSelect,iFlag
	[ ] LIST OF ANYTYPE lsExcelData,lsResponseRequestDetails,lsPayeeDetails
	[ ] STRING sPayeeDetail,sCategory
	[ ] HFILE hFile
	[ ] public STRING sACEData= "ACE",sRequestResponseWorksheet="Request_Response",sPayeeDetailWorsheet="PayeeDetails",sAccountDetails="AccountDetails"
	[ ] STRING sWebFile=LOCAL_LOG+"\WEB0.tmp",sLBTLogFile=LOCAL_LOG+"\lbtlog.txt",sOFXLogFile=AUT_DATAFILE_PATH+"\OFXLOG.txt",sPath="ACE_files\"
	[ ] BOOLEAN bMatch
	[ ] STRING sRight_Click="Right Click",sAccept="Accept",sHandle
	[ ] 
[ ] 
[ ] // All data for the QDF(Web Connect Files) is got from Excelsheet - "ACE" and worksheet - "PayeeDetails"
[ ] //Data for testcase 14,15,16,17 is found in worksheet="PayeeDetails" . The 4th and 5th row must be changed .the 1st column must be changed to the latest payee names and the 2nd coulumn should be changed to the corresponding payee categories 
[ ] 
[+] //############# ACE  SetUp #################################################
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
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test0_ACESetUp()appstate none
	[+] //variable declaration
		[ ] STRING sWebFile1=LOCAL_LOG+"\WEB1.tmp",sLine
		[ ] INTEGER i
		[ ] 
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ]  //########Launch Quicken and open MemorizedPayee_Test File######################//
	[ ] iResult=DataFileCreate(sFileName1)
	[+] if(iResult==PASS)
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
		[ ] //Report Status if Quicken is not launched
		[+] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available")
		[ ] 
		[ ] 
		[ ] // Open file, append line, and close
		[ ] hFile = SYS_FileOpen (sQuickenIniFile, FM_UPDATE)
		[ ] 
		[+] for i = 1 to 32
			[ ] FileReadLine(hFile, sLine)
		[ ] 
		[ ] FileReadLine(hFile, sLine)
		[ ] SYS_FileClose (hFile)
		[ ] 
		[+] if(sLine!="lbtlog=3")
			[ ] // Open file, append line, and close
			[ ] hFile = SYS_FileOpen (sQuickenIniFile, FM_UPDATE)
			[ ] 
			[+] for i = 1 to 32
				[ ] FileReadLine(hFile, sLine)
			[ ] 
			[ ] SYS_FileWriteLine (hFile, "lbtlog=3")
			[ ] SYS_FileClose (hFile)
		[ ] 
		[ ] 
		[+] if(SYS_FileExists(sLBTLogFile))
			[ ] DeleteFile(sLBTLogFile)
		[+] if(SYS_FileExists(sWebFile))
			[ ] DeleteFile(sWebFile)
		[+] if(SYS_FileExists(sWebFile1))
			[ ] DeleteFile(sWebFile1)
		[+] if(SYS_FileExists(sOFXLogFile))
			[ ] DeleteFile(sOFXLogFile)
		[ ] 
		[+] if (LowScreenResolution.Exists(5))
			[ ] LowScreenResolution.SetActive()
			[ ] LowScreenResolution.Dontshowthisagain.Check()
			[ ] LowScreenResolution.OK.Click()
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName1} created ", FAIL, "Verify datafile {sFileName1} created: Datafile {sFileName1} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //############# Test01-Verify first time download for clean payee in C2R mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_FirstTimeDownloadC2RMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the request and response when a web connect file is imported for the first time in C2R mode
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test1_FirstTimeDownloadC2RMode()appstate none
	[+] //variable declaration
		[ ] sFileName="ACE01"
		[ ] sAccount="Checking at Bank of America-All Other S"
		[ ] STRING sLine
		[ ] LIST OF STRING lsPayeeDetailRegister
		[ ] INTEGER i=1,iRequestLines
		[ ] bMatch=FALSE
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Set C2R mode ON
		[ ] iFlag=SetC2RMode("ON")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode set successfully")
			[ ] //import Web Connect File
			[ ] iSelect=ImportWebConnectFile(sPath+sFileName)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify web connect file is imported",PASS,"web connect file was imported successfully")
				[ ] //open register from account bar
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
					[ ] 
					[ ] // Read data from excel sheet for payee details
					[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
					[ ] 
					[ ] lsPayeeDetails=lsExcelData[1]
					[ ] 
					[ ] //accept transactions via C2R
					[ ] iSelect=C2RTransactionOperations(lsPayeeDetails[1],sRight_Click,sAccept)
					[ ] 
					[+] if(iSelect==PASS)
						[ ] ReportStatus("verify transaction was accepted",PASS,"transaction was accepted successfully")
						[ ] //Get Payee details from register
						[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
						[ ] 
						[ ] //verify if  transaction has payee name
						[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[1])
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
						[+] else
							[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
						[ ] 
						[ ] //verify if  transaction has payee category
						[ ] bMatch=MatchStr("*{lsPayeeDetails[2]}*",lsPayeeDetailRegister[1])
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
						[+] else
							[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
						[ ] 
						[ ] // verify payee is memorized
						[ ] iFlag=SearchPayeeInMemorizedPayee(lsPayeeDetails[1])
						[ ] 
						[+] if(iFlag==PASS)
							[ ] ReportStatus("verify payee is present in memorized payee list",PASS,"payee is memorized")
						[+] else
							[ ] ReportStatus("verify payee is present in memorized payee list",FAIL,"payee is not memorized")
						[ ] 
						[ ] //save ofx log
						[ ] iFlag=OpenAndSaveOFXLog()
						[ ] 
						[+] if(iFlag==PASS)
							[ ] ReportStatus("verify ofx log was saved",PASS,"ofx log was saved successfully")
							[ ] // Read data from excel sheet for request
							[ ] lsExcelData=ReadExcelTable(sACEData, sRequestResponseWorksheet)
							[ ] //get number of lines of request
							[ ] iRequestLines=ListCount(lsExcelData)-2
							[ ] // Fetch 1st row from the given sheet
							[ ] lsResponseRequestDetails=lsExcelData[1]
							[ ] 
							[ ] bMatch=FALSE
							[ ] i=1
							[ ] //open response file
							[ ] hFile = FileOpen (sOFXLogFile, FM_READ)
							[ ] //reading and verifyin response
							[+] while (FileReadLine (hFile, sLine)) 
								[ ] 
								[ ] // verify request
								[+] if(lsResponseRequestDetails[2]==sLine)
									[ ] bMatch=TRUE
									[ ] ReportStatus("verify request ",PASS,"correct request sent")
								[+] else
									[ ] 
									[+] if(bMatch==TRUE)
										[ ] bMatch=FALSE
										[ ] ReportStatus("verify request",FAIL,"incorrect request sent")
										[ ] break
								[ ] 
								[+] if(bMatch==TRUE)
									[ ] i++
									[+] if(i<iRequestLines)
										[ ] 
										[ ] // Fetch jth row from the given sheet
										[ ] lsResponseRequestDetails=lsExcelData[i]
									[+] else
										[ ] break
									[ ] 
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[+] if(i==iRequestLines)
								[ ] ReportStatus("verify request",PASS,"all lines of request match correctly")
							[+] else
								[ ] ReportStatus("verify request",FAIL,"all lines of request not matched correctly")
							[ ] 
							[ ] //close response file
							[ ] FileClose (hFile)  
							[ ] 
						[+] else
							[ ] ReportStatus("verify ofx log was saved",FAIL,"ofx log could not be saved")
						[ ] 
						[ ] // Read data from excel sheet for response
						[ ] lsExcelData=ReadExcelTable(sACEData, sRequestResponseWorksheet)
						[ ] i=1
						[ ] //open response file
						[ ] hFile = FileOpen (sWebFile, FM_READ)
						[ ] //reading and verifyin response
						[+] while (FileReadLine (hFile, sLine)) 
							[ ] 
							[ ] // Fetch ith row from the given sheet
							[ ] lsResponseRequestDetails=lsExcelData[i]
							[ ] // verify response
							[+] if(lsResponseRequestDetails[1]==sLine)
								[ ] ReportStatus("verify response ",PASS,"correct response received")
							[+] else
								[ ] ReportStatus("verify response",FAIL,"incorrect response received")
							[ ] i++
							[ ] 
						[ ] //close response file
						[ ] FileClose (hFile)  
					[+] else
						[ ] ReportStatus("verify transaction was accepted",FAIL,"transaction was not accepted successfully")
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
				[ ] //delete payee
				[ ] DeletePayees()
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
				[ ] //Remove OFX Log file
				[ ] DeleteOFXLogFile(sFileName1)
				[ ] //Delete lbtlog file
				[ ] DeleteFile(sLBTLogFile)
				[ ] //delete Webxx.tmp file
				[ ] DeleteFile(sWebFile)
			[+] else
				[ ] ReportStatus("verify web connect file is imported",FAIL,"web connect file could not be imported")
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was not set")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
[ ] 
[+] //############# Test02-Verify first time download for clean payee in non C2R mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test2_FirstTimeDownloadNonC2RMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the request and response when a web connect file is imported for the first time in non C2R mode
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test2_FirstTimeDownloadNonC2RMode()appstate none
	[ ] 
	[ ] 
	[+] //variable declaration
		[ ] sFileName="ACE01"
		[ ] sAccount="Checking at Bank of America-All Other S"
		[ ] STRING sLine
		[ ] LIST OF STRING lsPayeeDetailRegister
		[ ] INTEGER i=1,iRequestLines
		[ ] bMatch=FALSE
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Set C2R mode OFF
		[ ] iFlag=SetC2RMode("OFF")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is unset",PASS,"C2R mode unset successfully")
			[ ] //import Web Connect File
			[ ] iSelect=ImportWebConnectFile(sPath+sFileName)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify web connect file is imported",PASS,"web connect file was imported successfully")
				[ ] //open register from account bar
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
					[ ] 
					[ ] // Read data from excel sheet for payee details
					[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
					[ ] 
					[ ] lsPayeeDetails=lsExcelData[1]
					[ ] 
					[ ] 
					[ ] //Get Payee details from register
					[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
					[ ] 
					[ ] //verify if  transaction has payee name
					[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[1])
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
					[+] else
						[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
					[ ] 
					[ ] //verify if  transaction has payee category
					[ ] bMatch=MatchStr("*{lsPayeeDetails[2]}*",lsPayeeDetailRegister[1])
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
					[+] else
						[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
					[ ] 
					[ ] // verify payee is memorized
					[ ] iFlag=SearchPayeeInMemorizedPayee(lsPayeeDetails[1])
					[ ] 
					[+] if(iFlag==PASS)
						[ ] ReportStatus("verify payee is present in memorized payee list",PASS,"payee is memorized")
					[+] else
						[ ] ReportStatus("verify payee is present in memorized payee list",FAIL,"payee is not memorized")
					[ ] 
					[ ] //save ofx log
					[ ] iFlag=OpenAndSaveOFXLog()
					[ ] 
					[+] if(iFlag==PASS)
						[ ] ReportStatus("verify ofx log was saved",PASS,"ofx log was saved successfully")
						[ ] // Read data from excel sheet for request
						[ ] lsExcelData=ReadExcelTable(sACEData, sRequestResponseWorksheet)
						[ ] //get number of lines of request
						[ ] iRequestLines=ListCount(lsExcelData)-2
						[ ] // Fetch 1st row from the given sheet
						[ ] lsResponseRequestDetails=lsExcelData[1]
						[ ] 
						[ ] bMatch=FALSE
						[ ] i=1
						[ ] //open response file
						[ ] hFile = FileOpen (sOFXLogFile, FM_READ)
						[ ] //reading and verifyin response
						[+] while (FileReadLine (hFile, sLine)) 
							[ ] 
							[ ] // verify request
							[+] if(lsResponseRequestDetails[2]==sLine)
								[ ] bMatch=TRUE
								[ ] ReportStatus("verify request ",PASS,"correct request sent")
							[+] else
								[ ] 
								[+] if(bMatch==TRUE)
									[ ] bMatch=FALSE
									[ ] ReportStatus("verify request",FAIL,"incorrect request sent")
									[ ] break
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] i++
								[+] if(i<iRequestLines)
									[ ] 
									[ ] // Fetch jth row from the given sheet
									[ ] lsResponseRequestDetails=lsExcelData[i]
								[+] else
									[ ] break
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[+] if(i==iRequestLines)
							[ ] ReportStatus("verify request",PASS,"all lines of request match correctly")
						[+] else
							[ ] ReportStatus("verify request",FAIL,"all lines of request not matched correctly")
						[ ] 
						[ ] //close response file
						[ ] FileClose (hFile)  
						[ ] 
					[+] else
						[ ] ReportStatus("verify ofx log was saved",FAIL,"ofx log could not be saved")
					[ ] 
					[ ] // Read data from excel sheet for response
					[ ] lsExcelData=ReadExcelTable(sACEData, sRequestResponseWorksheet)
					[ ] i=1
					[ ] //open response file
					[ ] hFile = FileOpen (sWebFile, FM_READ)
					[ ] //reading and verifyin response
					[+] while (FileReadLine (hFile, sLine)) 
						[ ] 
						[ ] // Fetch ith row from the given sheet
						[ ] lsResponseRequestDetails=lsExcelData[i]
						[ ] // verify response
						[+] if(lsResponseRequestDetails[1]==sLine)
							[ ] ReportStatus("verify response ",PASS,"correct response received")
						[+] else
							[ ] ReportStatus("verify response",FAIL,"incorrect response received")
						[ ] i++
						[ ] 
					[ ] //close response file
					[ ] FileClose (hFile)  
					[ ] 
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
				[ ] //delete payee
				[ ] DeletePayees()
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
				[ ] //Remove OFX Log file
				[ ] DeleteOFXLogFile(sFileName1)
				[ ] //Delete lbtlog file
				[ ] DeleteFile(sLBTLogFile)
				[ ] //delete Webxx.tmp file
				[ ] DeleteFile(sWebFile)
			[+] else
				[ ] ReportStatus("verify web connect file is imported",FAIL,"web connect file could not be imported")
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was not set")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test03- Verify first time download for clean payee in C2R mode when payee is already memorized #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_PayeeMemorizedC2RMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the category of the downloaded payee when it is already memorized and category has been changed in C2R mode
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test3_PayeeMemorizedC2RMode()appstate none
	[ ] 
	[+] //variable declaration
		[ ] INTEGER iAddAccount,i=1
		[ ] LIST OF STRING lsAddAccount,lsCategory,lsPayeeDetailRegister
		[ ] sFileName="ACE01"
		[ ] bMatch=FALSE
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sACEData, sAccountDetails)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] 
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] //Set C2R mode ON
			[ ] iFlag=SetC2RMode("ON")
			[ ] 
			[+] if(iFlag==PASS)
				[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode was set")
				[ ] 
				[ ] //read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
				[ ] //read the first row
				[ ] lsCategory=lsExcelData[1]
				[ ] 
				[ ] iFlag=AddCategory(lsCategory[3],"","",lsCategory[4])
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify category was added",PASS,"category was added successfully")
					[ ] //read the first row
					[ ] lsPayeeDetails=lsExcelData[1]
					[ ] 
					[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[+] if(iSelect==PASS)
						[ ] ReportStatus(" verify account was selected from account bar",PASS,"account was selected from account bar successfully")
						[ ] // add check # tab in register
						[ ] EditTabsInRegister("Add",sTab)
						[ ] 
						[ ] //Adding transaction
						[ ] iFlag= AddCheckingTransaction("MDI","Payment",lsPayeeDetails[5],lsAddAccount[4],"",lsPayeeDetails[1],"",lsCategory[4]+":"+lsCategory[3])
						[ ] 
						[+] if(iFlag==PASS)
							[ ] ReportStatus("verify transaction was added ",PASS,"transaction was added sucesfully")
							[ ] 
							[ ] //import web connect file and link it to existing account
							[ ] iSelect=ImportWebConnectFile(sPath+sFileName,"",1)
							[ ] 
							[+] if(iSelect==PASS)
								[ ] ReportStatus(" verify web connect file was imported and linked to existing account",PASS,"web connect file was imported and linked to existing account successfully")
								[ ] //select account from account bar
								[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
								[ ] 
								[ ] //accept transactions via C2R
								[ ] iSelect=C2RTransactionOperations(lsPayeeDetails[1],sRight_Click,sAccept)
								[ ] 
								[+] if(iSelect==PASS)
									[ ] ReportStatus("verify transaction was accepted",PASS,"transaction was accepted successfully")
									[ ] 
									[ ] 
									[ ] //verify if request is sent through checking if response exists
									[+] if (!SYS_FileExists(sWebFile))
										[ ] ReportStatus("verify request has not been sent",PASS,"request has not been sent")
									[+] else
										[ ] ReportStatus("verify request has not been sent",FAIL,"request has been sent")
									[ ] 
									[ ] //Get Payee details from register
									[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
									[ ] 
									[+] if(ListCount(lsPayeeDetailRegister)>1)
										[+] while(i<3)
											[ ] 
											[ ] //verify if  transaction has payee name
											[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[i])
											[ ] 
											[+] if(bMatch==TRUE)
												[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
											[+] else
												[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
											[ ] 
											[ ] //verify if  transaction has payee category
											[ ] bMatch=MatchStr("*{lsCategory[4]+":"+lsCategory[3]}*",lsPayeeDetailRegister[i])
											[ ] 
											[+] if(bMatch==TRUE)
												[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
											[+] else
												[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
											[ ] i++
									[+] else
										[ ] ReportStatus("verify if payee was registered",FAIL,"payee was not registered")
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("verify transaction was accepted",FAIL,"transaction was not accepted successfully")
								[ ] 
							[+] else
								[ ] ReportStatus(" verify web connect file was imported and linked to existing account",FAIL,"web connect file was not  imported and linked to existing account successfully")
						[+] else
							[ ] ReportStatus("verify transaction was added ",FAIL,"transaction could not be added")
					[+] else
						[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected from account bar")
				[+] else
					[ ] ReportStatus("verify category was added",FAIL,"category was not added successfully")
			[+] else
				[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was not set")
			[ ] //delete account
			[ ] DeleteAccount(ACCOUNT_BANKING,lsAddAccount[2])
			[ ] //delete category
			[ ] DeleteCategory(lsCategory[3],1)
			[+] if(CategoryList.Exists(5))
				[ ] CategoryList.Close()
			[ ] 
			[ ] //delete payee
			[ ] DeletePayees()
			[ ] //Remove OFX Log file
			[ ] DeleteOFXLogFile(sFileName1)
			[ ] //Delete lbtlog file
			[ ] DeleteFile(sLBTLogFile)
			[ ] //delete Webxx.tmp file
			[ ] DeleteFile(sWebFile)
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName1} created ", FAIL, "Verify datafile {sFileName1} created: Datafile {sFileName1} couldn't be created ")
		[ ] 
	[ ] 
[ ] 
[+] //############# Test04- Verify first time download for clean payee in Non C2R mode when payee is already memorized#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4_PayeeMemorizedNonC2RMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the category of the downloaded payee when it is already memorized and category has been changed in non C2R mode
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test4_PayeeMemorizedNonC2RMode()appstate none
	[ ] 
	[+] //variable declaration
		[ ] INTEGER iAddAccount,i=1
		[ ] LIST OF STRING lsAddAccount,lsCategory,lsPayeeDetailRegister
		[ ] sFileName="ACE01"
		[ ] bMatch=FALSE
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sACEData, sAccountDetails)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] 
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] //Set C2R mode ON
			[ ] iFlag=SetC2RMode("OFF")
			[ ] 
			[+] if(iFlag==PASS)
				[ ] ReportStatus("verify C2R mode is not set",PASS,"C2R mode was not set")
				[ ] 
				[ ] //read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
				[ ] //read the first row
				[ ] lsCategory=lsExcelData[1]
				[ ] 
				[ ] iFlag=AddCategory(lsCategory[3],"","",lsCategory[4])
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify category was added",PASS,"category was added successfully")
					[ ] //read the first row
					[ ] lsPayeeDetails=lsExcelData[1]
					[ ] 
					[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[+] if(iSelect==PASS)
						[ ] ReportStatus(" verify account was selected from account bar",PASS,"account was selected from account bar successfully")
						[ ] //add check # tab in register
						[ ] EditTabsInRegister("Add",sTab)
						[ ] //Adding transaction
						[ ] iFlag= AddCheckingTransaction("MDI","Payment",lsPayeeDetails[5],lsAddAccount[4],"",lsPayeeDetails[1],"",lsCategory[4]+":"+lsCategory[3])
						[ ] 
						[+] if(iFlag==PASS)
							[ ] ReportStatus("verify transaction was added ",PASS,"transaction was added sucesfully")
							[ ] 
							[ ] //import web connect file and link it to existing account
							[ ] iSelect=ImportWebConnectFile(sPath+sFileName,"",1)
							[ ] 
							[+] if(iSelect==PASS)
								[ ] ReportStatus(" verify web connect file was imported and linked to existing account",PASS,"web connect file was imported and linked to existing account successfully")
								[ ] //select account from account bar
								[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
								[ ] 
								[ ] 
								[ ] //verify if request is sent through checking if response exists
								[+] if (!SYS_FileExists(sWebFile))
									[ ] ReportStatus("verify request has not been sent",PASS,"request has not been sent")
								[+] else
									[ ] ReportStatus("verify request has not been sent",FAIL,"request has been sent")
								[ ] 
								[ ] //Get Payee details from register
								[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
								[ ] 
								[+] if(ListCount(lsPayeeDetailRegister)>1)
									[+] while(i<3)
										[ ] //verify if  transaction has payee name
										[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[i])
										[ ] 
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
										[+] else
											[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
										[ ] 
										[ ] //verify if  transaction has payee category
										[ ] bMatch=MatchStr("*{lsCategory[4]+":"+lsCategory[3]}*",lsPayeeDetailRegister[i])
										[ ] 
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
										[+] else
											[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
										[ ] i++
								[+] else
									[ ] ReportStatus("verify if payee was registered",FAIL,"payee was not registered")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus(" verify web connect file was imported and linked to existing account",FAIL,"web connect file was not  imported and linked to existing account successfully")
						[+] else
							[ ] ReportStatus("verify transaction was added ",FAIL,"transaction could not be added")
					[+] else
						[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected from account bar")
				[+] else
					[ ] ReportStatus("verify category was added",FAIL,"category was not added successfully")
			[+] else
				[ ] ReportStatus("verify C2R mode is not set",FAIL,"C2R mode was  set")
			[ ] //delete account
			[ ] DeleteAccount(ACCOUNT_BANKING,lsAddAccount[2])
			[ ] //delete category
			[ ] DeleteCategory(lsCategory[3],1)
			[+] if(CategoryList.Exists(5))
				[ ] CategoryList.Close()
			[ ] 
			[ ] //delete payee
			[ ] DeletePayees()
			[ ] //Remove OFX Log file
			[ ] DeleteOFXLogFile(sFileName1)
			[ ] //Delete lbtlog file
			[ ] DeleteFile(sLBTLogFile)
			[ ] //delete Webxx.tmp file
			[ ] DeleteFile(sWebFile)
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName1} created ", FAIL, "Verify datafile {sFileName1} created: Datafile {sFileName1} couldn't be created ")
		[ ] 
	[ ] 
[ ] 
[+] //#############Test05- Verify transaction when payee name and memo values are interchanged  #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test5_NameMemoInterChange()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the ACE response when payee name and memo values are interchanged and sent as request
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test5_NameMemoInterChange()appstate none
	[ ] 
	[+] //variable declaration
		[ ] sFileName="ACE02"
		[ ] sAccount="Checking at Bank of America-All Other S"
		[ ] LIST OF STRING lsPayeeDetailRegister
		[ ] bMatch=FALSE
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Set C2R mode ON
		[ ] iFlag=SetC2RMode("ON")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode set successfully")
			[ ] //import Web Connect File
			[ ] iSelect=ImportWebConnectFile(sPath+sFileName)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify web connect file is imported",PASS,"web connect file was imported successfully")
				[ ] //open register from account bar
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
					[ ] 
					[ ] // Read data from excel sheet for payee details
					[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
					[ ] 
					[ ] //read 2nt row from excel data
					[ ] lsPayeeDetails=lsExcelData[2]
					[ ] 
					[ ] 
					[ ] //accept transactions via C2R
					[ ] iSelect=C2RTransactionOperations(lsPayeeDetails[1],sRight_Click,sAccept)
					[ ] 
					[+] if(iSelect==PASS)
						[ ] ReportStatus("verify transaction was accepted",PASS,"transaction was accepted successfully")
						[ ] //verifying request sent by checking existence of response file
						[+] if (SYS_FileExists(sWebFile))
							[ ] ReportStatus("verify request has been sent",PASS,"request has been sent")
						[+] else
							[ ] ReportStatus("verify request has been sent",FAIL,"request has not been sent")
						[ ] 
						[ ] 
						[ ] //Get Payee details from register
						[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
						[+] if(ListCount(lsPayeeDetailRegister)>0)
							[ ] 
							[ ] //verify if  transaction has payee name
							[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
							[+] else
								[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
							[ ] 
							[ ] //verify if  transaction has payee category
							[ ] bMatch=MatchStr("*{lsPayeeDetails[2]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
							[+] else
								[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
						[+] else
							[ ] ReportStatus("verify if payee was registered",FAIL,"payee was not registered")
						[ ] 
					[+] else
						[ ] ReportStatus("verify transaction was accepted",FAIL,"transaction was not accepted successfully")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
				[ ] 
				[ ] 
				[ ] //delete payee
				[ ] DeletePayees()
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
				[ ] //Remove OFX Log file
				[ ] DeleteOFXLogFile(sFileName1)
				[ ] //Delete lbtlog file
				[ ] DeleteFile(sLBTLogFile)
				[ ] //delete Webxx.tmp file
				[ ] DeleteFile(sWebFile)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("verify web connect file is imported",FAIL,"web connect file could not be imported")
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was not set")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] //############# Test11- Verify importing two web connect files with  Automatically Memorizing new payees option set in C2R Mode#################################################
[+] //############# Test06- Verify Second time download using Web Connect file for the same Payee name and amount as in first download in C2R mode#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_SecondTimeDownloadC2RMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Second time download using Web Connext File for the same Payee name and amoint as in first download in C2R mode and Automatically Memorizing new payees option is set
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test6_SecondTimeDownloadC2RMode()appstate none
	[ ] 
	[+] //variable declaration
		[ ] sFileName="ACE01"
		[ ] sAccount="Checking at Bank of America-All Other S"
		[ ] LIST OF STRING lsPayeeDetailRegister
		[ ] bMatch=FALSE
		[ ] INTEGER i
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Set C2R mode ON
		[ ] iFlag=SetC2RMode("ON")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode set successfully")
			[ ] 
			[ ] // Read data from excel sheet for payee details
			[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
			[ ] 
			[ ] //read 1st row from excel data
			[ ] lsPayeeDetails=lsExcelData[1]
			[ ] 
			[ ] 
			[+] for(i=0;i<2;i++)
				[ ] 
				[+] if(i==1)
					[ ] sFileName="ACE03"
				[ ] 
				[ ] //import Web Connect File
				[ ] iSelect=ImportWebConnectFile(sPath+sFileName)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify web connect file is imported",PASS,"web connect file was imported successfully")
					[ ] //open register from account bar
					[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
					[+] if(iSelect==PASS)
						[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
						[ ] 
						[ ] //accept transactions via C2R
						[ ] iSelect=C2RTransactionOperations(lsPayeeDetails[1],sRight_Click,sAccept)
						[ ] 
						[+] if(iSelect==PASS)
							[ ] ReportStatus("verify transaction was accepted",PASS,"transaction was accepted successfully")
						[+] else
							[ ] ReportStatus("verify transaction was accepted",FAIL,"transaction was not accepted successfully")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
					[ ] 
					[ ] 
					[+] if(i==1)
						[ ] 
						[ ] //Get Payee details from register
						[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
						[+] if(ListCount(lsPayeeDetailRegister)>0)
							[ ] //verify if  transaction has payee name
							[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
							[+] else
								[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
							[ ] 
							[ ] //verify if  transaction has payee category
							[ ] bMatch=MatchStr("*{lsPayeeDetails[2]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
							[+] else
								[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
						[+] else
							[ ] ReportStatus("verify if payee was registered",FAIL,"payee was not registered")
						[ ] 
						[ ] 
						[ ] //Verify request is sent by checking reponse exists
						[+] if (!SYS_FileExists(sWebFile))
							[ ] ReportStatus("verify request has not been sent",PASS,"request has not been sent")
						[+] else
							[ ] ReportStatus("verify request has not been sent",FAIL,"request has been sent")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] //delete account
					[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
					[ ] //Remove OFX Log file
					[ ] DeleteOFXLogFile(sFileName1)
					[ ] //Delete lbtlog file
					[ ] DeleteFile(sLBTLogFile)
					[ ] //delete Webxx.tmp file
					[ ] DeleteFile(sWebFile)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify web connect file is imported",FAIL,"web connect file could not be imported")
			[ ] 
			[ ] //delete payee
			[ ] DeletePayees()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was not set")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test07- Verify Second time download using Web Connect file for the same Payee name and different amount as in first download in non C2R mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_SecondTimeDownloadC2RMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Second time download using Web Connext File for the same Payee name and amoint as in first download in non C2R mode and Automatically Memorizing new payees option is set
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test7_SecondTimeDownloadNonC2RMode()appstate none
	[ ] 
	[+] //variable declaration
		[ ] sFileName="ACE01"
		[ ] sAccount="Checking at Bank of America-All Other S"
		[ ] LIST OF STRING lsPayeeDetailRegister
		[ ] bMatch=FALSE
		[ ] INTEGER i
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Set C2R mode OFF
		[ ] iFlag=SetC2RMode("OFF")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is unset",PASS,"C2R mode is unset successfully")
			[ ] 
			[ ] // Read data from excel sheet for payee details
			[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
			[ ] 
			[ ] //read 1st row from excel data
			[ ] lsPayeeDetails=lsExcelData[1]
			[ ] 
			[ ] 
			[+] for(i=0;i<2;i++)
				[ ] 
				[+] if(i==1)
					[ ] sFileName="ACE04"
				[ ] 
				[ ] //import Web Connect File
				[ ] iSelect=ImportWebConnectFile(sPath+sFileName)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify web connect file is imported",PASS,"web connect file was imported successfully")
					[ ] //open register from account bar
					[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
					[+] if(iSelect==PASS)
						[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
						[ ] 
					[+] else
						[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
					[ ] 
					[ ] 
					[+] if(i==1)
						[ ] 
						[ ] //Get Payee details from register
						[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
						[+] if(ListCount(lsPayeeDetailRegister)>0)
							[ ] //verify if  transaction has payee name
							[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
							[+] else
								[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
							[ ] 
							[ ] //verify if  transaction has payee category
							[ ] bMatch=MatchStr("*{lsPayeeDetails[2]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
							[+] else
								[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
						[+] else
							[ ] ReportStatus("verify if payee was registered",FAIL,"payee was not registered")
						[ ] 
						[ ] iFlag=SearchPayeeInMemorizedPayee(lsPayeeDetails[1],lsPayeeDetails[5])
						[+] if(iFlag==PASS)
							[ ] ReportStatus("verify Payee amount is updated in Memorized Payee List",PASS,"Payee Amount is updated")
						[+] else
							[ ] ReportStatus("verify Payee amount is updated in Memorized Payee List",FAIL,"Payee Amount is not updated")
						[ ] 
						[ ] 
						[ ] //verify request is not sent by verifying there is no response
						[+] if (!SYS_FileExists(sWebFile))
							[ ] ReportStatus("verify request has not been sent",PASS,"request has not been sent")
						[+] else
							[ ] ReportStatus("verify request has not been sent",FAIL,"request has been sent")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] //delete account
					[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
					[ ] //Remove OFX Log file
					[ ] DeleteOFXLogFile(sFileName1)
					[ ] //Delete lbtlog file
					[ ] DeleteFile(sLBTLogFile)
					[ ] //delete Webxx.tmp file
					[ ] DeleteFile(sWebFile)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify web connect file is imported",FAIL,"web connect file could not be imported")
			[ ] 
			[ ] //delete payee
			[ ] DeletePayees()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify C2R mode is unset",FAIL,"C2R mode was set")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test08-Verify Second time download using Web Connect file for a Unique Payee that was not in first time download in non C2R Mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_UniquePayeeNonC2RMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Second time download using Web Connect file for a Unique Payee that was not in first time download in non C2R Mode
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test8_UniquePayeeNonC2RMode()appstate none
	[ ] 
	[+] //variable declaration
		[ ] sFileName="ACE01"
		[ ] sAccount="Checking at Bank of America-All Other S"
		[ ] LIST OF STRING lsPayeeDetailRegister
		[ ] bMatch=FALSE
		[ ] INTEGER i=0
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Set C2R mode OFF
		[ ] iFlag=SetC2RMode("OFF")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is unset",PASS,"C2R mode is unset successfully")
			[ ] 
			[ ] // Read data from excel sheet for payee details
			[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
			[ ] 
			[ ] 
			[ ] 
			[+] for(i=0;i<2;i++)
				[ ] 
				[ ] 
				[ ] //read 1st row from excel data
				[ ] lsPayeeDetails=lsExcelData[1+i]
				[ ] 
				[ ] 
				[+] if(i==1)
					[ ] sFileName="ACE05"
				[ ] 
				[ ] //import Web Connect File
				[ ] iSelect=ImportWebConnectFile(sPath+sFileName)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify web connect file is imported",PASS,"web connect file was imported successfully")
					[ ] //open register from account bar
					[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
					[+] if(iSelect==PASS)
						[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
						[ ] 
					[+] else
						[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
					[ ] 
					[ ] 
					[+] if(i==1)
						[ ] 
						[ ] //Get Payee details from register
						[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
						[+] if(ListCount(lsPayeeDetailRegister)>0)
							[ ] //verify if  transaction has payee name
							[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
							[+] else
								[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
							[ ] 
							[ ] //verify if  transaction has payee category
							[ ] bMatch=MatchStr("*{lsPayeeDetails[2]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
							[+] else
								[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
						[+] else
							[ ] ReportStatus("verify if payee was registered",FAIL,"payee was not registered")
						[ ] 
						[ ] iFlag=SearchPayeeInMemorizedPayee(lsPayeeDetails[1])
						[+] if(iFlag==PASS)
							[ ] ReportStatus("verify Payee amount is updated in Memorized Payee List",PASS,"Payee Amount is updated")
						[+] else
							[ ] ReportStatus("verify Payee amount is updated in Memorized Payee List",FAIL,"Payee Amount is updated")
						[ ] 
						[ ] //verify request is sent by verifying the response exists
						[+] if (SYS_FileExists(sWebFile))
							[ ] ReportStatus("verify request has been sent",PASS,"request has been sent")
						[+] else
							[ ] ReportStatus("verify request has been sent",FAIL,"request has not been sent")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] //delete account
					[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
					[ ] //Remove OFX Log file
					[ ] DeleteOFXLogFile(sFileName1)
					[ ] //Delete lbtlog file
					[ ] DeleteFile(sLBTLogFile)
					[ ] //delete Webxx.tmp file
					[ ] DeleteFile(sWebFile)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify web connect file is imported",FAIL,"web connect file could not be imported")
			[ ] 
			[ ] //delete payee
			[ ] DeletePayees()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify C2R mode is unset",FAIL,"C2R mode was set")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //#############Test09- Verify Second time download using Web Connect file changing category in C2R mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_ChangeCategoryC2RMode()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Second time download using Web Connect file changing category in C2R mode
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test9_ChangeCategoryC2RMode()appstate none
	[ ] 
	[+] //variable declaration
		[ ] sFileName="ACE01"
		[ ] sAccount="Checking at Bank of America-All Other S"
		[ ] LIST OF STRING lsPayeeDetailRegister
		[ ] bMatch=FALSE
		[ ] INTEGER i
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Set C2R mode OFF
		[ ] iFlag=SetC2RMode("OFF")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is unset",PASS,"C2R mode is unset successfully")
			[ ] 
			[ ] // Read data from excel sheet for payee details
			[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
			[ ] 
			[ ] //read 1st row from excel data
			[ ] lsPayeeDetails=lsExcelData[1]
			[ ] 
			[ ] 
			[+] for(i=0;i<2;i++)
				[ ] 
				[+] if(i==1)
					[ ] sFileName="ACE03"
				[ ] 
				[ ] //import Web Connect File
				[ ] iSelect=ImportWebConnectFile(sPath+sFileName)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify web connect file is imported",PASS,"web connect file was imported successfully")
					[ ] //open register from account bar
					[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
					[+] if(iSelect==PASS)
						[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
					[ ] 
					[+] if(i==0)
						[ ] DeletePayees()
						[ ] //finding the transaction
						[ ] FindTransaction("MDI",lsPayeeDetails[1])
						[ ] 
						[ ] //changing category of the transaction
						[ ] MDIClient.AccountRegister.TxList.Typekeys(Replicate(KEY_TAB,4))
						[ ] 
						[ ] MDIClient.AccountRegister.TxList.Typekeys(lsPayeeDetails[4])
						[ ] MDIClient.AccountRegister.TxList.Typekeys(KEY_ENTER)
						[ ] 
						[ ] //verifying if category has been changed in memorized payee list
						[ ] iFlag=SearchPayeeInMemorizedPayee(lsPayeeDetails[1],lsPayeeDetails[4])
						[+] if(iFlag==PASS)
							[ ] ReportStatus("verify Payee amount is updated in Memorized Payee List",PASS,"Payee Amount is updated")
						[+] else
							[ ] ReportStatus("verify Payee amount is updated in Memorized Payee List",FAIL,"Payee Amount is updated")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[+] if(i==1)
						[ ] 
						[ ] //Get Payee details from register
						[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
						[+] if(ListCount(lsPayeeDetailRegister)>0)
							[ ] //verify if  transaction has payee name
							[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
							[+] else
								[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
							[ ] 
							[ ] //verify if  transaction has payee category
							[ ] bMatch=MatchStr("*{lsPayeeDetails[4]}*",lsPayeeDetailRegister[1])
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
							[+] else
								[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
						[+] else
							[ ] ReportStatus("verify if payee was registered",FAIL,"payee was not registered")
						[ ] 
						[ ] 
						[ ] //verify request is sent by verifying the response exists
						[+] if (!SYS_FileExists(sWebFile))
							[ ] ReportStatus("verify request has not been sent",PASS,"request has not been sent")
						[+] else
							[ ] ReportStatus("verify request has not been sent",FAIL,"request has been sent")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] //delete account
					[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
					[ ] //Remove OFX Log file
					[ ] DeleteOFXLogFile(sFileName1)
					[ ] //Delete lbtlog file
					[ ] DeleteFile(sLBTLogFile)
					[ ] //delete Webxx.tmp file
					[ ] DeleteFile(sWebFile)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify web connect file is imported",FAIL,"web connect file could not be imported")
			[ ] 
			[ ] //delete payee
			[ ] DeletePayees()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify C2R mode is unset",FAIL,"C2R mode was set")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test16- Verify that single ACE request is made for all the unique Payee names obtained in C2R Mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_SingleRequestMultiplePayees()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that single ACE request is made for all the unique Payee names obtained in C2R Mode
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test10_SingleRequestMultiplePayees()appstate none
	[ ] 
	[+] //variable declarations
		[ ] sFileName="ACE06"
		[ ] STRING sWebFile1=LOCAL_LOG+"\WEB1.tmp"
		[ ] INTEGER i
		[ ] sAccount="Checking at Bank of America-All Other S"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Set C2R mode ON
		[ ] iFlag=SetC2RMode("ON")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode is set successfully")
			[ ] 
			[ ] //import Web Connect File
			[ ] iSelect=ImportWebConnectFile(sPath+sFileName)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify web connect file is imported",PASS,"web connect file was imported successfully")
				[ ] //open register from account bar
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
					[ ] 
					[ ] // Read data from excel sheet for payee details
					[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
					[ ] 
					[ ] lsPayeeDetails=lsExcelData[1]
					[ ] 
					[ ] //accept transactions via C2R
					[ ] C2RTransactionOperations(lsPayeeDetails[1],sRight_Click,"Accept All")
					[ ] 
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
				[ ] 
				[ ] 
				[ ] //verify request is sent by verifying the response exists
				[+] if (SYS_FileExists(sWebFile))
					[ ] ReportStatus("verify request has been sent",PASS,"request has been sent")
				[+] else
					[ ] ReportStatus("verify request has been sent",FAIL,"request has not been sent")
				[ ] 
				[ ] //verify only 1 response is received
				[+] if(!SYS_FileExists(sWebFile1))
					[ ] ReportStatus("verify 2nd request has not been sent",PASS,"2nd request has not been sent")
				[+] else
					[ ] ReportStatus("verify 2nd request has not been sent",FAIL,"2nd request has been sent")
				[ ] 
				[ ] 
				[ ] //delete payee
				[ ] DeletePayees()
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
				[ ] //Remove OFX Log file
				[ ] DeleteOFXLogFile(sFileName1)
				[ ] //Delete lbtlog file
				[ ] DeleteFile(sLBTLogFile)
				[ ] //delete Webxx.tmp file
				[ ] DeleteFile(sWebFile)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("verify web connect file is imported",FAIL,"web connect file could not be imported")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was unset")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[ ] //#############Test18- Verify that single ACE request is made for all the unique Payee names obtained in C2R Mode#################################################
[+] //############# Test13- Verify downloading transactions with Preferences option: Automatically Memorizing new payees in C2R Mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_AutomaticMemorizePayees()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify downloading transactions with Preferences option: Automatically Memorizing new payees in C2R Mode and check if a single ACE request is amde for all unique Payees for a Direct Connect
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test11_AutomaticMemorizePayees()appstate none
	[ ] 
	[+] //variable declarations
		[ ] 
		[ ] STRING sWebFile1=LOCAL_LOG+"\WEB1.tmp"
		[ ] INTEGER i
		[ ] sAccount="Test1 XX3456"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Set C2R mode ON
		[ ] iFlag=SetC2RMode("ON")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode is set successfully")
			[ ] 
			[ ] //add direct account
			[ ] iSelect=AddCCMintBankAccount("pp123","pp123")
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify direct connect account was created",PASS,"direct connect was created successfully")
				[ ] //open register from account bar
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] 
					[ ] sPayeeDetail=GetField(QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle), "@", 4)
					[ ] C2RTransactionOperations(sPayeeDetail,sRight_Click,sAccept)
					[ ] 
					[ ] sPayeeDetail=GetField(QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"2"), "@", 4)
					[ ] C2RTransactionOperations(sPayeeDetail,sRight_Click,sAccept)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
				[ ] 
				[ ] //navigate to memorized payee list
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_T)
				[ ] 
				[+] if(MemorizedPayeeList.Exists(5))
					[ ] ReportStatus("verify memorized payee list was opened",PASS,"memorized payee list was opened")
					[+] if(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()>0)
						[ ] 
						[ ] ReportStatus("verify payees are memorized when new DC account is added ",PASS,"payees are memorized successfully")
					[+] else
						[ ] ReportStatus("verify payees are memorized when new DC account is added",FAIL,"payees are not memorized")
				[+] else
					[ ] ReportStatus("verify memorized payee list was opened",FAIL,"memorized payee list was not opened")
					[ ] 
				[ ] 
				[ ] // iFlag=SearchPayeeInMemorizedPayee(lsPayeeDetails[1],NULL,lsPayeeDetails[2])
				[+] // if(iFlag==PASS)
					[ ] // ReportStatus("verify payee was memorized with category",PASS,"payee was memorized with category")
				[+] // else
					[ ] // ReportStatus("verify payee was memorized with category",FAIL,"payee was not memorized with categoy")
				[ ] 
				[ ] //verify request is sent by verifying the response exists
				[+] if (SYS_FileExists(sWebFile))
					[ ] ReportStatus("verify request has been sent",PASS,"request has been sent")
				[+] else
					[ ] ReportStatus("verify request has been sent",FAIL,"request has not been sent")
				[ ] 
				[ ] //verify only 1 response is received
				[+] if(!SYS_FileExists(sWebFile1))
					[ ] ReportStatus("verify 2nd request has not been sent",PASS,"2nd request has not been sent")
				[+] else
					[ ] ReportStatus("verify 2nd request has not been sent",FAIL,"2nd request has been sent")
				[ ] 
				[ ] 
				[ ] //delete payee
				[ ] DeletePayees()
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
				[ ] //Remove OFX Log file
				[ ] DeleteOFXLogFile(sFileName1)
				[ ] //Delete lbtlog file
				[ ] DeleteFile(sLBTLogFile)
				[ ] //delete Webxx.tmp file
				[ ] DeleteFile(sWebFile)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("verify direct connect account was created",FAIL,"direct connect was not created")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was unset")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //#############Test12- Verify downloading transactions without Preferences option: Automatically Memorizing new payees in C2R Mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_DoNotMemorizePayees()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify downloading transactions without Preferences option: Automatically Memorizing new payees in C2R Mode for direct connect
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test12_DoNotMemorizePayees()appstate none
	[ ] 
	[+] //variable declarations
		[ ] STRING sWebFile1=LOCAL_LOG+"\WEB1.tmp"
		[ ] INTEGER i
		[ ] sAccount="Test1 XX3456"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //uncheck automatically memorize new payees
		[ ] SelectPreferenceType("Data entry and QuickFill")
		[ ] Preferences.SetActive()
		[ ] Preferences.AutomaticallyMemorizeNewPay.Uncheck()
		[ ] Preferences.OK.Click()
		[ ] //Set C2R mode ON
		[ ] iFlag=SetC2RMode("ON")
		[ ] 
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode is set successfully")
			[ ] 
			[ ] //add direct account
			[ ] iSelect=AddCCMintBankAccount("pp123","pp123")
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify direct connect account was created",PASS,"direct connect account was created successfully")
				[ ] //open register from account bar
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] sHandle = Str(MDIClient.AccountRegister.QWSnapHolder1.StaticText1.DownloadedTransactions.ListBox.GetHandle())
					[ ] sPayeeDetail=GetField(QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle), "@", 4)
					[ ] C2RTransactionOperations(sPayeeDetail,sRight_Click,sAccept)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_T)
				[+] if(MemorizedPayeeList.Exists(5))
					[ ] ReportStatus("verify memorized payee list was opened",PASS,"memorized payee list was opened")
					[+] if(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount()==0)
						[ ] 
						[ ] ReportStatus("verify payees are not memorized when new DC account is added ",PASS,"payees are not memorized ")
					[+] else
						[ ] ReportStatus("verify payees are not memorized when new DC account is added",FAIL,"payees are memorized")
				[+] else
					[ ] ReportStatus("verify memorized payee list was opened",FAIL,"memorized payee list was not opened")
					[ ] 
				[ ] 
				[ ] //verify request is sent by verifying the response exists
				[+] if (SYS_FileExists(sWebFile))
					[ ] ReportStatus("verify request has been sent",PASS,"request has been sent")
				[+] else
					[ ] ReportStatus("verify request has been sent",FAIL,"request has not been sent")
				[ ] 
				[ ] 
				[ ] //delete payee
				[ ] DeletePayees()
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
				[ ] //Remove OFX Log file
				[ ] DeleteOFXLogFile(sFileName1)
				[ ] //Delete lbtlog file
				[ ] DeleteFile(sLBTLogFile)
				[ ] //delete Webxx.tmp file
				[ ] DeleteFile(sWebFile)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("verify direct connect account is created",FAIL,"directconnect account could not be created")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was unset")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //check automatically memorized new payees 
		[ ] sleep(3)
		[ ] SelectPreferenceType("Data entry and QuickFill")
		[ ] Preferences.SetActive()
		[ ] Preferences.AutomaticallyMemorizeNewPay.Check()
		[ ] Preferences.AutomaticallyIncludeOnCalen.Check()
		[ ] Preferences.OK.Click()
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
[ ] 
[+] //############# Test27- Verify that Quicken leaves category field blank (or uncategorized) when both ACE and Quicken AutoCat Logic finds no category for the payee name in C2R Mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_NoCategoryLogic()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Quicken leaves category field blank (or uncategorized) when both ACE and Quicken AutoCat Logic finds no category for the payee name in C2R Mode
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test13_NoCategoryLogic()appstate none
	[ ] 
	[+] //variable declarations
		[ ] sFileName="Ace07"
		[ ] INTEGER i,iFind
		[ ] sAccount="Checking at Bank of America-All Other S"
		[ ] bMatch=FALSE
		[ ] STRING sCategory,sName,sLine
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Set C2R mode ON
		[ ] iFlag=SetC2RMode("ON")
		[ ] 
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode is set successfully")
			[ ] 
			[ ] 
			[ ] //import Web Connect File
			[ ] iSelect=ImportWebConnectFile(sPath+sFileName)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify web connect file is imported",PASS,"web connect file was imported successfully")
				[ ] //open register from account bar
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
					[ ] 
					[ ] // Read data from excel sheet for payee details
					[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
					[ ] 
					[ ] //read 3rd row from excel data
					[ ] lsPayeeDetails=lsExcelData[3]
					[ ] 
					[ ] //accept transactions via C2R
					[ ] C2RTransactionOperations(lsPayeeDetails[1],sRight_Click,sAccept)
					[ ] 
					[ ] //finding the transaction
					[ ] iFind=FindTransaction("MDI",lsPayeeDetails[1])
					[+] if(iFind==PASS)
						[ ] //memorize the payee
						[ ] QuickenWindow.Typekeys(KEY_CTRL_M)
						[ ] Quicken2012.OK.Click()
						[ ] //open memorized payee list
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_T)
						[ ] 
						[+] if(MemorizedPayeeList.Exists(5))
							[ ] 
							[ ] //select the payee
							[ ] MemorizedPayeeList.MemorizedPayeeList.ListBox.Select(1)
							[ ] 
							[ ] //click on edit button
							[ ] MemorizedPayeeList.TextClick("Edit")
							[ ] //verify edit window exists
							[+] if(CreateMemorizedPayee.Exists(5))
								[ ] //get name of the payee
								[ ] sName=CreateMemorizedPayee.CreateMemorizedPayeeTextField.GetText()
								[ ] //verify if the name is not changed
								[+] if(sName==lsPayeeDetails[1])
									[ ] ReportStatus("verify payee name is not changed",PASS,"name is not changed")
								[+] else
									[ ] ReportStatus("verify payee name is not changed",FAIL,"name is changed")
								[ ] 
								[ ] //get category of the payee
								[ ] sCategory=CreateMemorizedPayee.CategoryTextField.GetText()
								[ ] //verify if the category is null
								[+] if(sCategory=="")
									[ ] ReportStatus("verify payee is not categorized",PASS,"category field was null")
								[+] else
									[ ] ReportStatus("verify payee is not categorized",FAIL,"category field was not null")
								[ ] //close edit window
								[ ] CreateMemorizedPayee.CancelButton.Click()
							[ ] //close memorized payee
							[ ] MemorizedPayeeList.Done.Click()
							[ ] 
							[ ] QuickenWindow.SetActive()
						[ ] 
					[ ] 
					[ ] // Read data from excel sheet for response
					[ ] lsExcelData=ReadExcelTable(sACEData, sRequestResponseWorksheet)
					[ ] // Fetch ith row from the given sheet
					[ ] lsResponseRequestDetails=lsExcelData[1]
					[ ] 
					[ ] //open response file
					[ ] hFile = FileOpen (sWebFile, FM_READ)
					[ ] //reading and verifyin response
					[+] while (FileReadLine (hFile, sLine)) 
						[ ] 
						[ ] bMatch=MatchStr("*{lsResponseRequestDetails[3]}*",sLine)
						[ ] // verify response
						[+] if(bMatch==TRUE)
							[ ] break
						[ ] 
					[ ] 
					[ ] // verify response
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify response ",PASS,"correct response received")
					[+] else
						[ ] ReportStatus("verify response",FAIL,"incorrect response received")
					[ ] 
					[ ] //close response file
					[ ] FileClose (hFile)  
					[ ] 
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
				[ ] 
				[ ] //delete payee
				[ ] DeletePayees()
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
				[ ] //Remove OFX Log file
				[ ] DeleteOFXLogFile(sFileName1)
				[ ] //Delete lbtlog file
				[ ] DeleteFile(sLBTLogFile)
				[ ] //delete Webxx.tmp file
				[ ] DeleteFile(sWebFile)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("verify web connect file is imported",FAIL,"web connect file could not be imported")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was unset")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
[ ] 
[+] //#############Test30-Verify First time download while setting an online account - Direct Connect in C2R Mode #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_FirstDownloadDirectConnectC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify First time download while setting an online account - Direct Connect. (C2R Mode)
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test14_FirstDownloadDirectConnectC2R()appstate none
	[+] //variable declaration
		[ ] sFileName="ACE01"
		[ ] sAccount="Test1 XX3456"
		[ ] STRING sLine
		[ ] LIST OF STRING lsPayeeDetailRegister
		[ ] INTEGER i=1,iRequestLines
		[ ] bMatch=FALSE
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Set C2R mode ON
		[ ] iFlag=SetC2RMode("ON")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode set successfully")
			[ ] //add direct account
			[ ] iSelect=AddCCMintBankAccount("pp123","pp123")
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify direct connect account is created",PASS,"direct connect account was created successfully")
				[ ] //open register from account bar
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
					[ ] 
					[ ] // Read data from excel sheet for payee details
					[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
					[ ] 
					[ ] lsPayeeDetails=lsExcelData[4]
					[ ] 
					[ ] 
					[ ] //Get Payee details from register
					[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
					[ ] 
					[ ] //Get Payee details from register
					[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
					[ ] 
					[ ] //verify if  transaction has payee name
					[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[1])
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
					[+] else
						[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
					[ ] 
					[ ] //verify if  transaction has payee category
					[ ] bMatch=MatchStr("*{lsPayeeDetails[2]}*",lsPayeeDetailRegister[1])
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
					[+] else
						[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
					[ ] 
					[ ] // verify payee is memorized
					[ ] iFlag=SearchPayeeInMemorizedPayee(lsPayeeDetails[1])
					[ ] 
					[+] if(iFlag==PASS)
						[ ] ReportStatus("verify payee is present in memorized payee list",PASS,"payee is memorized")
					[+] else
						[ ] ReportStatus("verify payee is present in memorized payee list",FAIL,"payee is not memorized")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
				[ ] 
				[ ] //verify request is sent by verifying the response exists
				[+] if (SYS_FileExists(sWebFile))
					[ ] ReportStatus("verify request has been sent",PASS,"request has been sent")
				[+] else
					[ ] ReportStatus("verify request has been sent",FAIL,"request has not been sent")
				[ ] 
				[ ] 
				[ ] //delete payee
				[ ] DeletePayees()
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
				[ ] //Remove OFX Log file
				[ ] DeleteOFXLogFile(sFileName1)
				[ ] //Delete lbtlog file
				[ ] DeleteFile(sLBTLogFile)
				[ ] //delete Webxx.tmp file
				[ ] DeleteFile(sWebFile)
			[+] else
				[ ] ReportStatus("verify direct connect account is created",FAIL,"direct connect account could not be created")
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was not set")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
[ ] 
[+] //############# Test33-Verify First time download while setting an online account - Direct Connect in Non C2R Mode#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_FirstDownloadDirectConnectNonC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify  First time download while setting an online account - Direct Connect. (No C2R Mode)
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test15_FirstDownloadDirectConnectNonC2R()appstate none
	[ ] 
	[ ] 
	[+] //variable declaration
		[ ] sFileName="ACE01"
		[ ] sAccount="Test1 XX3456"
		[ ] STRING sLine
		[ ] LIST OF STRING lsPayeeDetailRegister
		[ ] INTEGER i=1,iRequestLines
		[ ] bMatch=FALSE
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Set C2R mode OFF
		[ ] iFlag=SetC2RMode("OFF")
		[ ] 
		[+] if(iFlag==PASS)
			[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode set successfully")
			[ ] //add direct account
			[ ] iSelect=AddCCMintBankAccount("pp123","pp123")
			[+] if(iSelect==PASS)
				[ ] ReportStatus("verify direct connect account is created",PASS,"direct connect account was created successfully")
				[ ] //open register from account bar
				[ ] iSelect=SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("verify account was selected from account bar",PASS,"register was opened from account bar")
					[ ] 
					[ ] // Read data from excel sheet for payee details
					[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
					[ ] 
					[ ] lsPayeeDetails=lsExcelData[4]
					[ ] 
					[ ] 
					[ ] //Get Payee details from register
					[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
					[ ] 
					[ ] //verify if  transaction has payee name
					[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[1])
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
					[+] else
						[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
					[ ] 
					[ ] //verify if  transaction has payee category
					[ ] bMatch=MatchStr("*{lsPayeeDetails[2]}*",lsPayeeDetailRegister[1])
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
					[+] else
						[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
					[ ] 
					[ ] // verify payee is memorized
					[ ] iFlag=SearchPayeeInMemorizedPayee(lsPayeeDetails[1])
					[ ] 
					[+] if(iFlag==PASS)
						[ ] ReportStatus("verify payee is present in memorized payee list",PASS,"payee is memorized")
					[+] else
						[ ] ReportStatus("verify payee is present in memorized payee list",FAIL,"payee is not memorized")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("verify account was selected from account bar",FAIL,"register could not be opened from account bar")
				[ ] 
				[ ] 
				[ ] //verify request is sent by verifying the response exists
				[+] if (SYS_FileExists(sWebFile))
					[ ] ReportStatus("verify request has been sent",PASS,"request has been sent")
				[+] else
					[ ] ReportStatus("verify request has been sent",FAIL,"request has not been sent")
				[ ] 
				[ ] 
				[ ] //delete payee
				[ ] DeletePayees()
				[ ] //delete account
				[ ] DeleteAccount(ACCOUNT_BANKING,sAccount)
				[ ] //Remove OFX Log file
				[ ] DeleteOFXLogFile(sFileName1)
				[ ] //Delete lbtlog file
				[ ] DeleteFile(sLBTLogFile)
				[ ] //delete Webxx.tmp file
				[ ] DeleteFile(sWebFile)
			[+] else
				[ ] ReportStatus("verify direct connect account is created",FAIL,"direct connect account could not be created")
		[+] else
			[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was not set")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test31-Verify First time download while setting an online account - Direct Connect in C2R Mode when Payee is already memorized #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_DirectConnectMemorizedPayeeC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify First time download while setting an online account - Direct Connect in C2R Mode when Payee is already memorized
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test16_DirectConnectMemorizedPayeeC2R()appstate none
	[ ] 
	[+] //variable declaration
		[ ] INTEGER iAddAccount,i=1
		[ ] LIST OF STRING lsAddAccount,lsCategory,lsPayeeDetailRegister
		[ ] sFileName="ACE01"
		[ ] bMatch=FALSE
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sACEData, sAccountDetails)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] 
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] //Set C2R mode ON
			[ ] iFlag=SetC2RMode("ON")
			[ ] 
			[+] if(iFlag==PASS)
				[ ] ReportStatus("verify C2R mode is set",PASS,"C2R mode was set")
				[ ] 
				[ ] //read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
				[ ] //read the 4th row
				[ ] lsCategory=lsExcelData[4]
				[ ] 
				[ ] iFlag=AddCategory(lsCategory[3],"","",lsCategory[4])
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify category was added",PASS,"category was added successfully")
					[ ] //read the 4th row
					[ ] lsPayeeDetails=lsExcelData[4]
					[ ] 
					[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[+] if(iSelect==PASS)
						[ ] ReportStatus(" verify account was selected from account bar",PASS,"account was selected from account bar succesfully")
						[ ] //add check # tab in register
						[ ] EditTabsInRegister("Add",sTab)
						[ ] //Adding transaction
						[ ] iFlag= AddCheckingTransaction("MDI","Payment",lsPayeeDetails[5],lsAddAccount[4],"",lsPayeeDetails[1],"",lsCategory[4]+":"+lsCategory[3])
						[ ] 
						[+] if(iFlag==PASS)
							[ ] ReportStatus("verify transaction was added ",PASS,"transaction was added sucesfully")
							[ ] 
							[ ] //down direct account and link it to existing account
							[ ] iSelect=AddCCMintBankAccount("pp123","pp123",NULL,NULL,1)
							[ ] 
							[+] if(iSelect==PASS)
								[ ] ReportStatus("  verify dirrect account was added and linked",PASS,"direct account was not account and linked to existing account successfully")
								[ ] //select account from account bar
								[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
								[ ] 
								[ ] //accept transactions via C2R
								[ ] iSelect=C2RTransactionOperations(lsPayeeDetails[1],sRight_Click,sAccept)
								[ ] 
								[+] if(iSelect==PASS)
									[ ] ReportStatus("verify transaction was accepted",PASS,"transaction was accepted successfully")
									[ ] 
									[ ] 
									[ ] //verify if request is sent through checking if response exists
									[+] if (!SYS_FileExists(sWebFile))
										[ ] ReportStatus("verify request has not been sent",PASS,"request has not been sent")
									[+] else
										[ ] ReportStatus("verify request has not been sent",FAIL,"request has been sent")
									[ ] 
									[ ] //Get Payee details from register
									[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
									[ ] 
									[+] if(ListCount(lsPayeeDetailRegister)>1)
										[+] while(i<3)
											[ ] 
											[ ] //verify if  transaction has payee name
											[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[i])
											[ ] 
											[+] if(bMatch==TRUE)
												[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
											[+] else
												[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
											[ ] 
											[ ] //verify if  transaction has payee category
											[ ] bMatch=MatchStr("*{lsCategory[4]+":"+lsCategory[3]}*",lsPayeeDetailRegister[i])
											[ ] 
											[+] if(bMatch==TRUE)
												[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
											[+] else
												[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
											[ ] i++
									[+] else
										[ ] ReportStatus("verify if payee was registered",FAIL,"payee was not registered")
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("verify transaction was accepted",FAIL,"transaction was not accepted successfully")
								[ ] 
							[+] else
								[ ] ReportStatus(" verify dirrect account was added and linked",FAIL,"direct account was not account and linked to existing account successfully")
						[+] else
							[ ] ReportStatus("verify transaction was added ",FAIL,"transaction could not be added")
					[+] else
						[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected from account bar")
				[+] else
					[ ] ReportStatus("verify category was added",FAIL,"category was not added successfully")
			[+] else
				[ ] ReportStatus("verify C2R mode is set",FAIL,"C2R mode was not set")
			[ ] 
			[ ] //delete account
			[ ] DeleteAccount(ACCOUNT_BANKING,lsAddAccount[2])
			[ ] sleep(2)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //delete payee
			[ ] DeletePayees()
			[ ] //Remove OFX Log file
			[ ] DeleteOFXLogFile(sFileName1)
			[ ] //Delete lbtlog file
			[ ] DeleteFile(sLBTLogFile)
			[ ] //delete Webxx.tmp file
			[ ] DeleteFile(sWebFile)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //delete category
			[ ] DeleteCategory(lsCategory[3],1)
			[+] if(CategoryList.Exists(5))
				[ ] CategoryList.Close()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName1} created ", FAIL, "Verify datafile {sFileName1} created: Datafile {sFileName1} couldn't be created ")
		[ ] 
	[ ] 
[ ] 
[+] //#############Test34-Verify First time download while setting an online account - Direct Connect in non C2R Mode when Payee is already memorized #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_DirectConnectMemorizedPayeeNonC2R()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify First time download while setting an online account - Direct Connect in non C2R Mode when Payee is already memorized 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             July  13, 2014		
		[ ] //Author                          Shrivardhan 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test17_DirectConnectMemorizedPayeeNonC2R()appstate none
	[ ] 
	[+] //variable declaration
		[ ] INTEGER iAddAccount,i=1
		[ ] LIST OF STRING lsAddAccount,lsCategory,lsPayeeDetailRegister
		[ ] sFileName="ACE01"
		[ ] bMatch=FALSE
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sACEData, sAccountDetails)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] 
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] //Set C2R mode OFF
			[ ] iFlag=SetC2RMode("OFF")
			[ ] 
			[+] if(iFlag==PASS)
				[ ] ReportStatus("verify C2R mode is not set",PASS,"C2R mode was not set")
				[ ] 
				[ ] //read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sACEData, sPayeeDetailWorsheet)
				[ ] //read the 4th row
				[ ] lsCategory=lsExcelData[4]
				[ ] 
				[ ] iFlag=AddCategory(lsCategory[3],"","",lsCategory[4])
				[+] if(iFlag==PASS)
					[ ] ReportStatus("verify category was added",PASS,"category was added successfully")
					[ ] //read the first row
					[ ] lsPayeeDetails=lsExcelData[4]
					[ ] 
					[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[+] if(iSelect==PASS)
						[ ] ReportStatus(" verify account was selected from account bar",PASS,"account was selected from account bar successfully")
						[ ] //add check # tab in register
						[ ] EditTabsInRegister("Add",sTab)
						[ ] //Adding transaction
						[ ] iFlag= AddCheckingTransaction("MDI","Payment",lsPayeeDetails[5],lsAddAccount[4],"",lsPayeeDetails[1],"",lsCategory[4]+":"+lsCategory[3])
						[ ] 
						[+] if(iFlag==PASS)
							[ ] ReportStatus("verify transaction was added ",PASS,"transaction was added sucesfully")
							[ ] 
							[ ] //download direct account and link it to existing account
							[ ] iSelect=AddCCMintBankAccount("pp123","pp123",NULL,NULL,1)
							[ ] 
							[+] if(iSelect==PASS)
								[ ] ReportStatus(" verify direct account was added and linked to existing account",PASS,"direct account was added and linked to existing account successfully")
								[ ] //select account from account bar
								[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
								[ ] 
								[ ] 
								[ ] //verify if request is sent through checking if response exists
								[+] if (!SYS_FileExists(sWebFile))
									[ ] ReportStatus("verify request has not been sent",PASS,"request has not been sent")
								[+] else
									[ ] ReportStatus("verify request has not been sent",FAIL,"request has been sent")
								[ ] 
								[ ] //Get Payee details from register
								[ ] lsPayeeDetailRegister=GetTransactionsInRegister(lsPayeeDetails[1])
								[ ] 
								[+] if(ListCount(lsPayeeDetailRegister)>1)
									[+] while(i<3)
										[ ] //verify if  transaction has payee name
										[ ] bMatch=MatchStr("*{lsPayeeDetails[1]}*",lsPayeeDetailRegister[i])
										[ ] 
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("verify proper payee name exists",PASS,"correct payee name is present")
										[+] else
											[ ] ReportStatus("verify proper payee name exists",FAIL,"correct payee name is not present")
										[ ] 
										[ ] //verify if  transaction has payee category
										[ ] bMatch=MatchStr("*{lsCategory[4]+":"+lsCategory[3]}*",lsPayeeDetailRegister[i])
										[ ] 
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("verify proper category exists",PASS,"correct category is present")
										[+] else
											[ ] ReportStatus("verify proper category exists",FAIL,"correct category is not present")
										[ ] i++
								[+] else
									[ ] ReportStatus("verify if payee was registered",FAIL,"payee was not registered")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus(" verify direct account was added and linked to existing account",FAIL,"direct account was added and linked to existing account successfully")
						[+] else
							[ ] ReportStatus("verify transaction was added ",FAIL,"transaction could not be added")
					[+] else
						[ ] ReportStatus("verify account was selected from account bar",FAIL,"account could not be selected from account bar")
				[+] else
					[ ] ReportStatus("verify category was added",FAIL,"category was not added successfully")
			[+] else
				[ ] ReportStatus("verify C2R mode is not set",FAIL,"C2R mode was  set")
			[ ] //delete account
			[ ] DeleteAccount(ACCOUNT_BANKING,lsAddAccount[2])
			[ ] //delete category
			[ ] DeleteCategory(lsCategory[3],1)
			[+] if(CategoryList.Exists(5))
				[ ] CategoryList.Close()
			[ ] 
			[ ] //delete payee
			[ ] DeletePayees()
			[ ] //Remove OFX Log file
			[ ] DeleteOFXLogFile(sFileName1)
			[ ] //Delete lbtlog file
			[ ] DeleteFile(sLBTLogFile)
			[ ] //delete Webxx.tmp file
			[ ] DeleteFile(sWebFile)
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName1} created ", FAIL, "Verify datafile {sFileName1} created: Datafile {sFileName1} couldn't be created ")
		[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 