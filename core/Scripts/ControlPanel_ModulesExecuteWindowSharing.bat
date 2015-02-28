REM =====================================================================
REM Control Panel: Execute Modules Window Process
REM ----------------------------
REM Allow the user to choose wither or not to execute external modules in a new window or in the same [parent] window as the core.  If incase the modules are serious buggy, it is better to launch them in their own window.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Priority throttling menu
REM # =============================================================================================
:ControlPanel_ModuleExecuteSharingWindow
CALL :DashboardDisplay
ECHO Module Execution Window Sharing Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO When executing modules, it is possible to have them be in their own window and not sharing the same window as %ProgramName%.  When set to [true], this should be helpful for executing multiple modules as well as avoiding serious conflicts with buggy modules.
ECHO.
ECHO Default Value: True
ECHO Window Sharing is Currently: %ModuleExecuteSharingWindow%
ECHO %Separator%
ECHO [1] True
ECHO [2] False
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_ModuleExecuteSharingWindow_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_ModuleExecuteSharingWindow_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_ModuleExecuteSharingWindow_UserInput_Switch True
    CALL :ClearBuffer 1
    GOTO :ControlPanel_ModuleExecuteSharingWindow
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_ModuleExecuteSharingWindow_UserInput_Switch False
    CALL :ClearBuffer 1
    GOTO :ControlPanel_ModuleExecuteSharingWindow
)
CALL :BadInput& GOTO :ControlPanel_ModuleExecuteSharingWindow



REM # =============================================================================================
REM # Parameters: [{String} SettingType]
REM # Documentation: Adjust the variable value as requested by the user.
REM # =============================================================================================
:ControlPanel_ModuleExecuteSharingWindow_UserInput_Switch
IF %1 EQU False (
    SET ModuleExecuteSharingWindow=False
    GOTO :EOF
) ELSE (
    SET ModuleExecuteSharingWindow=True
    GOTO :EOF
)