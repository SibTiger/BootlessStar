REM =====================================================================
REM Visual Studio Detection
REM ----------------------------
REM This entire section is detected for scanning available Visual Studio installations and choosing the appropriate version for compiling the project.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function will try at best to determine the best version of Visual Studio to use for the project.  As of developing this section, the best is product is: 2008 && 2010 -- Anything higher may result into issues with the .NET foundation.
REM # =============================================================================================
:VisualStudio_AutomaticDetection
REM Visual Studio Versions:
REM 2008
IF %Detect_MSVS90COMMTOOLS% EQU True (
    SET "VisualStudio=%PathMSVS2008%"
    GOTO :EOF
)

REM 2010
IF %Detect_MSVS100COMMTOOLS% EQU True (
    SET "VisualStudio=%PathMSVS2010%"
    GOTO :EOF
)

REM 2012
IF %Detect_MSVS110COMMTOOLS% EQU True (
    SET "VisualStudio=%PathMSVS2012%"
    GOTO :EOF
)

REM 2013
IF %Detect_MSVS120COMMTOOLS% EQU True (
    SET "VisualStudio=%PathMSVS2013%"
    GOTO :EOF
)
REM Could not find any suitable version
ECHO !ATTN!: Could not find any suitable Microsoft Visual Studio versions within the system!
PAUSE
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Find the nice name for the currently used Visual Studio version.
REM # =============================================================================================
:VisualStudio_FindNiceName
REM 2008
IF "%VisualStudio%" EQU "%PathMSVS2008%" (
    SET VisualStudioNiceName=Visual Studio 2008
    GOTO :EOF
)

REM 2010
IF "%VisualStudio%" EQU "%PathMSVS2010%" (
    SET VisualStudioNiceName=Visual Studio 2010
    GOTO :EOF
)

REM 2012
IF "%VisualStudio%" EQU "%PathMSVS2012%" (
    SET VisualStudioNiceName=Visual Studio 2012
    GOTO :EOF
)

REM 2013
IF "%VisualStudio%" EQU "%PathMSVS2013%" (
    SET VisualStudioNiceName=Visual Studio 2013
    GOTO :EOF
)
REM Could not find any suitable version
ECHO !ATTN!: Could not find the name of the current Visual Studio preferred!  As such, the name within the location is currently unknown.
SET VisualStudioNiceName=UNKNOWN
PAUSE
GOTO :EOF