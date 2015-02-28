REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                 Visual Studio Environment Control


REM # =============================================================================================
REM # Documentation: Load the Visual Studio environment within the current session.
REM # =============================================================================================
:CompileProject_MicrosoftVisualStudioEnvironment
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Calling Microsoft Visual Studio environment"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
CALL :CompileProject_MicrosoftVisualStudioEnvironment_ConfirmCheck || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_MicrosoftVisualStudioEnvironment_TaskVSLoad || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Load the environment
REM # =============================================================================================
:CompileProject_MicrosoftVisualStudioEnvironment_TaskVSLoad
CALL :CompileProject_Display_IncomingTaskSubLevel "Setting up the Microsoft Visual Studio environment"
SET TaskCaller_CallLong=CALL "%VisualStudio%\vsvars32.bat"
SET TaskCaller_NiceProgramName=Call Script or Function
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Check to make sure that the required file exists before executing the file.
REM # =============================================================================================
:CompileProject_MicrosoftVisualStudioEnvironment_ConfirmCheck
IF EXIST "%VisualStudio%" (
    CALL :CompileProject_Display_IncomingTaskSubLevelMSG "Detected Microsoft Visual Studio's tool set!"
    EXIT /B 0
) ELSE (
    CALL :CompileProject_Display_IncomingTaskSubLevelMSG "!ERR: Could not detected Microsoft Visual Studio's tool set!"
    EXIT /B 1
)