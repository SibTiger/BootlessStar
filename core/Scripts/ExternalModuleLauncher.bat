REM =====================================================================
REM External Module Launcher
REM ----------------------------
REM This allows the user to utilize outside tools to get the job done that isn't normally provided in the program core.  This functionality gives the user the ability to use customized scripts to either get a few extra jobs finished or even to expand into more operations.  The modules, however, are not code checked.  Thus, if someone wrote 'del %systemdrive%' - then that'll happen.
REM External scripts directory is managed by this variable [ %DirSubScripts% - variable ]
REM Scripts that are executed from this environment are not allowed to use the core's environment.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: If the external scripts directory does not exist within the filesystem, then try to create it.
REM # =============================================================================================
:LoadExtScriptsInspect
IF NOT EXIST "%DirSubScripts%" MKDIR "%DirSubScripts%" || ECHO !ERR_CRIT!: Could not create directory [ %DirSubScripts% ] within the local filesystem!
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Display what scripts can be executed from the external scripts library.
REM # =============================================================================================
:LoadExtScriptsDirectoryViewer
DIR /B "%DirSubScripts%" | FINDSTR /E /I ".bat" || ECHO !ERR: Could not find the directory or files!&
GOTO :EOF



REM # =============================================================================================
REM # Documentation: External scripts menu
REM # =============================================================================================
:LoadExtScripts
CALL :DashboardDisplay
CALL :LoadExtScriptsInspect
ECHO Run External Scripts
ECHO.
ECHO Preset Directory: %DirSubScripts%
ECHO %SeparatorLong%
REM Display what scripts can be executed.
CALL :LoadExtScriptsDirectoryViewer
ECHO %SeparatorLong%
ECHO.&ECHO.
ECHO Other Options:
ECHO %SeparatorSmall%
ECHO [I] Install a External Script
ECHO [R] Refresh the list
ECHO [X] Cancel
ECHO %Separator%
ECHO.
ECHO Enter filename to launch an external module:
CALL :UserInput
GOTO :LoadExtScripts_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input and check if the script file can be executed.  If the latter is true, then simply allow it to be executed by calling the execute script function.
REM # =============================================================================================
:LoadExtScripts_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "R" (
    CALL :ClearBuffer 1
    GOTO :LoadExtScripts
)
IF /I "%STDIN%" EQU "Refresh" (
    CALL :ClearBuffer 1
    GOTO :LoadExtScripts
)
IF /I "%STDIN%" EQU "I" (
    CALL :ClearBuffer 1
    CALL :LoadExtScripts_Install
    CALL :ClearBuffer 1
    GOTO :LoadExtScripts
)
IF /I "%STDIN%" EQU "Install" (
    CALL :ClearBuffer 1
    CALL :LoadExtScripts_Install
    CALL :ClearBuffer 1
    GOTO :LoadExtScripts
)
IF EXIST "%DirSubScripts%\%STDIN%" (
    CALL :LoadExtScripts_ProjectLoader_ExecuteScript "%DirSubScripts%\%STDIN%"
    CALL :LoadExtScripts_LastStage
    GOTO :LoadExtScripts
)
IF EXIST "%DirSubScripts%\%STDIN%.bat" (
    CALL :LoadExtScripts_ProjectLoader_ExecuteScript "%DirSubScripts%\%STDIN%.bat"
    CALL :LoadExtScripts_LastStage
    GOTO :LoadExtScripts
)
ECHO Filename could not be found!
PAUSE
CALL :ClearBuffer 1
GOTO :LoadExtScripts



REM # =============================================================================================
REM # Documentation: Install a generalized script.  To make things easier for the user, this will forcefully open a new window allowing the user to simply drag and drop a batch script into the directory.
REM # =============================================================================================
:LoadExtScripts_Install
IF EXIST "%DirSubScripts%" (
    CALL :LoadExtScripts_Install_Message
    CALL :LoadExtScripts_Install_ExplorerDirectory
) ELSE (
    CALL :LoadExtScripts_Install_ErrorMessage
)
PAUSE
GOTO :EOF



:LoadExtScripts_Install_Message
ECHO Instructions:
ECHO With the newly pop-up directory window, simply drag and drop the project module into that directory.
ECHO This program only accepts 'Batch' [.bat] program scripts!
ECHO.
ECHO.
ECHO Safety Notice:
ECHO Please insure that the script file _is_safe_before_using_it_!  It is always possible for a script file remove the users data or perform various other malicious executions.  Thus, as a safety precaution, _always_check_user_reviews_and_inspect_the_code_before_blindly_using_them_!
ECHO.
GOTO :EOF



:LoadExtScripts_Install_ExplorerDirectory
CALL :Call_WindowsExplorer "%DirSubScripts%"
GOTO :EOF



:LoadExtScripts_Install_ErrorMessage
CALL :CantInstallScriptErrorMessage
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} FullPathFileName]
REM # Documentation: Execute the external script file into a new process.
REM # =============================================================================================
:LoadExtScripts_ProjectLoader_ExecuteScript
REM Update the title to include the script name that is going to be executed
CALL :UpdateCoreTitleExecutingScript "%~1"
REM Determine the parameters for START if the user enabled or disabled the Window Sharing
IF %ModuleExecuteSharingWindow% EQU False (
    SET ProcessVarB=
) ELSE (
    SET "ProcessVarB=/B /WAIT"
)
REM The working variable 'ProcessVarA' is captured from the function :UpdateCoreTitleExecutingScript
START "Batch External Fork: %ProcessVarA%" %ProcessVarB% /I CMD /C CALL "%~1"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: After a script has been terminated, this will print a notification that the script ended.  Additionally, this will also reset some of the core's environment settings that could have been altered, title - for example.
REM # =============================================================================================
:LoadExtScripts_LastStage
ECHO %SeparatorLong%
ECHO External Module has been closed!
ECHO %SeparatorLong%
PAUSE
REM Reset some of the environment settings
CALL :EnvironmentSetup_Switch PartialReset
CALL :ClearBuffer 1
GOTO :EOF