REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                      Project Local Directory


REM # =============================================================================================
REM # Documentation: Determine the file and directory name of the project and the current revision number.
REM # =============================================================================================
:CompileProject_ProjectLocalDirectory
REM Did the user want to run this functionality?
IF %UserConfig.MirrorCompiledData% EQU False EXIT /B 0
REM ----
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Mirroring compiled data to Local Directory"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
CALL :CompileProject_GenerateProjectName_CheckDirectoryExists || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_GenerateProjectName_MakeDirectory || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_GenerateProjectName_Duplicate || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Create a directory which will store the output contents.
REM # =============================================================================================
:CompileProject_GenerateProjectName_MakeDirectory
REM Create the directory
CALL :CompileProject_Display_IncomingTaskSubLevel "Creating the %FileName% directory"
SET TaskCaller_CallLong=MKDIR %LocalDirectory.Builds%\%FileName%
SET TaskCaller_NiceProgramName=Make Directory
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Does the directory already exists?  If it does, let the user know that the directory is about to be thrashed in exchange for new content.
REM # =============================================================================================
:CompileProject_GenerateProjectName_CheckDirectoryExists
IF EXIST "%LocalDirectory.Builds%\%FileName%" CALL :CompileProject_GenerateProjectName_CheckDirectoryExists_PromptChoice || (CALL :CaughtErrorSignal& EXIT /B 1)
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Manage how the duplicated directory should be removed.
REM # =============================================================================================
:CompileProject_GenerateProjectName_CheckDirectoryExists_PromptChoice
CALL :CompileProject_GenerateProjectName_CheckDirectoryExists_PromptChoice_PrintMessage
CALL :CompileProject_GenerateProjectName_CheckDirectoryExists_PromptChoice_ExpungeDirectory || EXIT /B 1
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Display a message that lets the user know that a directory already exists and can not be used until the directory has been thrashed.
REM # =============================================================================================
:CompileProject_GenerateProjectName_CheckDirectoryExists_PromptChoice_PrintMessage
ECHO.&ECHO.
ECHO ^<?^>       Directory Already Exists       ^<?^>
ECHO %SeparatorLong%
ECHO.
ECHO Found an existing compiled build which is one step away from being permanently deleted.  Any personal files [.wad files for example] will be expunged!  Move any personal files to a safe location before continuing!
ECHO.
ECHO Location:
ECHO   %LocalDirectory.Builds%\%FileName%
ECHO.
PAUSE
ECHO.
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Expunge the duplicated directory and all of the contents inside within the directory.
REM # =============================================================================================
:CompileProject_GenerateProjectName_CheckDirectoryExists_PromptChoice_ExpungeDirectory
CALL :CompileProject_Display_IncomingTaskSubLevel "Thrashing the existing directory"
SET TaskCaller_CallLong=RMDIR /S /Q %LocalDirectory.Builds%\%FileName%
SET TaskCaller_NiceProgramName=Remove Directory and Files
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Mirror the compiled data that is located in the Build directory to the newly created directory in the local directory.
REM # =============================================================================================
:CompileProject_GenerateProjectName_Duplicate
CALL :CompileProject_Display_IncomingTaskSubLevel "Duplicating compiled data to the local directory"
SET TaskCaller_CallLong=XCOPY %XCopyArg%/E /I "%ProjectDirectory.DirCompiledTarget%" "%LocalDirectory.Builds%\%FileName%"
SET TaskCaller_NiceProgramName=XCOPY
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%