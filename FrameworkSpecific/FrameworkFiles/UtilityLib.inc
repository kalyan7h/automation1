[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	UtilityLib.INC
[+] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file contains the utility library functions
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
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[+] // GENERAL UTILITY FUNCTIONS 
	[ ] 
	[+] VOID ListUpper(inout LIST OF STRING lsList)
		[ ] // ==========================================================
		[+] // FUNCTION: ListUpper()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function converts all items in a lists of string to upper case.
			[ ] //
			[ ] // PARAMETERS:	LIST OF STRING	lsList	list to be converted
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 4, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] INTEGER iCount
		[-] if (ListCount(lsList) > 0)
			[-] for iCount = 1 to ListCount(lsList)
				[ ] lsList[iCount] = Upper(lsList[iCount])
		[ ] 
		[ ] 
	[ ] 
	[+] VOID ListLower(inout LIST OF STRING lsList)
		[ ] // ==========================================================
		[+] // FUNCTION: ListLower()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function converts all items in a lists of string to lower case.
			[ ] //
			[ ] // PARAMETERS:	LIST OF STRING	lsList	list to be converted
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 4, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] INTEGER iCount
		[+] if (ListCount(lsList) > 0)
			[+] for iCount = 1 to ListCount(lsList)
				[ ] lsList[iCount] = lower(lsList[iCount])
		[ ] 
		[ ] 
	[ ] 
	[+] VOID ListRemoveDups(inout LIST OF ANYTYPE laList)
		[ ] // ==========================================================
		[+] // FUNCTION: ListRemoveDups()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function removes duplicate items from a specified list (e.g. {1,2,3,3,3,4}
			[ ] // becomes {1,2,3,4}).
			[ ] //
			[ ] // PARAMETERS:	LIST OF ANYTYPE		laList	list to be stripped of dups
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 6, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] LIST OF ANYTYPE laTemp = laList
		[ ] LIST OF ANYTYPE laOutput = {}
		[ ] ANYTYPE aItem
		[+] for each aItem in laList
			[+] if (ListFind(laTemp, aItem))
				[ ] ListAppend(laOutput, aItem)
			[+] while (ListFind(laTemp, aItem))
				[ ] ListDelete(laTemp, ListFind(laTemp, aItem))
		[ ] laList = laOutput
		[ ] 
		[ ] 
	[ ] 
	[+] VOID ListTran(inout LIST OF STRING lsList, STRING sSearch, STRING sReplace)
		[ ] // ==========================================================
		[+] // FUNCTION: ListTran()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function searches for and replaces characters in a list of strings.
			[ ] //
			[ ] // PARAMETERS:	LIST OF STRING	lsList		list to search
			[ ] //				STRING			sSearch		search string
			[ ] //				STRING			sReplace	replacement string
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 6, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] INTEGER iCount
		[+] if (ListCount(lsList) > 0)
			[-] for iCount = 1 to ListCount(lsList)
				[ ] lsList[iCount] = StrTran(lsList[iCount], sSearch, sReplace)
		[ ] 
		[ ] 
	[ ] 
	[+] VOID ListPrefixSuffix(inout LIST OF STRING lsList, STRING sPrefix optional, STRING sSuffix optional)
		[ ] // ==========================================================
		[+] // FUNCTION: ListPrefixSuffix()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function adds a prefix and/or suffix to each line of a specified list of
			[ ] // strings.
			[ ] //
			[ ] // PARAMETERS:	LIST OF STRING	lsList		list to search
			[ ] //				STRING			sPrefix		string to appear before each line
			[ ] //				STRING			sSuffix		string to appear after each line
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 8, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] INTEGER iCount
		[+] for iCount = 1 to ListCount(lsList)
			[+] if (sPrefix != NULL)
				[ ] lsList[iCount] = sPrefix + lsList[iCount]
			[+] if (sSuffix != NULL)
				[ ] lsList[iCount] = lsList[iCount] + sSuffix
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN StrToBoolean(STRING sVal)
		[ ] // ==========================================================
		[+] // FUNCTION: StrToBoolean()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function used for data conversion STRING to BOOLEAN.
			[ ] //
			[ ] // PARAMETERS:	sVal: STRING value
			[ ] //
			[ ] // RETURNS:		converted BOOLEAN value
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 27, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] 
		[ ] BOOLEAN bRetVal
		[ ] // Return TRUE, FALSE as appropriate. If returned value is neither, report an
		[ ] // error and return FALSE.
		[+] switch (Upper(sVal))
			[+] case "TRUE", "YES", "Y", "1"
				[ ] bRetVal = TRUE
			[+] case "FALSE", "NO", "N", "0"
				[ ] bRetVal = FALSE
			[+] default
				[ ] bRetVal = FALSE
				[ ] Log.Error("StrToBool: Expected a boolean value. sVal contains '{sVal}'. Assigning {bRetVal}")
		[ ] return (bRetVal)
		[ ] 
	[ ] 
	[+] BOOLEAN	ListCompare(LIST OF ANYTYPE laActual, LIST OF ANYTYPE laBaseLine, BOOLEAN bOrder optional)
		[ ] // ==========================================================
		[+] // FUNCTION: ListCompare()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function performs a comparison of a baseline list (in laBaseLine) with
			[ ] // the list specified in laActual, and returns a boolean result of TRUE if the
			[ ] // lists match.
			[ ] //
			[ ] // PARAMETERS:	LIST OF ANYTYPE	laActual	list to compare
			[ ] //				LIST OF ANYTYPE	laBaseLine	baseline list
			[ ] //				BOOLEAN			bOrder		TRUE  = (default) verify list ordering
			[ ] //											FALSE = ignore list ordering
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = lists match
			[ ] //							FALSE = mismatch in lists
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 27, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] INTEGER iCount
		[+] if (bOrder == NULL)
			[ ] bOrder = TRUE
		[ ] // check for missing items (Expected but not in Actual)
		[ ] LIST OF ANYTYPE laMissing	= ListMissingItems(laActual, laBaseLine)
		[ ] // check for extra items (Actual, but not expected)
		[ ] LIST OF ANYTYPE laExtra		= ListExtraItems(laActual, laBaseLine)
		[ ] BOOLEAN	bError = ((ListCount(laMissing) > 0) || (ListCount(laExtra) > 0))
		[ ] // if items in lists match, check that ordering of items is also correct.
		[+] if !(bError && bOrder)
			[+] for iCount = 1 to ListCount(laBaseLine)
				[+] if ((laBaseLine[iCount]) != (laActual[iCount]))
					[ ] Log.Message("Items out of sequence: {laActual[iCount]}, {laBaseLine[iCount]}")
					[ ] bError = TRUE
		[ ] // if the lists failed to match in any way, raise an exception.
		[+] if (bError)
			[ ] Log.Error("Unmatched lists.")
			[+] if (ListCount(laMissing) > 0)
				[ ] Log.Message("  Missing item(s): {laMissing}")
			[+] if (ListCount(laExtra) > 0)
				[ ] Log.Message("  Extra item(s):   {laExtra}")
		[ ] return !bError
		[ ] 
	[ ] 
	[+] BOOLEAN	IsInList(LIST OF ANYTYPE laList, ANYTYPE aItem)
		[ ] // ==========================================================
		[+] // FUNCTION: IsInList()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns TRUE if aItem is found in laList.
			[ ] //
			[ ] // PARAMETERS:	LIST OF ANYTYPE	laList		list to be checked
			[ ] //				ANYTYPE			aItem		item to search for
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = item is in list
			[ ] //							FALSE = item not found
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 27, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] return (ListFind(laList, aItem) != 0)
		[ ] 
	[ ] 
	[+] STRING	GetDirPath(STRING sFilePath)
		[ ] // ==========================================================
		[-] // FUNCTION: GetDirPath()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns the drive specifier and directory path without the file name
			[ ] // and extension specifier contained in a file path string.
			[ ] //
			[ ] // PARAMETERS:	STRING	sFilePath		file path string
			[ ] //
			[ ] // RETURNS:		STRING	drive specifier and directory path
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 	Jan 8,2007	Bhagwat Kolde		Created
		[ ] // ==========================================================
		[ ] STRING	sDummy
		[ ] STRING	sDrive
		[ ] STRING	sDir
		[ ] SplitPath(sFilePath, sDrive, sDir, sDummy, sDummy)
		[-] if (Len(sDrive) < 1)
			[ ] sDummy = BLANK_STR
		[-] else if (Len(sDrive) == 1)
			[ ] sDummy = sDrive + ":\" + sDir
		[+] else
			[ ] sDummy = "\\" + sDrive + "\" + sDir
		[ ] // return drive specifier and directory path
		[ ] return sDummy					
		[ ] 
		[ ] 
	[ ] 
	[+] STRING	ListOfStrToStr(LIST OF STRING lsList)
		[ ] // ==========================================================
		[+] // FUNCTION: ListofStrToStr()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns a given list of strings as a basic string.
			[ ] //
			[ ] // PARAMETERS:	LIST OF STRING	lsList		list of strings to be converted
			[ ] //
			[ ] // RETURNS:		:STRING	complete list as single string
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 10, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] STRING	sLine
		[ ] STRING	sOutput = BLANK_STR
		[+] for each sLine in lsList
			[ ] sOutput = sOutput + sLine
		[ ] return sOutput
		[ ] 
	[ ] 
	[+] INTEGER	ListOccurences(LIST OF ANYTYPE laList, ANYTYPE aItem)
		[ ] // ==========================================================
		[-] // FUNCTION: ListOccurences()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns the number of times an item occurs in a list of any type.
			[ ] //
			[ ] // PARAMETERS:	LIST OF ANYTYPE	laList		list to be checked
			[ ] //				ANYTYPE			aItem		item to count
			[ ] //
			[ ] // RETURNS:		INTEGER			number of times item occurs in list
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 10, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] LIST OF ANYTYPE laTemp = {...}
		[ ] INTEGER iCount = 0
		[ ] laTemp = laList
		[+] if IsInList(laTemp, aItem)
			[+] while IsInList(laTemp, aItem)
				[ ] iCount++
				[ ] ListDelete(laTemp, ListFind(laTemp, aItem))
		[ ] return iCount
		[ ] 
		[ ] 
	[ ] 
	[+] INTEGER	StrToInt(STRING sVal)
		[ ] // ==========================================================
		[+] // FUNCTION: StrToInt()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function converts the string in sVal to a number, returning the result as
			[ ] // an integer value.
			[ ] //
			[ ] // PARAMETERS:	STRING		sVal	the string to convert
			[ ] //
			[ ] // RETURNS:		INTEGER		the returned number
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 12,2007	Bhagwat Kolde		Created
		[ ] // ==========================================================
		[ ] return (Val(sVal))
		[ ] 
		[ ] 
	[ ] 
	[+] NUMBER	FindNumInStr(STRING sVal)
		[ ] // ==========================================================
		[-] // FUNCTION: FindNumInStr()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function searches for a string representation of a numeric value embedded
			[ ] // within a string and returns the integer representation of that numeric value. Only
			[ ] // the first occurance of a numeric string is returned. If no numeric values are found
			[ ] // in sVal, NULL is returned.
			[ ] 
			[ ] // PARAMETERS:	STRING	sVal string to search
			[ ] //
			[ ] // RETURNS:		NUMBER numeric value found in string (or NULL)
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 8,2007	Bhagwat Kolde		Created
			[ ] 
		[ ] // ==========================================================
		[ ] INTEGER iPos = 1
		[ ] STRING sRemaining = sVal
		[ ] STRING sWord = sVal
		[-] while (iPos > 0)
			[ ] iPos = StrPos(" ", sRemaining)
			[-] if (iPos > 0)
				[ ] sWord = Left(sRemaining, (iPos - 1))
				[ ] sRemaining = SubStr(sRemaining, (iPos + 1))
				[ ] 
			[ ] 
			[-] if IsDigit(sWord)
				[ ] return Val(StrTran(sWord, ",", BLANK_STR))
				[ ] break
				[ ] 
	[ ] 
	[+] ANYTYPE	ListItem(LIST OF ANYTYPE laList, INTEGER iItem)
		[ ] // ==========================================================
		[+] // FUNCTION: ListItem()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //  This function returns item present at specified iItem
			[ ] //
			[ ] // PARAMETERS:	LIST OF ANYTYPE laList
			[ ] //				INTEGER iItem
			[ ] //
			[ ] // RETURNS:		ANYTYPE item
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 12,2007	Bhagwat Kolde		Created
		[ ] // ==========================================================
		[ ] return (laList[iItem])
		[ ] 
	[ ] 
	[+] LIST OF ANYTYPE ListRevSort(inout LIST OF ANYTYPE laList)
		[ ] // ==========================================================
		[+] // FUNCTION: ListRevSort()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function sorts a list of any type in descending order.
			[ ] //
			[ ] // PARAMETERS:	LIST OF ANYTYPE  laList		list to be sorted
			[ ] //
			[ ] // RETURNS:		LIST OF ANYTYPE  descending order of list
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 10, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] LIST OF ANYTYPE laTemp = {...}
		[ ] INTEGER iCount
		[+] if (ListCount(laList) > 0)
			[ ] ListSort(laList)
			[+] for iCount = ListCount(laList) to 1 step - 1
				[ ] ListAppend(laTemp, laList[iCount])
			[ ] laList = laTemp
		[ ] return laList
		[ ] 
	[ ] 
	[+] LIST OF ANYTYPE	ListMissingItems(LIST OF ANYTYPE laActual, LIST OF ANYTYPE laBaseLine)
		[ ] // ============================================
		[+] // FUNCTION: ListMissingItems()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function performs a comparison of a baseline list (in laBaseLine) with
			[ ] // the list specified in laActual, and returns a list of missing items.
			[ ] //
			[ ] // PARAMETERS:	LIST OF ANYTYPE		laActual	list to compare
			[ ] //				LIST OF ANYTYPE		laBaseLine	baseline list
			[ ] //
			[ ] // RETURNS:		LIST OF ANYTYPE		list of missing items
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 10, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] ANYTYPE aItem
		[ ] LIST OF ANYTYPE laMissing
		[ ] // check for missing items (Expected but not in Actual)
		[+] for each aItem in laBaseLine
			[+] if (ListFind(laActual, aItem) == 0)
				[ ] ListAppend(laMissing, aItem)
		[ ] return laMissing
		[ ] 
		[ ] 
	[ ] 
	[+] LIST OF ANYTYPE	ListExtraItems(LIST OF ANYTYPE laActual, LIST OF ANYTYPE laBaseLine)
		[ ] // ==========================================================
		[+] // FUNCTION: ListExtraItems()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function performs a comparison of a baseline list (in laBaseLine) with
			[ ] // the list specified in laActual, and returns a list of extra items.
			[ ] //
			[ ] // PARAMETERS:	LIST OF ANYTYPE		laActual	list to compare
			[ ] //				LIST OF ANYTYPE		laBaseLine	baseline list
			[ ] //
			[ ] // RETURNS:		LIST OF ANYTYPE		list of extra items
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 10, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] ANYTYPE aItem
		[ ] LIST OF ANYTYPE laExtra
		[ ] // check for extra items (Actual, but not expected)
		[+] for each aItem in laActual
			[+] if (ListFind(laBaseLine, aItem) == 0)
				[ ] ListAppend(laExtra, aItem)
		[ ] return laExtra
		[ ] 
		[ ] 
	[ ] 
	[+] LIST OF ANYTYPE	ListDiffs(LIST OF ANYTYPE laActual, LIST OF ANYTYPE laBaseLine)
		[ ] // ==========================================================
		[+] // FUNCTION: ListDiffs()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function performs a comparison of a baseline list (in laBaseLine) with
			[ ] // the list specified in laActual, and returns a list of differences.
			[ ] //
			[ ] // PARAMETERS:	LIST OF ANYTYPE		laActual	list to compare
			[ ] //				LIST OF ANYTYPE		laBaseLine	baseline list
			[ ] //
			[ ] // RETURNS:		LIST OF ANYTYPE		list of differences
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 18, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] LIST OF ANYTYPE laDiffs = ListMissingItems(laActual, laBaseLine)
		[ ] ListMerge(laDiffs, ListExtraItems(laActual, laBaseLine))
		[ ] return laDiffs
		[ ] 
	[ ] 
	[+] STRING ValidDirName (inout string sDir)
		[ ] // ============================================
		[+] // FUNCTION: ValidDirName  (inout string sDir)
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //	Standardization issue: do paths end with a \ or not?
			[ ] //	Well, some would say not.  However, if you look at the
			[ ] //	root directory, it always ends in a \, so I choose that
			[ ] //	all should end in a slash
			[ ] //
			[ ] // PARAMETERS:	sDir: The path string to repair.  (inout)
			[ ] //
			[ ] // RETURNS:		repaired path
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] 
		[+] if right (sDir, 1) != "\"
			[ ] sDir = lower (sDir) + "\"
		[+] else
			[ ] sDir = lower (sDir)
		[ ] 
		[ ] return sDir
	[ ] 
	[+] STRING StringParse   (string sSearchStr, string sSeparator, integer iPosition optional)
		[ ] // ============================================
		[+] // FUNCTION: StringParse()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //	parses a string with a given separator returns a string segment given by the
			[ ] //  position of the sub string if no position is passed in, it defaults to last segment
			[ ] //	the 1st position is the 1st segment, 2nd is after separator
			[ ] //
			[ ] // PARAMETERS:	rSystemTime SystemTime	system date/time record
			[ ] //
			[ ] // RETURNS:		Sub String requested 
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] integer iSepLength = len (sSeparator)
		[ ] integer iStringPos = 1
		[ ] integer iIndex
		[ ] string 	sReturnStr
		[ ] 
		[+] if iPosition == NULL
			[+] while iStringPos != 0
				[ ] iStringPos = StrPos (sSeparator, sSearchStr)
				[ ] 
				[ ] sSearchStr = SubStr (sSearchStr, iStringPos + iSepLength)
			[ ] 
			[ ] return sSearchStr
		[+] else
			[+] for iIndex = 1 to iPosition
				[ ] iStringPos = StrPos (sSeparator, sSearchStr)
				[ ] 
				[+] if iStringPos != 0
					[ ] sReturnStr = left 	(sSearchStr, iStringPos - 1)
					[ ] 
					[ ] sSearchStr = SubStr (sSearchStr, iStringPos + iSepLength)
					[ ] 
				[+] else
					[ ] 
					[ ] return sSearchStr
			[ ] 
			[ ] return sReturnStr
		[ ] 
		[ ] 
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[ ] // ==========================================================
[-] // TIMER FUNCTIONS 
	[ ] 
	[+] HTIMER StartPerfTimer()
		[ ] // ============================================
		[+] // FUNCTION: StartPerfTimer()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function creates a performance timer, starts the timer, and returns a
			[ ] // handle to the timer.
			[ ] //
			[ ] // PARAMETERS:	none
			[ ] //
			[ ] // RETURNS:		HTIMER	handle of performance timer
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] HTIMER hPerfTimer = TimerCreate()			// initialize performance timer
		[ ] TimerStart(hPerfTimer)						// start performance timer
		[ ] return hPerfTimer
		[ ] 
		[ ] 
	[ ] 
	[+] VOID PausePerfTimer(HTIMER hPerfTimer)
		[ ] // ============================================
		[+] // FUNCTION: PausePerfTimer()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function pauses a running performance timer (passed in hPerfTimer).
			[ ] //
			[ ] // PARAMETERS:	HTIMER	hPerfTimer	handle of performance timer
			[ ] //
			[ ] // RETURNS:		none
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[+] if (TimerState(hPerfTimer) == TS_STARTED)
			[ ] TimerPause(hPerfTimer)
		[ ] 
		[ ] 
	[ ] 
	[+] VOID ResumePerfTimer(HTIMER hPerfTimer)
		[ ] // ============================================
		[+] // FUNCTION: ResumePerfTimer()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function resumes a paused performance timer (passed in hPerfTimer).
			[ ] //
			[ ] // PARAMETERS:	HTIMER	hPerfTimer	handle of performance timer
			[ ] //
			[ ] // RETURNS:		none
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[+] if (TimerState(hPerfTimer) == TS_PAUSED)
			[ ] TimerResume(hPerfTimer)
		[ ] 
		[ ] 
	[ ] 
	[+] REAL StopPerfTimer(HTIMER hPerfTimer)
		[ ] // ============================================
		[+] // FUNCTION: StopPerfTimer()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function halts the performance timer (passed in hPerfTimer), reads the timer
			[ ] // value, and destroys the timer. The timer value (measured in seconds) is returned as
			[ ] // a REAL number.
			[ ] //
			[ ] // PARAMETERS:	HTIMER	hPerfTimer	handle of performance timer
			[ ] //
			[ ] // RETURNS:		REAL	performance timer value (in seconds)
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] REAL rPerfTime								// performance time result
		[ ] TimerStop(hPerfTimer)						// stop performance timer
		[ ] rPerfTime = TimerValue(hPerfTimer)			// save result time
		[ ] TimerDestroy(hPerfTimer)					// destroy performance timer
		[ ] return rPerfTime							//...return result time
		[ ] 
		[ ] 
	[ ] 
	[+] VOID SetTime(rSystemTime SystemTime)
		[ ] // ============================================
		[-] // FUNCTION: SetTime()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function sets the date and time on the current machine.
			[ ] //
			[ ] // PARAMETERS:	rSystemTime SystemTime	system date/time record
			[ ] //
			[ ] // RETURNS:		none
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] SetSystemTime(SystemTime)
		[ ] 
	[ ] 
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] // *************************************************************************************
[ ] //	END OF INCLUDE FILE
[ ] // *************************************************************************************
[ ] 
