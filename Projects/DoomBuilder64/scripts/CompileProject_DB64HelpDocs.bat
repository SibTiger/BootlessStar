REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                 Doom Builder 64 Help Documentation


REM # =============================================================================================
REM # Documentation: Compile the help documentation for the project.
REM # =============================================================================================
:CompileProject_CompileHelpDocumentation
REM ----
REM Run this function?
IF %Detect_MSHTMLWorkShop% EQU False EXIT /B 0
REM ----
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Compiling %ProjectName% help documentation"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
CALL :CompileProject_CompileHelpDocumentation_Task || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B %ERRORLEVEL%



:CompileProject_CompileHelpDocumentation_Task
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the %ProjectName% help documentation"
SET TaskCaller_CallLong=START "Batch Fork: HTML Workshop Compiler Task" /B /WAIT /%PriorityGeneral% "%PathMSHTMLWorkShop%" "%ProjectDirectory.DirHelpTarget%\Refmanual.hhp"
SET TaskCaller_NiceProgramName=Microsoft HTML Workshop
CALL :CompileProject_TaskOperation
CALL :CompileProject_FlipBit_Common %ERRORLEVEL%
EXIT /B %ERRORLEVEL%