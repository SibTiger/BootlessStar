REM =====================================================================
REM Main Menu Interaction Field
REM ----------------------------
REM The main menu for the module program.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Main menu of the program.
REM # =============================================================================================
:MainMenu
CALL :DashboardOrClassicalDisplay
CALL :QuoteDatabase
ECHO %ProjectName% Menu
ECHO %Separator%
ECHO.
ECHO Main Tasks
ECHO %SeparatorSmall%
ECHO [1] Backup
ECHO [2] Restore
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [S] Settings
ECHO [V] View Directories
ECHO [C] Cleanup
ECHO [U] Check for Updates
ECHO [X] Exit
CALL :UserInput
GOTO :Menu_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input.
REM # =============================================================================================
:Menu_UserInput
IF "%STDIN%" EQU "1" GOTO :Main_Choice_Backup
IF "%STDIN%" EQU "2" GOTO :Main_Choice_Restore
IF /I "%STDIN%" EQU "S" GOTO :Main_Choice_Settings
IF /I "%STDIN%" EQU "V" GOTO :Main_Choice_ViewDirectories
IF /I "%STDIN%" EQU "C" GOTO :Main_Choice_Cleanup
IF /I "%STDIN%" EQU "U" GOTO :Main_Choice_Updates
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
CALL :BadInput& GOTO :MainMenu



REM # =============================================================================================
REM # Documentation: Backup the users data
REM # =============================================================================================
:Main_Choice_Backup
CALL :ClearBuffer
CALL :Backup
CALL :ClearBuffer
GOTO :MainMenu



REM # =============================================================================================
REM # Documentation: Restore the users data
REM # =============================================================================================
:Main_Choice_Restore
CALL :ClearBuffer
CALL :Restore
CALL :ClearBuffer
GOTO :MainMenu



REM # =============================================================================================
REM # Documentation: Access the control panel.
REM # =============================================================================================
:Main_Choice_Settings
CALL :ClearBuffer
CALL :Settings
CALL :ClearBuffer
GOTO :MainMenu



REM # =============================================================================================
REM # Documentation: Check for available module updates.
REM # =============================================================================================
:Main_Choice_Updates
CALL :ClearBuffer
CALL :ModuleUpdates
CALL :ClearBuffer
GOTO :MainMenu



REM # =============================================================================================
REM # Documentation: Cleanup the local directory and sub-directories.
REM # =============================================================================================
:Main_Choice_Cleanup
CALL :ClearBuffer
CALL :Cleanup
CALL :ClearBuffer
GOTO :MainMenu



REM # =============================================================================================
REM # Documentation: Allow the user to simply open directories in the GUI shell.
REM # =============================================================================================
:Main_Choice_ViewDirectories
CALL :ClearBuffer
CALL :ViewDirectories
CALL :ClearBuffer
GOTO :MainMenu