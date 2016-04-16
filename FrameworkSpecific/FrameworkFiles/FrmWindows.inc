[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	Windows.INC
[+] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file contains the all AUT WINDOWs and dialog boxes 
	[ ] // declarations with UI elements inside WINDOWs.
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Bhagwat B. Kolde
	[ ] //					Software Test Automation Engineer
	[ ] //					Persistent
	[ ] //
	[ ] // PROJECT:			IV AND V COE
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 10/Oct/06	Bhagwat B. Kolde  Created
[ ] // *************************************************************************************
[ ] 
[ ] // ==========================================================
[+] // OBJECT NAMING CONVENSIONS
	[ ] // 1. HtmlPushButton/PushButton - pb
	[ ] // 2. HtmlLink					- lnk
	[ ] // 3. HtmlText/StaticText		- txt
	[ ] // 4. HtmlTable					- tab
	[ ] // 5. HtmlRadioList/RadioList	- rl
	[ ] // 6. HtmlTextField/TextField	- tf
[ ] // ==========================================================
[ ] 
[ ] 
[ ] // ==========================================================
[-] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[+] // APPLICATION SPECIFIC WINDOWS 
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[-] // GENERIC WINDOWS
	[+] // WINDOW DialogBox Print
		[ ] // tag "Print"
		[ ] // parent Browser
		[+] // DialogBox General
			[+] // multitag "General"
				[ ] // "$0"
			[+] // ListView SelectPrinter1
				[+] // multitag "Select Printer"
					[ ] // "$1"
			[+] // StaticText txtSelectPrinterText
				[+] // multitag "Select Printer"
					[ ] // "$1072"
			[+] // StaticText txtStatusText
				[+] // multitag "Status:"
					[ ] // "$1004"
			[+] // TextField tfStatus
				[+] // multitag "Status:"
					[ ] // "$1005"
			[+] // StaticText txtLocationText
				[+] // multitag "Location:"
					[ ] // "$1006"
			[+] // TextField tfLocation
				[+] // multitag "Location:"
					[ ] // "$1007"
			[+] // StaticText txtCommentText
				[+] // multitag "Comment:"
					[ ] // "$1008"
			[+] // TextField tfComment
				[+] // multitag "Comment:"
					[ ] // "$1009"
			[+] // CheckBox cbPrintToFile
				[+] // multitag "Print to file"
					[ ] // "$1002"
			[+] // PushButton pbPreferences
				[+] // multitag "Preferences"
					[ ] // "$1010"
			[+] // PushButton pbFindPrinter
				[+] // multitag "Find Printer"
					[ ] // "$1003"
			[+] // DialogBox SelectPrinter2
				[+] // multitag "Select Printer"
					[ ] // "$0"
				[+] // StaticText PageRange1Text
					[+] // multitag "Page Range[1]"
						[ ] // "$1072"
				[+] // RadioList PageRange3
					[+] // multitag "Page Range"
						[ ] // "$1056"
				[+] // TextField PageRange4
					[+] // multitag "Page Range"
						[ ] // "$1152"
				[+] // StaticText EnterEitherASinglePageNum
					[+] // multitag "Enter either a single page number or a single page range.  For example, 5-12"
						[ ] // "$1089"
				[+] // StaticText PageRange2Text
					[+] // multitag "Page Range[2]"
						[ ] // "$1073"
				[+] // StaticText NumberOfCopiesText
					[+] // multitag "Number of copies:"
						[ ] // "$1090"
				[+] // TextField NumberOfCopies1
					[+] // multitag "Number of copies:"
						[ ] // "$1153"
				[+] // CheckBox Collate
					[+] // multitag "Collate"
						[ ] // "$1040"
				[+] // CustomWin NumberOfCopies2
					[+] // msw multitag "[Icon]Number of copies:"
						[ ] // "[Icon]$1084"
				[+] // UpDown UpDown1
					[ ] // tag "$9999"
		[+] // PushButton pbPrint
			[+] // multitag "Print"
				[ ] // "$1"
		[+] // PushButton pbCancel
			[+] // multitag "Cancel"
				[ ] // "$2"
		[+] // PushButton pbApply 
			[+] // multitag "Apply"
				[ ] // "$12321"
		[ ] 
	[+] WINDOW DialogBox FileDownload
		[ ] tag "File Download"
		[ ] parent Browser
		[+] PushButton pbOpen
			[+] multitag "Open"
				[ ] "$4423"
		[+] PushButton pbSave
			[ ] tag "Save"
		[+] PushButton pbCancel
			[+] multitag "Cancel"
				[ ] "$2"
		[ ] 
	[+] WINDOW DialogBox 	 SaveAsFileDownload
		[ ] tag "File Download"
		[-] DialogBox SaveAs
			[ ] tag "Save As"
			[+] ComboBox cbFileName
				[ ] tag "File name:"
			[+] PopupList plSaveAsType
				[ ] tag "Save as type:"
			[+] PushButton pbSave
				[ ] tag "Save"
			[+] PushButton pbCancel
				[ ] tag "Cancel"
		[ ] 
	[+] WINDOW MainWin		 WinZip
		[+] multitag "WinZip*"
			[ ] "$C:\PROGRA~1\WINZIP\winzip32.exe"
		[+] property sCmdLine				// command line used to invoke the application
			[+] STRING Get()
				[ ] return ("C:\PROGRA~1\WINZIP\winzip32.exe ""{sDATA_BACKUP}""")
				[ ] 
		[+] Menu mnuFile
			[ ] tag "File"
			[+] MenuItem MenuItem1
				[ ] tag "$3"
			[+] MenuItem MenuItem2
				[ ] tag "$4"
			[+] MenuItem MenuItem3
				[ ] tag "$114"
			[+] MenuItem MenuItem4
				[ ] tag "$43"
			[+] MenuItem MenuItem5
				[ ] tag "$83"
			[+] MenuItem CreateShortcut
				[+] multitag "Create Shortcut"
					[ ] "$112"
			[+] MenuItem MoveArchive
				[+] multitag "Move Archive"
					[ ] "$85"
			[+] MenuItem CopyArchive
				[+] multitag "Copy Archive"
					[ ] "$87"
			[+] MenuItem RenameArchive
				[+] multitag "Rename Archive"
					[ ] "$88"
			[+] MenuItem DeleteArchive
				[+] multitag "Delete Archive"
					[ ] "$89"
			[+] MenuItem MenuItem11
				[ ] tag "$71"
			[+] MenuItem MenuItem12
				[ ] tag "$111"
			[+] MenuItem MenuItem13
				[ ] tag "$101"
			[+] MenuItem MenuItem14
				[ ] tag "$47"
			[+] MenuItem N1CDATAFILEZip
				[+] multitag "1 C:\...\DATAFILE.zip"
					[ ] "$158"
			[+] MenuItem N2CSASIxpDATAFILEZip
				[+] multitag "2 C:\SASIxp\DATAFILE.zip"
					[ ] "$159"
			[+] MenuItem N3CAutomationSasixpDATAFIL
				[+] multitag "3 C:\Automation\Sasixp\DATAFILE.zip"
					[ ] "$160"
			[+] MenuItem N4CLogClassZip
				[+] multitag "4 C:\...\logClass.zip"
					[ ] "$161"
		[+] Menu mnuActions
			[ ] tag "Actions"
			[+] MenuItem MenuItem1
				[ ] tag "$7"
			[+] MenuItem MenuItem2
				[ ] tag "$8"
			[+] MenuItem Extract
				[ ] tag "Extract"
			[+] MenuItem MenuItem4
				[ ] tag "$34"
			[+] MenuItem SelectAll
				[+] multitag "Select All"
					[ ] "$31"
			[+] MenuItem InvertSelection
				[+] multitag "Invert Selection"
					[ ] "$32"
			[+] MenuItem MenuItem7
				[ ] tag "$66"
			[+] MenuItem MenuItem8
				[ ] tag "$65"
			[+] MenuItem MenuItem9
				[ ] tag "$113"
			[+] MenuItem MenuItem10
				[ ] tag "$192"
			[+] MenuItem MenuItem11
				[ ] tag "$86"
			[+] MenuItem MenuItem12
				[ ] tag "$70"
			[+] MenuItem MenuItem13
				[ ] tag "$63"
			[+] MenuItem MenuItem14
				[ ] tag "$35"
		[+] Menu mnuOptions
			[ ] tag "Options"
			[+] MenuItem MenuItem1
				[ ] tag "$45"
			[+] MenuItem Password
				[+] multitag "Password"
					[ ] "$22"
			[+] Menu Sort
				[ ] tag "Sort"
				[+] MenuItem ByName
					[+] multitag "by Name"
						[ ] "$125"
				[+] MenuItem ByType
					[+] multitag "by Type"
						[ ] "$126"
				[+] MenuItem ByDate
					[+] multitag "by Date"
						[ ] "$127"
				[+] MenuItem BySize
					[+] multitag "by Size"
						[ ] "$128"
				[+] MenuItem ByCompressionRatio
					[+] multitag "by Compression Ratio"
						[ ] "$129"
				[+] MenuItem ByPackedSize
					[+] multitag "by Packed Size"
						[ ] "$130"
				[+] MenuItem ByCRC
					[+] multitag "by CRC"
						[ ] "$131"
				[+] MenuItem ByFileAttributes
					[+] multitag "by File Attributes"
						[ ] "$132"
				[+] MenuItem ByPath
					[+] multitag "by Path"
						[ ] "$133"
				[+] MenuItem ByOriginalOrder
					[+] multitag "by Original Order"
						[ ] "$134"
			[+] MenuItem ReuseWinZipWindows
				[+] multitag "Reuse WinZip Windows"
					[ ] "$76"
			[+] MenuItem SaveSettingsOnExit
				[+] multitag "Save Settings on Exit"
					[ ] "$84"
			[+] MenuItem SaveSettingsNow
				[+] multitag "Save Settings Now"
					[ ] "$20"
			[+] MenuItem SetInstallationDefaults
				[+] multitag "Set Installation Defaults"
					[ ] "$21"
			[+] MenuItem ViewLastOutput
				[+] multitag "View Last Output"
					[ ] "$29"
		[ ] 
		[+] BOOLEAN	ExtractData()
			[ ] // =========================================================
			[+] // METHOD NAME: ExtractData()
				[ ] // DESCRIPTION:
				[ ] //   This method used to extract data for .zip file.
				[ ] // 
				[ ] // PARAMETERS:		Boolean Success
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] boolean	bSuccess = FALSE
			[ ] integer	iErrCount = 0
			[ ] integer	iState
			[ ] string	sErrMsg
			[ ] string	sErrFile
			[ ] 
			[ ] this.Invoke()
			[+] if !this.Exists(2)
				[ ] Log.Error("WinZip failed to open.")
			[+] else
				[ ] this.SetActive ()
				[ ] this.Actions.Extract.Pick()
				[+] if !WinZipExtract.Exists(2)
					[ ] Log.Error("WinZip Extract dialog failed to open.")
				[+] else
					[ ] WinZipExtract.SetActive ()
					[ ] WinZipExtract.cbOverwriteExistingFiles.Check()
					[ ] WinZipExtract.cbExtractTo.SetText(sDATA_RESTORE)
					[ ] WinZipExtract.pbExtract.Click()
					[+] if WinZipProgress.Exists(3)
						[ ] Resume:
						[ ] iState = WaitFor1stWindow({{WinZipProgress, FALSE}, {WinZipError, TRUE}}, 180)
						[+] switch iState
							[+] case 0
								[+] if MessageBox.Exists()
									[ ] MessageBox.No.Click()
								[ ] this.Close()
							[+] case 1
								[+] if MessageBox.Exists()
									[ ] MessageBox.No.Click()
								[ ] this.Close()
								[ ] Log.Pass("Dashboard dataset successfully restored.")
								[ ] bSuccess = TRUE
							[+] case 2
								[+] if WinZipError.Exists()
									[ ] iErrCount++
									[ ] sErrMsg = WinZipError.txtMessage.GetText()
									[+] if ((StrPos ("bad crc", Lower(sErrMsg)) > 0) && (iErrCount < 3))
										[ ] sErrFile = WinZipProgress.txtExtracting.GetText()
										[ ] Log.Warning("Error while {sErrFile} - {sErrMsg}")
										[ ] WinZipError.Accept()
										[+] if WinZipError.Exists()
											[ ] WinZipError.pbYes.Click()
											[ ] goto Resume
									[+] else
										[ ] Log.Error("An error was encountered during extraction: {sErrMsg}")
										[ ] WinZipError.Accept()
										[+] if WinZipError.Exists()
											[ ] WinZipError.Dismiss()
									[+] if MessageBox.Exists()
										[ ] MessageBox.No.Click()
									[ ] this.Close()
					[+] else
						[ ] Log.Error("WinZip progress dialog failed to open.")
			[ ] 
			[ ] return bSuccess
			[ ] 
			[ ] 
		[ ] 
	[+] WINDOW DialogBox	 WinZipExtract
		[ ] tag "Extract|Extract - *" 
		[ ] parent WinZip
		[ ] 
		[+] ComboBox cbExtractTo
			[+] multitag "Extract to:"
				[ ] "$5013"
		[+] PushButton pbShowTheSpecifiedFolder
			[+] multitag "show the specified folder in the outline below"
				[ ] "$5015"
		[+] PushButton pbCreateAFolder
			[+] multitag "create a folder"
				[ ] "$4101"
		[+] CheckBox cbOverwriteExistingFiles
			[+] multitag "Overwrite existing files"
				[ ] "$5008"
		[+] CheckBox cbSkipOlderFiles
			[+] multitag "Skip older files"
				[ ] "$5018"
		[+] CheckBox cbUseFolderNames
			[+] multitag "Use folder names"
				[ ] "$5012"
		[+] CheckBox cbOpenExplorerWindow
			[+] multitag "Open Explorer WINDOW"
				[ ] "$11028"
		[+] PushButton pbExtract
			[+] multitag "Extract"
				[ ] "$1"
		[+] PushButton pbCancel
			[+] multitag "Cancel"
				[ ] "$2"
		[+] PushButton pbHelp
			[+] multitag "Help"
				[ ] "$1038"
		[ ] 
		[ ] 
	[+] WINDOW DialogBox	 WinZipProgress
		[ ] tag "WinZip"
		[ ] parent WinZip
		[ ] 
		[+] StaticText txtExtracting
			[+] multitag "Extracting *"
				[ ] "$100"
		[+] PushButton pbCancel
			[+] multitag "Cancel"
				[ ] "$2"
		[ ] 
		[ ] 
	[+] WINDOW DialogBox	 WinZipError
		[ ] tag "WinZip"
		[ ] parent WinZipProgress
		[ ] WINDOW	wDismissButton = pbNo
		[ ] 
		[+] PushButton pbOK
			[+] multitag "OK"
				[ ] "$2"
		[+] PushButton pbYes
			[+] multitag "Yes"
				[ ] "$6"
		[+] PushButton pbNo
			[+] multitag "No"
				[ ] "$7"
		[+] PushButton pbHelp
			[+] multitag "Help"
				[ ] "$9"
		[+] StaticText txtMessage
			[+] multitag "bad CRC *."
				[ ] "#1"
				[ ] "$65535"
		[ ] 
		[ ] 
	[+] // WINDOW MessageBoxClass MessageBox				
		[ ] // tag "~ActiveApp/[DialogBox]$MessageBox"
		[+] // PushButton pbOK
			[ ] // tag "OK"
		[+] // PushButton pbCancel
			[ ] // tag "Cancel"
		[+] // PushButton pbYes
			[ ] // tag "Yes"
		[+] // PushButton pbNo
			[ ] // tag "No"
		[+] // StaticText txtMessage
			[ ] // tag "#1"
		[ ] // 
	[+] WINDOW DialogBox 	 LANSetting
		[ ] tag "Local Area Network (LAN) Settings"
		[ ] parent IE_Options
		[ ] 
		[+] CheckBox cbAutomaticallyDetectSettings
			[+] multitag "Automatically detect settings"
				[ ] "$1573"
		[+] CheckBox cbUseAutomaticConfigurationSc
			[+] multitag "Use automatic configuration script"
				[ ] "$1569"
		[+] CheckBox cbUseAProxyServerForYourLA
			[+] multitag "Use a proxy server for your LAN (These settings will not apply to dial-up or VPN connections)."
				[ ] "$1570"
		[+] TextField tfAddress
			[+] multitag "Address:"
				[ ] "$1460"
		[+] TextField tfPort
			[+] multitag "Port:"
				[ ] "$1461"
		[+] PushButton pbAdvanced
			[+] multitag "Advanced"
				[ ] "$1555"
		[+] CheckBox cbBypassProxyServerForLocal
			[+] multitag "Bypass proxy server for local addresses"
				[ ] "$1119"
		[+] PushButton pbOK
			[+] multitag "OK"
				[ ] "$1"
		[+] PushButton pbCancel
			[+] multitag "Cancel"
				[ ] "$2"
		[ ] 
	[+] WINDOW OpenDlg SysOpen
		[ ] tag "~ActiveApp/Open"
	[+] WINDOW SaveAsDlg SysSaveAs
		[ ] tag "~ActiveApp/Save As"
	[+] WINDOW  DialogBox TaskManager
		[ ] tag "Windows Task Manager"
		[ ] 
		[ ] const sCmdLine 	= "{GetSystemPath ()}taskmgr.exe"
		[ ] 
		[+] Menu File
			[ ] tag "File"
			[+] MenuItem NewTaskRun
				[ ] tag "New Task (Run..)"
			[+] MenuItem ExitTaskManager
				[ ] tag "Exit Task Manager"
		[+] Menu Options
			[ ] tag "Options"
			[+] MenuItem AlwaysOnTop
				[ ] tag "Always On Top"
			[+] MenuItem MinimizeOnUse
				[ ] tag "Minimize On Use"
			[+] MenuItem Confirmations
				[ ] tag "Confirmations"
			[+] MenuItem HideWhenMinimized
				[ ] tag "Hide When Minimized"
			[+] MenuItem Show16BitTasks
				[ ] tag "Show 16-bit tasks"
		[+] Menu View
			[ ] tag "View"
			[+] MenuItem RefreshNow
				[ ] tag "Refresh Now"
			[+] Menu UpdateSpeed
				[ ] tag "Update Speed"
				[+] MenuItem High
					[ ] tag "High"
				[+] MenuItem MenuItem2
					[ ] tag "#2"
				[+] MenuItem Low
					[ ] tag "Low"
				[+] MenuItem Paused
					[ ] tag "Paused"
			[+] MenuItem SelectColumns
				[ ] tag "Select Columns"
			[+] MenuItem LargeIcons
				[ ] tag "Large Icons"
			[+] MenuItem SmallIcons
				[ ] tag "Small Icons"
			[+] MenuItem MenuItem5
				[ ] tag "#5"
		[+] Menu Windows
			[ ] tag "Windows"
			[+] MenuItem TileHorizontally
				[ ] tag "Tile Horizontally"
			[+] MenuItem TileVertically
				[ ] tag "Tile Vertically"
			[+] MenuItem Minimize
				[ ] tag "Minimize"
			[+] MenuItem Maximize
				[ ] tag "Maximize"
			[+] MenuItem Cascade
				[ ] tag "Cascade"
			[+] MenuItem BringToFront
				[ ] tag "Bring To Front"
		[+] Menu Help
			[ ] tag "Help"
			[+] MenuItem TaskManagerHelpTopics
				[ ] tag "Task Manager Help Topics"
			[+] MenuItem AboutTaskManager
				[ ] tag "About Task Manager"
		[ ] 
		[+] DialogBox Processes
			[ ] tag "[DialogBox]$0/[ListView]#1/[Header]#1/[PushButton]Image Name/.."
			[+] ListView ProcessList
				[ ] tag "/../../[ListView]#1"
				[+] // Header ProcessHeader
					[ ] // tag "#1"
			[+] PushButton ImageName
				[ ] tag "Image Name"
			[+] PushButton PID
				[ ] tag "PID"
			[+] PushButton CPU
				[ ] tag "CPU"
			[+] PushButton CPUTime
				[ ] tag "CPU Time"
			[+] PushButton MemUsage
				[ ] tag "Mem Usage"
			[+] PushButton EndProcess
				[ ] tag "/../../[PushButton]End Process"
		[+] DialogBox Applications
			[ ] tag "[DialogBox]$0/[PushButton]Switch To/.."
			[+] ListView AppList
				[ ] tag "#1"
				[+] Header Header1
					[ ] tag "#1"
					[+] PushButton Task
						[ ] tag "Task"
					[+] PushButton Status
						[ ] tag "Status"
			[+] PushButton SwitchTo
				[ ] tag "Switch To"
			[+] PushButton EndTask
				[ ] tag "End Task"
			[+] PushButton NewTask
				[ ] tag "New Task"
		[+] DialogBox Performance
			[ ] tag "[DialogBox]$0/[StaticText]Handles/.."
			[+] PushButton OD3
				[ ] tag "OD[3]"
			[+] PushButton OD2
				[ ] tag "OD[2]"
			[+] PushButton OD1
				[ ] tag "OD[1]"
			[+] PushButton OD4
				[ ] tag "OD[4]"
			[+] StaticText HandlesText
				[ ] tag "Handles"
			[+] StaticText ThreadsText
				[ ] tag "Threads"
			[+] StaticText ProcessesText
				[ ] tag "Processes"
			[+] StaticText N2664Text
				[ ] tag "2664"
			[+] StaticText N191Text
				[ ] tag "191"
			[+] StaticText N30Text
				[ ] tag "30"
			[+] StaticText Total1Text
				[ ] tag "Total[1]"
			[+] StaticText AvailableText
				[ ] tag "Available"
			[+] StaticText FileCacheText
				[ ] tag "File Cache"
			[+] StaticText N130480Text
				[ ] tag "130480"
			[+] StaticText N68936Text
				[ ] tag "68936"
			[+] StaticText N23344Text
				[ ] tag "23344"
			[+] StaticText Total2Text
				[ ] tag "Total[2]"
			[+] StaticText LimitText
				[ ] tag "Limit"
			[+] StaticText PeakText
				[ ] tag "Peak"
			[+] StaticText N96528Text
				[ ] tag "96528"
			[+] StaticText N297128Text
				[ ] tag "297128"
			[+] StaticText N105844Text
				[ ] tag "105844"
			[+] StaticText Total3Text
				[ ] tag "Total[3]"
			[+] StaticText PagedText
				[ ] tag "Paged"
			[+] StaticText NonpagedText
				[ ] tag "Nonpaged"
			[+] StaticText N25728Text
				[ ] tag "25728"
			[+] StaticText N22132Text
				[ ] tag "22132"
			[+] StaticText N3596Text
				[ ] tag "3596"
			[+] CustomWin CPUUsageHistory
				[ ] msw tag "[DavesFrameClass]CPU Usage History"
			[+] PushButton OD5
				[ ] tag "OD[5]"
			[+] CustomWin CPUUsage
				[ ] msw tag "[DavesFrameClass]CPU Usage"
			[+] CustomWin MEMUsage
				[ ] msw tag "[DavesFrameClass]MEM Usage"
			[+] CustomWin MemoryUsageHistory
				[ ] msw tag "[DavesFrameClass]Memory Usage History"
			[+] CustomWin PhysicalMemoryK
				[ ] msw tag "[DavesFrameClass]Physical Memory (K)"
			[+] CustomWin CommitChargeK
				[ ] msw tag "[DavesFrameClass]Commit Charge (K)"
			[+] CustomWin KernelMemoryK
				[ ] msw tag "[DavesFrameClass]Kernel Memory (K)"
			[+] CustomWin Totals
				[ ] msw tag "[DavesFrameClass]Totals"
		[ ] 
		[+] PageList PageList
			[ ] tag "#1"
		[+] StatusBar StatusBar
			[ ] tag "#1"
			[+] DynamicText DynamicText1
				[ ] tag "#1"
			[+] DynamicText DynamicText2
				[ ] tag "#2"
			[+] DynamicText DynamicText3
				[ ] tag "#3"
		[ ] 
		[+] Invoke ()
			[+] if TaskManager.Exists () == false
				[ ] App_Start ("{GetSystemPath ()}taskmgr.exe")
			[ ] 
			[+] if TaskManager.GetState () == WS_MINIMIZED
				[ ] TaskManager.Restore ()
			[ ] 
			[ ] TaskManager.SetActive ()
			[ ] 
		[ ] 
		[+] Dismiss ()
			[+] if TaskManager.Exists ()
				[+] if TaskManager.GetState () == WS_MINIMIZED
					[ ] TaskManager.Restore ()
				[ ] 
				[ ] TaskManager.SetActive ()
				[ ] TaskManager.Close ()
				[ ] 
			[ ] 
		[ ] 
		[+] InvokeProcesses ()
			[ ] Invoke ()
			[ ] 
			[ ] TaskManager.PageList.Select ("Processes")
			[ ] 
		[ ] 
		[+] InvokeApplications ()
			[ ] Invoke ()
			[ ] TaskManager.PageList.Select ("Applications")
			[ ] 
		[ ] 
		[+] InvokePerformance ()
			[ ] Invoke ()
			[ ] TaskManager.PageList.Select ("Performance")
			[ ] 
		[ ] 
		[ ] 
		[+] boolean ProcessKill (string sProcess)
			[ ] 
			[ ] // *** Local Variables ***
			[ ] integer iIndex = 1
			[ ] integer iProcesses
			[ ] boolean bFoundIt = false
			[ ] 
			[ ] InvokeProcesses ()
			[ ] 
			[ ] iProcesses = Processes.ProcessList.GetItemCount ()
			[ ] 
			[ ] 
			[+] while iIndex <= iProcesses
				[+] if MatchStr (lower (sProcess), lower (StringParse(Processes.ProcessList.GetItemText (iIndex), ";", 1)))
					[ ] bFoundIt = true
					[ ] 
					[ ] Processes.ProcessList.Select (iIndex)
					[ ] Processes.EndProcess.Click ()
					[ ] 
					[+] if TaskManagerWarning.Exists ()
						[ ] TaskManagerWarning.Yes.Click ()
						[ ] 
					[ ] Sleep (2)						// wait until process is killed
					[ ] 
					[+] if DialogBox("[DialogBox]Windows NT Task Manager/[DialogBox]Unable to Terminate Process").Exists ()
						[ ] 
						[ ] DialogBox("[DialogBox]Windows NT Task Manager/[DialogBox]Unable to Terminate Process").PushButton("OK").Click ()
						[ ] 
					[ ] 
					[ ] TaskManager.SetActive ()
					[ ] iProcesses = iProcesses - 1
					[ ] 
				[+] else
					[ ] iIndex = iIndex + 1
					[ ] 
			[ ] 
			[ ] Dismiss ()
			[ ] 
			[+] if bFoundIt
				[ ] return true
				[ ] 
			[+] else
				[ ] return false
				[ ] 
			[ ] 
		[ ] 
		[+] integer ProcessIsAlive (string sProcess)
			[ ] // *** Local Variables ***
			[ ] integer iIndex = 1
			[ ] integer iProcesses
			[ ] integer iOccurance = 0
			[ ] 
			[ ] InvokeProcesses ()
			[ ] 
			[ ] iProcesses = Processes.ProcessList.GetItemCount ()
			[ ] 
			[+] while iIndex <= iProcesses
				[ ] 
				[+] if MatchStr (lower (sProcess), lower (StringParse(Processes.ProcessList.GetItemText (iIndex), ";", 1)))
					[ ] 
					[ ] iOccurance++
					[ ] 
				[ ] iIndex = iIndex + 1
				[ ] 
			[ ] 
			[ ] Dismiss ()
			[ ] 
			[ ] return iOccurance
			[ ] 
		[ ] 
		[+] list of string GetApplications ()
			[+] // DESCRIPTION
				[ ] // returns the list of applications running on a system
			[ ] 
			[ ] // Local vars
			[ ] string sApp
			[ ] list of string lsApps
			[ ] list of string lsList
			[ ] 
			[ ] InvokeApplications ()
			[ ] 
			[ ] lsList = TaskManager.Applications.AppList.GetContents ()
			[ ] 
			[+] for each sApp in lsList
				[ ] 
				[ ] ListAppend (lsApps, GetField (sApp, ";", 1))
				[ ] 
			[ ] 
			[ ] Dismiss ()
			[ ] 
			[ ] return lsApps
			[ ] 
		[ ] 
	[+] WINDOW  DialogBox TaskManagerWarning
		[ ] tag "Task Manager Warning"
		[ ] parent TaskManager
		[ ] 
		[+] PushButton Yes
			[ ] tag "Yes"
		[+] PushButton No
			[ ] tag "No"
		[+] CustomWin Icon1
			[ ] msw tag "[Icon]#1"
		[+] StaticText Message1
			[ ] tag "WARNING: Terminating a process can cause undesired?results including loss of data and system instability.  The?process will no*"
		[ ] 
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] // *************************************************************************************
[ ] //	END OF INCLUDE FILE
[ ] // *************************************************************************************
[ ] 
