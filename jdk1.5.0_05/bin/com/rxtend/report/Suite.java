package com.rxtend.report;

import java.util.HashMap;
import java.util.Vector;

// Referenced classes of package com.rxtend.report:
//            DebugLogger, AccessLog

public class Suite
{

    private DebugLogger dLogger;
    public static final String SUITES_TABLE = "SUITES";
    public static final String SUITE = "SUITE";
    public static final String START_TIME = "START_TIME";
    public static final String END_TIME = "END_TIME";
    public static final String TESTRUNID = "TESTRUNID";
    public static final String TOOLID = "TOOLID";
    private HashMap map;

    public Suite(String toolId, String testRunId, String logDB)
    {
        dLogger = DebugLogger.getDebugLogger();
        getSuiteDetails(toolId, testRunId, logDB);
    }

    public void getSuiteDetails(String toolId, String testRunId, String logDB)
    {
        try
        {
            AccessLog accessDAO = new AccessLog();
            Vector suites = new Vector();
            String query = (new StringBuilder("SELECT * FROM SUITES WHERE TESTRUNID='")).append(testRunId).append("' AND ").append("TOOLID").append("='").append(toolId).append("'").toString();
		System.out.println("Query in getSuiteDetails is :"+query);
            suites = accessDAO.executeSelect(logDB, query);
            map = (HashMap)(HashMap)suites.get(0);
        }
        catch(Exception e)
        {
            e.printStackTrace();
            dLogger.logError(e.getMessage());
        }
    }

    public String getSuiteName()
    {
        return map.get("SUITE").toString();
    }

    public String getStartTime()
    {
        return map.get("START_TIME").toString();
    }

    public String getEndTime()
    {
        return map.get("END_TIME").toString();
    }

    public String getTestRunId()
    {
        return map.get("TESTRUNID").toString();
    }
}
