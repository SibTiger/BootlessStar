REM =====================================================================
REM Project Loader
REM ----------------------------
REM This feature allows the core to be expandable and execute script modules to perform tedious tasks and to get various operations accomplished - such as compiling software or compiling a game project into a pk3 file.  As script modules are allowed to use Bootless Star's environment, this will allow the script modules to quickly use the end user's programs and settings without having to write the same information again.  For those that remember Bootless Star Beta 7 and before, it used to be hard coded to only compile specific software and nothing further -- Can not easily be expanded and required having to change the core's code.  But, however, now this has changed to allow more tasks to be done and less changes within the core.  The core essentially allows the modules to expand the programs capabilities.
REM Script module directory is managed by this variable [ %DirProjects% ]
REM Scripts that are executed from this environment are allowed to use the core's environment.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: If the script modules directory does not exist, then attempt to create the directory.
REM # =============================================================================================
:ProjectLoaderInspect
IF NOT EXIST "%DirProjects%" MKDIR "%DirProjects%" || ECHO !ERR_CRIT!: Could not create directory [ %DirProjects% ] within the local filesystem!
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Display what scripts can be found and can be used within the script module directory
REM # =============================================================================================
:ProjectLoaderDirectoryViewer
DIR /B %DirProjects% | FINDSTR /E /I ".bat" || ECHO !ERR: Could not find the directory or files!&
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Script Module menu screen
REM # =============================================================================================
:ProjectLoader
CALL :DashboardDisplay
CALL :ProjectLoaderInspect
ECHO Run Project Module
ECHO.
ECHO Projects Directory: %DirProjects%
ECHO %SeparatorLong%
REM Display what contents exist within the script module directory
CALL :ProjectLoaderDirectoryViewer
ECHO %SeparatorLong%
ECHO.&ECHO.
ECHO Select the following options:
ECHO %Separator%
ECHO [I] Install a Project Module
ECHO [R] Refresh lists
ECHO [X] Return to Main Menu
CALL :ProjectLoader_ChoicePrep
GOTO :ProjectLoader_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ProjectLoader_UserInput
IF /I "%STDIN%" EQU "R" (
    CALL :ClearBuffer 1
    GOTO :ProjectLoader
)
IF /I "%STDIN%" EQU "Refresh" (
    CALL :ClearBuffer 1
    GOTO :ProjectLoader
)
IF /I "%STDIN%" EQU "I" (
    CALL :ClearBuffer 1
    CALL :ProjectLoader_Install
    CALL :ClearBuffer 1
    GOTO :ProjectLoader
)
IF /I "%STDIN%" EQU "Install" (
    CALL :ClearBuffer 1
    CALL :ProjectLoader_Install
    CALL :ClearBuffer 1
    GOTO :ProjectLoader
)
IF /I "%STDIN%" EQU "X" GOTO :EOF
CALL :ProjectLoader_ExecuteProject
CALL :ClearBuffer 1
GOTO :ProjectLoader



REM # =============================================================================================
REM # Documentation: Install a compatible script.  To make things easier for the user, this will forcefully open a new window allowing the user to simply drag and drop a batch script into the directory.
REM # =============================================================================================
:ProjectLoader_Install
IF EXIST "%DirProjects%" (
    CALL :ProjectLoader_Install_Message
    CALL :ProjectLoader_Install_ExplorerDirectory
) ELSE (
    CALL :ProjectLoader_Install_ErrorMessage
)
PAUSE
GOTO :EOF



:ProjectLoader_Install_Message
ECHO Instructions:
ECHO With the newly pop-up directory window, simply drag and drop the project module into that directory.
ECHO This program only accepts 'Batch' [.bat] program scripts!
ECHO.
ECHO.
ECHO Compatibility Notice:
ECHO Be sure that the project module is able to work with %ProgramName% version %ProgramReleaseDate% environment!  Outdated scripts may not function properly or will not be able to take advantage of newer improvements and additions that is offered in the later versions!
ECHO.
ECHO.
ECHO Safety Notice:
ECHO Please insure that the script file _is_safe_before_using_it_!  It is always possible for a script file remove the users data or perform various other malicious executions.  Thus, as a safety precaution, _always_check_user_reviews_and_inspect_the_code_before_blindly_using_them_!
ECHO Make sure that the script is designed for %ProgramName% [version: %ProgramReleaseDate%]!  When a project module is loaded in %ProgramName% environment, the script is not only sharing %ProgramName% environment settings but also the users settings!  Thus, as a result, any sensitive data that was stored from the user, will be accessible to the script!
ECHO.
GOTO :EOF



:ProjectLoader_Install_ExplorerDirectory
CALL :Call_WindowsExplorer "%DirProjects%"
GOTO :EOF



:ProjectLoader_Install_ErrorMessage
CALL :CantInstallScriptErrorMessage
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Select a script module to execute within the environment.
REM # =============================================================================================
:ProjectLoader_ChoicePrep
ECHO.
ECHO %Separator%
ECHO.
ECHO Enter a filename:
CALL :UserInput
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Pass the script module to the ExecuteScript function and cache the exitcode for processing later.  If incase the file was not found, nothing is executed.
REM # =============================================================================================
:ProjectLoader_ExecuteProject
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I EXIST "%DirProjects%\%STDIN%" (
    CALL :ProjectLoader_ExecuteScript "%DirProjects%\%STDIN%"
    SET scriptExitCode=%ERRORLEVEL%
    CALL :ProjectLoader_Finished
    GOTO :EOF
)
IF /I EXIST "%DirProjects%\%STDIN%.bat" (
    CALL :ProjectLoader_ExecuteScript "%DirProjects%\%STDIN%.bat"
    SET scriptExitCode=%ERRORLEVEL%
    CALL :ProjectLoader_Finished
    GOTO :EOF
)
ECHO Filename could not be found!
PAUSE
CALL :ClearBuffer 1
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} FullPathFileName]
REM # Documentation: Execute the script file into a new process.
REM # =============================================================================================
:ProjectLoader_ExecuteScript
REM Update the title to include the script name that is going to be executed
CALL :UpdateCoreTitleExecutingScript "%~1"
REM Determine the parameters for START if the user enabled or disabled the Window Sharing
IF %ModuleExecuteSharingWindow% EQU False (
    SET ProcessVarB=
) ELSE (
    SET "ProcessVarB=/B /WAIT"
)
REM The working variable 'ProcessVarA' is captured from the function :UpdateCoreTitleExecutingScript
START "Batch Fork: %ProcessVarA%" %ProcessVarB% CMD /Q /C CALL "%~1"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: After the module has been closed, do the final procedures: checking the exit code of the execution, and resetting some of the core's settings.
REM # =============================================================================================
:ProjectLoader_Finished
REM Check to see if there was an error first
ECHO.&ECHO.
ECHO %SeparatorLong%
ECHO Script has been closed!
ECHO %SeparatorLong%
REM Reset some of the cores environment settings.
CALL :EnvironmentSetup_Switch PartialReset
IF %scriptExitCode% NEQ 0 GOTO :ProjectLoader_ExitWithError
PAUSE
GOTO :EOF



REM # =============================================================================================
REM # Documentation: When the module has been terminated prematurely, then tell the user that the script closed with an error.
REM # =============================================================================================
:ProjectLoader_ExitWithError
ECHO !ERR: A module has been terminated with an error....
PAUSE
GOTO :EOF