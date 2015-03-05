REM =====================================================================
REM Main Restore Driver
REM ----------------------------
REM This is a simple driver for calling other functions that properly helps to restore the user's personalized data.
REM =====================================================================



REM # =============================================================================================
REM # Documentation: This driver will guide the entire restore procedure.
REM # =============================================================================================
:Restore
REM Prompt the user with the restore menu; if the user cancels out - terminate the process.
CALL :Restore_MenuSection || GOTO :EOF
REM ----

REM The Restore Process
CALL :DashboardOrClassicalDisplay
CALL :QuoteDatabase


REM ----
REM Display the header message
CALL :Operation_DisplayHeaderMessage

REM ----
REM Check if the restore data already exists in the restore directory, and any other steps necessary.
CALL :Restore_Prepare || (CALL :Operation_TerminateWithError& GOTO :EOF)

REM ----
REM Restore the data
CALL :Restore_Extract || (CALL :Operation_TerminateWithError& GOTO :EOF)

REM ----
REM Completed, successfully finished
CALL :Operation_TerminateSuccessfully
REM Finished
PAUSE
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This section merely prompts the user with the Restore Menu
REM # =============================================================================================
:Restore_MenuSection
REM Display the Restore menu; allow the user to select which package they want to restore from
REM    Error out if the user cancels
CALL :Restore_Menu || EXIT /B 1
REM ----
REM Clear the terminal screen
CALL :ClearBuffer
EXIT /B 0