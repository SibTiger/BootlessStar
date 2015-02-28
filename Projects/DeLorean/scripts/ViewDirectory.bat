REM =====================================================================
REM View Directories
REM ----------------------------
REM Within this section, this will allow the user to simply open directories right from the GUI shell -- nothing fancy other than EXPLORER calls.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: What directory does the user wish to view?
REM # =============================================================================================
:ViewDirectories
CALL :DashboardOrClassicalDisplay
CALL :QuoteDatabase
ECHO Open a Directory Menu
ECHO %Separator%
ECHO.
ECHO [1] Backup Directory
ECHO [2] Restore Directory
ECHO [3] Log Directory
ECHO [X] Exit
CALL :UserInput
GOTO :ViewDirectories_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input
REM # =============================================================================================
:ViewDirectories_UserInput
IF "%STDIN%" EQU "1" (
    CALL :ViewDirectories_InputDriver Backup
    GOTO :ViewDirectories
)
IF "%STDIN%" EQU "2" (
    CALL :ViewDirectories_InputDriver Restore
    GOTO :ViewDirectories
)
IF "%STDIN%" EQU "3" (
    CALL :ViewDirectories_InputDriver Log
    GOTO :ViewDirectories
)
IF /I "%STDIN%" EQU "X" GOTO :EOF
CALL :BadInput& GOTO :ViewDirectories



REM # =============================================================================================
REM # Documentation: Manage the users request in a simple package and slightly easier to manage.
REM # =============================================================================================
:ViewDirectories_InputDriver
IF %1 EQU Backup CALL :ViewDirectories_BackupDir
IF %1 EQU Restore CALL :ViewDirectories_RestoreDir
IF %1 EQU Log CALL :ViewDirectories_LogDir
CALL :ClearBuffer
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Open the Backup Directory within the graphical user interface.
REM # =============================================================================================
:ViewDirectories_BackupDir
CALL :Call_WindowsExplorer "%LocalDirectory.Backup%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Open the Restore Directory within the graphical user interface.
REM # =============================================================================================
:ViewDirectories_RestoreDir
CALL :Call_WindowsExplorer "%LocalDirectory.Restore%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Open the Log Directory within the graphical user interface.
REM # =============================================================================================
:ViewDirectories_LogDir
CALL :Call_WindowsExplorer "%LocalDirectory.Logs%"
GOTO :EOF