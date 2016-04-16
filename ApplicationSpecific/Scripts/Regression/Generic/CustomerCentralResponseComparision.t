[+] // FILE NAME:	<CustomerCentralResponseComparision.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script will add Online account and save OFX log parse the lag and compare with expected log
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Puja Verma
	[ ] //
	[ ] // Developed on: 		11/5/2015
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 May 11, 2012	Puja Verma  Created
	[ ] // *********************************************************
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: SavelogFile()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will save OFX log file
	[ ] //
	[ ] // PARAMETERS:		
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS			 if all the file save  successfully
	[ ] //									FAIL  			 if any error occurs
	[ ] //
	[ ] // REVISION HISTORY:May 9, 2012  Puja Verma  Created
[ ] // ==========================================================
[+] SavelogFile(STRING sFileName)
		[ ] STRING sWindowTitleName="//MainWin[@caption='Quicken 2013 *']"
		[ ] //AUT_DATAFILE_PATH
	[+] if(FileExists("{AUT_DATAFILE_PATH}\{sFileName}"))
		[ ] print("{AUT_DATAFILE_PATH}\{sFileName}")
		[ ] DeleteFile("{AUT_DATAFILE_PATH}\{sFileName}")
		[ ] 
	[+] if(QuickenMainWindow.Exists(9))
		[ ] QuickenMainWindow.SetActive()
	[+] if(AccountAdded.Exists(3))
		[ ] AccountAdded.Close()
	[ ] 
	[ ] QuickenMainWindow.Help.LogFiles.Pick ()
	[ ] sleep(6)
	[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Log Files']").Find("//BrowserWindow").Find("//A[@textContents='OFX Log']").Select()
	[ ] // ViewOFXLog.FileType.Select ("Current Log ")
	[ ]  //ViewOFXLog.SetActive ()
	[ ] sleep(2)
	[ ] SysSaveAs.Click (1, 16, 17)
	[ ] // SaveAs.SetActive ()
	[ ] ViewOFXLog.FileDlg("Save As").ComboBox("File name:|^File name:|#1|$1148|@(318,310)").SetText(sFileName)
	[ ] // SaveAs.Save.Click ()
	[ ] ViewOFXLog.FileDlg("Save As").PushButton("Save|^File name:|#1|$1|@(511,310)").Click()
	[ ] ViewOFXLog.SetActive ()
	[ ] ViewOFXLog.Close.Click (1, 21, 7)
	[ ] MessageBox.Close()
	[-] ReportStatus("OFX log saved successfully ",PASS,"OFX log saved successfully")
		[ ] 
[ ] // ==========================================================
[+] // FUNCTION: TwoFileComparision()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will  compare two OFX log file
	[ ] //
	[ ] // PARAMETERS:		
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS			 if all the file compare  successfully
	[ ] //									FAIL  			 if any error occurs
	[ ] //
	[ ] // REVISION HISTORY:May 9, 2012  Puja Verma  Created
[ ] // ==========================================================
[+] // TwoFileComparision(STRING sTabName)
	[ ] // STRING sExcelName="CCScripting"
	[ ] // LIST OF ANYTYPE  lsExcelData
	[ ] // STRING sTabName1="ComparisionList"
	[ ] // INTEGER i
	[ ] // STRING sExpectedFile=AUT_DATAFILE_PATH+"\"+sTabName
	[ ] // //print(sExpectedFile)
	[ ] // STRING sActualFile =ROOT_PATH+"\"+sTabName
	[ ] // //print(sActualFile)
	[ ] // lsExcelData=ReadExcelTable(sExcelName, sTabName1)
	[ ] // // Fetch data  from the given sheet
	[-] // for(i=1;i<=ListCount(lsExcelData);i++)
		[ ] // lsData=lsExcelData[i]
		[ ] // //print(lsData)
		[ ] // //print(sExpectedFile +"\"+lsData[1]+".txt")
		[ ] // //print(sActualFile+"\"+lsData[1]+".txt")
		[ ] // SYS_VerifyText(sExpectedFile +"\"+lsData[1]+".txt",sActualFile+"\"+lsData[1]+".txt")
		[ ] // ReportStatus("Comparision of text ",PASS,"Actual and Expected of {lsData[1]} files both the  text are exactly same")
[-] TwoFileComparision(STRING sTabName)
	[ ] STRING sExcelName="CCScripting"
	[ ] LIST OF ANYTYPE  lsExcelData
	[ ] //STRING sTabName1="ComparisionList"
	[ ] INTEGER i
	[ ] STRING sExpectedFile=AUT_DATAFILE_PATH+"\"+sTabName
	[ ] //print(sExpectedFile)
	[ ] STRING sActualFile =ROOT_PATH+"\"+sTabName
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sExcelName, sTabName)
	[ ] // Fetch data  from the given sheet
	[-] for(i=1;i<=ListCount(lsExcelData);i++)
		[ ] lsData=lsExcelData[i]
		[ ] //print(lsData)
		[ ] //print(sExpectedFile +"\"+lsData[1]+".txt")
		[ ] //print(sActualFile+"\"+lsData[1]+".txt")
		[ ] Boolean b=CompareFiles(sExpectedFile +"\"+lsData[1]+".txt",sActualFile+"\"+lsData[1]+".txt")
		[-] if(b==TRUE)
			[ ] ReportStatus("Comparision of text ",PASS,"Actual and Expected of {lsData[1]} files both the  text are exactly same.")
		[-] else
			[ ] ReportStatus("Comparision of text ",FAIL,"Actual and Expected of {lsData[1]} files both the  text are not  exactly same.")
		[ ] 
		[ ] 
[ ] 
[+] // //############# Add online account and save OFX log #############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test01_AddAccountOnlineResponseComparision()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will add Wells Fargo Bank account. .
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while adding account 							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  April 13 , 2012		Puja Verma created	
	[ ] // //*********************************************************
[-] testcase Test01_AddAccountOnlineResponseComparision() appstate none
	[-] //VARIABLE
		[ ] STRING sOnlineFile="CustomerCentral"
		[ ] INTEGER iCreateDataFile
		[ ] STRING sLogName="ADDAcctOFXlog.txt"
		[ ] STRING sTabNameForRequest="CCAddAccountRequest"
		[ ] STRING sTabNameForResponse="CCAddAccountResponse"
		[ ] 
		[ ] // STRING sUserName="d_knievel19"
		[ ] // STRING sPassword="Quicken90"
		[ ] STRING CClogDat="CustomerCentralOFXLOG.DAT"
		[ ] STRING sBankName="Chase"
		[ ] 
		[ ] 
		[ ] STRING sUserName="QTester1"
		[ ] STRING sPassword="Helpme29"
		[ ] //Credentials for Chase Direct Connect account
		[ ] // User Name : intuitquicken2
		[ ] // Password: Hockey11
		[ ] 
	[ ] 
	[+] if (QuickenMainWindow.Exists() == TRUE)
		[ ] QuickenMainWindow.Exit()
		[ ] 
	[ ] //Deleting existing File
	[+] if(FileExists(AUT_DATAFILE_PATH + "\" +sOnlineFile+".QDF"))
		[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +sOnlineFile+".QDF")
	[ ] //Deleteing OFXLOG DAT file
	[+] if(FileExists(AUT_DATAFILE_PATH + "\" +CClogDat))
		[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +CClogDat)
	[ ] //Deleting OFX log file if exists
	[+] if(FileExists(AUT_DATAFILE_PATH + "\" +sLogName))
		[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +sLogName)
	[ ] //Launching Quicken
	[+] if (!QuickenMainWindow.Exists ())
		[ ] QuickenMainWindow.Start ("{QUICKEN_ROOT}" + "\qw.exe")
		[ ] 
	[ ] 
	[ ] // Create a new data file for Online account
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] iCreateDataFile = DataFileCreate(sOnlineFile)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sOnlineFile} is created")
		[ ] QuickenMainWindow.SetActive ()
		[ ] QuickenMainWindow.Maximize()
		[ ] ExpandAccountBar()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click ()
		[ ] AddAccount.VerifyEnabled(TRUE, 150)		// Verify window is enable as connection is established
		[ ] AddAccount.SetActive ()
		[ ] AddAccount.Checking.Click()//Spending.Select("Checking")
		[ ] AddAnyAccount.VerifyEnabled(TRUE, 500)
		[ ] AddAnyAccount.SetActive()
		[ ] AddAnyAccount.BankName.SetText(sBankName)
		[ ] AddAnyAccount.Next.Click()
		[ ] sleep(3)
		[ ] //AddCheckingAccount.Next.Click(1,5,5)
		[ ] //AddAnyAccount.SetActive()
		[ ] AddAnyAccount.TextField("MFCU Member Number|$1231").SetText(sUserName)
		[ ] AddAnyAccount.TextField("MFCU Password|$1233").SetText(sPassword)			// Any random passord is OK
		[ ] AddAnyAccount.Next.Click()
		[ ] sleep(100)
		[ ] AddAnyAccount.SetActive()
		[ ] AddAnyAccount.Next.Click()
		[ ] sleep(40)
		[ ] if(AddAccount.Exists(6))
		[ ] AccountAdded.Finish.Click(1,5,5)
		[ ] sleep(2)
		[+] if(AddAccount.Exists(3))
			[ ] AddAccount.Close()
		[ ] //Calling function which save OFX log
		[ ] SavelogFile(sLogName)
		[ ] //Calling Function which parsing OFX log of Request
		[ ] OFXLogParsingFunctionForRequest(sLogName,sTabNameForRequest)
		[ ] 
		[ ] //Calling Function which parsing OFX log of Response
		[ ] OFXLogParsingFunctionForResponse(sLogName,sTabNameForResponse)
		[ ] 
		[ ] // //Calling funtion which compariing OFX log
		[ ] // TwoFileComparision(sTabNameForRequest)
		[ ] // 
		[ ] // // //Calling funtion which compariing OFX log
		[ ] // TwoFileComparision(sTabNameForResponse)
		[ ] 
[ ] 
[+] // //############# Perform OSU online account and save OFX log ######################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test02_OSUOnlineResponseComparision()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will perform OSU Wells Fargo Bank account. .
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while adding account 							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  April 13 , 2012		Puja Verma created	
	[ ] // //*********************************************************
[-] testcase Test02_OSUOnlineResponseComparision() appstate none
	[+] //VARIABLE
		[ ] STRING sUserName="QTester1"
		[ ] STRING sPassword="Helpme29"
		[ ] STRING sOnlineFile="CustomerCentral"
		[ ] INTEGER iRegistration
		[ ] INTEGER iNavigate,iCreateDataFile
		[ ] STRING sLogName="OSUOFXlog.txt"
		[ ] STRING sTabNameForRequest="CCOSURequest"
		[ ] STRING sTabNameForResponse="CCOSUResponse"
		[ ] 
		[ ] STRING CClogDat="CustomerCentralOFXLOG.DAT"
	[ ] 
	[+] if (QuickenMainWindow.Exists() == TRUE)
		[ ] QuickenMainWindow.Exit()
		[ ] sleep(2)
	[ ] //Deleteing OFXLOG DAT file
	[+] if(FileExists(AUT_DATAFILE_PATH + "\" +CClogDat))
		[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +CClogDat)
	[ ] //Deleting OFX log file if exists
	[+] if(FileExists(AUT_DATAFILE_PATH + "\" +sLogName))
		[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +sLogName)
	[ ] 
	[+] if (!QuickenMainWindow.Exists ())
		[ ] QuickenMainWindow.Start ("{QUICKEN_ROOT}" + "\qw.exe")
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
	[ ] 
	[+] // if (QuickenMainWindow.Exists() == True)
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
	[ ] iCreateDataFile = OpenDataFile(sOnlineFile)
	[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sOnlineFile} is created")
	[ ] QuickenMainWindow.SetActive ()
	[ ] QuickenMainWindow.Maximize()
	[ ] //Click on one step update 
	[ ]  iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
	[+] if(ProductRegistrationPopup.Exists(5))
		[ ] ProductRegistrationPopup.CancelButn.Click()
		[-] iRegistration=BypassRegistration()
			[ ] ReportStatus("Bypass Registration ", iRegistration, "Registration bypassed")
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
	[ ] 
	[-] if(iNavigate == PASS)
		[+] if(OneStepUpdate.Exists(10))
			[ ] OneStepUpdate.SetActive ()
		[ ] 
		[ ] //QuickenMainWindow.QWNavigator.Update_Accounts.Click()
		[ ] //Entering password
		[ ]  MessageBox.ListBox.SubList.PasswordTextBox.SetText(sPassword)
		[ ] // MessageBox.UpdateNow.Click()
		[ ] OneStepUpdate.UpdateNow.Click ()		// click on Update button
		[ ] 
		[ ] //Cancel extra message box
		[+] if(OneStepUpdateMessagebox.Exists(10))
			[ ] OneStepUpdateMessagebox.SetActive()
			[ ] OneStepUpdateMessagebox.No.Click()
		[+] if(OneStepUpdateSummary.Close.Exists(100))
			[ ] OneStepUpdateSummary.Close.Click()
		[ ] //Calling function which save OFX log
		[ ]  SavelogFile(sLogName)
		[ ] 
		[ ] //Calling Function which parsing OFX log of Request
		[ ] OFXLogParsingFunctionForRequest(sLogName,sTabNameForRequest)
		[ ] 
		[ ] //Calling Function which parsing OFX log of Response
		[ ] OFXLogParsingFunctionForResponse(sLogName,sTabNameForResponse)
		[ ] 
		[ ] // //Calling funtion which compariing OFX log
		[ ] // TwoFileComparision(sTabNameForRequest)
		[ ] // 
		[ ] // //Calling funtion which compariing OFX log
		[ ] // TwoFileComparision(sTabNameForResponse)
		[ ] 
	[ ] 
[ ] 
[+] // //############# Perform Update Now  online account and save OFX log ################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test03_UpdateNowResponseCamparision()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will perform update now Wells Fargo Bank account. .
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while adding account 							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  April 13 , 2012		Puja Verma created	
	[ ] // //*********************************************************
[-]  testcase Test03_UpdateNowResponseCamparision() appstate none
	[+] //VARIABLE
		[ ] STRING sUserName="QTester1"
		[ ] STRING sPassword="Helpme29"
		[ ] STRING sOnlineFile="CustomerCentral"
		[ ] STRING sLogName="UpdateNowNOFXLog.txt"
		[ ] INTEGER iXCords = 38
		[ ] INTEGER iYCords = 5
		[ ] STRING sTabNameForRequest="CCUpdateNowRequest"
		[ ] STRING sTabNameForResponse="CCUpdateNowResponse"
		[ ] 
		[ ] STRING CClogDat="CustomerCentralOFXLOG.DAT"
	[ ] 
	[+] if (QuickenMainWindow.Exists() == TRUE)
		[ ] QuickenMainWindow.Exit()
		[ ] sleep(2)
	[ ] //Deleteing OFXLOG DAT file
	[+] if(FileExists(AUT_DATAFILE_PATH + "\" +CClogDat))
		[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +CClogDat)
	[ ] //Deleting OFX log file if exists
	[+] if(FileExists(AUT_DATAFILE_PATH + "\" +sLogName))
		[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +sLogName)
	[+] if (!QuickenMainWindow.Exists ())
		[ ] QuickenMainWindow.Start ("{QUICKEN_ROOT}" + "\qw.exe")
		[ ] 
		[ ] 
	[ ] OpenDataFile(sOnlineFile)
	[ ] //OFF the prefrences settings of Auto accept transaction
	[-] if (QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] UsePopupRegister("ON")			
		[ ] QuickenMainWindow.Maximize()
		[ ] BOOLEAN bSTATE=QuickenMainWindow.View.AccountBar.DockAccountBar.IsChecked()
		[+] if(bSTATE==FALSE)
			[ ] QuickenMainWindow.View.AccountBar.DockAccountBar.Pick ()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.Click(1,iXCords, iYCords)
		[ ] PopupWindow.SetActive()
		[ ] PopupWindow.Maximize()
		[ ] PopupWindow.PressKeys(KEY_CONTROL+ KEY_ALT)										/* Updated by Udita on 11 June 2012 */
		[ ] PopupWindow.TypeKeys("u")
		[ ] PopupWindow.ReleaseKeys(KEY_CONTROL+ KEY_ALT)	
		[+] if(MessageBox.Exists(10))
			[ ] MessageBox.OnlineUpdate.SetActive()
			[ ] MessageBox.OnlineUpdate.Frame.PasswordPopup.Click()
			[ ] MessageBox.OnlineUpdate.Frame.PasswordPopup.PasswordTextBox.SetText(sPassword)
			[ ] MessageBox.OnlineUpdate.UpdateNowButton.Click()
			[+] if(OneStepUpdatePasswordConf.Exists(5))
				[ ] OneStepUpdatePasswordConf.SetActive()
				[ ] OneStepUpdatePasswordConf.No.Click()
			[+] if(OneStepUpdateSummary.Close.Exists(100))
				[ ] OneStepUpdateSummary.Close.Click()
		[ ] //Calling function which save OFX log
		[ ]  SavelogFile(sLogName)
		[ ] //Calling Function which parsing OFX log of Request
		[ ] OFXLogParsingFunctionForRequest(sLogName,sTabNameForRequest)
		[ ] 
		[ ] //Calling Function which parsing OFX log of Response
		[ ] OFXLogParsingFunctionForResponse(sLogName,sTabNameForResponse)
		[ ] // 
		[ ] // // Calling funtion which compariing OFX log
		[ ] // TwoFileComparision(sTabNameForRequest)
		[ ] // 
		[ ] // //Calling funtion which compariing OFX log
		[ ] // TwoFileComparision(sTabNameForResponse)
		[ ] 
