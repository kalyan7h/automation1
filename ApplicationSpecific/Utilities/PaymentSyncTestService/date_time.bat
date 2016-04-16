@echo off
echo Started Batch Execution ...

echo ...%DATE%
echo Current Year: %DATE:~-4%
echo Current Month: %DATE:~4,2%
set month=%DATE:~4,2%

GOTO CASE_%month%
:CASE_04
    set month=April
    GOTO END_SWITCH
:CASE_1
    ECHO i equals 1
    GOTO END_SWITCH
:END_SWITCH

set TestServicePath= "C:\automation\TestingService\TestService\Once\Sandeep\%month%"
echo %TestServicePath%
