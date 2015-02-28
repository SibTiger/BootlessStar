REM =====================================================================
REM Backup: Compact
REM ----------------------------
REM This section will manage compacting the user's data from their home directory.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Compact the user's home directory
REM # =============================================================================================
:Backup_Compact
REM Display that we're starting the backup process
SET "DriversNiceTask=Backing up the %UserName%'s personalized settings"
CALL :Operation_Display_IncomingTask "%DriversNiceTask%"
REM ----
REM Build the parameters
CALL :Backup_Compact_ParameterBuild
REM ----
REM Call the actual process
CALL :Backup_Compact_Task || (CALL :CaughtErrorSignal& EXIT /B 1)
REM ----
REM Print the footer in the log.
CALL :Operation_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Compact the user's home directory
REM # =============================================================================================
:Backup_Compact_Task
CALL :Operation_Display_IncomingTaskSubLevel "Compacting the data"
SET TaskCaller_NiceProgramName=SevenZip
SET TaskCaller_CallLong="%Path7Zip%" a %ProcessVarA%
CALL :Operation_TaskOperation
EXIT /B %ExitCode%



REM # =============================================================================================
REM # Documentation: 7Zip Backup Parameter Builder
REM # =============================================================================================
:Backup_Compact_ParameterBuild
SET ProcessVarA="%Output%.%SevZipFileExtension%" "%USERPROFILE%" -t%SevZipArchiveFormat% -x@"%Backup_ExclusionList%" -mx=%SevZipCompressionPass% -mmt=%SevZipMultiThreadingCPU%
IF %SevZipUseKey% EQU True (
    SET ProcessVarA=%ProcessVarA% -p%SevZipKey%
)
GOTO :EOF