REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                   Doom Builder 64 Core Software


REM # =============================================================================================
REM # Documentation: Compile the core engine of the project
REM # =============================================================================================
:CompileProject_CompileCoreEngine
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Compiling %ProjectName% core engine"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
CALL :CompileProject_CompileCoreEngine_UpdateVersion_Task || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompileCoreEngine_Task || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompileCoreEngine_FlagLargeAddress || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B %ERRORLEVEL%



:CompileProject_CompileCoreEngine_UpdateVersion_Task
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the %ProjectName% core engine version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathCoreAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompileCoreEngine_Task
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the %ProjectName% core engine"
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathCoreEngine%" %MSVSArg%
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompileCoreEngine_FlagLargeAddress
CALL :CompileProject_Display_IncomingTaskSubLevel "Issuing the Large Address flag to the %ProjectName% core engine"
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% "%VisualStudio%\..\..\VC\bin\editbin.exe" /LARGEADDRESSAWARE "%ProjectDirectory.PathCoreEngine%"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%