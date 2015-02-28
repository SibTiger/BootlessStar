REM =====================================================================
REM Restore: Restore Preparations
REM ----------------------------
REM In this section, the program will merely setup any last minute updates\configurations and anything else that is required for the restoration process.
REM =====================================================================



REM # =============================================================================================
REM # Documentation: The prepare function will guide through the preparation process.
REM # =============================================================================================
:Restore_Prepare
SET "DriversNiceTask=Preparing restore process"
REM Print on the screen that the program is preparing
CALL :Operation_Display_IncomingTask "%DriversNiceTask%"
REM ----
REM Check to make sure there isn't going to be a duplication conflicts
CALL :Restore_Prepare_CheckExists || (CALL :CaughtIssueSignal& EXIT /B 1)
REM ----
REM Make the output directory; this will be used for extracting the contents
CALL :Restore_Prepare_CreateOutput || (CALL :CaughtIssueSignal& EXIT /B 1)
REM ----
REM Print the footer in the log.
CALL :Operation_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Check to make sure that the Restore directory does not already contain the same folder.
REM # =============================================================================================
:Restore_Prepare_CheckExists
CALL :Operation_Display_IncomingTaskSubLevel "Checking if [ %Output% ] already exists"
IF EXIST "%Output%" (
    CALL :Restore_Prepare_CheckExistsErr
    EXIT /B 1
) ELSE (
    EXIT /B 0
)



REM # =============================================================================================
REM # Documentation: The directory exists; this will print a fatal error on the screen.
REM # =============================================================================================
:Restore_Prepare_CheckExistsErr
CALL :Operation_Display_IncomingTaskSubLevelMSG "!ERR_CRIT!: The directory named [ %Output% ] already exists!  Can not overwrite or manage this directory!  Try managing the contents manually using the View Directories option or run the Cleanup on the Restore directory."
GOTO :EOF



REM # =============================================================================================
REM # Documentation: The directory could not be created; this directory is needed for the extraction point.  Without it, we can't extract the data in a 'neater' fashion.
REM # =============================================================================================
:Restore_CheckExists_MakeDirErr
CALL :Operation_Display_IncomingTaskSubLevelMSG "!ERR_CRIT!: The directory named [ %Output% ] could not be created!"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function will make sure that the output path is properly created and available for the program to utilize.
REM # =============================================================================================
:Restore_Prepare_CreateOutput
CALL :Operation_Display_IncomingTaskSubLevel "Creating the output directory [ %Output% ]"
CALL :Restore_Prepare_CreateOutput_Task || CALL :Restore_CheckExists_MakeDirErr
EXIT /B %ERRORLEVEL%



:Restore_Prepare_CreateOutput_Task
SET TaskCaller_NiceProgramName=MKDIR
SET TaskCaller_CallLong=MKDIR "%Output%"
CALL :Operation_TaskOperation
EXIT /B %ExitCode%