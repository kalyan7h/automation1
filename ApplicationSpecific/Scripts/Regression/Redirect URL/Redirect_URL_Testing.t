[ ] 
[+] // FILE NAME:	<Redirect_URL_Testing.t.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This suit will verify all redirects in linked excel document
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Dean Paes
	[ ] //
	[ ] // Developed on: 		8/4/2014
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //August 4, 2014 	Dean Paes Created
[ ] // *********************************************************
[ ] 
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[ ] 
[+] testcase Test_RedirectURL() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] // Variable Declaration
		[ ] 
		[ ] 
		[ ] // ---- STRING ------
		[ ] 
		[ ] // IE Browser URL
		[ ] STRING sCmdLine="C:\Program Files\Internet Explorer\iexplore.exe"
		[ ] 
		[ ] // Read Data From
		[ ] STRING sRedirectURL="TestRedirectURL"
		[ ] STRING sRedirectURLSheet="TestRedirectURLSheet"
		[ ] 
		[ ] // Write Results To
		[ ] STRING sRedirectURLResult="Test_RedirectURL_Result"
		[ ] STRING sRedirectURLResultSheet="RedirectTestResult"
		[ ] 
		[ ] STRING sPassText="PASS"
		[ ] STRING sFailText="FAIL"
		[ ] STRING sNAText="NA"
		[ ] 
		[ ] STRING sCaption,sURL
		[ ] 
		[ ] 
		[ ] //-------- LISTS --------
		[ ] LIST OF ANYTYPE lsExcelData
		[ ] LIST OF ANYTYPE lsResult,lsTemp
		[ ] 
		[ ] //-------- INTEGER --------
		[ ] INTEGER iCount
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // Launch Internet Explorer
	[ ] InternetExplorer.Start(sCmdLine)
	[ ] sleep(20)
	[ ] 
	[ ] // Read URL data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRedirectURL,sRedirectURLSheet)
	[ ] 
	[ ] 
	[+] if(InternetExplorer.Exists(5))
		[ ] 
		[-] for(iCount=1;iCount<=ListCount(lsExcelData);iCount++)
			[ ] 
			[ ] 
			[ ] 
			[ ] // Read Current Row of Excel
			[ ] lsData=lsExcelData[iCount]
			[ ] 
			[ ] lsResult=NULL
			[ ] lsResult=lsTemp
			[ ] 
			[ ] // Append Actual and Expected to Result
			[ ] ListAppend(lsResult,lsData[3])     //Actual
			[ ] ListAppend(lsResult,lsData[4])     // Expected
			[ ] 
			[ ] 
			[ ] // Navigate to Web page
			[ ] InternetExplorer.BrowserWindow.Navigate(lsData[3])
			[ ] 
			[ ] sleep(5)
			[ ] InternetExplorer.SetActive()
			[ ] // Get Expected URL
			[ ] sURL=InternetExplorer.BrowserWindow.GetUrl()
			[ ] ListAppend(lsResult,sURL)
			[ ] 
			[ ] // Get Expected Caption
			[ ] sCaption=InternetExplorer.GetCaption()
			[ ] ListAppend(lsResult,sCaption)
			[ ] 
			[ ] 
			[ ] // Match Actual and Expected URL
			[+] if(lsData[4]==NULL||lsData[4]=="")
				[ ] 
				[ ] ListAppend(lsResult,sNAText)
				[ ] 
			[+] else
				[ ] 
				[+] if(sURL==lsData[4])
					[ ] ListAppend(lsResult,sPassText)
					[ ] 
				[+] else
					[ ] ListAppend(lsResult,sFailText)
					[ ] 
				[ ] 
			[ ] 
			[ ] WriteExcelTable(sRedirectURLResult,sRedirectURLResultSheet,lsResult)
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Browser launched",FAIL,"IE not launched")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
