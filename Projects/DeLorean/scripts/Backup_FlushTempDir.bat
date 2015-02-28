REM =====================================================================
REM Backup: Thrash Temporary Contents
REM ----------------------------
REM This section will thrash all of the contents that is within the temporary directory.  This will make sure that all of the contents that is still stored within the directory is - expunged and not confused with the newer backup image or left over data that is hogging additional secondary storage within the system.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This manager will make sure that the temporary files are thrashed
REM # =============================================================================================
:Backup_FlushTempDirectory
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Thrash the local temporary directory"
REM Print on the screen that the program is trying to self-check
CALL :Operation_Display_IncomingTask "%DriversNiceTask%"
REM ----
CALL :Backup_FlushTempDirectory_Thrash || (CALL :CaughtIssueSignal& EXIT /B 1)
REM ----
REM Print the footer in the log.
CALL :Operation_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: This function will thrash the temporary directory's contents.
REM # =============================================================================================
:Backup_FlushTempDirectory_Thrash
CALL :Operation_Display_IncomingTaskSubLevel "Flushing the local temporary directory"
REM Expunge all data from the directories and subdirectories
CALL :Backup_FlushTempDirectory_Thrash_PhaseOne || (CALL :Backup_FlushTempDirectory_Thrash_Err& EXIT /B 1)
CALL :Backup_FlushTempDirectory_Thrash_PhaseTwo || (CALL :Backup_FlushTempDirectory_Thrash_Err& EXIT /B 1)
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Expunge the files within the directory.
REM # =============================================================================================
:Backup_FlushTempDirectory_Thrash_PhaseOne
CALL :Operation_Display_IncomingTaskSubLevelMSG "Deleting data from %LocalDirectory.Temp%\*.*"
REM Do not push this through "Operation_TaskOperation" function; this could cause the terminal to be 'Ghosting' and lose ALL processes.  Did I find a Windows Batch Shell bug?
DEL /F /Q /S "%LocalDirectory.Temp%\*.*" > NUL || EXIT /B 1
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Expunge all of the sub-directories.
REM # =============================================================================================
:Backup_FlushTempDirectory_Thrash_PhaseTwo
CALL :Operation_Display_IncomingTaskSubLevelMSG "Removing subdirectories in %LocalDirectory.Temp%\*.*"
REM Do not push this through "Operation_TaskOperation" function; this could cause the terminal to be 'Ghosting' and lose ALL processes.  Did I find a Windows Batch Shell bug?
FOR /D %%i IN ("%LocalDirectory.Temp%\*") DO RMDIR /Q /S "%%i" || EXIT /B 1
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Failed to thrash the temporary directory.
REM # =============================================================================================
:Backup_FlushTempDirectory_Thrash_Err
CALL :Operation_Display_IncomingTaskSubLevelMSG "!ERR_CRIT!: Could not properly thrash the temporary directory!"
GOTO :EOF