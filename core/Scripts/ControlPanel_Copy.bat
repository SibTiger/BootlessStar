REM =====================================================================
REM Control Panel: Copy Software
REM ----------------------------
REM This allows the user to switch from one supported mass copying software to another.  This is going to be needed when transporting a file or an entire directory from one place to another within the filesystem.
REM =====================================================================



REM # =============================================================================================
REM # Documentation: Copy software menu
REM # =============================================================================================
:ControlPanel_CopyConfiguration
CALL :DashboardDisplay
ECHO Copying Software Selection
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO To transition abundance of files from one directory to another, modules can call the preferred dedicated copy software [such as the ones listed below] to accomplish the tasks efficiently.
ECHO.
ECHO Default Value: XCopy
ECHO Copying is currently: %CopyMethod%
ECHO %Separator%
ECHO [1] XCopy
ECHO [2] RoboCopy
ECHO     [Requires Administrative Privileges]
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_CopyConfiguration_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_CopyConfiguration_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_CopyConfiguration_Toggle xcopy
    CALL :ClearBuffer 1
    GOTO :ControlPanel_CopyConfiguration
)
IF "%STDIN%" EQU "2" (
    REM Call an independent function that makes sure that Robocopy is selectable.
    CALL :ControlPanel_CopyConfiguration_RobocopySetup
    CALL :ClearBuffer 1
    GOTO :ControlPanel_CopyConfiguration
)
CALL :BadInput& GOTO :ControlPanel_CopyConfiguration



REM # =============================================================================================
REM # Parameters: [{String} SettingType]
REM # Documentation: Adjust the variable value as requested by the user.
REM # =============================================================================================
:ControlPanel_CopyConfiguration_Toggle
IF %1 EQU xcopy (
    SET CopyMethod=XCOPY
    SET CopyArg=%XCopyArg%
    GOTO :EOF
)
IF %1 EQU robocopy (
    SET CopyMethod=ROBOCOPY
    SET CopyArg=%RoboCopyArg%
    GOTO :EOF
)



REM # =============================================================================================
REM # Parameters: [{String} SettingType]
REM # Documentation: Check if the program has enough permissions to utilize the copy program.
REM #       ROBOCOPY can only be used with administrator\Root access.
REM # =============================================================================================
:ControlPanel_CopyConfiguration_CheckPermissions
IF %Detect_RootAccess% NEQ True (
    ECHO.&ECHO.
    ECHO ^<!^>    WARNING    ^<!^>
    ECHO %Separator%
    ECHO.
    ECHO The selected duplicating software [%~1] requires Administrative privileges!
    ECHO %ProgramName% must be restarted with Administrative privileges in order to use [%~1]!
    PAUSE
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: If the ROBOCOPY software does not exist, disallow the user from selecting it.
REM # =============================================================================================
:ControlPanel_CopyConfiguration_RobocopySetup_CheckExists
IF %Detect_Robocopy% NEQ True (
    ECHO.&ECHO.
    ECHO ^<!^>    Robocopy Not Found!    ^<!^>
    ECHO %SeparatorLong%
    ECHO.
    ECHO %ProgramName% was unable to detect Robocopy on the host system!
    PAUSE
    EXIT /B 1
)
EXIT /B 0



REM # =============================================================================================
REM # Documentation: This is an independent function that handles with Robocopy setup procedures; otherwise tieing into one grouped function will become an utter mess and pure frustration....
REM # =============================================================================================
:ControlPanel_CopyConfiguration_RobocopySetup
REM Does robocopy even exists in the system?  -- If not, leave this function
CALL :ControlPanel_CopyConfiguration_RobocopySetup_CheckExists || GOTO :EOF
REM Is the program running with adminstrative\root access?  NOTE: Robocopy requires it due to its nature.
CALL :ControlPanel_CopyConfiguration_CheckPermissions robocopy
REM If everything is okay, set it
CALL :ControlPanel_CopyConfiguration_Toggle robocopy
GOTO :EOF