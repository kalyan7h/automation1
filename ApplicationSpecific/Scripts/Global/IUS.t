﻿[ ] // *********************************************************
[+] // FILE NAME:	<IUS.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all IUS test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //
	[ ] // Developed on: 		11/09/2014
	[ ] //			
	[ ] // REVISION HISTORY:
[ ] // *********************************************************
[ ] 
[+] // Global variables used for IUS Test cases
	[ ] public STRING sFileName = "IUS Test"
	[ ] public STRING sTempFileName = "TempDataFile"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sHandle,sActual ,sAccountName ,sDateStamp ,sActualText,sDataFilePassword,sCaption
	[ ] public BOOLEAN bMatch, bExist  ,bResult
	[ ] public INTEGER  iResult ,iCount ,iCounter ,iPhoneNumber ,iZip ,iAddAccount ,iNavigate
	[ ] public STRING sEmailID,  sSecurityQuestion, sSecurityQuestionAnswer, sName, sLastName, sAddress, sCity, sState, sZip,sBoughtFrom,sPhoneNumber , sCityStateZip,sDateTime
	[ ] 
	[ ] public LIST OF ANYTYPE  lsAddAccount,lsExcelData , lsRegistrationData,lsRegistrationData1,lsClearReg
	[ ] public LIST OF STRING lsDetails
	[ ] public STRING sIUSTestData = "IUSTestData"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sRegistrationWorksheet = "RegistrationDetails"
	[ ] INTEGER iListCount 
	[ ] public STRING sIntuitIDPreferenceType ="Intuit ID, Mobile & Alerts"
	[ ] public STRING sProperty="Text"
	[ ] 
	[ ] 
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] public VOID VerifyRegisterationDetailsOnPreferences(STRING sEmailID, STRING sAddress optional, STRING sCityStateZip optional, STRING sPhoneNumber optional)
	[ ] 
	[ ] 
	[+] do
		[ ] 
		[ ] iResult=SelectPreferenceType(sIntuitIDPreferenceType)
		[+] if (iResult==PASS)
			[ ] Preferences.SetActive()
			[ ] 
			[ ] //Verify values updated on Preferences>Intuit ID, Mobile & Alerts
			[ ] //Verify IntuitId
			[ ] sEmailID=StrTran(sEmailID, "@test.qbn.intuit.com","")
			[ ] sActualText=Preferences.IntuitIdFieldText.GetText()
			[+] if (MatchStr("{sEmailID}*",sActualText))
				[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Intuit ID" , PASS, " Intuit ID: {sActualText} is displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab.")
			[+] else
				[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Intuit ID" , FAIL, " Intuit ID is NOT displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab, Actual: {sActualText}, Expected:{sEmailID}.")
			[ ] 
			[ ] //Verify EmailID
			[ ] sActualText=Preferences.EmailIDFieldText.GetText()
			[+] if (MatchStr("{sEmailID}*",sActualText))
				[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Email ID" , PASS, " Email ID: {sActualText} is displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab")
			[+] else
				[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Email ID" , FAIL, " Email ID is NOT displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab, Actual: {sActualText}, Expected:{sEmailID}.")
			[ ] 
			[ ] //Verify Address
			[+] if(!IsNULL(sAddress))
				[ ] sActualText=Preferences.AddressFieldText.GetText()
				[+] if ( sAddress== trim(sActualText))
					[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Address" , PASS, "Address: {sActualText} is displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab")
				[+] else
					[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Address" , FAIL, " Address is NOT displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab, Actual: {sActualText}, Expected:{sAddress}.")
			[ ] 
			[ ] //Verify City , State , Pincode
			[+] if(!IsNULL(sCityStateZip))
				[ ] sActualText=Preferences.CityStatePinFieldText.GetText()
				[+] if ( sCityStateZip== trim(sActualText))
					[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected City , State , Pincode" , PASS, "City , State , Pincode: {sActualText} is displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab.")
				[+] else
					[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected City , State , Pincode" , FAIL, " City , State , Pincode is NOT displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab, Actual: {sActualText}, Expected:{sCityStateZip}.")
			[ ] 
			[ ] //Verify Phone Number
			[+] if(!IsNULL(sPhoneNumber))
				[+] if (sPhoneNumber!="")
					[ ] sPhoneNumber= "+1 "+sPhoneNumber
				[ ] sActualText=Preferences.PhoneNumberFieldText.GetText()
				[+] if (sPhoneNumber== trim(sActualText))
					[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Phone Number" , PASS, "Phone Number: {sActualText} is displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab.")
				[+] else
					[ ] ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Phone Number" , FAIL, " Phone Number is NOT displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab, Actual: {sActualText}, Expected:{sPhoneNumber}.")
			[ ] 
			[ ] Preferences.SetActive()
			[ ] Preferences.Close()
			[ ] WaitForState(Preferences , FALSE ,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Preference dialog.", FAIL, "Preference dialog didn't appear or {sIntuitIDPreferenceType} option not found.")
		[ ] 
	[+] except
		[ ] ExceptLog()
		[ ] 
[ ] 
[+] public STRING GetDateString()
	[ ] 
	[ ] DATETIME dDate=GetDateTime()
	[ ] 
	[ ] STRING sDate= [STRING] dDate
	[ ] sDate= StrTran(sDate, "-", "")
	[ ] sDate= StrTran(sDate, " ", "")
	[ ] sDate= StrTran(sDate, ".", "")
	[ ] 
	[ ] 
	[ ] return sDate
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] // //#############Enviornment Setup #################################################
[+] // testcase IUS_Setup () appstate QuickenBaseState
	[ ] // 
	[ ] // STRING sEnviornment = "Stage-mini"   // Need to update this value as per required enviornment
	[ ] // 
	[ ] // LIST of STRING lsEnviornment = {"Stage-mini","Stage","Production"}
	[ ] // 
	[+] // if(sEnviornment=="Stage-mini")
		[ ] // 
		[ ] // iResult=SetUp_StageMiniConfig(lsEnviornment[1])
		[+] // if(iResult==PASS)
			[ ] // ReportStatus("setup {lsEnviornment[1]} enviornment",PASS,"Enviornment is set to {lsEnviornment[1]}")
		[+] // else
			[ ] // ReportStatus("setup {lsEnviornment[1]} enviornment",FAIL,"Enviornment is not set to {lsEnviornment[1]}")
			[ ] // 
		[ ] // 
	[+] // else if(sEnviornment=="Stage")
		[ ] // 
		[ ] // iResult=SetUp_StageMiniConfig(lsEnviornment[2])
		[+] // if(iResult==PASS)
			[ ] // ReportStatus("setup {lsEnviornment[2]} enviornment",PASS,"Enviornment is set to {lsEnviornment[2]}")
		[+] // else
			[ ] // ReportStatus("setup {lsEnviornment[2]} enviornment",FAIL,"Enviornment is not set to {lsEnviornment[2]}")
			[ ] // 
		[ ] // 
	[+] // else
		[ ] // // do nothing
	[ ] // 
	[+] // if(sEnviornment!="Production")
		[ ] // LaunchQuicken()
		[ ] // sleep(5)
[ ] // //##############################################################################
[ ] // 
[+] // //#############Verify user is able to register ##########################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test1()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Create a new data file and perform Quicken registration by creating a new IAM ID. Provide mobile number while registration.
		[ ] // // Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays all the details related to IAM in upper section
		[ ] // // Perform any online activity such as OSU
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while registering the user							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Sept 11, 2014		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test1 () appstate QuickenBaseState
	[ ] // 
	[ ] // 
	[ ] // // Read data from sAccountWorksheet 
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sAccountWorksheet)
	[ ] // lsAddAccount = lsExcelData[1]
	[ ] // sAccountName =lsAddAccount[2]
	[ ] // 
	[ ] // // Read data from sRegistrationWorksheet 
	[ ] // lsExcelData=NULL
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // lsRegistrationData = lsExcelData[1]
	[ ] // 
	[ ] // sEmailID = trim(lsRegistrationData[1])
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])
	[ ] // sSecurityQuestion = trim(lsRegistrationData[3])	
	[ ] // sSecurityQuestionAnswer = trim(lsRegistrationData[4])	
	[ ] // sName = trim(lsRegistrationData[5])	
	[ ] // sLastName = trim(lsRegistrationData[6])	
	[ ] // sAddress = trim(lsRegistrationData[7])	
	[ ] // sCity = trim(lsRegistrationData[8])	
	[ ] // sState= trim(lsRegistrationData[9])
	[ ] // sZip = trim(lsRegistrationData[10])	
	[ ] // iZip = VAL(sZip)
	[ ] // sZip =Str(iZip)
	[ ] // 
	[ ] // sBoughtFrom = trim(lsRegistrationData[11])	
	[ ] // sPhoneNumber = trim(lsRegistrationData[12])
	[ ] // iPhoneNumber = VAL(sPhoneNumber)
	[ ] // sPhoneNumber =Str(iPhoneNumber)
	[ ] // 
	[ ] // sCityStateZip= sCity + " " +sState +" " +sZip
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // 
		[ ] // //create new datafile
		[ ] // iResult=DataFileCreateWithoutRegistration(sFileName)
		[+] // if(iResult==PASS)
			[ ] // //Register Datafile
			[ ] // RegisterQuickenConnectedServices( sEmailID , sDataFilePassword , sSecurityQuestion , sSecurityQuestionAnswer , sName , sLastName , sAddress , sCity , sState , sZip , sBoughtFrom , NULL  , sPhoneNumber )
			[ ] // QuickenWindow.SetActive()
			[ ] // ExpandAccountBar()
			[ ] // //Verify Registration details on Preferences>Intuit ID, Mobile & Alerts tab
			[ ] // VerifyRegisterationDetailsOnPreferences(sEmailID,sAddress,sCityStateZip,sPhoneNumber)
			[ ] // 
			[ ] // //Enable investing tab
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.View.Click()
			[ ] // QuickenWindow.View.TabsToShow.Click()
			[+] // if(QuickenWindow.View.TabsToShow.Investing.IsChecked==FALSE)
				[ ] // QuickenWindow.View.TabsToShow.Investing.Select()
			[ ] // QuickenWindow.TypeKeys(KEY_ESC)
			[ ] // //Add account
			[ ] // // Quicken is launched then Add Account
			[ ] // iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[+] // if (iAddAccount==PASS)
				[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", PASS, "Account:{sAccountName} is created successfully")
				[ ] // 
				[ ] // // iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
				[+] // // if(iNavigate == PASS)
					[ ] // // 
					[+] // // if(OneStepUpdate.Exists(20))
						[ ] // // OneStepUpdate.SetActive ()
						[ ] // // OneStepUpdate.UpdateNow.Click ()	
						[ ] // // WaitForState(OneStepUpdate, false , 200)
						[+] // // if(OneStepUpdateSummary.Exists(200))
							[ ] // // OneStepUpdateSummary.SetActive()
							[ ] // // OneStepUpdateSummary.Close.Click ()
							[ ] // // ReportStatus("Verify OSU after registering the datafile ",PASS, " OSU was successful after registering the datafile")
						[+] // // else
							[ ] // // ReportStatus("Verify OSU after registering the datafile ",FAIL, " OSU after registering the datafile didn't succeed")
							[ ] // // 
						[ ] // // 
					[+] // // else
						[ ] // // ReportStatus("OneStepUpdate ",FAIL, "OneStepUpdate window is not launched")
						[ ] // // 
						[ ] // // 
						[ ] // // 
					[ ] // // 
				[+] // // else
					[ ] // // ReportStatus("Validate Quotes down loaded ",FAIL, "Quotes down updated unsucesfull")
					[ ] // // 
				[ ] // UpdateNow()
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", FAIL, "Account:{sAccountName} of type {lsAddAccount[1]} couldn't be created successfully")
			[ ] // 
			[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Data file create",FAIL,"Data file {sFileName} is not created ")
			[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##############################################################################
[ ] // 
[+] // //#############Verify Quicken registration using same id created in test scenario 1###########
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test2()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Clear Quicken registration. Create a new data file and perform Quicken registration using same id created in test scenario 1.
		[ ] // // Verify details which are pre-populated on ‘Quicken Registration (Step 2 out of 2)’ screen are correct.
		[ ] // // Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays all the details  related to IAM correctly.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while registering the user							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Sept 11, 2014		Udita Dube	updated
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test2 () appstate none
	[ ] // 
	[ ] // STRING sString = RandStr ("AA")
	[ ] // INTEGER iRand = RandInt(10000,100000)
	[ ] // 
	[ ] // sFileName= "{sString}{iRand}"
	[ ] // // Read data from sAccountWorksheet 
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sAccountWorksheet)
	[ ] // lsAddAccount = lsExcelData[1]
	[ ] // sAccountName =lsAddAccount[2]
	[ ] // 
	[ ] // // Read data from sRegistrationWorksheet 
	[ ] // lsExcelData=NULL
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // lsRegistrationData = lsExcelData[1]
	[ ] // 
	[ ] // sEmailID = trim(lsRegistrationData[1])
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])
	[ ] // sSecurityQuestion = trim(lsRegistrationData[3])	
	[ ] // sSecurityQuestionAnswer = trim(lsRegistrationData[4])	
	[ ] // sName = trim(lsRegistrationData[5])	
	[ ] // sLastName = trim(lsRegistrationData[6])	
	[ ] // sAddress = trim(lsRegistrationData[7])	
	[ ] // sCity = trim(lsRegistrationData[8])	
	[ ] // sState= trim(lsRegistrationData[9])
	[ ] // sZip = trim(lsRegistrationData[10])	
	[ ] // iZip = VAL(sZip)
	[ ] // sZip =Str(iZip)
	[ ] // 
	[ ] // sBoughtFrom = trim(lsRegistrationData[11])	
	[ ] // sPhoneNumber = trim(lsRegistrationData[12])
	[ ] // iPhoneNumber = VAL(sPhoneNumber)
	[ ] // sPhoneNumber =Str(iPhoneNumber)
	[ ] // sPhoneNumber= "+1 "+sPhoneNumber
	[ ] // sCityStateZip= sCity + " " +sState +" " +sZip
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // //Clear Registration
		[ ] // iResult=ClearRegistration()
		[ ] // 
		[+] // if(iResult==PASS)
			[ ] // iResult=NULL
			[ ] // iResult=DataFileCreateWithoutRegistration(sFileName)
			[+] // if(iResult==PASS)
				[ ] // 
				[ ] // lsDetails={sName,sLastName,sAddress,sCity,sState,sZip,sBoughtFrom, sPhoneNumber}
				[ ] // iResult=VerifyRegistrationDetails(sEmailID,sDataFilePassword,sSecurityQuestion,sSecurityQuestionAnswer,lsDetails)
				[+] // // //Register Datafile
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.Exists(20))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.SetText(sEmailID)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sDataFilePassword)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ConfirmPassword.SetText(sDataFilePassword)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestion.Select(val(sSecurityQuestion))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestionAnswer.SetText(sSecurityQuestionAnswer)
						[ ] // // sleep(2)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
						[ ] // // sleep(5)
					[+] // // else
						[ ] // // ReportStatus("Verify IAMContentControl screen",FAIL, "Email id field is not available")
					[ ] // // //Handle if ID already exists
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ExistingUserName.Exists(30))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sDataFilePassword)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
						[ ] // // 
					[+] // // else
						[ ] // // ReportStatus("Verify sign in window",FAIL,"Existing user sign in page is not displayed")
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Exists(60))
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected Name
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Name.GetProperty(sProperty)
						[+] // // if ( sName==lower( trim(sActualText)))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Name" , PASS, " Name: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Name" , FAIL, " Name: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sName}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected LastName
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.LastName.GetProperty(sProperty)
						[+] // // if ( sLastName==lower( trim(sActualText)))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Last Name" , PASS, " Last Name: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Last Name" , FAIL, " Last Name: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sLastName}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected Address
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Address.GetProperty(sProperty)
						[+] // // if ( sAddress== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Address" , PASS, " Address: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Address" , FAIL, " Address: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sAddress}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected City
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.City.GetProperty(sProperty)
						[+] // // if ( sCity== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected City" , PASS, " City: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected City" , FAIL, " City: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sCity}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected State
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.State.GetProperty(sProperty)
						[+] // // if ( sState== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected State" , PASS, " State: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected State" , FAIL, " State: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sState}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected Zip
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Zip.GetProperty(sProperty)
						[+] // // if ( sZip== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Zip" , PASS, " Zip: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Zip" , FAIL, " Zip: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sZip}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected Phone Number
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.MobileNumber.GetProperty(sProperty)
						[+] // // if ( sPhoneNumber== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Phone Number" , PASS, " Phone Number: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Phone Number" , FAIL, " Phone Number: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sPhoneNumber}.")
						[ ] // // 
						[ ] // // //Where Did You Purchase Quicken doesn't get auto populated
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Select(sBoughtFrom)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
						[ ] // // sleep(5)
						[ ] // // 
						[ ] // // 
					[+] // // else
						[ ] // // ReportStatus("Verify WhereDidYouPurchaseQuicken screen",FAIL,"WhereDidYouPurchaseQuicken screen is not displayed")
					[ ] // // //Password Vault condition in case of Registered User
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Exists(60))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseMobileOption.Check()
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Exists(60))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Click()
						[+] // // if(AddAccount.Exists(5))
							[ ] // // AddAccount.SetActive()
							[ ] // // AddAccount.Close()
							[ ] // // WaitForState(AddAccount, False ,5)
					[+] // // if(QuickenAccountSetup.Exists(3))
						[ ] // // QuickenAccountSetup.SetActive()
						[ ] // // QuickenAccountSetup.Cancel.Click()
				[+] // if(iResult==PASS)
					[ ] // 
					[ ] // QuickenWindow.SetActive()
					[ ] // ExpandAccountBar()
					[ ] // // //Navigate to Preferences>Intuit ID, Mobile & Alerts
					[ ] // // iResult=SelectPreferenceType(sIntuitIDPreferenceType)
					[+] // // if (iResult==PASS)
						[ ] // // Preferences.SetActive()
						[ ] // // //Verify values updated on Preferences>Intuit ID, Mobile & Alerts
						[ ] // // //Verify IntuitId
						[ ] // // sActualText=Preferences.IntuitIdFieldText.GetText()
						[+] // // if ( sEmailID== trim(sActualText))
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Intuit ID" , PASS, "Correct Intuit ID: {sActualText} is displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts")
						[+] // // else
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Intuit ID" , FAIL, "Correct Intuit ID is NOT displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts, Actual: {sActualText}, Expected:{sEmailID}.")
						[ ] // // 
						[ ] // // //Verify EmailID
						[ ] // // sActualText=Preferences.EmailIDFieldText.GetText()
						[+] // // if ( sEmailID== lower(trim(sActualText)))
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Email ID" , PASS, "Correct Email ID: {sActualText} is displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts")
						[+] // // else
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Email ID" , FAIL, "Correct Email ID is NOT displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts, Actual: {sActualText}, Expected:{sEmailID}.")
						[ ] // // 
						[ ] // // //Verify Address
						[ ] // // sActualText=Preferences.AddressFieldText.GetText()
						[+] // // if ( sAddress== trim(sActualText))
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Address" , PASS, "Correct Address: {sActualText} is displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts")
						[+] // // else
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Address" , FAIL, "Correct Address is NOT displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts, Actual: {sActualText}, Expected:{sAddress}.")
						[ ] // // 
						[ ] // // //Verify City , State , Pincode
						[ ] // // sActualText=Preferences.CityStatePinFieldText.GetText()
						[+] // // if ( sCityStateZip== trim(sActualText))
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected City , State , Pincode" , PASS, "Correct City , State , Pincode: {sActualText} are displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts")
						[+] // // else
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected City , State , Pincode" , FAIL, " Correct Correct City , State , Pincode are NOT displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts, Actual: {sActualText}, Expected:{sCityStateZip}.")
						[ ] // // 
						[ ] // // //Verify Phone Number
						[ ] // // 
						[ ] // // sActualText=Preferences.PhoneNumberFieldText.GetText()
						[+] // // if ( sPhoneNumber== trim(sActualText))
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Phone Number" , PASS, "Correct Phone Number: {sActualText} is displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts")
						[+] // // else
							[ ] // // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Phone Number" , FAIL, " Correct Phone Number is NOT displayed on Edit-> Preference ->Intuit ID and Mobile & Alerts, Actual: {sActualText}, Expected:{sPhoneNumber}.")
						[ ] // // 
						[ ] // // Preferences.SetActive()
						[ ] // // Preferences.Close()
						[ ] // // WaitForState(Preferences , False ,5)
						[ ] // 
					[ ] // 
					[ ] // sPhoneNumber=StrTran (sPhoneNumber, "+1", "")
					[ ] // sPhoneNumber=trim(sPhoneNumber)
					[ ] // //Verify Registration details on Preferences>Intuit ID, Mobile & Alerts tab
					[ ] // VerifyRegisterationDetailsOnPreferences(sEmailID,sAddress,sCityStateZip,sPhoneNumber)
					[ ] // 
					[ ] // //Enable investing tab
					[ ] // QuickenWindow.SetActive()
					[ ] // QuickenWindow.View.Click()
					[ ] // QuickenWindow.View.TabsToShow.Click()
					[+] // if(QuickenWindow.View.TabsToShow.Investing.IsChecked==FALSE)
						[ ] // QuickenWindow.View.TabsToShow.Investing.Select()
					[ ] // QuickenWindow.TypeKeys(KEY_ESC)
					[ ] // //Add account
					[ ] // // Quicken is launched then Add Account
					[ ] // iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
					[+] // if (iAddAccount==PASS)
						[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", PASS, "Account:{sAccountName} of type {lsAddAccount[1]} created successfully")
						[ ] // // iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
						[ ] // // 
						[+] // // if(iNavigate == PASS)
							[+] // // if(OneStepUpdate.Exists(20))
								[ ] // // OneStepUpdate.SetActive ()
								[ ] // // OneStepUpdate.UpdateNow.Click ()	
								[ ] // // WaitForState(OneStepUpdate, false , 200)
								[+] // // if(OneStepUpdateSummary.Exists(200))
									[ ] // // OneStepUpdateSummary.SetActive()
									[ ] // // OneStepUpdateSummary.Close.Click ()
									[ ] // // ReportStatus("Verify OSU after registering the datafile ",PASS, " OSU was successful after registering the datafile")
								[+] // // else
									[ ] // // ReportStatus("Verify OSU after registering the datafile ",FAIL, " OSU after registering the datafile didn't succeed")
									[ ] // // 
								[ ] // // 
							[+] // // else
								[ ] // // ReportStatus("OneStepUpdate ",FAIL, "OneStepUpdate window is not launched")
								[ ] // // 
							[ ] // // 
						[+] // // else
							[ ] // // ReportStatus("Validate Quotes down loaded ",FAIL, "Quotes down updated unsucesfull")
							[ ] // // 
						[ ] // UpdateNow()
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", FAIL, "Account:{sAccountName} of type {lsAddAccount[1]} couldn't be created successfully")
				[+] // else
					[ ] // ReportStatus("VerifyRegistrationDetails",FAIL,"VerifyRegistrationDetails failed")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Create New Quicken File", FAIL, "New Quicken File is not created") 
				[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Clear registration", FAIL,"Clear registration failed")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##############################################################################
[ ] // 
[+] // //#############Verify Quicken registration by creating a new IAM ID without mobile number ####
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test3()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Clear Quicken registration. Create a new data file and perform Quicken registration by creating a new IAM ID. 
		[ ] // //Don’t provide mobile number while registration.Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays all the details related to IAM in upper section.
		[ ] // //Perform any online activity such as OSU
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while registering the user							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Sept 16, 2014		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test3 () appstate none  //QuickenBaseState
	[ ] // // STRING sString = RandStr ("A(2)9(2)")
	[ ] // // INTEGER iRand = RandInt(RandInt(1,9),RandInt(11,999))
	[ ] // STRING sRandom= RandStr ("X9")
	[ ] // 
	[ ] // sDateTime=GetDateString()
	[ ] // 
	[ ] // STRING sFile= "X{sRandom}{sDateTime}"
	[ ] // 
	[ ] // // Read data from sAccountWorksheet 
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sAccountWorksheet)
	[ ] // lsAddAccount = lsExcelData[1]
	[ ] // sAccountName =lsAddAccount[2]
	[ ] // lsExcelData=NULL
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // lsRegistrationData = lsExcelData[1]
	[ ] // 
	[ ] // sPhoneNumber = " "
	[ ] // sEmailID = "{sRandom}{sDateTime}@test.qbn.intuit.com"
	[ ] // // sEmailID = "user_test@test.qbn.intuit.com"
	[ ] // lsRegistrationData={sEmailID,"auto_qw15","2","Ferrari","quicken","user1","101203 MTV","Mountain View","CA","12346","Other","8"}
	[ ] // WriteExcelTable(sIUSTestData,sRegistrationWorksheet,lsRegistrationData,XLS_DATAFILE_PATH)
	[ ] // // sEmailID = trim(lsRegistrationData[1])
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])	
	[ ] // sSecurityQuestion = trim(lsRegistrationData[3])	
	[ ] // sSecurityQuestionAnswer = trim(lsRegistrationData[4])	
	[ ] // sName = trim(lsRegistrationData[5])	
	[ ] // sLastName = trim(lsRegistrationData[6])	
	[ ] // sAddress = trim(lsRegistrationData[7])	
	[ ] // sCity = trim(lsRegistrationData[8])	
	[ ] // sState= trim(lsRegistrationData[9])
	[ ] // sZip = trim(lsRegistrationData[10])	
	[ ] // iZip = VAL(sZip)
	[ ] // sZip =Str(iZip)
	[ ] // 
	[ ] // sBoughtFrom = trim(lsRegistrationData[11])	
	[ ] // sPhoneNumber = ""
	[ ] // 
	[ ] // sCityStateZip= sCity + " " +sState +" " +sZip
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // 
		[ ] // // //Clear Registration
		[ ] // ClearRegistration()
		[ ] // ClearRegistration()
		[ ] // 
		[ ] // QuickenWindow.ReleaseKeys(KEY_SHIFT)
		[ ] // //create new datafile
		[ ] // iResult=DataFileCreateWithoutRegistration(sFile)
		[+] // if(iResult==PASS)
			[ ] // //Register Datafile
			[ ] // RegisterQuickenConnectedServices( sEmailID , sDataFilePassword , sSecurityQuestion , sSecurityQuestionAnswer , sName , sLastName , sAddress , sCity , sState , sZip , sBoughtFrom , NULL  , sPhoneNumber )
			[ ] // QuickenWindow.SetActive()
			[ ] // ExpandAccountBar()
			[ ] // 
			[ ] // //Verify Registration details on Preferences>Intuit ID, Mobile & Alerts tab
			[ ] // VerifyRegisterationDetailsOnPreferences(sEmailID,sAddress,sCityStateZip,sPhoneNumber)
			[ ] // 
			[ ] // //Enable investing tab
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.View.Click()
			[ ] // QuickenWindow.View.TabsToShow.Click()
			[+] // if(QuickenWindow.View.TabsToShow.Investing.IsChecked==FALSE)
				[ ] // QuickenWindow.View.TabsToShow.Investing.Select()
			[ ] // QuickenWindow.TypeKeys(KEY_ESC)
			[ ] // //Add account
			[ ] // // Quicken is launched then Add Account
			[ ] // iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[+] // if (iAddAccount==PASS)
				[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", PASS, "Account:{sAccountName} is created successfully")
				[ ] // 
				[ ] // // iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
				[+] // // if(iNavigate == PASS)
					[ ] // // 
					[+] // // if(OneStepUpdate.Exists(20))
						[ ] // // OneStepUpdate.SetActive ()
						[ ] // // OneStepUpdate.UpdateNow.Click ()	
						[ ] // // WaitForState(OneStepUpdate, false , 200)
						[+] // // if(OneStepUpdateSummary.Exists(200))
							[ ] // // OneStepUpdateSummary.SetActive()
							[ ] // // OneStepUpdateSummary.Close.Click ()
							[ ] // // ReportStatus("Verify OSU after registering the datafile ",PASS, " OSU was successful after registering the datafile")
						[+] // // else
							[ ] // // ReportStatus("Verify OSU after registering the datafile ",FAIL, " OSU after registering the datafile didn't succeed")
							[ ] // // 
						[ ] // // 
					[+] // // else
						[ ] // // ReportStatus("OneStepUpdate ",FAIL, "OneStepUpdate window is not launched")
						[ ] // // 
						[ ] // // 
						[ ] // // 
					[ ] // // 
				[+] // // else
					[ ] // // ReportStatus("Validate Quotes down loaded ",FAIL, "Quotes down updated unsucesfull")
					[ ] // // 
				[ ] // UpdateNow()
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", FAIL, "Account:{sAccountName} of type {lsAddAccount[1]} couldn't be created successfully")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Data file create",FAIL,"Data file {sFileName} is not created ")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##############################################################################
[ ] // 
[+] // //#Verify Quicken registration using same id created in test scenario3 with mobile number#######
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test4()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // Use the same file; clear the registration; Register with same user from scenario#3; 
		[ ] // //this time provide the phone number . E.g. +14086854800, 14086854800, 4084854800, 1234567890, +919881376338. 
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while registering the user							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Sept 17, 2014		Udita Dube	updated
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test4 () appstate none
	[ ] // INTEGER i
	[ ] // LIST OF STRING lsPhone
	[ ] // BOOLEAN bFlag=FALSE
	[ ] // STRING sDataFileName = RandStr ("AA(3)")
	[ ] // 
	[ ] // lsPhone={"4086854800","1408685490","4084854600","1234567890"}
	[ ] // 
	[ ] // // Read data from sAccountWorksheet 
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sAccountWorksheet)
	[ ] // lsAddAccount = lsExcelData[1]
	[ ] // sAccountName =lsAddAccount[2]
	[ ] // 
	[ ] // // Read data from sRegistrationWorksheet 
	[ ] // lsExcelData=NULL
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // lsRegistrationData = lsExcelData[2]
	[ ] // 
	[ ] // sEmailID = trim(lsRegistrationData[1])
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])
	[ ] // sSecurityQuestion = trim(lsRegistrationData[3])	
	[ ] // sSecurityQuestionAnswer = trim(lsRegistrationData[4])	
	[ ] // sName = trim(lsRegistrationData[5])	
	[ ] // sLastName = trim(lsRegistrationData[6])	
	[ ] // sAddress = trim(lsRegistrationData[7])	
	[ ] // sCity = trim(lsRegistrationData[8])	
	[ ] // sState= trim(lsRegistrationData[9])
	[ ] // sZip = trim(lsRegistrationData[10])	
	[ ] // iZip = VAL(sZip)
	[ ] // sZip =Str(iZip)
	[ ] // 
	[ ] // sBoughtFrom = trim(lsRegistrationData[11])	
	[ ] // sCityStateZip= sCity + " " +sState +" " +sZip
	[ ] // 
	[+] // for(i=1;i<=ListCount(lsPhone);i++)
		[ ] // print (i)
		[ ] // 
		[+] // if(QuickenWindow.Exists(5))
			[ ] // QuickenWindow.SetActive() 
			[ ] // 
			[ ] // ClearRegistration()
			[ ] // //Clear Registration
			[ ] // iResult=ClearRegistration()
			[+] // if(iResult==PASS)
				[ ] // ReportStatus("Clear registration", PASS,"Clear registration successful")
				[ ] // iResult=NULL
				[ ] // iResult=DataFileCreateWithoutRegistration(sDataFileName)
				[ ] // 
				[+] // if(iResult==PASS)
					[ ] // 
					[ ] // iResult=NULL
					[+] // //Register Datafile
						[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.Exists(20))
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.SetText(sEmailID)
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sDataFilePassword)
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ConfirmPassword.SetText(sDataFilePassword)
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestion.Select(val(sSecurityQuestion))
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestionAnswer.SetText(sSecurityQuestionAnswer)
							[ ] // // sleep(2)
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
							[ ] // // sleep(5)
						[+] // // else
							[ ] // // ReportStatus("Verify IAMContentControl screen",FAIL, "Email id field is not available")
						[ ] // // //Handle if ID already exists
						[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ExistingUserName.Exists(30))
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sDataFilePassword)
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
							[ ] // // 
						[+] // // else
							[ ] // // ReportStatus("Verify sign in window",FAIL,"Existing user sign in page is not displayed")
						[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Exists(60))
							[ ] // // 
							[ ] // // //Verify that 'Tell us about yourself' step displays expected Name
							[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Name.GetProperty(sProperty)
							[+] // // if ( sName==lower( trim(sActualText)))
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Name" , PASS, " Name: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
							[+] // // else
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Name" , FAIL, " Name: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sName}.")
							[ ] // // 
							[ ] // // //Verify that 'Tell us about yourself' step displays expected LastName
							[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.LastName.GetProperty(sProperty)
							[+] // // if ( sLastName==lower( trim(sActualText)))
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Last Name" , PASS, " Last Name: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
							[+] // // else
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Last Name" , FAIL, " Last Name: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sLastName}.")
							[ ] // // 
							[ ] // // //Verify that 'Tell us about yourself' step displays expected Address
							[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Address.GetProperty(sProperty)
							[+] // // if ( sAddress== trim(sActualText))
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Address" , PASS, " Address: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
							[+] // // else
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Address" , FAIL, " Address: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sAddress}.")
							[ ] // // 
							[ ] // // //Verify that 'Tell us about yourself' step displays expected City
							[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.City.GetProperty(sProperty)
							[+] // // if ( sCity== trim(sActualText))
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected City" , PASS, " City: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
							[+] // // else
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected City" , FAIL, " City: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sCity}.")
							[ ] // // 
							[ ] // // //Verify that 'Tell us about yourself' step displays expected State
							[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.State.GetProperty(sProperty)
							[+] // // if ( sState== trim(sActualText))
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected State" , PASS, " State: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
							[+] // // else
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected State" , FAIL, " State: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sState}.")
							[ ] // // 
							[ ] // // //Verify that 'Tell us about yourself' step displays expected Zip
							[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Zip.GetProperty(sProperty)
							[+] // // if ( sZip== trim(sActualText))
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Zip" , PASS, " Zip: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
							[+] // // else
								[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Zip" , FAIL, " Zip: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sZip}.")
							[ ] // // 
							[ ] // // //Verify that 'Tell us about yourself' step displays expected Phone Number
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.MobileNumber.SetText(lsPhone[i])
							[ ] // // STRING sTemp=QuickenIAMMainWindow.IAMUserControl.IAMContentControl.MobileNumber.GetProperty(sProperty)
							[ ] // // ReportStatus("Enter phone number on 'Tell us about yourself' step" , PASS, " Phone number: {sTemp} is entered on WhereDidYouPurchaseQuicken screen")
							[ ] // // 
							[ ] // // //Where Did You Purchase Quicken doesn't get auto populated
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Select(sBoughtFrom)
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
							[ ] // // sleep(5)
							[ ] // // 
							[ ] // // 
						[+] // // else
							[ ] // // ReportStatus("Verify WhereDidYouPurchaseQuicken screen",FAIL,"WhereDidYouPurchaseQuicken screen is not displayed")
							[ ] // // bFlag=TRUE
						[ ] // // //Password Vault condition in case of Registered User
						[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Exists(60))
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseMobileOption.Check()
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
						[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Exists(60))
							[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Click()
							[+] // // if(AddAccount.Exists(10))
								[ ] // // AddAccount.SetActive()
								[ ] // // AddAccount.Close()
								[ ] // // WaitForState(AddAccount, FALSE ,5)
						[+] // // if(QuickenAccountSetup.Exists(3))
							[ ] // // QuickenAccountSetup.SetActive()
							[ ] // // QuickenAccountSetup.Cancel.Click()
					[ ] // lsDetails={sName,sLastName,sAddress,sCity,sState,sZip,sBoughtFrom,lsPhone[i]}
					[ ] // iResult=VerifyRegistrationDetails(sEmailID,sDataFilePassword,sSecurityQuestion,sSecurityQuestionAnswer,lsDetails,TRUE)
					[ ] // 
					[+] // if(iResult==PASS)
						[ ] // QuickenWindow.SetActive()
						[ ] // ExpandAccountBar()
						[ ] // 
						[ ] // //Verify Registration details on Preferences>Intuit ID, Mobile & Alerts tab
						[ ] // VerifyRegisterationDetailsOnPreferences(sEmailID,sAddress,sCityStateZip,lsPhone[i])
						[ ] // 
						[ ] // //Enable investing tab
						[ ] // QuickenWindow.SetActive()
						[ ] // QuickenWindow.View.Click()
						[ ] // QuickenWindow.View.TabsToShow.Click()
						[+] // if(QuickenWindow.View.TabsToShow.Investing.IsChecked==FALSE)
							[ ] // QuickenWindow.View.TabsToShow.Investing.Select()
						[ ] // QuickenWindow.TypeKeys(KEY_ESC)
						[ ] // //Add account
						[ ] // // Quicken is launched then Add Account
						[ ] // iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
						[+] // if (iAddAccount==PASS)
							[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", PASS, "Account:{sAccountName} of type {lsAddAccount[1]} created successfully")
							[ ] // 
							[ ] // // iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
							[ ] // // 
							[+] // // if(iNavigate == PASS)
								[ ] // // 
								[+] // // if(OneStepUpdate.Exists(20))
									[ ] // // OneStepUpdate.SetActive ()
									[ ] // // OneStepUpdate.UpdateNow.Click ()	
									[ ] // // WaitForState(OneStepUpdate, false , 200)
									[+] // // if(OneStepUpdateSummary.Exists(200))
										[ ] // // OneStepUpdateSummary.SetActive()
										[ ] // // OneStepUpdateSummary.Close.Click ()
										[ ] // // ReportStatus("Verify OSU after registering the datafile ",PASS, " OSU was successful after registering the datafile")
									[+] // // else
										[ ] // // ReportStatus("Verify OSU after registering the datafile ",FAIL, " OSU after registering the datafile didn't succeed")
										[ ] // // 
									[ ] // // 
								[+] // // else
									[ ] // // ReportStatus("OneStepUpdate ",FAIL, "OneStepUpdate window is not launched")
									[ ] // // 
								[ ] // // 
							[+] // // else
								[ ] // // ReportStatus("Validate Quotes down loaded ",FAIL, "Quotes down updated unsucesfull")
								[ ] // // 
							[ ] // UpdateNow()
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", FAIL, "Account:{sAccountName} of type {lsAddAccount[1]} couldn't be created successfully")
						[ ] // 
						[+] // if(bFlag==TRUE)
							[ ] // ClearRegistration()
						[ ] // 
					[+] // else
						[ ] // ReportStatus("VerifyRegistrationDetails",FAIL,"VerifyRegistrationDetails failed")
						[ ] // 
					[ ] // 
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Create New Quicken File", FAIL, "New Quicken File is not created") 
					[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Clear registration", FAIL,"Clear registration failed")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##############################################################################
[ ] // 
[+] // //#Verify Quicken registration using same id created in test scenario3 with incorrect mobile number############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test5()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // Use the same file; clear the registration; Register with same user from scenario#3; 
		[ ] // // this time provide the incorrect phone number . E.g. +919882376339. 
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If incorrect phone number is not accepted					
		[ ] // //						Fail		If any error occurs or incorrect phone number is accepted in registeration process
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Sept 22, 2014		Udita Dube	updated
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test5 () appstate none
	[ ] // STRING sPhone
	[ ] // sPhone="+919882376338"
	[ ] // 
	[ ] // // Read data from sAccountWorksheet 
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sAccountWorksheet)
	[ ] // lsAddAccount = lsExcelData[1]
	[ ] // sAccountName =lsAddAccount[2]
	[ ] // 
	[ ] // // Read data from sRegistrationWorksheet 
	[ ] // lsExcelData=NULL
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // lsRegistrationData = lsExcelData[2]
	[ ] // 
	[ ] // sEmailID = trim(lsRegistrationData[1])
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])
	[ ] // sSecurityQuestion = trim(lsRegistrationData[3])	
	[ ] // sSecurityQuestionAnswer = trim(lsRegistrationData[4])	
	[ ] // sName = trim(lsRegistrationData[5])	
	[ ] // sLastName = trim(lsRegistrationData[6])	
	[ ] // sAddress = trim(lsRegistrationData[7])	
	[ ] // sCity = trim(lsRegistrationData[8])	
	[ ] // sState= trim(lsRegistrationData[9])
	[ ] // sZip = trim(lsRegistrationData[10])	
	[ ] // iZip = VAL(sZip)
	[ ] // sZip =Str(iZip)
	[ ] // 
	[ ] // sBoughtFrom = trim(lsRegistrationData[11])	
	[ ] // sCityStateZip= sCity + " " +sState +" " +sZip
	[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // 
		[ ] // //Clear Registration
		[ ] // iResult=ClearRegistration()
		[+] // if(iResult==PASS)
			[ ] // iResult=NULL
			[ ] // iResult=DataFileCreateWithoutRegistration(sFileName)
			[+] // if(iResult==PASS)
				[ ] // 
				[ ] // //Register Datafile
				[+] // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.Exists(20))
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.SetText(sEmailID)
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sDataFilePassword)
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ConfirmPassword.SetText(sDataFilePassword)
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestion.Select(val(sSecurityQuestion))
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestionAnswer.SetText(sSecurityQuestionAnswer)
					[ ] // sleep(2)
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[ ] // sleep(5)
				[+] // else
					[ ] // ReportStatus("Verify IAMContentControl screen",FAIL, "Email id field is not available")
				[ ] // 
				[ ] // //Handle if ID already exists
				[+] // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ExistingUserName.Exists(30))
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sDataFilePassword)
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify sign in window",FAIL,"Existing user sign in page is not displayed")
				[ ] // 
				[+] // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Exists(60))
					[ ] // 
					[ ] // //Verify that 'Tell us about yourself' step displays expected Name
					[ ] // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Name.GetProperty(sProperty)
					[+] // if ( sName==lower( trim(sActualText)))
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected Name" , PASS, " Name: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
					[+] // else
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected Name" , FAIL, " Name: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sName}.")
					[ ] // 
					[ ] // //Verify that 'Tell us about yourself' step displays expected LastName
					[ ] // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.LastName.GetProperty(sProperty)
					[+] // if ( sLastName==lower( trim(sActualText)))
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected Last Name" , PASS, " Last Name: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
					[+] // else
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected Last Name" , FAIL, " Last Name: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sLastName}.")
					[ ] // 
					[ ] // //Verify that 'Tell us about yourself' step displays expected Address
					[ ] // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Address.GetProperty(sProperty)
					[+] // if ( sAddress== trim(sActualText))
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected Address" , PASS, " Address: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
					[+] // else
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected Address" , FAIL, " Address: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sAddress}.")
					[ ] // 
					[ ] // //Verify that 'Tell us about yourself' step displays expected City
					[ ] // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.City.GetProperty(sProperty)
					[+] // if ( sCity== trim(sActualText))
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected City" , PASS, " City: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
					[+] // else
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected City" , FAIL, " City: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sCity}.")
					[ ] // 
					[ ] // //Verify that 'Tell us about yourself' step displays expected State
					[ ] // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.State.GetProperty(sProperty)
					[+] // if ( sState== trim(sActualText))
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected State" , PASS, " State: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
					[+] // else
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected State" , FAIL, " State: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sState}.")
					[ ] // 
					[ ] // //Verify that 'Tell us about yourself' step displays expected Zip
					[ ] // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Zip.GetProperty(sProperty)
					[+] // if ( sZip== trim(sActualText))
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected Zip" , PASS, " Zip: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
					[+] // else
						[ ] // ReportStatus("Verify that 'Tell us about yourself' step displays expected Zip" , FAIL, " Zip: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sZip}.")
					[ ] // 
					[ ] // //Verify that 'Tell us about yourself' step displays expected Phone Number
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.MobileNumber.SetText(sPhone)
					[ ] // 
					[ ] // //Where Did You Purchase Quicken doesn't get auto populated
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Select(sBoughtFrom)
					[+] // if(!QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.IsEnabled)
						[ ] // ReportStatus("Verify Incorrect phone number - {sPhone}",PASS,"{sPhone} phone number is not allowed as Next button is not enabled")
					[+] // else
						[ ] // ReportStatus("Verify Incorrect phone number - {sPhone}",FAIL,"{sPhone} phone number is allowed as Next button is enabled")
					[ ] // 
					[ ] // //Verify that 'Tell us about yourself' step displays expected Phone Number
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.MobileNumber.SetText("1234567890")
					[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[ ] // sleep(2)
					[+] // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Exists(150))
						[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseMobileOption.Check()
						[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[ ] // 
					[+] // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Exists(300))
						[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Click()
						[+] // if(AddAccount.Exists(10))
							[ ] // AddAccount.SetActive()
							[ ] // AddAccount.Close()
							[ ] // WaitForState(AddAccount, FALSE ,5)
					[+] // if(QuickenAccountSetup.Exists(3))
						[ ] // QuickenAccountSetup.SetActive()
						[ ] // QuickenAccountSetup.Cancel.Click()
					[ ] // 
					[ ] // 
					[ ] // 
					[ ] // sleep(3)
				[+] // else
					[ ] // ReportStatus("Verify Preference dialog.", FAIL, "Preference dialog didn't appear or {sIntuitIDPreferenceType} option not found.")
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Create New Quicken File", FAIL, "New Quicken File is not created") 
				[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Clear registration", FAIL,"Clear registration failed")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##########################################################################################################
[ ] // 
[+] // //###Use the same file; clear the registration;Sign out IAM; Create a new IAM user and register using it#########################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test6()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Use the same file; clear the registration;Sign out IAM; Create a new IAM user and register using it
		[ ] // // provide the phone number while registering
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while registering the user							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Sept 23, 2014		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test6 () appstate none  
	[ ] // STRING sString = RandStr ("AA")
	[ ] // INTEGER i,iRand = RandInt(1,100)
	[ ] // STRING sConfWorksheet = "Quicken.ini"
	[ ] // 
	[ ] // sDateTime=GetDateString()
	[ ] // 
	[ ] // lsClearReg={"InstallationID","RegisteredVersion","RegistrationCount"}
	[ ] // iCount=ListCount(lsClearReg)
	[ ] //  
	[ ] // STRING sConf_FilePath, sValue, sBlock, sKey
	[ ] // HINIFILE hIni
	[ ] // sBlock="Registration"
	[ ] // // sConf_FilePath = QUICKEN_CONFIG  
	[ ] // sConf_FilePath= "C:\ProgramData\Intuit\Quicken\Config\Quicken.ini"	
	[ ] // 
	[ ] // // Read data from sAccountWorksheet 
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sAccountWorksheet)
	[ ] // lsAddAccount = lsExcelData[1]
	[ ] // sAccountName =lsAddAccount[2]
	[ ] // 
	[ ] // lsExcelData=NULL
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // // lsRegistrationData1 = lsExcelData[2]
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // sEmailID = "{sString}{iRand}{sDateTime}@test.qbn.intuit.com"
	[ ] // // sEmailID = "user_test@test.qbn.intuit.com"
	[ ] // lsRegistrationData={sEmailID,"auto_qw15","2","Ferrari","quicken","user2","101403 MTV","Mountain View","CA","12547","Other","4057554200"}
	[ ] // WriteExcelTable(sIUSTestData,sRegistrationWorksheet,lsRegistrationData,XLS_DATAFILE_PATH)
	[ ] // sEmailID = trim(lsRegistrationData[1])	
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])	
	[ ] // sSecurityQuestion = trim(lsRegistrationData[3])	
	[ ] // sSecurityQuestionAnswer = trim(lsRegistrationData[4])	
	[ ] // sName = trim(lsRegistrationData[5])	
	[ ] // sLastName = trim(lsRegistrationData[6])	
	[ ] // sAddress = trim(lsRegistrationData[7])	
	[ ] // sCity = trim(lsRegistrationData[8])	
	[ ] // sState= trim(lsRegistrationData[9])
	[ ] // sZip = trim(lsRegistrationData[10])	
	[ ] // iZip = VAL(sZip)
	[ ] // sZip =Str(iZip)
	[ ] // 
	[ ] // sBoughtFrom = trim(lsRegistrationData[11])	
	[ ] // sPhoneNumber= trim(lsRegistrationData[12])
	[ ] // sCityStateZip= sCity + " " +sState +" " +sZip
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // 
		[ ] // // // Sign in to data file
		[ ] // // SignInQuickenConnectedServices(lsRegistrationData1[1],lsRegistrationData1[2])
		[ ] // 
		[ ] // // Sign out 
		[ ] // SignOutQuickenConnectedServices()
		[ ] // 
		[+] // for(i=1;i<=iCount;i++)
			[ ] // 
			[ ] // // Clear registration
			[+] // if (FileExists(sConf_FilePath))
				[ ] // sKey=lsClearReg[i]
				[ ] // sValue = ""
				[ ] // 
				[ ] // // Open File
				[ ] // hIni = SYS_IniFileOpen (sConf_FilePath)
				[ ] // // Set Values for keys
				[ ] // SYS_IniFileSetValue (hIni, sBlock , sKey, sValue)
				[ ] // // Close File
				[ ] // SYS_IniFileClose (hIni)
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify {sConf_FilePath} file exists",FAIL,"File - {sConf_FilePath} not found")
				[ ] // 
		[ ] // 
		[ ] // LaunchQuicken()
		[ ] // 
		[ ] // //Register Datafile
		[ ] // RegisterQuickenConnectedServices( sEmailID , sDataFilePassword , sSecurityQuestion , sSecurityQuestionAnswer , sName , sLastName , sAddress , sCity , sState , sZip , sBoughtFrom , NULL  , sPhoneNumber )
		[ ] // QuickenWindow.SetActive()
		[ ] // ExpandAccountBar()
		[ ] // 
		[ ] // //Verify Registration details on Preferences>Intuit ID, Mobile & Alerts tab
		[ ] // VerifyRegisterationDetailsOnPreferences(sEmailID,sAddress,sCityStateZip,sPhoneNumber)
		[ ] // 
		[ ] // //Enable investing tab
		[ ] // QuickenWindow.SetActive()
		[ ] // QuickenWindow.View.Click()
		[ ] // QuickenWindow.View.TabsToShow.Click()
		[+] // if(QuickenWindow.View.TabsToShow.Investing.IsChecked==FALSE)
			[ ] // QuickenWindow.View.TabsToShow.Investing.Select()
		[ ] // QuickenWindow.TypeKeys(KEY_ESC)
		[ ] // 
		[ ] // //Add account
		[ ] // // Quicken is launched then Add Account
		[ ] // iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[+] // if (iAddAccount==PASS)
			[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", PASS, "Account:{sAccountName} is created successfully")
			[ ] // 
			[ ] // // iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
			[+] // // if(iNavigate == PASS)
				[ ] // // 
				[+] // // if(OneStepUpdate.Exists(20))
					[ ] // // OneStepUpdate.SetActive ()
					[ ] // // OneStepUpdate.UpdateNow.Click ()	
					[ ] // // WaitForState(OneStepUpdate, false , 200)
					[+] // // if(OneStepUpdateSummary.Exists(200))
						[ ] // // OneStepUpdateSummary.SetActive()
						[ ] // // OneStepUpdateSummary.Close.Click ()
						[ ] // // ReportStatus("Verify OSU after registering the datafile ",PASS, " OSU was successful after registering the datafile")
					[+] // // else
						[ ] // // ReportStatus("Verify OSU after registering the datafile ",FAIL, " OSU after registering the datafile didn't succeed")
						[ ] // // 
					[ ] // // 
				[+] // // else
					[ ] // // ReportStatus("OneStepUpdate ",FAIL, "OneStepUpdate window is not launched")
					[ ] // // 
					[ ] // // 
					[ ] // // 
				[ ] // // 
			[+] // // else
				[ ] // // ReportStatus("Validate Quotes down loaded ",FAIL, "Quotes down updated unsucesfull")
				[ ] // // 
			[ ] // UpdateNow()
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", FAIL, "Account:{sAccountName} of type {lsAddAccount[1]} couldn't be created successfully")
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##########################################################################################################
[ ] // 
[+] // //###Clear the registration;Create a new data file and perform Quicken registration using same id created in #6##################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test7()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // Clear Quicken registration. Create a new data file and perform Quicken registration using same id created in #6
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while registering the user							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Sept 23, 2014		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test7 () appstate none
	[ ] // // Read data from sAccountWorksheet 
	[ ] // NUMBER nPhone
	[ ] // STRING sMobile
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sAccountWorksheet)
	[ ] // lsAddAccount = lsExcelData[1]
	[ ] // sAccountName =lsAddAccount[2]
	[ ] // 
	[ ] // STRING sString = RandStr ("AA")
	[ ] // INTEGER iRand = RandInt(10000,100000)
	[ ] // 
	[ ] // sFileName= "{sString}{iRand}"
	[ ] // 
	[ ] // 
	[ ] // lsExcelData=NULL
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // lsRegistrationData = lsExcelData[3]
	[ ] // 
	[ ] // sEmailID = trim(lsRegistrationData[1])	
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])	
	[ ] // sSecurityQuestion = trim(lsRegistrationData[3])	
	[ ] // sSecurityQuestionAnswer = trim(lsRegistrationData[4])	
	[ ] // sName = trim(lsRegistrationData[5])	
	[ ] // sLastName = trim(lsRegistrationData[6])	
	[ ] // sAddress = trim(lsRegistrationData[7])	
	[ ] // sCity = trim(lsRegistrationData[8])	
	[ ] // sState= trim(lsRegistrationData[9])
	[ ] // sZip = trim(lsRegistrationData[10])	
	[ ] // iZip = VAL(sZip)
	[ ] // sZip =Str(iZip)
	[ ] // 
	[ ] // sBoughtFrom = trim(lsRegistrationData[11])	
	[ ] // 
	[ ] // sPhoneNumber = trim(lsRegistrationData[12])
	[ ] // nPhone  =VAL(sPhoneNumber)
	[ ] // sPhoneNumber =Str(nPhone,10,0)
	[ ] // sMobile=sPhoneNumber
	[ ] // sPhoneNumber= "+1 "+sPhoneNumber
	[ ] // 
	[ ] // 
	[ ] // sCityStateZip= sCity + " " +sState +" " +sZip
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // 
		[ ] // //Clear Registration
		[ ] // iResult=ClearRegistration()
		[+] // if(iResult==PASS)
			[ ] // iResult=NULL
			[ ] // iResult=DataFileCreateWithoutRegistration(sFileName)
			[+] // if(iResult==PASS)
				[ ] // 
				[ ] // 
				[ ] // LIST OF STRING lsDetails={sName,sLastName,sAddress,sCity,sState,sZip,sBoughtFrom,sPhoneNumber}
				[ ] // iResult=VerifyRegistrationDetails(sEmailID,sDataFilePassword,sSecurityQuestion,sSecurityQuestionAnswer,lsDetails)
				[ ] // 
				[+] // //Register Datafile
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.Exists(20))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.SetText(sEmailID)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sDataFilePassword)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ConfirmPassword.SetText(sDataFilePassword)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestion.Select(val(sSecurityQuestion))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestionAnswer.SetText(sSecurityQuestionAnswer)
						[ ] // // sleep(2)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
						[ ] // // sleep(5)
					[+] // // else
						[ ] // // ReportStatus("Verify IAMContentControl screen",FAIL, "Email id field is not available")
					[ ] // // //Handle if ID already exists
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ExistingUserName.Exists(30))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sDataFilePassword)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
						[ ] // // 
					[+] // // else
						[ ] // // ReportStatus("Verify sign in window",FAIL,"Existing user sign in page is not displayed")
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Exists(60))
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected Name
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Name.GetProperty(sProperty)
						[+] // // if ( sName==lower( trim(sActualText)))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Name" , PASS, " Name: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Name" , FAIL, " Name: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sName}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected LastName
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.LastName.GetProperty(sProperty)
						[+] // // if ( sLastName==lower( trim(sActualText)))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Last Name" , PASS, " Last Name: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Last Name" , FAIL, " Last Name: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sLastName}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected Address
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Address.GetProperty(sProperty)
						[+] // // if ( sAddress== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Address" , PASS, " Address: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Address" , FAIL, " Address: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sAddress}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected City
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.City.GetProperty(sProperty)
						[+] // // if ( sCity== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected City" , PASS, " City: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen.")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected City" , FAIL, " City: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sCity}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected State
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.State.GetProperty(sProperty)
						[+] // // if ( sState== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected State" , PASS, " State: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected State" , FAIL, " State: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sState}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected Zip
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Zip.GetProperty(sProperty)
						[+] // // if ( sZip== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Zip" , PASS, " Zip: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Zip" , FAIL, " Zip: {sActualText} is not auto populated on WhereDidYouPurchaseQuicken screen as expected: {sZip}.")
						[ ] // // 
						[ ] // // //Verify that 'Tell us about yourself' step displays expected Phone Number
						[ ] // // sActualText = QuickenIAMMainWindow.IAMUserControl.IAMContentControl.MobileNumber.GetProperty(sProperty)
						[+] // // if (sPhoneNumber== trim(sActualText))
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Phone Number" , PASS, " Phone Number: {sPhoneNumber} is auto populated on WhereDidYouPurchaseQuicken screen")
						[+] // // else
							[ ] // // ReportStatus("Verify that 'Tell us about yourself' step displays expected Phone Number" , FAIL, " Phone Number: {sActualText} is auto populated on WhereDidYouPurchaseQuicken screen but expected: {sPhoneNumber}.")
						[ ] // // 
						[ ] // // //Where Did You Purchase Quicken doesn't get auto populated
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Select(sBoughtFrom)
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
						[ ] // // sleep(5)
						[ ] // // 
						[ ] // // 
					[+] // // else
						[ ] // // ReportStatus("Verify WhereDidYouPurchaseQuicken screen",FAIL,"WhereDidYouPurchaseQuicken screen is not displayed")
					[ ] // // //Password Vault condition in case of Registered User
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Exists(60))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseMobileOption.Check()
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Exists(60))
						[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Click()
						[+] // // if(AddAccount.Exists(10))
							[ ] // // AddAccount.SetActive()
							[ ] // // AddAccount.Close()
							[ ] // // WaitForState(AddAccount, FALSE ,5)
					[+] // // if(QuickenAccountSetup.Exists(3))
						[ ] // // QuickenAccountSetup.SetActive()
						[ ] // // QuickenAccountSetup.Cancel.Click()
				[+] // if(iResult==PASS)
					[ ] // 
					[ ] // QuickenWindow.SetActive()
					[ ] // ExpandAccountBar()
					[ ] // 
					[ ] // //Verify Registration details on Preferences>Intuit ID, Mobile & Alerts tab
					[ ] // VerifyRegisterationDetailsOnPreferences(sEmailID,sAddress,sCityStateZip,sMobile)
					[ ] // 
					[ ] // //Enable investing tab
					[ ] // QuickenWindow.SetActive()
					[ ] // QuickenWindow.View.Click()
					[ ] // QuickenWindow.View.TabsToShow.Click()
					[+] // if(QuickenWindow.View.TabsToShow.Investing.IsChecked==FALSE)
						[ ] // QuickenWindow.View.TabsToShow.Investing.Select()
					[ ] // QuickenWindow.TypeKeys(KEY_ESC)
					[ ] // //Add account
					[ ] // // Quicken is launched then Add Account
					[ ] // iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
					[+] // if (iAddAccount==PASS)
						[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", PASS, "Account:{sAccountName} of type {lsAddAccount[1]} created successfully")
						[ ] // 
						[ ] // // iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
						[+] // // if(iNavigate == PASS)
							[ ] // // 
							[+] // // if(OneStepUpdate.Exists(20))
								[ ] // // OneStepUpdate.SetActive ()
								[ ] // // OneStepUpdate.UpdateNow.Click ()	
								[ ] // // WaitForState(OneStepUpdate, false , 200)
								[+] // // if(OneStepUpdateSummary.Exists(200))
									[ ] // // OneStepUpdateSummary.SetActive()
									[ ] // // OneStepUpdateSummary.Close.Click ()
									[ ] // // ReportStatus("Verify OSU after registering the datafile ",PASS, " OSU was successful after registering the datafile")
								[+] // // else
									[ ] // // ReportStatus("Verify OSU after registering the datafile ",FAIL, " OSU after registering the datafile didn't succeed")
									[ ] // // 
								[ ] // // 
							[+] // // else
								[ ] // // ReportStatus("OneStepUpdate ",FAIL, "OneStepUpdate window is not launched")
								[ ] // // 
							[ ] // // 
						[+] // // else
							[ ] // // ReportStatus("Validate Quotes down loaded ",FAIL, "Quotes down updated unsucesfull")
							[ ] // // 
						[ ] // UpdateNow()
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify account:{sAccountName} of type {lsAddAccount[1]} created", FAIL, "Account:{sAccountName} of type {lsAddAccount[1]} couldn't be created successfully")
				[+] // else
					[ ] // ReportStatus("VerifyRegistrationDetails",FAIL,"VerifyRegistrationDetails failed")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Create New Quicken File", FAIL, "New Quicken File is not created") 
				[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Clear registration", FAIL,"Clear registration failed")
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##########################################################################################################
[ ] // 
[+] // //#########################Update Intuit id#####################################################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test8()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // Go to Edit -Preferences and update Intuit id
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while updating intuit id		
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Sept 23, 2014		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test8 () appstate none 
	[ ] // 
	[ ] // STRING sSource,sTarget
	[ ] // 
	[ ] // STRING sString = RandStr ("A(3)9(2)")
	[ ] // INTEGER iRand = RandInt(99,9999)
	[ ] // STRING sRandom= RandStr ("X9")
	[ ] // 
	[ ] // sSource=ROOT_PATH + "\ApplicationSpecific\Tools\config\qw.exe.config"
	[ ] // sTarget="{QUICKEN_ROOT}\qw.exe.config"
	[ ] // 
	[ ] // 
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // lsRegistrationData = lsExcelData[3]
	[ ] // 
	[ ] // sEmailID = "{sString}{iRand}{sRandom}@test.qbn.intuit.com"
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])	
	[ ] // 
	[ ] // 
	[+] // if(FileExists(sTarget))
		[ ] // DeleteFile(sTarget)
		[ ] // sleep(2)
	[ ] // 
	[+] // if(FileExists(sSource))
		[ ] // CopyFile(sSource,sTarget)
	[+] // else
		[ ] // ReportStatus("Verify file {sSource} existance",FAIL,"{sSource} file is missing")
	[ ] // 
	[ ] // LaunchQuicken()
	[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // 
		[ ] // iResult=SelectPreferenceType(sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE)
		[+] // if (iResult==PASS)
			[ ] // 
			[ ] // Preferences.SetActive()
			[ ] // Preferences.TextClick("Change",1)
			[+] // if(DlgChangeYourIntuitIDOrEmail.Exists(3))
				[ ] // START:
				[ ] // DlgChangeYourIntuitIDOrEmail.SetActive()
				[ ] // DlgChangeYourIntuitIDOrEmail.NewInTuitIDTextField.SetText(sEmailID)
				[ ] // DlgChangeYourIntuitIDOrEmail.IntuitPasswordTextField.SetText(sDataFilePassword)
				[ ] // DlgChangeYourIntuitIDOrEmail.OKButton.Click()
				[+] // if(DlgChangeYourIntuitIDOrEmail.Exists(SHORT_SLEEP))
					[ ] // sString = RandStr ("A(2)9(3)")
					[ ] // sEmailID = "{sString}_{iRand}@test.qbn.intuit.com"
					[ ] // goto START
					[ ] // 
				[ ] // 
				[ ] // Preferences.SetActive()
				[ ] // 
				[ ] // //Verify values updated on Preferences>Intuit ID, Mobile & Alerts
				[ ] // //Verify IntuitId
				[ ] // sActualText=Preferences.IntuitIdFieldText.GetText()
				[+] // if (lower(sEmailID)== lower(trim(sActualText)))
					[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Intuit ID" , PASS, " Intuit ID: {sActualText} is displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab.")
				[+] // else
					[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Intuit ID" , FAIL, " Intuit ID is NOT displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab, Actual: {sActualText}, Expected:{sEmailID}.")
				[ ] // 
				[ ] // Preferences.SetActive()
				[ ] // Preferences.Close()
				[ ] // 
				[ ] // sleep(1)
				[ ] // QuickenWindow.SetActive()
				[ ] // QuickenWindow.Debug.Click()
				[ ] // QuickenWindow.Debug.SignOut.Select()
				[ ] // 
				[ ] // ExpandAccountBar()
				[ ] // // Verify updated intuit id on sign in dialog
				[+] // do
					[ ] // QuickenMainWindow.QWNavigator.Update_Accounts.Click ()
				[+] // except
					[ ] // QuickenWindow.Tools.Click()
					[ ] // QuickenWindow.Tools.OneStepUpdate.Select()
				[+] // if(DlgIAMSignIn.Exists(5))
					[ ] // DlgIAMSignIn.SetActive()
					[ ] // sCaption=DlgIAMSignIn.IntuitIdText.GetProperty(sProperty)
					[+] // if(sCaption==sEmailID)
						[ ] // ReportStatus("Verify Intuit id on Sign in dialog",PASS,"Updated intuit id {sEmailID} is displayed on Sign in dialog")
					[+] // else
						[ ] // ReportStatus("Verify Intuit id on Sign in dialog",FAIL,"Updated intuit id {sEmailID} is not displayed on Sign in dialog, Actual: {sCaption}")
						[ ] // 
					[ ] // DlgIAMSignIn.Close()
				[+] // else
					[ ] // ReportStatus("Verify Sign in dialog",FAIL,"Sign in dialog is not displayed")
				[ ] // 
				[ ] // // Verify updated intuit id on Mobile and Alerts tab
				[ ] // NavigateQuickenTab(sTAB_MOBILE_ALERTS)
				[+] // if (DlgEnterIntuitPassword.Exists(10))
					[ ] // DlgEnterIntuitPassword.SetActive()
					[ ] // DlgEnterIntuitPassword.Cancel.Click()
					[ ] // WaitForState(DlgEnterIntuitPassword , FALSE , 2)
					[ ] // 
				[ ] // MobileSignUp(sDataFilePassword)
				[ ] // sleep(1)
				[ ] // 
				[ ] // QuickenWindow.SetActive()
				[ ] // sCaption=NULL
				[ ] // sCaption=QuickenMainWindow.IntuitIdText.GetText()
				[+] // if(MatchStr("{sCaption}",sEmailID))
					[ ] // ReportStatus("Verify Intuit id on Mobile & Alerts tab",PASS,"Updated intuit id {sEmailID} is displayed on Mobile & Alerts tab")
				[+] // else
					[ ] // ReportStatus("Verify Intuit id on Mobile & Alerts tab",FAIL,"Updated intuit id {sEmailID} is not displayed on Mobile & Alerts tab, Actual: {sCaption}")
					[ ] // 
					[ ] // 
				[ ] // 
				[ ] // WinMoblieSync.QWSnapHolder1.CreateQuickenCloudIDPanel.DoneButton.DoubleClick()
				[+] // if (DlgAccountsSynced.Exists(400))
					[ ] // DlgAccountsSynced.SetActive()
					[ ] // DlgAccountsSynced.Close()
				[ ] // 
				[ ] // sleep(1)
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify dialog Change Your Intuit ID Or Email",FAIL,"Change Your Intuit ID or Email dialog is not displayed")
		[+] // else
			[ ] // ReportStatus("Select Preference type {sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE}",FAIL,"Preference Type {sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE} is not selected")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##########################################################################################################
[ ] // 
[+] // //#########################Update Email id#####################################################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test9()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // Go to Edit -Preferences and update email id
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while updating email id		
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Sept 29, 2014		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test9 () appstate none 
	[ ] // 
	[ ] // STRING sString = RandStr ("A")
	[ ] // INTEGER iRand = RandInt(99,1000)
	[ ] // 
	[ ] // 
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // lsRegistrationData = lsExcelData[3]
	[ ] // 
	[ ] // sEmailID = "testuser{sString}{iRand}@test.qbn.intuit.com"
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])	
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // 
		[ ] // iResult=SelectPreferenceType(sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE)
		[+] // if (iResult==PASS)
			[ ] // Preferences.SetActive()
			[ ] // Preferences.TextClick("Change",2)
			[+] // if(DlgChangeYourIntuitIDOrEmail.Exists(3))
				[ ] // DlgChangeYourIntuitIDOrEmail.SetActive()
				[ ] // DlgChangeYourIntuitIDOrEmail.NewEmailTextField.SetText(sEmailID)
				[ ] // DlgChangeYourIntuitIDOrEmail.IntuitPasswordTextField.SetText(sDataFilePassword)
				[ ] // DlgChangeYourIntuitIDOrEmail.OKButton.Click()
				[ ] // 
				[ ] // Preferences.SetActive()
				[ ] // 
				[ ] // //Verify values updated on Preferences>Intuit ID, Mobile & Alerts
				[ ] // //Verify EmailID Text
				[ ] // sActualText=Preferences.EmailIDFieldText.GetText()
				[+] // if (lower(sEmailID)== lower(trim(sActualText)))
					[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Email ID" , PASS, " Email ID: {sActualText} is displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab.")
				[+] // else
					[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Email ID" , FAIL, " Email ID is NOT displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab, Actual: {sActualText}, Expected:{sEmailID}.")
				[ ] // 
				[ ] // //Verify values updated on Preferences>Intuit ID, Mobile & Alerts > Alerts Settings
				[ ] // //Verify EmailID Text
				[ ] // Preferences.TextClick("Alert settings")
				[+] // if(DlgEditAlertsSettings.Exists(3))
					[ ] // DlgEditAlertsSettings.SetActive()
					[ ] // sActualText=DlgEditAlertsSettings.EmailIDText.GetProperty(sProperty)
					[+] // if (lower(sEmailID)== lower(trim(sActualText)))
						[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab > Alerts Settings displays expected Email ID" , PASS, " Email ID: {sActualText} is displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab > Alerts Settings.")
					[+] // else
						[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab > Alerts Settings displays expected Email ID" , FAIL, " Email ID is NOT displayed on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab > Alerts Settings, Actual: {sActualText}, Expected:{sEmailID}.")
					[ ] // 
					[ ] // DlgEditAlertsSettings.SetActive()
					[ ] // DlgEditAlertsSettings.Close()
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Edit Alert Settings dialog",FAIL,"Edit Alert Settings Settings dialog is not displayed")
				[ ] // 
				[+] // if(Preferences.Exists(3))
					[ ] // Preferences.SetActive()
					[ ] // Preferences.Close()
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify dialog Change Your Intuit ID Or Email",FAIL,"Change Your Intuit ID or Email dialog is not displayed")
		[+] // else
			[ ] // ReportStatus("Select Preference type {sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE}",FAIL,"Preference Type {sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE} is not selected")
		[ ] //  
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##########################################################################################################
[ ] // 
[+] // //#########################Update Mobile Number################################################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test10()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // Go to Edit -Preferences and update mobile number
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while updating mobile number	
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Sept 29, 2014		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test10 () appstate none 
	[ ] // 
	[ ] // STRING sMobileNumber
	[ ] // INTEGER iRand = RandInt(1000000000,9999999999)
	[ ] // 
	[ ] // 
	[ ] // lsExcelData=ReadExcelTable(sIUSTestData, sRegistrationWorksheet)
	[ ] // lsRegistrationData = lsExcelData[3]
	[ ] // 
	[ ] // sMobileNumber = "+1 {iRand}"
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])	
	[ ] // 
	[-] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // 
		[ ] // iResult=SelectPreferenceType(sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE)
		[-] // if (iResult==PASS)
			[ ] // Preferences.SetActive()
			[-] // do
				[ ] // Preferences.TextClick("Change",3)
			[-] // except
				[ ] // LogException(ExceptData()+"")
				[ ] // Preferences.Close()
			[+] // if(DlgChangeYourContactInformation.Exists(3))
				[ ] // DlgChangeYourContactInformation.SetActive()
				[ ] // DlgChangeYourContactInformation.MobileNumberTextField.SetText(sMobileNumber)
				[ ] // DlgChangeYourContactInformation.IntuitPasswordTextField.SetText(sDataFilePassword)
				[ ] // DlgChangeYourContactInformation.OKButton.Click()
				[ ] // 
				[ ] // Preferences.SetActive()
				[ ] // 
				[ ] // //Verify values updated on Preferences>Intuit ID, Mobile & Alerts
				[ ] // //Verify Mobile number Text
				[ ] // sActualText=Preferences.PhoneNumberFieldText.GetText()
				[+] // if (trim(sMobileNumber)== trim(sActualText))
					[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Mobile number" , PASS, " Mobile number: {sActualText} is updated on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab.")
				[+] // else
					[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Mobile number" , FAIL, " Mobile number is NOT updated on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab, Actual: {sActualText}, Expected:{sMobileNumber}.")
				[ ] // 
				[ ] // Preferences.SetActive()
				[ ] // Preferences.Close()
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify dialog DlgChangeYourContactInformation",FAIL,"DlgChangeYourContactInformation dialog is not displayed")
		[+] // else
			[ ] // ReportStatus("Select Preference type {sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE}",FAIL,"Preference Type {sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE} is not selected")
		[ ] //  
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##########################################################################################################
[ ] // 
[+] // //#############Go to Edit -Preferences and add a mobile number associated with Intuit Id #################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 IUS_Test11()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // Perform Quicken registration, Don't provide mobile number while registration. Go to Edit -Preferences and add a mobile number associated with Intuit Id
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If no error occurs while registering the user							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Sept 29, 2014		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase IUS_Test11 () appstate none 
	[ ] // STRING sString = RandStr ("X9")
	[ ] // INTEGER iRand = RandInt(10000,100000)
	[ ] // STRING sMobileNumber
	[ ] // INTEGER iRand1 = RandInt(1000000000,9999999999)
	[ ] // sMobileNumber = "+1 {iRand1}"
	[ ] // 
	[ ] // sPhoneNumber = " "
	[ ] // sEmailID = "user{sString}{iRand}@test.qbn.intuit.com"
	[ ] // lsRegistrationData={sEmailID,"auto_qw15","2","Ferrari","quicken","user1","101203 MTV","Mountain View","CA","12346","Other","8"}
	[ ] // WriteExcelTable(sIUSTestData,sRegistrationWorksheet,lsRegistrationData,XLS_DATAFILE_PATH)
	[ ] // // sEmailID = trim(lsRegistrationData[1])
	[ ] // sDataFilePassword=trim(lsRegistrationData[2])	
	[ ] // sSecurityQuestion = trim(lsRegistrationData[3])	
	[ ] // sSecurityQuestionAnswer = trim(lsRegistrationData[4])	
	[ ] // sName = trim(lsRegistrationData[5])	
	[ ] // sLastName = trim(lsRegistrationData[6])	
	[ ] // sAddress = trim(lsRegistrationData[7])	
	[ ] // sCity = trim(lsRegistrationData[8])	
	[ ] // sState= trim(lsRegistrationData[9])
	[ ] // sZip = trim(lsRegistrationData[10])	
	[ ] // iZip = VAL(sZip)
	[ ] // sZip =Str(iZip)
	[ ] // 
	[ ] // sBoughtFrom = trim(lsRegistrationData[11])	
	[ ] // sPhoneNumber = ""
	[ ] // 
	[ ] // sCityStateZip= sCity + " " +sState +" " +sZip
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive() 
		[ ] // 
		[ ] // // //Clear Registration
		[ ] // ClearRegistration()
		[ ] // 
		[ ] // //create new datafile
		[ ] // iResult=DataFileCreateWithoutRegistration(sFileName)
		[+] // if(iResult==PASS)
			[ ] // //Register Datafile
			[ ] // RegisterQuickenConnectedServices( sEmailID , sDataFilePassword , sSecurityQuestion , sSecurityQuestionAnswer , sName , sLastName , sAddress , sCity , sState , sZip , sBoughtFrom , NULL  , sPhoneNumber )
			[ ] // QuickenWindow.SetActive()
			[ ] // ExpandAccountBar()
			[ ] // 
			[ ] // //Verify Registration details on Preferences>Intuit ID, Mobile & Alerts tab
			[ ] // VerifyRegisterationDetailsOnPreferences(sEmailID,sAddress,sCityStateZip,sPhoneNumber)
			[ ] // 
			[ ] // QuickenWindow.SetActive()
			[ ] // iResult=SelectPreferenceType(sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE)
			[+] // if (iResult==PASS)
				[ ] // Preferences.SetActive()
				[ ] // Preferences.TextClick("Change",3)
				[+] // if(DlgChangeYourContactInformation.Exists(3))
					[ ] // DlgChangeYourContactInformation.SetActive()
					[ ] // DlgChangeYourContactInformation.MobileNumberTextField.SetText(sMobileNumber)
					[ ] // DlgChangeYourContactInformation.IntuitPasswordTextField.SetText(sDataFilePassword)
					[ ] // DlgChangeYourContactInformation.OKButton.Click()
					[ ] // 
					[ ] // Preferences.SetActive()
					[ ] // 
					[ ] // //Verify values updated on Preferences>Intuit ID, Mobile & Alerts
					[ ] // //Verify Mobile number Text
					[ ] // sActualText=Preferences.PhoneNumberFieldText.GetText()
					[+] // if (trim(sMobileNumber)== trim(sActualText))
						[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Mobile number" , PASS, " Mobile number: {sActualText} is updated on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab.")
					[+] // else
						[ ] // ReportStatus("Verify that ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab displays expected Mobile number" , FAIL, " Mobile number is NOT updated on ‘Edit-> Preference ->Intuit ID and Mobile & Alerts’ tab, Actual: {sActualText}, Expected:{sMobileNumber}.")
					[ ] // 
					[ ] // Preferences.SetActive()
					[ ] // Preferences.Close()
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify dialog DlgChangeYourContactInformation",FAIL,"DlgChangeYourContactInformation dialog is not displayed")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Select Preference type {sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE}",FAIL,"Preference Type {sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE} is not selected")
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Data file create",FAIL,"Data file {sFileName} is not created ")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // //##########################################################################################################
[ ] 
[+] testcase Autolab_Execution_Checking() appstate none
	[ ] // Kalyan
	[ ] print ("Autolab_Execution_Checking to fix notification mails")