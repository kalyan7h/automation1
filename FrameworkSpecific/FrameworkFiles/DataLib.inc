[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	DataLib.INC
[+] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file contains the data library funtions
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
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 
	[ ] // STRING s = "..\..\ApplicationSpecific\Data\TestData\TestDriver"	
	[ ] STRING s = "..\..\ApplicationSpecific\Data\TestData\"	
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[-] // DATA LIBRARY FUNCTIONS
	[ ] 
	[+] LIST OF LIST OF STRING GetDefData()
		[ ] // ==========================================================
		[-] // FUNCTION: GetDefData()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function used to read default data from .xls file.
			[ ] //
			[ ] // PARAMETERS:	NULL
			[ ] //
			[ ] // RETURNS:		LIST OF STRING  data
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 10, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] return  ReadExcelTable(s,"DefaultData")
		[ ] 
	[ ] 
	[+] LIST OF STRING ParseString(STRING sTarget optional, STRING sDelim optional)
		[ ] // ==========================================================
		[+] // FUNCTION: ParseString()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function breaks down a STRING (in sTarget) into a list of substrings, using
			[ ] // the STRING delimiter (in sDelim) to mark the endpoints of each substring. If a
			[ ] // STRING begins with the delimeter, the first entry in the list should be blank. If
			[ ] // the STRING ends with the delimeter, the last entry in the list should be blank.
			[ ] //
			[ ] // PARAMETERS:	STRING	sTarget		STRING to parse
			[ ] //				STRING	sDelim		STRING delimiter
			[ ] //
			[ ] // RETURNS:		LIST OF STRING		substrings
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 		Bhagwat Kolde		Created
			[ ] 
		[ ] // ==========================================================
		[ ] 
		[+] if (sTarget == NULL)
			[ ] sTarget = Space(1)
			[ ] 
		[ ] LIST OF STRING lsRes
		[ ] BOOLEAN	bDone = FALSE
		[ ] INTEGER	iDelimLen = Len(sDelim)
		[ ] STRING	sRemain = sTarget
		[-] while !(bDone)
			[ ] INTEGER iPos = StrPos(sDelim, sRemain)
			[-] if (0 == iPos)
				[ ] bDone = TRUE
				[ ] ListAppend(lsRes, Trim(sRemain))
			[-] else
				[ ] // iPos is guaranteed to be >= 1. If iPos - 1 = 0, this means that the remaining
				[ ] // string begins with sDelim, therefore this entry should be blank.
				[ ] // If iPos + iDelimLen is off the end of the string, SubStr returns a null string,
				[ ] // which will be added to the list at the end.
				[ ] ListAppend(lsRes, Trim(Left(sRemain, (iPos - 1))))
				[ ] sRemain = SubStr(sRemain, (iPos + iDelimLen))
		[ ] return (lsRes)
		[ ] 
		[ ] 
	[ ] 
	[+] // LIST OF ANYTYPE ReadExcelTable(STRING sDB, STRING sWorksheet, STRING sCellRange optional)
		[ ] // // ==========================================================
		[+] // // FUNCTION: ReadExcelTable()
			[ ] // //
			[ ] // // DESCRIPTION:
			[ ] // //   This function used to read data from .xls file
			[ ] // 
			[ ] // // PARAMETERS:	STRING sDB: file name
			[ ] // //				STRING sWorksheet: worksheet name
			[ ] // //				STRING sCellRange optional:cell range
			[ ] // //
			[ ] // // RETURNS:		LIST OF LIST OF STRING (Records)
			[ ] // //
			[ ] // // REVISION HISTORY:
			[ ] // //	 Mar 10, 2011	Udita Dube created
			[ ] // // 	 May 18, 2011 Mamta Jain Updated
			[ ] // //    April 26, 2012 Puja Verma Updated
		[ ] // // ==========================================================
		[ ] // 
		[-] // // Variable declaration
			[ ] // HANDLE hDB
			[ ] // HANDLE hSQL 
			[ ] // List of STRING lsData //To get testdata
			[ ] // STRING		sRange = BLANK_STR
			[ ] // INTEGER i = 0
			[ ] // STRING sDB_FilePath
			[ ] // LIST OF LIST OF ANYTYPE laResults = {}
			[ ] // STRING sTestcaseName= GetTestCaseName()
		[ ] // 
		[ ] // 
		[+] // if (MatchStr("*TestingService*", sDB))
			[ ] // sDB_FilePath = sDB
		[-] // else if(StrPos ("Navigation", sTestcaseName) > 0)
			[ ] // sDB_FilePath = XLS_DATAFILE_PATH + "\Navigation\" + sDB
		[-] // else if (MatchStr("*.xls*", sDB)) //added by Puja to make run testing as services
			[ ] // sDB_FilePath = sDB
			[ ] // print(sDB_FilePath)
		[-] // else
			[ ] // sDB_FilePath = XLS_DATAFILE_PATH + "\" + sDB+".xls"
			[ ] // 
		[-] // if (sDB_FilePath != NULL)
			[-] // if (sCellRange != NULL)
				[ ] // sRange = sCellRange
			[-] // else
				[ ] // sRange=""
			[-] // do
				[ ] // // connect to the database
				[ ] // hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sDB_FilePath}{DB_CONNECT_SUFFIX}")
				[ ] // //execute a SQL statement
				[ ] // hSQL = DB_ExecuteSQL (hDB, "{SQL_QUERY_START}[{sWorksheet}${sRange}]")//while there are still rows to retrieve
			[-] // except
				[ ] // Log.Error("Verify WorkSheet existence", "Worksheet - {sWorksheet} is not present in {sDB} file")
			[ ] // sleep (SHORT_SLEEP)
			[-] // if(GetTestCaseErrorCount ( ) >=1)
				[ ] // laResults = {}
			[-] // else
				[ ] // // read data from table
				[-] // do
					[ ] // // loop to retrieve rows of data
					[-] // while (DB_FetchNext(hSQL,lsData))
						[ ] // // append data to results list
						[ ] // ListAppend(laResults, lsData)
						[ ] // 
					[ ] // 
				[-] // except
					[ ] // Log.Error("ReadExcelTable","Error while reading {sWorksheet} worksheet of {sDB} file.")
					[ ] // ExceptLog()
				[ ] // DB_FinishSQL (hSQL) 
				[ ] // // disconnect from database
				[ ] // DB_Disconnect(hDB)
				[ ] // 
			[ ] // 
		[ ] // return (laResults)
		[ ] // 
		[ ] // 
	[+] LIST OF ANYTYPE ReadExcelTable(STRING sDB, STRING sWorksheet, STRING sPath optional ,STRING sCellRange optional) 
		[ ] // ==========================================================
		[+] // FUNCTION: ReadExcelTable()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function used to read data from .xls file
			[ ] 
			[ ] // PARAMETERS:	STRING sDB: file name
			[ ] //				STRING sWorksheet: worksheet name
			[ ] //				STRING sCellRange optional:cell range
			[ ] //
			[ ] // RETURNS:		LIST OF LIST OF STRING (Records)
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Mar 10, 2011	Udita Dube created
			[ ] // 	 May 18, 2011 Mamta Jain Updated
			[ ] //    April 26, 2012 Puja Verma Updated
		[ ] // ==========================================================
		[ ] 
		[-] // Variable declaration
			[ ] HANDLE hDB
			[ ] HANDLE hSQL 
			[ ] List of STRING lsData //To get testdata
			[ ] STRING		sRange = BLANK_STR
			[ ] INTEGER i = 0
			[ ] STRING sDB_FilePath
			[ ] LIST OF LIST OF ANYTYPE laResults = {}
			[ ] STRING sTestScriptName= GetProgramName()
		[ ] 
		[+] 
			[+] // if (MatchStr("*TestingService*", sDB))
				[ ] // sDB_FilePath = sDB
			[+] // else if(StrPos ("Navigation", sTestScriptName) > 0)
				[ ] // sDB_FilePath = XLS_DATAFILE_PATH + "\Navigation\" + sDB
			[+] // else if (MatchStr("*.xls*", sDB)) //added by Puja to make run testing as services
				[ ] // sDB_FilePath = sDB
				[ ] // print(sDB_FilePath)
				[ ] // 
		[-] if (sPath!=NULL)
			[ ] sDB_FilePath = sPath + "\" + sDB+".xls"
			[ ] 
		[-] else
			[ ] sDB_FilePath = XLS_DATAFILE_PATH + "\" + sDB+".xls"
			[ ] 
		[-] if (sDB_FilePath != NULL)
			[+] if (sCellRange != NULL)
				[ ] sRange = sCellRange
			[+] else
				[ ] sRange=""
			[-] do
				[ ] // connect to the database
				[ ] hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sDB_FilePath}{DB_CONNECT_SUFFIX}")
				[ ] //execute a SQL statement
				[ ] hSQL = DB_ExecuteSQL (hDB, "{SQL_QUERY_START}[{sWorksheet}${sRange}]")//while there are still rows to retrieve
			[-] except
				[ ] Log.Error("Verify WorkSheet existence", "Worksheet - {sWorksheet} is not present in {sDB} file")
			[ ] sleep (SHORT_SLEEP)
			[-] // if(GetTestCaseErrorCount ( ) >=1)
				[ ] // laResults = {}
			[ ] // else
			[ ] // read data from table
			[-] do
				[ ] // loop to retrieve rows of data
				[-] while (DB_FetchNext(hSQL,lsData))
					[ ] // append data to results list
					[ ] ListAppend(laResults, lsData)
					[ ] 
				[ ] 
			[+] except
				[ ] Log.Error("ReadExcelTable","Error while reading {sWorksheet} worksheet of {sDB} file.")
				[ ] ExceptLog()
			[ ] DB_FinishSQL (hSQL) 
			[ ] // disconnect from database
			[ ] DB_Disconnect(hDB)
			[ ] 
		[ ] return (laResults)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] public STRING ModifyDate(INTEGER iDaysIncrement ,STRING sDateFormat optional )
		[ ] // ==========================================================
		[+] // FUNCTION: ModifyDate()
			[ ] // 
			[ ] // DESCRIPTION:
			[ ] // This function will verify if 
			[ ] // 
			[ ] // PARAMETERS:		STRING	 			sCycle                  Forward or Backward
			[ ] //                                  INTEGER                iDaysIncrement       
			[ ] //                                    STRING                  sDateFormat          eg: "dd/mm/yyyy"
			[ ] //
			[ ] // 
			[ ] // RETURNS:			STRING		 		Required Date
			[ ] //                                                          
			[ ] // 
			[ ] // REVISION HISTORY:
			[ ] // Dean Paes  created  Feb 15 2013
		[ ] // ==========================================================
		[ ] 
		[ ] datetime dtDateTime,newDateTime
		[ ] STRING sNewDate
		[ ] STRING sDate
		[ ] 
		[+] do
			[ ] dtDateTime= GetDateTime ()
			[ ] 
			[+] if(sDateFormat==NULL)
				[ ] sDateFormat="dd/mm/yyyy"
			[ ] 
			[ ] newDateTime = AddDateTime (dtDateTime, iDaysIncrement)
			[ ] sNewDate = FormatDateTime (newDateTime, sDateFormat)
			[ ] 
		[+] except
			[ ] ReportStatus("Modify Date",FAIL,"Error in Modify date function")
		[ ] return sNewDate
	[ ] 
	[+] public STRING LastDateOfTheMonth()
		[ ]  // ==========================================================
		[+]  // FUNCTION: LastDateOfTheMonth()
			[ ] // 
			[ ] // DESCRIPTION:
			[ ] // This function will return the last date of the current month
			[ ] // 
			[ ] // PARAMETERS:		None
			[ ] //
			[ ] // 
			[ ] // RETURNS:			STRING		 		Last Date of the month
			[ ] //                                                          
			[ ] // 
			[ ] // REVISION HISTORY:
			[ ] // Udita Dube  created  April 01 2013
		[ ] // ==========================================================
		[ ] 
		[+] // Variable declarations
			[ ] INTEGER iDay,iMonth,iYear
			[ ] DATETIME dtDateTime
			[ ] STRING sDate,sMonth,sYear
		[ ] 
		[+] do
			[ ] sMonth = FormatDateTime(GetDateTime(), "m")
			[ ] iMonth = Val(sMonth)
			[ ] sYear= FormatDateTime(GetDateTime(), "yyyy")
			[ ] iYear = Val(sYear)
			[ ] 
			[+] switch (iMonth) 
				[-] case 2
					[ ] // if year is divisible by 4 and not divisible by 100
					[-] if ((iYear % 4 == 0) && (iYear % 100) > 0)
						[ ] iDay = 29
					[ ] //or if year is divisible by 400
					[-] else if (iYear % 400 == 0)
						[ ] iDay= 29
					[-] else
						[ ] iDay= 28
				[-] case 4
					[ ] iDay= 30
				[-] case 6
					[ ] iDay= 30
				[-] case 9
					[ ] iDay= 30
				[-] case 11
					[ ] iDay= 30
				[-] default
					[ ] iDay= 31
    
			[ ] 
			[ ] dtDateTime=MakeDateTime(iYear, iMonth, iDay)
			[ ] sDate=FormatDateTime(dtDateTime,"m/d/yyyy")
		[+] except
			[ ] ExceptLog()
		[ ] 
		[ ] return sDate
	[ ] 
	[+] public STRING LastFridayOfTheCurrentMonth()
		[ ]  // ==========================================================
		[+]  // FUNCTION: LastFridayOfTheCurrentMonth()
			[ ] // 
			[ ] // DESCRIPTION:
			[ ] // This function will return the last friday's date of the current month
			[ ] // 
			[ ] // PARAMETERS:		None
			[ ] //
			[ ] // 
			[ ] // RETURNS:			STRING		 		Last friday's date of the current month
			[ ] //                                                          
			[ ] // 
			[ ] // REVISION HISTORY:
			[ ] // Udita Dube  created  April 01 2013
		[ ] // ==========================================================
		[ ] 
		[+] // Variable Declarations
			[ ] INTEGER iDifference,iLastFridayOfTheMonth,iDayIncreament,iFridayOfTheWeek,i
			[ ] STRING sDay,sDate,sToday
			[ ] DATETIME dtDateTime,newDateTime
			[ ] 
		[+] do
			[ ] dtDateTime= GetDateTime ()
			[ ] 
			[ ] sDay = FormatDateTime(GetDateTime(), "w")  // Sun, Mon, Tue, Wed, Thu, Fri, or Sat
			[ ]         										  //  1       2      3      4      5       6      7
			[ ] iDifference = 6 - Val(sDay)
			[ ] 
			[ ] sToday = FormatDateTime(GetDateTime(),"d")
			[ ] // print("sToday = {sToday}")
			[ ] 
			[ ] 
			[ ] iFridayOfTheWeek = Val(sToday) + iDifference
			[ ] // print("iFridayOfTheWeek = {iFridayOfTheWeek}")
			[+] if(iFridayOfTheWeek > 31)
				[ ] iFridayOfTheWeek = Val(sToday) - Val(sDay)-1
				[ ] 
			[ ] 
			[ ] iLastFridayOfTheMonth=iFridayOfTheWeek
			[ ] // print("iLastFridayOfTheMonth = {iLastFridayOfTheMonth}")
			[ ] 
			[-] for(i=iLastFridayOfTheMonth;i<31;i++)
				[ ] iLastFridayOfTheMonth=iLastFridayOfTheMonth+7
				[+] if(iLastFridayOfTheMonth>31)
					[ ] iLastFridayOfTheMonth=iLastFridayOfTheMonth-7
					[ ] // print("Last friday {iLastFridayOfTheMonth}")
					[ ] break
				[+] else
					[ ] // print(iLastFridayOfTheMonth)
			[ ] 
			[ ] iDayIncreament=iLastFridayOfTheMonth-Val(sToday)
			[ ] newDateTime = AddDateTime (dtDateTime, iDayIncreament)
			[ ] sDate = FormatDateTime (newDateTime, "m/d/yyyy")
			[ ] 
		[+] except 
			[ ] ExceptLog()
			[ ] 
		[ ] 
		[ ] return sDate
		[ ] 
	[ ] 
	[+] // VOID WriteExcelTable(STRING sDB, STRING sWorksheet, LIST OF ANYTYPE lsDataValues)
		[ ] // // ==========================================================
		[+] // // FUNCTION: ReadExcelTable()
			[ ] // //
			[ ] // // DESCRIPTION:
			[ ] // //   This function used to read data from .xls file
			[ ] // 
			[ ] // // PARAMETERS:	STRING sDB: file name
			[ ] // //				STRING sWorksheet: worksheet name
			[ ] // //				STRING sCellRange optional:cell range
			[ ] // //
			[ ] // // RETURNS:		LIST OF LIST OF STRING (Records)
			[ ] // //
			[ ] // // REVISION HISTORY:
			[ ] // //	 Mar 10, 2011	Udita Dube created
			[ ] // // 	 May 18, 2011 Mamta Jain Updated
			[ ] // //    April 26, 2012 Puja Verma Updated
		[ ] // // ==========================================================
		[ ] // 
		[-] // // Variable declaration
			[ ] // HANDLE hDB
			[ ] // HANDLE hSQL 
			[ ] // List of STRING lsData //To get testdata
			[ ] // STRING sInsertString
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // STRING		sRange = BLANK_STR
			[ ] // INTEGER i = 0 , iCount
			[ ] // STRING sDB_FilePath
			[ ] // LIST OF LIST OF ANYTYPE laResults = {}
			[ ] // STRING sTestcaseName= GetTestCaseName()
			[ ] // sDB_FilePath = AUT_DATAFILE_PATH + "\" + sDB+".xls"
			[+] // if (ListCount(lsDataValues)>1)
				[-] // for (iCount =1 ; iCount <ListCount(lsDataValues) +1 ; ++iCount)
					[-] // if (lsDataValues[iCount]==NULL)
						[ ] // lsDataValues[iCount]=""
					[ ] // 
					[-] // if (iCount==1)
						[ ] // sInsertString =" '{lsDataValues[iCount]}' "
						[ ] // 
					[-] // else if (lsDataValues[iCount]==NULL)
						[ ] // 
					[ ] // 
					[-] // else
						[ ] // sInsertString=  sInsertString+ " , " + " '{lsDataValues[iCount]}' "
					[ ] // 
			[+] // else if (lsDataValues[1]==NULL)
				[ ] // sInsertString=""
				[ ] // 
			[+] // else
				[ ] // sInsertString=lsDataValues[1]
			[ ] // 
			[ ] // print (sDB_FilePath)
			[+] // do
				[ ] // // connect to the database
				[ ] // hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sDB_FilePath}{DB_CONNECT_SUFFIX}")
				[ ] // //execute a SQL statement
				[ ] // 
				[ ] // // hSQL = DB_ExecuteSQL (hDB, "INSERT INTO [{sWorksheet}$] VALUES ('jh' , 'ghg' , 'dff') ")  //while there are still rows to retrieve
				[ ] // hSQL = DB_ExecuteSQL (hDB, "INSERT INTO [{sWorksheet}$] VALUES ({sInsertString})")  //while there are still rows to retrieve
				[ ] // 
			[+] // except
				[ ] // ExceptLog()
			[ ] // sleep (SHORT_SLEEP)
			[ ] // // read data from table
			[ ] // DB_FinishSQL (hSQL) 
			[ ] // // disconnect from database
			[ ] // DB_Disconnect(hDB)
			[ ] // 
		[ ] // 
		[ ] // 
	[+] VOID WriteExcelTable(STRING sDB, STRING sWorksheet, LIST OF ANYTYPE lsDataValues  ,STRING sPath optional)
		[ ] // ==========================================================
		[+] // FUNCTION: ReadExcelTable()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function used to read data from .xls file
			[ ] 
			[ ] // PARAMETERS:	STRING sDB: file name
			[ ] //				STRING sWorksheet: worksheet name
			[ ] //				STRING sCellRange optional:cell range
			[ ] //
			[ ] // RETURNS:		LIST OF LIST OF STRING (Records)
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Mar 10, 2011	Udita Dube created
			[ ] // 	 May 18, 2011 Mamta Jain Updated
			[ ] //    April 26, 2012 Puja Verma Updated
		[ ] // ==========================================================
		[ ] 
		[-] // Variable declaration
			[ ] HANDLE hDB
			[ ] HANDLE hSQL 
			[ ] List of STRING lsData //To get testdata
			[ ] STRING sInsertString
			[ ] 
			[ ] 
			[ ] 
			[ ] STRING		sRange = BLANK_STR
			[ ] INTEGER i = 0 , iCount
			[ ] STRING sDB_FilePath
			[ ] LIST OF LIST OF ANYTYPE laResults = {}
			[ ] STRING sTestcaseName= GetTestCaseName()
			[-]  if (sPath!=NULL) 
				[ ] sDB_FilePath = sPath + "\" + sDB+".xls"
			[-] else
				[ ] sDB_FilePath = AUT_DATAFILE_PATH + "\" + sDB+".xls"
			[+] if (ListCount(lsDataValues)>1)
				[-] for (iCount =1 ; iCount <ListCount(lsDataValues) +1 ; ++iCount)
					[-] if (lsDataValues[iCount]==NULL)
						[ ] lsDataValues[iCount]=""
					[ ] 
					[-] if (iCount==1)
						[ ] sInsertString =" '{lsDataValues[iCount]}' "
						[ ] 
					[-] else if (lsDataValues[iCount]==NULL)
						[ ] 
					[ ] 
					[-] else
						[ ] sInsertString=  sInsertString+ " , " + " '{lsDataValues[iCount]}' "
					[ ] 
			[-] else if (lsDataValues[1]==NULL)
				[ ] sInsertString=""
				[ ] 
			[-] else
				[ ] sInsertString=lsDataValues[1]
			[ ] 
			[ ] 
			[-] do
				[ ] // connect to the database
				[ ] hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sDB_FilePath}{DB_CONNECT_SUFFIX}")
				[ ] //execute a SQL statement
				[ ] 
				[ ] // hSQL = DB_ExecuteSQL (hDB, "INSERT INTO [{sWorksheet}$] VALUES ('jh' , 'ghg' , 'dff') ")  //while there are still rows to retrieve
				[ ] hSQL = DB_ExecuteSQL (hDB, "INSERT INTO [{sWorksheet}$] VALUES ({sInsertString})")  //while there are still rows to retrieve
				[ ] 
			[-] except
				[ ] ExceptLog()
			[ ] sleep (SHORT_SLEEP)
			[ ] // read data from table
			[ ] DB_FinishSQL (hSQL) 
			[ ] // disconnect from database
			[ ] DB_Disconnect(hDB)
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[ ] // *************************************************************************************
[ ] //	END OF INCLUDE FILE
[ ] // *************************************************************************************
[ ] 
