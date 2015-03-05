REM =====================================================================
REM Main Backup Driver
REM ----------------------------
REM This is a simple driver for calling other functions that properly helps to backup the user's personalized data.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This driver will guide the entire backup procedure.
REM # =============================================================================================
:Backup
CALL :DashboardOrClassicalDisplay
CALL :QuoteDatabase

REM ----
REM Display the header message
CALL :Operation_DisplayHeaderMessage

REM ----
REM Flush the Temporary directory; if in-case anything was there previously
CALL :Backup_FlushTempDirectory || (CALL :Operation_TerminateWithError& GOTO :EOF)

REM ----
REM Prepare the environment for the backup process.
CALL :Backup_Prepare || (CALL :Operation_TerminateWithError& GOTO :EOF)

REM ----
REM Check to make sure that all prerequisites and dependencies are available and ready to be used.  This detection is important, otherwise - everything will be a waste of time if some minor issue occurs.
CALL :Backup_CheckResources || (CALL :Operation_TerminateWithError& GOTO :EOF)

REM ----
REM Call the Backup Driver
CALL :Backup_Compact || (CALL :Operation_TerminateWithError& GOTO :EOF)

REM ----
REM Test the archive file
CALL :Backup_Test || (CALL :Operation_TerminateWithError& GOTO :EOF)

REM ----
REM Flush the Temporary directory; if in-case anything was there previously
CALL :Backup_FlushTempDirectory || (CALL :Operation_TerminateWithError& GOTO :EOF)

REM ----
REM Completed, successfully finished
CALL :Operation_TerminateSuccessfully
REM Check Power Settings; wither or not the system needs to be hibernated, enter sleep mode, etc.
CALL :PowerState
REM Finished
GOTO :EOF