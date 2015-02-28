REM =====================================================================
REM Backup: Testing
REM ----------------------------
REM This section will manage the integrity testing of the archive file.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Main testing driver
REM # =============================================================================================
:Backup_Test
REM Display that we're starting the backup process
SET "DriversNiceTask=Testing archive file [ %Backup_FileName% ]"
CALL :Operation_Display_IncomingTask "%DriversNiceTask%"
REM ----
REM Call the parameter builder
CALL :Backup_Compact_ParameterBuildTesting
REM ----
REM Call the actual process
CALL :Backup_Test_Task || (CALL :Backup_Test_FailureCheck& CALL :CaughtErrorSignal& EXIT /B 1)
REM ----
REM Print the footer in the log.
CALL :Operation_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Test the backup archive file
REM # =============================================================================================
:Backup_Test_Task
CALL :Operation_Display_IncomingTaskSubLevel "Archive integrity testing"
SET TaskCaller_NiceProgramName=SevenZip
SET TaskCaller_CallLong="%Path7Zip%" t %ProcessVarA%
CALL :Operation_TaskOperation
EXIT /B %ExitCode%



REM # =============================================================================================
REM # Documentation: 7Zip returned an error during the testing
REM # =============================================================================================
:Backup_Test_FailureCheck
CALL :Operation_Display_IncomingTaskSubLevelMSG "!ERR_CRIT!: 7Zip has detected that the archive file [ %Output% ] is damaged!"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: 7Zip Testing Parameter Builder
REM # =============================================================================================
:Backup_Compact_ParameterBuildTesting
SET ProcessVarA="%Output%.%SevZipFileExtension%"
IF %SevZipUseKey% EQU True (
    SET ProcessVarA=%ProcessVarA% -p%SevZipKey%
)
GOTO :EOF