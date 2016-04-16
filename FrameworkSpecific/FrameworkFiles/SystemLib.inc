[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	SystemLib.INC
[-] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file contains the system library functions
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
[-] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[-] // COMMON SYSTEM REGISTRY FUNCTIONS
	[ ] 
	[+] BOOLEAN	RegValueExists(INTEGER iKey, STRING sPath, STRING sItem optional)
		[ ] // ============================================
		[+] // FUNCTION: RegValueExists()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function tests for the existence of the specified path to a data value, and
			[ ] // the data value itself (if specified) within the system registry at the specified
			[ ] // registry key. The result is returned as a BOOLEAN value.
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey	registry key
			[ ] //				STRING	sPath	path to item through registry hierarchy
			[ ] //				STRING	sItem	name of data value to verify (optional)
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = registry value (or path) exists in registry
			[ ] //							FALSE = registry value undefined
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[+] if (sItem == NULL)
			[ ] sItem = BLANK_STR
		[+] do
			[ ] STRING sRes = SYS_GetRegistryValue(iKey, sPath, sItem)
			[ ] return TRUE
		[+] except
			[ ] return FALSE
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN	RegSetValue(INTEGER iKey, STRING sPath, STRING sItem, STRING sValue)
		[ ] // ============================================
		[+] // FUNCTION: RegSetValue()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] // 		RegSetValue sets values of existing registry items but does not create
			[ ] // new registry items. If the data or item do not exist in the system registry at
			[ ] // the specified registry key, this function returns a boolean result of FALSE.
			[ ] //
			[ ] // RegSetValue supports these three data types: REG_SZ (string), REG_DWORD (4-byte
			[ ] // binary value), and REG_BINARY (binary value of arbitrary length). If you want to
			[ ] // set an item that has a value of type REG_BINARY or REG_DWORD, then you must format
			[ ] // the value within a string that includes the data type prefix, as shown in the
			[ ] // following examples:
			[ ] //		"REG_BINARY: 14 00 00 7e 8f 99 33 22 08 00 07 00 06"
			[ ] //		"REG_DWORD: 0x00008f7e"
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey	registry key
			[ ] //				STRING	sPath	path to item through registry hierarchy
			[ ] //				STRING	sItem	name of data value to be set
			[ ] //				STRING	sValue	value to be set
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = registry value (or path) exists in registry
			[ ] //							FALSE = registry value undefined
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[+] if RegValueExists(iKey, sPath, sItem)
			[ ] SYS_SetRegistryValue(iKey, sPath, sItem, sValue)
			[ ] return TRUE
		[+] else
			[ ] return FALSE
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN	RegCreateValue(INTEGER iKey, STRING sPath, STRING sItem optional, ANYTYPE aValue optional)
		[ ] // ============================================
		[+] // FUNCTION: RegCreateValue()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function creates the specified registry key if it does not already exist,
			[ ] // and creates the optionally specified value item, setting it to the specified
			[ ] // STRING, DWORD, or BINARY value.
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey	registry key
			[ ] //				STRING	sPath	path to item through registry hierarchy
			[ ] //				STRING	sItem	name of data value to be set (optional)
			[ ] //				ANYTYPE	aValue	STRING or DWORD value to be set (optional)
			[ ] // RETURNS:		BOOLEAN		TRUE  = registry value created and set successfully
			[ ] //							FALSE = registry value could not be created
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] LONG	hKey, lDisposition, lError, lValue, lenData
		[ ] STRING	sValue = BLANK_STR
		[ ] BOOLEAN	bRes = FALSE
		[ ] lError = RegCreateKeyEx(iKey, sPath, 0, BLANK_STR, 0, KEY_WRITE, 0, hKey, lDisposition)
		[+] if (lError != 0)
			[ ] Log.Error("Could not create registry key {GetRegKeyName(iKey)}\{sPath}.")
		[+] else if ((aValue != NULL) && (sItem != NULL))
			[+] if (TypeOf(aValue) == STRING)
				[ ] sValue	= aValue + CHR_NUL
				[+] if (StrPos(sREG_BIN, sValue) > 0)
					[ ] lValue	= 0
					[ ] lenData	= 4
					[ ] lError	= RegSetLongValue(hKey, sItem, 0, REG_BINARY, lValue, lenData)
				[+] else if (StrPos(sREG_DWORD, sValue) > 0)
					[ ] lValue	= 0
					[ ] lenData	= 4
					[ ] lError	= RegSetLongValue(hKey, sItem, 0, REG_DWORD, lValue, lenData)
				[+] else
					[ ] lenData	= Len(sValue)
					[ ] lError	= RegSetStringValue(hKey, sItem, 0, REG_SZ, sValue, lenData)
			[+] else
				[ ] lValue	= aValue
				[ ] lenData	= 4
				[ ] lError	= RegSetLongValue(hKey, sItem, 0, REG_DWORD, lValue, lenData)
			[+] if (lError != 0)
				[ ] Log.Error("Could not set value of registry key {GetRegKeyName(iKey)}\{sPath}\{sItem} to {aValue}.")
			[+] else
				[ ] bRes = TRUE
		[ ] RegCloseKey(hKey)
		[+] if bRes && ((StrPos(sREG_BIN, sValue) > 0) || (StrPos(sREG_DWORD, sValue) > 0))
			[ ] bRes = RegSetValue(iKey, sPath, sItem, sValue)
		[ ] return bRes
		[ ] 
		[ ] 
	[ ] 
	[+] STRING RegGetValue(INTEGER iKey, STRING sPath, STRING sItem)
		[ ] // ============================================
		[+] // FUNCTION: RegGetValue()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] // 		RegGetValue supports these three data types: REG_SZ (string), REG_DWORD
			[ ] // (4-byte binary value), and REG_BINARY (binary value of arbitrary length). Retrieved
			[ ] // REG_BINARY and REG_DWORD values are formatted within a string which includes the
			[ ] // data type prefix, as shown in the following examples:
			[ ] //		"REG_BINARY: 14 00 00 7e 8f 99 33 22 08 00 07 00 06"
			[ ] //		"REG_DWORD: 0x00008f7e"
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey	registry key
			[ ] //				STRING	sPath	path to item through registry hierarchy
			[ ] //				STRING	sItem	name of data value to be retrieved
			[ ] //
			[ ] // RETURNS:		STRING	data retrieved from registry
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[+] if RegValueExists(iKey, sPath, sItem)
			[ ] return SYS_GetRegistryValue(iKey, sPath, sItem)
		[+] else
			[ ] return NULL
		[ ] 
		[ ] 
	[ ] 
	[+] VOID RegKeyDelete(INTEGER iKey, STRING sPath)
		[ ] // ============================================
		[+] // FUNCTION: RegKeyDelete()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function deletes the specified registry subkey if it exists.
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey	registry key
			[ ] //				STRING	sPath	path to item through registry hierarchy
			[ ] //
			[ ] // RETURNS:		none
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[+] if RegValueExists(iKey, sPath)
			[ ] RegDeleteKey(iKey, sPath)
		[ ] 
		[ ] 
	[ ] 
	[+] VOID RegValueDelete(INTEGER iKey, STRING sPath, STRING sItem)
		[ ] // ============================================
		[+] // FUNCTION: RegValueDelete()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function deletes the specified registry value if it exists.
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey	registry key
			[ ] //				STRING	sPath	path to item through registry hierarchy
			[ ] //				STRING	sItem	name of data value to delete
			[ ] //
			[ ] // RETURNS:		none
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] LONG	hKey
		[+] if RegValueExists(iKey, sPath, sItem)
			[ ] RegOpenKeyEx(iKey, sPath, 0, KEY_WRITE, hKey)
			[ ] RegDeleteValue(hKey, sItem)
			[ ] RegCloseKey(hKey)
		[ ] 
		[ ] 
	[ ] 
	[+] VOID RegKeyCopy(INTEGER iKey, STRING sExistingPath, STRING sNewPath)
		[ ] // ============================================
		[+] // FUNCTION: RegKeyCopy()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function copies all values and subkeys within the specified registry
			[ ] // key and path to a new path within the same key.
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey			registry key
			[ ] //				STRING	sExistingPath	path to items through registry hierarchy
			[ ] //				STRING	sNewPath		new path to be created
			[ ] // RETURNS:		none
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] STRING	sValItem, sValue, sKey
		[ ] LIST OF STRING	lsSubKeys	= RegKeyEnumerate(iKey, sExistingPath)
		[ ] LIST OF STRING	lsValues	= RegValueEnumerate(iKey, sExistingPath)
		[ ] RegCreateValue(iKey, sNewPath)
		[+] for each sValItem in lsValues
			[ ] sValue = RegGetValue(iKey, sExistingPath, sValItem)
			[ ] RegCreateValue(iKey, sNewPath, sValItem, sValue)
		[+] for each sKey in lsSubKeys
			[ ] RegKeyCopy(iKey, "{sExistingPath}\{sKey}", "{sNewPath}\{sKey}")
		[ ] 
		[ ] 
	[ ] 
	[+] VOID RegKeyReplace(INTEGER iKey, STRING sExistingPath, STRING sNewPath)
		[ ] // ============================================
		[+] // FUNCTION: RegKeyReplace()
			[ ] //
			[ ] // Description:
			[ ] //   This function copies all values and subkeys within the specified registry
			[ ] // key and path to a new path within the same key, and then deletes the original
			[ ] // registry path.
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey			registry key
			[ ] //				STRING	sExistingPath	path to items through registry hierarchy
			[ ] //				STRING	sNewPath		new path to be created
			[ ] //
			[ ] // RETURNS:		none
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] RegKeyCopy(iKey, sExistingPath, sNewPath)
		[ ] RegKeyDelete(iKey, sExistingPath)
		[ ] 
		[ ] 
	[ ] 
	[+] STRING GetRegKeyName(INTEGER iKey)
		[ ] // ============================================
		[+] // FUNCTION: GetRegKeyName()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns the string representation of the registry key specified in
			[ ] // the iKey parameter.
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey	registry key
			[ ] //
			[ ] // RETURNS:		STRING	string representation of registry key
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[+] switch (iKey)
			[+] case HKEY_CLASSES_ROOT
				[ ] return "HKEY_CLASSES_ROOT"
			[+] case HKEY_CURRENT_USER
				[ ] return "HKEY_CURRENT_USER"
			[+] case HKEY_LOCAL_MACHINE
				[ ] return "HKEY_LOCAL_MACHINE"
			[+] case HKEY_USERS
				[ ] return "HKEY_USERS"
			[+] case HKEY_PERFORMANCE_DATA
				[ ] return "HKEY_PERFORMANCE_DATA"
			[+] case HKEY_CURRENT_CONFIG
				[ ] return "HKEY_CURRENT_CONFIG"
			[+] case HKEY_DYN_DATA
				[ ] return "HKEY_DYN_DATA"
			[+] default
				[ ] return NULL
		[ ] 
	[ ] 
	[+] LIST OF STRING RegValueEnumerate(INTEGER iKey, STRING sPath) 
		[ ] // ============================================
		[+] // FUNCTION: RegValueEnumerate()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns a list of all registry values within the specified registry
			[ ] // key and path.
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey	registry key
			[ ] //				STRING	sPath	path to item through registry hierarchy
			[ ] // RETURNS:		LIST OF STRING	values in specified registry key and path
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] LIST OF STRING lsRes
		[ ] LONG	hKey
		[ ] LONG	lenValueName = 1000
		[ ] STRING	sValueName = Replicate(" ", lenValueName)
		[ ] LONG	lenData = 1000
		[ ] STRING	sData = Replicate(" ", lenData)
		[ ] LONG	dwType
		[ ] INTEGER	idx = 0
		[ ] RegOpenKeyEx(iKey, sPath, 0, KEY_READ | KEY_WRITE, hKey)
		[+] while (RegEnumValue(hKey, idx, sValueName, lenValueName, 0, dwType, sData, lenData) == 0)
			[ ] ListAppend(lsRes, sValueName)
			[ ] //Restore everything to its original state 
			[ ] lenValueName = 1000
			[ ] sValueName = Replicate(" ", lenValueName)
			[ ] lenData = 1000
			[ ] sData = Replicate(" ", lenData)
			[ ] ++idx
		[ ] RegCloseKey(hKey)
		[ ] return (lsRes)
		[ ] 
		[ ] 
	[ ] 
	[+] LIST OF STRING RegKeyEnumerate(INTEGER iKey, STRING sPath optional) 
		[ ] // ============================================
		[+] // FUNCTION: RegKeyEnumerate()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns a list of all registry subKeys within the specified registry
			[ ] // key and path.
			[ ] //
			[ ] // PARAMETERS:	INTEGER	iKey	registry key
			[ ] //				STRING	sPath	path to item through registry hierarchy
			[ ] // RETURNS:		LIST OF STRING	subKeys in specified registry key and path
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] LIST OF STRING lsRes
		[ ] LONG	hKey
		[ ] LONG	lenSubKey = 1000
		[ ] STRING	sSubKey = Replicate(" ", lenSubKey)
		[ ] INTEGER	idx = 0
		[ ] STRING	sClass = NULL
		[ ] LONG	lData = NULL
		[ ] RegOpenKeyEx(iKey, sPath, 0, KEY_READ | KEY_WRITE, hKey)
		[+] while (RegEnumKeyEx(hKey, idx, sSubKey, lenSubKey, 0, sClass, lData, lData) == 0)
			[ ] ListAppend(lsRes, sSubKey)
			[ ] //Restore everything to its original state 
			[ ] lenSubKey = 1000
			[ ] sSubKey = Replicate(" ", lenSubKey)
			[ ] ++idx
		[ ] RegCloseKey(hKey)
		[ ] return (lsRes)
		[ ] 
		[ ] 
	[ ] 
	[+] STRING	GetSystemPath ( )
		[ ] // ============================================
		[+] // FUNCTION: GetSystemPath()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //	this function returns windows system path.
			[ ] //
			[ ] // PARAMETERS:	NULL
			[ ] //
			[ ] // RETURNS:		sPath: Windows' System Directory.
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] 
		[ ] string sRtn ="" //Edited By Poonam
		[ ] string sSysPath
		[ ] 
		[ ] sSysPath = Space (145)
		[ ] 
		[+] switch GetGuiType ()
			[-] // case mswdos  //-ommented by poonam
				[ ] // sRtn = trim (left (sSysPath, GetSystemDirectory(sSysPath, len(sSysPath))))
			[-] // case msw95, mswnt, msw9x  //case msw95, mswnt, msw98 //Commented by Poonam
				[ ] // sRtn = trim (left (sSysPath, GetSystemDirectoryA(sSysPath, len(sSysPath))))
		[ ] 
		[ ] ValidDirName (sRtn)
		[ ] return sRtn
		[ ] 
	[ ] 
	[+] INTEGER SYS_GetFreePhysicalMemory()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	iFree = SYS_GetFreePhysicalMemory ()
		[ ] //	returns:	iFree = Bytes of physical memory free.
		[ ] //	notes:		Gets the amount of physical memory free.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return m.dwAvailPhys
	[ ] 
	[+] INTEGER SYS_GetFreePageMemory()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	iFree = SYS_GetFreePageMemory ()
		[ ] //	returns:	iFree = Bytes of paged memory free.
		[ ] //	notes:		Gets the amount of paged memory free.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return m.dwAvailPageFile
		[ ] 
	[ ] 
	[+] INTEGER SYS_GetFreeVirtualMemory()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	iFree = SYS_GetFreeVirtualMemory ()
		[ ] //	returns:	iFree = Bytes of virtual memory free.
		[ ] //	notes:		Gets the amount of virtual memory free.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return m.dwAvailVirtual
	[ ] 
	[+] INTEGER SYS_GetTotalPhysicalMemory()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	iFree = SYS_GetTotalPhysicalMemory ()
		[ ] //	returns:	iFree = Total bytes of physical memory.
		[ ] //	notes:		Gets the total amount of physical memory.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return m.dwTotalPhys
	[ ] 
	[+] INTEGER SYS_GetTotalPageMemory()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	iFree = SYS_GetTotalPageMemory ()
		[ ] //	returns:	iFree = Total bytes of paged memory.
		[ ] //	notes:		Gets the total amount of paged memory.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return m.dwTotalPageFile
	[ ] 
	[+] INTEGER SYS_GetTotalVirtualMemory()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	iFree = SYS_GetTotalVirtualMemory ()
		[ ] //	returns:	iFree = Total bytes of virtual memory.
		[ ] //	notes:		Gets the total amount of virtual memory.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return m.dwTotalVirtual
	[ ] 
	[+] INTEGER SYS_GetFreeMemPct()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	iFree = SYS_GetFreeMemPct ()
		[ ] //	returns:	iFree = Percentage of memory free.
		[ ] //	notes:		Gets the amount of system memory free.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return (100 - m.dwMemoryLoad)
	[ ] 
	[+] REAL SYS_GetFreePhysicalPct()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	rFree = SYS_GetFreePhysicalPct ()
		[ ] //	returns:	rFree = Percent of physical memory free.
		[ ] //	notes:		Gets the percentage of physical memory free.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return (([REAL]m.dwAvailPhys/[REAL]m.dwTotalPhys) * 100)
	[ ] 
	[+] REAL SYS_GetFreePagePct()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	rFree = SYS_GetFreePagePct ()
		[ ] //	returns:	rFree = Percent of paged memory free.
		[ ] //	notes:		Gets the percentage of paged memory free.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return (([REAL]m.dwAvailPageFile/[REAL]m.dwTotalPageFile) * 100)
		[ ] 
	[ ] 
	[+] REAL SYS_GetFreeVirtualPct()
		[ ] //	*****	LIBRARY BROWSER CODE	*****
		[ ] //	function:	rFree = SYS_GetFreeVirtualPct ()
		[ ] //	returns:	rFree = Percent of virtual memory free.
		[ ] //	notes:		Gets the percentage of virtual memory free.
		[ ] 
		[ ] MEMORYSTATUS m
		[ ] 
		[ ] GlobalMemoryStatus (m)
		[ ] 
		[ ] return (([REAL]m.dwAvailVirtual/[REAL]m.dwTotalVirtual) * 100)
	[ ] 
	[+] VOID StartService(STRING sService)
		[ ] // ============================================
		[+] // FUNCTION: StartService()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function use to start windows service
			[ ] //
			[ ] // PARAMETERS:	STRING sServive: Serveice name
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Nov 13, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] 
		[ ] SYS_Execute("NET START ""{sService}""")
		[ ] 
	[ ] 
	[+] VOID StopService(STRING sService)
		[ ] // ============================================
		[+] // FUNCTION: StopService()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function use to stop windows service
			[ ] //
			[ ] // PARAMETERS:	STRING sServive: Serveice name
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Nov 13, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] 
		[ ] SYS_Execute("NET STOP ""{sService}""")
		[ ] 
	[ ] 
	[+] VOID PauseService(STRING sService)
		[ ] // ============================================
		[+] // FUNCTION: PauseService()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function use to pause windows service
			[ ] //
			[ ] // PARAMETERS:	STRING sServive: Serveice name
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Nov 13, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] 
		[ ] SYS_Execute("NET PAUSE ""{sService}""")
		[ ] 
	[ ] 
	[+] LIST OF STRING GetNotRespondingServices()
		[ ] // ============================================
		[+] // FUNCTION: PauseService()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function use to pause windows service
			[ ] //
			[ ] // PARAMETERS:	STRING sServive: Serveice name
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Nov 13, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] 
		[ ] LIST OF STRING lsOutPut
		[ ] SYS_Execute("TASKLIST /FI ""status eq not responding""", lsOutPut)
		[ ] return lsOutPut
		[ ]  
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[ ] // *************************************************************************************
[ ] //	END OF INCLUDE FILE
[ ] // *************************************************************************************
[ ] 
