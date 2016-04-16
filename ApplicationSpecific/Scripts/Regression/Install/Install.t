[ ] // *********************************************************
[+] // FILE NAME:	<Install.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains Install test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //
	[ ] // Developed on: 		06/07/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 July 06, 2011	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] //############# Install SetUp ###################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 InstallSetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will copy Setup.ini from source dir to c:\. It will setup the necessary pre-requisite for Install suite
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 25, 2011		Udita Dube	added
	[ ] // ********************************************************
	[ ] 
[+] testcase InstallSetUp () appstate none
	[+] // Variable declaration
		[ ] BOOLEAN bActual
		[ ] HFILE hFile
		[ ] STRING sSource, sLatest, sLine, sProductId ="" 
		[ ] // Get latset build no.
		[ ] sLatest = GetLatestBuild()									
		[ ] sSource = INSTALL_BUILD_PATH + "\" + sLatest + "\{SKU_TOBE_TESTED}\DISK1\Setup.ini"
		[ ] 
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] // Check if Quicken is installed on Machine or Not
	[ ] bActual = Check_Quicken_Existing ()
	[+] if( bActual == TRUE)
		[+] if (FileExists(sSetUpDestPath) == TRUE)
			[ ] DeleteFile(sSetUpDestPath)
		[ ] CopyFile(sSource, sSetUpDestPath) 						// copy Setup.ini from source dir to c:\
		[ ] 
		[ ] hFile = FileOpen (sSetUpDestPath, FM_READ) 
		[ ] FileReadLine (hFile, sLine)
		[ ] 
		[+] while(FileReadLine (hFile, sLine))
				[+] if (MatchStr ("*ProductCode*", sLine)) 
					[ ] sProductId = SubStr(sLine,13) 										// only the code of the product is returned
					[+] if (MatchStr ("*}*", sProductId) && (MatchStr ("*"{*", sProductId)) && (sProductId != "") )
						[ ] SYS_Execute("msiexec.exe /X"+ sProductId+ " /Q")				// Command for uninstalling Quicken
		[ ] FileClose (hFile)
		[ ] 
	[+] else
		[ ] // Do nothing as Quicken is already uninstalled
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Quicken Installation  ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_InstallQuickenByWizard()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will install Quicken using Wizard
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Quicken installed successfully						
		[ ] // 							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY: 	06/07/2011  	Created By	Udita Dube
		[ ] // 
	[ ] // ********************************************************
[-] testcase Test01_InstallQuickenByWizard () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iInstall,iValidate
	[ ] 
	[ ] // If Quicken is not installed then install Quicken
	[-] if (Check_Quicken_Existing () == FALSE)
		[ ] 
		[ ] 
		[ ] // Install Quicken by Wizard
		[ ] iInstall = Quicken_Install()
		[-] if(iInstall ==PASS)
			[ ] ReportStatus("Validate Quicken Installation through Wizard ", PASS, "Quicken installation is done successfully")
			[ ] 
		[-] else
			[ ] ReportStatus("Validate Quicken Installation through Wizard ", FAIL, "Quicken installation is not done")
			[ ] 
		[ ] 
		[ ] // Validate Quicken Installation
		[ ] iValidate=Quicken_Install_Validate(SKU_TOBE_TESTED)
		[ ] ReportStatus("Validate Quicken Installation", iValidate, "Quicken installation is validated")
		[ ] 
	[ ] // Report Status if Quicken is already installed
	[+] else
		[ ] ReportStatus("Validate Quicken Installation", FAIL, "Quicken is already installed") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Quicken Uninstallation  ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_UninstallQuicken()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will install Quicken using Wizard
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Quicken installed successfully						
		[ ] // 							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY: 	06/07/2011  	Created By	Udita Dube
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test02_UninstallQuicken() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iInstall,iValidate
	[ ] 
	[ ] // If Quicken is not installed then install Quicken
	[+] if (Check_Quicken_Existing () == TRUE)
		[ ] 
		[ ] 
		[ ] // Install Quicken by Wizard
		[ ] iInstall = Quicken_Uninstall()
		[+] if(iInstall ==PASS)
			[ ] ReportStatus("Validate Quicken uninstallation", PASS, "Quicken uninstallation is done successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken uninstallation", FAIL, "Quicken uninstallation is not done")
			[ ] 
		[ ] 
		[ ] // Validate Quicken Installation
		[ ] iValidate=Quicken_Uninstall_Validate(SKU_TOBE_TESTED)
		[ ] ReportStatus("Validate Quicken Uninstallation", iValidate, "Quicken Uninstallation is validated")
		[ ] 
	[ ] // Report Status if Quicken is not already installed
	[+] else
		[ ] ReportStatus("Validate Quicken Installation", FAIL, "Quicken is not already installed") 
		[ ] 
	[ ] 
[ ] //############################################################################
