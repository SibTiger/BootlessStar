REM =====================================================================
REM Prerequisites Check
REM ----------------------------
REM Check if wither or not the user meets all of the necessary prerequisites.  If the user is missing the necessary prerequisites - then the users session will ultimately terminate.  Other prerequisites, however, such as local directories can be created and setup for the program's use exclusively.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function will run through the prerequisite driver and make sure that this program's dependencies are meet.
REM # =============================================================================================
:Prerequisite_Driver
REM Does the Local Directories exists?
CALL :Prerequisites_LocalDirectory
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: If the local directories where not created, then display a warning message.
REM # =============================================================================================
:Prerequisites_LocalDirectory_CheckErr
ECHO !ERR_CRIT!: Could not create dependable directories!
ECHO              %LocalDirectory.MainRoot%
ECHO              %LocalDirectory.Temp%
ECHO              %LocalDirectory.UserConfig%
ECHO              %LocalDirectory.Backup%
ECHO              %LocalDirectory.Restore%
ECHO              %LocalDirectory.Logs%
PAUSE
EXIT /B 1



REM # =============================================================================================
REM # Documentation: This function will check to make sure if the local directories exists within the filesystem, if - however they do not exist, then the directories will be created.  This local directories are crucial for this program as they are used for storing temporary data and output data.
REM # =============================================================================================
:Prerequisites_LocalDirectory
IF NOT EXIST "%LocalDirectory.MainRoot%" (
    MKDIR "%LocalDirectory.MainRoot%" || GOTO :Prerequisites_LocalDirectory_CheckErr
)
IF NOT EXIST "%LocalDirectory.Temp%" (
    MKDIR "%LocalDirectory.Temp%" || GOTO :Prerequisites_LocalDirectory_CheckErr
)
IF NOT EXIST "%LocalDirectory.UserConfig%" (
    MKDIR "%LocalDirectory.UserConfig%" || GOTO :Prerequisites_LocalDirectory_CheckErr
)
IF NOT EXIST "%LocalDirectory.Backup%" (
    MKDIR "%LocalDirectory.Backup%" || GOTO :Prerequisites_LocalDirectory_CheckErr
)
IF NOT EXIST "%LocalDirectory.Restore%" (
    MKDIR "%LocalDirectory.Restore%" || GOTO :Prerequisites_LocalDirectory_CheckErr
)
IF NOT EXIST "%LocalDirectory.Logs%" (
    MKDIR "%LocalDirectory.Logs%" || GOTO :Prerequisites_LocalDirectory_CheckErr
)
EXIT /B 0