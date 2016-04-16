	[ ] STRING sAutolabResultsInterface = "java -jar q:\bin\AutolabResultsUpload.jar"
	[-] BOOLEAN IsQAD ()
		[ ] //#
		[ ] //returns:	BOOLEAN:
		[ ] //notes:	Checks to see if QAD Suite ID environment variable is there.
		[ ] //#
		[ ] return Val (HOST_GetEnv ("QC_SUITE_ID"))
	[-] CleanupResults()
		[ ] // This method should be the first method called and should be called only once before adding testsuites or tests
		[ ] // This method marks the one test already added by Autolab execution engine as inactive.
		[ ] // This is required to have clean results as the team needs
		[-] if (IsQAD ())
			[ ] STRING sCmd = sAutolabResultsInterface + " 1 " + HOST_GetEnv ("AL_ODR") + " " + HOST_GetEnv ("AL_TASK_ID")
			[ ] SYS_Execute(sCmd)
	[-] AddTestSuite(STRING sSuiteName)
		[ ] // Use this method to add a new test Suite/feature
		[ ] // Do not have spaces in Suitename
		[-] if (IsQAD ())
			[ ] STRING sCmd = sAutolabResultsInterface + " 2 " + HOST_GetEnv ("AL_ODR") + " " + HOST_GetEnv ("AL_TASK_ID") + " " + sSuiteName
			[ ] SYS_Execute(sCmd)
	[-] AddTestCase(STRING sSuiteName, STRING sTestName, STRING sResult, STRING sMsg)
		[ ] // Use this method to add a new test case with status "Pass" or "Fail"
		[ ] // If result is "Fail", you can send in a fail message using the last parameter Msg
		[ ] // If result is "Pass", you can send an empty string for Msg
		[ ] // Do not have spaces in Suite name, test name and each test name should be **unique**
		[-] if (IsQAD ())
			[ ] STRING sCmd = sAutolabResultsInterface + " 3 " + HOST_GetEnv ("AL_ODR") + " " + HOST_GetEnv ("AL_TASK_ID") + " " + sSuiteName
			[ ] sCmd = sCmd + " " + sTestName + " " + sResult + " " + sMsg
			[ ] SYS_Execute(sCmd)
	[+] AddSubTest(STRING sSuiteName, STRING sTestName, STRING sSubTestName, STRING sResult, STRING sMsg)
		[ ] // Use this method to add a new sub test with status "Pass" or "Fail"
		[ ] // If result is "Fail", you can send in a fail message using the last parameter Msg
		[ ] // If result is "Pass", you can send an empty string for Msg
		[ ] // Do not have spaces in Suite name, test name and each test name should be **unique**
		[-] if (IsQAD ())
			[ ] STRING sCmd = sAutolabResultsInterface + " 4 " + HOST_GetEnv ("AL_ODR") + " " + HOST_GetEnv ("AL_TASK_ID") + " " + sSuiteName
			[ ] sCmd = sCmd + " " + sTestName + " " + sSubTestName + " " + sResult + " " + sMsg
			[ ] SYS_Execute(sCmd)
		[ ] 
