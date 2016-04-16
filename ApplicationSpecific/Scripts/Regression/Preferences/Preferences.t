[+] window DialogBox Prefs
	[ ] locator "Preferences"
	[+] StaticText PreferenceTypeText
		[ ] locator "Select preference type:"
	[+] ListBox TypeList
		[ ] locator "//ListBox"
	[+] StaticText PreferencesSelectText
		[ ] locator "Select preferences:"
	[+] StaticText ReportsAndGraphsPreferences
		[ ] locator "Reports and Graphs Preferences"
	[+] PushButton OK
		[ ] locator "OK"
	[+] PushButton Cancel
		[ ] locator "Cancel"
	[+] PushButton Help
		[ ] locator "@priorlabel='Select preference type:'"
	[ ] 
	[ ] // Startup Type - Start
	[ ] 
	[+] StaticText StartupPerfs
		[ ] locator "Startup preferences"
	[ ] 
	[+] Group StartupLocationGroup
		[ ] locator "Startup Location"
	[+] ComboBox OnStartupOpenTo
		[ ] locator 'On startup open to*'
	[ ] 
	[+] Group StartupActionsGroup
		[ ] locator "Startup Actions"
	[+] CheckBox DownloadTransactionsWhenQuickenStarts
		[ ] locator 'Download Transactions when Quicken Starts'
	[+] Control PasswordRequired
		[ ] locator "@windowClassName='QWHtmlView'"
	[ ] 
	[+] Group QuickenColorsGroup
		[ ] locator "Quicken Colors"
	[+] StaticText ColorScheme
		[ ] locator "Color scheme*"
	[+] ComboBox ColorSchemeList
		[ ] locator 'Color scheme*'
	[+] Scale DimDisableWindowsScale
		[ ]  locator 'Lightbox Control'
	[+] CheckBox DimDisableWindows
		[ ] locator "Dim disabled windows"
		[ ] 
	[ ] 
	[ ] // Startup Type - End
	[ ] 
	[+] Group DefaultDateRange
		[ ] locator "Default date range"
	[+] ComboBox DefaultDateRangeComboBox
		[ ] locator "Default date range"
	[+] StaticText From
		[ ] locator "[@caption='from:'][1]"
	[+] StaticText x112014
		[ ] locator "@caption='1/1/2014'"
	[+] StaticText To
		[ ] locator "[@caption='to:'][1]"
	[+] StaticText x6102014
		[ ] locator "@caption='6/10/2014'"
	[+] Group DefaultComparisonDateRange
		[ ] locator "Default comparison date range"
	[+] ComboBox DefaultComparisonDateRangeComboBox
		[ ] locator "Default comparison date range"
	[+] StaticText From2
		[ ] locator "[@caption='from:'][2]"
	[+] StaticText x112013
		[ ] locator "@caption='1/1/2013'"
	[+] StaticText To2
		[ ] locator "[@caption='to:'][2]"
	[+] StaticText x6102013
		[ ] locator "@caption='6/10/2013'"
	[+] Group ReportToolbar
		[ ] locator "Report toolbar"
	[+] RadioList ShowIconsAndText
		[ ] locator "Show icons and text"
	[+] RadioList ShowIconsOnly
		[ ] locator "Show icons only"
	[+] Group CustomizingReportsAndGraphs
		[ ] locator "Customizing reports and graphs"
	[+] RadioList CustomizingCreatesNewReportOrGraph
		[ ] locator "Customizing creates new report or graph"
	[+] RadioList CustomizingModifiesCurrentReportOrGraph
		[ ] locator "Customizing modifies current report or graph"
	[+] Control QWSeparator
		[ ] locator "@windowClassName='QWSeparator'"
	[+] CheckBox CustomizeReportGraphBeforeCreating
		[ ] locator "@caption='Customize report/graph before creating'"
	[+] CheckBox CashBasisReportingIfApplicable
		[ ] locator "Cash-basis reporting if applicable"
	[ ] 
	[ ] LIST OF STRING lsPrefsType = {}
	[ ] 
	[+] BOOLEAN Invoke ()
		[+] if ( this.Exists ())
			[ ] this.SetActive ()
			[ ] return TRUE
			[ ] 
		[ ] 
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[+] do
				[ ] QuickenWindow.Edit.Preferences.Select ()
			[+] except
				[ ] Sleep (1)
				[ ] QuickenWindow.TypeKeys ("<ALT-E>P")
			[ ] Sleep (2)
			[ ] return true
		[+] else
			[ ] LogError ("Quicken Window does not exist...")
			[ ] return false
			[ ] 
		[ ] 
	[ ] 
	[+] INTEGER SelectPrefsType (STRING sPrefsType)
		[ ] INTEGER i
		[ ] STRING sTmpType
		[ ] STRING sHandle
		[ ] 
		[+] for i = 0 to this.TypeList.GetItemCount ()
			[ ] sHandle = Str(this.TypeList.GetHandle())
			[ ] sTmpType = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{i}")
			[+] if MatchStr ("{sPrefsType}", Trim (sTmpType))
				[ ] this.TypeList.Select (i+1)
				[ ] return i+1
			[ ] 
		[ ] return 0
		[ ] 
	[ ] 
	[+] INTEGER SelectPrefsTypePartial (STRING sPrefsType)
		[ ] INTEGER i
		[ ] STRING sTmpType
		[ ] STRING sHandle
		[ ] 
		[+] for i = 0 to this.TypeList.GetItemCount ()
			[ ] sHandle = Str(this.TypeList.GetHandle())
			[ ] sTmpType = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{i}")
			[+] if MatchStr ("*{sPrefsType}*", Trim (sTmpType))
				[ ] this.TypeList.Select (i+1)
				[ ] return i+1
			[ ] 
		[ ] return 0
		[ ] 
	[ ] 
	[+] DialogBox QuickenFilePassword
		[ ] locator "Quicken File Password"
		[+] StaticText QuickenFilePassword
			[ ] locator "Quicken File Password"
		[+] StaticText OldPassword
			[ ] locator "Old Password:"
		[+] TextField OldPasswordTextField
			[ ] locator "Old Password:"
		[+] StaticText NewPassword
			[ ] locator "New Password:"
		[+] TextField NewPasswordTextField
			[ ] locator "New Password:"
		[+] StaticText ConfirmPassword
			[ ] locator "Confirm Password:"
		[+] TextField ConfirmPasswordTextField
			[ ] locator "Confirm Password:"
		[+] StaticText SecurePasswordsAreTypicallyLon
			[ ] locator "Secure passwords are typically longer than six characters, should include a combination of letters and numbers, and should not contain obvious words such as your name."
		[+] StaticText NoteToRemoveOldPasswordLeaveNe
			[ ] locator "Note: To remove old password, leave new and Confirm fields blank.  Also note that passwords are case senstive."
		[+] PushButton NoteToRemoveOldPasswordLeaveNePushButton
			[ ] locator "[@priorlabel='Note: To remove old password, leave new and Confirm fields blank.  Also note that passwords are case senstive.'][1]"
		[+] PushButton OK
			[ ] locator "OK"
		[+] PushButton Cancel
			[ ] locator "Cancel"
[ ] 
[+] window MainWin OneStepUpdate
	[ ] locator "One Step Update *"
	[+] Control QWIconDisplay
		[ ] locator "@windowClassName='QWIconDisplay'"
	[+] StaticText OneStepUpdateSettings
		[ ] locator "One Step Update Settings"
	[+] MainWin xWindow
		[ ] locator "//MainWin"
	[+] ListBox ListBox
		[ ] locator "//ListBox"
	[+] PushButton ScheduleUpdates
		[ ] locator "Schedule Updates..."
	[+] CheckBox ShowPasswordCharacters
		[ ] locator "Show password characters"
	[+] PushButton OneStepUpdateSettingsPushButton
		[ ] locator "[@priorlabel='One Step Update Settings'][2]"
	[+] PushButton UpdateNow
		[ ] locator "Update Now"
	[+] PushButton Cancel
		[ ] locator "Cancel"
	[+] PushButton Close
		[ ] locator "Close"
	[ ] 
[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<Preferences.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Preferences  test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Prakash Palanisamy
	[ ] //
	[ ] // Developed on: 		16/Jun/2014
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Jun 16, 2014	Prakash Palanisamy  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "C:\automation\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] // Global variables
	[ ] public STRING sQuickenFilePassword = "Quicken"
	[ ] public STRING sNewFileName = "Prefs"
	[ ] public STRING sFileName = "Prefs_Data"
	[ ] public STRING sNewDataFile = AUT_DATAFILE_PATH + "\" + sNewFileName + ".QDF"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] LIST OF STRING lsSKUName = {"Rental Property Manager", "Home & Business", "Premier", "Deluxe", "Starter Edition", "Checkbook"}
	[ ] 
	[ ] public INTEGER iSelect, iResultStatus
	[ ] 
	[ ] BOOLEAN bResult = False
[ ] 
[+] //#############  Preferences Setup #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 PreferencesSetup()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the Prefs.QDF if it exists. It will setup the necessary pre-requisite for tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // ********************************************************
	[ ] 
[+] testcase PreferencesSetup () appstate none
	[ ] INTEGER iSetupAutoAPI,iCreateDataFile, iSelect, iNavigate
	[ ] STRING sAccountType = "Checking"
	[ ] STRING sAccountName = "PreferencesChecking"
	[ ] STRING sAccountBalance = "1000"
	[ ] STRING sCurrentDate
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
	[+] else
		[ ] LaunchQuicken ()
		[ ] 
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] // Create Data File
	[ ] iCreateDataFile = DataFileCreate(sNewFileName)
	[ ] 
	[ ] // Report Staus If Data file Created successfully
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sNewDataFile} is created")
		[ ] 
		[ ] //Navigate to Home Tab and create a checking account
		[ ] NavigateQuickenTab(sTAB_HOME)
		[+] if (QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Exists())
			[ ] ReportStatus("Validate if  Account Bar is expanded", PASS, "Account Bar is expanded")
		[+] else
			[ ] QuickenMainWindow.QWNavigator.AccountExpand.Click()
		[ ] sCurrentDate = FormatDateTime(GetDateTime(), "mm/dd/yyyy")
		[ ] iSelect = AddManualSpendingAccount(sAccountType, sAccountName, sAccountBalance, sCurrentDate)
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Validate Account Creation ", PASS, "Checking Account -  {sAccountName} is created")
		[+] else
			[ ] ReportStatus("Validate Account Creation ", PASS, "Checking Account -  {sAccountName} is created")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sNewDataFile} is not created")
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test1_StartupPrefs_UI #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test1_StartupPrefs_UI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the Start Up Preferences-UI for New User based on the sku installed
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while verifying the Start Up Preferences-UI for New User based on the sku						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test1_StartupPrefs_UI() appstate none
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // STEP2: Verify the available options
			[ ] // 1) By default Startup preference should be selected.
			[ ] bResult = Prefs.StartupPerfs.Exists ()
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "By default Startup preference is selected.")
			[ ] 
			[ ] // 2) In Startup Preferences it should display three main section as,
    //   A) On start Up open to
    //   B) Quicken color.
    //   C) StartUp Action
			[ ] 
			[ ] bResult = Prefs.StartupLocationGroup.Exists ()
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "On Start Up open to: group present")
			[ ] 
			[ ] bResult = Prefs.StartupActionsGroup.Exists ()
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "On Start Up action: group present")
			[ ] 
			[ ] bResult = Prefs.QuickenColorsGroup.Exists ()
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "Quicken Colors: group present")
			[ ] 
			[ ] // 3) Two button should dispaly as 
    //     a) Ok
    //     b) Cancel.
			[ ] bResult = Prefs.OK.Exists ()
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "OK button present")
			[ ] 
			[ ] bResult = Prefs.Cancel.Exists ()
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "Cancel button present")
			[ ] 
			[ ] // 4) The Help link should dispaly.
			[ ] bResult = Prefs.Help.Exists ()
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "Help Link present")
			[ ] 
			[ ] Prefs.Cancel.Click ()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test2_StartupPrefs_OnStartUpOpenTo #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test2_StartupPrefs_OnStartUpOpenTo()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if user changes  option for "On start Up open to"
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying if user changes  option for "On start Up open to"					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test2_StartupPrefs_OnStartUpOpenTo() appstate none
	[ ] STRING sQknCaption = ""
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // Select any other option like Bill, My pages, Banking etc.
			[ ] Prefs.OnStartupOpenTo.Select (3)
			[ ] 
			[ ] // Click on OK button
			[ ] Prefs.OK.Click ()
			[ ] 
			[ ] // Close and Open Quicken
			[ ] CloseQuicken ()
			[ ] LaunchQuicken ()
			[ ] 
			[ ] // After open the Quicken application it should open the page which Is selected option for "On start up open to"
			[ ] QuickenWindow.SetActive()
			[ ] sQknCaption = QuickenWindow.GetCaption ()
			[ ] bResult = MatchStr ("*[Bills]*", sQknCaption)
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "Quicken Opens with [Bills] Tab")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test3_StartupPrefs_QuickenDefColor #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test3_StartupPrefs_QuickenDefColor()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the default selected option for "Quicken Color"
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying the default color in Quicken Preferences				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test3_StartupPrefs_QuickenDefColor () appstate none
	[ ] STRING sQknSelColor = ""
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // Verify the default selected option for "Quicken Color"
			[ ] sQknSelColor = Prefs.ColorSchemeList.GetSelectedItem ()
			[ ] bResult = MatchStr ("*Blue*", sQknSelColor)
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "By default the 'Blue' color is selected for")
			[ ] 
			[ ] Prefs.Cancel.Click ()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test4_StartupPrefs_QuickenSelColor #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test4_StartupPrefs_QuickenDefColor()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if User changes  option for "Quicken Color" 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying the changes made in the "Quicken Color" scheme	
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test4_StartupPrefs_QuickenSelColor () appstate none
	[ ] STRING sQknSelColor = ""
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // select any one color as " Green,perpal,tan
			[ ] Prefs.ColorSchemeList.Select ("Green")
			[ ] 
			[ ] // Click on OK button
			[ ] Prefs.OK.Click ()
			[ ] 
			[ ] // Close and Open Quicken
			[ ] CloseQuicken ()
			[ ] LaunchQuicken ()
			[ ] 
			[ ] // Verify The color  should display as selcted color in "Quicken color " option.
			[ ] Prefs.Invoke ()
			[ ] sQknSelColor = Prefs.ColorSchemeList.GetSelectedItem ()
			[ ] bResult = MatchStr ("Green", sQknSelColor)
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "The Color is changed to [Green] ")
			[ ] 
			[ ] Prefs.Cancel.Click ()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test5_StartupPrefs_StartupAction #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test5_StartupPrefs_StartupAction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify the available option for "Startup Action"
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying the available option for "Startup Action"			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test5_StartupPrefs_StartupAction () appstate none
	[ ] STRING sQknSelColor = ""
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // Verify the available option for "Startup Action"
			[ ] 
			[ ] // In the start up Action the following three option should display as;
			[ ] //    A) Downlaod Transaction when QN start
			[ ] //    B) Password required when QN start
			[ ] 
			[ ] bResult = Prefs.DownloadTransactionsWhenQuickenStarts.Exists ()
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "Downlaod Transaction when Quicken starts option is available")
			[ ] 
			[ ] bResult = Prefs.PasswordRequired.Exists ()
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "Password Required when Quicken starts option is available")
			[ ] 
			[ ] Prefs.Cancel.Click ()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test6_StartupPrefs_StartupDownloadTxns #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test6_StartupPrefs_StartupDownloadTxns()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify if user select the check box for "Downlaod Transaction when QN start"
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying if user select the check box for "Downlaod Transaction when QN start"			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test6_StartupPrefs_StartupDownloadTxns () appstate none
	[ ] STRING sQknSelColor = ""
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // Verify the available option for "Startup Action"
			[ ] 
			[ ] // In the start up Action the following three option should display as;
			[ ] //    A) Downlaod Transaction when QN start
			[ ] 
			[ ] bResult = Prefs.DownloadTransactionsWhenQuickenStarts.Exists ()
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "Downlaod Transaction when Quicken starts option is available")
			[ ] 
			[ ] // Select the check box for " "Downlaod Transaction when QN start"
			[+] if ( Prefs.DownloadTransactionsWhenQuickenStarts.Exists () )
				[ ] Prefs.DownloadTransactionsWhenQuickenStarts.Check ()
				[ ] 
				[ ] // Click on OK button
				[ ] Prefs.OK.Click ()
				[ ] 
				[ ] // Close and Open Quicken
				[ ] CloseQuicken ()
				[ ] 
				[ ] // The Quicken should start OSU and download the transaction if available when Quicken start.
				[ ] App_Start (sCmdLine)
				[ ] sleep(15)
				[ ] WaitForState(OneStepUpdate, true , 120)
				[ ] 
				[ ] bResult = OneStepUpdate.Exists ()
				[ ] 
				[+] if ( bResult )
					[ ] iResultStatus = 0
					[+] if ( OneStepUpdate.Cancel.Exists ())
						[ ] OneStepUpdate.Cancel.Click ()
					[+] if ( OneStepUpdate.Close.Exists ())
						[ ] OneStepUpdate.Close.Click ()
					[+] if (OneStepUpdate.Exists ())
						[ ] OneStepUpdate.Close ()
					[ ] 
				[+] else
					[ ] iResultStatus = 1
				[ ] 
				[ ] ReportStatus("Startup Preferences ", iResultStatus, "The Quicken starts OSU and download the transaction if available when Quicken starts")
				[ ] 
			[+] else
				[ ] ReportStatus("Startup Preferences ", iResultStatus, "Downlaod Transaction when Quicken starts option is NOT available")
			[ ] 
			[ ] Prefs.Invoke ()
			[+] if ( Prefs.DownloadTransactionsWhenQuickenStarts.Exists () )
				[ ] Prefs.DownloadTransactionsWhenQuickenStarts.Uncheck ()
				[ ] 
				[ ] // Click on OK button
				[ ] Prefs.OK.Click ()
				[ ] 
				[ ] // Close and Open Quicken
				[ ] CloseQuicken ()
				[ ] LaunchQuicken ()
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test7_StartupPrefs_NoPwdDefOpt #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test7_StartupPrefs_NoPwdDefOpt()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the by default selected option for "Password required when QN start"
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying the by default selected option for "Password required when QN start"			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test7_StartupPrefs_NoPwdDefOpt () appstate none
	[ ] STRING sPwdTxt = ""
	[ ] RECT rXYPosPwd
	[ ] 
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // Verify the by default selected option for "Password required when QN start"
			[+] if ( Prefs.PasswordRequired.Exists () )
				[ ] rXYPosPwd = Prefs.PasswordRequired.GetRect ()
				[ ] Prefs.PasswordRequired.Click(MB_LEFT, rXYPosPwd.xPos-5, rXYPosPwd.ySize-5)
				[ ] WaitForState (Prefs.QuickenFilePassword, TRUE, 30)
				[ ] 
				[+] if ( Prefs.QuickenFilePassword.Exists ())
					[ ] Prefs.QuickenFilePassword.SetActive ()
					[ ] bResult = ! Prefs.QuickenFilePassword.OldPassword.Exists ()
					[ ] 
					[+] if ( bResult )
						[ ] iResultStatus = 0
					[+] else
						[ ] iResultStatus = 1
					[ ] 
					[ ] ReportStatus("Startup Preferences ", iResultStatus, "By default for the new file the NO option is displayed")
					[ ] 
					[ ] Prefs.QuickenFilePassword.Cancel.Click ()
					[ ] 
				[+] else
					[ ] ReportStatus("Startup Preferences ", 1, "Quicken File Password Dialog Failed to Open")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] iResultStatus = 1
				[ ] ReportStatus("Startup Preferences ", iResultStatus, "The Password Change link is not available")
				[ ] 
			[ ] 
			[ ] Prefs.Cancel.Click ()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test8_StartupPrefs_PwdClick #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test8_StartupPrefs_PwdClick ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if user click on Change link
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying if user click on Change link			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test8_StartupPrefs_PwdClick () appstate none
	[ ] STRING sPwdTxt = ""
	[ ] RECT rXYPosPwd
	[ ] 
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // Verify if user click on Change link
			[ ] // It should open the "Quicken File Password" dialog
			[ ] 
			[+] if ( Prefs.PasswordRequired.Exists () )
				[ ] rXYPosPwd = Prefs.PasswordRequired.GetRect ()
				[ ] 
				[ ] Prefs.PasswordRequired.Click(MB_LEFT, rXYPosPwd.xPos-5, rXYPosPwd.ySize-5)
				[ ] WaitForState (Prefs.QuickenFilePassword, TRUE, 30)
				[ ] 
				[+] if ( Prefs.QuickenFilePassword.Exists ())
					[ ] Prefs.QuickenFilePassword.SetActive ()
					[ ] bResult = Prefs.QuickenFilePassword.Exists ()
					[ ] 
					[+] if ( bResult )
						[ ] iResultStatus = 0
					[+] else
						[ ] iResultStatus = 1
					[ ] 
					[ ] ReportStatus("Startup Preferences ", iResultStatus, "Clicks on Password [change] link, the Quicken File Password dialog  is displayed")
					[ ] 
					[ ] Prefs.QuickenFilePassword.Cancel.Click ()
					[ ] 
				[+] else
					[ ] ReportStatus("Startup Preferences ", FAIL, "Quicken File Password Dialog Failed to Open")
					[ ] 
			[+] else
				[ ] iResultStatus = 1
				[ ] ReportStatus("Startup Preferences ", iResultStatus, "The Password Change link is not available")
				[ ] 
			[ ] 
			[ ] Prefs.Cancel.Click ()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test9_StartupPrefs_SetPwd #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test9_StartupPrefs_SetPwd ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if usercan set the file password
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying if usercan set the file password			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test9_StartupPrefs_SetPwd () appstate none
	[ ] STRING sPwdTxt = ""
	[ ] RECT rXYPosPwd
	[ ] 
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // Verify if user click on Change link
			[ ] // It should open the "Quicken File Password" dialog
			[ ] // Verify if user can set the password for Quicken File
			[ ] 
			[+] if ( Prefs.PasswordRequired.Exists () )
				[ ] rXYPosPwd = Prefs.PasswordRequired.GetRect ()
				[ ] 
				[ ] Prefs.PasswordRequired.Click(MB_LEFT, rXYPosPwd.xPos-5, rXYPosPwd.ySize-5)
				[ ] WaitForState (Prefs.QuickenFilePassword, TRUE, 30)
				[ ] 
				[+] if ( Prefs.QuickenFilePassword.Exists ())
					[ ] Prefs.QuickenFilePassword.SetActive ()
					[ ] bResult = Prefs.QuickenFilePassword.Exists ()
					[ ] 
					[+] if ( bResult )
						[ ] iResultStatus = 0
					[+] else
						[ ] iResultStatus = 1
					[ ] 
					[ ] ReportStatus("Startup Preferences ", iResultStatus, "Clicks on Password [change] link, the Quicken File Password dialog  is displayed")
					[ ] 
					[ ] Prefs.QuickenFilePassword.NewPasswordTextField.SetText ("{sQuickenFilePassword}")
					[ ] Prefs.QuickenFilePassword.ConfirmPasswordTextField.SetText ("{sQuickenFilePassword}")
					[ ] Prefs.QuickenFilePassword.OK.Click ()
					[ ] 
				[+] else
					[ ] ReportStatus("Startup Preferences ", FAIL, "Quicken File Password Dialog Failed to Open")
					[ ] 
				[ ] 
				[ ] Prefs.PasswordRequired.Click(MB_LEFT, rXYPosPwd.xPos-5, rXYPosPwd.ySize-5)
				[ ] WaitForState (Prefs.QuickenFilePassword, TRUE, 30)
				[ ] 
				[+] if ( Prefs.QuickenFilePassword.Exists ())
					[ ] Prefs.QuickenFilePassword.SetActive ()
					[ ] bResult = Prefs.QuickenFilePassword.OldPassword.Exists ()
					[ ] 
					[+] if ( bResult )
						[ ] iResultStatus = 0
					[+] else
						[ ] iResultStatus = 1
					[ ] 
					[ ] ReportStatus("Startup Preferences ", iResultStatus, "The Password has been set for Quicken Data File")
					[ ] 
					[ ] Prefs.QuickenFilePassword.Cancel.Click ()
					[ ] 
				[+] else
					[ ] ReportStatus("Startup Preferences ", 1, "Quicken File Password Dialog Failed to Open")
					[ ] 
				[ ] 
			[+] else
				[ ] iResultStatus = 1
				[ ] ReportStatus("Startup Preferences ", iResultStatus, "The Password Change link is not available")
				[ ] 
			[ ] 
			[ ] Prefs.OK.Click ()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test10_StartupPrefs_VerifyPwd #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test10_StartupPrefs_VerifyPwd ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify file Password is working properly
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying file Password is working properly			
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test10_StartupPrefs_VerifyPwd () appstate none
	[ ] STRING sPwdTxt = ""
	[ ] RECT rXYPosPwd
	[ ] 
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // Verify if user click on Change link
			[ ] // It should open the "Quicken File Password" dialog
			[ ] // Verify file Password is working properly
			[ ] 
			[+] if ( Prefs.PasswordRequired.Exists () )
				[ ] rXYPosPwd = Prefs.PasswordRequired.GetRect ()
				[ ] 
				[ ] Prefs.PasswordRequired.Click(MB_LEFT, rXYPosPwd.xPos-5, rXYPosPwd.ySize-5)
				[ ] WaitForState (Prefs.QuickenFilePassword, TRUE, 30)
				[ ] 
				[+] if ( Prefs.QuickenFilePassword.Exists ())
					[ ] Prefs.QuickenFilePassword.SetActive ()
					[+] if ( ! Prefs.QuickenFilePassword.OldPassword.Exists ())
						[ ] Prefs.QuickenFilePassword.NewPasswordTextField.SetText ("{sQuickenFilePassword}")
						[ ] Prefs.QuickenFilePassword.ConfirmPasswordTextField.SetText ("{sQuickenFilePassword}")
						[ ] Prefs.QuickenFilePassword.OK.Click ()
					[+] else
						[ ] Prefs.QuickenFilePassword.Cancel.Click ()
					[ ] 
				[+] else
					[ ] ReportStatus("Startup Preferences ", 1, "Quicken File Password Dialog Failed to Open")
					[ ] 
				[ ] 
			[+] else
				[ ] iResultStatus = 1
				[ ] ReportStatus("Startup Preferences ", iResultStatus, "The Password Change link is not available")
				[ ] 
			[ ] 
			[ ] Prefs.OK.Click ()
			[ ] 
			[ ] // Close Quicken
			[ ] CloseQuicken ()
			[ ] 
			[ ] // Open Quicken
			[ ] App_Start (sCmdLine)
			[ ] sleep(15)
			[ ] 
			[ ] WaitForState(EnterQuickenPassword, true , 120)
			[ ] 
			[ ] bResult = EnterQuickenPassword.Exists ()
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
				[ ] EnterQuickenPassword.Password.SetText ("{sQuickenFilePassword}")
				[ ] EnterQuickenPassword.OK.Click ()
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "The [Enter Quicken Password] dialog appears when Quicken starts")
			[ ] 
			[ ] WaitForState(EnterQuickenPassword, False , 120)
			[ ] 
			[ ] WaitForState(QuickenWindow, TRUE , 120)
			[ ] 
			[ ] 
			[ ] bResult = QuickenWindow.Exists () && QuickenWindow.IsActive ()
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "Quicken Launched & Active after entering correct password")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Test11_StartupPrefs_RemovePwd #################################################
	[ ] // *************************************************************************************************
	[+] // TestCase Name:	 Test11_StartupPrefs_RemovePwd ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if user can remove the file password
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while Verifying if user can remove the file password		
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jun 16, 2014		Prakash Palanisamy	created
	[ ] // *****************************************************************************************************
	[ ] 
[+] testcase Test11_StartupPrefs_RemovePwd () appstate none
	[ ] STRING sPwdTxt = ""
	[ ] RECT rXYPosPwd
	[ ] 
	[+] do
		[ ] // PreCondition Steps: 1.Quicken 2010 Installed on Machine.
		[+] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // STEP1: Go to Edit Menu-> Preference->Quicken programm
			[ ] Prefs.Invoke ()
			[ ] 
			[ ] // Verify if user click on Change link
			[ ] // It should open the "Quicken File Password" dialog
			[ ] // Verify if user can remove the file password
			[ ] 
			[+] if ( Prefs.PasswordRequired.Exists () )
				[ ] rXYPosPwd = Prefs.PasswordRequired.GetRect ()
				[ ] 
				[ ] Prefs.PasswordRequired.Click(MB_LEFT, rXYPosPwd.xPos-5, rXYPosPwd.ySize-5)
				[ ] WaitForState (Prefs.QuickenFilePassword, TRUE, 30)
				[ ] 
				[+] if ( Prefs.QuickenFilePassword.Exists ())
					[ ] Prefs.QuickenFilePassword.SetActive ()
					[+] if ( Prefs.QuickenFilePassword.OldPassword.Exists ())
						[ ] Prefs.QuickenFilePassword.OldPasswordTextField.SetText ("{sQuickenFilePassword}")
						[ ] Prefs.QuickenFilePassword.NewPasswordTextField.SetText ("")
						[ ] Prefs.QuickenFilePassword.ConfirmPasswordTextField.SetText ("")
						[ ] Prefs.QuickenFilePassword.OK.Click ()
					[+] else
						[ ] Prefs.QuickenFilePassword.Cancel.Click ()
					[ ] 
				[+] else
					[ ] ReportStatus("Startup Preferences ", 1, "Quicken File Password Dialog Failed to Open")
					[ ] 
				[ ] 
			[+] else
				[ ] iResultStatus = 1
				[ ] ReportStatus("Startup Preferences ", iResultStatus, "The Password Change link is not available")
				[ ] 
			[ ] 
			[ ] Prefs.OK.Click ()
			[ ] 
			[ ] // Close Quicken
			[ ] CloseQuicken ()
			[ ] 
			[ ] // Open Quicken
			[ ] App_Start (sCmdLine)
			[ ] sleep(15)
			[ ] 
			[ ] WaitForState(EnterQuickenPassword, true , 20)
			[ ] 
			[ ] bResult = ! EnterQuickenPassword.Exists ()
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
				[ ] EnterQuickenPassword.Password.SetText ("{sQuickenFilePassword}")
				[ ] EnterQuickenPassword.OK.Click ()
				[ ] 
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "The [Enter Quicken Password] dialog does not appear when Quicken starts")
			[ ] 
			[ ] WaitForState(EnterQuickenPassword, False , 120)
			[ ] 
			[ ] WaitForState(QuickenWindow, TRUE , 120)
			[ ] 
			[ ] 
			[ ] bResult = QuickenWindow.Exists () && QuickenWindow.IsActive ()
			[ ] 
			[+] if ( bResult )
				[ ] iResultStatus = 0
			[+] else
				[ ] iResultStatus = 1
			[ ] 
			[ ] ReportStatus("Startup Preferences ", iResultStatus, "Quicken Launched & Active after removing the password")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
	[+] except
		[ ] ExceptLog ()
		[+] if (Prefs.Exists ())
			[ ] Prefs.Cancel.Click ()
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
