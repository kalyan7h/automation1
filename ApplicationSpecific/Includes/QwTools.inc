[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<QwTools.INC>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This file contains all GUI declarations for different tools used by Quicken Automation (e.g. qwauto, intuonl etc)
	[ ] //
	[ ] // DEPENDENCIES:	None
	[ ] //
	[ ] // DEVELOPED BY:	Mamta Jain
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 06/Dec/10 Mamta Jain	Created
	[ ] 
[ ] // *********************************************************
[ ] 
[ ] // GUI Declarations for qwauto Tool
[+] window MainWin QuickenAutomationInterface
	[ ] locator "Quicken Automation Interface"
	[-] PushButton Exit
		[ ] locator "@windowid='2'"
	[-] TextField CommandString
		[ ] locator "@windowid='1000'"
	[-] TextField CommandOutput
		[ ] locator "@windowid='1001'"
	[-] PushButton ProcessCommand
		[ ] locator "@windowid='1'"
	[-] PushButton Help
		[ ] locator "@windowid='1008'"
	[ ] 
[ ] // GUI Declarations for intuonl Tool
[+] window FileDlg Intuonl
	[ ] tag "intuonl"
	[+] CheckBox UseLocalfileTool
		[+] multitag "Use localfile tool"
			[ ] "$1001"
	[+] PushButton Add
		[+] multitag "Add"
			[ ] "$1036"
	[+] PushButton Edit
		[+] multitag "Edit"
			[ ] "$1037"
	[+] PushButton Remove
		[+] multitag "Remove"
			[ ] "$1038"
	[+] CheckBox CreateOFXSEND
		[+] multitag "Create OFXSEND"
			[ ] "$1006"
	[+] CheckBox ConnlogLevel100
		[+] multitag "Connlog level 100"
			[ ] "$1008"
	[+] CheckBox OLCLocalfileButton
		[+] multitag "OLC localfile button"
			[ ] "$1007"
	[+] CheckBox DonTPromoteQBP
		[+] multitag "Don't promote QBP"
			[ ] "$1032"
	[+] CheckBox ShowSignonPIN
		[+] multitag "Show Signon PIN"
			[ ] "$1034"
	[+] CheckBox ForceErrRecovery
		[+] multitag "Force Err Recovery"
			[ ] "$1009"
	[+] ComboBox ConnectionAndRequests1
		[-] multitag "Connection and Requests[1]"
			[ ] "$1012"
	[+] ComboBox ConnectionAndRequests2
		[+] multitag "Connection and Requests[2]"
			[ ] "$1035"
	[+] CheckBox SignonVersion
		[-] multitag "Signon version"
			[ ] "$1010"
	[+] CheckBox AnonymousSignon
		[+] multitag "Anonymous signon"
			[ ] "$1016"
	[+] CheckBox SkipSecureURL
		[+] multitag "Skip Secure URL"
			[ ] "$1017"
	[+] CheckBox SkipLogSession
		[+] multitag "Skip Log Session"
			[ ] "$1020"
	[+] CheckBox SkipSyncWrapper
		[+] multitag "Skip Sync Wrapper"
			[ ] "$1019"
	[+] CheckBox SkipSyncSession
		[+] multitag "Skip Sync Session"
			[ ] "$1018"
	[+] CheckBox DisableGoodFunds
		[+] multitag "Disable Good Funds"
			[ ] "$1015"
	[+] CheckBox NoACCTINFO
		[+] multitag "No ACCTINFO"
			[ ] "$1021"
	[+] CheckBox BrandingEnv
		[+] multitag "Branding Env"
			[ ] "$1013"
	[+] TextField BrandingAndProfile11
		[+] multitag "Branding and Profile[1]"
			[ ] "$1014"
	[+] CheckBox UpdateBranding
		[+] multitag "Update Branding"
			[ ] "$1022"
	[+] RadioList BrandingAndProfile21
		[+] multitag "Branding and Profile[2]"
			[ ] "$1023"
	[+] RadioList BrandingAndProfile31
		[+] multitag "Branding and Profile[3]"
			[ ] "$1024"
	[+] RadioList BrandingAndProfile12
		[+] multitag "Branding and Profile[1]"
			[ ] "$1025"
	[+] TextField BrandingAndProfile22
		[+] multitag "Branding and Profile[2]"
			[ ] "$1026"
	[+] CheckBox UpdateProfile
		[+] multitag "Update Profile"
			[ ] "$1027"
	[+] TextField BrandingAndProfile32
		[+] multitag "Branding and Profile[3]"
			[ ] "$1031"
	[+] PushButton OK
		[+] multitag "OK"
			[ ] "$1"
	[+] PushButton Apply
		[+] multitag "Apply"
			[ ] "$3"
	[+] PushButton Help
		[+] multitag "Help"
			[ ] "$9"
	[+] PushButton Cancel
		[+] multitag "Cancel"
			[ ] "$2"
	[+] StaticText Days1Text
		[+] multitag "days[1]"
			[ ] "$-1[5]"
	[+] StaticText Days2Text
		[+] multitag "days[2]"
			[ ] "$-1[6]"
	[+] StaticText LocalFileToolRECVFileDia1
		[+] multitag "Local File Tool (RECV file dialog)"
			[ ] "$-1[1]"
	[+] StaticText LoggingFilesAndOLCText
		[+] multitag "Logging files and OLC"
			[ ] "$-1[2]"
	[+] StaticText ConnectionAndRequestsText
		[+] multitag "Connection and Requests"
			[ ] "$-1[3]"
	[+] StaticText BrandingAndProfileText
		[+] multitag "Branding and Profile"
			[ ] "$-1[4]"
	[+] ListBox LocalFileToolRECVFileDia2
		[+] multitag "Local File Tool (RECV file dialog)"
			[ ] "$1033"
	[ ] 
[ ] 
