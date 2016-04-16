[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	Includes.INC
[-] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file used to include all framework files together for 
	[ ] // 	 declaration sharing.
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
[-] 
	[ ] STRING sFeature  //Feature, 
	[ ] STRING sTCId //TCId, 
	[ ] STRING sTCDesc  //TCDesc, 
	[ ] STRING sTestData  //TestData, 
	[ ] STRING sTDDesc  //TDDesc, 
	[ ] STRING sPriority  //Priority, 
	[ ] STRING sResult  //Result, 
	[ ] STRING sLastRun  //LastRun, 
	[ ] STRING sBmpFilePath  //BmpFilePath,
	[ ] LIST OF STRING lsData //Data
	[ ] String resultupdateDSN= "DSN=MS Access Database;DBQ=D:\Quicken\ApplicationSpecific\Data\TestData\TestDB.mdb;UID=;PWD=;"
[ ] 
[ ] // ==========================================================
[-] // FRAMEWORK FILES INCLUDED
	[ ] use "Globals.inc"
	[ ] use "Classes.inc"
	[ ] use "Config.inc"
	[ ] use "FrmWindows.inc"
	[ ] use "DataLib.inc"
	[ ] use "FileLib.inc"
	[ ] use "RecoveryLib.inc"
	[ ] use "SystemLib.inc"
	[ ] use "UtilityLib.inc"
	[ ] use "VerifyLib.inc"
	[ ] use 'msw32.inc'								
	[ ] use 'bwcompat.inc'
	[ ] use "datadrivetc.inc"
	[ ] use "DatabaseLib.inc"
	[ ] use "genlib.inc"
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[ ] // ==========================================================
[-] // APPLICATION FILES INCLUDED 
	[ ] use "..\..\ApplicationSpecific\includes\AppFrame.inc"
	[ ] use "..\..\ApplicationSpecific\includes\Install.inc"
	[ ] use "..\..\ApplicationSpecific\includes\QwTools.inc"
	[ ] use "..\..\ApplicationSpecific\includes\QuickenGlobals.inc"
	[ ] use "..\..\ApplicationSpecific\includes\QuickenConfig.inc"
	[ ] use "..\..\ApplicationSpecific\includes\QuickenGenLib.inc" 
	[ ] use "..\..\ApplicationSpecific\includes\QuickenToolsLib.inc"
	[ ] use "..\..\ApplicationSpecific\includes\QuickenSkuOSLayer.inc"
	[ ] use "..\..\ApplicationSpecific\includes\AutolabResultsUpload.inc"
[ ] // ==========================================================
[ ] 
[ ] 
[ ] // *************************************************************************************
[ ] //	END OF INCLUDE FILE
[ ] // *************************************************************************************
