REM =====================================================================
REM Control Panel: Windows Explorer
REM ----------------------------
REM This section allows the user to allow or disallow the programs to utilize the Windows Explorer functionality.  This ultimately can be used to open new windows into environment and also can highlight objects within a new window.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function is a translator which takes the variable's value and stores a nicer value name to a temporary working variable.
REM # =============================================================================================
:ControlPanel_WindowsExplorer_Translator
IF %CallExplorerCommands% EQU True SET ProcessVarA=Enable& GOTO :EOF
IF %CallExplorerCommands% EQU False SET ProcessVarA=Disable
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Explorer menu
REM # =============================================================================================
:ControlPanel_WindowsExplorer
CALL :DashboardDisplay
REM Translate the actual variable value into another variable with a nicer value.
CALL :ControlPanel_WindowsExplorer_Translator
ECHO Windows Explorer Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO For certain operations or events, this program might call on Windows 'explorer.exe' for certain operations.  Most simply, in terms of operations could be, opening a new window focus, highlighting objects, and small various tasks.
ECHO.
ECHO Default Value: Enable
ECHO Calling Explorer is Currently: %ProcessVarA%
ECHO %Separator%
ECHO [1] Disable
ECHO [2] Enable
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_WindowsExplorer_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_WindowsExplorer_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_WindowsExplorer_Toggle Disable
    CALL :ClearBuffer 1
    GOTO :ControlPanel_WindowsExplorer
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_WindowsExplorer_Toggle Enable
    CALL :ClearBuffer 1
    GOTO :ControlPanel_WindowsExplorer
)
CALL :BadInput& GOTO :ControlPanel_WindowsExplorer



REM # =============================================================================================
REM # Parameters: [{Bool} SettingType]
REM # Documentation: Adjust the variable value as requested by the user.
REM # =============================================================================================
:ControlPanel_WindowsExplorer_Toggle
IF %1 EQU Enable (
    SET CallExplorerCommands=True
    GOTO :EOF
) ELSE (
    SET CallExplorerCommands=False
    GOTO :EOF
)