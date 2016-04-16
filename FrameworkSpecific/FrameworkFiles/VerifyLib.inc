[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	VerifyLib.INC
[+] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file contains the verification library functions
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
[-] // VERIFY LIBRARY FUNCTIONS
	[ ] 
	[+] hidecalls BOOLEAN DoVerifyContents(WINDOW wObj, LIST OF STRING lsContents, ANYTYPE aLog optional)
		[ ] // ==========================================================
		[+] // FUNCTION: DoVerifyContents()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function verifies that the contents of wObj match the contents specified in
			[ ] // lsContents, and returns the results as a BOOLEAN value. If the aLog parameter is
			[ ] // specified as a BOOLEAN value of TRUE, or if aLog contains a string value, then
			[ ] // an error will be logged if the contents of wObj do not match those in lsContents.
			[ ] //
			[ ] // PARAMETERS:		WINDOW			wObj		object specifier
			[ ] //					LIST OF STRING	lsContents	list of expected contents to be verified
			[ ] //					ANYTYPE			aLog		log error on exception (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = wObj contents verified
			[ ] //								FALSE = wObj contents not verified
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 20, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[+] do
			[ ] wObj.VerifyContents(lsContents)				// verify contents of wObj
			[ ] return TRUE									// return TRUE if contents verified
		[+] except
			[ ] ErrorHandler(aLog, wObj, "contents")		// log error if aLog parameter provided
			[ ] return FALSE								// return FALSE
		[ ] 
		[ ] 
	[ ] 
	[+] hidecalls BOOLEAN DoVerifyEverything(WINDOW wObj, LIST OF STRING lsValues, ANYTYPE aLog optional)
		[ ] // ==========================================================
		[-] // FUNCTION: DoVerifyEverything()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function verifies that the attributes of wObj match the attributes specified
			[ ] // in lsValues, and returns the results as a BOOLEAN value. If the aLog parameter is
			[ ] // specified as a BOOLEAN value of TRUE, or if aLog contains a string value, then
			[ ] // an error will be logged if the attributes of wObj do not match those in lsValues.
			[ ] //
			[ ] // PARAMETERS:		WINDOW			wObj		object specifier
			[ ] //					LIST OF STRING	lsValues	list of expected attributes to be verified
			[ ] //					ANYTYPE			aLog		log error on exception (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = wObj attributes verified
			[ ] //								FALSE = wObj attributes not verified
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 20, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[+] do
			[ ] wObj.VerifyEverything(lsValues)				// verify attributes of wObj
			[ ] return TRUE									// return TRUE if attributes verified
		[+] except
			[ ] ErrorHandler(aLog, wObj, "attributes")		// log error if aLog parameter provided
			[ ] return FALSE								// return FALSE
		[ ] 
		[ ] 
	[ ] 
	[+] hidecalls BOOLEAN DoVerifyProperties(WINDOW wObj, WINPROPTREE lsProps, ANYTYPE aLog optional, FUZZYVERIFY Fuzzy optional)
		[ ] // ==========================================================
		[+] // FUNCTION: DoVerifyProperties()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function verifies that the properties of wObj match the properties specified
			[ ] // in lsProps, and returns the results as a BOOLEAN value. if the optional Fuzzy parameter
			[ ] // is specified, fuzzy verification is enabled. If the aLog parameter is specified as a
			[ ] // BOOLEAN value of TRUE, or if aLog contains a string value, then an error will be logged
			[ ] // if the properties of wObj do not match.
			[ ] //
			[ ] // PARAMETERS:		WINDOW		wObj	object specifier
			[ ] //					WINPROPTREE	lsProps	list of expected properties to be verified
			[ ] //					ANYTYPE		aLog	log error on exception (optional)
			[ ] //					FUZZYVERIFY	Fuzzy	enable fuzzy verification (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = wObj properties verified
			[ ] //								FALSE = wObj properties not verified
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 21, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[+] do
			[ ] wObj.VerifyProperties(lsProps, Fuzzy)		// verify properties of wObj
			[ ] return TRUE									// return TRUE if properties verified
		[-] except
			[ ] ErrorHandler(aLog, wObj, "properties")		// log error if aLog parameter provided
			[ ] return FALSE								// return FALSE
		[ ] 
		[ ] 
	[ ] 
	[+] hidecalls BOOLEAN DoVerifyEnabled(WINDOW wObj, BOOLEAN bState, ANYTYPE aLog optional)
		[ ] // ==========================================================
		[-] // FUNCTION: DoVerifyEnabled()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function verifies that the enable/disable state of wObj matches the expected
			[ ] // enable/disable state specified in bState, and returns the results as a BOOLEAN value.
			[ ] // If the aLog parameter is specified as a BOOLEAN value of TRUE, or if aLog contains
			[ ] // a string value, then an error will be logged if the enable/disable state of wObj does
			[ ] // not match bState.
			[ ] //
			[ ] // PARAMETERS:		WINDOW		wObj	object specifier
			[ ] //					BOOLEAN		bState	expected enable/disable state to be verified
			[ ] //					ANYTYPE		aLog	log error on exception (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = wObj enable/disable state verified
			[ ] //								FALSE = wObj enable/disable state not verified
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 21, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[-] do
			[ ] wObj.VerifyEnabled(bState)					// verify wObj enable state
			[ ] return TRUE									// return TRUE if state verified
		[-] except
			[ ] ErrorHandler(aLog, wObj, "enable state")
			[ ] return FALSE								// return FALSE
		[ ] 
		[ ] 
	[ ] 
	[+] hidecalls BOOLEAN DoVerifyVisible(WINDOW wObj, BOOLEAN bState, ANYTYPE aLog optional)
		[ ] // ==========================================================
		[+] // FUNCTION: DoVerifyVisible()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function verifies that the visiblity of wObj matches the expected visible
			[ ] // state specified in bState, and returns the results as a BOOLEAN value. If the aLog
			[ ] // parameter is specified as a BOOLEAN value of TRUE, or if aLog contains a string value,
			[ ] // then an error will be logged if the visiblity state of wObj does not match bState.
			[ ] //
			[ ] // PARAMETERS:	WINDOW		wObj	object specifier
			[ ] //				BOOLEAN		bState	expected visiblity state to be verified
			[ ] //				ANYTYPE		aLog	log error on exception (optional)
			[ ] //
			[ ] // RETURNS:		BOOLEAN		TRUE  = wObj visiblity state verified
			[ ] //							FALSE = wObj visiblity state not verified
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 22, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[-] do
			[ ] Verify(wObj.IsVisible(), bState)			// verify wObj exists
			[ ] return TRUE									// return TRUE if object exists
		[-] except
			[ ] ErrorHandler(aLog, wObj, "visible")			// log error if aLog parameter provided
			[ ] return FALSE								// return FALSE
		[ ] 
		[ ] 
	[ ] 
	[+] hidecalls BOOLEAN DoVerifyValue(WINDOW wObj, ANYTYPE aVal, ANYTYPE aLog optional)
		[ ] // ==========================================================
		[+] // FUNCTION: DoVerifyValue()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function verifies that the value of wObj matches the expected value specified
			[ ] // in aVal, and returns the results as a BOOLEAN value. If the aLog parameter is
			[ ] // specified as a BOOLEAN value of TRUE, or if aLog contains a string value, then
			[ ] // an error will be logged if the value of wObj does not match aExpected.
			[ ] //
			[ ] // PARAMETERS:		WINDOW		wObj	object specifier
			[ ] //					ANYTYPE		aVal	expected value to be verified
			[ ] //					ANYTYPE		aLog	log error on exception (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = wObj value verified
			[ ] //								FALSE = wObj value not verified
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 22, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[+] do
			[ ] wObj.VerifyValue(aVal)						// verify value of wObj
			[ ] return TRUE									// return TRUE if value verified
		[+] except
			[ ] ErrorHandler(aLog, wObj, "value")
			[ ] return FALSE
		[ ] 
		[ ] 
	[ ] 
	[+] hidecalls BOOLEAN DoVerifyFuzzy(ANYTYPE aActual, ANYTYPE aExpected, ANYTYPE aLog optional)
		[ ] // ==========================================================
		[+] // FUNCTION: DoVerifyFuzzy()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function verifies that the value in aActual matches the expected value specified
			[ ] // in aExpected using fuzzy verification, and returns the results as a BOOLEAN value. If
			[ ] // the aLog parameter is specified as a BOOLEAN value of TRUE, or if aLog contains a string
			[ ] // value, then an error will be logged if aActual does not match aExpected.
			[ ] //
			[ ] // PARAMETERS:		ANYTYPE		aActual		actual value to be verified
			[ ] //					ANYTYPE		aExpected	expected value to be verified
			[ ] //					ANYTYPE		aLog		log error on exception (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = values match
			[ ] //								FALSE = value do not match
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 23, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[-] do
			[ ] FuzzyVerify(aActual, aExpected)				// verify actual matches expected
			[ ] return TRUE									// return TRUE if matched
		[+] except
			[ ] STRING sErrMsg = "values"
			[-] if (aLog != NULL)
				[+] if (TypeOf(aLog) == STRING) || (aLog == TRUE)
					[+] if (TypeOf(aLog) == STRING)
						[ ] sErrMsg = aLog
					[ ] LogException(sErrMsg)
			[ ] return FALSE								// return FALSE if no match
		[ ] 
		[ ] 
	[ ] 
	[+] hidecalls INTEGER WaitFor1stWindow(LIST OF rWinStates lrWindows, REAL rTimeout optional)
		[ ] // ==========================================================
		[-] // FUNCTION: WaitFor1WindowState()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function waits for up to rTimeout seconds for any one of the windows in
			[ ] // lrWindows to match its target state and returns the result as an INTEGER value.
			[ ] //
			[ ] // PARAMETERS:		LIST OF rWinStates	lrWindows	list of target windows and states
			[ ] //					REAL				rTimeout	max wait time (optional)
			[ ] //
			[ ] // RETURNS:			INTEGER	0 = none of the windows matched their target states
			[ ] //							x = index of window in list that matched its target state
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 12, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] rWinStates	rTarget
		[ ] INTEGER	iTarget = 0
		[ ] INTEGER	iWindow
		[ ] HTIMER hWaitTimer = TimerCreate()					// initialize wait timer
		[+] if (rTimeout == NULL)								// if rTimeout not specified...
			[ ] rTimeout = Agent.GetOption(OPT_WINDOW_TIMEOUT)		// ...set Agent timeout value
		[ ] TimerStart(hWaitTimer)								// start wait timer
		[ ] // wait until a window exists or timer expires
		[-] while ((iTarget == 0) && (TimerValue(hWaitTimer) < rTimeout))
			[ ] iWindow = 0
			[-] for each rTarget in lrWindows
				[ ] iWindow++
				[-] if DoVerifyExists(rTarget.wTarget, rTarget.bExists)
					[ ] iTarget = iWindow
					[ ] break
			[ ] Sleep(0.5)		// loop
		[ ] TimerDestroy(hWaitTimer)							// get rid of timer
		[ ] return iTarget										// return result
		[ ] 
	[ ] 
	[+] hidecalls BOOLEAN WaitForState(WINDOW wObj, BOOLEAN bExists, REAL rTimeout optional)
		[ ] // ==========================================================
		[+] // FUNCTION: WaitForState()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function waits for up to rTimeout seconds for wObj to exist and returns the
			[ ] // result as a BOOLEAN value.
			[ ] //
			[ ] // PARAMETERS:		WINDOW	wObj		object specifier
			[ ] //					BOOLEAN	bExists		TRUE  = wait for object to exist
			[ ] //										FALSE = wait for object to be dismissed
			[ ] //					REAL	rTimeout	max wait time (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = wObj exists
			[ ] //								FALSE = wObj not found within rTimeout
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 23, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] HTIMER hWaitTimer = TimerCreate()					// initialize wait timer
		[+] if (rTimeout == NULL)								// if rTimeout not specified...
			[ ] rTimeout = Agent.GetOption(OPT_WINDOW_TIMEOUT)		// ...set Agent timeout value
		[ ] TimerStart(hWaitTimer)								// start wait timer
		[ ] // wait until object exists or timer expires
		[+] while !(DoVerifyExists(wObj, bExists)) && (TimerValue(hWaitTimer) < rTimeout)
			[ ] Sleep(0.5)		// loop
		[ ] TimerDestroy(hWaitTimer)							// get rid of timer
		[ ] return DoVerifyExists(wObj, bExists)				// return result
		[ ] 
		[ ] 
	[ ] 
	[+] hidecalls BOOLEAN WaitForProperties(WINDOW wObj, WINPROPTREE lsProps, REAL rTimeout optional)
		[ ] // ==========================================================
		[+] // FUNCTION: WaitForProperties()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function waits for up to rTimeout seconds for the properties of wObj to match
			[ ] // those specified in lsProps, and returns the result as a BOOLEAN value.
			[ ] //
			[ ] // PARAMETERS:		WINDOW		wObj		object specifier
			[ ] //					WINPROPTREE	lsProps		list of object properties to be matched
			[ ] //					REAL		rTimeout	max wait time (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = wObj properties matched before rTimeout
			[ ] //								FALSE = wObj properties not matched before rTimeout
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 21, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] HTIMER hWaitTimer = TimerCreate()					// initialize wait timer
		[+] if (rTimeout == NULL)								// if rTimeout not specified...
			[ ] rTimeout = Agent.GetOption(OPT_WINDOW_TIMEOUT)		// ...set Agent timeout value
		[ ] TimerStart(hWaitTimer)								// start wait timer
		[ ] // wait until object properties exist or timer expires
		[+] while !(DoVerifyProperties(wObj, lsProps)) && (TimerValue(hWaitTimer) < rTimeout)
			[ ] Sleep(0.5)		// loop
		[ ] TimerDestroy(hWaitTimer)							// get rid of timer
		[ ] return (DoVerifyProperties(wObj, lsProps))			// return result
		[ ] 
		[ ] 
	[ ] 
	[+] hidecalls BOOLEAN WaitForValue(WINDOW wObj, ANYTYPE aVal, REAL rTimeout optional)
		[ ] // ==========================================================
		[+] // FUNCTION: WaitForValue()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function waits for up to rTimeout seconds for the value of wObj to match the
			[ ] // value specified in aVal, and returns the result as a BOOLEAN value.
			[ ] //
			[ ] // PARAMETERS:		WINDOW		wObj		object specifier
			[ ] //					ANYTYPE		aVal		expected value to be verified
			[ ] //					REAL		rTimeout	max wait time (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = wObj properties matched before rTimeout
			[ ] //								FALSE = wObj properties not matched before rTimeout
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 21, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] HTIMER hWaitTimer = TimerCreate()					// initialize wait timer
		[+] if (rTimeout == NULL)								// if rTimeout not specified...
			[ ] rTimeout = Agent.GetOption(OPT_WINDOW_TIMEOUT)		// ...set Agent timeout value
		[ ] TimerStart(hWaitTimer)								// start wait timer
		[ ] // wait until object value exist or timer expires
		[+] while !(DoVerifyValue(wObj, aVal)) && (TimerValue(hWaitTimer) < rTimeout)
			[ ] Sleep(0.5)		// loop
		[ ] TimerDestroy(hWaitTimer)							// get rid of timer
		[ ] return (DoVerifyValue(wObj, aVal))					// return result
		[ ] 
		[ ] 
	[ ] 
	[+] VOID DoVerify(ANYTYPE aExpected,ANYTYPE aActual ,STRING sMag optional)
		[ ] // ==========================================================
		[+] // FUNCTION: DoVerify()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This is verification function used to compare two values.
			[ ] //
			[ ] // PARAMETERS:	ANYTYPE aExpected: Expected value
			[ ] //				ANYTYPE aActual: Actual value
			[ ] // 				STRING sMag optional : Message to print
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 8, 2006	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] 
		[-] if (sMag == NULL)
			[ ] sMag = BLANK_STR
		[-] if (aExpected == aActual)
			[ ] Log.Message("Verification passed", sMag)
		[-] else
			[ ] Log.Error("Verification failed {sMag}")
			[ ] 
	[ ] 
	[+] hidecalls BOOLEAN DoVerifyExists(WINDOW wObj, BOOLEAN bState, ANYTYPE aLog optional)
		[ ] // ==========================================================
		[-] // FUNCTION: DoVerifyExists()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This function verifies that the existence of wObj matches the expected existence
			[ ] // state specified in bState, and returns the results as a BOOLEAN value. If the aLog
			[ ] // parameter is specified as a BOOLEAN value of TRUE, or if aLog contains a string value,
			[ ] // then an error will be logged if the existence state of wObj does not match bState.
			[ ] //
			[ ] // PARAMETERS:		WINDOW		wObj	object specifier
			[ ] //					BOOLEAN		bState	expected existence state to be verified
			[ ] //					ANYTYPE		aLog	log error on exception (optional)
			[ ] //
			[ ] // RETURNS:			BOOLEAN		TRUE  = wObj existence state verified
			[ ] //								FALSE = wObj existence state not verified
			[ ] // REVISION HISTORY:
			[ ] //	 Dec 27, 2006	Bhagwat Kolde created
			[ ] 
		[ ] // ==========================================================
		[-] do
			[ ] Verify(wObj.Exists(), bState)				// verify wObj exists
			[ ] return TRUE									// return TRUE if object exists
		[-] except
			[ ] ErrorHandler(aLog, wObj, "existence")		// log error if aLog parameter provided
			[ ] return FALSE								// return FALSE
		[ ] 
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[ ] // *************************************************************************************
[ ] //	END OF INCLUDE FILE
[ ] // *************************************************************************************
[ ] 
