REM =====================================================================
REM Dashboard - Detection
REM ----------------------------
REM This is merely an extended version of the dashboard feature, though this includes further checks.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function executes the entire detection procedure for the Dashboard Viewer Tool.
REM # =============================================================================================
:DashboardDetection
CALL :DashboardDetection_CheckResources
IF %ProcessVarB% NEQ 0 EXIT /B 1
EXIT /B 0



REM # =============================================================================================
REM # Documentation: This function scans for warnings that could cause problems when attempting to compile the project.
REM # =============================================================================================
:DashboardDetection_CheckResources
REM Clear the variables
SET ProcessVarA=
SET ProcessVarB=0

CALL :DashboardDetection_dotNETFoundation3-5
IF %ERRORLEVEL% EQU 1 (
    SET "ProcessVarA=%ProcessVarA%.NET Framework 3.5 - Not Found!&ECHO."
    SET /A ProcessVarB=%ProcessVarB%+1
)
CALL :DashboardDetection_VisualStudio
IF %ERRORLEVEL% EQU 1 (
    SET "ProcessVarA=%ProcessVarA%Visual Studio - Not Found!&ECHO."
    SET /A ProcessVarB=%ProcessVarB%+1
)
CALL :DashboardDetection_WorkingCopy
IF %ERRORLEVEL% EQU 1 (
    SET "ProcessVarA=%ProcessVarA%Doom Builder 64 Dir - Not Found!&ECHO."
    SET /A ProcessVarB=%ProcessVarB%+1
)
CALL :DashboardDetection_SVN
IF %ERRORLEVEL% EQU 1 (
    SET "ProcessVarA=%ProcessVarA%Subversion - Not Found!&ECHO."
    SET /A ProcessVarB=%ProcessVarB%+1
)
CALL :DashboardDetection_7Zip
IF %ERRORLEVEL% EQU 1 (
    SET "ProcessVarA=%ProcessVarA%7Zip - Not Found!&ECHO."
    SET /A ProcessVarB=%ProcessVarB%+1
)
CALL :DashboardDetection_InnoSetup
IF %ERRORLEVEL% EQU 1 (
    SET "ProcessVarA=%ProcessVarA%Inno Setup - Not Found!&ECHO."
    SET /A ProcessVarB=%ProcessVarB%+1
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Were we able to detect the project's Working Copy files?
REM # =============================================================================================
:DashboardDetection_WorkingCopy
REM Doom Builder 64 Local Working Copy
CALL :DetectionProject "%UserConfig.DirProjectWorkingCopy%"
IF %ERRORLEVEL% EQU 0 EXIT /B 1
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Was the Subversion Commandline tools detected from the core?
REM # =============================================================================================
:DashboardDetection_SVN
IF %UserConfig.SVNMasterControl% EQU True (
    IF %Detect_SVN% EQU False EXIT /B 1
)
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Was the 7Zip software detected from the core?
REM # =============================================================================================
:DashboardDetection_7Zip
IF %UserConfig.7ZipMasterControl% EQU True (
    IF %Detect_7Zip% EQU False EXIT /B 1
)
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Was the Inno Setup software detected from the core?
REM # =============================================================================================
:DashboardDetection_InnoSetup
IF %UserConfig.InnoMasterControl% EQU True (
    IF %Detect_InnoSetup% EQU False EXIT /B 1
)
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Was Microsoft .NET Framework 3.5 detected from the core?
REM # =============================================================================================
:DashboardDetection_dotNETFoundation3-5
IF %Detect_dotNET3.5% EQU False (
    EXIT /B 1
) ELSE (
    EXIT /B 0
)



REM # =============================================================================================
REM # Documentation: Was a product of Microsoft Visual Studio selected?
REM # =============================================================================================
:DashboardDetection_VisualStudio
IF NOT DEFINED VisualStudio (
    EXIT /B 1
) ELSE (
    EXIT /B 0
)