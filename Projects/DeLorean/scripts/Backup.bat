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
CALL :Backup_FlushTempDirectory || GOTO :Operation_TerminateWithError

REM ----
REM Prepare the environment for the backup process.
CALL :Backup_Prepare || GOTO :Operation_TerminateWithError

REM ----
REM Check to make sure that all prerequisites and dependencies are available and ready to be used.  This detection is important, otherwise - everything will be a waste of time if some minor issue occurs.
CALL :Backup_CheckResources || GOTO :Operation_TerminateWithError

REM ----
REM Call the Backup Driver
CALL :Backup_Compact || GOTO :Operation_TerminateWithError

REM ----
REM Test the archive file
CALL :Backup_Test || GOTO :Operation_TerminateWithError

REM ----
REM Flush the Temporary directory; if in-case anything was there previously
CALL :Backup_FlushTempDirectory || GOTO :Operation_TerminateWithError

REM ----
REM Completed, successfully finished
GOTO :Operation_TerminateSuccessfully