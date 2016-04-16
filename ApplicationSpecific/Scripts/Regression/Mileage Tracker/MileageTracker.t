[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<MileageTracker.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all MileageTracker test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  KalyanG
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Feb 17, 2015	KalyanG  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[+] // Global variables 
	[ ] 
	[ ] 
	[ ] //--------------EXCEL DATA----------------
	[ ] // .xls file
	[ ] public STRING sMileageTrackerDataExcel="MileageTracker_TestData"
	[ ] 
	[ ] 
	[ ] //----------DATA FILES -------------------
	[ ] public STRING sMileageTrackerDataFile = AUT_DATAFILE_PATH + "\" + sMileageTrackerDataExcel + ".QDF"
	[ ] public STRING sMileageTrackerWorksheet = "MileageTracker"
	[ ] 
[ ] 
[+] //Local Functions
	[ ] 
	[+] public void SetVehicleMileage (VehicleMileage_Record REC_VehicleMileage)
		[ ] 
		[+] if (REC_VehicleMileage.sStartDateInMDDYYYY != NULL)
			[ ] DlgVehicleMileage.TripDatesTextField.SetText(REC_VehicleMileage.sStartDateInMDDYYYY)
		[+] if (REC_VehicleMileage.sEndDateInMDDYYYY != NULL)
			[ ] DlgVehicleMileage.ToDateTextField.SetText(REC_VehicleMileage.sEndDateInMDDYYYY)
		[-] if (REC_VehicleMileage.sTripType != NULL)
			[ ] DlgVehicleMileage.TripTypePopupList.Select(REC_VehicleMileage.sTripType)
		[-] if (REC_VehicleMileage.sBusiness != NULL)
			[ ] //DlgVehicleMileage.BusinessNamePopupList.SetText(REC_VehicleMileage.sBusiness)
			[ ] DlgVehicleMileage.BusinessNamePopupList.Select(REC_VehicleMileage.sBusiness)
		[+] if (REC_VehicleMileage.sPurpose != NULL)
			[ ] DlgVehicleMileage.PurposeTextField.SetText(REC_VehicleMileage.sPurpose)
		[+] if (REC_VehicleMileage.sStart != NULL)
			[ ] DlgVehicleMileage.StartLocationTextField.SetText(REC_VehicleMileage.sStart)
		[+] if (REC_VehicleMileage.sDestination != NULL)
			[ ] DlgVehicleMileage.DestinationTextField.SetText(REC_VehicleMileage.sDestination)
			[ ] 
		[+] if (REC_VehicleMileage.sVehicleUsed != NULL)
			[ ] DlgVehicleMileage.VehicleUsedTextField.SetText(REC_VehicleMileage.sVehicleUsed)
		[+] if (REC_VehicleMileage.sParkingAndToll != NULL)
			[ ] DlgVehicleMileage.ParkingAndTollTextField.SetText(REC_VehicleMileage.sParkingAndToll)
			[ ] 
		[+] if (REC_VehicleMileage.sOdometerAtStart != NULL)
			[ ] DlgVehicleMileage.OdometerAtStartTextField.SetText(REC_VehicleMileage.sOdometerAtStart)
		[+] if (REC_VehicleMileage.sOdometerAtEnd != NULL)
			[ ] DlgVehicleMileage.OdometerAtEndTextField.SetText(REC_VehicleMileage.sOdometerAtEnd)
		[-] if (REC_VehicleMileage.sMilesTravelled != NULL)
			[ ] DlgVehicleMileage.MilesTraveledTextField.SetText(REC_VehicleMileage.sMilesTravelled)
		[ ] 
		[ ] 
	[+] public void DeleteAllMileageRecords()
		[ ] 
		[ ] STRING sWindowHandle
		[ ] INTEGER iRecCount,iCount 
		[ ] 
		[+] if (!  DlgVehicleMileage.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.MileageTracker.Click()
			[ ] sleep(2)
		[ ] 
		[ ] sWindowHandle = Str(DlgVehicleMileage.AllTripsForGrid.ListBox1.GetHandle())
		[ ] iRecCount = ListCount(DlgVehicleMileage.AllTripsForGrid.ListBox1.GetContents())-2
		[ ] 
		[-] for iCount = 0 to iRecCount
			[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW",sWindowHandle,str(0))
			[ ] DlgVehicleMileage.DeleteButton.Click()
			[ ] sleep(2)
			[+] if (VehicleMileageDeleteConfirmationDialog.Exists())
				[ ] VehicleMileageDeleteConfirmationDialog.OK.Click()
				[ ] sleep(1)
			[ ] 
		[ ] ReportStatus("All VehicleMileage records deleted successfully ", PASS, "CLEAN UP: All VehicleMileage records deleted successfully")
		[ ] 
	[+] public LIST OF STRING getAllRatesDisplayed(STRING sCommand, STRING sHandle)
		[ ] 
		[ ] INTEGER iStartToolStatus, iRecCount = listcount(MileageRates.listboxRates.GetContents()), iCount
		[ ] STRING sOutputString = ""
		[ ] LIST OF STRING lsRows
		[ ] 
		[ ] 
		[-] do
			[ ] SetUp_AutoApi()
			[ ] 
			[-] if ( StartQwAuto() == PASS )
				[-] for iCount = 0 to iRecCount-1
					[ ] QuickenAutomationInterface.CommandString.SetText ("{sCommand},  {sHandle}, {iCount}, """)
					[ ] QuickenAutomationInterface.ProcessCommand.Click()
					[ ] QuickenAutomationInterface.VerifyEnabled(TRUE,20)
					[ ] sOutputString = QuickenAutomationInterface.CommandOutput.GetText()
					[ ] ListAppend(lsRows,sOutputString)
					[ ] sleep(SHORT_SLEEP)
					[ ] sOutputString=""
				[ ] QuickenAutomationInterface.Close()
			[-] else
				[ ] ReportStatus("Invoke QWAUTO Tool", FAIL, "QWAUTO Tool is not launched") 
		[-] except
			[ ] raise 1, "ERROR: Command execution failed in Qw Auto" 
		[ ] 
		[ ] return lsRows
	[ ] 
[+] type VehicleMileage_Record is record
	[ ] STRING sStartDateInMDDYYYY
	[ ] STRING sEndDateInMDDYYYY
	[ ] STRING sTripType
	[ ] STRING sBusiness
	[ ] STRING sPurpose
	[ ] STRING sStart
	[ ] STRING sDestination
	[ ] STRING sVehicleUsed
	[ ] STRING sParkingAndToll
	[ ] STRING sOdometerAtStart
	[ ] STRING sOdometerAtEnd
	[ ] STRING sMilesTravelled
[ ] 
[+] testcase Test01_VerifySubMenuItemPresentUnderTheBusinessMenu()  appstate MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[+] else
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.Business.Click()
		[ ] bExists = QuickenWindow.Business.MileageTracker.Exists()
		[ ] 
		[+] if (! bExists)
			[ ] ReportStatus("MileageTracker sub menu under Business ", FAIL, "MileageTracker sub menu under Business does not exists")
		[+] else
			[ ] ReportStatus("MileageTracker sub menu under Business ", PASS, "MileageTracker sub menu exists under Business")
	[ ] 
[ ] 
[+] testcase Test02_VerifyMileageTrackerWindowGetdispalyed() appstate none //appstate MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[+] else
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.MileageTracker.Click()
		[ ] bExists = DlgVehicleMileage.Exists(5)
		[ ] 
		[+] if (! bExists)
			[ ] ReportStatus("MileageTracker Dialog ", FAIL, "MileageTracker dialog does not exists")
		[+] else
			[ ] DlgVehicleMileage.DoneButton.Click()
			[ ] ReportStatus("MileageTracker Dialog ", PASS, "MileageTracker dialog exists")
	[ ] 
[ ] 
[+] testcase Test03_VerifyAddedTripDataInTheGivenForm() appstate none //appstate MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText, sHandle, sActual
	[ ] LIST OF ANYTYPE lsVehicleMileage
	[ ] 
	[ ] lsVehicleMileage = ReadExcelTable(sMileageTrackerDataExcel, sMileageTrackerWorksheet)
	[+] VehicleMileage_Record REC_Mileage = {...}
		[ ] lsVehicleMileage[1][1]
		[ ] lsVehicleMileage[1][2]
		[ ] lsVehicleMileage[1][3]
		[ ] lsVehicleMileage[1][4]
		[ ] FormatDateTime (GetDateTime(), "hh:nn:ss")
		[ ] lsVehicleMileage[1][6]
		[ ] lsVehicleMileage[1][7]
		[ ] lsVehicleMileage[1][8]
		[ ] lsVehicleMileage[1][9]
		[ ] lsVehicleMileage[1][10]
		[ ] lsVehicleMileage[1][11]
		[ ] lsVehicleMileage[1][12]
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[+] else
		[ ] // clean up all the records
		[ ] DeleteAllMileageRecords()
		[ ] 
		[ ] // add a record
		[ ] SetVehicleMileage(REC_Mileage)
		[ ] DlgVehicleMileage.EnterTripButton.Click()
		[ ] 
		[ ] // verify the added record
		[ ] sHandle = Str(DlgVehicleMileage.AllTripsForGrid.ListBox1.GetHandle())
		[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETROW",sHandle,str(0))
		[ ] 
		[+] if MatchStr("*{REC_Mileage.sPurpose}*",sActual)
			[ ] ReportStatus("MileageTracker Dialog ", PASS, "MileageTracker record added successfully")
		[+] else
			[ ] ReportStatus("MileageTracker Dialog ", FAIL, "Failed to add MileageTracker record")
		[ ] DlgVehicleMileage.DoneButton.Click()
		[ ] sleep(1)
[ ] 
[+] testcase Test04_VerifyTheCustomizedButtonFunctionality() appstate none //appstate MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText, sHandle, sActual
	[ ] LIST OF ANYTYPE lsVehicleMileage
	[ ] 
	[ ] lsVehicleMileage = ReadExcelTable(sMileageTrackerDataExcel, sMileageTrackerWorksheet)
	[+] VehicleMileage_Record REC_Mileage = {...}
		[ ] lsVehicleMileage[1][1]
		[ ] lsVehicleMileage[1][2]
		[ ] lsVehicleMileage[1][3]
		[ ] lsVehicleMileage[1][4]
		[ ] FormatDateTime (GetDateTime(), "hh:nn:ss")
		[ ] lsVehicleMileage[1][6]
		[ ] lsVehicleMileage[1][7]
		[ ] lsVehicleMileage[1][8]
		[ ] lsVehicleMileage[1][9]
		[ ] lsVehicleMileage[1][10]
		[ ] lsVehicleMileage[1][11]
		[ ] lsVehicleMileage[1][12]
	[+] VehicleMileage_Record REC_Mileage2 = {...}
		[ ] lsVehicleMileage[2][1]
		[ ] lsVehicleMileage[2][2]
		[ ] lsVehicleMileage[2][3]
		[ ] lsVehicleMileage[2][4]
		[ ] FormatDateTime (GetDateTime(), "hh:nn:ss")
		[ ] lsVehicleMileage[2][6]
		[ ] lsVehicleMileage[2][7]
		[ ] lsVehicleMileage[2][8]
		[ ] lsVehicleMileage[2][9]
		[ ] lsVehicleMileage[2][10]
		[ ] lsVehicleMileage[2][11]
		[ ] lsVehicleMileage[2][12]
	[ ] 
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[+] else
		[ ] 
		[ ] // clean up all the records
		[ ] DeleteAllMileageRecords()
		[ ] 
		[ ] // add two records
		[ ] SetVehicleMileage(REC_Mileage)
		[ ] DlgVehicleMileage.EnterTripButton.Click()
		[ ] sleep(2)
		[ ] SetVehicleMileage(REC_Mileage2)
		[ ] DlgVehicleMileage.EnterTripButton.Click()
		[ ] sleep(2)
		[ ] 
		[ ] // customize
		[ ] DlgVehicleMileage.CustomizeButton.Click()
		[+] if ! CustomizeMileageList.Exists(5)
			[ ] ReportStatus("CustomizeMileageList Window", FAIL, "CustomizeMileageList is not available")
		[+] else
			[ ] ReportStatus("CustomizeMileageList Window", PASS, "CustomizeMileageList Exists")
			[ ] CustomizeMileageList.chkboxPurpose.Uncheck()
			[ ] CustomizeMileageList.ddlBusinessName.Select(REC_Mileage2.sBusiness)
			[ ] CustomizeMileageList.buttonOK.Click()
			[ ] WaitForState(CustomizeMileageList,FALSE,3)
			[ ] 
			[ ] 
			[ ] // verify the customization
			[ ] sHandle = Str(DlgVehicleMileage.AllTripsForGrid.ListBox1.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETROW",sHandle,str(0))
			[ ] 
			[+] if ! MatchStr("*{REC_Mileage.sPurpose}*",sActual)
				[ ] ReportStatus("Customization Dialog ", PASS, "On customization Purpose is unchecked and data reflected accordingly")
			[+] else
				[ ] ReportStatus("Customization Dialog ", FAIL, "On customization Purpose is unchecked and data not reflected accordingly")
			[ ] 
			[+] if MatchStr("*{REC_Mileage.sBusiness}*",sActual)
				[ ] ReportStatus("Customization Dialog ", PASS, "On customization selected Business as {REC_Mileage.sBusiness}, data reflected accordingly")
			[+] else
				[ ] ReportStatus("Customization Dialog ", PASS, "On customization selected Business as {REC_Mileage.sBusiness}, data not reflected accordingly")
			[ ] 
			[ ] // undo the customization
			[ ] DlgVehicleMileage.CustomizeButton.Click()
			[ ] WaitForState(CustomizeMileageList,TRUE,3)
			[ ] CustomizeMileageList.buttonReset.Click()
			[ ] CustomizeMileageList.buttonOK.Click()
			[ ] WaitForState(CustomizeMileageList,FALSE,3)
			[ ] DlgVehicleMileage.DoneButton.Click()
[ ] 
[+] testcase Test05_VerifyTheRatesButtonFunctionality()  appstate none //MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText, sHandle, sActual, sCurrentYear = FormatDateTime(GetDateTime(), "yyyy")
	[ ] LIST OF STRING lsActuals = {...}
	[ ] INTEGER iRecCount, iCount
	[+] LIST OF STRING lsCategories = <text>
		[ ] Business - Schedule C
		[ ] Charity - Schedule A
		[ ] Medical - Schedule A
		[ ] Rental Property - Schedule E
		[ ] Unreimbursed Business - Schedule A
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[-] else
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.MileageTracker.Click()
		[ ] 
		[+] if ! DlgVehicleMileage.Exists(2)
			[ ] ReportStatus("VehicleMileage Dialog ", FAIL, "VehicleMileage dialog does not exist")
		[ ] DlgVehicleMileage.RatesButton.Click()
		[ ] 
		[+] if ! MileageRates.Exists(2)
			[ ] ReportStatus("MileageRates Dialog ", FAIL, "MileageRates dialog does not exists")
		[-] else
			[ ] ReportStatus("MileageRates Dialog ", PASS, "MileageRates dialog exists")
			[ ] sHandle = Str(MileageRates.listboxRates.GetHandle())
			[ ] lsActuals = getAllRatesDisplayed("LISTBOX_GETROW", sHandle)
			[ ] 
			[ ] // verify all categories present or not
			[+] for iCount = 1 to ListCount(lsCategories)
				[+] if (ListFind (lsActuals, lsCategories[iCount]) > 0)
					[ ] ReportStatus("Rates Dialog ", PASS, "{lsCategories[iCount]} exists on rates dialog")
				[+] else
					[ ] ReportStatus("Rates Dialog ", FAIL, "{lsCategories[iCount]} does not exists on rates dialog")
			[ ] 
			[ ] // check if the rates are upto date
			[+] for iCount = 2 to 5
				[-] if (iCount <= 5)
					[+] if (MatchStr("*{sCurrentYear}*",lsActuals[ListFind(lsActuals, lsCategories[iCount])-1]))
						[ ] ReportStatus("Rates Dialog ", PASS, "{lsCategories[iCount-1]} rates are upto date, current year rate exists")
					[+] else
						[ ] ReportStatus("Rates Dialog ", FAIL, "{lsCategories[iCount-1]} rates are not upto date, current year rate does not exis")
			[+] if (MatchStr("*{sCurrentYear}*",lsActuals[ListCount(lsActuals)]))
				[ ] ReportStatus("Rates Dialog ", PASS, "{lsCategories[iCount]} rates are upto date, current year rate exist")
			[+] else
				[ ] ReportStatus("Rates Dialog ", FAIL, "{lsCategories[iCount]} rates are not upto date, current year rate does not exist")
			[ ] 
			[ ] MileageRates.buttonClose.Click()
			[ ] WaitForState(MileageRates,FALSE,3)
			[ ] DlgVehicleMileage.DoneButton.click()
			[ ] WaitForState(DlgVehicleMileage,FALSE,3)
		[ ] 
	[ ] 
[ ] 
[+] testcase Test06_VerifyTheEditButtonFunctionality() appstate none //appstate MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText, sHandle, sActual
	[ ] LIST OF ANYTYPE lsVehicleMileage
	[ ] 
	[ ] lsVehicleMileage = ReadExcelTable(sMileageTrackerDataExcel, sMileageTrackerWorksheet)
	[+] VehicleMileage_Record REC_Mileage = {...}
		[ ] lsVehicleMileage[1][1]
		[ ] lsVehicleMileage[1][2]
		[ ] lsVehicleMileage[1][3]
		[ ] lsVehicleMileage[1][4]
		[ ] FormatDateTime (GetDateTime(), "hh:nn:ss")
		[ ] lsVehicleMileage[1][6]
		[ ] lsVehicleMileage[1][7]
		[ ] lsVehicleMileage[1][8]
		[ ] lsVehicleMileage[1][9]
		[ ] lsVehicleMileage[1][10]
		[ ] lsVehicleMileage[1][11]
		[ ] lsVehicleMileage[1][12]
	[ ] VehicleMileage_Record REC_MileageEdit = {...}
	[ ] REC_MileageEdit.sPurpose = REC_Mileage.sPurpose+"edit"
	[ ] REC_MileageEdit.sStart = REC_Mileage.sStart+"edit"
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[+] else
		[ ] // clean up all the records
		[ ] DeleteAllMileageRecords()
		[ ] 
		[ ] // add a record
		[ ] SetVehicleMileage(REC_Mileage)
		[ ] DlgVehicleMileage.EnterTripButton.Click()
		[ ] 
		[ ] // verify the added record
		[ ] sHandle = Str(DlgVehicleMileage.AllTripsForGrid.ListBox1.GetHandle())
		[ ] sActual= QwAutoExecuteCommand("LISTBOX_SELECTROW",sHandle,str(0))
		[ ] DlgVehicleMileage.EditButton.Click()
		[ ] sleep(1)
		[ ] // edit the fields
		[ ] SetVehicleMileage(REC_MileageEdit)
		[ ] DlgVehicleMileage.SaveChangesButton.Click()
		[ ] sleep(1)
		[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETROW",sHandle,str(0))
		[ ] 
		[ ] // verify edited fields
		[+] if ! ( MatchStr("*{REC_MileageEdit.sPurpose}*",sActual) &&  MatchStr("*{REC_MileageEdit.sStart}*",sActual) )
			[ ] ReportStatus("DlgVehicleMileage ", FAIL, "Edited fields [purpose, start] did not reflect")
		[+] else
			[ ] ReportStatus("DlgVehicleMileage ", PASS, "Edited fields [purpose, start] reflect after saving the changes")
		[ ] 
		[ ] DlgVehicleMileage.DoneButton.Click()
		[ ] WaitForState(DlgVehicleMileage,FALSE,3)
[ ] 
[+] testcase Test07_VerifyTheDeleteButton() appstate none //appstate MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText, sHandle, sActual
	[ ] LIST OF ANYTYPE lsVehicleMileage
	[ ] 
	[ ] lsVehicleMileage = ReadExcelTable(sMileageTrackerDataExcel, sMileageTrackerWorksheet)
	[+] VehicleMileage_Record REC_Mileage = {...}
		[ ] lsVehicleMileage[1][1]
		[ ] lsVehicleMileage[1][2]
		[ ] lsVehicleMileage[1][3]
		[ ] lsVehicleMileage[1][4]
		[ ] FormatDateTime (GetDateTime(), "hh:nn:ss")
		[ ] lsVehicleMileage[1][6]
		[ ] lsVehicleMileage[1][7]
		[ ] lsVehicleMileage[1][8]
		[ ] lsVehicleMileage[1][9]
		[ ] lsVehicleMileage[1][10]
		[ ] lsVehicleMileage[1][11]
		[ ] lsVehicleMileage[1][12]
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[+] else
		[ ] 
		[ ] // clean up all the records
		[ ] DeleteAllMileageRecords()
		[ ] 
		[ ] // add a record
		[ ] SetVehicleMileage(REC_Mileage)
		[ ] DlgVehicleMileage.EnterTripButton.Click()
		[ ] 
		[ ] // verify the added record
		[ ] sHandle = Str(DlgVehicleMileage.AllTripsForGrid.ListBox1.GetHandle())
		[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETROW",sHandle,str(0))
		[ ] 
		[+] if MatchStr("*{REC_Mileage.sPurpose}*",sActual)
			[ ] ReportStatus("MileageTracker Dialog ", PASS, "MileageTracker record added successfully")
		[+] else
			[ ] ReportStatus("MileageTracker Dialog ", FAIL, "Failed to add MileageTracker record")
		[ ] 
		[ ] // delete the record
		[ ] DeleteAllMileageRecords()
		[ ] 
		[+] if (ListCount(DlgVehicleMileage.AllTripsForGrid.ListBox1.GetContents()) > 1)
			[ ] ReportStatus("MileageTracker Delete Button functionality ", FAIL, "Record is deleted but not reflected")
		[+] else
			[ ] ReportStatus("MileageTracker Delete Button functionality ", PASS, "DeleteButton on MileageTracker Verified")
		[ ] 
		[ ] DlgVehicleMileage.DoneButton.Click()
		[ ] WaitForState(DlgVehicleMileage,FALSE,3)
[ ] 
[+] testcase Test08_VerifyTheHelpIconButton() appstate none //appstate MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[+] else
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.MileageTracker.Click()
		[ ] bExists = DlgVehicleMileage.Exists(5)
		[ ] 
		[+] if (! bExists)
			[ ] ReportStatus("MileageTracker Dialog ", FAIL, "MileageTracker dialog does not exists")
		[+] else
			[ ] ReportStatus("MileageTracker Dialog ", PASS, "MileageTracker dialog exists")
			[ ] 
			[ ] DlgVehicleMileage.HelpButton.Click()
			[ ] 
			[+] if (QuickenHelp.Exists(5))
				[+] if (QuickenHelp.BrowserWindow.TrackingMileage.Exists())
					[ ] ReportStatus("MileageTracker Help Window ", PASS, "The Help got opened, showing Business>MileageTracker info")
				[+] else
					[ ] ReportStatus("MileageTracker Help Window ", FAIL, "The Help got opened, but did not show showing Business>MileageTracker info")
					[ ] 
			[+] else
					[ ] ReportStatus("MileageTracker Help Window ", FAIL, "MileageTracker Help Window did not appear after clicking help button")
			[ ] 
			[ ] QuickenHelp.Close()
			[ ] WaitForState(QuickenHelp,FALSE,3)
			[ ] DlgVehicleMileage.DoneButton.click()
			[ ] WaitForState(DlgVehicleMileage,FALSE,3)
[ ] 
[+] testcase Test09_VerifyThePrintButton() appstate none //appstate MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[+] else
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.MileageTracker.Click()
		[ ] bExists = DlgVehicleMileage.Exists(5)
		[ ] 
		[+] if (! bExists)
			[ ] ReportStatus("MileageTracker Dialog ", FAIL, "MileageTracker dialog does not exists")
		[+] else
			[ ] ReportStatus("MileageTracker Dialog ", PASS, "MileageTracker dialog exists")
			[ ] DlgVehicleMileage.PrintButton.Click()
			[+] if (DlgPrint.Exists(5))
				[ ] DlgPrint.PreviewButton.Click()
				[+] if (DlgPrintPreview.Exists(2))
					[ ] ReportStatus("MileageTracker Print Window ", PASS, "Print Preview dialog got opened")
				[+] else
					[ ] ReportStatus("MileageTracker Print Window ", FAIL, "Print dialog got opened, but Print Preview dialog did not open after clicking preview button")
			[+] else
					[ ] ReportStatus("DlgPrint Window ", FAIL, "DlgPrint Window did not appear after clicking print button")
			[ ] 
			[ ] DlgPrintPreview.Close()
			[ ] WaitForState(DlgPrintPreview,FALSE,3)
			[ ] DlgVehicleMileage.DoneButton.click()
			[ ] WaitForState(DlgVehicleMileage,FALSE,3)
[ ] 
[+] testcase Test10_VerifyTheProperMapIsGettingDisplayed() appstate none //appstate MileageTracker
	[ ] 
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.Business.Click()
	[ ] QuickenWindow.Business.MileageTracker.Click()
	[ ] bExists = DlgVehicleMileage.Exists(5)
	[ ] 
	[+] if (! bExists)
		[ ] ReportStatus("MileageTracker Dialog ", FAIL, "MileageTracker dialog not exist")
	[+] else
		[ ] ReportStatus("MileageTracker Dialog ", PASS, "MileageTracker dialog exists")
		[ ] DlgVehicleMileage.linkNotSureHowFarItWas.Click()
		[ ] sleep(1)
		[ ] 
		[-] if ( InternetExplorer.BrowserWindow.textMapQuest.Exists(20))
			[ ] ReportStatus("MapQuest in IE ", PASS, "MapQuest invoked in the internet explorer browser")
			[ ] InternetExplorer.Close()
			[ ] WaitForState(InternetExplorer,FALSE,3)
		[+] else
			[ ] ReportStatus("MapQuest in IE ", FAIL, "MapQuest not invoked in the internet explorer browser")
		[ ] DlgVehicleMileage.DoneButton.click()
		[ ] WaitForState(DlgVehicleMileage,FALSE,3)
[ ] 
[+] testcase Test11_VerifyTheEnteredTripDataIsTrackedInReports() appstate none //appstate MileageTracker
	[ ] 
	[ ] BOOLEAN bExists
	[ ] STRING sText, sHandle, sActual
	[ ] LIST OF ANYTYPE lsVehicleMileage
	[ ] 
	[ ] lsVehicleMileage = ReadExcelTable(sMileageTrackerDataExcel, sMileageTrackerWorksheet)
	[+] VehicleMileage_Record REC_Mileage = {...}
		[ ] lsVehicleMileage[1][1]
		[ ] lsVehicleMileage[1][2]
		[ ] lsVehicleMileage[1][3]
		[ ] lsVehicleMileage[1][4]
		[ ] FormatDateTime (GetDateTime(), "hh:nn:ss")
		[ ] lsVehicleMileage[1][6]
		[ ] lsVehicleMileage[1][7]
		[ ] lsVehicleMileage[1][8]
		[ ] lsVehicleMileage[1][9]
		[ ] lsVehicleMileage[1][10]
		[ ] lsVehicleMileage[1][11]
		[ ] lsVehicleMileage[1][12]
	[ ] 
	[+] if (! QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[-] else
		[ ] 
		[ ] // clean up all the records
		[ ] DeleteAllMileageRecords()
		[ ] 
		[ ] // add a record
		[ ] SetVehicleMileage(REC_Mileage)
		[ ] DlgVehicleMileage.EnterTripButton.Click()
		[ ] DlgVehicleMileage.DoneButton.Click()
		[ ] 
		[ ] QuickenMainWindow.Planning.Click()
		[ ] QuickenMainWindow.TaxCenter.Click()
		[ ] QuickenMainWindow.ShowTaxSummaryReport.Click()
		[ ] 
		[+] if (TaxSummary.Exists(5))
			[ ] ReportStatus("TaxSummary Dialog ", PASS, "TaxSummary Dialog invoked successfully")
			[ ] 
			[ ] // verify the added record
			[ ] sHandle = Str(TaxSummary.QWListViewer1.ListBox1.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETROW",sHandle,str(3))
			[ ] 
			[+] if (MatchStr ("*{REC_Mileage.sStart}*{REC_Mileage.sDestination}*{REC_Mileage.sVehicleUsed}*", sActual))
				[ ] ReportStatus("TaxSummary ", PASS, "Added record [{REC_Mileage.sStart}*{REC_Mileage.sDestination}*{REC_Mileage.sVehicleUsed}] present on Tax summary")
			[+] else
				[ ] ReportStatus("TaxSummary ", FAIL, "TaxSummary Dialog did not show added record [{REC_Mileage.sStart}*{REC_Mileage.sDestination}*{REC_Mileage.sVehicleUsed}]")
				[ ] 
			[ ] TaxSummary.Close()
			[ ] WaitForState(TaxSummary,FALSE,3)
		[+] else
			[ ] ReportStatus("TaxSummary Dialog ", FAIL, "TaxSummary Dialog not exist")
[ ] 
