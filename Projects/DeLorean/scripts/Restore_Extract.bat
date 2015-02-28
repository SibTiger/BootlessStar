REM =====================================================================
REM Restore: Extracting \ Restore
REM ----------------------------
REM This section will manage the extraction process of the archive file.
REM =====================================================================



REM # =============================================================================================
REM # Documentation: This function will create the output path that is going to be the placeholder for the archive extraction.
REM # =============================================================================================
:Restore_Extract
REM Display that we're starting the backup process
SET "DriversNiceTask=Restore the data"
CALL :Operation_Display_IncomingTask "%DriversNiceTask%"
REM ----
REM Build the parameters
CALL :Restore_Extract_ParameterBuild
REM ----
REM Call the actual process
CALL :Restore_Extract_Task || (CALL :Restore_ExtractErr& CALL :CaughtErrorSignal& EXIT /B 1)
REM ----
REM Print the footer in the log.
CALL :Operation_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0


REM # =============================================================================================
REM # Documentation: Extract the backup contents from the archive file
REM # =============================================================================================
:Restore_Extract_Task
CALL :Operation_Display_IncomingTaskSubLevel "Extracting the data"
SET TaskCaller_NiceProgramName=SevenZip
SET TaskCaller_CallLong="%Path7Zip%" x %ProcessVarA%
CALL :Operation_TaskOperation
EXIT /B %ExitCode%



REM # =============================================================================================
REM # Documentation: 7Zip returned an error when trying to extract the contents from the archive file
REM # =============================================================================================
:Restore_ExtractErr
CALL :Operation_Display_IncomingTaskSubLevelMSG "!ERR_CRIT!: 7Zip could not successfully extract the contents from archive file [ %Source% ]."
GOTO :EOF



REM # =============================================================================================
REM # Documentation: 7Zip Restore Parameter Builder
REM # =============================================================================================
:Restore_Extract_ParameterBuild
SET ProcessVarA="%Source%" -o"%Output%"
IF DEFINED ArchivePassword (
    SET ProcessVarA=%ProcessVarA% -p%ArchivePassword%
)
GOTO :EOF