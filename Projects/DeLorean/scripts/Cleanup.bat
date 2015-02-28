REM =====================================================================
REM Clean-up Local Directories
REM ----------------------------
REM This functionality allows the user to thrash all of the data that is stored in the local directories.
REM This helps the user to remove all of the abundant superfluous data that has accumulated within the user's secondary storage.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Cleanup menu
REM # =============================================================================================
:Cleanup
CALL :DashboardOrClassicalDisplay
CALL :Cleanup_Menu_Warning
ECHO Clean-up Local Directories Menu
ECHO %Separator%
ECHO.
ECHO Clean-up the following directories:
ECHO.
ECHO [1] Temporary files
ECHO [2] Backup files
ECHO [3] Restore files
ECHO [4] Log files
ECHO [A] Everything
ECHO [X] Exit
CALL :UserInput
CALL :Cleanup_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input
REM # =============================================================================================
:Cleanup_UserInput
REM Check the parameters and determine how to execute.
IF "%STDIN%" EQU "1" GOTO :Cleanup_Choice_TemporaryFiles
IF "%STDIN%" EQU "2" GOTO :Cleanup_Choice_BackupFiles
IF "%STDIN%" EQU "3" GOTO :Cleanup_Choice_RestoreFiles
IF "%STDIN%" EQU "4" GOTO :Cleanup_Choice_LogFiles
IF /I "%STDIN%" EQU "A" GOTO :Cleanup_Choice_Everything
IF /I "%STDIN%" EQU "X" GOTO :EOF
CALL :BadInput& GOTO :Cleanup



REM # =============================================================================================
REM # Documentation: Print this warning message to alert the user that these changes has effects and consequences
REM # =============================================================================================
:Cleanup_Menu_Warning
ECHO ^<?^>       WARNING       ^<?^>
ECHO %SeparatorLong%
ECHO.
ECHO Clean-up will effectively thrash the data that is located with the directories or just specific directories as requested by the user.  This feature will help the end-user to automatically flush all of the superfluous data that might have accumulated over time, which will allow the user to gain back some free space (from their secondary storage devices).
ECHO.
ECHO ATTENTION: Once these files have been deleted, it is possible to easily recover the data!
ECHO.&ECHO.
GOTO :EOF



REM =====================================================
REM -----------------------------------------------------
REM =====================================================



REM # =============================================================================================
REM # Documentation: Thrash: Log files
REM #     Requires User Confirmation? No
REM # =============================================================================================
:Cleanup_Choice_LogFiles
CALL :Cleanup_Thrash_LogFiles
CALL :ClearBuffer
GOTO :Cleanup



REM # =============================================================================================
REM # Documentation: Thrash: Backup files
REM #     Requires User Confirmation? Yes
REM # =============================================================================================
:Cleanup_Choice_BackupFiles
CALL :Cleanup_Thrash_BackupFiles
CALL :ClearBuffer
GOTO :Cleanup



REM # =============================================================================================
REM # Documentation: Thrash: Temporary files
REM #     Requires User Confirmation? No
REM # =============================================================================================
:Cleanup_Choice_TemporaryFiles
CALL :Cleanup_Thrash_TemporaryFiles
CALL :ClearBuffer
GOTO :Cleanup



REM # =============================================================================================
REM # Documentation: Thrash: Restore files
REM #     Requires User Confirmation? Yes
REM # =============================================================================================
:Cleanup_Choice_RestoreFiles
CALL :Cleanup_Thrash_RestoreFiles
CALL :ClearBuffer
GOTO :Cleanup



REM # =============================================================================================
REM # Documentation: Thrash: Everything [Logs, Backup, Temporary, and Restore]
REM #     Requires User Confirmation? Yes
REM # =============================================================================================
:Cleanup_Choice_Everything
CALL :Cleanup_Thrash_LogFiles
CALL :Cleanup_Thrash_BackupFiles
CALL :Cleanup_Thrash_TemporaryFiles
CALL :Cleanup_Thrash_RestoreFiles
CALL :ClearBuffer
GOTO :Cleanup



REM =====================================================
REM -----------------------------------------------------
REM =====================================================



REM # =============================================================================================
REM # Documentation: Thrash all of the log files
REM # =============================================================================================
:Cleanup_Thrash_LogFiles
ECHO Thrashing log files. . .
CALL :Cleanup_Thrash_DelCall "%LocalDirectory.Logs%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Thrash all of the backup files.  This will require a confirmation pass from the user.
REM # =============================================================================================
:Cleanup_Thrash_BackupFiles
ECHO Thrashing backup contents and database. . .
CALL :Cleanup_Thrash_Confirm Backup
IF %ERRORLEVEL% EQU 0 (
    REM The user really wanted to remove the contents within this directory
    CALL :Cleanup_Thrash_DelCall "%LocalDirectory.Backup%"
) ELSE (
    REM Do not remove the contents within the directory.
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Thrash all of the restore files.  This will require a confirmation pass from the user.
REM # =============================================================================================
:Cleanup_Thrash_RestoreFiles
ECHO Thrashing restore contents. . .
CALL :Cleanup_Thrash_Confirm Restore
IF %ERRORLEVEL% EQU 0 (
    REM The user really wanted to remove the contents within this directory
    CALL :Cleanup_Thrash_DelCall "%LocalDirectory.Restore%"
) ELSE (
    REM Do not remove the contents within the directory.
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Thrash all of the Temporary files
REM # =============================================================================================
:Cleanup_Thrash_TemporaryFiles
ECHO Thrashing temporary files. . .
CALL :Cleanup_Thrash_DelCall "%LocalDirectory.Temp%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This will display an error if incase the local directory files could not successfully expunged.
REM # =============================================================================================
:Cleanup_Thrash_Error
ECHO ^<!^>       ERROR       ^<!^>
ECHO %SeparatorLong%
ECHO.
ECHO Could not successfully thrash all of the files!
ECHO.
PAUSE
ECHO.&ECHO.
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} NiceNameDirectory]
REM # Documentation: Display a confirmation request.  Just incase the user accidentally presses the wrong key.
REM # =============================================================================================
:Cleanup_Thrash_Confirm
ECHO.
ECHO ^<?^>       ATTENTION       ^<?^>
ECHO %SeparatorLong%
ECHO.
ECHO Are you sure you want to remove all contents from the [ %1 ] directory?
ECHO.
ECHO [Yes] Yes
ECHO Any other key will mean 'no'.
CALL :UserInput
CALL :Cleanup_Thrash_Confirm_UserInput
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Make sure that user really wanted to remove a specific directory.
REM # =============================================================================================
:Cleanup_Thrash_Confirm_UserInput
IF /I "%STDIN%" EQU "Yes" (
    EXIT /B 0
) ELSE (
    EXIT /B 1
)



REM # =============================================================================================
REM # Documentation: This function will allow the user to thrash a collection of files as requested.
REM # Parameters: [{string}Directory]
REM # =============================================================================================
:Cleanup_Thrash_DelCall
REM Expunge all data from the directories and subdirectories
DEL /F /Q /S "%~1\*.*" > NUL || CALL :Cleanup_Thrash_Error
REM Expunge all of the directories
FOR /D %%i IN ("%~1\*") DO RMDIR /Q /S "%%i" > NUL || CALL :Cleanup_Thrash_Error
GOTO :EOF