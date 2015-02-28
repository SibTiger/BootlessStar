REM =====================================================================
REM Restore: Main Menu
REM ----------------------------
REM This will print the restore menu on the screen and allows the user to pick which archive to extract automatically for them.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Restore Menu
REM # =============================================================================================
:Restore_Menu
CALL :DashboardOrClassicalDisplay
CALL :QuoteDatabase
ECHO Restore Menu
ECHO %Separator%
ECHO.
ECHO Available Backups:
ECHO %SeparatorLong%
ECHO.
DIR "%LocalDirectory.Backup%" /B /O:-D /P
ECHO.
ECHO %SeparatorLong%
ECHO.
ECHO Type the full name [with file extension] of the backup file to restore
ECHO   Warning: Do _NOT_ use quotes!
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Exit
CALL :UserInput
GOTO :Restore_Menu_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input
REM # =============================================================================================
:Restore_Menu_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
REM Does file exist or is it invalid
IF NOT EXIST "%LocalDirectory.Backup%\%STDIN%" (
    CALL :BadInput
    GOTO :Restore_Menu
)
CALL :Restore_Menu_UpdateVars "%STDIN%"
CALL :Restore_Menu_Password
CALL :ClearBuffer
EXIT /B 0



REM # =============================================================================================
REM # Parameters: [{String} ArchiveName]
REM # Documentation: Cache the user's requested archive to backup with the exact paths.
REM # =============================================================================================
:Restore_Menu_UpdateVars
SET "Source=%LocalDirectory.Backup%\%~1"
REM Output the contents in 'Output'
SET "Output=%LocalDirectory.Restore%\%~1"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Prompt the user for the password that is possibly used for the archive .
REM # =============================================================================================
:Restore_Menu_Password
ECHO.& ECHO.
REM ----
ECHO Enter the password that was used for encrypting the data; leave blank if there's no password.
ECHO Enter Password:
CALL :UserInput
REM ----
SET "ArchivePassword=%STDIN%"
GOTO :EOF