[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	FileLib.INC
[+] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file contains the generic functions and AUT specific
	[ ] // functions.
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
[-] // DLL CALLS
	[ ] 
	[-] dll "kernel32.dll"
		[ ] LONG	GetFileAttribs(STRING lpFileName) alias "GetFileAttributesA"
		[ ] LONG	SetFileAttribs(STRING lpFileName, LONG dwAttributes) alias "SetFileAttributesA"
		[ ] LONG 	SetSystemTime(in rSystemTime rTime)
		[ ] GetSystemTime(inout rSystemTime rTime)
		[ ] INT	GetWindowsDirectoryA(inout string sPath, INT iS)
		[ ] INT	GetSystemDirectoryA (inout string sPath, INT iSize)
		[ ] 
		[ ] DWORD 	GetFileAttributesA	(LPCSTR lpFileName)
		[ ] BOOL 	SetFileAttributesA	(LPCSTR lpFileName, DWORD dwFileAttributes) 
		[ ] BOOL 	GetFileTime			(long hFile,out FILETIME lpCreationTime, out FILETIME lpLastAccessTime, out FILETIME lpLastWriteTime)
		[ ] long 	CreateFileA			(LPCSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode, out LPSECURITY lpSecurityAttributes, DWORD dwCreationDistribution, DWORD dwFlagsAndAttributes, long hTemplateFile )
		[ ] BOOL 	CloseHandle			(long hObject) 
		[ ] 
		[ ] BOOL 	FileTimeToLocalFileTime(out FILETIME lpFileTime, out FILETIME lpLocalFileTime)
		[ ] BOOL 	FileTimeToSystemTime(out FILETIME lpFileTime, out SYSTEMTIME lpSystemTime) 
		[ ] 
		[ ] VOID GlobalMemoryStatus (inout MEMORYSTATUS lpBuffer)
	[ ] 
	[+] dll "advapi32.dll"
		[ ] LONG 	RegCloseKey(LONG hKey)
		[ ] LONG 	RegOpenKeyEx(LONG hKey, STRING lpSubKey optional, LONG ulOptions, LONG samDesired, out LONG phkResult) alias "RegOpenKeyExA"
		[ ] LONG 	RegDeleteValue(LONG hKey, STRING lpValueName) alias "RegDeleteValueA"
		[ ] LONG 	RegCreateKeyEx(LONG hKey, STRING lpSubKey, LONG Reserved, STRING lpClass, LONG dwOptions, LONG samDesired, LONG lpSecurityAttributes, out LONG phkResult, out LONG lpdwDisposition) alias "RegCreateKeyExA"
		[ ] LONG 	RegDeleteKey(LONG hKey, STRING lpSubKey) alias "RegDeleteKeyA"
		[ ] LONG 	RegEnumValue(LONG hKey, LONG dwIndex, out STRING lpValueName, out LONG lpcbValueName, LONG lpReserved, out LONG lpType, out STRING lpData, out LONG lpcbData) alias "RegEnumValueA"
		[ ] LONG 	RegEnumKeyEx(LONG hKey, LONG dwIndex, out STRING lpName, out LONG lpcbName, LONG lpReserved, out STRING lpClass, out LONG lpcbClass, out LONG lpcbData) alias "RegEnumKeyExA"
		[ ] LONG 	RegSaveKey(LONG hKey, STRING lpFile, LONG lpSecurityAttributes) alias "RegSaveKeyA"
		[ ] LONG 	RegRestoreKey(LONG hKey, STRING lpFile, LONG dwFlags) alias "RegRestoreKeyA"
		[ ] LONG 	RegSetStringValue(LONG hKey, STRING lpValueName, LONG Reserved, LONG dwType, STRING lpData, LONG cbData) alias "RegSetValueExA"
		[ ] LONG 	RegSetLongValue(LONG hKey, STRING lpValueName, LONG Reserved, LONG dwType, out LONG lpData, LONG cbData) alias "RegSetValueExA"
	[ ] 
	[+] dll	"kernel"
		[ ] INT		GetWindowsDirectory (inout string sPath, INT iS)
		[ ] INT		GetSystemDirectory (inout string sPath, INT iSize)
		[ ] 
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[-] // RECORD TYPE DECLARATIONS
	[ ] 
	[-] type rWinStates is record	
		[ ] // Window presence data record	
		[ ] WINDOW	wTarget						// target window
		[ ] BOOLEAN	bExists						// target existence state (TRUE = window exists)
	[ ] 
	[-] type DB_Data is record
		[ ] STRING sFeatureName
		[ ] STRING sExecute
		[ ] STRING sDataFile
	[ ] 
	[-] type rSystemTime is record				// System time data record
		[ ] WORD	wYear
		[ ] WORD	wMonth
		[ ] WORD	wDayOfWeek
		[ ] WORD	wDay
		[ ] WORD	wHour
		[ ] WORD	wMinute
		[ ] WORD	wSecond
		[ ] WORD	wMilliseconds
		[ ] 
	[ ] 
	[-] type REG_VAL_TYPE is enum		// Predefined Registry value types
		[ ] REG_NONE = 0							// No value type
		[ ] REG_SZ									// Unicode null terminated string
		[ ] REG_EXPAND_SZ							// Unicode null terminated string
		[ ] REG_BINARY								// Free form binary
		[ ] REG_DWORD								// 32-bit number
		[ ] REG_DWORD_BIG_ENDIAN					// 32-bit number
		[ ] REG_LINK								// Symbolic Link (unicode)
		[ ] REG_MULTI_SZ							// Multiple Unicode strings
		[ ] REG_RESOURCE_LIST						// Resource list in the resource map
		[ ] REG_FULL_RESOURCE_DESCRIPTOR			// Resource list in the hardware description
		[ ] 
		[ ] 
	[ ] 
	[-] type FILETIME is record
		[ ] long dwLowDateTime
		[ ] long dwHighDateTime
	[ ] 
	[-] type SYSTEMTIME is record
		[ ] WORD wYear
		[ ] WORD wMonth
		[ ] WORD wDayOfWeek
		[ ] WORD wDay
		[ ] WORD wHour
		[ ] WORD wMinute
		[ ] WORD wSecond
		[ ] WORD wMilliseconds
	[ ] 
	[ ] type LPFILETIME is STRING
	[ ] 
	[ ] type LPSECURITY is long
	[ ] 
	[-] type MouseButton is enum
		[ ] MOUSE_LEFT = 1
		[ ] MOUSE_RIGHT
		[ ] MOUSE_CENTER
	[ ] 
	[-] type MEMORYSTATUS is record
		[ ] DWORD dwLength        // sizeof(MEMORYSTATUS) 
		[ ] DWORD dwMemoryLoad    // percent of memory in use 
		[ ] DWORD dwTotalPhys     // bytes of physical memory 
		[ ] DWORD dwAvailPhys     // free physical memory bytes 
		[ ] DWORD dwTotalPageFile // bytes of paging file 
		[ ] DWORD dwAvailPageFile // free bytes of paging file 
		[ ] DWORD dwTotalVirtual  // user bytes of address space 
		[ ] DWORD dwAvailVirtual  // free user bytes 
	[ ] 
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[-] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[+] // FILE LIBRARY FUNCTIONS 
	[ ] 
	[+] BOOLEAN	CompareFiles(STRING sActual, STRING sExpected)
		[ ] // ==========================================================
		[+] // FUNCTION: CompareFiles()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function performs a binary comparison of a baseline file (in sExpected) with
			[ ] // the file specified in sActual, and returns a boolean result of TRUE if the files are
			[ ] // same.
			[ ] 
			[ ] // PARAMETERS:	STRING		sActual		file to compare
			[ ] //				STRING		sExpected	baseline file
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = files are the same
			[ ] //							FALSE = files do not match
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 25, 2006	Bhagwat Kolde created
			[ ] 
		[ ] // ==========================================================
		[ ] BOOLEAN	bRes = FALSE
		[ ] BOOLEAN	bActual   = SYS_FileExists(sActual)
		[ ] BOOLEAN	bExpected = SYS_FileExists(sExpected)
		[+] if !(bActual)
			[ ] Log.Error("File '{sActual}' was not found.")
		[+] if !(bExpected)
			[ ] Log.Error("File '{sExpected}' was not found.")
		[+] if (bActual && bExpected)
			[ ] bRes = SYS_CompareBinary(sActual, sExpected)
		[ ] return bRes
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN	CopyFile(STRING sSrc, STRING sTarget)
		[ ] // ==========================================================
		[+] // FUNCTION: CopyFile()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function copies the source file (sSrc) to a target file (sTarget), deleting
			[ ] // any preexisting file with the same name as the target. A boolean result of TRUE is
			[ ] // returned if the file was successfully copied.
			[ ] //
			[ ] // PARAMETERS:	STRING		sSrc		path of file to copy
			[ ] //				STRING		sTarget		destination file path
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = file successfully copied
			[ ] //							FALSE = file could not be created
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 25, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] DeleteFile(sTarget)
		[+] do
			[ ] SYS_CopyFile(sSrc, sTarget)
		[+] except
			[ ] ExceptLog()
		[ ] return SYS_FileExists(sTarget)
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN	DeleteFile(STRING sTarget)
		[ ] // ==========================================================
		[+] // FUNCTION: DeleteFile()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function checks for the existence of the specified file (sTarget) and
			[ ] // deletes the file if it is found. 
			[ ] //
			[ ] // PARAMETERS:	STRING		sTarget		path of file to delete
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = file successfully deleted
			[ ] //							FALSE = file could not be deleted
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 25, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[+] if SYS_FileExists(sTarget)
			[ ] //SetFileAttributes(sTarget, FILE_ATTRIB_NORMAL)	// unlock file
			[ ] //added by sandeep: This command will first change the file attribute to write.
			[ ] SYS_Execute("attrib -r  {sTarget} ")
			[+] do
				[ ] SYS_RemoveFile(sTarget)							// delete file
			[+] except
				[ ] ExceptLog()
		[ ] return !SYS_FileExists(sTarget)
		[ ] 
		[ ] 
	[ ] 
	[+] VOID SplitPath(STRING sFilePath, out STRING sDrive, out STRING sDir, out STRING sFile, out STRING sExt)
		[ ] // ==========================================================
		[+] // FUNCTION: SplitPath()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function splits a given path into its respective components. The drive
			[ ] // specification is returned in sDrive. The directory path is returned in sDir. The
			[ ] // base filename is returned in sFile. The extension is returned in sExt.
			[ ] //
			[ ] // PARAMETERS:	STRING	sFilePath	file path string
			[ ] //			out	STRING	sDrive		returns drive specifier
			[ ] //			out	STRING	sDir		returns directory path
			[ ] //			out	STRING	sFile		returns file name
			[ ] //			out	STRING	sExt		returns file extension
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 8, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] STRING	sTemp	= BLANK_STR
		[ ] STRING	sRemain = sFilePath
		[ ] // parse and return drive specifier
		[ ] INTEGER	iPos	= StrPos(":\", sFilePath)
		[+] if (iPos > 0)
			[ ] sDrive	= Upper(Left(sFilePath, (iPos - 1)))
			[ ] sRemain = SubStr(sRemain, (iPos + 2))
		[+] else
			[+] if (StrPos("\\", sFilePath) == 1)
				[ ] sRemain	= SubStr(sRemain, 3)
				[ ] iPos	= StrPos("\", sRemain)
				[+] if (iPos > 0)
					[ ] sDrive = Left(sRemain, (iPos - 1))
					[ ] sRemain = SubStr(sRemain, (iPos + 1))
				[+] else
					[ ] sDrive	= BLANK_STR
			[+] else
				[ ] sDrive	= BLANK_STR
		[ ] // parse and return directory path
		[ ] iPos = 1
		[+] while (iPos > 0)
			[ ] iPos = StrPos("\", sRemain)
			[+] if (iPos > 0)
				[ ] sTemp	= sTemp + Left(sRemain, iPos)
				[ ] sRemain	= SubStr(sRemain, (iPos + 1))
		[ ] sDir = sTemp
		[ ] // parse and return file name and extension
		[ ] sTemp = BLANK_STR
		[ ] iPos = 1
		[+] while (iPos > 0)
			[ ] iPos = StrPos(".", sRemain)
			[+] if (iPos > 0)
				[ ] sTemp	= sTemp + Left(sRemain, iPos)
				[ ] sRemain = SubStr(sRemain, (iPos + 1))
		[+] if (Len(sTemp) > 0)
			[+] if (sTemp[Len(sTemp)] == ".")
				[ ] sTemp = Left(sTemp, (Len(sTemp) - 1))
			[ ] sFile = sTemp
			[+] if (sRemain != BLANK_STR)
				[ ] sRemain = "." + sRemain
			[ ] sExt = sRemain
		[+] else
			[ ] sFile = sRemain
			[ ] sExt = BLANK_STR
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN	CopyFileVerify(STRING sSrc, STRING sTarget)
		[ ] // ============================================
		[+] // FUNCTION: CopyFileVerify()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function copies the source file (sSrc) to a target file (sTarget), and
			[ ] // compares the copy with the original on the target. A boolean result of TRUE is
			[ ] // returned if the file was successfully copied.
			[ ] //
			[ ] // PARAMETERS:	STRING		sSrc		name of file to copy
			[ ] //				STRING		sTarget		name of file to copy to.
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = file successfully copied
			[ ] //							FALSE = file could not be created
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Jan 18, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] BOOLEAN bRes = TRUE
		[+] if !(CopyFile(sSrc, sTarget))
			[ ] Log.Error("Source file {sSrc} could not be copied to {sTarget}.")
			[ ] bRes = FALSE
		[+] else
			[+] if !(CompareFiles(sSrc, sTarget))
				[ ] Log.Error("Copied file {sTarget} does not match source file {sSrc}.")
				[ ] bRes = FALSE
		[ ] return bRes
		[ ] 
		[ ] 
	[ ] 
	[+] INTEGER	GetFileSize(STRING sTarget)
		[ ] // ============================================
		[+] // FUNCTION: GetFileSize()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns the file size (in bytes) of the target file specified in
			[ ] // sTarget. If the target file does not exist, or cannot be accessed due to a sharing
			[ ] // violation, NULL is returned.
			[ ] //
			[ ] // PARAMETERS:	STRING		sTarget		target file path
			[ ] //
			[ ] // RETURNS:		INTEGER		file size in bytes (or NULL if file does not exist)
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 19, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] INTEGER	iSize = NULL
		[+] if SYS_FileExists(sTarget)
			[ ] INTEGER iCount
			[ ] STRING	sFile = Upper(GetFullFileName(sTarget))
			[ ] LIST OF FILEINFO lfFiles = SYS_GetDirContents(GetDirPath(sTarget))
			[+] for iCount = 1 to ListCount(lfFiles)
				[+] if (Upper(lfFiles[iCount].sName) == sFile)
					[ ] iSize = lfFiles[iCount].iSize
					[ ] break
		[ ] return iSize
		[ ] 
		[ ] 
	[ ] 
	[+] STRING GetFullFileName(STRING sFilePath)
		[ ] // ============================================
		[+] // FUNCTION: GetFullFileName()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns the complete file name and extension specifier contained
			[ ] // in a file path string.
			[ ] //
			[ ] // PARAMETERS:	STRING	sFilePath		file path string
			[ ] //
			[ ] // RETURNS:		STRING	file name with extension
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 19, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] STRING	sDummy
		[ ] STRING	sFile
		[ ] STRING	sExt
		[ ] SplitPath(sFilePath, sDummy, sDummy, sFile, sExt)
		[ ] return (sFile + sExt)			// return file name and extension
		[ ] 
		[ ] 
	[ ] 
	[+] LIST OF STRING FindFiles(STRING sPath, STRING sPattern, BOOLEAN bRecurse optional)
		[ ] // ============================================
		[+] // FUNCTION: FindFiles()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns a list of files matching a pattern (specified in sPattern)
			[ ] // in a directory or directory tree (specified in sPath). If bRecurse is TRUE (or
			[ ] // unspecified), all subdirectories will be searched as well.
			[ ] //
			[ ] // PARAMETERS:	STRING	sPath		path of directory to search
			[ ] //				STRING	sPattern	Pattern to look for, including wildcards
			[ ] //				BOOLEAN	bRecurse	TRUE (or NULL) = search all subdirectories
			[ ] //									FALSE = search only root directory
			[ ] // RETURNS:		LIST OF STRING		a list of files matching specified pattern
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 19, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] LIST OF FILEINFO lfFiles
		[ ] FILEINFO f
		[ ] LIST OF STRING lsDirs
		[ ] LIST OF STRING lsRtn
		[+] if (bRecurse == NULL)
			[ ] bRecurse = TRUE
		[+] if (SYS_DirExists(sPath))		// verify path exists
			[ ] lsDirs = {sPath}				// add the current path to the list of paths
			[+] while (ListCount(lsDirs))		// while there are still directories to check
				[ ] sPath = lsDirs[1]				// use first directory in list
				[+] if (Right(sPath, 1) != "\")		// repair path string (if necessary)
					[ ] sPath = sPath + "\"
				[ ] lfFiles = SYS_GetDirContents(sPath)
				[+] for each f in lfFiles
					[ ] // if directory and sub directories to be checked...
					[+] if (f.bIsDir) && (bRecurse)
						[ ] ListAppend(lsDirs, sPath + f.sName)	// add to list of directories
						[ ] continue							// next item in the loop
					[+] if (MatchStr(sPattern, f.sName))
						[ ] ListAppend(lsRtn, sPath + f.sName)
				[ ] ListDelete(lsDirs, 1)			// remove directory just checked
		[+] else							//path doesn't exist so post error
			[ ] Log.Error("Path '{sPath}' does not exist.")
		[ ] return lsRtn					// return results
		[ ] 
		[ ] 
	[ ] 
	[+] STRING	GetDriveLetter(STRING sDrive)
		[ ] // ============================================
		[+] // FUNCTION: GetDriveLetter()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns the drive letter only from a drive specifier formatted
			[ ] // as DRIVE_LETTER:\ or DRIVE_LETTER: .
			[ ] //
			[ ] // PARAMETERS:	STRING	sDrive drive specifier ( i.e.; "C:\" )
			[ ] // RETURNS:		STRING	drive letter ( i.e.; "C" )
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 19, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] return GetField(sDrive,":",1)
		[ ] 
	[ ] 
	[+] BOOLEAN	DeleteDir(STRING sPath)
		[ ] // ============================================
		[+] // FUNCTION: DeleteDir()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function checks for the existence of the specified directory (sPath) and
			[ ] // deletes the directory (and it's contents) if it is found. A boolean result of TRUE
			[ ] // is returned if the directory was successfully deleted.
			[ ] //
			[ ] // PARAMETERS:	STRING		sPath	path of directory to delete
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = directory successfully deleted
			[ ] //							FALSE = directory could not be deleted
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 5, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[+] if SYS_DirExists(sPath)
			[ ] FILEINFO fFile
			[ ] STRING sTarget
			[+] for each fFile in SYS_GetDirContents(sPath)
				[ ] sTarget = sPath + "\" + fFile.sName
				[+] if fFile.bIsDir
					[ ] SYS_Execute("attrib -r  {sTarget} ")
					[ ] DeleteDir(sTarget)
				[+] else
					[+] if !(DeleteFile(sTarget))
						[ ] Log.Error("Delete dir", "File '{sTarget}' could not be deleted.")
			[ ] SYS_RemoveDir(sPath)
		[ ] return !SYS_DirExists(sPath)
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN	MakeDir(STRING sPath)
		[ ] // ============================================
		[+] // FUNCTION: MakeDir()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function creates the complete directory path specified in sPath. A
			[ ] // boolean result of TRUE is returned if the directory was successfully created.
			[ ] //
			[ ] // PARAMETERS:	STRING		sPath	path of directory to create
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = directory successfully created
			[ ] //							FALSE = directory could not be created
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 5, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[+] if !SYS_DirExists(sPath)
			[+] do
				[ ] SYS_MakeDir(sPath)
			[+] except
				[ ] STRING sDirPath = GetDirPath(sPath)
				[+] if (Right(sDirPath, 1) == "\")
					[ ] sDirPath = Left(sDirPath, Len(sDirPath) - 1)
				[+] if MakeDir(sDirPath)
					[ ] MakeDir(sPath)
		[ ] return SYS_DirExists(sPath)
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN	CopyDir(STRING sSrc, STRING sTarget)
		[ ] // ============================================
		[+] // FUNCTION: CopyDir()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function copies the contents of the source directory (sSrc) to a target
			[ ] // directory (sTarget), deleting any preexisting files with the same name as the target.
			[ ] // A boolean result of TRUE is returned if the directory was successfully copied.
			[ ] //
			[ ] // PARAMETERS:	STRING		sSrc		path of directory to copy
			[ ] //				STRING		sTarget		path of directory to copy to.
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = directory successfully copied
			[ ] //							FALSE = directory could not be created
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 5, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] FILEINFO fFile
		[ ] Sleep(RandReal() * 3.5)
		[+] if !MakeDir(sTarget)
			[ ] Log.Error("Could not create directory '{sTarget}'.")
		[+] else
			[+] for each fFile in SYS_GetDirContents(sSrc)
				[ ] STRING	sFrom = sSrc
				[ ] STRING	sTo   = sTarget
				[+] if (GetDir(sSrc) != BLANK_STR)
					[ ] sFrom = sFrom + "\"
				[ ] sFrom = sFrom + fFile.sName
				[+] if (GetDir(sTarget) != BLANK_STR)
					[ ] sTo = sTo + "\"
				[ ] sTo = sTo + fFile.sName
				[+] if fFile.bIsDir
					[ ] CopyDir(sFrom, sTo)
				[+] else
					[+] if !CopyFile(sFrom, sTo)
						[ ] Log.Error("File '{sFrom}' could not be copied to '{sTo}'.")
		[ ] return SYS_DirExists(sTarget)
		[ ] 
		[ ] 
	[ ] 
	[+] STRING	GetDir(STRING sFilePath)
		[ ] // ============================================
		[+] // FUNCTION: GetDir()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns the directory path without the drive, file name, and
			[ ] // extension specifiers contained in a file path string.
			[ ] //
			[ ] // PARAMETERS:	STRING	sFilePath		file path string
			[ ] //
			[ ] // RETURNS:		STRING	directory path (without drive and file specifiers)
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 7, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] STRING	sDummy
		[ ] STRING	sDir
		[ ] SplitPath(sFilePath, sDummy, sDir, sDummy, sDummy)
		[ ] return sDir						// return directory path
		[ ] 
		[ ] 
	[ ] 
	[+] LIST OF STRING GetDirTree(STRING sPath)
		[ ] // ============================================
		[+] // FUNCTION: GetDirTree()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns all of the paths in a directory tree specified in sPath.
			[ ] //
			[ ] // PARAMETERS:	STRING	sPath		path of directory to parse
			[ ] //
			[ ] // RETURNS:		LIST OF STRING		list of all directories in tree
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 7, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] LIST OF FILEINFO lfFiles
		[ ] FILEINFO f
		[ ] LIST OF STRING lsDirs = {}
		[ ] LIST OF STRING lsRtn = {}
		[+] if (SYS_DirExists(sPath))
			[ ] lsDirs	= {sPath}					// add current path to list of paths
			[ ] lsRtn	= {sPath}					// add search path to return value
			[+] while (ListCount(lsDirs))			// while there are still directories to check
				[ ] sPath = lsDirs[1]					// use the first one in there
				[+] if (Right(sPath, 1) != "\")			// repair path string (if necessary)
					[ ] sPath = sPath + "\"
				[ ] lfFiles = SYS_GetDirContents(sPath)
				[+] for each f in lfFiles
					[+] if (f.bIsDir)						// if it's a directory
						[ ] ListAppend(lsDirs, sPath + f.sName)	// add it into list of directories
						[ ] ListAppend(lsRtn, sPath + f.sName)	// add it into return value
						[ ] continue							// next item in the loop
				[ ] ListDelete(lsDirs, 1)				// remove the directory we just checked
		[+] else
			[ ] Log.Error("GetDirTree", "Path '{sPath}' does not exist.")
		[ ] ListSort(lsRtn)							// sort the return value
		[ ] return lsRtn							// return result
		[ ] 
		[ ] 
	[ ] 
	[+] LIST OF STRING GetDirectoryListing(STRING sPath, STRING sFileType optional, BOOLEAN bRecurse optional)
		[ ] // ============================================
		[+] // FUNCTION: GetDirectoryListing()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns all files (with their complete file path) located in the
			[ ] // directory specified in sPath. If a file type is specified in sFileType, only files
			[ ] // of the specified file type are returned. If bRecurse is TRUE (or unspecified), all
			[ ] // subdirectories will be searched as well.
			[ ] //
			[ ] // PARAMETERS:	STRING	sPath		path of directory to search
			[ ] //				STRING	sFileType	optional file type specifier
			[ ] //				BOOLEAN	bRecurse	TRUE (or NULL) = search all subdirectories
			[ ] //									FALSE = search only root directory
			[ ] //
			[ ] // RETURNS:		LIST OF STRING		list of file paths
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 7, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] LIST OF FILEINFO lfFiles
		[ ] LIST OF STRING lsDirList = {}
		[ ] LIST OF STRING lsTemp = {}
		[ ] INTEGER	iIdx
		[ ] INTEGER	iLength
		[ ] STRING	sTempType
		[+] if SYS_DirExists(sPath)
			[+] if (bRecurse == NULL)
				[ ] bRecurse = TRUE
			[+] if (sFileType != NULL)
				[+] if (Left(sFileType, 1) == ".")
					[ ] sTempType = sFileType
				[+] else
					[ ] sTempType = "." + sFileType
				[ ] iLength = Len(sTempType)
			[+] if (Right(sPath, 1) != "\")			// repair path string (if necessary)
				[ ] sPath = sPath + "\"
			[ ] lfFiles = SYS_GetDirContents(sPath)
			[+] for iIdx = 1 to ListCount(lfFiles)
				[ ] // If filename is a directory and bRecurse is TRUE, then call GetDirectoryListing
				[ ] // again with the new path name. Otherwise, add the filename to the list if the
				[ ] // FileType is correct. If no path name, just add to the list.
				[+] if (lfFiles[iIdx].bIsDir)
					[+] if bRecurse
						[ ] lsTemp = GetDirectoryListing("{sPath}{lfFiles[iIdx].sName}", sFileType, bRecurse)
						[ ] ListMerge(lsDirList, lsTemp)
				[+] else
					[+] if (sFileType == NULL)
						[ ] ListAppend(lsDirList, "{sPath}{lfFiles[iIdx].sName}")
					[+] else if (Upper(sTempType) == Upper(Right(lfFiles[iIdx].sName, iLength)))
						[ ] ListAppend(lsDirList, "{sPath}{lfFiles[iIdx].sName}")
		[+] else
			[ ] Log.Error("GetDirectoryListing", "Path '{sPath}' does not exist.")
		[ ] return lsDirList
		[ ] 
		[ ] 
	[ ] 
	[+] LIST OF STRING GetDirFileNames(STRING sPath, STRING sFileType optional)
		[ ] // ============================================
		[+] // FUNCTION: GetDirFileNames()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns the names of all files (without file path) located in the
			[ ] // directory specified in sPath. If a file type is specified in sFileType, only files
			[ ] // of the specified file type are returned.
			[ ] //
			[ ] // PARAMETERS:	STRING	sPath		path of directory to search
			[ ] //				STRING	sFileType	optional file type specifier
			[ ] // RETURNS:		LIST OF STRING		list of files in this directory
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 9, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] LIST OF FILEINFO lfFiles
		[ ] LIST OF STRING lsTemp
		[ ] INTEGER	iIdx
		[ ] INTEGER	iLength
		[ ] STRING	sTempType
		[+] if sFileType != NULL
			[+] if (Left(sFileType, 1) == ".")
				[ ] sTempType = sFileType
			[+] else
				[ ] sTempType = "." + sFileType
			[ ] iLength = Len (sTempType)
		[+] if SYS_DirExists(sPath)
			[ ] lfFiles = SYS_GetDirContents(sPath)
			[+] for iIdx = 1 to ListCount(lfFiles)
				[+] if !(lfFiles[iIdx].bIsDir)
					[+] if (sFileType == NULL)
						[ ] ListAppend(lsTemp, lfFiles[iIdx].sName)
					[+] else
						[+] if (Upper(sTempType) == Upper(Right(lfFiles[iIdx].sName, iLength)))
							[ ] ListAppend(lsTemp, lfFiles[iIdx].sName)
		[+] else
			[ ] Log.Error("Path '{sPath}' does not exist.")
		[ ] return lsTemp
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN	VerifyDirectoryList(BOOLEAN bExists, LIST OF STRING lsDirList)
		[ ] // ============================================
		[+] // FUNCTION: VerifyDirectoryList()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function verifies that the actual existence state of all files specified in
			[ ] // lsDirList match the expected existence state specified in bExists. A boolean result
			[ ] // of TRUE is returned if the list was successfully verified.
			[ ] //
			[ ] // PARAMETERS:	BOOLEAN			bExists		TRUE  = files should exist
			[ ] //											FALSE = files should not exists
			[ ] //				LIST OF STRING	lsDirList	list of file paths
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = All files successfully verified
			[ ] //							FALSE = Not all files verified
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 9, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] BOOLEAN bRes = TRUE
		[ ] STRING	sFile, sVal
		[+] for each sFile in lsDirList			// loop thru entire list of files
			[ ] BOOLEAN	bFound	= SYS_FileExists(sFile)
			[+] if !bFound
				[ ] bFound	= SYS_DirExists(sFile)
			[ ] // post an error if actual existence does not match expected existence status
			[+] if (bExists != bFound)
				[+] if (bExists)
					[ ] sVal = "not "
				[+] else
					[ ] sVal = BLANK_STR
				[ ] bRes = FALSE
				[ ] Log.Error("{sFile} was {sVal}found.")
		[ ] return bRes								// return result
		[ ] 
		[ ] 
	[ ] 
	[+] STRING	GetDrive(STRING sFilePath)
		[ ] // ============================================
		[+] // FUNCTION: GetDrive()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function returns the drive specifier contained in a file path string.
			[ ] //
			[ ] // PARAMETERS:	STRING	sFilePath		file path string
			[ ] //
			[ ] // RETURNS:		STRING	drive specifier (upper case)
			[ ] //							FALSE = Not all files verified
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 9, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] STRING	sDummy
		[ ] STRING	sDrive
		[ ] SplitPath(sFilePath, sDrive, sDummy, sDummy, sDummy)
		[ ] return sDrive					// return drive specifier
		[ ] 
		[ ] 
	[ ] 
	[+] STRING	ResolveUNCpath(STRING sMachine, STRING sPath)
		[ ] // ============================================
		[+] // FUNCTION: ResolveUNCpath()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function combines machine name and file path (located on specified
			[ ] // machine) and returns a UNC path formatted as \\machine\drive\dir\filename.
			[ ] //
			[ ] // PARAMETERS:	STRING	sMachine		name of machine where path resides
			[ ] //				STRING	sPath			file path string
			[ ] //
			[ ] // RETURNS:		STRING	complete UNC path
			[ ] //							FALSE = Not all files verified
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 9, 2007	Bhagwat Kolde created
		[ ] // ============================================
		[ ] STRING	sDir	= GetDir(sPath)
		[ ] STRING	sFile	= GetFullFileName(sPath)
		[ ] STRING	sDrive	= GetDriveLetter(GetDrive(sPath))
		[+] if (sDrive != BLANK_STR)
			[ ] sDrive = sDrive + "\"
		[ ] STRING	sResult	= "\\{sMachine}\{sDrive}{sDir}{sFile}"
		[ ] return	sResult
		[ ] 
		[ ] 
	[ ] 
	[+] BOOLEAN	SetFileAttributes(STRING sTarget, INTEGER iAttributes)
		[ ] // ==========================================================
		[+] // FUNCTION: SetFileAttributes()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function sets the file attributes (specified in iAttributes) for the target
			[ ] // file specified in sTarget.
			[ ] //
			[ ] // PARAMETERS:	STRING	sTarget			target file path
			[ ] //				INTEGER	iAttributes		file attribute flags
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = file attributes successfully changed
			[ ] //							FALSE = file not found
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] BOOLEAN	bRes = SetFileAttribs(sTarget, iAttributes)
		[+] if !(bRes)
			[ ] Log.Warning("Warning:  ","SetFileAttributes could not find file '{sTarget}'.")
		[ ] return bRes
		[ ] 
	[ ] 
	[+] VOID CompareFileLists (STRING sBaseFile, STRING sResFile)
		[ ] //*******************************************************************************************************************************************************************************
		[ ] //function: 			CompareFileLists(sBaseFile, sResFile)
		[ ] //description: 			Compares files in a list and displays files that don't compare or that do not exist.
		[ ] //parameter:			string sBaseFile = Base text file containing list of files generated by WriteFileList() function.
		[ ] //parameter:			string sResFile = Result text file containing list of files generated by WriteFileList() function.
		[ ] //returns:
		[ ] //file:					library2.inc
		[ ] //*******************************************************************************************************************************************************************************
		[ ] HFILE Input1 //File handle
		[ ] HFILE Input2 //File handle
		[ ] STRING sBaseLine //Line info from FileReadLine
		[ ] STRING sResLine
		[ ] STRING sBaseNotesFile
		[ ] STRING sResNotesFile
		[ ] ARRAY[5000] OF STRING FBASE
		[ ] ARRAY[5000] OF STRING FRES
		[ ] ARRAY[5000] OF STRING RESNAME
		[ ] ARRAY[5000] OF STRING BASENAME
		[ ] INTEGER iCount = 0
		[ ] INTEGER x
		[ ] INTEGER iPos
		[ ] 
		[ ] //Read in installed and comparison directory and file names into arrays.
		[ ] Input1 = FileOpen (sBaseFile, FM_READ)
		[ ] Input2 = FileOpen (sResFile, FM_READ)
		[ ] 
		[ ] 
		[+] while FileReadLine (Input1, sBaseLine)
			[+] if len (sBaseLine) == 0
				[ ] continue
			[ ] 
			[ ] iCount = iCount + 1
			[ ] FBASE[iCount] = upper (sBaseLine)
			[ ] BASENAME[iCount] = FilenameParse (FBASE[iCount])
		[ ] 
		[ ] ArrayResize (FBASE, iCount)
		[ ] ArrayResize (BASENAME, iCount)
		[ ] iCount = 0
		[ ] 
		[+] while FileReadLine (Input2, sResLine)
			[+] if len (sResLine) == 0
				[ ] continue
			[ ] 
			[ ] iCount = iCount + 1
			[ ] FRES[iCount] = upper (sResLine)
			[ ] RESNAME[iCount] = FilenameParse (FRES[iCount])
		[ ] 
		[ ] ArrayResize (FRES, iCount)
		[ ] ArrayResize (RESNAME, iCount)
		[ ] iCount = 0
		[ ] 
		[ ] 
		[ ] FileClose (Input1)
		[ ] FileClose (Input2)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Do File Compares
		[ ] 
		[ ] 
		[ ] 
		[ ] print ("")
		[ ] print ("Comparing " + upper (DirParse (FBASE[1])) + " To " + upper (DirParse (FRES[1])))
		[ ] 
		[ ] 
		[ ] 
		[+] for x = 1 to ArraySize (FBASE)
			[ ] iPos = ArrayFind (RESNAME, BASENAME[x], ArraySize (RESNAME))
			[ ] 
			[+] if iPos == 0
				[ ] LogError (upper (FBASE[x]) + " does not exist in " + upper (DirParse (FRES[1])) + ".")
				[ ] 
			[+] else if SYS_CompareBinary (upper (FBASE[x]), upper (FRES[iPos])) == FALSE
				[ ] LogError ("FAILED FILE COMPARE: " + lower (FBASE[x]) + "    " + lower (FRES[iPos]))
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] print ("")
		[ ] print ("Comparing " + upper (DirParse (FRES[1])) + " To " + upper (DirParse (FBASE[1])))
		[ ] 
		[ ] 
		[ ] 
		[+] for x = 1 to ArraySize (FRES)
			[ ] iPos = ArrayFind (BASENAME, RESNAME[x], ArraySize (BASENAME))
			[ ] 
			[+] if iPos == 0
				[ ] LogError (upper (FRES[x]) + " does not exist in " + upper (DirParse (FBASE[1])) + ".")
				[ ] 
			[+] else if SYS_CompareBinary (upper (FRES[x]), upper (FBASE[iPos])) == FALSE
				[ ] LogError ("FAILED FILE COMPARE: " + lower (FRES[x]) + "    " + lower (FBASE[iPos]))
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] print ("")
		[ ] print ("")
		[ ] 
	[ ] 
	[+] LIST OF STRING FileAddPrefixSuffix (STRING sDataFile, STRING sPrefix optional, STRING sSuffix optional)
		[ ] //*******************************************************************************************************************************************************************************
		[ ] //function: 			FileAddPrefixSuffix(string sDataFile, string sPrefix optional, string sSuffix optional)
		[ ] //description: 			Optionally adds a prefix and/or suffix to each line in a specified file and returns the new file contents as a list of string
		[ ] //returns:				returns the new file contents as a list of string
		[ ] //parameter:			string sDataFile = the file to read in.
		[ ] //parameter:			string sPrefix = Text that you want to appear before each line in the specified file.
		[ ] //parameter:			string sSuffix = Text that you want to appear at the end of each line in the specified file.
		[ ] //file:					library2.inc
		[ ] //*******************************************************************************************************************************************************************************
		[ ] LIST OF STRING lsReadIn, lsWriteOut
		[ ] STRING sItem
		[ ] 
		[ ] listread (lsReadIn, sDataFile)
		[ ] 
		[ ] //Modify items in list
		[+] for each sItem in lsReadIn
			[+] if sItem == ""
				[ ] continue
			[ ] 
			[+] if sPrefix != NULL
				[ ] sItem = "{sPrefix}{sItem}"
			[ ] 
			[+] if sSuffix != NULL
				[ ] sItem = "{sItem}{sSuffix}"
			[ ] 
			[ ] listappend (lsWriteOut, sItem)
		[ ] 
		[ ] return lsWriteOut
	[ ] 
	[+] LIST OF STRING FileReplaceItems (STRING sDataFile, STRING sSearch, STRING sReplace)
		[ ] //*******************************************************************************************************************************************************************************
		[ ] //function: 			FileReplaceItems(string sDataFile, string sSearch, string sReplace)
		[ ] //description: 			Searches the specified file for the search string (sSearch) and replaces all instances of it with the Replace string (sReplace) then returns the new file contents as a list of string
		[ ] //returns:				returns the new file contents as a list of string
		[ ] //parameter:			string sDataFile = the file to read in.
		[ ] //parameter:			string sSearch = Text that you want to search the specified file for.
		[ ] //parameter:			string sReplace = Text that you want to replace the search string (sSearch) with.
		[ ] //file:					library2.inc
		[ ] //*******************************************************************************************************************************************************************************
		[ ] LIST OF STRING lsReadIn, lsWriteOut
		[ ] STRING sItem
		[ ] INTEGER iPos
		[ ] 
		[ ] listread (lsReadIn, sDataFile)
		[ ] 
		[ ] //Modify items in list
		[+] for each sItem in lsReadIn
			[+] if sItem == ""
				[ ] continue
			[ ] 
			[ ] 
			[+] if strpos (sSearch, sItem)
				[ ] sItem = strtran (sItem, sSearch, sReplace)
			[ ] 
			[ ] listappend (lsWriteOut, sItem)
		[ ] 
		[ ] return lsWriteOut
	[ ] 
	[+] STRING FilenameParse (STRING sText)
		[ ] //*******************************************************************************************************************************************************************************
		[ ] //function: 			FilenameParse(sText)
		[ ] //description: 			Returns only filename portion of a complete path string.
		[ ] //parameter:			string sText = Complete path string (i.e. "c:\automate\tools\test.txt") function will return "test.txt"
		[ ] //returns:				string sText = function will return "test.txt" from example above
		[ ] //file:					library1.inc
		[ ] //*******************************************************************************************************************************************************************************
		[ ] INTEGER iParse
		[ ] 
		[+] while strpos ("\", sText) != 0
			[ ] iParse = strpos ("\", sText)
			[ ] sText = right (sText, len (sText) - iParse)
		[ ] 
		[ ] return sText
	[ ] 
	[+] STRING DirParse (STRING sText)
		[ ] //*******************************************************************************************************************************************************************************
		[ ] //function: 			DirParse(sText)
		[ ] //description: 			Returns only the directory portion of a complete path string.
		[ ] //parameter:			string sText = Complete path string (i.e. "c:\automate\tools\test.txt").
		[ ] //returns:				string sDir = function will return "c:\automate\tools" from example above
		[ ] //file:					library1.inc
		[ ] //*******************************************************************************************************************************************************************************
		[ ] INTEGER iParse
		[ ] STRING sDir
		[ ] 
		[ ] sDir = sText
		[ ] 
		[+] while strpos ("\", sText) != 0
			[ ] iParse = strpos ("\", sText)
			[ ] sText = right (sText, len (sText) - iParse)
		[ ] 
		[ ] sDir = left (sDir, (len (sDir) - len (sText)))
		[ ] 
		[ ] return sDir
	[ ] 
	[+] VOID WriteFileItem (STRING sItem, STRING sTextFile)
		[ ] //*******************************************************************************************************************************************************************************
		[ ] //function: 			WriteFileItem(sItem, sTextFile)
		[ ] //description: 			Writes out an item to a specified Text file.
		[ ] //parameter:			string sItem
		[ ] //parameter:			string sTextFile
		[ ] //returns:
		[ ] //file:					library1.inc
		[ ] //*******************************************************************************************************************************************************************************
		[ ] HFILE OutputFileHandle
		[ ] 
		[ ] OutputFileHandle = FileOpen (sTextFile, FM_APPEND)
		[ ] 
		[ ] FileWriteLine (OutputFileHandle, sItem)
		[ ] 
		[ ] FileClose (OutputFileHandle)
	[ ] 
	[+] VOID WriteFileList (STRING sPath optional, STRING sTextFile, BOOLEAN bTopLevelOnly optional)
		[ ] //*******************************************************************************************************************************************************************************
		[ ] //function: 			WriteFileList(sPath, sTextFile, bTopLevelOnly)
		[ ] //description: 			Writes out a list of files in a given directory to a an output file.
		[ ] //parameter:			string sPath optional = Directory path to get contents from
		[ ] //parameter:			string sTextFile = Path and Name of text file to log directory contents to.
		[ ] //parameter:			boolean bTopLevelOnly optional = TRUE to get only top-level contents FALSE drills down all subdirs.
		[ ] //returns:
		[ ] //file:					library2.inc
		[ ] //*******************************************************************************************************************************************************************************
		[ ] LIST OF FILEINFO lfDirContents //Main Directory
		[ ] INTEGER x //counter
		[ ] STRING sFilename //Filenames
		[ ] STRING sSubDir
		[ ] 
		[+] if SYS_FileExists (sTextFile)
			[ ] SYS_RemoveFile (sTextFile)
		[ ] 
		[+] if matchstr ("\", right (sPath, 1))
			[ ] sPath = substr (sPath, 1, len (sPath) - 1)
		[ ] 
		[ ] 
		[ ] lfDirContents = SYS_GetDirContents (sPath)
		[ ] 
		[+] for x = 1 to ListCount (lfDirContents)
			[ ] sFilename = lfDirContents[x].sName
			[ ] 
			[+] if lfDirContents[x].bIsDir == TRUE
				[ ] continue
			[ ] 
			[ ] WriteFileItem ("{sPath}{gsDelim}{sFilename}", sTextFile)
			[ ] 
		[ ] 
		[ ] 
		[+] for x = 1 to ListCount (lfDirContents)
			[ ] sFilename = lfDirContents[x].sName
			[+] if bTopLevelOnly == FALSE && lfDirContents[x].bIsDir == TRUE
				[ ] sSubDir = "{sPath}{gsDelim}{sFilename}"
				[ ] WriteMainDir (sSubDir, sTextFile)
			[ ] 
		[ ] 
	[ ] 
	[+] VOID WriteMainDir (STRING sDir, STRING sTextFile)
		[ ] //*******************************************************************************************************************************************************************************
		[ ] //function: 			WriteMainDir(sDir,sTextFile)
		[ ] //description: 			Writes out list of top-level files within the specified directory to a specified output file.
		[ ] //parameter:			string sDir = Directory to search.
		[ ] //parameter:			string sTextFile = Text file to log top-level directory contents to.
		[ ] //returns:
		[ ] //file:					library2.inc
		[ ] //*******************************************************************************************************************************************************************************
		[ ] LIST OF FILEINFO lfDirContents //Directory listing
		[ ] INTEGER x
		[ ] STRING sFilename
		[ ] STRING sSubDir
		[ ] 
		[ ] 
		[ ] lfDirContents = SYS_GetDirContents (sDir)
		[ ] 
		[ ] 
		[+] for x = 1 to ListCount (lfDirContents)
			[ ] sFilename = lfDirContents[x].sName
			[+] if lfDirContents[x].bIsDir == TRUE
				[ ] sSubDir = "{sDir}{gsDelim}{sFilename}"
				[ ] WriteSubDir (sSubDir, sTextFile)
			[+] else
				[ ] WriteFileItem ("{sDir}{gsDelim}{sFilename}", sTextFile)
			[ ] 
		[ ] 
	[ ] 
	[+] VOID WriteSubDir (STRING sDir, STRING sTextFile)
		[ ] //*******************************************************************************************************************************************************************************
		[ ] //function: 			WriteSubDir(sDir, sTextFile)
		[ ] //description: 			Writes out list of subdirectory files within the specified directory to a specified output file.
		[ ] //parameter:			string sDir = Directory to search
		[ ] //parameter:			string sTextFile = Text file to log sub directory contents to.
		[ ] //returns:
		[ ] //file:					library2.inc
		[ ] //*******************************************************************************************************************************************************************************
		[ ] LIST OF FILEINFO lfDirContents //Directory listing
		[ ] INTEGER x
		[ ] STRING sFilename
		[ ] STRING sSubDir
		[ ] 
		[ ] 
		[ ] 
		[ ] lfDirContents = SYS_GetDirContents (sDir)
		[ ] 
		[+] for x = 1 to ListCount (lfDirContents)
			[ ] sFilename = lfDirContents[x].sName
			[+] if lfDirContents[x].bIsDir == TRUE
				[ ] sSubDir = "{sDir}{gsDelim}{sFilename}"
				[ ] WriteMainDir (sSubDir, sTextFile)
			[+] else
				[ ] WriteFileItem ("{sDir}{gsDelim}{sFilename}", sTextFile)
			[ ] 
	[ ] 
	[+] BOOLEAN	GetFileDateTimeVal	(string sFile, 	inout int iYear, inout int iMonth, 	inout int iDay, inout int iHour, inout int iMinute, inout int iSecond)
		[ ] 
		[+] // Description
			[ ] // function:  bPassed = GetFileDateTimeVal (sFile, iYear, iMonth, iDay, iHour, iMinute, iSecond)
			[ ] // returns:   bPassed: True if passed, false otherwise
			[ ] // parameter: sFile: The Path to the File
			[ ] // parameter: iYear: The current year. (inout)
			[ ] // parameter: iMonth: The current year. (inout)
			[ ] // parameter: iDay: The current year. (inout)
			[ ] // parameter: iHour: The current year. (inout)
			[ ] // parameter: iMinute: The current year. (inout)
			[ ] // parameter: iSecond: The current year. (inout)
			[ ] // notes:     Gets File date and time values
			[ ] 
		[ ] 
		[ ] FILETIME 	ftCreate, ftAccess, ftWrite, ftLocal
		[ ] SYSTEMTIME	stCreate
		[ ] long 		lNull = NULL
		[ ] long		hFile
		[ ] 
		[ ] 
		[ ] hFile 	= 	CreateFileA	(sFile, 0x80000000, 0, lNull, 3, 0x00000080, 0)
		[ ] 
		[ ] 			GetFileTime	(hFile, ftCreate, ftAccess, [out] ftWrite)
		[ ] 
		[ ] 			CloseHandle	(hFile)
		[ ] 
		[ ] FileTimeToLocalFileTime (ftWrite, [out] ftLocal)
		[ ] 
		[ ] FileTimeToSystemTime 	(ftLocal, [out] stCreate)
		[ ] 
		[ ] iYear 	= stCreate.wYear
		[ ] iMonth 	= stCreate.wMonth
		[ ] iDay	= stCreate.wDay
		[ ] iHour 	= stCreate.wHour
		[ ] iMinute	= stCreate.wMinute
		[ ] iSecond	= stCreate.wSecond
		[ ] 
		[ ] 
		[+] if (iYear == 0) 
			[ ] 
			[ ] return false
			[ ] 
		[ ] 
		[ ] return true
		[ ] 
	[ ] 
	[+] STRING GetFileDateString 	(string sFile)
		[ ] 
		[+] // Description
			[ ] // function:  sDate = GetFileDateString (sFile)
			[ ] // returns:   sDate: File Date
			[ ] // parameter: sFile: The Path to the File
			[ ] // notes:     Gets File date in format: mm/dd/year
			[ ] 
		[ ] 
		[ ] integer	iYear, iMonth, iDay, iHour, iMinute, iSecond
		[ ] string	sDate
		[ ] 
		[ ] GetFileDateTimeVal (sFile, iYear, iMonth, iDay, iHour, iMinute, iSecond)
		[ ] 
		[ ] sDate = str (iMonth) + "/" + str (iDay) + "/" + str (iYear )
		[ ] 
		[ ] return sDate
		[ ] 
	[ ] 
	[+] STRING GetFileTimeString 	(string sFile)
		[ ] 
		[+] // Description
			[ ] // function:  sTime = GetFileTimeString (sFile)
			[ ] // returns:   sDate: File Time
			[ ] // parameter: sFile: The Path to the File
			[ ] // notes:     Gets File date in format: hh:mm:ss
			[ ] 
		[ ] 
		[ ] integer	iYear, iMonth, iDay, iHour, iMinute, iSecond
		[ ] string	sTime
		[ ] 
		[ ] GetFileDateTimeVal (sFile, iYear, iMonth, iDay, iHour, iMinute, iSecond)
		[ ] 
		[ ] sTime = str (iHour) + ":" + str (iMinute) + ":" + str (iSecond) 
		[ ] 
		[ ] return sTime
		[ ] 
	[ ] 
	[+] INTEGER GetFileTimeSecond 	(string sFile)
		[ ] 
		[+] // Description
			[ ] // function:  iSeconds = GetFileTimeSecond (sFile)
			[ ] // returns:   iSeconds: Date transformed into seconds
			[ ] // parameter: sFile: The Path to the File
			[ ] // notes:     Gets File date in seconds
			[ ] 
		[ ] 
		[ ] integer	iYear, iMonth, iDay, iHour, iMinute, iSecond
		[ ] integer iTotal
		[ ] 
		[ ] GetFileDateTimeVal (sFile, iYear, iMonth, iDay, iHour, iMinute, iSecond)
		[ ] 
		[ ] iTotal = iSecond + (iMinute * 60) + (iHour * 3600) + (iDay *  86400) + (iMonth *  2592000) + (iYear *  31104000)
		[ ] 
		[ ] return iTotal
		[ ] 
	[ ] 
	[+] STRING GetFileAttributes 	(string sFile)
		[ ] 
		[+] // Description
			[ ] // function:  sAttributes = GetFileAttributes (sFile)
			[ ] // returns:   sAttributes: File Attributes any of "CRHSA"
			[ ] // parameter: sFile: The Path to the File
			[ ] // notes:     Gets File Attributes in format "CRHSA"
			[ ] 
		[ ] 
		[ ] integer iAttrib
		[ ] string	sAttrib = ""
		[ ] 
		[ ] iAttrib = GetFileAttributesA (sFile)
		[ ] 
		[+] if (iAttrib / 2048) > 0
			[ ] 
			[ ] sAttrib = sAttrib + "C"
			[ ] 
			[ ] iAttrib = iAttrib % 2048
			[ ] 
		[ ] 
		[+] if (iAttrib / 128) > 0
			[ ] 
			[ ] sAttrib = ""
			[ ] 
			[ ] iAttrib = iAttrib % 128
			[ ] 
		[ ] 
		[+] if (iAttrib / 32) > 0
			[ ] 
			[ ] sAttrib = "A" + sAttrib
			[ ] 
			[ ] iAttrib = iAttrib % 32
			[ ] 
		[ ] 
		[+] if (iAttrib / 4) > 0
			[ ] 
			[ ] sAttrib = "S" + sAttrib
			[ ] 
			[ ] iAttrib = iAttrib % 4
			[ ] 
		[ ] 
		[+] if (iAttrib / 2) > 0
			[ ] 
			[ ] sAttrib = "H" + sAttrib
			[ ] 
			[ ] iAttrib = iAttrib % 2
			[ ] 
		[ ] 
		[+] if (iAttrib / 1) > 0
			[ ] 
			[ ] sAttrib = "R" + sAttrib 
			[ ] 
			[ ] iAttrib = iAttrib % 1
			[ ] 
		[ ] 
		[+] if iAttrib > 0
			[ ] 
			[ ] LogWarning ("Missing Attribute not calculated: {iAttrib}")
			[ ] 
		[ ] 
		[ ] return sAttrib
		[ ] 
	[ ] 
	[+] BOOLEAN FileExists(STRING sFileName)
		[ ] // ==========================================================
		[+] // FUNCTION: FileExists()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function checks for the existence of the specified file (sFileName)
			[ ] //
			[ ] // PARAMETERS:	STRING		sFileName		File name to be verified 
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = file exists
			[ ] //							FALSE = file not exists
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 06, 2010	Mamta Jain created
		[ ] // ==========================================================
		[ ] BOOLEAN bExists
		[+] do
			[+] if SYS_FileExists(sFileName)
				[ ] bExists = TRUE
			[+] else
				[ ] bExists = FALSE
		[+] except
			[ ] bExists = FALSE
			[ ] ExceptLog()
		[ ] return bExists
		[ ] 
	[ ] 
	[+] BOOLEAN DirExists(STRING sDirName)
		[ ] // ==========================================================
		[+] // FUNCTION: DirExists()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function checks for the existence of the specified Directory (sDirName)
			[ ] //
			[ ] // PARAMETERS:	STRING		sDirName		dir name to be verified
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = dir exists
			[ ] //							FALSE = dir not exists
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 06, 2010	Mamta Jain created
		[ ] // ==========================================================
		[ ] BOOLEAN bExists
		[+] do
			[+] if SYS_DirExists(sDirName)
				[ ] bExists = TRUE
			[+] else
				[ ] bExists = FALSE
		[+] except
			[ ] bExists = FALSE
			[ ] ExceptLog()
		[ ] return bExists
		[ ] 
		[ ] 
	[ ] 
	[+] // LIST OF STRING GetFileListing(STRING sPath)
		[ ] // // ============================================
		[+] // // FUNCTION: GetFileListing()
			[ ] // //
			[ ] // // DESCRIPTION:
			[ ] // //   This function returns all of the paths in a directory tree specified in sPath.
			[ ] // //
			[ ] // // PARAMETERS:	STRING	sPath		path of directory to parse
			[ ] // //
			[ ] // // RETURNS:		LIST OF STRING		No. of Files in specified directory
			[ ] // //
			[ ] // // REVISION HISTORY:
			[ ] // //	 Dec 1, 2010	Mamta Jain created
		[ ] // // ============================================
		[ ] // LIST OF FILEINFO lfFiles
		[ ] // FILEINFO f
		[ ] // LIST OF STRING lsDirs = {}
		[ ] // LIST OF STRING lsRtn = {}
		[ ] // Integer iFiles = 0
		[+] // if (SYS_DirExists(sPath))
			[ ] // lsDirs	= {sPath}					// add current path to list of paths
			[ ] // lsRtn	= {sPath}					// add search path to return value
			[+] // while (ListCount(lsDirs))			// while there are still directories to check
				[ ] // sPath = lsDirs[1]					// use the first one in there
				[+] // if (Right(sPath, 1) != "\")			// repair path string (if necessary)
					[ ] // sPath = sPath + "\"
				[ ] // lfFiles = SYS_GetDirContents(sPath)
				[+] // for each f in lfFiles
					[+] // if (f.bIsDir)						// if it's a directory
						[ ] // ListAppend(lsDirs, sPath + f.sName)	// add it into list of directories
						[ ] // //ListAppend(lsRtn, sPath + f.sName)	// add it into return value
						[ ] // continue							// next item in the loop
					[+] // else
						[ ] // ListAppend(lsRtn, sPath + f.sName)
						[ ] // iFiles=iFiles+1
				[ ] // ListDelete(lsDirs, 1)				// remove the directory we just checked
		[+] // else
			[ ] // Log.Error("Path '{sPath}' does not exist.")
		[ ] // ListSort(lsRtn)						// sort the return value
		[ ] // ListDelete(lsRtn, 1)				//remove the first value which is the specified folder
		[ ] // //print(listcount(lsRtn), iFiles)
		[ ] // return lsRtn					// return result
	[ ] 
[ ] // ==========================================================
[ ] 
[+] window MainWin PdfFile
	[+] multitag "*.pdf*"
		[ ] "*Adobe Reader"
		[ ] "$C:\Program Files\Adobe\Reader 11.0\Reader\AcroRd32.exe"
	[+] Menu File
		[ ] tag "#1"
		[+] MenuItem MenuItem1
			[+] multitag "#1"
				[ ] "$6001"
		[+] MenuItem MenuItem2
			[+] multitag "#2"
				[ ] "$6195"
		[+] MenuItem MenuItem3
			[+] multitag "#3"
				[ ] "$6005"
		[+] MenuItem MenuItem4
			[+] multitag "#4"
				[ ] "$6006"
		[+] Menu SaveAs
			[ ] tag "#5"
			[+] MenuItem Text
				[+] multitag "#1"
					[ ] "$6007"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6198"
		[+] MenuItem MenuItem6
			[+] multitag "#6"
				[ ] "$6199"
		[+] MenuItem MenuItem7
			[+] multitag "#7"
				[ ] "$6010"
		[+] MenuItem MenuItem8
			[+] multitag "#8"
				[ ] "$6194"
		[+] MenuItem MenuItem9
			[+] multitag "#9"
				[ ] "$6012"
		[+] Menu Menu10
			[ ] tag "#10"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6014"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6015"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6016"
			[+] MenuItem MenuItem4
				[+] multitag "#4"
					[ ] "$6017"
		[+] MenuItem MenuItem11
			[+] multitag "#11"
				[ ] "$6021"
		[+] MenuItem MenuItem12
			[+] multitag "#12"
				[ ] "$6022"
		[+] MenuItem MenuItem13
			[+] multitag "#13"
				[ ] "$6024"
		[+] MenuItem MenuItem14
			[+] multitag "#14"
				[ ] "$6028"
		[+] MenuItem MenuItem15
			[+] multitag "#15"
				[ ] "$6031"
		[+] MenuItem MenuItem16
			[+] multitag "#16"
				[ ] "$6033"
	[+] Menu Menu2
		[ ] tag "#2"
		[+] MenuItem MenuItem1
			[+] multitag "#1"
				[ ] "$6034"
		[+] MenuItem MenuItem2
			[+] multitag "#2"
				[ ] "$6035"
		[+] MenuItem MenuItem3
			[+] multitag "#3"
				[ ] "$6037"
		[+] MenuItem MenuItem4
			[+] multitag "#4"
				[ ] "$6038"
		[+] MenuItem MenuItem5
			[+] multitag "#5"
				[ ] "$6039"
		[+] MenuItem MenuItem6
			[+] multitag "#6"
				[ ] "$6040"
		[+] MenuItem MenuItem7
			[+] multitag "#7"
				[ ] "$6042"
		[+] MenuItem MenuItem8
			[+] multitag "#8"
				[ ] "$6043"
		[+] MenuItem MenuItem9
			[+] multitag "#9"
				[ ] "$6200"
		[+] MenuItem MenuItem10
			[+] multitag "#10"
				[ ] "$6045"
		[+] Menu Menu11
			[ ] tag "#11"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6047"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6048"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6049"
		[+] MenuItem MenuItem12
			[+] multitag "#12"
				[ ] "$6051"
		[+] MenuItem MenuItem13
			[+] multitag "#13"
				[ ] "$6053"
		[+] MenuItem MenuItem14
			[+] multitag "#14"
				[ ] "$6054"
		[+] Menu Menu15
			[ ] tag "#15"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6056"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6058"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6059"
			[+] MenuItem MenuItem4
				[+] multitag "#4"
					[ ] "$6060"
			[+] MenuItem MenuItem5
				[+] multitag "#5"
					[ ] "$6061"
		[+] Menu Menu16
			[ ] tag "#16"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6063"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6064"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6065"
		[+] Menu Menu17
			[ ] tag "#17"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6067"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6068"
		[+] MenuItem MenuItem18
			[+] multitag "#18"
				[ ] "$6071"
	[+] Menu Menu3
		[ ] tag "#3"
		[+] Menu Menu1
			[ ] tag "#1"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6076"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6077"
		[+] Menu Menu2
			[ ] tag "#2"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6081"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6082"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6083"
			[+] MenuItem MenuItem4
				[+] multitag "#4"
					[ ] "$6084"
			[+] MenuItem MenuItem5
				[+] multitag "#5"
					[ ] "$6085"
			[+] MenuItem MenuItem6
				[+] multitag "#6"
					[ ] "$6087"
			[+] MenuItem MenuItem7
				[+] multitag "#7"
					[ ] "$6088"
		[+] Menu Menu3
			[ ] tag "#3"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6094"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6095"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6096"
			[+] MenuItem MenuItem4
				[+] multitag "#4"
					[ ] "$6097"
			[+] MenuItem MenuItem5
				[+] multitag "#5"
					[ ] "$6099"
			[+] MenuItem MenuItem6
				[+] multitag "#6"
					[ ] "$6100"
			[+] MenuItem MenuItem7
				[+] multitag "#7"
					[ ] "$6102"
		[+] Menu Menu4
			[ ] tag "#4"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6104"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6105"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6106"
			[+] MenuItem MenuItem4
				[+] multitag "#4"
					[ ] "$6108"
			[+] MenuItem MenuItem5
				[+] multitag "#5"
					[ ] "$6109"
			[+] MenuItem MenuItem6
				[+] multitag "#6"
					[ ] "$6110"
			[+] MenuItem MenuItem7
				[+] multitag "#7"
					[ ] "$6111"
			[+] MenuItem MenuItem8
				[+] multitag "#8"
					[ ] "$6112"
			[+] MenuItem MenuItem9
				[+] multitag "#9"
					[ ] "$6114"
			[+] MenuItem MenuItem10
				[+] multitag "#10"
					[ ] "$6115"
			[+] MenuItem MenuItem11
				[+] multitag "#11"
					[ ] "$6117"
		[+] Menu Menu5
			[ ] tag "#5"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6121"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6123"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6124"
			[+] MenuItem MenuItem4
				[+] multitag "#4"
					[ ] "$6126"
		[+] Menu Menu6
			[ ] tag "#6"
			[+] Menu Menu1
				[ ] tag "#1"
				[+] MenuItem MenuItem1
					[+] multitag "#1"
						[ ] "$6206"
				[+] MenuItem MenuItem2
					[+] multitag "#2"
						[ ] "$6207"
				[+] MenuItem MenuItem3
					[+] multitag "#3"
						[ ] "$6205"
				[+] MenuItem MenuItem4
					[+] multitag "#4"
						[ ] "$6202"
				[+] MenuItem MenuItem5
					[+] multitag "#5"
						[ ] "$6208"
				[+] MenuItem MenuItem6
					[+] multitag "#6"
						[ ] "$6210"
				[+] MenuItem MenuItem7
					[+] multitag "#7"
						[ ] "$6204"
				[+] MenuItem MenuItem8
					[+] multitag "#8"
						[ ] "$6203"
				[+] MenuItem MenuItem9
					[+] multitag "#9"
						[ ] "$6209"
				[+] MenuItem MenuItem10
					[+] multitag "#10"
						[ ] "$6211"
				[+] MenuItem MenuItem11
					[+] multitag "#11"
						[ ] "$6131"
				[+] MenuItem MenuItem12
					[+] multitag "#12"
						[ ] "$6132"
				[+] MenuItem MenuItem13
					[+] multitag "#13"
						[ ] "$6212"
			[+] Menu Menu2
				[ ] tag "#2"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6135"
			[+] Menu Menu4
				[ ] tag "#4"
				[+] MenuItem MenuItem1
					[+] multitag "#1"
						[ ] "$6137"
		[+] MenuItem MenuItem7
			[+] multitag "#7"
				[ ] "$6141"
		[+] MenuItem MenuItem8
			[+] multitag "#8"
				[ ] "$6142"
		[+] MenuItem MenuItem9
			[+] multitag "#9"
				[ ] "$6144"
		[+] Menu Menu10
			[ ] tag "#10"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6146"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6147"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6148"
			[+] MenuItem MenuItem4
				[+] multitag "#4"
					[ ] "$6149"
			[+] MenuItem MenuItem5
				[+] multitag "#5"
					[ ] "$6150"
	[+] Menu Menu4
		[ ] tag "#4"
		[+] MenuItem MenuItem1
			[+] multitag "#1"
				[ ] "$6152"
		[+] MenuItem MenuItem2
			[+] multitag "#2"
				[ ] "$6154"
		[+] Menu Menu3
			[ ] tag "#3"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6155"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6156"
		[+] MenuItem MenuItem4
			[+] multitag "#4"
				[ ] "$6158"
		[+] MenuItem MenuItem5
			[+] multitag "#5"
				[ ] "$6160"
		[+] MenuItem MenuItem6
			[+] multitag "#6"
				[ ] "$6161"
		[+] MenuItem MenuItem7
			[+] multitag "#7"
				[ ] "$6162"
		[+] MenuItem MenuItem8
			[+] multitag "#8"
				[ ] "$6003"
	[+] Menu Menu5
		[ ] tag "#5"
		[+] MenuItem MenuItem1
			[+] multitag "#1"
				[ ] "$6164"
		[+] MenuItem MenuItem2
			[+] multitag "#2"
				[ ] "$6170"
		[+] MenuItem MenuItem3
			[+] multitag "#3"
				[ ] "$6171"
		[+] MenuItem MenuItem4
			[+] multitag "#4"
				[ ] "$6175"
		[+] MenuItem MenuItem5
			[+] multitag "#5"
				[ ] "$6178"
		[+] Menu Menu6
			[ ] tag "#6"
			[+] MenuItem MenuItem1
				[+] multitag "#1"
					[ ] "$6180"
			[+] MenuItem MenuItem2
				[+] multitag "#2"
					[ ] "$6181"
			[+] MenuItem MenuItem3
				[+] multitag "#3"
					[ ] "$6182"
			[+] MenuItem MenuItem4
				[+] multitag "#4"
					[ ] "$6183"
			[+] MenuItem MenuItem5
				[+] multitag "#5"
					[ ] "$6185"
		[+] MenuItem MenuItem7
			[+] multitag "#7"
				[ ] "$6187"
		[+] MenuItem MenuItem8
			[+] multitag "#8"
				[ ] "$6188"
		[+] MenuItem MenuItem9
			[+] multitag "#9"
				[ ] "$6190"
	[+] MenuItem MenuItem6
		[+] multitag "#6"
			[ ] "$6000"
	[+] CustomWin AVUICommandWidget
		[+] multitag "[AVL_AVView]AVUICommandWidget"
			[ ] "[AVL_AVView]#1"
			[ ] "[AVL_AVView]$0[1]"
			[ ] "[AVL_AVView]@(720,19)"
		[+] TextField TextField2
			[+] multitag "#2"
				[ ] "$0[2]"
				[ ] "@(480,18)"
		[+] TextField TextField1
			[+] multitag "#1"
				[ ] "$0[1]"
				[ ] "@(333,18)"
	[+] CustomWin AVTableContainerView
		[+] multitag "[AVL_AVView]AVTableContainerView"
			[ ] "[AVL_AVView]#3"
			[ ] "[AVL_AVView]$0[3]"
			[ ] "[AVL_AVView]@(720,38)"
	[+] CustomWin AVTabStripView
		[+] multitag "[AVL_AVView]AVTabStripView"
			[ ] "[AVL_AVView]#2"
			[ ] "[AVL_AVView]$0[2]"
			[ ] "[AVL_AVView]@(21,433)"
	[+] CustomWin AVSplitterView
		[+] multitag "[AVL_AVView]AVSplitterView"
			[ ] "[AVL_AVView]#4"
			[ ] "[AVL_AVView]$0[4]"
			[ ] "[AVL_AVView]@(741,433)"
		[+] CustomWin AVSplitationPageView
			[+] multitag "[AVL_AVView]AVSplitationPageView"
				[ ] "[AVL_AVView]#1"
				[ ] "[AVL_AVView]$0"
				[ ] "[AVL_AVView]@(699,395)"
			[+] CustomWin AVSplitterView
				[+] multitag "[AVL_AVView]AVSplitterView"
					[ ] "[AVL_AVView]#1"
					[ ] "[AVL_AVView]$0"
					[ ] "[AVL_AVView]@(699,395)"
				[+] CustomWin AVScrolledPageView
					[+] multitag "[AVL_AVView]AVScrolledPageView"
						[ ] "[AVL_AVView]#1"
						[ ] "[AVL_AVView]$0"
						[ ] "[AVL_AVView]@(699,395)"
					[+] CustomWin AVScrollView
						[+] multitag "[AVL_AVView]AVScrollView"
							[ ] "[AVL_AVView]#1"
							[ ] "[AVL_AVView]$0"
							[ ] "[AVL_AVView]@(699,395)"
						[+] CustomWin AVTableContainerView
							[+] multitag "[AVL_AVView]AVTableContainerView"
								[ ] "[AVL_AVView]#2"
								[ ] "[AVL_AVView]$0[2]"
								[ ] "[AVL_AVView]@(56,799)"
							[+] CustomWin OwnerDraw1
								[+] multitag "[OwnerDraw]#1"
									[ ] "[OwnerDraw]$0"
									[ ] "[OwnerDraw]@(56,8)"
						[+] CustomWin AVPageView
							[+] multitag "[AVL_AVView]AVPageView"
								[ ] "[AVL_AVView]#1"
								[ ] "[AVL_AVView]$0[1]"
								[ ] "[AVL_AVView]@(690,395)"
						[+] ScrollBar ScrollBar1
							[+] multitag "#1"
								[ ] "$0"
								[ ] "@(1389,395)"
	[+] CustomWin Tools
		[+] multitag "[ShockwaveFlashLibrary]AVFlashView"
			[ ] "#1"
			[ ] "$0"
			[ ] "@(1326,432)"
[+] window FileDlg OpenSaveAs
	[ ] tag "Open|Save As"
	[ ] parent PdfFile
	[+] StaticText LookInText
		[+] multitag "Look in:"
			[ ] "#1"
			[ ] "$1091"
			[ ] "@(49,17)"
	[+] PopupList LookIn
		[+] multitag "Look in:"
			[ ] "^Look in:"
			[ ] "#1"
			[ ] "$1137"
			[ ] "@(229,19)"
	[+] ToolBar LookIn1
		[+] multitag "Look in:[1]"
			[ ] "^Look in:[1]"
			[ ] "#1"
			[ ] "$1088"
			[ ] "@(432,18)"
		[+] PushButton PushButton1
			[+] multitag "#1"
				[ ] "$40971"
				[ ] "@(11,11)"
		[+] PushButton PushButton2
			[+] multitag "#2"
				[ ] "$40961"
				[ ] "@(34,11)"
		[+] PushButton PushButton3
			[+] multitag "#3"
				[ ] "$40962"
				[ ] "@(57,11)"
		[+] PushButton PushButton4
			[+] multitag "#4"
				[ ] "$40970"
				[ ] "@(85,11)"
	[+] ToolBar LookIn2
		[+] multitag "Look in:[2]"
			[ ] "^Look in:[2]"
			[ ] "#2"
			[ ] "$1184"
			[ ] "@(49,205)"
		[+] PushButton RecentPlaces
			[+] multitag "Recent Places"
				[ ] "#1"
				[ ] "$41060"
				[ ] "@(43,30)"
		[+] PushButton Desktop
			[+] multitag "Desktop"
				[ ] "#2"
				[ ] "$41061"
				[ ] "@(43,90)"
		[+] PushButton Libraries
			[+] multitag "Libraries"
				[ ] "#3"
				[ ] "$41062"
				[ ] "@(43,150)"
		[+] PushButton Computer
			[+] multitag "Computer"
				[ ] "#4"
				[ ] "$41063"
				[ ] "@(43,210)"
		[+] PushButton Network
			[+] multitag "Network"
				[ ] "#5"
				[ ] "$41064"
				[ ] "@(43,270)"
	[+] ListView ListView1
		[+] multitag "#1"
			[ ] "$1"
			[ ] "@(324,177)"
		[+] Header Header1
			[+] multitag "#1"
				[ ] "$0"
				[ ] "@(225,12)"
			[+] PushButton Name
				[+] multitag "Name"
					[ ] "#1"
					[ ] "@(136,12)"
			[+] PushButton DateModified
				[+] multitag "Date modified"
					[ ] "#2"
					[ ] "@(332,12)"
			[+] PushButton Type
				[+] multitag "Type"
					[ ] "#3"
					[ ] "@(452,12)"
			[+] PushButton Size
				[+] multitag "Size"
					[ ] "#4"
					[ ] "@(552,12)"
	[+] StaticText FileNameText
		[+] multitag "File name:"
			[ ] "#2"
			[ ] "$1090"
			[ ] "@(144,339)"
	[+] ComboBox FileName
		[+] multitag "File name:"
			[ ] "^File name:"
			[ ] "#1"
			[ ] "$1148"
			[ ] "@(318,339)"
	[+] StaticText FilesOfTypeText
		[+] multitag "Files of type:"
			[ ] "^File name:"
			[ ] "#3"
			[ ] "$1089"
			[ ] "@(144,365)"
	[+] PopupList FilesOfType
		[+] multitag "Files of type:"
			[ ] "^Files of type:"
			[ ] "#2"
			[ ] "$1136"
			[ ] "@(318,366)"
	[+] PushButton OpenSave
		[+] multitag "Open|Save"
			[ ] "^File name:"
			[ ] "#1"
			[ ] "$1"
			[ ] "@(511,339)"
	[+] PushButton Cancel
		[+] multitag "Cancel"
			[ ] "^Files of type:"
			[ ] "#2"
			[ ] "$2"
			[ ] "@(511,365)"
	[+] ScrollBar ScrollBar1
		[+] multitag "#1"
			[ ] "$-1"
			[ ] "@(546,410)"
	[+] FileDlg DialogBox1
		[ ] tag "$0"
		[+] PopupList PopupList1
			[+] multitag "#1"
				[ ] "$1046"
				[ ] "@(80,398)"
[ ] 
[ ] 
[ ] 
[+] BOOLEAN	ComparePDF(STRING sActual, STRING sExpected, STRING sPath optional)
	[ ] // ==========================================================
	[+] // FUNCTION: ComparePDF()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //   This function performs a comparison of two PDF files. It will Save PDF as text and then compare two text files.
		[ ] // and returns a boolean result of TRUE if the files are
		[ ] // same.
		[ ] 
		[ ] // PARAMETERS:		STRING		sActual		file to compare
		[ ] //						STRING		sExpected	baseline file
		[ ] //
		[ ] // RETURNS:			BOOLEAN		TRUE  = files are the same
		[ ] //										FALSE = files do not match
		[ ] // REVISION HISTORY:
		[ ] //	 Oct 18, 2012	Udita Dube  created
		[ ] 
	[ ] // ==========================================================
	[ ] STRING sCmdLine = "C:\Program Files\Adobe\Reader 11.0\Reader\AcroRd32.exe"
	[ ] STRING sActualFile, sExpectedFile, sActualTextFile, sExpectedTextFile
	[ ] BOOLEAN bFlag
	[ ] 
	[-] if(sPath!=NULL)
		[ ] sActualFile= sPath + "\" + "{sActual}.pdf"
		[ ] sExpectedFile= sPath + "\" + "{sExpected}.pdf"
	[-] else
		[ ] sActualFile= "{sActual}.pdf"
		[ ] sExpectedFile= "{sExpected}.pdf"
	[ ] 
	[ ] sActualTextFile = sPath + "\" + sActual+".txt"
	[ ] sExpectedTextFile = sPath + "\" + sExpected+".txt"
	[ ] 
	[ ] // Start application
	[ ] PdfFile.Start(sCmdLine)
	[ ] sleep(SHORT_SLEEP)
	[ ] 
	[ ] // Open Actual pdf File
	[ ] PdfFile.TypeKeys("<Ctrl-o>")
	[ ] OpenSaveAs.SetActive()
	[ ] // sActual = File name 
	[ ] OpenSaveAs.FileName.SetText(sActualFile)
	[ ] OpenSaveAs.OpenSave.Click()
	[ ] 
	[ ] // Save PDF as text
	[ ] PdfFile.SetActive()
	[ ] PdfFile.File.SaveAs.Text.Pick()
	[ ] OpenSaveAs.SetActive()
	[ ] OpenSaveAs.FileName.SetText(sActualTextFile)
	[ ] OpenSaveAs.OpenSave.Click()
	[ ] 
	[ ] PdfFile.SetActive()
	[ ] PdfFile.TypeKeys("<Ctrl-o>")
	[ ] OpenSaveAs.SetActive()
	[ ] OpenSaveAs.FileName.SetText(sExpectedFile)
	[ ] OpenSaveAs.OpenSave.Click()
	[ ] 
	[ ] MainWin("{sActual}.pdf*|*Adobe Reader").SetActive()
	[ ] MainWin("{sActual}.pdf*|*Adobe Reader").Close()
	[ ] 
	[ ] PdfFile.SetActive()
	[ ] PdfFile.File.SaveAs.Text.Pick()
	[ ] OpenSaveAs.SetActive()
	[ ] OpenSaveAs.FileName.SetText(sExpectedTextFile)
	[ ] OpenSaveAs.OpenSave.Click()
	[ ] 
	[ ] bFlag=SYS_CompareText(sActualTextFile,sExpectedTextFile)
	[ ] 
	[ ] return bFlag
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] // *************************************************************************************
[ ] //	END OF INCLUDE FILE
[ ] // *************************************************************************************
[ ] 
